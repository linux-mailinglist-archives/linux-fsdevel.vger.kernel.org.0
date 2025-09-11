Return-Path: <linux-fsdevel+bounces-60978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CBFB53ECB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 00:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CA51C240C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 22:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A242F530E;
	Thu, 11 Sep 2025 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wl+Y4M+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FAB23E34C;
	Thu, 11 Sep 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757630792; cv=none; b=gCRF9cQuv71akA/S/Q3XVVUT4+zKjgofs6ezIxxws6OtyRjmzHN+pXivBDtlpUz5zfACy2BtRqeQLVxe8LI3NwTv6LlwRFun5HSSJaHsx4G0V5hB/EU/JRETZJvLiDfCKY46y9wHvJ7qSJivExWQ4bwY6XVc9zG2+qy0THqeHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757630792; c=relaxed/simple;
	bh=RZNDsVsGOGAXkrZfTTJuwdVi+QSAv9GH4uV9YlB0jZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5pFgfaDlpICzc8m541cgXdLf+1lnXWGuOVJ8XYiMMdhKlaVT04wVtxQ8JjZrHLvhMldMGTiWGxH+96a6mZCORO9Tmc70EUbzrZsbTIOQ6V6l33O9VDNpLJUkhGFNddZrnPEcUnZEfRXZhEQwxz+gj0To6yfM2O/RMS/kKVEQZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wl+Y4M+N; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9I9ogF6ckZjiOeaQ6tk1lYm9yI5JWNPHHidN4cgkQ9E=; b=wl+Y4M+Nq3KcaoAWHxKaK/x64x
	XczvBWy5x85lghevUwenptv4KF2g6FvVSzGLTMDYstdxmce8gZC3cFTfEcUG7pwhXZTXFElasBmVz
	w7CeCpavvC1KMWR6Bgm6G8PDPm47kg2CSZKZ6DD6omobZCkW0MA9mc37iMzhHoBTxSQdvnyJa9O6s
	YiRd5++u6CN9fH4hpf2gqWAiiV52h0D7h7HFUC0r+17N1KPbtzAh5LdaH2gPQfbRIEsN2pDU2AHyd
	fBxazQXKuxnXiTPegAs9rIBdhMVYF1Z3J7/xu/ziO58lBnidlljUYzttgyUE+pyYfe/VBW3OwaCD2
	LnmUWcPQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwq3h-00000006g34-0GeC;
	Thu, 11 Sep 2025 22:46:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org,
	jlayton@kernel.org,
	neil@brown.name
Subject: [PATCH 4/5] nfsdfs_create_files(): switch to simple_start_creating()
Date: Thu, 11 Sep 2025 23:46:27 +0100
Message-ID: <20250911224628.1591565-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911224628.1591565-1-viro@zeniv.linux.org.uk>
References: <20250911224429.GX39973@ZenIV>
 <20250911224628.1591565-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfsctl.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 1b5e417784f6..6deabe359a80 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1216,40 +1216,34 @@ struct nfsdfs_client *get_nfsdfs_client(struct inode *inode)
 
 /* XXX: cut'n'paste from simple_fill_super; figure out if we could share
  * code instead. */
-static  int nfsdfs_create_files(struct dentry *root,
+static int nfsdfs_create_files(struct dentry *root,
 				const struct tree_descr *files,
 				struct nfsdfs_client *ncl,
 				struct dentry **fdentries)
 {
 	struct inode *dir = d_inode(root);
-	struct inode *inode;
 	struct dentry *dentry;
-	int i;
 
-	inode_lock(dir);
-	for (i = 0; files->name && files->name[0]; i++, files++) {
-		dentry = d_alloc_name(root, files->name);
-		if (!dentry)
-			goto out;
-		inode = nfsd_get_inode(d_inode(root)->i_sb,
-					S_IFREG | files->mode);
-		if (!inode) {
-			dput(dentry);
-			goto out;
+	for (int i = 0; files->name && files->name[0]; i++, files++) {
+		struct inode *inode = nfsd_get_inode(root->d_sb,
+						     S_IFREG | files->mode);
+		if (!inode)
+			return -ENOMEM;
+		dentry = simple_start_creating(root, files->name);
+		if (IS_ERR(dentry)) {
+			iput(inode);
+			return PTR_ERR(dentry);
 		}
 		kref_get(&ncl->cl_ref);
 		inode->i_fop = files->ops;
 		inode->i_private = ncl;
-		d_add(dentry, inode);
+		d_instantiate(dentry, inode);
 		fsnotify_create(dir, dentry);
 		if (fdentries)
 			fdentries[i] = dentry;
+		inode_unlock(dir);
 	}
-	inode_unlock(dir);
 	return 0;
-out:
-	inode_unlock(dir);
-	return -ENOMEM;
 }
 
 /* on success, returns positive number unique to that client. */
-- 
2.47.2


