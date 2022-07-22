Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D330357DAE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 09:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiGVHOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 03:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiGVHOG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:14:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7160D93C39;
        Fri, 22 Jul 2022 00:14:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FEE062198;
        Fri, 22 Jul 2022 07:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D34C385A5;
        Fri, 22 Jul 2022 07:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658474043;
        bh=rxppfGAWTvoazShXWqiRQAPwYvWCuKApheXmuFc/BQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8Cr8JecsbZeIRQ5t/ggsqjOh0c2t2g7QqlNyJmjUUDIPAUtozy6cOgFB7SV0zcUp
         /T8YLw5znD4KGJcOsBBB+flZcvly70mwKQ41iSnh0z92m9Jmud61wnc1bDwKWuQUJI
         Rn5yqXLjsVmKwG22H580yBSImGur4cgc3K419yEFlPziedpRBGdmkr5eyqREj/S52z
         HgTwDj6ixSn33wQw+fOeGINjGF+jSadcLM31+806a4u9E9MpsBAFiqA1lE3se9pjyi
         gBJMlDD6R3sahaq1iDLwrQyRu2+9b4G5peXYUU8azaH0T6Bj3JrUFlo8CPrg6ZitMi
         utD1hbXc1INFg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v4 2/9] vfs: support STATX_DIOALIGN on block devices
Date:   Fri, 22 Jul 2022 00:12:21 -0700
Message-Id: <20220722071228.146690-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220722071228.146690-1-ebiggers@kernel.org>
References: <20220722071228.146690-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add support for STATX_DIOALIGN to block devices, so that direct I/O
alignment restrictions are exposed to userspace in a generic way.

Note that this breaks the tradition of stat operating only on the block
device node, not the block device itself.  However, it was felt that
doing this is preferable, in order to make the interface useful and
avoid needing separate interfaces for regular files and block devices.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/bdev.c           | 25 +++++++++++++++++++++++++
 fs/stat.c              | 12 ++++++++++++
 include/linux/blkdev.h |  4 ++++
 3 files changed, 41 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 5fe06c1f2def41..cee0951e27a82a 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -26,6 +26,7 @@
 #include <linux/namei.h>
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
+#include <linux/stat.h>
 #include "../fs/internal.h"
 #include "blk.h"
 
@@ -1071,3 +1072,27 @@ void sync_bdevs(bool wait)
 	spin_unlock(&blockdev_superblock->s_inode_list_lock);
 	iput(old_inode);
 }
+
+/*
+ * Handle STATX_DIOALIGN for block devices.
+ *
+ * Note that the inode passed to this is the inode of a block device node file,
+ * not the block device's internal inode.  Therefore it is *not* valid to use
+ * I_BDEV() here; the block device has to be looked up by i_rdev instead.
+ */
+void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
+{
+	struct block_device *bdev;
+	unsigned int lbs;
+
+	bdev = blkdev_get_no_open(inode->i_rdev);
+	if (!bdev)
+		return;
+
+	lbs = bdev_logical_block_size(bdev);
+	stat->dio_mem_align = lbs;
+	stat->dio_offset_align = lbs;
+	stat->result_mask |= STATX_DIOALIGN;
+
+	blkdev_put_no_open(bdev);
+}
diff --git a/fs/stat.c b/fs/stat.c
index a7930d74448304..ef50573c72a269 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/blkdev.h>
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/errno.h>
@@ -230,11 +231,22 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 		goto out;
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
+
 	stat->mnt_id = real_mount(path.mnt)->mnt_id;
 	stat->result_mask |= STATX_MNT_ID;
+
 	if (path.mnt->mnt_root == path.dentry)
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
+
+	/* Handle STATX_DIOALIGN for block devices. */
+	if (request_mask & STATX_DIOALIGN) {
+		struct inode *inode = d_backing_inode(path.dentry);
+
+		if (S_ISBLK(inode->i_mode))
+			bdev_statx_dioalign(inode, stat);
+	}
+
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2f7b43444c5f8d..d75151bd43b541 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1538,6 +1538,7 @@ int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
 int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
+void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
 void printk_all_partitions(void);
 #else
 static inline void invalidate_bdev(struct block_device *bdev)
@@ -1554,6 +1555,9 @@ static inline int sync_blockdev_nowait(struct block_device *bdev)
 static inline void sync_bdevs(bool wait)
 {
 }
+static inline void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
+{
+}
 static inline void printk_all_partitions(void)
 {
 }
-- 
2.37.0

