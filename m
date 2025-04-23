Return-Path: <linux-fsdevel+bounces-47138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B89A99B16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 00:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86D04644C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 22:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6421E51E3;
	Wed, 23 Apr 2025 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnyuQFc3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74528E7
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445612; cv=none; b=aXLDhUUXi8wc7OtpBGkQbzRiXslZyzy7C0B24EzdN28ep2BCr10LiUApzfLYYKPKx+pwx1eGzfqvYe34nR7mW+PIlOyiUphYdZWtI74bGrmsRNPUHkqm2sLE7d/sNAlORlt/w0XIsbbeyp76MGVRS1sRnJ7Tf9VdiwizejVniLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445612; c=relaxed/simple;
	bh=xSu7yldYtY394iXyh716SwkKhsQ7KUzGTfIuHJv4r2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZbNNNh67fJO6DZPH+XvlRTcfEGRXYWwYUNSL5GD9NOmdg+54tS/73ELKG7MTidKtGvzOxTtgzQDRKMX7GKiGJjAKTEYGIhRB2t72O+2/MNG1+c1Uk5W2sj29I4xQ4sJx6FD+L8jgfW6+V9jHxoqZL1onpV7ovlNU44xbI4+z9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnyuQFc3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745445609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8G1PZo2FSpN3qXS7bw7NtvTqFoW8ogiPXZSrTrzIJvs=;
	b=fnyuQFc3prwVjNuUiQBFmeG+hXABgoUvUs9i2B7L4zoSjHlq9OgE0PhSHY11IGEXkHw+Ch
	4TlhNBRg/KVj+2tmxp2/GGHlaLc2qtrVQx/o9SZOL+AWQBDC3cx9A+B5E65Bs9/6H12VFT
	Ns5+uSFzmavZLoRn7XgCj+tlzR8DIig=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-1CYb5dVgNwacthBGs5Xf6A-1; Wed, 23 Apr 2025 18:00:07 -0400
X-MC-Unique: 1CYb5dVgNwacthBGs5Xf6A-1
X-Mimecast-MFC-AGG-ID: 1CYb5dVgNwacthBGs5Xf6A_1745445607
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso1562265e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 15:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745445605; x=1746050405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8G1PZo2FSpN3qXS7bw7NtvTqFoW8ogiPXZSrTrzIJvs=;
        b=u26f9HCPOXAhyCXtgVZXHtepEBGXzdG167jqQ6D/jvWSD5i9je+8Ssbc1G3onkN6iz
         jq2+pD51fIbjHYRQDVIwgFLMu5pws2kwIOyxGz4sWVy+h4M0LC4TqHFVqAU6QtByHcFK
         UkRWNp7ivGfmVlA8O5VbQ3Mt+V66iYaCJeawBdqKkaJRGcZlMQKsWgwvb7VAtAlHlPMt
         yB29Izc726h7g/7fZSBfLQj6g318A9Rvpg8qrjX5lMFHVqYIPSPHTM1GLPpu8PFMKW9P
         6HgFT0Lz+KGvM1qtgpOgms77ZO0bWNdKhBbZiYvGMjvvhUl/a8P76RhpBBBQHfpzaVAc
         NovQ==
X-Gm-Message-State: AOJu0Yyc0kg8Gh9OwQZdDoQCwjwW/MUvh7ESt7yx1TnI7NeneMYyyH2f
	Ido7GSWDchrLdwQZC2MohPK56TqsR6r2+fnBPAQw5E6AdHSz2UJEO9ooCaamQ/zhzGUZbHP4QXa
	bpRTynY7He1+DthpoRadEesichUTFtzR4KdvQg9sDX72lJUJEo8bgh92+d170ulpOMLuIxEBt+J
	to3bLlF9TS5i96yaXBi5C4YUU22Ck526ZpGnBMboBDw0Tx0w==
X-Gm-Gg: ASbGncuvCeIR4krLD6yV03ePBgxAFxE//q4X/PRhhCGvnSlSrmeJEcLRcdmqCtPczwO
	gw4bjVcqissVKEUZmxYpnD3sEwyoiR/7MB6yL1Rexeq/wAoMRLV5kqeLGtj3wGTl70Qu2FsOWE3
	TTDd9H5HeVR17xm4to4L0Hl0OV/ggLspGwD3ynQxJJTrZ94NMr3ZdYT1dtVTJ7VYiGm+pB0Ia7m
	FtQ0Uw2ZJB6Kn5NuCgK4NXEeZFwXZ+5zOaLzkExoZutIu9d96zh5ZNguJVIoQ2w/tZB+xmytTaJ
	i6yRqsahiDz8foE/4RQdAEOr6voFPOW+kZgNFLdO2rFAyX2P
X-Received: by 2002:a05:600c:458c:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-4409bd839camr1057275e9.23.1745445604835;
        Wed, 23 Apr 2025 15:00:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFte/DAGVnPjmHzlOwWwntw1rf9VtEB6s1d7SBK6GheGcqHRFnswkbdpun3jH36amrHiFuMOA==
X-Received: by 2002:a05:600c:458c:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-4409bd839camr1056415e9.23.1745445604025;
        Wed, 23 Apr 2025 15:00:04 -0700 (PDT)
Received: from fedora.redhat.com (gw20-pha-stl-mmo-2.avonet.cz. [131.117.213.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409c3daf69sm164365e9.38.2025.04.23.15.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 15:00:03 -0700 (PDT)
From: Pavel Reichl <preichl@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: me@bobcopeland.com,
	sandeen@redhat.com,
	brauner@kernel.org
Subject: [PATCH] omfs: convert to new mount API
Date: Thu, 24 Apr 2025 00:00:01 +0200
Message-ID: <20250423220001.1535071-1-preichl@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the OMFS filesystem to the new mount API.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 fs/omfs/inode.c | 176 ++++++++++++++++++++++++++++--------------------
 1 file changed, 104 insertions(+), 72 deletions(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index d6cd81163030..135c49c5d848 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -9,12 +9,13 @@
 #include <linux/fs.h>
 #include <linux/vfs.h>
 #include <linux/cred.h>
-#include <linux/parser.h>
 #include <linux/buffer_head.h>
 #include <linux/vmalloc.h>
 #include <linux/writeback.h>
 #include <linux/seq_file.h>
 #include <linux/crc-itu-t.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include "omfs.h"
 
 MODULE_AUTHOR("Bob Copeland <me@bobcopeland.com>");
@@ -384,79 +385,83 @@ static int omfs_get_imap(struct super_block *sb)
 	return -ENOMEM;
 }
 
+struct omfs_mount_options {
+	kuid_t s_uid;
+	kgid_t s_gid;
+	int s_dmask;
+	int s_fmask;
+};
+
 enum {
-	Opt_uid, Opt_gid, Opt_umask, Opt_dmask, Opt_fmask, Opt_err
+	Opt_uid, Opt_gid, Opt_umask, Opt_dmask, Opt_fmask,
 };
 
-static const match_table_t tokens = {
-	{Opt_uid, "uid=%u"},
-	{Opt_gid, "gid=%u"},
-	{Opt_umask, "umask=%o"},
-	{Opt_dmask, "dmask=%o"},
-	{Opt_fmask, "fmask=%o"},
-	{Opt_err, NULL},
+static const struct fs_parameter_spec omfs_param_spec[] = {
+	fsparam_uid	("uid",		Opt_uid),
+	fsparam_gid	("gid",		Opt_gid),
+	fsparam_u32oct	("umask",	Opt_umask),
+	fsparam_u32oct	("dmask",	Opt_dmask),
+	fsparam_u32oct	("fmask",	Opt_fmask),
+	{}
 };
 
-static int parse_options(char *options, struct omfs_sb_info *sbi)
+static int
+omfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-
-	if (!options)
-		return 1;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_uid:
-			if (match_int(&args[0], &option))
-				return 0;
-			sbi->s_uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(sbi->s_uid))
-				return 0;
-			break;
-		case Opt_gid:
-			if (match_int(&args[0], &option))
-				return 0;
-			sbi->s_gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(sbi->s_gid))
-				return 0;
-			break;
-		case Opt_umask:
-			if (match_octal(&args[0], &option))
-				return 0;
-			sbi->s_fmask = sbi->s_dmask = option;
-			break;
-		case Opt_dmask:
-			if (match_octal(&args[0], &option))
-				return 0;
-			sbi->s_dmask = option;
-			break;
-		case Opt_fmask:
-			if (match_octal(&args[0], &option))
-				return 0;
-			sbi->s_fmask = option;
-			break;
-		default:
-			return 0;
-		}
+	struct omfs_mount_options *opts = fc->fs_private;
+	int token;
+	struct fs_parse_result result;
+
+	/* All options are ignored on remount */
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
+		return 0;
+
+	token = fs_parse(fc, omfs_param_spec, param, &result);
+	if (token < 0)
+		return token;
+
+	switch (token) {
+	case Opt_uid:
+		opts->s_uid = result.uid;
+		break;
+	case Opt_gid:
+		opts->s_gid = result.gid;
+		break;
+	case Opt_umask:
+		opts->s_fmask = opts->s_dmask = result.uint_32;
+		break;
+	case Opt_dmask:
+		opts->s_dmask = result.uint_32;
+		break;
+	case Opt_fmask:
+		opts->s_fmask = result.uint_32;
+		break;
+	default:
+		return -EINVAL;
 	}
-	return 1;
+
+	return 0;
 }
 
-static int omfs_fill_super(struct super_block *sb, void *data, int silent)
+static void
+omfs_set_options(struct omfs_sb_info *sbi, struct omfs_mount_options *opts)
+{
+	sbi->s_uid = opts->s_uid;
+	sbi->s_gid = opts->s_gid;
+	sbi->s_dmask = opts->s_dmask;
+	sbi->s_fmask = opts->s_fmask;
+}
+
+static int omfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct buffer_head *bh, *bh2;
 	struct omfs_super_block *omfs_sb;
 	struct omfs_root_block *omfs_rb;
 	struct omfs_sb_info *sbi;
 	struct inode *root;
+	struct omfs_mount_options *parsed_opts = fc->fs_private;
 	int ret = -EINVAL;
+	int silent = fc->sb_flags & SB_SILENT;
 
 	sbi = kzalloc(sizeof(struct omfs_sb_info), GFP_KERNEL);
 	if (!sbi)
@@ -464,12 +469,7 @@ static int omfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_fs_info = sbi;
 
-	sbi->s_uid = current_uid();
-	sbi->s_gid = current_gid();
-	sbi->s_dmask = sbi->s_fmask = current_umask();
-
-	if (!parse_options((char *) data, sbi))
-		goto end;
+	omfs_set_options(sbi, parsed_opts);
 
 	sb->s_maxbytes = 0xffffffff;
 
@@ -594,18 +594,50 @@ static int omfs_fill_super(struct super_block *sb, void *data, int silent)
 	return ret;
 }
 
-static struct dentry *omfs_mount(struct file_system_type *fs_type,
-			int flags, const char *dev_name, void *data)
+static int omfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, omfs_fill_super);
+}
+
+static void omfs_free_fc(struct fs_context *fc);
+
+static const struct fs_context_operations omfs_context_ops = {
+	.parse_param	= omfs_parse_param,
+	.get_tree	= omfs_get_tree,
+	.free		= omfs_free_fc,
+};
+
+static int omfs_init_fs_context(struct fs_context *fc)
+{
+	struct omfs_mount_options *opts;
+
+	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+
+	/* Set mount options defaults */
+	opts->s_uid = current_uid();
+	opts->s_gid = current_gid();
+	opts->s_dmask = opts->s_fmask = current_umask();
+
+	fc->fs_private = opts;
+	fc->ops = &omfs_context_ops;
+
+	return 0;
+}
+
+static void omfs_free_fc(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, omfs_fill_super);
+	kfree(fc->fs_private);
 }
 
 static struct file_system_type omfs_fs_type = {
-	.owner = THIS_MODULE,
-	.name = "omfs",
-	.mount = omfs_mount,
-	.kill_sb = kill_block_super,
-	.fs_flags = FS_REQUIRES_DEV,
+	.owner		 = THIS_MODULE,
+	.name		 = "omfs",
+	.kill_sb	 = kill_block_super,
+	.fs_flags	 = FS_REQUIRES_DEV,
+	.init_fs_context = omfs_init_fs_context,
+	.parameters	 = omfs_param_spec,
 };
 MODULE_ALIAS_FS("omfs");
 
-- 
2.49.0


