Return-Path: <linux-fsdevel+bounces-7195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C118D822DB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63821C23498
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D82199B7;
	Wed,  3 Jan 2024 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfK1dCYa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A594199A1;
	Wed,  3 Jan 2024 12:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45571C433CA;
	Wed,  3 Jan 2024 12:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286557;
	bh=kwAJtLc8apI/Uo1XL1vD3tPPin09CwI62esGwHw4y7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rfK1dCYaX6Sla+BymY9Zw20WtndmhVWsUY9p7ezEGzEdxKI+a98FL4mkAw6cYWWj/
	 9UsftS4SbQts7OW6eAhmeP7gOPTDggMgPERobVypi4D4Rj7N/9tB5TSCg7pcNDJV/J
	 Kd/u6CJU8RG0rkLpc09kgGYOG6YBUwFmGzexdVWrGkMqufIu01DsOicR5F7kXzm8TX
	 jVBjs5vDkQ4rya6Ho2sTF4kUMLVg2uc4AXnEzA1RLM423osOfqv7Y0S+0vS235lP2Z
	 T7BNT4sXlXdFmb9fJlFcC3ZPL1eEgy38aCf0S5aRYxs+ipRJ1xW6EK3u3awdJv5XNd
	 +QPMgpeA6j6TQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:12 +0100
Subject: [PATCH RFC 14/34] block2mtd: port device access to files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-14-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=4922; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kwAJtLc8apI/Uo1XL1vD3tPPin09CwI62esGwHw4y7g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbTJ3/Y3VEC25IPEn2O37JvSAvwai8Ujvj+ZXqaTW
 /uDv1C1o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgF4CYHMPxTu5y29ua3ZO0ijtZH
 D++1890LCPP0uP/Ke9kheY+7m3KXMzIs8NJIiuBnKVJ89iru2avGA12J11XnT2tbFG5Y9OKFfR4
 vAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/mtd/devices/block2mtd.c | 42 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index aa44a23ec045..290e08afb8d0 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -37,7 +37,7 @@
 /* Info for the block device */
 struct block2mtd_dev {
 	struct list_head list;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	struct mtd_info mtd;
 	struct mutex write_mutex;
 };
@@ -56,7 +56,7 @@ static struct page *page_read(struct address_space *mapping, pgoff_t index)
 static int _block2mtd_erase(struct block2mtd_dev *dev, loff_t to, size_t len)
 {
 	struct address_space *mapping =
-				dev->bdev_handle->bdev->bd_inode->i_mapping;
+				file_inode(dev->f_bdev)->i_mapping;
 	struct page *page;
 	pgoff_t index = to >> PAGE_SHIFT;	// page index
 	int pages = len >> PAGE_SHIFT;
@@ -107,7 +107,7 @@ static int block2mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
 {
 	struct block2mtd_dev *dev = mtd->priv;
 	struct address_space *mapping =
-				dev->bdev_handle->bdev->bd_inode->i_mapping;
+				file_inode(dev->f_bdev)->i_mapping;
 	struct page *page;
 	pgoff_t index = from >> PAGE_SHIFT;
 	int offset = from & (PAGE_SIZE-1);
@@ -143,7 +143,7 @@ static int _block2mtd_write(struct block2mtd_dev *dev, const u_char *buf,
 {
 	struct page *page;
 	struct address_space *mapping =
-				dev->bdev_handle->bdev->bd_inode->i_mapping;
+				file_inode(dev->f_bdev)->i_mapping;
 	pgoff_t index = to >> PAGE_SHIFT;	// page index
 	int offset = to & ~PAGE_MASK;	// page offset
 	int cpylen;
@@ -198,7 +198,7 @@ static int block2mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
 static void block2mtd_sync(struct mtd_info *mtd)
 {
 	struct block2mtd_dev *dev = mtd->priv;
-	sync_blockdev(dev->bdev_handle->bdev);
+	sync_blockdev(F_BDEV(dev->f_bdev));
 	return;
 }
 
@@ -210,10 +210,10 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
 
 	kfree(dev->mtd.name);
 
-	if (dev->bdev_handle) {
+	if (dev->f_bdev) {
 		invalidate_mapping_pages(
-			dev->bdev_handle->bdev->bd_inode->i_mapping, 0, -1);
-		bdev_release(dev->bdev_handle);
+			file_inode(dev->f_bdev)->i_mapping, 0, -1);
+		fput(dev->f_bdev);
 	}
 
 	kfree(dev);
@@ -223,10 +223,10 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
  * This function is marked __ref because it calls the __init marked
  * early_lookup_bdev when called from the early boot code.
  */
-static struct bdev_handle __ref *mdtblock_early_get_bdev(const char *devname,
+static struct file __ref *mdtblock_early_get_bdev(const char *devname,
 		blk_mode_t mode, int timeout, struct block2mtd_dev *dev)
 {
-	struct bdev_handle *bdev_handle = ERR_PTR(-ENODEV);
+	struct file *f_bdev = ERR_PTR(-ENODEV);
 #ifndef MODULE
 	int i;
 
@@ -234,7 +234,7 @@ static struct bdev_handle __ref *mdtblock_early_get_bdev(const char *devname,
 	 * We can't use early_lookup_bdev from a running system.
 	 */
 	if (system_state >= SYSTEM_RUNNING)
-		return bdev_handle;
+		return f_bdev;
 
 	/*
 	 * We might not have the root device mounted at this point.
@@ -253,20 +253,20 @@ static struct bdev_handle __ref *mdtblock_early_get_bdev(const char *devname,
 		wait_for_device_probe();
 
 		if (!early_lookup_bdev(devname, &devt)) {
-			bdev_handle = bdev_open_by_dev(devt, mode, dev, NULL);
-			if (!IS_ERR(bdev_handle))
+			f_bdev = bdev_file_open_by_dev(devt, mode, dev, NULL);
+			if (!IS_ERR(f_bdev))
 				break;
 		}
 	}
 #endif
-	return bdev_handle;
+	return f_bdev;
 }
 
 static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		char *label, int timeout)
 {
 	const blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_WRITE;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	struct block_device *bdev;
 	struct block2mtd_dev *dev;
 	char *name;
@@ -279,16 +279,16 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		return NULL;
 
 	/* Get a handle on the device */
-	bdev_handle = bdev_open_by_path(devname, mode, dev, NULL);
-	if (IS_ERR(bdev_handle))
-		bdev_handle = mdtblock_early_get_bdev(devname, mode, timeout,
+	f_bdev = bdev_file_open_by_path(devname, mode, dev, NULL);
+	if (IS_ERR(f_bdev))
+		f_bdev = mdtblock_early_get_bdev(devname, mode, timeout,
 						      dev);
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(f_bdev)) {
 		pr_err("error: cannot open device %s\n", devname);
 		goto err_free_block2mtd;
 	}
-	dev->bdev_handle = bdev_handle;
-	bdev = bdev_handle->bdev;
+	dev->f_bdev = f_bdev;
+	bdev = F_BDEV(f_bdev);
 
 	if (MAJOR(bdev->bd_dev) == MTD_BLOCK_MAJOR) {
 		pr_err("attempting to use an MTD device as a block device\n");

-- 
2.42.0


