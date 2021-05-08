Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8893771B5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 May 2021 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhEHMaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 May 2021 08:30:14 -0400
Received: from foss.arm.com ([217.140.110.172]:53538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230419AbhEHMaN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 May 2021 08:30:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4244ED1;
        Sat,  8 May 2021 05:29:11 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3FAA43F73B;
        Sat,  8 May 2021 05:29:05 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@ftp.linux.org.uk>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jia He <justin.he@arm.com>
Subject: [PATCH RFC 0/3] make '%pD' print full path for file
Date:   Sat,  8 May 2021 20:25:27 +0800
Message-Id: <20210508122530.1971-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At [1], Linux suggested printing full path for file instead of printing
the components as '%pd'.

Typically, there is no need for printk specifiers to take any real locks
(ie mount_lock or rename_lock). So I introduce a new helper d_path_fast
which is similar to d_path except not taking any seqlock/spinlock.

The cases I tested:
1. print %pD with full path when opening a ext4 file
2. mount a ext4 filesystem upon a ext4 filesystem, and print the file
   with %pD
3. print the file full path which has more than 128 chars
4. all test_print selftests

After this set, I noticed there are many lines which contained "%pD[234]"
that should be changed to "%pD". I don't want to involve those
subsystems in this patch series before the helper is satisfied with
everyone.

You can get the lines by 
$find fs/ -name \*.[ch] | xargs grep -rn "\%pD[234]"
	 
[1] https://lore.kernel.org/lkml/CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/

Jia He (3):
  fs: introduce helper d_path_fast()
  lib/vsprintf.c: make %pD print full path for file
  s390/hmcdrv: remove the redundant directory path in debug message

 Documentation/core-api/printk-formats.rst |  5 ++-
 drivers/s390/char/hmcdrv_dev.c            | 10 ++---
 fs/d_path.c                               | 51 +++++++++++++++++------
 include/linux/dcache.h                    |  1 +
 lib/vsprintf.c                            | 12 +++++-
 5 files changed, 58 insertions(+), 21 deletions(-)

-- 
2.17.1

