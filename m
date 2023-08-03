Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EAE76EE81
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 17:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbjHCPp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 11:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbjHCPp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:45:27 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8263535B0;
        Thu,  3 Aug 2023 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QnXvmo+pGJHTaTtdiH64v7w8MHpTofPd0HAyxnugKFY=; b=XOuVBZqdnEcBAnOJkSdDPMqY7/
        V/Z7Gs3WDhBnONfSZM9N5avXdJ2XmTbbxrpTn5NxyU1s1xXHBMaGXEUJTs9ivoLJujb89F6YlLVtI
        3Y4byx8DJco8gE6Q7/zVt3w6UD35nfPn4vCYQECa/6PtqPoefdi0eYn21Obj9ACCqETBFl4SBqImR
        ngo4GQtlsgvOeLmRSQ0jC6/z4avp6ufO2+Iwa8nN076t3PjDWbi07y4WmJGIpRIpv0gm9i65ehNcU
        uNvopR5txhSBLxn4CvZjAl8ASwLIXdVldFP8Do+qVMmPf4xq4tekyzOMEMoCgGM+xSUaG+fB6RzRO
        8qQe3SLw==;
Received: from [201.92.22.215] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qRaVs-00BtyE-I7; Thu, 03 Aug 2023 17:45:21 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        gpiccoli@igalia.com, kernel-dev@igalia.com, anand.jain@oracle.com,
        david@fromorbit.com, kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: [PATCH 2/3] btrfs: Introduce the single-dev feature
Date:   Thu,  3 Aug 2023 12:43:40 -0300
Message-ID: <20230803154453.1488248-3-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803154453.1488248-1-gpiccoli@igalia.com>
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Btrfs doesn't currently support to mount 2 different devices holding the
same filesystem - the fsid is used as a unique identifier in the driver.
This case is supported though in some other common filesystems, like
ext4; one of the reasons for which is not trivial supporting this case
on btrfs is due to its multi-device filesystem nature, native RAID, etc.

Supporting the same-fsid mounts has the advantage of allowing btrfs to
be used in A/B partitioned devices, like mobile phones or the Steam Deck
for example. Without this support, it's not safe for users to keep the
same "image version" in both A and B partitions, a setup that is quite
common for development, for example. Also, as a big bonus, it allows fs
integrity check based on block devices for RO devices (whereas currently
it is required that both have different fsid, breaking the block device
hash comparison).

Such same-fsid mounting is hereby added through the usage of the
filesystem feature "single-dev" - when such feature is used, btrfs
generates a random fsid for the filesystem and leverages the long-term
present metadata_uuid infrastructure to enable the usage of this
secondary virtual fsid, effectively requiring few non-invasive changes
to the code and no new potential corner cases.

In order to prevent more code complexity and corner cases, given
the nature of this mechanism (single-devices), the single-dev feature
is not allowed when the metadata_uuid flag is already present on the
fs, or if the device is on fsid-change state. Device removal/replace
is also disabled for devices presenting the single-dev feature.

Suggested-by: John Schoenick <johns@valvesoftware.com>
Suggested-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 fs/btrfs/disk-io.c         | 19 +++++++-
 fs/btrfs/fs.h              |  3 +-
 fs/btrfs/ioctl.c           | 18 +++++++
 fs/btrfs/super.c           |  8 ++--
 fs/btrfs/volumes.c         | 97 ++++++++++++++++++++++++++++++--------
 fs/btrfs/volumes.h         |  3 +-
 include/uapi/linux/btrfs.h |  7 +++
 7 files changed, 127 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 669b10355091..455fa4949c98 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -320,7 +320,7 @@ static bool check_tree_block_fsid(struct extent_buffer *eb)
 	/*
 	 * alloc_fs_devices() copies the fsid into metadata_uuid if the
 	 * metadata_uuid is unset in the superblock, including for a seed device.
-	 * So, we can use fs_devices->metadata_uuid.
+	 * So, we can use fs_devices->metadata_uuid; same for SINGLE_DEV devices.
 	 */
 	if (!memcmp(fsid, fs_info->fs_devices->metadata_uuid, BTRFS_FSID_SIZE))
 		return false;
@@ -2288,6 +2288,7 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 {
 	u64 nodesize = btrfs_super_nodesize(sb);
 	u64 sectorsize = btrfs_super_sectorsize(sb);
+	u8 *fsid;
 	int ret = 0;
 
 	if (btrfs_super_magic(sb) != BTRFS_MAGIC) {
@@ -2368,7 +2369,21 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
-	if (memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE)) {
+	/*
+	 * For SINGLE_DEV devices, btrfs creates a random fsid and makes
+	 * use of the metadata_uuid infrastructure in order to allow, for
+	 * example, two devices with same fsid getting mounted at the same
+	 * time. But notice no changes happen at the disk level, so the
+	 * random generated fsid is a driver abstraction, not to be written
+	 * in the disk. That's the reason we're required here to compare the
+	 * fsid with the metadata_uuid for such devices.
+	 */
+	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV))
+		fsid = fs_info->fs_devices->metadata_uuid;
+	else
+		fsid = fs_info->fs_devices->fsid;
+
+	if (memcmp(fsid, sb->fsid, BTRFS_FSID_SIZE)) {
 		btrfs_err(fs_info,
 		"superblock fsid doesn't match fsid of fs_devices: %pU != %pU",
 			  sb->fsid, fs_info->fs_devices->fsid);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 203d2a267828..c6d124973361 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -200,7 +200,8 @@ enum {
 	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
 	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
 	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
-	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
+	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE |	\
+	 BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV)
 
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a895d105464b..56703d87def9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2678,6 +2678,12 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
+		btrfs_err(fs_info,
+			  "device removal is unsupported on SINGLE_DEV devices\n");
+		return -EINVAL;
+	}
+
 	vol_args = memdup_user(arg, sizeof(*vol_args));
 	if (IS_ERR(vol_args))
 		return PTR_ERR(vol_args);
@@ -2744,6 +2750,12 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
+		btrfs_err(fs_info,
+			  "device removal is unsupported on SINGLE_DEV devices\n");
+		return -EINVAL;
+	}
+
 	vol_args = memdup_user(arg, sizeof(*vol_args));
 	if (IS_ERR(vol_args))
 		return PTR_ERR(vol_args);
@@ -3268,6 +3280,12 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
+		btrfs_err(fs_info,
+			  "device removal is unsupported on SINGLE_DEV devices\n");
+		return -EINVAL;
+	}
+
 	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
 		btrfs_err(fs_info, "device replace not supported on extent tree v2 yet");
 		return -EINVAL;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f1dd172d8d5b..ee87189b1ccd 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -883,7 +883,7 @@ static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
 				error = -ENOMEM;
 				goto out;
 			}
-			device = btrfs_scan_one_device(device_name, flags);
+			device = btrfs_scan_one_device(device_name, flags, true);
 			kfree(device_name);
 			if (IS_ERR(device)) {
 				error = PTR_ERR(device);
@@ -1478,7 +1478,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		goto error_fs_info;
 	}
 
-	device = btrfs_scan_one_device(device_name, mode);
+	device = btrfs_scan_one_device(device_name, mode, true);
 	if (IS_ERR(device)) {
 		mutex_unlock(&uuid_mutex);
 		error = PTR_ERR(device);
@@ -2190,7 +2190,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case BTRFS_IOC_SCAN_DEV:
 		mutex_lock(&uuid_mutex);
-		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
+		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
 		ret = PTR_ERR_OR_ZERO(device);
 		mutex_unlock(&uuid_mutex);
 		break;
@@ -2204,7 +2204,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		break;
 	case BTRFS_IOC_DEVICES_READY:
 		mutex_lock(&uuid_mutex);
-		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
+		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
 		if (IS_ERR(device)) {
 			mutex_unlock(&uuid_mutex);
 			ret = PTR_ERR(device);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 73753dae111a..433a490f2de8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -681,12 +681,14 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	return -EINVAL;
 }
 
-static u8 *btrfs_sb_metadata_uuid_or_null(struct btrfs_super_block *sb)
+static u8 *btrfs_sb_metadata_uuid_single_dev(struct btrfs_super_block *sb,
+					     bool has_metadata_uuid,
+					     bool single_dev)
 {
-	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
-				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+	if (has_metadata_uuid || single_dev)
+		return sb->metadata_uuid;
 
-	return has_metadata_uuid ? sb->metadata_uuid : NULL;
+	return NULL;
 }
 
 u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
@@ -775,8 +777,36 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
 
 	return NULL;
 }
+
+static void prepare_virtual_fsid(struct btrfs_super_block *disk_super,
+				 const char *path)
+{
+	struct btrfs_fs_devices *fs_devices;
+	u8 vfsid[BTRFS_FSID_SIZE];
+	bool dup_fsid = true;
+
+	while (dup_fsid) {
+		dup_fsid = false;
+		generate_random_uuid(vfsid);
+
+		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+			if (!memcmp(vfsid, fs_devices->fsid, BTRFS_FSID_SIZE) ||
+			    !memcmp(vfsid, fs_devices->metadata_uuid,
+				    BTRFS_FSID_SIZE))
+				dup_fsid = true;
+		}
+	}
+
+	memcpy(disk_super->metadata_uuid, disk_super->fsid, BTRFS_FSID_SIZE);
+	memcpy(disk_super->fsid, vfsid, BTRFS_FSID_SIZE);
+
+	pr_info("BTRFS: virtual fsid (%pU) set for SINGLE_DEV device %s (real fsid %pU)\n",
+		disk_super->fsid, path, disk_super->metadata_uuid);
+}
+
 /*
- * Add new device to list of registered devices
+ * Add new device to list of registered devices, or in case of a SINGLE_DEV
+ * device, also creates a virtual fsid to cope with same-fsid cases.
  *
  * Returns:
  * device pointer which was just added or updated when successful
@@ -784,7 +814,7 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
  */
 static noinline struct btrfs_device *device_list_add(const char *path,
 			   struct btrfs_super_block *disk_super,
-			   bool *new_device_added)
+			   bool *new_device_added, bool single_dev)
 {
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *fs_devices = NULL;
@@ -805,23 +835,32 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		return ERR_PTR(error);
 	}
 
-	if (fsid_change_in_progress) {
-		if (!has_metadata_uuid)
-			fs_devices = find_fsid_inprogress(disk_super);
-		else
-			fs_devices = find_fsid_changed(disk_super);
-	} else if (has_metadata_uuid) {
-		fs_devices = find_fsid_with_metadata_uuid(disk_super);
+	if (single_dev) {
+		if (has_metadata_uuid || fsid_change_in_progress) {
+			btrfs_err(NULL,
+		"SINGLE_DEV devices don't support the metadata_uuid feature\n");
+			return ERR_PTR(-EINVAL);
+		}
+		prepare_virtual_fsid(disk_super, path);
 	} else {
-		fs_devices = find_fsid_reverted_metadata(disk_super);
-		if (!fs_devices)
-			fs_devices = find_fsid(disk_super->fsid, NULL);
+		if (fsid_change_in_progress) {
+			if (!has_metadata_uuid)
+				fs_devices = find_fsid_inprogress(disk_super);
+			else
+				fs_devices = find_fsid_changed(disk_super);
+		} else if (has_metadata_uuid) {
+			fs_devices = find_fsid_with_metadata_uuid(disk_super);
+		} else {
+			fs_devices = find_fsid_reverted_metadata(disk_super);
+			if (!fs_devices)
+				fs_devices = find_fsid(disk_super->fsid, NULL);
+		}
 	}
 
-
 	if (!fs_devices) {
 		fs_devices = alloc_fs_devices(disk_super->fsid,
-				btrfs_sb_metadata_uuid_or_null(disk_super));
+				btrfs_sb_metadata_uuid_single_dev(disk_super,
+							has_metadata_uuid, single_dev));
 		if (IS_ERR(fs_devices))
 			return ERR_CAST(fs_devices);
 
@@ -1365,13 +1404,15 @@ int btrfs_forget_devices(dev_t devt)
  * and we are not allowed to call set_blocksize during the scan. The superblock
  * is read via pagecache
  */
-struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
+struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
+					   bool mounting)
 {
 	struct btrfs_super_block *disk_super;
 	bool new_device_added = false;
 	struct btrfs_device *device = NULL;
 	struct block_device *bdev;
 	u64 bytenr, bytenr_orig;
+	bool single_dev;
 	int ret;
 
 	lockdep_assert_held(&uuid_mutex);
@@ -1410,7 +1451,17 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
 		goto error_bdev_put;
 	}
 
-	device = device_list_add(path, disk_super, &new_device_added);
+	single_dev = btrfs_super_compat_ro_flags(disk_super) &
+			BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV;
+
+	if (!mounting && single_dev) {
+		pr_info("BTRFS: skipped non-mount scan on SINGLE_DEV device %s\n",
+			path);
+		btrfs_release_disk_super(disk_super);
+		return ERR_PTR(-EINVAL);
+	}
+
+	device = device_list_add(path, disk_super, &new_device_added, single_dev);
 	if (!IS_ERR(device) && new_device_added)
 		btrfs_free_stale_devices(device->devt, device);
 
@@ -2406,6 +2457,12 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 
 	args->devid = btrfs_stack_device_id(&disk_super->dev_item);
 	memcpy(args->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE);
+
+	/*
+	 * Note that SINGLE_DEV devices are not handled in a special way here;
+	 * device removal/replace is instead forbidden when such feature is
+	 * present, this note is for future users/readers of this function.
+	 */
 	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
 		memcpy(args->fsid, disk_super->metadata_uuid, BTRFS_FSID_SIZE);
 	else
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 0f87057bb575..b9856c801567 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -611,7 +611,8 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder);
-struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags);
+struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
+					   bool mounting);
 int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index dbb8b96da50d..cb7a7cfe1ea9 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -313,6 +313,13 @@ struct btrfs_ioctl_fs_info_args {
  */
 #define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 3)
 
+/*
+ * Single devices (as flagged by the corresponding compat_ro flag) only
+ * gets scanned during mount time; also, a random fsid is generated for
+ * them, in order to cope with same-fsid filesystem mounts.
+ */
+#define BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV		(1ULL << 4)
+
 #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
 #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
 #define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
-- 
2.41.0

