Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7343CBFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 16:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242519AbhJ0OX5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 10:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242533AbhJ0OXZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635344460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R5glgHi3CqkpPxj6W348QTPHuPlNwUn+GVItqkopqW0=;
        b=U8JO01mAvZPNb7RucirpuiTRxH6Fzu8/rZBZcWP6WKFf13XZZCYocpnOgut25H9zyylsVf
        acUnVyjhXU9amGaKMK4xnrtyDpzSg/0Ri/cIDGOpqr1D4jksRadHcv4u8VpoEPJUfj3Qr9
        7s4x9kfvj86RRNhsh20rkK40y9LmXPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-QnL5ntvkNMmhzNOk1-q-2w-1; Wed, 27 Oct 2021 10:20:56 -0400
X-MC-Unique: QnL5ntvkNMmhzNOk1-q-2w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDAD88C2672;
        Wed, 27 Oct 2021 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9433E5DF35;
        Wed, 27 Oct 2021 14:20:51 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v4 12/13] ext4: switch to the new mount api
Date:   Wed, 27 Oct 2021 16:18:56 +0200
Message-Id: <20211027141857.33657-13-lczerner@redhat.com>
In-Reply-To: <20211027141857.33657-1-lczerner@redhat.com>
References: <20211027141857.33657-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the necessary functions for the fs_context_operations. Convert and
rename ext4_remount() and ext4_fill_super() to ext4_get_tree() and
ext4_reconfigure() respectively and switch the ext4 to use the new api.

One user facing change is the fact that we no longer have access to the
entire string of mount options provided by mount(2) since the mount api
does not store it anywhere. As a result we can't print the options to
the log as we did in the past after the successful mount.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ext4/super.c | 195 +++++++++++++++++++++---------------------------
 1 file changed, 86 insertions(+), 109 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 67efe9c6b9e8..55552b37bea2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -74,12 +74,9 @@ static int ext4_mark_recovery_complete(struct super_block *sb,
 static int ext4_clear_journal_err(struct super_block *sb,
 				  struct ext4_super_block *es);
 static int ext4_sync_fs(struct super_block *sb, int wait);
-static int ext4_remount(struct super_block *sb, int *flags, char *data);
 static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int ext4_unfreeze(struct super_block *sb);
 static int ext4_freeze(struct super_block *sb);
-static struct dentry *ext4_mount(struct file_system_type *fs_type, int flags,
-		       const char *dev_name, void *data);
 static inline int ext2_feature_set_ok(struct super_block *sb);
 static inline int ext3_feature_set_ok(struct super_block *sb);
 static void ext4_destroy_lazyinit_thread(void);
@@ -92,6 +89,11 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
 				      struct super_block *sb);
 static int ext4_apply_options(struct fs_context *fc, struct super_block *sb);
 static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param);
+static int ext4_get_tree(struct fs_context *fc);
+static int ext4_reconfigure(struct fs_context *fc);
+static void ext4_fc_free(struct fs_context *fc);
+static int ext4_init_fs_context(struct fs_context *fc);
+static const struct fs_parameter_spec ext4_param_specs[];
 
 /*
  * Lock ordering
@@ -121,16 +123,20 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param);
 
 static const struct fs_context_operations ext4_context_ops = {
 	.parse_param	= ext4_parse_param,
+	.get_tree	= ext4_get_tree,
+	.reconfigure	= ext4_reconfigure,
+	.free		= ext4_fc_free,
 };
 
 
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defined(CONFIG_EXT4_USE_FOR_EXT2)
 static struct file_system_type ext2_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "ext2",
-	.mount		= ext4_mount,
-	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.owner			= THIS_MODULE,
+	.name			= "ext2",
+	.init_fs_context	= ext4_init_fs_context,
+	.parameters		= ext4_param_specs,
+	.kill_sb		= kill_block_super,
+	.fs_flags		= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext2");
 MODULE_ALIAS("ext2");
@@ -141,11 +147,12 @@ MODULE_ALIAS("ext2");
 
 
 static struct file_system_type ext3_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "ext3",
-	.mount		= ext4_mount,
-	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.owner			= THIS_MODULE,
+	.name			= "ext3",
+	.init_fs_context	= ext4_init_fs_context,
+	.parameters		= ext4_param_specs,
+	.kill_sb		= kill_block_super,
+	.fs_flags		= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext3");
 MODULE_ALIAS("ext3");
@@ -1658,7 +1665,6 @@ static const struct super_operations ext4_sops = {
 	.freeze_fs	= ext4_freeze,
 	.unfreeze_fs	= ext4_unfreeze,
 	.statfs		= ext4_statfs,
-	.remount_fs	= ext4_remount,
 	.show_options	= ext4_show_options,
 #ifdef CONFIG_QUOTA
 	.quota_read	= ext4_quota_read,
@@ -2196,6 +2202,35 @@ struct ext4_fs_context {
 	ext4_fsblk_t	s_sb_block;
 };
 
+static void ext4_fc_free(struct fs_context *fc)
+{
+	struct ext4_fs_context *ctx = fc->fs_private;
+	int i;
+
+	if (!ctx)
+		return;
+
+	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+		kfree(ctx->s_qf_names[i]);
+
+	kfree(ctx->test_dummy_enc_arg);
+	kfree(ctx);
+}
+
+int ext4_init_fs_context(struct fs_context *fc)
+{
+	struct xfs_fs_context	*ctx;
+
+	ctx = kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	fc->fs_private = ctx;
+	fc->ops = &ext4_context_ops;
+
+	return 0;
+}
+
 #ifdef CONFIG_QUOTA
 /*
  * Note the name of the specified quota file.
@@ -5596,61 +5631,31 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb,
 	return err ? err : ret;
 }
 
-static void cleanup_ctx(struct ext4_fs_context *ctx)
+static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)
 {
-	int i;
-
-	if (!ctx)
-		return;
-
-	for (i = 0; i < EXT4_MAXQUOTAS; i++) {
-		kfree(ctx->s_qf_names[i]);
-	}
-
-	kfree(ctx->test_dummy_enc_arg);
-}
-
-static int ext4_fill_super(struct super_block *sb, void *data, int silent)
-{
-	struct ext4_fs_context ctx;
+	struct ext4_fs_context *ctx = fc->fs_private;
 	struct ext4_sb_info *sbi;
-	struct fs_context fc;
 	const char *descr;
-	char *orig_data;
-	int ret = -ENOMEM;
-
-	orig_data = kstrdup(data, GFP_KERNEL);
-	if (data && !orig_data)
-		return -ENOMEM;
-
-	/* Cleanup superblock name */
-	strreplace(sb->s_id, '/', '!');
-
-	memset(&fc, 0, sizeof(fc));
-	memset(&ctx, 0, sizeof(ctx));
-	fc.fs_private = &ctx;
-
-	ret = parse_options(&fc, (char *) data);
-	if (ret < 0)
-		goto free_data;
+	int ret;
 
 	sbi = ext4_alloc_sbi(sb);
-	if (!sbi) {
+	if (!sbi)
 		ret = -ENOMEM;
-		goto free_data;
-	}
 
-	fc.s_fs_info = sbi;
+	fc->s_fs_info = sbi;
+
+	/* Cleanup superblock name */
+	strreplace(sb->s_id, '/', '!');
 
 	sbi->s_sb_block = 1;	/* Default super block location */
-	if (ctx.spec & EXT4_SPEC_s_sb_block)
-		sbi->s_sb_block = ctx.s_sb_block;
+	if (ctx->spec & EXT4_SPEC_s_sb_block)
+		sbi->s_sb_block = ctx->s_sb_block;
 
-	ret = __ext4_fill_super(&fc, sb, silent);
+	ret = __ext4_fill_super(fc, sb, fc->sb_flags & SB_SILENT);
 	if (ret < 0)
 		goto free_sbi;
 
-	if (EXT4_SB(sb)->s_journal) {
+	if (sbi->s_journal) {
 		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
 			descr = " journalled data mode";
 		else if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
@@ -5662,23 +5667,21 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
 	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
 		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
-			 "Opts: %.*s%s%s. Quota mode: %s.", descr,
-			 (int) sizeof(sbi->s_es->s_mount_opts),
-			 sbi->s_es->s_mount_opts,
-			 *sbi->s_es->s_mount_opts ? "; " : "", orig_data,
-			 ext4_quota_mode(sb));
-
-	kfree(orig_data);
-	cleanup_ctx(&ctx);
+			 "Quota mode: %s.", descr, ext4_quota_mode(sb));
+
 	return 0;
+
 free_sbi:
 	ext4_free_sbi(sbi);
-free_data:
-	kfree(orig_data);
-	cleanup_ctx(&ctx);
+	fc->s_fs_info = NULL;
 	return ret;
 }
 
+static int ext4_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, ext4_fill_super);
+}
+
 /*
  * Setup any per-fs journal parameters now.  We'll do this both on
  * initial mount, once the journal has been initialised but before we've
@@ -6601,47 +6604,26 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb,
 	return err;
 }
 
-static int ext4_remount(struct super_block *sb, int *flags, char *data)
+static int ext4_reconfigure(struct fs_context *fc)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct ext4_fs_context ctx;
-	struct fs_context fc;
-	char *orig_data;
+	struct super_block *sb = fc->root->d_sb;
+	int flags = fc->sb_flags;
 	int ret;
 
-	orig_data = kstrdup(data, GFP_KERNEL);
-	if (data && !orig_data)
-		return -ENOMEM;
-
-	memset(&fc, 0, sizeof(fc));
-	memset(&ctx, 0, sizeof(ctx));
+	fc->s_fs_info = EXT4_SB(sb);
 
-	fc.fs_private = &ctx;
-	fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
-	fc.s_fs_info = sbi;
-
-	ret = parse_options(&fc, (char *) data);
+	ret = ext4_check_opt_consistency(fc, sb);
 	if (ret < 0)
-		goto err_out;
+		return ret;
 
-	ret = ext4_check_opt_consistency(&fc, sb);
+	ret = __ext4_remount(fc, sb, &flags);
 	if (ret < 0)
-		goto err_out;
+		return ret;
 
-	ret = __ext4_remount(&fc, sb, flags);
-	if (ret < 0)
-		goto err_out;
+	ext4_msg(sb, KERN_INFO, "re-mounted. Quota mode: %s.",
+		 ext4_quota_mode(sb));
 
-	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s. Quota mode: %s.",
-		 orig_data, ext4_quota_mode(sb));
-	cleanup_ctx(&ctx);
-	kfree(orig_data);
 	return 0;
-
-err_out:
-	cleanup_ctx(&ctx);
-	kfree(orig_data);
-	return ret;
 }
 
 #ifdef CONFIG_QUOTA
@@ -7126,12 +7108,6 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 }
 #endif
 
-static struct dentry *ext4_mount(struct file_system_type *fs_type, int flags,
-		       const char *dev_name, void *data)
-{
-	return mount_bdev(fs_type, flags, dev_name, data, ext4_fill_super);
-}
-
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defined(CONFIG_EXT4_USE_FOR_EXT2)
 static inline void register_as_ext2(void)
 {
@@ -7189,11 +7165,12 @@ static inline int ext3_feature_set_ok(struct super_block *sb)
 }
 
 static struct file_system_type ext4_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "ext4",
-	.mount		= ext4_mount,
-	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.owner			= THIS_MODULE,
+	.name			= "ext4",
+	.init_fs_context	= ext4_init_fs_context,
+	.parameters		= ext4_param_specs,
+	.kill_sb		= kill_block_super,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("ext4");
 
-- 
2.31.1

