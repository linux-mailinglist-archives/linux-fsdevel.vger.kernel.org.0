Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424D479F524
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 00:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjIMWo2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 18:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIMWo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:44:27 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAFB1BCB;
        Wed, 13 Sep 2023 15:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=k4H54/p/Genq+SU3jawRyC8suI8WmC/MurTdqUSDtC4=; b=icxWefqszQ19dcKNLCM9Xx1Fhi
        il85CkEWDQslw/3hJR5TdaNsbuq07UYyaDcLstIvqB5LoCHMwvVRzPoyocpXPF/AZINbDA/Gfd8Lj
        kqbfmD6QWVyWZvXv1qQs3HtPNsWGnNQKIjTHLROs9CtZmpRutob6w3+zthH0+ZbRLCXYoeJCF/fDs
        R0OvB22nKe6B69aE7ndl13+FJE4d6336Kw1mhPZaN0UmbaB0DCYCEREiFoDgAIwnOl0KB5PlWN9Tp
        I0znL1X6teWcYeHnSnmSBu5To5YQuS2gx5p6NvXVi05H4g6Iwu5xLkQr9LNv56mqf3HDyuLEn7FAO
        eOYMnEaA==;
Received: from [187.116.122.196] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qgYap-003Z6w-4L; Thu, 14 Sep 2023 00:44:20 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        dsterba@suse.cz, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, anand.jain@oracle.com,
        david@fromorbit.com, kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH v4 1/2] btrfs-progs: Add the temp-fsid feature (to both mkfs/tune)
Date:   Wed, 13 Sep 2023 19:36:15 -0300
Message-ID: <20230913224402.3940543-2-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913224402.3940543-1-gpiccoli@igalia.com>
References: <20230913224402.3940543-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The temp-fsid feature allows a device to be mounted regardless of
its fsid already being present in another device - in other words,
this feature disables RAID modes / metadata_uuid, allowing users
to mount the same fsid at the same time in the system.

Introduce hereby the feature to both mkfs (-O temp-fsid) and
btrfstune (--convert-to-temp-fsid), syncing the kernel-shared
headers as well. The feature is a compat_ro, its kernel version was
set to v6.7.

Suggested-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V4:

- Rebased against v6.5.1, taking into account the patch
("tune: do not allow multiple incompatible features to be set");
created a new group for this feature;

- Renamed the feature to temp-fsid;

- Moved kernel version compat to 6.7.

V3: https://lore.kernel.org/linux-btrfs/20230831001544.3379273-1-gpiccoli@igalia.com/


 common/fsfeatures.c        |  7 ++++
 kernel-shared/ctree.h      |  3 +-
 kernel-shared/uapi/btrfs.h |  7 ++++
 mkfs/main.c                |  4 ++-
 tune/main.c                | 72 +++++++++++++++++++++++++-------------
 5 files changed, 66 insertions(+), 27 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 1c993b594288..e39aa0a622be 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -161,6 +161,13 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "RAID1 with 3 or 4 copies"
 	},
+	{
+		.name		= "temp-fsid",
+		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_TEMP_FSID,
+		.sysfs_name	= "temp_fsid",
+		VERSION_TO_STRING2(compat, 6,7),
+		.desc		= "temp fsid (allows same fsid mounting)"
+	},
 #ifdef BTRFS_ZONED
 	{
 		.name		= "zoned",
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 59533879b939..ca5777f0098b 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -86,7 +86,8 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
 	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
 	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
-	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
+	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE |	\
+	 BTRFS_FEATURE_COMPAT_RO_TEMP_FSID)
 
 #if EXPERIMENTAL
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index 85b04f89a2a9..8c3e47e7d711 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -336,6 +336,13 @@ _static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
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
diff --git a/mkfs/main.c b/mkfs/main.c
index 1c5d668e1e02..911daafefb1c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1025,6 +1025,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	char *label = NULL;
 	int nr_global_roots = sysconf(_SC_NPROCESSORS_ONLN);
 	char *source_dir = NULL;
+	bool temp_fsid;
 
 	cpu_detect_flags();
 	hash_init_accel();
@@ -1218,6 +1219,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		usage(&mkfs_cmd, 1);
 
 	opt_zoned = !!(features.incompat_flags & BTRFS_FEATURE_INCOMPAT_ZONED);
+	temp_fsid = !!(features.compat_ro_flags & BTRFS_FEATURE_COMPAT_RO_TEMP_FSID);
 
 	if (source_dir && device_count > 1) {
 		error("the option -r is limited to a single device");
@@ -1815,7 +1817,7 @@ out:
 		device_count = argc - optind;
 		while (device_count-- > 0) {
 			file = argv[optind++];
-			if (path_is_block_device(file) == 1)
+			if (path_is_block_device(file) == 1 && !temp_fsid)
 				btrfs_register_one_device(file);
 		}
 	}
diff --git a/tune/main.c b/tune/main.c
index 63539b991528..6194b0f2b0b1 100644
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
@@ -108,6 +112,8 @@ static const char * const tune_usage[] = {
 	OPTLINE("--convert-from-block-group-tree",
 			"convert the block group tree back to extent tree (remove the incompat bit)"),
 	OPTLINE("--convert-to-free-space-tree", "convert filesystem to use free space tree (v2 cache)"),
+	OPTLINE("--convert-to-temp-fsid", "enable the temp fsid feature "
+			"(mkfs: temp-fsid, allows same fsid mounting)"),
 	"",
 	"UUID changes:",
 	OPTLINE("-u", "rewrite fsid, use a random one"),
@@ -145,6 +151,9 @@ enum btrfstune_group_enum {
 	/* Csum conversion */
 	CSUM_CHANGE,
 
+	/* TEMP_FSID devices */
+	TEMP_FSID,
+
 	/*
 	 * Legacy features (which later become default), including:
 	 * - no-holes
@@ -188,7 +197,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	int csum_type = -1;
 	char *new_fsid_str = NULL;
 	int ret;
-	u64 super_flags = 0;
+	u64 compat_ro_flags = 0;
+	u64 incompat_flags = 0;
 	int fd = -1;
 
 	btrfs_config_init();
@@ -197,7 +207,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST,
 		       GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE,
 		       GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE,
-		       GETOPT_VAL_ENABLE_FREE_SPACE_TREE };
+		       GETOPT_VAL_ENABLE_FREE_SPACE_TREE,
+		       GETOPT_VAL_TEMP_FSID };
 		static const struct option long_options[] = {
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
 			{ "convert-to-block-group-tree", no_argument, NULL,
@@ -206,6 +217,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 				GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE},
 			{ "convert-to-free-space-tree", no_argument, NULL,
 				GETOPT_VAL_ENABLE_FREE_SPACE_TREE},
+			{ "convert-to-temp-fsid", no_argument, NULL,
+				GETOPT_VAL_TEMP_FSID},
 #if EXPERIMENTAL
 			{ "csum", required_argument, NULL, GETOPT_VAL_CSUM },
 #endif
@@ -222,15 +235,15 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			btrfstune_cmd_groups[SEED] = true;
 			break;
 		case 'r':
-			super_flags |= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF;
+			incompat_flags |= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF;
 			btrfstune_cmd_groups[LEGACY] = true;
 			break;
 		case 'x':
-			super_flags |= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
+			incompat_flags |= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
 			btrfstune_cmd_groups[LEGACY] = true;
 			break;
 		case 'n':
-			super_flags |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
+			incompat_flags |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
 			btrfstune_cmd_groups[LEGACY] = true;
 			break;
 		case 'f':
@@ -269,6 +282,10 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			to_fst = true;
 			btrfstune_cmd_groups[SPACE_CACHE] = true;
 			break;
+		case GETOPT_VAL_TEMP_FSID:
+			compat_ro_flags |= BTRFS_FEATURE_COMPAT_RO_TEMP_FSID;
+			btrfstune_cmd_groups[TEMP_FSID] = true;
+			break;
 #if EXPERIMENTAL
 		case GETOPT_VAL_CSUM:
 			btrfs_warn_experimental(
@@ -448,8 +465,13 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		goto out;
 	}
 
-	if (super_flags) {
-		ret = set_super_incompat_flags(root, super_flags);
+	if (incompat_flags) {
+		ret = set_super_incompat_flags(root, incompat_flags);
+		goto out;
+	}
+
+	if (compat_ro_flags) {
+		ret = set_super_compat_ro_flags(root, compat_ro_flags);
 		goto out;
 	}
 
-- 
2.42.0

