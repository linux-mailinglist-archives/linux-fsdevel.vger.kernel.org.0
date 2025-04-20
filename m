Return-Path: <linux-fsdevel+bounces-46805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2698A9524B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9788C18946C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5089334545;
	Mon, 21 Apr 2025 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSiYO3xK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F2F6F30F
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244031; cv=none; b=WN4i1FMTw5a7VJ/Bz/ifbfJVurVEPTN/H7ZfJyBetHVC2gqPF/7LIwpJASK0Gt8iuO59C6GJ5AcCCPTLaRSd13uRwxRABQEQV7ZN8zC7UkYmAWw8s/ynyJyjnfu12hNMBBukoFYWuNhK5C8n5hhwjB/esB9tpgnVRBqXKHldawI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244031; c=relaxed/simple;
	bh=ejyjEhZnw7R/A6UpispbNNW6e1M7gSRpMO+K2rLIiqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sorkDzav8ibU+yAQs0zUPUGxptReK/GhQMSjIwQrWtgKk6287aoow9/Fwg78zAarH89d7YFRg/s31jYKuckkKV1Pl4sV2HDiHeW48dc9zxiGfPpPOBh1oNNuM355SfVPcWCqpoNedhpB4UIEaO/UJNj/UQXS9qcCWwY796foo0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSiYO3xK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745244028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6q1XqAhJKR2J7yq4FGfxf88PoC9IKoSTJKFzw/a7/M=;
	b=jSiYO3xKPq67yTTFvSLotRnTnLgWpJSd+JguyJWkqUmaTqKgpTH3Lj18crkscqXmVL2pu5
	N+10v6Uo+CpDizLbPExlfEnf3+7O3TgZETZm80wQ0CRgF/GNjHyBtEqoUk8CW9T9g/cnC2
	VGTE6Wyb0DERgXr77ckkD2be31Rg+Bc=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-MKF6O43oMkOuWOBsx6hpCw-1; Mon, 21 Apr 2025 10:00:25 -0400
X-MC-Unique: MKF6O43oMkOuWOBsx6hpCw-1
X-Mimecast-MFC-AGG-ID: MKF6O43oMkOuWOBsx6hpCw_1745244025
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d438be189bso34769545ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 07:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745244024; x=1745848824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6q1XqAhJKR2J7yq4FGfxf88PoC9IKoSTJKFzw/a7/M=;
        b=rQ2uLlQp4XK/GWu50k6Oi/pVjvZ4MeSpc7uOpL1JiBNPmTaPfHwiZkKDP5DQey2ScK
         XR/Ohq2tbUXj0kYcvf+E81y/6GaoDWxzlMw+UccwSoqY0M6LL7ZBWr59QTkkBOzIRXFq
         BF1TPaXlOw9yjZ/Rp+7dCfYYh+uOaqBTDu6SRnw8k93SLmLPMKOeguIJ53qKdg1MfABf
         IC/TT80xFEAP5Fx8nuJdoGWolXchZOzLPuTGO7chPyuCKeoICc8/IvQI1IcBOwdHr/hM
         CZWN/T5ikqo0CWEJc+CwH7xHHHqTZyVH9Q+sTlPnDv+U4mvQY5WS0mAlhCi4w+zFGumo
         emxA==
X-Gm-Message-State: AOJu0Yx07LMZiYkUvAtIIASWP9AB3E9zkfD4ZMkclTYDjJZMcNZCTdBc
	t7cJQcgI3IDESH9gh3f3JUcnKHGz1lQfqrbzSXMv7Vw6xOh5gD31vdIivnI/s93GjAcDF/qN/ee
	pYGX4ySaj4anB0/TQoaqXOk/DsrNUtXKivJTtKwsv5hXMK0KkCQYSl1868VRzg3UQDj95qNU=
X-Gm-Gg: ASbGnctFdHu80lnR3Q8+qXVywzMIOFBv39/SuzSomwlir8JrfTPjrA+aX/viDigfGL0
	a9Z1IcJOdJANDJcVtrLvVrbMowa5IEMxmRCrcAshd7BjPfYPgBjsbZ3y9H6+f8yPTw9DHWhDP3U
	6HPC/+me/OTeNn0tStLXPlTcsLGwoWrrqs/T3v+T2UgpK1VYl53MQ4w0Ua/SD8/M+nquiuQb1C3
	+L5/KLlcJCt9yNaPE/PG2rvvy+7dK1XGb25DGu8wqO8HUWdqrOmJRcczLgOJrQI18JaGw14yne4
	4BDj6ol24PZS+0E=
X-Received: by 2002:a05:6e02:1c24:b0:3d6:cbed:330c with SMTP id e9e14a558f8ab-3d88edc110fmr97168265ab.11.1745244024072;
        Mon, 21 Apr 2025 07:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvGeyzxJ+2kAfsYcAx4DViifQ5j+ZnTwB+Ke1Y+GtrJQVFufrBQWEo8m1qEDC/MNdsFu9cyA==
X-Received: by 2002:a05:6e02:1c24:b0:3d6:cbed:330c with SMTP id e9e14a558f8ab-3d88edc110fmr97167895ab.11.1745244023655;
        Mon, 21 Apr 2025 07:00:23 -0700 (PDT)
Received: from fedora.. ([65.128.104.55])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3839336sm1788866173.73.2025.04.21.07.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 07:00:23 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	lihongbo22@huawei.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 7/7] f2fs: switch to the new mount api
Date: Sun, 20 Apr 2025 10:25:06 -0500
Message-ID: <20250420154647.1233033-8-sandeen@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250420154647.1233033-1-sandeen@redhat.com>
References: <20250420154647.1233033-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongbo Li <lihongbo22@huawei.com>

The new mount api will execute .parse_param, .init_fs_context, .get_tree
and will call .remount if remount happened. So we add the necessary
functions for the fs_context_operations. If .init_fs_context is added,
the old .mount should remove.

See Documentation/filesystems/mount_api.rst for more information.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
[sandeen: forward port]
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/f2fs/super.c | 156 +++++++++++++++++++-----------------------------
 1 file changed, 62 insertions(+), 94 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 21042a02459f..28a7aa01d009 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1139,47 +1139,6 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
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
@@ -2579,13 +2538,12 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
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
@@ -2631,7 +2589,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 #endif
 
 	/* recover superblocks we couldn't write due to previous RO mount */
-	if (!(*flags & SB_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
+	if (!(flags & SB_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
 		err = f2fs_commit_super(sbi, false);
 		f2fs_info(sbi, "Try to recover all the superblocks, ret: %d",
 			  err);
@@ -2641,21 +2599,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
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
@@ -2674,20 +2622,20 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
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
@@ -2743,7 +2691,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 
-	if ((*flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
+	if ((flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
 		err = -EINVAL;
 		f2fs_warn(sbi, "disabling checkpoint not compatible with read-only");
 		goto restore_opts;
@@ -2754,7 +2702,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * or if background_gc = off is passed in mount
 	 * option. Also sync the filesystem.
 	 */
-	if ((*flags & SB_RDONLY) ||
+	if ((flags & SB_RDONLY) ||
 			(F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF &&
 			!test_opt(sbi, GC_MERGE))) {
 		if (sbi->gc_thread) {
@@ -2768,7 +2716,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		need_stop_gc = true;
 	}
 
-	if (*flags & SB_RDONLY) {
+	if (flags & SB_RDONLY) {
 		sync_inodes_sb(sb);
 
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
@@ -2781,7 +2729,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * We stop issue flush thread if FS is mounted as RO
 	 * or if flush_merge is not passed in mount option.
 	 */
-	if ((*flags & SB_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
+	if ((flags & SB_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
 		clear_opt(sbi, FLUSH_MERGE);
 		f2fs_destroy_flush_cmd_control(sbi, false);
 		need_restart_flush = true;
@@ -2823,7 +2771,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * triggered while remount and we need to take care of it before
 	 * returning from remount.
 	 */
-	if ((*flags & SB_RDONLY) || test_opt(sbi, DISABLE_CHECKPOINT) ||
+	if ((flags & SB_RDONLY) || test_opt(sbi, DISABLE_CHECKPOINT) ||
 			!test_opt(sbi, MERGE_CHECKPOINT)) {
 		f2fs_stop_ckpt_thread(sbi);
 	} else {
@@ -2850,7 +2798,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
 	limit_reserve_root(sbi);
-	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
+	fc->sb_flags = (flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 
 	sbi->umount_lock_holder = NULL;
 	return 0;
@@ -3519,7 +3467,6 @@ static const struct super_operations f2fs_sops = {
 	.freeze_fs	= f2fs_freeze,
 	.unfreeze_fs	= f2fs_unfreeze,
 	.statfs		= f2fs_statfs,
-	.remount_fs	= f2fs_remount,
 	.shutdown	= f2fs_shutdown,
 };
 
@@ -4741,16 +4688,13 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
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
@@ -4763,9 +4707,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	raw_super = NULL;
 	valid_super_block = -1;
 	recovery = 0;
-	memset(&fc, 0, sizeof(fc));
-	memset(&ctx, 0, sizeof(ctx));
-	fc.fs_private = &ctx;
 
 	/* allocate memory for f2fs-specific super block info */
 	sbi = kzalloc(sizeof(struct f2fs_sb_info), GFP_KERNEL);
@@ -4816,22 +4757,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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
@@ -5156,7 +5087,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		if (err)
 			goto sync_free_meta;
 	}
-	kvfree(options);
 
 	/* recover broken superblock */
 	if (recovery) {
@@ -5251,7 +5181,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		kfree(F2FS_OPTION(sbi).s_qf_names[i]);
 #endif
 	fscrypt_free_dummy_policy(&F2FS_OPTION(sbi).dummy_enc_policy);
-	kvfree(options);
 free_sb_buf:
 	kfree(raw_super);
 free_sbi:
@@ -5267,14 +5196,39 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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
@@ -5318,10 +5272,24 @@ static void kill_f2fs_super(struct super_block *sb)
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
2.47.0


