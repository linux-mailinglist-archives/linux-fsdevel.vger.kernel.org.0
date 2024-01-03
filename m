Return-Path: <linux-fsdevel+bounces-7211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E32F822DD8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B04285BBD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151B71C6AF;
	Wed,  3 Jan 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVIP+wyC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144B1C692;
	Wed,  3 Jan 2024 12:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739F6C433CA;
	Wed,  3 Jan 2024 12:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286592;
	bh=3QdoyKimZ2MzZfuqTDgI4se0zTrQjYhFaZCp+W/qXJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KVIP+wyC2QC19bsWt70J1tV9mvM5YqTuCiIr7UgMfZCuaELahybc/CmfLUYdn0G/6
	 vFTl/EgoGBS9vDvCPfsk8cqZNaRYMdBm7ItZafO1o8kZCsp36eXDiDhsHNyNe/sR8/
	 WBAchS0ihR36Eh+FvTd2rXB2/L1ibRBa3xbtzzb9Q8iyChZju9PiYWwt+oI+oTwxvz
	 PJo194/X0gyOSybmHXxowe7JnGt5QUhw2NtIQESS4TAZRlbxOAJ9C1MoGXFaMn1cKK
	 C5THkQptFIKMXdXgsnrc4VennDWtqv9uLrDsgf8+HTxKogVJ7yj9sYwySEpLdKDEyU
	 ZrnvM7yO5AwJA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:28 +0100
Subject: [PATCH RFC 30/34] bdev: rework bdev_open_by_dev()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-30-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=9361; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3QdoyKimZ2MzZfuqTDgI4se0zTrQjYhFaZCp+W/qXJU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbS9NfdLwgMGbUm+lufS6/3svDIuq91Yprd4/+HXD
 GZsM+YwdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkJR8jw/b7sRbrituP3eKc
 e7BAnimN6/bxtxK/Ci7Pusy8YMmu0LsM/33Zp+85dO4ZU3987tfcP2VXDMT8QlP+Cefe9Quv4Td
 Q4QAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that we always use files when opening block devices rework
bdev_open_by_dev() to work well with both bdev_file_open_by_*() and
blkdev_open().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c | 139 +++++++++++++++++++++++++++++++++--------------------------
 block/blk.h  |   6 +--
 block/fops.c |  34 ++++++---------
 3 files changed, 94 insertions(+), 85 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b276ef994858..2867edba0169 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -704,6 +704,24 @@ static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
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
@@ -796,15 +814,15 @@ static void bdev_yield_write_access(struct block_device *bdev, blk_mode_t mode)
 }
 
 /**
- * bdev_open_by_dev - open a block device by device number
- * @dev: device number of block device to open
+ * bdev_open - open a block device
+ * @bdev: block device to open
  * @mode: open mode (BLK_OPEN_*)
  * @holder: exclusive holder identifier
  * @hops: holder operations
+ * @f_bdev: file for the block device
  *
- * Open the block device described by device number @dev. If @holder is not
- * %NULL, the block device is opened with exclusive access.  Exclusive opens may
- * nest for the same @holder.
+ * Open the block device. If @holder is not %NULL, the block device is opened
+ * with exclusive access.  Exclusive opens may nest for the same @holder.
  *
  * Use this interface ONLY if you really do not have anything better - i.e. when
  * you are behind a truly sucky interface and all you are given is a device
@@ -814,52 +832,29 @@ static void bdev_yield_write_access(struct block_device *bdev, blk_mode_t mode)
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
+	      const struct blk_holder_ops *hops, struct file *f_bdev)
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
@@ -903,7 +898,22 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
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
+	f_bdev->f_flags |= O_LARGEFILE;
+	f_bdev->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
+	if (bdev_nowait(bdev))
+		f_bdev->f_mode |= FMODE_NOWAIT;
+	f_bdev->f_mapping = handle->bdev->bd_inode->i_mapping;
+	f_bdev->f_wb_err = filemap_sample_wb_err(f_bdev->f_mapping);
+	f_bdev->private_data = handle;
+
+	return 0;
 put_module:
 	module_put(disk->fops->owner);
 abort_claiming:
@@ -911,11 +921,8 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
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
@@ -927,8 +934,10 @@ static unsigned blk_to_file_flags(blk_mode_t mode)
 		flags |= O_RDWR;
 	else if (mode & BLK_OPEN_WRITE)
 		flags |= O_WRONLY;
-	else
+	else if (mode & BLK_OPEN_READ)
 		flags |= O_RDONLY;
+	else /* Neither read nor write for a block device requested? */
+		WARN_ON_ONCE(true);
 
 	/*
 	 * O_EXCL is one of those flags that the VFS clears once it's done with
@@ -952,31 +961,37 @@ static unsigned blk_to_file_flags(blk_mode_t mode)
 struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 				   const struct blk_holder_ops *hops)
 {
-	struct file *file;
-	struct bdev_handle *handle;
+	struct file *f_bdev;
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
-	file = alloc_file_pseudo(handle->bdev->bd_inode, blockdev_mnt, "",
-				 flags | O_LARGEFILE, &def_blk_fops);
-	if (IS_ERR(file)) {
-		bdev_release(handle);
-		return file;
+	f_bdev = alloc_file_pseudo(bdev->bd_inode, blockdev_mnt, "",
+				   flags | O_LARGEFILE, &def_blk_fops);
+	if (IS_ERR(f_bdev)) {
+		blkdev_put_no_open(bdev);
+		return f_bdev;
 	}
-	ihold(handle->bdev->bd_inode);
-
-	file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT | FMODE_NOACCOUNT;
-	if (bdev_nowait(handle->bdev))
-		file->f_mode |= FMODE_NOWAIT;
+	f_bdev->f_mode &= ~FMODE_OPENED;
 
-	file->f_mapping = handle->bdev->bd_inode->i_mapping;
-	file->f_wb_err = filemap_sample_wb_err(file->f_mapping);
-	file->private_data = handle;
-	return file;
+	ihold(bdev->bd_inode);
+	ret = bdev_open(bdev, mode, holder, hops, f_bdev);
+	if (ret) {
+		fput(f_bdev);
+		return ERR_PTR(ret);
+	}
+	/* Now that thing is opened. */
+	f_bdev->f_mode |= FMODE_OPENED;
+	return f_bdev;
 }
 EXPORT_SYMBOL(bdev_file_open_by_dev);
 
diff --git a/block/blk.h b/block/blk.h
index d1a2030fa5c3..ab1a5ab8cd2e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -525,7 +525,7 @@ static inline int req_ref_read(struct request *req)
 }
 
 void bdev_release(struct bdev_handle *handle);
-struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-		const struct blk_holder_ops *hops);
-
+int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
+	      const struct blk_holder_ops *hops, struct file *f_bdev);
+int bdev_permission(dev_t dev, blk_mode_t mode, void *holder);
 #endif /* BLK_INTERNAL_H */
diff --git a/block/fops.c b/block/fops.c
index 0abaac705daf..ed7be8b5810e 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -584,31 +584,25 @@ blk_mode_t file_to_blk_mode(struct file *file)
 
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

-- 
2.42.0


