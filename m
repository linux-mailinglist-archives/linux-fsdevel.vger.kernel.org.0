Return-Path: <linux-fsdevel+bounces-29522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCB197A6B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 19:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA431C26DC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 17:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCC915B97D;
	Mon, 16 Sep 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXErf+cp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AAA15B12B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507499; cv=none; b=RRYEnwOJ7Bg0Lz5zvC5PsMdimtickRqjwhLigJbZSF94lDs/hoWi70BS/DnvalQ05pm72R+nPnUSfpS+t44OaYuI9GHNBR7ukjrapdhcCDrWx4lCr04vppQdBx+65cxa6erJW4+1Q3M8SIGVQJN0D3MM2vZSb0rVVZoBCwiHzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507499; c=relaxed/simple;
	bh=HuKFHKbhtjmo1fug7pKvDAvTvHtNZVzvOwCc5+y2gEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OR895HQBrdRI659qi9MBkRWV9ES0C4KRClBtzGkhLfNnNWlg7yYta4/tOgPW1DIMPN+LbjJKK2GgdqfdGY6bYjuDMztyyzAcTdh3XQwEbOQxgpPjKTgOSaV63/XOQdP2wuKrBPWM6jIK2nrpNia0Csdq0/OHUPcF/Mn0bWvGUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXErf+cp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726507497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAMfm33qNfzE6tZoXUDqd3skWXoN9hIZmU7wzd2mK1A=;
	b=VXErf+cpJ5+RWx7grpoJnwlQiBaJNIy18S7z6i09Nr62YZztoKt3Nlp4mQg4EKhAYxv/ro
	b7VsOXNcDcu+B1jToWjv+EVnOPhw+ZF0pzAYvsjWFYw+nQwVvIdFKad9UNv7CgrJYzVVPk
	ZDHpqpsB+zLPdbjikltDGV66DzzfSSg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-Lzrn7OMdOmO9BljJYqVNfw-1; Mon, 16 Sep 2024 13:24:56 -0400
X-MC-Unique: Lzrn7OMdOmO9BljJYqVNfw-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82ced069d94so1016246339f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 10:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726507495; x=1727112295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAMfm33qNfzE6tZoXUDqd3skWXoN9hIZmU7wzd2mK1A=;
        b=R601AUpwrO1MMzut1zAFzmPiZtYoOqT+0bHv+wqGuMhG+h6zYsLy3nRIfBF/6nHbUC
         q1M1c4g+6F0iyiOoR8LtjDHKt5M684LT/Y0lxPzMT6OzBkWIZGnnKqMaP5cipwoL658i
         qgpv5aFje1E6EvQTQnTi2yA+dqB4Ds8Rm6Y7oFGxE7R+qoQezjCbJYMYohgtIdI1hb2N
         NjvYk/ZfY5GhQYtKUXzlYOiGKA0UTYYoUxlGw/2tGaWd4hbDXGKifqoYYzdLp75nf0fi
         w85XvI3hwxCC/kzC6njiinr1bd6mhBmvW8Eso1PA8rygTSAROmUVRLQttbzH9hAiNR5b
         ytGQ==
X-Gm-Message-State: AOJu0YwF5zqvUb5H6m8Huen9COKhljfb3UQj1D1u6laxcoMEJyDwZkqB
	6WI28DHOHDQamWUtKzwB47x+7sXYO3TpfAg5Xe3eJ4Ny6y5nEpm7AGH0SizVO9jQ7Q4uJQu3Dtn
	iJlMvWT2t1e52iIkGgJYB4KEiqH8NokUnOjuTX1W/E7mNzZO9FDhbRBWb6dFbE7RgUjT0UVVXe/
	pVl6MkPNFe1WNoA8SFaZAolIbKFeppT9xWkhN4toY+wKz3tQ==
X-Received: by 2002:a05:6602:6d8b:b0:82a:a4e7:5544 with SMTP id ca18e2360f4ac-82d1f8e18c6mr1465029939f.9.1726507495171;
        Mon, 16 Sep 2024 10:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZO8ci1VqblmNCPwWVE/SzbnDrftPRWzySXpcJXLz3AtWvyLzAPppgapf/JTrloag8E73xFQ==
X-Received: by 2002:a05:6602:6d8b:b0:82a:a4e7:5544 with SMTP id ca18e2360f4ac-82d1f8e18c6mr1465027639f.9.1726507494783;
        Mon, 16 Sep 2024 10:24:54 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net (67-4-202-127.mpls.qwest.net. [67.4.202.127])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed190a2sm1610876173.89.2024.09.16.10.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 10:24:54 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	Eric Sandeen <sandeen@redhat.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH 3/5] befs: convert befs to use the new mount api
Date: Mon, 16 Sep 2024 13:26:20 -0400
Message-ID: <20240916172735.866916-4-sandeen@redhat.com>
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

Convert the befs filesystem to use the new mount API.
Tested by comparing random mount & remount options before and after
the change.

Cc: Luis de Bethencourt <luisbg@kernel.org>
Cc: Salah Triki <salah.triki@gmail.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/befs/linuxvfs.c | 199 +++++++++++++++++++++++----------------------
 1 file changed, 102 insertions(+), 97 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index f92f108840f5..8f430ff8e445 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -11,12 +11,13 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/errno.h>
 #include <linux/stat.h>
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
-#include <linux/parser.h>
 #include <linux/namei.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
@@ -54,22 +55,20 @@ static int befs_utf2nls(struct super_block *sb, const char *in, int in_len,
 static int befs_nls2utf(struct super_block *sb, const char *in, int in_len,
 			char **out, int *out_len);
 static void befs_put_super(struct super_block *);
-static int befs_remount(struct super_block *, int *, char *);
 static int befs_statfs(struct dentry *, struct kstatfs *);
 static int befs_show_options(struct seq_file *, struct dentry *);
-static int parse_options(char *, struct befs_mount_options *);
 static struct dentry *befs_fh_to_dentry(struct super_block *sb,
 				struct fid *fid, int fh_len, int fh_type);
 static struct dentry *befs_fh_to_parent(struct super_block *sb,
 				struct fid *fid, int fh_len, int fh_type);
 static struct dentry *befs_get_parent(struct dentry *child);
+static void befs_free_fc(struct fs_context *fc);
 
 static const struct super_operations befs_sops = {
 	.alloc_inode	= befs_alloc_inode,	/* allocate a new inode */
 	.free_inode	= befs_free_inode, /* deallocate an inode */
 	.put_super	= befs_put_super,	/* uninit super */
 	.statfs		= befs_statfs,	/* statfs */
-	.remount_fs	= befs_remount,
 	.show_options	= befs_show_options,
 };
 
@@ -672,92 +671,53 @@ static struct dentry *befs_get_parent(struct dentry *child)
 }
 
 enum {
-	Opt_uid, Opt_gid, Opt_charset, Opt_debug, Opt_err,
+	Opt_uid, Opt_gid, Opt_charset, Opt_debug,
 };
 
-static const match_table_t befs_tokens = {
-	{Opt_uid, "uid=%d"},
-	{Opt_gid, "gid=%d"},
-	{Opt_charset, "iocharset=%s"},
-	{Opt_debug, "debug"},
-	{Opt_err, NULL}
+static const struct fs_parameter_spec befs_param_spec[] = {
+	fsparam_uid	("uid",		Opt_uid),
+	fsparam_gid	("gid",		Opt_gid),
+	fsparam_string	("iocharset",	Opt_charset),
+	fsparam_flag	("debug",	Opt_debug),
+	{}
 };
 
 static int
-parse_options(char *options, struct befs_mount_options *opts)
+befs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-	kuid_t uid;
-	kgid_t gid;
-
-	/* Initialize options */
-	opts->uid = GLOBAL_ROOT_UID;
-	opts->gid = GLOBAL_ROOT_GID;
-	opts->use_uid = 0;
-	opts->use_gid = 0;
-	opts->iocharset = NULL;
-	opts->debug = 0;
-
-	if (!options)
-		return 1;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-
-		if (!*p)
-			continue;
-
-		token = match_token(p, befs_tokens, args);
-		switch (token) {
-		case Opt_uid:
-			if (match_int(&args[0], &option))
-				return 0;
-			uid = INVALID_UID;
-			if (option >= 0)
-				uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(uid)) {
-				pr_err("Invalid uid %d, "
-				       "using default\n", option);
-				break;
-			}
-			opts->uid = uid;
-			opts->use_uid = 1;
-			break;
-		case Opt_gid:
-			if (match_int(&args[0], &option))
-				return 0;
-			gid = INVALID_GID;
-			if (option >= 0)
-				gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(gid)) {
-				pr_err("Invalid gid %d, "
-				       "using default\n", option);
-				break;
-			}
-			opts->gid = gid;
-			opts->use_gid = 1;
-			break;
-		case Opt_charset:
-			kfree(opts->iocharset);
-			opts->iocharset = match_strdup(&args[0]);
-			if (!opts->iocharset) {
-				pr_err("allocation failure for "
-				       "iocharset string\n");
-				return 0;
-			}
-			break;
-		case Opt_debug:
-			opts->debug = 1;
-			break;
-		default:
-			pr_err("Unrecognized mount option \"%s\" "
-			       "or missing value\n", p);
-			return 0;
-		}
+	struct befs_mount_options *opts = fc->fs_private;
+	int token;
+	struct fs_parse_result result;
+
+	/* befs ignores all options on remount */
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
+		return 0;
+
+	token = fs_parse(fc, befs_param_spec, param, &result);
+	if (token < 0)
+		return token;
+
+	switch (token) {
+	case Opt_uid:
+		opts->uid = result.uid;
+		opts->use_uid = 1;
+		break;
+	case Opt_gid:
+		opts->gid = result.gid;
+		opts->use_gid = 1;
+		break;
+	case Opt_charset:
+		kfree(opts->iocharset);
+		opts->iocharset = param->string;
+		param->string = NULL;
+		break;
+	case Opt_debug:
+		opts->debug = 1;
+		break;
+	default:
+		return -EINVAL;
 	}
-	return 1;
+	return 0;
 }
 
 static int befs_show_options(struct seq_file *m, struct dentry *root)
@@ -793,6 +753,21 @@ befs_put_super(struct super_block *sb)
 	sb->s_fs_info = NULL;
 }
 
+/*
+ * Copy the parsed options into the sbi mount_options member
+ */
+static void
+befs_set_options(struct befs_sb_info *sbi, struct befs_mount_options *opts)
+{
+	sbi->mount_opts.uid = opts->uid;
+	sbi->mount_opts.gid = opts->gid;
+	sbi->mount_opts.use_uid = opts->use_uid;
+	sbi->mount_opts.use_gid = opts->use_gid;
+	sbi->mount_opts.debug = opts->debug;
+	sbi->mount_opts.iocharset = opts->iocharset;
+	opts->iocharset = NULL;
+}
+
 /* Allocate private field of the superblock, fill it.
  *
  * Finish filling the public superblock fields
@@ -800,7 +775,7 @@ befs_put_super(struct super_block *sb)
  * Load a set of NLS translations if needed.
  */
 static int
-befs_fill_super(struct super_block *sb, void *data, int silent)
+befs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct buffer_head *bh;
 	struct befs_sb_info *befs_sb;
@@ -810,6 +785,8 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 	const unsigned long sb_block = 0;
 	const off_t x86_sb_off = 512;
 	int blocksize;
+	struct befs_mount_options *parsed_opts = fc->fs_private;
+	int silent = fc->sb_flags & SB_SILENT;
 
 	sb->s_fs_info = kzalloc(sizeof(*befs_sb), GFP_KERNEL);
 	if (sb->s_fs_info == NULL)
@@ -817,11 +794,7 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 
 	befs_sb = BEFS_SB(sb);
 
-	if (!parse_options((char *) data, &befs_sb->mount_opts)) {
-		if (!silent)
-			befs_error(sb, "cannot parse mount options");
-		goto unacquire_priv_sbp;
-	}
+	befs_set_options(befs_sb, parsed_opts);
 
 	befs_debug(sb, "---> %s", __func__);
 
@@ -934,10 +907,10 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static int
-befs_remount(struct super_block *sb, int *flags, char *data)
+befs_reconfigure(struct fs_context *fc)
 {
-	sync_filesystem(sb);
-	if (!(*flags & SB_RDONLY))
+	sync_filesystem(fc->root->d_sb);
+	if (!(fc->sb_flags & SB_RDONLY))
 		return -EINVAL;
 	return 0;
 }
@@ -965,19 +938,51 @@ befs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-static struct dentry *
-befs_mount(struct file_system_type *fs_type, int flags, const char *dev_name,
-	    void *data)
+static int befs_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, befs_fill_super);
+}
+
+static const struct fs_context_operations befs_context_ops = {
+	.parse_param	= befs_parse_param,
+	.get_tree	= befs_get_tree,
+	.reconfigure	= befs_reconfigure,
+	.free		= befs_free_fc,
+};
+
+static int befs_init_fs_context(struct fs_context *fc)
+{
+	struct befs_mount_options *opts;
+
+	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+
+	/* Initialize options */
+	opts->uid = GLOBAL_ROOT_UID;
+	opts->gid = GLOBAL_ROOT_GID;
+
+	fc->fs_private = opts;
+	fc->ops = &befs_context_ops;
+
+	return 0;
+}
+
+static void befs_free_fc(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, befs_fill_super);
+	struct befs_mount_options *opts = fc->fs_private;
+
+	kfree(opts->iocharset);
+	kfree(fc->fs_private);
 }
 
 static struct file_system_type befs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "befs",
-	.mount		= befs_mount,
 	.kill_sb	= kill_block_super,
 	.fs_flags	= FS_REQUIRES_DEV,
+	.init_fs_context = befs_init_fs_context,
+	.parameters	= befs_param_spec,
 };
 MODULE_ALIAS_FS("befs");
 
-- 
2.46.0


