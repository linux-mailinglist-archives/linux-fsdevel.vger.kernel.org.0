Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7172173E1F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 16:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjFZOUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjFZOTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:19:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6179710E4;
        Mon, 26 Jun 2023 07:18:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D481560E8C;
        Mon, 26 Jun 2023 14:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536D3C433C9;
        Mon, 26 Jun 2023 14:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687789035;
        bh=ox51D2RLll22NeAm3Fc2Ql02olAEhMIZTohhLguFykg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lzpLkqEyPg8bF14zDDxft55I+3HF41dGrOdore1GQwlUadDOnHvCby6AFNTe37ud1
         Uk/FiE86WIBS7BtmRtoJL0oXwuno5PiVNOQZMFdPzR0WB0JLuRDRhd+T4lop52NVGa
         BaBRu3d4ahpQKD0yPqjXbLNxGlP7RdvM2A67n/4ha7gFgDKvISH7rqcVTGczGbjl52
         w1RNAJeoCWno3Dx+9NXz1Ki0ZRYic04Sc3gdUC689E4jX9LQ6JiSSxVGgHt5ix/Fsc
         FbvBj2fK2CAga7KO5foV2TE5CPu2JIaeWpYXGxIXaWmjDwrxYCtW3O6KuXCWDCCD60
         d5+Mk3cz/aV+w==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 26 Jun 2023 16:16:51 +0200
Subject: [PATCH 2/2] btrfs: port to new mount api
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230626-fs-btrfs-mount-api-v1-2-045e9735a00b@kernel.org>
References: <20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org>
In-Reply-To: <20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=108796; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ox51D2RLll22NeAm3Fc2Ql02olAEhMIZTohhLguFykg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTMnPs0cq36tV+v7/XsrDk5dVPWh1JOv+UqyrncyQvZO+sP
 /1bb3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRI3MZ/sfueW29er5W6qMN30LVC1
 nYbz3ljTs12/rBt3vs22W1u0wY/tnGaiXGbDrHKB/NlbrzTkxPylmfiPsLV4ooK8WtOHrNjAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/btrfs/Makefile  |    2 +-
 fs/btrfs/disk-io.c |    9 +-
 fs/btrfs/disk-io.h |    5 +-
 fs/btrfs/params.c  | 1770 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/params.h  |   21 +
 fs/btrfs/super.c   | 1500 +-------------------------------------------
 fs/btrfs/super.h   |    7 +-
 7 files changed, 1815 insertions(+), 1499 deletions(-)

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 90d53209755b..62886b39fa7f 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -33,7 +33,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
 	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o \
-	   lru_cache.o
+	   lru_cache.o params.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fbf9006c6234..20b0df76703d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -52,6 +52,7 @@
 #include "relocation.h"
 #include "scrub.h"
 #include "super.h"
+#include "params.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -3339,8 +3340,8 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 	return 0;
 }
 
-int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices,
-		      char *options)
+int __cold open_ctree(struct fs_context *fc, struct super_block *sb,
+		      struct btrfs_fs_devices *fs_devices)
 {
 	u32 sectorsize;
 	u32 nodesize;
@@ -3477,8 +3478,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 
-	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
-	if (ret)
+	ret = btrfs_fs_params_verify(fs_info, fc);
+	if (ret < 0)
 		goto fail_alloc;
 
 	ret = btrfs_check_features(fs_info, !sb_rdonly(sb));
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 4d5772330110..35d0cb97a1a9 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -45,9 +45,8 @@ void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info);
 int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info);
 int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 			   const struct btrfs_super_block *disk_sb);
-int __cold open_ctree(struct super_block *sb,
-	       struct btrfs_fs_devices *fs_devices,
-	       char *options);
+int __cold open_ctree(struct fs_context *fc, struct super_block *sb,
+		      struct btrfs_fs_devices *fs_devices);
 void __cold close_ctree(struct btrfs_fs_info *fs_info);
 int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 			 struct btrfs_super_block *sb, int mirror_num);
diff --git a/fs/btrfs/params.c b/fs/btrfs/params.c
new file mode 100644
index 000000000000..0e90caef2ca4
--- /dev/null
+++ b/fs/btrfs/params.c
@@ -0,0 +1,1770 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Christian Brauner.
+ */
+
+#include "ctree.h"
+#include "defrag.h"
+#include "dev-replace.h"
+#include "dir-item.h"
+#include "discard.h"
+#include "disk-io.h"
+#include "messages.h"
+#include "qgroup.h"
+#include "scrub.h"
+#include "super.h"
+#include "zoned.h"
+#include "accessors.h"
+#include "params.h"
+
+enum btrfs_get_tree_t {
+	BTRFS_FS_CONTEXT_PREPARE,
+	BTRFS_FS_CONTEXT_SUPER,
+	BTRFS_FS_CONTEXT_SUBTREE,
+};
+
+enum space_cache_t {
+	BTRFS_FS_CONTEXT_SPACE_CACHE_DEFAULT	= 0,
+	BTRFS_FS_CONTEXT_SPACE_CACHE_V1		= 1,
+	BTRFS_FS_CONTEXT_SPACE_CACHE_V2		= 2,
+	BTRFS_FS_CONTEXT_SPACE_CACHE_OFF	= 3,
+};
+
+/* Let the btrfs_fs_context hold all mount options. */
+struct btrfs_fs_context {
+	refcount_t refs;
+	enum btrfs_get_tree_t phase;
+
+	/* subvolume mount options */
+	char *subvol_name;
+	u64 subvol_id;
+	struct vfsmount *root_mnt;
+
+	/* generic mount options */
+	unsigned long mount_opt;
+
+	u8 has_space_cache:1;
+	u8 has_compression:1;
+	u8 has_commit_interval:1;
+	u8 has_max_inline:1;
+	u8 has_metadata_ratio:1;
+	u8 has_clear_cache:1;
+#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
+	u8 has_check_integrity_print_mask:1;
+	u32 check_integrity_print_mask;
+#endif
+
+	enum space_cache_t space_cache;
+	unsigned long compress_type:4;
+	unsigned int compress_level;
+	u32 commit_interval;
+	u64 max_inline;
+	u32 metadata_ratio;
+	u32 thread_pool_size;
+
+	/* device mount options */
+	size_t capacity;
+	size_t nr;
+	char **device_paths;
+};
+
+enum {
+	Opt_acl,
+	Opt_clear_cache,
+	Opt_commit_interval,
+	Opt_compress,
+	Opt_compress_force,
+	Opt_degraded,
+	Opt_device,
+	Opt_fatal_errors,
+	Opt_flushoncommit,
+	Opt_max_inline,
+	Opt_barrier,
+	Opt_datacow,
+	Opt_datasum,
+	Opt_defrag,
+	Opt_discard,
+	Opt_nodiscard,
+	Opt_norecovery,
+	Opt_ratio,
+	Opt_rescan_uuid_tree,
+	Opt_skip_balance,
+	Opt_space_cache,
+	Opt_no_space_cache,
+	Opt_ssd,
+	Opt_ssd_spread,
+	Opt_subvol,
+	Opt_subvolid,
+	Opt_thread_pool,
+	Opt_treelog,
+	Opt_user_subvol_rm_allowed,
+
+	/* Rescue options */
+	Opt_rescue,
+	Opt_usebackuproot,
+	Opt_nologreplay,
+
+	/* Deprecated options */
+	Opt_recovery,
+	Opt_inode_cache,
+
+	/* Debugging options */
+	Opt_check_integrity,
+	Opt_check_integrity_including_extent_data,
+	Opt_check_integrity_print_mask,
+	Opt_enospc_debug,
+#ifdef CONFIG_BTRFS_DEBUG
+	Opt_fragment,
+#endif
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+	Opt_ref_verify,
+#endif
+};
+
+enum {
+	BTRFS_PARAM_RESCUE_USEBACKUPROOT,
+	BTRFS_PARAM_RESCUE_NOLOGREPLAY,
+	BTRFS_PARAM_RESCUE_IGNOREBADROOTS,
+	BTRFS_PARAM_RESCUE_IGNOREDATACSUMS,
+	BTRFS_PARAM_RESCUE_RESCUE_ALL,
+};
+
+static const struct constant_table btrfs_rescue_parameters[] = {
+	{ "usebackuproot",	BTRFS_PARAM_RESCUE_USEBACKUPROOT   },
+	{ "nologreplay",	BTRFS_PARAM_RESCUE_NOLOGREPLAY	   },
+	{ "ignorebadroots",	BTRFS_PARAM_RESCUE_IGNOREBADROOTS  },
+	{ "ibadroots",		BTRFS_PARAM_RESCUE_IGNOREBADROOTS  },
+	{ "ignoredatacsums",	BTRFS_PARAM_RESCUE_IGNOREDATACSUMS },
+	{ "all",		BTRFS_PARAM_RESCUE_RESCUE_ALL	   },
+	{}
+};
+
+#ifdef CONFIG_BTRFS_DEBUG
+enum {
+	BTRFS_PARAM_FRAGMENT_DATA,
+	BTRFS_PARAM_FRAGMENT_METADATA,
+	BTRFS_PARAM_FRAGMENT_ALL,
+};
+
+static const struct constant_table btrfs_fragment_parameters[] = {
+	{ "data",	BTRFS_PARAM_FRAGMENT_DATA     },
+	{ "metadata",	BTRFS_PARAM_FRAGMENT_METADATA },
+	{ "all",	BTRFS_PARAM_FRAGMENT_ALL      },
+	{}
+};
+#endif
+
+#define fsparam_string_empty(NAME, OPT) \
+	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
+
+const struct fs_parameter_spec btrfs_parameter_spec[] = {
+	fsparam_flag_no		("acl",				Opt_acl),
+	fsparam_flag		("clear_cache",			Opt_clear_cache),
+	fsparam_u32		("commit",			Opt_commit_interval),
+	fsparam_flag		("compress",			Opt_compress),
+	fsparam_string		("compress",			Opt_compress),
+	fsparam_flag		("compress-force",		Opt_compress_force),
+	fsparam_string		("compress-force",		Opt_compress_force),
+	fsparam_flag		("degraded",			Opt_degraded),
+	fsparam_string_empty	("device",			Opt_device),
+	fsparam_string		("fatal_errors",		Opt_fatal_errors),
+	fsparam_flag_no		("flushoncommit",		Opt_flushoncommit),
+	fsparam_flag_no		("inode_cache",			Opt_inode_cache),
+	fsparam_string		("max_inline",			Opt_max_inline),
+	fsparam_flag_no		("barrier",			Opt_barrier),
+	fsparam_flag_no		("datacow",			Opt_datacow),
+	fsparam_flag_no		("datasum",			Opt_datasum),
+	fsparam_flag_no		("autodefrag",			Opt_defrag),
+	fsparam_flag		("discard",			Opt_discard),
+	fsparam_string		("discard",			Opt_discard),
+	fsparam_flag		("nodiscard",			Opt_nodiscard),
+
+	/* norecovery is deprecated */
+	fsparam_flag		("recovery",			Opt_recovery),
+	fsparam_flag		("norecovery",			Opt_norecovery),
+	fsparam_u32		("metadata_ratio",		Opt_ratio),
+	fsparam_flag		("rescan_uuid_tree",		Opt_rescan_uuid_tree),
+	fsparam_flag		("skip_balance",		Opt_skip_balance),
+	fsparam_flag		("space_cache",			Opt_space_cache),
+	fsparam_string		("space_cache",			Opt_space_cache),
+	fsparam_flag		("nospace_cache",		Opt_no_space_cache),
+	fsparam_flag_no		("ssd",				Opt_ssd),
+	fsparam_flag_no		("ssd_spread",			Opt_ssd_spread),
+	fsparam_flag		("subvol",			Opt_subvol),
+	fsparam_string_empty	("subvol",			Opt_subvol),
+	fsparam_u64		("subvolid",			Opt_subvolid),
+	fsparam_u32		("thread_pool",			Opt_thread_pool),
+	fsparam_flag_no		("treelog",			Opt_treelog),
+	fsparam_flag		("user_subvol_rm_allowed",	Opt_user_subvol_rm_allowed),
+
+	/* Rescue options */
+	fsparam_enum		("rescue",			Opt_rescue, btrfs_rescue_parameters),
+
+	/* Deprecated, with alias rescue=nologreplay */
+	fsparam_flag		("nologreplay",			Opt_nologreplay),
+
+	/* Deprecated, with alias rescue=usebackuproot */
+	fsparam_flag		("usebackuproot",		Opt_usebackuproot),
+
+	/* Debugging options */
+	fsparam_flag		("check_int",			Opt_check_integrity),
+	fsparam_flag		("check_int_data",		Opt_check_integrity_including_extent_data),
+	fsparam_u32		("check_int_print_mask",	Opt_check_integrity_print_mask),
+	fsparam_flag_no		("enospc_debug",		Opt_enospc_debug),
+
+#ifdef CONFIG_BTRFS_DEBUG
+	fsparam_enum		("fragment",			Opt_fragment, btrfs_fragment_parameters),
+#endif
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+	fsparam_flag		("ref_verify",			Opt_ref_verify),
+#endif
+
+	{}
+};
+
+#define btrfs_param_info(fc, fmt, args...)                                   \
+	do {                                                                 \
+		static_assert(__same_type(typeof(fc), struct fs_context *)); \
+		btrfs_info(fc->s_fs_info, fmt, ##args);                      \
+	} while (0)
+
+#define btrfs_param_warn(fc, fmt, args...)                                   \
+	do {                                                                 \
+		static_assert(__same_type(typeof(fc), struct fs_context *)); \
+		btrfs_warn(fc->s_fs_info, fmt, ##args);                      \
+	} while (0)
+
+#define btrfs_param_err(fc, fmt, args...)                                    \
+	do {                                                                 \
+		static_assert(__same_type(typeof(fc), struct fs_context *)); \
+		btrfs_err(fc->s_fs_info, fmt, ##args);                       \
+	} while (0)
+
+#define btrfs_param_clear_info(fc, ctx, opt, fmt, args...)                    \
+	do {                                                                  \
+		static_assert(                                                \
+			__same_type(typeof(ctx), struct btrfs_fs_context *)); \
+		if (btrfs_test_opt(ctx, opt))                                 \
+			btrfs_param_info(fc, fmt, ##args);                    \
+		btrfs_clear_opt(ctx->mount_opt, opt);                         \
+	} while (0)
+
+#define btrfs_param_set_info(fc, ctx, opt, fmt, args...)                      \
+	do {                                                                  \
+		static_assert(                                                \
+			__same_type(typeof(ctx), struct btrfs_fs_context *)); \
+		if (!btrfs_test_opt(ctx, opt))                                \
+			btrfs_param_info(fc, fmt, ##args);                    \
+		btrfs_set_opt(ctx->mount_opt, opt);                           \
+	} while (0)
+
+static void btrfs_fs_context_to_info(struct btrfs_fs_context *ctx,
+				     struct btrfs_fs_info *fs_info)
+{
+	fs_info->mount_opt = ctx->mount_opt;
+
+	if (ctx->has_metadata_ratio)
+		fs_info->metadata_ratio = ctx->metadata_ratio;
+
+	if (ctx->has_compression) {
+		fs_info->compress_type = ctx->compress_type;
+		fs_info->compress_level = ctx->compress_level;
+	}
+
+	if (ctx->has_commit_interval)
+		fs_info->commit_interval = ctx->commit_interval;
+
+	if (ctx->has_max_inline)
+		fs_info->max_inline =
+			min_t(u64, ctx->max_inline, fs_info->sectorsize);
+
+	if (ctx->thread_pool_size)
+		fs_info->thread_pool_size = ctx->thread_pool_size;
+
+#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
+	if (ctx->has_check_integrity_print_mask)
+		fs_info->check_integrity_print_mask =
+			ctx->check_integrity_print_mask;
+#endif
+}
+
+static void btrfs_fs_info_to_context(struct btrfs_fs_context *ctx,
+				     struct btrfs_fs_info *fs_info)
+{
+	ctx->mount_opt		= fs_info->mount_opt;
+	ctx->compress_type	= fs_info->compress_type;
+	ctx->compress_level	= fs_info->compress_level;
+	ctx->thread_pool_size	= fs_info->thread_pool_size;
+	ctx->commit_interval	= fs_info->commit_interval;
+	ctx->metadata_ratio	= fs_info->metadata_ratio;
+	ctx->max_inline		= fs_info->max_inline;
+#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
+	ctx->check_integrity_print_mask = fs_info->check_integrity_print_mask;
+#endif
+}
+
+static bool check_ro_option(struct fs_context *fc, struct btrfs_fs_context *ctx,
+			    unsigned long opt, const char *opt_name)
+{
+	if (!(ctx->mount_opt & opt))
+		return false;
+
+	btrfs_param_err(fc, "%s must be used with ro mount option", opt_name);
+	return true;
+}
+
+int btrfs_fs_params_verify(struct btrfs_fs_info *info, struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	bool is_remount = (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE);
+	int ret = 0;
+
+	/*
+	 * At this point we've read the superblock from disk and we need
+	 * to take the default space cache options into account.
+	 */
+	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
+		btrfs_set_opt(ctx->mount_opt, FREE_SPACE_TREE);
+	else if (btrfs_free_space_cache_v1_active(info)) {
+		if (btrfs_is_zoned(info)) {
+			btrfs_param_info(fc, "zoned: clearing existing space cache");
+			btrfs_set_super_cache_generation(info->super_copy, 0);
+		} else {
+			btrfs_set_opt(ctx->mount_opt, SPACE_CACHE);
+		}
+	}
+
+	/*
+	 * To set space cache options we need to have the on-disk
+	 * superblock information around. During mount this needs to
+	 * happen after the on-disk superblock has been read from disk.
+	 * For reconfiguration this has already happened.
+	 */
+	if (ctx->has_space_cache) {
+		switch (ctx->space_cache) {
+		case BTRFS_FS_CONTEXT_SPACE_CACHE_DEFAULT:
+			break;
+		case BTRFS_FS_CONTEXT_SPACE_CACHE_V1:
+			/*
+			 * We already set FREE_SPACE_TREE above because
+			 * we have compat_ro(FREE_SPACE_TREE) set, and
+			 * we aren't going to allow v1 to be set for
+			 * extent tree v2, simply ignore this setting if
+			 * we're extent tree v2.
+			 */
+			if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
+				break;
+
+			btrfs_clear_opt(ctx->mount_opt, FREE_SPACE_TREE);
+			if (is_remount && !btrfs_test_opt(info, SPACE_CACHE))
+				btrfs_param_info(fc,
+						 "enabling disk space caching");
+			btrfs_set_opt(ctx->mount_opt, SPACE_CACHE);
+			break;
+		case BTRFS_FS_CONTEXT_SPACE_CACHE_V2:
+			/*
+			 * We already set FREE_SPACE_TREE above because
+			 * we have compat_ro(FREE_SPACE_TREE) set, and
+			 * we aren't going to allow v1 to be set for
+			 * extent tree v2, simply ignore this setting if
+			 * we're extent tree v2.
+			 */
+			if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
+				break;
+
+			btrfs_clear_opt(ctx->mount_opt, SPACE_CACHE);
+			if (is_remount &&
+			    !btrfs_test_opt(info, FREE_SPACE_TREE))
+				btrfs_param_info(fc, "enabling free space tree");
+			btrfs_set_opt(ctx->mount_opt, FREE_SPACE_TREE);
+			break;
+		case BTRFS_FS_CONTEXT_SPACE_CACHE_OFF:
+			/*
+			 * We cannot operate without the free space tree
+			 * with extent tree v2, ignore this option.
+			 */
+			if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
+				break;
+
+			if (is_remount && btrfs_test_opt(info, SPACE_CACHE))
+				btrfs_param_info(
+					fc, "disabling disk space caching");
+			btrfs_clear_opt(ctx->mount_opt, SPACE_CACHE);
+
+			if (is_remount && btrfs_test_opt(info, FREE_SPACE_TREE))
+				btrfs_param_info(fc,
+						 "disabling free space tree");
+			btrfs_clear_opt(ctx->mount_opt, FREE_SPACE_TREE);
+			break;
+		default:
+			/* not reached */
+			WARN_ON(true);
+			ret = -EINVAL;
+		}
+	}
+
+	/*
+	 * We cannot clear the free space tree with extent tree v2,
+	 * ignore this option.
+	 */
+	if (!btrfs_fs_incompat(info, EXTENT_TREE_V2) && ctx->has_clear_cache) {
+		if (is_remount && btrfs_test_opt(info, CLEAR_CACHE))
+			btrfs_param_info(fc, "force clearing of disk cache");
+		btrfs_set_opt(ctx->mount_opt, CLEAR_CACHE);
+	}
+
+	if (!(fc->sb_flags & SB_RDONLY)) {
+		if (check_ro_option(fc, ctx, BTRFS_MOUNT_NOLOGREPLAY,
+				    "nologreplay") ||
+		    check_ro_option(fc, ctx, BTRFS_MOUNT_IGNOREBADROOTS,
+				    "ignorebadroots") ||
+		    check_ro_option(fc, ctx, BTRFS_MOUNT_IGNOREDATACSUMS,
+				    "ignoredatacsums"))
+			ret = -EINVAL;
+	}
+
+	if (ctx->has_compression) {
+		switch (ctx->compress_type) {
+		case BTRFS_COMPRESS_LZO:
+			btrfs_set_fs_incompat(info, COMPRESS_LZO);
+			break;
+		case BTRFS_COMPRESS_ZSTD:
+			btrfs_set_fs_incompat(info, COMPRESS_ZSTD);
+			break;
+		}
+	}
+
+	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
+	    !btrfs_test_opt(ctx, FREE_SPACE_TREE) &&
+	    !btrfs_test_opt(ctx, CLEAR_CACHE)) {
+		btrfs_param_err(fc, "cannot disable free space tree");
+		ret = -EINVAL;
+	}
+	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
+	     !btrfs_test_opt(ctx, FREE_SPACE_TREE)) {
+		btrfs_param_err(fc,
+				"cannot disable free space tree with block-group-tree feature");
+		ret = -EINVAL;
+	}
+	if (!ret)
+		ret = btrfs_check_mountopts_zoned(info);
+	if (!ret && !is_remount) {
+		if (btrfs_test_opt(ctx, SPACE_CACHE))
+			btrfs_param_info(fc, "disk space caching is enabled");
+		if (btrfs_test_opt(ctx, FREE_SPACE_TREE))
+			btrfs_param_info(fc, "using free space tree");
+	}
+
+	/*
+	 * Copy mount options over into superblock. On failure the old
+	 * values will be restored. Technically, this can and should at
+	 * some point be rewritten to only rely on @btrfs_fs_context and
+	 * to defer committing the new values after all validation has
+	 * been done. This would work but would mean a lot more work.
+	 */
+	btrfs_fs_context_to_info(ctx, info);
+	return ret;
+}
+
+static void btrfs_parse_param_drop_devices(struct btrfs_fs_context *ctx)
+{
+	for (size_t nr = 0; nr < ctx->nr; nr++) {
+		kfree(ctx->device_paths[nr]);
+		ctx->device_paths[nr] = NULL;
+	}
+	ctx->nr = 0;
+}
+
+/*
+ * Currently we parse the device names. What we should really do in the
+ * future is to resolve these device names to paths and stash paths
+ * here. And then resolve those paths to block devices during
+ * ->get_tree().
+ */
+static int btrfs_parse_param_device(struct fs_parameter *param,
+				    struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	char **pp;
+
+	if (!*param->string) {
+		btrfs_parse_param_drop_devices(ctx);
+		return 0;
+	}
+
+	if (ctx->nr + 1 >= ctx->capacity) {
+		pp = krealloc_array(ctx->device_paths, ctx->nr + 1,
+				    sizeof(*ctx->device_paths),
+				    GFP_KERNEL_ACCOUNT);
+		if (!pp)
+			return -ENOMEM;
+
+		ctx->device_paths = pp;
+		ctx->capacity = ctx->nr + 1;
+	}
+
+	/*
+	 * It's legitimate to steal the parameter's value. We just need
+	 * to make sure to NULL it.
+	 */
+	ctx->device_paths[ctx->nr] = param->string;
+	param->string = NULL;
+	ctx->nr++;
+	return 0;
+}
+
+static inline bool btrfs_param_is_flag(const struct fs_parameter *param)
+{
+	return param->type == fs_value_is_flag;
+}
+
+static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	bool is_remount = (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE);
+	struct fs_parse_result result;
+	char *compress_type;
+	bool compress_force = false, saved_compress_type, saved_compress_force,
+	     saved_compress_level;
+	int no_compress = 0;
+	char *dup = NULL;
+	int ret = 0;
+	int opt;
+
+	opt = fs_parse(fc, btrfs_parameter_spec, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_degraded:
+		btrfs_param_info(fc, "allowing degraded mounts");
+		btrfs_set_opt(ctx->mount_opt, DEGRADED);
+		break;
+	case Opt_subvol:
+		if (is_remount && !fc->oldapi)
+			return -EINVAL;
+
+		/* "subvol", just ignore */
+		if (btrfs_param_is_flag(param))
+			break;
+
+		if (*param->string) {
+			dup = kstrdup(param->string, GFP_KERNEL);
+			if (!dup) {
+				ret = -ENOMEM;
+				break;
+			}
+		}
+		kfree(ctx->subvol_name);
+		ctx->subvol_name = dup;
+		break;
+	case Opt_subvolid:
+		if (is_remount && !fc->oldapi)
+			return -EINVAL;
+
+		if (result.uint_64 == 0)
+			ctx->subvol_id = BTRFS_FS_TREE_OBJECTID;
+		else
+			ctx->subvol_id = result.uint_64;
+		break;
+	case Opt_device:
+		if (is_remount && !fc->oldapi)
+			ret = -EINVAL;
+		else
+			ret = btrfs_parse_param_device(param, fc);
+		break;
+	case Opt_datasum:
+		if (!result.negated) {
+			if (btrfs_test_opt(ctx, NODATASUM)) {
+				if (btrfs_test_opt(ctx, NODATACOW))
+					btrfs_param_info(fc, "setting datasum, datacow enabled");
+				else
+					btrfs_param_info(fc, "setting datasum");
+			}
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+		} else {
+			btrfs_param_set_info(fc, ctx, NODATASUM, "setting nodatasum");
+		}
+		break;
+	case Opt_datacow:
+		if (!result.negated) {
+			btrfs_param_clear_info(fc, ctx, NODATACOW, "setting datacow");
+		} else {
+			if (!btrfs_test_opt(ctx, NODATACOW)) {
+				if (!btrfs_test_opt(ctx, COMPRESS) ||
+				    !btrfs_test_opt(ctx, FORCE_COMPRESS)) {
+					btrfs_param_info(fc, "setting nodatacow, compression disabled");
+				} else {
+					btrfs_param_info(fc, "setting nodatacow");
+				}
+			}
+			btrfs_clear_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
+			btrfs_set_opt(ctx->mount_opt, NODATACOW);
+			btrfs_set_opt(ctx->mount_opt, NODATASUM);
+		}
+		break;
+	case Opt_compress_force:
+		compress_force = true;
+		fallthrough;
+	case Opt_compress:
+		saved_compress_type = btrfs_test_opt(ctx, COMPRESS) ?
+					      ctx->compress_type :
+					      BTRFS_COMPRESS_NONE;
+		saved_compress_force = btrfs_test_opt(ctx, FORCE_COMPRESS);
+		saved_compress_level = ctx->compress_level;
+
+		if (btrfs_param_is_flag(param) ||
+		    strncmp(param->string, "zlib", 4) == 0) {
+			compress_type = "zlib";
+
+			ctx->compress_type = BTRFS_COMPRESS_ZLIB;
+			ctx->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
+			/*
+			 * args[0] contains uninitialized data since
+			 * for these tokens we don't expect any
+			 * parameter.
+			 */
+			if (!btrfs_param_is_flag(param))
+				ctx->compress_level = btrfs_compress_str2level(
+					BTRFS_COMPRESS_ZLIB, param->string + 4);
+			btrfs_set_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+			no_compress = 0;
+		} else if (strncmp(param->string, "lzo", 3) == 0) {
+			compress_type = "lzo";
+			ctx->compress_type = BTRFS_COMPRESS_LZO;
+			ctx->compress_level = 0;
+			btrfs_set_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+			no_compress = 0;
+		} else if (strncmp(param->string, "zstd", 4) == 0) {
+			compress_type = "zstd";
+			ctx->compress_type = BTRFS_COMPRESS_ZSTD;
+			ctx->compress_level = btrfs_compress_str2level(
+				BTRFS_COMPRESS_ZSTD, param->string + 4);
+			btrfs_set_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+			no_compress = 0;
+		} else if (strncmp(param->string, "no", 2) == 0) {
+			compress_type = "no";
+			ctx->compress_level = 0;
+			ctx->compress_type = 0;
+			btrfs_clear_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
+			compress_force = false;
+			no_compress++;
+		} else {
+			btrfs_param_warn(fc, "unrecognized compression value %s",
+					 param->string);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (compress_force) {
+			btrfs_set_opt(ctx->mount_opt, FORCE_COMPRESS);
+		} else {
+			/*
+			 * If we remount from compress-force=xxx to
+			 * compress=xxx, we need clear FORCE_COMPRESS
+			 * flag, otherwise, there is no way for users
+			 * to disable forcible compression separately.
+			 */
+			btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
+		}
+		if (no_compress == 1) {
+			btrfs_param_info(fc, "use no compression");
+		} else if ((ctx->compress_type != saved_compress_type) ||
+			   (compress_force != saved_compress_force) ||
+			   (ctx->compress_level != saved_compress_level)) {
+			btrfs_param_info(fc, "%s %s compression, level %d",
+				   (compress_force) ? "force" : "use",
+				   compress_type, ctx->compress_level);
+		}
+		ctx->has_compression = 1;
+		compress_force = false;
+		break;
+	case Opt_ssd:
+		if (!result.negated) {
+			btrfs_param_set_info(fc, ctx, SSD,
+					     "enabling ssd optimizations");
+			btrfs_clear_opt(ctx->mount_opt, NOSSD);
+		} else {
+			btrfs_set_opt(ctx->mount_opt, NOSSD);
+			btrfs_param_clear_info(fc, ctx, SSD,
+					       "not using ssd optimizations");
+			/* also clear Opt_ssd_spread */
+			btrfs_param_clear_info(fc, ctx, SSD_SPREAD,
+					       "not using spread ssd allocation scheme");
+		}
+		break;
+	case Opt_ssd_spread:
+		if (!result.negated) {
+			btrfs_param_set_info(fc, ctx, SSD,
+					     "enabling ssd optimizations");
+			btrfs_param_set_info(fc, ctx, SSD_SPREAD,
+					     "using spread ssd allocation scheme");
+			btrfs_clear_opt(ctx->mount_opt, NOSSD);
+		} else {
+			btrfs_param_clear_info(fc, ctx, SSD_SPREAD,
+					       "not using spread ssd allocation scheme");
+		}
+		break;
+	case Opt_barrier:
+		if (!result.negated)
+			btrfs_param_clear_info(fc, ctx, NOBARRIER,
+					       "turning on barriers");
+		else
+			btrfs_param_set_info(fc, ctx, NOBARRIER,
+					     "turning off barriers");
+		break;
+	case Opt_thread_pool:
+		if (result.uint_32 == 0) {
+			btrfs_param_err(fc, "invalid value 0 for thread_pool");
+			ret = -EINVAL;
+			break;
+		}
+		ctx->thread_pool_size = result.uint_32;
+		break;
+	case Opt_max_inline:
+		dup = kstrdup(param->string, GFP_KERNEL);
+		if (!dup) {
+			ret = -ENOMEM;
+			break;
+		}
+		ctx->has_max_inline = 1;
+		ctx->max_inline = memparse(dup, NULL);
+		kfree(dup);
+		btrfs_param_info(fc, "max_inline at %llu", ctx->max_inline);
+		break;
+	case Opt_acl:
+		if (!result.negated) {
+#ifdef CONFIG_BTRFS_FS_POSIX_ACL
+			fc->sb_flags |= SB_POSIXACL;
+#else
+			btrfs_param_err(err, "support for ACL not compiled in!");
+			ret = -EINVAL;
+#endif
+			break;
+		}
+
+		fc->sb_flags &= ~SB_POSIXACL;
+		break;
+	case Opt_treelog:
+		if (!result.negated)
+			btrfs_param_clear_info(fc, ctx, NOTREELOG,
+					       "enabling tree log");
+		else
+			btrfs_param_set_info(fc, ctx, NOTREELOG,
+					     "disabling tree log");
+		break;
+	case Opt_norecovery:
+		fallthrough;
+	case Opt_nologreplay:
+		btrfs_param_warn(fc, "'nologreplay' is deprecated, use 'rescue=nologreplay' instead");
+		btrfs_param_set_info(fc, ctx, NOLOGREPLAY,
+				     "disabling log replay at mount time");
+		break;
+	case Opt_flushoncommit:
+		if (!result.negated)
+			btrfs_param_set_info(fc, ctx, FLUSHONCOMMIT,
+					     "turning on flush-on-commit");
+		else
+			btrfs_param_clear_info(fc, ctx, FLUSHONCOMMIT,
+					       "turning off flush-on-commit");
+		break;
+	case Opt_ratio:
+		ctx->has_metadata_ratio = 1;
+		ctx->metadata_ratio = result.uint_32;
+		btrfs_param_info(fc, "metadata ratio %u", ctx->metadata_ratio);
+		break;
+	case Opt_nodiscard:
+		btrfs_param_clear_info(fc, ctx, DISCARD_SYNC,
+				       "turning off discard");
+		btrfs_param_clear_info(fc, ctx, DISCARD_ASYNC,
+				       "turning off async discard");
+		btrfs_set_opt(ctx->mount_opt, NODISCARD);
+		break;
+	case Opt_discard:
+		if (btrfs_param_is_flag(param) ||
+		    strcmp(param->string, "sync") == 0) {
+			btrfs_clear_opt(ctx->mount_opt, DISCARD_ASYNC);
+			btrfs_param_set_info(fc, ctx, DISCARD_SYNC,
+					     "turning on sync discard");
+		} else if (strcmp(param->string, "async") == 0) {
+			btrfs_clear_opt(ctx->mount_opt, DISCARD_SYNC);
+			btrfs_param_set_info(fc, ctx, DISCARD_ASYNC,
+					     "turning on async discard");
+		} else {
+			btrfs_param_err(fc, "unrecognized discard mode value %s",
+					param->string);
+			ret = -EINVAL;
+			break;
+		}
+		btrfs_clear_opt(ctx->mount_opt, NODISCARD);
+		break;
+	case Opt_no_space_cache:
+		ctx->has_space_cache = 1;
+		ctx->space_cache = BTRFS_FS_CONTEXT_SPACE_CACHE_OFF;
+		if (btrfs_test_opt(ctx, SPACE_CACHE))
+			btrfs_param_clear_info(fc, ctx, SPACE_CACHE,
+					       "disabling disk space caching");
+		if (btrfs_test_opt(ctx, FREE_SPACE_TREE))
+			btrfs_param_clear_info(fc, ctx, FREE_SPACE_TREE,
+					       "disabling free space tree");
+		break;
+	case Opt_space_cache:
+		if (btrfs_param_is_flag(param) ||
+		    strcmp(param->string, "v1") == 0) {
+			ctx->has_space_cache = 1;
+			ctx->space_cache = BTRFS_FS_CONTEXT_SPACE_CACHE_V1;
+		} else if (strcmp(param->string, "v2") == 0) {
+			ctx->has_space_cache = 1;
+			ctx->space_cache = BTRFS_FS_CONTEXT_SPACE_CACHE_V2;
+		} else {
+			btrfs_param_err(fc, "unrecognized space_cache value %s",
+					param->string);
+			ret = -EINVAL;
+			break;
+		}
+		break;
+	case Opt_rescan_uuid_tree:
+		btrfs_set_opt(ctx->mount_opt, RESCAN_UUID_TREE);
+		break;
+	case Opt_inode_cache:
+		btrfs_param_warn(fc, "the 'inode_cache' option is deprecated and has no effect since 5.11");
+		break;
+	case Opt_clear_cache:
+		ctx->has_clear_cache = 1;
+		break;
+	case Opt_user_subvol_rm_allowed:
+		btrfs_set_opt(ctx->mount_opt, USER_SUBVOL_RM_ALLOWED);
+		break;
+	case Opt_enospc_debug:
+		if (!result.negated)
+			btrfs_set_opt(ctx->mount_opt, ENOSPC_DEBUG);
+		else
+			btrfs_clear_opt(ctx->mount_opt, ENOSPC_DEBUG);
+		break;
+	case Opt_defrag:
+		if (!result.negated)
+			btrfs_param_set_info(fc, ctx, AUTO_DEFRAG,
+					     "enabling auto defrag");
+		else
+			btrfs_param_clear_info(fc, ctx, AUTO_DEFRAG,
+					       "disabling auto defrag");
+		break;
+	case Opt_recovery:
+		fallthrough;
+	case Opt_usebackuproot:
+		btrfs_param_warn(fc,
+				 "'%s' is deprecated, use 'rescue=usebackuproot' instead",
+				 opt == Opt_recovery ? "recovery" : "usebackuproot");
+		btrfs_param_info(fc, "trying to use backup root at mount time");
+		btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
+		break;
+	case Opt_skip_balance:
+		btrfs_set_opt(ctx->mount_opt, SKIP_BALANCE);
+		break;
+#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
+	case Opt_check_integrity_including_extent_data:
+		btrfs_param_info(fc, "enabling check integrity including extent data");
+		btrfs_set_opt(ctx->mount_opt, CHECK_INTEGRITY_DATA);
+		btrfs_set_opt(ctx->mount_opt, CHECK_INTEGRITY);
+		break;
+	case Opt_check_integrity:
+		btrfs_param_info(fc, "enabling check integrity");
+		btrfs_set_opt(ctx->mount_opt, CHECK_INTEGRITY);
+		break;
+	case Opt_check_integrity_print_mask:
+		ctx->has_check_integrity_print_mask = 1;
+		ctx->check_integrity_print_mask = result.uint_32;
+		btrfs_param_info(fc, "check_integrity_print_mask 0x%x",
+				 ctx->check_integrity_print_mask);
+		break;
+#else
+	case Opt_check_integrity_including_extent_data:
+		fallthrough;
+	case Opt_check_integrity:
+		fallthrough;
+	case Opt_check_integrity_print_mask:
+		btrfs_param_err(fc, "support for check_integrity* not compiled in!");
+		ret = -EINVAL;
+		break;
+#endif
+	case Opt_fatal_errors:
+		if (strcmp(param->string, "panic") == 0) {
+			btrfs_set_opt(ctx->mount_opt, PANIC_ON_FATAL_ERROR);
+		} else if (strcmp(param->string, "bug") == 0) {
+			btrfs_clear_opt(ctx->mount_opt, PANIC_ON_FATAL_ERROR);
+		} else {
+			btrfs_param_err(fc, "unrecognized fatal_errors value %s",
+					param->string);
+			ret = -EINVAL;
+		}
+		break;
+	case Opt_commit_interval:
+		ctx->has_commit_interval = 1;
+		if (result.uint_32 == 0) {
+			btrfs_param_info(fc, "using default commit interval %us",
+					 BTRFS_DEFAULT_COMMIT_INTERVAL);
+			ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
+			break;
+		}
+
+		if (result.uint_32 > 300)
+			btrfs_param_warn(fc, "excessive commit interval %d",
+					 result.uint_32);
+
+		ctx->commit_interval = result.uint_32;
+		break;
+	case Opt_rescue:
+		switch (result.uint_32) {
+		case BTRFS_PARAM_RESCUE_USEBACKUPROOT:
+			btrfs_param_info(fc, "trying to use backup root at mount time");
+			btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
+			break;
+		case BTRFS_PARAM_RESCUE_NOLOGREPLAY:
+			btrfs_param_set_info(fc, ctx, NOLOGREPLAY,
+					     "disabling log replay at mount time");
+			break;
+		case BTRFS_PARAM_RESCUE_IGNOREBADROOTS:
+			btrfs_param_set_info(fc, ctx, IGNOREBADROOTS,
+					     "ignoring bad roots");
+			break;
+		case BTRFS_PARAM_RESCUE_IGNOREDATACSUMS:
+			btrfs_param_set_info(fc, ctx, IGNOREDATACSUMS,
+					     "ignoring data csums");
+			break;
+		case BTRFS_PARAM_RESCUE_RESCUE_ALL:
+			btrfs_param_info(fc,
+					 "enabling all of the rescue options");
+			btrfs_param_set_info(fc, ctx, IGNOREDATACSUMS,
+					     "ignoring data csums");
+			btrfs_param_set_info(fc, ctx, IGNOREBADROOTS,
+					     "ignoring bad roots");
+			btrfs_param_set_info(fc, ctx, NOLOGREPLAY,
+					     "disabling log replay at mount time");
+			break;
+		default:
+			/* not reached */
+			WARN_ON(true);
+			ret = -EINVAL;
+		}
+		break;
+#ifdef CONFIG_BTRFS_DEBUG
+	case Opt_fragment:
+		switch (result.uint_32) {
+		case BTRFS_PARAM_FRAGMENT_DATA:
+			btrfs_param_info(fc, "fragmenting data");
+			btrfs_set_opt(ctx->mount_opt, FRAGMENT_DATA);
+			break;
+		case BTRFS_PARAM_FRAGMENT_METADATA:
+			btrfs_param_info(fc, "fragmenting metadata");
+			btrfs_set_opt(ctx->mount_opt, FRAGMENT_METADATA);
+			break;
+		case BTRFS_PARAM_FRAGMENT_ALL:
+			btrfs_param_info(fc, "fragmenting all space");
+			btrfs_set_opt(ctx->mount_opt, FRAGMENT_DATA);
+			btrfs_set_opt(ctx->mount_opt, FRAGMENT_METADATA);
+			break;
+		default:
+			/* not reached */
+			WARN_ON(true);
+			ret = -EINVAL;
+		}
+		break;
+#endif
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+	case Opt_ref_verify:
+		btrfs_param_info(fc, "doing ref verification");
+		btrfs_set_opt(ctx->mount_opt, REF_VERIFY);
+		break;
+#endif
+	default:
+		/* We have a bug in the VFS parser. */
+		WARN_ON(true);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int btrfs_reconfigure(struct fs_context *fc);
+
+static int btrfs_legacy_reconfigure(struct fs_context *root_fc)
+{
+	int ret;
+	struct btrfs_fs_context *ctx = root_fc->fs_private;
+	struct vfsmount *root_mnt = ctx->root_mnt;
+
+	root_fc->sb_flags &= ~SB_RDONLY;
+	down_write(&root_mnt->mnt_sb->s_umount);
+	ret = btrfs_reconfigure(root_fc);
+	up_write(&root_mnt->mnt_sb->s_umount);
+	return ret;
+}
+
+static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objectid)
+{
+	struct btrfs_root *root = fs_info->tree_root;
+	struct btrfs_dir_item *di;
+	struct btrfs_path *path;
+	struct btrfs_key location;
+	struct fscrypt_str name = FSTR_INIT("default", 7);
+	u64 dir_id;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	/*
+	 * Find the "default" dir item which points to the root item that we
+	 * will mount by default if we haven't been given a specific subvolume
+	 * to mount.
+	 */
+	dir_id = btrfs_super_root_dir(fs_info->super_copy);
+	di = btrfs_lookup_dir_item(NULL, root, path, dir_id, &name, 0);
+	if (IS_ERR(di)) {
+		btrfs_free_path(path);
+		return PTR_ERR(di);
+	}
+	if (!di) {
+		/*
+		 * Ok the default dir item isn't there.  This is weird since
+		 * it's always been there, but don't freak out, just try and
+		 * mount the top-level subvolume.
+		 */
+		btrfs_free_path(path);
+		*objectid = BTRFS_FS_TREE_OBJECTID;
+		return 0;
+	}
+
+	btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
+	btrfs_free_path(path);
+	*objectid = location.objectid;
+	return 0;
+}
+
+/*
+ * subvolumes are identified by ino 256
+ */
+static inline int is_subvolume_inode(struct inode *inode)
+{
+	if (inode && inode->i_ino == BTRFS_FIRST_FREE_OBJECTID)
+		return 1;
+	return 0;
+}
+
+static struct dentry *mount_subvol(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct super_block *s = ctx->root_mnt->mnt_sb;
+	struct btrfs_fs_info *fs_info = btrfs_sb(s);
+	struct inode *root_inode;
+	u64 root_objectid;
+	struct dentry *root;
+	int ret;
+
+	if (WARN_ON(ctx->phase != BTRFS_FS_CONTEXT_SUBTREE))
+		return ERR_PTR(-EINVAL);
+
+	if (!ctx->subvol_name) {
+		if (!ctx->subvol_id) {
+			ret = get_default_subvol_objectid(fs_info,
+							  &ctx->subvol_id);
+			if (ret)
+				return ERR_PTR(ret);
+		}
+		ctx->subvol_name = btrfs_get_subvol_name_from_objectid(
+			fs_info, ctx->subvol_id);
+		if (IS_ERR(ctx->subvol_name)) {
+			root = ERR_CAST(ctx->subvol_name);
+			ctx->subvol_name = NULL;
+			return root;
+		}
+
+	}
+
+	root = mount_subtree(ctx->root_mnt, ctx->subvol_name);
+	ctx->root_mnt = NULL; /* @ctx->root_mnt has been consumed */
+	if (IS_ERR(root))
+		return root;
+
+	root_inode = d_inode(root);
+	root_objectid = BTRFS_I(root_inode)->root->root_key.objectid;
+
+	ret = 0;
+	if (!is_subvolume_inode(root_inode)) {
+		btrfs_err(fs_info, "'%s' is not a valid subvolume",
+			  ctx->subvol_name);
+		ret = -EINVAL;
+	}
+	if (ctx->subvol_id && root_objectid != ctx->subvol_id) {
+		/*
+		 * This will also catch a race condition where a
+		 * subvolume which was passed by ID is renamed and
+		 * another subvolume is renamed over the old location.
+		 */
+		btrfs_err(fs_info, "subvol '%s' does not match subvolid %llu",
+			  ctx->subvol_name, ctx->subvol_id);
+		ret = -EINVAL;
+	}
+	if (ret) {
+		dput(root);
+		root = ERR_PTR(ret);
+		/*
+		 * On successful mount_subtree() we'll trade vfsmount
+		 * reference for a super block reference and will have
+		 * locked the super block again after fc_mount()
+		 * unlocked it.
+		 */
+		deactivate_locked_super(s);
+	}
+
+	return root;
+}
+
+static int btrfs_get_tree_common(struct fs_context *fc)
+{
+	struct vfsmount *root_mnt = NULL;
+	struct fs_context *root_fc;
+	struct dentry *root_dentry;
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	int ret;
+
+	if (WARN_ON(ctx->phase != BTRFS_FS_CONTEXT_PREPARE))
+		return -EINVAL;
+
+	root_fc = vfs_dup_fs_context(fc);
+	if (IS_ERR(root_fc))
+		return PTR_ERR(root_fc);
+
+	/*
+	 * We've duplicated the security mount options above and we only
+	 * need them to be set when we really create a new superblock.
+	 * They're irrelevant when we mount the subvolume as the
+	 * superblock does already exist at that point. So free the
+	 * security blob here.
+	 */
+	security_free_mnt_opts(&fc->security);
+	fc->security = NULL;
+
+	/* Create the superblock so we can mount a subtree later. */
+	ctx->phase = BTRFS_FS_CONTEXT_SUPER;
+
+	root_mnt = fc_mount(root_fc);
+	if (PTR_ERR_OR_ZERO(root_mnt) == -EBUSY) {
+		bool ro2rw = !(root_fc->sb_flags & SB_RDONLY);
+
+		if (ro2rw)
+			root_fc->sb_flags |= SB_RDONLY;
+		else
+			root_fc->sb_flags &= ~SB_RDONLY;
+
+		root_mnt = fc_mount(root_fc);
+		if (IS_ERR(root_mnt)) {
+			put_fs_context(root_fc);
+			return PTR_ERR(root_mnt);
+		}
+		ctx->root_mnt = root_mnt;
+
+		/*
+		 * Ever since commit 0723a0473fb4 ("btrfs: allow
+		 * mounting btrfs subvolumes with different ro/rw
+		 * options") the following works:
+		 *
+		 *        (i) mount /dev/sda3 -o subvol=foo,ro /mnt/foo
+		 *       (ii) mount /dev/sda3 -o subvol=bar,rw /mnt/bar
+		 *
+		 * which looks nice and innocent but is actually pretty
+		 * intricate and deserves a long comment.
+		 *
+		 * On another filesystem a subvolume mount is close to
+		 * something like:
+		 *
+		 *	(iii) # create rw superblock + initial mount
+		 *	      mount -t xfs /dev/sdb /opt/
+		 *
+		 *	      # create ro bind mount
+		 *	      mount --bind -o ro /opt/foo /mnt/foo
+		 *
+		 *	      # unmount initial mount
+		 *	      umount /opt
+		 *
+		 * Of course, there's some special subvolume sauce and
+		 * there's the fact that the sb->s_root dentry is really
+		 * swapped after mount_subtree(). But conceptually it's
+		 * very close and will help us understand the issue.
+		 *
+		 * The old mount api didn't cleanly distinguish between
+		 * a mount being made ro and a superblock being made ro.
+		 * The only way to change the ro state of either object
+		 * was by passing MS_RDONLY. If a new mount was created
+		 * via mount(2) such as:
+		 *
+		 *      mount("/dev/sdb", "/mnt", "xfs", MS_RDONLY, NULL);
+		 *
+		 * the MS_RDONLY flag being specified had two effects:
+		 *
+		 * (1) MNT_READONLY was raised -> the resulting mount
+		 *     got @mnt->mnt_flags |= MNT_READONLY raised.
+		 *
+		 * (2) MS_RDONLY was passed to the filesystem's mount
+		 *     method and the filesystems made the superblock
+		 *     ro. Note, how SB_RDONLY has the same value as
+		 *     MS_RDONLY and is raised whenever MS_RDONLY is
+		 *     passed through mount(2).
+		 *
+		 * Creating a subtree mount via (iii) ends up leaving a
+		 * rw superblock with a subtree mounted ro.
+		 *
+		 * But consider the effect on the old mount api on btrfs
+		 * subvolume mounting which combines the distinct step
+		 * in (iii) into a a single step.
+		 *
+		 * By issuing (i) both the mount and the superblock are
+		 * turned ro. Now when (ii) is issued the superblock is
+		 * ro and thus even if the mount created for (ii) is rw
+		 * it wouldn't help. Hence, btrfs needed to transition
+		 * the superblock from ro to rw for (ii) which it did
+		 * using an internal remount call (a bold choice...).
+		 *
+		 * IOW, subvolume mounting was inherently messy due to
+		 * the ambiguity of MS_RDONLY in mount(2). Note, this
+		 * ambiguity has mount(8) always translate "ro" to
+		 * MS_RDONLY. IOW, in both (i) and (ii) "ro" becomes
+		 * MS_RDONLY when passed by mount(8) to mount(2).
+		 *
+		 * Enter the new mount api. The new mount api
+		 * disambiguates making a mount ro and making a
+		 * superblock ro.
+		 *
+		 * (3) To turn a mount ro the MOUNT_ATTR_RDONLY flag can
+		 *     be used with either fsmount() or mount_setattr().
+		 *     This is a pure VFS level change for a specific
+		 *     mount or mount tree that is never seen by the
+		 *     filesystem itself.
+		 *
+		 * (4) To turn a superblock ro the "ro" flag must be
+		 *     used with fsconfig(FSCONFIG_SET_FLAG, "ro"). This
+		 *     option is seen by the filesytem in fc->sb_flags.
+		 *
+		 * This disambiguation has rather positive consequences.
+		 * Mounting a subvolume ro will not also turn the
+		 * superblock ro. Only the mount for the subvolume will
+		 * become ro.
+		 *
+		 * So, if the superblock creation request comes from the
+		 * new mount api the caller must've explicitly done:
+		 *
+		 *      fsconfig(FSCONFIG_SET_FLAG, "ro")
+		 *      fsmount/mount_setattr(MOUNT_ATTR_RDONLY)
+		 *
+		 * IOW, at some point the caller must have explicitly
+		 * turned the whole superblock ro and we shouldn't just
+		 * undo it like we did for the old mount api. In any
+		 * case, it lets us avoid this nasty hack in the new
+		 * mount api.
+		 *
+		 * Consequently, the remounting hack must only be used
+		 * for requests originating from the old mount api and
+		 * should be marked for full deprecation so it can be
+		 * turned off in a couple of years.
+		 *
+		 * The new mount api has no reason to support this hack.
+		 */
+		if (root_fc->oldapi && ro2rw) {
+			/*
+			 * This magic internal remount is a pretty bold
+			 * move as the VFS reserves the right to protect
+			 * ro->rw transitions on the VFS layer similar
+			 * to how it protects rw->ro transitions.
+			 */
+			ret = btrfs_legacy_reconfigure(root_fc);
+			if (ret)
+				root_mnt = ERR_PTR(ret);
+		}
+	}
+	put_fs_context(root_fc);
+	if (IS_ERR(root_mnt))
+		return PTR_ERR(root_mnt);
+	ctx->root_mnt = root_mnt;
+
+	root_dentry = mount_subvol(fc);
+	if (IS_ERR(root_dentry))
+		return PTR_ERR(root_dentry);
+
+	fc->root = root_dentry;
+	return 0;
+}
+
+static int btrfs_test_super(struct super_block *s, struct fs_context *fc)
+{
+	struct btrfs_fs_info *p = fc->s_fs_info;
+	struct btrfs_fs_info *fs_info = btrfs_sb(s);
+
+	return fs_info->fs_devices == p->fs_devices;
+}
+
+static int btrfs_set_super(struct super_block *s, struct fs_context *fc)
+{
+	return set_anon_super_fc(s, fc->s_fs_info);
+}
+
+static int btrfs_get_tree_super(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct btrfs_fs_info *fs_info = fc->s_fs_info;
+	struct block_device *bdev = NULL;
+	struct super_block *s;
+	struct btrfs_device *device = NULL;
+	struct btrfs_fs_devices *fs_devices = NULL;
+	blk_mode_t mode = sb_open_mode(fc->sb_flags);
+	int error = 0;
+
+	if (WARN_ON(ctx->phase != BTRFS_FS_CONTEXT_SUPER))
+		return -EINVAL;
+
+	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
+	fs_info->super_for_commit = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
+	if (!fs_info->super_copy || !fs_info->super_for_commit)
+		return -ENOMEM;
+
+	mutex_lock(&uuid_mutex);
+
+	for (size_t nr = 0; nr < ctx->nr; nr++) {
+		device = btrfs_scan_one_device(ctx->device_paths[nr], mode);
+		if (IS_ERR(device)) {
+			mutex_unlock(&uuid_mutex);
+			return -ENOMEM;
+		}
+	}
+
+	device = btrfs_scan_one_device(fc->source, mode);
+	if (IS_ERR(device)) {
+		mutex_unlock(&uuid_mutex);
+		return PTR_ERR(device);
+	}
+
+	fs_devices = device->fs_devices;
+	fs_info->fs_devices = fs_devices;
+
+	error = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+	mutex_unlock(&uuid_mutex);
+	if (error)
+		return error;
+
+	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
+		error = -EACCES;
+		goto error_close_devices;
+	}
+
+	bdev = fs_devices->latest_dev->bdev;
+
+	fc->sb_flags |= SB_NOSEC;
+	/*
+	 * If a new superblock is allocated then fc->s_fs_info will have
+	 * been transfered to sb->s_fs_info and will be cleaned up by
+	 * ->kill_sb() if we fail afterwards.
+	 *
+	 * If no matching or an existing superblock is found
+	 * fc->s_fs_info will be left alone and cleaned up during
+	 * btrfs_free().
+	 */
+	s = sget_fc(fc, btrfs_test_super, btrfs_set_super);
+	if (IS_ERR(s)) {
+		error = PTR_ERR(s);
+		goto error_close_devices;
+	}
+
+	if (s->s_root) {
+		btrfs_close_devices(fs_devices);
+		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY)
+			error = -EBUSY;
+	} else {
+		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
+		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", btrfs_fs_type.name,
+					s->s_id);
+		btrfs_sb(s)->bdev_holder = &btrfs_fs_type;
+		error = btrfs_fill_super(fc, s, fs_devices);
+	}
+	if (error) {
+		/* we can rely on @fs_devices having been closed */
+		deactivate_locked_super(s);
+		return error;
+	}
+
+	fc->root = dget(s->s_root);
+	ctx->phase = BTRFS_FS_CONTEXT_SUBTREE;
+	return 0;
+
+error_close_devices:
+	btrfs_close_devices(fs_devices);
+	return error;
+}
+
+int btrfs_get_tree(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+
+	if (ctx->phase == BTRFS_FS_CONTEXT_SUPER)
+		return btrfs_get_tree_super(fc);
+
+	return btrfs_get_tree_common(fc);
+}
+
+static int btrfs_dup_fs_context(struct fs_context *fc, struct fs_context *src_fc)
+{
+	struct btrfs_fs_context *ctx = src_fc->fs_private;
+	struct btrfs_fs_info *fs_info;
+
+	/*
+	 * Setup a dummy root and fs_info for test/set super.  This is
+	 * because we don't actually fill this stuff out until
+	 * open_ctree, but we need then open_ctree will properly
+	 * initialize the file system specific settings later.
+	 * btrfs_init_fs_info initializes the static elements of the
+	 * fs_info (locks and such) to make cleanup easier if we find a
+	 * superblock with our given fs_devices later on at sget_fc()
+	 * time.
+	 */
+	fs_info = kvzalloc(sizeof(struct btrfs_fs_info), GFP_KERNEL);
+	if (!fs_info)
+		return -ENOMEM;
+	btrfs_init_fs_info(fs_info);
+
+	refcount_inc(&ctx->refs);
+
+	/*
+	 * Steal the fs_context::source from original context. We only
+	 * need it to create the superblock, but not for the subtree.
+	 */
+	fc->source	= src_fc->source;
+	src_fc->source	= NULL;
+	fc->fs_private	= ctx;
+	fc->s_fs_info	= fs_info;
+
+	return 0;
+}
+
+static inline void btrfs_free_fs_context_private(struct btrfs_fs_context *ctx)
+{
+	if (refcount_dec_and_test(&ctx->refs)) {
+		mntput(ctx->root_mnt);
+		btrfs_parse_param_drop_devices(ctx);
+		kfree(ctx->subvol_name);
+		kfree(ctx);
+	}
+}
+
+static void btrfs_free_fs_context(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct btrfs_fs_info *fs_info = fc->s_fs_info;
+
+	if (ctx)
+		btrfs_free_fs_context_private(ctx);
+
+	if (fs_info)
+		btrfs_free_fs_info(fs_info);
+}
+
+static inline void btrfs_remount_begin(struct btrfs_fs_info *fs_info,
+				       unsigned long old_opts, int flags)
+{
+	if (btrfs_raw_test_opt(old_opts, AUTO_DEFRAG) &&
+	    (!btrfs_raw_test_opt(fs_info->mount_opt, AUTO_DEFRAG) ||
+	     (flags & SB_RDONLY))) {
+		/* wait for any defraggers to finish */
+		wait_event(fs_info->transaction_wait,
+			   (atomic_read(&fs_info->defrag_running) == 0));
+		if (flags & SB_RDONLY)
+			sync_filesystem(fs_info->sb);
+	}
+}
+
+static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
+					 unsigned long old_opts)
+{
+	const bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
+
+	/*
+	 * We need to cleanup all defragable inodes if the autodefragment is
+	 * close or the filesystem is read only.
+	 */
+	if (btrfs_raw_test_opt(old_opts, AUTO_DEFRAG) &&
+	    (!btrfs_raw_test_opt(fs_info->mount_opt, AUTO_DEFRAG) || sb_rdonly(fs_info->sb))) {
+		btrfs_cleanup_defrag_inodes(fs_info);
+	}
+
+	/* If we toggled discard async */
+	if (!btrfs_raw_test_opt(old_opts, DISCARD_ASYNC) &&
+	    btrfs_test_opt(fs_info, DISCARD_ASYNC))
+		btrfs_discard_resume(fs_info);
+	else if (btrfs_raw_test_opt(old_opts, DISCARD_ASYNC) &&
+		 !btrfs_test_opt(fs_info, DISCARD_ASYNC))
+		btrfs_discard_cleanup(fs_info);
+
+	/* If we toggled space cache */
+	if (cache_opt != btrfs_free_space_cache_v1_active(fs_info))
+		btrfs_set_free_space_cache_v1_active(fs_info, cache_opt);
+}
+
+static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
+				     u32 new_pool_size, u32 old_pool_size)
+{
+	if (new_pool_size == old_pool_size)
+		return;
+
+	fs_info->thread_pool_size = new_pool_size;
+
+	btrfs_info(fs_info, "resize thread pool %d -> %d",
+	       old_pool_size, new_pool_size);
+
+	btrfs_workqueue_set_max(fs_info->workers, new_pool_size);
+	btrfs_workqueue_set_max(fs_info->hipri_workers, new_pool_size);
+	btrfs_workqueue_set_max(fs_info->delalloc_workers, new_pool_size);
+	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
+	workqueue_set_max_active(fs_info->endio_workers, new_pool_size);
+	workqueue_set_max_active(fs_info->endio_meta_workers, new_pool_size);
+	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
+	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_size);
+	btrfs_workqueue_set_max(fs_info->delayed_workers, new_pool_size);
+}
+
+static int btrfs_reconfigure(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct super_block *sb = fc->root->d_sb;
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	unsigned old_flags = sb->s_flags;
+	unsigned long old_opts = fs_info->mount_opt;
+	unsigned long old_compress_type = fs_info->compress_type;
+	u64 old_max_inline = fs_info->max_inline;
+	u32 old_thread_pool_size = fs_info->thread_pool_size;
+	u32 old_metadata_ratio = fs_info->metadata_ratio;
+	int ret = 0;
+
+	sync_filesystem(sb);
+	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+
+	/*
+	 * If ctx->phase is BTRFS_FS_CONTEXT_SUPER we've just created or
+	 * gotten a reference on a superblock immediately followed by an
+	 * internal remount. That can only happen for the old mount api.
+	 */
+	if (ctx->phase != BTRFS_FS_CONTEXT_SUPER)
+		ret = btrfs_fs_params_verify(fs_info, fc);
+	else if (WARN_ON(!fc->oldapi))
+		ret = -EINVAL;
+	if (ret)
+		goto restore;
+
+	ret = btrfs_check_features(fs_info, !(fc->sb_flags & SB_RDONLY));
+	if (ret < 0)
+		goto restore;
+
+	btrfs_remount_begin(fs_info, old_opts, fc->sb_flags);
+	btrfs_resize_thread_pool(fs_info, fs_info->thread_pool_size,
+				 old_thread_pool_size);
+
+	if ((bool)btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
+	    (bool)btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    (!sb_rdonly(sb) || (fc->sb_flags & SB_RDONLY))) {
+		btrfs_param_warn(fc,
+				 "remount supports changing free space tree only from ro to rw");
+		/* Make sure free space cache options match the state on disk */
+		if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
+		}
+		if (btrfs_free_space_cache_v1_active(fs_info)) {
+			btrfs_clear_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
+		}
+	}
+
+	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
+		goto out;
+
+	if (fc->sb_flags & SB_RDONLY) {
+		/*
+		 * this also happens on 'umount -rf' or on shutdown, when
+		 * the filesystem is busy.
+		 */
+		cancel_work_sync(&fs_info->async_reclaim_work);
+		cancel_work_sync(&fs_info->async_data_reclaim_work);
+
+		btrfs_discard_cleanup(fs_info);
+
+		/* wait for the uuid_scan task to finish */
+		down(&fs_info->uuid_tree_rescan_sem);
+		/* avoid complains from lockdep et al. */
+		up(&fs_info->uuid_tree_rescan_sem);
+
+		btrfs_set_sb_rdonly(sb);
+
+		/*
+		 * Setting SB_RDONLY will put the cleaner thread to
+		 * sleep at the next loop if it's already active.
+		 * If it's already asleep, we'll leave unused block
+		 * groups on disk until we're mounted read-write again
+		 * unless we clean them up here.
+		 */
+		btrfs_delete_unused_bgs(fs_info);
+
+		/*
+		 * The cleaner task could be already running before we set the
+		 * flag BTRFS_FS_STATE_RO (and SB_RDONLY in the superblock).
+		 * We must make sure that after we finish the remount, i.e. after
+		 * we call btrfs_commit_super(), the cleaner can no longer start
+		 * a transaction - either because it was dropping a dead root,
+		 * running delayed iputs or deleting an unused block group (the
+		 * cleaner picked a block group from the list of unused block
+		 * groups before we were able to in the previous call to
+		 * btrfs_delete_unused_bgs()).
+		 */
+		wait_on_bit(&fs_info->flags, BTRFS_FS_CLEANER_RUNNING,
+			    TASK_UNINTERRUPTIBLE);
+
+		/*
+		 * We've set the superblock to RO mode, so we might have made
+		 * the cleaner task sleep without running all pending delayed
+		 * iputs. Go through all the delayed iputs here, so that if an
+		 * unmount happens without remounting RW we don't end up at
+		 * finishing close_ctree() with a non-empty list of delayed
+		 * iputs.
+		 */
+		btrfs_run_delayed_iputs(fs_info);
+
+		btrfs_dev_replace_suspend_for_unmount(fs_info);
+		btrfs_scrub_cancel(fs_info);
+		btrfs_pause_balance(fs_info);
+
+		/*
+		 * Pause the qgroup rescan worker if it is running. We don't want
+		 * it to be still running after we are in RO mode, as after that,
+		 * by the time we unmount, it might have left a transaction open,
+		 * so we would leak the transaction and/or crash.
+		 */
+		btrfs_qgroup_wait_for_completion(fs_info, false);
+
+		ret = btrfs_commit_super(fs_info);
+		if (ret)
+			goto restore;
+	} else {
+		if (BTRFS_FS_ERROR(fs_info)) {
+			btrfs_err(fs_info,
+				"Remounting read-write after error is not allowed");
+			ret = -EINVAL;
+			goto restore;
+		}
+		if (fs_info->fs_devices->rw_devices == 0) {
+			ret = -EACCES;
+			goto restore;
+		}
+
+		if (!btrfs_check_rw_degradable(fs_info, NULL)) {
+			btrfs_param_warn(
+				fc,
+				"too many missing devices, writable remount is not allowed");
+			ret = -EACCES;
+			goto restore;
+		}
+
+		if (btrfs_super_log_root(fs_info->super_copy) != 0) {
+			btrfs_param_warn(
+				fc,
+				"mount required to replay tree-log, cannot remount read-write");
+			ret = -EINVAL;
+			goto restore;
+		}
+
+		/*
+		 * NOTE: when remounting with a change that does writes, don't
+		 * put it anywhere above this point, as we are not sure to be
+		 * safe to write until we pass the above checks.
+		 */
+		ret = btrfs_start_pre_rw_mount(fs_info);
+		if (ret)
+			goto restore;
+
+		btrfs_clear_sb_rdonly(sb);
+
+		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
+	}
+out:
+
+	if (fc->sb_flags & SB_POSIXACL)
+		sb->s_flags |= SB_POSIXACL;
+	else
+		sb->s_flags &= ~SB_POSIXACL;
+
+	wake_up_process(fs_info->transaction_kthread);
+	btrfs_remount_cleanup(fs_info, old_opts);
+	btrfs_clear_oneshot_options(fs_info);
+	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+
+	return 0;
+
+restore:
+	/* We've hit an error - don't reset SB_RDONLY */
+	if (sb_rdonly(sb))
+		old_flags |= SB_RDONLY;
+	if (!(old_flags & SB_RDONLY))
+		clear_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
+	sb->s_flags = old_flags;
+	fs_info->mount_opt = old_opts;
+	fs_info->compress_type = old_compress_type;
+	fs_info->max_inline = old_max_inline;
+	btrfs_resize_thread_pool(fs_info,
+		old_thread_pool_size, fs_info->thread_pool_size);
+	fs_info->metadata_ratio = old_metadata_ratio;
+	btrfs_remount_cleanup(fs_info, old_opts);
+	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+
+	return ret;
+}
+
+static const struct fs_context_operations btrfs_context_ops = {
+	.parse_param	= btrfs_parse_param,
+	.get_tree	= btrfs_get_tree,
+	.reconfigure	= btrfs_reconfigure,
+	.free		= btrfs_free_fs_context,
+	.dup		= btrfs_dup_fs_context,
+};
+
+int btrfs_init_fs_context(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct btrfs_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	refcount_set(&ctx->refs, 1);
+	ctx->phase = BTRFS_FS_CONTEXT_PREPARE;
+
+	/*
+	 * If this is a remount make sure that we copy the current mount
+	 * options into @ctx so checking for current options during
+	 * parameter parsing is identical for both remount and a regular
+	 * mount.
+	 */
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
+		btrfs_fs_info_to_context(ctx, btrfs_sb(fc->root->d_sb));
+	else
+		ctx->compress_type = BTRFS_COMPRESS_ZLIB;
+
+#ifdef CONFIG_BTRFS_FS_POSIX_ACL
+	fc->sb_flags	|= SB_POSIXACL;
+	fc->sb_flags	|= SB_I_VERSION;
+#endif
+	fc->fs_private	= ctx;
+	fc->ops		= &btrfs_context_ops;
+	return 0;
+}
diff --git a/fs/btrfs/params.h b/fs/btrfs/params.h
new file mode 100644
index 000000000000..85ccaa4a660f
--- /dev/null
+++ b/fs/btrfs/params.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Christian Brauner.
+ */
+
+#ifndef BTRFS_FS_CONTEXT_H
+#define BTRFS_FS_CONTEXT_H
+
+#include <linux/btrfs.h>
+#include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
+#include "fs.h"
+
+extern const struct fs_parameter_spec btrfs_parameter_spec[];
+
+int btrfs_fs_params_verify(struct btrfs_fs_info *info, struct fs_context *fc);
+int btrfs_get_tree(struct fs_context *fc);
+int btrfs_init_fs_context(struct fs_context *fc);
+
+#endif
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1c3c1d7ad68c..65172cfdad22 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -59,905 +59,17 @@
 #include "verity.h"
 #include "super.h"
 #include "extent-tree.h"
+#include "params.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
 static const struct super_operations btrfs_super_ops;
 
-/*
- * Types for mounting the default subvolume and a subvolume explicitly
- * requested by subvol=/path. That way the callchain is straightforward and we
- * don't have to play tricks with the mount options and recursive calls to
- * btrfs_mount.
- *
- * The new btrfs_root_fs_type also servers as a tag for the bdev_holder.
- */
-static struct file_system_type btrfs_fs_type;
-static struct file_system_type btrfs_root_fs_type;
-
-static int btrfs_remount(struct super_block *sb, int *flags, char *data);
-
 static void btrfs_put_super(struct super_block *sb)
 {
 	close_ctree(btrfs_sb(sb));
 }
 
-enum {
-	Opt_acl, Opt_noacl,
-	Opt_clear_cache,
-	Opt_commit_interval,
-	Opt_compress,
-	Opt_compress_force,
-	Opt_compress_force_type,
-	Opt_compress_type,
-	Opt_degraded,
-	Opt_device,
-	Opt_fatal_errors,
-	Opt_flushoncommit, Opt_noflushoncommit,
-	Opt_max_inline,
-	Opt_barrier, Opt_nobarrier,
-	Opt_datacow, Opt_nodatacow,
-	Opt_datasum, Opt_nodatasum,
-	Opt_defrag, Opt_nodefrag,
-	Opt_discard, Opt_nodiscard,
-	Opt_discard_mode,
-	Opt_norecovery,
-	Opt_ratio,
-	Opt_rescan_uuid_tree,
-	Opt_skip_balance,
-	Opt_space_cache, Opt_no_space_cache,
-	Opt_space_cache_version,
-	Opt_ssd, Opt_nossd,
-	Opt_ssd_spread, Opt_nossd_spread,
-	Opt_subvol,
-	Opt_subvol_empty,
-	Opt_subvolid,
-	Opt_thread_pool,
-	Opt_treelog, Opt_notreelog,
-	Opt_user_subvol_rm_allowed,
-
-	/* Rescue options */
-	Opt_rescue,
-	Opt_usebackuproot,
-	Opt_nologreplay,
-	Opt_ignorebadroots,
-	Opt_ignoredatacsums,
-	Opt_rescue_all,
-
-	/* Deprecated options */
-	Opt_recovery,
-	Opt_inode_cache, Opt_noinode_cache,
-
-	/* Debugging options */
-	Opt_check_integrity,
-	Opt_check_integrity_including_extent_data,
-	Opt_check_integrity_print_mask,
-	Opt_enospc_debug, Opt_noenospc_debug,
-#ifdef CONFIG_BTRFS_DEBUG
-	Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
-#endif
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
-	Opt_ref_verify,
-#endif
-	Opt_err,
-};
-
-static const match_table_t tokens = {
-	{Opt_acl, "acl"},
-	{Opt_noacl, "noacl"},
-	{Opt_clear_cache, "clear_cache"},
-	{Opt_commit_interval, "commit=%u"},
-	{Opt_compress, "compress"},
-	{Opt_compress_type, "compress=%s"},
-	{Opt_compress_force, "compress-force"},
-	{Opt_compress_force_type, "compress-force=%s"},
-	{Opt_degraded, "degraded"},
-	{Opt_device, "device=%s"},
-	{Opt_fatal_errors, "fatal_errors=%s"},
-	{Opt_flushoncommit, "flushoncommit"},
-	{Opt_noflushoncommit, "noflushoncommit"},
-	{Opt_inode_cache, "inode_cache"},
-	{Opt_noinode_cache, "noinode_cache"},
-	{Opt_max_inline, "max_inline=%s"},
-	{Opt_barrier, "barrier"},
-	{Opt_nobarrier, "nobarrier"},
-	{Opt_datacow, "datacow"},
-	{Opt_nodatacow, "nodatacow"},
-	{Opt_datasum, "datasum"},
-	{Opt_nodatasum, "nodatasum"},
-	{Opt_defrag, "autodefrag"},
-	{Opt_nodefrag, "noautodefrag"},
-	{Opt_discard, "discard"},
-	{Opt_discard_mode, "discard=%s"},
-	{Opt_nodiscard, "nodiscard"},
-	{Opt_norecovery, "norecovery"},
-	{Opt_ratio, "metadata_ratio=%u"},
-	{Opt_rescan_uuid_tree, "rescan_uuid_tree"},
-	{Opt_skip_balance, "skip_balance"},
-	{Opt_space_cache, "space_cache"},
-	{Opt_no_space_cache, "nospace_cache"},
-	{Opt_space_cache_version, "space_cache=%s"},
-	{Opt_ssd, "ssd"},
-	{Opt_nossd, "nossd"},
-	{Opt_ssd_spread, "ssd_spread"},
-	{Opt_nossd_spread, "nossd_spread"},
-	{Opt_subvol, "subvol=%s"},
-	{Opt_subvol_empty, "subvol="},
-	{Opt_subvolid, "subvolid=%s"},
-	{Opt_thread_pool, "thread_pool=%u"},
-	{Opt_treelog, "treelog"},
-	{Opt_notreelog, "notreelog"},
-	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
-
-	/* Rescue options */
-	{Opt_rescue, "rescue=%s"},
-	/* Deprecated, with alias rescue=nologreplay */
-	{Opt_nologreplay, "nologreplay"},
-	/* Deprecated, with alias rescue=usebackuproot */
-	{Opt_usebackuproot, "usebackuproot"},
-
-	/* Deprecated options */
-	{Opt_recovery, "recovery"},
-
-	/* Debugging options */
-	{Opt_check_integrity, "check_int"},
-	{Opt_check_integrity_including_extent_data, "check_int_data"},
-	{Opt_check_integrity_print_mask, "check_int_print_mask=%u"},
-	{Opt_enospc_debug, "enospc_debug"},
-	{Opt_noenospc_debug, "noenospc_debug"},
-#ifdef CONFIG_BTRFS_DEBUG
-	{Opt_fragment_data, "fragment=data"},
-	{Opt_fragment_metadata, "fragment=metadata"},
-	{Opt_fragment_all, "fragment=all"},
-#endif
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
-	{Opt_ref_verify, "ref_verify"},
-#endif
-	{Opt_err, NULL},
-};
-
-static const match_table_t rescue_tokens = {
-	{Opt_usebackuproot, "usebackuproot"},
-	{Opt_nologreplay, "nologreplay"},
-	{Opt_ignorebadroots, "ignorebadroots"},
-	{Opt_ignorebadroots, "ibadroots"},
-	{Opt_ignoredatacsums, "ignoredatacsums"},
-	{Opt_ignoredatacsums, "idatacsums"},
-	{Opt_rescue_all, "all"},
-	{Opt_err, NULL},
-};
-
-static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
-			    const char *opt_name)
-{
-	if (fs_info->mount_opt & opt) {
-		btrfs_err(fs_info, "%s must be used with ro mount option",
-			  opt_name);
-		return true;
-	}
-	return false;
-}
-
-static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
-{
-	char *opts;
-	char *orig;
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int ret = 0;
-
-	opts = kstrdup(options, GFP_KERNEL);
-	if (!opts)
-		return -ENOMEM;
-	orig = opts;
-
-	while ((p = strsep(&opts, ":")) != NULL) {
-		int token;
-
-		if (!*p)
-			continue;
-		token = match_token(p, rescue_tokens, args);
-		switch (token){
-		case Opt_usebackuproot:
-			btrfs_info(info,
-				   "trying to use backup root at mount time");
-			btrfs_set_opt(info->mount_opt, USEBACKUPROOT);
-			break;
-		case Opt_nologreplay:
-			btrfs_set_and_info(info, NOLOGREPLAY,
-					   "disabling log replay at mount time");
-			break;
-		case Opt_ignorebadroots:
-			btrfs_set_and_info(info, IGNOREBADROOTS,
-					   "ignoring bad roots");
-			break;
-		case Opt_ignoredatacsums:
-			btrfs_set_and_info(info, IGNOREDATACSUMS,
-					   "ignoring data csums");
-			break;
-		case Opt_rescue_all:
-			btrfs_info(info, "enabling all of the rescue options");
-			btrfs_set_and_info(info, IGNOREDATACSUMS,
-					   "ignoring data csums");
-			btrfs_set_and_info(info, IGNOREBADROOTS,
-					   "ignoring bad roots");
-			btrfs_set_and_info(info, NOLOGREPLAY,
-					   "disabling log replay at mount time");
-			break;
-		case Opt_err:
-			btrfs_info(info, "unrecognized rescue option '%s'", p);
-			ret = -EINVAL;
-			goto out;
-		default:
-			break;
-		}
-
-	}
-out:
-	kfree(orig);
-	return ret;
-}
-
-/*
- * Regular mount options parser.  Everything that is needed only when
- * reading in a new superblock is parsed here.
- * XXX JDM: This needs to be cleaned up for remount.
- */
-int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
-			unsigned long new_flags)
-{
-	substring_t args[MAX_OPT_ARGS];
-	char *p, *num;
-	int intarg;
-	int ret = 0;
-	char *compress_type;
-	bool compress_force = false;
-	enum btrfs_compression_type saved_compress_type;
-	int saved_compress_level;
-	bool saved_compress_force;
-	int no_compress = 0;
-	const bool remounting = test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state);
-
-	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
-		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
-	else if (btrfs_free_space_cache_v1_active(info)) {
-		if (btrfs_is_zoned(info)) {
-			btrfs_info(info,
-			"zoned: clearing existing space cache");
-			btrfs_set_super_cache_generation(info->super_copy, 0);
-		} else {
-			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
-		}
-	}
-
-	/*
-	 * Even the options are empty, we still need to do extra check
-	 * against new flags
-	 */
-	if (!options)
-		goto check;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_degraded:
-			btrfs_info(info, "allowing degraded mounts");
-			btrfs_set_opt(info->mount_opt, DEGRADED);
-			break;
-		case Opt_subvol:
-		case Opt_subvol_empty:
-		case Opt_subvolid:
-		case Opt_device:
-			/*
-			 * These are parsed by btrfs_parse_subvol_options or
-			 * btrfs_parse_device_options and can be ignored here.
-			 */
-			break;
-		case Opt_nodatasum:
-			btrfs_set_and_info(info, NODATASUM,
-					   "setting nodatasum");
-			break;
-		case Opt_datasum:
-			if (btrfs_test_opt(info, NODATASUM)) {
-				if (btrfs_test_opt(info, NODATACOW))
-					btrfs_info(info,
-						   "setting datasum, datacow enabled");
-				else
-					btrfs_info(info, "setting datasum");
-			}
-			btrfs_clear_opt(info->mount_opt, NODATACOW);
-			btrfs_clear_opt(info->mount_opt, NODATASUM);
-			break;
-		case Opt_nodatacow:
-			if (!btrfs_test_opt(info, NODATACOW)) {
-				if (!btrfs_test_opt(info, COMPRESS) ||
-				    !btrfs_test_opt(info, FORCE_COMPRESS)) {
-					btrfs_info(info,
-						   "setting nodatacow, compression disabled");
-				} else {
-					btrfs_info(info, "setting nodatacow");
-				}
-			}
-			btrfs_clear_opt(info->mount_opt, COMPRESS);
-			btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
-			btrfs_set_opt(info->mount_opt, NODATACOW);
-			btrfs_set_opt(info->mount_opt, NODATASUM);
-			break;
-		case Opt_datacow:
-			btrfs_clear_and_info(info, NODATACOW,
-					     "setting datacow");
-			break;
-		case Opt_compress_force:
-		case Opt_compress_force_type:
-			compress_force = true;
-			fallthrough;
-		case Opt_compress:
-		case Opt_compress_type:
-			saved_compress_type = btrfs_test_opt(info,
-							     COMPRESS) ?
-				info->compress_type : BTRFS_COMPRESS_NONE;
-			saved_compress_force =
-				btrfs_test_opt(info, FORCE_COMPRESS);
-			saved_compress_level = info->compress_level;
-			if (token == Opt_compress ||
-			    token == Opt_compress_force ||
-			    strncmp(args[0].from, "zlib", 4) == 0) {
-				compress_type = "zlib";
-
-				info->compress_type = BTRFS_COMPRESS_ZLIB;
-				info->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
-				/*
-				 * args[0] contains uninitialized data since
-				 * for these tokens we don't expect any
-				 * parameter.
-				 */
-				if (token != Opt_compress &&
-				    token != Opt_compress_force)
-					info->compress_level =
-					  btrfs_compress_str2level(
-							BTRFS_COMPRESS_ZLIB,
-							args[0].from + 4);
-				btrfs_set_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, NODATACOW);
-				btrfs_clear_opt(info->mount_opt, NODATASUM);
-				no_compress = 0;
-			} else if (strncmp(args[0].from, "lzo", 3) == 0) {
-				compress_type = "lzo";
-				info->compress_type = BTRFS_COMPRESS_LZO;
-				info->compress_level = 0;
-				btrfs_set_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, NODATACOW);
-				btrfs_clear_opt(info->mount_opt, NODATASUM);
-				btrfs_set_fs_incompat(info, COMPRESS_LZO);
-				no_compress = 0;
-			} else if (strncmp(args[0].from, "zstd", 4) == 0) {
-				compress_type = "zstd";
-				info->compress_type = BTRFS_COMPRESS_ZSTD;
-				info->compress_level =
-					btrfs_compress_str2level(
-							 BTRFS_COMPRESS_ZSTD,
-							 args[0].from + 4);
-				btrfs_set_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, NODATACOW);
-				btrfs_clear_opt(info->mount_opt, NODATASUM);
-				btrfs_set_fs_incompat(info, COMPRESS_ZSTD);
-				no_compress = 0;
-			} else if (strncmp(args[0].from, "no", 2) == 0) {
-				compress_type = "no";
-				info->compress_level = 0;
-				info->compress_type = 0;
-				btrfs_clear_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
-				compress_force = false;
-				no_compress++;
-			} else {
-				btrfs_err(info, "unrecognized compression value %s",
-					  args[0].from);
-				ret = -EINVAL;
-				goto out;
-			}
-
-			if (compress_force) {
-				btrfs_set_opt(info->mount_opt, FORCE_COMPRESS);
-			} else {
-				/*
-				 * If we remount from compress-force=xxx to
-				 * compress=xxx, we need clear FORCE_COMPRESS
-				 * flag, otherwise, there is no way for users
-				 * to disable forcible compression separately.
-				 */
-				btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
-			}
-			if (no_compress == 1) {
-				btrfs_info(info, "use no compression");
-			} else if ((info->compress_type != saved_compress_type) ||
-				   (compress_force != saved_compress_force) ||
-				   (info->compress_level != saved_compress_level)) {
-				btrfs_info(info, "%s %s compression, level %d",
-					   (compress_force) ? "force" : "use",
-					   compress_type, info->compress_level);
-			}
-			compress_force = false;
-			break;
-		case Opt_ssd:
-			btrfs_set_and_info(info, SSD,
-					   "enabling ssd optimizations");
-			btrfs_clear_opt(info->mount_opt, NOSSD);
-			break;
-		case Opt_ssd_spread:
-			btrfs_set_and_info(info, SSD,
-					   "enabling ssd optimizations");
-			btrfs_set_and_info(info, SSD_SPREAD,
-					   "using spread ssd allocation scheme");
-			btrfs_clear_opt(info->mount_opt, NOSSD);
-			break;
-		case Opt_nossd:
-			btrfs_set_opt(info->mount_opt, NOSSD);
-			btrfs_clear_and_info(info, SSD,
-					     "not using ssd optimizations");
-			fallthrough;
-		case Opt_nossd_spread:
-			btrfs_clear_and_info(info, SSD_SPREAD,
-					     "not using spread ssd allocation scheme");
-			break;
-		case Opt_barrier:
-			btrfs_clear_and_info(info, NOBARRIER,
-					     "turning on barriers");
-			break;
-		case Opt_nobarrier:
-			btrfs_set_and_info(info, NOBARRIER,
-					   "turning off barriers");
-			break;
-		case Opt_thread_pool:
-			ret = match_int(&args[0], &intarg);
-			if (ret) {
-				btrfs_err(info, "unrecognized thread_pool value %s",
-					  args[0].from);
-				goto out;
-			} else if (intarg == 0) {
-				btrfs_err(info, "invalid value 0 for thread_pool");
-				ret = -EINVAL;
-				goto out;
-			}
-			info->thread_pool_size = intarg;
-			break;
-		case Opt_max_inline:
-			num = match_strdup(&args[0]);
-			if (num) {
-				info->max_inline = memparse(num, NULL);
-				kfree(num);
-
-				if (info->max_inline) {
-					info->max_inline = min_t(u64,
-						info->max_inline,
-						info->sectorsize);
-				}
-				btrfs_info(info, "max_inline at %llu",
-					   info->max_inline);
-			} else {
-				ret = -ENOMEM;
-				goto out;
-			}
-			break;
-		case Opt_acl:
-#ifdef CONFIG_BTRFS_FS_POSIX_ACL
-			info->sb->s_flags |= SB_POSIXACL;
-			break;
-#else
-			btrfs_err(info, "support for ACL not compiled in!");
-			ret = -EINVAL;
-			goto out;
-#endif
-		case Opt_noacl:
-			info->sb->s_flags &= ~SB_POSIXACL;
-			break;
-		case Opt_notreelog:
-			btrfs_set_and_info(info, NOTREELOG,
-					   "disabling tree log");
-			break;
-		case Opt_treelog:
-			btrfs_clear_and_info(info, NOTREELOG,
-					     "enabling tree log");
-			break;
-		case Opt_norecovery:
-		case Opt_nologreplay:
-			btrfs_warn(info,
-		"'nologreplay' is deprecated, use 'rescue=nologreplay' instead");
-			btrfs_set_and_info(info, NOLOGREPLAY,
-					   "disabling log replay at mount time");
-			break;
-		case Opt_flushoncommit:
-			btrfs_set_and_info(info, FLUSHONCOMMIT,
-					   "turning on flush-on-commit");
-			break;
-		case Opt_noflushoncommit:
-			btrfs_clear_and_info(info, FLUSHONCOMMIT,
-					     "turning off flush-on-commit");
-			break;
-		case Opt_ratio:
-			ret = match_int(&args[0], &intarg);
-			if (ret) {
-				btrfs_err(info, "unrecognized metadata_ratio value %s",
-					  args[0].from);
-				goto out;
-			}
-			info->metadata_ratio = intarg;
-			btrfs_info(info, "metadata ratio %u",
-				   info->metadata_ratio);
-			break;
-		case Opt_discard:
-		case Opt_discard_mode:
-			if (token == Opt_discard ||
-			    strcmp(args[0].from, "sync") == 0) {
-				btrfs_clear_opt(info->mount_opt, DISCARD_ASYNC);
-				btrfs_set_and_info(info, DISCARD_SYNC,
-						   "turning on sync discard");
-			} else if (strcmp(args[0].from, "async") == 0) {
-				btrfs_clear_opt(info->mount_opt, DISCARD_SYNC);
-				btrfs_set_and_info(info, DISCARD_ASYNC,
-						   "turning on async discard");
-			} else {
-				btrfs_err(info, "unrecognized discard mode value %s",
-					  args[0].from);
-				ret = -EINVAL;
-				goto out;
-			}
-			btrfs_clear_opt(info->mount_opt, NODISCARD);
-			break;
-		case Opt_nodiscard:
-			btrfs_clear_and_info(info, DISCARD_SYNC,
-					     "turning off discard");
-			btrfs_clear_and_info(info, DISCARD_ASYNC,
-					     "turning off async discard");
-			btrfs_set_opt(info->mount_opt, NODISCARD);
-			break;
-		case Opt_space_cache:
-		case Opt_space_cache_version:
-			/*
-			 * We already set FREE_SPACE_TREE above because we have
-			 * compat_ro(FREE_SPACE_TREE) set, and we aren't going
-			 * to allow v1 to be set for extent tree v2, simply
-			 * ignore this setting if we're extent tree v2.
-			 */
-			if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
-				break;
-			if (token == Opt_space_cache ||
-			    strcmp(args[0].from, "v1") == 0) {
-				btrfs_clear_opt(info->mount_opt,
-						FREE_SPACE_TREE);
-				btrfs_set_and_info(info, SPACE_CACHE,
-					   "enabling disk space caching");
-			} else if (strcmp(args[0].from, "v2") == 0) {
-				btrfs_clear_opt(info->mount_opt,
-						SPACE_CACHE);
-				btrfs_set_and_info(info, FREE_SPACE_TREE,
-						   "enabling free space tree");
-			} else {
-				btrfs_err(info, "unrecognized space_cache value %s",
-					  args[0].from);
-				ret = -EINVAL;
-				goto out;
-			}
-			break;
-		case Opt_rescan_uuid_tree:
-			btrfs_set_opt(info->mount_opt, RESCAN_UUID_TREE);
-			break;
-		case Opt_no_space_cache:
-			/*
-			 * We cannot operate without the free space tree with
-			 * extent tree v2, ignore this option.
-			 */
-			if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
-				break;
-			if (btrfs_test_opt(info, SPACE_CACHE)) {
-				btrfs_clear_and_info(info, SPACE_CACHE,
-					     "disabling disk space caching");
-			}
-			if (btrfs_test_opt(info, FREE_SPACE_TREE)) {
-				btrfs_clear_and_info(info, FREE_SPACE_TREE,
-					     "disabling free space tree");
-			}
-			break;
-		case Opt_inode_cache:
-		case Opt_noinode_cache:
-			btrfs_warn(info,
-	"the 'inode_cache' option is deprecated and has no effect since 5.11");
-			break;
-		case Opt_clear_cache:
-			/*
-			 * We cannot clear the free space tree with extent tree
-			 * v2, ignore this option.
-			 */
-			if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
-				break;
-			btrfs_set_and_info(info, CLEAR_CACHE,
-					   "force clearing of disk cache");
-			break;
-		case Opt_user_subvol_rm_allowed:
-			btrfs_set_opt(info->mount_opt, USER_SUBVOL_RM_ALLOWED);
-			break;
-		case Opt_enospc_debug:
-			btrfs_set_opt(info->mount_opt, ENOSPC_DEBUG);
-			break;
-		case Opt_noenospc_debug:
-			btrfs_clear_opt(info->mount_opt, ENOSPC_DEBUG);
-			break;
-		case Opt_defrag:
-			btrfs_set_and_info(info, AUTO_DEFRAG,
-					   "enabling auto defrag");
-			break;
-		case Opt_nodefrag:
-			btrfs_clear_and_info(info, AUTO_DEFRAG,
-					     "disabling auto defrag");
-			break;
-		case Opt_recovery:
-		case Opt_usebackuproot:
-			btrfs_warn(info,
-			"'%s' is deprecated, use 'rescue=usebackuproot' instead",
-				   token == Opt_recovery ? "recovery" :
-				   "usebackuproot");
-			btrfs_info(info,
-				   "trying to use backup root at mount time");
-			btrfs_set_opt(info->mount_opt, USEBACKUPROOT);
-			break;
-		case Opt_skip_balance:
-			btrfs_set_opt(info->mount_opt, SKIP_BALANCE);
-			break;
-#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-		case Opt_check_integrity_including_extent_data:
-			btrfs_info(info,
-				   "enabling check integrity including extent data");
-			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY_DATA);
-			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY);
-			break;
-		case Opt_check_integrity:
-			btrfs_info(info, "enabling check integrity");
-			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY);
-			break;
-		case Opt_check_integrity_print_mask:
-			ret = match_int(&args[0], &intarg);
-			if (ret) {
-				btrfs_err(info,
-				"unrecognized check_integrity_print_mask value %s",
-					args[0].from);
-				goto out;
-			}
-			info->check_integrity_print_mask = intarg;
-			btrfs_info(info, "check_integrity_print_mask 0x%x",
-				   info->check_integrity_print_mask);
-			break;
-#else
-		case Opt_check_integrity_including_extent_data:
-		case Opt_check_integrity:
-		case Opt_check_integrity_print_mask:
-			btrfs_err(info,
-				  "support for check_integrity* not compiled in!");
-			ret = -EINVAL;
-			goto out;
-#endif
-		case Opt_fatal_errors:
-			if (strcmp(args[0].from, "panic") == 0) {
-				btrfs_set_opt(info->mount_opt,
-					      PANIC_ON_FATAL_ERROR);
-			} else if (strcmp(args[0].from, "bug") == 0) {
-				btrfs_clear_opt(info->mount_opt,
-					      PANIC_ON_FATAL_ERROR);
-			} else {
-				btrfs_err(info, "unrecognized fatal_errors value %s",
-					  args[0].from);
-				ret = -EINVAL;
-				goto out;
-			}
-			break;
-		case Opt_commit_interval:
-			intarg = 0;
-			ret = match_int(&args[0], &intarg);
-			if (ret) {
-				btrfs_err(info, "unrecognized commit_interval value %s",
-					  args[0].from);
-				ret = -EINVAL;
-				goto out;
-			}
-			if (intarg == 0) {
-				btrfs_info(info,
-					   "using default commit interval %us",
-					   BTRFS_DEFAULT_COMMIT_INTERVAL);
-				intarg = BTRFS_DEFAULT_COMMIT_INTERVAL;
-			} else if (intarg > 300) {
-				btrfs_warn(info, "excessive commit interval %d",
-					   intarg);
-			}
-			info->commit_interval = intarg;
-			break;
-		case Opt_rescue:
-			ret = parse_rescue_options(info, args[0].from);
-			if (ret < 0) {
-				btrfs_err(info, "unrecognized rescue value %s",
-					  args[0].from);
-				goto out;
-			}
-			break;
-#ifdef CONFIG_BTRFS_DEBUG
-		case Opt_fragment_all:
-			btrfs_info(info, "fragmenting all space");
-			btrfs_set_opt(info->mount_opt, FRAGMENT_DATA);
-			btrfs_set_opt(info->mount_opt, FRAGMENT_METADATA);
-			break;
-		case Opt_fragment_metadata:
-			btrfs_info(info, "fragmenting metadata");
-			btrfs_set_opt(info->mount_opt,
-				      FRAGMENT_METADATA);
-			break;
-		case Opt_fragment_data:
-			btrfs_info(info, "fragmenting data");
-			btrfs_set_opt(info->mount_opt, FRAGMENT_DATA);
-			break;
-#endif
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
-		case Opt_ref_verify:
-			btrfs_info(info, "doing ref verification");
-			btrfs_set_opt(info->mount_opt, REF_VERIFY);
-			break;
-#endif
-		case Opt_err:
-			btrfs_err(info, "unrecognized mount option '%s'", p);
-			ret = -EINVAL;
-			goto out;
-		default:
-			break;
-		}
-	}
-check:
-	/* We're read-only, don't have to check. */
-	if (new_flags & SB_RDONLY)
-		goto out;
-
-	if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
-	    check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
-	    check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums"))
-		ret = -EINVAL;
-out:
-	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
-	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
-	    !btrfs_test_opt(info, CLEAR_CACHE)) {
-		btrfs_err(info, "cannot disable free space tree");
-		ret = -EINVAL;
-	}
-	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
-	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
-		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
-		ret = -EINVAL;
-	}
-	if (!ret)
-		ret = btrfs_check_mountopts_zoned(info);
-	if (!ret && !remounting) {
-		if (btrfs_test_opt(info, SPACE_CACHE))
-			btrfs_info(info, "disk space caching is enabled");
-		if (btrfs_test_opt(info, FREE_SPACE_TREE))
-			btrfs_info(info, "using free space tree");
-	}
-	return ret;
-}
-
-/*
- * Parse mount options that are required early in the mount process.
- *
- * All other options will be parsed on much later in the mount process and
- * only when we need to allocate a new super block.
- */
-static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
-{
-	substring_t args[MAX_OPT_ARGS];
-	char *device_name, *opts, *orig, *p;
-	struct btrfs_device *device = NULL;
-	int error = 0;
-
-	lockdep_assert_held(&uuid_mutex);
-
-	if (!options)
-		return 0;
-
-	/*
-	 * strsep changes the string, duplicate it because btrfs_parse_options
-	 * gets called later
-	 */
-	opts = kstrdup(options, GFP_KERNEL);
-	if (!opts)
-		return -ENOMEM;
-	orig = opts;
-
-	while ((p = strsep(&opts, ",")) != NULL) {
-		int token;
-
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		if (token == Opt_device) {
-			device_name = match_strdup(&args[0]);
-			if (!device_name) {
-				error = -ENOMEM;
-				goto out;
-			}
-			device = btrfs_scan_one_device(device_name, flags);
-			kfree(device_name);
-			if (IS_ERR(device)) {
-				error = PTR_ERR(device);
-				goto out;
-			}
-		}
-	}
-
-out:
-	kfree(orig);
-	return error;
-}
-
-/*
- * Parse mount options that are related to subvolume id
- *
- * The value is later passed to mount_subvol()
- */
-static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
-		u64 *subvol_objectid)
-{
-	substring_t args[MAX_OPT_ARGS];
-	char *opts, *orig, *p;
-	int error = 0;
-	u64 subvolid;
-
-	if (!options)
-		return 0;
-
-	/*
-	 * strsep changes the string, duplicate it because
-	 * btrfs_parse_device_options gets called later
-	 */
-	opts = kstrdup(options, GFP_KERNEL);
-	if (!opts)
-		return -ENOMEM;
-	orig = opts;
-
-	while ((p = strsep(&opts, ",")) != NULL) {
-		int token;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_subvol:
-			kfree(*subvol_name);
-			*subvol_name = match_strdup(&args[0]);
-			if (!*subvol_name) {
-				error = -ENOMEM;
-				goto out;
-			}
-			break;
-		case Opt_subvolid:
-			error = match_u64(&args[0], &subvolid);
-			if (error)
-				goto out;
-
-			/* we want the original fs_tree */
-			if (subvolid == 0)
-				subvolid = BTRFS_FS_TREE_OBJECTID;
-
-			*subvol_objectid = subvolid;
-			break;
-		default:
-			break;
-		}
-	}
-
-out:
-	kfree(orig);
-	return error;
-}
-
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid)
 {
@@ -1080,50 +192,8 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 	return ERR_PTR(ret);
 }
 
-static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objectid)
-{
-	struct btrfs_root *root = fs_info->tree_root;
-	struct btrfs_dir_item *di;
-	struct btrfs_path *path;
-	struct btrfs_key location;
-	struct fscrypt_str name = FSTR_INIT("default", 7);
-	u64 dir_id;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	/*
-	 * Find the "default" dir item which points to the root item that we
-	 * will mount by default if we haven't been given a specific subvolume
-	 * to mount.
-	 */
-	dir_id = btrfs_super_root_dir(fs_info->super_copy);
-	di = btrfs_lookup_dir_item(NULL, root, path, dir_id, &name, 0);
-	if (IS_ERR(di)) {
-		btrfs_free_path(path);
-		return PTR_ERR(di);
-	}
-	if (!di) {
-		/*
-		 * Ok the default dir item isn't there.  This is weird since
-		 * it's always been there, but don't freak out, just try and
-		 * mount the top-level subvolume.
-		 */
-		btrfs_free_path(path);
-		*objectid = BTRFS_FS_TREE_OBJECTID;
-		return 0;
-	}
-
-	btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
-	btrfs_free_path(path);
-	*objectid = location.objectid;
-	return 0;
-}
-
-static int btrfs_fill_super(struct super_block *sb,
-			    struct btrfs_fs_devices *fs_devices,
-			    void *data)
+int btrfs_fill_super(struct fs_context *fc, struct super_block *sb,
+		     struct btrfs_fs_devices *fs_devices)
 {
 	struct inode *inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
@@ -1139,10 +209,6 @@ static int btrfs_fill_super(struct super_block *sb,
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;
-#ifdef CONFIG_BTRFS_FS_POSIX_ACL
-	sb->s_flags |= SB_POSIXACL;
-#endif
-	sb->s_flags |= SB_I_VERSION;
 	sb->s_iflags |= SB_I_CGROUPWB;
 
 	err = super_setup_bdi(sb);
@@ -1151,7 +217,7 @@ static int btrfs_fill_super(struct super_block *sb,
 		return err;
 	}
 
-	err = open_ctree(sb, fs_devices, (char *)data);
+	err = open_ctree(fc, sb, fs_devices);
 	if (err) {
 		btrfs_err(fs_info, "open_ctree failed");
 		return err;
@@ -1334,542 +400,6 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	return 0;
 }
 
-static int btrfs_test_super(struct super_block *s, void *data)
-{
-	struct btrfs_fs_info *p = data;
-	struct btrfs_fs_info *fs_info = btrfs_sb(s);
-
-	return fs_info->fs_devices == p->fs_devices;
-}
-
-static int btrfs_set_super(struct super_block *s, void *data)
-{
-	int err = set_anon_super(s, data);
-	if (!err)
-		s->s_fs_info = data;
-	return err;
-}
-
-/*
- * subvolumes are identified by ino 256
- */
-static inline int is_subvolume_inode(struct inode *inode)
-{
-	if (inode && inode->i_ino == BTRFS_FIRST_FREE_OBJECTID)
-		return 1;
-	return 0;
-}
-
-static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
-				   struct vfsmount *mnt)
-{
-	struct dentry *root;
-	int ret;
-
-	if (!subvol_name) {
-		if (!subvol_objectid) {
-			ret = get_default_subvol_objectid(btrfs_sb(mnt->mnt_sb),
-							  &subvol_objectid);
-			if (ret) {
-				root = ERR_PTR(ret);
-				goto out;
-			}
-		}
-		subvol_name = btrfs_get_subvol_name_from_objectid(
-					btrfs_sb(mnt->mnt_sb), subvol_objectid);
-		if (IS_ERR(subvol_name)) {
-			root = ERR_CAST(subvol_name);
-			subvol_name = NULL;
-			goto out;
-		}
-
-	}
-
-	root = mount_subtree(mnt, subvol_name);
-	/* mount_subtree() drops our reference on the vfsmount. */
-	mnt = NULL;
-
-	if (!IS_ERR(root)) {
-		struct super_block *s = root->d_sb;
-		struct btrfs_fs_info *fs_info = btrfs_sb(s);
-		struct inode *root_inode = d_inode(root);
-		u64 root_objectid = BTRFS_I(root_inode)->root->root_key.objectid;
-
-		ret = 0;
-		if (!is_subvolume_inode(root_inode)) {
-			btrfs_err(fs_info, "'%s' is not a valid subvolume",
-			       subvol_name);
-			ret = -EINVAL;
-		}
-		if (subvol_objectid && root_objectid != subvol_objectid) {
-			/*
-			 * This will also catch a race condition where a
-			 * subvolume which was passed by ID is renamed and
-			 * another subvolume is renamed over the old location.
-			 */
-			btrfs_err(fs_info,
-				  "subvol '%s' does not match subvolid %llu",
-				  subvol_name, subvol_objectid);
-			ret = -EINVAL;
-		}
-		if (ret) {
-			dput(root);
-			root = ERR_PTR(ret);
-			deactivate_locked_super(s);
-		}
-	}
-
-out:
-	mntput(mnt);
-	kfree(subvol_name);
-	return root;
-}
-
-/*
- * Find a superblock for the given device / mount point.
- *
- * Note: This is based on mount_bdev from fs/super.c with a few additions
- *       for multiple device setup.  Make sure to keep it in sync.
- */
-static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
-		int flags, const char *device_name, void *data)
-{
-	struct block_device *bdev = NULL;
-	struct super_block *s;
-	struct btrfs_device *device = NULL;
-	struct btrfs_fs_devices *fs_devices = NULL;
-	struct btrfs_fs_info *fs_info = NULL;
-	void *new_sec_opts = NULL;
-	blk_mode_t mode = sb_open_mode(flags);
-	int error = 0;
-
-	if (data) {
-		error = security_sb_eat_lsm_opts(data, &new_sec_opts);
-		if (error)
-			return ERR_PTR(error);
-	}
-
-	/*
-	 * Setup a dummy root and fs_info for test/set super.  This is because
-	 * we don't actually fill this stuff out until open_ctree, but we need
-	 * then open_ctree will properly initialize the file system specific
-	 * settings later.  btrfs_init_fs_info initializes the static elements
-	 * of the fs_info (locks and such) to make cleanup easier if we find a
-	 * superblock with our given fs_devices later on at sget() time.
-	 */
-	fs_info = kvzalloc(sizeof(struct btrfs_fs_info), GFP_KERNEL);
-	if (!fs_info) {
-		error = -ENOMEM;
-		goto error_sec_opts;
-	}
-	btrfs_init_fs_info(fs_info);
-
-	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
-	fs_info->super_for_commit = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
-	if (!fs_info->super_copy || !fs_info->super_for_commit) {
-		error = -ENOMEM;
-		goto error_fs_info;
-	}
-
-	mutex_lock(&uuid_mutex);
-	error = btrfs_parse_device_options(data, mode);
-	if (error) {
-		mutex_unlock(&uuid_mutex);
-		goto error_fs_info;
-	}
-
-	device = btrfs_scan_one_device(device_name, mode);
-	if (IS_ERR(device)) {
-		mutex_unlock(&uuid_mutex);
-		error = PTR_ERR(device);
-		goto error_fs_info;
-	}
-
-	fs_devices = device->fs_devices;
-	fs_info->fs_devices = fs_devices;
-
-	error = btrfs_open_devices(fs_devices, mode, fs_type);
-	mutex_unlock(&uuid_mutex);
-	if (error)
-		goto error_fs_info;
-
-	if (!(flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
-		error = -EACCES;
-		goto error_close_devices;
-	}
-
-	bdev = fs_devices->latest_dev->bdev;
-	s = sget(fs_type, btrfs_test_super, btrfs_set_super, flags | SB_NOSEC,
-		 fs_info);
-	if (IS_ERR(s)) {
-		error = PTR_ERR(s);
-		goto error_close_devices;
-	}
-
-	if (s->s_root) {
-		btrfs_close_devices(fs_devices);
-		btrfs_free_fs_info(fs_info);
-		if ((flags ^ s->s_flags) & SB_RDONLY)
-			error = -EBUSY;
-	} else {
-		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
-		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
-					s->s_id);
-		btrfs_sb(s)->bdev_holder = fs_type;
-		error = btrfs_fill_super(s, fs_devices, data);
-	}
-	if (!error)
-		error = security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);
-	security_free_mnt_opts(&new_sec_opts);
-	if (error) {
-		deactivate_locked_super(s);
-		return ERR_PTR(error);
-	}
-
-	return dget(s->s_root);
-
-error_close_devices:
-	btrfs_close_devices(fs_devices);
-error_fs_info:
-	btrfs_free_fs_info(fs_info);
-error_sec_opts:
-	security_free_mnt_opts(&new_sec_opts);
-	return ERR_PTR(error);
-}
-
-/*
- * Mount function which is called by VFS layer.
- *
- * In order to allow mounting a subvolume directly, btrfs uses mount_subtree()
- * which needs vfsmount* of device's root (/).  This means device's root has to
- * be mounted internally in any case.
- *
- * Operation flow:
- *   1. Parse subvol id related options for later use in mount_subvol().
- *
- *   2. Mount device's root (/) by calling vfs_kern_mount().
- *
- *      NOTE: vfs_kern_mount() is used by VFS to call btrfs_mount() in the
- *      first place. In order to avoid calling btrfs_mount() again, we use
- *      different file_system_type which is not registered to VFS by
- *      register_filesystem() (btrfs_root_fs_type). As a result,
- *      btrfs_mount_root() is called. The return value will be used by
- *      mount_subtree() in mount_subvol().
- *
- *   3. Call mount_subvol() to get the dentry of subvolume. Since there is
- *      "btrfs subvolume set-default", mount_subvol() is called always.
- */
-static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
-		const char *device_name, void *data)
-{
-	struct vfsmount *mnt_root;
-	struct dentry *root;
-	char *subvol_name = NULL;
-	u64 subvol_objectid = 0;
-	int error = 0;
-
-	error = btrfs_parse_subvol_options(data, &subvol_name,
-					&subvol_objectid);
-	if (error) {
-		kfree(subvol_name);
-		return ERR_PTR(error);
-	}
-
-	/* mount device's root (/) */
-	mnt_root = vfs_kern_mount(&btrfs_root_fs_type, flags, device_name, data);
-	if (PTR_ERR_OR_ZERO(mnt_root) == -EBUSY) {
-		if (flags & SB_RDONLY) {
-			mnt_root = vfs_kern_mount(&btrfs_root_fs_type,
-				flags & ~SB_RDONLY, device_name, data);
-		} else {
-			mnt_root = vfs_kern_mount(&btrfs_root_fs_type,
-				flags | SB_RDONLY, device_name, data);
-			if (IS_ERR(mnt_root)) {
-				root = ERR_CAST(mnt_root);
-				kfree(subvol_name);
-				goto out;
-			}
-
-			down_write(&mnt_root->mnt_sb->s_umount);
-			error = btrfs_remount(mnt_root->mnt_sb, &flags, NULL);
-			up_write(&mnt_root->mnt_sb->s_umount);
-			if (error < 0) {
-				root = ERR_PTR(error);
-				mntput(mnt_root);
-				kfree(subvol_name);
-				goto out;
-			}
-		}
-	}
-	if (IS_ERR(mnt_root)) {
-		root = ERR_CAST(mnt_root);
-		kfree(subvol_name);
-		goto out;
-	}
-
-	/* mount_subvol() will free subvol_name and mnt_root */
-	root = mount_subvol(subvol_name, subvol_objectid, mnt_root);
-
-out:
-	return root;
-}
-
-static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
-				     u32 new_pool_size, u32 old_pool_size)
-{
-	if (new_pool_size == old_pool_size)
-		return;
-
-	fs_info->thread_pool_size = new_pool_size;
-
-	btrfs_info(fs_info, "resize thread pool %d -> %d",
-	       old_pool_size, new_pool_size);
-
-	btrfs_workqueue_set_max(fs_info->workers, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->hipri_workers, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->delalloc_workers, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
-	workqueue_set_max_active(fs_info->endio_workers, new_pool_size);
-	workqueue_set_max_active(fs_info->endio_meta_workers, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->delayed_workers, new_pool_size);
-}
-
-static inline void btrfs_remount_begin(struct btrfs_fs_info *fs_info,
-				       unsigned long old_opts, int flags)
-{
-	if (btrfs_raw_test_opt(old_opts, AUTO_DEFRAG) &&
-	    (!btrfs_raw_test_opt(fs_info->mount_opt, AUTO_DEFRAG) ||
-	     (flags & SB_RDONLY))) {
-		/* wait for any defraggers to finish */
-		wait_event(fs_info->transaction_wait,
-			   (atomic_read(&fs_info->defrag_running) == 0));
-		if (flags & SB_RDONLY)
-			sync_filesystem(fs_info->sb);
-	}
-}
-
-static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
-					 unsigned long old_opts)
-{
-	const bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
-
-	/*
-	 * We need to cleanup all defragable inodes if the autodefragment is
-	 * close or the filesystem is read only.
-	 */
-	if (btrfs_raw_test_opt(old_opts, AUTO_DEFRAG) &&
-	    (!btrfs_raw_test_opt(fs_info->mount_opt, AUTO_DEFRAG) || sb_rdonly(fs_info->sb))) {
-		btrfs_cleanup_defrag_inodes(fs_info);
-	}
-
-	/* If we toggled discard async */
-	if (!btrfs_raw_test_opt(old_opts, DISCARD_ASYNC) &&
-	    btrfs_test_opt(fs_info, DISCARD_ASYNC))
-		btrfs_discard_resume(fs_info);
-	else if (btrfs_raw_test_opt(old_opts, DISCARD_ASYNC) &&
-		 !btrfs_test_opt(fs_info, DISCARD_ASYNC))
-		btrfs_discard_cleanup(fs_info);
-
-	/* If we toggled space cache */
-	if (cache_opt != btrfs_free_space_cache_v1_active(fs_info))
-		btrfs_set_free_space_cache_v1_active(fs_info, cache_opt);
-}
-
-static int btrfs_remount(struct super_block *sb, int *flags, char *data)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-	unsigned old_flags = sb->s_flags;
-	unsigned long old_opts = fs_info->mount_opt;
-	unsigned long old_compress_type = fs_info->compress_type;
-	u64 old_max_inline = fs_info->max_inline;
-	u32 old_thread_pool_size = fs_info->thread_pool_size;
-	u32 old_metadata_ratio = fs_info->metadata_ratio;
-	int ret;
-
-	sync_filesystem(sb);
-	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
-
-	if (data) {
-		void *new_sec_opts = NULL;
-
-		ret = security_sb_eat_lsm_opts(data, &new_sec_opts);
-		if (!ret)
-			ret = security_sb_remount(sb, new_sec_opts);
-		security_free_mnt_opts(&new_sec_opts);
-		if (ret)
-			goto restore;
-	}
-
-	ret = btrfs_parse_options(fs_info, data, *flags);
-	if (ret)
-		goto restore;
-
-	ret = btrfs_check_features(fs_info, !(*flags & SB_RDONLY));
-	if (ret < 0)
-		goto restore;
-
-	btrfs_remount_begin(fs_info, old_opts, *flags);
-	btrfs_resize_thread_pool(fs_info,
-		fs_info->thread_pool_size, old_thread_pool_size);
-
-	if ((bool)btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
-	    (bool)btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
-	    (!sb_rdonly(sb) || (*flags & SB_RDONLY))) {
-		btrfs_warn(fs_info,
-		"remount supports changing free space tree only from ro to rw");
-		/* Make sure free space cache options match the state on disk */
-		if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
-			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
-			btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
-		}
-		if (btrfs_free_space_cache_v1_active(fs_info)) {
-			btrfs_clear_opt(fs_info->mount_opt, FREE_SPACE_TREE);
-			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
-		}
-	}
-
-	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
-		goto out;
-
-	if (*flags & SB_RDONLY) {
-		/*
-		 * this also happens on 'umount -rf' or on shutdown, when
-		 * the filesystem is busy.
-		 */
-		cancel_work_sync(&fs_info->async_reclaim_work);
-		cancel_work_sync(&fs_info->async_data_reclaim_work);
-
-		btrfs_discard_cleanup(fs_info);
-
-		/* wait for the uuid_scan task to finish */
-		down(&fs_info->uuid_tree_rescan_sem);
-		/* avoid complains from lockdep et al. */
-		up(&fs_info->uuid_tree_rescan_sem);
-
-		btrfs_set_sb_rdonly(sb);
-
-		/*
-		 * Setting SB_RDONLY will put the cleaner thread to
-		 * sleep at the next loop if it's already active.
-		 * If it's already asleep, we'll leave unused block
-		 * groups on disk until we're mounted read-write again
-		 * unless we clean them up here.
-		 */
-		btrfs_delete_unused_bgs(fs_info);
-
-		/*
-		 * The cleaner task could be already running before we set the
-		 * flag BTRFS_FS_STATE_RO (and SB_RDONLY in the superblock).
-		 * We must make sure that after we finish the remount, i.e. after
-		 * we call btrfs_commit_super(), the cleaner can no longer start
-		 * a transaction - either because it was dropping a dead root,
-		 * running delayed iputs or deleting an unused block group (the
-		 * cleaner picked a block group from the list of unused block
-		 * groups before we were able to in the previous call to
-		 * btrfs_delete_unused_bgs()).
-		 */
-		wait_on_bit(&fs_info->flags, BTRFS_FS_CLEANER_RUNNING,
-			    TASK_UNINTERRUPTIBLE);
-
-		/*
-		 * We've set the superblock to RO mode, so we might have made
-		 * the cleaner task sleep without running all pending delayed
-		 * iputs. Go through all the delayed iputs here, so that if an
-		 * unmount happens without remounting RW we don't end up at
-		 * finishing close_ctree() with a non-empty list of delayed
-		 * iputs.
-		 */
-		btrfs_run_delayed_iputs(fs_info);
-
-		btrfs_dev_replace_suspend_for_unmount(fs_info);
-		btrfs_scrub_cancel(fs_info);
-		btrfs_pause_balance(fs_info);
-
-		/*
-		 * Pause the qgroup rescan worker if it is running. We don't want
-		 * it to be still running after we are in RO mode, as after that,
-		 * by the time we unmount, it might have left a transaction open,
-		 * so we would leak the transaction and/or crash.
-		 */
-		btrfs_qgroup_wait_for_completion(fs_info, false);
-
-		ret = btrfs_commit_super(fs_info);
-		if (ret)
-			goto restore;
-	} else {
-		if (BTRFS_FS_ERROR(fs_info)) {
-			btrfs_err(fs_info,
-				"Remounting read-write after error is not allowed");
-			ret = -EINVAL;
-			goto restore;
-		}
-		if (fs_info->fs_devices->rw_devices == 0) {
-			ret = -EACCES;
-			goto restore;
-		}
-
-		if (!btrfs_check_rw_degradable(fs_info, NULL)) {
-			btrfs_warn(fs_info,
-		"too many missing devices, writable remount is not allowed");
-			ret = -EACCES;
-			goto restore;
-		}
-
-		if (btrfs_super_log_root(fs_info->super_copy) != 0) {
-			btrfs_warn(fs_info,
-		"mount required to replay tree-log, cannot remount read-write");
-			ret = -EINVAL;
-			goto restore;
-		}
-
-		/*
-		 * NOTE: when remounting with a change that does writes, don't
-		 * put it anywhere above this point, as we are not sure to be
-		 * safe to write until we pass the above checks.
-		 */
-		ret = btrfs_start_pre_rw_mount(fs_info);
-		if (ret)
-			goto restore;
-
-		btrfs_clear_sb_rdonly(sb);
-
-		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
-	}
-out:
-	/*
-	 * We need to set SB_I_VERSION here otherwise it'll get cleared by VFS,
-	 * since the absence of the flag means it can be toggled off by remount.
-	 */
-	*flags |= SB_I_VERSION;
-
-	wake_up_process(fs_info->transaction_kthread);
-	btrfs_remount_cleanup(fs_info, old_opts);
-	btrfs_clear_oneshot_options(fs_info);
-	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
-
-	return 0;
-
-restore:
-	/* We've hit an error - don't reset SB_RDONLY */
-	if (sb_rdonly(sb))
-		old_flags |= SB_RDONLY;
-	if (!(old_flags & SB_RDONLY))
-		clear_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
-	sb->s_flags = old_flags;
-	fs_info->mount_opt = old_opts;
-	fs_info->compress_type = old_compress_type;
-	fs_info->max_inline = old_max_inline;
-	btrfs_resize_thread_pool(fs_info,
-		old_thread_pool_size, fs_info->thread_pool_size);
-	fs_info->metadata_ratio = old_metadata_ratio;
-	btrfs_remount_cleanup(fs_info, old_opts);
-	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
-
-	return ret;
-}
-
 /* Used to sort the devices by max_avail(descending sort) */
 static int btrfs_cmp_device_free_bytes(const void *a, const void *b)
 {
@@ -2134,20 +664,13 @@ static void btrfs_kill_super(struct super_block *sb)
 	btrfs_free_fs_info(fs_info);
 }
 
-static struct file_system_type btrfs_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "btrfs",
-	.mount		= btrfs_mount,
-	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
-};
-
-static struct file_system_type btrfs_root_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "btrfs",
-	.mount		= btrfs_mount_root,
-	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
+struct file_system_type btrfs_fs_type = {
+	.owner			= THIS_MODULE,
+	.name			= "btrfs",
+	.init_fs_context	= btrfs_init_fs_context,
+	.parameters		= btrfs_parameter_spec,
+	.kill_sb		= btrfs_kill_super,
+	.fs_flags		= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
 };
 
 MODULE_ALIAS_FS("btrfs");
@@ -2352,7 +875,6 @@ static const struct super_operations btrfs_super_ops = {
 	.destroy_inode	= btrfs_destroy_inode,
 	.free_inode	= btrfs_free_inode,
 	.statfs		= btrfs_statfs,
-	.remount_fs	= btrfs_remount,
 	.freeze_fs	= btrfs_freeze,
 	.unfreeze_fs	= btrfs_unfreeze,
 };
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index 8dbb909b364f..2901eea1541c 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -3,8 +3,8 @@
 #ifndef BTRFS_SUPER_H
 #define BTRFS_SUPER_H
 
-int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
-			unsigned long new_flags);
+extern struct file_system_type btrfs_fs_type;
+
 int btrfs_sync_fs(struct super_block *sb, int wait);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid);
@@ -26,4 +26,7 @@ static inline void btrfs_clear_sb_rdonly(struct super_block *sb)
 	clear_bit(BTRFS_FS_STATE_RO, &btrfs_sb(sb)->fs_state);
 }
 
+int btrfs_fill_super(struct fs_context *fc, struct super_block *sb,
+		     struct btrfs_fs_devices *fs_devices);
+
 #endif

-- 
2.34.1

