Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA135F4FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 15:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351421AbhDNNkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 09:40:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16916 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351401AbhDNNkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:40:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FL3ST6xz1zjZBp;
        Wed, 14 Apr 2021 21:37:45 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 14 Apr 2021
 21:39:29 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [RFC PATCH v2 6/7] fs: introduce a usage count into the superblock
Date:   Wed, 14 Apr 2021 21:47:36 +0800
Message-ID: <20210414134737.2366971-7-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210414134737.2366971-1-yi.zhang@huawei.com>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit <87d8fe1ee6b8> ("add releasepage hooks to block devices which can
be used by file systems") introduce a hook that used by ext4 filesystem
to release journal buffers, but it doesn't add corresponding concurrency
protection that ->bdev_try_to_free_page() could be raced by umount
filesystem concurrently. This patch add a usage count on superblock that
filesystem can use it to prevent above race and make invoke
->bdev_try_to_free_page() safe.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 include/linux/fs.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..3c6a5c08c2df 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -41,6 +41,7 @@
 #include <linux/stddef.h>
 #include <linux/mount.h>
 #include <linux/cred.h>
+#include <linux/percpu-refcount.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1547,6 +1548,13 @@ struct super_block {
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
+
+	/*
+	 * Count users who are using the super_block, used to protect
+	 * umount filesystem concurrently with others.
+	 */
+	struct percpu_ref	s_usage_counter;
+	wait_queue_head_t	s_usage_waitq;
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will
@@ -1765,6 +1773,27 @@ static inline bool sb_start_intwrite_trylock(struct super_block *sb)
 bool inode_owner_or_capable(struct user_namespace *mnt_userns,
 			    const struct inode *inode);
 
+static inline void sb_usage_counter_release(struct percpu_ref *ref)
+{
+	struct super_block *sb;
+
+	sb = container_of(ref, struct super_block, s_usage_counter);
+	wake_up(&sb->s_usage_waitq);
+}
+
+static inline int sb_usage_counter_init(struct super_block *sb)
+{
+	init_waitqueue_head(&sb->s_usage_waitq);
+	return percpu_ref_init(&sb->s_usage_counter, sb_usage_counter_release,
+			       0, GFP_KERNEL);
+}
+
+static inline void sb_usage_counter_wait(struct super_block *sb)
+{
+	percpu_ref_kill(&sb->s_usage_counter);
+	wait_event(sb->s_usage_waitq, percpu_ref_is_zero(&sb->s_usage_counter));
+}
+
 /*
  * VFS helper functions..
  */
-- 
2.25.4

