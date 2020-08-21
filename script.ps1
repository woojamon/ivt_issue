mkdir myproj
cd myproj
dotnet new classlib --language f#
@'
module myproj

open System.Runtime.CompilerServices

[<assembly: InternalsVisibleTo("myproj.tests")>]
do()

type LOL = private LOL of int
'@ | Out-File Library.fs
dotnet build
cd ..
mkdir myproj.tests
cd myproj.tests
dotnet new xunit --language f#
dotnet add reference ../myproj
@'
module LOLtests

open Xunit
open myproj

[<Fact>]
let ``test`` () =
    let expected = 4
    let (LOL actual) = LOL expected
    Assert.Equal(expected, actual)
'@ | Out-File Tests.fs
dotnet test
