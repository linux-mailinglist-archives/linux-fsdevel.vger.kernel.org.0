Return-Path: <linux-fsdevel+bounces-54489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E3CB0016E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 14:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9ED31C881E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0D125B1FF;
	Thu, 10 Jul 2025 12:15:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A432505A9
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752149751; cv=none; b=erKnH7Orj+pwUPuW0JeYuQxapOS8sS0uHoH/PlalMzbbYyTx5Ck6A8Hem2wtuO5fCFvzD4S1AbX8suqQdYbGQNLlyi8+iBy/kJ5iJ5IJh6L/wtZTIiKoibhD7GJ3e4ttItZuHXpURN60gAIpOycpb7TRHh4lpnQ1vnF5oVWqwAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752149751; c=relaxed/simple;
	bh=zYjNsp7LnjgPq1tuwq6mR42y7pPTpVUiBUS9K309yb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTkYFaSSHhKFIwGfalGVxTv3Nk2xM+CukebWwgzTOObY3i3zuIsyIVa+LNoKSmq5uzsFAR7avjnWVP6YQwArhRtYLTlHLwj9rmZzLLeIp2LX7nFA3m8yAe+8c/17FRNXs0vlfrN5Honlt7MNydZDZ0rZgzwTJfbkjnsVQJeslq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bdDJQ0Jflz1R8Sc;
	Thu, 10 Jul 2025 20:13:10 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id ABD951402C4;
	Thu, 10 Jul 2025 20:15:44 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Jul
 2025 20:15:44 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>, <sandeen@redhat.com>
Subject: [PATCH v5 4/7] f2fs: Add f2fs_fs_context to record the mount options
Date: Thu, 10 Jul 2025 12:14:12 +0000
Message-ID: <20250710121415.628398-5-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250710121415.628398-1-lihongbo22@huawei.com>
References: <20250710121415.628398-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

At the parsing phase of mouont in the new mount api, options
value will be recorded with the context, and then it will be
used in fill_super and other helpers.

Note that, this is a temporary status, we want remove the sb
and sbi usages in handle_mount_opt. So here the f2fs_fs_context
only records the mount options, it will be copied in sb/sbi in
later process. (At this point in the series, mount options are
temporarily not set during mount.)

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
[sandeen: forward port, minor fixes and updates]
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
[hongbo: minor cleanup]
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/f2fs/super.c | 410 +++++++++++++++++++++++++++---------------------
 1 file changed, 235 insertions(+), 175 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4f0cd790a24e..c84425771f0e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -312,8 +312,56 @@ static match_table_t f2fs_checkpoint_tokens = {
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
 void f2fs_printk(struct f2fs_sb_info *sbi, bool limit_rate,
-						const char *fmt, ...)
+					const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -431,57 +479,51 @@ static void init_once(void *foo)
 #ifdef CONFIG_QUOTA
 static const char * const quotatypes[] = INITQFNAMES;
 #define QTYPE2NAME(t) (quotatypes[t])
-static int f2fs_set_qf_name(struct f2fs_sb_info *sbi, int qtype,
-			    struct fs_parameter *param)
+/*
+ * Note the name of the specified quota file.
+ */
+static int f2fs_note_qf_name(struct fs_context *fc, int qtype,
+			     struct fs_parameter *param)
 {
-	struct super_block *sb = sbi->sb;
+	struct f2fs_fs_context *ctx = fc->fs_private;
 	char *qname;
-	int ret = -EINVAL;
 
-	if (sb_any_quota_loaded(sb) && !F2FS_OPTION(sbi).s_qf_names[qtype]) {
-		f2fs_err(sbi, "Cannot change journaled quota options when quota turned on");
+	if (param->size < 1) {
+		f2fs_err(NULL, "Missing quota name");
 		return -EINVAL;
 	}
-	if (f2fs_sb_has_quota_ino(sbi)) {
-		f2fs_info(sbi, "QUOTA feature is enabled, so ignore qf_name");
+	if (strchr(param->string, '/')) {
+		f2fs_err(NULL, "quotafile must be on filesystem root");
+		return -EINVAL;
+	}
+	if (ctx->info.s_qf_names[qtype]) {
+		if (strcmp(ctx->info.s_qf_names[qtype], param->string) != 0) {
+			f2fs_err(NULL, "Quota file already specified");
+			return -EINVAL;
+		}
 		return 0;
 	}
 
 	qname = kmemdup_nul(param->string, param->size, GFP_KERNEL);
 	if (!qname) {
-		f2fs_err(sbi, "Not enough memory for storing quotafile name");
+		f2fs_err(NULL, "Not enough memory for storing quotafile name");
 		return -ENOMEM;
 	}
-	if (F2FS_OPTION(sbi).s_qf_names[qtype]) {
-		if (strcmp(F2FS_OPTION(sbi).s_qf_names[qtype], qname) == 0)
-			ret = 0;
-		else
-			f2fs_err(sbi, "%s quota file already specified",
-				 QTYPE2NAME(qtype));
-		goto errout;
-	}
-	if (strchr(qname, '/')) {
-		f2fs_err(sbi, "quotafile must be on filesystem root");
-		goto errout;
-	}
-	F2FS_OPTION(sbi).s_qf_names[qtype] = qname;
-	set_opt(sbi, QUOTA);
+	F2FS_CTX_INFO(ctx).s_qf_names[qtype] = qname;
+	ctx->qname_mask |= 1 << qtype;
 	return 0;
-errout:
-	kfree(qname);
-	return ret;
 }
 
-static int f2fs_clear_qf_name(struct f2fs_sb_info *sbi, int qtype)
+/*
+ * Clear the name of the specified quota file.
+ */
+static int f2fs_unnote_qf_name(struct fs_context *fc, int qtype)
 {
-	struct super_block *sb = sbi->sb;
+	struct f2fs_fs_context *ctx = fc->fs_private;
 
-	if (sb_any_quota_loaded(sb) && F2FS_OPTION(sbi).s_qf_names[qtype]) {
-		f2fs_err(sbi, "Cannot change journaled quota options when quota turned on");
-		return -EINVAL;
-	}
-	kfree(F2FS_OPTION(sbi).s_qf_names[qtype]);
-	F2FS_OPTION(sbi).s_qf_names[qtype] = NULL;
+	kfree(ctx->info.s_qf_names[qtype]);
+	ctx->info.s_qf_names[qtype] = NULL;
+	ctx->qname_mask |= 1 << qtype;
 	return 0;
 }
 
@@ -531,54 +573,33 @@ static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
 }
 #endif
 
-static int f2fs_set_test_dummy_encryption(struct f2fs_sb_info *sbi,
-					  const struct fs_parameter *param,
-					  bool is_remount)
+static int f2fs_parse_test_dummy_encryption(const struct fs_parameter *param,
+					    struct f2fs_fs_context *ctx)
 {
-	struct fscrypt_dummy_policy *policy =
-		&F2FS_OPTION(sbi).dummy_enc_policy;
 	int err;
 
 	if (!IS_ENABLED(CONFIG_FS_ENCRYPTION)) {
-		f2fs_warn(sbi, "test_dummy_encryption option not supported");
-		return -EINVAL;
-	}
-
-	if (!f2fs_sb_has_encrypt(sbi)) {
-		f2fs_err(sbi, "Encrypt feature is off");
-		return -EINVAL;
-	}
-
-	/*
-	 * This mount option is just for testing, and it's not worthwhile to
-	 * implement the extra complexity (e.g. RCU protection) that would be
-	 * needed to allow it to be set or changed during remount.  We do allow
-	 * it to be specified during remount, but only if there is no change.
-	 */
-	if (is_remount && !fscrypt_is_dummy_policy_set(policy)) {
-		f2fs_warn(sbi, "Can't set test_dummy_encryption on remount");
+		f2fs_warn(NULL, "test_dummy_encryption option not supported");
 		return -EINVAL;
 	}
-
-	err = fscrypt_parse_test_dummy_encryption(param, policy);
+	err = fscrypt_parse_test_dummy_encryption(param,
+					&ctx->info.dummy_enc_policy);
 	if (err) {
-		if (err == -EEXIST)
-			f2fs_warn(sbi,
-				  "Can't change test_dummy_encryption on remount");
-		else if (err == -EINVAL)
-			f2fs_warn(sbi, "Value of option \"%s\" is unrecognized",
+		if (err == -EINVAL)
+			f2fs_warn(NULL, "Value of option \"%s\" is unrecognized",
 				  param->key);
+		else if (err == -EEXIST)
+			f2fs_warn(NULL, "Conflicting test_dummy_encryption options");
 		else
-			f2fs_warn(sbi, "Error processing option \"%s\" [%d]",
+			f2fs_warn(NULL, "Error processing option \"%s\" [%d]",
 				  param->key, err);
 		return -EINVAL;
 	}
-	f2fs_warn(sbi, "Test dummy encryption mode enabled");
 	return 0;
 }
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-static bool is_compress_extension_exist(struct f2fs_sb_info *sbi,
+static bool is_compress_extension_exist(struct f2fs_mount_info *info,
 					const char *new_ext, bool is_ext)
 {
 	unsigned char (*ext)[F2FS_EXTENSION_LEN];
@@ -586,11 +607,11 @@ static bool is_compress_extension_exist(struct f2fs_sb_info *sbi,
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
@@ -639,58 +660,62 @@ static int f2fs_test_compress_extension(struct f2fs_sb_info *sbi)
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
@@ -698,16 +723,17 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 
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
@@ -715,6 +741,7 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 
 static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 {
+	struct f2fs_fs_context *ctx = fc->fs_private;
 	struct f2fs_sb_info *sbi = fc->s_fs_info;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	unsigned char (*ext)[F2FS_EXTENSION_LEN];
@@ -735,14 +762,15 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 
 	switch (token) {
 	case Opt_gc_background:
-		F2FS_OPTION(sbi).bggc_mode = result.uint_32;
+		F2FS_CTX_INFO(ctx).bggc_mode = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_background_gc;
 		break;
 	case Opt_disable_roll_forward:
-		set_opt(sbi, DISABLE_ROLL_FORWARD);
+		ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_ROLL_FORWARD);
 		break;
 	case Opt_norecovery:
 		/* requires ro mount, checked in f2fs_validate_options */
-		set_opt(sbi, NORECOVERY);
+		ctx_set_opt(ctx, F2FS_MOUNT_NORECOVERY);
 		break;
 	case Opt_discard:
 		if (result.negated) {
@@ -750,13 +778,13 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 				f2fs_warn(NULL, "discard is required for zoned block devices");
 				return -EINVAL;
 			}
-			clear_opt(sbi, DISCARD);
+			ctx_clear_opt(ctx, F2FS_MOUNT_DISCARD);
 		} else {
 			if (!f2fs_hw_support_discard(sbi)) {
 				f2fs_warn(NULL, "device does not support discard");
 				break;
 			}
-			set_opt(sbi, DISCARD);
+			ctx_set_opt(ctx, F2FS_MOUNT_DISCARD);
 		}
 		break;
 	case Opt_noheap:
@@ -766,19 +794,20 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 #ifdef CONFIG_F2FS_FS_XATTR
 	case Opt_user_xattr:
 		if (result.negated)
-			clear_opt(sbi, XATTR_USER);
+			ctx_clear_opt(ctx, F2FS_MOUNT_XATTR_USER);
 		else
-			set_opt(sbi, XATTR_USER);
+			ctx_set_opt(ctx, F2FS_MOUNT_XATTR_USER);
 		break;
 	case Opt_inline_xattr:
 		if (result.negated)
-			clear_opt(sbi, INLINE_XATTR);
+			ctx_clear_opt(ctx, F2FS_MOUNT_INLINE_XATTR);
 		else
-			set_opt(sbi, INLINE_XATTR);
+			ctx_set_opt(ctx, F2FS_MOUNT_INLINE_XATTR);
 		break;
 	case Opt_inline_xattr_size:
-		set_opt(sbi, INLINE_XATTR_SIZE);
-		F2FS_OPTION(sbi).inline_xattr_size = result.int_32;
+		ctx_set_opt(ctx, F2FS_MOUNT_INLINE_XATTR_SIZE);
+		F2FS_CTX_INFO(ctx).inline_xattr_size = result.int_32;
+		ctx->spec_mask |= F2FS_SPEC_inline_xattr_size;
 		break;
 #else
 	case Opt_user_xattr:
@@ -790,9 +819,9 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
 	case Opt_acl:
 		if (result.negated)
-			clear_opt(sbi, POSIX_ACL);
+			ctx_clear_opt(ctx, F2FS_MOUNT_POSIX_ACL);
 		else
-			set_opt(sbi, POSIX_ACL);
+			ctx_set_opt(ctx, F2FS_MOUNT_POSIX_ACL);
 		break;
 #else
 	case Opt_acl:
@@ -803,37 +832,38 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (result.int_32 != 2 && result.int_32 != 4 &&
 			result.int_32 != NR_CURSEG_PERSIST_TYPE)
 			return -EINVAL;
-		F2FS_OPTION(sbi).active_logs = result.int_32;
+		ctx->spec_mask |= F2FS_SPEC_active_logs;
+		F2FS_CTX_INFO(ctx).active_logs = result.int_32;
 		break;
 	case Opt_disable_ext_identify:
-		set_opt(sbi, DISABLE_EXT_IDENTIFY);
+		ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_EXT_IDENTIFY);
 		break;
 	case Opt_inline_data:
 		if (result.negated)
-			clear_opt(sbi, INLINE_DATA);
+			ctx_clear_opt(ctx, F2FS_MOUNT_INLINE_DATA);
 		else
-			set_opt(sbi, INLINE_DATA);
+			ctx_set_opt(ctx, F2FS_MOUNT_INLINE_DATA);
 		break;
 	case Opt_inline_dentry:
 		if (result.negated)
-			clear_opt(sbi, INLINE_DENTRY);
+			ctx_clear_opt(ctx, F2FS_MOUNT_INLINE_DENTRY);
 		else
-			set_opt(sbi, INLINE_DENTRY);
+			ctx_set_opt(ctx, F2FS_MOUNT_INLINE_DENTRY);
 		break;
 	case Opt_flush_merge:
 		if (result.negated)
-			clear_opt(sbi, FLUSH_MERGE);
+			ctx_clear_opt(ctx, F2FS_MOUNT_FLUSH_MERGE);
 		else
-			set_opt(sbi, FLUSH_MERGE);
+			ctx_set_opt(ctx, F2FS_MOUNT_FLUSH_MERGE);
 		break;
 	case Opt_barrier:
 		if (result.negated)
-			set_opt(sbi, NOBARRIER);
+			ctx_set_opt(ctx, F2FS_MOUNT_NOBARRIER);
 		else
-			clear_opt(sbi, NOBARRIER);
+			ctx_clear_opt(ctx, F2FS_MOUNT_NOBARRIER);
 		break;
 	case Opt_fastboot:
-		set_opt(sbi, FASTBOOT);
+		ctx_set_opt(ctx, F2FS_MOUNT_FASTBOOT);
 		break;
 	case Opt_extent_cache:
 		if (result.negated) {
@@ -841,42 +871,50 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 				f2fs_err(sbi, "device aliasing requires extent cache");
 				return -EINVAL;
 			}
-			clear_opt(sbi, READ_EXTENT_CACHE);
+			ctx_clear_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE);
 		} else
-			set_opt(sbi, READ_EXTENT_CACHE);
+			ctx_set_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE);
 		break;
 	case Opt_data_flush:
-		set_opt(sbi, DATA_FLUSH);
+		ctx_set_opt(ctx, F2FS_MOUNT_DATA_FLUSH);
 		break;
 	case Opt_reserve_root:
 		if (test_opt(sbi, RESERVE_ROOT)) {
 			f2fs_info(NULL, "Preserve previous reserve_root=%u",
 				  F2FS_OPTION(sbi).root_reserved_blocks);
 		} else {
-			F2FS_OPTION(sbi).root_reserved_blocks = result.int_32;
-			set_opt(sbi, RESERVE_ROOT);
+			ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
+			F2FS_CTX_INFO(ctx).root_reserved_blocks = result.uint_32;
+			ctx->spec_mask |= F2FS_SPEC_reserve_root;
 		}
 		break;
 	case Opt_resuid:
-		F2FS_OPTION(sbi).s_resuid = result.uid;
+		F2FS_CTX_INFO(ctx).s_resuid = result.uid;
+		ctx->spec_mask |= F2FS_SPEC_resuid;
 		break;
 	case Opt_resgid:
-		F2FS_OPTION(sbi).s_resgid = result.gid;
+		F2FS_CTX_INFO(ctx).s_resgid = result.gid;
+		ctx->spec_mask |= F2FS_SPEC_resgid;
 		break;
 	case Opt_mode:
-		F2FS_OPTION(sbi).fs_mode = result.uint_32;
+		F2FS_CTX_INFO(ctx).fs_mode = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_mode;
 		break;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	case Opt_fault_injection:
 		if (f2fs_build_fault_attr(sbi, result.int_32, 0, FAULT_RATE))
 			return -EINVAL;
-		set_opt(sbi, FAULT_INJECTION);
+		F2FS_CTX_INFO(ctx).fault_info.inject_rate = result.int_32;
+		ctx->spec_mask |= F2FS_SPEC_fault_injection;
+		ctx_set_opt(ctx, F2FS_MOUNT_FAULT_INJECTION);
 		break;
 
 	case Opt_fault_type:
 		if (f2fs_build_fault_attr(sbi, 0, result.int_32, FAULT_TYPE))
 			return -EINVAL;
-		set_opt(sbi, FAULT_INJECTION);
+		F2FS_CTX_INFO(ctx).fault_info.inject_type = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_fault_type;
+		ctx_set_opt(ctx, F2FS_MOUNT_FAULT_INJECTION);
 		break;
 #else
 	case Opt_fault_injection:
@@ -886,55 +924,56 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 #endif
 	case Opt_lazytime:
 		if (result.negated)
-			clear_opt(sbi, LAZYTIME);
+			ctx_clear_opt(ctx, F2FS_MOUNT_LAZYTIME);
 		else
-			set_opt(sbi, LAZYTIME);
+			ctx_set_opt(ctx, F2FS_MOUNT_LAZYTIME);
 		break;
 #ifdef CONFIG_QUOTA
 	case Opt_quota:
 		if (result.negated) {
-			clear_opt(sbi, QUOTA);
-			clear_opt(sbi, USRQUOTA);
-			clear_opt(sbi, GRPQUOTA);
-			clear_opt(sbi, PRJQUOTA);
+			ctx_clear_opt(ctx, F2FS_MOUNT_QUOTA);
+			ctx_clear_opt(ctx, F2FS_MOUNT_USRQUOTA);
+			ctx_clear_opt(ctx, F2FS_MOUNT_GRPQUOTA);
+			ctx_clear_opt(ctx, F2FS_MOUNT_PRJQUOTA);
 		} else
-			set_opt(sbi, USRQUOTA);
+			ctx_set_opt(ctx, F2FS_MOUNT_USRQUOTA);
 		break;
 	case Opt_usrquota:
-		set_opt(sbi, USRQUOTA);
+		ctx_set_opt(ctx, F2FS_MOUNT_USRQUOTA);
 		break;
 	case Opt_grpquota:
-		set_opt(sbi, GRPQUOTA);
+		ctx_set_opt(ctx, F2FS_MOUNT_GRPQUOTA);
 		break;
 	case Opt_prjquota:
-		set_opt(sbi, PRJQUOTA);
+		ctx_set_opt(ctx, F2FS_MOUNT_PRJQUOTA);
 		break;
 	case Opt_usrjquota:
 		if (!*param->string)
-			ret = f2fs_clear_qf_name(sbi, USRQUOTA);
+			ret = f2fs_unnote_qf_name(fc, USRQUOTA);
 		else
-			ret = f2fs_set_qf_name(sbi, USRQUOTA, param);
+			ret = f2fs_note_qf_name(fc, USRQUOTA, param);
 		if (ret)
 			return ret;
 		break;
 	case Opt_grpjquota:
 		if (!*param->string)
-			ret = f2fs_clear_qf_name(sbi, GRPQUOTA);
+			ret = f2fs_unnote_qf_name(fc, GRPQUOTA);
 		else
-			ret = f2fs_set_qf_name(sbi, GRPQUOTA, param);
+			ret = f2fs_note_qf_name(fc, GRPQUOTA, param);
 		if (ret)
 			return ret;
 		break;
 	case Opt_prjjquota:
 		if (!*param->string)
-			ret = f2fs_clear_qf_name(sbi, PRJQUOTA);
+			ret = f2fs_unnote_qf_name(fc, PRJQUOTA);
 		else
-			ret = f2fs_set_qf_name(sbi, PRJQUOTA, param);
+			ret = f2fs_note_qf_name(fc, PRJQUOTA, param);
 		if (ret)
 			return ret;
 		break;
 	case Opt_jqfmt:
-		F2FS_OPTION(sbi).s_jquota_fmt = result.uint_32;
+		F2FS_CTX_INFO(ctx).s_jquota_fmt = result.int_32;
+		ctx->spec_mask |= F2FS_SPEC_jqfmt;
 		break;
 #else
 	case Opt_quota:
@@ -948,19 +987,21 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		break;
 #endif
 	case Opt_alloc:
-		F2FS_OPTION(sbi).alloc_mode = result.uint_32;
+		F2FS_CTX_INFO(ctx).alloc_mode = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_alloc_mode;
 		break;
 	case Opt_fsync:
-		F2FS_OPTION(sbi).fsync_mode = result.uint_32;
+		F2FS_CTX_INFO(ctx).fsync_mode = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_fsync_mode;
 		break;
 	case Opt_test_dummy_encryption:
-		ret = f2fs_set_test_dummy_encryption(sbi, param, is_remount);
+		ret = f2fs_parse_test_dummy_encryption(param, ctx);
 		if (ret)
 			return ret;
 		break;
 	case Opt_inlinecrypt:
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
-		set_opt(sbi, INLINECRYPT);
+		ctx_set_opt(ctx, F2FS_MOUNT_INLINECRYPT);
 #else
 		f2fs_info(NULL, "inline encryption not supported");
 #endif
@@ -981,20 +1022,22 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 				return -EINVAL;
 			if (arg < 0 || arg > 100)
 				return -EINVAL;
-			F2FS_OPTION(sbi).unusable_cap_perc = arg;
-			set_opt(sbi, DISABLE_CHECKPOINT);
+			F2FS_CTX_INFO(ctx).unusable_cap_perc = arg;
+			ctx->spec_mask |= F2FS_SPEC_checkpoint_disable_cap_perc;
+			ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOINT);
 			break;
 		case Opt_checkpoint_disable_cap:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
-			F2FS_OPTION(sbi).unusable_cap = arg;
-			set_opt(sbi, DISABLE_CHECKPOINT);
+			F2FS_CTX_INFO(ctx).unusable_cap = arg;
+			ctx->spec_mask |= F2FS_SPEC_checkpoint_disable_cap;
+			ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOINT);
 			break;
 		case Opt_checkpoint_disable:
-			set_opt(sbi, DISABLE_CHECKPOINT);
+			ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOINT);
 			break;
 		case Opt_checkpoint_enable:
-			clear_opt(sbi, DISABLE_CHECKPOINT);
+			ctx_clear_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOINT);
 			break;
 		default:
 			return -EINVAL;
@@ -1002,9 +1045,9 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_checkpoint_merge:
 		if (result.negated)
-			clear_opt(sbi, MERGE_CHECKPOINT);
+			ctx_clear_opt(ctx, F2FS_MOUNT_MERGE_CHECKPOINT);
 		else
-			set_opt(sbi, MERGE_CHECKPOINT);
+			ctx_set_opt(ctx, F2FS_MOUNT_MERGE_CHECKPOINT);
 		break;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	case Opt_compress_algorithm:
@@ -1015,33 +1058,39 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		name = param->string;
 		if (!strcmp(name, "lzo")) {
 #ifdef CONFIG_F2FS_FS_LZO
-			F2FS_OPTION(sbi).compress_level = 0;
-			F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZO;
+			F2FS_CTX_INFO(ctx).compress_level = 0;
+			F2FS_CTX_INFO(ctx).compress_algorithm = COMPRESS_LZO;
+			ctx->spec_mask |= F2FS_SPEC_compress_level;
+			ctx->spec_mask |= F2FS_SPEC_compress_algorithm;
 #else
 			f2fs_info(NULL, "kernel doesn't support lzo compression");
 #endif
 		} else if (!strncmp(name, "lz4", 3)) {
 #ifdef CONFIG_F2FS_FS_LZ4
-			ret = f2fs_set_lz4hc_level(sbi, name);
+			ret = f2fs_set_lz4hc_level(ctx, name);
 			if (ret)
 				return -EINVAL;
-			F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
+			F2FS_CTX_INFO(ctx).compress_algorithm = COMPRESS_LZ4;
+			ctx->spec_mask |= F2FS_SPEC_compress_algorithm;
 #else
 			f2fs_info(NULL, "kernel doesn't support lz4 compression");
 #endif
 		} else if (!strncmp(name, "zstd", 4)) {
 #ifdef CONFIG_F2FS_FS_ZSTD
-			ret = f2fs_set_zstd_level(sbi, name);
+			ret = f2fs_set_zstd_level(ctx, name);
 			if (ret)
 				return -EINVAL;
-			F2FS_OPTION(sbi).compress_algorithm = COMPRESS_ZSTD;
+			F2FS_CTX_INFO(ctx).compress_algorithm = COMPRESS_ZSTD;
+			ctx->spec_mask |= F2FS_SPEC_compress_algorithm;
 #else
 			f2fs_info(NULL, "kernel doesn't support zstd compression");
 #endif
 		} else if (!strcmp(name, "lzo-rle")) {
 #ifdef CONFIG_F2FS_FS_LZORLE
-			F2FS_OPTION(sbi).compress_level = 0;
-			F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZORLE;
+			F2FS_CTX_INFO(ctx).compress_level = 0;
+			F2FS_CTX_INFO(ctx).compress_algorithm = COMPRESS_LZORLE;
+			ctx->spec_mask |= F2FS_SPEC_compress_level;
+			ctx->spec_mask |= F2FS_SPEC_compress_algorithm;
 #else
 			f2fs_info(NULL, "kernel doesn't support lzorle compression");
 #endif
@@ -1059,7 +1108,8 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 				"Compress cluster log size is out of range");
 			return -EINVAL;
 		}
-		F2FS_OPTION(sbi).compress_log_size = result.uint_32;
+		F2FS_CTX_INFO(ctx).compress_log_size = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_compress_log_size;
 		break;
 	case Opt_compress_extension:
 		if (!f2fs_sb_has_compression(sbi)) {
@@ -1067,8 +1117,8 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			break;
 		}
 		name = param->string;
-		ext = F2FS_OPTION(sbi).extensions;
-		ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
+		ext = F2FS_CTX_INFO(ctx).extensions;
+		ext_cnt = F2FS_CTX_INFO(ctx).compress_ext_cnt;
 
 		if (strlen(name) >= F2FS_EXTENSION_LEN ||
 		    ext_cnt >= COMPRESS_EXT_NUM) {
@@ -1076,13 +1126,14 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		}
 
-		if (is_compress_extension_exist(sbi, name, true))
+		if (is_compress_extension_exist(&ctx->info, name, true))
 			break;
 
 		ret = strscpy(ext[ext_cnt], name, F2FS_EXTENSION_LEN);
 		if (ret < 0)
 			return ret;
-		F2FS_OPTION(sbi).compress_ext_cnt++;
+		F2FS_CTX_INFO(ctx).compress_ext_cnt++;
+		ctx->spec_mask |= F2FS_SPEC_compress_extension;
 		break;
 	case Opt_nocompress_extension:
 		if (!f2fs_sb_has_compression(sbi)) {
@@ -1090,8 +1141,8 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			break;
 		}
 		name = param->string;
-		noext = F2FS_OPTION(sbi).noextensions;
-		noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
+		noext = F2FS_CTX_INFO(ctx).noextensions;
+		noext_cnt = F2FS_CTX_INFO(ctx).nocompress_ext_cnt;
 
 		if (strlen(name) >= F2FS_EXTENSION_LEN ||
 			noext_cnt >= COMPRESS_EXT_NUM) {
@@ -1099,34 +1150,37 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		}
 
-		if (is_compress_extension_exist(sbi, name, false))
+		if (is_compress_extension_exist(&ctx->info, name, false))
 			break;
 
 		ret = strscpy(noext[noext_cnt], name, F2FS_EXTENSION_LEN);
 		if (ret < 0)
 			return ret;
-		F2FS_OPTION(sbi).nocompress_ext_cnt++;
+		F2FS_CTX_INFO(ctx).nocompress_ext_cnt++;
+		ctx->spec_mask |= F2FS_SPEC_nocompress_extension;
 		break;
 	case Opt_compress_chksum:
 		if (!f2fs_sb_has_compression(sbi)) {
 			f2fs_info(NULL, "Image doesn't support compression");
 			break;
 		}
-		F2FS_OPTION(sbi).compress_chksum = true;
+		F2FS_CTX_INFO(ctx).compress_chksum = true;
+		ctx->spec_mask |= F2FS_SPEC_compress_chksum;
 		break;
 	case Opt_compress_mode:
 		if (!f2fs_sb_has_compression(sbi)) {
 			f2fs_info(NULL, "Image doesn't support compression");
 			break;
 		}
-		F2FS_OPTION(sbi).compress_mode = result.uint_32;
+		F2FS_CTX_INFO(ctx).compress_mode = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_compress_mode;
 		break;
 	case Opt_compress_cache:
 		if (!f2fs_sb_has_compression(sbi)) {
 			f2fs_info(NULL, "Image doesn't support compression");
 			break;
 		}
-		set_opt(sbi, COMPRESS_CACHE);
+		ctx_set_opt(ctx, F2FS_MOUNT_COMPRESS_CACHE);
 		break;
 #else
 	case Opt_compress_algorithm:
@@ -1140,28 +1194,31 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		break;
 #endif
 	case Opt_atgc:
-		set_opt(sbi, ATGC);
+		ctx_set_opt(ctx, F2FS_MOUNT_ATGC);
 		break;
 	case Opt_gc_merge:
 		if (result.negated)
-			clear_opt(sbi, GC_MERGE);
+			ctx_clear_opt(ctx, F2FS_MOUNT_GC_MERGE);
 		else
-			set_opt(sbi, GC_MERGE);
+			ctx_set_opt(ctx, F2FS_MOUNT_GC_MERGE);
 		break;
 	case Opt_discard_unit:
-		F2FS_OPTION(sbi).discard_unit = result.uint_32;
+		F2FS_CTX_INFO(ctx).discard_unit = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_discard_unit;
 		break;
 	case Opt_memory_mode:
-		F2FS_OPTION(sbi).memory_mode = result.uint_32;
+		F2FS_CTX_INFO(ctx).memory_mode = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_memory_mode;
 		break;
 	case Opt_age_extent_cache:
-		set_opt(sbi, AGE_EXTENT_CACHE);
+		ctx_set_opt(ctx, F2FS_MOUNT_AGE_EXTENT_CACHE);
 		break;
 	case Opt_errors:
-		F2FS_OPTION(sbi).errors = result.uint_32;
+		F2FS_CTX_INFO(ctx).errors = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_errors;
 		break;
 	case Opt_nat_bits:
-		set_opt(sbi, NAT_BITS);
+		ctx_set_opt(ctx, F2FS_MOUNT_NAT_BITS);
 		break;
 	}
 	return 0;
@@ -1171,6 +1228,7 @@ static int parse_options(struct f2fs_sb_info *sbi, char *options, bool is_remoun
 {
 	struct fs_parameter param;
 	struct fs_context fc;
+	struct f2fs_fs_context ctx;
 	char *key;
 	int ret;
 
@@ -1179,6 +1237,8 @@ static int parse_options(struct f2fs_sb_info *sbi, char *options, bool is_remoun
 
 	memset(&fc, 0, sizeof(fc));
 	fc.s_fs_info = sbi;
+	fc.fs_private = &ctx;
+
 	if (is_remount)
 		fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
 
-- 
2.33.0


