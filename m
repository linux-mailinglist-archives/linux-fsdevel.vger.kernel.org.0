Return-Path: <linux-fsdevel+bounces-39368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8726A13277
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA9A166DEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BCB1990D9;
	Thu, 16 Jan 2025 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vhuXjkFj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8BA15747D;
	Thu, 16 Jan 2025 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005003; cv=none; b=jzggpVMkO56klMvXyYRNueIjICI2UcFE24qurDWpP02XxwHW2tltDbkX0M9rjA7t53BJ0RIxsx8MAzVoGQeiJR6RdQt2xjf8MAG955dnVoBPKGKruCxqs5+ZyKiWY9d2fKcDHmv3O8c4sTGp4c1RDGTuY/znNg69T96bqrtibMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005003; c=relaxed/simple;
	bh=0+hFddWLFnmL+tckEgZ67f4iwTSw7MM/4NhMsRHp1tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYu36Bmrxgm3INmEUPqpq/R4C8dNUWioJCkmqo2FCxqpkVUITRCLFXvGOBcixuzEVDkhWIdKHtZWAM1x25hFEcKZTdTU2blM81PWX1CIOFZzlZ8KmMRMO/xExxG9av8vbYxurNB52Oj00mLCYhvzqjYBeCLek0WKkypqmkBfuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vhuXjkFj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uKVFcS5x/dn1Dud+2w3p9ch7ol0X1AFzGaKnw/NDGIE=; b=vhuXjkFjYSCIcw27AhRhUmDQd5
	JvAPZiMwX7KZDvGNVxN6kewRJkdXnKSZSky55wDh5FR9hALU52QV5bGr8Qr8LJvsP6cER8ZjTAVsJ
	Ulo2oQgpRDW8f1gzSSON3Mt7ekXssYD/zVDnvW5Vb3UJj4it9e3kQiNAhPYf2LGg2DNd0PB3pDlaH
	ASRNbzRhHnUMnzyJV3uEC/rhKey1AueXYfmrLmw+oRrk/2r2Ug5N4Vptn6QrQf1IZAUxGrxVofQID
	b5qw6bBvp7PW3efk8oEUrNVOH9e6vgGkan2Z6CfSZR0yz875QKdxd9v2xOO3mDX7yUcRFjMgYjGjf
	Oy11D+XQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYILf-000000022IJ-31di;
	Thu, 16 Jan 2025 05:23:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH v2 16/20] nfs{,4}_lookup_validate(): use stable parent inode passed by caller
Date: Thu, 16 Jan 2025 05:23:13 +0000
Message-ID: <20250116052317.485356-16-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116052317.485356-1-viro@zeniv.linux.org.uk>
References: <20250116052103.GF1977892@ZenIV>
 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

we can't kill __nfs_lookup_revalidate() completely, but ->d_parent boilerplate
in it is gone

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/dir.c | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 9910d9796f4c..c28983ee75ca 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1732,8 +1732,8 @@ static int nfs_lookup_revalidate_dentry(struct inode *dir,
  * cached dentry and do a new lookup.
  */
 static int
-nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
-			 unsigned int flags)
+nfs_do_lookup_revalidate(struct inode *dir, const struct qstr *name,
+			 struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
 	int error = 0;
@@ -1785,39 +1785,26 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 }
 
 static int
-__nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags,
-			int (*reval)(struct inode *, struct dentry *, unsigned int))
+__nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 {
-	struct dentry *parent;
-	struct inode *dir;
-	int ret;
-
 	if (flags & LOOKUP_RCU) {
 		if (dentry->d_fsdata == NFS_FSDATA_BLOCKED)
 			return -ECHILD;
-		parent = READ_ONCE(dentry->d_parent);
-		dir = d_inode_rcu(parent);
-		if (!dir)
-			return -ECHILD;
-		ret = reval(dir, dentry, flags);
-		if (parent != READ_ONCE(dentry->d_parent))
-			return -ECHILD;
 	} else {
 		/* Wait for unlink to complete - see unblock_revalidate() */
 		wait_var_event(&dentry->d_fsdata,
 			       smp_load_acquire(&dentry->d_fsdata)
 			       != NFS_FSDATA_BLOCKED);
-		parent = dget_parent(dentry);
-		ret = reval(d_inode(parent), dentry, flags);
-		dput(parent);
 	}
-	return ret;
+	return 0;
 }
 
 static int nfs_lookup_revalidate(struct inode *dir, const struct qstr *name,
 				 struct dentry *dentry, unsigned int flags)
 {
-	return __nfs_lookup_revalidate(dentry, flags, nfs_do_lookup_revalidate);
+	if (__nfs_lookup_revalidate(dentry, flags))
+		return -ECHILD;
+	return nfs_do_lookup_revalidate(dir, name, dentry, flags);
 }
 
 static void block_revalidate(struct dentry *dentry)
@@ -2216,11 +2203,14 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 EXPORT_SYMBOL_GPL(nfs_atomic_open);
 
 static int
-nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
-			  unsigned int flags)
+nfs4_lookup_revalidate(struct inode *dir, const struct qstr *name,
+		       struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
 
+	if (__nfs_lookup_revalidate(dentry, flags))
+		return -ECHILD;
+
 	trace_nfs_lookup_revalidate_enter(dir, dentry, flags);
 
 	if (!(flags & LOOKUP_OPEN) || (flags & LOOKUP_DIRECTORY))
@@ -2259,14 +2249,7 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
 
 full_reval:
-	return nfs_do_lookup_revalidate(dir, dentry, flags);
-}
-
-static int nfs4_lookup_revalidate(struct inode *dir, const struct qstr *name,
-				  struct dentry *dentry, unsigned int flags)
-{
-	return __nfs_lookup_revalidate(dentry, flags,
-			nfs4_do_lookup_revalidate);
+	return nfs_do_lookup_revalidate(dir, name, dentry, flags);
 }
 
 #endif /* CONFIG_NFSV4 */
-- 
2.39.5


