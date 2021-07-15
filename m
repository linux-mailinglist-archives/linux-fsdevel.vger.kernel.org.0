Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97DE3C9576
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 03:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhGOBRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 21:17:12 -0400
Received: from foss.arm.com ([217.140.110.172]:45018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230388AbhGOBRM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:17:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E622131B;
        Wed, 14 Jul 2021 18:14:19 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B68A33F7D8;
        Wed, 14 Jul 2021 18:14:14 -0700 (PDT)
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
Subject: [PATCH v7 0/5] make '%pD' print the full path of file
Date:   Thu, 15 Jul 2021 09:14:02 +0800
Message-Id: <20210715011407.7449-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Background
==========
Linus suggested printing the full path of file instead of printing
the components as '%pd'.

Typically, there is no need for printk specifiers to take any real locks
(ie mount_lock or rename_lock). So I introduce a new helper
d_path_unsafe() which is similar to d_path() except it doesn't take any
seqlock/spinlock.

Test
====
The cases I tested:
1. print '%pD' with full path of ext4 file
2. mount a ext4 filesystem upon a ext4 filesystem, and print the file
   with '%pD'
3. all test_print selftests, including the new '%14pD' '%-14pD'
4. kasprintf

TODO
====
I plan to do the followup work after '%pD' behavior is changed.
- s390/hmcdrv: remove the redundant directory path in printing string.
- fs/iomap: simplify the iomap_swapfile_fail() with '%pD'.
- simplify the string printing when file_path() is invoked(in some
  cases, not all).
- change the previous '%pD[2,3,4]' to '%pD'
   
Changelog
=========
v7:
- rebase to 5.14-rc1 after Al Viro d_path cleanup series was merged
- add patch1/5 to fix the kernel doc validator issue
- refine the commit msg, add more comments for the smp_load_acquire in
  prepend_name_with_len()

v6(new v2):https://lkml.org/lkml/2021/6/23/44
- refine the commit msg/comments (Andy)
- pass the validator check by "make C=1 W=1"
- add the R-b for patch 4/4 from Andy

v5(new v1): https://lkml.org/lkml/2021/6/22/680
- remove the RFC tag
- refine the commit msg/comments(by Petr, Andy)
- make using_scratch_space a new parameter of the test case 

RFCv4:
- don't support spec.precision anymore for '%pD'
- add Rasmus's patch into this series
 
RFCv3:
- implement new d_path_unsafe to use [buf, end] instead of stack space for
  filling bytes (by Matthew)
- add new test cases for '%pD'
- drop patch "hmcdrv: remove the redundant directory path" before removing rfc.

RFCv2: 
- implement new d_path_fast based on Al Viro's patches
- add check_pointer check (by Petr)
- change the max full path size to 256 in stack space

RFCv1: https://lkml.org/lkml/2021/5/8/122

Jia He (4):
  d_path: fix Kernel doc validator complaints
  d_path: introduce helper d_path_unsafe()
  lib/vsprintf.c: make '%pD' print the full path of file
  lib/test_printf.c: add test cases for '%pD'

Rasmus Villemoes (1):
  lib/test_printf.c: split write-beyond-buffer check in two

 Documentation/core-api/printk-formats.rst |   7 +-
 fs/d_path.c                               | 123 ++++++++++++++++++++--
 include/linux/dcache.h                    |   1 +
 lib/test_printf.c                         |  54 ++++++++--
 lib/vsprintf.c                            |  40 ++++++-
 5 files changed, 202 insertions(+), 23 deletions(-)

-- 
2.17.1

