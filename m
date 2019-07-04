Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB21C5F01A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2019 02:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfGDAhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 20:37:03 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:34675 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfGDAhD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 20:37:03 -0400
Received: by mail-vk1-f202.google.com with SMTP id 21so450606vki.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2019 17:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3dkcwHp7UkbBjeC+jKJgdEez1r7JnE/QFVNxh/Av3lE=;
        b=P/9Q0U57X0Mjr2pSdVR3fq5Q9Stk+yaqd+YUm9sq0ou6AVsZSt/1N/33ozuhbgY2vA
         l95M1OTPG7AMpCdkXNxZwoF74wXCpWnPckCjmlCUOfpVWb6OUe1dqoKeBMLQ2rRoWAC+
         fNHaGobDGBWH78hBlHjYyz8R5pV2r1lKhN6q853RMfM6pw8GA8VVYjvcvo3uf8gDuuir
         ENB2mZWRXg62IrhKkC86LfkNF4vHPkE6nmhUv9Xome467fLx+E9J0pgZrqEdzyy++0mz
         884zs7eBSkOyiHbrPJJuzc+Z2DaP9Fz7PcxSltbsQgqsrKy/bR2ai8bDNYsLrfqN7e+f
         Qiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3dkcwHp7UkbBjeC+jKJgdEez1r7JnE/QFVNxh/Av3lE=;
        b=RVxOw8JrweckakJJY+imvbT/619ioLbfNnZ81MB3IPHzLbm7SQpmf3Mt6Uej8c51SI
         aXQ2RamrRay8nCJra8svIsGRpfaGYMqWy4c21oiSyW81dSF3MKwqK3Ko0r15e5tnA0yT
         2jYshYy4uGIUBZ6o9nBq4ZFmow4tNY6CuRj/Xgrtu8zsTJdFmQ5uCUBPfb7TcMfflHpC
         JsLUxflxRTHYnlUMLadzhHejtlloVbHOdq2LduLvt9YaX0asS95UVWKiEJss4PCSHPcE
         uzRWQBrNLg/P41zexmrAajvLDzrfVFTd1okUcIYYni5aLsxyGORDF1StgHIBockDDBeL
         OWog==
X-Gm-Message-State: APjAAAXpqgrU/Jarhj3tmCJfZ+HhcIh6oNI6/CIqxbx+XJ2JdyQNXzLN
        JnqRHvzpvNutZ7ctmjuWJwGW6SCfytqMFKwaHe3rmA==
X-Google-Smtp-Source: APXvYqxifi+9P2uuB2xECPxDjII80enpIo8mSlNTAxiC8KmAvRxtyVWjtDGXaCnqTdPCo5Xn7dOc4Z0daGhonP28ve9Qzg==
X-Received: by 2002:a1f:5945:: with SMTP id n66mr6468396vkb.58.1562200621022;
 Wed, 03 Jul 2019 17:37:01 -0700 (PDT)
Date:   Wed,  3 Jul 2019 17:35:57 -0700
Message-Id: <20190704003615.204860-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v6 00/18] kunit: introduce KUnit, the Linux kernel unit
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
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

## TL;DR

This is a pretty straightforward follow-up to Stephen and Luis' comments
on PATCH v5: There is nothing that really changes any functionality or
usage with the minor exception that I renamed `struct kunit_module` to
`struct kunit_suite`. Nevertheless, a good deal of clean ups and fixes.
See "Changes Since Last Version" section below.

As for our current status, right now we got Reviewed-bys on all patches
except:

- [PATCH v6 08/18] objtool: add kunit_try_catch_throw to the noreturn
  list

However, it would probably be good to get reviews/acks from the
subsystem maintainers on:

- [PATCH v6 06/18] kbuild: enable building KUnit
- [PATCH v6 08/18] objtool: add kunit_try_catch_throw to the noreturn
  list
- [PATCH v6 15/18] Documentation: kunit: add documentation for KUnit
- [PATCH v6 17/18] kernel/sysctl-test: Add null pointer test for
  sysctl.c:proc_dointvec()

Other than that, I think we should be good to go.

## Background

This patch set proposes KUnit, a lightweight unit testing and mocking
framework for the Linux kernel.

Unlike Autotest and kselftest, KUnit is a true unit testing framework;
it does not require installing the kernel on a test machine or in a VM
(however, KUnit still allows you to run tests on test machines or in VMs
if you want[1]) and does not require tests to be written in userspace
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
For convenience I am hosting the compiled docs here[2].

Additionally for convenience, I have applied these patches to a
branch[3]. The repo may be cloned with:
git clone https://kunit.googlesource.com/linux
This patchset is on the kunit/rfc/v5.2-rc7/v6 branch.

## Changes Since Last Version

Aside from renaming `struct kunit_module` to `struct kunit_suite`, there
isn't really anything in here that changes any functionality:

- Rebased on v5.2-rc7
- Got rid of spinlocks.
  - Now update success field using WRITE_ONCE. - Suggested by Stephen
  - Other instances replaced by mutex. - Suggested by Stephen and Luis
- Renamed `struct kunit_module` to `struct kunit_suite`. - Inspired by
  Luis.
- Fixed a broken example of how to use kunit_tool. - Pointed out by Ted
- Added descriptions to unit tests. - Suggested by Luis
- Labeled unit tests which tested the API. - Suggested by Luis
- Made a number of minor cleanups. - Suggested by Luis and Stephen.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2-rc7/v6

-- 
2.22.0.410.gd8fdbe21b5-goog

