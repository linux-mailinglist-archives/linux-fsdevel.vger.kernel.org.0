Return-Path: <linux-fsdevel+bounces-8559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD839839003
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3EF2922D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079A660BB6;
	Tue, 23 Jan 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttIxG4DJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029560B8B;
	Tue, 23 Jan 2024 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016453; cv=none; b=AWuIiBHjgUxtLxobOtGFX1fXxyIqrcBFqU6hJ9QYxO4qHmuGHYKIIuwaDdoygr2fVyg4/2SAPk2ZKm7673tDhuxd5VLaFEJWL8YPcXtPPxRbKRT2Qw015eBR+4rEywb/7c5vxTGzlowmWkt6r9Ey8UpQ23vlUYcWdwGeOKIPzcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016453; c=relaxed/simple;
	bh=zvQJtorkoXXa/FXSil4w5qxpHrmga1OP6ymfQ7y/j7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fszKLYP+wkkCkAwDVpPzKLtmCGW7cN3ANA7C5sAcdFChhr4MihPT0ZH02jQ4UwcGfLzWKxt0X/DdvOqtAQYGDp9j5INFblsVxX5XTsLevSGfmt6ovwO7c/yp3jEM6mUH9UlYW1VflOC1YJEPYksVfweluPLPL+EHGOmZZesOpZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttIxG4DJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DB3C4166A;
	Tue, 23 Jan 2024 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016452;
	bh=zvQJtorkoXXa/FXSil4w5qxpHrmga1OP6ymfQ7y/j7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ttIxG4DJrqTa9Qk1Y2P5PZrh8i6rs33vx2td4oqu47boylhZQDr5zXiClV3p62dFc
	 RNHIzXdcqAsEIpqkzep9sumuEida8tVopTE8JkC28/7ZAiZ9ucXLggdlgprdDI+c/D
	 qa6hK9lD2oycCSBiCwiM86pusHHHkWFY3FbmLSPy+lp8NkR1I3FBzpXyh6hiLZnmu0
	 Kze55N0efGiZSu4Htl4ui4dKH2Znr9budXcAchS2yBqiOFMb3HgVNmt6lgps7sa4pP
	 IpiNQjkTgZ3WH9CU8S+CjXxIZYN3AuCdJ+ts7FwOJGoPcq32AL9iv704Xy1S1G6WNC
	 n5CVuJBZgQjhQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:31 +0100
Subject: [PATCH v2 14/34] block2mtd: port device access to files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-14-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=5174; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zvQJtorkoXXa/FXSil4w5qxpHrmga1OP6ymfQ7y/j7M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zdfOWuiQ2S/bKvO/9vfZt+9v1TO4sA/TwH+g4f4H
 pnWfT/m3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR1SsZGaZdOHJSnevSlp71
 Gmv2beP5z/Vb+/Qmn1SrlStcGgKOCYgwMvzZ0XZULSG7Ly1Zf6tRX0pU0eqZDq8uBIrmJdtMluH
 bxw8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/mtd/devices/block2mtd.c | 46 +++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index aa44a23ec045..97a00ec9a4d4 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -37,7 +37,7 @@
 /* Info for the block device */
 struct block2mtd_dev {
 	struct list_head list;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	struct mtd_info mtd;
 	struct mutex write_mutex;
 };
@@ -55,8 +55,7 @@ static struct page *page_read(struct address_space *mapping, pgoff_t index)
 /* erase a specified part of the device */
 static int _block2mtd_erase(struct block2mtd_dev *dev, loff_t to, size_t len)
 {
-	struct address_space *mapping =
-				dev->bdev_handle->bdev->bd_inode->i_mapping;
+	struct address_space *mapping = dev->bdev_file->f_mapping;
 	struct page *page;
 	pgoff_t index = to >> PAGE_SHIFT;	// page index
 	int pages = len >> PAGE_SHIFT;
@@ -106,8 +105,7 @@ static int block2mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
 		size_t *retlen, u_char *buf)
 {
 	struct block2mtd_dev *dev = mtd->priv;
-	struct address_space *mapping =
-				dev->bdev_handle->bdev->bd_inode->i_mapping;
+	struct address_space *mapping = dev->bdev_file->f_mapping;
 	struct page *page;
 	pgoff_t index = from >> PAGE_SHIFT;
 	int offset = from & (PAGE_SIZE-1);
@@ -142,8 +140,7 @@ static int _block2mtd_write(struct block2mtd_dev *dev, const u_char *buf,
 		loff_t to, size_t len, size_t *retlen)
 {
 	struct page *page;
-	struct address_space *mapping =
-				dev->bdev_handle->bdev->bd_inode->i_mapping;
+	struct address_space *mapping = dev->bdev_file->f_mapping;
 	pgoff_t index = to >> PAGE_SHIFT;	// page index
 	int offset = to & ~PAGE_MASK;	// page offset
 	int cpylen;
@@ -198,7 +195,7 @@ static int block2mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
 static void block2mtd_sync(struct mtd_info *mtd)
 {
 	struct block2mtd_dev *dev = mtd->priv;
-	sync_blockdev(dev->bdev_handle->bdev);
+	sync_blockdev(file_bdev(dev->bdev_file));
 	return;
 }
 
@@ -210,10 +207,9 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
 
 	kfree(dev->mtd.name);
 
-	if (dev->bdev_handle) {
-		invalidate_mapping_pages(
-			dev->bdev_handle->bdev->bd_inode->i_mapping, 0, -1);
-		bdev_release(dev->bdev_handle);
+	if (dev->bdev_file) {
+		invalidate_mapping_pages(dev->bdev_file->f_mapping, 0, -1);
+		fput(dev->bdev_file);
 	}
 
 	kfree(dev);
@@ -223,10 +219,10 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
  * This function is marked __ref because it calls the __init marked
  * early_lookup_bdev when called from the early boot code.
  */
-static struct bdev_handle __ref *mdtblock_early_get_bdev(const char *devname,
+static struct file __ref *mdtblock_early_get_bdev(const char *devname,
 		blk_mode_t mode, int timeout, struct block2mtd_dev *dev)
 {
-	struct bdev_handle *bdev_handle = ERR_PTR(-ENODEV);
+	struct file *bdev_file = ERR_PTR(-ENODEV);
 #ifndef MODULE
 	int i;
 
@@ -234,7 +230,7 @@ static struct bdev_handle __ref *mdtblock_early_get_bdev(const char *devname,
 	 * We can't use early_lookup_bdev from a running system.
 	 */
 	if (system_state >= SYSTEM_RUNNING)
-		return bdev_handle;
+		return bdev_file;
 
 	/*
 	 * We might not have the root device mounted at this point.
@@ -253,20 +249,20 @@ static struct bdev_handle __ref *mdtblock_early_get_bdev(const char *devname,
 		wait_for_device_probe();
 
 		if (!early_lookup_bdev(devname, &devt)) {
-			bdev_handle = bdev_open_by_dev(devt, mode, dev, NULL);
-			if (!IS_ERR(bdev_handle))
+			bdev_file = bdev_file_open_by_dev(devt, mode, dev, NULL);
+			if (!IS_ERR(bdev_file))
 				break;
 		}
 	}
 #endif
-	return bdev_handle;
+	return bdev_file;
 }
 
 static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		char *label, int timeout)
 {
 	const blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_WRITE;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	struct block_device *bdev;
 	struct block2mtd_dev *dev;
 	char *name;
@@ -279,16 +275,16 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		return NULL;
 
 	/* Get a handle on the device */
-	bdev_handle = bdev_open_by_path(devname, mode, dev, NULL);
-	if (IS_ERR(bdev_handle))
-		bdev_handle = mdtblock_early_get_bdev(devname, mode, timeout,
+	bdev_file = bdev_file_open_by_path(devname, mode, dev, NULL);
+	if (IS_ERR(bdev_file))
+		bdev_file = mdtblock_early_get_bdev(devname, mode, timeout,
 						      dev);
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(bdev_file)) {
 		pr_err("error: cannot open device %s\n", devname);
 		goto err_free_block2mtd;
 	}
-	dev->bdev_handle = bdev_handle;
-	bdev = bdev_handle->bdev;
+	dev->bdev_file = bdev_file;
+	bdev = file_bdev(bdev_file);
 
 	if (MAJOR(bdev->bd_dev) == MTD_BLOCK_MAJOR) {
 		pr_err("attempting to use an MTD device as a block device\n");

-- 
2.43.0


