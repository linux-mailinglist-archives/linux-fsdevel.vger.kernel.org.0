Return-Path: <linux-fsdevel+bounces-13373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2BB86F182
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 17:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7288EB231E3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 16:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594B9249E4;
	Sat,  2 Mar 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkNrkO2P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C618658
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398662; cv=none; b=NsCcn0xME7wrdLeF5Rz60tGEi2WmpLDeq0eVPN7gi99h9qPpc1ipbi2VP+f2fxOEWIyZPtVRoRobBazQTIQBXJZhqgPxmFwlwjouihy9N5rcl078STaFEk64f9s0ZLcsm9PFegM426Rjrj69sjJQiul5LimbdL5M+kqjZjh8//c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398662; c=relaxed/simple;
	bh=oTUiHyw7WSYv9al0iH6c402X4AyYwXQ+9xMDoegVmFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDS/UAZILZl8H3rG67URC1XgUxhzEnMEOnZ7aGAK491hylBHOZCq/MwJXZIHt5hBbizgZecPyW6AAfH2awOon/B/eugjfZV2AmSdCCPgH9dnF81vZSIjqHiZmiF1dST38H6lTMDc6hfBDKsnrcZ5329BH3lZCib6lEG61UKK5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QkNrkO2P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709398659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QAZasKHwM+NFWjSbslaSZDWeA88p6Bbr/95az4hhWG0=;
	b=QkNrkO2PZmaMSMOZY08YIpyH5piw9jFTmiVfkR0AVq+9MNTP4TUPPnzZvsSCs/gFkNwUel
	Y5ngh6que0HqkbG4jM4YoYaVxUxb+jFDu73lPJ4cEEeqaHu3U1d5ymzrULrXthhIxBjabb
	yHTjvLY0CL6R1ZuIyEyA9S9Ssi76i9s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-11Zq8aXnNkeCAVI8CkYuSw-1; Sat,
 02 Mar 2024 11:57:34 -0500
X-MC-Unique: 11Zq8aXnNkeCAVI8CkYuSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8ECE71C0BB40;
	Sat,  2 Mar 2024 16:57:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A547840C6EBA;
	Sat,  2 Mar 2024 16:57:32 +0000 (UTC)
From: Bill O'Donnell <bodonnel@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: al@alarsen.net,
	brauner@kernel.org,
	sandeen@redhat.com,
	Bill O'Donnell <bodonnel@redhat.com>
Subject: [PATCH v2] qnx6: convert qnx6 to use the new mount api
Date: Sat,  2 Mar 2024 10:48:34 -0600
Message-ID: <20240302165714.859504-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Convert the qnx6 filesystem to use the new mount API.

Mostly untested, since there is no qnx6 fs image readily available.
Testing did include parsing of the mmi_fs option.

Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
---

v2: Remove unneeded include, add s_mount_opt read in fill_super,
    remove Opt_err, untangle the qs and sbi code in fill_super to
    properly initialize qs and handle qs->s_mount_opt.

---
 fs/qnx6/inode.c | 117 ++++++++++++++++++++++++++++--------------------
 1 file changed, 69 insertions(+), 48 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index a286c545717f..d32cba4e25da 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -19,11 +19,11 @@
 #include <linux/buffer_head.h>
 #include <linux/writeback.h>
 #include <linux/statfs.h>
-#include <linux/parser.h>
 #include <linux/seq_file.h>
-#include <linux/mount.h>
 #include <linux/crc32.h>
 #include <linux/mpage.h>
+#include <linux/fs_parser.h>
+#include <linux/fs_context.h>
 #include "qnx6.h"
 
 static const struct super_operations qnx6_sops;
@@ -31,7 +31,7 @@ static const struct super_operations qnx6_sops;
 static void qnx6_put_super(struct super_block *sb);
 static struct inode *qnx6_alloc_inode(struct super_block *sb);
 static void qnx6_free_inode(struct inode *inode);
-static int qnx6_remount(struct super_block *sb, int *flags, char *data);
+static int qnx6_reconfigure(struct fs_context *fc);
 static int qnx6_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int qnx6_show_options(struct seq_file *seq, struct dentry *root);
 
@@ -40,7 +40,6 @@ static const struct super_operations qnx6_sops = {
 	.free_inode	= qnx6_free_inode,
 	.put_super	= qnx6_put_super,
 	.statfs		= qnx6_statfs,
-	.remount_fs	= qnx6_remount,
 	.show_options	= qnx6_show_options,
 };
 
@@ -54,10 +53,12 @@ static int qnx6_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
-static int qnx6_remount(struct super_block *sb, int *flags, char *data)
+static int qnx6_reconfigure(struct fs_context *fc)
 {
+	struct super_block *sb = fc->root->d_sb;
+
 	sync_filesystem(sb);
-	*flags |= SB_RDONLY;
+	fc->sb_flags |= SB_RDONLY;
 	return 0;
 }
 
@@ -218,39 +219,36 @@ void qnx6_superblock_debug(struct qnx6_super_block *sb, struct super_block *s)
 #endif
 
 enum {
-	Opt_mmifs,
-	Opt_err
+	Opt_mmifs
+};
+
+struct qnx6_context {
+	unsigned long s_mount_opts;
 };
 
-static const match_table_t tokens = {
-	{Opt_mmifs, "mmi_fs"},
-	{Opt_err, NULL}
+static const struct fs_parameter_spec qnx6_param_spec[] = {
+	fsparam_flag	("mmi_fs",	Opt_mmifs),
+	{}
 };
 
-static int qnx6_parse_options(char *options, struct super_block *sb)
+static int qnx6_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *p;
-	struct qnx6_sb_info *sbi = QNX6_SB(sb);
-	substring_t args[MAX_OPT_ARGS];
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
-		case Opt_mmifs:
-			set_opt(sbi->s_mount_opt, MMI_FS);
-			break;
-		default:
-			return 0;
-		}
+	struct qnx6_context *ctx = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, qnx6_param_spec, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_mmifs:
+		ctx->s_mount_opts |= QNX6_MOUNT_MMI_FS;
+		break;
+	default:
+		return -EINVAL;
 	}
-	return 1;
+	return 0;
 }
 
 static struct buffer_head *qnx6_check_first_superblock(struct super_block *s,
@@ -293,22 +291,25 @@ static struct buffer_head *qnx6_check_first_superblock(struct super_block *s,
 static struct inode *qnx6_private_inode(struct super_block *s,
 					struct qnx6_root_node *p);
 
-static int qnx6_fill_super(struct super_block *s, void *data, int silent)
+static int qnx6_fill_super(struct super_block *s, struct fs_context *fc)
 {
 	struct buffer_head *bh1 = NULL, *bh2 = NULL;
 	struct qnx6_super_block *sb1 = NULL, *sb2 = NULL;
 	struct qnx6_sb_info *sbi;
+	struct qnx6_context *ctx = fc->fs_private;
 	struct inode *root;
 	const char *errmsg;
 	struct qnx6_sb_info *qs;
 	int ret = -EINVAL;
 	u64 offset;
 	int bootblock_offset = QNX6_BOOTBLOCK_SIZE;
+	int silent = fc->sb_flags & SB_SILENT;
 
 	qs = kzalloc(sizeof(struct qnx6_sb_info), GFP_KERNEL);
 	if (!qs)
 		return -ENOMEM;
 	s->s_fs_info = qs;
+	qs->s_mount_opt = ctx->s_mount_opts;
 
 	/* Superblock always is 512 Byte long */
 	if (!sb_set_blocksize(s, QNX6_SUPERBLOCK_SIZE)) {
@@ -316,12 +317,7 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
 		goto outnobh;
 	}
 
-	/* parse the mount-options */
-	if (!qnx6_parse_options((char *) data, s)) {
-		pr_err("invalid mount options.\n");
-		goto outnobh;
-	}
-	if (test_opt(s, MMI_FS)) {
+	if (qs->s_mount_opt == QNX6_MOUNT_MMI_FS) {
 		sb1 = qnx6_mmi_fill_super(s, silent);
 		if (sb1)
 			goto mmi_success;
@@ -632,18 +628,43 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(qnx6_inode_cachep);
 }
 
-static struct dentry *qnx6_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int qnx6_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, qnx6_fill_super);
+}
+
+static void qnx6_free_fc(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, qnx6_fill_super);
+	kfree(fc->fs_private);
+}
+
+static const struct fs_context_operations qnx6_context_ops = {
+	.parse_param	= qnx6_parse_param,
+	.get_tree	= qnx6_get_tree,
+	.reconfigure	= qnx6_reconfigure,
+	.free		= qnx6_free_fc,
+};
+
+static int qnx6_init_fs_context(struct fs_context *fc)
+{
+	struct qnx6_context *ctx;
+
+	ctx = kzalloc(sizeof(struct qnx6_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	fc->ops = &qnx6_context_ops;
+	fc->fs_private = ctx;
+
+	return 0;
 }
 
 static struct file_system_type qnx6_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "qnx6",
-	.mount		= qnx6_mount,
-	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.owner			= THIS_MODULE,
+	.name			= "qnx6",
+	.kill_sb		= kill_block_super,
+	.fs_flags		= FS_REQUIRES_DEV,
+	.init_fs_context	= qnx6_init_fs_context,
+	.parameters		= qnx6_param_spec,
 };
 MODULE_ALIAS_FS("qnx6");
 
-- 
2.43.2


