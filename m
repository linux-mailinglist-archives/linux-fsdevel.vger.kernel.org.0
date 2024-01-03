Return-Path: <linux-fsdevel+bounces-7200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C824822DC1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137291C2348E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BACE1B278;
	Wed,  3 Jan 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpbyKaKz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052C1B274;
	Wed,  3 Jan 2024 12:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73E2C433C8;
	Wed,  3 Jan 2024 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286568;
	bh=0scOEoK8nI/0sgEwQ10FnDv3pe9VS6iqwfSWS4IvgXI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VpbyKaKzx3UZa5/9KMBL/QSaSl9mhLoNQ9/UmOiMKj699yZsEYVBk1k3o8wWmua03
	 6sFy4QSTkOqqPGxyvbG8OyOBMrJEli6LWXpupoouHt6NBUE1iCvs5LcwtEetuXX6xB
	 5jPN+p6+u/KcislYOFNT611vay2sJiOVml10H0/S0RnRD9f0mgppxJrJrRjQmYbBUC
	 gXyHrLAoymDDy1AJCXOIQ21JBO3vGGs3b5Uj4iyZGlw0Q8dRzSiXli/Th0oSU0ad5Y
	 uLHlbJc235tXGHRsDYxZAFqDMNgGqVaHA0vZcXFRuPzaQ8F7ZT6GeZM9R7k5gGXNkM
	 NlxIFe90Y8vOw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:17 +0100
Subject: [PATCH RFC 19/34] btrfs: port device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-19-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=14776; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0scOEoK8nI/0sgEwQ10FnDv3pe9VS6iqwfSWS4IvgXI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbR9OXX+se4q+ecz91XIHvpss6bJMK0t+cPOq7MqJ
 /bmvkmW7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIxCyG/6W3982QvPLBpOSB
 yOIb4qJlsVWWH+z1W0Kl+353yqRN2sTwz7Rvzsc1JgaiIa/EdE0ONC+d5XjaZnp2QcT0dQ6bout
 q+AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/btrfs/dev-replace.c | 14 ++++----
 fs/btrfs/ioctl.c       | 16 ++++-----
 fs/btrfs/volumes.c     | 92 +++++++++++++++++++++++++-------------------------
 fs/btrfs/volumes.h     |  4 +--
 4 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f9544fda38e9..74d171f91369 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -246,7 +246,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	struct block_device *bdev;
 	u64 devid = BTRFS_DEV_REPLACE_DEVID;
 	int ret = 0;
@@ -257,13 +257,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 		return -EINVAL;
 	}
 
-	bdev_handle = bdev_open_by_path(device_path, BLK_OPEN_WRITE,
+	f_bdev = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
 					fs_info->bdev_holder, NULL);
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(f_bdev)) {
 		btrfs_err(fs_info, "target device %s is invalid!", device_path);
-		return PTR_ERR(bdev_handle);
+		return PTR_ERR(f_bdev);
 	}
-	bdev = bdev_handle->bdev;
+	bdev = F_BDEV(f_bdev);
 
 	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
 		btrfs_err(fs_info,
@@ -314,7 +314,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	device->commit_bytes_used = device->bytes_used;
 	device->fs_info = fs_info;
 	device->bdev = bdev;
-	device->bdev_handle = bdev_handle;
+	device->f_bdev = f_bdev;
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	set_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
 	device->dev_stats_valid = 1;
@@ -335,7 +335,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	return 0;
 
 error:
-	bdev_release(bdev_handle);
+	fput(f_bdev);
 	return ret;
 }
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 41b479861b3c..2bd9e137661a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2691,7 +2691,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args_v2 *vol_args;
-	struct bdev_handle *bdev_handle = NULL;
+	struct file *f_bdev = NULL;
 	int ret;
 	bool cancel = false;
 
@@ -2728,7 +2728,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 		goto err_drop;
 
 	/* Exclusive operation is now claimed */
-	ret = btrfs_rm_device(fs_info, &args, &bdev_handle);
+	ret = btrfs_rm_device(fs_info, &args, &f_bdev);
 
 	btrfs_exclop_finish(fs_info);
 
@@ -2742,8 +2742,8 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	}
 err_drop:
 	mnt_drop_write_file(file);
-	if (bdev_handle)
-		bdev_release(bdev_handle);
+	if (f_bdev)
+		fput(f_bdev);
 out:
 	btrfs_put_dev_args_from_path(&args);
 	kfree(vol_args);
@@ -2756,7 +2756,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args *vol_args;
-	struct bdev_handle *bdev_handle = NULL;
+	struct file *f_bdev = NULL;
 	int ret;
 	bool cancel = false;
 
@@ -2783,15 +2783,15 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
 					   cancel);
 	if (ret == 0) {
-		ret = btrfs_rm_device(fs_info, &args, &bdev_handle);
+		ret = btrfs_rm_device(fs_info, &args, &f_bdev);
 		if (!ret)
 			btrfs_info(fs_info, "disk deleted %s", vol_args->name);
 		btrfs_exclop_finish(fs_info);
 	}
 
 	mnt_drop_write_file(file);
-	if (bdev_handle)
-		bdev_release(bdev_handle);
+	if (f_bdev)
+		fput(f_bdev);
 out:
 	btrfs_put_dev_args_from_path(&args);
 	kfree(vol_args);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f627674b37db..0295731d0b76 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -457,39 +457,39 @@ static noinline struct btrfs_fs_devices *find_fsid(
 
 static int
 btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
-		      int flush, struct bdev_handle **bdev_handle,
+		      int flush, struct file **f_bdev,
 		      struct btrfs_super_block **disk_super)
 {
 	struct block_device *bdev;
 	int ret;
 
-	*bdev_handle = bdev_open_by_path(device_path, flags, holder, NULL);
+	*f_bdev = bdev_file_open_by_path(device_path, flags, holder, NULL);
 
-	if (IS_ERR(*bdev_handle)) {
-		ret = PTR_ERR(*bdev_handle);
+	if (IS_ERR(*f_bdev)) {
+		ret = PTR_ERR(*f_bdev);
 		goto error;
 	}
-	bdev = (*bdev_handle)->bdev;
+	bdev = F_BDEV(*f_bdev);
 
 	if (flush)
 		sync_blockdev(bdev);
 	ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
 	if (ret) {
-		bdev_release(*bdev_handle);
+		fput(*f_bdev);
 		goto error;
 	}
 	invalidate_bdev(bdev);
 	*disk_super = btrfs_read_dev_super(bdev);
 	if (IS_ERR(*disk_super)) {
 		ret = PTR_ERR(*disk_super);
-		bdev_release(*bdev_handle);
+		fput(*f_bdev);
 		goto error;
 	}
 
 	return 0;
 
 error:
-	*bdev_handle = NULL;
+	*f_bdev = NULL;
 	return ret;
 }
 
@@ -632,7 +632,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 			struct btrfs_device *device, blk_mode_t flags,
 			void *holder)
 {
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	struct btrfs_super_block *disk_super;
 	u64 devid;
 	int ret;
@@ -643,7 +643,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		return -EINVAL;
 
 	ret = btrfs_get_bdev_and_sb(device->name->str, flags, holder, 1,
-				    &bdev_handle, &disk_super);
+				    &f_bdev, &disk_super);
 	if (ret)
 		return ret;
 
@@ -667,20 +667,20 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 		fs_devices->seeding = true;
 	} else {
-		if (bdev_read_only(bdev_handle->bdev))
+		if (bdev_read_only(F_BDEV(f_bdev)))
 			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 		else
 			set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 	}
 
-	if (!bdev_nonrot(bdev_handle->bdev))
+	if (!bdev_nonrot(F_BDEV(f_bdev)))
 		fs_devices->rotating = true;
 
-	if (bdev_max_discard_sectors(bdev_handle->bdev))
+	if (bdev_max_discard_sectors(F_BDEV(f_bdev)))
 		fs_devices->discardable = true;
 
-	device->bdev_handle = bdev_handle;
-	device->bdev = bdev_handle->bdev;
+	device->f_bdev = f_bdev;
+	device->bdev = F_BDEV(f_bdev);
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 
 	fs_devices->open_devices++;
@@ -695,7 +695,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 
 error_free_page:
 	btrfs_release_disk_super(disk_super);
-	bdev_release(bdev_handle);
+	fput(f_bdev);
 
 	return -EINVAL;
 }
@@ -1004,10 +1004,10 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
 		if (device->devid == BTRFS_DEV_REPLACE_DEVID)
 			continue;
 
-		if (device->bdev_handle) {
-			bdev_release(device->bdev_handle);
+		if (device->f_bdev) {
+			fput(device->f_bdev);
 			device->bdev = NULL;
-			device->bdev_handle = NULL;
+			device->f_bdev = NULL;
 			fs_devices->open_devices--;
 		}
 		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
@@ -1052,7 +1052,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
 		invalidate_bdev(device->bdev);
 	}
 
-	bdev_release(device->bdev_handle);
+	fput(device->f_bdev);
 }
 
 static void btrfs_close_one_device(struct btrfs_device *device)
@@ -1305,7 +1305,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	struct btrfs_super_block *disk_super;
 	bool new_device_added = false;
 	struct btrfs_device *device = NULL;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	u64 bytenr, bytenr_orig;
 	int ret;
 
@@ -1328,18 +1328,18 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	 * values temporarily, as the device paths of the fsid are the only
 	 * required information for assembling the volume.
 	 */
-	bdev_handle = bdev_open_by_path(path, flags, NULL, NULL);
-	if (IS_ERR(bdev_handle))
-		return ERR_CAST(bdev_handle);
+	f_bdev = bdev_file_open_by_path(path, flags, NULL, NULL);
+	if (IS_ERR(f_bdev))
+		return ERR_CAST(f_bdev);
 
 	bytenr_orig = btrfs_sb_offset(0);
-	ret = btrfs_sb_log_location_bdev(bdev_handle->bdev, 0, READ, &bytenr);
+	ret = btrfs_sb_log_location_bdev(F_BDEV(f_bdev), 0, READ, &bytenr);
 	if (ret) {
 		device = ERR_PTR(ret);
 		goto error_bdev_put;
 	}
 
-	disk_super = btrfs_read_disk_super(bdev_handle->bdev, bytenr,
+	disk_super = btrfs_read_disk_super(F_BDEV(f_bdev), bytenr,
 					   bytenr_orig);
 	if (IS_ERR(disk_super)) {
 		device = ERR_CAST(disk_super);
@@ -1370,7 +1370,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	btrfs_release_disk_super(disk_super);
 
 error_bdev_put:
-	bdev_release(bdev_handle);
+	fput(f_bdev);
 
 	return device;
 }
@@ -2047,7 +2047,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		    struct btrfs_dev_lookup_args *args,
-		    struct bdev_handle **bdev_handle)
+		    struct file **f_bdev)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_device *device;
@@ -2156,7 +2156,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 
 	btrfs_assign_next_active_device(device, NULL);
 
-	if (device->bdev_handle) {
+	if (device->f_bdev) {
 		cur_devices->open_devices--;
 		/* remove sysfs entry */
 		btrfs_sysfs_remove_device(device);
@@ -2172,9 +2172,9 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	 * free the device.
 	 *
 	 * We cannot call btrfs_close_bdev() here because we're holding the sb
-	 * write lock, and bdev_release() will pull in the ->open_mutex on
-	 * the block device and it's dependencies.  Instead just flush the
-	 * device and let the caller do the final bdev_release.
+	 * write lock, and fput() on the block device will pull in the
+	 * ->open_mutex on the block device and it's dependencies.  Instead
+	 *  just flush the device and let the caller do the final bdev_release.
 	 */
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 		btrfs_scratch_superblocks(fs_info, device->bdev,
@@ -2185,7 +2185,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	*bdev_handle = device->bdev_handle;
+	*f_bdev = device->f_bdev;
 	synchronize_rcu();
 	btrfs_free_device(device);
 
@@ -2322,7 +2322,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 				 const char *path)
 {
 	struct btrfs_super_block *disk_super;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	int ret;
 
 	if (!path || !path[0])
@@ -2340,7 +2340,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 	}
 
 	ret = btrfs_get_bdev_and_sb(path, BLK_OPEN_READ, NULL, 0,
-				    &bdev_handle, &disk_super);
+				    &f_bdev, &disk_super);
 	if (ret) {
 		btrfs_put_dev_args_from_path(args);
 		return ret;
@@ -2353,7 +2353,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 	else
 		memcpy(args->fsid, disk_super->fsid, BTRFS_FSID_SIZE);
 	btrfs_release_disk_super(disk_super);
-	bdev_release(bdev_handle);
+	fput(f_bdev);
 	return 0;
 }
 
@@ -2573,7 +2573,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct btrfs_root *root = fs_info->dev_root;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_device *device;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	struct super_block *sb = fs_info->sb;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_fs_devices *seed_devices = NULL;
@@ -2586,12 +2586,12 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
 
-	bdev_handle = bdev_open_by_path(device_path, BLK_OPEN_WRITE,
+	f_bdev = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
 					fs_info->bdev_holder, NULL);
-	if (IS_ERR(bdev_handle))
-		return PTR_ERR(bdev_handle);
+	if (IS_ERR(f_bdev))
+		return PTR_ERR(f_bdev);
 
-	if (!btrfs_check_device_zone_type(fs_info, bdev_handle->bdev)) {
+	if (!btrfs_check_device_zone_type(fs_info, F_BDEV(f_bdev))) {
 		ret = -EINVAL;
 		goto error;
 	}
@@ -2603,11 +2603,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		locked = true;
 	}
 
-	sync_blockdev(bdev_handle->bdev);
+	sync_blockdev(F_BDEV(f_bdev));
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
-		if (device->bdev == bdev_handle->bdev) {
+		if (device->bdev == F_BDEV(f_bdev)) {
 			ret = -EEXIST;
 			rcu_read_unlock();
 			goto error;
@@ -2623,8 +2623,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	}
 
 	device->fs_info = fs_info;
-	device->bdev_handle = bdev_handle;
-	device->bdev = bdev_handle->bdev;
+	device->f_bdev = f_bdev;
+	device->bdev = F_BDEV(f_bdev);
 	ret = lookup_bdev(device_path, &device->devt);
 	if (ret)
 		goto error_free_device;
@@ -2807,7 +2807,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 error_free_device:
 	btrfs_free_device(device);
 error:
-	bdev_release(bdev_handle);
+	fput(f_bdev);
 	if (locked) {
 		mutex_unlock(&uuid_mutex);
 		up_write(&sb->s_umount);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 9cc374864a79..78de9ab6652a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -90,7 +90,7 @@ struct btrfs_device {
 
 	u64 generation;
 
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	struct block_device *bdev;
 
 	struct btrfs_zoned_device_info *zone_info;
@@ -646,7 +646,7 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args);
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		    struct btrfs_dev_lookup_args *args,
-		    struct bdev_handle **bdev_handle);
+		    struct file **f_bdev);
 void __exit btrfs_cleanup_fs_uuids(void);
 int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
 int btrfs_grow_device(struct btrfs_trans_handle *trans,

-- 
2.42.0


