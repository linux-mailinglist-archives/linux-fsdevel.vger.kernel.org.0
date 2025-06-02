Return-Path: <linux-fsdevel+bounces-50297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C59ACAB19
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F98189D7A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428BE1E1DF8;
	Mon,  2 Jun 2025 09:03:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E41A0BFE
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748854982; cv=none; b=kFAuQyYkTiiNsXSxk1B/S2WC3P8SPFYCvcD/tprlMHI+eIK3h4ErjxzmuCl8bS6KnNI9cU8LmiH7xfKLKaCpI1hQHtz2dpQLDIipF8LCkAz589LYPr41UneK2i5xgLkF4g+LIocyXt/TZjb9NefzNEm0LqhkGEbNmbZBqO3JjK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748854982; c=relaxed/simple;
	bh=Q+3yDVoDxozpmBCcTzIjxeP0eBmzI2o+jARDsDNbH3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3Ey3/yHlw5AHmu9CTreFU7I6Vtgf2g3piFUSlr4zv7i0fd+ehk3/FvADyejgp+CwBv440KJQUCb1G2VdsLsfWs2zJEtmZDbNYigzbYxcKsYhNvpewKR2e3rlik8LcWQgzFQHn9ymXSjoATQrwuyzyVp4WUXs6gqLoaiSfGf1G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4b9ns43RP3z1fy42;
	Mon,  2 Jun 2025 17:01:44 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id D3C64140109;
	Mon,  2 Jun 2025 17:02:52 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Jun
 2025 17:02:52 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <sandeen@redhat.com>,
	<lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v4 7/7] f2fs: switch to the new mount api
Date: Mon, 2 Jun 2025 09:02:24 +0000
Message-ID: <20250602090224.485077-8-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250602090224.485077-1-lihongbo22@huawei.com>
References: <20250602090224.485077-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)

The new mount api will execute .parse_param, .init_fs_context, .get_tree
and will call .remount if remount happened. So we add the necessary
functions for the fs_context_operations. If .init_fs_context is added,
the old .mount should remove.

See Documentation/filesystems/mount_api.rst for more information.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
[sandeen: forward port]
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
[hongbo: context modified]
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/f2fs/super.c | 165 ++++++++++++++++++++----------------------------
 1 file changed, 70 insertions(+), 95 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c503b7b92482..0a070dadbb42 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -541,6 +541,14 @@ static int f2fs_unnote_qf_name(struct fs_context *fc, int qtype)
 	ctx->qname_mask |= 1 << qtype;
 	return 0;
 }
+
+static void f2fs_unnote_qf_name_all(struct fs_context *fc)
+{
+	int i;
+
+	for (i = 0; i < MAXQUOTAS; i++)
+		f2fs_unnote_qf_name(fc, i);
+}
 #endif
 
 static int f2fs_parse_test_dummy_encryption(const struct fs_parameter *param,
@@ -1148,47 +1156,6 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
-static int parse_options(struct fs_context *fc, char *options)
-{
-	struct fs_parameter param;
-	char *key;
-	int ret;
-
-	if (!options)
-		return 0;
-
-	while ((key = strsep(&options, ",")) != NULL) {
-		if (*key) {
-			size_t v_len = 0;
-			char *value = strchr(key, '=');
-
-			param.type = fs_value_is_flag;
-			param.string = NULL;
-
-			if (value) {
-				if (value == key)
-					continue;
-
-				*value++ = 0;
-				v_len = strlen(value);
-				param.string = kmemdup_nul(value, v_len, GFP_KERNEL);
-				if (!param.string)
-					return -ENOMEM;
-				param.type = fs_value_is_string;
-			}
-
-			param.key = key;
-			param.size = v_len;
-
-			ret = f2fs_parse_param(fc, &param);
-			kfree(param.string);
-			if (ret < 0)
-				return ret;
-		}
-	}
-	return 0;
-}
-
 /*
  * Check quota settings consistency.
  */
@@ -2628,13 +2595,12 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	f2fs_flush_ckpt_thread(sbi);
 }
 
-static int f2fs_remount(struct super_block *sb, int *flags, char *data)
+static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct f2fs_mount_info org_mount_opt;
-	struct f2fs_fs_context ctx;
-	struct fs_context fc;
 	unsigned long old_sb_flags;
+	unsigned int flags = fc->sb_flags;
 	int err;
 	bool need_restart_gc = false, need_stop_gc = false;
 	bool need_restart_flush = false, need_stop_flush = false;
@@ -2680,7 +2646,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 #endif
 
 	/* recover superblocks we couldn't write due to previous RO mount */
-	if (!(*flags & SB_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
+	if (!(flags & SB_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
 		err = f2fs_commit_super(sbi, false);
 		f2fs_info(sbi, "Try to recover all the superblocks, ret: %d",
 			  err);
@@ -2690,21 +2656,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 	default_options(sbi, true);
 
-	memset(&fc, 0, sizeof(fc));
-	memset(&ctx, 0, sizeof(ctx));
-	fc.fs_private = &ctx;
-	fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
-
-	/* parse mount options */
-	err = parse_options(&fc, data);
+	err = f2fs_check_opt_consistency(fc, sb);
 	if (err)
 		goto restore_opts;
 
-	err = f2fs_check_opt_consistency(&fc, sb);
-	if (err)
-		goto restore_opts;
-
-	f2fs_apply_options(&fc, sb);
+	f2fs_apply_options(fc, sb);
 
 	err = f2fs_sanity_check_options(sbi, true);
 	if (err)
@@ -2717,20 +2673,20 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * Previous and new state of filesystem is RO,
 	 * so skip checking GC and FLUSH_MERGE conditions.
 	 */
-	if (f2fs_readonly(sb) && (*flags & SB_RDONLY))
+	if (f2fs_readonly(sb) && (flags & SB_RDONLY))
 		goto skip;
 
-	if (f2fs_dev_is_readonly(sbi) && !(*flags & SB_RDONLY)) {
+	if (f2fs_dev_is_readonly(sbi) && !(flags & SB_RDONLY)) {
 		err = -EROFS;
 		goto restore_opts;
 	}
 
 #ifdef CONFIG_QUOTA
-	if (!f2fs_readonly(sb) && (*flags & SB_RDONLY)) {
+	if (!f2fs_readonly(sb) && (flags & SB_RDONLY)) {
 		err = dquot_suspend(sb, -1);
 		if (err < 0)
 			goto restore_opts;
-	} else if (f2fs_readonly(sb) && !(*flags & SB_RDONLY)) {
+	} else if (f2fs_readonly(sb) && !(flags & SB_RDONLY)) {
 		/* dquot_resume needs RW */
 		sb->s_flags &= ~SB_RDONLY;
 		if (sb_any_quota_suspended(sb)) {
@@ -2780,7 +2736,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 
-	if ((*flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
+	if ((flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
 		err = -EINVAL;
 		f2fs_warn(sbi, "disabling checkpoint not compatible with read-only");
 		goto restore_opts;
@@ -2791,7 +2747,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * or if background_gc = off is passed in mount
 	 * option. Also sync the filesystem.
 	 */
-	if ((*flags & SB_RDONLY) ||
+	if ((flags & SB_RDONLY) ||
 			(F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF &&
 			!test_opt(sbi, GC_MERGE))) {
 		if (sbi->gc_thread) {
@@ -2805,7 +2761,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		need_stop_gc = true;
 	}
 
-	if (*flags & SB_RDONLY) {
+	if (flags & SB_RDONLY) {
 		sync_inodes_sb(sb);
 
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
@@ -2818,7 +2774,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * We stop issue flush thread if FS is mounted as RO
 	 * or if flush_merge is not passed in mount option.
 	 */
-	if ((*flags & SB_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
+	if ((flags & SB_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
 		clear_opt(sbi, FLUSH_MERGE);
 		f2fs_destroy_flush_cmd_control(sbi, false);
 		need_restart_flush = true;
@@ -2860,7 +2816,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * triggered while remount and we need to take care of it before
 	 * returning from remount.
 	 */
-	if ((*flags & SB_RDONLY) || test_opt(sbi, DISABLE_CHECKPOINT) ||
+	if ((flags & SB_RDONLY) || test_opt(sbi, DISABLE_CHECKPOINT) ||
 			!test_opt(sbi, MERGE_CHECKPOINT)) {
 		f2fs_stop_ckpt_thread(sbi);
 	} else {
@@ -2887,7 +2843,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
 	limit_reserve_root(sbi);
-	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
+	fc->sb_flags = (flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 
 	sbi->umount_lock_holder = NULL;
 	return 0;
@@ -3558,7 +3514,6 @@ static const struct super_operations f2fs_sops = {
 	.freeze_fs	= f2fs_freeze,
 	.unfreeze_fs	= f2fs_unfreeze,
 	.statfs		= f2fs_statfs,
-	.remount_fs	= f2fs_remount,
 	.shutdown	= f2fs_shutdown,
 };
 
@@ -4817,16 +4772,14 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 	sbi->readdir_ra = true;
 }
 
-static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
+static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct f2fs_fs_context *ctx = fc->fs_private;
 	struct f2fs_sb_info *sbi;
 	struct f2fs_super_block *raw_super;
-	struct f2fs_fs_context ctx;
-	struct fs_context fc;
 	struct inode *root;
 	int err;
 	bool skip_recovery = false, need_fsck = false;
-	char *options = NULL;
 	int recovery, i, valid_super_block;
 	struct curseg_info *seg_i;
 	int retry_cnt = 1;
@@ -4839,9 +4792,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	raw_super = NULL;
 	valid_super_block = -1;
 	recovery = 0;
-	memset(&fc, 0, sizeof(fc));
-	memset(&ctx, 0, sizeof(ctx));
-	fc.fs_private = &ctx;
 
 	/* allocate memory for f2fs-specific super block info */
 	sbi = kzalloc(sizeof(struct f2fs_sb_info), GFP_KERNEL);
@@ -4892,22 +4842,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 						 sizeof(raw_super->uuid));
 
 	default_options(sbi, false);
-	/* parse mount options */
-	options = kstrdup((const char *)data, GFP_KERNEL);
-	if (data && !options) {
-		err = -ENOMEM;
-		goto free_sb_buf;
-	}
 
-	err = parse_options(&fc, options);
+	err = f2fs_check_opt_consistency(fc, sb);
 	if (err)
-		goto free_options;
-
-	err = f2fs_check_opt_consistency(&fc, sb);
-	if (err)
-		goto free_options;
+		goto free_sb_buf;
 
-	f2fs_apply_options(&fc, sb);
+	f2fs_apply_options(fc, sb);
 
 	err = f2fs_sanity_check_options(sbi, false);
 	if (err)
@@ -5236,7 +5176,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		if (err)
 			goto sync_free_meta;
 	}
-	kvfree(options);
 
 	/* recover broken superblock */
 	if (recovery) {
@@ -5331,8 +5270,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		kfree(F2FS_OPTION(sbi).s_qf_names[i]);
 #endif
 	/* no need to free dummy_enc_policy, we just keep it in ctx when failed */
-	swap(F2FS_CTX_INFO(&ctx).dummy_enc_policy, F2FS_OPTION(sbi).dummy_enc_policy);
-	kvfree(options);
+	swap(F2FS_CTX_INFO(ctx).dummy_enc_policy, F2FS_OPTION(sbi).dummy_enc_policy);
 free_sb_buf:
 	kfree(raw_super);
 free_sbi:
@@ -5348,14 +5286,37 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	return err;
 }
 
-static struct dentry *f2fs_mount(struct file_system_type *fs_type, int flags,
-			const char *dev_name, void *data)
+static int f2fs_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, f2fs_fill_super);
+}
+
+static int f2fs_reconfigure(struct fs_context *fc)
+{
+	struct super_block *sb = fc->root->d_sb;
+
+	return __f2fs_remount(fc, sb);
+}
+
+static void f2fs_fc_free(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, f2fs_fill_super);
+	struct f2fs_fs_context *ctx = fc->fs_private;
+
+	if (!ctx)
+		return;
+
+#ifdef CONFIG_QUOTA
+	f2fs_unnote_qf_name_all(fc);
+#endif
+	fscrypt_free_dummy_policy(&F2FS_CTX_INFO(ctx).dummy_enc_policy);
+	kfree(ctx);
 }
 
 static const struct fs_context_operations f2fs_context_ops = {
 	.parse_param	= f2fs_parse_param,
+	.get_tree	= f2fs_get_tree,
+	.reconfigure = f2fs_reconfigure,
+	.free	= f2fs_fc_free,
 };
 
 static void kill_f2fs_super(struct super_block *sb)
@@ -5399,10 +5360,24 @@ static void kill_f2fs_super(struct super_block *sb)
 	}
 }
 
+static int f2fs_init_fs_context(struct fs_context *fc)
+{
+	struct f2fs_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct f2fs_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	fc->fs_private = ctx;
+	fc->ops = &f2fs_context_ops;
+
+	return 0;
+}
+
 static struct file_system_type f2fs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "f2fs",
-	.mount		= f2fs_mount,
+	.init_fs_context = f2fs_init_fs_context,
 	.kill_sb	= kill_f2fs_super,
 	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
-- 
2.33.0


