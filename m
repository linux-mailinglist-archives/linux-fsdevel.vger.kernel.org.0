Return-Path: <linux-fsdevel+bounces-38965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0676A0A791
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA20F164C78
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40751922F8;
	Sun, 12 Jan 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GlZf0ADp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A25C154456
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669230; cv=none; b=m861I9ib4XnKus+dxoIH62p5Sq2hKnKT1/o+lzZeF92+sRjfq/8MVAmT4IuQAV/Gm9kxnLrFT0anfsddHm22S/xxqzGOEkNUB/Wg4yWRRWFenN4v0+THY4a91WY8Vfr1P/17YMHsziJ4fxeTOVEUkbaloRYqBII5HKn7nBsoBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669230; c=relaxed/simple;
	bh=mHadgRfritLH2mUKjulWkr3tvtB7lzsBxlFk7fvDAmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMKAsdbLstc42TX9a66zLPEaYaQYvbAIpX3+3GjaNsBg/JtMAcYi5w8rSpMKEj6ffN33Ljl7/1IDkI6xw1xTeqpeGbUQEqitgJnrl7X5FKqUU7AZtmAFeH1Julxzmh/kQBWabHRiK/Z1Sw2E8P3+HjiDI6mP6TjYhK0AwdjziUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GlZf0ADp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=L/mnsQLDDKaL2OxxbVxrCZCiNiu/obgKoaYVCacvb4M=; b=GlZf0ADpIU3dJoTur7dy7xZNHi
	LSVuVZQxgLsf/LL8PXh81EICalRhRPBBe4CxAlYkw0xAAm6cvJA13zEQl+NfF6CRyU4HXIf0zncTq
	YeV+ksSKEfDJuxpXrp1CUgrAoIJsyeMpRzJiTPP5aPHd6wnFB1atsnMgs+f3bTNM431jjiR9WXw/K
	bh4LIe4JQTWYm3C/jvQHh9AYR+pYc704buHEBxo8siuMMLVEyX/PbtRI+SSiyHwZXK5WhfMGO1kqr
	YWwsF2yeKkE4PjcWHLlZ/+ec54+gB9V1eaA+DV/qWrXSHm5h2fvtDt497UhjZLTSpuT0C08nuuzY0
	P1nBzvlA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszx-00000000aj0-1mdi;
	Sun, 12 Jan 2025 08:07:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 01/21] debugfs: separate cache for debugfs inodes
Date: Sun, 12 Jan 2025 08:06:45 +0000
Message-ID: <20250112080705.141166-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112080545.GX1977892@ZenIV>
References: <20250112080545.GX1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Embed them into container (struct debugfs_inode_info, with nothing
else in it at the moment), set the cache up, etc.

Just the infrastructure changes letting us augment debugfs inodes
here; adding stuff will come at the next step.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/debugfs/inode.c    | 40 ++++++++++++++++++++++++++++++++++------
 fs/debugfs/internal.h |  9 +++++++++
 2 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index e752009de929..5d423bd92f93 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -208,16 +208,34 @@ static int debugfs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+static struct kmem_cache *debugfs_inode_cachep __ro_after_init;
+
+static void init_once(void *foo)
+{
+	struct debugfs_inode_info *info = foo;
+	inode_init_once(&info->vfs_inode);
+}
+
+static struct inode *debugfs_alloc_inode(struct super_block *sb)
+{
+	struct debugfs_inode_info *info;
+	info = alloc_inode_sb(sb, debugfs_inode_cachep, GFP_KERNEL);
+	if (!info)
+		return NULL;
+	return &info->vfs_inode;
+}
+
 static void debugfs_free_inode(struct inode *inode)
 {
 	if (S_ISLNK(inode->i_mode))
 		kfree(inode->i_link);
-	free_inode_nonrcu(inode);
+	kmem_cache_free(debugfs_inode_cachep, DEBUGFS_I(inode));
 }
 
 static const struct super_operations debugfs_super_operations = {
 	.statfs		= simple_statfs,
 	.show_options	= debugfs_show_options,
+	.alloc_inode	= debugfs_alloc_inode,
 	.free_inode	= debugfs_free_inode,
 };
 
@@ -939,12 +957,22 @@ static int __init debugfs_init(void)
 	if (retval)
 		return retval;
 
-	retval = register_filesystem(&debug_fs_type);
-	if (retval)
+	debugfs_inode_cachep = kmem_cache_create("debugfs_inode_cache",
+				sizeof(struct debugfs_inode_info), 0,
+				SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
+				init_once);
+	if (debugfs_inode_cachep == NULL) {
 		sysfs_remove_mount_point(kernel_kobj, "debug");
-	else
-		debugfs_registered = true;
+		return -ENOMEM;
+	}
 
-	return retval;
+	retval = register_filesystem(&debug_fs_type);
+	if (retval) { // Really not going to happen
+		sysfs_remove_mount_point(kernel_kobj, "debug");
+		kmem_cache_destroy(debugfs_inode_cachep);
+		return retval;
+	}
+	debugfs_registered = true;
+	return 0;
 }
 core_initcall(debugfs_init);
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index bbae4a228ef4..5cb940b0b8f6 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -11,6 +11,15 @@
 
 struct file_operations;
 
+struct debugfs_inode_info {
+	struct inode vfs_inode;
+};
+
+static inline struct debugfs_inode_info *DEBUGFS_I(struct inode *inode)
+{
+	return container_of(inode, struct debugfs_inode_info, vfs_inode);
+}
+
 /* declared over in file.c */
 extern const struct file_operations debugfs_noop_file_operations;
 extern const struct file_operations debugfs_open_proxy_file_operations;
-- 
2.39.5


