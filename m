Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5B97B005D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjI0JfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjI0Jet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:34:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B68FE6;
        Wed, 27 Sep 2023 02:34:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D18C1FD60;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QXXWYi/CugbgcY+nFXgCcA/0RERIVN8f9MFx70ClnXk=;
        b=gnBYYac82HKpajtThHIaHXfW4bakjFiyOwErQjTKjCEHqvOPndLSgQYx8nV4gJ855HhKKE
        nytqd14BgZEPENQ4nI9HDIbi1CQeavIYycf5lXEBUcFmihAhuRVUnNwuhVHyKLZ79jhLJu
        PJnrgLpWhtwXTf0cKBNWc2R8//uqOjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QXXWYi/CugbgcY+nFXgCcA/0RERIVN8f9MFx70ClnXk=;
        b=LPwdgOPeHvCjs5avAMu8UIMomqG03C9h7PPvKAjLAzlCJZb4H4f4A/Olc68kpR3jkNSAw7
        Ybv0T3hOOD8p/sDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A0931338F;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UvlMBjT3E2UTEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 25C8BA07D9; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-bcache@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>
Subject: [PATCH 09/29] bcache: Convert to bdev_open_by_path()
Date:   Wed, 27 Sep 2023 11:34:15 +0200
Message-Id: <20230927093442.25915-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8953; i=jack@suse.cz; h=from:subject; bh=KC1oQdUSqfPzXndrrRSwSHkWPzflpoKAqNs/klkwoNU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cYs8Q5I8rvLLCKSdt0VDIb4W0EXuEOn7PbBmUx 8z3MiW2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3GAAKCRCcnaoHP2RA2fOCCA DjkWjqYuTOrVeEcK1LObPvK5PHpVNCuBtBzr8TQXPBH+Bn0fEWu/A09+hRH3fHG24qPqHS32wGevrF JxSuzMFI+wG8OoVeTZDF2lfN7lTMVK2tGJFgYdqMOrs93PjV/DPlWpaFw9oFi6bV90OMh17psxfuel heEYJLnR4PxI8R/ZQlH+HM8xIM5oIfaZy4tRTeaSI/dLoLw1MKI74fBA9pG1paJ2YZ5/JvBNeIVwKy PWjSaiEu7VgQkv/nOTKs5PTmHjC274lbMsZQKo9eCEwnGTF3cV3sydJnSXXAo0AGKRcgHIq7gUzDcu wPRoB1EuCmkC/i/UYThw7m8Rz6ZM2f
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert bcache to use bdev_open_by_path() and pass the handle around.

CC: linux-bcache@vger.kernel.org
CC: Coly Li <colyli@suse.de
CC: Kent Overstreet <kent.overstreet@gmail.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: Coly Li <colyli@suse.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/md/bcache/bcache.h |  2 +
 drivers/md/bcache/super.c  | 78 ++++++++++++++++++++------------------
 2 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 5a79bb3c272f..2aa3f2c1f719 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -299,6 +299,7 @@ struct cached_dev {
 	struct list_head	list;
 	struct bcache_device	disk;
 	struct block_device	*bdev;
+	struct bdev_handle	*bdev_handle;
 
 	struct cache_sb		sb;
 	struct cache_sb_disk	*sb_disk;
@@ -421,6 +422,7 @@ struct cache {
 
 	struct kobject		kobj;
 	struct block_device	*bdev;
+	struct bdev_handle	*bdev_handle;
 
 	struct task_struct	*alloc_thread;
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 0ae2b3676293..c11ac86be72b 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1368,8 +1368,8 @@ static void cached_dev_free(struct closure *cl)
 	if (dc->sb_disk)
 		put_page(virt_to_page(dc->sb_disk));
 
-	if (!IS_ERR_OR_NULL(dc->bdev))
-		blkdev_put(dc->bdev, dc);
+	if (dc->bdev_handle)
+		bdev_release(dc->bdev_handle);
 
 	wake_up(&unregister_wait);
 
@@ -1444,7 +1444,7 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
 /* Cached device - bcache superblock */
 
 static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
-				 struct block_device *bdev,
+				 struct bdev_handle *bdev_handle,
 				 struct cached_dev *dc)
 {
 	const char *err = "cannot allocate memory";
@@ -1452,14 +1452,15 @@ static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 	int ret = -ENOMEM;
 
 	memcpy(&dc->sb, sb, sizeof(struct cache_sb));
-	dc->bdev = bdev;
+	dc->bdev_handle = bdev_handle;
+	dc->bdev = bdev_handle->bdev;
 	dc->sb_disk = sb_disk;
 
 	if (cached_dev_init(dc, sb->block_size << 9))
 		goto err;
 
 	err = "error creating kobject";
-	if (kobject_add(&dc->disk.kobj, bdev_kobj(bdev), "bcache"))
+	if (kobject_add(&dc->disk.kobj, bdev_kobj(dc->bdev), "bcache"))
 		goto err;
 	if (bch_cache_accounting_add_kobjs(&dc->accounting, &dc->disk.kobj))
 		goto err;
@@ -2216,8 +2217,8 @@ void bch_cache_release(struct kobject *kobj)
 	if (ca->sb_disk)
 		put_page(virt_to_page(ca->sb_disk));
 
-	if (!IS_ERR_OR_NULL(ca->bdev))
-		blkdev_put(ca->bdev, ca);
+	if (ca->bdev_handle)
+		bdev_release(ca->bdev_handle);
 
 	kfree(ca);
 	module_put(THIS_MODULE);
@@ -2337,16 +2338,18 @@ static int cache_alloc(struct cache *ca)
 }
 
 static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
-				struct block_device *bdev, struct cache *ca)
+				struct bdev_handle *bdev_handle,
+				struct cache *ca)
 {
 	const char *err = NULL; /* must be set for any error case */
 	int ret = 0;
 
 	memcpy(&ca->sb, sb, sizeof(struct cache_sb));
-	ca->bdev = bdev;
+	ca->bdev_handle = bdev_handle;
+	ca->bdev = bdev_handle->bdev;
 	ca->sb_disk = sb_disk;
 
-	if (bdev_max_discard_sectors((bdev)))
+	if (bdev_max_discard_sectors((bdev_handle->bdev)))
 		ca->discard = CACHE_DISCARD(&ca->sb);
 
 	ret = cache_alloc(ca);
@@ -2354,10 +2357,10 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 		/*
 		 * If we failed here, it means ca->kobj is not initialized yet,
 		 * kobject_put() won't be called and there is no chance to
-		 * call blkdev_put() to bdev in bch_cache_release(). So we
-		 * explicitly call blkdev_put() here.
+		 * call bdev_release() to bdev in bch_cache_release(). So
+		 * we explicitly call bdev_release() here.
 		 */
-		blkdev_put(bdev, ca);
+		bdev_release(bdev_handle);
 		if (ret == -ENOMEM)
 			err = "cache_alloc(): -ENOMEM";
 		else if (ret == -EPERM)
@@ -2367,7 +2370,7 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 		goto err;
 	}
 
-	if (kobject_add(&ca->kobj, bdev_kobj(bdev), "bcache")) {
+	if (kobject_add(&ca->kobj, bdev_kobj(bdev_handle->bdev), "bcache")) {
 		err = "error calling kobject_add";
 		ret = -ENOMEM;
 		goto out;
@@ -2382,14 +2385,14 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 		goto out;
 	}
 
-	pr_info("registered cache device %pg\n", ca->bdev);
+	pr_info("registered cache device %pg\n", ca->bdev_handle->bdev);
 
 out:
 	kobject_put(&ca->kobj);
 
 err:
 	if (err)
-		pr_notice("error %pg: %s\n", ca->bdev, err);
+		pr_notice("error %pg: %s\n", ca->bdev_handle->bdev, err);
 
 	return ret;
 }
@@ -2445,7 +2448,7 @@ struct async_reg_args {
 	char *path;
 	struct cache_sb *sb;
 	struct cache_sb_disk *sb_disk;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	void *holder;
 };
 
@@ -2456,8 +2459,8 @@ static void register_bdev_worker(struct work_struct *work)
 		container_of(work, struct async_reg_args, reg_work.work);
 
 	mutex_lock(&bch_register_lock);
-	if (register_bdev(args->sb, args->sb_disk, args->bdev, args->holder)
-	    < 0)
+	if (register_bdev(args->sb, args->sb_disk, args->bdev_handle,
+			  args->holder) < 0)
 		fail = true;
 	mutex_unlock(&bch_register_lock);
 
@@ -2477,7 +2480,8 @@ static void register_cache_worker(struct work_struct *work)
 		container_of(work, struct async_reg_args, reg_work.work);
 
 	/* blkdev_put() will be called in bch_cache_release() */
-	if (register_cache(args->sb, args->sb_disk, args->bdev, args->holder))
+	if (register_cache(args->sb, args->sb_disk, args->bdev_handle,
+			   args->holder))
 		fail = true;
 
 	if (fail)
@@ -2514,7 +2518,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	char *path = NULL;
 	struct cache_sb *sb;
 	struct cache_sb_disk *sb_disk;
-	struct block_device *bdev, *bdev2;
+	struct bdev_handle *bdev_handle, *bdev_handle2;
 	void *holder = NULL;
 	ssize_t ret;
 	bool async_registration = false;
@@ -2547,15 +2551,15 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 
 	ret = -EINVAL;
 	err = "failed to open device";
-	bdev = blkdev_get_by_path(strim(path), BLK_OPEN_READ, NULL, NULL);
-	if (IS_ERR(bdev))
+	bdev_handle = bdev_open_by_path(strim(path), BLK_OPEN_READ, NULL, NULL);
+	if (IS_ERR(bdev_handle))
 		goto out_free_sb;
 
 	err = "failed to set blocksize";
-	if (set_blocksize(bdev, 4096))
+	if (set_blocksize(bdev_handle->bdev, 4096))
 		goto out_blkdev_put;
 
-	err = read_super(sb, bdev, &sb_disk);
+	err = read_super(sb, bdev_handle->bdev, &sb_disk);
 	if (err)
 		goto out_blkdev_put;
 
@@ -2567,13 +2571,13 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	}
 
 	/* Now reopen in exclusive mode with proper holder */
-	bdev2 = blkdev_get_by_dev(bdev->bd_dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
-				  holder, NULL);
-	blkdev_put(bdev, NULL);
-	bdev = bdev2;
-	if (IS_ERR(bdev)) {
-		ret = PTR_ERR(bdev);
-		bdev = NULL;
+	bdev_handle2 = bdev_open_by_dev(bdev_handle->bdev->bd_dev,
+			BLK_OPEN_READ | BLK_OPEN_WRITE, holder, NULL);
+	bdev_release(bdev_handle);
+	bdev_handle = bdev_handle2;
+	if (IS_ERR(bdev_handle)) {
+		ret = PTR_ERR(bdev_handle);
+		bdev_handle = NULL;
 		if (ret == -EBUSY) {
 			dev_t dev;
 
@@ -2608,7 +2612,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 		args->path	= path;
 		args->sb	= sb;
 		args->sb_disk	= sb_disk;
-		args->bdev	= bdev;
+		args->bdev_handle	= bdev_handle;
 		args->holder	= holder;
 		register_device_async(args);
 		/* No wait and returns to user space */
@@ -2617,14 +2621,14 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 
 	if (SB_IS_BDEV(sb)) {
 		mutex_lock(&bch_register_lock);
-		ret = register_bdev(sb, sb_disk, bdev, holder);
+		ret = register_bdev(sb, sb_disk, bdev_handle, holder);
 		mutex_unlock(&bch_register_lock);
 		/* blkdev_put() will be called in cached_dev_free() */
 		if (ret < 0)
 			goto out_free_sb;
 	} else {
 		/* blkdev_put() will be called in bch_cache_release() */
-		ret = register_cache(sb, sb_disk, bdev, holder);
+		ret = register_cache(sb, sb_disk, bdev_handle, holder);
 		if (ret)
 			goto out_free_sb;
 	}
@@ -2640,8 +2644,8 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 out_put_sb_page:
 	put_page(virt_to_page(sb_disk));
 out_blkdev_put:
-	if (bdev)
-		blkdev_put(bdev, holder);
+	if (bdev_handle)
+		bdev_release(bdev_handle);
 out_free_sb:
 	kfree(sb);
 out_free_path:
-- 
2.35.3

