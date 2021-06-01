Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1139396AE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 04:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhFACOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 22:14:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2807 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhFACOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 22:14:55 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvFtz0y7dzWq2c;
        Tue,  1 Jun 2021 10:08:27 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 10:13:03 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 10:12:49 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yuqi Jin <jinyuqi@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH RESEND] fs: Optimized file struct to improve performance
Date:   Tue, 1 Jun 2021 10:12:37 +0800
Message-ID: <1622513557-46189-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
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
Hi,
    Sorry for the noise that I resent the patch since v1[1], while
Intel's robot gives the 19.2% improvement[2].

[1]https://www.spinics.net/lists/linux-fsdevel/msg192888.html
[2]https://www.spinics.net/lists/linux-fsdevel/msg193521.html

 include/linux/fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..23baa7c8301b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -922,7 +922,6 @@ struct file {
 		struct llist_node	fu_llist;
 		struct rcu_head 	fu_rcuhead;
 	} f_u;
-	struct path		f_path;
 	struct inode		*f_inode;	/* cached value */
 	const struct file_operations	*f_op;
 
@@ -931,13 +930,14 @@ struct file {
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

