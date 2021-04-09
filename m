Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC32359360
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 05:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhDIDru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 23:47:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16059 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhDIDrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:47:49 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGkXc1HR8zPpPs;
        Fri,  9 Apr 2021 11:44:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 11:47:29 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yuqi Jin <jinyuqi@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH] fs: Optimized file struct to improve performance
Date:   Fri, 9 Apr 2021 11:47:37 +0800
Message-ID: <1617940057-52843-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yuqi Jin <jinyuqi@huawei.com>

In the syscall process, @f_count and @f_mod are frequently used, if
we put them together with each other and they will share the same
cacheline. It is useful for the performance.

syscall of unixbench is tested on Intel 8180.
before this patch
80 CPUs in system; running 80 parallel copies of tests

System Call Overhead                    3789860.2 lps   (10.0 s, 1 samples)

System Benchmarks Partial Index              BASELINE       RESULT    INDEX
System Call Overhead                          15000.0    3789860.2   2526.6
                                                                   ========
System Benchmarks Index Score (Partial Only)                         2526.6

after this patch
80 CPUs in system; running 80 parallel copies of tests

System Call Overhead                    3951328.1 lps   (10.0 s, 1 samples)

System Benchmarks Partial Index              BASELINE       RESULT    INDEX
System Call Overhead                          15000.0    3951328.1   2634.2
                                                                   ========
System Benchmarks Index Score (Partial Only)                         2634.2

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Yuqi Jin <jinyuqi@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 include/linux/fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3fbb98126248..cfc91d2dd6a7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -917,7 +917,6 @@ struct file {
 		struct llist_node	fu_llist;
 		struct rcu_head 	fu_rcuhead;
 	} f_u;
-	struct path		f_path;
 	struct inode		*f_inode;	/* cached value */
 	const struct file_operations	*f_op;
 
@@ -926,13 +925,14 @@ struct file {
 	 * Must not be taken from IRQ context.
 	 */
 	spinlock_t		f_lock;
-	enum rw_hint		f_write_hint;
 	atomic_long_t		f_count;
 	unsigned int 		f_flags;
 	fmode_t			f_mode;
 	struct mutex		f_pos_lock;
 	loff_t			f_pos;
 	struct fown_struct	f_owner;
+	enum rw_hint		f_write_hint;
+	struct path		f_path;
 	const struct cred	*f_cred;
 	struct file_ra_state	f_ra;
 
-- 
2.7.4

