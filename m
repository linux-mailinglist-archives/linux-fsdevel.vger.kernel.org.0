Return-Path: <linux-fsdevel+bounces-7193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD8A822DB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11E1284063
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABB819468;
	Wed,  3 Jan 2024 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G556tMuT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1319445;
	Wed,  3 Jan 2024 12:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ECBC433CC;
	Wed,  3 Jan 2024 12:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286553;
	bh=/ll1XHivVArMWvaVV2mzYuNe9BlTI/z4SH3I5iJyfBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G556tMuT1fjUnUcycMLt+2boX9n6kgitrhgkyqhc42HrbsAbNN0+NmS9GAnqMx0hM
	 JkCIGHGL59exrTQr5gQRAh2rztqRTF+A2WqLvjUtcq+NQcP11UsZOG7dYa3DAC0VhY
	 1G6vEEve9A84vTy/7EZha4v7AsFQNMemvFZ9MoDhMB/miVTtjrZSdPdrCnCHKSwHr7
	 5VhhNV7aV//Shz5aRr7ss0S1w9Qb9duNW3ThQhM8DMFivMNhxSfCsPi1RCn/vRL8yN
	 Gu+aK3kVlLfT3+sWsdlO4ETs697Hm/tjU2VYrdYrTkyNvO+Jj3FboEFXjEhAPLwRS3
	 LszD3B8Lwt13A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:10 +0100
Subject: [PATCH RFC 12/34] zram: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-12-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=3622; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/ll1XHivVArMWvaVV2mzYuNe9BlTI/z4SH3I5iJyfBk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbQJ8nn+IFLxkdWj7/zuNT7/ZzGsmLJ+WXlRU8Keb
 96Vm2JYOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYS94Hhf951y4XtJtEtK9da
 THXi2SOYEhJSIv9P4N7B08t1PyWv/MXw3zPhQGif6op1AdyCnWcV7wgUaD212D1txY72oMfObAe
 W8AEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/zram/zram_drv.c | 26 +++++++++++++-------------
 drivers/block/zram/zram_drv.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d77d3664ca08..7bf8360831b7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -417,11 +417,11 @@ static void reset_bdev(struct zram *zram)
 	if (!zram->backing_dev)
 		return;
 
-	bdev_release(zram->bdev_handle);
+	fput(zram->f_bdev);
 	/* hope filp_close flush all of IO */
 	filp_close(zram->backing_dev, NULL);
 	zram->backing_dev = NULL;
-	zram->bdev_handle = NULL;
+	zram->f_bdev = NULL;
 	zram->disk->fops = &zram_devops;
 	kvfree(zram->bitmap);
 	zram->bitmap = NULL;
@@ -467,7 +467,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	struct address_space *mapping;
 	unsigned int bitmap_sz;
 	unsigned long nr_pages, *bitmap = NULL;
-	struct bdev_handle *bdev_handle = NULL;
+	struct file *f_bdev = NULL;
 	int err;
 	struct zram *zram = dev_to_zram(dev);
 
@@ -504,11 +504,11 @@ static ssize_t backing_dev_store(struct device *dev,
 		goto out;
 	}
 
-	bdev_handle = bdev_open_by_dev(inode->i_rdev,
+	f_bdev = bdev_file_open_by_dev(inode->i_rdev,
 				BLK_OPEN_READ | BLK_OPEN_WRITE, zram, NULL);
-	if (IS_ERR(bdev_handle)) {
-		err = PTR_ERR(bdev_handle);
-		bdev_handle = NULL;
+	if (IS_ERR(f_bdev)) {
+		err = PTR_ERR(f_bdev);
+		f_bdev = NULL;
 		goto out;
 	}
 
@@ -522,7 +522,7 @@ static ssize_t backing_dev_store(struct device *dev,
 
 	reset_bdev(zram);
 
-	zram->bdev_handle = bdev_handle;
+	zram->f_bdev = f_bdev;
 	zram->backing_dev = backing_dev;
 	zram->bitmap = bitmap;
 	zram->nr_pages = nr_pages;
@@ -535,8 +535,8 @@ static ssize_t backing_dev_store(struct device *dev,
 out:
 	kvfree(bitmap);
 
-	if (bdev_handle)
-		bdev_release(bdev_handle);
+	if (f_bdev)
+		fput(f_bdev);
 
 	if (backing_dev)
 		filp_close(backing_dev, NULL);
@@ -578,7 +578,7 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 {
 	struct bio *bio;
 
-	bio = bio_alloc(zram->bdev_handle->bdev, 1, parent->bi_opf, GFP_NOIO);
+	bio = bio_alloc(F_BDEV(zram->f_bdev), 1, parent->bi_opf, GFP_NOIO);
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
 	__bio_add_page(bio, page, PAGE_SIZE, 0);
 	bio_chain(bio, parent);
@@ -694,7 +694,7 @@ static ssize_t writeback_store(struct device *dev,
 			continue;
 		}
 
-		bio_init(&bio, zram->bdev_handle->bdev, &bio_vec, 1,
+		bio_init(&bio, F_BDEV(zram->f_bdev), &bio_vec, 1,
 			 REQ_OP_WRITE | REQ_SYNC);
 		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
 		__bio_add_page(&bio, page, PAGE_SIZE, 0);
@@ -776,7 +776,7 @@ static void zram_sync_read(struct work_struct *work)
 	struct bio_vec bv;
 	struct bio bio;
 
-	bio_init(&bio, zw->zram->bdev_handle->bdev, &bv, 1, REQ_OP_READ);
+	bio_init(&bio, F_BDEV(zw->zram->f_bdev), &bv, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = zw->entry * (PAGE_SIZE >> 9);
 	__bio_add_page(&bio, zw->page, PAGE_SIZE, 0);
 	zw->error = submit_bio_wait(&bio);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index d090753f97be..6d02e678483e 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -132,7 +132,7 @@ struct zram {
 	spinlock_t wb_limit_lock;
 	bool wb_limit_enable;
 	u64 bd_wb_limit;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	unsigned long *bitmap;
 	unsigned long nr_pages;
 #endif

-- 
2.42.0


