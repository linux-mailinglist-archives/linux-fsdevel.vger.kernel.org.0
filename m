Return-Path: <linux-fsdevel+bounces-29521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2E897A6AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 19:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3975E1F23A2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 17:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519C415B96C;
	Mon, 16 Sep 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPhqJk8h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62415B10A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507499; cv=none; b=k890IWe6qiE7l0S5/Yaw+9b5H5vGRN8N+LgPlTPVB+hF7n/rBF16ffTaoAEkfCc8fnA+AnWaQWlWdDPv2TrL+MaTipNnBWBlWlg7VGuWqp499KdgDwTB3YoHkuqrZnJnR/ioie5U3dA5SV1xs8LG5CSe2iBxEo7UCOF0WrIrg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507499; c=relaxed/simple;
	bh=qhwGlbrGrrU7qtFihkHaGK0L2JszmZlBSIu84dnbiW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxasNl7IE62CPW0N0DBIO34bjYv5q2gm0yD7ot1IVVm3vDh+3M1/Vi2tK0HO+rObpXpah3gs/HIMGtffbyonmwIeWUqG7vK8c7UhbV6Ye8CiXW+gB14DDoS5m9Ix28gLTbw2T7n8j2zAA9t7m6gWLuytNuxSmlejU2UIrJxaS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPhqJk8h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726507496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ccoGXEg3xRcWyf4e5Y07F31dNBjX7k9KGzIGPyHAbg=;
	b=EPhqJk8hJxLYPb4yVemIs1SM/m2k0x9SpLhAT11uS8I/1BcrutcSmwmOJyeJIy9vT9Fb1U
	0NVdgRxxefDToXJOh3Cse2+uc/eGaZbwUedhx3ANVIVxjpqSnjAMmjxv3E3XKt31PRjJHd
	qKKHoTnDFBwUhmLKsz2lsMMdsz/QdYc=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-7BvCsZPJMMWhEIW1nr4LsQ-1; Mon, 16 Sep 2024 13:24:55 -0400
X-MC-Unique: 7BvCsZPJMMWhEIW1nr4LsQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a09d8ee141so16524475ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 10:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726507495; x=1727112295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ccoGXEg3xRcWyf4e5Y07F31dNBjX7k9KGzIGPyHAbg=;
        b=WdGLOp6sBVVShVqg11UD8kBK4xAwXqEmmJIsvFkH+ec05E/7GeJob4U1cOO50WLU80
         EddgyVeTSLblHbUu7Q0Aj3Z0orZqa9MtoIICm7rs+LMLF5mlI8dT/wVNhciUkH+q3B2H
         XvgXEc2z6IoKmKSmDBcIBMo9Qy6K/X6lKfB45uowrukmin2XtxtGDaiL+1T0LuNitsq3
         PqCjeG/UrJrURg7B9i1W8G2Dk7RldUEkJjPMQyaoPx8gldWR+TD7uPDE1G7Ef/4+Czro
         Rhde96zJv65iyJhUYRiA/MQkmgcDGEjYWMb+CaV2HwgLp/9J/dKVXA6lW+TNZHoLTw7j
         astg==
X-Gm-Message-State: AOJu0Yw/7XCR52sBW7QyxByVMIgG4tm/BU2nA9VuQI13OTLn4D2BWa9R
	K9l2YSWf1h+YMQxnVzBDnDmns2Q2E34jYUYugy8eNH+NXq4vrG9UdUJra+qkKqWEDPvu310ta8Z
	8Gyn/ba6I5mzlsPLRs0WiyIGuHmI+t1vKMqew5XeYHH4gSjn3ZqoceFmeIizZK9Yo4tBIRLVj5O
	JHM4FYZpgAxte/VWqzDHg9KizrAFOpBY6AayLUe6IAsa4MwA==
X-Received: by 2002:a92:8747:0:b0:3a0:8c5f:90d8 with SMTP id e9e14a558f8ab-3a08c5f91dfmr73127045ab.6.1726507494548;
        Mon, 16 Sep 2024 10:24:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDPwECTSEnANQUTGzi+wyxiZl2l5daaFnQ+6nD2GXuAW5qb01AjO+iUM+xOZx7hSnRPPQdWA==
X-Received: by 2002:a92:8747:0:b0:3a0:8c5f:90d8 with SMTP id e9e14a558f8ab-3a08c5f91dfmr73126705ab.6.1726507493961;
        Mon, 16 Sep 2024 10:24:53 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net (67-4-202-127.mpls.qwest.net. [67.4.202.127])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed190a2sm1610876173.89.2024.09.16.10.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 10:24:53 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	Eric Sandeen <sandeen@redhat.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 2/5] affs: convert affs to use the new mount api
Date: Mon, 16 Sep 2024 13:26:19 -0400
Message-ID: <20240916172735.866916-3-sandeen@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916172735.866916-1-sandeen@redhat.com>
References: <20240916172735.866916-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the affs filesystem to use the new mount API.
Tested by comparing random mount & remount options before and after
the change.

Cc: David Sterba <dsterba@suse.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/affs/super.c | 375 ++++++++++++++++++++++++------------------------
 1 file changed, 189 insertions(+), 186 deletions(-)

diff --git a/fs/affs/super.c b/fs/affs/super.c
index 3c5821339609..8010ad991dad 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -14,7 +14,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/statfs.h>
-#include <linux/parser.h>
+#include <linux/fs_parser.h>
+#include <linux/fs_context.h>
 #include <linux/magic.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
@@ -27,7 +28,6 @@
 
 static int affs_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int affs_show_options(struct seq_file *m, struct dentry *root);
-static int affs_remount (struct super_block *sb, int *flags, char *data);
 
 static void
 affs_commit_super(struct super_block *sb, int wait)
@@ -155,140 +155,115 @@ static const struct super_operations affs_sops = {
 	.put_super	= affs_put_super,
 	.sync_fs	= affs_sync_fs,
 	.statfs		= affs_statfs,
-	.remount_fs	= affs_remount,
 	.show_options	= affs_show_options,
 };
 
 enum {
 	Opt_bs, Opt_mode, Opt_mufs, Opt_notruncate, Opt_prefix, Opt_protect,
 	Opt_reserved, Opt_root, Opt_setgid, Opt_setuid,
-	Opt_verbose, Opt_volume, Opt_ignore, Opt_err,
+	Opt_verbose, Opt_volume, Opt_ignore,
 };
 
-static const match_table_t tokens = {
-	{Opt_bs, "bs=%u"},
-	{Opt_mode, "mode=%o"},
-	{Opt_mufs, "mufs"},
-	{Opt_notruncate, "nofilenametruncate"},
-	{Opt_prefix, "prefix=%s"},
-	{Opt_protect, "protect"},
-	{Opt_reserved, "reserved=%u"},
-	{Opt_root, "root=%u"},
-	{Opt_setgid, "setgid=%u"},
-	{Opt_setuid, "setuid=%u"},
-	{Opt_verbose, "verbose"},
-	{Opt_volume, "volume=%s"},
-	{Opt_ignore, "grpquota"},
-	{Opt_ignore, "noquota"},
-	{Opt_ignore, "quota"},
-	{Opt_ignore, "usrquota"},
-	{Opt_err, NULL},
+struct affs_context {
+	kuid_t		uid;		/* uid to override */
+	kgid_t		gid;		/* gid to override */
+	unsigned int	mode;		/* mode to override */
+	unsigned int	reserved;	/* Number of reserved blocks */
+	int		root_block;	/* FFS root block number */
+	int		blocksize;	/* Initial device blksize */
+	char		*prefix;	/* Prefix for volumes and assigns */
+	char		volume[32];	/* Vol. prefix for absolute symlinks */
+	unsigned long	mount_flags;	/* Options */
 };
 
-static int
-parse_options(char *options, kuid_t *uid, kgid_t *gid, int *mode, int *reserved, s32 *root,
-		int *blocksize, char **prefix, char *volume, unsigned long *mount_opts)
+static const struct fs_parameter_spec affs_param_spec[] = {
+	fsparam_u32	("bs",		Opt_bs),
+	fsparam_u32oct	("mode",	Opt_mode),
+	fsparam_flag	("mufs",	Opt_mufs),
+	fsparam_flag	("nofilenametruncate",	Opt_notruncate),
+	fsparam_string	("prefix",	Opt_prefix),
+	fsparam_flag	("protect",	Opt_protect),
+	fsparam_u32	("reserved",	Opt_reserved),
+	fsparam_u32	("root",	Opt_root),
+	fsparam_gid	("setgid",	Opt_setgid),
+	fsparam_uid	("setuid",	Opt_setuid),
+	fsparam_flag	("verbose",	Opt_verbose),
+	fsparam_string	("volume",	Opt_volume),
+	fsparam_flag	("grpquota",	Opt_ignore),
+	fsparam_flag	("noquota",	Opt_ignore),
+	fsparam_flag	("quota",	Opt_ignore),
+	fsparam_flag	("usrquota",	Opt_ignore),
+	{},
+};
+
+static int affs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-
-	/* Fill in defaults */
-
-	*uid        = current_uid();
-	*gid        = current_gid();
-	*reserved   = 2;
-	*root       = -1;
-	*blocksize  = -1;
-	volume[0]   = ':';
-	volume[1]   = 0;
-	*mount_opts = 0;
-	if (!options)
-		return 1;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token, n, option;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_bs:
-			if (match_int(&args[0], &n))
-				return 0;
-			if (n != 512 && n != 1024 && n != 2048
-			    && n != 4096) {
-				pr_warn("Invalid blocksize (512, 1024, 2048, 4096 allowed)\n");
-				return 0;
-			}
-			*blocksize = n;
-			break;
-		case Opt_mode:
-			if (match_octal(&args[0], &option))
-				return 0;
-			*mode = option & 0777;
-			affs_set_opt(*mount_opts, SF_SETMODE);
-			break;
-		case Opt_mufs:
-			affs_set_opt(*mount_opts, SF_MUFS);
-			break;
-		case Opt_notruncate:
-			affs_set_opt(*mount_opts, SF_NO_TRUNCATE);
-			break;
-		case Opt_prefix:
-			kfree(*prefix);
-			*prefix = match_strdup(&args[0]);
-			if (!*prefix)
-				return 0;
-			affs_set_opt(*mount_opts, SF_PREFIX);
-			break;
-		case Opt_protect:
-			affs_set_opt(*mount_opts, SF_IMMUTABLE);
-			break;
-		case Opt_reserved:
-			if (match_int(&args[0], reserved))
-				return 0;
-			break;
-		case Opt_root:
-			if (match_int(&args[0], root))
-				return 0;
-			break;
-		case Opt_setgid:
-			if (match_int(&args[0], &option))
-				return 0;
-			*gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(*gid))
-				return 0;
-			affs_set_opt(*mount_opts, SF_SETGID);
-			break;
-		case Opt_setuid:
-			if (match_int(&args[0], &option))
-				return 0;
-			*uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(*uid))
-				return 0;
-			affs_set_opt(*mount_opts, SF_SETUID);
-			break;
-		case Opt_verbose:
-			affs_set_opt(*mount_opts, SF_VERBOSE);
-			break;
-		case Opt_volume: {
-			char *vol = match_strdup(&args[0]);
-			if (!vol)
-				return 0;
-			strscpy(volume, vol, 32);
-			kfree(vol);
-			break;
-		}
-		case Opt_ignore:
-		 	/* Silently ignore the quota options */
-			break;
-		default:
-			pr_warn("Unrecognized mount option \"%s\" or missing value\n",
-				p);
-			return 0;
+	struct affs_context *ctx = fc->fs_private;
+	struct fs_parse_result result;
+	int n;
+	int opt;
+
+	opt = fs_parse(fc, affs_param_spec, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_bs:
+		n = result.uint_32;
+		if (n != 512 && n != 1024 && n != 2048
+		    && n != 4096) {
+			pr_warn("Invalid blocksize (512, 1024, 2048, 4096 allowed)\n");
+			return -EINVAL;
 		}
+		ctx->blocksize = n;
+		break;
+	case Opt_mode:
+		ctx->mode = result.uint_32 & 0777;
+		affs_set_opt(ctx->mount_flags, SF_SETMODE);
+		break;
+	case Opt_mufs:
+		affs_set_opt(ctx->mount_flags, SF_MUFS);
+		break;
+	case Opt_notruncate:
+		affs_set_opt(ctx->mount_flags, SF_NO_TRUNCATE);
+		break;
+	case Opt_prefix:
+		kfree(ctx->prefix);
+		ctx->prefix = param->string;
+		param->string = NULL;
+		affs_set_opt(ctx->mount_flags, SF_PREFIX);
+		break;
+	case Opt_protect:
+		affs_set_opt(ctx->mount_flags, SF_IMMUTABLE);
+		break;
+	case Opt_reserved:
+		ctx->reserved = result.uint_32;
+		break;
+	case Opt_root:
+		ctx->root_block = result.uint_32;
+		break;
+	case Opt_setgid:
+		ctx->gid = result.gid;
+		affs_set_opt(ctx->mount_flags, SF_SETGID);
+		break;
+	case Opt_setuid:
+		ctx->uid = result.uid;
+		affs_set_opt(ctx->mount_flags, SF_SETUID);
+		break;
+	case Opt_verbose:
+		affs_set_opt(ctx->mount_flags, SF_VERBOSE);
+		break;
+	case Opt_volume: {
+		strscpy(ctx->volume, param->string, 32);
+		break;
 	}
-	return 1;
+	case Opt_ignore:
+	 	/* Silently ignore the quota options */
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
 }
 
 static int affs_show_options(struct seq_file *m, struct dentry *root)
@@ -329,27 +304,22 @@ static int affs_show_options(struct seq_file *m, struct dentry *root)
  * hopefully have the guts to do so. Until then: sorry for the mess.
  */
 
-static int affs_fill_super(struct super_block *sb, void *data, int silent)
+static int affs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct affs_sb_info	*sbi;
+	struct affs_context	*ctx = fc->fs_private;
 	struct buffer_head	*root_bh = NULL;
 	struct buffer_head	*boot_bh;
 	struct inode		*root_inode = NULL;
-	s32			 root_block;
+	int			 silent = fc->sb_flags & SB_SILENT;
 	int			 size, blocksize;
 	u32			 chksum;
 	int			 num_bm;
 	int			 i, j;
-	kuid_t			 uid;
-	kgid_t			 gid;
-	int			 reserved;
-	unsigned long		 mount_flags;
 	int			 tmp_flags;	/* fix remount prototype... */
 	u8			 sig[4];
 	int			 ret;
 
-	pr_debug("read_super(%s)\n", data ? (const char *)data : "no options");
-
 	sb->s_magic             = AFFS_SUPER_MAGIC;
 	sb->s_op                = &affs_sops;
 	sb->s_flags |= SB_NODIRATIME;
@@ -369,19 +339,16 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 	spin_lock_init(&sbi->work_lock);
 	INIT_DELAYED_WORK(&sbi->sb_work, flush_superblock);
 
-	if (!parse_options(data,&uid,&gid,&i,&reserved,&root_block,
-				&blocksize,&sbi->s_prefix,
-				sbi->s_volume, &mount_flags)) {
-		pr_err("Error parsing options\n");
-		return -EINVAL;
-	}
-	/* N.B. after this point s_prefix must be released */
+	sbi->s_flags	= ctx->mount_flags;
+	sbi->s_mode	= ctx->mode;
+	sbi->s_uid	= ctx->uid;
+	sbi->s_gid	= ctx->gid;
+	sbi->s_reserved	= ctx->reserved;
+	sbi->s_prefix	= ctx->prefix;
+	ctx->prefix	= NULL;
+	memcpy(sbi->s_volume, ctx->volume, 32);
 
-	sbi->s_flags   = mount_flags;
-	sbi->s_mode    = i;
-	sbi->s_uid     = uid;
-	sbi->s_gid     = gid;
-	sbi->s_reserved= reserved;
+	/* N.B. after this point s_prefix must be released */
 
 	/* Get the size of the device in 512-byte blocks.
 	 * If we later see that the partition uses bigger
@@ -396,15 +363,16 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 
 	i = bdev_logical_block_size(sb->s_bdev);
 	j = PAGE_SIZE;
+	blocksize = ctx->blocksize;
 	if (blocksize > 0) {
 		i = j = blocksize;
 		size = size / (blocksize / 512);
 	}
 
 	for (blocksize = i; blocksize <= j; blocksize <<= 1, size >>= 1) {
-		sbi->s_root_block = root_block;
-		if (root_block < 0)
-			sbi->s_root_block = (reserved + size - 1) / 2;
+		sbi->s_root_block = ctx->root_block;
+		if (ctx->root_block < 0)
+			sbi->s_root_block = (ctx->reserved + size - 1) / 2;
 		pr_debug("setting blocksize to %d\n", blocksize);
 		affs_set_blocksize(sb, blocksize);
 		sbi->s_partition_size = size;
@@ -424,7 +392,7 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 				"size=%d, reserved=%d\n",
 				sb->s_id,
 				sbi->s_root_block + num_bm,
-				blocksize, size, reserved);
+				ctx->blocksize, size, ctx->reserved);
 			root_bh = affs_bread(sb, sbi->s_root_block + num_bm);
 			if (!root_bh)
 				continue;
@@ -447,7 +415,7 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 got_root:
 	/* Keep super block in cache */
 	sbi->s_root_bh = root_bh;
-	root_block = sbi->s_root_block;
+	ctx->root_block = sbi->s_root_block;
 
 	/* Find out which kind of FS we have */
 	boot_bh = sb_bread(sb, 0);
@@ -506,7 +474,7 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 		return -EINVAL;
 	}
 
-	if (affs_test_opt(mount_flags, SF_VERBOSE)) {
+	if (affs_test_opt(ctx->mount_flags, SF_VERBOSE)) {
 		u8 len = AFFS_ROOT_TAIL(sb, root_bh)->disk_name[0];
 		pr_notice("Mounting volume \"%.*s\": Type=%.3s\\%c, Blocksize=%d\n",
 			len > 31 ? 31 : len,
@@ -528,7 +496,7 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 
 	/* set up enough so that it can read an inode */
 
-	root_inode = affs_iget(sb, root_block);
+	root_inode = affs_iget(sb, ctx->root_block);
 	if (IS_ERR(root_inode))
 		return PTR_ERR(root_inode);
 
@@ -548,56 +516,43 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 }
 
-static int
-affs_remount(struct super_block *sb, int *flags, char *data)
+static int affs_reconfigure(struct fs_context *fc)
 {
+	struct super_block	*sb = fc->root->d_sb;
+	struct affs_context	*ctx = fc->fs_private;
 	struct affs_sb_info	*sbi = AFFS_SB(sb);
-	int			 blocksize;
-	kuid_t			 uid;
-	kgid_t			 gid;
-	int			 mode;
-	int			 reserved;
-	int			 root_block;
-	unsigned long		 mount_flags;
 	int			 res = 0;
-	char			 volume[32];
-	char			*prefix = NULL;
-
-	pr_debug("%s(flags=0x%x,opts=\"%s\")\n", __func__, *flags, data);
 
 	sync_filesystem(sb);
-	*flags |= SB_NODIRATIME;
-
-	memcpy(volume, sbi->s_volume, 32);
-	if (!parse_options(data, &uid, &gid, &mode, &reserved, &root_block,
-			   &blocksize, &prefix, volume,
-			   &mount_flags)) {
-		kfree(prefix);
-		return -EINVAL;
-	}
+	fc->sb_flags |= SB_NODIRATIME;
 
 	flush_delayed_work(&sbi->sb_work);
 
-	sbi->s_flags = mount_flags;
-	sbi->s_mode  = mode;
-	sbi->s_uid   = uid;
-	sbi->s_gid   = gid;
+	/*
+	 * NB: Historically, only mount_flags, mode, uid, gic, prefix,
+	 * and volume are accepted during remount.
+	 */
+	sbi->s_flags = ctx->mount_flags;
+	sbi->s_mode  = ctx->mode;
+	sbi->s_uid   = ctx->uid;
+	sbi->s_gid   = ctx->gid;
 	/* protect against readers */
 	spin_lock(&sbi->symlink_lock);
-	if (prefix) {
+	if (ctx->prefix) {
 		kfree(sbi->s_prefix);
-		sbi->s_prefix = prefix;
+		sbi->s_prefix = ctx->prefix;
+		ctx->prefix = NULL;
 	}
-	memcpy(sbi->s_volume, volume, 32);
+	memcpy(sbi->s_volume, ctx->volume, 32);
 	spin_unlock(&sbi->symlink_lock);
 
-	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
+	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
 		return 0;
 
-	if (*flags & SB_RDONLY)
+	if (fc->sb_flags & SB_RDONLY)
 		affs_free_bitmap(sb);
 	else
-		res = affs_init_bitmap(sb, flags);
+		res = affs_init_bitmap(sb, &fc->sb_flags);
 
 	return res;
 }
@@ -624,10 +579,9 @@ affs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-static struct dentry *affs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int affs_get_tree(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, affs_fill_super);
+        return get_tree_bdev(fc, affs_fill_super);
 }
 
 static void affs_kill_sb(struct super_block *sb)
@@ -643,12 +597,61 @@ static void affs_kill_sb(struct super_block *sb)
 	}
 }
 
+static void affs_free_fc(struct fs_context *fc)
+{
+	struct affs_context *ctx = fc->fs_private;
+
+	kfree(ctx->prefix);
+	kfree(ctx);
+}
+
+static const struct fs_context_operations affs_context_ops = {
+	.parse_param	= affs_parse_param,
+	.get_tree	= affs_get_tree,
+	.reconfigure	= affs_reconfigure,
+	.free		= affs_free_fc,
+};
+
+static int affs_init_fs_context(struct fs_context *fc)
+{
+	struct affs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct affs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		struct super_block *sb = fc->root->d_sb;
+		struct affs_sb_info *sbi = AFFS_SB(sb);
+
+		/*
+		 * NB: historically, no options other than volume were
+		 * preserved across a remount unless they were explicitly
+		 * passed in.
+		 */
+		memcpy(ctx->volume, sbi->s_volume, 32);
+	} else {
+		ctx->uid	= current_uid();
+		ctx->gid	= current_gid();
+		ctx->reserved	= 2;
+		ctx->root_block	= -1;
+		ctx->blocksize	= -1;
+		ctx->volume[0]	= ':';
+	}
+
+        fc->ops = &affs_context_ops;
+        fc->fs_private = ctx;
+
+        return 0;
+}
+
 static struct file_system_type affs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "affs",
-	.mount		= affs_mount,
 	.kill_sb	= affs_kill_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
+	.init_fs_context = affs_init_fs_context,
+	.parameters	= affs_param_spec,
 };
 MODULE_ALIAS_FS("affs");
 
-- 
2.46.0


