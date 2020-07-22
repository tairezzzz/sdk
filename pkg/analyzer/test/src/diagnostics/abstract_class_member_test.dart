// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/src/dart/error/syntactic_errors.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../dart/resolution/driver_resolution.dart';
import '../dart/resolution/with_null_safety_mixin.dart';

main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AbstractClassMemberTest);
    defineReflectiveTests(AbstractClassMemberTest_NNBD);
  });
}

@reflectiveTest
class AbstractClassMemberTest extends DriverResolutionTest {
  test_abstract_field_dynamic() async {
    await assertErrorsInCode(
        '''
abstract class A {
  abstract dynamic x;
}
''',
        expectedErrorsByNullability(nullable: [], legacy: [
          error(ParserErrorCode.ABSTRACT_CLASS_MEMBER, 21, 8),
        ]));
  }

  test_abstract_field_untyped() async {
    await assertErrorsInCode(
        '''
abstract class A {
  abstract var x;
}
''',
        expectedErrorsByNullability(nullable: [], legacy: [
          error(ParserErrorCode.ABSTRACT_CLASS_MEMBER, 21, 8),
        ]));
  }

  test_abstract_field_untyped_covariant() async {
    await assertErrorsInCode(
        '''
abstract class A {
  abstract covariant var x;
}
''',
        expectedErrorsByNullability(nullable: [], legacy: [
          error(ParserErrorCode.ABSTRACT_CLASS_MEMBER, 21, 8),
        ]));
  }
}

@reflectiveTest
class AbstractClassMemberTest_NNBD extends AbstractClassMemberTest
    with WithNullSafetyMixin {}
