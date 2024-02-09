Return-Path: <linux-fsdevel+bounces-11014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D244184FCFB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DC61F2285B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 19:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D976284A2A;
	Fri,  9 Feb 2024 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWCSRebk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9C84A36
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507472; cv=none; b=GFA1vjTVVTp7V8BLSpSYFQl7Vdm8nIkY2wVRccdwq+xMaU2CVMuzSCNVEfDMoqfV+BKUU1QoFlllOykdgHbtAQQKmn39B7szD1qIXRG0rhHfh6NsXht3e7jiGdYNmwvEMPSWD6lN6FGCSjxs9OBPOH1lbgCVweEwQAaKB1+sx14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507472; c=relaxed/simple;
	bh=A+OaEq9QmotctKEF4JGiVwSqideSGPnvxL7Z2ft5Fhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7oLI5wH/EHfWFYM+XsiKLjucNtrLpseTGFm0SqxCo7W4z9JmnqUPc237djYPJ2SdrqPbMm6gooZzz+no/ZQEu42qS7XUW5Dnwib25L4+Orztf/BceyLPqIS+L69Zm1s08HPt5ZwM7o4f/fp+jshWsbWaxf5610VTFMD7wlWv/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWCSRebk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707507469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CAZwPg81PFWrZXufeqepBtI6YneRnyGoKrXTNlwY/sg=;
	b=eWCSRebkijt3Aau1C0bWB6T8Wh9W8kgJ48TexUfBan0cOCDLNZnt6MXBKb1nf+mDiH0Bb7
	CGwm105e2IwKBOYwS7U+OGcoq3Obt8fy9gepFjsZfLV7j9AFH/jw1TV7y5T9aqOjv+F/rK
	SE37F1TGk+wGlIu8fa9WsF+ViHlt5NY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-kUJpC7-cMXqNDefD60SNug-1; Fri,
 09 Feb 2024 14:37:47 -0500
X-MC-Unique: kUJpC7-cMXqNDefD60SNug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 573071C0BB42;
	Fri,  9 Feb 2024 19:37:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.174])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 16FF2C1E95A;
	Fri,  9 Feb 2024 19:37:47 +0000 (UTC)
From: Bill O'Donnell <bodonnel@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: dlemoal@kernel.org,
	Bill O'Donnell <bodonnel@redhat.com>
Subject: [PATCH v2] zonefs: convert zonefs to use the new mount api
Date: Fri,  9 Feb 2024 13:36:59 -0600
Message-ID: <20240209193726.40115-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Convert the zonefs filesystem to use the new mount API.
Tested using the zonefs test suite from:
https://github.com/damien-lemoal/zonefs-tools

Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
---
Changelog:

v2: Fix whitespace issues. Reorder functions to eliminate forward
    declaration. Remove superfluous variable ctx in zonefs_kill_super().
---
 fs/zonefs/super.c | 165 ++++++++++++++++++++++++++--------------------
 1 file changed, 93 insertions(+), 72 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index e6a75401677d..285e711fca9e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -15,13 +15,14 @@
 #include <linux/writeback.h>
 #include <linux/quotaops.h>
 #include <linux/seq_file.h>
-#include <linux/parser.h>
 #include <linux/uio.h>
 #include <linux/mman.h>
 #include <linux/sched/mm.h>
 #include <linux/crc32.h>
 #include <linux/task_io_accounting_ops.h>
 
+#include <linux/fs_parser.h>
+#include <linux/fs_context.h>
 #include "zonefs.h"
 
 #define CREATE_TRACE_POINTS
@@ -460,58 +461,47 @@ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
 }
 
 enum {
-	Opt_errors_ro, Opt_errors_zro, Opt_errors_zol, Opt_errors_repair,
-	Opt_explicit_open, Opt_err,
+	Opt_errors, Opt_explicit_open,
 };
 
-static const match_table_t tokens = {
-	{ Opt_errors_ro,	"errors=remount-ro"},
-	{ Opt_errors_zro,	"errors=zone-ro"},
-	{ Opt_errors_zol,	"errors=zone-offline"},
-	{ Opt_errors_repair,	"errors=repair"},
-	{ Opt_explicit_open,	"explicit-open" },
-	{ Opt_err,		NULL}
+struct zonefs_context {
+	unsigned long s_mount_opts;
 };
 
-static int zonefs_parse_options(struct super_block *sb, char *options)
-{
-	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
-	substring_t args[MAX_OPT_ARGS];
-	char *p;
-
-	if (!options)
-		return 0;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
+static const struct constant_table zonefs_param_errors[] = {
+	{"remount-ro",		ZONEFS_MNTOPT_ERRORS_RO},
+	{"zone-ro",		ZONEFS_MNTOPT_ERRORS_ZRO},
+	{"zone-offline",	ZONEFS_MNTOPT_ERRORS_ZOL},
+	{"repair", 		ZONEFS_MNTOPT_ERRORS_REPAIR},
+	{}
+};
 
-		if (!*p)
-			continue;
+static const struct fs_parameter_spec zonefs_param_spec[] = {
+	fsparam_enum	("errors",		Opt_errors, zonefs_param_errors),
+	fsparam_flag	("explicit-open",	Opt_explicit_open),
+	{}
+};
 
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_errors_ro:
-			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
-			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_RO;
-			break;
-		case Opt_errors_zro:
-			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
-			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_ZRO;
-			break;
-		case Opt_errors_zol:
-			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
-			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_ZOL;
-			break;
-		case Opt_errors_repair:
-			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
-			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_REPAIR;
-			break;
-		case Opt_explicit_open:
-			sbi->s_mount_opts |= ZONEFS_MNTOPT_EXPLICIT_OPEN;
-			break;
-		default:
-			return -EINVAL;
-		}
+static int zonefs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct zonefs_context *ctx = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, zonefs_param_spec, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_errors:
+		ctx->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
+		ctx->s_mount_opts |= result.uint_32;
+		break;
+	case Opt_explicit_open:
+		ctx->s_mount_opts |= ZONEFS_MNTOPT_EXPLICIT_OPEN;
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	return 0;
@@ -533,13 +523,6 @@ static int zonefs_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
-static int zonefs_remount(struct super_block *sb, int *flags, char *data)
-{
-	sync_filesystem(sb);
-
-	return zonefs_parse_options(sb, data);
-}
-
 static int zonefs_inode_setattr(struct mnt_idmap *idmap,
 				struct dentry *dentry, struct iattr *iattr)
 {
@@ -1197,7 +1180,6 @@ static const struct super_operations zonefs_sops = {
 	.alloc_inode	= zonefs_alloc_inode,
 	.free_inode	= zonefs_free_inode,
 	.statfs		= zonefs_statfs,
-	.remount_fs	= zonefs_remount,
 	.show_options	= zonefs_show_options,
 };
 
@@ -1242,9 +1224,10 @@ static void zonefs_release_zgroup_inodes(struct super_block *sb)
  * sub-directories and files according to the device zone configuration and
  * format options.
  */
-static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
+static int zonefs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct zonefs_sb_info *sbi;
+	struct zonefs_context *ctx = fc->fs_private;
 	struct inode *inode;
 	enum zonefs_ztype ztype;
 	int ret;
@@ -1281,7 +1264,7 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_uid = GLOBAL_ROOT_UID;
 	sbi->s_gid = GLOBAL_ROOT_GID;
 	sbi->s_perm = 0640;
-	sbi->s_mount_opts = ZONEFS_MNTOPT_ERRORS_RO;
+	sbi->s_mount_opts = ctx->s_mount_opts;
 
 	atomic_set(&sbi->s_wro_seq_files, 0);
 	sbi->s_max_wro_seq_files = bdev_max_open_zones(sb->s_bdev);
@@ -1292,10 +1275,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	if (ret)
 		return ret;
 
-	ret = zonefs_parse_options(sb, data);
-	if (ret)
-		return ret;
-
 	zonefs_info(sb, "Mounting %u zones", bdev_nr_zones(sb->s_bdev));
 
 	if (!sbi->s_max_wro_seq_files &&
@@ -1356,12 +1335,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	return ret;
 }
 
-static struct dentry *zonefs_mount(struct file_system_type *fs_type,
-				   int flags, const char *dev_name, void *data)
-{
-	return mount_bdev(fs_type, flags, dev_name, data, zonefs_fill_super);
-}
-
 static void zonefs_kill_super(struct super_block *sb)
 {
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
@@ -1376,15 +1349,63 @@ static void zonefs_kill_super(struct super_block *sb)
 	kfree(sbi);
 }
 
+static void zonefs_free_fc(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
+
+static int zonefs_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, zonefs_fill_super);
+}
+
+static int zonefs_reconfigure(struct fs_context *fc)
+{
+	struct zonefs_context *ctx = fc->fs_private;
+	struct super_block *sb = fc->root->d_sb;
+	struct zonefs_sb_info *sbi = sb->s_fs_info;
+
+	sync_filesystem(fc->root->d_sb);
+	/* Copy new options from ctx into sbi. */
+	sbi->s_mount_opts = ctx->s_mount_opts;
+
+	return 0;
+}
+
+static const struct fs_context_operations zonefs_context_ops = {
+	.parse_param    = zonefs_parse_param,
+	.get_tree       = zonefs_get_tree,
+	.reconfigure	= zonefs_reconfigure,
+	.free           = zonefs_free_fc,
+};
+
+/*
+ * Set up the filesystem mount context.
+ */
+static int zonefs_init_fs_context(struct fs_context *fc)
+{
+	struct zonefs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct zonefs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->s_mount_opts = ZONEFS_MNTOPT_ERRORS_RO;
+	fc->ops = &zonefs_context_ops;
+	fc->fs_private = ctx;
+
+	return 0;
+}
+
 /*
  * File system definition and registration.
  */
 static struct file_system_type zonefs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "zonefs",
-	.mount		= zonefs_mount,
-	.kill_sb	= zonefs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.owner			= THIS_MODULE,
+	.name			= "zonefs",
+	.kill_sb		= zonefs_kill_super,
+	.fs_flags		= FS_REQUIRES_DEV,
+	.init_fs_context	= zonefs_init_fs_context,
+	.parameters		= zonefs_param_spec,
 };
 
 static int __init zonefs_init_inodecache(void)
-- 
2.43.0


