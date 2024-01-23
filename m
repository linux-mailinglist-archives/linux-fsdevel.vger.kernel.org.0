Return-Path: <linux-fsdevel+bounces-8577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7E183902F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B67B293770
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE4E6027B;
	Tue, 23 Jan 2024 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="up3LsDng"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913261679;
	Tue, 23 Jan 2024 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016496; cv=none; b=M2x10dzwAl3/GCDjzz91dEw11hs7hZWspbZx5ba0MnG/6r57Ro0+krl5HLXi2CpLn14Q4R1UzwJEUO/MCYm6BF6QCCXxyYvXQKd8ABs9CMdUKk3aP33kqpW4XylE7d09NZxPwJovfmP12Bt2zjZUhzEMB5+pgKJRmcgXpuwL6FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016496; c=relaxed/simple;
	bh=lwhIC205Rs3asrRhkS7ASqcjNClTd+mvqrLWpkdYYTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8gs+b9ADmdyywEt2pfU0fILGr2NiHxwuJsqUx2AlgQGut+HxO+XYyJztew2QMlRKhd1MDzHyv+/mhK33OktnxMK2xpE8taoUCvi57KCyWPO3GkDpgIOIisw2nEyUf3dQrxsJRNqUh2fyOOaf7lZInyAb8jZgeC71tegjs1swvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=up3LsDng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0EAC3278D;
	Tue, 23 Jan 2024 13:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016496;
	bh=lwhIC205Rs3asrRhkS7ASqcjNClTd+mvqrLWpkdYYTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=up3LsDngdBwgMobuJsI0LBlCJqnqP5Pbd/Ai3XJj/xB7JJ6BBAhZddGbUfH6S6blg
	 JTFn3RBmTmmatkY1jsFqVp24EJYO9lOg1b23hx+2x+7o3wCjOUHkb4w+amSRXqMjjD
	 +eQtscmBv84sxDYvhtvrlweNy4KfCpUEhABk+JAoeL4D884C6wdQmNKzUzOpmLRpT4
	 O+3JZG8Eb8rcrnRVDbnOp2uZbMo7rg9raSctjH8ly5jqITQ/Uo9i09aJZB2hwk+u8m
	 +NfDnqK02Rs5hJHOOsInit30mb3I7l8SAMyjVfbyoXokkoYSYKbNYht4shMfH9xukQ
	 AEjk63bQmcd6A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:49 +0100
Subject: [PATCH v2 32/34] block: remove bdev_handle completely
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-32-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=6067; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lwhIC205Rs3asrRhkS7ASqcjNClTd+mvqrLWpkdYYTE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37fQ+JFO7xSbwmaD9sTt1a/nTvYRnBLC0nJ0KTtrv
 WqEv1JPRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQsihkZVr74zRrksmzV7XWW
 p7a+OnRxVZjk3pMfbt13C3LPTK5QW8zwz+7T0oC/WZ+X9eR9rfre9+q3p6LQznk3DjkzHLw033a
 GNBsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We just need to use the holder to indicate whether a block device open
was exclusive or not. We did use to do that before but had to give that
up once we switched to struct bdev_handle. Before struct bdev_handle we
only stashed stuff in file->private_data if this was an exclusive open
but after struct bdev_handle we always set file->private_data to a
struct bdev_handle and so we had to use bdev_handle->mode or
bdev_handle->holder. Now that we don't use struct bdev_handle anymore we
can revert back to the old behavior.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c | 24 +++++++-----------------
 block/blk.h  |  5 -----
 block/fops.c | 18 +++++++++++-------
 3 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 9d96a43f198d..4b47003d8082 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -799,7 +799,7 @@ static void bdev_claim_write_access(struct block_device *bdev, blk_mode_t mode)
 		bdev->bd_writers++;
 }
 
-static void bdev_yield_write_access(struct file *bdev_file, blk_mode_t mode)
+static void bdev_yield_write_access(struct file *bdev_file)
 {
 	struct block_device *bdev;
 
@@ -810,7 +810,7 @@ static void bdev_yield_write_access(struct file *bdev_file, blk_mode_t mode)
 	/* Yield exclusive or shared write access. */
 	if (bdev_file->f_op == &def_blk_fops_restricted)
 		bdev_unblock_writes(bdev);
-	else if (mode & BLK_OPEN_WRITE)
+	else if (bdev_file->f_mode & FMODE_WRITE)
 		bdev->bd_writers--;
 }
 
@@ -838,16 +838,10 @@ static void bdev_yield_write_access(struct file *bdev_file, blk_mode_t mode)
 int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	      const struct blk_holder_ops *hops, struct file *bdev_file)
 {
-	struct bdev_handle *handle = kmalloc(sizeof(struct bdev_handle),
-					     GFP_KERNEL);
 	bool unblock_events = true;
 	struct gendisk *disk = bdev->bd_disk;
 	int ret;
 
-	handle = kmalloc(sizeof(struct bdev_handle), GFP_KERNEL);
-	if (!handle)
-		return -ENOMEM;
-
 	if (holder) {
 		mode |= BLK_OPEN_EXCL;
 		ret = bd_prepare_to_claim(bdev, holder, hops);
@@ -896,8 +890,6 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 
 	if (unblock_events)
 		disk_unblock_events(disk);
-	handle->holder = holder;
-	handle->mode = mode;
 
 	/*
 	 * Preserve backwards compatibility and allow large file access
@@ -911,7 +903,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 		bdev_file->f_mode |= FMODE_NOWAIT;
 	bdev_file->f_mapping = bdev->bd_inode->i_mapping;
 	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
-	bdev_file->private_data = handle;
+	bdev_file->private_data = holder;
 
 	return 0;
 put_module:
@@ -921,7 +913,6 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&disk->open_mutex);
 	disk_unblock_events(disk);
-	kfree(handle);
 	return ret;
 }
 
@@ -1027,7 +1018,7 @@ EXPORT_SYMBOL(bdev_file_open_by_path);
 void bdev_release(struct file *bdev_file)
 {
 	struct block_device *bdev = file_bdev(bdev_file);
-	struct bdev_handle *handle = bdev_file->private_data;
+	void *holder = bdev_file->private_data;
 	struct gendisk *disk = bdev->bd_disk;
 
 	/*
@@ -1041,10 +1032,10 @@ void bdev_release(struct file *bdev_file)
 		sync_blockdev(bdev);
 
 	mutex_lock(&disk->open_mutex);
-	bdev_yield_write_access(bdev_file, handle->mode);
+	bdev_yield_write_access(bdev_file);
 
-	if (handle->holder)
-		bd_end_claim(bdev, handle->holder);
+	if (holder)
+		bd_end_claim(bdev, holder);
 
 	/*
 	 * Trigger event checking and tell drivers to flush MEDIA_CHANGE
@@ -1061,7 +1052,6 @@ void bdev_release(struct file *bdev_file)
 
 	module_put(disk->fops->owner);
 	blkdev_put_no_open(bdev);
-	kfree(handle);
 }
 
 /**
diff --git a/block/blk.h b/block/blk.h
index dfa958909c54..cce1ac0ff303 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -27,11 +27,6 @@ struct blk_flush_queue {
 	struct request		*flush_rq;
 };
 
-struct bdev_handle {
-	void *holder;
-	blk_mode_t mode;
-};
-
 bool is_flush_rq(struct request *req);
 
 struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
diff --git a/block/fops.c b/block/fops.c
index f56bdfe459de..a0bff2c0d88d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -569,7 +569,6 @@ static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
 blk_mode_t file_to_blk_mode(struct file *file)
 {
 	blk_mode_t mode = 0;
-	struct bdev_handle *handle = file->private_data;
 
 	if (file->f_mode & FMODE_READ)
 		mode |= BLK_OPEN_READ;
@@ -579,8 +578,8 @@ blk_mode_t file_to_blk_mode(struct file *file)
 	 * do_dentry_open() clears O_EXCL from f_flags, use handle->mode to
 	 * determine whether the open was exclusive for already open files.
 	 */
-	if (handle)
-		mode |= handle->mode & BLK_OPEN_EXCL;
+	if (file->private_data)
+		mode |= BLK_OPEN_EXCL;
 	else if (file->f_flags & O_EXCL)
 		mode |= BLK_OPEN_EXCL;
 	if (file->f_flags & O_NDELAY)
@@ -601,12 +600,17 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 {
 	struct block_device *bdev;
 	blk_mode_t mode;
-	void *holder;
 	int ret;
 
+	/*
+	 * Use the file private data to store the holder for exclusive opens.
+	 * file_to_blk_mode relies on it being present to set BLK_OPEN_EXCL.
+	 */
+	if (filp->f_flags & O_EXCL)
+		filp->private_data = filp;
+
 	mode = file_to_blk_mode(filp);
-	holder = mode & BLK_OPEN_EXCL ? filp : NULL;
-	ret = bdev_permission(inode->i_rdev, mode, holder);
+	ret = bdev_permission(inode->i_rdev, mode, filp->private_data);
 	if (ret)
 		return ret;
 
@@ -614,7 +618,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if (!bdev)
 		return -ENXIO;
 
-	ret = bdev_open(bdev, mode, holder, NULL, filp);
+	ret = bdev_open(bdev, mode, filp->private_data, NULL, filp);
 	if (ret)
 		blkdev_put_no_open(bdev);
 	return ret;

-- 
2.43.0


