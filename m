Return-Path: <linux-fsdevel+bounces-8558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1B0839001
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF455292007
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B7A60B9E;
	Tue, 23 Jan 2024 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVNydM1x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654A860B8D;
	Tue, 23 Jan 2024 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016451; cv=none; b=F4vcMhIvIEzuyBM188xc7fBrRyIfjPpzhCvLtLVEhkxjxeRxZ4GSjx7J6xEDisiJY69Y4A75qpj13rKkTnCc5QxYtQchd00HA4QjYGCkTZ/F4ZLmEiDJgqfFZzc2cn0znbj4z/w3Yw0zuR+fXaflLkr1quV3Sy/ZZr4ox4ZUofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016451; c=relaxed/simple;
	bh=h8FU3r+cVFUvc6HDTBVeny/0GesaL0HXMLFocoEdmxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2k2ww48HyniO518ly5Vs1gXAhbWAMqordwM3b9fScWAKu+gynvg6e0VZQSwKz0SQ3ad1kmp6dbuB3cmbXuhb723mhqw+NvffuIU6x+ZFPA4JDnf2oBEvo1VCeALy+45l2yJT1HCVDan2O34gKURS6B4yMJlmF/CriSEDLHN4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVNydM1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1302C116B1;
	Tue, 23 Jan 2024 13:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016450;
	bh=h8FU3r+cVFUvc6HDTBVeny/0GesaL0HXMLFocoEdmxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rVNydM1xyBGmXednqT/ePlRheP6KyUpIBIWXlM0yA/CQCNHip72fzLimGmSWd0xcn
	 hLgf3P5QYGvBgzHMqohZIglrNooDDkxBtaajTR8tLYPa7SemPplNA3xlWmDW4TEwJT
	 BPSwDnVEeNPlSZ9Dskq471koY7ojc5KxJfZwrYek6HmV+1lIhS5PXXQEqlb9xDYKyC
	 xD9u1dzGNxRKGTPGUzo0rGyNQccMO2uZSgXcSI/GWIptPFBCzULXGWadZE6EE1VAbR
	 AnYWrAeAFDcedApizmTVtm/umwchUQIYF7uSPGGuyRpVpMp1Q1/LHn5jm+aCvvshSz
	 VVIlar9nPkHNg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:30 +0100
Subject: [PATCH v2 13/34] bcache: port block device access to files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-13-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=8477; i=brauner@kernel.org;
 h=from:subject:message-id; bh=h8FU3r+cVFUvc6HDTBVeny/0GesaL0HXMLFocoEdmxQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zd/mkD2LbW7LXHhqh96K/sP9m+TkZzw7/TvYzY9O
 3/d/fVsZUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEbjgz/NO4axKV4Gh6u/li
 A5Pbq/A7/qfDvq4oPSRiyVmmuVhtvivD/wDrvdN0/15yalMx37D1y4KPmifnZu247skz2fuP1hm
 Wdk4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/md/bcache/bcache.h |  4 +--
 drivers/md/bcache/super.c  | 74 +++++++++++++++++++++++-----------------------
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 6ae2329052c9..4e6afa89921f 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -300,7 +300,7 @@ struct cached_dev {
 	struct list_head	list;
 	struct bcache_device	disk;
 	struct block_device	*bdev;
-	struct bdev_handle	*bdev_handle;
+	struct file		*bdev_file;
 
 	struct cache_sb		sb;
 	struct cache_sb_disk	*sb_disk;
@@ -423,7 +423,7 @@ struct cache {
 
 	struct kobject		kobj;
 	struct block_device	*bdev;
-	struct bdev_handle	*bdev_handle;
+	struct file		*bdev_file;
 
 	struct task_struct	*alloc_thread;
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index dc3f50f69714..d00b3abab133 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1369,8 +1369,8 @@ static CLOSURE_CALLBACK(cached_dev_free)
 	if (dc->sb_disk)
 		put_page(virt_to_page(dc->sb_disk));
 
-	if (dc->bdev_handle)
-		bdev_release(dc->bdev_handle);
+	if (dc->bdev_file)
+		fput(dc->bdev_file);
 
 	wake_up(&unregister_wait);
 
@@ -1445,7 +1445,7 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
 /* Cached device - bcache superblock */
 
 static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
-				 struct bdev_handle *bdev_handle,
+				 struct file *bdev_file,
 				 struct cached_dev *dc)
 {
 	const char *err = "cannot allocate memory";
@@ -1453,8 +1453,8 @@ static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 	int ret = -ENOMEM;
 
 	memcpy(&dc->sb, sb, sizeof(struct cache_sb));
-	dc->bdev_handle = bdev_handle;
-	dc->bdev = bdev_handle->bdev;
+	dc->bdev_file = bdev_file;
+	dc->bdev = file_bdev(bdev_file);
 	dc->sb_disk = sb_disk;
 
 	if (cached_dev_init(dc, sb->block_size << 9))
@@ -2218,8 +2218,8 @@ void bch_cache_release(struct kobject *kobj)
 	if (ca->sb_disk)
 		put_page(virt_to_page(ca->sb_disk));
 
-	if (ca->bdev_handle)
-		bdev_release(ca->bdev_handle);
+	if (ca->bdev_file)
+		fput(ca->bdev_file);
 
 	kfree(ca);
 	module_put(THIS_MODULE);
@@ -2339,18 +2339,18 @@ static int cache_alloc(struct cache *ca)
 }
 
 static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
-				struct bdev_handle *bdev_handle,
+				struct file *bdev_file,
 				struct cache *ca)
 {
 	const char *err = NULL; /* must be set for any error case */
 	int ret = 0;
 
 	memcpy(&ca->sb, sb, sizeof(struct cache_sb));
-	ca->bdev_handle = bdev_handle;
-	ca->bdev = bdev_handle->bdev;
+	ca->bdev_file = bdev_file;
+	ca->bdev = file_bdev(bdev_file);
 	ca->sb_disk = sb_disk;
 
-	if (bdev_max_discard_sectors((bdev_handle->bdev)))
+	if (bdev_max_discard_sectors(file_bdev(bdev_file)))
 		ca->discard = CACHE_DISCARD(&ca->sb);
 
 	ret = cache_alloc(ca);
@@ -2361,20 +2361,20 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 			err = "cache_alloc(): cache device is too small";
 		else
 			err = "cache_alloc(): unknown error";
-		pr_notice("error %pg: %s\n", bdev_handle->bdev, err);
+		pr_notice("error %pg: %s\n", file_bdev(bdev_file), err);
 		/*
 		 * If we failed here, it means ca->kobj is not initialized yet,
 		 * kobject_put() won't be called and there is no chance to
-		 * call bdev_release() to bdev in bch_cache_release(). So
-		 * we explicitly call bdev_release() here.
+		 * call fput() to bdev in bch_cache_release(). So
+		 * we explicitly call fput() on the block device here.
 		 */
-		bdev_release(bdev_handle);
+		fput(bdev_file);
 		return ret;
 	}
 
-	if (kobject_add(&ca->kobj, bdev_kobj(bdev_handle->bdev), "bcache")) {
+	if (kobject_add(&ca->kobj, bdev_kobj(file_bdev(bdev_file)), "bcache")) {
 		pr_notice("error %pg: error calling kobject_add\n",
-			  bdev_handle->bdev);
+			  file_bdev(bdev_file));
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -2388,7 +2388,7 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 		goto out;
 	}
 
-	pr_info("registered cache device %pg\n", ca->bdev_handle->bdev);
+	pr_info("registered cache device %pg\n", file_bdev(ca->bdev_file));
 
 out:
 	kobject_put(&ca->kobj);
@@ -2446,7 +2446,7 @@ struct async_reg_args {
 	char *path;
 	struct cache_sb *sb;
 	struct cache_sb_disk *sb_disk;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	void *holder;
 };
 
@@ -2457,7 +2457,7 @@ static void register_bdev_worker(struct work_struct *work)
 		container_of(work, struct async_reg_args, reg_work.work);
 
 	mutex_lock(&bch_register_lock);
-	if (register_bdev(args->sb, args->sb_disk, args->bdev_handle,
+	if (register_bdev(args->sb, args->sb_disk, args->bdev_file,
 			  args->holder) < 0)
 		fail = true;
 	mutex_unlock(&bch_register_lock);
@@ -2478,7 +2478,7 @@ static void register_cache_worker(struct work_struct *work)
 		container_of(work, struct async_reg_args, reg_work.work);
 
 	/* blkdev_put() will be called in bch_cache_release() */
-	if (register_cache(args->sb, args->sb_disk, args->bdev_handle,
+	if (register_cache(args->sb, args->sb_disk, args->bdev_file,
 			   args->holder))
 		fail = true;
 
@@ -2516,7 +2516,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	char *path = NULL;
 	struct cache_sb *sb;
 	struct cache_sb_disk *sb_disk;
-	struct bdev_handle *bdev_handle, *bdev_handle2;
+	struct file *bdev_file, *bdev_file2;
 	void *holder = NULL;
 	ssize_t ret;
 	bool async_registration = false;
@@ -2549,15 +2549,15 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 
 	ret = -EINVAL;
 	err = "failed to open device";
-	bdev_handle = bdev_open_by_path(strim(path), BLK_OPEN_READ, NULL, NULL);
-	if (IS_ERR(bdev_handle))
+	bdev_file = bdev_file_open_by_path(strim(path), BLK_OPEN_READ, NULL, NULL);
+	if (IS_ERR(bdev_file))
 		goto out_free_sb;
 
 	err = "failed to set blocksize";
-	if (set_blocksize(bdev_handle->bdev, 4096))
+	if (set_blocksize(file_bdev(bdev_file), 4096))
 		goto out_blkdev_put;
 
-	err = read_super(sb, bdev_handle->bdev, &sb_disk);
+	err = read_super(sb, file_bdev(bdev_file), &sb_disk);
 	if (err)
 		goto out_blkdev_put;
 
@@ -2569,13 +2569,13 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	}
 
 	/* Now reopen in exclusive mode with proper holder */
-	bdev_handle2 = bdev_open_by_dev(bdev_handle->bdev->bd_dev,
+	bdev_file2 = bdev_file_open_by_dev(file_bdev(bdev_file)->bd_dev,
 			BLK_OPEN_READ | BLK_OPEN_WRITE, holder, NULL);
-	bdev_release(bdev_handle);
-	bdev_handle = bdev_handle2;
-	if (IS_ERR(bdev_handle)) {
-		ret = PTR_ERR(bdev_handle);
-		bdev_handle = NULL;
+	fput(bdev_file);
+	bdev_file = bdev_file2;
+	if (IS_ERR(bdev_file)) {
+		ret = PTR_ERR(bdev_file);
+		bdev_file = NULL;
 		if (ret == -EBUSY) {
 			dev_t dev;
 
@@ -2610,7 +2610,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 		args->path	= path;
 		args->sb	= sb;
 		args->sb_disk	= sb_disk;
-		args->bdev_handle	= bdev_handle;
+		args->bdev_file	= bdev_file;
 		args->holder	= holder;
 		register_device_async(args);
 		/* No wait and returns to user space */
@@ -2619,14 +2619,14 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 
 	if (SB_IS_BDEV(sb)) {
 		mutex_lock(&bch_register_lock);
-		ret = register_bdev(sb, sb_disk, bdev_handle, holder);
+		ret = register_bdev(sb, sb_disk, bdev_file, holder);
 		mutex_unlock(&bch_register_lock);
 		/* blkdev_put() will be called in cached_dev_free() */
 		if (ret < 0)
 			goto out_free_sb;
 	} else {
 		/* blkdev_put() will be called in bch_cache_release() */
-		ret = register_cache(sb, sb_disk, bdev_handle, holder);
+		ret = register_cache(sb, sb_disk, bdev_file, holder);
 		if (ret)
 			goto out_free_sb;
 	}
@@ -2642,8 +2642,8 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 out_put_sb_page:
 	put_page(virt_to_page(sb_disk));
 out_blkdev_put:
-	if (bdev_handle)
-		bdev_release(bdev_handle);
+	if (bdev_file)
+		fput(bdev_file);
 out_free_sb:
 	kfree(sb);
 out_free_path:

-- 
2.43.0


