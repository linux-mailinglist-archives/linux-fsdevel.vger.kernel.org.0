Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86491C1F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 07:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfENFni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 01:43:38 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55183 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfENFni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 01:43:38 -0400
Received: by mail-pg1-f202.google.com with SMTP id s5so10761072pgv.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 22:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CA1N44QTqLhlVaroRojZdGi6CcVwoP2KNr1A1UImFq0=;
        b=h6AZqHkX1OcXuKiWGxhO61tdk+HR2HvTKQEpCCBYcqn6plqrOohI9Okal84aTEN2gJ
         pcUal3uJknEB+RrEmMmXoyWtFQ8z/VEve2BGMzS/N7pXPIQp0h1NVAva9rDSUnGHjLEJ
         vx1VU8Uvu79S0JOwGTWgOfWHxd/ASKWGvpXSYxqiyDlRKx/kfa47HynTXrI6mghbfUkz
         ftvsf604JHZwsEPgj7aK8R+INHqcBEEkFy98bk6arBDrrsX/GZ25q4wQIXVIU1DJAHdt
         6dh5pUod4MbGUjQOr69py/QRwji6PeGn961MqFFs+Tum9tKKLYMRMp7U9XKdfLOGJDyx
         zipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CA1N44QTqLhlVaroRojZdGi6CcVwoP2KNr1A1UImFq0=;
        b=Sa5w2B1L9c/9YGD2jSvlelznLYrORLt/xbAr/D8nQA9WF7rgU46Ki3+ZlVkwfvFnoe
         d/8B0YbU070x82E6bb7T8ql9JmJ/9LaXiiwhF1ux2Rh0XtMAKLNyQ2bDxy3GIF8WJYRN
         Zi75MkdATfvObt7Foc/MIV+ceMtGWYFG2D3qMjvRlKzjOT7/G0EqME6YRqnrB0vTILuo
         dKyTQfCxbZnKXeeeUAvdXq1KokuS2CswZvSkSfsJCW5bw8nONAZDvFt5QWDAmKsW2YLR
         r/6IT8U7fyx5pSqQzx+HtjIrX7iI6pg/dp+WMRNzNQPmkIr7WLnibh2gcmX+S8qKSgxt
         Sjtg==
X-Gm-Message-State: APjAAAVYbig+ew9rakJxRoQIiI5gTBRVBwvvHBjIPpb0b6K2j4NvWS2w
        N2dVEj6LWC2H6m08gs0lF5YBLT5aEMG3YPNhfsG//Q==
X-Google-Smtp-Source: APXvYqyBPTv6v4eKPVDjcz6uhAI6teASmDK3xBqeYKpM9SuSjEAG+BViYVdVY5Rrq8TOB5itpc/QrUR1WPgEkoPcFI6QTA==
X-Received: by 2002:a65:550b:: with SMTP id f11mr35449216pgr.311.1557812616583;
 Mon, 13 May 2019 22:43:36 -0700 (PDT)
Date:   Mon, 13 May 2019 22:42:33 -0700
Message-Id: <20190514054251.186196-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v3 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, rdunlap@infradead.org, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

## TLDR

I mostly wanted to incorporate feedback I got over the last week and a
half.

Biggest things to look out for:

- KUnit core now outputs results in TAP14.
- Heavily reworked tools/testing/kunit/kunit.py
  - Changed how parsing works.
  - Added testing.
  - Greg, Logan, you might want to re-review this.
- Added documentation on how to use KUnit on non-UML kernels. You can
  see the docs rendered here[1].

There is still some discussion going on on the [PATCH v2 00/17] thread,
but I wanted to get some of these updates out before they got too stale
(and too difficult for me to keep track of). I hope no one minds.

## Background

This patch set proposes KUnit, a lightweight unit testing and mocking
framework for the Linux kernel.

Unlike Autotest and kselftest, KUnit is a true unit testing framework;
it does not require installing the kernel on a test machine or in a VM
(however, KUnit still allows you to run tests on test machines or in VMs
if you want) and does not require tests to be written in userspace
running on a host kernel. Additionally, KUnit is fast: From invocation
to completion KUnit can run several dozen tests in under a second.
Currently, the entire KUnit test suite for KUnit runs in under a second
from the initial invocation (build time excluded).

KUnit is heavily inspired by JUnit, Python's unittest.mock, and
Googletest/Googlemock for C++. KUnit provides facilities for defining
unit test cases, grouping related test cases into test suites, providing
common infrastructure for running tests, mocking, spying, and much more.

## What's so special about unit testing?

A unit test is supposed to test a single unit of code in isolation,
hence the name. There should be no dependencies outside the control of
the test; this means no external dependencies, which makes tests orders
of magnitudes faster. Likewise, since there are no external dependencies,
there are no hoops to jump through to run the tests. Additionally, this
makes unit tests deterministic: a failing unit test always indicates a
problem. Finally, because unit tests necessarily have finer granularity,
they are able to test all code paths easily solving the classic problem
of difficulty in exercising error handling code.

## Is KUnit trying to replace other testing frameworks for the kernel?

No. Most existing tests for the Linux kernel are end-to-end tests, which
have their place. A well tested system has lots of unit tests, a
reasonable number of integration tests, and some end-to-end tests. KUnit
is just trying to address the unit test space which is currently not
being addressed.

## More information on KUnit

There is a bunch of documentation near the end of this patch set that
describes how to use KUnit and best practices for writing unit tests.
For convenience I am hosting the compiled docs here[2].

Additionally for convenience, I have applied these patches to a
branch[3].
The repo may be cloned with:
git clone https://kunit.googlesource.com/linux
This patchset is on the kunit/rfc/v5.1/v3 branch.

## Changes Since Last Version

- Converted KUnit core to print test results in TAP14 format as
  suggested by Greg and Frank.
- Heavily reworked tools/testing/kunit/kunit.py
  - Changed how parsing works.
  - Added testing.
- Added documentation on how to use KUnit on non-UML kernels. You can
  see the docs rendered here[1].
- Added a new set of EXPECTs and ASSERTs for pointer comparison.
- Removed more function indirection as suggested by Logan.
- Added a new patch that adds `kunit_try_catch_throw` to objtool's
  noreturn list.
- Fixed a number of minorish issues pointed out by Shuah, Masahiro, and
  kbuild bot.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.1/v3

-- 
2.21.0.1020.gf2820cf01a-goog

