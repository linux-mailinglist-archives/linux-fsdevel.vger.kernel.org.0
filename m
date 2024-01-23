Return-Path: <linux-fsdevel+bounces-8574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ED7839024
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309271F24465
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D28612F1;
	Tue, 23 Jan 2024 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="To3MOWDD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8806560258;
	Tue, 23 Jan 2024 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016489; cv=none; b=LpY/LSNzQV0wO1aZyFkoNvGKevSmA90yhjYK8iFpIlGCf/Lw0MDYTagbDu7JxF/aT6iQouoh3u8Fn5nDRdRilN04UD4+XgmG5+JRDP+NGtlASYm/TLCiemnScgjUpfDHkkC3khZmkv1X07n1eJBlLVrOQEFo6RB3j5O93g4vox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016489; c=relaxed/simple;
	bh=2xUBoCjEzVM2g6HqpxwtJhEVTkF10uVrmchKukKoXH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fro47k+aqRiuSl1/MNLfDaf6LikkLGHLBnsQJDPvZ0t7yEIp7uM7xh9ZmfwzKo5CW2OVt4Lv3wN7T4286mpYuaLe0L+yeyJ5SPikWdG7gl7Jtnk9LR+nsps1vgxQ/uTNWzmag2tTJP1OpbRVhaYL7LYbeJgKCCKegctjWNHifwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=To3MOWDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E4CC32782;
	Tue, 23 Jan 2024 13:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016489;
	bh=2xUBoCjEzVM2g6HqpxwtJhEVTkF10uVrmchKukKoXH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=To3MOWDD/Zot7lLpbc7aUnn9j7eo8Z8hasco7NrTesNhvUtSDvoYexKabk8RimDe9
	 gFOjAO1zZqZhjK79YRX+2QGb/kcSH5juL2fsrEXGf0Nmo/3yFGZ1/OTlkOaq1gtR2+
	 VKcGstlKTQefXXWFe7yFQQVqPuRGOxJRNHkK6F2k0UlnvDFi8cXU2NCXmHFUWd66GU
	 Lvr9tW0c3xIkUBTncZZk/UYqEtSKGWJz6K8/kRqnzXs2E8rT3oMq5DHGuiMvErXVQP
	 IvEdGwR4+5QQFBGo/r/ovNGn9HVbEkxD3T0E0pWavbQJmGkvJ4kN5+IPf2nvWh0TFk
	 LbQWQA2me0iUg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:46 +0100
Subject: [PATCH v2 29/34] bdev: make struct bdev_handle private to the
 block layer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-29-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=10332; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2xUBoCjEzVM2g6HqpxwtJhEVTkF10uVrmchKukKoXH4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37dwp71F+qLXfByVuf16EvnGJ6+82Lw18kJX354f9
 woizHmqO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS4cbwh/fzps5XAbkLV+mm
 Rj75dTu7ozBp0ZG0mV5ul64Vz3qw4hQjwz53x019Jey/J54sNLnwz/dh5dcFiX86786wC1+zZmu
 sAjcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           | 125 +++++++++++++++++++++++++++----------------------
 block/blk.h            |  12 +++--
 block/fops.c           |  34 ++++++--------
 include/linux/blkdev.h |   7 ---
 include/linux/fs.h     |   6 ---
 5 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 1f64f213c5fa..34b9a16edb6e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -703,6 +703,24 @@ static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
 	return ret;
 }
 
+int bdev_permission(dev_t dev, blk_mode_t mode, void *holder)
+{
+	int ret;
+
+	ret = devcgroup_check_permission(
+		DEVCG_DEV_BLOCK, MAJOR(dev), MINOR(dev),
+		((mode & BLK_OPEN_READ) ? DEVCG_ACC_READ : 0) |
+			((mode & BLK_OPEN_WRITE) ? DEVCG_ACC_WRITE : 0));
+	if (ret)
+		return ret;
+
+	/* Blocking writes requires exclusive opener */
+	if (mode & BLK_OPEN_RESTRICT_WRITES && !holder)
+		return -EINVAL;
+
+	return 0;
+}
+
 static void blkdev_put_part(struct block_device *part)
 {
 	struct block_device *whole = bdev_whole(part);
@@ -795,15 +813,15 @@ static void bdev_yield_write_access(struct block_device *bdev, blk_mode_t mode)
 }
 
 /**
- * bdev_open_by_dev - open a block device by device number
- * @dev: device number of block device to open
+ * bdev_open - open a block device
+ * @bdev: block device to open
  * @mode: open mode (BLK_OPEN_*)
  * @holder: exclusive holder identifier
  * @hops: holder operations
+ * @bdev_file: file for the block device
  *
- * Open the block device described by device number @dev. If @holder is not
- * %NULL, the block device is opened with exclusive access.  Exclusive opens may
- * nest for the same @holder.
+ * Open the block device. If @holder is not %NULL, the block device is opened
+ * with exclusive access.  Exclusive opens may nest for the same @holder.
  *
  * Use this interface ONLY if you really do not have anything better - i.e. when
  * you are behind a truly sucky interface and all you are given is a device
@@ -813,52 +831,29 @@ static void bdev_yield_write_access(struct block_device *bdev, blk_mode_t mode)
  * Might sleep.
  *
  * RETURNS:
- * Handle with a reference to the block_device on success, ERR_PTR(-errno) on
- * failure.
+ * zero on success, -errno on failure.
  */
-struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-				     const struct blk_holder_ops *hops)
+int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
+	      const struct blk_holder_ops *hops, struct file *bdev_file)
 {
 	struct bdev_handle *handle = kmalloc(sizeof(struct bdev_handle),
 					     GFP_KERNEL);
-	struct block_device *bdev;
 	bool unblock_events = true;
-	struct gendisk *disk;
+	struct gendisk *disk = bdev->bd_disk;
 	int ret;
 
+	handle = kmalloc(sizeof(struct bdev_handle), GFP_KERNEL);
 	if (!handle)
-		return ERR_PTR(-ENOMEM);
-
-	ret = devcgroup_check_permission(DEVCG_DEV_BLOCK,
-			MAJOR(dev), MINOR(dev),
-			((mode & BLK_OPEN_READ) ? DEVCG_ACC_READ : 0) |
-			((mode & BLK_OPEN_WRITE) ? DEVCG_ACC_WRITE : 0));
-	if (ret)
-		goto free_handle;
-
-	/* Blocking writes requires exclusive opener */
-	if (mode & BLK_OPEN_RESTRICT_WRITES && !holder) {
-		ret = -EINVAL;
-		goto free_handle;
-	}
-
-	bdev = blkdev_get_no_open(dev);
-	if (!bdev) {
-		ret = -ENXIO;
-		goto free_handle;
-	}
-	disk = bdev->bd_disk;
+		return -ENOMEM;
 
 	if (holder) {
 		mode |= BLK_OPEN_EXCL;
 		ret = bd_prepare_to_claim(bdev, holder, hops);
 		if (ret)
-			goto put_blkdev;
+			return ret;
 	} else {
-		if (WARN_ON_ONCE(mode & BLK_OPEN_EXCL)) {
-			ret = -EIO;
-			goto put_blkdev;
-		}
+		if (WARN_ON_ONCE(mode & BLK_OPEN_EXCL))
+			return -EIO;
 	}
 
 	disk_block_events(disk);
@@ -902,7 +897,22 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	handle->bdev = bdev;
 	handle->holder = holder;
 	handle->mode = mode;
-	return handle;
+
+	/*
+	 * Preserve backwards compatibility and allow large file access
+	 * even if userspace doesn't ask for it explicitly. Some mkfs
+	 * binary needs it. We might want to drop this workaround
+	 * during an unstable branch.
+	 */
+	bdev_file->f_flags |= O_LARGEFILE;
+	bdev_file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
+	if (bdev_nowait(bdev))
+		bdev_file->f_mode |= FMODE_NOWAIT;
+	bdev_file->f_mapping = handle->bdev->bd_inode->i_mapping;
+	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
+	bdev_file->private_data = handle;
+
+	return 0;
 put_module:
 	module_put(disk->fops->owner);
 abort_claiming:
@@ -910,11 +920,8 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&disk->open_mutex);
 	disk_unblock_events(disk);
-put_blkdev:
-	blkdev_put_no_open(bdev);
-free_handle:
 	kfree(handle);
-	return ERR_PTR(ret);
+	return ret;
 }
 
 static unsigned blk_to_file_flags(blk_mode_t mode)
@@ -954,29 +961,35 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 				   const struct blk_holder_ops *hops)
 {
 	struct file *bdev_file;
-	struct bdev_handle *handle;
+	struct block_device *bdev;
 	unsigned int flags;
+	int ret;
 
-	handle = bdev_open_by_dev(dev, mode, holder, hops);
-	if (IS_ERR(handle))
-		return ERR_CAST(handle);
+	ret = bdev_permission(dev, 0, holder);
+	if (ret)
+		return ERR_PTR(ret);
+
+	bdev = blkdev_get_no_open(dev);
+	if (!bdev)
+		return ERR_PTR(-ENXIO);
 
 	flags = blk_to_file_flags(mode);
-	bdev_file = alloc_file_pseudo_noaccount(handle->bdev->bd_inode,
+	bdev_file = alloc_file_pseudo_noaccount(bdev->bd_inode,
 			blockdev_mnt, "", flags | O_LARGEFILE, &def_blk_fops);
 	if (IS_ERR(bdev_file)) {
-		bdev_release(handle);
+		blkdev_put_no_open(bdev);
 		return bdev_file;
 	}
-	ihold(handle->bdev->bd_inode);
+	bdev_file->f_mode &= ~FMODE_OPENED;
 
-	bdev_file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
-	if (bdev_nowait(handle->bdev))
-		bdev_file->f_mode |= FMODE_NOWAIT;
-
-	bdev_file->f_mapping = handle->bdev->bd_inode->i_mapping;
-	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
-	bdev_file->private_data = handle;
+	ihold(bdev->bd_inode);
+	ret = bdev_open(bdev, mode, holder, hops, bdev_file);
+	if (ret) {
+		fput(bdev_file);
+		return ERR_PTR(ret);
+	}
+	/* Now that thing is opened. */
+	bdev_file->f_mode |= FMODE_OPENED;
 	return bdev_file;
 }
 EXPORT_SYMBOL(bdev_file_open_by_dev);
diff --git a/block/blk.h b/block/blk.h
index c9630774767d..19b15870284f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -25,6 +25,12 @@ struct blk_flush_queue {
 	struct request		*flush_rq;
 };
 
+struct bdev_handle {
+	struct block_device *bdev;
+	void *holder;
+	blk_mode_t mode;
+};
+
 bool is_flush_rq(struct request *req);
 
 struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
@@ -517,7 +523,7 @@ static inline int req_ref_read(struct request *req)
 }
 
 void bdev_release(struct bdev_handle *handle);
-struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-		const struct blk_holder_ops *hops);
-
+int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
+	      const struct blk_holder_ops *hops, struct file *bdev_file);
+int bdev_permission(dev_t dev, blk_mode_t mode, void *holder);
 #endif /* BLK_INTERNAL_H */
diff --git a/block/fops.c b/block/fops.c
index 0cf8cf72cdfa..81ff8c0ce32f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -599,31 +599,25 @@ blk_mode_t file_to_blk_mode(struct file *file)
 
 static int blkdev_open(struct inode *inode, struct file *filp)
 {
-	struct bdev_handle *handle;
+	struct block_device *bdev;
 	blk_mode_t mode;
-
-	/*
-	 * Preserve backwards compatibility and allow large file access
-	 * even if userspace doesn't ask for it explicitly. Some mkfs
-	 * binary needs it. We might want to drop this workaround
-	 * during an unstable branch.
-	 */
-	filp->f_flags |= O_LARGEFILE;
-	filp->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
+	void *holder;
+	int ret;
 
 	mode = file_to_blk_mode(filp);
-	handle = bdev_open_by_dev(inode->i_rdev, mode,
-			mode & BLK_OPEN_EXCL ? filp : NULL, NULL);
-	if (IS_ERR(handle))
-		return PTR_ERR(handle);
+	holder = mode & BLK_OPEN_EXCL ? filp : NULL;
+	ret = bdev_permission(inode->i_rdev, mode, holder);
+	if (ret)
+		return ret;
 
-	if (bdev_nowait(handle->bdev))
-		filp->f_mode |= FMODE_NOWAIT;
+	bdev = blkdev_get_no_open(inode->i_rdev);
+	if (!bdev)
+		return -ENXIO;
 
-	filp->f_mapping = handle->bdev->bd_inode->i_mapping;
-	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
-	filp->private_data = handle;
-	return 0;
+	ret = bdev_open(bdev, mode, holder, NULL, filp);
+	if (ret)
+		blkdev_put_no_open(bdev);
+	return ret;
 }
 
 static int blkdev_release(struct inode *inode, struct file *filp)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 495f55587207..2f5dbde23094 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1475,13 +1475,6 @@ extern const struct blk_holder_ops fs_holder_ops;
 	(BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES | \
 	 (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
 
-/* @bdev_handle will be removed soon. */
-struct bdev_handle {
-	struct block_device *bdev;
-	void *holder;
-	blk_mode_t mode;
-};
-
 struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e9291e27cc47..6e0714d35d9b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1327,12 +1327,6 @@ struct super_block {
 	struct list_head	s_inodes_wb;	/* writeback inodes */
 } __randomize_layout;
 
-/* Temporary helper that will go away. */
-static inline struct bdev_handle *sb_bdev_handle(struct super_block *sb)
-{
-	return sb->s_bdev_file->private_data;
-}
-
 static inline struct user_namespace *i_user_ns(const struct inode *inode)
 {
 	return inode->i_sb->s_user_ns;

-- 
2.43.0


