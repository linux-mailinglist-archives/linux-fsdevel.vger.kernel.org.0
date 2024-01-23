Return-Path: <linux-fsdevel+bounces-8575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AB883902A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD0E286301
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5830161664;
	Tue, 23 Jan 2024 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNuu+yUq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746F60279;
	Tue, 23 Jan 2024 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016491; cv=none; b=jXPIaSEXMLpUEYvN7omJyODYBmBbV3VRu7XFqOckf4iMryx8z9jwzgLS4L7hN4dvPcQLtU3eb4YhYqpwhgTIwPSkszJukO8DNDxOfG5p8Ehlkvcv/ThBDaoWaGTdl1lRTXwlmkrQlL2MPsjbtXu03ZUsLFkAfSc156HClmJ9w5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016491; c=relaxed/simple;
	bh=+zjJnu9Kypce5d+LOhS2wPlDKbTu6ygG3AFJwrfU9dM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RgefbCR5AtONqqq9vbtuT9MBcfFrMe42RexXpoZprBI7BxccfUYP4vlvzw5Uz9p2EyQCajZrBeCAwt2YpkGb0IirhIE9eIOvbZYSoJbq8PyIo72f+1j0t6xAeYo+8AuKgQxQIrg7l9LfHm5pO832J7R4YY09CIsgdppkRbmPfR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNuu+yUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8392DC3278C;
	Tue, 23 Jan 2024 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016491;
	bh=+zjJnu9Kypce5d+LOhS2wPlDKbTu6ygG3AFJwrfU9dM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hNuu+yUqOtO7KinlalNFUOjTXC3wS3AuoiBuV9ArvRqJzocpIXnMhLSr2Pv7oAsoO
	 FsJjTLJrEVARIUIijYL6EDmgfUcREVHDU3bYs8Ue3bKUr1QYTX5j72N+2DccNpXwgR
	 d1Wbj/5pfx0OQu7fAiu7X0ukI2phvwivJrIlFDamn+mx6nWoottYxyWbNKwsbCjsS1
	 9t6AtZg0aZS3JiBrjvI3GBDGnH2Je0Yi+oBrlIVP7bla0EYHsFoN3KjCWsP4xEvFEQ
	 0/uk9jAL4X7Z03vjGSDbbKBi1nN1gdXwkLrKMJRMEg0UhZvk7W7PKwpvT9FVBCzNzH
	 a/m0IuttuYhvg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:47 +0100
Subject: [PATCH v2 30/34] bdev: remove bdev pointer from struct bdev_handle
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-30-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=3756; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+zjJnu9Kypce5d+LOhS2wPlDKbTu6ygG3AFJwrfU9dM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37fQ34mb74ijpuWTpxdr/LSvrjk/kb+2aiO/6qFnx
 qGTUl8Yd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkQI3hf/ADF8e8o69F8v3n
 PwvW+RpqeOf25a4T802dN9ec/G54QIPhn5LbkX5f4/8TYmquXnNIbvnk3fH4iPWn+u9TuHfMZ/m
 owAkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We can always go directly via:

* I_BDEV(bdev_file->f_inode)
* I_BDEV(bdev_file->f_mapping->host)

So keeping struct bdev in struct bdev_handle is redundant.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c | 26 ++++++++++++--------------
 block/blk.h  |  3 +--
 block/fops.c |  2 +-
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 34b9a16edb6e..71eaa1b5b7eb 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -51,8 +51,7 @@ EXPORT_SYMBOL(I_BDEV);
 
 struct block_device *file_bdev(struct file *bdev_file)
 {
-	struct bdev_handle *handle = bdev_file->private_data;
-	return handle->bdev;
+	return I_BDEV(bdev_file->f_mapping->host);
 }
 EXPORT_SYMBOL(file_bdev);
 
@@ -894,7 +893,6 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 
 	if (unblock_events)
 		disk_unblock_events(disk);
-	handle->bdev = bdev;
 	handle->holder = holder;
 	handle->mode = mode;
 
@@ -908,7 +906,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	bdev_file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
 	if (bdev_nowait(bdev))
 		bdev_file->f_mode |= FMODE_NOWAIT;
-	bdev_file->f_mapping = handle->bdev->bd_inode->i_mapping;
+	bdev_file->f_mapping = bdev->bd_inode->i_mapping;
 	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
 	bdev_file->private_data = handle;
 
@@ -998,7 +996,7 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 				    void *holder,
 				    const struct blk_holder_ops *hops)
 {
-	struct file *bdev_file;
+	struct file *file;
 	dev_t dev;
 	int error;
 
@@ -1006,22 +1004,22 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 	if (error)
 		return ERR_PTR(error);
 
-	bdev_file = bdev_file_open_by_dev(dev, mode, holder, hops);
-	if (!IS_ERR(bdev_file) && (mode & BLK_OPEN_WRITE)) {
-		struct bdev_handle *handle = bdev_file->private_data;
-		if (bdev_read_only(handle->bdev)) {
-			fput(bdev_file);
-			bdev_file = ERR_PTR(-EACCES);
+	file = bdev_file_open_by_dev(dev, mode, holder, hops);
+	if (!IS_ERR(file) && (mode & BLK_OPEN_WRITE)) {
+		if (bdev_read_only(file_bdev(file))) {
+			fput(file);
+			file = ERR_PTR(-EACCES);
 		}
 	}
 
-	return bdev_file;
+	return file;
 }
 EXPORT_SYMBOL(bdev_file_open_by_path);
 
-void bdev_release(struct bdev_handle *handle)
+void bdev_release(struct file *bdev_file)
 {
-	struct block_device *bdev = handle->bdev;
+	struct block_device *bdev = file_bdev(bdev_file);
+	struct bdev_handle *handle = bdev_file->private_data;
 	struct gendisk *disk = bdev->bd_disk;
 
 	/*
diff --git a/block/blk.h b/block/blk.h
index 19b15870284f..7ca24814f3a0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -26,7 +26,6 @@ struct blk_flush_queue {
 };
 
 struct bdev_handle {
-	struct block_device *bdev;
 	void *holder;
 	blk_mode_t mode;
 };
@@ -522,7 +521,7 @@ static inline int req_ref_read(struct request *req)
 	return atomic_read(&req->ref);
 }
 
-void bdev_release(struct bdev_handle *handle);
+void bdev_release(struct file *bdev_file);
 int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	      const struct blk_holder_ops *hops, struct file *bdev_file);
 int bdev_permission(dev_t dev, blk_mode_t mode, void *holder);
diff --git a/block/fops.c b/block/fops.c
index 81ff8c0ce32f..5589bf9c3822 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -622,7 +622,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 
 static int blkdev_release(struct inode *inode, struct file *filp)
 {
-	bdev_release(filp->private_data);
+	bdev_release(filp);
 	return 0;
 }
 

-- 
2.43.0


