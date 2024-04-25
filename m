Return-Path: <linux-fsdevel+bounces-17818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFD68B28B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 21:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D33281D5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0A61514CC;
	Thu, 25 Apr 2024 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1IIRItH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D4639FCF;
	Thu, 25 Apr 2024 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071964; cv=none; b=gAu0krlLrawIUvB4NdntN1LreiQjZ2yIpoXcdTHZEqoBYMnmdmVp4ORQUcF4jKXdDuec2GPNjT7+n+FQVKaeg9TuBdfHm4UbticYJmq+7/2G/6DPlILYvdToGz9qUIdCpCdD1qFN6O6k0euKPatWpp0G9tqwLRpMIspSLa7JuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071964; c=relaxed/simple;
	bh=ZEmZGRl1rm/iHfnBBtlNElEh12bpHVKFN0H8fnxPGCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PtQJzAE197UsrI2QBG3J1QNQvjSs1H3mpgbJNieZPmAXo7yuVo7apSwDfZLoc6xu1jdQBUsZoYoV2pcGSrq7zBzjHpFPvbx3mZa2npBW+wjUrQLDzzUsFfTIuBoGNm+kHwhYMnqvUGwarKC9submERsbLvvJvN/D9kkuHnvwSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1IIRItH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so1331780b3a.0;
        Thu, 25 Apr 2024 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714071961; x=1714676761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SX8tGEcFT5/jFu3pdWpkn+5vdsSuK+OxzBcQI05MfR0=;
        b=S1IIRItHCXKiKLNseh1pRfmX6IxP52m7/QHqcJFl7E4HOUvRLJLhNf5U8ZUj9OP6qR
         HPn6MJlbsjRtioC7ty24ukAW+ztZ75X3jK6xjBh9Z4C+1d6/Ig2ca5lgql5nArKF+UA+
         hrHFp4x9aPlFfXPlyWRzZiaD0IwSCZFYW8srhJ3Tow51YFYR162s6BYeH82f3eCo30/C
         g6s9YLvtU380zEGWCskgC3Rqc38JrYyPxN4f/pMwBV53SaqbbtW7pDKZx+cF2Bnnb0GR
         eCgvzrpbkTlBChVp196M0PjCvGwsEUDjLZY8LVfcluBQtBz1piebrKf2iXZuPifgVQdp
         n/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714071961; x=1714676761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SX8tGEcFT5/jFu3pdWpkn+5vdsSuK+OxzBcQI05MfR0=;
        b=MtBgR7a2p2dTKuIvERL9uCRNnQ54Q5w3lgnaePRmfw/Ht6pfXOLok5K5x5TqTYf7Nw
         tS3MZm0zclshkLr93i7vmlAX7L8ImSKOKLaZafzqwRE8hIYfWXe9rXapY2kahdOF4ScG
         Hne8SRoOxT0edvbqTId4YO3zoAk5XIlsebVAHb8+BwRuPInnGACot5wNjeHBu+bfdgcj
         aCnEks6clNfZIdcdK/4iG4KPXw0sv0b/MjvZ49ajb/+hiEkSNiCZ1BeOOit47zfDN9nA
         XbKmC3gVo+ouHW3rSisFKzZU2Sy8S4bPIk4FrcpivSJ8/zzHMPij4wbd9ZcvCL71ABjv
         jRng==
X-Forwarded-Encrypted: i=1; AJvYcCV+ZdD8n3deXaSQo6o7hq8aKtgaBlFJ50hi/ze5EAHj3IMD/uQC/tUsg5EDcWXO7VOpANuaKoXUBk2XdoJcHoHFt7wn6GqMCQzNt8hWAwtvVeDVuiC7UgXkEYQFxoMRI0PhpO4t+mi+p0NXVw==
X-Gm-Message-State: AOJu0YxiFL3VIiqUlHIYM4o7avI3aHj1K+jK0L5R+MYE00G+jftHGRQC
	vc7RRSv1/5c7aMxpR0ciSQLjkl226fiF7fVQK50h9hQwqLM+1zT39YSP0Q==
X-Google-Smtp-Source: AGHT+IH/7PZ1Ec0+lG3sulNmNZKT9oHefX51Btp/WXF2ghMJ8O1JnMUNxidWuGjGA+8fdjfHiw00EA==
X-Received: by 2002:a05:6a20:975b:b0:1ac:de56:eed4 with SMTP id hs27-20020a056a20975b00b001acde56eed4mr640082pzc.53.1714071961157;
        Thu, 25 Apr 2024 12:06:01 -0700 (PDT)
Received: from carrot.. (i223-218-108-246.s42.a014.ap.plala.or.jp. [223.218.108.246])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79901000000b006ed3509ecd0sm13481458pff.56.2024.04.25.12.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 12:06:00 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH -mm v2] nilfs2: convert to use the new mount API
Date: Fri, 26 Apr 2024 04:05:26 +0900
Message-Id: <20240425190526.10905-1-konishi.ryusuke@gmail.com>
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

[konishi.ryusuke: fixed missing SB_RDONLY flag repair, UAF read for
 fc->root on error, reference to uninitialized variable, duplicate header
 inclusion, and missing update of kernel-doc comments]
Link: https://lkml.kernel.org/r/33d078a7-9072-4d8e-a3a9-dec23d4191da@redhat.com
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Hi Andrew, please use this to replace the new mount API support patch
queued for the next merge window.

v2 (to -mm):
- fix UAF read for fc->root in put_fs_context() when call to
  nilfs_reconfigure() from nilfs_get_tree() fails.
- fix reference to uninitialized variable 's' in nilfs_get_tree().
- fix duplicate inclusion of fs_context.h.
- reflect function argument changes to kernel-doc comments.

Thanks,
Ryusuke Konishi

 fs/nilfs2/nilfs.h     |   4 +-
 fs/nilfs2/super.c     | 388 ++++++++++++++++++------------------------
 fs/nilfs2/the_nilfs.c |   5 +-
 fs/nilfs2/the_nilfs.h |   6 +-
 4 files changed, 174 insertions(+), 229 deletions(-)

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
index ac24ed109ce9..e835e1f5a712 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -29,13 +29,13 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
-#include <linux/parser.h>
 #include <linux/crc32.h>
 #include <linux/vfs.h>
 #include <linux/writeback.h>
 #include <linux/seq_file.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include "nilfs.h"
 #include "export.h"
 #include "mdt.h"
@@ -61,7 +61,6 @@ struct kmem_cache *nilfs_segbuf_cachep;
 struct kmem_cache *nilfs_btree_path_cache;
 
 static int nilfs_setup_super(struct super_block *sb, int is_mount);
-static int nilfs_remount(struct super_block *sb, int *flags, char *data);
 
 void __nilfs_msg(struct super_block *sb, const char *fmt, ...)
 {
@@ -702,105 +701,98 @@ static const struct super_operations nilfs_sops = {
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
-
-static inline void
-nilfs_set_default_options(struct super_block *sb,
-			  struct nilfs_super_block *sbp)
-{
-	struct the_nilfs *nilfs = sb->s_fs_info;
 
-	nilfs->ns_mount_opt =
-		NILFS_MOUNT_ERRORS_RO | NILFS_MOUNT_BARRIER;
+	return 0;
 }
 
 static int nilfs_setup_super(struct super_block *sb, int is_mount)
@@ -857,9 +849,8 @@ struct nilfs_super_block *nilfs_read_super_block(struct super_block *sb,
 	return (struct nilfs_super_block *)((char *)(*pbh)->b_data + offset);
 }
 
-int nilfs_store_magic_and_option(struct super_block *sb,
-				 struct nilfs_super_block *sbp,
-				 char *data)
+int nilfs_store_magic(struct super_block *sb,
+		      struct nilfs_super_block *sbp)
 {
 	struct the_nilfs *nilfs = sb->s_fs_info;
 
@@ -870,14 +861,12 @@ int nilfs_store_magic_and_option(struct super_block *sb,
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
@@ -1035,17 +1024,17 @@ int nilfs_checkpoint_is_mounted(struct super_block *sb, __u64 cno)
 /**
  * nilfs_fill_super() - initialize a super block instance
  * @sb: super_block
- * @data: mount options
- * @silent: silent mode flag
+ * @fc: filesystem context
  *
  * This function is called exclusively by nilfs->ns_mount_mutex.
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
 
@@ -1055,10 +1044,13 @@ nilfs_fill_super(struct super_block *sb, void *data, int silent)
 
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
@@ -1117,34 +1109,25 @@ nilfs_fill_super(struct super_block *sb, void *data, int silent)
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
@@ -1172,138 +1155,67 @@ static int nilfs_remount(struct super_block *sb, int *flags, char *data)
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
+		nilfs_err(NULL,
+			  "invalid option \"cp=%llu\": read-only option is not specified",
+			  ctx->cno);
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
@@ -1312,37 +1224,75 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 			}
 		} else {
 			/*
-			 * Try remount to setup mount states if the current
+			 * Try reconfigure to setup mount states if the current
 			 * tree is not mounted and only snapshots use this sb.
+			 *
+			 * Since nilfs_reconfigure() requires fc->root to be
+			 * set, set it first and release it on failure.
 			 */
-			err = nilfs_remount(s, &flags, data);
-			if (err)
+			fc->root = dget(s->s_root);
+			err = nilfs_reconfigure(fc);
+			if (err) {
+				dput(fc->root);
+				fc->root = NULL;  /* prevent double release */
 				goto failed_super;
+			}
+			return 0;
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
index 2ae2c1bbf6d1..db322068678f 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -659,7 +659,6 @@ static int nilfs_load_super_block(struct the_nilfs *nilfs,
  * init_nilfs - initialize a NILFS instance.
  * @nilfs: the_nilfs structure
  * @sb: super block
- * @data: mount options
  *
  * init_nilfs() performs common initialization per block device (e.g.
  * reading the super block, getting disk layout information, initializing
@@ -668,7 +667,7 @@ static int nilfs_load_super_block(struct the_nilfs *nilfs,
  * Return Value: On success, 0 is returned. On error, a negative error
  * code is returned.
  */
-int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
+int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 {
 	struct nilfs_super_block *sbp;
 	int blocksize;
@@ -686,7 +685,7 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
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


