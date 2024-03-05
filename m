Return-Path: <linux-fsdevel+bounces-13669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0663872AD1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 00:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471691F21C87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 23:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112712D20D;
	Tue,  5 Mar 2024 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lrj3l22d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B241760
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 23:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709680178; cv=none; b=iJgHNixswyQ17EZt5TAF4cO/huuRNlOizW5FkgQNRfoKJYq+gewKMbFbMhyunD2H4t7PfBOmAp1SQdetnYN+LgYxccHVl3elne80vxS2D7k+DKinlx0HvfLguJa+jOn/CWSJSQ5Sd+SypEOUUn0fl9zrjqHh1Dlph5ZwGBpHVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709680178; c=relaxed/simple;
	bh=IJ9aojpkJmxYtFGSIIJ9LCRD3xs5LMQNYlnl0wvLuXQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r680UTvhE1FJW9CuPmw8OiPI5oopUP75sODgSnOTIG1cqPhU37qbqPdhrdCXhFMxFv9FSX5gH1qPQt0uvS47nglErZ5mQUK9jY+Z99aMhUlMXw5oh80Vd7gwEhv2HvLkdlucmWP3F7NHghmmLgvCRop/z0pbJISyw+b50Y5lSqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lrj3l22d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709680175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJaQu7t353O8uY3bvGcCFr7/5QWG6aSanVNZbb37UEY=;
	b=Lrj3l22dhLxMksgQ226BVY/AYiLkKNtT2U2S141ucLAotcH9iL6mE8wPq+SJxfxHwHvVSL
	KYeWGeDuXMYN3PAbiS4tpXNO703Q0aLT+EIoYjwnnELeBJ1k8R73f1s1JIT6b8JZkGnMGX
	OEEsQ9hxnUNzQNrd0UJvtvk8Y+GO24c=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-8sPRQ032Nqu-K7mlokC2Uw-1; Tue, 05 Mar 2024 18:09:34 -0500
X-MC-Unique: 8sPRQ032Nqu-K7mlokC2Uw-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c49c867608so649752739f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 15:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709680172; x=1710284972;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJaQu7t353O8uY3bvGcCFr7/5QWG6aSanVNZbb37UEY=;
        b=BnAR9Tj/4REWP23Yaf5Nv8H16KUdAAode8C/sF5qgt36ClI8zGJlPfhnA2umo7cLSy
         EfnafdEkaZfSGNTC/Yz84ei4pdcuhKHjdcMR7S0MqJGAf5ONBoAp/qiBmyE6jss7ROkX
         1vZXRa2HnnnmoFP07/p/cnG9z899du4BhxQYOoFLiBM7AKHQEAHT9j46OxW0n5okhWE6
         Vnk7H+zjqj1Tjp0eKSCLRxn9VmIGortgUi10uHvaZs20f/iG3OgUhvOnIFIi3sWOx23L
         xCNQaOwRM3N0fBxwDBNSHHUPYUtzjv+tUY51f2IdWYCzC6+bquB1aNoqLY+4h74P+Q04
         Cr+Q==
X-Gm-Message-State: AOJu0YwYhl/nBUshKysR8hOr+nxaMnsqhGkZ5xPvevaPUhIsHwfEE1We
	1JgbA2P2VGFOvXTIPMZdMWaPZTmVKgd2dcR8p+V5shveBEKzmJel4Ob5D59QsI58xGgpBSPj6xK
	AJWaCvhNigvsuj8I+1vpjPBxSLSiiQaeg3IunKXWn32h8kf57VTcC9zxd7Vh5/94mxwhXmFuN5k
	Oz45ECIQH8trwxtUwHbwWRtybALXwwReaNOEc1M2upRCYfmWyq
X-Received: by 2002:a05:6e02:1c82:b0:365:1563:c4e5 with SMTP id w2-20020a056e021c8200b003651563c4e5mr17433775ill.9.1709680172467;
        Tue, 05 Mar 2024 15:09:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmmRL2kuGmWOveWvjB3db+x8Z5UB73/B5/cIrRIb0BYvejzdOdxkRVo5061OWPaQVqMdUCNA==
X-Received: by 2002:a05:6e02:1c82:b0:365:1563:c4e5 with SMTP id w2-20020a056e021c8200b003651563c4e5mr17433755ill.9.1709680172125;
        Tue, 05 Mar 2024 15:09:32 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id u11-20020a92d1cb000000b0036600aa51dbsm390770ilg.47.2024.03.05.15.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 15:09:31 -0800 (PST)
Message-ID: <536e99d3-345c-448b-adee-a21389d7ab4b@redhat.com>
Date: Tue, 5 Mar 2024 17:09:30 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] vfs: Convert tracefs to use the new mount API
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Bill O'Donnell <billodo@redhat.com>,
 David Howells <dhowells@redhat.com>
References: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
In-Reply-To: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: David Howells <dhowells@redhat.com>

Convert the tracefs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
[sandeen: forward port to modern kernel, fix remounting]
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/tracefs/inode.c | 196 +++++++++++++++++++++------------------------
 1 file changed, 91 insertions(+), 105 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index d65ffad4c327..69d0fb2e03a2 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -11,14 +11,14 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
-#include <linux/mount.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
 #include <linux/tracefs.h>
 #include <linux/fsnotify.h>
 #include <linux/security.h>
 #include <linux/seq_file.h>
-#include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
 #include "internal.h"
@@ -231,7 +231,7 @@ struct inode *tracefs_get_inode(struct super_block *sb)
 	return inode;
 }
 
-struct tracefs_mount_opts {
+struct tracefs_fs_info {
 	kuid_t uid;
 	kgid_t gid;
 	umode_t mode;
@@ -243,68 +243,51 @@ enum {
 	Opt_uid,
 	Opt_gid,
 	Opt_mode,
-	Opt_err
 };
 
-static const match_table_t tokens = {
-	{Opt_uid, "uid=%u"},
-	{Opt_gid, "gid=%u"},
-	{Opt_mode, "mode=%o"},
-	{Opt_err, NULL}
+static const struct fs_parameter_spec tracefs_param_specs[] = {
+	fsparam_u32	("gid",		Opt_gid),
+	fsparam_u32oct	("mode",	Opt_mode),
+	fsparam_u32	("uid",		Opt_uid),
+	{}
 };
 
-struct tracefs_fs_info {
-	struct tracefs_mount_opts mount_opts;
-};
-
-static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
+static int tracefs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-	int token;
+	struct tracefs_fs_info *opts = fc->s_fs_info;
+	struct fs_parse_result result;
 	kuid_t uid;
 	kgid_t gid;
-	char *p;
-
-	opts->opts = 0;
-	opts->mode = TRACEFS_DEFAULT_MODE;
-
-	while ((p = strsep(&data, ",")) != NULL) {
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
-			break;
-		case Opt_gid:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(gid))
-				return -EINVAL;
-			opts->gid = gid;
-			break;
-		case Opt_mode:
-			if (match_octal(&args[0], &option))
-				return -EINVAL;
-			opts->mode = option & S_IALLUGO;
-			break;
-		/*
-		 * We might like to report bad mount options here;
-		 * but traditionally tracefs has ignored all mount options
-		 */
-		}
-
-		opts->opts |= BIT(token);
+	int opt;
+
+	opt = fs_parse(fc, tracefs_param_specs, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_uid:
+		uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(uid))
+			return invalf(fc, "Unknown uid");
+		opts->uid = uid;
+		break;
+	case Opt_gid:
+		gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(gid))
+			return invalf(fc, "Unknown gid");
+		opts->gid = gid;
+		break;
+	case Opt_mode:
+		opts->mode = result.uint_32 & S_IALLUGO;
+		break;
+	/*
+	 * We might like to report bad mount options here;
+	 * but traditionally tracefs has ignored all mount options
+	 */
 	}
 
+	opts->opts |= BIT(opt);
+
 	return 0;
 }
 
@@ -312,7 +295,6 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 {
 	struct tracefs_fs_info *fsi = sb->s_fs_info;
 	struct inode *inode = d_inode(sb->s_root);
-	struct tracefs_mount_opts *opts = &fsi->mount_opts;
 	umode_t tmp_mode;
 
 	/*
@@ -320,50 +302,46 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 	 * options.
 	 */
 
-	if (!remount || opts->opts & BIT(Opt_mode)) {
+	if (!remount || fsi->opts & BIT(Opt_mode)) {
 		tmp_mode = READ_ONCE(inode->i_mode) & ~S_IALLUGO;
-		tmp_mode |= opts->mode;
+		tmp_mode |= fsi->mode;
 		WRITE_ONCE(inode->i_mode, tmp_mode);
 	}
 
-	if (!remount || opts->opts & BIT(Opt_uid))
-		inode->i_uid = opts->uid;
+	if (!remount || fsi->opts & BIT(Opt_uid))
+		inode->i_uid = fsi->uid;
 
-	if (!remount || opts->opts & BIT(Opt_gid))
-		inode->i_gid = opts->gid;
+	if (!remount || fsi->opts & BIT(Opt_gid))
+		inode->i_gid = fsi->gid;
 
 	return 0;
 }
 
-static int tracefs_remount(struct super_block *sb, int *flags, char *data)
+static int tracefs_reconfigure(struct fs_context *fc)
 {
-	int err;
-	struct tracefs_fs_info *fsi = sb->s_fs_info;
+	struct super_block *sb = fc->root->d_sb;
+	struct tracefs_fs_info *sb_opts = sb->s_fs_info;
+	struct tracefs_fs_info *new_opts = fc->s_fs_info;
 
 	sync_filesystem(sb);
-	err = tracefs_parse_options(data, &fsi->mount_opts);
-	if (err)
-		goto fail;
+	/* structure copy of new mount options to sb */
+	*sb_opts = *new_opts;
 
-	tracefs_apply_options(sb, true);
-
-fail:
-	return err;
+	return tracefs_apply_options(sb, true);
 }
 
 static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct tracefs_fs_info *fsi = root->d_sb->s_fs_info;
-	struct tracefs_mount_opts *opts = &fsi->mount_opts;
 
-	if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
+	if (!uid_eq(fsi->uid, GLOBAL_ROOT_UID))
 		seq_printf(m, ",uid=%u",
-			   from_kuid_munged(&init_user_ns, opts->uid));
-	if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
+			   from_kuid_munged(&init_user_ns, fsi->uid));
+	if (!gid_eq(fsi->gid, GLOBAL_ROOT_GID))
 		seq_printf(m, ",gid=%u",
-			   from_kgid_munged(&init_user_ns, opts->gid));
-	if (opts->mode != TRACEFS_DEFAULT_MODE)
-		seq_printf(m, ",mode=%o", opts->mode);
+			   from_kgid_munged(&init_user_ns, fsi->gid));
+	if (fsi->mode != TRACEFS_DEFAULT_MODE)
+		seq_printf(m, ",mode=%o", fsi->mode);
 
 	return 0;
 }
@@ -373,7 +351,6 @@ static const struct super_operations tracefs_super_operations = {
 	.free_inode     = tracefs_free_inode,
 	.drop_inode     = generic_delete_inode,
 	.statfs		= simple_statfs,
-	.remount_fs	= tracefs_remount,
 	.show_options	= tracefs_show_options,
 };
 
@@ -403,26 +380,14 @@ static const struct dentry_operations tracefs_dentry_operations = {
 	.d_release = tracefs_d_release,
 };
 
-static int trace_fill_super(struct super_block *sb, void *data, int silent)
+static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr trace_files[] = {{""}};
-	struct tracefs_fs_info *fsi;
 	int err;
 
-	fsi = kzalloc(sizeof(struct tracefs_fs_info), GFP_KERNEL);
-	sb->s_fs_info = fsi;
-	if (!fsi) {
-		err = -ENOMEM;
-		goto fail;
-	}
-
-	err = tracefs_parse_options(data, &fsi->mount_opts);
-	if (err)
-		goto fail;
-
-	err  =  simple_fill_super(sb, TRACEFS_MAGIC, trace_files);
+	err = simple_fill_super(sb, TRACEFS_MAGIC, trace_files);
 	if (err)
-		goto fail;
+		return err;
 
 	sb->s_op = &tracefs_super_operations;
 	sb->s_d_op = &tracefs_dentry_operations;
@@ -430,24 +395,45 @@ static int trace_fill_super(struct super_block *sb, void *data, int silent)
 	tracefs_apply_options(sb, false);
 
 	return 0;
+}
 
-fail:
-	kfree(fsi);
-	sb->s_fs_info = NULL;
-	return err;
+static int tracefs_get_tree(struct fs_context *fc)
+{
+	return get_tree_single(fc, tracefs_fill_super);
 }
 
-static struct dentry *trace_mount(struct file_system_type *fs_type,
-			int flags, const char *dev_name,
-			void *data)
+static void tracefs_free_fc(struct fs_context *fc)
 {
-	return mount_single(fs_type, flags, data, trace_fill_super);
+	kfree(fc->s_fs_info);
+}
+
+static const struct fs_context_operations tracefs_context_ops = {
+	.free		= tracefs_free_fc,
+	.parse_param	= tracefs_parse_param,
+	.get_tree	= tracefs_get_tree,
+	.reconfigure	= tracefs_reconfigure,
+};
+
+static int tracefs_init_fs_context(struct fs_context *fc)
+{
+	struct tracefs_fs_info *fsi;
+
+	fsi = kzalloc(sizeof(struct tracefs_fs_info), GFP_KERNEL);
+	if (!fsi)
+		return -ENOMEM;
+
+	fsi->mode = TRACEFS_DEFAULT_MODE;
+
+	fc->s_fs_info = fsi;
+	fc->ops = &tracefs_context_ops;
+	return 0;
 }
 
 static struct file_system_type trace_fs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"tracefs",
-	.mount =	trace_mount,
+	.init_fs_context = tracefs_init_fs_context,
+	.parameters	= tracefs_param_specs,
 	.kill_sb =	kill_litter_super,
 };
 MODULE_ALIAS_FS("tracefs");
-- 
2.43.0


