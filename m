Return-Path: <linux-fsdevel+bounces-38219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3889FDDEF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF683A1691
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0D2770FE;
	Sun, 29 Dec 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RwqC9iyP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2254A382
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459947; cv=none; b=GxmlSWbGqC92SGXezkN53JKH7XkyvrnE2BTNkJIcPLtJLDeGKBX5Eca12hUJDh21AgeLlX4GUm75ojPASgbY1h2BGffXd0WnomeVZWi+yZZHHMwE3oL4hArYJWea6hvrqzFuYyxC0wSQ1kO8FIt0iuDwRPkZdMUWSpoyFlyRh60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459947; c=relaxed/simple;
	bh=DvSzu25NvyU8hfJsGrDzjIfqpxi6eeWq1OLykA0P30c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCGNRkhvhLIOqheDOh7s6ttbenPsYrJKZuvQC3mKdwMxOQLeh17MryCa2e6lnKxlrRO3Ev0wBE4XU9rXTU38xR+qSGSf0KmNVfj2Pl56lT4D9+/Szra3uoj9kQ9HVhrXr8AJNzk/T3mGUVUCQeXNWV3hZcYrMt09C6GA8qqKv8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RwqC9iyP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RslBjbp5gC4N/iAPMGBpdd2f80meoVcSVQLKN4iLbPw=; b=RwqC9iyPSTScwDLcfF5k8djGlz
	bB3Q6g+yckvQo+kHdJvzmT89Q2Or9nYKy+8QBgSgvmZUDNpX5RoOqcLaNJh4OyD2PyUDdgAGQSH1o
	j6QbDi00xjRMMjcLtcVzRhcIEiGvtYkJzoM4qS3EZ3mN57CBKflc/V1fNWTWCWZGwj7ge37RN2YMS
	t4XlS3b6kg6BjwaG5peK/i33aCv1JzLY23WlITAmk3PoSj6SQ6xP1xYSRJbmW5Frawx7Nr3H8cu1r
	a/LjOPSNd1J/0bR7aDdV69GyyC0RJ40Bjikh6DdhVu7Z2HgLcIKRFca+JGnX3P/Ob61OygftuMTE5
	AyapCbYw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPP-0000000DOhp-2dlz;
	Sun, 29 Dec 2024 08:12:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 02/20] debugfs: separate cache for debugfs inodes
Date: Sun, 29 Dec 2024 08:12:05 +0000
Message-ID: <20241229081223.3193228-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
References: <20241229080948.GY1977892@ZenIV>
 <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
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
index c99a0599c811..6194c1cd87b9 100644
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
 
@@ -942,12 +960,22 @@ static int __init debugfs_init(void)
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
index a3edfa4f0d8e..0926d865cd81 100644
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


