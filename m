Return-Path: <linux-fsdevel+bounces-8557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C260838FFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEAB11C280A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868D160B83;
	Tue, 23 Jan 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC5SQu32"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D660885;
	Tue, 23 Jan 2024 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016449; cv=none; b=QE9I25zGEkiiQOJNeIuMWwIwmdCqeO7lRe0c5nplH7CT/iiQoid6H9aW/qOA5P6VuTCn6IlzqVY3q9CgKiKmf+j3dfo6v/D18OlT8rxwJsztZGpLBYWtlfh4M3dLNzmHyIAN5KRSyOqwu+ohjJ7w6srq6m/Fa1X8cqtfBw1I1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016449; c=relaxed/simple;
	bh=Yf7JkIn85TjhAiBr3XqAbnyrj52syGPdnkvlt5pRMls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Acnz6z0L6qu/fY7qxDJ3EgZHHEnMYWvQccEtoPGrP9oXxCz7GeF0waZtVEBNmMmSSX7whDjcG5/13n5OBkqF21+cGaxmbA37k+S87qD52BrKf8kdm+9cknkZdcrXau/FzF9Sl/nE8cYV5crVcNCBRvnu+qTHW4b4GBuqsIOOAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC5SQu32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3ABBC4166A;
	Tue, 23 Jan 2024 13:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016448;
	bh=Yf7JkIn85TjhAiBr3XqAbnyrj52syGPdnkvlt5pRMls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aC5SQu32WUG8jwJnQcyr8T1YCGatMMPBehgF7espj7WgybQ0xbxxx/DKsMYJ5mLlL
	 WtMn4V4tzswHLha1phVmC/fXqMIBQvdS9e2F56uqMiLWn++QSwgDtM3FCNi0PFFiDA
	 oCxsOIM1Zq95JxamRIb+tGpRC2r+jgQfKmNKaJcWERWJRAkwHFldXugkeCHC+g8G/R
	 Z/x7NDXqSmi+vbfLf+3hcbCBATidiDWCt85CvrOFPvb+wsN7HSOMH0TeWkWn3ljq4J
	 waAQpqxJ9nommaZgpa1kq1lmZ/VcYwlacHM2J/p1fv/WRkIhVRKeKzvgTgNLMA+67D
	 pivaqdHXk0TQA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:29 +0100
Subject: [PATCH v2 12/34] zram: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-12-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=3676; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Yf7JkIn85TjhAiBr3XqAbnyrj52syGPdnkvlt5pRMls=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zf/xsE3y/qMP/YyvvfdyzQ578ZnFtVvh7fc/SPTH
 nD588H1WztKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAm0lvDyDDlzkU2CWk+IQ9d
 ncb2Y+ZTn7BXci63Ob3lXIeF3sqMnjOMDHsnv7tSv4LFkv3mmco4m/YmhT+9c6au6WJ67CZuWX+
 1iRkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/zram/zram_drv.c | 26 +++++++++++++-------------
 drivers/block/zram/zram_drv.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6772e0c654fa..d96b3851b5d3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -426,11 +426,11 @@ static void reset_bdev(struct zram *zram)
 	if (!zram->backing_dev)
 		return;
 
-	bdev_release(zram->bdev_handle);
+	fput(zram->bdev_file);
 	/* hope filp_close flush all of IO */
 	filp_close(zram->backing_dev, NULL);
 	zram->backing_dev = NULL;
-	zram->bdev_handle = NULL;
+	zram->bdev_file = NULL;
 	zram->disk->fops = &zram_devops;
 	kvfree(zram->bitmap);
 	zram->bitmap = NULL;
@@ -476,7 +476,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	struct address_space *mapping;
 	unsigned int bitmap_sz;
 	unsigned long nr_pages, *bitmap = NULL;
-	struct bdev_handle *bdev_handle = NULL;
+	struct file *bdev_file = NULL;
 	int err;
 	struct zram *zram = dev_to_zram(dev);
 
@@ -513,11 +513,11 @@ static ssize_t backing_dev_store(struct device *dev,
 		goto out;
 	}
 
-	bdev_handle = bdev_open_by_dev(inode->i_rdev,
+	bdev_file = bdev_file_open_by_dev(inode->i_rdev,
 				BLK_OPEN_READ | BLK_OPEN_WRITE, zram, NULL);
-	if (IS_ERR(bdev_handle)) {
-		err = PTR_ERR(bdev_handle);
-		bdev_handle = NULL;
+	if (IS_ERR(bdev_file)) {
+		err = PTR_ERR(bdev_file);
+		bdev_file = NULL;
 		goto out;
 	}
 
@@ -531,7 +531,7 @@ static ssize_t backing_dev_store(struct device *dev,
 
 	reset_bdev(zram);
 
-	zram->bdev_handle = bdev_handle;
+	zram->bdev_file = bdev_file;
 	zram->backing_dev = backing_dev;
 	zram->bitmap = bitmap;
 	zram->nr_pages = nr_pages;
@@ -544,8 +544,8 @@ static ssize_t backing_dev_store(struct device *dev,
 out:
 	kvfree(bitmap);
 
-	if (bdev_handle)
-		bdev_release(bdev_handle);
+	if (bdev_file)
+		fput(bdev_file);
 
 	if (backing_dev)
 		filp_close(backing_dev, NULL);
@@ -587,7 +587,7 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 {
 	struct bio *bio;
 
-	bio = bio_alloc(zram->bdev_handle->bdev, 1, parent->bi_opf, GFP_NOIO);
+	bio = bio_alloc(file_bdev(zram->bdev_file), 1, parent->bi_opf, GFP_NOIO);
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
 	__bio_add_page(bio, page, PAGE_SIZE, 0);
 	bio_chain(bio, parent);
@@ -703,7 +703,7 @@ static ssize_t writeback_store(struct device *dev,
 			continue;
 		}
 
-		bio_init(&bio, zram->bdev_handle->bdev, &bio_vec, 1,
+		bio_init(&bio, file_bdev(zram->bdev_file), &bio_vec, 1,
 			 REQ_OP_WRITE | REQ_SYNC);
 		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
 		__bio_add_page(&bio, page, PAGE_SIZE, 0);
@@ -785,7 +785,7 @@ static void zram_sync_read(struct work_struct *work)
 	struct bio_vec bv;
 	struct bio bio;
 
-	bio_init(&bio, zw->zram->bdev_handle->bdev, &bv, 1, REQ_OP_READ);
+	bio_init(&bio, file_bdev(zw->zram->bdev_file), &bv, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = zw->entry * (PAGE_SIZE >> 9);
 	__bio_add_page(&bio, zw->page, PAGE_SIZE, 0);
 	zw->error = submit_bio_wait(&bio);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 3b94d12f41b4..37bf29f34d26 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -132,7 +132,7 @@ struct zram {
 	spinlock_t wb_limit_lock;
 	bool wb_limit_enable;
 	u64 bd_wb_limit;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	unsigned long *bitmap;
 	unsigned long nr_pages;
 #endif

-- 
2.43.0


