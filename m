Return-Path: <linux-fsdevel+bounces-27949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DFA964F2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 21:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAC91F24290
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C087A1BA88E;
	Thu, 29 Aug 2024 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6pjIAbi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7CB1BB69E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960337; cv=none; b=cEwhrj0bHcI9yvYIE5A1muzFVR4h8F6yh4Op1UY0duLv+ZkHJRGNRBCtSFNJZokSonNIyOXPoJAXcyhutor8ySqKCdrpUJZzNi6PqOeztXcLVjK+IX/4k124Zg1rhQngZ8g4NSvMKvGBkXabzt8F8wP+5DwkEtSKYBMkovIFJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960337; c=relaxed/simple;
	bh=Tx4LeCNgHOv5zycaowkINmI0w4aalfQW2b4D4xuiZuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fq9Zty3oMKaHAcToD0xaR6otkxiDbNfjlCjj3yNgsw+txkGOWlRmfdVpnwYNwElwiddUBcw1NzHyMW+7TJyIfOXNL+3fn1AoqxxI2JW3S+dsDfX0MjJh2AQ0dTP3uIpBzgpszrARs+rM/EG6ZNk8AyAAUyTdFcjKLuGX5TFVd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6pjIAbi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724960334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZYiwb0SV9hfiP7UcHKqqBveeWtPqimI4x9Aq9jAjLU=;
	b=D6pjIAbiSvmjUOuMshRz2eKaqEzK4pVmepXSHcrC8NkrOHOrIWDD0wy8wJVeOI0S8h2Oq5
	i+G5bOCdiMVGoD+Uv8yDGK2Y3zv6hT0PlHmYuauZFXqgdeldU2YLEop2N4KTRSpWC/WF73
	lo2MLngmrtHa9SDkpOz/C7gOqW3DuFc=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-57VeBrZ3Mem89F8xA-0flw-1; Thu, 29 Aug 2024 15:38:53 -0400
X-MC-Unique: 57VeBrZ3Mem89F8xA-0flw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a1c81b736so105106739f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 12:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724960332; x=1725565132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZYiwb0SV9hfiP7UcHKqqBveeWtPqimI4x9Aq9jAjLU=;
        b=usbEchCbgl8qvbllFEWO6IqISKlTU0UbwaMUNCi0WuNcF3RlfE7h7RYpVC/aWd7ieA
         3+sykySu4SdkXzlJqhVg5PJrGxxXmH3L2p3tcBSu6Xd33ojt6hVFdZwR8O13WEuBF6mL
         XpBqenb22JkOcQKRhBZqPB4XKHAIvX4KAlcVhcZeiyGzLcIcMBlqaAWEfDShFUxJt4u6
         Hr/LGPhDL2gsW5T88Uavc/khdKpolxqxaPvXstS4OOo5cUInwsOXvF6ouZLDSFBjmBN9
         sSDdOlHuTL5zhZmew8Gq6AuqQrWvSj7QSrCm16q5YHC+nQOEOm7AWqgLfXaOGXq8aPwk
         AV5g==
X-Gm-Message-State: AOJu0YxY3IXpv2I9SDJ9He/9ed9GRsBIZvi+9UO3ECzC+6crILWgS5S5
	cCo6f3Ov/iRHClgQoHg0zkBnmewQv/H4APO/YaLMnCLLHMOAtGsQC9YFhDxY6rgJgjqlT89qa9A
	9PCO5TYrd0RtJ0uu13kOHYrmNzo8SP/t4Vze1+vwlbl6oFMq3bdoQbRMAvQfMO96KmDaLfq/PI6
	kJMxboka8oanv6BTlOlkum/ENnBzkY0+phPcIb8sqk9BBgTw==
X-Received: by 2002:a05:6e02:1c4a:b0:39d:2625:b565 with SMTP id e9e14a558f8ab-39f37837ec0mr51395235ab.19.1724960332439;
        Thu, 29 Aug 2024 12:38:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl7LBqrnn81FLqsCnNnLvnsLN44zL5OYH10n6ixgcpGkbmKkqNfjC3tNGYp69FvAaWGZk27Q==
X-Received: by 2002:a05:6e02:1c4a:b0:39d:2625:b565 with SMTP id e9e14a558f8ab-39f37837ec0mr51395035ab.19.1724960331959;
        Thu, 29 Aug 2024 12:38:51 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3b058880sm4388025ab.74.2024.08.29.12.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:38:51 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	Eric Sandeen <sandeen@redhat.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH 3/3] befs: convert befs to use the new mount api
Date: Thu, 29 Aug 2024 15:40:01 -0400
Message-ID: <20240829194138.2073709-4-sandeen@redhat.com>
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

Convert the befs filesystem to use the new mount API.
Tested by comparing random mount & remount options before and after
the change.

Cc: Luis de Bethencourt <luisbg@kernel.org>
Cc: Salah Triki <salah.triki@gmail.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/befs/linuxvfs.c | 183 +++++++++++++++++++++------------------------
 1 file changed, 85 insertions(+), 98 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index f92f108840f5..2d59943e9681 100644
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
@@ -800,7 +760,7 @@ befs_put_super(struct super_block *sb)
  * Load a set of NLS translations if needed.
  */
 static int
-befs_fill_super(struct super_block *sb, void *data, int silent)
+befs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct buffer_head *bh;
 	struct befs_sb_info *befs_sb;
@@ -810,6 +770,8 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 	const unsigned long sb_block = 0;
 	const off_t x86_sb_off = 512;
 	int blocksize;
+	struct befs_mount_options *opts = fc->fs_private;
+	int silent = fc->sb_flags & SB_SILENT;
 
 	sb->s_fs_info = kzalloc(sizeof(*befs_sb), GFP_KERNEL);
 	if (sb->s_fs_info == NULL)
@@ -817,14 +779,10 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 
 	befs_sb = BEFS_SB(sb);
 
-	if (!parse_options((char *) data, &befs_sb->mount_opts)) {
-		if (!silent)
-			befs_error(sb, "cannot parse mount options");
-		goto unacquire_priv_sbp;
-	}
-
 	befs_debug(sb, "---> %s", __func__);
 
+	befs_sb->mount_opts = *opts;
+
 	if (!sb_rdonly(sb)) {
 		befs_warning(sb,
 			     "No write support. Marking filesystem read-only");
@@ -934,10 +892,10 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
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
@@ -965,19 +923,48 @@ befs_statfs(struct dentry *dentry, struct kstatfs *buf)
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


