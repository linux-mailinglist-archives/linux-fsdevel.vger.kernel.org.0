Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D84B9A01
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 01:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394038AbfITXTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 19:19:42 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:56736 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393980AbfITXTl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:19:41 -0400
Received: by mail-pf1-f202.google.com with SMTP id m25so5739672pfa.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 16:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nb7QxHXj+SKvjsJLG8FWioDhlMnWN+bRLwlVtN25RL8=;
        b=gBA2/p13VviwFX4KcGj3wi73zswgh9stq+u0+VIVmsQc5JjIHMEAc8dxixhA5Rl+C3
         3uN9VQFxr8hIUCrY4o5HmaFJmwEZnNosUkMmsdxptY6kSkTRMPReA+DGLs5E4S0eKzMb
         wxzegoEDbhr1qTO0W9rClb06XAlrKyS+1nRcMn00URrZxhtKVvqNGaVUmf5l45RflXbu
         api8zdcu39O2cGMSnmhZ8WwwXzUwnyWjqJ93u7qNLGNUqBTnR6n+wjy0GTxPZLA6Tksq
         vc03vGL3W4/BQKCds3KzP7hRH5zJsvNdcNRfMW9REt7lHDUwBIQvByxBpEgtHGWEvZZv
         wJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nb7QxHXj+SKvjsJLG8FWioDhlMnWN+bRLwlVtN25RL8=;
        b=Dp5adC+92hS5h0CsOKYjbNtNAWRfQdLor7fhDiXNEt/AUXJr+SrLVUDupGft7ig2c8
         N8cAmEQBAJ063hW39yQndJKp+v6VpplxCygamEAAZr5lZBM2dQzRFB5KQMjKW6eBRMFL
         +x4DrjNeKDi7iWDmFLTpdHBEJqhtaVOi+sC4TDcZ8S2xdFAfSPJ+7cNNkqSOAv2HOY/f
         GgHimzhzMsdUfUfnFpMedyIaCXW/FTmSzK0pjlnTymgPzbv4LuN02EZDBS70WVOFPZWj
         AWvrCtzUXr9NEz33f8hxFbZjlwNlvL+P4nv87WWYX52mRUp2ij+JGInHTdv00HSD3BaH
         yavQ==
X-Gm-Message-State: APjAAAWSxExFhhvoaFRsEyW8e5gynHOR52pUQapOSawnntM6lLi42i4Q
        Xq1tjaXX3A7WeNsFyVNbMmEPSD/ymNN8/k3O4DpMjA==
X-Google-Smtp-Source: APXvYqytMR8IZXABl+f3jYgBOchzLzV2fU9kRlUfaLFAk4s8Ys3CTvTqt33JWkrWAeywlxKZdNmAWieZg+uzSvfi8E7soQ==
X-Received: by 2002:a65:5543:: with SMTP id t3mr17639051pgr.242.1569021579027;
 Fri, 20 Sep 2019 16:19:39 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:19:04 -0700
Message-Id: <20190920231923.141900-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v16 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, torvalds@linux-foundation.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

## TL;DR

This revision addresses comments from Linus[1] and Randy[2], by moving
top level `kunit/` directory to `lib/kunit/` and likewise moves top
level Kconfig entry under lib/Kconfig.debug, so the KUnit submenu now
shows up under the "Kernel Hacking" menu.

As a consequence of this, I rewrote patch 06/18 (kbuild: enable building
KUnit), and now needs to be re-acked/reviewed.

## Background

This patch set proposes KUnit, a lightweight unit testing and mocking
framework for the Linux kernel.

Unlike Autotest and kselftest, KUnit is a true unit testing framework;
it does not require installing the kernel on a test machine or in a VM
(however, KUnit still allows you to run tests on test machines or in VMs
if you want[3]) and does not require tests to be written in userspace
running on a host kernel. Additionally, KUnit is fast: From invocation
to completion KUnit can run several dozen tests in about a second.
Currently, the entire KUnit test suite for KUnit runs in under a second
from the initial invocation (build time excluded).

KUnit is heavily inspired by JUnit, Python's unittest.mock, and
Googletest/Googlemock for C++. KUnit provides facilities for defining
unit test cases, grouping related test cases into test suites, providing
common infrastructure for running tests, mocking, spying, and much more.

### What's so special about unit testing?

A unit test is supposed to test a single unit of code in isolation,
hence the name. There should be no dependencies outside the control of
the test; this means no external dependencies, which makes tests orders
of magnitudes faster. Likewise, since there are no external dependencies,
there are no hoops to jump through to run the tests. Additionally, this
makes unit tests deterministic: a failing unit test always indicates a
problem. Finally, because unit tests necessarily have finer granularity,
they are able to test all code paths easily solving the classic problem
of difficulty in exercising error handling code.

### Is KUnit trying to replace other testing frameworks for the kernel?

No. Most existing tests for the Linux kernel are end-to-end tests, which
have their place. A well tested system has lots of unit tests, a
reasonable number of integration tests, and some end-to-end tests. KUnit
is just trying to address the unit test space which is currently not
being addressed.

### More information on KUnit

There is a bunch of documentation near the end of this patch set that
describes how to use KUnit and best practices for writing unit tests.
For convenience I am hosting the compiled docs here[4].

Additionally for convenience, I have applied these patches to a
branch[5]. The repo may be cloned with:
git clone https://kunit.googlesource.com/linux
This patchset is on the kunit/initial/v5.3/v16 branch.

[1] https://www.lkml.org/lkml/2019/9/20/696
[2] https://www.lkml.org/lkml/2019/9/20/738
[3] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[4] https://google.github.io/kunit-docs/third_party/kernel/docs/
[5] https://kunit.googlesource.com/linux/+/kunit/initial/v5.3/v16

---

Avinash Kondareddy (1):
  kunit: test: add tests for KUnit managed resources

Brendan Higgins (16):
  kunit: test: add KUnit test runner core
  kunit: test: add test resource management API
  kunit: test: add string_stream a std::stream like string builder
  kunit: test: add assertion printing library
  kunit: test: add the concept of expectations
  lib: enable building KUnit in lib/
  kunit: test: add initial tests
  objtool: add kunit_try_catch_throw to the noreturn list
  kunit: test: add support for test abort
  kunit: test: add tests for kunit test abort
  kunit: test: add the concept of assertions
  kunit: defconfig: add defconfigs for building KUnit tests
  Documentation: kunit: add documentation for KUnit
  MAINTAINERS: add entry for KUnit the unit testing framework
  MAINTAINERS: add proc sysctl KUnit test to PROC SYSCTL section
  kunit: fix failure to build without printk

Felix Guo (1):
  kunit: tool: add Python wrappers for running KUnit tests

Iurii Zaikin (1):
  kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()

 Documentation/dev-tools/index.rst             |    1 +
 Documentation/dev-tools/kunit/api/index.rst   |   16 +
 Documentation/dev-tools/kunit/api/test.rst    |   11 +
 Documentation/dev-tools/kunit/faq.rst         |   62 +
 Documentation/dev-tools/kunit/index.rst       |   79 +
 Documentation/dev-tools/kunit/start.rst       |  180 ++
 Documentation/dev-tools/kunit/usage.rst       |  576 +++++++
 MAINTAINERS                                   |   13 +
 arch/um/configs/kunit_defconfig               |    3 +
 include/kunit/assert.h                        |  356 ++++
 include/kunit/string-stream.h                 |   51 +
 include/kunit/test.h                          | 1490 +++++++++++++++++
 include/kunit/try-catch.h                     |   75 +
 kernel/Makefile                               |    2 +
 kernel/sysctl-test.c                          |  392 +++++
 lib/Kconfig.debug                             |   13 +
 lib/Makefile                                  |    2 +
 lib/kunit/Kconfig                             |   38 +
 lib/kunit/Makefile                            |    9 +
 lib/kunit/assert.c                            |  141 ++
 lib/kunit/example-test.c                      |   88 +
 lib/kunit/string-stream-test.c                |   52 +
 lib/kunit/string-stream.c                     |  217 +++
 lib/kunit/test-test.c                         |  331 ++++
 lib/kunit/test.c                              |  478 ++++++
 lib/kunit/try-catch.c                         |  118 ++
 tools/objtool/check.c                         |    1 +
 tools/testing/kunit/.gitignore                |    3 +
 tools/testing/kunit/configs/all_tests.config  |    3 +
 tools/testing/kunit/kunit.py                  |  136 ++
 tools/testing/kunit/kunit_config.py           |   66 +
 tools/testing/kunit/kunit_kernel.py           |  149 ++
 tools/testing/kunit/kunit_parser.py           |  310 ++++
 tools/testing/kunit/kunit_tool_test.py        |  206 +++
 .../test_is_test_passed-all_passed.log        |   32 +
 .../test_data/test_is_test_passed-crash.log   |   69 +
 .../test_data/test_is_test_passed-failure.log |   36 +
 .../test_is_test_passed-no_tests_run.log      |   75 +
 .../test_output_isolated_correctly.log        |  106 ++
 .../test_data/test_read_from_file.kconfig     |   17 +
 40 files changed, 6003 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/api/index.rst
 create mode 100644 Documentation/dev-tools/kunit/api/test.rst
 create mode 100644 Documentation/dev-tools/kunit/faq.rst
 create mode 100644 Documentation/dev-tools/kunit/index.rst
 create mode 100644 Documentation/dev-tools/kunit/start.rst
 create mode 100644 Documentation/dev-tools/kunit/usage.rst
 create mode 100644 arch/um/configs/kunit_defconfig
 create mode 100644 include/kunit/assert.h
 create mode 100644 include/kunit/string-stream.h
 create mode 100644 include/kunit/test.h
 create mode 100644 include/kunit/try-catch.h
 create mode 100644 kernel/sysctl-test.c
 create mode 100644 lib/kunit/Kconfig
 create mode 100644 lib/kunit/Makefile
 create mode 100644 lib/kunit/assert.c
 create mode 100644 lib/kunit/example-test.c
 create mode 100644 lib/kunit/string-stream-test.c
 create mode 100644 lib/kunit/string-stream.c
 create mode 100644 lib/kunit/test-test.c
 create mode 100644 lib/kunit/test.c
 create mode 100644 lib/kunit/try-catch.c
 create mode 100644 tools/testing/kunit/.gitignore
 create mode 100644 tools/testing/kunit/configs/all_tests.config
 create mode 100755 tools/testing/kunit/kunit.py
 create mode 100644 tools/testing/kunit/kunit_config.py
 create mode 100644 tools/testing/kunit/kunit_kernel.py
 create mode 100644 tools/testing/kunit/kunit_parser.py
 create mode 100755 tools/testing/kunit/kunit_tool_test.py
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-crash.log
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-failure.log
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
 create mode 100644 tools/testing/kunit/test_data/test_output_isolated_correctly.log
 create mode 100644 tools/testing/kunit/test_data/test_read_from_file.kconfig

-- 
2.23.0.351.gc4317032e6-goog

