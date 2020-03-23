Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D941218FA0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 17:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgCWQjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 12:39:04 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:60734 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727234AbgCWQjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:39:03 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 607A92E152E;
        Mon, 23 Mar 2020 19:39:00 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id jWwzoNdhbo-d0j4RkDT;
        Mon, 23 Mar 2020 19:39:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1584981540; bh=zTTQKR+VKnK5VPfkvW5AiK8AFpqm3pZyCRE1yhsG6C4=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=bnhCG/VMk2kQlBnbzL9B5P3h2UEOaulch82QuJyuPsryKJkl37OGU8PhOu4NDvdar
         sQWw1cwiz1iUot5HtsjkgeuaI7U+ZU9KUnorAYy9/WJq2yZdSQkwsR2q7x+t2sxZj3
         uRs/nMnx6l1T6XXgQ1al+lLIbIKeNilKxHaCcU28=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6803::1:2])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 15DoWmPvFf-cxbO6bfO;
        Mon, 23 Mar 2020 19:38:59 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] lib/test_lockup: add parameters for locking generic vfs
 locks
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Date:   Mon, 23 Mar 2020 19:38:59 +0300
Message-ID: <158498153964.5621.83061779039255681.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

file_path=<path>	defines file or directory to open
lock_inode=Y		set lock_rwsem_ptr to inode->i_rwsem
lock_mapping=Y		set lock_rwsem_ptr to mapping->i_mmap_rwsem
lock_sb_umount=Y	set lock_rwsem_ptr to sb->s_umount

This gives safe and simple way to see how system reacts to contention of
common vfs locks and how syscalls depend on them directly or indirectly.

For example to block s_umount for 60 seconds:
# modprobe test_lockup file_path=. lock_sb_umount time_secs=60 state=S

This is useful for checking/testing scalability issues like this:
https://lore.kernel.org/lkml/158497590858.7371.9311902565121473436.stgit@buzz/

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 lib/test_lockup.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index 83683ec1f429..ea09ca335b21 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -14,6 +14,7 @@
 #include <linux/nmi.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <linux/file.h>
 
 static unsigned int time_secs;
 module_param(time_secs, uint, 0600);
@@ -140,6 +141,24 @@ static bool reallocate_pages;
 module_param(reallocate_pages, bool, 0400);
 MODULE_PARM_DESC(reallocate_pages, "free and allocate pages between iterations");
 
+struct file *test_file;
+struct inode *test_inode;
+static char test_file_path[256];
+module_param_string(file_path, test_file_path, sizeof(test_file_path), 0400);
+MODULE_PARM_DESC(file_path, "file path to test");
+
+static bool test_lock_inode;
+module_param_named(lock_inode, test_lock_inode, bool, 0400);
+MODULE_PARM_DESC(lock_inode, "lock file -> inode -> i_rwsem");
+
+static bool test_lock_mapping;
+module_param_named(lock_mapping, test_lock_mapping, bool, 0400);
+MODULE_PARM_DESC(lock_mapping, "lock file -> mapping -> i_mmap_rwsem");
+
+static bool test_lock_sb_umount;
+module_param_named(lock_sb_umount, test_lock_sb_umount, bool, 0400);
+MODULE_PARM_DESC(lock_sb_umount, "lock file -> sb -> s_umount");
+
 static atomic_t alloc_pages_failed = ATOMIC_INIT(0);
 
 static atomic64_t max_lock_wait = ATOMIC64_INIT(0);
@@ -490,6 +509,29 @@ static int __init test_lockup_init(void)
 		return -EINVAL;
 	}
 
+	if (test_file_path[0]) {
+		test_file = filp_open(test_file_path, O_RDONLY, 0);
+		if (IS_ERR(test_file)) {
+			pr_err("cannot find file_path\n");
+			return -EINVAL;
+		}
+		test_inode = file_inode(test_file);
+	} else if (test_lock_inode ||
+		   test_lock_mapping ||
+		   test_lock_sb_umount) {
+		pr_err("no file to lock\n");
+		return -EINVAL;
+	}
+
+	if (test_lock_inode && test_inode)
+		lock_rwsem_ptr = (unsigned long)&test_inode->i_rwsem;
+
+	if (test_lock_mapping && test_file && test_file->f_mapping)
+		lock_rwsem_ptr = (unsigned long)&test_file->f_mapping->i_mmap_rwsem;
+
+	if (test_lock_sb_umount && test_inode)
+		lock_rwsem_ptr = (unsigned long)&test_inode->i_sb->s_umount;
+
 	pr_notice("START pid=%d time=%u +%u ns cooldown=%u +%u ns iterations=%u state=%s %s%s%s%s%s%s%s%s%s%s%s\n",
 		  main_task->pid, time_secs, time_nsecs,
 		  cooldown_secs, cooldown_nsecs, iterations, state,
@@ -542,6 +584,9 @@ static int __init test_lockup_init(void)
 
 	pr_notice("FINISH in %llu ns\n", local_clock() - test_start);
 
+	if (test_file)
+		fput(test_file);
+
 	if (signal_pending(main_task))
 		return -EINTR;
 

