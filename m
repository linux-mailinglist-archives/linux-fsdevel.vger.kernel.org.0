Return-Path: <linux-fsdevel+bounces-29520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C41697A6AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 19:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1A8282932
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D383C15B13C;
	Mon, 16 Sep 2024 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGpMGLYF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E214EC5B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507498; cv=none; b=Rx3LuwTWZtBrKc7c55y54tcZ7rc+w3mQPTuOQ+DvjW8CRjxHjSE7bg40VLD0mG62Yn13JidedTIKGLzVNloDge/fsos6grWdlbwiul97N/DehcyLniCEuWG7kuAcHck0KfxWs2aX2xVDHVn+r/f0MLey7B1S+PWYNDrhu/bp2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507498; c=relaxed/simple;
	bh=QRer3Ady3En5I7GIbikdGJsxUSg7fUAnVsh21KwJ7Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0Ku41ahIxNPFVA4IOu2ihK3rRk/QHLlpYSmMluSYjykt3Kd3GWl9BKpY6ubiryBN61Zj2I3jibq9BKnpOp5BLhZLCw2oH6VeE/DXdL/x6midVffJrvGDkimaDmA7GxQtHrzWukGvXQ71SCMVYql40/1PXM/Oz/VVCrIPm8GcEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGpMGLYF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726507495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SfCQJ2tjVlpK9RZslFZKZqUeZpFiyXh8vMOykWUX0sY=;
	b=VGpMGLYFQ86bLr0DWAp+RfVxZmFWgibCMXDeBacmNniBzDXftKtLsBLQFmWq6eJeQGrKsq
	+VJnzLLQrGwaHUhi5uLnIevmLNBYDEm9bcLeDmOe42LLxTJHZVbtCqe1UKCe8Id9oHVPpo
	3B7tD5dJiccltW4wDM3ZcSnhD8/S7t0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-ixBobXYEORSjD3iVYeG_Cw-1; Mon, 16 Sep 2024 13:24:54 -0400
X-MC-Unique: ixBobXYEORSjD3iVYeG_Cw-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82ce3316d51so789939139f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 10:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726507494; x=1727112294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfCQJ2tjVlpK9RZslFZKZqUeZpFiyXh8vMOykWUX0sY=;
        b=u9p0t1cRwcG7W61Liwp0zr1LM129Ji2pFHCIUDQMmhVK1/A5SzKaUUrhBW1KjsosJP
         1RMIIQafGtVPAP/+OwaCAmBQMW7KqoqtHpJxcX1kYKYjb6Y3g0q/w5rj5KBc0QgW5WQF
         19Y7+VZg2vteBqMww5IGXv6ZJCTKMdDPU8IccCB4vBKl6bKHOUWmYPKBQZHXyRGLcvJ4
         F6f5vzqiVLDuY1y6c8UwZ0SlsDaWrtLXlXmIzGJNkh14e64vGa4aaN7Nh+2ytSo6Hi5d
         1oW487vPeNVPDfdTlJJddUkbHplPxE/gZFIHjIQOEUaGLQrWfCU4DhBiYK2uukiw/Nes
         GeFw==
X-Gm-Message-State: AOJu0YxTn43IQFs6WNXLZX3xFgmiCnzR/7thpFvXPkfNYADHn3rFcrfE
	frxV6GCfgLc4TsCbW1dojHc6mIEkMHskHt/XrmGSl1eINhvTsFNv0jT2NeNVr82z+XaVDpJAF9e
	0IZQrHN7YyIlCHcOpbWkgm642kUatOSYdApE3WR2qdxU0QT452nP7MBfQS6b8Nxj3TPpQLm8OsQ
	LffxUuVI72J8JI4py7HLwmlXkrZDK544spdZw5f53jxJIMPQ==
X-Received: by 2002:a05:6602:2dc5:b0:82c:eb18:ea53 with SMTP id ca18e2360f4ac-82d1faa20d7mr1657179339f.16.1726507493573;
        Mon, 16 Sep 2024 10:24:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIW3d9hjigZQvGp/9ypZMCLH0ymXMHD+n+ouFwWUyFTH82NnC1dfpQHO9Zu6hlN7HsddB4uQ==
X-Received: by 2002:a05:6602:2dc5:b0:82c:eb18:ea53 with SMTP id ca18e2360f4ac-82d1faa20d7mr1657176839f.16.1726507493074;
        Mon, 16 Sep 2024 10:24:53 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net (67-4-202-127.mpls.qwest.net. [67.4.202.127])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed190a2sm1610876173.89.2024.09.16.10.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 10:24:52 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 1/5] adfs: convert adfs to use the new mount api
Date: Mon, 16 Sep 2024 13:26:18 -0400
Message-ID: <20240916172735.866916-2-sandeen@redhat.com>
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

Convert the adfs filesystem to use the new mount API.
Tested by comparing random mount & remount options before and after
the change.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/adfs/super.c | 186 +++++++++++++++++++++++++-----------------------
 1 file changed, 95 insertions(+), 91 deletions(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index f0b999a4961b..017c48a80203 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -6,7 +6,8 @@
  */
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/parser.h>
+#include <linux/fs_parser.h>
+#include <linux/fs_context.h>
 #include <linux/mount.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -115,87 +116,61 @@ static int adfs_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
-enum {Opt_uid, Opt_gid, Opt_ownmask, Opt_othmask, Opt_ftsuffix, Opt_err};
+enum {Opt_uid, Opt_gid, Opt_ownmask, Opt_othmask, Opt_ftsuffix};
 
-static const match_table_t tokens = {
-	{Opt_uid, "uid=%u"},
-	{Opt_gid, "gid=%u"},
-	{Opt_ownmask, "ownmask=%o"},
-	{Opt_othmask, "othmask=%o"},
-	{Opt_ftsuffix, "ftsuffix=%u"},
-	{Opt_err, NULL}
+static const struct fs_parameter_spec adfs_param_spec[] = {
+	fsparam_uid	("uid",		Opt_uid),
+	fsparam_gid	("gid",		Opt_gid),
+	fsparam_u32oct	("ownmask",	Opt_ownmask),
+	fsparam_u32oct	("othmask",	Opt_othmask),
+	fsparam_u32	("ftsuffix",	Opt_ftsuffix),
+	{}
 };
 
-static int parse_options(struct super_block *sb, struct adfs_sb_info *asb,
-			 char *options)
+static int adfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *p;
-	int option;
-
-	if (!options)
-		return 0;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		substring_t args[MAX_OPT_ARGS];
-		int token;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_uid:
-			if (match_int(args, &option))
-				return -EINVAL;
-			asb->s_uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(asb->s_uid))
-				return -EINVAL;
-			break;
-		case Opt_gid:
-			if (match_int(args, &option))
-				return -EINVAL;
-			asb->s_gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(asb->s_gid))
-				return -EINVAL;
-			break;
-		case Opt_ownmask:
-			if (match_octal(args, &option))
-				return -EINVAL;
-			asb->s_owner_mask = option;
-			break;
-		case Opt_othmask:
-			if (match_octal(args, &option))
-				return -EINVAL;
-			asb->s_other_mask = option;
-			break;
-		case Opt_ftsuffix:
-			if (match_int(args, &option))
-				return -EINVAL;
-			asb->s_ftsuffix = option;
-			break;
-		default:
-			adfs_msg(sb, KERN_ERR,
-				 "unrecognised mount option \"%s\" or missing value",
-				 p);
-			return -EINVAL;
-		}
+	struct adfs_sb_info *asb = fc->s_fs_info;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, adfs_param_spec, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_uid:
+		asb->s_uid = result.uid;
+		break;
+	case Opt_gid:
+		asb->s_gid = result.gid;
+		break;
+	case Opt_ownmask:
+		asb->s_owner_mask = result.uint_32;
+		break;
+	case Opt_othmask:
+		asb->s_other_mask = result.uint_32;
+		break;
+	case Opt_ftsuffix:
+		asb->s_ftsuffix = result.uint_32;
+		break;
+	default:
+		return -EINVAL;
 	}
 	return 0;
 }
 
-static int adfs_remount(struct super_block *sb, int *flags, char *data)
+static int adfs_reconfigure(struct fs_context *fc)
 {
-	struct adfs_sb_info temp_asb;
-	int ret;
+	struct adfs_sb_info *new_asb = fc->s_fs_info;
+	struct adfs_sb_info *asb = ADFS_SB(fc->root->d_sb);
 
-	sync_filesystem(sb);
-	*flags |= ADFS_SB_FLAGS;
+	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |= ADFS_SB_FLAGS;
 
-	temp_asb = *ADFS_SB(sb);
-	ret = parse_options(sb, &temp_asb, data);
-	if (ret == 0)
-		*ADFS_SB(sb) = temp_asb;
+	/* Structure copy newly parsed options */
+	*asb = *new_asb;
 
-	return ret;
+	return 0;
 }
 
 static int adfs_statfs(struct dentry *dentry, struct kstatfs *buf)
@@ -273,7 +248,6 @@ static const struct super_operations adfs_sops = {
 	.write_inode	= adfs_write_inode,
 	.put_super	= adfs_put_super,
 	.statfs		= adfs_statfs,
-	.remount_fs	= adfs_remount,
 	.show_options	= adfs_show_options,
 };
 
@@ -361,34 +335,21 @@ static int adfs_validate_dr0(struct super_block *sb, struct buffer_head *bh,
 	return 0;
 }
 
-static int adfs_fill_super(struct super_block *sb, void *data, int silent)
+static int adfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct adfs_discrecord *dr;
 	struct object_info root_obj;
-	struct adfs_sb_info *asb;
+	struct adfs_sb_info *asb = sb->s_fs_info;
 	struct inode *root;
 	int ret = -EINVAL;
+	int silent = fc->sb_flags & SB_SILENT;
 
 	sb->s_flags |= ADFS_SB_FLAGS;
 
-	asb = kzalloc(sizeof(*asb), GFP_KERNEL);
-	if (!asb)
-		return -ENOMEM;
-
 	sb->s_fs_info = asb;
 	sb->s_magic = ADFS_SUPER_MAGIC;
 	sb->s_time_gran = 10000000;
 
-	/* set default options */
-	asb->s_uid = GLOBAL_ROOT_UID;
-	asb->s_gid = GLOBAL_ROOT_GID;
-	asb->s_owner_mask = ADFS_DEFAULT_OWNER_MASK;
-	asb->s_other_mask = ADFS_DEFAULT_OTHER_MASK;
-	asb->s_ftsuffix = 0;
-
-	if (parse_options(sb, asb, data))
-		goto error;
-
 	/* Try to probe the filesystem boot block */
 	ret = adfs_probe(sb, ADFS_DISCRECORD, 1, adfs_validate_bblk);
 	if (ret == -EILSEQ)
@@ -453,18 +414,61 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	return ret;
 }
 
-static struct dentry *adfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int adfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, adfs_fill_super);
+}
+
+static void adfs_free_fc(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, adfs_fill_super);
+	struct adfs_context *asb = fc->s_fs_info;
+
+	kfree(asb);
+}
+
+static const struct fs_context_operations adfs_context_ops = {
+	.parse_param	= adfs_parse_param,
+	.get_tree	= adfs_get_tree,
+	.reconfigure	= adfs_reconfigure,
+	.free		= adfs_free_fc,
+};
+
+static int adfs_init_fs_context(struct fs_context *fc)
+{
+	struct adfs_sb_info *asb;
+
+	asb = kzalloc(sizeof(struct adfs_sb_info), GFP_KERNEL);
+	if (!asb)
+		return -ENOMEM;
+
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		struct super_block *sb = fc->root->d_sb;
+		struct adfs_sb_info *old_asb = ADFS_SB(sb);
+
+		/* structure copy existing options before parsing */
+		*asb = *old_asb;
+	} else {
+		/* set default options */
+		asb->s_uid = GLOBAL_ROOT_UID;
+		asb->s_gid = GLOBAL_ROOT_GID;
+		asb->s_owner_mask = ADFS_DEFAULT_OWNER_MASK;
+		asb->s_other_mask = ADFS_DEFAULT_OTHER_MASK;
+		asb->s_ftsuffix = 0;
+	}
+
+	fc->ops = &adfs_context_ops;
+	fc->s_fs_info = asb;
+
+	return 0;
 }
 
 static struct file_system_type adfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "adfs",
-	.mount		= adfs_mount,
 	.kill_sb	= kill_block_super,
 	.fs_flags	= FS_REQUIRES_DEV,
+	.init_fs_context = adfs_init_fs_context,
+	.parameters	= adfs_param_spec,
 };
 MODULE_ALIAS_FS("adfs");
 
-- 
2.46.0


