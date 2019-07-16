Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 834436A553
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 11:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbfGPJnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 05:43:11 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:51992 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfGPJnK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:43:10 -0400
Received: by mail-vs1-f73.google.com with SMTP id b7so4180760vsr.18
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pGdEsik+1M6jb/HINg07WI5yjzJ1jMxME0W4+2uDrMc=;
        b=eAEOpY1OH/FnKVljQodIm2gUsxEwhjJezpJfsDh5+L9jGMf2prsNq4n5iGGl8lhFcy
         3GIJYBh3yNP4rG6hnKRTyj90mHYFk0BHKtIgiGVyRA9kF/uIcjPZdmXbW8ZEQW4EZ5IH
         SXn4qORJzI5ksZoYb5wqvx7hlnvhT2sxT5FgtaGJr+HG+NjnhSJ69g9xxveqLaNBs89a
         ktkggSKnDQEOXJdhLHX3eRSCy+Xqa76qSYaf55Id0NRKz4na4h3mnh2/MOGZbY4WN6E8
         fCBR1frwWPhwmOtJudmJgXI/JrEuT7i8sdsJFK8HYCxGVYzU3slHOExwB171GfmM6DRJ
         5ZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pGdEsik+1M6jb/HINg07WI5yjzJ1jMxME0W4+2uDrMc=;
        b=suGe22+abMLCrCCkQjScrnzCPilOGRHHcwgr2lo2baTe5mQFnhAm1trhr2GoDjWKOO
         ZRxd1QrL3UJaADQtm8ILSF4q918+weiLQpuGYC3mW338TzVvpL/7i12hRiINe86ie3r5
         4Nl8qVzpYnGu1FRnYxfhrYowQ2Xl8JHQ56M2RiDvvvET4Bu88xjou3/CoCFmrLcOWzbB
         2hI1ug1SaNGUl3ZeFeO4AGykZLipELYAyD4nZSmiVjMBbwkIHMc5iag4TI+Ai3x5Ye3K
         gVKricG4uUhjo+yHMTcEyfvt1+Bve1BTADy+PVF+2EMnN40jMqAe3R4GPsPoM0evrjSD
         gaGg==
X-Gm-Message-State: APjAAAU07TnDAECHRYepKXJdZf0wpT+ntpIaZhD8cdjGYwXnV6kGOCbs
        AshCLJLPmIMJ6OVVMiSG2jQceXZABaTRKutWyjRaOA==
X-Google-Smtp-Source: APXvYqw3wlXdIHgaqyGI3Fkb5EoQvIKrYD7PYJZvCXqueiq4LTaNvNX4mlOb1gL0HCxxqPqMgE7qX6kvoBg4NaGW2/1i8w==
X-Received: by 2002:a9f:230c:: with SMTP id 12mr15226541uae.85.1563270188644;
 Tue, 16 Jul 2019 02:43:08 -0700 (PDT)
Date:   Tue, 16 Jul 2019 02:42:44 -0700
Message-Id: <20190716094302.180360-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v10 00/18] kunit: introduce KUnit, the Linux kernel unit
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

This patchset addresses comments from Stephen Boyd. Most changes are
pretty minor, but this does fix a couple of bugs pointed out by Stephen.

I imagine that Stephen will probably have some more comments, but I
wanted to get this out for him to look at as soon as possible.

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
This patchset is on the kunit/rfc/v5.2/v10 branch.

## Changes Since Last Version

- Went back to using spinlock in `struct kunit`. Needed for resource
  management API. Thanks to Stephen for this change.
- Fixed bug where an init failure may not be recorded as a failure in
  patch 01/18.
- Added append method to string_stream as suggested by Stephen.
- Mostly pretty minor changes after that, which mostly pertain to
  string_stream and kunit_stream.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2/v10

-- 
2.22.0.510.g264f2c817a-goog

