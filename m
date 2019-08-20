Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8171496D9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 01:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfHTXUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 19:20:55 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:37265 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfHTXUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:20:54 -0400
Received: by mail-vk1-f202.google.com with SMTP id c199so75201vkc.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=d/yRotIqofKL6ivNLT0spFL8C+ImKotVaARxIwjjT6U=;
        b=AVw2bVu+4NwiDCTMe7ctCvAsytyWg/rXh1qSlFIYcZ34MZ2W4zFBX61usfUDXKDI+U
         6mkzeHkKvCm3jsXc7ellvdvzMZ/yYq5pQYIgEJEeej2GmzjldUwbhas7sVL0y1BF9R5Q
         aeLd89FDK15SPfbl+SuyrbqBs3o2uiag6LIW+dn6YgaIXzRVfITYu/qa+PVnh2pu0la1
         EgwkQGeMgeft4WVs3y+cr1sGSCDFeF0e6bPs6wefJLtZGnA3fREotyJnv1WY33ED8Kos
         PZta1YwDrJCXLZftQ0jdf7GzZQX+uUMqkEw7bGquy+vwd3aApIC+kCto7n+WJu4zEbsw
         +lOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=d/yRotIqofKL6ivNLT0spFL8C+ImKotVaARxIwjjT6U=;
        b=TdQqxXF/gQ6DrOEXG+jnu6NdOUfaJVoZtfNCYNFjIhY5nzLZaxaVzVuY3JYiNKzR4n
         ijQU++Z7LMwU6kqJybyAvbBXZw3LIIYni3ua4QEh3XN+A/bzgim6IfdPFobqLH4A91UT
         AOp58osq73DAfqK92u86Qo+ctjP6f1dl/rGSShaRKw7UZWtg+X/Vj8hoG7f1PH+irJBI
         rVaLfNG44uWzq3n8xnAOR10cke6FsNIaMurWJSZnlc8lBuE4YM2jnS9/LIZj9/JmDzyG
         hqUJ2nDZ3f8CvAsThsCel04uZmHjMECxVlivblIi0ahYSMLiGYglkxb71AQScttecyUF
         Nn2w==
X-Gm-Message-State: APjAAAWSizqAXbN7ptCKK5WGF3KfE2/eVDpu98MVNypcSba7RFGoo1z3
        jGpDCxhrMYaXCqlwmUFoDR6jx9UBf/MzG/Bd/6QReg==
X-Google-Smtp-Source: APXvYqxI/nPId+DHfk6D741GOqFrVhdMCpaqnV+6xqhMReBcYshk3sm1bvTSqco2NKWiElhS3+UgytqYYzLVwPw9MVYXZA==
X-Received: by 2002:a67:2605:: with SMTP id m5mr19353609vsm.120.1566343253112;
 Tue, 20 Aug 2019 16:20:53 -0700 (PDT)
Date:   Tue, 20 Aug 2019 16:20:28 -0700
Message-Id: <20190820232046.50175-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v14 00/18] kunit: introduce KUnit, the Linux kernel unit
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

This revision addresses comments from Shuah by removing two macros that
were causing checkpatch errors. No API or major structual changes have
been made since v13.

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
This patchset is on the kunit/rfc/v5.3/v14 branch.

## Changes Since Last Version

- Removed to macros which helped define expectation and assertion
  macros; these values are now just copied and pasted. Change was made
  to fix checkpatch error, as suggested by Shuah.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.3/v14

-- 
2.23.0.rc1.153.gdeed80330f-goog

