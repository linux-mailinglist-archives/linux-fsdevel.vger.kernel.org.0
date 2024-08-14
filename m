Return-Path: <linux-fsdevel+bounces-25863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ADE95127C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF2E1C2120D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C1538385;
	Wed, 14 Aug 2024 02:32:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA981BF3F
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 02:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602765; cv=none; b=Y4CJUS2F9XY6TCMrT4MFVn8wTELatNBaqjBLRi81Bk67IETBcxNahOBL9mXN7ec+i1DitQRij3V/Ja2lkPNFp3RNL2BNcXavLf6K9uqDpRyUqA9rgkO0GqReyuEAxq1zgnh4GFXVWRMa8/QOKslH6Vf6MKq8UCNfwX/B059pzzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602765; c=relaxed/simple;
	bh=vZnp8cqXKhbNZckHmGRQ+hRmHBTS/VRDYlUoTqyGFVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnEsbE/2lkhgx3mg7/lRwo61GFbdSU1jVMC8WWsjwNzl/JsJ+vtWNzsTFzbkx1SIa7gJa+6Ihq3C+XX1wQXuu1ySK+UTXuIAuL28oW65mGhCyL/lg+/h2d2e0UQUG6BeRT1qfCOCFshykji9apFKWHsS1iVFFtF7xQ7vOCltt04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WkBxd4j1YzQphQ;
	Wed, 14 Aug 2024 10:28:05 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A7E771800D0;
	Wed, 14 Aug 2024 10:32:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 10:32:39 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <brauner@kernel.org>,
	<lczerner@redhat.com>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH 6/9] f2fs: separate the options parsing and options checking
Date: Wed, 14 Aug 2024 10:39:09 +0800
Message-ID: <20240814023912.3959299-7-lihongbo22@huawei.com>
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

The new mount api separates option parsing and super block setup
into two distinc steps and so we need to separate the options
parsing out of the parse_options().

In order to achieve this, here we handle the mount options with
three steps:
  - Firstly, we move sb/sbi out of handle_mount_opt.
    As the former patch introduce f2fs_fs_context, so we record
    the changed mount options in this context. In handle_mount_opt,
    sb/sbi is null, so we should move all relative code out of
    handle_mount_opt (thus, some check case which use sb/sbi should
    move out).
  - Secondly, we introduce the some check helpers to keep the option
  consistent.
    During filling superblock period, sb/sbi are ready. So we check
    the f2fs_fs_context which holds the mount options base on sb/sbi.
  - Thirdly, we apply the new mount options to sb/sbi.
    After checking the f2fs_fs_context, all changed on mount options
    are valid. So we can apply them to sb/sbi directly.

After do these, option parsing and super block setting have been
decoupled. Also it should have retained the original execution
flow.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/f2fs/super.c | 665 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 538 insertions(+), 127 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b6cc020f8d6f..f658d75f4bb7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -41,7 +41,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/f2fs.h>
 
-static int f2fs_validate_options(struct super_block *sb);
+static int f2fs_validate_options(struct fs_context *fc);
 
 static struct kmem_cache *f2fs_inode_cachep;
 
@@ -401,6 +401,12 @@ static inline void ctx_clear_opt(struct f2fs_fs_context *ctx,
 	ctx->opt_mask |= flag;
 }
 
+static inline bool ctx_test_opt(struct f2fs_fs_context *ctx,
+				unsigned int flag)
+{
+	return ctx->info.opt & flag;
+}
+
 static inline void ctx_set_flags(struct f2fs_fs_context *ctx,
 				 unsigned int flag)
 {
@@ -780,28 +786,28 @@ static bool is_compress_extension_exist(struct f2fs_mount_info *info,
  * extension will be treated as special cases and will not be compressed.
  * 3. Don't allow the non-compress extension specifies all files.
  */
-static int f2fs_test_compress_extension(struct f2fs_sb_info *sbi)
+static int f2fs_test_compress_extension(unsigned char (*noext)[F2FS_EXTENSION_LEN],
+					int noext_cnt,
+					unsigned char (*ext)[F2FS_EXTENSION_LEN],
+					int ext_cnt)
 {
-	unsigned char (*ext)[F2FS_EXTENSION_LEN];
-	unsigned char (*noext)[F2FS_EXTENSION_LEN];
-	int ext_cnt, noext_cnt, index = 0, no_index = 0;
-
-	ext = F2FS_OPTION(sbi).extensions;
-	ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
-	noext = F2FS_OPTION(sbi).noextensions;
-	noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
+	int index = 0, no_index = 0;
 
 	if (!noext_cnt)
 		return 0;
 
 	for (no_index = 0; no_index < noext_cnt; no_index++) {
+		if (strlen(noext[no_index]) == 0)
+			continue;
 		if (!strcasecmp("*", noext[no_index])) {
-			f2fs_info(sbi, "Don't allow the nocompress extension specifies all files");
+			f2fs_info(NULL, "Don't allow the nocompress extension specifies all files");
 			return -EINVAL;
 		}
 		for (index = 0; index < ext_cnt; index++) {
+			if (strlen(ext[index]) == 0)
+				continue;
 			if (!strcasecmp(ext[index], noext[no_index])) {
-				f2fs_info(sbi, "Don't allow the same extension %s appear in both compress and nocompress extension",
+				f2fs_info(NULL, "Don't allow the same extension %s appear in both compress and nocompress extension",
 						ext[index]);
 				return -EINVAL;
 			}
@@ -893,15 +899,12 @@ static int f2fs_set_zstd_level(struct f2fs_fs_context *ctx, const char *str)
 static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct f2fs_fs_context *ctx = fc->fs_private;
-	struct f2fs_sb_info *sbi = fc->s_fs_info;
-	struct super_block *sb = sbi->sb;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	unsigned char (*ext)[F2FS_EXTENSION_LEN];
 	unsigned char (*noext)[F2FS_EXTENSION_LEN];
 	int ext_cnt, noext_cnt;
 #endif
 	struct fs_parse_result result;
-	int is_remount;
 	char *name;
 	kuid_t uid;
 	kgid_t gid;
@@ -911,8 +914,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 	if (token < 0)
 		return token;
 
-	is_remount = fc->purpose == FS_CONTEXT_FOR_RECONFIGURE;
-
 	switch (token) {
 	case Opt_gc_background:
 		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
@@ -936,23 +937,12 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_ROLL_FORWARD);
 		return 0;
 	case Opt_norecovery:
-		/* this option mounts f2fs with ro */
 		ctx_set_opt(ctx, F2FS_MOUNT_NORECOVERY);
-		if (!f2fs_readonly(sb))
-			return -EINVAL;
 		return 0;
 	case Opt_discard:
-		if (!f2fs_hw_support_discard(sbi)) {
-			f2fs_warn(NULL, "device does not support discard");
-			return 0;
-		}
 		ctx_set_opt(ctx, F2FS_MOUNT_DISCARD);
 		return 0;
 	case Opt_nodiscard:
-		if (f2fs_hw_should_discard(sbi)) {
-			f2fs_warn(NULL, "discard is required for zoned block devices");
-			return -EINVAL;
-		}
 		ctx_clear_opt(ctx, F2FS_MOUNT_DISCARD);
 		return 0;
 	case Opt_noheap:
@@ -973,6 +963,12 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		ctx_clear_opt(ctx, F2FS_MOUNT_INLINE_XATTR);
 		return 0;
 	case Opt_inline_xattr_size:
+		if (result.int_32 < MIN_INLINE_XATTR_SIZE ||
+			result.int_32 > MAX_INLINE_XATTR_SIZE) {
+			f2fs_err(NULL, "inline xattr size is out of range: %lu ~ %lu",
+				MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
+			return -EINVAL;
+		}
 		ctx_set_opt(ctx, F2FS_MOUNT_INLINE_XATTR_SIZE);
 		F2FS_CTX_INFO(ctx).inline_xattr_size = result.int_32;
 		ctx->spec_mask |= F2FS_SPEC_inline_xattr_size;
@@ -1053,14 +1049,9 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		ctx_set_opt(ctx, F2FS_MOUNT_DATA_FLUSH);
 		return 0;
 	case Opt_reserve_root:
-		if (test_opt(sbi, RESERVE_ROOT)) {
-			f2fs_info(NULL, "Preserve previous reserve_root=%u",
-				  F2FS_OPTION(sbi).root_reserved_blocks);
-		} else {
-			ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
-			F2FS_CTX_INFO(ctx).root_reserved_blocks = result.uint_32;
-			ctx->spec_mask |= F2FS_SPEC_reserve_root;
-		}
+		ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
+		F2FS_CTX_INFO(ctx).root_reserved_blocks = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_reserve_root;
 		return 0;
 	case Opt_resuid:
 		uid = make_kuid(current_user_ns(), result.uint_32);
@@ -1102,8 +1093,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		return 0;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	case Opt_fault_injection:
-		if (f2fs_build_fault_attr(sbi, result.int_32,
-				F2FS_ALL_FAULT_TYPE))
+		if (result.int_32 > INT_MAX)
 			return -EINVAL;
 		F2FS_CTX_INFO(ctx).fault_info.inject_rate = result.int_32;
 		ctx->spec_mask |= F2FS_SPEC_fault_injection;
@@ -1111,7 +1101,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		return 0;
 
 	case Opt_fault_type:
-		if (f2fs_build_fault_attr(sbi, 0, result.uint_32))
+		if (result.uint_32 > BIT(FAULT_MAX))
 			return -EINVAL;
 		F2FS_CTX_INFO(ctx).fault_info.inject_type = result.uint_32;
 		ctx->spec_mask |= F2FS_SPEC_fault_type;
@@ -1286,10 +1276,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		return 0;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	case Opt_compress_algorithm:
-		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(NULL, "Image doesn't support compression");
-			return 0;
-		}
 		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
 		if (!name)
 			return -ENOMEM;
@@ -1346,10 +1332,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		kfree(name);
 		return 0;
 	case Opt_compress_log_size:
-		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(NULL, "Image doesn't support compression");
-			return 0;
-		}
 		if (result.int_32 < MIN_COMPRESS_LOG_SIZE ||
 			result.int_32 > MAX_COMPRESS_LOG_SIZE) {
 			f2fs_err(NULL,
@@ -1360,10 +1342,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		ctx->spec_mask |= F2FS_SPEC_compress_log_size;
 		return 0;
 	case Opt_compress_extension:
-		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(NULL, "Image doesn't support compression");
-			break;
-		}
 		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
 		if (!name)
 			return -ENOMEM;
@@ -1394,10 +1372,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		kfree(name);
 		return 0;
 	case Opt_nocompress_extension:
-		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(NULL, "Image doesn't support compression");
-			return 0;
-		}
 		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
 		if (!name)
 			return -ENOMEM;
@@ -1428,18 +1402,10 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		kfree(name);
 		return 0;
 	case Opt_compress_chksum:
-		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(NULL, "Image doesn't support compression");
-			return 0;
-		}
 		F2FS_CTX_INFO(ctx).compress_chksum = true;
 		ctx->spec_mask |= F2FS_SPEC_compress_chksum;
 		return 0;
 	case Opt_compress_mode:
-		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(NULL, "Image doesn't support compression");
-			return 0;
-		}
 		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
 		if (!name)
 			return -ENOMEM;
@@ -1455,10 +1421,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		kfree(name);
 		return 0;
 	case Opt_compress_cache:
-		if (!f2fs_sb_has_compression(sbi)) {
-			f2fs_info(NULL, "Image doesn't support compression");
-			return 0;
-		}
 		ctx_set_opt(ctx, F2FS_MOUNT_COMPRESS_CACHE);
 		return 0;
 #else
@@ -1550,22 +1512,15 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
-static int parse_options(struct super_block *sb, char *options, bool is_remount)
+static int parse_options(struct fs_context *fc, char *options)
 {
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct fs_parameter param;
-	struct fs_context fc;
 	char *key;
 	int ret;
 
 	if (!options)
 		goto default_check;
 
-	memset(&fc, 0, sizeof(fc));
-	fc.s_fs_info = sbi;
-	if (is_remount)
-		fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
-
 	while ((key = strsep(&options, ",")) != NULL) {
 		if (*key) {
 			size_t v_len = 0;
@@ -1589,7 +1544,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			param.key = key;
 			param.size = v_len;
 
-			ret = handle_mount_opt(&fc, &param);
+			ret = handle_mount_opt(fc, &param);
 			kfree(param.string);
 			if (ret < 0)
 				return ret;
@@ -1597,33 +1552,324 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 	}
 
 default_check:
-	return f2fs_validate_options(sb);
+	return f2fs_validate_options(fc);
 }
 
-static int f2fs_validate_options(struct super_block *sb)
+static int f2fs_validate_options(struct fs_context *fc)
 {
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+#ifdef CONFIG_QUOTA
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	char *usr_qf_name, *grp_qf_name, *prj_qf_name;
+
+	usr_qf_name = F2FS_CTX_INFO(ctx).s_qf_names[USRQUOTA];
+	grp_qf_name = F2FS_CTX_INFO(ctx).s_qf_names[GRPQUOTA];
+	prj_qf_name = F2FS_CTX_INFO(ctx).s_qf_names[PRJQUOTA];
+
+	if (usr_qf_name || grp_qf_name || prj_qf_name) {
+		if (ctx_test_opt(ctx, F2FS_MOUNT_USRQUOTA) && usr_qf_name)
+			ctx_clear_opt(ctx, F2FS_MOUNT_USRQUOTA);
+
+		if (ctx_test_opt(ctx, F2FS_MOUNT_GRPQUOTA) && grp_qf_name)
+			ctx_clear_opt(ctx, F2FS_MOUNT_GRPQUOTA);
+
+		if (ctx_test_opt(ctx, F2FS_MOUNT_PRJQUOTA) && prj_qf_name)
+			ctx_clear_opt(ctx, F2FS_MOUNT_PRJQUOTA);
+
+		if (ctx_test_opt(ctx, F2FS_MOUNT_USRQUOTA) ||
+			ctx_test_opt(ctx, F2FS_MOUNT_GRPQUOTA) ||
+			ctx_test_opt(ctx, F2FS_MOUNT_PRJQUOTA)) {
+			f2fs_err(NULL, "old and new quota format mixing");
+			return -EINVAL;
+		}
+	}
+#endif
+	return 0;
+}
 
+/*
+ * Check quota settings consistency.
+ */
+static int f2fs_check_quota_consistency(struct fs_context *fc,
+					struct super_block *sb)
+{
 #ifdef CONFIG_QUOTA
-	if (f2fs_check_quota_options(sbi))
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	bool quota_feature = f2fs_sb_has_quota_ino(sbi);
+	bool quota_turnon = sb_any_quota_loaded(sb);
+	char *old_qname, *new_qname;
+	bool usr_qf_name, grp_qf_name, prj_qf_name, usrquota, grpquota, prjquota;
+	int i;
+
+	/*
+	 * We do the test below only for project quotas. 'usrquota' and
+	 * 'grpquota' mount options are allowed even without quota feature
+	 * to support legacy quotas in quota files.
+	 */
+	if (ctx_test_opt(ctx, F2FS_MOUNT_PRJQUOTA) &&
+			!f2fs_sb_has_project_quota(sbi)) {
+		f2fs_err(sbi, "Project quota feature not enabled. Cannot enable project quota enforcement.");
 		return -EINVAL;
+	}
+
+	if (ctx->qname_mask) {
+		for (i = 0; i < MAXQUOTAS; i++) {
+			if (!(ctx->qname_mask & (1 << i)))
+				continue;
+
+			old_qname = F2FS_OPTION(sbi).s_qf_names[i];
+			new_qname = F2FS_CTX_INFO(ctx).s_qf_names[i];
+			if (quota_turnon &&
+				!!old_qname != !!new_qname)
+				goto err_jquota_change;
+
+			if (old_qname) {
+				if (strcmp(old_qname, new_qname) == 0) {
+					ctx->qname_mask &= ~(1 << i);
+					continue;
+				}
+				goto err_jquota_specified;
+			}
+
+			if (quota_feature) {
+				f2fs_info(sbi, "QUOTA feature is enabled, so ignore qf_name");
+				ctx->qname_mask &= ~(1 << i);
+			}
+		}
+	}
+
+	/* Make sure we don't mix old and new quota format */
+	usr_qf_name = F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
+			F2FS_CTX_INFO(ctx).s_qf_names[USRQUOTA];
+	grp_qf_name = F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
+			F2FS_CTX_INFO(ctx).s_qf_names[GRPQUOTA];
+	prj_qf_name = F2FS_OPTION(sbi).s_qf_names[PRJQUOTA] ||
+			F2FS_CTX_INFO(ctx).s_qf_names[PRJQUOTA];
+	usrquota = test_opt(sbi, USRQUOTA) ||
+			ctx_test_opt(ctx, F2FS_MOUNT_USRQUOTA);
+	grpquota = test_opt(sbi, GRPQUOTA) ||
+			ctx_test_opt(ctx, F2FS_MOUNT_GRPQUOTA);
+	prjquota = test_opt(sbi, PRJQUOTA) ||
+			ctx_test_opt(ctx, F2FS_MOUNT_PRJQUOTA);
+
+	if (usr_qf_name) {
+		ctx_clear_opt(ctx, F2FS_MOUNT_USRQUOTA);
+		usrquota = false;
+	}
+	if (grp_qf_name) {
+		ctx_clear_opt(ctx, F2FS_MOUNT_GRPQUOTA);
+		grpquota = false;
+	}
+	if (prj_qf_name) {
+		ctx_clear_opt(ctx, F2FS_MOUNT_PRJQUOTA);
+		prjquota = false;
+	}
+	if (usr_qf_name || grp_qf_name || prj_qf_name) {
+		if (grpquota || usrquota || prjquota) {
+			f2fs_err(sbi, "old and new quota format mixing");
+			return -EINVAL;
+		}
+		if (!(ctx->spec_mask & F2FS_SPEC_jqfmt ||
+				F2FS_OPTION(sbi).s_jquota_fmt)) {
+			f2fs_err(sbi, "journaled quota format not specified");
+			return -EINVAL;
+		}
+	}
+	return 0;
+
+err_jquota_change:
+	f2fs_err(sbi, "Cannot change journaled quota options when quota turned on");
+	return -EINVAL;
+err_jquota_specified:
+	f2fs_err(sbi, "%s quota file already specified",
+		 QTYPE2NAME(i));
+	return -EINVAL;
+
 #else
-	if (f2fs_sb_has_quota_ino(sbi) && !f2fs_readonly(sbi->sb)) {
-		f2fs_info(NULL, "Filesystem with quota feature cannot be mounted RDWR without CONFIG_QUOTA");
+	if (f2fs_readonly(sbi->sb))
+		return 0;
+	if (f2fs_sb_has_quota_ino(sbi)) {
+		f2fs_info(sbi, "Filesystem with quota feature cannot be mounted RDWR without CONFIG_QUOTA");
 		return -EINVAL;
 	}
-	if (f2fs_sb_has_project_quota(sbi) && !f2fs_readonly(sbi->sb)) {
-		f2fs_err(NULL, "Filesystem with project quota feature cannot be mounted RDWR without CONFIG_QUOTA");
+	if (f2fs_sb_has_project_quota(sbi)) {
+		f2fs_err(sbi, "Filesystem with project quota feature cannot be mounted RDWR without CONFIG_QUOTA");
 		return -EINVAL;
 	}
+
+	return 0;
 #endif
-#if !IS_ENABLED(CONFIG_UNICODE)
-	if (f2fs_sb_has_casefold(sbi)) {
-		f2fs_err(NULL,
-			"Filesystem with casefold feature cannot be mounted without CONFIG_UNICODE");
+}
+
+static int f2fs_check_test_dummy_encryption(struct fs_context *fc,
+					    struct super_block *sb)
+{
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+
+	if (!fscrypt_is_dummy_policy_set(&F2FS_CTX_INFO(ctx).dummy_enc_policy))
+		return 0;
+
+	if (!f2fs_sb_has_encrypt(sbi)) {
+		f2fs_err(sbi, "Encrypt feature is off");
+		return -EINVAL;
+	}
+
+	/*
+	 * This mount option is just for testing, and it's not worthwhile to
+	 * implement the extra complexity (e.g. RCU protection) that would be
+	 * needed to allow it to be set or changed during remount.  We do allow
+	 * it to be specified during remount, but only if there is no change.
+	 */
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		if (fscrypt_dummy_policies_equal(&F2FS_OPTION(sbi).dummy_enc_policy,
+				&F2FS_CTX_INFO(ctx).dummy_enc_policy))
+			return 0;
+		f2fs_warn(sbi, "Can't set or change test_dummy_encryption on remount");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static inline bool test_compression_spec(unsigned int mask)
+{
+	return mask & (F2FS_SPEC_compress_algorithm
+			| F2FS_SPEC_compress_log_size
+			| F2FS_SPEC_compress_extension
+			| F2FS_SPEC_nocompress_extension
+			| F2FS_SPEC_compress_chksum
+			| F2FS_SPEC_compress_mode);
+}
+
+static inline void clear_compression_spec(struct f2fs_fs_context *ctx)
+{
+	ctx->spec_mask &= ~(F2FS_SPEC_compress_algorithm
+						| F2FS_SPEC_compress_log_size
+						| F2FS_SPEC_compress_extension
+						| F2FS_SPEC_nocompress_extension
+						| F2FS_SPEC_compress_chksum
+						| F2FS_SPEC_compress_mode);
+}
+
+static int f2fs_check_compression(struct fs_context *fc,
+				  struct super_block *sb)
+{
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	int i, cnt;
+
+	if (!f2fs_sb_has_compression(sbi)) {
+		if (test_compression_spec(ctx->opt_mask) ||
+			ctx_test_opt(ctx, F2FS_MOUNT_COMPRESS_CACHE))
+			f2fs_info(sbi, "Image doesn't support compression");
+		clear_compression_spec(ctx);
+		ctx->opt_mask &= ~F2FS_MOUNT_COMPRESS_CACHE;
+		return 0;
+	}
+	if (ctx->spec_mask & F2FS_SPEC_compress_extension) {
+		cnt = F2FS_CTX_INFO(ctx).compress_ext_cnt;
+		for (i = 0; i < F2FS_CTX_INFO(ctx).compress_ext_cnt; i++) {
+			if (is_compress_extension_exist(&F2FS_OPTION(sbi),
+					F2FS_CTX_INFO(ctx).extensions[i], true)) {
+				F2FS_CTX_INFO(ctx).extensions[i][0] = '\0';
+				cnt--;
+			}
+		}
+		if (F2FS_OPTION(sbi).compress_ext_cnt + cnt > COMPRESS_EXT_NUM) {
+			f2fs_err(sbi, "invalid extension length/number");
+			return -EINVAL;
+		}
+	}
+	if (ctx->spec_mask & F2FS_SPEC_nocompress_extension) {
+		cnt = F2FS_CTX_INFO(ctx).nocompress_ext_cnt;
+		for (i = 0; i < F2FS_CTX_INFO(ctx).nocompress_ext_cnt; i++) {
+			if (is_compress_extension_exist(&F2FS_OPTION(sbi),
+					F2FS_CTX_INFO(ctx).noextensions[i], false)) {
+				F2FS_CTX_INFO(ctx).noextensions[i][0] = '\0';
+				cnt--;
+			}
+		}
+		if (F2FS_OPTION(sbi).nocompress_ext_cnt + cnt > COMPRESS_EXT_NUM) {
+			f2fs_err(sbi, "invalid noextension length/number");
+			return -EINVAL;
+		}
+	}
+
+	if (f2fs_test_compress_extension(F2FS_CTX_INFO(ctx).noextensions,
+				F2FS_CTX_INFO(ctx).nocompress_ext_cnt,
+				F2FS_CTX_INFO(ctx).extensions,
+				F2FS_CTX_INFO(ctx).compress_ext_cnt)) {
+		f2fs_err(sbi, "invalid compress or nocompress extension");
+		return -EINVAL;
+	}
+	if (f2fs_test_compress_extension(F2FS_CTX_INFO(ctx).noextensions,
+				F2FS_CTX_INFO(ctx).nocompress_ext_cnt,
+				F2FS_OPTION(sbi).extensions,
+				F2FS_OPTION(sbi).compress_ext_cnt)) {
+		f2fs_err(sbi, "invalid compress or nocompress extension");
+		return -EINVAL;
+	}
+	if (f2fs_test_compress_extension(F2FS_OPTION(sbi).noextensions,
+				F2FS_OPTION(sbi).nocompress_ext_cnt,
+				F2FS_CTX_INFO(ctx).extensions,
+				F2FS_CTX_INFO(ctx).compress_ext_cnt)) {
+		f2fs_err(sbi, "invalid compress or nocompress extension");
 		return -EINVAL;
 	}
 #endif
+	return 0;
+}
+
+static int f2fs_check_opt_consistency(struct fs_context *fc,
+				      struct super_block *sb)
+{
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	int err;
+
+	if (ctx_test_opt(ctx, F2FS_MOUNT_NORECOVERY) && !f2fs_readonly(sb))
+		return -EINVAL;
+
+	if (f2fs_hw_should_discard(sbi) && (ctx->opt_mask & F2FS_MOUNT_DISCARD)
+				&& !ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
+		f2fs_warn(sbi, "discard is required for zoned block devices");
+		return -EINVAL;
+	}
+
+	if (!f2fs_hw_support_discard(sbi) && (ctx->opt_mask & F2FS_MOUNT_DISCARD)
+				&& ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
+		f2fs_warn(sbi, "device does not support discard");
+		ctx_clear_opt(ctx, F2FS_MOUNT_DISCARD);
+		ctx->opt_mask &= ~F2FS_MOUNT_DISCARD;
+	}
+
+	if (test_opt(sbi, RESERVE_ROOT) && (ctx->opt_mask & F2FS_MOUNT_RESERVE_ROOT)
+				&& ctx_test_opt(ctx, F2FS_MOUNT_RESERVE_ROOT)) {
+		f2fs_info(sbi, "Preserve previous reserve_root=%u",
+			F2FS_OPTION(sbi).root_reserved_blocks);
+		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
+		ctx->opt_mask &= ~F2FS_MOUNT_RESERVE_ROOT;
+	}
+
+	err = f2fs_check_test_dummy_encryption(fc, sb);
+	if (err)
+		return err;
+
+	err = f2fs_check_compression(fc, sb);
+	if (err)
+		return err;
+
+	err = f2fs_check_quota_consistency(fc, sb);
+	if (err)
+		return err;
+
+	if (!IS_ENABLED(CONFIG_UNICODE) && f2fs_sb_has_casefold(sbi)) {
+		f2fs_err(sbi,
+			"Filesystem with casefold feature cannot be mounted without CONFIG_UNICODE");
+		return -EINVAL;
+	}
+
 	/*
 	 * The BLKZONED feature indicates that the drive was formatted with
 	 * zone alignment optimization. This is optional for host-aware
@@ -1631,71 +1877,212 @@ static int f2fs_validate_options(struct super_block *sb)
 	 */
 	if (f2fs_sb_has_blkzoned(sbi)) {
 #ifdef CONFIG_BLK_DEV_ZONED
-		if (F2FS_OPTION(sbi).discard_unit !=
-						DISCARD_UNIT_SECTION) {
-			f2fs_info(NULL, "Zoned block device doesn't need small discard, set discard_unit=section by default");
-			F2FS_OPTION(sbi).discard_unit =
-					DISCARD_UNIT_SECTION;
+		if ((ctx->spec_mask & F2FS_SPEC_discard_unit) &&
+		F2FS_CTX_INFO(ctx).discard_unit != DISCARD_UNIT_SECTION) {
+			f2fs_info(sbi, "Zoned block device doesn't need small discard, set discard_unit=section by default");
+			F2FS_CTX_INFO(ctx).discard_unit = DISCARD_UNIT_SECTION;
 		}
 
-		if (F2FS_OPTION(sbi).fs_mode != FS_MODE_LFS) {
-			f2fs_info(NULL, "Only lfs mode is allowed with zoned block device feature");
+		if ((ctx->spec_mask & F2FS_SPEC_mode) &&
+		F2FS_CTX_INFO(ctx).fs_mode != FS_MODE_LFS) {
+			f2fs_info(sbi, "Only lfs mode is allowed with zoned block device feature");
 			return -EINVAL;
 		}
 #else
-			f2fs_err(NULL, "Zoned block device support is not enabled");
-			return -EINVAL;
-#endif
-		}
-
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (f2fs_test_compress_extension(sbi)) {
-		f2fs_err(NULL, "invalid compress or nocompress extension");
+		f2fs_err(sbi, "Zoned block device support is not enabled");
 		return -EINVAL;
-	}
 #endif
+	}
 
-	if (test_opt(sbi, INLINE_XATTR_SIZE)) {
-		int min_size, max_size;
-
+	if (ctx_test_opt(ctx, F2FS_MOUNT_INLINE_XATTR_SIZE)) {
 		if (!f2fs_sb_has_extra_attr(sbi) ||
 			!f2fs_sb_has_flexible_inline_xattr(sbi)) {
-			f2fs_err(NULL, "extra_attr or flexible_inline_xattr feature is off");
+			f2fs_err(sbi, "extra_attr or flexible_inline_xattr feature is off");
 			return -EINVAL;
 		}
-		if (!test_opt(sbi, INLINE_XATTR)) {
-			f2fs_err(NULL, "inline_xattr_size option should be set with inline_xattr option");
-			return -EINVAL;
-		}
-
-		min_size = MIN_INLINE_XATTR_SIZE;
-		max_size = MAX_INLINE_XATTR_SIZE;
-
-		if (F2FS_OPTION(sbi).inline_xattr_size < min_size ||
-				F2FS_OPTION(sbi).inline_xattr_size > max_size) {
-			f2fs_err(NULL, "inline xattr size is out of range: %d ~ %d",
-				 min_size, max_size);
+		if (!ctx_test_opt(ctx, F2FS_MOUNT_INLINE_XATTR)) {
+			f2fs_err(sbi, "inline_xattr_size option should be set with inline_xattr option");
 			return -EINVAL;
 		}
 	}
 
-	if (test_opt(sbi, ATGC) && f2fs_lfs_mode(sbi)) {
-		f2fs_err(NULL, "LFS is not compatible with ATGC");
+	if (ctx_test_opt(ctx, F2FS_MOUNT_ATGC) && f2fs_lfs_mode(sbi)) {
+		f2fs_err(sbi, "LFS is not compatible with ATGC");
 		return -EINVAL;
 	}
 
-	if (f2fs_is_readonly(sbi) && test_opt(sbi, FLUSH_MERGE)) {
-		f2fs_err(NULL, "FLUSH_MERGE not compatible with readonly mode");
+	if (f2fs_is_readonly(sbi) && ctx_test_opt(ctx, F2FS_MOUNT_FLUSH_MERGE)) {
+		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
 		return -EINVAL;
 	}
 
 	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
-		f2fs_err(NULL, "Allow to mount readonly mode only");
+		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
 	}
 	return 0;
 }
 
+static void f2fs_apply_quota_options(struct fs_context *fc,
+				     struct super_block *sb)
+{
+#ifdef CONFIG_QUOTA
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	bool quota_feature = f2fs_sb_has_quota_ino(sbi);
+	char *qname;
+	int i;
+
+	if (quota_feature)
+		return;
+
+	for (i = 0; i < MAXQUOTAS; i++) {
+		if (!(ctx->qname_mask & (1 << i)))
+			continue;
+
+		qname = F2FS_CTX_INFO(ctx).s_qf_names[i];
+		if (qname)
+			set_opt(sbi, QUOTA);
+		F2FS_OPTION(sbi).s_qf_names[i] = qname;
+		F2FS_CTX_INFO(ctx).s_qf_names[i] = NULL;
+	}
+
+	if (ctx->spec_mask & F2FS_SPEC_jqfmt)
+		F2FS_OPTION(sbi).s_jquota_fmt = F2FS_CTX_INFO(ctx).s_jquota_fmt;
+
+	if (quota_feature && F2FS_OPTION(sbi).s_jquota_fmt) {
+		f2fs_info(sbi, "QUOTA feature is enabled, so ignore jquota_fmt");
+		F2FS_OPTION(sbi).s_jquota_fmt = 0;
+	}
+#endif
+}
+
+static void f2fs_apply_test_dummy_encryption(struct fs_context *fc,
+					     struct super_block *sb)
+{
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+
+	if (!fscrypt_is_dummy_policy_set(&F2FS_CTX_INFO(ctx).dummy_enc_policy) ||
+		/* if already set, it was already verified to be the same */
+		fscrypt_is_dummy_policy_set(&F2FS_OPTION(sbi).dummy_enc_policy))
+		return;
+	F2FS_OPTION(sbi).dummy_enc_policy = F2FS_CTX_INFO(ctx).dummy_enc_policy;
+	memset(&F2FS_CTX_INFO(ctx).dummy_enc_policy, 0,
+		sizeof(F2FS_CTX_INFO(ctx).dummy_enc_policy));
+	f2fs_warn(sbi, "Test dummy encryption mode enabled");
+}
+
+static void f2fs_apply_compression(struct fs_context *fc,
+				   struct super_block *sb)
+{
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	unsigned char (*ctx_ext)[F2FS_EXTENSION_LEN];
+	unsigned char (*sbi_ext)[F2FS_EXTENSION_LEN];
+	int ctx_cnt, sbi_cnt, i;
+
+	if (ctx->spec_mask & F2FS_SPEC_compress_level)
+		F2FS_OPTION(sbi).compress_level =
+					F2FS_CTX_INFO(ctx).compress_level;
+	if (ctx->spec_mask & F2FS_SPEC_compress_algorithm)
+		F2FS_OPTION(sbi).compress_algorithm =
+					F2FS_CTX_INFO(ctx).compress_algorithm;
+	if (ctx->spec_mask & F2FS_SPEC_compress_log_size)
+		F2FS_OPTION(sbi).compress_log_size =
+					F2FS_CTX_INFO(ctx).compress_log_size;
+	if (ctx->spec_mask & F2FS_SPEC_compress_chksum)
+		F2FS_OPTION(sbi).compress_chksum =
+					F2FS_CTX_INFO(ctx).compress_chksum;
+	if (ctx->spec_mask & F2FS_SPEC_compress_mode)
+		F2FS_OPTION(sbi).compress_mode =
+					F2FS_CTX_INFO(ctx).compress_mode;
+	if (ctx->spec_mask & F2FS_SPEC_compress_extension) {
+		ctx_ext = F2FS_CTX_INFO(ctx).extensions;
+		ctx_cnt = F2FS_CTX_INFO(ctx).compress_ext_cnt;
+		sbi_ext = F2FS_OPTION(sbi).extensions;
+		sbi_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
+		for (i = 0; i < ctx_cnt; i++) {
+			if (strlen(ctx_ext[i]) == 0)
+				continue;
+			strscpy(sbi_ext[sbi_cnt], ctx_ext[i]);
+			sbi_cnt++;
+		}
+		F2FS_OPTION(sbi).compress_ext_cnt = sbi_cnt;
+	}
+	if (ctx->spec_mask & F2FS_SPEC_nocompress_extension) {
+		ctx_ext = F2FS_CTX_INFO(ctx).noextensions;
+		ctx_cnt = F2FS_CTX_INFO(ctx).nocompress_ext_cnt;
+		sbi_ext = F2FS_OPTION(sbi).noextensions;
+		sbi_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
+		for (i = 0; i < ctx_cnt; i++) {
+			if (strlen(ctx_ext[i]) == 0)
+				continue;
+			strscpy(sbi_ext[sbi_cnt], ctx_ext[i]);
+			sbi_cnt++;
+		}
+		F2FS_OPTION(sbi).nocompress_ext_cnt = sbi_cnt;
+	}
+#endif
+}
+
+
+static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
+{
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+
+	F2FS_OPTION(sbi).opt &= ~ctx->opt_mask;
+	F2FS_OPTION(sbi).opt |= F2FS_CTX_INFO(ctx).opt;
+	sb->s_flags &= ~ctx->sflags_mask;
+	sb->s_flags |= ctx->sflags;
+
+	if (ctx->spec_mask & F2FS_SPEC_background_gc)
+		F2FS_OPTION(sbi).bggc_mode = F2FS_CTX_INFO(ctx).bggc_mode;
+	if (ctx->spec_mask & F2FS_SPEC_inline_xattr_size)
+		F2FS_OPTION(sbi).inline_xattr_size =
+					F2FS_CTX_INFO(ctx).inline_xattr_size;
+	if (ctx->spec_mask & F2FS_SPEC_active_logs)
+		F2FS_OPTION(sbi).active_logs = F2FS_CTX_INFO(ctx).active_logs;
+	if (ctx->spec_mask & F2FS_SPEC_reserve_root)
+		F2FS_OPTION(sbi).root_reserved_blocks =
+					F2FS_CTX_INFO(ctx).root_reserved_blocks;
+	if (ctx->spec_mask & F2FS_SPEC_resgid)
+		F2FS_OPTION(sbi).s_resgid = F2FS_CTX_INFO(ctx).s_resgid;
+	if (ctx->spec_mask & F2FS_SPEC_resuid)
+		F2FS_OPTION(sbi).s_resuid = F2FS_CTX_INFO(ctx).s_resuid;
+	if (ctx->spec_mask & F2FS_SPEC_mode)
+		F2FS_OPTION(sbi).fs_mode = F2FS_CTX_INFO(ctx).fs_mode;
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (ctx->spec_mask & F2FS_SPEC_fault_injection)
+		(void)f2fs_build_fault_attr(sbi,
+		F2FS_CTX_INFO(ctx).fault_info.inject_rate, F2FS_ALL_FAULT_TYPE);
+	if (ctx->spec_mask & F2FS_SPEC_fault_type)
+		(void)f2fs_build_fault_attr(sbi,
+			0, F2FS_CTX_INFO(ctx).fault_info.inject_type);
+#endif
+	if (ctx->spec_mask & F2FS_SPEC_alloc_mode)
+		F2FS_OPTION(sbi).alloc_mode = F2FS_CTX_INFO(ctx).alloc_mode;
+	if (ctx->spec_mask & F2FS_SPEC_fsync_mode)
+		F2FS_OPTION(sbi).fsync_mode = F2FS_CTX_INFO(ctx).fsync_mode;
+	if (ctx->spec_mask & F2FS_SPEC_checkpoint_disable_cap)
+		F2FS_OPTION(sbi).unusable_cap = F2FS_CTX_INFO(ctx).unusable_cap;
+	if (ctx->spec_mask & F2FS_SPEC_checkpoint_disable_cap_perc)
+		F2FS_OPTION(sbi).unusable_cap_perc =
+					F2FS_CTX_INFO(ctx).unusable_cap_perc;
+	if (ctx->spec_mask & F2FS_SPEC_discard_unit)
+		F2FS_OPTION(sbi).discard_unit = F2FS_CTX_INFO(ctx).discard_unit;
+	if (ctx->spec_mask & F2FS_SPEC_memory_mode)
+		F2FS_OPTION(sbi).memory_mode = F2FS_CTX_INFO(ctx).memory_mode;
+	if (ctx->spec_mask & F2FS_SPEC_errors)
+		F2FS_OPTION(sbi).errors = F2FS_CTX_INFO(ctx).errors;
+
+	f2fs_apply_compression(fc, sb);
+	f2fs_apply_test_dummy_encryption(fc, sb);
+	f2fs_apply_quota_options(fc, sb);
+}
+
 static struct inode *f2fs_alloc_inode(struct super_block *sb)
 {
 	struct f2fs_inode_info *fi;
@@ -2570,6 +2957,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct f2fs_mount_info org_mount_opt;
+	struct f2fs_fs_context ctx;
+	struct fs_context fc;
 	unsigned long old_sb_flags;
 	int err;
 	bool need_restart_gc = false, need_stop_gc = false;
@@ -2623,11 +3012,22 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 	default_options(sbi, true);
 
+	memset(&fc, 0, sizeof(fc));
+	memset(&ctx, 0, sizeof(ctx));
+	fc.fs_private = &ctx;
+	fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
+
 	/* parse mount options */
-	err = parse_options(sb, data, true);
+	err = parse_options(&fc, data);
 	if (err)
 		goto restore_opts;
 
+	err = f2fs_check_opt_consistency(&fc, sb);
+	if (err < 0)
+		goto restore_opts;
+
+	f2fs_apply_options(&fc, sb);
+
 #ifdef CONFIG_BLK_DEV_ZONED
 	if (f2fs_sb_has_blkzoned(sbi) &&
 		sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
@@ -4651,6 +5051,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct f2fs_sb_info *sbi;
 	struct f2fs_super_block *raw_super;
+	struct f2fs_fs_context ctx;
+	struct fs_context fc;
 	struct inode *root;
 	int err;
 	bool skip_recovery = false, need_fsck = false;
@@ -4667,6 +5069,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	raw_super = NULL;
 	valid_super_block = -1;
 	recovery = 0;
+	memset(&fc, 0, sizeof(fc));
+	memset(&ctx, 0, sizeof(ctx));
+	fc.fs_private = &ctx;
 
 	/* allocate memory for f2fs-specific super block info */
 	sbi = kzalloc(sizeof(struct f2fs_sb_info), GFP_KERNEL);
@@ -4733,10 +5138,16 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_sb_buf;
 	}
 
-	err = parse_options(sb, options, false);
+	err = parse_options(&fc, options);
 	if (err)
 		goto free_options;
 
+	err = f2fs_check_opt_consistency(&fc, sb);
+	if (err < 0)
+		goto free_options;
+
+	f2fs_apply_options(&fc, sb);
+
 	sb->s_maxbytes = max_file_blocks(NULL) <<
 				le32_to_cpu(raw_super->log_blocksize);
 	sb->s_max_links = F2FS_LINK_MAX;
-- 
2.34.1


