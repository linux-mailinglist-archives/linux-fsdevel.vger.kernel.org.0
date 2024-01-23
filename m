Return-Path: <linux-fsdevel+bounces-8564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0D083900F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2011282355
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0352260EC8;
	Tue, 23 Jan 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tS3EqjuC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647FF60DE9;
	Tue, 23 Jan 2024 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016465; cv=none; b=W7wye84BiAy2XZiJzo4G7tyCuu/sbnbE8Y07EdtdnsocvIxRP+LEPdrMFdQv8AkFbiy2ysERu1TrSJSntKkcPCoIFkxdSaRrMdX6xejxoFDY5MidQSlr/3oUUHAFvQtJSMuPy7Tq4nJkWmOLhpb+//H3IfTIS86ePz7+zWKJjac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016465; c=relaxed/simple;
	bh=9QVlhIY5DLf6fBLVQx201dvj8k85eEzENqaPZCJOIZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rzBCvt17GwJBiT+6BRFgXkaoAfmlFcDAVnYAyAIkvCwzVr5W/3+mdO491knwL2uCMIlLQ0HXwOS1yt9V2d5KyHsMIk1FIsXXXMnH6iLua7WDzbEnfoDZhnyPOGRJkJIBPWqGcNJNQw3TNQSjhhCjImmGDRsrbOoVrAZHW5bi1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tS3EqjuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040D6C43394;
	Tue, 23 Jan 2024 13:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016464;
	bh=9QVlhIY5DLf6fBLVQx201dvj8k85eEzENqaPZCJOIZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tS3EqjuCepaLK/L/31L1BIosib/IpfKZG9kJjC2uPyH5DcP7MvyI4PDVVZ2C97XB+
	 P2jZe6F3f+ZEoXZ2iK8BDbst4YVjvgM+W6Mxcpj+mzReJtq5BRt+vCiROQelcILuUu
	 FNrW1M0EWzpFiRFIZ6sfTF8xvXcpddGxF9IfGkqpNdDih6YYyuSeTLXRfK94GxXuf/
	 Qi/jelDKwuybbIa8Ja5oIiRSSilIce9MVei+qCLeYf8oRcPcXrHMQiWQzDU3DkLYvT
	 zeBcp3/7hkW+jfmlWcRs9gQd7V9ttbJBb6VMXdh6XYJD+5IYRysJSoZirB2UGFN9Wh
	 PXjyLZ7GB+t8w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:36 +0100
Subject: [PATCH v2 19/34] btrfs: port device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-19-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=15004; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9QVlhIY5DLf6fBLVQx201dvj8k85eEzENqaPZCJOIZ8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37dg94dm9abw12U3uaXvze1rntJf5dYnnhQ8n/nFz
 pwM9iirjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkUxzP84ZfzVPirPFncSUG4
 0PVhQ4VYsArH+ZBUw6YzThIb2crmMfz3qpwZ3/YvaGcyh/bmnub9FmeYy5ielZyeEVtx/QznPVY
 uAA==
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
index 1502d664c892..2eb11fe4bd05 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -246,7 +246,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	struct block_device *bdev;
 	u64 devid = BTRFS_DEV_REPLACE_DEVID;
 	int ret = 0;
@@ -257,13 +257,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 		return -EINVAL;
 	}
 
-	bdev_handle = bdev_open_by_path(device_path, BLK_OPEN_WRITE,
+	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
 					fs_info->bdev_holder, NULL);
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(bdev_file)) {
 		btrfs_err(fs_info, "target device %s is invalid!", device_path);
-		return PTR_ERR(bdev_handle);
+		return PTR_ERR(bdev_file);
 	}
-	bdev = bdev_handle->bdev;
+	bdev = file_bdev(bdev_file);
 
 	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
 		btrfs_err(fs_info,
@@ -314,7 +314,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	device->commit_bytes_used = device->bytes_used;
 	device->fs_info = fs_info;
 	device->bdev = bdev;
-	device->bdev_handle = bdev_handle;
+	device->bdev_file = bdev_file;
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	set_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
 	device->dev_stats_valid = 1;
@@ -335,7 +335,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	return 0;
 
 error:
-	bdev_release(bdev_handle);
+	fput(bdev_file);
 	return ret;
 }
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 41b479861b3c..9e0b3932d90c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2691,7 +2691,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args_v2 *vol_args;
-	struct bdev_handle *bdev_handle = NULL;
+	struct file *bdev_file = NULL;
 	int ret;
 	bool cancel = false;
 
@@ -2728,7 +2728,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 		goto err_drop;
 
 	/* Exclusive operation is now claimed */
-	ret = btrfs_rm_device(fs_info, &args, &bdev_handle);
+	ret = btrfs_rm_device(fs_info, &args, &bdev_file);
 
 	btrfs_exclop_finish(fs_info);
 
@@ -2742,8 +2742,8 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	}
 err_drop:
 	mnt_drop_write_file(file);
-	if (bdev_handle)
-		bdev_release(bdev_handle);
+	if (bdev_file)
+		fput(bdev_file);
 out:
 	btrfs_put_dev_args_from_path(&args);
 	kfree(vol_args);
@@ -2756,7 +2756,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args *vol_args;
-	struct bdev_handle *bdev_handle = NULL;
+	struct file *bdev_file = NULL;
 	int ret;
 	bool cancel = false;
 
@@ -2783,15 +2783,15 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
 					   cancel);
 	if (ret == 0) {
-		ret = btrfs_rm_device(fs_info, &args, &bdev_handle);
+		ret = btrfs_rm_device(fs_info, &args, &bdev_file);
 		if (!ret)
 			btrfs_info(fs_info, "disk deleted %s", vol_args->name);
 		btrfs_exclop_finish(fs_info);
 	}
 
 	mnt_drop_write_file(file);
-	if (bdev_handle)
-		bdev_release(bdev_handle);
+	if (bdev_file)
+		fput(bdev_file);
 out:
 	btrfs_put_dev_args_from_path(&args);
 	kfree(vol_args);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4c32497311d2..769a1dc4b756 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -468,39 +468,39 @@ static noinline struct btrfs_fs_devices *find_fsid(
 
 static int
 btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
-		      int flush, struct bdev_handle **bdev_handle,
+		      int flush, struct file **bdev_file,
 		      struct btrfs_super_block **disk_super)
 {
 	struct block_device *bdev;
 	int ret;
 
-	*bdev_handle = bdev_open_by_path(device_path, flags, holder, NULL);
+	*bdev_file = bdev_file_open_by_path(device_path, flags, holder, NULL);
 
-	if (IS_ERR(*bdev_handle)) {
-		ret = PTR_ERR(*bdev_handle);
+	if (IS_ERR(*bdev_file)) {
+		ret = PTR_ERR(*bdev_file);
 		goto error;
 	}
-	bdev = (*bdev_handle)->bdev;
+	bdev = file_bdev(*bdev_file);
 
 	if (flush)
 		sync_blockdev(bdev);
 	ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
 	if (ret) {
-		bdev_release(*bdev_handle);
+		fput(*bdev_file);
 		goto error;
 	}
 	invalidate_bdev(bdev);
 	*disk_super = btrfs_read_dev_super(bdev);
 	if (IS_ERR(*disk_super)) {
 		ret = PTR_ERR(*disk_super);
-		bdev_release(*bdev_handle);
+		fput(*bdev_file);
 		goto error;
 	}
 
 	return 0;
 
 error:
-	*bdev_handle = NULL;
+	*bdev_file = NULL;
 	return ret;
 }
 
@@ -643,7 +643,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 			struct btrfs_device *device, blk_mode_t flags,
 			void *holder)
 {
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	struct btrfs_super_block *disk_super;
 	u64 devid;
 	int ret;
@@ -654,7 +654,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		return -EINVAL;
 
 	ret = btrfs_get_bdev_and_sb(device->name->str, flags, holder, 1,
-				    &bdev_handle, &disk_super);
+				    &bdev_file, &disk_super);
 	if (ret)
 		return ret;
 
@@ -678,20 +678,20 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 		fs_devices->seeding = true;
 	} else {
-		if (bdev_read_only(bdev_handle->bdev))
+		if (bdev_read_only(file_bdev(bdev_file)))
 			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 		else
 			set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 	}
 
-	if (!bdev_nonrot(bdev_handle->bdev))
+	if (!bdev_nonrot(file_bdev(bdev_file)))
 		fs_devices->rotating = true;
 
-	if (bdev_max_discard_sectors(bdev_handle->bdev))
+	if (bdev_max_discard_sectors(file_bdev(bdev_file)))
 		fs_devices->discardable = true;
 
-	device->bdev_handle = bdev_handle;
-	device->bdev = bdev_handle->bdev;
+	device->bdev_file = bdev_file;
+	device->bdev = file_bdev(bdev_file);
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 
 	fs_devices->open_devices++;
@@ -706,7 +706,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 
 error_free_page:
 	btrfs_release_disk_super(disk_super);
-	bdev_release(bdev_handle);
+	fput(bdev_file);
 
 	return -EINVAL;
 }
@@ -1015,10 +1015,10 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
 		if (device->devid == BTRFS_DEV_REPLACE_DEVID)
 			continue;
 
-		if (device->bdev_handle) {
-			bdev_release(device->bdev_handle);
+		if (device->bdev_file) {
+			fput(device->bdev_file);
 			device->bdev = NULL;
-			device->bdev_handle = NULL;
+			device->bdev_file = NULL;
 			fs_devices->open_devices--;
 		}
 		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
@@ -1063,7 +1063,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
 		invalidate_bdev(device->bdev);
 	}
 
-	bdev_release(device->bdev_handle);
+	fput(device->bdev_file);
 }
 
 static void btrfs_close_one_device(struct btrfs_device *device)
@@ -1316,7 +1316,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	struct btrfs_super_block *disk_super;
 	bool new_device_added = false;
 	struct btrfs_device *device = NULL;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	u64 bytenr, bytenr_orig;
 	int ret;
 
@@ -1339,18 +1339,18 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	 * values temporarily, as the device paths of the fsid are the only
 	 * required information for assembling the volume.
 	 */
-	bdev_handle = bdev_open_by_path(path, flags, NULL, NULL);
-	if (IS_ERR(bdev_handle))
-		return ERR_CAST(bdev_handle);
+	bdev_file = bdev_file_open_by_path(path, flags, NULL, NULL);
+	if (IS_ERR(bdev_file))
+		return ERR_CAST(bdev_file);
 
 	bytenr_orig = btrfs_sb_offset(0);
-	ret = btrfs_sb_log_location_bdev(bdev_handle->bdev, 0, READ, &bytenr);
+	ret = btrfs_sb_log_location_bdev(file_bdev(bdev_file), 0, READ, &bytenr);
 	if (ret) {
 		device = ERR_PTR(ret);
 		goto error_bdev_put;
 	}
 
-	disk_super = btrfs_read_disk_super(bdev_handle->bdev, bytenr,
+	disk_super = btrfs_read_disk_super(file_bdev(bdev_file), bytenr,
 					   bytenr_orig);
 	if (IS_ERR(disk_super)) {
 		device = ERR_CAST(disk_super);
@@ -1381,7 +1381,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	btrfs_release_disk_super(disk_super);
 
 error_bdev_put:
-	bdev_release(bdev_handle);
+	fput(bdev_file);
 
 	return device;
 }
@@ -2057,7 +2057,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		    struct btrfs_dev_lookup_args *args,
-		    struct bdev_handle **bdev_handle)
+		    struct file **bdev_file)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_device *device;
@@ -2166,7 +2166,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 
 	btrfs_assign_next_active_device(device, NULL);
 
-	if (device->bdev_handle) {
+	if (device->bdev_file) {
 		cur_devices->open_devices--;
 		/* remove sysfs entry */
 		btrfs_sysfs_remove_device(device);
@@ -2182,9 +2182,9 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
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
@@ -2195,7 +2195,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	*bdev_handle = device->bdev_handle;
+	*bdev_file = device->bdev_file;
 	synchronize_rcu();
 	btrfs_free_device(device);
 
@@ -2332,7 +2332,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 				 const char *path)
 {
 	struct btrfs_super_block *disk_super;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	int ret;
 
 	if (!path || !path[0])
@@ -2350,7 +2350,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 	}
 
 	ret = btrfs_get_bdev_and_sb(path, BLK_OPEN_READ, NULL, 0,
-				    &bdev_handle, &disk_super);
+				    &bdev_file, &disk_super);
 	if (ret) {
 		btrfs_put_dev_args_from_path(args);
 		return ret;
@@ -2363,7 +2363,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 	else
 		memcpy(args->fsid, disk_super->fsid, BTRFS_FSID_SIZE);
 	btrfs_release_disk_super(disk_super);
-	bdev_release(bdev_handle);
+	fput(bdev_file);
 	return 0;
 }
 
@@ -2583,7 +2583,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct btrfs_root *root = fs_info->dev_root;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_device *device;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	struct super_block *sb = fs_info->sb;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_fs_devices *seed_devices = NULL;
@@ -2596,12 +2596,12 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
 
-	bdev_handle = bdev_open_by_path(device_path, BLK_OPEN_WRITE,
+	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
 					fs_info->bdev_holder, NULL);
-	if (IS_ERR(bdev_handle))
-		return PTR_ERR(bdev_handle);
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
 
-	if (!btrfs_check_device_zone_type(fs_info, bdev_handle->bdev)) {
+	if (!btrfs_check_device_zone_type(fs_info, file_bdev(bdev_file))) {
 		ret = -EINVAL;
 		goto error;
 	}
@@ -2613,11 +2613,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		locked = true;
 	}
 
-	sync_blockdev(bdev_handle->bdev);
+	sync_blockdev(file_bdev(bdev_file));
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
-		if (device->bdev == bdev_handle->bdev) {
+		if (device->bdev == file_bdev(bdev_file)) {
 			ret = -EEXIST;
 			rcu_read_unlock();
 			goto error;
@@ -2633,8 +2633,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	}
 
 	device->fs_info = fs_info;
-	device->bdev_handle = bdev_handle;
-	device->bdev = bdev_handle->bdev;
+	device->bdev_file = bdev_file;
+	device->bdev = file_bdev(bdev_file);
 	ret = lookup_bdev(device_path, &device->devt);
 	if (ret)
 		goto error_free_device;
@@ -2817,7 +2817,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 error_free_device:
 	btrfs_free_device(device);
 error:
-	bdev_release(bdev_handle);
+	fput(bdev_file);
 	if (locked) {
 		mutex_unlock(&uuid_mutex);
 		up_write(&sb->s_umount);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 53f87f398da7..a11854912d53 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -90,7 +90,7 @@ struct btrfs_device {
 
 	u64 generation;
 
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	struct block_device *bdev;
 
 	struct btrfs_zoned_device_info *zone_info;
@@ -661,7 +661,7 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args);
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		    struct btrfs_dev_lookup_args *args,
-		    struct bdev_handle **bdev_handle);
+		    struct file **bdev_file);
 void __exit btrfs_cleanup_fs_uuids(void);
 int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
 int btrfs_grow_device(struct btrfs_trans_handle *trans,

-- 
2.43.0


