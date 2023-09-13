Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C740B79F525
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 00:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjIMWof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 18:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIMWoe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:44:34 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF251BCB;
        Wed, 13 Sep 2023 15:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=H4MLlc/Ub7dsFWXtWOXJz+8BFvxbJQAMwoz2MwdVO8c=; b=kro3RsgyPidOPZLs0aCu7foF9y
        oKi2U5V+9/0BHZV/XooA4B18ebm3pNtN4QX0FQG8q1+MBPDhEIqv0oDks17qKObNQDgSHkLaPVs2O
        K5BTK9kRQ15eImisrJIFueH92npLeXG4u8CGWg617rK6f8+Q+6zknnp/vtkd0hXyXzfCRFJlXJIEK
        GfRDGkgYNRv4xzmqAoSXhfWUL5d1U8g1Yn78IoxXByy9wNOiU+VF2Xpu64C5h1Lm+OWdFK7Bo727R
        s5Jx7FnXk9HUA7jucDIheRyd9s+YRDPGTTrOLyK+uwdAsTZdqyoozgdNVBm57pZVVZmGUb/vqJjHz
        7dyXhlkg==;
Received: from [187.116.122.196] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qgYaw-003Z7W-6F; Thu, 14 Sep 2023 00:44:26 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        dsterba@suse.cz, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, anand.jain@oracle.com,
        david@fromorbit.com, kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH v4 2/2] btrfs: Introduce the temp-fsid feature
Date:   Wed, 13 Sep 2023 19:36:16 -0300
Message-ID: <20230913224402.3940543-3-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913224402.3940543-1-gpiccoli@igalia.com>
References: <20230913224402.3940543-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Btrfs doesn't currently support to mount 2 different devices holding the
same filesystem - the fsid is exposed as a unique identifier by the
driver. This case is supported though in some other common filesystems,
like ext4.

Supporting the same-fsid mounts has the advantage of allowing btrfs to
be used in A/B partitioned devices, like mobile phones or the Steam Deck
for example. Without this support, it's not safe for users to keep the
same "image version" in both A and B partitions, a setup that is quite
common for development, for example. Also, as a big bonus, it allows fs
integrity check based on block devices for RO devices (whereas currently
it is required that both have different fsid, breaking the block device
hash comparison).

Such same-fsid mounting is hereby added through the usage of the
filesystem feature "temp-fsid" - when such feature is used, btrfs
generates a random fsid for the filesystem and leverages the long-term
present metadata_uuid infrastructure to enable the usage of this
secondary "virtual" fsid, effectively requiring few non-invasive
changes to the code and no new potential corner cases.

In order to prevent more code complexity and corner cases, the
temp-fsid feature is not allowed when the metadata_uuid flag is
present on the fs, or if the device is on fsid-change state. Device
removal/replace is also disabled for filesystems presenting the feature.

Cc: Anand Jain <anand.jain@oracle.com>
Suggested-by: John Schoenick <johns@valvesoftware.com>
Suggested-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V4:

- Rebased against the github misc-next branch (of 2023-09-13); notice
it already includes the patch: ("btrfs: scan forget for no instance of dev"),
that was folded into the original commit;

- Patch ("btrfs: scan but don't register device on single device filesystem")
was took into account - now we don't need to mess with the function
btrfs_scan_one_device() here, since it already has the "mounting" argument;

- Improved the description of the fsid/metadata_uuid relation in volumes.h
comment (thanks Anand!);

- Dropped the '\n' in the btrfs_{err/info} prints (also thanks Anand!);

- Switched the feature name for temp-fsid - seems the "less disliked"
name, though personally I'd prefer virtual-fsid; also, that could be
easily changed according the maintainers agreement.

Previous versions:
V3: https://lore.kernel.org/linux-btrfs/20230831001544.3379273-1-gpiccoli@igalia.com/

V2: https://lore.kernel.org/linux-btrfs/20230803154453.1488248-1-gpiccoli@igalia.com/

V1: https://lore.kernel.org/linux-btrfs/20230504170708.787361-1-gpiccoli@igalia.com/


 fs/btrfs/disk-io.c         | 18 +++++++++-
 fs/btrfs/fs.h              |  3 +-
 fs/btrfs/ioctl.c           | 18 ++++++++++
 fs/btrfs/sysfs.c           |  2 ++
 fs/btrfs/volumes.c         | 70 +++++++++++++++++++++++++++++++-------
 fs/btrfs/volumes.h         |  5 +++
 include/uapi/linux/btrfs.h |  7 ++++
 7 files changed, 109 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 163f37ad1b27..860f98486d0d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2302,6 +2302,7 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 {
 	u64 nodesize = btrfs_super_nodesize(sb);
 	u64 sectorsize = btrfs_super_sectorsize(sb);
+	u8 *fsid;
 	int ret = 0;
 
 	if (btrfs_super_magic(sb) != BTRFS_MAGIC) {
@@ -2382,7 +2383,22 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
-	if (memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE) != 0) {
+	/*
+	 * For TEMP_FSID devices, btrfs creates a random fsid and makes
+	 * use of the metadata_uuid infrastructure in order to allow, for
+	 * example, two devices with same fsid getting mounted at the same
+	 * time. But notice no changes happen at the disk level, the random
+	 * generated fsid is a driver abstraction, not written to the disk.
+	 * That's the reason we're required here to compare the fsid  with
+	 * the metadata_uuid for such devices. See volumes.h for a more
+	 * descriptive analysis of the relation between fsid/metadata_uuid.
+	 */
+	if (btrfs_fs_compat_ro(fs_info, TEMP_FSID))
+		fsid = fs_info->fs_devices->metadata_uuid;
+	else
+		fsid = fs_info->fs_devices->fsid;
+
+	if (memcmp(fsid, sb->fsid, BTRFS_FSID_SIZE) != 0) {
 		btrfs_err(fs_info,
 		"superblock fsid doesn't match fsid of fs_devices: %pU != %pU",
 			  sb->fsid, fs_info->fs_devices->fsid);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index d84a390336fc..97fbbed79f0e 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -196,7 +196,8 @@ enum {
 	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
 	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
 	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
-	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
+	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE |	\
+	 BTRFS_FEATURE_COMPAT_RO_TEMP_FSID)
 
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 018ea98b239a..0278ede9e308 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2684,6 +2684,12 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (btrfs_fs_compat_ro(fs_info, TEMP_FSID)) {
+		btrfs_err(fs_info,
+			  "device removal is unsupported on TEMP_FSID devices");
+		return -EINVAL;
+	}
+
 	vol_args = memdup_user(arg, sizeof(*vol_args));
 	if (IS_ERR(vol_args))
 		return PTR_ERR(vol_args);
@@ -2750,6 +2756,12 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (btrfs_fs_compat_ro(fs_info, TEMP_FSID)) {
+		btrfs_err(fs_info,
+			  "device removal is unsupported on TEMP_FSID devices");
+		return -EINVAL;
+	}
+
 	vol_args = memdup_user(arg, sizeof(*vol_args));
 	if (IS_ERR(vol_args))
 		return PTR_ERR(vol_args);
@@ -3274,6 +3286,12 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (btrfs_fs_compat_ro(fs_info, TEMP_FSID)) {
+		btrfs_err(fs_info,
+			  "device replace is unsupported on TEMP_FSID devices");
+		return -EINVAL;
+	}
+
 	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
 		btrfs_err(fs_info, "device replace not supported on extent tree v2 yet");
 		return -EINVAL;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b1d1ac25237b..995773ece844 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -290,6 +290,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
+BTRFS_FEAT_ATTR_COMPAT_RO(temp_fsid, TEMP_FSID);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
 #ifdef CONFIG_BLK_DEV_ZONED
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
@@ -322,6 +323,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
 	BTRFS_FEAT_ATTR_PTR(block_group_tree),
+	BTRFS_FEAT_ATTR_PTR(temp_fsid),
 #ifdef CONFIG_BLK_DEV_ZONED
 	BTRFS_FEAT_ATTR_PTR(zoned),
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index de5ddd4f366e..eb40df615d7d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -767,8 +767,37 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
 
 	return NULL;
 }
+
+static void prepare_random_fsid(struct btrfs_super_block *disk_super,
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
+	btrfs_info(NULL,
+		"random fsid (%pU) set for TEMP_FSID device %s (real fsid %pU)",
+		disk_super->fsid, path, disk_super->metadata_uuid);
+}
+
 /*
- * Add new device to list of registered devices
+ * Add new device to list of registered devices, or in case of a TEMP_FSID
+ * device, also creates a random fsid to cope with same-fsid cases.
  *
  * Returns:
  * device pointer which was just added or updated when successful
@@ -789,6 +818,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
 	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
 					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
+	bool temp_fsid = (btrfs_super_compat_ro_flags(disk_super) &
+			 BTRFS_FEATURE_COMPAT_RO_TEMP_FSID);
 
 	error = lookup_bdev(path, &path_devt);
 	if (error) {
@@ -797,23 +828,32 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		return ERR_PTR(error);
 	}
 
-	if (fsid_change_in_progress) {
-		if (!has_metadata_uuid)
-			fs_devices = find_fsid_inprogress(disk_super);
-		else
-			fs_devices = find_fsid_changed(disk_super);
-	} else if (has_metadata_uuid) {
-		fs_devices = find_fsid_with_metadata_uuid(disk_super);
+	if (temp_fsid) {
+		if (has_metadata_uuid || fsid_change_in_progress) {
+			btrfs_err(NULL,
+		"TEMP_FSID devices don't support the metadata_uuid feature");
+			return ERR_PTR(-EINVAL);
+		}
+		prepare_random_fsid(disk_super, path);
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
 
 
 	if (!fs_devices) {
 		fs_devices = alloc_fs_devices(disk_super->fsid);
-		if (has_metadata_uuid)
+		if (has_metadata_uuid || temp_fsid)
 			memcpy(fs_devices->metadata_uuid,
 			       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
 
@@ -2415,6 +2455,12 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 
 	args->devid = btrfs_stack_device_id(&disk_super->dev_item);
 	memcpy(args->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE);
+
+	/*
+	 * Note that TEMP_FSID devices are not handled in a special way here;
+	 * device removal/replace is instead forbidden when such feature is
+	 * present, this note is for future users/readers of this function.
+	 */
 	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
 		memcpy(args->fsid, disk_super->metadata_uuid, BTRFS_FSID_SIZE);
 	else
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b513b2846793..13d486ed8095 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -299,6 +299,11 @@ struct btrfs_fs_devices {
 	 *   - When the BTRFS_FEATURE_INCOMPAT_METADATA_UUID flag is set:
 	 *       fs_devices->fsid == sb->fsid
 	 *       fs_devices->metadata_uuid == sb->metadata_uuid
+	 *
+	 *   - When the BTRFS_FEATURE_COMPAT_RO_TEMP_FSID flag is set:
+	 *       fs_devices->fsid == random; [see the function prepare_random_fsid()]
+	 *       fs_devices->metadata_uuid = sb->fsid;
+	 *       sb->metadata_uuid == 0;
 	 */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index dbb8b96da50d..594a240a20d4 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -313,6 +313,13 @@ struct btrfs_ioctl_fs_info_args {
  */
 #define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 3)
 
+/*
+ * A random fsid is generated for TEMP_FSID devices (as flagged by the
+ * corresponding compat_ro flag), in order to cope with same-fsid FS
+ * mounts.
+ */
+#define BTRFS_FEATURE_COMPAT_RO_TEMP_FSID	(1ULL << 4)
+
 #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
 #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
 #define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
-- 
2.42.0

