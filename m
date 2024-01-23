Return-Path: <linux-fsdevel+bounces-8549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63859838FEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E267E1F20D44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764BB60244;
	Tue, 23 Jan 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+iiFKvD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1CD5FF12;
	Tue, 23 Jan 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016430; cv=none; b=BA8jIh9wVvj1tzK6yEzTk8PcqVRrM1FAFY2xuAfLZ8VY2GVnF9It5nqgC5ePkCM10E1F968drUTAuueGtrXB2HrpyUaUPgbWbt4Unm+Bx+P81vo8vg17Lor9rBipTl7G6mhrr6ElbKGWWP5kEf2SJUgQvOPm24uWTnxWwvg7XMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016430; c=relaxed/simple;
	bh=zzafEKIU4K0Ai5z9JsG5YvgiMOhfaQHMXtd+NujUf+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EDUSzgMDM7bXGRYwNFE+zK0m9LWjm3MdOPgAkn0bv7MSbAhhI+myo9ML5CHPuNvNdtgGzqyui3MXtYgDfhQ5tDvJN5HJ+IsF/7Wbsm2utcIt+lc94+43oJqNEFxn6/02sTzpeaDEKblzu5FztuqI81u/wSy8HzDb+BfcK3fCavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+iiFKvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7669DC433B1;
	Tue, 23 Jan 2024 13:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016429;
	bh=zzafEKIU4K0Ai5z9JsG5YvgiMOhfaQHMXtd+NujUf+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U+iiFKvDY0eieab7i1GWRxXdvSxqfAkI7HFi16xONriuwgNo7azyLg1KyQIPFrmDg
	 9J08vdECVT70YVfYMTq97zRjehjB2do9t6gnkG4SyVJF8Q+yN6ZEQTGwGcWWVoQ6cZ
	 KKUG3msbgjZwqf09ruoboV1ueZzBv9eWNYlwuVSGmUXCMr0ai9EW7VGSlkvmIYsCDB
	 gvL2OWZHcWDvQyvDUs4vG6wXIXEw1Ca70Y9+kBw12voQ8uk9lgbuPKVM19KTp877vB
	 dIXNvkBpdsiIfnSKu+fmq1huR75F067KVrdUjTUgOiJBpEOGHqud5Zljjpe/qbyI2W
	 6RfX9qhuhxR5g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:21 +0100
Subject: [PATCH v2 04/34] md: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-4-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=4774; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zzafEKIU4K0Ai5z9JsG5YvgiMOhfaQHMXtd+NujUf+4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zcvuFyMc8m091mNGW9Ynq9+MH3C5RPfzx16YNs8/
 VnjU7Y1Dh2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATibVm+Kf84fztb04ybxUY
 zv7gEFqqJqG0MGxduaj3jb+yi1M69cIZ/hn2rvl1z61DtUw87vxCFY+9bwx7SlZv5pXdvLpDoME
 sgh8A
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
index 8dcabf84d866..87de5b5682ad 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -726,7 +726,8 @@ static struct table_device *open_table_device(struct mapped_device *md,
 		dev_t dev, blk_mode_t mode)
 {
 	struct table_device *td;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
+	struct block_device *bdev;
 	u64 part_off;
 	int r;
 
@@ -735,34 +736,36 @@ static struct table_device *open_table_device(struct mapped_device *md,
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&td->count, 1);
 
-	bdev_handle = bdev_open_by_dev(dev, mode, _dm_claim_ptr, NULL);
-	if (IS_ERR(bdev_handle)) {
-		r = PTR_ERR(bdev_handle);
+	bdev_file = bdev_file_open_by_dev(dev, mode, _dm_claim_ptr, NULL);
+	if (IS_ERR(bdev_file)) {
+		r = PTR_ERR(bdev_file);
 		goto out_free_td;
 	}
 
+	bdev = file_bdev(bdev_file);
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
+	td->dm_dev.bdev_file = bdev_file;
+	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off,
 						NULL, NULL);
 	format_dev_t(td->dm_dev.name, dev);
 	list_add(&td->list, &md->table_devices);
 	return td;
 
 out_blkdev_put:
-	bdev_release(bdev_handle);
+	fput(bdev_file);
 out_free_td:
 	kfree(td);
 	return ERR_PTR(r);
@@ -775,7 +778,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 {
 	if (md->disk->slave_dir)
 		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
-	bdev_release(td->dm_dev.bdev_handle);
+	fput(td->dm_dev.bdev_file);
 	put_dax(td->dm_dev.dax_dev);
 	list_del(&td->list);
 	kfree(td);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2266358d8074..0653584db63b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2578,7 +2578,7 @@ static void export_rdev(struct md_rdev *rdev, struct mddev *mddev)
 	if (test_bit(AutoDetected, &rdev->flags))
 		md_autodetect_dev(rdev->bdev->bd_dev);
 #endif
-	bdev_release(rdev->bdev_handle);
+	fput(rdev->bdev_file);
 	rdev->bdev = NULL;
 	kobject_put(&rdev->kobj);
 }
@@ -3773,16 +3773,16 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	if (err)
 		goto out_clear_rdev;
 
-	rdev->bdev_handle = bdev_open_by_dev(newdev,
+	rdev->bdev_file = bdev_file_open_by_dev(newdev,
 			BLK_OPEN_READ | BLK_OPEN_WRITE,
 			super_format == -2 ? &claim_rdev : rdev, NULL);
-	if (IS_ERR(rdev->bdev_handle)) {
+	if (IS_ERR(rdev->bdev_file)) {
 		pr_warn("md: could not open device unknown-block(%u,%u).\n",
 			MAJOR(newdev), MINOR(newdev));
-		err = PTR_ERR(rdev->bdev_handle);
+		err = PTR_ERR(rdev->bdev_file);
 		goto out_clear_rdev;
 	}
-	rdev->bdev = rdev->bdev_handle->bdev;
+	rdev->bdev = file_bdev(rdev->bdev_file);
 
 	kobject_init(&rdev->kobj, &rdev_ktype);
 
@@ -3813,7 +3813,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	return rdev;
 
 out_blkdev_put:
-	bdev_release(rdev->bdev_handle);
+	fput(rdev->bdev_file);
 out_clear_rdev:
 	md_rdev_clear(rdev);
 out_free_rdev:
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 8d881cc59799..a079ee9b6190 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -59,7 +59,7 @@ struct md_rdev {
 	 */
 	struct block_device *meta_bdev;
 	struct block_device *bdev;	/* block device handle */
-	struct bdev_handle *bdev_handle;	/* Handle from open for bdev */
+	struct file *bdev_file;		/* Handle from open for bdev */
 
 	struct page	*sb_page, *bb_page;
 	int		sb_loaded;
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 772ab4d74d94..82b2195efaca 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -165,7 +165,7 @@ void dm_error(const char *message);
 
 struct dm_dev {
 	struct block_device *bdev;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	struct dax_device *dax_dev;
 	blk_mode_t mode;
 	char name[16];

-- 
2.43.0


