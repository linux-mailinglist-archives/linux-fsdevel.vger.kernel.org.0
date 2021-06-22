Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EB23B067B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 16:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhFVOJN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 10:09:13 -0400
Received: from foss.arm.com ([217.140.110.172]:49792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhFVOJM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:09:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 889B9ED1;
        Tue, 22 Jun 2021 07:06:56 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E7273F694;
        Tue, 22 Jun 2021 07:06:51 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>
Subject: [PATCH v5 0/4] make '%pD' print the full path of file
Date:   Tue, 22 Jun 2021 22:06:30 +0800
Message-Id: <20210622140634.2436-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Background
==========
Linus suggested printing the full path of file instead of printing
the components as '%pd'.

Typically, there is no need for printk specifiers to take any real locks
(ie mount_lock or rename_lock). So I introduce a new helper d_path_fast
which is similar to d_path except it doesn't take any seqlock/spinlock.

This series is based on Al Viro's d_path cleanup patches [1] which
lifted the inner lockless loop into a new helper. 

Link: https://lkml.org/lkml/2021/5/18/1260 [1]

Test
====
The cases I tested:
1. print '%pD' with full path of ext4 file
2. mount a ext4 filesystem upon a ext4 filesystem, and print the file
   with '%pD'
3. all test_print selftests, including the new '%14pD' '%-14pD'
4. kasnprintf
   
Changelog
=========
v5:
- remove the RFC tag
- refine the commit msg/comments(by Petr, Andy)
- make using_scratch_space a new parameter of the test case 

v4:
- don't support spec.precision anymore for '%pD'
- add Rasmus's patch into this series
 
v3:
- implement new d_path_unsafe to use [buf, end] instead of stack space for
  filling bytes (by Matthew)
- add new test cases for '%pD'
- drop patch "hmcdrv: remove the redundant directory path" before removing rfc.

v2: 
- implement new d_path_fast based on Al Viro's patches
- add check_pointer check (by Petr)
- change the max full path size to 256 in stack space

v1: https://lkml.org/lkml/2021/5/8/122


Jia He (3):
  fs: introduce helper d_path_unsafe()
  lib/vsprintf.c: make '%pD' print the full path of file
  lib/test_printf.c: add test cases for '%pD'

Rasmus Villemoes (1):
  lib/test_printf.c: split write-beyond-buffer check in two

 Documentation/core-api/printk-formats.rst |   5 +-
 fs/d_path.c                               | 104 +++++++++++++++++++++-
 include/linux/dcache.h                    |   1 +
 lib/test_printf.c                         |  54 ++++++++---
 lib/vsprintf.c                            |  40 ++++++++-
 5 files changed, 184 insertions(+), 20 deletions(-)

-- 
2.17.1

