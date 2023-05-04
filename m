Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5513B6F7077
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 19:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjEDRIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 13:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjEDRIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 13:08:47 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E0E4225;
        Thu,  4 May 2023 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pmckdOpDeH35/MapFJ+LqwY/p5loLTbra3jToW/0uZc=; b=rmnTEa8ubCFmYx5Uk5gbg4DrQi
        c8/yqDC6lg00Rk7ch2cAuQ5zJUHJaCsx+Tk3fEkA5k/EJDoig+IgW+wO/cpL9LxocKFHjYVrl36Fc
        m3o6Hpi2H1NNhYjniewLIE+wNNxMdsIBvCWTvRsqs2Gi+C5sN6YW9OPcvsuvO9MMBgMMD5HIZdNaR
        s30OYKNKnxxaBFX7wQRbDwk4EWRE+a6PWDCIIvLjAiDxRTDh8TeQEO9NrkhYg9LX2tqutclRpwWdL
        b53sLXk3UGXiScVqGtvXEtml/F9q6i59xJVUQpgmD5K1v2DoGD9H54vWhNTBPDyI0+l2crrumO7D/
        ETokcUEw==;
Received: from [177.189.3.64] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pucRe-001H7p-Oi; Thu, 04 May 2023 19:08:44 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 2/2] btrfs: Add module parameter to enable non-mount scan skipping
Date:   Thu,  4 May 2023 14:07:08 -0300
Message-Id: <20230504170708.787361-3-gpiccoli@igalia.com>
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

In case there are 2 btrfs filesystems holding the same fsid but in
different block devices, the ioctl-based scanning prevents their
peaceful coexistence, due to checks during the device add to the fsid
list. Imagine an A/B partitioned OS, like in mobile devices or the Steam
Deck - if we have both partitions holding the exact same image, depending
on the order that udev triggers the scan and the filesystem generation
number, the users potentially won't be able to mount one of them, even
if the other was never mounted.

To avoid this case, introduce a btrfs parameter to allow users to select
devices to be excluded of non-mount scanning. The module parameter
"skip_scan=%s" accepts full device paths comma-separated, the same paths
passed as a parameter to btrfs_scan_one_device(). If a scan procedure
wasn't triggered from the mount path (meaning it was ioctl-based) and
the "skip_scan" parameter contains a valid device path, such device
scanning is skipped and this is informed on dmesg.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

Some design choices that should be discussed here:

(1) We could either have it as a parameter, or a flag in the superblock
(like the metadata_uuid) - the parameter approach seemed easier / less
invasive, but I might be wrong - appreciate feedback on this.

(2) The parameter name of course is irrelevant and if somebody has a
better idea for the name, I'm upfront okay with that =)

(3) Again, no documentation is provided here - appreciate suggestions
on how to proper document changes to btrfs (wiki, I assume?).

Thanks in advance for reviews and suggestions,

Guilherme


 fs/btrfs/super.c   | 13 +++++++++----
 fs/btrfs/super.h   |  1 +
 fs/btrfs/volumes.c | 27 ++++++++++++++++++++++++++-
 fs/btrfs/volumes.h |  3 ++-
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 8d9df169107a..4532cbc2bb57 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -62,6 +62,11 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
+char *skip_scan;
+module_param(skip_scan, charp, 0444);
+MODULE_PARM_DESC(skip_scan,
+		 "User list of devices to be skipped in non mount induced scans (comma separated)");
+
 static const struct super_operations btrfs_super_ops;
 
 /*
@@ -889,7 +894,7 @@ static int btrfs_parse_early_options(const char *options, fmode_t flags,
 				goto out;
 			}
 			info.path = device_name;
-			device = btrfs_scan_one_device(&info, flags, holder);
+			device = btrfs_scan_one_device(&info, flags, holder, true);
 			kfree(device_name);
 			if (IS_ERR(device)) {
 				error = PTR_ERR(device);
@@ -1488,7 +1493,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	}
 
 	info.path = device_name;
-	device = btrfs_scan_one_device(&info, mode, fs_type);
+	device = btrfs_scan_one_device(&info, mode, fs_type, true);
 	if (IS_ERR(device)) {
 		mutex_unlock(&uuid_mutex);
 		error = PTR_ERR(device);
@@ -2198,7 +2203,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 	case BTRFS_IOC_SCAN_DEV:
 		mutex_lock(&uuid_mutex);
 		device = btrfs_scan_one_device(&info, FMODE_READ,
-					       &btrfs_root_fs_type);
+					       &btrfs_root_fs_type, false);
 		ret = PTR_ERR_OR_ZERO(device);
 		mutex_unlock(&uuid_mutex);
 		break;
@@ -2213,7 +2218,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 	case BTRFS_IOC_DEVICES_READY:
 		mutex_lock(&uuid_mutex);
 		device = btrfs_scan_one_device(&info, FMODE_READ,
-					       &btrfs_root_fs_type);
+					       &btrfs_root_fs_type, false);
 		if (IS_ERR(device)) {
 			mutex_unlock(&uuid_mutex);
 			ret = PTR_ERR(device);
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index 8dbb909b364f..6eddd196bb51 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -3,6 +3,7 @@
 #ifndef BTRFS_SUPER_H
 #define BTRFS_SUPER_H
 
+extern char *skip_scan;
 int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5a38b3482ec5..53da2ebb246c 100644
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
@@ -1403,7 +1404,8 @@ int btrfs_forget_devices(dev_t devt)
  * is read via pagecache
  */
 struct btrfs_device *btrfs_scan_one_device(const struct btrfs_scan_info *info,
-					   fmode_t flags, void *holder)
+					   fmode_t flags, void *holder,
+					   bool mounting)
 {
 	struct btrfs_super_block *disk_super;
 	bool new_device_added = false;
@@ -1414,6 +1416,29 @@ struct btrfs_device *btrfs_scan_one_device(const struct btrfs_scan_info *info,
 
 	lockdep_assert_held(&uuid_mutex);
 
+	if (!mounting && skip_scan) {
+		char *p, *skip_devs, *orig;
+
+		skip_devs = kstrdup(skip_scan, GFP_KERNEL);
+		if (!skip_devs)
+			return ERR_PTR(-ENOMEM);
+
+		orig = skip_devs;
+		while ((p = strsep(&skip_devs, ",")) != NULL) {
+			if (!*p)
+				continue;
+
+			if (!strcmp(p, info->path)) {
+				pr_info(
+	"BTRFS: skipped non-mount scan on device %s due to module parameter\n",
+					info->path);
+				kfree(orig);
+				return ERR_PTR(-EINVAL);
+			}
+		}
+		kfree(orig);
+	}
+
 	/*
 	 * we would like to check all the supers, but that would make
 	 * a btrfs mount succeed after a mkfs from a different FS.
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f2354e8288f9..3e83565b326a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -544,7 +544,8 @@ void btrfs_mapping_tree_free(struct extent_map_tree *tree);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       fmode_t flags, void *holder);
 struct btrfs_device *btrfs_scan_one_device(const struct btrfs_scan_info *info,
-					   fmode_t flags, void *holder);
+					   fmode_t flags, void *holder,
+					   bool mounting);
 int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
-- 
2.40.0

