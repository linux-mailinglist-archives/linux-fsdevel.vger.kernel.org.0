Return-Path: <linux-fsdevel+bounces-25864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C875F95127D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBC21C20B85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8873C38DCD;
	Wed, 14 Aug 2024 02:32:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA21C694
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 02:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602765; cv=none; b=Y9hEMp5CD6gm96ozjk+7FMKH0xKqvjyHXDMjeKOzgamkD7MQixlRev+EmTfPL/HXybpZuw9dbCrJduiIixHUt0A4IfENKJZZ11K5gFcKKppuS60iYuMlObrWQGojmSD8N9MGIQWnyLR2FDmiLL/aIq1iAwpneGyS5CbTYLOGVUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602765; c=relaxed/simple;
	bh=y1dCXDx4Gx5TTmgag6d1efih0Lf16D1ueJXmhwfABYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQIsRMrEbJWngaELIPxLDwNTIbwXAWdl4RGjVWWuHHIdRIkf8ToV8Qd2iTrnm6BQ6ZhLOL2pBWZuPrGQ0dnxitjPN70lKHvoXpn7V0A47bU778pUouF/pC01D/rREPVnqaiQEGBRB2AhOoUgIQio6HWyxohkFIYRBdfFWpJVDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WkBxH200Dz1S7rN;
	Wed, 14 Aug 2024 10:27:47 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B5421402CF;
	Wed, 14 Aug 2024 10:32:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 10:32:38 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <brauner@kernel.org>,
	<lczerner@redhat.com>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH 2/9] f2fs: move the option parser into handle_mount_opt
Date: Wed, 14 Aug 2024 10:39:05 +0800
Message-ID: <20240814023912.3959299-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814023912.3959299-1-lihongbo22@huawei.com>
References: <20240814023912.3959299-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

In handle_mount_opt, we use fs_parameter to pass each options.
However we're still using the old API to get the options string.

There are some change about parsering options:
  1. For `active_logs`, `inline_xattr_size` and `fault_injection`,
  we use s32 type according the internal structure to record the
  option's value.
  2. Introduce constant_table for `jqfmt` options.
  3. Obtain the checkpoint disable cap (or percent) with private logic.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/f2fs/super.c | 1191 ++++++++++++++++++++++++-----------------------
 1 file changed, 614 insertions(+), 577 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1bd923a73c1f..013b1078653f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -28,6 +28,7 @@
 #include <linux/part_stat.h>
 #include <linux/zstd.h>
 #include <linux/lz4.h>
+#include <linux/ctype.h>
 #include <linux/fs_parser.h>
 
 #include "f2fs.h"
@@ -460,7 +461,7 @@ static void init_once(void *foo)
 static const char * const quotatypes[] = INITQFNAMES;
 #define QTYPE2NAME(t) (quotatypes[t])
 static int f2fs_set_qf_name(struct super_block *sb, int qtype,
-							substring_t *args)
+			    struct fs_parameter *param)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	char *qname;
@@ -475,7 +476,7 @@ static int f2fs_set_qf_name(struct super_block *sb, int qtype,
 		return 0;
 	}
 
-	qname = match_strdup(args);
+	qname = kmemdup_nul(param->string, param->size, GFP_KERNEL);
 	if (!qname) {
 		f2fs_err(sbi, "Not enough memory for storing quotafile name");
 		return -ENOMEM;
@@ -560,15 +561,10 @@ static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
 #endif
 
 static int f2fs_set_test_dummy_encryption(struct super_block *sb,
-					  const char *opt,
-					  const substring_t *arg,
+					  const struct fs_parameter *param,
 					  bool is_remount)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-	struct fs_parameter param = {
-		.type = fs_value_is_string,
-		.string = arg->from ? arg->from : "",
-	};
 	struct fscrypt_dummy_policy *policy =
 		&F2FS_OPTION(sbi).dummy_enc_policy;
 	int err;
@@ -594,17 +590,17 @@ static int f2fs_set_test_dummy_encryption(struct super_block *sb,
 		return -EINVAL;
 	}
 
-	err = fscrypt_parse_test_dummy_encryption(&param, policy);
+	err = fscrypt_parse_test_dummy_encryption(param, policy);
 	if (err) {
 		if (err == -EEXIST)
 			f2fs_warn(sbi,
 				  "Can't change test_dummy_encryption on remount");
 		else if (err == -EINVAL)
 			f2fs_warn(sbi, "Value of option \"%s\" is unrecognized",
-				  opt);
+				  param->key);
 		else
 			f2fs_warn(sbi, "Error processing option \"%s\" [%d]",
-				  opt, err);
+				  param->key, err);
 		return -EINVAL;
 	}
 	f2fs_warn(sbi, "Test dummy encryption mode enabled");
@@ -747,639 +743,680 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 #endif
 #endif
 
-static int parse_options(struct super_block *sb, char *options, bool is_remount)
+static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 {
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-	substring_t args[MAX_OPT_ARGS];
+	struct f2fs_sb_info *sbi = fc->s_fs_info;
+	struct super_block *sb = sbi->sb;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	unsigned char (*ext)[F2FS_EXTENSION_LEN];
 	unsigned char (*noext)[F2FS_EXTENSION_LEN];
 	int ext_cnt, noext_cnt;
 #endif
-	char *p, *name;
-	int arg = 0;
+	struct fs_parse_result result;
+	int is_remount;
+	char *name;
 	kuid_t uid;
 	kgid_t gid;
-	int ret;
-
-	if (!options)
-		goto default_check;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-
-		if (!*p)
-			continue;
-		/*
-		 * Initialize args struct so we know whether arg was
-		 * found; some options take optional arguments.
-		 */
-		args[0].to = args[0].from = NULL;
-		token = match_token(p, f2fs_tokens, args);
-
-		switch (token) {
-		case Opt_gc_background:
-			name = match_strdup(&args[0]);
-
-			if (!name)
-				return -ENOMEM;
-			if (!strcmp(name, "on")) {
-				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
-			} else if (!strcmp(name, "off")) {
-				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_OFF;
-			} else if (!strcmp(name, "sync")) {
-				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_SYNC;
-			} else {
-				kfree(name);
-				return -EINVAL;
-			}
+	int token, ret;
+
+	token = fs_parse(fc, f2fs_param_specs, param, &result);
+	if (token < 0)
+		return token;
+
+	is_remount = fc->purpose == FS_CONTEXT_FOR_RECONFIGURE;
+
+	switch (token) {
+	case Opt_gc_background:
+		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
+
+		if (!name)
+			return -ENOMEM;
+		if (!strcmp(name, "on")) {
+			F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
+		} else if (!strcmp(name, "off")) {
+			F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_OFF;
+		} else if (!strcmp(name, "sync")) {
+			F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_SYNC;
+		} else {
 			kfree(name);
-			break;
-		case Opt_disable_roll_forward:
-			set_opt(sbi, DISABLE_ROLL_FORWARD);
-			break;
-		case Opt_norecovery:
-			/* this option mounts f2fs with ro */
-			set_opt(sbi, NORECOVERY);
-			if (!f2fs_readonly(sb))
-				return -EINVAL;
-			break;
-		case Opt_discard:
-			if (!f2fs_hw_support_discard(sbi)) {
-				f2fs_warn(sbi, "device does not support discard");
-				break;
-			}
-			set_opt(sbi, DISCARD);
-			break;
-		case Opt_nodiscard:
-			if (f2fs_hw_should_discard(sbi)) {
-				f2fs_warn(sbi, "discard is required for zoned block devices");
-				return -EINVAL;
-			}
-			clear_opt(sbi, DISCARD);
-			break;
-		case Opt_noheap:
-		case Opt_heap:
-			f2fs_warn(sbi, "heap/no_heap options were deprecated");
-			break;
+			return -EINVAL;
+		}
+		kfree(name);
+		return 0;
+	case Opt_disable_roll_forward:
+		set_opt(sbi, DISABLE_ROLL_FORWARD);
+		return 0;
+	case Opt_norecovery:
+		/* this option mounts f2fs with ro */
+		set_opt(sbi, NORECOVERY);
+		if (!f2fs_readonly(sb))
+			return -EINVAL;
+		return 0;
+	case Opt_discard:
+		if (!f2fs_hw_support_discard(sbi)) {
+			f2fs_warn(sbi, "device does not support discard");
+			return 0;
+		}
+		set_opt(sbi, DISCARD);
+		return 0;
+	case Opt_nodiscard:
+		if (f2fs_hw_should_discard(sbi)) {
+			f2fs_warn(sbi, "discard is required for zoned block devices");
+			return -EINVAL;
+		}
+		clear_opt(sbi, DISCARD);
+		return 0;
+	case Opt_noheap:
+	case Opt_heap:
+		f2fs_warn(sbi, "heap/no_heap options were deprecated");
+		return 0;
 #ifdef CONFIG_F2FS_FS_XATTR
-		case Opt_user_xattr:
-			set_opt(sbi, XATTR_USER);
-			break;
-		case Opt_nouser_xattr:
-			clear_opt(sbi, XATTR_USER);
-			break;
-		case Opt_inline_xattr:
-			set_opt(sbi, INLINE_XATTR);
-			break;
-		case Opt_noinline_xattr:
-			clear_opt(sbi, INLINE_XATTR);
-			break;
-		case Opt_inline_xattr_size:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
-			set_opt(sbi, INLINE_XATTR_SIZE);
-			F2FS_OPTION(sbi).inline_xattr_size = arg;
-			break;
+	case Opt_user_xattr:
+		set_opt(sbi, XATTR_USER);
+		return 0;
+	case Opt_nouser_xattr:
+		clear_opt(sbi, XATTR_USER);
+		return 0;
+	case Opt_inline_xattr:
+		set_opt(sbi, INLINE_XATTR);
+		return 0;
+	case Opt_noinline_xattr:
+		clear_opt(sbi, INLINE_XATTR);
+		return 0;
+	case Opt_inline_xattr_size:
+		set_opt(sbi, INLINE_XATTR_SIZE);
+		F2FS_OPTION(sbi).inline_xattr_size = result.int_32;
+		return 0;
 #else
-		case Opt_user_xattr:
-			f2fs_info(sbi, "user_xattr options not supported");
-			break;
-		case Opt_nouser_xattr:
-			f2fs_info(sbi, "nouser_xattr options not supported");
-			break;
-		case Opt_inline_xattr:
-			f2fs_info(sbi, "inline_xattr options not supported");
-			break;
-		case Opt_noinline_xattr:
-			f2fs_info(sbi, "noinline_xattr options not supported");
-			break;
+	case Opt_user_xattr:
+		f2fs_info(sbi, "user_xattr options not supported");
+		return 0;
+	case Opt_nouser_xattr:
+		f2fs_info(sbi, "nouser_xattr options not supported");
+		return 0;
+	case Opt_inline_xattr:
+		f2fs_info(sbi, "inline_xattr options not supported");
+		return 0;
+	case Opt_noinline_xattr:
+		f2fs_info(sbi, "noinline_xattr options not supported");
+		return 0;
 #endif
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
-		case Opt_acl:
-			set_opt(sbi, POSIX_ACL);
-			break;
-		case Opt_noacl:
-			clear_opt(sbi, POSIX_ACL);
-			break;
+	case Opt_acl:
+		set_opt(sbi, POSIX_ACL);
+		return 0;
+	case Opt_noacl:
+		clear_opt(sbi, POSIX_ACL);
+		return 0;
 #else
-		case Opt_acl:
-			f2fs_info(sbi, "acl options not supported");
-			break;
-		case Opt_noacl:
-			f2fs_info(sbi, "noacl options not supported");
-			break;
+	case Opt_acl:
+		f2fs_info(sbi, "acl options not supported");
+		return 0;
+	case Opt_noacl:
+		f2fs_info(sbi, "noacl options not supported");
+		return 0;
 #endif
-		case Opt_active_logs:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
-			if (arg != 2 && arg != 4 &&
-				arg != NR_CURSEG_PERSIST_TYPE)
-				return -EINVAL;
-			F2FS_OPTION(sbi).active_logs = arg;
-			break;
-		case Opt_disable_ext_identify:
-			set_opt(sbi, DISABLE_EXT_IDENTIFY);
-			break;
-		case Opt_inline_data:
-			set_opt(sbi, INLINE_DATA);
-			break;
-		case Opt_inline_dentry:
-			set_opt(sbi, INLINE_DENTRY);
-			break;
-		case Opt_noinline_dentry:
-			clear_opt(sbi, INLINE_DENTRY);
-			break;
-		case Opt_flush_merge:
-			set_opt(sbi, FLUSH_MERGE);
-			break;
-		case Opt_noflush_merge:
-			clear_opt(sbi, FLUSH_MERGE);
-			break;
-		case Opt_nobarrier:
-			set_opt(sbi, NOBARRIER);
-			break;
-		case Opt_barrier:
-			clear_opt(sbi, NOBARRIER);
-			break;
-		case Opt_fastboot:
-			set_opt(sbi, FASTBOOT);
-			break;
-		case Opt_extent_cache:
-			set_opt(sbi, READ_EXTENT_CACHE);
-			break;
-		case Opt_noextent_cache:
-			clear_opt(sbi, READ_EXTENT_CACHE);
-			break;
-		case Opt_noinline_data:
-			clear_opt(sbi, INLINE_DATA);
-			break;
-		case Opt_data_flush:
-			set_opt(sbi, DATA_FLUSH);
-			break;
-		case Opt_reserve_root:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
-			if (test_opt(sbi, RESERVE_ROOT)) {
-				f2fs_info(sbi, "Preserve previous reserve_root=%u",
-					  F2FS_OPTION(sbi).root_reserved_blocks);
-			} else {
-				F2FS_OPTION(sbi).root_reserved_blocks = arg;
-				set_opt(sbi, RESERVE_ROOT);
-			}
-			break;
-		case Opt_resuid:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
-			uid = make_kuid(current_user_ns(), arg);
-			if (!uid_valid(uid)) {
-				f2fs_err(sbi, "Invalid uid value %d", arg);
-				return -EINVAL;
-			}
-			F2FS_OPTION(sbi).s_resuid = uid;
-			break;
-		case Opt_resgid:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
-			gid = make_kgid(current_user_ns(), arg);
-			if (!gid_valid(gid)) {
-				f2fs_err(sbi, "Invalid gid value %d", arg);
-				return -EINVAL;
-			}
-			F2FS_OPTION(sbi).s_resgid = gid;
-			break;
-		case Opt_mode:
-			name = match_strdup(&args[0]);
-
-			if (!name)
-				return -ENOMEM;
-			if (!strcmp(name, "adaptive")) {
-				F2FS_OPTION(sbi).fs_mode = FS_MODE_ADAPTIVE;
-			} else if (!strcmp(name, "lfs")) {
-				F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
-			} else if (!strcmp(name, "fragment:segment")) {
-				F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_SEG;
-			} else if (!strcmp(name, "fragment:block")) {
-				F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_BLK;
-			} else {
-				kfree(name);
-				return -EINVAL;
-			}
+	case Opt_active_logs:
+		if (result.int_32 != 2 && result.int_32 != 4 &&
+			result.int_32 != NR_CURSEG_PERSIST_TYPE)
+			return -EINVAL;
+		F2FS_OPTION(sbi).active_logs = result.int_32;
+		return 0;
+	case Opt_disable_ext_identify:
+		set_opt(sbi, DISABLE_EXT_IDENTIFY);
+		return 0;
+	case Opt_inline_data:
+		set_opt(sbi, INLINE_DATA);
+		return 0;
+	case Opt_inline_dentry:
+		set_opt(sbi, INLINE_DENTRY);
+		return 0;
+	case Opt_noinline_dentry:
+		clear_opt(sbi, INLINE_DENTRY);
+		return 0;
+	case Opt_flush_merge:
+		set_opt(sbi, FLUSH_MERGE);
+		return 0;
+	case Opt_noflush_merge:
+		clear_opt(sbi, FLUSH_MERGE);
+		return 0;
+	case Opt_nobarrier:
+		set_opt(sbi, NOBARRIER);
+		return 0;
+	case Opt_barrier:
+		clear_opt(sbi, NOBARRIER);
+		return 0;
+	case Opt_fastboot:
+		set_opt(sbi, FASTBOOT);
+		return 0;
+	case Opt_extent_cache:
+		set_opt(sbi, READ_EXTENT_CACHE);
+		return 0;
+	case Opt_noextent_cache:
+		clear_opt(sbi, READ_EXTENT_CACHE);
+		return 0;
+	case Opt_noinline_data:
+		clear_opt(sbi, INLINE_DATA);
+		return 0;
+	case Opt_data_flush:
+		set_opt(sbi, DATA_FLUSH);
+		return 0;
+	case Opt_reserve_root:
+		if (test_opt(sbi, RESERVE_ROOT)) {
+			f2fs_info(sbi, "Preserve previous reserve_root=%u",
+				  F2FS_OPTION(sbi).root_reserved_blocks);
+		} else {
+			F2FS_OPTION(sbi).root_reserved_blocks = result.uint_32;
+			set_opt(sbi, RESERVE_ROOT);
+		}
+		return 0;
+	case Opt_resuid:
+		uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(uid)) {
+			f2fs_err(sbi, "Invalid uid value %u", result.uint_32);
+			return -EINVAL;
+		}
+		F2FS_OPTION(sbi).s_resuid = uid;
+		return 0;
+	case Opt_resgid:
+		gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(gid)) {
+			f2fs_err(sbi, "Invalid gid value %u", result.uint_32);
+			return -EINVAL;
+		}
+		F2FS_OPTION(sbi).s_resgid = gid;
+		return 0;
+	case Opt_mode:
+		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
+
+		if (!name)
+			return -ENOMEM;
+		if (!strcmp(name, "adaptive")) {
+			F2FS_OPTION(sbi).fs_mode = FS_MODE_ADAPTIVE;
+		} else if (!strcmp(name, "lfs")) {
+			F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
+		} else if (!strcmp(name, "fragment:segment")) {
+			F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_SEG;
+		} else if (!strcmp(name, "fragment:block")) {
+			F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_BLK;
+		} else {
 			kfree(name);
-			break;
+			return -EINVAL;
+		}
+		kfree(name);
+		return 0;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-		case Opt_fault_injection:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
-			if (f2fs_build_fault_attr(sbi, arg,
-					F2FS_ALL_FAULT_TYPE))
-				return -EINVAL;
-			set_opt(sbi, FAULT_INJECTION);
-			break;
+	case Opt_fault_injection:
+		if (f2fs_build_fault_attr(sbi, result.int_32,
+				F2FS_ALL_FAULT_TYPE))
+			return -EINVAL;
+		set_opt(sbi, FAULT_INJECTION);
+		return 0;
 
-		case Opt_fault_type:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
-			if (f2fs_build_fault_attr(sbi, 0, arg))
-				return -EINVAL;
-			set_opt(sbi, FAULT_INJECTION);
-			break;
+	case Opt_fault_type:
+		if (f2fs_build_fault_attr(sbi, 0, result.uint_32))
+			return -EINVAL;
+		set_opt(sbi, FAULT_INJECTION);
+		return 0;
 #else
-		case Opt_fault_injection:
-			f2fs_info(sbi, "fault_injection options not supported");
-			break;
+	case Opt_fault_injection:
+		f2fs_info(sbi, "fault_injection options not supported");
+		return 0;
 
-		case Opt_fault_type:
-			f2fs_info(sbi, "fault_type options not supported");
-			break;
+	case Opt_fault_type:
+		f2fs_info(sbi, "fault_type options not supported");
+		return 0;
 #endif
 #ifdef CONFIG_QUOTA
-		case Opt_quota:
-		case Opt_usrquota:
-			set_opt(sbi, USRQUOTA);
-			break;
-		case Opt_grpquota:
-			set_opt(sbi, GRPQUOTA);
-			break;
-		case Opt_prjquota:
-			set_opt(sbi, PRJQUOTA);
-			break;
-		case Opt_usrjquota:
-			ret = f2fs_set_qf_name(sb, USRQUOTA, &args[0]);
-			if (ret)
-				return ret;
-			break;
-		case Opt_grpjquota:
-			ret = f2fs_set_qf_name(sb, GRPQUOTA, &args[0]);
-			if (ret)
-				return ret;
-			break;
-		case Opt_prjjquota:
-			ret = f2fs_set_qf_name(sb, PRJQUOTA, &args[0]);
-			if (ret)
-				return ret;
-			break;
-		case Opt_offusrjquota:
+	case Opt_quota:
+	case Opt_usrquota:
+		set_opt(sbi, USRQUOTA);
+		return 0;
+	case Opt_grpquota:
+		set_opt(sbi, GRPQUOTA);
+		return 0;
+	case Opt_prjquota:
+		set_opt(sbi, PRJQUOTA);
+		return 0;
+	case Opt_usrjquota:
+		if (!*param->string)
 			ret = f2fs_clear_qf_name(sb, USRQUOTA);
-			if (ret)
-				return ret;
-			break;
-		case Opt_offgrpjquota:
+		else
+			ret = f2fs_set_qf_name(sb, USRQUOTA, param);
+		if (ret)
+			return ret;
+		return 0;
+	case Opt_grpjquota:
+		if (!*param->string)
 			ret = f2fs_clear_qf_name(sb, GRPQUOTA);
-			if (ret)
-				return ret;
-			break;
-		case Opt_offprjjquota:
+		else
+			ret = f2fs_set_qf_name(sb, GRPQUOTA, param);
+		if (ret)
+			return ret;
+		return 0;
+	case Opt_prjjquota:
+		if (!*param->string)
 			ret = f2fs_clear_qf_name(sb, PRJQUOTA);
-			if (ret)
-				return ret;
-			break;
-		case Opt_jqfmt_vfsold:
-			F2FS_OPTION(sbi).s_jquota_fmt = QFMT_VFS_OLD;
-			break;
-		case Opt_jqfmt_vfsv0:
-			F2FS_OPTION(sbi).s_jquota_fmt = QFMT_VFS_V0;
-			break;
-		case Opt_jqfmt_vfsv1:
-			F2FS_OPTION(sbi).s_jquota_fmt = QFMT_VFS_V1;
-			break;
-		case Opt_noquota:
-			clear_opt(sbi, QUOTA);
-			clear_opt(sbi, USRQUOTA);
-			clear_opt(sbi, GRPQUOTA);
-			clear_opt(sbi, PRJQUOTA);
-			break;
+		else
+			ret = f2fs_set_qf_name(sb, PRJQUOTA, param);
+		if (ret)
+			return ret;
+		return 0;
+	case Opt_jqfmt:
+		F2FS_OPTION(sbi).s_jquota_fmt = result.uint_32;
+		return 0;
+	case Opt_noquota:
+		clear_opt(sbi, QUOTA);
+		clear_opt(sbi, USRQUOTA);
+		clear_opt(sbi, GRPQUOTA);
+		clear_opt(sbi, PRJQUOTA);
+		return 0;
 #else
-		case Opt_quota:
-		case Opt_usrquota:
-		case Opt_grpquota:
-		case Opt_prjquota:
-		case Opt_usrjquota:
-		case Opt_grpjquota:
-		case Opt_prjjquota:
-		case Opt_offusrjquota:
-		case Opt_offgrpjquota:
-		case Opt_offprjjquota:
-		case Opt_jqfmt_vfsold:
-		case Opt_jqfmt_vfsv0:
-		case Opt_jqfmt_vfsv1:
-		case Opt_noquota:
-			f2fs_info(sbi, "quota operations not supported");
-			break;
+	case Opt_quota:
+	case Opt_usrquota:
+	case Opt_grpquota:
+	case Opt_prjquota:
+	case Opt_usrjquota:
+	case Opt_grpjquota:
+	case Opt_prjjquota:
+	case Opt_offusrjquota:
+	case Opt_offgrpjquota:
+	case Opt_offprjjquota:
+	case Opt_jqfmt_vfsold:
+	case Opt_jqfmt_vfsv0:
+	case Opt_jqfmt_vfsv1:
+	case Opt_noquota:
+		f2fs_info(sbi, "quota operations not supported");
+		return 0;
 #endif
-		case Opt_alloc:
-			name = match_strdup(&args[0]);
-			if (!name)
-				return -ENOMEM;
-
-			if (!strcmp(name, "default")) {
-				F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
-			} else if (!strcmp(name, "reuse")) {
-				F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
-			} else {
-				kfree(name);
-				return -EINVAL;
-			}
+	case Opt_alloc:
+		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
+
+		if (!strcmp(name, "default")) {
+			F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
+		} else if (!strcmp(name, "reuse")) {
+			F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
+		} else {
 			kfree(name);
-			break;
-		case Opt_fsync:
-			name = match_strdup(&args[0]);
-			if (!name)
-				return -ENOMEM;
-			if (!strcmp(name, "posix")) {
-				F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_POSIX;
-			} else if (!strcmp(name, "strict")) {
-				F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_STRICT;
-			} else if (!strcmp(name, "nobarrier")) {
-				F2FS_OPTION(sbi).fsync_mode =
-							FSYNC_MODE_NOBARRIER;
-			} else {
-				kfree(name);
-				return -EINVAL;
-			}
+			return -EINVAL;
+		}
+		kfree(name);
+		return 0;
+	case Opt_fsync:
+		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
+		if (!strcmp(name, "posix")) {
+			F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_POSIX;
+		} else if (!strcmp(name, "strict")) {
+			F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_STRICT;
+		} else if (!strcmp(name, "nobarrier")) {
+			F2FS_OPTION(sbi).fsync_mode =
+						FSYNC_MODE_NOBARRIER;
+		} else {
 			kfree(name);
-			break;
-		case Opt_test_dummy_encryption:
-			ret = f2fs_set_test_dummy_encryption(sb, p, &args[0],
-							     is_remount);
-			if (ret)
-				return ret;
-			break;
-		case Opt_inlinecrypt:
+			return -EINVAL;
+		}
+		kfree(name);
+		return 0;
+	case Opt_test_dummy_encryption:
+		ret = f2fs_set_test_dummy_encryption(sb, param, is_remount);
+		if (ret)
+			return ret;
+		return 0;
+	case Opt_inlinecrypt:
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
-			sb->s_flags |= SB_INLINECRYPT;
+		sb->s_flags |= SB_INLINECRYPT;
 #else
-			f2fs_info(sbi, "inline encryption not supported");
+		f2fs_info(sbi, "inline encryption not supported");
 #endif
-			break;
-		case Opt_checkpoint_disable_cap_perc:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
-			if (arg < 0 || arg > 100)
-				return -EINVAL;
-			F2FS_OPTION(sbi).unusable_cap_perc = arg;
-			set_opt(sbi, DISABLE_CHECKPOINT);
-			break;
-		case Opt_checkpoint_disable_cap:
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
-			F2FS_OPTION(sbi).unusable_cap = arg;
+		return 0;
+	case Opt_checkpoint:
+	{
+		const char *prefix = "disable:";
+		size_t len = strlen(prefix);
+		const char *cp = param->string + len;
+		char *endp = (char *)cp;
+		unsigned long cap = 0;
+
+		if (!strcmp(param->string, "enable")) {
+			clear_opt(sbi, DISABLE_CHECKPOINT);
+			return 0;
+		}
+
+		if (!strcmp(param->string, "disable")) {
 			set_opt(sbi, DISABLE_CHECKPOINT);
-			break;
-		case Opt_checkpoint_disable:
+			return 0;
+		}
+
+		if (strlen(param->string) <= len)
+			return -EINVAL;
+		if (strncmp(prefix, param->string, len))
+			return -EINVAL;
+
+		while (isdigit(*endp)) {
+			cap = cap * 10 + (*endp - '0');
+			endp++;
+		}
+		if (!strcmp(cp, endp))
+			return -EINVAL;
+		if (strlen(endp) == 0) {
+			F2FS_OPTION(sbi).unusable_cap = cap;
 			set_opt(sbi, DISABLE_CHECKPOINT);
-			break;
-		case Opt_checkpoint_enable:
-			clear_opt(sbi, DISABLE_CHECKPOINT);
-			break;
-		case Opt_checkpoint_merge:
-			set_opt(sbi, MERGE_CHECKPOINT);
-			break;
-		case Opt_nocheckpoint_merge:
-			clear_opt(sbi, MERGE_CHECKPOINT);
-			break;
+			return 0;
+		}
+		if (strcmp(endp, "%"))
+			return -EINVAL;
+		if (cap > 100)
+			return -EINVAL;
+		F2FS_OPTION(sbi).unusable_cap_perc = cap;
+		set_opt(sbi, DISABLE_CHECKPOINT);
+		return 0;
+	}
+	case Opt_checkpoint_merge:
+		set_opt(sbi, MERGE_CHECKPOINT);
+		return 0;
+	case Opt_nocheckpoint_merge:
+		clear_opt(sbi, MERGE_CHECKPOINT);
+		return 0;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-		case Opt_compress_algorithm:
-			if (!f2fs_sb_has_compression(sbi)) {
-				f2fs_info(sbi, "Image doesn't support compression");
-				break;
-			}
-			name = match_strdup(&args[0]);
-			if (!name)
-				return -ENOMEM;
-			if (!strcmp(name, "lzo")) {
+	case Opt_compress_algorithm:
+		if (!f2fs_sb_has_compression(sbi)) {
+			f2fs_info(sbi, "Image doesn't support compression");
+			return 0;
+		}
+		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
+		if (!strcmp(name, "lzo")) {
 #ifdef CONFIG_F2FS_FS_LZO
-				F2FS_OPTION(sbi).compress_level = 0;
-				F2FS_OPTION(sbi).compress_algorithm =
-								COMPRESS_LZO;
+			F2FS_OPTION(sbi).compress_level = 0;
+			F2FS_OPTION(sbi).compress_algorithm =
+							COMPRESS_LZO;
 #else
-				f2fs_info(sbi, "kernel doesn't support lzo compression");
+			f2fs_info(sbi, "kernel doesn't support lzo compression");
 #endif
-			} else if (!strncmp(name, "lz4", 3)) {
+		} else if (!strncmp(name, "lz4", 3)) {
 #ifdef CONFIG_F2FS_FS_LZ4
-				ret = f2fs_set_lz4hc_level(sbi, name);
-				if (ret) {
-					kfree(name);
-					return -EINVAL;
-				}
-				F2FS_OPTION(sbi).compress_algorithm =
-								COMPRESS_LZ4;
+			ret = f2fs_set_lz4hc_level(sbi, name);
+			if (ret) {
+				kfree(name);
+				return -EINVAL;
+			}
+			F2FS_OPTION(sbi).compress_algorithm =
+							COMPRESS_LZ4;
 #else
-				f2fs_info(sbi, "kernel doesn't support lz4 compression");
+			f2fs_info(sbi, "kernel doesn't support lz4 compression");
 #endif
-			} else if (!strncmp(name, "zstd", 4)) {
+		} else if (!strncmp(name, "zstd", 4)) {
 #ifdef CONFIG_F2FS_FS_ZSTD
-				ret = f2fs_set_zstd_level(sbi, name);
-				if (ret) {
-					kfree(name);
-					return -EINVAL;
-				}
-				F2FS_OPTION(sbi).compress_algorithm =
-								COMPRESS_ZSTD;
+			ret = f2fs_set_zstd_level(sbi, name);
+			if (ret) {
+				kfree(name);
+				return -EINVAL;
+			}
+			F2FS_OPTION(sbi).compress_algorithm =
+							COMPRESS_ZSTD;
 #else
-				f2fs_info(sbi, "kernel doesn't support zstd compression");
+			f2fs_info(sbi, "kernel doesn't support zstd compression");
 #endif
-			} else if (!strcmp(name, "lzo-rle")) {
+		} else if (!strcmp(name, "lzo-rle")) {
 #ifdef CONFIG_F2FS_FS_LZORLE
-				F2FS_OPTION(sbi).compress_level = 0;
-				F2FS_OPTION(sbi).compress_algorithm =
-								COMPRESS_LZORLE;
+			F2FS_OPTION(sbi).compress_level = 0;
+			F2FS_OPTION(sbi).compress_algorithm =
+							COMPRESS_LZORLE;
 #else
-				f2fs_info(sbi, "kernel doesn't support lzorle compression");
+			f2fs_info(sbi, "kernel doesn't support lzorle compression");
 #endif
-			} else {
-				kfree(name);
-				return -EINVAL;
-			}
+		} else {
 			kfree(name);
+			return -EINVAL;
+		}
+		kfree(name);
+		return 0;
+	case Opt_compress_log_size:
+		if (!f2fs_sb_has_compression(sbi)) {
+			f2fs_info(sbi, "Image doesn't support compression");
+			return 0;
+		}
+		if (result.int_32 < MIN_COMPRESS_LOG_SIZE ||
+			result.int_32 > MAX_COMPRESS_LOG_SIZE) {
+			f2fs_err(sbi,
+				"Compress cluster log size is out of range");
+			return -EINVAL;
+		}
+		F2FS_OPTION(sbi).compress_log_size = result.int_32;
+		return 0;
+	case Opt_compress_extension:
+		if (!f2fs_sb_has_compression(sbi)) {
+			f2fs_info(sbi, "Image doesn't support compression");
 			break;
-		case Opt_compress_log_size:
-			if (!f2fs_sb_has_compression(sbi)) {
-				f2fs_info(sbi, "Image doesn't support compression");
-				break;
-			}
-			if (args->from && match_int(args, &arg))
-				return -EINVAL;
-			if (arg < MIN_COMPRESS_LOG_SIZE ||
-				arg > MAX_COMPRESS_LOG_SIZE) {
-				f2fs_err(sbi,
-					"Compress cluster log size is out of range");
-				return -EINVAL;
-			}
-			F2FS_OPTION(sbi).compress_log_size = arg;
-			break;
-		case Opt_compress_extension:
-			if (!f2fs_sb_has_compression(sbi)) {
-				f2fs_info(sbi, "Image doesn't support compression");
-				break;
-			}
-			name = match_strdup(&args[0]);
-			if (!name)
-				return -ENOMEM;
+		}
+		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
 
-			ext = F2FS_OPTION(sbi).extensions;
-			ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
+		ext = F2FS_OPTION(sbi).extensions;
+		ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
 
-			if (strlen(name) >= F2FS_EXTENSION_LEN ||
-				ext_cnt >= COMPRESS_EXT_NUM) {
-				f2fs_err(sbi,
-					"invalid extension length/number");
-				kfree(name);
-				return -EINVAL;
-			}
+		if (strlen(name) >= F2FS_EXTENSION_LEN ||
+			ext_cnt >= COMPRESS_EXT_NUM) {
+			f2fs_err(sbi,
+				"invalid extension length/number");
+			kfree(name);
+			return -EINVAL;
+		}
 
-			if (is_compress_extension_exist(sbi, name, true)) {
-				kfree(name);
-				break;
-			}
+		if (is_compress_extension_exist(sbi, name, true)) {
+			kfree(name);
+			return 0;
+		}
 
-			strcpy(ext[ext_cnt], name);
-			F2FS_OPTION(sbi).compress_ext_cnt++;
+		ret = strscpy(ext[ext_cnt], name, F2FS_EXTENSION_LEN);
+		if (ret < 0) {
 			kfree(name);
-			break;
-		case Opt_nocompress_extension:
-			if (!f2fs_sb_has_compression(sbi)) {
-				f2fs_info(sbi, "Image doesn't support compression");
-				break;
-			}
-			name = match_strdup(&args[0]);
-			if (!name)
-				return -ENOMEM;
+			return ret;
+		}
+		F2FS_OPTION(sbi).compress_ext_cnt++;
+		kfree(name);
+		return 0;
+	case Opt_nocompress_extension:
+		if (!f2fs_sb_has_compression(sbi)) {
+			f2fs_info(sbi, "Image doesn't support compression");
+			return 0;
+		}
+		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
 
-			noext = F2FS_OPTION(sbi).noextensions;
-			noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
+		noext = F2FS_OPTION(sbi).noextensions;
+		noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
 
-			if (strlen(name) >= F2FS_EXTENSION_LEN ||
-				noext_cnt >= COMPRESS_EXT_NUM) {
-				f2fs_err(sbi,
-					"invalid extension length/number");
-				kfree(name);
-				return -EINVAL;
-			}
+		if (strlen(name) >= F2FS_EXTENSION_LEN ||
+			noext_cnt >= COMPRESS_EXT_NUM) {
+			f2fs_err(sbi,
+				"invalid extension length/number");
+			kfree(name);
+			return -EINVAL;
+		}
 
-			if (is_compress_extension_exist(sbi, name, false)) {
-				kfree(name);
-				break;
-			}
+		if (is_compress_extension_exist(sbi, name, false)) {
+			kfree(name);
+			return 0;
+		}
 
-			strcpy(noext[noext_cnt], name);
-			F2FS_OPTION(sbi).nocompress_ext_cnt++;
+		ret = strscpy(noext[noext_cnt], name, F2FS_EXTENSION_LEN);
+		if (ret < 0) {
 			kfree(name);
-			break;
-		case Opt_compress_chksum:
-			if (!f2fs_sb_has_compression(sbi)) {
-				f2fs_info(sbi, "Image doesn't support compression");
-				break;
-			}
-			F2FS_OPTION(sbi).compress_chksum = true;
-			break;
-		case Opt_compress_mode:
-			if (!f2fs_sb_has_compression(sbi)) {
-				f2fs_info(sbi, "Image doesn't support compression");
-				break;
-			}
-			name = match_strdup(&args[0]);
-			if (!name)
-				return -ENOMEM;
-			if (!strcmp(name, "fs")) {
-				F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
-			} else if (!strcmp(name, "user")) {
-				F2FS_OPTION(sbi).compress_mode = COMPR_MODE_USER;
-			} else {
-				kfree(name);
-				return -EINVAL;
-			}
+			return ret;
+		}
+		F2FS_OPTION(sbi).nocompress_ext_cnt++;
+		kfree(name);
+		return 0;
+	case Opt_compress_chksum:
+		if (!f2fs_sb_has_compression(sbi)) {
+			f2fs_info(sbi, "Image doesn't support compression");
+			return 0;
+		}
+		F2FS_OPTION(sbi).compress_chksum = true;
+		return 0;
+	case Opt_compress_mode:
+		if (!f2fs_sb_has_compression(sbi)) {
+			f2fs_info(sbi, "Image doesn't support compression");
+			return 0;
+		}
+		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
+		if (!strcmp(name, "fs")) {
+			F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
+		} else if (!strcmp(name, "user")) {
+			F2FS_OPTION(sbi).compress_mode = COMPR_MODE_USER;
+		} else {
 			kfree(name);
-			break;
-		case Opt_compress_cache:
-			if (!f2fs_sb_has_compression(sbi)) {
-				f2fs_info(sbi, "Image doesn't support compression");
-				break;
-			}
-			set_opt(sbi, COMPRESS_CACHE);
-			break;
+			return -EINVAL;
+		}
+		kfree(name);
+		return 0;
+	case Opt_compress_cache:
+		if (!f2fs_sb_has_compression(sbi)) {
+			f2fs_info(sbi, "Image doesn't support compression");
+			return 0;
+		}
+		set_opt(sbi, COMPRESS_CACHE);
+		return 0;
 #else
-		case Opt_compress_algorithm:
-		case Opt_compress_log_size:
-		case Opt_compress_extension:
-		case Opt_nocompress_extension:
-		case Opt_compress_chksum:
-		case Opt_compress_mode:
-		case Opt_compress_cache:
-			f2fs_info(sbi, "compression options not supported");
-			break;
+	case Opt_compress_algorithm:
+	case Opt_compress_log_size:
+	case Opt_compress_extension:
+	case Opt_nocompress_extension:
+	case Opt_compress_chksum:
+	case Opt_compress_mode:
+	case Opt_compress_cache:
+		f2fs_info(sbi, "compression options not supported");
+		return 0;
 #endif
-		case Opt_atgc:
-			set_opt(sbi, ATGC);
-			break;
-		case Opt_gc_merge:
-			set_opt(sbi, GC_MERGE);
-			break;
-		case Opt_nogc_merge:
-			clear_opt(sbi, GC_MERGE);
-			break;
-		case Opt_discard_unit:
-			name = match_strdup(&args[0]);
-			if (!name)
-				return -ENOMEM;
-			if (!strcmp(name, "block")) {
-				F2FS_OPTION(sbi).discard_unit =
-						DISCARD_UNIT_BLOCK;
-			} else if (!strcmp(name, "segment")) {
-				F2FS_OPTION(sbi).discard_unit =
-						DISCARD_UNIT_SEGMENT;
-			} else if (!strcmp(name, "section")) {
-				F2FS_OPTION(sbi).discard_unit =
-						DISCARD_UNIT_SECTION;
-			} else {
-				kfree(name);
-				return -EINVAL;
-			}
+	case Opt_atgc:
+		set_opt(sbi, ATGC);
+		return 0;
+	case Opt_gc_merge:
+		set_opt(sbi, GC_MERGE);
+		return 0;
+	case Opt_nogc_merge:
+		clear_opt(sbi, GC_MERGE);
+		return 0;
+	case Opt_discard_unit:
+		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
+		if (!strcmp(name, "block")) {
+			F2FS_OPTION(sbi).discard_unit =
+					DISCARD_UNIT_BLOCK;
+		} else if (!strcmp(name, "segment")) {
+			F2FS_OPTION(sbi).discard_unit =
+					DISCARD_UNIT_SEGMENT;
+		} else if (!strcmp(name, "section")) {
+			F2FS_OPTION(sbi).discard_unit =
+					DISCARD_UNIT_SECTION;
+		} else {
 			kfree(name);
-			break;
-		case Opt_memory_mode:
-			name = match_strdup(&args[0]);
-			if (!name)
-				return -ENOMEM;
-			if (!strcmp(name, "normal")) {
-				F2FS_OPTION(sbi).memory_mode =
-						MEMORY_MODE_NORMAL;
-			} else if (!strcmp(name, "low")) {
-				F2FS_OPTION(sbi).memory_mode =
-						MEMORY_MODE_LOW;
-			} else {
-				kfree(name);
-				return -EINVAL;
-			}
+			return -EINVAL;
+		}
+		kfree(name);
+		return 0;
+	case Opt_memory_mode:
+		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
+		if (!strcmp(name, "normal")) {
+			F2FS_OPTION(sbi).memory_mode =
+					MEMORY_MODE_NORMAL;
+		} else if (!strcmp(name, "low")) {
+			F2FS_OPTION(sbi).memory_mode =
+					MEMORY_MODE_LOW;
+		} else {
 			kfree(name);
-			break;
-		case Opt_age_extent_cache:
-			set_opt(sbi, AGE_EXTENT_CACHE);
-			break;
-		case Opt_errors:
-			name = match_strdup(&args[0]);
-			if (!name)
-				return -ENOMEM;
-			if (!strcmp(name, "remount-ro")) {
-				F2FS_OPTION(sbi).errors =
-						MOUNT_ERRORS_READONLY;
-			} else if (!strcmp(name, "continue")) {
-				F2FS_OPTION(sbi).errors =
-						MOUNT_ERRORS_CONTINUE;
-			} else if (!strcmp(name, "panic")) {
-				F2FS_OPTION(sbi).errors =
-						MOUNT_ERRORS_PANIC;
-			} else {
-				kfree(name);
-				return -EINVAL;
-			}
+			return -EINVAL;
+		}
+		kfree(name);
+		return 0;
+	case Opt_age_extent_cache:
+		set_opt(sbi, AGE_EXTENT_CACHE);
+		return 0;
+	case Opt_errors:
+		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
+		if (!strcmp(name, "remount-ro")) {
+			F2FS_OPTION(sbi).errors =
+					MOUNT_ERRORS_READONLY;
+		} else if (!strcmp(name, "continue")) {
+			F2FS_OPTION(sbi).errors =
+					MOUNT_ERRORS_CONTINUE;
+		} else if (!strcmp(name, "panic")) {
+			F2FS_OPTION(sbi).errors =
+					MOUNT_ERRORS_PANIC;
+		} else {
 			kfree(name);
-			break;
-		default:
-			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
-				 p);
 			return -EINVAL;
 		}
+		kfree(name);
+		return 0;
+	default:
+		f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
+			 param->key);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int parse_options(struct super_block *sb, char *options, bool is_remount)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct fs_parameter param;
+	struct fs_context fc;
+	char *key;
+	int ret;
+
+	if (!options)
+		goto default_check;
+
+	memset(&fc, 0, sizeof(fc));
+	fc.s_fs_info = sbi;
+	if (is_remount)
+		fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
+
+	while ((key = strsep(&options, ",")) != NULL) {
+		if (*key) {
+			size_t v_len = 0;
+			char *value = strchr(key, '=');
+
+			param.type = fs_value_is_flag;
+			param.string = NULL;
+
+			if (value) {
+				if (value == key)
+					continue;
+
+				*value++ = 0;
+				v_len = strlen(value);
+				param.string = kmemdup_nul(value, v_len, GFP_KERNEL);
+				if (!param.string)
+					return -ENOMEM;
+				param.type = fs_value_is_string;
+			}
+
+			param.key = key;
+			param.size = v_len;
+
+			ret = handle_mount_opt(&fc, &param);
+			kfree(param.string);
+			if (ret < 0)
+				return ret;
+		}
 	}
 default_check:
 #ifdef CONFIG_QUOTA
-- 
2.34.1


