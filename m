Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E146F7074
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 19:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjEDRIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 13:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjEDRIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 13:08:42 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4122D62;
        Thu,  4 May 2023 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gpHUVZ8+DmfAicFsbWUqgKQnsnbIs4P1ISYIw/E6+Ck=; b=S3LvawSWYHdRW+ll/YN7HsbYd+
        7giwfoSmwuuw0fdmDN5t/R0p79ZcFqfCjYB3wtbOtywkgYM0EUCK6vQVtJ8YzIU5A5BG+k0sQ3xVH
        onxAoBnbjfIG3PHy1a60IxQ+BGJXqUa/l8BtW2nc07TB+EAHNcduP2YFwR9mtWMo+OXfXdJm4BqML
        TGfAYQ8hIkeReTq9O3fVhSMBvkk059D9OeNnLQ7BcbipwYbfJ5CQUeqXnMO5MGSR2ftFvl4xy+I74
        lIDjGDcJkgsT8tQSPvT779E2ERGEOrGmcpzoSWxvIOKPD5/Px6CM0SV1XRP8dn/5J06WHZc36im+P
        PAxk+WcQ==;
Received: from [177.189.3.64] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pucRY-001H7f-Gr; Thu, 04 May 2023 19:08:37 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Date:   Thu,  4 May 2023 14:07:07 -0300
Message-Id: <20230504170708.787361-2-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504170708.787361-1-gpiccoli@igalia.com>
References: <20230504170708.787361-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
mount option "virtual_fsid" - when such option is used, btrfs generates
a random fsid for the filesystem and leverages the metadata_uuid
infrastructure (introduced by [0]) to enable the usage of this secondary
virtual fsid. But differently from the regular metadata_uuid flag, this
is not written into the disk superblock - effectively, this is a spoofed
fsid approach that enables the same filesystem in different devices to
appear as different filesystems to btrfs on runtime.

In order to prevent more code complexity and potential corner cases,
given the usage is aimed to single-devices / partitions, virtual_fsid
is not allowed when the metadata_uuid flag is already present on the fs,
or if the device is on fsid-change state. Device removal/replace is also
disabled for devices mounted with the virtual_fsid option.

[0] 7239ff4b2be8 ("btrfs: Introduce support for FSID change without metadata rewrite)

Cc: Nikolay Borisov <nborisov@suse.com>
Suggested-by: John Schoenick <johns@valvesoftware.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

Hi folks, first of all thanks in advance for reviews / suggestions!
Some design choices that worth a discussion:

(1) The first choice was for the random fsid versus user-passed id.
Initially we considered that the flag could be "virtual_fsid=%s", hence
userspace would be responsible to generate the fsid. But seems the
collision probability of fsids in near zero, also the random code
hereby proposed checks if any other fsid/metadata_uuid present in
the btrfs structures is a match, and if so, new random uuids are
created until they prove the unique within btrfs.

(2) About disabling device removal/replace: these cases could be
handled I guess, but with increased code complexity. If there is a
need for that, we could implement. Also worth mentioning that any
advice is appreciated with regards to potential incompatibilities
between "virtual_fsid" and any other btrfs feature / mount option.

(3) There is no proposed documentation about the "virtual_fsid" here;
seems the kernel docs points to a wiki page, so appreciate suggestions
on how to edit such wiki and how to coordinate this with the patch
development cycle.


 fs/btrfs/disk-io.c | 22 ++++++++++--
 fs/btrfs/ioctl.c   | 18 ++++++++++
 fs/btrfs/super.c   | 32 +++++++++++------
 fs/btrfs/volumes.c | 86 +++++++++++++++++++++++++++++++++++++++-------
 fs/btrfs/volumes.h |  8 ++++-
 5 files changed, 139 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9e1596bb208d..66c2bac343b8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -468,7 +468,8 @@ static int check_tree_block_fsid(struct extent_buffer *eb)
 	 * seed devices it's forbidden to have their uuid changed so reading
 	 * ->fsid in this case is fine
 	 */
-	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
+	if (btrfs_fs_incompat(fs_info, METADATA_UUID) ||
+	    fs_devices->virtual_fsid)
 		metadata_uuid = fs_devices->metadata_uuid;
 	else
 		metadata_uuid = fs_devices->fsid;
@@ -2539,6 +2540,7 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 {
 	u64 nodesize = btrfs_super_nodesize(sb);
 	u64 sectorsize = btrfs_super_sectorsize(sb);
+	u8 *fsid;
 	int ret = 0;
 
 	if (btrfs_super_magic(sb) != BTRFS_MAGIC) {
@@ -2619,8 +2621,22 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
-	if (memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid,
-		   BTRFS_FSID_SIZE)) {
+	/*
+	 * When the virtual_fsid flag is passed at mount time, btrfs
+	 * creates a random fsid and makes use of the metadata_uuid
+	 * infrastructure in order to allow, for example, two devices
+	 * with same fsid getting mounted at the same time. But notice
+	 * no changes happen at the disk level, so the random fsid is a
+	 * driver abstraction for that single mount, not to be written
+	 * in the disk. That's the reason we're required here to compare
+	 * the fsid with the metadata_uuid if virtual_fsid was set.
+	 */
+	if (fs_info->fs_devices->virtual_fsid)
+		fsid = fs_info->fs_devices->metadata_uuid;
+	else
+		fsid = fs_info->fs_devices->fsid;
+
+	if (memcmp(fsid, fs_info->super_copy->fsid, BTRFS_FSID_SIZE)) {
 		btrfs_err(fs_info,
 		"superblock fsid doesn't match fsid of fs_devices: %pU != %pU",
 			fs_info->super_copy->fsid, fs_info->fs_devices->fsid);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ba769a1eb87a..35e3a23f8c83 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2677,6 +2677,12 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (fs_info->fs_devices->virtual_fsid) {
+		btrfs_err(fs_info,
+			  "device removal is unsupported on devices mounted with virtual fsid\n");
+		return -EINVAL;
+	}
+
 	vol_args = memdup_user(arg, sizeof(*vol_args));
 	if (IS_ERR(vol_args))
 		return PTR_ERR(vol_args);
@@ -2743,6 +2749,12 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (fs_info->fs_devices->virtual_fsid) {
+		btrfs_err(fs_info,
+			  "device removal is unsupported on devices mounted with virtual fsid\n");
+		return -EINVAL;
+	}
+
 	vol_args = memdup_user(arg, sizeof(*vol_args));
 	if (IS_ERR(vol_args))
 		return PTR_ERR(vol_args);
@@ -3261,6 +3273,12 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
 		return -EINVAL;
 	}
 
+	if (fs_info->fs_devices->virtual_fsid) {
+		btrfs_err(fs_info,
+			  "device replace is unsupported on devices mounted with virtual fsid\n");
+		return -EINVAL;
+	}
+
 	p = memdup_user(arg, sizeof(*p));
 	if (IS_ERR(p))
 		return PTR_ERR(p);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 366fb4cde145..8d9df169107a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -115,6 +115,7 @@ enum {
 	Opt_thread_pool,
 	Opt_treelog, Opt_notreelog,
 	Opt_user_subvol_rm_allowed,
+	Opt_virtual_fsid,
 
 	/* Rescue options */
 	Opt_rescue,
@@ -188,6 +189,7 @@ static const match_table_t tokens = {
 	{Opt_treelog, "treelog"},
 	{Opt_notreelog, "notreelog"},
 	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
+	{Opt_virtual_fsid, "virtual_fsid"},
 
 	/* Rescue options */
 	{Opt_rescue, "rescue=%s"},
@@ -352,9 +354,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		case Opt_subvol_empty:
 		case Opt_subvolid:
 		case Opt_device:
+		case Opt_virtual_fsid:
 			/*
 			 * These are parsed by btrfs_parse_subvol_options or
-			 * btrfs_parse_device_options and can be ignored here.
+			 * btrfs_parse_early_options and can be ignored here.
 			 */
 			break;
 		case Opt_nodatasum:
@@ -845,9 +848,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
  * All other options will be parsed on much later in the mount process and
  * only when we need to allocate a new super block.
  */
-static int btrfs_parse_device_options(const char *options, fmode_t flags,
-				      void *holder)
+static int btrfs_parse_early_options(const char *options, fmode_t flags,
+				    bool *virtual_fsid, void *holder)
 {
+	struct btrfs_scan_info info = { .vfsid = false };
 	substring_t args[MAX_OPT_ARGS];
 	char *device_name, *opts, *orig, *p;
 	struct btrfs_device *device = NULL;
@@ -874,14 +878,18 @@ static int btrfs_parse_device_options(const char *options, fmode_t flags,
 			continue;
 
 		token = match_token(p, tokens, args);
+
+		if (token == Opt_virtual_fsid)
+			(*virtual_fsid) = true;
+
 		if (token == Opt_device) {
 			device_name = match_strdup(&args[0]);
 			if (!device_name) {
 				error = -ENOMEM;
 				goto out;
 			}
-			device = btrfs_scan_one_device(device_name, flags,
-					holder);
+			info.path = device_name;
+			device = btrfs_scan_one_device(&info, flags, holder);
 			kfree(device_name);
 			if (IS_ERR(device)) {
 				error = PTR_ERR(device);
@@ -913,7 +921,7 @@ static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
 
 	/*
 	 * strsep changes the string, duplicate it because
-	 * btrfs_parse_device_options gets called later
+	 * btrfs_parse_early_options gets called later
 	 */
 	opts = kstrdup(options, GFP_KERNEL);
 	if (!opts)
@@ -1431,6 +1439,7 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
 static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		int flags, const char *device_name, void *data)
 {
+	struct btrfs_scan_info info = { .path = NULL, .vfsid = false};
 	struct block_device *bdev = NULL;
 	struct super_block *s;
 	struct btrfs_device *device = NULL;
@@ -1472,13 +1481,14 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	}
 
 	mutex_lock(&uuid_mutex);
-	error = btrfs_parse_device_options(data, mode, fs_type);
+	error = btrfs_parse_early_options(data, mode, &info.vfsid, fs_type);
 	if (error) {
 		mutex_unlock(&uuid_mutex);
 		goto error_fs_info;
 	}
 
-	device = btrfs_scan_one_device(device_name, mode, fs_type);
+	info.path = device_name;
+	device = btrfs_scan_one_device(&info, mode, fs_type);
 	if (IS_ERR(device)) {
 		mutex_unlock(&uuid_mutex);
 		error = PTR_ERR(device);
@@ -2169,6 +2179,7 @@ static int btrfs_control_open(struct inode *inode, struct file *file)
 static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 				unsigned long arg)
 {
+	struct btrfs_scan_info info = { .vfsid = false };
 	struct btrfs_ioctl_vol_args *vol;
 	struct btrfs_device *device = NULL;
 	dev_t devt = 0;
@@ -2182,10 +2193,11 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		return PTR_ERR(vol);
 	vol->name[BTRFS_PATH_NAME_MAX] = '\0';
 
+	info.path = vol->name;
 	switch (cmd) {
 	case BTRFS_IOC_SCAN_DEV:
 		mutex_lock(&uuid_mutex);
-		device = btrfs_scan_one_device(vol->name, FMODE_READ,
+		device = btrfs_scan_one_device(&info, FMODE_READ,
 					       &btrfs_root_fs_type);
 		ret = PTR_ERR_OR_ZERO(device);
 		mutex_unlock(&uuid_mutex);
@@ -2200,7 +2212,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		break;
 	case BTRFS_IOC_DEVICES_READY:
 		mutex_lock(&uuid_mutex);
-		device = btrfs_scan_one_device(vol->name, FMODE_READ,
+		device = btrfs_scan_one_device(&info, FMODE_READ,
 					       &btrfs_root_fs_type);
 		if (IS_ERR(device)) {
 			mutex_unlock(&uuid_mutex);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6d592870400..5a38b3482ec5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -745,6 +745,33 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
 
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
+	pr_info("BTRFS: virtual fsid (%pU) set for device %s (real fsid %pU)\n",
+		disk_super->fsid, path, disk_super->metadata_uuid);
+}
+
 /*
  * Add new device to list of registered devices
  *
@@ -752,12 +779,15 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
  * device pointer which was just added or updated when successful
  * error pointer when failed
  */
-static noinline struct btrfs_device *device_list_add(const char *path,
-			   struct btrfs_super_block *disk_super,
-			   bool *new_device_added)
+static noinline
+struct btrfs_device *device_list_add(const struct btrfs_scan_info *info,
+				     struct btrfs_super_block *disk_super,
+				     bool *new_device_added)
 {
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *fs_devices = NULL;
+	const char *path = info->path;
+	const bool virtual_fsid = info->vfsid;
 	struct rcu_string *name;
 	u64 found_transid = btrfs_super_generation(disk_super);
 	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
@@ -775,12 +805,25 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		return ERR_PTR(error);
 	}
 
+	if (virtual_fsid) {
+		if (has_metadata_uuid || fsid_change_in_progress) {
+			btrfs_err(NULL,
+			  "failed to add device %s with virtual fsid (%s)\n",
+				  path, (has_metadata_uuid ?
+					 "the fs already has a metadata_uuid" :
+					 "fsid change in progress"));
+			return ERR_PTR(-EINVAL);
+		}
+
+		prepare_virtual_fsid(disk_super, path);
+	}
+
 	if (fsid_change_in_progress) {
 		if (!has_metadata_uuid)
 			fs_devices = find_fsid_inprogress(disk_super);
 		else
 			fs_devices = find_fsid_changed(disk_super);
-	} else if (has_metadata_uuid) {
+	} else if (has_metadata_uuid || virtual_fsid) {
 		fs_devices = find_fsid_with_metadata_uuid(disk_super);
 	} else {
 		fs_devices = find_fsid_reverted_metadata(disk_super);
@@ -790,7 +833,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 
 
 	if (!fs_devices) {
-		if (has_metadata_uuid)
+		if (has_metadata_uuid || virtual_fsid)
 			fs_devices = alloc_fs_devices(disk_super->fsid,
 						      disk_super->metadata_uuid);
 		else
@@ -799,6 +842,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		if (IS_ERR(fs_devices))
 			return ERR_CAST(fs_devices);
 
+		fs_devices->virtual_fsid = virtual_fsid;
 		fs_devices->fsid_change = fsid_change_in_progress;
 
 		mutex_lock(&fs_devices->device_list_mutex);
@@ -870,11 +914,21 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	"BTRFS: device label %s devid %llu transid %llu %s scanned by %s (%d)\n",
 				disk_super->label, devid, found_transid, path,
 				current->comm, task_pid_nr(current));
-		else
-			pr_info(
+		else {
+			if (virtual_fsid)
+				pr_info(
+"BTRFS: device with virtual fsid %pU (real fsid %pU) devid %llu transid %llu %s scanned by %s (%d)\n",
+					disk_super->fsid,
+					disk_super->metadata_uuid, devid,
+					found_transid, path, current->comm,
+					task_pid_nr(current));
+			else
+				pr_info(
 	"BTRFS: device fsid %pU devid %llu transid %llu %s scanned by %s (%d)\n",
-				disk_super->fsid, devid, found_transid, path,
-				current->comm, task_pid_nr(current));
+					disk_super->fsid, devid, found_transid,
+					path, current->comm,
+					task_pid_nr(current));
+		}
 
 	} else if (!device->name || strcmp(device->name->str, path)) {
 		/*
@@ -1348,8 +1402,8 @@ int btrfs_forget_devices(dev_t devt)
  * and we are not allowed to call set_blocksize during the scan. The superblock
  * is read via pagecache
  */
-struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
-					   void *holder)
+struct btrfs_device *btrfs_scan_one_device(const struct btrfs_scan_info *info,
+					   fmode_t flags, void *holder)
 {
 	struct btrfs_super_block *disk_super;
 	bool new_device_added = false;
@@ -1377,7 +1431,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	 * values temporarily, as the device paths of the fsid are the only
 	 * required information for assembling the volume.
 	 */
-	bdev = blkdev_get_by_path(path, flags, holder);
+	bdev = blkdev_get_by_path(info->path, flags, holder);
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
 
@@ -1394,7 +1448,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 		goto error_bdev_put;
 	}
 
-	device = device_list_add(path, disk_super, &new_device_added);
+	device = device_list_add(info, disk_super, &new_device_added);
 	if (!IS_ERR(device) && new_device_added)
 		btrfs_free_stale_devices(device->devt, device);
 
@@ -2390,6 +2444,12 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 
 	args->devid = btrfs_stack_device_id(&disk_super->dev_item);
 	memcpy(args->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE);
+
+	/*
+	 * Notice that the virtual_fsid feature is not handled here; device
+	 * removal/replace is instead forbidden when such feature is in-use,
+	 * but this note is for future users of btrfs_get_dev_args_from_path().
+	 */
 	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
 		memcpy(args->fsid, disk_super->metadata_uuid, BTRFS_FSID_SIZE);
 	else
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 7e51f2238f72..f2354e8288f9 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -73,6 +73,11 @@ enum btrfs_raid_types {
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 #define BTRFS_DEV_STATE_NO_READA	(5)
 
+struct btrfs_scan_info {
+	const char *path;
+	bool vfsid;
+};
+
 struct btrfs_zoned_device_info;
 
 struct btrfs_device {
@@ -278,6 +283,7 @@ struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
 	bool fsid_change;
+	bool virtual_fsid;
 	struct list_head fs_list;
 
 	/*
@@ -537,7 +543,7 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       fmode_t flags, void *holder);
-struct btrfs_device *btrfs_scan_one_device(const char *path,
+struct btrfs_device *btrfs_scan_one_device(const struct btrfs_scan_info *info,
 					   fmode_t flags, void *holder);
 int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
-- 
2.40.0

