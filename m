Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA473A8516
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 17:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhFOPxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 11:53:22 -0400
Received: from foss.arm.com ([217.140.110.172]:39002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232169AbhFOPwI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:52:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B60E913A1;
        Tue, 15 Jun 2021 08:50:03 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 102773F694;
        Tue, 15 Jun 2021 08:49:58 -0700 (PDT)
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
        Jia He <justin.he@arm.com>
Subject: [PATCH RFCv4 0/4] make '%pD' print full path for file
Date:   Tue, 15 Jun 2021 23:49:48 +0800
Message-Id: <20210615154952.2744-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Background
==========
Linus suggested printing full path for file instead of printing
the components as '%pd'.

Typically, there is no need for printk specifiers to take any real locks
(ie mount_lock or rename_lock). So I introduce a new helper d_path_fast
which is similar to d_path except it doesn't take any seqlock/spinlock.

This series is based on Al Viro's d_path cleanup patches [1] which
lifted the inner lockless loop into a new helper. 

[1] https://lkml.org/lkml/2021/5/18/1260

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

Jia He (4):
  fs: introduce helper d_path_unsafe()
  lib/vsprintf.c: make '%pD' print full path for file
  lib/test_printf.c: split write-beyond-buffer check in two
  lib/test_printf.c: add test cases for '%pD'

 Documentation/core-api/printk-formats.rst |  5 +-
 fs/d_path.c                               | 83 ++++++++++++++++++++++-
 include/linux/dcache.h                    |  1 +
 lib/test_printf.c                         | 31 ++++++++-
 lib/vsprintf.c                            | 37 ++++++++--
 5 files changed, 148 insertions(+), 9 deletions(-)

-- 
2.17.1

