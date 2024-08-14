Return-Path: <linux-fsdevel+bounces-25861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A72F95127A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9851F21865
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D505D364AE;
	Wed, 14 Aug 2024 02:32:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F518026
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 02:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602764; cv=none; b=gmHT7t4PmSCUPPHT7lERyQUxtIgIfau0CuOVb/hRdfLdZJLzx+w9lFlHMoezgY7LE99JFsBmQCz7qglt9nx+s7v32DmtqEJzMwWLsLH8nqC582dIOCkc9oGEw4mIKxnh/qMzViQAMOqxeLMxtTfUqqpMbtoLQcnfXw52bMQbKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602764; c=relaxed/simple;
	bh=L0TgpzzQ+ZIBRQ3H9AG9xEp8/55YFosdP2f1cU6Z2aE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nqrmmtz0P3ybL5ZBkcMqvD+HQA24el55vkwbsvA0xVrMeqvGcWR7ucDLZoliOILSEKW6HAr3iDaP0GPLkLVe3ZtWdKgF7SMa/TtGWZCSDLJ4N37oDK9J9YSaZAgi6IjDn++Vr6ONNE5Fjbtq1e8aR6H5CZ81xBfBHj+UbC9sJJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WkBzM3x5dz1HGLq;
	Wed, 14 Aug 2024 10:29:35 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 84C5518001B;
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
Subject: [PATCH 5/9] f2fs: Add f2fs_fs_context to record the mount options
Date: Wed, 14 Aug 2024 10:39:08 +0800
Message-ID: <20240814023912.3959299-6-lihongbo22@huawei.com>
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

At the parsing phase of mouont in the new mount api, options
value will be recorded with the context, and then it will be
used in fill_super and other helpers.

Notes that, this is a temporary status, we want remove the sb
and sbi usages in handle_mount_opt. So here the f2fs_fs_context
only records the mount options, it will be copied in sb/sbi in
later process.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/f2fs/super.c | 409 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 288 insertions(+), 121 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2a06444e7e02..b6cc020f8d6f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -351,8 +351,65 @@ static match_table_t f2fs_tokens = {
 	{Opt_err, NULL},
 };
 
+#define F2FS_SPEC_background_gc			(1 << 0)
+#define F2FS_SPEC_inline_xattr_size		(1 << 1)
+#define F2FS_SPEC_active_logs			(1 << 2)
+#define F2FS_SPEC_reserve_root			(1 << 3)
+#define F2FS_SPEC_resgid			(1 << 4)
+#define F2FS_SPEC_resuid			(1 << 5)
+#define F2FS_SPEC_mode				(1 << 6)
+#define F2FS_SPEC_fault_injection		(1 << 7)
+#define F2FS_SPEC_fault_type			(1 << 8)
+#define F2FS_SPEC_jqfmt				(1 << 9)
+#define F2FS_SPEC_alloc_mode			(1 << 10)
+#define F2FS_SPEC_fsync_mode			(1 << 11)
+#define F2FS_SPEC_checkpoint_disable_cap	(1 << 12)
+#define F2FS_SPEC_checkpoint_disable_cap_perc	(1 << 13)
+#define F2FS_SPEC_compress_level		(1 << 14)
+#define F2FS_SPEC_compress_algorithm		(1 << 15)
+#define F2FS_SPEC_compress_log_size		(1 << 16)
+#define F2FS_SPEC_compress_extension		(1 << 17)
+#define F2FS_SPEC_nocompress_extension		(1 << 18)
+#define F2FS_SPEC_compress_chksum		(1 << 19)
+#define F2FS_SPEC_compress_mode			(1 << 20)
+#define F2FS_SPEC_discard_unit			(1 << 21)
+#define F2FS_SPEC_memory_mode			(1 << 22)
+#define F2FS_SPEC_errors			(1 << 23)
+
+struct f2fs_fs_context {
+	struct f2fs_mount_info info;
+	unsigned int	opt_mask;	/* Bits changed */
+	unsigned int	spec_mask;
+	unsigned short	qname_mask;
+	unsigned long	sflags;
+	unsigned long	sflags_mask;
+};
+
+#define F2FS_CTX_INFO(ctx)	((ctx)->info)
+
+static inline void ctx_set_opt(struct f2fs_fs_context *ctx,
+			       unsigned int flag)
+{
+	ctx->info.opt |= flag;
+	ctx->opt_mask |= flag;
+}
+
+static inline void ctx_clear_opt(struct f2fs_fs_context *ctx,
+				 unsigned int flag)
+{
+	ctx->info.opt &= ~flag;
+	ctx->opt_mask |= flag;
+}
+
+static inline void ctx_set_flags(struct f2fs_fs_context *ctx,
+				 unsigned int flag)
+{
+	ctx->sflags |= flag;
+	ctx->sflags_mask |= flag;
+}
+
 void f2fs_printk(struct f2fs_sb_info *sbi, bool limit_rate,
-						const char *fmt, ...)
+					const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -524,6 +581,56 @@ static int f2fs_clear_qf_name(struct super_block *sb, int qtype)
 	return 0;
 }
 
+/*
+ * Note the name of the specified quota file.
+ */
+static int f2fs_note_qf_name(struct fs_context *fc, int qtype,
+			     struct fs_parameter *param)
+{
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	char *qname;
+
+	if (param->size < 1) {
+		f2fs_err(NULL, "Missing quota name");
+		return -EINVAL;
+	}
+	if (strchr(param->string, '/')) {
+		f2fs_err(NULL, "quotafile must be on filesystem root");
+		return -EINVAL;
+	}
+	if (ctx->info.s_qf_names[qtype]) {
+		if (strcmp(ctx->info.s_qf_names[qtype], param->string) != 0) {
+			f2fs_err(NULL, "Quota file already specified");
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	qname = kmemdup_nul(param->string, param->size, GFP_KERNEL);
+	if (!qname) {
+		f2fs_err(NULL, "Not enough memory for storing quotafile name");
+		return -ENOMEM;
+	}
+	F2FS_CTX_INFO(ctx).s_qf_names[qtype] = qname;
+	ctx->qname_mask |= 1 << qtype;
+	return 0;
+}
+
+/*
+ * Clear the name of the specified quota file.
+ */
+static int f2fs_unnote_qf_name(struct fs_context *fc, int qtype)
+{
+	struct f2fs_fs_context *ctx = fc->fs_private;
+
+	if (ctx->info.s_qf_names[qtype])
+		kfree(ctx->info.s_qf_names[qtype]);
+
+	ctx->info.s_qf_names[qtype] = NULL;
+	ctx->qname_mask |= 1 << qtype;
+	return 0;
+}
+
 static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
 {
 	/*
@@ -570,6 +677,31 @@ static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
 }
 #endif
 
+static int f2fs_parse_test_dummy_encryption(const struct fs_parameter *param,
+					    struct f2fs_fs_context *ctx)
+{
+	int err;
+
+	if (!IS_ENABLED(CONFIG_FS_ENCRYPTION)) {
+		f2fs_warn(NULL, "test_dummy_encryption option not supported");
+		return -EINVAL;
+	}
+	err = fscrypt_parse_test_dummy_encryption(param,
+					&ctx->info.dummy_enc_policy);
+	if (err) {
+		if (err == -EINVAL)
+			f2fs_warn(NULL, "Value of option \"%s\" is unrecognized",
+				  param->key);
+		else if (err == -EEXIST)
+			f2fs_warn(NULL, "Conflicting test_dummy_encryption options");
+		else
+			f2fs_warn(NULL, "Error processing option \"%s\" [%d]",
+				  param->key, err);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int f2fs_set_test_dummy_encryption(struct super_block *sb,
 					  const struct fs_parameter *param,
 					  bool is_remount)
@@ -618,7 +750,7 @@ static int f2fs_set_test_dummy_encryption(struct super_block *sb,
 }
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-static bool is_compress_extension_exist(struct f2fs_sb_info *sbi,
+static bool is_compress_extension_exist(struct f2fs_mount_info *info,
 					const char *new_ext, bool is_ext)
 {
 	unsigned char (*ext)[F2FS_EXTENSION_LEN];
@@ -626,11 +758,11 @@ static bool is_compress_extension_exist(struct f2fs_sb_info *sbi,
 	int i;
 
 	if (is_ext) {
-		ext = F2FS_OPTION(sbi).extensions;
-		ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
+		ext = info->extensions;
+		ext_cnt = info->compress_ext_cnt;
 	} else {
-		ext = F2FS_OPTION(sbi).noextensions;
-		ext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
+		ext = info->noextensions;
+		ext_cnt = info->nocompress_ext_cnt;
 	}
 
 	for (i = 0; i < ext_cnt; i++) {
@@ -679,58 +811,62 @@ static int f2fs_test_compress_extension(struct f2fs_sb_info *sbi)
 }
 
 #ifdef CONFIG_F2FS_FS_LZ4
-static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
+static int f2fs_set_lz4hc_level(struct f2fs_fs_context *ctx, const char *str)
 {
 #ifdef CONFIG_F2FS_FS_LZ4HC
 	unsigned int level;
 
 	if (strlen(str) == 3) {
-		F2FS_OPTION(sbi).compress_level = 0;
+		F2FS_CTX_INFO(ctx).compress_level = 0;
+		ctx->spec_mask |= F2FS_SPEC_compress_level;
 		return 0;
 	}
 
 	str += 3;
 
 	if (str[0] != ':') {
-		f2fs_info(sbi, "wrong format, e.g. <alg_name>:<compr_level>");
+		f2fs_info(NULL, "wrong format, e.g. <alg_name>:<compr_level>");
 		return -EINVAL;
 	}
 	if (kstrtouint(str + 1, 10, &level))
 		return -EINVAL;
 
 	if (!f2fs_is_compress_level_valid(COMPRESS_LZ4, level)) {
-		f2fs_info(sbi, "invalid lz4hc compress level: %d", level);
+		f2fs_info(NULL, "invalid lz4hc compress level: %d", level);
 		return -EINVAL;
 	}
 
-	F2FS_OPTION(sbi).compress_level = level;
+	F2FS_CTX_INFO(ctx).compress_level = level;
+	ctx->spec_mask |= F2FS_SPEC_compress_level;
 	return 0;
 #else
 	if (strlen(str) == 3) {
-		F2FS_OPTION(sbi).compress_level = 0;
+		F2FS_CTX_INFO(ctx).compress_level = 0;
+		ctx->spec_mask |= F2FS_SPEC_compress_level;
 		return 0;
 	}
-	f2fs_info(sbi, "kernel doesn't support lz4hc compression");
+	f2fs_info(NULL, "kernel doesn't support lz4hc compression");
 	return -EINVAL;
 #endif
 }
 #endif
 
 #ifdef CONFIG_F2FS_FS_ZSTD
-static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
+static int f2fs_set_zstd_level(struct f2fs_fs_context *ctx, const char *str)
 {
 	int level;
 	int len = 4;
 
 	if (strlen(str) == len) {
-		F2FS_OPTION(sbi).compress_level = F2FS_ZSTD_DEFAULT_CLEVEL;
+		F2FS_CTX_INFO(ctx).compress_level = F2FS_ZSTD_DEFAULT_CLEVEL;
+		ctx->spec_mask |= F2FS_SPEC_compress_level;
 		return 0;
 	}
 
 	str += len;
 
 	if (str[0] != ':') {
-		f2fs_info(sbi, "wrong format, e.g. <alg_name>:<compr_level>");
+		f2fs_info(NULL, "wrong format, e.g. <alg_name>:<compr_level>");
 		return -EINVAL;
 	}
 	if (kstrtoint(str + 1, 10, &level))
@@ -738,16 +874,17 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 
 	/* f2fs does not support negative compress level now */
 	if (level < 0) {
-		f2fs_info(sbi, "do not support negative compress level: %d", level);
+		f2fs_info(NULL, "do not support negative compress level: %d", level);
 		return -ERANGE;
 	}
 
 	if (!f2fs_is_compress_level_valid(COMPRESS_ZSTD, level)) {
-		f2fs_info(sbi, "invalid zstd compress level: %d", level);
+		f2fs_info(NULL, "invalid zstd compress level: %d", level);
 		return -EINVAL;
 	}
 
-	F2FS_OPTION(sbi).compress_level = level;
+	F2FS_CTX_INFO(ctx).compress_level = level;
+	ctx->spec_mask |= F2FS_SPEC_compress_level;
 	return 0;
 }
 #endif
@@ -755,6 +892,7 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 
 static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 {
+	struct f2fs_fs_context *ctx = fc->fs_private;
 	struct f2fs_sb_info *sbi = fc->s_fs_info;
 	struct super_block *sb = sbi->sb;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -782,23 +920,24 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (!name)
 			return -ENOMEM;
 		if (!strcmp(name, "on")) {
-			F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
+			F2FS_CTX_INFO(ctx).bggc_mode = BGGC_MODE_ON;
 		} else if (!strcmp(name, "off")) {
-			F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_OFF;
+			F2FS_CTX_INFO(ctx).bggc_mode = BGGC_MODE_OFF;
 		} else if (!strcmp(name, "sync")) {
-			F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_SYNC;
+			F2FS_CTX_INFO(ctx).bggc_mode = BGGC_MODE_SYNC;
 		} else {
 			kfree(name);
 			return -EINVAL;
 		}
+		ctx->spec_mask |= F2FS_SPEC_background_gc;
 		kfree(name);
 		return 0;
 	case Opt_disable_roll_forward:
-		set_opt(sbi, DISABLE_ROLL_FORWARD);
+		ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_ROLL_FORWARD);
 		return 0;
 	case Opt_norecovery:
 		/* this option mounts f2fs with ro */
-		set_opt(sbi, NORECOVERY);
+		ctx_set_opt(ctx, F2FS_MOUNT_NORECOVERY);
 		if (!f2fs_readonly(sb))
 			return -EINVAL;
 		return 0;
@@ -807,14 +946,14 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			f2fs_warn(NULL, "device does not support discard");
 			return 0;
 		}
-		set_opt(sbi, DISCARD);
+		ctx_set_opt(ctx, F2FS_MOUNT_DISCARD);
 		return 0;
 	case Opt_nodiscard:
 		if (f2fs_hw_should_discard(sbi)) {
 			f2fs_warn(NULL, "discard is required for zoned block devices");
 			return -EINVAL;
 		}
-		clear_opt(sbi, DISCARD);
+		ctx_clear_opt(ctx, F2FS_MOUNT_DISCARD);
 		return 0;
 	case Opt_noheap:
 	case Opt_heap:
@@ -822,20 +961,21 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		return 0;
 #ifdef CONFIG_F2FS_FS_XATTR
 	case Opt_user_xattr:
-		set_opt(sbi, XATTR_USER);
+		ctx_set_opt(ctx, F2FS_MOUNT_XATTR_USER);
 		return 0;
 	case Opt_nouser_xattr:
-		clear_opt(sbi, XATTR_USER);
+		ctx_clear_opt(ctx, F2FS_MOUNT_XATTR_USER);
 		return 0;
 	case Opt_inline_xattr:
-		set_opt(sbi, INLINE_XATTR);
+		ctx_set_opt(ctx, F2FS_MOUNT_INLINE_XATTR);
 		return 0;
 	case Opt_noinline_xattr:
-		clear_opt(sbi, INLINE_XATTR);
+		ctx_clear_opt(ctx, F2FS_MOUNT_INLINE_XATTR);
 		return 0;
 	case Opt_inline_xattr_size:
-		set_opt(sbi, INLINE_XATTR_SIZE);
-		F2FS_OPTION(sbi).inline_xattr_size = result.int_32;
+		ctx_set_opt(ctx, F2FS_MOUNT_INLINE_XATTR_SIZE);
+		F2FS_CTX_INFO(ctx).inline_xattr_size = result.int_32;
+		ctx->spec_mask |= F2FS_SPEC_inline_xattr_size;
 		return 0;
 #else
 	case Opt_user_xattr:
@@ -853,10 +993,10 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 #endif
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
 	case Opt_acl:
-		set_opt(sbi, POSIX_ACL);
+		ctx_set_opt(ctx, F2FS_MOUNT_POSIX_ACL);
 		return 0;
 	case Opt_noacl:
-		clear_opt(sbi, POSIX_ACL);
+		ctx_clear_opt(ctx, F2FS_MOUNT_POSIX_ACL);
 		return 0;
 #else
 	case Opt_acl:
@@ -870,54 +1010,56 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (result.int_32 != 2 && result.int_32 != 4 &&
 			result.int_32 != NR_CURSEG_PERSIST_TYPE)
 			return -EINVAL;
-		F2FS_OPTION(sbi).active_logs = result.int_32;
+		F2FS_CTX_INFO(ctx).active_logs = result.int_32;
+		ctx->spec_mask |= F2FS_SPEC_active_logs;
 		return 0;
 	case Opt_disable_ext_identify:
-		set_opt(sbi, DISABLE_EXT_IDENTIFY);
+		ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_EXT_IDENTIFY);
 		return 0;
 	case Opt_inline_data:
-		set_opt(sbi, INLINE_DATA);
+		ctx_set_opt(ctx, F2FS_MOUNT_INLINE_DATA);
 		return 0;
 	case Opt_inline_dentry:
-		set_opt(sbi, INLINE_DENTRY);
+		ctx_set_opt(ctx, F2FS_MOUNT_INLINE_DENTRY);
 		return 0;
 	case Opt_noinline_dentry:
-		clear_opt(sbi, INLINE_DENTRY);
+		ctx_clear_opt(ctx, F2FS_MOUNT_INLINE_DENTRY);
 		return 0;
 	case Opt_flush_merge:
-		set_opt(sbi, FLUSH_MERGE);
+		ctx_set_opt(ctx, F2FS_MOUNT_FLUSH_MERGE);
 		return 0;
 	case Opt_noflush_merge:
-		clear_opt(sbi, FLUSH_MERGE);
+		ctx_clear_opt(ctx, F2FS_MOUNT_FLUSH_MERGE);
 		return 0;
 	case Opt_nobarrier:
-		set_opt(sbi, NOBARRIER);
+		ctx_set_opt(ctx, F2FS_MOUNT_NOBARRIER);
 		return 0;
 	case Opt_barrier:
-		clear_opt(sbi, NOBARRIER);
+		ctx_clear_opt(ctx, F2FS_MOUNT_NOBARRIER);
 		return 0;
 	case Opt_fastboot:
-		set_opt(sbi, FASTBOOT);
+		ctx_set_opt(ctx, F2FS_MOUNT_FASTBOOT);
 		return 0;
 	case Opt_extent_cache:
-		set_opt(sbi, READ_EXTENT_CACHE);
+		ctx_set_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE);
 		return 0;
 	case Opt_noextent_cache:
-		clear_opt(sbi, READ_EXTENT_CACHE);
+		ctx_clear_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE);
 		return 0;
 	case Opt_noinline_data:
-		clear_opt(sbi, INLINE_DATA);
+		ctx_clear_opt(ctx, F2FS_MOUNT_INLINE_DATA);
 		return 0;
 	case Opt_data_flush:
-		set_opt(sbi, DATA_FLUSH);
+		ctx_set_opt(ctx, F2FS_MOUNT_DATA_FLUSH);
 		return 0;
 	case Opt_reserve_root:
 		if (test_opt(sbi, RESERVE_ROOT)) {
 			f2fs_info(NULL, "Preserve previous reserve_root=%u",
 				  F2FS_OPTION(sbi).root_reserved_blocks);
 		} else {
-			F2FS_OPTION(sbi).root_reserved_blocks = result.uint_32;
-			set_opt(sbi, RESERVE_ROOT);
+			ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
+			F2FS_CTX_INFO(ctx).root_reserved_blocks = result.uint_32;
+			ctx->spec_mask |= F2FS_SPEC_reserve_root;
 		}
 		return 0;
 	case Opt_resuid:
@@ -926,7 +1068,8 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			f2fs_err(NULL, "Invalid uid value %u", result.uint_32);
 			return -EINVAL;
 		}
-		F2FS_OPTION(sbi).s_resuid = uid;
+		F2FS_CTX_INFO(ctx).s_resuid = uid;
+		ctx->spec_mask |= F2FS_SPEC_resuid;
 		return 0;
 	case Opt_resgid:
 		gid = make_kgid(current_user_ns(), result.uint_32);
@@ -934,7 +1077,8 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			f2fs_err(NULL, "Invalid gid value %u", result.uint_32);
 			return -EINVAL;
 		}
-		F2FS_OPTION(sbi).s_resgid = gid;
+		F2FS_CTX_INFO(ctx).s_resgid = gid;
+		ctx->spec_mask |= F2FS_SPEC_resgid;
 		return 0;
 	case Opt_mode:
 		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
@@ -942,17 +1086,18 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (!name)
 			return -ENOMEM;
 		if (!strcmp(name, "adaptive")) {
-			F2FS_OPTION(sbi).fs_mode = FS_MODE_ADAPTIVE;
+			F2FS_CTX_INFO(ctx).fs_mode = FS_MODE_ADAPTIVE;
 		} else if (!strcmp(name, "lfs")) {
-			F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
+			F2FS_CTX_INFO(ctx).fs_mode = FS_MODE_LFS;
 		} else if (!strcmp(name, "fragment:segment")) {
-			F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_SEG;
+			F2FS_CTX_INFO(ctx).fs_mode = FS_MODE_FRAGMENT_SEG;
 		} else if (!strcmp(name, "fragment:block")) {
-			F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_BLK;
+			F2FS_CTX_INFO(ctx).fs_mode = FS_MODE_FRAGMENT_BLK;
 		} else {
 			kfree(name);
 			return -EINVAL;
 		}
+		ctx->spec_mask |= F2FS_SPEC_mode;
 		kfree(name);
 		return 0;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
@@ -960,13 +1105,17 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (f2fs_build_fault_attr(sbi, result.int_32,
 				F2FS_ALL_FAULT_TYPE))
 			return -EINVAL;
-		set_opt(sbi, FAULT_INJECTION);
+		F2FS_CTX_INFO(ctx).fault_info.inject_rate = result.int_32;
+		ctx->spec_mask |= F2FS_SPEC_fault_injection;
+		ctx_set_opt(ctx, F2FS_MOUNT_FAULT_INJECTION);
 		return 0;
 
 	case Opt_fault_type:
 		if (f2fs_build_fault_attr(sbi, 0, result.uint_32))
 			return -EINVAL;
-		set_opt(sbi, FAULT_INJECTION);
+		F2FS_CTX_INFO(ctx).fault_info.inject_type = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_fault_type;
+		ctx_set_opt(ctx, F2FS_MOUNT_FAULT_INJECTION);
 		return 0;
 #else
 	case Opt_fault_injection:
@@ -980,46 +1129,47 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 #ifdef CONFIG_QUOTA
 	case Opt_quota:
 	case Opt_usrquota:
-		set_opt(sbi, USRQUOTA);
+		ctx_set_opt(ctx, F2FS_MOUNT_USRQUOTA);
 		return 0;
 	case Opt_grpquota:
-		set_opt(sbi, GRPQUOTA);
+		ctx_set_opt(ctx, F2FS_MOUNT_GRPQUOTA);
 		return 0;
 	case Opt_prjquota:
-		set_opt(sbi, PRJQUOTA);
+		ctx_set_opt(ctx, F2FS_MOUNT_PRJQUOTA);
 		return 0;
 	case Opt_usrjquota:
 		if (!*param->string)
-			ret = f2fs_clear_qf_name(sb, USRQUOTA);
+			ret = f2fs_unnote_qf_name(fc, USRQUOTA);
 		else
-			ret = f2fs_set_qf_name(sb, USRQUOTA, param);
+			ret = f2fs_note_qf_name(fc, USRQUOTA, param);
 		if (ret)
 			return ret;
 		return 0;
 	case Opt_grpjquota:
 		if (!*param->string)
-			ret = f2fs_clear_qf_name(sb, GRPQUOTA);
+			ret = f2fs_unnote_qf_name(fc, GRPQUOTA);
 		else
-			ret = f2fs_set_qf_name(sb, GRPQUOTA, param);
+			ret = f2fs_note_qf_name(fc, GRPQUOTA, param);
 		if (ret)
 			return ret;
 		return 0;
 	case Opt_prjjquota:
 		if (!*param->string)
-			ret = f2fs_clear_qf_name(sb, PRJQUOTA);
+			ret = f2fs_unnote_qf_name(fc, PRJQUOTA);
 		else
-			ret = f2fs_set_qf_name(sb, PRJQUOTA, param);
+			ret = f2fs_note_qf_name(fc, PRJQUOTA, param);
 		if (ret)
 			return ret;
 		return 0;
 	case Opt_jqfmt:
-		F2FS_OPTION(sbi).s_jquota_fmt = result.uint_32;
+		F2FS_CTX_INFO(ctx).s_jquota_fmt = result.int_32;
+		ctx->spec_mask |= F2FS_SPEC_jqfmt;
 		return 0;
 	case Opt_noquota:
-		clear_opt(sbi, QUOTA);
-		clear_opt(sbi, USRQUOTA);
-		clear_opt(sbi, GRPQUOTA);
-		clear_opt(sbi, PRJQUOTA);
+		ctx_clear_opt(ctx, F2FS_MOUNT_QUOTA);
+		ctx_clear_opt(ctx, F2FS_MOUNT_USRQUOTA);
+		ctx_clear_opt(ctx, F2FS_MOUNT_GRPQUOTA);
+		ctx_clear_opt(ctx, F2FS_MOUNT_PRJQUOTA);
 		return 0;
 #else
 	case Opt_quota:
@@ -1045,13 +1195,14 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			return -ENOMEM;
 
 		if (!strcmp(name, "default")) {
-			F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
+			F2FS_CTX_INFO(ctx).alloc_mode = ALLOC_MODE_DEFAULT;
 		} else if (!strcmp(name, "reuse")) {
-			F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
+			F2FS_CTX_INFO(ctx).alloc_mode = ALLOC_MODE_REUSE;
 		} else {
 			kfree(name);
 			return -EINVAL;
 		}
+		ctx->spec_mask |= F2FS_SPEC_alloc_mode;
 		kfree(name);
 		return 0;
 	case Opt_fsync:
@@ -1059,26 +1210,26 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (!name)
 			return -ENOMEM;
 		if (!strcmp(name, "posix")) {
-			F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_POSIX;
+			F2FS_CTX_INFO(ctx).fsync_mode = FSYNC_MODE_POSIX;
 		} else if (!strcmp(name, "strict")) {
-			F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_STRICT;
+			F2FS_CTX_INFO(ctx).fsync_mode = FSYNC_MODE_STRICT;
 		} else if (!strcmp(name, "nobarrier")) {
-			F2FS_OPTION(sbi).fsync_mode =
-						FSYNC_MODE_NOBARRIER;
+			F2FS_CTX_INFO(ctx).fsync_mode = FSYNC_MODE_NOBARRIER;
 		} else {
 			kfree(name);
 			return -EINVAL;
 		}
+		ctx->spec_mask |= F2FS_SPEC_fsync_mode;
 		kfree(name);
 		return 0;
 	case Opt_test_dummy_encryption:
-		ret = f2fs_set_test_dummy_encryption(sb, param, is_remount);
+		ret = f2fs_parse_test_dummy_encryption(param, ctx);
 		if (ret)
 			return ret;
 		return 0;
 	case Opt_inlinecrypt:
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
-		sb->s_flags |= SB_INLINECRYPT;
+		ctx_set_flags(ctx, SB_INLINECRYPT);
 #else
 		f2fs_info(NULL, "inline encryption not supported");
 #endif
@@ -1092,12 +1243,12 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		unsigned long cap = 0;
 
 		if (!strcmp(param->string, "enable")) {
-			clear_opt(sbi, DISABLE_CHECKPOINT);
+			ctx_clear_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOINT);
 			return 0;
 		}
 
 		if (!strcmp(param->string, "disable")) {
-			set_opt(sbi, DISABLE_CHECKPOINT);
+			ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOINT);
 			return 0;
 		}
 
@@ -1113,23 +1264,25 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (!strcmp(cp, endp))
 			return -EINVAL;
 		if (strlen(endp) == 0) {
-			F2FS_OPTION(sbi).unusable_cap = cap;
-			set_opt(sbi, DISABLE_CHECKPOINT);
+			F2FS_CTX_INFO(ctx).unusable_cap = cap;
+			ctx->spec_mask |= F2FS_SPEC_checkpoint_disable_cap;
+			ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOINT);
 			return 0;
 		}
 		if (strcmp(endp, "%"))
 			return -EINVAL;
 		if (cap > 100)
 			return -EINVAL;
-		F2FS_OPTION(sbi).unusable_cap_perc = cap;
-		set_opt(sbi, DISABLE_CHECKPOINT);
+		F2FS_CTX_INFO(ctx).unusable_cap_perc = cap;
+		ctx->spec_mask |= F2FS_SPEC_checkpoint_disable_cap_perc;
+		ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOINT);
 		return 0;
 	}
 	case Opt_checkpoint_merge:
-		set_opt(sbi, MERGE_CHECKPOINT);
+		ctx_set_opt(ctx, F2FS_MOUNT_MERGE_CHECKPOINT);
 		return 0;
 	case Opt_nocheckpoint_merge:
-		clear_opt(sbi, MERGE_CHECKPOINT);
+		ctx_clear_opt(ctx, F2FS_MOUNT_MERGE_CHECKPOINT);
 		return 0;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	case Opt_compress_algorithm:
@@ -1142,41 +1295,47 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			return -ENOMEM;
 		if (!strcmp(name, "lzo")) {
 #ifdef CONFIG_F2FS_FS_LZO
-			F2FS_OPTION(sbi).compress_level = 0;
-			F2FS_OPTION(sbi).compress_algorithm =
+			F2FS_CTX_INFO(ctx).compress_level = 0;
+			F2FS_CTX_INFO(ctx).compress_algorithm =
 							COMPRESS_LZO;
+			ctx->spec_mask |= F2FS_SPEC_compress_level;
+			ctx->spec_mask |= F2FS_SPEC_compress_algorithm;
 #else
 			f2fs_info(NULL, "kernel doesn't support lzo compression");
 #endif
 		} else if (!strncmp(name, "lz4", 3)) {
 #ifdef CONFIG_F2FS_FS_LZ4
-			ret = f2fs_set_lz4hc_level(sbi, name);
+			ret = f2fs_set_lz4hc_level(ctx, name);
 			if (ret) {
 				kfree(name);
 				return -EINVAL;
 			}
-			F2FS_OPTION(sbi).compress_algorithm =
+			F2FS_CTX_INFO(ctx).compress_algorithm =
 							COMPRESS_LZ4;
+			ctx->spec_mask |= F2FS_SPEC_compress_algorithm;
 #else
 			f2fs_info(NULL, "kernel doesn't support lz4 compression");
 #endif
 		} else if (!strncmp(name, "zstd", 4)) {
 #ifdef CONFIG_F2FS_FS_ZSTD
-			ret = f2fs_set_zstd_level(sbi, name);
+			ret = f2fs_set_zstd_level(ctx, name);
 			if (ret) {
 				kfree(name);
 				return -EINVAL;
 			}
-			F2FS_OPTION(sbi).compress_algorithm =
+			F2FS_CTX_INFO(ctx).compress_algorithm =
 							COMPRESS_ZSTD;
+			ctx->spec_mask |= F2FS_SPEC_compress_algorithm;
 #else
 			f2fs_info(NULL, "kernel doesn't support zstd compression");
 #endif
 		} else if (!strcmp(name, "lzo-rle")) {
 #ifdef CONFIG_F2FS_FS_LZORLE
-			F2FS_OPTION(sbi).compress_level = 0;
-			F2FS_OPTION(sbi).compress_algorithm =
+			F2FS_CTX_INFO(ctx).compress_level = 0;
+			F2FS_CTX_INFO(ctx).compress_algorithm =
 							COMPRESS_LZORLE;
+			ctx->spec_mask |= F2FS_SPEC_compress_level;
+			ctx->spec_mask |= F2FS_SPEC_compress_algorithm;
 #else
 			f2fs_info(NULL, "kernel doesn't support lzorle compression");
 #endif
@@ -1197,7 +1356,8 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 				"Compress cluster log size is out of range");
 			return -EINVAL;
 		}
-		F2FS_OPTION(sbi).compress_log_size = result.int_32;
+		F2FS_CTX_INFO(ctx).compress_log_size = result.int_32;
+		ctx->spec_mask |= F2FS_SPEC_compress_log_size;
 		return 0;
 	case Opt_compress_extension:
 		if (!f2fs_sb_has_compression(sbi)) {
@@ -1208,8 +1368,8 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (!name)
 			return -ENOMEM;
 
-		ext = F2FS_OPTION(sbi).extensions;
-		ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
+		ext = F2FS_CTX_INFO(ctx).extensions;
+		ext_cnt = F2FS_CTX_INFO(ctx).compress_ext_cnt;
 
 		if (strlen(name) >= F2FS_EXTENSION_LEN ||
 			ext_cnt >= COMPRESS_EXT_NUM) {
@@ -1219,7 +1379,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		}
 
-		if (is_compress_extension_exist(sbi, name, true)) {
+		if (is_compress_extension_exist(&ctx->info, name, true)) {
 			kfree(name);
 			return 0;
 		}
@@ -1229,7 +1389,8 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			kfree(name);
 			return ret;
 		}
-		F2FS_OPTION(sbi).compress_ext_cnt++;
+		F2FS_CTX_INFO(ctx).compress_ext_cnt++;
+		ctx->spec_mask |= F2FS_SPEC_compress_extension;
 		kfree(name);
 		return 0;
 	case Opt_nocompress_extension:
@@ -1241,8 +1402,8 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (!name)
 			return -ENOMEM;
 
-		noext = F2FS_OPTION(sbi).noextensions;
-		noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
+		noext = F2FS_CTX_INFO(ctx).noextensions;
+		noext_cnt = F2FS_CTX_INFO(ctx).nocompress_ext_cnt;
 
 		if (strlen(name) >= F2FS_EXTENSION_LEN ||
 			noext_cnt >= COMPRESS_EXT_NUM) {
@@ -1252,7 +1413,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		}
 
-		if (is_compress_extension_exist(sbi, name, false)) {
+		if (is_compress_extension_exist(&ctx->info, name, false)) {
 			kfree(name);
 			return 0;
 		}
@@ -1262,7 +1423,8 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			kfree(name);
 			return ret;
 		}
-		F2FS_OPTION(sbi).nocompress_ext_cnt++;
+		F2FS_CTX_INFO(ctx).nocompress_ext_cnt++;
+		ctx->spec_mask |= F2FS_SPEC_nocompress_extension;
 		kfree(name);
 		return 0;
 	case Opt_compress_chksum:
@@ -1270,7 +1432,8 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			f2fs_info(NULL, "Image doesn't support compression");
 			return 0;
 		}
-		F2FS_OPTION(sbi).compress_chksum = true;
+		F2FS_CTX_INFO(ctx).compress_chksum = true;
+		ctx->spec_mask |= F2FS_SPEC_compress_chksum;
 		return 0;
 	case Opt_compress_mode:
 		if (!f2fs_sb_has_compression(sbi)) {
@@ -1281,13 +1444,14 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (!name)
 			return -ENOMEM;
 		if (!strcmp(name, "fs")) {
-			F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
+			F2FS_CTX_INFO(ctx).compress_mode = COMPR_MODE_FS;
 		} else if (!strcmp(name, "user")) {
-			F2FS_OPTION(sbi).compress_mode = COMPR_MODE_USER;
+			F2FS_CTX_INFO(ctx).compress_mode = COMPR_MODE_USER;
 		} else {
 			kfree(name);
 			return -EINVAL;
 		}
+		ctx->spec_mask |= F2FS_SPEC_compress_mode;
 		kfree(name);
 		return 0;
 	case Opt_compress_cache:
@@ -1295,7 +1459,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			f2fs_info(NULL, "Image doesn't support compression");
 			return 0;
 		}
-		set_opt(sbi, COMPRESS_CACHE);
+		ctx_set_opt(ctx, F2FS_MOUNT_COMPRESS_CACHE);
 		return 0;
 #else
 	case Opt_compress_algorithm:
@@ -1309,31 +1473,32 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		return 0;
 #endif
 	case Opt_atgc:
-		set_opt(sbi, ATGC);
+		ctx_set_opt(ctx, F2FS_MOUNT_ATGC);
 		return 0;
 	case Opt_gc_merge:
-		set_opt(sbi, GC_MERGE);
+		ctx_set_opt(ctx, F2FS_MOUNT_GC_MERGE);
 		return 0;
 	case Opt_nogc_merge:
-		clear_opt(sbi, GC_MERGE);
+		ctx_clear_opt(ctx, F2FS_MOUNT_GC_MERGE);
 		return 0;
 	case Opt_discard_unit:
 		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
 		if (!name)
 			return -ENOMEM;
 		if (!strcmp(name, "block")) {
-			F2FS_OPTION(sbi).discard_unit =
+			F2FS_CTX_INFO(ctx).discard_unit =
 					DISCARD_UNIT_BLOCK;
 		} else if (!strcmp(name, "segment")) {
-			F2FS_OPTION(sbi).discard_unit =
+			F2FS_CTX_INFO(ctx).discard_unit =
 					DISCARD_UNIT_SEGMENT;
 		} else if (!strcmp(name, "section")) {
-			F2FS_OPTION(sbi).discard_unit =
+			F2FS_CTX_INFO(ctx).discard_unit =
 					DISCARD_UNIT_SECTION;
 		} else {
 			kfree(name);
 			return -EINVAL;
 		}
+		ctx->spec_mask |= F2FS_SPEC_discard_unit;
 		kfree(name);
 		return 0;
 	case Opt_memory_mode:
@@ -1341,37 +1506,39 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (!name)
 			return -ENOMEM;
 		if (!strcmp(name, "normal")) {
-			F2FS_OPTION(sbi).memory_mode =
+			F2FS_CTX_INFO(ctx).memory_mode =
 					MEMORY_MODE_NORMAL;
 		} else if (!strcmp(name, "low")) {
-			F2FS_OPTION(sbi).memory_mode =
+			F2FS_CTX_INFO(ctx).memory_mode =
 					MEMORY_MODE_LOW;
 		} else {
 			kfree(name);
 			return -EINVAL;
 		}
+		ctx->spec_mask |= F2FS_SPEC_memory_mode;
 		kfree(name);
 		return 0;
 	case Opt_age_extent_cache:
-		set_opt(sbi, AGE_EXTENT_CACHE);
+		ctx_set_opt(ctx, F2FS_MOUNT_AGE_EXTENT_CACHE);
 		return 0;
 	case Opt_errors:
 		name = kmemdup_nul(param->string, param->size, GFP_KERNEL);
 		if (!name)
 			return -ENOMEM;
 		if (!strcmp(name, "remount-ro")) {
-			F2FS_OPTION(sbi).errors =
+			F2FS_CTX_INFO(ctx).errors =
 					MOUNT_ERRORS_READONLY;
 		} else if (!strcmp(name, "continue")) {
-			F2FS_OPTION(sbi).errors =
+			F2FS_CTX_INFO(ctx).errors =
 					MOUNT_ERRORS_CONTINUE;
 		} else if (!strcmp(name, "panic")) {
-			F2FS_OPTION(sbi).errors =
+			F2FS_CTX_INFO(ctx).errors =
 					MOUNT_ERRORS_PANIC;
 		} else {
 			kfree(name);
 			return -EINVAL;
 		}
+		ctx->spec_mask |= F2FS_SPEC_errors;
 		kfree(name);
 		return 0;
 	default:
-- 
2.34.1


