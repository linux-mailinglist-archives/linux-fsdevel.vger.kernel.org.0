Return-Path: <linux-fsdevel+bounces-13660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C0E872921
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 22:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343B11F22B03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 21:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42F612A173;
	Tue,  5 Mar 2024 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UD2tw1qa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851D014012
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672928; cv=none; b=ECfdZiovVZ9EChukvxLJL57Nod/pL0BfpXWHZjQTRydYVf8C87og6hLQuwloC/IRvi2rnBa8dYBx/xf5/xAzqd9J6zhydzz4A2M43N3reGwSJqdlS4oc7J7Fkka37+XkCMVRsd0AY9u+baHF3Nsj3VkrZIXgtEIaojJFp2ZYEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672928; c=relaxed/simple;
	bh=hxcf9uP0aEOXNq7qUgJSy+IvdHTpTc5eZnnjD0eh7II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKRqPodgQeCZGoEjtkCLvxrZj9oPllgzuT4l62AuYUlMcPRVc/SH9yiIUKvzGEhynscoBlO/anmGsn4CWEb5L9zh/kcDt6Q7XBSwgk/dVZ+cBFxisFv8gXh7HsTXFK3y3Qxwtf4N/J5mDG0YGE85YSI4SpMNC9AE76zuchhyaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UD2tw1qa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709672925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KpvmWkvcSNBDny0fBaZJcu0KNQdPAMGp2g8e+vi2M7g=;
	b=UD2tw1qa6TTM7SXIJRITykeLJRfgG410s1gP8nBD1Qve32uuz1nq37FsBR+iI0Vkbaz95b
	txL0xzj1tk+7aSANcj83xedHEfQ0LQG6TDNvAGFLp/l/QUBqT8nbwfVBRugJnUV6/M2Gm1
	oqkzePx93QpACrkHZmKQyuwUvTI0OhY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-Q3QpTukwMdO93Wmpg4p3lA-1; Tue, 05 Mar 2024 16:08:44 -0500
X-MC-Unique: Q3QpTukwMdO93Wmpg4p3lA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7A09800267;
	Tue,  5 Mar 2024 21:08:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 049F94073598;
	Tue,  5 Mar 2024 21:08:42 +0000 (UTC)
From: Bill O'Donnell <bodonnel@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	sandeen@redhat.com,
	Bill O'Donnell <bodonnel@redhat.com>
Subject: [PATCH] minix: convert minix to use the new mount api
Date: Tue,  5 Mar 2024 15:08:18 -0600
Message-ID: <20240305210829.943737-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Convert the minix filesystem to use the new mount API.

Tested using mount and remount on minix device.

Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
---
 fs/minix/inode.c | 64 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 73f37f298087..248e78a118e7 100644
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
@@ -371,6 +372,39 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
 	return ret;
 }
 
+static int minix_get_tree(struct fs_context *fc)
+{
+	 return get_tree_bdev(fc, minix_fill_super);
+}
+
+static void minix_free_fc(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
+
+struct minix_context {
+	unsigned long s_mount_opts;
+};
+
+static const struct fs_context_operations minix_context_ops = {
+	.get_tree	= minix_get_tree,
+	.reconfigure	= minix_reconfigure,
+	.free		= minix_free_fc,
+};
+
+static int minix_init_fs_context(struct fs_context *fc)
+{
+	struct minix_context *ctx;
+
+	ctx = kzalloc(sizeof(struct minix_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	fc->ops = &minix_context_ops;
+	fc->fs_private = ctx;
+
+	return 0;
+}
+
 static int minix_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
@@ -680,18 +714,12 @@ void minix_truncate(struct inode * inode)
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


