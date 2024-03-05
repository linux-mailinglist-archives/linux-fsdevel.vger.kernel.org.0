Return-Path: <linux-fsdevel+bounces-13668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09B6872AD0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 00:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BBA1F229FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 23:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE08812D20E;
	Tue,  5 Mar 2024 23:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoC9sk/N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2670D41760
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709680127; cv=none; b=W1fZ84VhEL837OU29swC7uJShONPZ/6y7J3pU+d6sPQTS6o76TPAgNUIosgN8UgIAQNJIiPfCi26TKeMliMjqBpCBx8D4ib9UpbHHiaPIm/U0LiRleMbOYqHgCDxxGWJ3E8AqvzZ8WGrbkXehN3zkjz/otIr9IARTaoitfgQiys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709680127; c=relaxed/simple;
	bh=WahJi691px2HbISMWp7obAm0qtvVi/xNabmzwdrhntg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gi2xLrjgwSZ3t3F5of+KyZR5fh5OAVZhFUxpXFQfGwgaFvI/gDB+kGpIVT4dEZi4U7S5Q+XSsisxK9qhtp/QL8Wm/FAu5TMdDiZLtbkXBkf1O2htcA6g2U4M6TIVh+0agI1zqawP03TMjzOqrnhyI3eGStBAIOsMNle6NBTbQz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WoC9sk/N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709680124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4zEhLylkVYxuq8jN+r2udJ/BfLYP8M/KqSxgUaIftk=;
	b=WoC9sk/NcHfTXcOrCD9NJ17MivG7Fsy8lIinXw51OncdtVjkkn/GeGPK2PijJ/eus2ldeH
	8CbFxJsyhA6IdVCC59KLZlOBD93J6zPjrcEKeBmeqmaE82w5IL68BxNwWnIRvsPYSVEgdE
	RgMRN7C9m6bk3TQ/SFK/zkaZcCxFMCE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-QFpHNVP3M_-d1KGWhEnuKQ-1; Tue, 05 Mar 2024 18:08:42 -0500
X-MC-Unique: QFpHNVP3M_-d1KGWhEnuKQ-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3651a261194so13154385ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 15:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709680121; x=1710284921;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4zEhLylkVYxuq8jN+r2udJ/BfLYP8M/KqSxgUaIftk=;
        b=i34hadXUoZ1khaqbhEQFIIMVTgOETEhhm5Yh1UTbTrA0ZOUSIlstZTslqnidPjMf+w
         OFBHy2fc82vfC6y80gtWrCesODasxYPLfWrxprBXs35Yu3p8aNP1iVwlvI7nWDrMedF3
         DDZ5Ek9MPDL3OyqNq+u/3Uojb7ly2rNe75OfZqrIC2KmTQ3Nfo2prB5DREQLzAJrgj1N
         Mm3aBCOcPxbdO4EtcXZK1ypDaSWIS0MIFzAbRgq1V/z9G1TgD8WjcKpNwKyo6zDRVWro
         9rHa4b0axwSP+1PqE4xcgaG+qS755kIjJREAs7qBsYzze5BpmAyZvjmzY9QT0AYIlBIa
         JMHw==
X-Gm-Message-State: AOJu0Yy+1hWVsv+G9RJ4omuBXr0lLFvizNoxBts1NyyDF5Oq8K3kIpll
	R7vXCMFGo+Agj7MmiG6OaZx6N/JPBNHGKiYUCXB3MplrZJsmGcQOeuP5FBK1lljxr4Bs3tNQmDT
	wnp1chlVKaIk9btIHnfpXWpY2DzzX8tbts75GNy0Ojknhjd1LavmPbi6z1SkH/5QSnnqoJ9r5ZU
	OpD73/Ei5Z4jhFIvhcl8/Lj+5PkFZyMJhY7h4jqKIPl54emc5a
X-Received: by 2002:a92:2a12:0:b0:365:fe08:8268 with SMTP id r18-20020a922a12000000b00365fe088268mr2432965ile.5.1709680121029;
        Tue, 05 Mar 2024 15:08:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMtMbVl5rdNWnHCtrmrtao16YtmiXNjBFhb1rTLa/2uPILDGeH74WPU7dzzgc9lLERTJ68eA==
X-Received: by 2002:a92:2a12:0:b0:365:fe08:8268 with SMTP id r18-20020a922a12000000b00365fe088268mr2432931ile.5.1709680120621;
        Tue, 05 Mar 2024 15:08:40 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id u11-20020a92d1cb000000b0036600aa51dbsm390770ilg.47.2024.03.05.15.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 15:08:40 -0800 (PST)
Message-ID: <49d1f108-46e3-443f-85a3-6dd730c5d076@redhat.com>
Date: Tue, 5 Mar 2024 17:08:39 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] vfs: Convert debugfs to use the new mount API
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

Convert the debugfs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
[sandeen: forward port to modern kernel, fix remounting]
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 fs/debugfs/inode.c | 198 +++++++++++++++++++++------------------------
 1 file changed, 93 insertions(+), 105 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 034a617cb1a5..c2adfb272da8 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -14,7 +14,8 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
-#include <linux/mount.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/kobject.h>
@@ -23,7 +24,6 @@
 #include <linux/fsnotify.h>
 #include <linux/string.h>
 #include <linux/seq_file.h>
-#include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
 #include <linux/security.h>
@@ -77,7 +77,7 @@ static struct inode *debugfs_get_inode(struct super_block *sb)
 	return inode;
 }
 
-struct debugfs_mount_opts {
+struct debugfs_fs_info {
 	kuid_t uid;
 	kgid_t gid;
 	umode_t mode;
@@ -89,68 +89,51 @@ enum {
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
+static const struct fs_parameter_spec debugfs_param_specs[] = {
+	fsparam_u32	("gid",		Opt_gid),
+	fsparam_u32oct	("mode",	Opt_mode),
+	fsparam_u32	("uid",		Opt_uid),
+	{}
 };
 
-struct debugfs_fs_info {
-	struct debugfs_mount_opts mount_opts;
-};
-
-static int debugfs_parse_options(char *data, struct debugfs_mount_opts *opts)
+static int debugfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-	int token;
+	struct debugfs_fs_info *opts = fc->s_fs_info;
+	struct fs_parse_result result;
 	kuid_t uid;
 	kgid_t gid;
-	char *p;
-
-	opts->opts = 0;
-	opts->mode = DEBUGFS_DEFAULT_MODE;
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
-		 * but traditionally debugfs has ignored all mount options
-		 */
-		}
-
-		opts->opts |= BIT(token);
+	int opt;
+
+	opt = fs_parse(fc, debugfs_param_specs, param, &result);
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
+	 * but traditionally debugfs has ignored all mount options
+	 */
 	}
 
+	opts->opts |= BIT(opt);
+
 	return 0;
 }
 
@@ -158,23 +141,22 @@ static void _debugfs_apply_options(struct super_block *sb, bool remount)
 {
 	struct debugfs_fs_info *fsi = sb->s_fs_info;
 	struct inode *inode = d_inode(sb->s_root);
-	struct debugfs_mount_opts *opts = &fsi->mount_opts;
 
 	/*
 	 * On remount, only reset mode/uid/gid if they were provided as mount
 	 * options.
 	 */
 
-	if (!remount || opts->opts & BIT(Opt_mode)) {
+	if (!remount || fsi->opts & BIT(Opt_mode)) {
 		inode->i_mode &= ~S_IALLUGO;
-		inode->i_mode |= opts->mode;
+		inode->i_mode |= fsi->mode;
 	}
 
-	if (!remount || opts->opts & BIT(Opt_uid))
-		inode->i_uid = opts->uid;
+	if (!remount || fsi->opts & BIT(Opt_uid))
+		inode->i_uid = fsi->uid;
 
-	if (!remount || opts->opts & BIT(Opt_gid))
-		inode->i_gid = opts->gid;
+	if (!remount || fsi->opts & BIT(Opt_gid))
+		inode->i_gid = fsi->gid;
 }
 
 static void debugfs_apply_options(struct super_block *sb)
@@ -187,35 +169,33 @@ static void debugfs_apply_options_remount(struct super_block *sb)
 	_debugfs_apply_options(sb, true);
 }
 
-static int debugfs_remount(struct super_block *sb, int *flags, char *data)
+static int debugfs_reconfigure(struct fs_context *fc)
 {
-	int err;
-	struct debugfs_fs_info *fsi = sb->s_fs_info;
+	struct super_block *sb = fc->root->d_sb;
+	struct debugfs_fs_info *sb_opts = sb->s_fs_info;
+	struct debugfs_fs_info *new_opts = fc->s_fs_info;
 
 	sync_filesystem(sb);
-	err = debugfs_parse_options(data, &fsi->mount_opts);
-	if (err)
-		goto fail;
 
+	/* structure copy of new mount options to sb */
+	*sb_opts = *new_opts;
 	debugfs_apply_options_remount(sb);
 
-fail:
-	return err;
+	return 0;
 }
 
 static int debugfs_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct debugfs_fs_info *fsi = root->d_sb->s_fs_info;
-	struct debugfs_mount_opts *opts = &fsi->mount_opts;
 
-	if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
+	if (!uid_eq(fsi->uid, GLOBAL_ROOT_UID))
 		seq_printf(m, ",uid=%u",
-			   from_kuid_munged(&init_user_ns, opts->uid));
-	if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
+			   from_kuid_munged(&init_user_ns, fsi->uid));
+	if (!gid_eq(fsi->gid, GLOBAL_ROOT_GID))
 		seq_printf(m, ",gid=%u",
-			   from_kgid_munged(&init_user_ns, opts->gid));
-	if (opts->mode != DEBUGFS_DEFAULT_MODE)
-		seq_printf(m, ",mode=%o", opts->mode);
+			   from_kgid_munged(&init_user_ns, fsi->gid));
+	if (fsi->mode != DEBUGFS_DEFAULT_MODE)
+		seq_printf(m, ",mode=%o", fsi->mode);
 
 	return 0;
 }
@@ -229,7 +209,6 @@ static void debugfs_free_inode(struct inode *inode)
 
 static const struct super_operations debugfs_super_operations = {
 	.statfs		= simple_statfs,
-	.remount_fs	= debugfs_remount,
 	.show_options	= debugfs_show_options,
 	.free_inode	= debugfs_free_inode,
 };
@@ -263,26 +242,14 @@ static const struct dentry_operations debugfs_dops = {
 	.d_automount = debugfs_automount,
 };
 
-static int debug_fill_super(struct super_block *sb, void *data, int silent)
+static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr debug_files[] = {{""}};
-	struct debugfs_fs_info *fsi;
 	int err;
 
-	fsi = kzalloc(sizeof(struct debugfs_fs_info), GFP_KERNEL);
-	sb->s_fs_info = fsi;
-	if (!fsi) {
-		err = -ENOMEM;
-		goto fail;
-	}
-
-	err = debugfs_parse_options(data, &fsi->mount_opts);
+	err = simple_fill_super(sb, DEBUGFS_MAGIC, debug_files);
 	if (err)
-		goto fail;
-
-	err  =  simple_fill_super(sb, DEBUGFS_MAGIC, debug_files);
-	if (err)
-		goto fail;
+		return err;
 
 	sb->s_op = &debugfs_super_operations;
 	sb->s_d_op = &debugfs_dops;
@@ -290,27 +257,48 @@ static int debug_fill_super(struct super_block *sb, void *data, int silent)
 	debugfs_apply_options(sb);
 
 	return 0;
-
-fail:
-	kfree(fsi);
-	sb->s_fs_info = NULL;
-	return err;
 }
 
-static struct dentry *debug_mount(struct file_system_type *fs_type,
-			int flags, const char *dev_name,
-			void *data)
+static int debugfs_get_tree(struct fs_context *fc)
 {
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API))
-		return ERR_PTR(-EPERM);
+		return -EPERM;
+
+	return get_tree_single(fc, debugfs_fill_super);
+}
+
+static void debugfs_free_fc(struct fs_context *fc)
+{
+	kfree(fc->s_fs_info);
+}
 
-	return mount_single(fs_type, flags, data, debug_fill_super);
+static const struct fs_context_operations debugfs_context_ops = {
+	.free		= debugfs_free_fc,
+	.parse_param	= debugfs_parse_param,
+	.get_tree	= debugfs_get_tree,
+	.reconfigure	= debugfs_reconfigure,
+};
+
+static int debugfs_init_fs_context(struct fs_context *fc)
+{
+	struct debugfs_fs_info *fsi;
+
+	fsi = kzalloc(sizeof(struct debugfs_fs_info), GFP_KERNEL);
+	if (!fsi)
+		return -ENOMEM;
+
+	fsi->mode = DEBUGFS_DEFAULT_MODE;
+
+	fc->s_fs_info = fsi;
+	fc->ops = &debugfs_context_ops;
+	return 0;
 }
 
 static struct file_system_type debug_fs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"debugfs",
-	.mount =	debug_mount,
+	.init_fs_context = debugfs_init_fs_context,
+	.parameters =	debugfs_param_specs,
 	.kill_sb =	kill_litter_super,
 };
 MODULE_ALIAS_FS("debugfs");
-- 
2.43.0



