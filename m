Return-Path: <linux-fsdevel+bounces-3599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4217F6BE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1001F20F71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411535699;
	Fri, 24 Nov 2023 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XeXLFlO4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC539D5C;
	Thu, 23 Nov 2023 22:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QVkAuzyOVfZEPbtFLrMy972YXvNnlxohvZRBOnyl33o=; b=XeXLFlO4ueo6GsI8wTl/Y9OgMq
	3oCXaGBKljqckVIDfLDyZRM3YjKDP6R5ao4CCf2JvibohIcGERPM+QFnPwYLczpQlSlT5laXtz8/2
	IvZ440Q20n30HbwSgaQXYqkTuQcEoBPphy36wvNI37Hmd5x8Nl3vba0DKDkaaDwrR6/PGgoDEfHVP
	CvOwIhKpi3E7xSVBnHnKF2DW5XeTP+QDmlkSmw2Nwio9H7/2SYlbGyQepfj/X91MduDO0VTMvIkEK
	d7pVbzTRAWRXK4ZT/98qagc9MfpFAnC8zAer7cfpxiMOJqLQVEr1xhiT5mwRxcTsFHofVQ0kF2gHx
	/d2HklDg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PIc-002Ptd-1Q;
	Fri, 24 Nov 2023 06:04:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/21] switch nfsd_client_rmdir() to use of simple_recursive_removal()
Date: Fri, 24 Nov 2023 06:04:02 +0000
Message-Id: <20231124060422.576198-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060200.GR38156@ZenIV>
References: <20231124060200.GR38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

nfsd_client_rmdir() open-codes a subset of simple_recursive_removal().
Conversion to calling simple_recursive_removal() allows to clean things
up quite a bit.

While we are at it, nfsdfs_create_files() doesn't need to mess with "pick
the reference to struct nfsdfs_client from the already created parent" -
the caller already knows it (that's where the parent got it from,
after all), so we might as well just pass it as an explicit argument.
So __get_nfsdfs_client() is only needed in get_nfsdfs_client() and
can be folded in there.

Incidentally, the locking in get_nfsdfs_client() is too heavy - we don't
need ->i_rwsem for that, ->i_lock serves just fine.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfsctl.c | 70 ++++++++++--------------------------------------
 1 file changed, 14 insertions(+), 56 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3e15b72f421d..50df5e9d0069 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1236,63 +1236,34 @@ static inline void _nfsd_symlink(struct dentry *parent, const char *name,
 
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
@@ -1311,8 +1282,9 @@ static  int nfsdfs_create_files(struct dentry *root,
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
@@ -1321,7 +1293,6 @@ static  int nfsdfs_create_files(struct dentry *root,
 	inode_unlock(dir);
 	return 0;
 out:
-	nfsdfs_remove_files(root);
 	inode_unlock(dir);
 	return -ENOMEM;
 }
@@ -1341,7 +1312,7 @@ struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
 	dentry = nfsd_mkdir(nn->nfsd_client_dir, ncl, name);
 	if (IS_ERR(dentry)) /* XXX: tossing errors? */
 		return NULL;
-	ret = nfsdfs_create_files(dentry, files, fdentries);
+	ret = nfsdfs_create_files(dentry, files, ncl, fdentries);
 	if (ret) {
 		nfsd_client_rmdir(dentry);
 		return NULL;
@@ -1352,20 +1323,7 @@ struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
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


