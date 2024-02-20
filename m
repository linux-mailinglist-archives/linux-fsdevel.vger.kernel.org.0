Return-Path: <linux-fsdevel+bounces-12162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E93385C1AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 17:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A622871BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00FC7641C;
	Tue, 20 Feb 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M91Zfqli"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D682599
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447673; cv=none; b=l/M1UhR4FM5v2MIvV3MDY+94Cr3rik0Tm52B+swnbssAro0NLUBP52DXj/IwEHz4mLc7WK1AnIyMf4qpcNxxyfMCdn2zaPt4FByOJ7sS3UKoTUe4bYUDN9VOXtIZba+PCNgIZW8vYSu5kP/MoWYB4lUJmjPzxSusctpZgtuzPGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447673; c=relaxed/simple;
	bh=O7FuNpXb+6qzocVTIlhZHoQZKcX0XpltZq33vh1VWuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmEzOpnC7uLM1iYgSi+WaDtCRfpWfypIrDYt3ULQ+ZMl/uwrXsnJ2clrfUxuyLyMonEM27kkk32nafdn05gSt9sF4vBFEHboUaqMtiEBJXSJko1ZB+Eu0L0Fmi2icfTkYW+xfbGYW3OQl6dYC9ygF9XNgIqA+mKJDjYq964fvk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M91Zfqli; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708447669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CYQw0PJXD9wrMMJjpRMkOMjeEba8pSFeZiX9+3hSxXM=;
	b=M91ZfqliKlIzzEjyTWrTfbMSt7haSli6jeKA+zd5llqG/8JzaEtE2zFxSkn1OB1DCgfmxg
	uAZga/lWjCUV49YQKp0yli7Y26l0tq3Xpwgbl9U6hDyDRwperyW81Kf/jzSAkfO1wDiPWL
	mF/OFot++qNBOH8w5kMMvSTMUk7F0fE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-xyHVVaqgMOugkv4Hh2fAlg-1; Tue,
 20 Feb 2024 11:47:48 -0500
X-MC-Unique: xyHVVaqgMOugkv4Hh2fAlg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2FEC3811F2F;
	Tue, 20 Feb 2024 16:47:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.227])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 96D29401A77C;
	Tue, 20 Feb 2024 16:47:47 +0000 (UTC)
From: Bill O'Donnell <bodonnel@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	Bill O'Donnell <bodonnel@redhat.com>
Subject: [PATCH v2] efs: convert efs to use the new mount api
Date: Tue, 20 Feb 2024 10:45:36 -0600
Message-ID: <20240220164729.179594-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Convert the efs filesystem to use the new mount API.

Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
---

Changelog:
v2: Remove efs_param_spec and efs_parse_param, since no mount options.

---
 fs/efs/super.c | 91 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 30 deletions(-)

diff --git a/fs/efs/super.c b/fs/efs/super.c
index f17fdac76b2e..d86c84e9e497 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -14,19 +14,13 @@
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
 #include <linux/blkdev.h>
-
+#include <linux/fs_context.h>
 #include "efs.h"
 #include <linux/efs_vh.h>
 #include <linux/efs_fs_sb.h>
 
 static int efs_statfs(struct dentry *dentry, struct kstatfs *buf);
-static int efs_fill_super(struct super_block *s, void *d, int silent);
-
-static struct dentry *efs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
-{
-	return mount_bdev(fs_type, flags, dev_name, data, efs_fill_super);
-}
+static int efs_init_fs_context(struct fs_context *fc);
 
 static void efs_kill_sb(struct super_block *s)
 {
@@ -35,15 +29,6 @@ static void efs_kill_sb(struct super_block *s)
 	kfree(sbi);
 }
 
-static struct file_system_type efs_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "efs",
-	.mount		= efs_mount,
-	.kill_sb	= efs_kill_sb,
-	.fs_flags	= FS_REQUIRES_DEV,
-};
-MODULE_ALIAS_FS("efs");
-
 static struct pt_types sgi_pt_types[] = {
 	{0x00,		"SGI vh"},
 	{0x01,		"SGI trkrepl"},
@@ -63,6 +48,17 @@ static struct pt_types sgi_pt_types[] = {
 	{0,		NULL}
 };
 
+/*
+ * File system definition and registration.
+ */
+static struct file_system_type efs_fs_type = {
+	.owner			= THIS_MODULE,
+	.name			= "efs",
+	.kill_sb		= efs_kill_sb,
+	.fs_flags		= FS_REQUIRES_DEV,
+	.init_fs_context	= efs_init_fs_context,
+};
+MODULE_ALIAS_FS("efs");
 
 static struct kmem_cache * efs_inode_cachep;
 
@@ -108,18 +104,10 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(efs_inode_cachep);
 }
 
-static int efs_remount(struct super_block *sb, int *flags, char *data)
-{
-	sync_filesystem(sb);
-	*flags |= SB_RDONLY;
-	return 0;
-}
-
 static const struct super_operations efs_superblock_operations = {
 	.alloc_inode	= efs_alloc_inode,
 	.free_inode	= efs_free_inode,
 	.statfs		= efs_statfs,
-	.remount_fs	= efs_remount,
 };
 
 static const struct export_operations efs_export_ops = {
@@ -249,26 +237,26 @@ static int efs_validate_super(struct efs_sb_info *sb, struct efs_super *super) {
 	return 0;    
 }
 
-static int efs_fill_super(struct super_block *s, void *d, int silent)
+static int efs_fill_super(struct super_block *s, struct fs_context *fc)
 {
 	struct efs_sb_info *sb;
 	struct buffer_head *bh;
 	struct inode *root;
 
- 	sb = kzalloc(sizeof(struct efs_sb_info), GFP_KERNEL);
+	sb = kzalloc(sizeof(struct efs_sb_info), GFP_KERNEL);
 	if (!sb)
 		return -ENOMEM;
 	s->s_fs_info = sb;
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
- 
+
 	s->s_magic		= EFS_SUPER_MAGIC;
 	if (!sb_set_blocksize(s, EFS_BLOCKSIZE)) {
 		pr_err("device does not support %d byte blocks\n",
 			EFS_BLOCKSIZE);
 		return -EINVAL;
 	}
-  
+
 	/* read the vh (volume header) block */
 	bh = sb_bread(s, 0);
 
@@ -294,7 +282,7 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
 		pr_err("cannot read superblock\n");
 		return -EIO;
 	}
-		
+
 	if (efs_validate_super(sb, (struct efs_super *) bh->b_data)) {
 #ifdef DEBUG
 		pr_warn("invalid superblock at block %u\n",
@@ -328,6 +316,49 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
 	return 0;
 }
 
+static void efs_free_fc(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
+
+static int efs_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, efs_fill_super);
+}
+
+static int efs_reconfigure(struct fs_context *fc)
+{
+	sync_filesystem(fc->root->d_sb);
+
+	return 0;
+}
+
+struct efs_context {
+	unsigned long s_mount_opts;
+};
+
+static const struct fs_context_operations efs_context_opts = {
+	.get_tree	= efs_get_tree,
+	.reconfigure	= efs_reconfigure,
+	.free		= efs_free_fc,
+};
+
+/*
+ * Set up the filesystem mount context.
+ */
+static int efs_init_fs_context(struct fs_context *fc)
+{
+	struct efs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct efs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	fc->fs_private = ctx;
+	fc->ops = &efs_context_opts;
+
+	return 0;
+}
+
 static int efs_statfs(struct dentry *dentry, struct kstatfs *buf) {
 	struct super_block *sb = dentry->d_sb;
 	struct efs_sb_info *sbi = SUPER_INFO(sb);
-- 
2.43.2


