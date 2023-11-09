Return-Path: <linux-fsdevel+bounces-2472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 806DE7E63B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD412812C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338F8DF6A;
	Thu,  9 Nov 2023 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JeY1xkge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C6D304
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:20:58 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8C826AB
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OrmJa85C5elcGZzOrChSJYM4gm189u5IK4tOJQ7Bupg=; b=JeY1xkge7QFAGBdCOwOiC5OQz7
	vuP1/tsDxwprQ+e/zI7Mxpj6XqGz5ucIImbULUQzQvHVs7RdLJkjyc6YEdPILUAPN/5mhc+aKb5hG
	LNn4m3IeYJcs091o5hMrcbs8bEFRQfDz4p1WxiMbzDn2ILWI4MHVD+k/OA0BIl9FLJ5K7N30MaaiF
	06TwIdKVeWnx1gsOvPILYt6US/isN+RNzLaY7YBHU7zirxvtk9LxvevBKposPrJY/dDLU+w7o5QQr
	iCJ0Z4cix2EdT1m+09g/7f+c+G83KCc6jfdqCshfLoire/JitYxWxVBGet1kSwM9U+kB/MBoFNylO
	xnEtEJdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPQ-00DLj6-1M;
	Thu, 09 Nov 2023 06:20:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 02/22] switch nfsd_client_rmdir() to use of simple_recursive_removal()
Date: Thu,  9 Nov 2023 06:20:36 +0000
Message-Id: <20231109062056.3181775-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfsctl.c | 70 ++++++++++--------------------------------------
 1 file changed, 14 insertions(+), 56 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 7ed02fb88a36..035b42c1a181 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1235,63 +1235,34 @@ static inline void _nfsd_symlink(struct dentry *parent, const char *name,
 
 #endif
 
-static void clear_ncl(struct inode *inode)
+static void clear_ncl(struct dentry *dentry)
 {
+	struct inode *inode = d_inode(dentry);
 	struct nfsdfs_client *ncl = inode->i_private;
 
+	spin_lock(&inode->i_lock);
 	inode->i_private = NULL;
+	spin_unlock(&inode->i_lock);
 	kref_put(&ncl->cl_ref, ncl->cl_release);
 }
 
-static struct nfsdfs_client *__get_nfsdfs_client(struct inode *inode)
-{
-	struct nfsdfs_client *nc = inode->i_private;
-
-	if (nc)
-		kref_get(&nc->cl_ref);
-	return nc;
-}
-
 struct nfsdfs_client *get_nfsdfs_client(struct inode *inode)
 {
 	struct nfsdfs_client *nc;
 
-	inode_lock_shared(inode);
-	nc = __get_nfsdfs_client(inode);
-	inode_unlock_shared(inode);
+	spin_lock(&inode->i_lock);
+	nc = inode->i_private;
+	if (nc)
+		kref_get(&nc->cl_ref);
+	spin_unlock(&inode->i_lock);
 	return nc;
 }
-/* from __rpc_unlink */
-static void nfsdfs_remove_file(struct inode *dir, struct dentry *dentry)
-{
-	int ret;
-
-	clear_ncl(d_inode(dentry));
-	dget(dentry);
-	ret = simple_unlink(dir, dentry);
-	d_drop(dentry);
-	fsnotify_unlink(dir, dentry);
-	dput(dentry);
-	WARN_ON_ONCE(ret);
-}
-
-static void nfsdfs_remove_files(struct dentry *root)
-{
-	struct dentry *dentry, *tmp;
-
-	list_for_each_entry_safe(dentry, tmp, &root->d_subdirs, d_child) {
-		if (!simple_positive(dentry)) {
-			WARN_ON_ONCE(1); /* I think this can't happen? */
-			continue;
-		}
-		nfsdfs_remove_file(d_inode(root), dentry);
-	}
-}
 
 /* XXX: cut'n'paste from simple_fill_super; figure out if we could share
  * code instead. */
 static  int nfsdfs_create_files(struct dentry *root,
 				const struct tree_descr *files,
+				struct nfsdfs_client *ncl,
 				struct dentry **fdentries)
 {
 	struct inode *dir = d_inode(root);
@@ -1310,8 +1281,9 @@ static  int nfsdfs_create_files(struct dentry *root,
 			dput(dentry);
 			goto out;
 		}
+		kref_get(&ncl->cl_ref);
 		inode->i_fop = files->ops;
-		inode->i_private = __get_nfsdfs_client(dir);
+		inode->i_private = ncl;
 		d_add(dentry, inode);
 		fsnotify_create(dir, dentry);
 		if (fdentries)
@@ -1320,7 +1292,6 @@ static  int nfsdfs_create_files(struct dentry *root,
 	inode_unlock(dir);
 	return 0;
 out:
-	nfsdfs_remove_files(root);
 	inode_unlock(dir);
 	return -ENOMEM;
 }
@@ -1340,7 +1311,7 @@ struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
 	dentry = nfsd_mkdir(nn->nfsd_client_dir, ncl, name);
 	if (IS_ERR(dentry)) /* XXX: tossing errors? */
 		return NULL;
-	ret = nfsdfs_create_files(dentry, files, fdentries);
+	ret = nfsdfs_create_files(dentry, files, ncl, fdentries);
 	if (ret) {
 		nfsd_client_rmdir(dentry);
 		return NULL;
@@ -1351,20 +1322,7 @@ struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
 /* Taken from __rpc_rmdir: */
 void nfsd_client_rmdir(struct dentry *dentry)
 {
-	struct inode *dir = d_inode(dentry->d_parent);
-	struct inode *inode = d_inode(dentry);
-	int ret;
-
-	inode_lock(dir);
-	nfsdfs_remove_files(dentry);
-	clear_ncl(inode);
-	dget(dentry);
-	ret = simple_rmdir(dir, dentry);
-	WARN_ON_ONCE(ret);
-	d_drop(dentry);
-	fsnotify_rmdir(dir, dentry);
-	dput(dentry);
-	inode_unlock(dir);
+	simple_recursive_removal(dentry, clear_ncl);
 }
 
 static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
-- 
2.39.2


