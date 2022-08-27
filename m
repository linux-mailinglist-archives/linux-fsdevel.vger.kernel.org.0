Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241875A352A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 09:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiH0HBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 03:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiH0HBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 03:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B366124F3E;
        Sat, 27 Aug 2022 00:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B440B61070;
        Sat, 27 Aug 2022 07:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFBEC43470;
        Sat, 27 Aug 2022 07:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661583691;
        bh=/jfuS15hStMnpPV1JCJsBTOyuHhx2Au7mlZgnZnCDk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tk8MR2jqxzcI6Z/DtHV20OwpdVkX7XRj2jaKlNofUBIxuGMJGzu97VGo9dwQ/tR7v
         0Jt/IXU//m55YomHShR07pVXCz9Z2GCkmNxcLtIu6leHOB0DJ284sbZxKhRtPLMOnX
         PAAhC164epKLu5NPPd/KXRYRqIISSuoO66I69VpEVVATEP9uOp3Tgnb1Q5vqqWcjkr
         7RcdLWHYGIP4OhaSoy4hyMalRdxYLkK5ZwVo+M80Liz0G/cAxYh/zwx/jSuTtGWiQ/
         EnqY4St20g4OlKR/z0WAd6AcnpumqrKgzs3MCjiz5RC0/3QI6S8cQi53PMQkX9T/uE
         NMG+YgymZmAzg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v5 2/8] vfs: support STATX_DIOALIGN on block devices
Date:   Fri, 26 Aug 2022 23:58:45 -0700
Message-Id: <20220827065851.135710-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827065851.135710-1-ebiggers@kernel.org>
References: <20220827065851.135710-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 block/bdev.c           | 23 +++++++++++++++++++++++
 fs/stat.c              | 12 ++++++++++++
 include/linux/blkdev.h |  4 ++++
 3 files changed, 39 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index ce05175e71cea4..d699ecdb32604e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -26,6 +26,7 @@
 #include <linux/namei.h>
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
+#include <linux/stat.h>
 #include "../fs/internal.h"
 #include "blk.h"
 
@@ -1069,3 +1070,25 @@ void sync_bdevs(bool wait)
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
+
+	bdev = blkdev_get_no_open(inode->i_rdev);
+	if (!bdev)
+		return;
+
+	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
+	stat->dio_offset_align = bdev_logical_block_size(bdev);
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
index 84b13fdd34a716..8038c5fbde4099 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1498,6 +1498,7 @@ int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
 int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
+void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
 void printk_all_partitions(void);
 #else
 static inline void invalidate_bdev(struct block_device *bdev)
@@ -1514,6 +1515,9 @@ static inline int sync_blockdev_nowait(struct block_device *bdev)
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
2.37.2

