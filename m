Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D5476EE85
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 17:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbjHCPpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbjHCPpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:45:33 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0973582;
        Thu,  3 Aug 2023 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pcNm2tGAu/WGE5Yp4ptBPcu3Aj2mc+V2YQ93YaHjPbA=; b=MGgek6bKJYJGB6q5NaDjncOFWW
        w8Pb7gdLYpWPD6Wm7XenLRfiXnr20dYUMXu0Z9DYdbQzbNCEaUsaK8D5W7OaHy5E5tjHyxRKiHkjX
        De05WpGEvvaSETbptTeKmLkBzZOZaAP3q/lTbCcAjHI9LRKTsnvpovZJZv3vmVJEzsYUqEIQvZJzN
        981hVxC8SCPGWOUeQ4bZcDB9fq5rZzUDjOBs763miMPNuEqbYFp+rQAFmr/spDH1XuLaHZrqx8Tvt
        foC9wwEJ0wESByQDE+UYld38iu8TlsvKlWjTQseOoP3lXKsZ6Gm0pl5Aiu5ZEyi7a3AThxpYsLY1Z
        2wi8vWgw==;
Received: from [201.92.22.215] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qRaW0-00Btyc-I0; Thu, 03 Aug 2023 17:45:29 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        gpiccoli@igalia.com, kernel-dev@igalia.com, anand.jain@oracle.com,
        david@fromorbit.com, kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: [PATCH 3/3] btrfs: Add parameter to force devices behave as single-dev ones
Date:   Thu,  3 Aug 2023 12:43:41 -0300
Message-ID: <20230803154453.1488248-4-gpiccoli@igalia.com>
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

Devices with the single-dev feature enabled in their superblock are
allowed to be mounted regardless of their fsid being already present
in the system - the goal of such feature is to have the device in a
single mode with no advanced features, like RAID; it is a compat_ro
feature present since kernel v6.5.

The thing is that such feature comes in the form of a superblock flag,
so devices that doesn't have it set, can't use the feature of course.
The Steam Deck console aims to have block-based updates in its
RO rootfs, and given its A/B partition nature, both block devices are
required to be the same for their hash to match, so it's not possible
to compare two images if one has this feature set in the superblock,
while the other has not. So if we end-up having two old images, we
couldn't make use of the single-dev feature to mount both at same time,
or if we set the flag in one of them to enable the feature, we break
the block-based hash comparison.

We propose here a module parameter approach to allow forcing any given
path (to a device holding a btrfs filesystem) behaving as a single-dev
device. That would useful for cases like the Steam Deck one, or for
debug purposes. If the filesystem already has the compat_ro flag set
in its superblock, the parameter is no-op.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 fs/btrfs/disk-io.c |  2 +-
 fs/btrfs/ioctl.c   |  6 +++---
 fs/btrfs/super.c   |  5 +++++
 fs/btrfs/super.h   |  2 ++
 fs/btrfs/volumes.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/volumes.h |  2 ++
 6 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 455fa4949c98..8df1defa1ede 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2378,7 +2378,7 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 	 * in the disk. That's the reason we're required here to compare the
 	 * fsid with the metadata_uuid for such devices.
 	 */
-	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV))
+	if (fs_info->fs_devices->single_dev)
 		fsid = fs_info->fs_devices->metadata_uuid;
 	else
 		fsid = fs_info->fs_devices->fsid;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 56703d87def9..4fc63e802b08 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2678,7 +2678,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
+	if (fs_info->fs_devices->single_dev) {
 		btrfs_err(fs_info,
 			  "device removal is unsupported on SINGLE_DEV devices\n");
 		return -EINVAL;
@@ -2750,7 +2750,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
+	if (fs_info->fs_devices->single_dev) {
 		btrfs_err(fs_info,
 			  "device removal is unsupported on SINGLE_DEV devices\n");
 		return -EINVAL;
@@ -3280,7 +3280,7 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
+	if (fs_info->fs_devices->single_dev) {
 		btrfs_err(fs_info,
 			  "device removal is unsupported on SINGLE_DEV devices\n");
 		return -EINVAL;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ee87189b1ccd..3cfc9c63360f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -62,6 +62,11 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
+char *force_single_dev;
+module_param(force_single_dev, charp, 0444);
+MODULE_PARM_DESC(force_single_dev,
+	"User list of devices to force acting as single-dev (comma separated)");
+
 static const struct super_operations btrfs_super_ops;
 
 /*
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index 8dbb909b364f..c855127600c8 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_SUPER_H
 #define BTRFS_SUPER_H
 
+extern char *force_single_dev;
+
 int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 433a490f2de8..06c5bad77bdf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -12,6 +12,7 @@
 #include <linux/uuid.h>
 #include <linux/list_sort.h>
 #include <linux/namei.h>
+#include <linux/string.h>
 #include "misc.h"
 #include "ctree.h"
 #include "extent_map.h"
@@ -865,6 +866,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			return ERR_CAST(fs_devices);
 
 		fs_devices->fsid_change = fsid_change_in_progress;
+		fs_devices->single_dev = single_dev;
 
 		mutex_lock(&fs_devices->device_list_mutex);
 		list_add(&fs_devices->fs_list, &fs_uuids);
@@ -1399,6 +1401,45 @@ int btrfs_forget_devices(dev_t devt)
 	return ret;
 }
 
+/*
+ * SINGLE_DEV is a compat_ro feature, but we also have the force_single_dev
+ * module parameter in order to allow forcing a device to behave as single-dev,
+ * so old filesystems could also get mounted in a same-fsid mounting way.
+ */
+
+static bool is_single_dev(const char *path, struct btrfs_super_block *sb)
+{
+
+	if (btrfs_super_compat_ro_flags(sb) & BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV)
+		return true;
+
+	if (force_single_dev) {
+		char *p, *skip_devs, *orig;
+
+		skip_devs = kstrdup(force_single_dev, GFP_KERNEL);
+		if (!skip_devs) {
+			pr_err("BTRFS: couldn't parse force_single_dev parameter\n");
+			return false;
+		}
+
+		orig = skip_devs;
+		while ((p = strsep(&skip_devs, ",")) != NULL) {
+			if (!*p)
+				continue;
+
+			if (!strcmp(p, path)) {
+				pr_info(
+			"BTRFS: forcing device %s to be single-dev\n", path);
+				kfree(orig);
+				return true;
+			}
+		}
+		kfree(orig);
+	}
+
+	return false;
+}
+
 /*
  * Look for a btrfs signature on a device. This may be called out of the mount path
  * and we are not allowed to call set_blocksize during the scan. The superblock
@@ -1451,9 +1492,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto error_bdev_put;
 	}
 
-	single_dev = btrfs_super_compat_ro_flags(disk_super) &
-			BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV;
-
+	single_dev = is_single_dev(path, disk_super);
 	if (!mounting && single_dev) {
 		pr_info("BTRFS: skipped non-mount scan on SINGLE_DEV device %s\n",
 			path);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b9856c801567..57a3969f101c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -293,6 +293,8 @@ struct btrfs_fs_devices {
 	 */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
 
+	bool single_dev;
+
 	struct list_head fs_list;
 
 	/*
-- 
2.41.0

