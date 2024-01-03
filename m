Return-Path: <linux-fsdevel+bounces-7185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A90822DA0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328D1283999
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F90199CF;
	Wed,  3 Jan 2024 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIblHZms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF5199AD;
	Wed,  3 Jan 2024 12:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B931C433C9;
	Wed,  3 Jan 2024 12:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286536;
	bh=cB/ONpG3pRu8P63Oq88NUsbpgGRdyHmqXBst1QNeyyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IIblHZmsT5ZjOD82RfKkBTT5OrtFIw+z33enGg307livlThPrRtUXAdg1jhPwtzOW
	 ZgqMtjcmAQ1Hf8NaQWavmwTV+jp91KrJTBUBkApKu1AvWVrjSZ7yDNbTve+ELG5oBD
	 UjMf/lIn3iCjvIVWBRj2JlLePcrr8RqR28VEzVT/veUeAbGEGvbJAHPtF8yeMUz2N5
	 Q6YxQeHV5Vb4F8ckU7KOrJwQ7GQoLtibYYhGFCm8JCyRFf82vmQ8v2vlS28p6f/nT3
	 EDBHbjhwa6H7dyCsREQGDc48/JUt2KDTrIwGG3FiRfpOIGkmZpFExMXkxt6Rxt5lYT
	 uZMf2hK29dGWQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:02 +0100
Subject: [PATCH RFC 04/34] md: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-4-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=4717; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cB/ONpG3pRu8P63Oq88NUsbpgGRdyHmqXBst1QNeyyw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbRO8lq081jVJj6vUxdC+HRUJvD9trsoaxUq0yVm2
 3D4acKujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn4azH8r4yQU1ZbX6+kPXuq
 jprZnC7JeTduWSW/Whi/WdMxoG+xBSPDqiwHz1WlN+W42UKLnPa9Z9Exa625bXB6z/JXcYwfsiW
 ZAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/md/dm.c               | 23 +++++++++++++----------
 drivers/md/md.c               | 12 ++++++------
 drivers/md/md.h               |  2 +-
 include/linux/device-mapper.h |  2 +-
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8dcabf84d866..5f45dda430d7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -726,7 +726,8 @@ static struct table_device *open_table_device(struct mapped_device *md,
 		dev_t dev, blk_mode_t mode)
 {
 	struct table_device *td;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
+	struct block_device *bdev;
 	u64 part_off;
 	int r;
 
@@ -735,34 +736,36 @@ static struct table_device *open_table_device(struct mapped_device *md,
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&td->count, 1);
 
-	bdev_handle = bdev_open_by_dev(dev, mode, _dm_claim_ptr, NULL);
-	if (IS_ERR(bdev_handle)) {
-		r = PTR_ERR(bdev_handle);
+	f_bdev = bdev_file_open_by_dev(dev, mode, _dm_claim_ptr, NULL);
+	if (IS_ERR(f_bdev)) {
+		r = PTR_ERR(f_bdev);
 		goto out_free_td;
 	}
 
+	bdev = F_BDEV(f_bdev);
+
 	/*
 	 * We can be called before the dm disk is added.  In that case we can't
 	 * register the holder relation here.  It will be done once add_disk was
 	 * called.
 	 */
 	if (md->disk->slave_dir) {
-		r = bd_link_disk_holder(bdev_handle->bdev, md->disk);
+		r = bd_link_disk_holder(bdev, md->disk);
 		if (r)
 			goto out_blkdev_put;
 	}
 
 	td->dm_dev.mode = mode;
-	td->dm_dev.bdev = bdev_handle->bdev;
-	td->dm_dev.bdev_handle = bdev_handle;
-	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev_handle->bdev, &part_off,
+	td->dm_dev.bdev = bdev;
+	td->dm_dev.f_bdev = f_bdev;
+	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off,
 						NULL, NULL);
 	format_dev_t(td->dm_dev.name, dev);
 	list_add(&td->list, &md->table_devices);
 	return td;
 
 out_blkdev_put:
-	bdev_release(bdev_handle);
+	fput(f_bdev);
 out_free_td:
 	kfree(td);
 	return ERR_PTR(r);
@@ -775,7 +778,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 {
 	if (md->disk->slave_dir)
 		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
-	bdev_release(td->dm_dev.bdev_handle);
+	fput(td->dm_dev.f_bdev);
 	put_dax(td->dm_dev.dax_dev);
 	list_del(&td->list);
 	kfree(td);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9bdd57324c37..2235285ac58a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2549,7 +2549,7 @@ static void export_rdev(struct md_rdev *rdev, struct mddev *mddev)
 	if (test_bit(AutoDetected, &rdev->flags))
 		md_autodetect_dev(rdev->bdev->bd_dev);
 #endif
-	bdev_release(rdev->bdev_handle);
+	fput(rdev->f_bdev);
 	rdev->bdev = NULL;
 	kobject_put(&rdev->kobj);
 }
@@ -3748,16 +3748,16 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	if (err)
 		goto out_clear_rdev;
 
-	rdev->bdev_handle = bdev_open_by_dev(newdev,
+	rdev->f_bdev = bdev_file_open_by_dev(newdev,
 			BLK_OPEN_READ | BLK_OPEN_WRITE,
 			super_format == -2 ? &claim_rdev : rdev, NULL);
-	if (IS_ERR(rdev->bdev_handle)) {
+	if (IS_ERR(rdev->f_bdev)) {
 		pr_warn("md: could not open device unknown-block(%u,%u).\n",
 			MAJOR(newdev), MINOR(newdev));
-		err = PTR_ERR(rdev->bdev_handle);
+		err = PTR_ERR(rdev->f_bdev);
 		goto out_clear_rdev;
 	}
-	rdev->bdev = rdev->bdev_handle->bdev;
+	rdev->bdev = F_BDEV(rdev->f_bdev);
 
 	kobject_init(&rdev->kobj, &rdev_ktype);
 
@@ -3788,7 +3788,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	return rdev;
 
 out_blkdev_put:
-	bdev_release(rdev->bdev_handle);
+	fput(rdev->f_bdev);
 out_clear_rdev:
 	md_rdev_clear(rdev);
 out_free_rdev:
diff --git a/drivers/md/md.h b/drivers/md/md.h
index ade83af123a2..67d3a62a11f9 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -59,7 +59,7 @@ struct md_rdev {
 	 */
 	struct block_device *meta_bdev;
 	struct block_device *bdev;	/* block device handle */
-	struct bdev_handle *bdev_handle;	/* Handle from open for bdev */
+	struct file *f_bdev;		/* Handle from open for bdev */
 
 	struct page	*sb_page, *bb_page;
 	int		sb_loaded;
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 772ab4d74d94..c6eaa66d753b 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -165,7 +165,7 @@ void dm_error(const char *message);
 
 struct dm_dev {
 	struct block_device *bdev;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	struct dax_device *dax_dev;
 	blk_mode_t mode;
 	char name[16];

-- 
2.42.0


