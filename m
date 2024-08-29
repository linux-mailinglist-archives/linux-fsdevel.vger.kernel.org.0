Return-Path: <linux-fsdevel+bounces-27950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79615964F2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 21:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F75128335D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FD21BBBC8;
	Thu, 29 Aug 2024 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvioZbdA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3AF1BA885
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960337; cv=none; b=lNJANU4dwNKzshoow8zVL1MppjSenpHpv5R90gB1CXcX7H5JqVqfDeNI0hAHxWQkFWq4qTb4kY/K5vRRlwr+LsoUW738EmxVBu1MM6GJxqWI08jq+EuSiu7WcmWm/ey80jhNJAuK8UTSWleeim1jX91FMck7fTGYhTfLdURo2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960337; c=relaxed/simple;
	bh=e/hSO5LTSyHehBreFb9/iWqXOESqJXDf+zAdLmy08kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLbqykW17Ni5+9j4AL6exn2XgzGSwGrpwP+LE5Sjtsc8NsyceYfEtKkmNMXXSzBz26gxgjFNgNCjNLkg3kwzQDoZ80Uz2JcjoEIpN6AyRtjUo7vskKG38cN0GII6YKjpWljID6q4A2zjdg0hySLzxVEKciudMekPoCZAAfwId9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvioZbdA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724960334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4xw3aGunlDpCChTmmPe3m44iLgT8WYZZRARkKCrrRU=;
	b=dvioZbdABnSm8DkkxOaoZ+JWLZ6pz07juVQwztpVTvIOM0BywwVdm2Qo0Jzaw6FaRCwFDB
	iP3Q+1apeoJJlwYbwvNcwEldEjXOGGwUwaZvYa9PVCrFbql6rGRO3ggh1CEsUzBDVF6aKS
	U5I/Z3vOopzH1Zf56+ypdkmlR6mzu5U=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-Vcw6Mcn4NQmmxylvWx5BvA-1; Thu, 29 Aug 2024 15:38:52 -0400
X-MC-Unique: Vcw6Mcn4NQmmxylvWx5BvA-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d4c656946so11113285ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 12:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724960331; x=1725565131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4xw3aGunlDpCChTmmPe3m44iLgT8WYZZRARkKCrrRU=;
        b=X7ZfA6Rjb+ANBDkotR0BJnze2jx9oIGDn65JjD5RAe8LPc2wRWaM3fgzq1G4nrRFv5
         F/g8+EgBhuWPO9xC4N3OFePSFzOZ2DmIkoxTQcadN+xgyb8PAv0SVNtUosWQ97L5FepJ
         ZT+/e8traZQdrnq/fPUnuVn6FUUaWLWqmri6nM2Myyn5oKxBD4ch8JlABj6WRoxKhgqb
         VHtxbBR9qh55PX6cAFaX2av2pwTE9c4qBCPg28bitqatyoWoxxwTE7Mv0EWl3QeoRyL0
         J+6ZPtttAwyJhoYDYuGSSPm5+NEuvAIP+23UNWBAtJNDdKbi90BsELGXgONV9kMW6efZ
         obpQ==
X-Gm-Message-State: AOJu0YyDayfv6SfrQFwAPF1AyBtDbyqWU5ebovZEIJ7uE6U7sRhceOfJ
	kyvHnQBzh7ZnGf8dKPvYnyarL72N3hc8tyziMXsm6C51VABJiP1ig7K/wNgWc2oboqmac9QaYHi
	LVGlUkYpNQ3KNSURdEOLQjmTn83czOeyHOReAETcLdm/NGHrXuG+o7x2pofaT+xgUa+oq85hA7i
	HitxAWJsDF8KiEz5a2Tc6z/BMPA08PWFyYN1OGGfcL18YoQA==
X-Received: by 2002:a92:cdab:0:b0:396:e8b8:88d with SMTP id e9e14a558f8ab-39f377f495bmr49034515ab.11.1724960331088;
        Thu, 29 Aug 2024 12:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGycH3S8E7wjdLJzCqoHWmKQfObniSSSWpoFeI5gcgq1PppERnzqOjB/fDwutuquWpoPbN2jQ==
X-Received: by 2002:a92:cdab:0:b0:396:e8b8:88d with SMTP id e9e14a558f8ab-39f377f495bmr49034255ab.11.1724960330604;
        Thu, 29 Aug 2024 12:38:50 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3b058880sm4388025ab.74.2024.08.29.12.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:38:50 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	Eric Sandeen <sandeen@redhat.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] adfs: convert adfs to use the new mount api
Date: Thu, 29 Aug 2024 15:39:59 -0400
Message-ID: <20240829194138.2073709-2-sandeen@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829194138.2073709-1-sandeen@redhat.com>
References: <20240829194138.2073709-1-sandeen@redhat.com>
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

Cc: David Sterba <dsterba@suse.com>
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


