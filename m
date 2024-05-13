Return-Path: <linux-fsdevel+bounces-19369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0887E8C40E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 14:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FD7281761
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 12:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6F914F9C8;
	Mon, 13 May 2024 12:42:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549414BFAB
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604123; cv=none; b=Z8ZtQkKerJIDb4SQpQIEtN6MQNtWe0rfpsVxiNjDIxmKcFpVMyHSP/Xyy8KzbAbF61aI0EAhTmj4OE2ZOXKGeQCZmD+I57PnUpwAAJgufrbToa24S/RSOQTGAMPDW0MAhxof/2vufM3ast3/I8kW1uCfHb3BGf2lL4m+8nWTtBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604123; c=relaxed/simple;
	bh=X0W4OH23nS9KGFG0qHf1YkHBT1cnvvDJ00XPoaKWxU4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XHmFI9E0KMJtmHIUKbTgSxCd599f6qaKSSSrz00xHJ+RyUx0TOQ+7Gvb+coicPCMWy5TqrToTcgZahmQ087pkQpcWUwWd3vJzFe/9AV9mr2zCdpEbIsiJNITIUou2oOSpofCZXVb62t/1P6vcXYdXGy0yqirCk+hPe4kf5+wYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VdJtt56Yjz2ChqR;
	Mon, 13 May 2024 20:38:30 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id C5A1F1A016C;
	Mon, 13 May 2024 20:41:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 13 May
 2024 20:41:51 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH] hostfs: convert hostfs to use the new mount api
Date: Mon, 13 May 2024 20:41:41 +0800
Message-ID: <20240513124141.3788846-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Convert the hostfs filesystem to use the new mount API.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/hostfs/hostfs_kern.c | 83 ++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index a73d27c4dd58..24e64dda65df 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -16,11 +16,16 @@
 #include <linux/seq_file.h>
 #include <linux/writeback.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/namei.h>
 #include "hostfs.h"
 #include <init.h>
 #include <kern.h>
 
+struct hostfs_fs_info {
+	char *host_root_path;
+};
+
 struct hostfs_inode_info {
 	int fd;
 	fmode_t mode;
@@ -90,8 +95,10 @@ static char *__dentry_name(struct dentry *dentry, char *name)
 	char *p = dentry_path_raw(dentry, name, PATH_MAX);
 	char *root;
 	size_t len;
+	struct hostfs_fs_info *fsi;
 
-	root = dentry->d_sb->s_fs_info;
+	fsi = dentry->d_sb->s_fs_info;
+	root = fsi->host_root_path;
 	len = strlen(root);
 	if (IS_ERR(p)) {
 		__putname(name);
@@ -196,8 +203,10 @@ static int hostfs_statfs(struct dentry *dentry, struct kstatfs *sf)
 	long long f_bavail;
 	long long f_files;
 	long long f_ffree;
+	struct hostfs_fs_info *fsi;
 
-	err = do_statfs(dentry->d_sb->s_fs_info,
+	fsi = dentry->d_sb->s_fs_info;
+	err = do_statfs(fsi->host_root_path,
 			&sf->f_bsize, &f_blocks, &f_bfree, &f_bavail, &f_files,
 			&f_ffree, &sf->f_fsid, sizeof(sf->f_fsid),
 			&sf->f_namelen);
@@ -245,7 +254,11 @@ static void hostfs_free_inode(struct inode *inode)
 
 static int hostfs_show_options(struct seq_file *seq, struct dentry *root)
 {
-	const char *root_path = root->d_sb->s_fs_info;
+	struct hostfs_fs_info *fsi;
+	const char *root_path;
+
+	fsi = root->d_sb->s_fs_info;
+	root_path = fsi->host_root_path;
 	size_t offset = strlen(root_ino) + 1;
 
 	if (strlen(root_path) > offset)
@@ -922,10 +935,11 @@ static const struct inode_operations hostfs_link_iops = {
 	.get_link	= hostfs_get_link,
 };
 
-static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
+static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct hostfs_fs_info *fsi = sb->s_fs_info;
 	struct inode *root_inode;
-	char *host_root_path, *req_root = d;
+	char *host_root;
 	int err;
 
 	sb->s_blocksize = 1024;
@@ -939,15 +953,15 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 		return err;
 
 	/* NULL is printed as '(null)' by printf(): avoid that. */
-	if (req_root == NULL)
-		req_root = "";
+	if (fc->source == NULL)
+		host_root = "";
 
-	sb->s_fs_info = host_root_path =
-		kasprintf(GFP_KERNEL, "%s/%s", root_ino, req_root);
-	if (host_root_path == NULL)
+	fsi->host_root_path =
+		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
+	if (fsi->host_root_path == NULL)
 		return -ENOMEM;
 
-	root_inode = hostfs_iget(sb, host_root_path);
+	root_inode = hostfs_iget(sb, fsi->host_root_path);
 	if (IS_ERR(root_inode))
 		return PTR_ERR(root_inode);
 
@@ -955,7 +969,7 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 		char *name;
 
 		iput(root_inode);
-		name = follow_link(host_root_path);
+		name = follow_link(fsi->host_root_path);
 		if (IS_ERR(name))
 			return PTR_ERR(name);
 
@@ -972,11 +986,38 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 	return 0;
 }
 
-static struct dentry *hostfs_read_sb(struct file_system_type *type,
-			  int flags, const char *dev_name,
-			  void *data)
+static int hostfs_fc_get_tree(struct fs_context *fc)
 {
-	return mount_nodev(type, flags, data, hostfs_fill_sb_common);
+	return get_tree_nodev(fc, hostfs_fill_super);
+}
+
+static void hostfs_fc_free(struct fs_context *fc)
+{
+	struct hostfs_fs_info *fsi = fc->s_fs_info;
+
+	if (!fsi)
+		return;
+
+	kfree(fsi->host_root_path);
+	kfree(fsi);
+}
+
+static const struct fs_context_operations hostfs_context_ops = {
+	.get_tree	= hostfs_fc_get_tree,
+	.free		= hostfs_fc_free,
+};
+
+static int hostfs_init_fs_context(struct fs_context *fc)
+{
+	struct hostfs_fs_info *fsi;
+
+	fsi = kzalloc(sizeof(*fsi), GFP_KERNEL);
+	if (!fsi)
+		return -ENOMEM;
+
+	fc->s_fs_info = fsi;
+	fc->ops = &hostfs_context_ops;
+	return 0;
 }
 
 static void hostfs_kill_sb(struct super_block *s)
@@ -986,11 +1027,11 @@ static void hostfs_kill_sb(struct super_block *s)
 }
 
 static struct file_system_type hostfs_type = {
-	.owner 		= THIS_MODULE,
-	.name 		= "hostfs",
-	.mount	 	= hostfs_read_sb,
-	.kill_sb	= hostfs_kill_sb,
-	.fs_flags 	= 0,
+	.owner			= THIS_MODULE,
+	.name			= "hostfs",
+	.init_fs_context	= hostfs_init_fs_context,
+	.kill_sb		= hostfs_kill_sb,
+	.fs_flags		= 0,
 };
 MODULE_ALIAS_FS("hostfs");
 
-- 
2.34.1


