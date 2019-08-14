Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41F8CACA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 07:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfHNFwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 01:52:10 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50639 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfHNFwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 01:52:10 -0400
Received: by mail-pg1-f202.google.com with SMTP id q9so67760215pgv.17
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 22:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JIx6gT8XrMurJkYFq0Mwh3doyQoWfrR1Obdr19umRAo=;
        b=lYtLPslE++KBhps7EtMXbyUcustGXe90OzEpA99zwHxQbVzot3NR81r30SxELmpTRj
         bFTX6PGmhfSfkUB0/hnN4TiDWPb9DGLT5n61SEFnAdjshDyjj9bfjOnYsVA8+2Wxa382
         hltZppNluZLMP3S27A5ep9xYE0fIqIXqNkFfqFxv/fX4amYyXfyPeKZMuHa0KtJyXYcL
         3dfzQ9XQrdy8jFFrB3jJCdZRXVPkDPt0BxDMzHm0Rbo2i7qahJfYSiN5kDw0wJhAXIM9
         5J0ignULWuWomRnfxW/Cnhs9Nkq0yzbvKJSmYrGdmqVvm6nl9IXqxbyhcWibeLv1FLvS
         sTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JIx6gT8XrMurJkYFq0Mwh3doyQoWfrR1Obdr19umRAo=;
        b=Ox1it+tR1LJJSWcG9Y0q11xqr6iaHiQHTDM+IztuLpq2BsrkVqlVaaI9408jL/rQ29
         JAYQ1i04KRRsJ12FTAfTEFLHjNbHu4NpObDvBIyH5DtfubQksL5/cFnUwj4kblVRhLyy
         NVt2T7ijfUhvcDUmWMGnqGx6h05wLzdg+iT6cKitzPQt0rxxsTuMUVmGfkmJ199pYLFx
         ucetxrPpFYoApvoSlUx5giCl71W+eXvpWYdm87AOsADGxvD/zXB5FRVL2WhLm9LyedZb
         6v42FTKNkNqVcifsyXSZyKJ+Lv680WaSJgU4D3fH3XNBI2F/Rw7R1qXjO7M9yqcB/dQD
         q4wQ==
X-Gm-Message-State: APjAAAVIZAsPN4/EQfmpUVM/VVyvStMlrDRvGbgFYgaHd/BQ6LrMkOzl
        3XO0/jf6bL5UK38e6U1P9ea2iJBpti8mMRfwl8/cZg==
X-Google-Smtp-Source: APXvYqzpu9CiuWlTANWLufkskZGUP8V49k9uzqoRz2WmUPz8UVqc7iwJcusHzog7K8pIU/rzSJgkN1EhsWWgKYr26ckb6g==
X-Received: by 2002:a63:6c4:: with SMTP id 187mr34796011pgg.401.1565761928470;
 Tue, 13 Aug 2019 22:52:08 -0700 (PDT)
Date:   Tue, 13 Aug 2019 22:50:50 -0700
Message-Id: <20190814055108.214253-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v13 00/18] kunit: introduce KUnit, the Linux kernel unit
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
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

## TL;DR

This revision addresses comments from Stephen and Bjorn Helgaas. Most
changes are pretty minor stuff that doesn't affect the API in anyway.
One significant change, however, is that I added support for freeing
kunit_resource managed resources before the test case is finished via
kunit_resource_destroy(). Additionally, Bjorn pointed out that I broke
KUnit on certain configurations (like the default one for x86, whoops).

Based on Stephen's feedback on the previous change, I think we are
pretty close. I am not expecting any significant changes from here on
out.

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
This patchset is on the kunit/rfc/v5.3/v13 branch.

## Changes Since Last Version

- Added support for freeing kunit_resources (KUnit managed resources)
  via kunit_resource_destroy() as suggested by Stephen.
- Promoted WARN() after __noreturn function to BUG() in
  "[PATCH v13 09/18] kunit: test: add support for test abort" as
  suggested by Stephen.
- Dropped concept of death test since I am not actually using it yet as
  pointed out by Stephen.
- Replaced usage of warn_slowpath_fmt with WARN in kunit_do_assertion
  since warn_slowpath_fmt is not available on some build configurations,
  as pointed out by Bjorn.
- Lots of other minor changes suggested by Stephen.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.3/v13

-- 
2.23.0.rc1.153.gdeed80330f-goog

