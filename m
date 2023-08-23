Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A85785638
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjHWKu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjHWKuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:50:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0420E7C;
        Wed, 23 Aug 2023 03:49:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8DC321F4A;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tnJLH+Bt8+gCmYzpQyIDbcgmN9zx4njPgoMK7Z76VCM=;
        b=Lf3fGSZ6HuNxEO4vvXk3+A3/fYUgHWEloT8G4qddjQzaiuLvNOR4uCaIzIrjsA9GDFM6Sa
        vAzQ/5OpHRuBPXwFxGTAL3bFsINnyB1r0RrU+KrdaPN5xotxva4+iRBSYJ49CkyfWEog1X
        CLvy9i+K6hU9o+iUlnCTsPS4oIK5ypI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tnJLH+Bt8+gCmYzpQyIDbcgmN9zx4njPgoMK7Z76VCM=;
        b=jmyOW+Mg9bSiYynl7+ZoIXADpXF567jT4YdFFptYN/LQY4XpeXDYYQJN1d4vEno9SsIGYt
        6ZOgTCxk3pv08xDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3CC413A1B;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MFsnMxrk5WRWIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7CF75A0796; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 20/29] btrfs: Convert to bdev_open_by_path()
Date:   Wed, 23 Aug 2023 12:48:31 +0200
Message-Id: <20230823104857.11437-20-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16691; i=jack@suse.cz; h=from:subject; bh=8ZCF8MRl0DvMKekoyxZXeZG8/TJG3dOn3Qg5luwR2e4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5eP/2XJt9XwxFj6rvuJzZnJ/e+3VH8bLhPjr3Zg7 gHlT2ruJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj/wAKCRCcnaoHP2RA2brOCA Ci5LG/u0ZQhetYrg46DD59U2zhbO+4msdsLokvokt5Ds1yq2dzOzJnT8RFWLcjMyOfV93ETcfOhySy /kCxA4nrYNvHVrvzCUJIpuMPcdL4+l98/9fHkChhwBCLhdlmFwGNUW9cn/ckAXA1NrhfI1jbqoVwe0 wys2zFcultBbJidqy+ALgdnWMDXtyiEeXdRl+aili/mK0JW6E7dduez83LlwOnOAdlODrl7Q7ed/36 MC6OVFAKnFT5h2Qa46tC1CawIwQqRsfBsQ8WNSmZxpsRVb9ZaSdilysazlHdpYN/hdnq6IHWdnN8BO KLyXwlvDM8X32ZPrJtYwIAgUOR2s5v
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert btrfs to use bdev_open_by_path() and pass the handle around.  We
also drop the holder from struct btrfs_device as it is now not needed
anymore.

CC: David Sterba <dsterba@suse.com>
CC: linux-btrfs@vger.kernel.org
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/btrfs/dev-replace.c |  14 +++---
 fs/btrfs/ioctl.c       |  18 +++----
 fs/btrfs/volumes.c     | 107 +++++++++++++++++++++--------------------
 fs/btrfs/volumes.h     |   6 +--
 4 files changed, 73 insertions(+), 72 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 5f10965fd72b..fec013c5f26c 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -247,6 +247,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
+	struct bdev_handle *bdev_handle;
 	struct block_device *bdev;
 	u64 devid = BTRFS_DEV_REPLACE_DEVID;
 	int ret = 0;
@@ -257,12 +258,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 		return -EINVAL;
 	}
 
-	bdev = blkdev_get_by_path(device_path, BLK_OPEN_WRITE,
-				  fs_info->bdev_holder, NULL);
-	if (IS_ERR(bdev)) {
+	bdev_handle = bdev_open_by_path(device_path, BLK_OPEN_WRITE,
+					fs_info->bdev_holder, NULL);
+	if (IS_ERR(bdev_handle)) {
 		btrfs_err(fs_info, "target device %s is invalid!", device_path);
-		return PTR_ERR(bdev);
+		return PTR_ERR(bdev_handle);
 	}
+	bdev = bdev_handle->bdev;
 
 	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
 		btrfs_err(fs_info,
@@ -313,9 +315,9 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	device->commit_bytes_used = device->bytes_used;
 	device->fs_info = fs_info;
 	device->bdev = bdev;
+	device->bdev_handle = bdev_handle;
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	set_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
-	device->holder = fs_info->bdev_holder;
 	device->dev_stats_valid = 1;
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 	device->fs_devices = fs_devices;
@@ -334,7 +336,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	return 0;
 
 error:
-	blkdev_put(bdev, fs_info->bdev_holder);
+	bdev_release(bdev_handle);
 	return ret;
 }
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a18ee7b5a166..b4074191fcc7 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2670,8 +2670,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args_v2 *vol_args;
-	struct block_device *bdev = NULL;
-	void *holder;
+	struct bdev_handle *bdev_handle = NULL;
 	int ret;
 	bool cancel = false;
 
@@ -2708,7 +2707,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 		goto err_drop;
 
 	/* Exclusive operation is now claimed */
-	ret = btrfs_rm_device(fs_info, &args, &bdev, &holder);
+	ret = btrfs_rm_device(fs_info, &args, &bdev_handle);
 
 	btrfs_exclop_finish(fs_info);
 
@@ -2722,8 +2721,8 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	}
 err_drop:
 	mnt_drop_write_file(file);
-	if (bdev)
-		blkdev_put(bdev, holder);
+	if (bdev_handle)
+		bdev_release(bdev_handle);
 out:
 	btrfs_put_dev_args_from_path(&args);
 	kfree(vol_args);
@@ -2736,8 +2735,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args *vol_args;
-	struct block_device *bdev = NULL;
-	void *holder;
+	struct bdev_handle *bdev_handle = NULL;
 	int ret;
 	bool cancel = false;
 
@@ -2764,15 +2762,15 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
 					   cancel);
 	if (ret == 0) {
-		ret = btrfs_rm_device(fs_info, &args, &bdev, &holder);
+		ret = btrfs_rm_device(fs_info, &args, &bdev_handle);
 		if (!ret)
 			btrfs_info(fs_info, "disk deleted %s", vol_args->name);
 		btrfs_exclop_finish(fs_info);
 	}
 
 	mnt_drop_write_file(file);
-	if (bdev)
-		blkdev_put(bdev, holder);
+	if (bdev_handle)
+		bdev_release(bdev_handle);
 out:
 	btrfs_put_dev_args_from_path(&args);
 	kfree(vol_args);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fc1bd0b03d63..9c4b5b825b5c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -512,37 +512,39 @@ static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
 
 static int
 btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
-		      int flush, struct block_device **bdev,
+		      int flush, struct bdev_handle **bdev_handle,
 		      struct btrfs_super_block **disk_super)
 {
+	struct block_device *bdev;
 	int ret;
 
-	*bdev = blkdev_get_by_path(device_path, flags, holder, NULL);
+	*bdev_handle = bdev_open_by_path(device_path, flags, holder, NULL);
 
-	if (IS_ERR(*bdev)) {
-		ret = PTR_ERR(*bdev);
+	if (IS_ERR(*bdev_handle)) {
+		ret = PTR_ERR(*bdev_handle);
 		goto error;
 	}
+	bdev = (*bdev_handle)->bdev;
 
 	if (flush)
-		sync_blockdev(*bdev);
-	ret = set_blocksize(*bdev, BTRFS_BDEV_BLOCKSIZE);
+		sync_blockdev(bdev);
+	ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
 	if (ret) {
-		blkdev_put(*bdev, holder);
+		bdev_release(*bdev_handle);
 		goto error;
 	}
-	invalidate_bdev(*bdev);
-	*disk_super = btrfs_read_dev_super(*bdev);
+	invalidate_bdev(bdev);
+	*disk_super = btrfs_read_dev_super(bdev);
 	if (IS_ERR(*disk_super)) {
 		ret = PTR_ERR(*disk_super);
-		blkdev_put(*bdev, holder);
+		bdev_release(*bdev_handle);
 		goto error;
 	}
 
 	return 0;
 
 error:
-	*bdev = NULL;
+	*bdev_handle = NULL;
 	return ret;
 }
 
@@ -614,7 +616,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 			struct btrfs_device *device, blk_mode_t flags,
 			void *holder)
 {
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	struct btrfs_super_block *disk_super;
 	u64 devid;
 	int ret;
@@ -625,7 +627,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		return -EINVAL;
 
 	ret = btrfs_get_bdev_and_sb(device->name->str, flags, holder, 1,
-				    &bdev, &disk_super);
+				    &bdev_handle, &disk_super);
 	if (ret)
 		return ret;
 
@@ -649,21 +651,21 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 		fs_devices->seeding = true;
 	} else {
-		if (bdev_read_only(bdev))
+		if (bdev_read_only(bdev_handle->bdev))
 			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 		else
 			set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 	}
 
-	if (!bdev_nonrot(bdev))
+	if (!bdev_nonrot(bdev_handle->bdev))
 		fs_devices->rotating = true;
 
-	if (bdev_max_discard_sectors(bdev))
+	if (bdev_max_discard_sectors(bdev_handle->bdev))
 		fs_devices->discardable = true;
 
-	device->bdev = bdev;
+	device->bdev_handle = bdev_handle;
+	device->bdev = bdev_handle->bdev;
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
-	device->holder = holder;
 
 	fs_devices->open_devices++;
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
@@ -677,7 +679,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 
 error_free_page:
 	btrfs_release_disk_super(disk_super);
-	blkdev_put(bdev, holder);
+	bdev_release(bdev_handle);
 
 	return -EINVAL;
 }
@@ -1067,9 +1069,10 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
 		if (device->devid == BTRFS_DEV_REPLACE_DEVID)
 			continue;
 
-		if (device->bdev) {
-			blkdev_put(device->bdev, device->holder);
+		if (device->bdev_handle) {
+			bdev_release(device->bdev_handle);
 			device->bdev = NULL;
+			device->bdev_handle = NULL;
 			fs_devices->open_devices--;
 		}
 		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
@@ -1114,7 +1117,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
 		invalidate_bdev(device->bdev);
 	}
 
-	blkdev_put(device->bdev, device->holder);
+	bdev_release(device->bdev_handle);
 }
 
 static void btrfs_close_one_device(struct btrfs_device *device)
@@ -1359,7 +1362,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path)
 	struct btrfs_super_block *disk_super;
 	bool new_device_added = false;
 	struct btrfs_device *device = NULL;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	u64 bytenr, bytenr_orig;
 	int ret;
 
@@ -1382,18 +1385,19 @@ struct btrfs_device *btrfs_scan_one_device(const char *path)
 	 * values temporarily, as the device paths of the fsid are the only
 	 * required information for assembling the volume.
 	 */
-	bdev = blkdev_get_by_path(path, BLK_OPEN_READ, NULL, NULL);
-	if (IS_ERR(bdev))
-		return ERR_CAST(bdev);
+	bdev_handle = bdev_open_by_path(path, BLK_OPEN_READ, NULL, NULL);
+	if (IS_ERR(bdev_handle))
+		return ERR_CAST(bdev_handle);
 
 	bytenr_orig = btrfs_sb_offset(0);
-	ret = btrfs_sb_log_location_bdev(bdev, 0, READ, &bytenr);
+	ret = btrfs_sb_log_location_bdev(bdev_handle->bdev, 0, READ, &bytenr);
 	if (ret) {
 		device = ERR_PTR(ret);
 		goto error_bdev_put;
 	}
 
-	disk_super = btrfs_read_disk_super(bdev, bytenr, bytenr_orig);
+	disk_super = btrfs_read_disk_super(bdev_handle->bdev, bytenr,
+					   bytenr_orig);
 	if (IS_ERR(disk_super)) {
 		device = ERR_CAST(disk_super);
 		goto error_bdev_put;
@@ -1406,7 +1410,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path)
 	btrfs_release_disk_super(disk_super);
 
 error_bdev_put:
-	blkdev_put(bdev, NULL);
+	bdev_release(bdev_handle);
 
 	return device;
 }
@@ -2091,7 +2095,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		    struct btrfs_dev_lookup_args *args,
-		    struct block_device **bdev, void **holder)
+		    struct bdev_handle **bdev_handle)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_device *device;
@@ -2200,7 +2204,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 
 	btrfs_assign_next_active_device(device, NULL);
 
-	if (device->bdev) {
+	if (device->bdev_handle) {
 		cur_devices->open_devices--;
 		/* remove sysfs entry */
 		btrfs_sysfs_remove_device(device);
@@ -2216,9 +2220,9 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	 * free the device.
 	 *
 	 * We cannot call btrfs_close_bdev() here because we're holding the sb
-	 * write lock, and blkdev_put() will pull in the ->open_mutex on the
-	 * block device and it's dependencies.  Instead just flush the device
-	 * and let the caller do the final blkdev_put.
+	 * write lock, and bdev_release() will pull in the ->open_mutex on
+	 * the block device and it's dependencies.  Instead just flush the
+	 * device and let the caller do the final bdev_release.
 	 */
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 		btrfs_scratch_superblocks(fs_info, device->bdev,
@@ -2229,8 +2233,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	*bdev = device->bdev;
-	*holder = device->holder;
+	*bdev_handle = device->bdev_handle;
 	synchronize_rcu();
 	btrfs_free_device(device);
 
@@ -2368,7 +2371,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 				 const char *path)
 {
 	struct btrfs_super_block *disk_super;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	int ret;
 
 	if (!path || !path[0])
@@ -2386,7 +2389,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 	}
 
 	ret = btrfs_get_bdev_and_sb(path, BLK_OPEN_READ, NULL, 0,
-				    &bdev, &disk_super);
+				    &bdev_handle, &disk_super);
 	if (ret) {
 		btrfs_put_dev_args_from_path(args);
 		return ret;
@@ -2399,7 +2402,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 	else
 		memcpy(args->fsid, disk_super->fsid, BTRFS_FSID_SIZE);
 	btrfs_release_disk_super(disk_super);
-	blkdev_put(bdev, NULL);
+	bdev_release(bdev_handle);
 	return 0;
 }
 
@@ -2620,7 +2623,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct btrfs_root *root = fs_info->dev_root;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_device *device;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	struct super_block *sb = fs_info->sb;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_fs_devices *seed_devices = NULL;
@@ -2633,12 +2636,12 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
 
-	bdev = blkdev_get_by_path(device_path, BLK_OPEN_WRITE,
-				  fs_info->bdev_holder, NULL);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
+	bdev_handle = bdev_open_by_path(device_path, BLK_OPEN_WRITE,
+					fs_info->bdev_holder, NULL);
+	if (IS_ERR(bdev_handle))
+		return PTR_ERR(bdev_handle);
 
-	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
+	if (!btrfs_check_device_zone_type(fs_info, bdev_handle->bdev)) {
 		ret = -EINVAL;
 		goto error;
 	}
@@ -2650,11 +2653,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		locked = true;
 	}
 
-	sync_blockdev(bdev);
+	sync_blockdev(bdev_handle->bdev);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
-		if (device->bdev == bdev) {
+		if (device->bdev == bdev_handle->bdev) {
 			ret = -EEXIST;
 			rcu_read_unlock();
 			goto error;
@@ -2670,7 +2673,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	}
 
 	device->fs_info = fs_info;
-	device->bdev = bdev;
+	device->bdev_handle = bdev_handle;
+	device->bdev = bdev_handle->bdev;
 	ret = lookup_bdev(device_path, &device->devt);
 	if (ret)
 		goto error_free_device;
@@ -2691,12 +2695,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	device->io_align = fs_info->sectorsize;
 	device->sector_size = fs_info->sectorsize;
 	device->total_bytes =
-		round_down(bdev_nr_bytes(bdev), fs_info->sectorsize);
+		round_down(bdev_nr_bytes(device->bdev), fs_info->sectorsize);
 	device->disk_total_bytes = device->total_bytes;
 	device->commit_total_bytes = device->total_bytes;
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
-	device->holder = fs_info->bdev_holder;
 	device->dev_stats_valid = 1;
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 
@@ -2732,7 +2735,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
 
-	if (!bdev_nonrot(bdev))
+	if (!bdev_nonrot(device->bdev))
 		fs_devices->rotating = true;
 
 	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
@@ -2854,7 +2857,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 error_free_device:
 	btrfs_free_device(device);
 error:
-	blkdev_put(bdev, fs_info->bdev_holder);
+	bdev_release(bdev_handle);
 	if (locked) {
 		mutex_unlock(&uuid_mutex);
 		up_write(&sb->s_umount);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f472d646715e..d92ebeaf1200 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -90,13 +90,11 @@ struct btrfs_device {
 
 	u64 generation;
 
+	struct bdev_handle *bdev_handle;
 	struct block_device *bdev;
 
 	struct btrfs_zoned_device_info *zone_info;
 
-	/* block device holder for blkdev_get/put */
-	void *holder;
-
 	/*
 	 * Device's major-minor number. Must be set even if the device is not
 	 * opened (bdev == NULL), unless the device is missing.
@@ -631,7 +629,7 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args);
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		    struct btrfs_dev_lookup_args *args,
-		    struct block_device **bdev, void **holder);
+		    struct bdev_handle **bdev_handle);
 void __exit btrfs_cleanup_fs_uuids(void);
 int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
 int btrfs_grow_device(struct btrfs_trans_handle *trans,
-- 
2.35.3

