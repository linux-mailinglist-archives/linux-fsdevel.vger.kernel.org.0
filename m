Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C334C8A646
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 20:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfHLSYl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 14:24:41 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:35171 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfHLSYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:24:40 -0400
Received: by mail-qk1-f202.google.com with SMTP id z2so13332346qkf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9mTljNvnyVjruVsrPNgUh53D69b4G0uh+rf/XKR7JZU=;
        b=LnitzvMrBNB6LXONfL+PvwD9Ikk/vWzKySiopcnIrxQgVqiY5+jLuNhJ9ZjzPBotY0
         Y0ntD2wGlkRwN/WqMUqePvF0CIftp/LQyZGsiE/rMamSPolRPy/gI1hWyTFrYjj8Az0S
         iO+WLGSlSP4wDNeKPbhpSACldOlKIN0vm2AbpOTth5lwOi+wd5FtPBH+6DMV4BF7XZ5u
         DCsO7wsqQZmhB7r+8C/SPCwSznOeI9ADcdzFPsEOZDZ9rWtgCf15F0uO/DhlcKvYD1vS
         ikhy6UaROEOWv19ZHJDw8MIz7i0jbDy1yYL+vXOT6UpBhCm16LBtfsDmmxW8jdqFq7iG
         CYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9mTljNvnyVjruVsrPNgUh53D69b4G0uh+rf/XKR7JZU=;
        b=LuYCd1xVmRqFLg3VrBlzm6wiPhMg96QWEqMOKqg2EfktAWMzJi0nHCQP+UR9iYtxIy
         Aov7xkKMkXEz6tkN5Y7gQ2PutjFgNq1nh7FnDOB6bDUbbkfGp4dULKZrcfZZkBcZf+hj
         prLpRUa8Z1uRBb6EXtLidRSWyXSwaDjdUL6ErjwPfjB333uVqGJ0QPxWXEvk2mTO+ONd
         HBnEXBSk4sZTDcWUZKgdKx5AUiXkntUvwM0l73RFJNew63eY8XIK251fU0Z0BRjluCMj
         p4iFDwrBgnSvlsqgld7nICdMPXoCEo6KnxLgiDpqkmKIdWi/Q2ZmWrCFvuoE27xfaD+l
         K/Bw==
X-Gm-Message-State: APjAAAX0uf7xRnpOnMyno7KFDoMaK5LfM6f3kjWCqpxyTZDGDjNyFY+H
        vDbeQTQUPsDBmuqmWo/KHNvF0BG9YkGatxXkN8BSTA==
X-Google-Smtp-Source: APXvYqyX/pgx0ykzeqZ6WcltGi5sso4Ln3mqeyyrGVZaHJD02/SPkwtsL4N8Ya+oDgvaUGfqUr1kIJOvfUwiqmtqKuHktw==
X-Received: by 2002:a37:4a88:: with SMTP id x130mr13395431qka.501.1565634278957;
 Mon, 12 Aug 2019 11:24:38 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:24:03 -0700
Message-Id: <20190812182421.141150-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v12 00/18] kunit: introduce KUnit, the Linux kernel unit
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

This revision removes dependence on kunit_stream in favor of
kunit_assert, as suggested by Stephen Boyd. kunit_assert provides a more
structured interface for constructing messages and allows most required
data to be stored on the stack for most expectations until it is
determined that a failure message must be produced.

As a part of introducing kunit_assert, expectations (KUNIT_EXPECT_*) and
assertions (KUNIT_ASSERT_*) have been substantially refactored.
Nevertheless, behavior should be the same.

As this revision, adds a new patch, it, [PATCH v12 04/18], needs to be
reviewed. All other patches have appropriate reviews and acks.

I also rebased the patchset on v5.3-rc3.

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
This patchset is on the kunit/rfc/v5.3/v12 branch.

## Changes Since Last Version

- Dropped patch "[PATCH v11 04/18] kunit: test: add kunit_stream a
  std::stream like logger" and replaced it with "[PATCH v12 04/18]
  kunit: test: add assertion printing library", which provides a totally
  new mechanism for constructing expectation/assertion failure messages.
- Substantially refactored expectations and assertions definitions in
  [PATCH 05/18] and [PATCH 11/18] respectively.
- Rebased patchset on v5.3-rc3.
- Fixed a minor documentation bug.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.3/v12

-- 
2.23.0.rc1.153.gdeed80330f-goog

