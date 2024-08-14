Return-Path: <linux-fsdevel+bounces-25862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D3F95127B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBCC1C20F1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B59376E0;
	Wed, 14 Aug 2024 02:32:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81F1CD00
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602764; cv=none; b=mk83JcLzU70HmdwiuoWxZSZMGymox4UH+VWvwkmoLajFotLULN7GA8lCpoUmfuthwcSPSwsWYMu6/OKVCym0/8ZsEuWGOBNQwgInwdH958+o/nN6IH+evFseEip+HMOByMXaXB1EsOhRb5TjQghbyx4dUm7cTBtvlPidaaqXW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602764; c=relaxed/simple;
	bh=ZW/Z6Bx5kTxKdTgQ32ntK2goPrLH/3AONLBEOZw6ECg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zi1R8wzTAXqkEdQpdmuTXtGdSsUQU4qZvOo6hk3ighx+tGpA0CiywIC4rgBzKvclLR1TW45TOvz7BZBZ1zyrOAOu2xC0TWYJmO2Y8r2LVYIbaIvzFmEjdU/8tN4GXTfLx+zYpXh++bc9s4oghy7vEkXWYRNXwa1LfAEbWM4cCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WkC0f62CyzfbQk;
	Wed, 14 Aug 2024 10:30:42 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id DFF4F180088;
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
Subject: [PATCH 8/9] f2fs: switch to the new mount api
Date: Wed, 14 Aug 2024 10:39:11 +0800
Message-ID: <20240814023912.3959299-9-lihongbo22@huawei.com>
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

The new mount api will excute .parse_param, .init_fs_context, .get_tree
and will call .remount if remount happened. So we add the necessary
functions for the fs_context_operations. If .init_fs_context is added,
the old .mount should remove.

See Documentation/filesystems/mount_api.rst for more information.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/f2fs/super.c | 125 ++++++++++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 53 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8c43fbe092ff..86acb7354d95 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2953,13 +2953,12 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
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
@@ -2976,6 +2975,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	int i, j;
 #endif
 
+	/* check the mount options legality in ctx first */
+	err = f2fs_validate_options(fc);
+	if (err)
+		return -EINVAL;
+
 	/*
 	 * Save the old mount options in case we
 	 * need to restore them.
@@ -3002,7 +3006,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 #endif
 
 	/* recover superblocks we couldn't write due to previous RO mount */
-	if (!(*flags & SB_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
+	if (!(flags & SB_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
 		err = f2fs_commit_super(sbi, false);
 		f2fs_info(sbi, "Try to recover all the superblocks, ret: %d",
 			  err);
@@ -3012,21 +3016,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 	default_options(sbi, true);
 
-	memset(&fc, 0, sizeof(fc));
-	memset(&ctx, 0, sizeof(ctx));
-	fc.fs_private = &ctx;
-	fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
-
-	/* parse mount options */
-	err = parse_options(&fc, data);
-	if (err)
-		goto restore_opts;
-
-	err = f2fs_check_opt_consistency(&fc, sb);
+	err = f2fs_check_opt_consistency(fc, sb);
 	if (err < 0)
 		goto restore_opts;
 
-	f2fs_apply_options(&fc, sb);
+	f2fs_apply_options(fc, sb);
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	if (f2fs_sb_has_blkzoned(sbi) &&
@@ -3046,20 +3040,20 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
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
@@ -3109,7 +3103,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 
-	if ((*flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
+	if ((flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
 		err = -EINVAL;
 		f2fs_warn(sbi, "disabling checkpoint not compatible with read-only");
 		goto restore_opts;
@@ -3120,7 +3114,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * or if background_gc = off is passed in mount
 	 * option. Also sync the filesystem.
 	 */
-	if ((*flags & SB_RDONLY) ||
+	if ((flags & SB_RDONLY) ||
 			(F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF &&
 			!test_opt(sbi, GC_MERGE))) {
 		if (sbi->gc_thread) {
@@ -3134,7 +3128,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		need_stop_gc = true;
 	}
 
-	if (*flags & SB_RDONLY) {
+	if (flags & SB_RDONLY) {
 		sync_inodes_sb(sb);
 
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
@@ -3147,7 +3141,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * We stop issue flush thread if FS is mounted as RO
 	 * or if flush_merge is not passed in mount option.
 	 */
-	if ((*flags & SB_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
+	if ((flags & SB_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
 		clear_opt(sbi, FLUSH_MERGE);
 		f2fs_destroy_flush_cmd_control(sbi, false);
 		need_restart_flush = true;
@@ -3188,7 +3182,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * triggered while remount and we need to take care of it before
 	 * returning from remount.
 	 */
-	if ((*flags & SB_RDONLY) || test_opt(sbi, DISABLE_CHECKPOINT) ||
+	if ((flags & SB_RDONLY) || test_opt(sbi, DISABLE_CHECKPOINT) ||
 			!test_opt(sbi, MERGE_CHECKPOINT)) {
 		f2fs_stop_ckpt_thread(sbi);
 	} else {
@@ -3216,7 +3210,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 	limit_reserve_root(sbi);
 	adjust_unusable_cap_perc(sbi);
-	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
+	fc->sb_flags = (flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 	return 0;
 restore_checkpoint:
 	if (need_enable_checkpoint) {
@@ -3863,7 +3857,6 @@ static const struct super_operations f2fs_sops = {
 	.freeze_fs	= f2fs_freeze,
 	.unfreeze_fs	= f2fs_unfreeze,
 	.statfs		= f2fs_statfs,
-	.remount_fs	= f2fs_remount,
 	.shutdown	= f2fs_shutdown,
 };
 
@@ -5047,16 +5040,13 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 	sbi->readdir_ra = true;
 }
 
-static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
+static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
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
@@ -5069,9 +5059,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	raw_super = NULL;
 	valid_super_block = -1;
 	recovery = 0;
-	memset(&fc, 0, sizeof(fc));
-	memset(&ctx, 0, sizeof(ctx));
-	fc.fs_private = &ctx;
+
+	/* check the mount options legality in ctx first */
+	err = f2fs_validate_options(fc);
+	if (err)
+		return -EINVAL;
 
 	/* allocate memory for f2fs-specific super block info */
 	sbi = kzalloc(sizeof(struct f2fs_sb_info), GFP_KERNEL);
@@ -5131,22 +5123,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 						sizeof(raw_super->uuid));
 
 	default_options(sbi, false);
-	/* parse mount options */
-	options = kstrdup((const char *)data, GFP_KERNEL);
-	if (data && !options) {
-		err = -ENOMEM;
-		goto free_sb_buf;
-	}
-
-	err = parse_options(&fc, options);
-	if (err)
-		goto free_options;
 
-	err = f2fs_check_opt_consistency(&fc, sb);
+	err = f2fs_check_opt_consistency(fc, sb);
 	if (err < 0)
-		goto free_options;
+		goto free_sb_buf;
 
-	f2fs_apply_options(&fc, sb);
+	f2fs_apply_options(fc, sb);
 
 	sb->s_maxbytes = max_file_blocks(NULL) <<
 				le32_to_cpu(raw_super->log_blocksize);
@@ -5460,7 +5442,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		if (err)
 			goto sync_free_meta;
 	}
-	kvfree(options);
 
 	/* recover broken superblock */
 	if (recovery) {
@@ -5553,7 +5534,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		kfree(F2FS_OPTION(sbi).s_qf_names[i]);
 #endif
 	fscrypt_free_dummy_policy(&F2FS_OPTION(sbi).dummy_enc_policy);
-	kvfree(options);
 free_sb_buf:
 	kfree(raw_super);
 free_sbi:
@@ -5571,14 +5551,39 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	return err;
 }
 
-static struct dentry *f2fs_mount(struct file_system_type *fs_type, int flags,
-			const char *dev_name, void *data)
+static int f2fs_get_tree(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, f2fs_fill_super);
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
+{
+	struct f2fs_fs_context *ctx = fc->fs_private;
+	int i;
+
+	if (!ctx)
+		return;
+
+#ifdef CONFIG_QUOTA
+	for (i = 0; i < MAXQUOTAS; i++)
+		kfree(F2FS_CTX_INFO(ctx).s_qf_names[i]);
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
@@ -5620,10 +5625,24 @@ static void kill_f2fs_super(struct super_block *sb)
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
2.34.1


