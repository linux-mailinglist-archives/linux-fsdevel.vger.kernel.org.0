Return-Path: <linux-fsdevel+bounces-13491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79DF8706C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 17:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468FF28D7B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 16:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B72482E2;
	Mon,  4 Mar 2024 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgsPYHgE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F748CDC
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568994; cv=none; b=l2KA/rd/QW85JRSgGY6YimZJ1j7VTqL2UX82bx1AR/OLoADlsVWS8ykL1+rtK3HobwlnQWoK0hDwYfa4nhrQDYK4huprwLc/NkJVvvjNCJ7AT4Ate3eTcQGbV0iyJGUJuygXKfpOpePpJZRhnWV2VbFaJP+LjQraNp3BQB98je8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568994; c=relaxed/simple;
	bh=pMpMZ9FzWbqVEPj42vXpPEZUGh4sHMNF32QwYBYxHOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YvaTGdjZoBmG1mn1cqyONBZAp47JZVoAiFpEzUb+Co3NZofjzjJ/jS5MecAaOT7QKBBYWkwnz+bZq0GNuR/gOK+bjIlzue66TLqKwmKgKFrKQ/vwskMjDd8SfefKvKfUCdbeCkruSsomWlf/nm/FNi8s2BbTuA5E3mBXKNAScIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgsPYHgE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709568991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oMW6No/8wXMkrU1n5vtJtEiFiIr2URL/ix/sn5GIZBs=;
	b=AgsPYHgEjFmSb++/nzS/pXl91tx+kk6v5QEIRNc2xe1rXNzKiogVNkwqtwE7gH2ALfy/Bo
	PzuO0rJBnMCED+x+ch5XsW9yG5mgfvhH6dKlAMo/SsQ0ANU6+/RFsTJ822I63pakBPWPzo
	ClyxQYWTHhLqJhCJTH5Qh8j4WNGMHhY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-iBPgETB6OVWuPQxnELlrnA-1; Mon, 04 Mar 2024 11:16:28 -0500
X-MC-Unique: iBPgETB6OVWuPQxnELlrnA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D819884343;
	Mon,  4 Mar 2024 16:16:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A9669492BC9;
	Mon,  4 Mar 2024 16:16:27 +0000 (UTC)
From: Bill O'Donnell <bodonnel@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	sandeen@redhat.com,
	Bill O'Donnell <bodonnel@redhat.com>
Subject: [PATCH v3] efs: convert efs to use the new mount api
Date: Mon,  4 Mar 2024 10:03:06 -0600
Message-ID: <20240304161526.909415-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Convert the efs filesystem to use the new mount API.

Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
---

Changelog:
v3: efs_fill_super: when setting blocksize use invalf(fc...) as return
    instead of -EINVAL. Remove unneeded efs_free_fc().
    In efs_reconfigure, add fc->sb_flags |= SB_RDONLY.
    Remove unused efs_context struct.

v2: Remove efs_param_spec and efs_parse_param, since no mount options.

---
 fs/efs/super.c | 78 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/fs/efs/super.c b/fs/efs/super.c
index f17fdac76b2e..5584248fccb4 100644
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
@@ -249,26 +237,27 @@ static int efs_validate_super(struct efs_sb_info *sb, struct efs_super *super) {
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
-		return -EINVAL;
+		return invalf(fc, "device does not support %d byte blocks\n",
+			      EFS_BLOCKSIZE);
 	}
-  
+
 	/* read the vh (volume header) block */
 	bh = sb_bread(s, 0);
 
@@ -294,7 +283,7 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
 		pr_err("cannot read superblock\n");
 		return -EIO;
 	}
-		
+
 	if (efs_validate_super(sb, (struct efs_super *) bh->b_data)) {
 #ifdef DEBUG
 		pr_warn("invalid superblock at block %u\n",
@@ -328,6 +317,33 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
 	return 0;
 }
 
+static int efs_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, efs_fill_super);
+}
+
+static int efs_reconfigure(struct fs_context *fc)
+{
+	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |= SB_RDONLY;
+	return 0;
+}
+
+static const struct fs_context_operations efs_context_opts = {
+	.get_tree	= efs_get_tree,
+	.reconfigure	= efs_reconfigure,
+};
+
+/*
+ * Set up the filesystem mount context.
+ */
+static int efs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &efs_context_opts;
+
+	return 0;
+}
+
 static int efs_statfs(struct dentry *dentry, struct kstatfs *buf) {
 	struct super_block *sb = dentry->d_sb;
 	struct efs_sb_info *sbi = SUPER_INFO(sb);
-- 
2.44.0


