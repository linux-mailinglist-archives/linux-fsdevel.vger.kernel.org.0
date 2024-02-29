Return-Path: <linux-fsdevel+bounces-13195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F15086CEE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 17:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB8D283084
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 16:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164F94AEDB;
	Thu, 29 Feb 2024 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZJWITXg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCACE4AED3
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223443; cv=none; b=Mrf06h/EIUDF8PsJ+lYK5+cWW7epsiwzHP/wt0YPJpuvs+IUhX6ROlxoWCgUAUEu30/71NjiM9aM/k69k3TMnzo2UZfBFZPeGT893ENdvNajq3v9G0ZjU2+PkOqcHkNCSSpdYzvF1O39UTgjbYvhbZOYzyO83cle66C/TqvU+sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223443; c=relaxed/simple;
	bh=0+/E83NBOjCEHhQVo9DQjq2ZN1RwXNZ7Mt2i8oSDEV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwQ1SYQk0vMNHIFIHO/WvzHJ89HiEJgmpqIZgf5qNYqH81f+16ZxXTt5xr8/Q/GrmCCWqv7wyze4/k9qO3rHJkaYKn0Uv66E/bxvooPsyghxEzGghQrX8CIMpyojetQj6uxfE3G/Jh0l/WXpu8eXRYBsb4H42wBOz0NNnVmrUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZJWITXg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709223440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BwmaGg78Nxe18yJ3N261SGIngFYiy4eXXF+n7qd+QYk=;
	b=OZJWITXgw9cnIKlUUZ/8i1iJG02pHyvEXhqFCRbK/YXOxHpEcezyEweXvc8KM5jRKnwIvN
	GizI3/o6QRf4Ia12mCr+PywfIF8YVpAzQ/zbLXOnsA9DWBBfJySUQIwJAv6Nxk1by3WSxY
	fKsVf8QaZfL1AoXlFlRDbejThH/AT0M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-U6UdqiAqPOSVfRy5YtC9og-1; Thu,
 29 Feb 2024 11:17:15 -0500
X-MC-Unique: U6UdqiAqPOSVfRy5YtC9og-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCD6D3C025BB;
	Thu, 29 Feb 2024 16:17:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.9.199])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8BE901C060AF;
	Thu, 29 Feb 2024 16:17:13 +0000 (UTC)
From: Bill O'Donnell <bodonnel@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: al@alarsen.net,
	brauner@kernel.org,
	sandeen@redhat.com,
	Bill O'Donnell <bodonnel@redhat.com>
Subject: [PATCH v2] qnx4: convert qnx4 to use the new mount api
Date: Thu, 29 Feb 2024 10:15:38 -0600
Message-ID: <20240229161649.800957-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Convert the qnx4 filesystem to use the new mount API.

Tested mount, umount, and remount using a qnx4 boot image.

Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
---

v2: Remove redundant initialization of qs in qnx4_reconfigure().

---
 fs/qnx4/inode.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 6eb9bb369b57..7b5711f76709 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -21,6 +21,7 @@
 #include <linux/buffer_head.h>
 #include <linux/writeback.h>
 #include <linux/statfs.h>
+#include <linux/fs_context.h>
 #include "qnx4.h"
 
 #define QNX4_VERSION  4
@@ -30,28 +31,33 @@ static const struct super_operations qnx4_sops;
 
 static struct inode *qnx4_alloc_inode(struct super_block *sb);
 static void qnx4_free_inode(struct inode *inode);
-static int qnx4_remount(struct super_block *sb, int *flags, char *data);
 static int qnx4_statfs(struct dentry *, struct kstatfs *);
+static int qnx4_get_tree(struct fs_context *fc);
 
 static const struct super_operations qnx4_sops =
 {
 	.alloc_inode	= qnx4_alloc_inode,
 	.free_inode	= qnx4_free_inode,
 	.statfs		= qnx4_statfs,
-	.remount_fs	= qnx4_remount,
 };
 
-static int qnx4_remount(struct super_block *sb, int *flags, char *data)
+static int qnx4_reconfigure(struct fs_context *fc)
 {
+	struct super_block *sb = fc->root->d_sb;
 	struct qnx4_sb_info *qs;
 
 	sync_filesystem(sb);
 	qs = qnx4_sb(sb);
 	qs->Version = QNX4_VERSION;
-	*flags |= SB_RDONLY;
+	fc->sb_flags |= SB_RDONLY;
 	return 0;
 }
 
+static const struct fs_context_operations qnx4_context_opts = {
+	.get_tree	= qnx4_get_tree,
+	.reconfigure	= qnx4_reconfigure,
+};
+
 static int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_head *bh, int create )
 {
 	unsigned long phys;
@@ -183,12 +189,13 @@ static const char *qnx4_checkroot(struct super_block *sb,
 	return "bitmap file not found.";
 }
 
-static int qnx4_fill_super(struct super_block *s, void *data, int silent)
+static int qnx4_fill_super(struct super_block *s, struct fs_context *fc)
 {
 	struct buffer_head *bh;
 	struct inode *root;
 	const char *errmsg;
 	struct qnx4_sb_info *qs;
+	int silent = fc->sb_flags & SB_SILENT;
 
 	qs = kzalloc(sizeof(struct qnx4_sb_info), GFP_KERNEL);
 	if (!qs)
@@ -216,7 +223,7 @@ static int qnx4_fill_super(struct super_block *s, void *data, int silent)
 	errmsg = qnx4_checkroot(s, (struct qnx4_super_block *) bh->b_data);
 	brelse(bh);
 	if (errmsg != NULL) {
- 		if (!silent)
+		if (!silent)
 			printk(KERN_ERR "qnx4: %s\n", errmsg);
 		return -EINVAL;
 	}
@@ -235,6 +242,18 @@ static int qnx4_fill_super(struct super_block *s, void *data, int silent)
 	return 0;
 }
 
+static int qnx4_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, qnx4_fill_super);
+}
+
+static int qnx4_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &qnx4_context_opts;
+
+	return 0;
+}
+
 static void qnx4_kill_sb(struct super_block *sb)
 {
 	struct qnx4_sb_info *qs = qnx4_sb(sb);
@@ -376,18 +395,12 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(qnx4_inode_cachep);
 }
 
-static struct dentry *qnx4_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
-{
-	return mount_bdev(fs_type, flags, dev_name, data, qnx4_fill_super);
-}
-
 static struct file_system_type qnx4_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "qnx4",
-	.mount		= qnx4_mount,
-	.kill_sb	= qnx4_kill_sb,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.owner			= THIS_MODULE,
+	.name			= "qnx4",
+	.kill_sb		= qnx4_kill_sb,
+	.fs_flags		= FS_REQUIRES_DEV,
+	.init_fs_context	= qnx4_init_fs_context,
 };
 MODULE_ALIAS_FS("qnx4");
 
-- 
2.43.2


