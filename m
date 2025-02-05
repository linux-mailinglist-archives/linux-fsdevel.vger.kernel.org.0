Return-Path: <linux-fsdevel+bounces-40987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8415A29BEE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 22:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7489188885E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 21:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8E3215177;
	Wed,  5 Feb 2025 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvtDeG3n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563D215061
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791615; cv=none; b=Tmu8mPRt/u5nXD2umOUEcOCkLm5/AueO8ukrCLOOXSIwo5X8hOC8U3+luwReIejKAZ4lJTwoo0V4o/HIdKoftdWUsUTG0q/fhJCdPq0ZABeSwtbcc9YTz9XC0dWwjICcxrbNfxZCvUF8wEgsgF78duegK5mpLB2jMM5h095SbnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791615; c=relaxed/simple;
	bh=azwto8Wr25Sepyyo2DmLoxYZySV9Z0YPe4/TK7gylUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aB0aw4aEUO5zXqc3wpLyQWE1IhqsfTBWhdBmBgUPJ1ZBzfG+3y3TwiPU/GZJN/Q9iD2ouIi7ayJoDYZ4ERAezQ7GPLuGrmhwj8b7lBvsNpwnvmF5VlXx1wgFkvVkRDlDvlU0OYqkqGGzGlJq07WABq8ZhybK+HexidUOj2XzuTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvtDeG3n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738791612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0f0XlPODOFk/42r4cLPPvJRiuiBbme5HVwGFVIEHVSo=;
	b=LvtDeG3nDW2sNf3lHcyeNx/Hu5i+ggWjFOb6ey8o1o4qQeiW3jBwe2FR90esMSKr8iRCwr
	2ZqEAxwNsZt7BsC5A+waBlEwJ5zwRTvfb1fwU20tr33kDmWlAwyyCe03zilRq+iaSXEy0g
	d4G0kp5/8evZRRqGjgmxd3bypO/jA+g=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-2BBtx_8aNGWRO6RzbOHLsg-1; Wed, 05 Feb 2025 16:40:11 -0500
X-MC-Unique: 2BBtx_8aNGWRO6RzbOHLsg-1
X-Mimecast-MFC-AGG-ID: 2BBtx_8aNGWRO6RzbOHLsg
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-844e6476ab1so48612239f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2025 13:40:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738791610; x=1739396410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f0XlPODOFk/42r4cLPPvJRiuiBbme5HVwGFVIEHVSo=;
        b=LPBUyH3rZKOFXtxImqVmRYBJ7pgdlOcYk8On9/y+PfrwQ/cBzPRtnlDo1Onx4uQwUz
         /+20WBMWRdo4OgA+nR2ATsKjhQBRWG5U0pAQHk33eYdq7kKcNZMzcHzusmYJqxIlNyZc
         /adzQu8mNo1uIxRnq/EnZgo7buD3j8G7yUppmxyJeN5aXKCTHU1ylTwVdIAsssfFZeVh
         UeWLHPsFCpEDdNevvfYYZP21xi9gRk/A7tIX6hO9OqLt94Yyhp6wRk3NhR9OaVur2J/x
         8G0iFKvhap/jzUNKBBK8Ic6FrmjxhVvsS2K0pJuWhAEnXLoPujccR7EMHecxM54z9JIu
         X/CQ==
X-Gm-Message-State: AOJu0Yy7Pc+GNTyVUKSafQSmg7RjiAjwvXWFMU9+i3Ex7JNZcHrepzlr
	YHmXzo8fKegS/dvLEsHlFX8jXTrt6n4x1Hq8aBKXdq6UPuK+kmVULsNfzCjmV8wwOtLa+i061Ty
	//io+KhvOuErWkdyLHhrD5uuR2jfGXVAC389MZa0W5/pozuLc00WcvLENMLoBmcZe2tZJhE0gqv
	696G5k7zr6vN3HOO+6/dVg2UmV7A79c/U8nPkCAXrGCp029vhG
X-Gm-Gg: ASbGnct3JBebPgvgqaSK71EOIVyMhtWaTZWgwH/h2dgxIbOfO6xNNSkiiTuWLar+xnf
	gxJZHUDjeiO/862HnQj3waBhqPT2+QjYSIi5aUTVzFKdiS/z9ZAO1JQ9SLW4tlYNQHP/pw5w4YJ
	6ZJOE4dIWa6o1DrVebusd0/Hx5sKW+LfrNzA20wowTuQLMsnIhaOka2Kr5l1U/eQvctVqYkDI1E
	sQz4EcOBl/8OL7FbUqioadHDuH/LI1ys/IXi01Gwol0uZ06bxm04JsHbVQV0ypuhjwviQForu4P
	z9F4Lc+O46lIdYmpv5wOMKYXCPohs+SeJIwINLpIBEqR0j0rnozCiQ==
X-Received: by 2002:a05:6602:408f:b0:849:c82e:c03a with SMTP id ca18e2360f4ac-854ea5114fdmr490857739f.10.1738791610346;
        Wed, 05 Feb 2025 13:40:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPo0QZghJ2lYGnnMl6XP0Kul7jlCOlH53eHz79q79zQ/sCcUxBobXIq2HpdgPzsf91FtQLKg==
X-Received: by 2002:a05:6602:408f:b0:849:c82e:c03a with SMTP id ca18e2360f4ac-854ea5114fdmr490855139f.10.1738791609942;
        Wed, 05 Feb 2025 13:40:09 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a1717863sm368050839f.36.2025.02.05.13.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:40:09 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	neilb@suse.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	tony.luck@intel.com,
	David Howells <dhowells@redhat.com>,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 2/4] vfs: Convert devpts to use the new mount API
Date: Wed,  5 Feb 2025 15:34:30 -0600
Message-ID: <20250205213931.74614-3-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250205213931.74614-1-sandeen@redhat.com>
References: <20250205213931.74614-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

Convert the devpts filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: David Howells <dhowells@redhat.com>
[sandeen: forward port, keep pr_err vs errorf]
Co-developed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/devpts/inode.c | 251 ++++++++++++++++++++--------------------------
 1 file changed, 110 insertions(+), 141 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 1096ff8562fa..42e4d6eeb29f 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -12,6 +12,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/sched.h>
 #include <linux/namei.h>
 #include <linux/slab.h>
@@ -21,7 +23,6 @@
 #include <linux/magic.h>
 #include <linux/idr.h>
 #include <linux/devpts_fs.h>
-#include <linux/parser.h>
 #include <linux/fsnotify.h>
 #include <linux/seq_file.h>
 
@@ -87,14 +88,14 @@ enum {
 	Opt_err
 };
 
-static const match_table_t tokens = {
-	{Opt_uid, "uid=%u"},
-	{Opt_gid, "gid=%u"},
-	{Opt_mode, "mode=%o"},
-	{Opt_ptmxmode, "ptmxmode=%o"},
-	{Opt_newinstance, "newinstance"},
-	{Opt_max, "max=%d"},
-	{Opt_err, NULL}
+static const struct fs_parameter_spec devpts_param_specs[] = {
+	fsparam_u32	("gid",		Opt_gid),
+	fsparam_s32	("max",		Opt_max),
+	fsparam_u32oct	("mode",	Opt_mode),
+	fsparam_flag	("newinstance",	Opt_newinstance),
+	fsparam_u32oct	("ptmxmode",	Opt_ptmxmode),
+	fsparam_u32	("uid",		Opt_uid),
+	{}
 };
 
 struct pts_fs_info {
@@ -214,93 +215,48 @@ void devpts_release(struct pts_fs_info *fsi)
 	deactivate_super(fsi->sb);
 }
 
-#define PARSE_MOUNT	0
-#define PARSE_REMOUNT	1
-
 /*
- * parse_mount_options():
- *	Set @opts to mount options specified in @data. If an option is not
- *	specified in @data, set it to its default value.
- *
- * Note: @data may be NULL (in which case all options are set to default).
+ * devpts_parse_param - Parse mount parameters
  */
-static int parse_mount_options(char *data, int op, struct pts_mount_opts *opts)
+static int devpts_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *p;
-	kuid_t uid;
-	kgid_t gid;
-
-	opts->setuid  = 0;
-	opts->setgid  = 0;
-	opts->uid     = GLOBAL_ROOT_UID;
-	opts->gid     = GLOBAL_ROOT_GID;
-	opts->mode    = DEVPTS_DEFAULT_MODE;
-	opts->ptmxmode = DEVPTS_DEFAULT_PTMX_MODE;
-	opts->max     = NR_UNIX98_PTY_MAX;
-
-	/* Only allow instances mounted from the initial mount
-	 * namespace to tap the reserve pool of ptys.
-	 */
-	if (op == PARSE_MOUNT)
-		opts->reserve =
-			(current->nsproxy->mnt_ns == init_task.nsproxy->mnt_ns);
-
-	while ((p = strsep(&data, ",")) != NULL) {
-		substring_t args[MAX_OPT_ARGS];
-		int token;
-		int option;
-
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_uid:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(uid))
-				return -EINVAL;
-			opts->uid = uid;
-			opts->setuid = 1;
-			break;
-		case Opt_gid:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(gid))
-				return -EINVAL;
-			opts->gid = gid;
-			opts->setgid = 1;
-			break;
-		case Opt_mode:
-			if (match_octal(&args[0], &option))
-				return -EINVAL;
-			opts->mode = option & S_IALLUGO;
-			break;
-		case Opt_ptmxmode:
-			if (match_octal(&args[0], &option))
-				return -EINVAL;
-			opts->ptmxmode = option & S_IALLUGO;
-			break;
-		case Opt_newinstance:
-			break;
-		case Opt_max:
-			if (match_int(&args[0], &option) ||
-			    option < 0 || option > NR_UNIX98_PTY_MAX)
-				return -EINVAL;
-			opts->max = option;
-			break;
-		default:
-			pr_err("called with bogus options\n");
-			return -EINVAL;
-		}
+	struct pts_fs_info *fsi = fc->s_fs_info;
+	struct pts_mount_opts *opts = &fsi->mount_opts;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, devpts_param_specs, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_uid:
+		opts->uid = result.uid;
+		opts->setuid = 1;
+		break;
+	case Opt_gid:
+		opts->gid = result.gid;
+		opts->setgid = 1;
+		break;
+	case Opt_mode:
+		opts->mode = result.uint_32 & S_IALLUGO;
+		break;
+	case Opt_ptmxmode:
+		opts->ptmxmode = result.uint_32 & S_IALLUGO;
+		break;
+	case Opt_newinstance:
+		break;
+	case Opt_max:
+		if (result.uint_32 > NR_UNIX98_PTY_MAX)
+			return invalf(fc, "max out of range");
+		opts->max = result.uint_32;
+		break;
 	}
 
 	return 0;
 }
 
-static int mknod_ptmx(struct super_block *sb)
+static int mknod_ptmx(struct super_block *sb, struct fs_context *fc)
 {
 	int mode;
 	int rc = -ENOMEM;
@@ -362,13 +318,23 @@ static void update_ptmx_mode(struct pts_fs_info *fsi)
 	}
 }
 
-static int devpts_remount(struct super_block *sb, int *flags, char *data)
+static int devpts_reconfigure(struct fs_context *fc)
 {
-	int err;
-	struct pts_fs_info *fsi = DEVPTS_SB(sb);
-	struct pts_mount_opts *opts = &fsi->mount_opts;
+	struct pts_fs_info *fsi = DEVPTS_SB(fc->root->d_sb);
+	struct pts_fs_info *new = fc->s_fs_info;
 
-	err = parse_mount_options(data, PARSE_REMOUNT, opts);
+	/* Apply the revised options.  We don't want to change ->reserve.
+	 * Ideally, we'd update each option conditionally on it having been
+	 * explicitly changed, but the default is to reset everything so that
+	 * would break UAPI...
+	 */
+	fsi->mount_opts.setuid		= new->mount_opts.setuid;
+	fsi->mount_opts.setgid		= new->mount_opts.setgid;
+	fsi->mount_opts.uid		= new->mount_opts.uid;
+	fsi->mount_opts.gid		= new->mount_opts.gid;
+	fsi->mount_opts.mode		= new->mount_opts.mode;
+	fsi->mount_opts.ptmxmode	= new->mount_opts.ptmxmode;
+	fsi->mount_opts.max		= new->mount_opts.max;
 
 	/*
 	 * parse_mount_options() restores options to default values
@@ -378,7 +344,7 @@ static int devpts_remount(struct super_block *sb, int *flags, char *data)
 	 */
 	update_ptmx_mode(fsi);
 
-	return err;
+	return 0;
 }
 
 static int devpts_show_options(struct seq_file *seq, struct dentry *root)
@@ -402,31 +368,13 @@ static int devpts_show_options(struct seq_file *seq, struct dentry *root)
 
 static const struct super_operations devpts_sops = {
 	.statfs		= simple_statfs,
-	.remount_fs	= devpts_remount,
 	.show_options	= devpts_show_options,
 };
 
-static void *new_pts_fs_info(struct super_block *sb)
-{
-	struct pts_fs_info *fsi;
-
-	fsi = kzalloc(sizeof(struct pts_fs_info), GFP_KERNEL);
-	if (!fsi)
-		return NULL;
-
-	ida_init(&fsi->allocated_ptys);
-	fsi->mount_opts.mode = DEVPTS_DEFAULT_MODE;
-	fsi->mount_opts.ptmxmode = DEVPTS_DEFAULT_PTMX_MODE;
-	fsi->sb = sb;
-
-	return fsi;
-}
-
-static int
-devpts_fill_super(struct super_block *s, void *data, int silent)
+static int devpts_fill_super(struct super_block *s, struct fs_context *fc)
 {
+	struct pts_fs_info *fsi = DEVPTS_SB(s);
 	struct inode *inode;
-	int error;
 
 	s->s_iflags &= ~SB_I_NODEV;
 	s->s_blocksize = 1024;
@@ -435,20 +383,11 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	s->s_op = &devpts_sops;
 	s->s_d_op = &simple_dentry_operations;
 	s->s_time_gran = 1;
+	fsi->sb = s;
 
-	error = -ENOMEM;
-	s->s_fs_info = new_pts_fs_info(s);
-	if (!s->s_fs_info)
-		goto fail;
-
-	error = parse_mount_options(data, PARSE_MOUNT, &DEVPTS_SB(s)->mount_opts);
-	if (error)
-		goto fail;
-
-	error = -ENOMEM;
 	inode = new_inode(s);
 	if (!inode)
-		goto fail;
+		return -ENOMEM;
 	inode->i_ino = 1;
 	simple_inode_init_ts(inode);
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR;
@@ -459,31 +398,60 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	s->s_root = d_make_root(inode);
 	if (!s->s_root) {
 		pr_err("get root dentry failed\n");
-		goto fail;
+		return -ENOMEM;
 	}
 
-	error = mknod_ptmx(s);
-	if (error)
-		goto fail_dput;
-
-	return 0;
-fail_dput:
-	dput(s->s_root);
-	s->s_root = NULL;
-fail:
-	return error;
+	return mknod_ptmx(s, fc);
 }
 
 /*
- * devpts_mount()
+ * devpts_get_tree()
  *
  *     Mount a new (private) instance of devpts.  PTYs created in this
  *     instance are independent of the PTYs in other devpts instances.
  */
-static struct dentry *devpts_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int devpts_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, devpts_fill_super);
+}
+
+static void devpts_free_fc(struct fs_context *fc)
+{
+	kfree(fc->s_fs_info);
+}
+
+static const struct fs_context_operations devpts_context_ops = {
+	.free		= devpts_free_fc,
+	.parse_param	= devpts_parse_param,
+	.get_tree	= devpts_get_tree,
+	.reconfigure	= devpts_reconfigure,
+};
+
+/*
+ * Set up the filesystem mount context.
+ */
+static int devpts_init_fs_context(struct fs_context *fc)
 {
-	return mount_nodev(fs_type, flags, data, devpts_fill_super);
+	struct pts_fs_info *fsi;
+
+	fsi = kzalloc(sizeof(struct pts_fs_info), GFP_KERNEL);
+	if (!fsi)
+		return -ENOMEM;
+
+	ida_init(&fsi->allocated_ptys);
+	fsi->mount_opts.uid     = GLOBAL_ROOT_UID;
+	fsi->mount_opts.gid     = GLOBAL_ROOT_GID;
+	fsi->mount_opts.mode    = DEVPTS_DEFAULT_MODE;
+	fsi->mount_opts.ptmxmode = DEVPTS_DEFAULT_PTMX_MODE;
+	fsi->mount_opts.max     = NR_UNIX98_PTY_MAX;
+
+	if (fc->purpose == FS_CONTEXT_FOR_MOUNT &&
+	    current->nsproxy->mnt_ns == init_task.nsproxy->mnt_ns)
+		fsi->mount_opts.reserve = true;
+
+	fc->s_fs_info = fsi;
+	fc->ops = &devpts_context_ops;
+	return 0;
 }
 
 static void devpts_kill_sb(struct super_block *sb)
@@ -498,7 +466,8 @@ static void devpts_kill_sb(struct super_block *sb)
 
 static struct file_system_type devpts_fs_type = {
 	.name		= "devpts",
-	.mount		= devpts_mount,
+	.init_fs_context = devpts_init_fs_context,
+	.parameters	= devpts_param_specs,
 	.kill_sb	= devpts_kill_sb,
 	.fs_flags	= FS_USERNS_MOUNT,
 };
-- 
2.48.0


