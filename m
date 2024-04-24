Return-Path: <linux-fsdevel+bounces-17660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64A28B1265
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 20:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311B41F250A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 18:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D241791FC;
	Wed, 24 Apr 2024 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1l7dwRF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350EE16E88D;
	Wed, 24 Apr 2024 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983245; cv=none; b=WvKzZBY44ygNSJzVQqOSNSd+vwHwnLwRU9I9FojbIJfuHQvMC+N96J5KmnADBP6NxZLaZF3+qAUQiwjRdYaKJbqaoLgu5sVMJ/5HVA3qGy+h8YjuNuIphv0NCSv0eE2+XfATp1t4LB+DItSPSeCJwaij0drv71zu76GmpWTIstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983245; c=relaxed/simple;
	bh=Icat3W7wsXivUho2TNiHdiOd0vRaNw09lXS4cPFxcB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kbcs8RyUmn0WoVHcERPLjWJbyKYYC+8s5SgzQgpKSpUUEMEmfMz6VC0RZ6t46Qjp3sDkH4xEdRvMmGSgfdXk9+Vfjnp8iKjVgWTigekddBMLCKDghLCEU2rdDhofswYqJFN2RVLzylv8uQ+Y1Yj5gKwNOIn6dtDwymWcO/Alw0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1l7dwRF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so243488b3a.0;
        Wed, 24 Apr 2024 11:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713983242; x=1714588042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gllD3V+9UonJLQlKKZQX9a1vPvnXC9F7uFXx0nrGAwo=;
        b=J1l7dwRFPKPZHMj8LnU5ixIckku5dyvvVxWMo+2t5+JF4+8grTDfGc+3kMk4iuBWm3
         MfeKaZNo8phTNYjlj0/yTHUDCe+2IlAuXmHkH9rWAyQbx3Gg2FSKHrDEDH7nGuLpyQ/H
         ohxulR5c0xcpA72pbdzSpWw8IM0VF7L3BSsmBywVLYtmwzzkRquqka+Xp6fgydgGeVJw
         FMdVTQVBmwOXh1SXyVQFq+DG5Lt7k3r8dHsXEO2zwSJ6BktEqeVC1pjNBFAY49UTGFco
         zZNUejJ4PoqZSCm7WG85phU1bM/uic39Q63fm1F2tNPxMcmA+TNiBU1dAgDIi6DUIhO2
         131w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713983242; x=1714588042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gllD3V+9UonJLQlKKZQX9a1vPvnXC9F7uFXx0nrGAwo=;
        b=jdZvw+QCwExCT7GXeEMpIhkirOJ88P0/N8hGF2tfDjAvRx1ZVR31pRupYYx/4M83WS
         96ji1osFwUu/wU/KYMagSYWaoKcUKpzDNtvslKXSrqrRD6/zhCApOklIMogqkoTyI38l
         zzBOsF0ZQe2wDfzFnTAiEcNBTWKN/CQSrvxG7PovgQ0kpKN5We+h7y0iP3OfLDijmP8u
         PvaIGc6ZfEdBUHk9ciJvtS7BfFdvsmF0Ygs3BYRPr150CIk2CDDVlPQ8zl6Zr2RjUYTo
         yWy7fxh17lwieV+nweI3PcFajd15P78ZPm32L1zVLEbhhR5Wtg+jFd0wdngNt9ptDr+k
         3HEA==
X-Forwarded-Encrypted: i=1; AJvYcCWBTqxFXOHIgli0LYSIPiXZYdlWrZ6/xMRPhJqZyM+gZAzWks4f76n1JnYLH8YbImPWh5+6193hwrrIi69TgfqVjgqcNoEZUM0d4e2d5L6EvvUlu6o1tW/7FHw6X0w9IH9/d+diekbWVYNwmQ==
X-Gm-Message-State: AOJu0YyrigjdKQqFOysJCjLaEHfr50/E4ZAYGYF/X6JOMbyK+5iw9/jd
	oq2GlgV5leJDyCAvkBtuYVhBgPDaVcpV7iyxbOMuRxTdPUKrdcnjLIXhOiD1
X-Google-Smtp-Source: AGHT+IGM64+wK/U1/kGzEYF21QZbH4l2q/tDZG7KAlOD0Pqy2J3QlGaM3AqHhakH91hRO+fCMzW/Tg==
X-Received: by 2002:a05:6a20:2e16:b0:1ad:e38:5472 with SMTP id be22-20020a056a202e1600b001ad0e385472mr2772094pzb.35.1713983242304;
        Wed, 24 Apr 2024 11:27:22 -0700 (PDT)
Received: from carrot.. (i223-218-108-246.s42.a014.ap.plala.or.jp. [223.218.108.246])
        by smtp.gmail.com with ESMTPSA id fi33-20020a056a0039a100b006e65d66bb3csm11746376pfb.21.2024.04.24.11.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:27:21 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] nilfs2: convert to use the new mount API
Date: Thu, 25 Apr 2024 03:27:16 +0900
Message-Id: <20240424182716.6024-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Sandeen <sandeen@redhat.com>

Convert nilfs2 to use the new mount API.

[konishi.ryusuke: fixed missing SB_RDONLY flag repair in nilfs_reconfigure]
Link: https://lkml.kernel.org/r/33d078a7-9072-4d8e-a3a9-dec23d4191da@redhat.com
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Hi Andrew, please add this to the queue for the next merge window.

As the title suggests, this patch transforms the implementation around
nilfs2 mount/remount, so I reviewed all changes and tested all mount
options and nilfs2-specific mount patterns (such as simultaneous
mounting of snapshots and current tree).  This one passed those checks.

Thanks,
Ryusuke Konishi

 fs/nilfs2/nilfs.h     |   4 +-
 fs/nilfs2/super.c     | 374 ++++++++++++++++++------------------------
 fs/nilfs2/the_nilfs.c |   4 +-
 fs/nilfs2/the_nilfs.h |   6 +-
 4 files changed, 164 insertions(+), 224 deletions(-)

diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 2e29b98ba8ba..728e90be3570 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -335,8 +335,8 @@ void __nilfs_error(struct super_block *sb, const char *function,
 
 extern struct nilfs_super_block *
 nilfs_read_super_block(struct super_block *, u64, int, struct buffer_head **);
-extern int nilfs_store_magic_and_option(struct super_block *,
-					struct nilfs_super_block *, char *);
+extern int nilfs_store_magic(struct super_block *sb,
+			     struct nilfs_super_block *sbp);
 extern int nilfs_check_feature_compatibility(struct super_block *,
 					     struct nilfs_super_block *);
 extern void nilfs_set_log_cursor(struct nilfs_super_block *,
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index ac24ed109ce9..55667ab6706d 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -29,7 +29,8 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/crc32.h>
 #include <linux/vfs.h>
 #include <linux/writeback.h>
@@ -61,7 +62,6 @@ struct kmem_cache *nilfs_segbuf_cachep;
 struct kmem_cache *nilfs_btree_path_cache;
 
 static int nilfs_setup_super(struct super_block *sb, int is_mount);
-static int nilfs_remount(struct super_block *sb, int *flags, char *data);
 
 void __nilfs_msg(struct super_block *sb, const char *fmt, ...)
 {
@@ -702,105 +702,98 @@ static const struct super_operations nilfs_sops = {
 	.freeze_fs	= nilfs_freeze,
 	.unfreeze_fs	= nilfs_unfreeze,
 	.statfs         = nilfs_statfs,
-	.remount_fs     = nilfs_remount,
 	.show_options = nilfs_show_options
 };
 
 enum {
-	Opt_err_cont, Opt_err_panic, Opt_err_ro,
-	Opt_barrier, Opt_nobarrier, Opt_snapshot, Opt_order, Opt_norecovery,
-	Opt_discard, Opt_nodiscard, Opt_err,
+	Opt_err, Opt_barrier, Opt_snapshot, Opt_order, Opt_norecovery,
+	Opt_discard,
 };
 
-static match_table_t tokens = {
-	{Opt_err_cont, "errors=continue"},
-	{Opt_err_panic, "errors=panic"},
-	{Opt_err_ro, "errors=remount-ro"},
-	{Opt_barrier, "barrier"},
-	{Opt_nobarrier, "nobarrier"},
-	{Opt_snapshot, "cp=%u"},
-	{Opt_order, "order=%s"},
-	{Opt_norecovery, "norecovery"},
-	{Opt_discard, "discard"},
-	{Opt_nodiscard, "nodiscard"},
-	{Opt_err, NULL}
+static const struct constant_table nilfs_param_err[] = {
+	{"continue",	NILFS_MOUNT_ERRORS_CONT},
+	{"panic",	NILFS_MOUNT_ERRORS_PANIC},
+	{"remount-ro",	NILFS_MOUNT_ERRORS_RO},
+	{}
 };
 
-static int parse_options(char *options, struct super_block *sb, int is_remount)
-{
-	struct the_nilfs *nilfs = sb->s_fs_info;
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-
-	if (!options)
-		return 1;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
+static const struct fs_parameter_spec nilfs_param_spec[] = {
+	fsparam_enum	("errors", Opt_err, nilfs_param_err),
+	fsparam_flag_no	("barrier", Opt_barrier),
+	fsparam_u64	("cp", Opt_snapshot),
+	fsparam_string	("order", Opt_order),
+	fsparam_flag	("norecovery", Opt_norecovery),
+	fsparam_flag_no	("discard", Opt_discard),
+	{}
+};
 
-		if (!*p)
-			continue;
+struct nilfs_fs_context {
+	unsigned long ns_mount_opt;
+	__u64 cno;
+};
 
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_barrier:
-			nilfs_set_opt(nilfs, BARRIER);
-			break;
-		case Opt_nobarrier:
+static int nilfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct nilfs_fs_context *nilfs = fc->fs_private;
+	int is_remount = fc->purpose == FS_CONTEXT_FOR_RECONFIGURE;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, nilfs_param_spec, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_barrier:
+		if (result.negated)
 			nilfs_clear_opt(nilfs, BARRIER);
-			break;
-		case Opt_order:
-			if (strcmp(args[0].from, "relaxed") == 0)
-				/* Ordered data semantics */
-				nilfs_clear_opt(nilfs, STRICT_ORDER);
-			else if (strcmp(args[0].from, "strict") == 0)
-				/* Strict in-order semantics */
-				nilfs_set_opt(nilfs, STRICT_ORDER);
-			else
-				return 0;
-			break;
-		case Opt_err_panic:
-			nilfs_write_opt(nilfs, ERROR_MODE, ERRORS_PANIC);
-			break;
-		case Opt_err_ro:
-			nilfs_write_opt(nilfs, ERROR_MODE, ERRORS_RO);
-			break;
-		case Opt_err_cont:
-			nilfs_write_opt(nilfs, ERROR_MODE, ERRORS_CONT);
-			break;
-		case Opt_snapshot:
-			if (is_remount) {
-				nilfs_err(sb,
-					  "\"%s\" option is invalid for remount",
-					  p);
-				return 0;
-			}
-			break;
-		case Opt_norecovery:
-			nilfs_set_opt(nilfs, NORECOVERY);
-			break;
-		case Opt_discard:
-			nilfs_set_opt(nilfs, DISCARD);
-			break;
-		case Opt_nodiscard:
-			nilfs_clear_opt(nilfs, DISCARD);
-			break;
-		default:
-			nilfs_err(sb, "unrecognized mount option \"%s\"", p);
-			return 0;
+		else
+			nilfs_set_opt(nilfs, BARRIER);
+		break;
+	case Opt_order:
+		if (strcmp(param->string, "relaxed") == 0)
+			/* Ordered data semantics */
+			nilfs_clear_opt(nilfs, STRICT_ORDER);
+		else if (strcmp(param->string, "strict") == 0)
+			/* Strict in-order semantics */
+			nilfs_set_opt(nilfs, STRICT_ORDER);
+		else
+			return -EINVAL;
+		break;
+	case Opt_err:
+		nilfs->ns_mount_opt &= ~NILFS_MOUNT_ERROR_MODE;
+		nilfs->ns_mount_opt |= result.uint_32;
+		break;
+	case Opt_snapshot:
+		if (is_remount) {
+			struct super_block *sb = fc->root->d_sb;
+
+			nilfs_err(sb,
+				  "\"%s\" option is invalid for remount",
+				  param->key);
+			return -EINVAL;
+		}
+		if (result.uint_64 == 0) {
+			nilfs_err(NULL,
+				  "invalid option \"cp=0\": invalid checkpoint number 0");
+			return -EINVAL;
 		}
+		nilfs->cno = result.uint_64;
+		break;
+	case Opt_norecovery:
+		nilfs_set_opt(nilfs, NORECOVERY);
+		break;
+	case Opt_discard:
+		if (result.negated)
+			nilfs_clear_opt(nilfs, DISCARD);
+		else
+			nilfs_set_opt(nilfs, DISCARD);
+		break;
+	default:
+		return -EINVAL;
 	}
-	return 1;
-}
 
-static inline void
-nilfs_set_default_options(struct super_block *sb,
-			  struct nilfs_super_block *sbp)
-{
-	struct the_nilfs *nilfs = sb->s_fs_info;
-
-	nilfs->ns_mount_opt =
-		NILFS_MOUNT_ERRORS_RO | NILFS_MOUNT_BARRIER;
+	return 0;
 }
 
 static int nilfs_setup_super(struct super_block *sb, int is_mount)
@@ -857,9 +850,8 @@ struct nilfs_super_block *nilfs_read_super_block(struct super_block *sb,
 	return (struct nilfs_super_block *)((char *)(*pbh)->b_data + offset);
 }
 
-int nilfs_store_magic_and_option(struct super_block *sb,
-				 struct nilfs_super_block *sbp,
-				 char *data)
+int nilfs_store_magic(struct super_block *sb,
+		      struct nilfs_super_block *sbp)
 {
 	struct the_nilfs *nilfs = sb->s_fs_info;
 
@@ -870,14 +862,12 @@ int nilfs_store_magic_and_option(struct super_block *sb,
 	sb->s_flags |= SB_NOATIME;
 #endif
 
-	nilfs_set_default_options(sb, sbp);
-
 	nilfs->ns_resuid = le16_to_cpu(sbp->s_def_resuid);
 	nilfs->ns_resgid = le16_to_cpu(sbp->s_def_resgid);
 	nilfs->ns_interval = le32_to_cpu(sbp->s_c_interval);
 	nilfs->ns_watermark = le32_to_cpu(sbp->s_c_block_max);
 
-	return !parse_options(data, sb, 0) ? -EINVAL : 0;
+	return 0;
 }
 
 int nilfs_check_feature_compatibility(struct super_block *sb,
@@ -1042,10 +1032,11 @@ int nilfs_checkpoint_is_mounted(struct super_block *sb, __u64 cno)
  * So, the recovery process is protected from other simultaneous mounts.
  */
 static int
-nilfs_fill_super(struct super_block *sb, void *data, int silent)
+nilfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct the_nilfs *nilfs;
 	struct nilfs_root *fsroot;
+	struct nilfs_fs_context *ctx = fc->fs_private;
 	__u64 cno;
 	int err;
 
@@ -1055,10 +1046,13 @@ nilfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_fs_info = nilfs;
 
-	err = init_nilfs(nilfs, sb, (char *)data);
+	err = init_nilfs(nilfs, sb);
 	if (err)
 		goto failed_nilfs;
 
+	/* Copy in parsed mount options */
+	nilfs->ns_mount_opt = ctx->ns_mount_opt;
+
 	sb->s_op = &nilfs_sops;
 	sb->s_export_op = &nilfs_export_ops;
 	sb->s_root = NULL;
@@ -1117,34 +1111,25 @@ nilfs_fill_super(struct super_block *sb, void *data, int silent)
 	return err;
 }
 
-static int nilfs_remount(struct super_block *sb, int *flags, char *data)
+static int nilfs_reconfigure(struct fs_context *fc)
 {
+	struct nilfs_fs_context *ctx = fc->fs_private;
+	struct super_block *sb = fc->root->d_sb;
 	struct the_nilfs *nilfs = sb->s_fs_info;
-	unsigned long old_sb_flags;
-	unsigned long old_mount_opt;
 	int err;
 
 	sync_filesystem(sb);
-	old_sb_flags = sb->s_flags;
-	old_mount_opt = nilfs->ns_mount_opt;
-
-	if (!parse_options(data, sb, 1)) {
-		err = -EINVAL;
-		goto restore_opts;
-	}
-	sb->s_flags = (sb->s_flags & ~SB_POSIXACL);
 
 	err = -EINVAL;
 
 	if (!nilfs_valid_fs(nilfs)) {
 		nilfs_warn(sb,
 			   "couldn't remount because the filesystem is in an incomplete recovery state");
-		goto restore_opts;
+		goto ignore_opts;
 	}
-
-	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
+	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
 		goto out;
-	if (*flags & SB_RDONLY) {
+	if (fc->sb_flags & SB_RDONLY) {
 		sb->s_flags |= SB_RDONLY;
 
 		/*
@@ -1172,138 +1157,66 @@ static int nilfs_remount(struct super_block *sb, int *flags, char *data)
 				   "couldn't remount RDWR because of unsupported optional features (%llx)",
 				   (unsigned long long)features);
 			err = -EROFS;
-			goto restore_opts;
+			goto ignore_opts;
 		}
 
 		sb->s_flags &= ~SB_RDONLY;
 
 		root = NILFS_I(d_inode(sb->s_root))->i_root;
 		err = nilfs_attach_log_writer(sb, root);
-		if (err)
-			goto restore_opts;
+		if (err) {
+			sb->s_flags |= SB_RDONLY;
+			goto ignore_opts;
+		}
 
 		down_write(&nilfs->ns_sem);
 		nilfs_setup_super(sb, true);
 		up_write(&nilfs->ns_sem);
 	}
  out:
-	return 0;
-
- restore_opts:
-	sb->s_flags = old_sb_flags;
-	nilfs->ns_mount_opt = old_mount_opt;
-	return err;
-}
-
-struct nilfs_super_data {
-	__u64 cno;
-	int flags;
-};
-
-static int nilfs_parse_snapshot_option(const char *option,
-				       const substring_t *arg,
-				       struct nilfs_super_data *sd)
-{
-	unsigned long long val;
-	const char *msg = NULL;
-	int err;
-
-	if (!(sd->flags & SB_RDONLY)) {
-		msg = "read-only option is not specified";
-		goto parse_error;
-	}
-
-	err = kstrtoull(arg->from, 0, &val);
-	if (err) {
-		if (err == -ERANGE)
-			msg = "too large checkpoint number";
-		else
-			msg = "malformed argument";
-		goto parse_error;
-	} else if (val == 0) {
-		msg = "invalid checkpoint number 0";
-		goto parse_error;
-	}
-	sd->cno = val;
-	return 0;
-
-parse_error:
-	nilfs_err(NULL, "invalid option \"%s\": %s", option, msg);
-	return 1;
-}
-
-/**
- * nilfs_identify - pre-read mount options needed to identify mount instance
- * @data: mount options
- * @sd: nilfs_super_data
- */
-static int nilfs_identify(char *data, struct nilfs_super_data *sd)
-{
-	char *p, *options = data;
-	substring_t args[MAX_OPT_ARGS];
-	int token;
-	int ret = 0;
-
-	do {
-		p = strsep(&options, ",");
-		if (p != NULL && *p) {
-			token = match_token(p, tokens, args);
-			if (token == Opt_snapshot)
-				ret = nilfs_parse_snapshot_option(p, &args[0],
-								  sd);
-		}
-		if (!options)
-			break;
-		BUG_ON(options == data);
-		*(options - 1) = ',';
-	} while (!ret);
-	return ret;
-}
+	sb->s_flags = (sb->s_flags & ~SB_POSIXACL);
+	/* Copy over parsed remount options */
+	nilfs->ns_mount_opt = ctx->ns_mount_opt;
 
-static int nilfs_set_bdev_super(struct super_block *s, void *data)
-{
-	s->s_dev = *(dev_t *)data;
 	return 0;
-}
 
-static int nilfs_test_bdev_super(struct super_block *s, void *data)
-{
-	return !(s->s_iflags & SB_I_RETIRED) && s->s_dev == *(dev_t *)data;
+ ignore_opts:
+	return err;
 }
 
-static struct dentry *
-nilfs_mount(struct file_system_type *fs_type, int flags,
-	     const char *dev_name, void *data)
+static int
+nilfs_get_tree(struct fs_context *fc)
 {
-	struct nilfs_super_data sd = { .flags = flags };
+	struct nilfs_fs_context *ctx = fc->fs_private;
 	struct super_block *s;
 	dev_t dev;
 	int err;
 
-	if (nilfs_identify(data, &sd))
-		return ERR_PTR(-EINVAL);
+	if (ctx->cno && !(fc->sb_flags & SB_RDONLY)) {
+		nilfs_err(s, "invalid option \"cp=%llu\": read-only option is not specified",
+			ctx->cno);
+		return -EINVAL;
+	}
 
-	err = lookup_bdev(dev_name, &dev);
+	err = lookup_bdev(fc->source, &dev);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
-	s = sget(fs_type, nilfs_test_bdev_super, nilfs_set_bdev_super, flags,
-		 &dev);
+	s = sget_dev(fc, dev);
 	if (IS_ERR(s))
-		return ERR_CAST(s);
+		return PTR_ERR(s);
 
 	if (!s->s_root) {
-		err = setup_bdev_super(s, flags, NULL);
+		err = setup_bdev_super(s, fc->sb_flags, fc);
 		if (!err)
-			err = nilfs_fill_super(s, data,
-					       flags & SB_SILENT ? 1 : 0);
+			err = nilfs_fill_super(s, fc);
 		if (err)
 			goto failed_super;
 
 		s->s_flags |= SB_ACTIVE;
-	} else if (!sd.cno) {
+	} else if (!ctx->cno) {
 		if (nilfs_tree_is_busy(s->s_root)) {
-			if ((flags ^ s->s_flags) & SB_RDONLY) {
+			if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY) {
 				nilfs_err(s,
 					  "the device already has a %s mount.",
 					  sb_rdonly(s) ? "read-only" : "read/write");
@@ -1315,34 +1228,65 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 			 * Try remount to setup mount states if the current
 			 * tree is not mounted and only snapshots use this sb.
 			 */
-			err = nilfs_remount(s, &flags, data);
+			fc->root = s->s_root;
+			err = nilfs_reconfigure(fc);
 			if (err)
 				goto failed_super;
 		}
 	}
 
-	if (sd.cno) {
+	if (ctx->cno) {
 		struct dentry *root_dentry;
 
-		err = nilfs_attach_snapshot(s, sd.cno, &root_dentry);
+		err = nilfs_attach_snapshot(s, ctx->cno, &root_dentry);
 		if (err)
 			goto failed_super;
-		return root_dentry;
+		fc->root = root_dentry;
+		return 0;
 	}
 
-	return dget(s->s_root);
+	fc->root = dget(s->s_root);
+	return 0;
 
  failed_super:
 	deactivate_locked_super(s);
-	return ERR_PTR(err);
+	return err;
+}
+
+static void nilfs_free_fc(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
+
+static const struct fs_context_operations nilfs_context_ops = {
+	.parse_param	= nilfs_parse_param,
+	.get_tree	= nilfs_get_tree,
+	.reconfigure	= nilfs_reconfigure,
+	.free		= nilfs_free_fc,
+};
+
+static int nilfs_init_fs_context(struct fs_context *fc)
+{
+	struct nilfs_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->ns_mount_opt = NILFS_MOUNT_ERRORS_RO | NILFS_MOUNT_BARRIER;
+	fc->fs_private = ctx;
+	fc->ops = &nilfs_context_ops;
+
+	return 0;
 }
 
 struct file_system_type nilfs_fs_type = {
 	.owner    = THIS_MODULE,
 	.name     = "nilfs2",
-	.mount    = nilfs_mount,
 	.kill_sb  = kill_block_super,
 	.fs_flags = FS_REQUIRES_DEV,
+	.init_fs_context = nilfs_init_fs_context,
+	.parameters = nilfs_param_spec,
 };
 MODULE_ALIAS_FS("nilfs2");
 
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 2ae2c1bbf6d1..77fce1f509d1 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -668,7 +668,7 @@ static int nilfs_load_super_block(struct the_nilfs *nilfs,
  * Return Value: On success, 0 is returned. On error, a negative error
  * code is returned.
  */
-int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
+int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 {
 	struct nilfs_super_block *sbp;
 	int blocksize;
@@ -686,7 +686,7 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 	if (err)
 		goto out;
 
-	err = nilfs_store_magic_and_option(sb, sbp, data);
+	err = nilfs_store_magic(sb, sbp);
 	if (err)
 		goto failed_sbh;
 
diff --git a/fs/nilfs2/the_nilfs.h b/fs/nilfs2/the_nilfs.h
index cd4ae1b8ae16..85da0629415d 100644
--- a/fs/nilfs2/the_nilfs.h
+++ b/fs/nilfs2/the_nilfs.h
@@ -219,10 +219,6 @@ THE_NILFS_FNS(PURGING, purging)
 #define nilfs_set_opt(nilfs, opt)  \
 	((nilfs)->ns_mount_opt |= NILFS_MOUNT_##opt)
 #define nilfs_test_opt(nilfs, opt) ((nilfs)->ns_mount_opt & NILFS_MOUNT_##opt)
-#define nilfs_write_opt(nilfs, mask, opt)				\
-	((nilfs)->ns_mount_opt =					\
-		(((nilfs)->ns_mount_opt & ~NILFS_MOUNT_##mask) |	\
-		 NILFS_MOUNT_##opt))					\
 
 /**
  * struct nilfs_root - nilfs root object
@@ -276,7 +272,7 @@ static inline int nilfs_sb_will_flip(struct the_nilfs *nilfs)
 void nilfs_set_last_segment(struct the_nilfs *, sector_t, u64, __u64);
 struct the_nilfs *alloc_nilfs(struct super_block *sb);
 void destroy_nilfs(struct the_nilfs *nilfs);
-int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data);
+int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb);
 int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb);
 unsigned long nilfs_nrsvsegs(struct the_nilfs *nilfs, unsigned long nsegs);
 void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs);
-- 
2.34.1


