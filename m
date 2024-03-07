Return-Path: <linux-fsdevel+bounces-13900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 053A9875434
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 17:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35C328505A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 16:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A350F12F393;
	Thu,  7 Mar 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+V6DZGW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB9347A2
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829238; cv=none; b=OtcshJ7pXPJHaUn3rZUQUMzA3i/y19J6MIsjx/DnLDd6/yroX3CRsLC6OzSxHuj43qRlJAc3c+M1rvX+WW+Fxr2V5p5iuEqJ1dYwcEycLQL3VZSFQ5f4NIoa39M+B67uVUuj+IYFXiD19WxL2BsABJciosJNAU0qSNSrC+Xb+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829238; c=relaxed/simple;
	bh=X9Xq+n0wdkBc9af7pjBPYYWH/9rznF2thPgXbIY7C9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtI1FavHC0E0n1OgvZ4pNiSq+w/kAqQodlIs01uapEcj+JRMtpw76VqXk/w0PDvLxqZKNagmLkuSvmwBWY97YdyVLr+FJsrajGw6EK7dHtRcnoCSAx9NH8zVbI8AOuiBBSjIPE/9ulPqJVl+NX/PF89HUq+fvR6j1hG6QKAjsIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+V6DZGW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709829235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kOM2NiMGTSm9v68wD4LNA5KWs7+uOOVCGSM8emLa6Ts=;
	b=M+V6DZGWWMJYU6Ai0prJqGu61ENN2gcR4qo5nwYRRy/kAYom/Te+NG+fcJK0N/VFLSKKsd
	pHDpoKbGIibMbmb4erEm/TnVZyuMeLAoLk7GOVXt8rsVotlAJZyosvVUw04+kAXZYSRRyP
	j/euQA6mTxIbChoppRTuQJFLPq5JemA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-t4x3Xz7XO-ef3wZXCJ0J2g-1; Thu,
 07 Mar 2024 11:33:52 -0500
X-MC-Unique: t4x3Xz7XO-ef3wZXCJ0J2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCFE81C54023;
	Thu,  7 Mar 2024 16:33:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 676C236FF;
	Thu,  7 Mar 2024 16:33:51 +0000 (UTC)
From: Bill O'Donnell <bodonnel@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	sandeen@redhat.com,
	Bill O'Donnell <bodonnel@redhat.com>
Subject: [PATCH v2] minix: convert minix to use the new mount api
Date: Thu,  7 Mar 2024 10:29:18 -0600
Message-ID: <20240307163325.998723-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Convert the minix filesystem to use the new mount API.

Tested using mount and remount on minix device.

Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
---

v2: Remove unneeded minix_context struct and its allocation/freeing.

---
 fs/minix/inode.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 73f37f298087..7b2b394a0799 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -20,11 +20,11 @@
 #include <linux/mpage.h>
 #include <linux/vfs.h>
 #include <linux/writeback.h>
+#include <linux/fs_context.h>
 
 static int minix_write_inode(struct inode *inode,
 		struct writeback_control *wbc);
 static int minix_statfs(struct dentry *dentry, struct kstatfs *buf);
-static int minix_remount (struct super_block * sb, int * flags, char * data);
 
 static void minix_evict_inode(struct inode *inode)
 {
@@ -111,19 +111,19 @@ static const struct super_operations minix_sops = {
 	.evict_inode	= minix_evict_inode,
 	.put_super	= minix_put_super,
 	.statfs		= minix_statfs,
-	.remount_fs	= minix_remount,
 };
 
-static int minix_remount (struct super_block * sb, int * flags, char * data)
+static int minix_reconfigure(struct fs_context *fc)
 {
-	struct minix_sb_info * sbi = minix_sb(sb);
 	struct minix_super_block * ms;
+	struct super_block *sb = fc->root->d_sb;
+	struct minix_sb_info * sbi = sb->s_fs_info;
 
 	sync_filesystem(sb);
 	ms = sbi->s_ms;
-	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
+	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
 		return 0;
-	if (*flags & SB_RDONLY) {
+	if (fc->sb_flags & SB_RDONLY) {
 		if (ms->s_state & MINIX_VALID_FS ||
 		    !(sbi->s_mount_state & MINIX_VALID_FS))
 			return 0;
@@ -170,7 +170,7 @@ static bool minix_check_superblock(struct super_block *sb)
 	return true;
 }
 
-static int minix_fill_super(struct super_block *s, void *data, int silent)
+static int minix_fill_super(struct super_block *s, struct fs_context *fc)
 {
 	struct buffer_head *bh;
 	struct buffer_head **map;
@@ -180,6 +180,7 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
 	struct inode *root_inode;
 	struct minix_sb_info *sbi;
 	int ret = -EINVAL;
+	int silent = fc->sb_flags & SB_SILENT;
 
 	sbi = kzalloc(sizeof(struct minix_sb_info), GFP_KERNEL);
 	if (!sbi)
@@ -371,6 +372,23 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
 	return ret;
 }
 
+static int minix_get_tree(struct fs_context *fc)
+{
+	 return get_tree_bdev(fc, minix_fill_super);
+}
+
+static const struct fs_context_operations minix_context_ops = {
+	.get_tree	= minix_get_tree,
+	.reconfigure	= minix_reconfigure,
+};
+
+static int minix_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &minix_context_ops;
+
+	return 0;
+}
+
 static int minix_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
@@ -680,18 +698,12 @@ void minix_truncate(struct inode * inode)
 		V2_minix_truncate(inode);
 }
 
-static struct dentry *minix_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
-{
-	return mount_bdev(fs_type, flags, dev_name, data, minix_fill_super);
-}
-
 static struct file_system_type minix_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "minix",
-	.mount		= minix_mount,
-	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.owner			= THIS_MODULE,
+	.name			= "minix",
+	.kill_sb		= kill_block_super,
+	.fs_flags		= FS_REQUIRES_DEV,
+	.init_fs_context	= minix_init_fs_context,
 };
 MODULE_ALIAS_FS("minix");
 
-- 
2.44.0


