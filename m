Return-Path: <linux-fsdevel+bounces-10867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 727C484EE32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 01:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA361C22C9C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 00:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34D236F;
	Fri,  9 Feb 2024 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjvxQy6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64779364
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707437365; cv=none; b=AmfjT+UkZM/kcNpMHzV9o5PpUIGZvKfONnfmXBoZPepvqMEjNDDrSGsD1O4cN0NYXgfygTIkbbyJfJ7zaarRXn1VJBe1vp3Tp2rZg/VgrJ6VW+PQMnEhx8PnbyqITnty1KYATurRqUFOVeI4D9dxcKk7dHV0d61g8g2K+cdsR3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707437365; c=relaxed/simple;
	bh=VnMubbcLEYRPOwowFN4Hbhtf0C0MsyAYWFiCKpDGt9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riRGQZ6xL4vrYnOjabRmitBe+PBqETJ1ZFzDPEABPGBN6eATN/JVgoZ2TlapX4FLu+Q/j+3d/DNcWA4GTwOp7db0vpxy0YSbg++MiTUSmO2gMAkdQPKGUyyPZaeCtWxUHAY4xv/IaBY5Y4OEXUIU53f8VeQdnlkYRdhnaYvXSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjvxQy6C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707437362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kIacy2orDvO4RnhNB+PIOV6IoOj1+fjYkNVIo1wEK28=;
	b=fjvxQy6CiEznva6D1nZZfBXjcOlbxP+IWS7wteJ3z+dsdCQwUJKPqjPhqMWjo4ewZlbTRa
	Sg0cA+07dXHz2a2xIf1c95yv0p2msK0PsAo7r1wKGLiwNTbWC9gc0fmB+TKz260dDpLMH9
	32aGp5Ed282cYGgz0EdrRfTgqX1Yr5o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-drlpKP7kPNmGvo1g6QDfiQ-1; Thu, 08 Feb 2024 19:09:19 -0500
X-MC-Unique: drlpKP7kPNmGvo1g6QDfiQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D51D0830DCD;
	Fri,  9 Feb 2024 00:09:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.174])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94E35C1690E;
	Fri,  9 Feb 2024 00:09:18 +0000 (UTC)
From: Bill O'Donnell <bodonnel@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: dlemoal@kernel.org,
	Bill O'Donnell <bodonnel@redhat.com>
Subject: [PATCH] zonefs: convert zonefs to use the new mount api
Date: Thu,  8 Feb 2024 18:08:57 -0600
Message-ID: <20240209000857.21040-1-bodonnel@redhat.com>
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
 fs/zonefs/super.c | 156 ++++++++++++++++++++++++++--------------------
 1 file changed, 90 insertions(+), 66 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index e6a75401677d..6b8ecd2e55b8 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -15,13 +15,13 @@
 #include <linux/writeback.h>
 #include <linux/quotaops.h>
 #include <linux/seq_file.h>
-#include <linux/parser.h>
 #include <linux/uio.h>
 #include <linux/mman.h>
 #include <linux/sched/mm.h>
 #include <linux/crc32.h>
 #include <linux/task_io_accounting_ops.h>
-
+#include <linux/fs_parser.h>
+#include <linux/fs_context.h>
 #include "zonefs.h"
 
 #define CREATE_TRACE_POINTS
@@ -460,58 +460,47 @@ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
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
@@ -533,11 +522,19 @@ static int zonefs_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
-static int zonefs_remount(struct super_block *sb, int *flags, char *data)
+static int zonefs_get_tree(struct fs_context *fc);
+
+static int zonefs_reconfigure(struct fs_context *fc)
 {
-	sync_filesystem(sb);
+	struct zonefs_context *ctx = fc->fs_private;
+	struct super_block *sb = fc->root->d_sb;
+	struct zonefs_sb_info *sbi = sb->s_fs_info;
 
-	return zonefs_parse_options(sb, data);
+	sync_filesystem(fc->root->d_sb);
+	/* Copy new options from ctx into sbi. */
+	sbi->s_mount_opts = ctx->s_mount_opts;
+
+	return 0;
 }
 
 static int zonefs_inode_setattr(struct mnt_idmap *idmap,
@@ -1197,7 +1194,6 @@ static const struct super_operations zonefs_sops = {
 	.alloc_inode	= zonefs_alloc_inode,
 	.free_inode	= zonefs_free_inode,
 	.statfs		= zonefs_statfs,
-	.remount_fs	= zonefs_remount,
 	.show_options	= zonefs_show_options,
 };
 
@@ -1242,9 +1238,10 @@ static void zonefs_release_zgroup_inodes(struct super_block *sb)
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
@@ -1281,21 +1278,17 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_uid = GLOBAL_ROOT_UID;
 	sbi->s_gid = GLOBAL_ROOT_GID;
 	sbi->s_perm = 0640;
-	sbi->s_mount_opts = ZONEFS_MNTOPT_ERRORS_RO;
-
+	sbi->s_mount_opts = ctx->s_mount_opts;
 	atomic_set(&sbi->s_wro_seq_files, 0);
 	sbi->s_max_wro_seq_files = bdev_max_open_zones(sb->s_bdev);
 	atomic_set(&sbi->s_active_seq_files, 0);
+
 	sbi->s_max_active_seq_files = bdev_max_active_zones(sb->s_bdev);
 
 	ret = zonefs_read_super(sb);
 	if (ret)
 		return ret;
 
-	ret = zonefs_parse_options(sb, data);
-	if (ret)
-		return ret;
-
 	zonefs_info(sb, "Mounting %u zones", bdev_nr_zones(sb->s_bdev));
 
 	if (!sbi->s_max_wro_seq_files &&
@@ -1356,12 +1349,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
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
@@ -1376,17 +1363,54 @@ static void zonefs_kill_super(struct super_block *sb)
 	kfree(sbi);
 }
 
+static void zonefs_free_fc(struct fs_context *fc)
+{
+	struct zonefs_context *ctx = fc->fs_private;
+
+	kfree(ctx);
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
+		return 0;
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
 	.owner		= THIS_MODULE,
 	.name		= "zonefs",
-	.mount		= zonefs_mount,
 	.kill_sb	= zonefs_kill_super,
 	.fs_flags	= FS_REQUIRES_DEV,
+	.init_fs_context	= zonefs_init_fs_context,
+	.parameters	= zonefs_param_spec,
 };
 
+static int zonefs_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, zonefs_fill_super);
+}
+
 static int __init zonefs_init_inodecache(void)
 {
 	zonefs_inode_cachep = kmem_cache_create("zonefs_inode_cache",
-- 
2.43.0


