Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1B76EE80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 17:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbjHCPpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 11:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbjHCPpT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:45:19 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970C8E46;
        Thu,  3 Aug 2023 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uzP7UXLX5/VT/n6cYOegUOZi54+OqutmMNOZMMzFZ4g=; b=GPePsTm97PHIlLUznJ0HNjOsXi
        01cRWwTh22HqB4TRFXYl5cUp+GflJjiRpf8zaI1S4xFtz7zskClU3Ay2PScfZNelaVVArF+YbE4AF
        Taj8RrUCUKIkCOQbY1x0jsGvrU70WTok/9U2Fh6M7eq7DUtnbhbnymcmWcApAAMLaS0xv5pkmZKfN
        dACLlKjCF1DqqMix1mj5gnpPSu2nvM3qxyl24KK4fKOfE6qOzI38o4dtGGDIInY10JZgPppSJ7gP9
        28ZeHeM3ueU+guUvCDN1iCgThcFffVBdRLBCDwNTL6N/WCujRDhKdRDJJjq4k4FWTu8RTx+jwIIMh
        vR0GQThg==;
Received: from [201.92.22.215] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qRaVl-00Bty6-GA; Thu, 03 Aug 2023 17:45:14 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        gpiccoli@igalia.com, kernel-dev@igalia.com, anand.jain@oracle.com,
        david@fromorbit.com, kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: [PATCH 1/3] btrfs-progs: Add the single-dev feature (to both mkfs/tune)
Date:   Thu,  3 Aug 2023 12:43:39 -0300
Message-ID: <20230803154453.1488248-2-gpiccoli@igalia.com>
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

The single-dev feature allows a device to be mounted regardless of
its fsid already being present in another device - in other words,
this feature disables RAID modes / metadata_uuid, allowing a single
device per filesystem. Its goal is mainly to allow mounting the
same fsid at the same time in the system.

Introduce hereby the feature to both mkfs (-O single-dev) and
btrfstune (-s), syncing the kernel-shared headers as well. The
feature is a compat_ro, its kernel version was set to v6.5.

Suggested-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

Hi folks, thanks in advance for reviews! Notice that I've added
the feature to btrfstune as well, but I found docs online saying
this tool is deprecated..so not sure if that was the proper approach.

Also, a design decision: I've skipped the btrfs_register_one_device()
call when mkfs was just used with the single-dev tuning, or else
it shows a (harmless) error and succeeds, since of course scanning
fails for such devices, as per the feature implementation.
So, I thought it was more straightforward to just skip the call itself.

Cheers,

Guilherme

 common/fsfeatures.c        |  7 ++++
 kernel-shared/ctree.h      |  3 +-
 kernel-shared/uapi/btrfs.h |  7 ++++
 mkfs/main.c                |  4 ++-
 tune/main.c                | 72 +++++++++++++++++++++++---------------
 5 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 00658fa5159f..a320b7062b8c 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -160,6 +160,13 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "RAID1 with 3 or 4 copies"
 	},
+	{
+		.name		= "single-dev",
+		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV,
+		.sysfs_name	= "single_dev",
+		VERSION_TO_STRING2(compat, 6,5),
+		.desc		= "single device (allows same fsid mounting)"
+	},
 #ifdef BTRFS_ZONED
 	{
 		.name		= "zoned",
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 59533879b939..e3fd834aa6dd 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -86,7 +86,8 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
 	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
 	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
-	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
+	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE |	\
+	 BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV)
 
 #if EXPERIMENTAL
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index 85b04f89a2a9..2e0ee6ef6446 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -336,6 +336,13 @@ _static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
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
diff --git a/mkfs/main.c b/mkfs/main.c
index 972ed1112ea6..429799932224 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1025,6 +1025,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	char *label = NULL;
 	int nr_global_roots = sysconf(_SC_NPROCESSORS_ONLN);
 	char *source_dir = NULL;
+	bool single_dev;
 
 	cpu_detect_flags();
 	hash_init_accel();
@@ -1218,6 +1219,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		usage(&mkfs_cmd, 1);
 
 	opt_zoned = !!(features.incompat_flags & BTRFS_FEATURE_INCOMPAT_ZONED);
+	single_dev = !!(features.compat_ro_flags & BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV);
 
 	if (source_dir && device_count > 1) {
 		error("the option -r is limited to a single device");
@@ -1815,7 +1817,7 @@ out:
 		device_count = argc - optind;
 		while (device_count-- > 0) {
 			file = argv[optind++];
-			if (path_is_block_device(file) == 1)
+			if (path_is_block_device(file) == 1 && !single_dev)
 				btrfs_register_one_device(file);
 		}
 	}
diff --git a/tune/main.c b/tune/main.c
index 0ca1e01282c9..95e55fcda44f 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -42,27 +42,31 @@
 #include "tune/tune.h"
 #include "check/clear-cache.h"
 
+#define SET_SUPER_FLAGS(type) \
+static int set_super_##type##_flags(struct btrfs_root *root, u64 flags) \
+{									\
+	struct btrfs_trans_handle *trans;				\
+	struct btrfs_super_block *disk_super;				\
+	u64 super_flags;						\
+	int ret;							\
+									\
+	disk_super = root->fs_info->super_copy;				\
+	super_flags = btrfs_super_##type##_flags(disk_super);		\
+	super_flags |= flags;						\
+	trans = btrfs_start_transaction(root, 1);			\
+	BUG_ON(IS_ERR(trans));						\
+	btrfs_set_super_##type##_flags(disk_super, super_flags);	\
+	ret = btrfs_commit_transaction(trans, root);			\
+									\
+	return ret;							\
+}
+
+SET_SUPER_FLAGS(incompat)
+SET_SUPER_FLAGS(compat_ro)
+
 static char *device;
 static int force = 0;
 
-static int set_super_incompat_flags(struct btrfs_root *root, u64 flags)
-{
-	struct btrfs_trans_handle *trans;
-	struct btrfs_super_block *disk_super;
-	u64 super_flags;
-	int ret;
-
-	disk_super = root->fs_info->super_copy;
-	super_flags = btrfs_super_incompat_flags(disk_super);
-	super_flags |= flags;
-	trans = btrfs_start_transaction(root, 1);
-	BUG_ON(IS_ERR(trans));
-	btrfs_set_super_incompat_flags(disk_super, super_flags);
-	ret = btrfs_commit_transaction(trans, root);
-
-	return ret;
-}
-
 static int convert_to_fst(struct btrfs_fs_info *fs_info)
 {
 	int ret;
@@ -102,6 +106,7 @@ static const char * const tune_usage[] = {
 	OPTLINE("-r", "enable extended inode refs (mkfs: extref, for hardlink limits)"),
 	OPTLINE("-x", "enable skinny metadata extent refs (mkfs: skinny-metadata)"),
 	OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more efficient sparse file representation)"),
+	OPTLINE("-s", "enable single device feature (mkfs: single-dev, allows same fsid mounting)"),
 	OPTLINE("-S <0|1>", "set/unset seeding status of a device"),
 	OPTLINE("--convert-to-block-group-tree", "convert filesystem to track block groups in "
 			"the separate block-group-tree instead of extent tree (sets the incompat bit)"),
@@ -146,7 +151,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	int csum_type = -1;
 	char *new_fsid_str = NULL;
 	int ret;
-	u64 super_flags = 0;
+	u64 compat_ro_flags = 0;
+	u64 incompat_flags = 0;
 	int fd = -1;
 
 	btrfs_config_init();
@@ -169,7 +175,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 #endif
 			{ NULL, 0, NULL, 0 }
 		};
-		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
+		int c = getopt_long(argc, argv, "S:rxfuU:nsmM:", long_options, NULL);
 
 		if (c < 0)
 			break;
@@ -179,13 +185,16 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			seeding_value = arg_strtou64(optarg);
 			break;
 		case 'r':
-			super_flags |= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF;
+			incompat_flags |= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF;
 			break;
 		case 'x':
-			super_flags |= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
+			incompat_flags |= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
 			break;
 		case 'n':
-			super_flags |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
+			incompat_flags |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
+			break;
+		case 's':
+			compat_ro_flags |= BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV;
 			break;
 		case 'f':
 			force = 1;
@@ -239,9 +248,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		error("random fsid can't be used with specified fsid");
 		return 1;
 	}
-	if (!super_flags && !seeding_flag && !(random_fsid || new_fsid_str) &&
-	    !change_metadata_uuid && csum_type == -1 && !to_bg_tree &&
-	    !to_extent_tree && !to_fst) {
+	if (!compat_ro_flags && !incompat_flags && !seeding_flag &&
+	    !(random_fsid || new_fsid_str) && !change_metadata_uuid &&
+	    csum_type == -1 && !to_bg_tree && !to_extent_tree && !to_fst) {
 		error("at least one option should be specified");
 		usage(&tune_cmd, 1);
 		return 1;
@@ -363,8 +372,15 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		total++;
 	}
 
-	if (super_flags) {
-		ret = set_super_incompat_flags(root, super_flags);
+	if (incompat_flags) {
+		ret = set_super_incompat_flags(root, incompat_flags);
+		if (!ret)
+			success++;
+		total++;
+	}
+
+	if (compat_ro_flags) {
+		ret = set_super_compat_ro_flags(root, compat_ro_flags);
 		if (!ret)
 			success++;
 		total++;
-- 
2.41.0

