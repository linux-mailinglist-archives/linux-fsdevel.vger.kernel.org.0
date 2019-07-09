Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E86763077
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 08:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfGIGcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 02:32:42 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:46290 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGIGcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:32:42 -0400
Received: by mail-yw1-f73.google.com with SMTP id q79so12559762ywg.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2019 23:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ccEO1tkkeH8HT1/mhIGVUKFl/9lAslI495fANVrqi9k=;
        b=e2JKyD27N2epGYfKgaRHgJrtns9MYtHULutiWECP0zFRJv3jgMPgvU/mgzt7m2CruN
         qyDh4tO7vEMXIwz5uC90ZiqlsOp6jxtaX8TLEstg/mB6t2n5nc3E1nANny//4ZuViIuT
         Q3ccwNzcmvwEgQPy45ljMduIsRcMZ+yyArZsE7tNVMmyeTDybeKjOVOQs49sE+w8xRgU
         l6IbFINnO1SRMJvZ1e6x0/QcQs5GYjWItk2Tf6QcJnNv92P+Yml808NgCvyRAieR+7tt
         vVHGQ59GH0W9PqLAZQXcyb1ZKKpl+uFrILyK+81ZrKs3HHFsWjaaDhu+6fgoH9G5s9wC
         jETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ccEO1tkkeH8HT1/mhIGVUKFl/9lAslI495fANVrqi9k=;
        b=JLC2b6X8amlYPa+tSYoi9kCeKP00VN237/bdtQN+PpYBZ1V4A7KRCZc9wYC5zNiAKg
         B/T07rCYXMNsV0jGf7l0+ZJr3DTdhBaR54KT2M5WgJPGu0OfQjMVQhKffUhgl0WQ3Hn4
         6W4xQuy4823QeKHUmkZWCX5/mmxSuu20tkFjSMCEs2M3dfg61I5M1bNkNbuxrsfW1ylx
         jTSkfzY2ph5Oo8rdLieQjZnWtfiAEnPtLtcD6fp3J0zEoSVQBAAs4IX8LgLLhbL/IH9C
         ZCTv60l37AhjWyaP2otDNK1PeDyPZZUYUvj4+k/w/ln08f/MyvmGV6dY03jJWMQw75Sz
         gSeA==
X-Gm-Message-State: APjAAAWjO/WRqH6Bk0xd0nrTAIb82hAtqsDK6DEUfgO0ztg+KXbPqf7s
        DvSXEyFSZ1FI5iGIVIS8FzrMHm3GBOo/ZK8jxJW7cA==
X-Google-Smtp-Source: APXvYqxTCUgwXCc9biuo/mRL1pSgsNPvKrcZOBY5oaano9+5jCyWavrpS1UTvqWVKgVXm3lya3N2nYit0+zc7OI5xI8uZg==
X-Received: by 2002:a81:710a:: with SMTP id m10mr13083743ywc.277.1562653960705;
 Mon, 08 Jul 2019 23:32:40 -0700 (PDT)
Date:   Mon,  8 Jul 2019 23:30:05 -0700
Message-Id: <20190709063023.251446-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v7 00/18] kunit: introduce KUnit, the Linux kernel unit
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
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

## TL;DR

This is a pretty straightforward follow-up to Luis' comments on PATCH
v6: There is nothing that changes any functionality or usage.

As for our current status, we only need reviews/acks on the following
patches:

- [PATCH v7 06/18] kbuild: enable building KUnit
  - Need a review or ack from Masahiro Yamada or Michal Marek
- [PATCH v7 08/18] objtool: add kunit_try_catch_throw to the noreturn
  list
  - Need a review or ack from Josh Poimboeuf or Peter Zijlstra

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
This patchset is on the kunit/rfc/v5.2/v7 branch.

## Changes Since Last Version

Aside from renaming `struct kunit_module` to `struct kunit_suite`, there
isn't really anything in here that changes any functionality:

- Rebased on v5.2
- Added Iurii as a maintainer for PROC SYSCTL, as suggested by Luis.
- Removed some references to spinlock that I failed to remove in the
  previous version, as pointed out by Luis.
- Cleaned up some comments, as suggested by Luis.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2/v7

-- 
2.22.0.410.gd8fdbe21b5-goog

