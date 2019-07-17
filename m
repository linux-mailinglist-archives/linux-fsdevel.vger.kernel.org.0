Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A516B420
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 03:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfGQBzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 21:55:54 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45549 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfGQBzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 21:55:53 -0400
Received: by mail-pl1-f201.google.com with SMTP id y9so11179788plp.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 18:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=g73VbK9hP8iwHcV/w0DEWc6A8T81W2obxVf/JscQhPY=;
        b=Vbb6ETWdoL7/dyTwrtnSjUAJji8HmC0dbYlvBQhYL3ZtcFa53MTUkxRV21Vh+xQzRU
         gtcMrgV6CsUcmCq6PHa2QI2RapBr3kPi3qcDZTk/V+RQINbCgIAGW9XgyyKfzkIP+4A2
         Cj9ApaRpGtUkElZpxENbPQ4y/LhEkO32Y8s6YtL6EobTN8efWAzcypCT1B1B2UtD/u4i
         A3n0+WeJDp01P7yO5hdDAfarVytQtTxJ7QrOXdADRb4dC2e7V8+WsZndPYZvAMZpQ4s7
         2BclIo1VrtBu6iu7lEVSZ2YJI8piqhPI0Z2qIl5B2wcZ4ToCguieuFOeyAl4qvN2wNXh
         HDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=g73VbK9hP8iwHcV/w0DEWc6A8T81W2obxVf/JscQhPY=;
        b=sNFRTIvb58OQGA9ZFnPlUVPscRHllYXoLR3tcEUJQK6b/vGeb8MEITintPvGNl++Zd
         ET1laNgXsh8mZwEB0lo00uejzEvgcHb41xSEJ7MJ/PY2onpytjO1Jol3Ia1dxDgS700y
         PiP0f6k62NGl23ZQvBuZG7H+BBG6REe/I/NDfyV0uRx2pzq7oMh1FzRihUe51tvDXuwN
         uHzv99Ep3yi0gGI0BwKGqbUGhfXZChJRcx1QRP1WBxJuCTAbew0H3LugPOMZTITNyqPv
         eXmJ0nK1kD6OO0d+eXKibuJ3LCHU9yXyG0r+bN9xmN54Ff93yhxU4c/FXsHenR3mAVW4
         Ay0Q==
X-Gm-Message-State: APjAAAUy+SQxEaIVkBQ0BaJ/KcDgUFynJk/cgNqb0IG1RW1DrqF/ExlE
        6ZFcXYpjSpuws1p9D+FKOfnQpPg+hA6lnmMShcHNsg==
X-Google-Smtp-Source: APXvYqzIJkjKQ3S+2BDLj5Fx/7Xa9wrPBuZpZW0wEdv7tjBDXndxr0psGCLPsqNbiarNlPEHuGD5doQNqhtuO1IsifVYng==
X-Received: by 2002:a63:2606:: with SMTP id m6mr37469748pgm.436.1563328552353;
 Tue, 16 Jul 2019 18:55:52 -0700 (PDT)
Date:   Tue, 16 Jul 2019 18:55:25 -0700
Message-Id: <20190717015543.152251-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v11 00/18] kunit: introduce KUnit, the Linux kernel unit
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

This patchset addresses comments from Stephen Boyd. No changes affect
the API, and all changes are specific to patches 02, 03, and 04;
however, there were some significant changes to how string_stream and
kunit_stream work under the hood.

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
This patchset is on the kunit/rfc/v5.2/v11 branch.

## Changes Since Last Version

- Went back to using spinlock in `struct string_stream`. Needed for so
  that it is compatible with different GFP flags to address comment from
  Stephen.
- Added string_stream_append function to string_stream API. - suggested
  by Stephen.
- Made all string fragments and other allocations internal to
  string_stream and kunit_stream managed by the KUnit resource
  management API.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2/v11

-- 
2.22.0.510.g264f2c817a-goog

