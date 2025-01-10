Return-Path: <linux-fsdevel+bounces-38787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB4AA08592
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B523A9127
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E9B674;
	Fri, 10 Jan 2025 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RajbiAnE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1671E2617;
	Fri, 10 Jan 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476989; cv=none; b=FkTitcAsFWbLf/3Gdh+eNFAB4GrvSxqupaeZPfVaD+s1Okvl+FeKyyeDKsZiq+yfB1wlIFKrmEYotq5YM7nE70/cvHIqN+ekykHFIV6NwichnLgR4+eAKsl8tECoRx0y8c5xbw2sdJlo4yW0zGvnTRssweuCgeB0IArosAeOkg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476989; c=relaxed/simple;
	bh=0+hFddWLFnmL+tckEgZ67f4iwTSw7MM/4NhMsRHp1tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0gBIBvLGFffZHkF+V7U6MBlwiew5DUMjuPWm2zVPFaEZtaFqAV3PZqcCrlCviI2ofiG9KKwq8gIYcZlhGPfUHNplLFQA0SxurJdbACAODHtG9Nxz/b4gubMm/oOTve1VHrZykjZNQteaSe/zGJJA8R27FDq54xD0oIkbGeHBeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RajbiAnE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uKVFcS5x/dn1Dud+2w3p9ch7ol0X1AFzGaKnw/NDGIE=; b=RajbiAnE+YYGcwO45RVBt4amQY
	xPgr60+FlgQdeC4x5yU9Jlav4skSB+LmaBz19PvQeiMQXx7QW1xZX/4q0la1ZxJxJcBk6Zqt71DYd
	GLiN24aN5W48scgxRo5AL/fWihGm7WlRXtprBw9SVbLiGqaVsHm+QE1+aeNNcpsyAH5++M+hWZlsq
	ZxWj61CmSUY9FYa1lhAfroxe/ldgYFbvGNdi9gOhEm8NpffzwqSD9JVPsTXq44xqxhZPlIZT+IQw3
	SOypvAVC+jCT46v6Yj5ceTAXgjAbcvXbZ7A+xzLHObqYjW8KEvx1xX0qvfRe7mjdAv18a2Xy1LKiB
	aJUpXBFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4zJ-0000000HRcg-1BUD;
	Fri, 10 Jan 2025 02:43:05 +0000
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
Subject: [PATCH 16/20] nfs{,4}_lookup_validate(): use stable parent inode passed by caller
Date: Fri, 10 Jan 2025 02:42:59 +0000
Message-ID: <20250110024303.4157645-16-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
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


