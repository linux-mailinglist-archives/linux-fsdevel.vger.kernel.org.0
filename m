Return-Path: <linux-fsdevel+bounces-7194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED87822DB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F4B22123
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878B51947D;
	Wed,  3 Jan 2024 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SK5ru5pG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11FF19472;
	Wed,  3 Jan 2024 12:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228E1C433C7;
	Wed,  3 Jan 2024 12:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286555;
	bh=SB7+ux+/SnqsQ3wYEQi/h04VDB+2G1xzuBQj59RBeRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SK5ru5pGhKN0Lf/Nisib+jfJcL61Ow8czGyaMmdvoxcrL8ZPLEIZzg5mqiiZ8YM8b
	 N/7tO8Qyd0lJIWbm7K/Ou/aVxCG659OuKfy0PN84u7VpUsT3Sw6wjPgSC03SDFKGd1
	 hJYNGI/VIgksi6hPdBANs38HVqedVLnjoWD/Uum56yIt6Hn7/ggxaGi+6KvkRMJd8Y
	 4IMqDCNAXE2QzM8lbEj+WZk3kDDzfp9z7VT1i+5wI5U15gMvOCex36BTbVW37CmazH
	 RM7jFZPtp7lb9ZUvGtHqOIsnVVNrdA8DhoGQgS0mf36uGJMH4JwPh02a270Lxysf6c
	 eMr2stGZat24A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:11 +0100
Subject: [PATCH RFC 13/34] bcache: port block device access to files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-13-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=8318; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SB7+ux+/SnqsQ3wYEQi/h04VDB+2G1xzuBQj59RBeRI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbRpyZv+SiH2+kT1JydcG+c7Os9+8/5G/SwlP7EHe
 25m/Ghc1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARBVaG/zl/n3uf+HPGq8lX
 WTyBY9Vrxm+7X0zwtq45Ic/ux5C+dQIjw4WSKOsff94lbrzouay/+FBHe9nWu9uD7sqVpSUdK85
 pYwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/md/bcache/bcache.h |  4 +--
 drivers/md/bcache/super.c  | 74 +++++++++++++++++++++++-----------------------
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 6ae2329052c9..f1579b0acd8d 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -300,7 +300,7 @@ struct cached_dev {
 	struct list_head	list;
 	struct bcache_device	disk;
 	struct block_device	*bdev;
-	struct bdev_handle	*bdev_handle;
+	struct file		*f_bdev;
 
 	struct cache_sb		sb;
 	struct cache_sb_disk	*sb_disk;
@@ -423,7 +423,7 @@ struct cache {
 
 	struct kobject		kobj;
 	struct block_device	*bdev;
-	struct bdev_handle	*bdev_handle;
+	struct file		*f_bdev;
 
 	struct task_struct	*alloc_thread;
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 1402096b8076..8f7ed34ba1c8 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1370,8 +1370,8 @@ static CLOSURE_CALLBACK(cached_dev_free)
 	if (dc->sb_disk)
 		put_page(virt_to_page(dc->sb_disk));
 
-	if (dc->bdev_handle)
-		bdev_release(dc->bdev_handle);
+	if (dc->f_bdev)
+		fput(dc->f_bdev);
 
 	wake_up(&unregister_wait);
 
@@ -1446,7 +1446,7 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
 /* Cached device - bcache superblock */
 
 static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
-				 struct bdev_handle *bdev_handle,
+				 struct file *f_bdev,
 				 struct cached_dev *dc)
 {
 	const char *err = "cannot allocate memory";
@@ -1454,8 +1454,8 @@ static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 	int ret = -ENOMEM;
 
 	memcpy(&dc->sb, sb, sizeof(struct cache_sb));
-	dc->bdev_handle = bdev_handle;
-	dc->bdev = bdev_handle->bdev;
+	dc->f_bdev = f_bdev;
+	dc->bdev = F_BDEV(f_bdev);
 	dc->sb_disk = sb_disk;
 
 	if (cached_dev_init(dc, sb->block_size << 9))
@@ -2219,8 +2219,8 @@ void bch_cache_release(struct kobject *kobj)
 	if (ca->sb_disk)
 		put_page(virt_to_page(ca->sb_disk));
 
-	if (ca->bdev_handle)
-		bdev_release(ca->bdev_handle);
+	if (ca->f_bdev)
+		fput(ca->f_bdev);
 
 	kfree(ca);
 	module_put(THIS_MODULE);
@@ -2340,18 +2340,18 @@ static int cache_alloc(struct cache *ca)
 }
 
 static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
-				struct bdev_handle *bdev_handle,
+				struct file *f_bdev,
 				struct cache *ca)
 {
 	const char *err = NULL; /* must be set for any error case */
 	int ret = 0;
 
 	memcpy(&ca->sb, sb, sizeof(struct cache_sb));
-	ca->bdev_handle = bdev_handle;
-	ca->bdev = bdev_handle->bdev;
+	ca->f_bdev = f_bdev;
+	ca->bdev = F_BDEV(f_bdev);
 	ca->sb_disk = sb_disk;
 
-	if (bdev_max_discard_sectors((bdev_handle->bdev)))
+	if (bdev_max_discard_sectors(F_BDEV(f_bdev)))
 		ca->discard = CACHE_DISCARD(&ca->sb);
 
 	ret = cache_alloc(ca);
@@ -2362,20 +2362,20 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 			err = "cache_alloc(): cache device is too small";
 		else
 			err = "cache_alloc(): unknown error";
-		pr_notice("error %pg: %s\n", bdev_handle->bdev, err);
+		pr_notice("error %pg: %s\n", F_BDEV(f_bdev), err);
 		/*
 		 * If we failed here, it means ca->kobj is not initialized yet,
 		 * kobject_put() won't be called and there is no chance to
-		 * call bdev_release() to bdev in bch_cache_release(). So
-		 * we explicitly call bdev_release() here.
+		 * call fput() to bdev in bch_cache_release(). So
+		 * we explicitly call fput() on the block device here.
 		 */
-		bdev_release(bdev_handle);
+		fput(f_bdev);
 		return ret;
 	}
 
-	if (kobject_add(&ca->kobj, bdev_kobj(bdev_handle->bdev), "bcache")) {
+	if (kobject_add(&ca->kobj, bdev_kobj(F_BDEV(f_bdev)), "bcache")) {
 		pr_notice("error %pg: error calling kobject_add\n",
-			  bdev_handle->bdev);
+			  F_BDEV(f_bdev));
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -2389,7 +2389,7 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 		goto out;
 	}
 
-	pr_info("registered cache device %pg\n", ca->bdev_handle->bdev);
+	pr_info("registered cache device %pg\n", F_BDEV(ca->f_bdev));
 
 out:
 	kobject_put(&ca->kobj);
@@ -2447,7 +2447,7 @@ struct async_reg_args {
 	char *path;
 	struct cache_sb *sb;
 	struct cache_sb_disk *sb_disk;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	void *holder;
 };
 
@@ -2458,7 +2458,7 @@ static void register_bdev_worker(struct work_struct *work)
 		container_of(work, struct async_reg_args, reg_work.work);
 
 	mutex_lock(&bch_register_lock);
-	if (register_bdev(args->sb, args->sb_disk, args->bdev_handle,
+	if (register_bdev(args->sb, args->sb_disk, args->f_bdev,
 			  args->holder) < 0)
 		fail = true;
 	mutex_unlock(&bch_register_lock);
@@ -2479,7 +2479,7 @@ static void register_cache_worker(struct work_struct *work)
 		container_of(work, struct async_reg_args, reg_work.work);
 
 	/* blkdev_put() will be called in bch_cache_release() */
-	if (register_cache(args->sb, args->sb_disk, args->bdev_handle,
+	if (register_cache(args->sb, args->sb_disk, args->f_bdev,
 			   args->holder))
 		fail = true;
 
@@ -2517,7 +2517,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	char *path = NULL;
 	struct cache_sb *sb;
 	struct cache_sb_disk *sb_disk;
-	struct bdev_handle *bdev_handle, *bdev_handle2;
+	struct file *f_bdev, *f_bdev2;
 	void *holder = NULL;
 	ssize_t ret;
 	bool async_registration = false;
@@ -2550,15 +2550,15 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 
 	ret = -EINVAL;
 	err = "failed to open device";
-	bdev_handle = bdev_open_by_path(strim(path), BLK_OPEN_READ, NULL, NULL);
-	if (IS_ERR(bdev_handle))
+	f_bdev = bdev_file_open_by_path(strim(path), BLK_OPEN_READ, NULL, NULL);
+	if (IS_ERR(f_bdev))
 		goto out_free_sb;
 
 	err = "failed to set blocksize";
-	if (set_blocksize(bdev_handle->bdev, 4096))
+	if (set_blocksize(F_BDEV(f_bdev), 4096))
 		goto out_blkdev_put;
 
-	err = read_super(sb, bdev_handle->bdev, &sb_disk);
+	err = read_super(sb, F_BDEV(f_bdev), &sb_disk);
 	if (err)
 		goto out_blkdev_put;
 
@@ -2570,13 +2570,13 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	}
 
 	/* Now reopen in exclusive mode with proper holder */
-	bdev_handle2 = bdev_open_by_dev(bdev_handle->bdev->bd_dev,
+	f_bdev2 = bdev_file_open_by_dev(F_BDEV(f_bdev)->bd_dev,
 			BLK_OPEN_READ | BLK_OPEN_WRITE, holder, NULL);
-	bdev_release(bdev_handle);
-	bdev_handle = bdev_handle2;
-	if (IS_ERR(bdev_handle)) {
-		ret = PTR_ERR(bdev_handle);
-		bdev_handle = NULL;
+	fput(f_bdev);
+	f_bdev = f_bdev2;
+	if (IS_ERR(f_bdev)) {
+		ret = PTR_ERR(f_bdev);
+		f_bdev = NULL;
 		if (ret == -EBUSY) {
 			dev_t dev;
 
@@ -2611,7 +2611,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 		args->path	= path;
 		args->sb	= sb;
 		args->sb_disk	= sb_disk;
-		args->bdev_handle	= bdev_handle;
+		args->f_bdev	= f_bdev;
 		args->holder	= holder;
 		register_device_async(args);
 		/* No wait and returns to user space */
@@ -2620,14 +2620,14 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 
 	if (SB_IS_BDEV(sb)) {
 		mutex_lock(&bch_register_lock);
-		ret = register_bdev(sb, sb_disk, bdev_handle, holder);
+		ret = register_bdev(sb, sb_disk, f_bdev, holder);
 		mutex_unlock(&bch_register_lock);
 		/* blkdev_put() will be called in cached_dev_free() */
 		if (ret < 0)
 			goto out_free_sb;
 	} else {
 		/* blkdev_put() will be called in bch_cache_release() */
-		ret = register_cache(sb, sb_disk, bdev_handle, holder);
+		ret = register_cache(sb, sb_disk, f_bdev, holder);
 		if (ret)
 			goto out_free_sb;
 	}
@@ -2643,8 +2643,8 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 out_put_sb_page:
 	put_page(virt_to_page(sb_disk));
 out_blkdev_put:
-	if (bdev_handle)
-		bdev_release(bdev_handle);
+	if (f_bdev)
+		fput(f_bdev);
 out_free_sb:
 	kfree(sb);
 out_free_path:

-- 
2.42.0


