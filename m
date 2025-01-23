Return-Path: <linux-fsdevel+bounces-39919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BB2A19C86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01CDB1885D89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4411192B76;
	Thu, 23 Jan 2025 01:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rK0aBnNc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1771F92A;
	Thu, 23 Jan 2025 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596810; cv=none; b=nSB6CBNfTwEsGgj/5seZze3ZwGGjCoMbn4f1UusiX3Mnfn27W+DOmddScUindomJ96g3KLo5F7C+uHnz1C0Exv99rraeuPKSDxIilxRKiwCrr0DG8RUbhUshnQxN3k1pCwgnPbh8fuf5O0+Jt7MZotGciE0/+VD/oeSHDSZXbaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596810; c=relaxed/simple;
	bh=uuOYAcCsZvfNWBuhkwEcQmxnrFHlSC4MBUvxn5oudH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPvHtyl/ozKfJBBAO9PxiZl877ZuxN77jtYWVw6MABw7Q+v4znEtw9aCh5BzoM0HlzdJ2GUHJ8s2H2j0yNnUDBY03HAjchPshCcXQCj37DHkLECY7ta9LC6dZJb0ryr84kuPb8lS4b6y16hal/U6vODvGJROB6cCuEPU8nSMYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rK0aBnNc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SYkmr2IBFqPKWfGL5TFM2Vx7NKTai7OLmWoPpyDqP5A=; b=rK0aBnNc8O3NA3uUm/qeUI9Eaw
	S8YHjZgdnDz/dDHIaSz2DHD3bIEP2kc9tk+oov0+QvCn0V8+vkc6k6e+LyQMvROOTFmlTdNz7LZ4u
	QfgqHomXYYn6FzQLdXKWhmLWBueR6wjLEgrh8A1/7FkSOUe4Nsjjgbr+D8GPLj6qCy8S+VpkRksI5
	Kw4gZW0X+1gNRUIbyfFDAlyOSYbzuKYciCgYdWDB5eM19kYAF/KN1/zZUmWsdgtWzaUlyTrlR4Kk0
	66g30EaK0U0TkH0QfXFdWU1kiNL5TYacHXAEsaO3HveO4shFbe5ISaQ0/CAFFarNApj78qWAMEZX7
	99Fr59tQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamIv-00000008F3U-1WAq;
	Thu, 23 Jan 2025 01:46:45 +0000
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
Subject: [PATCH v3 16/20] nfs{,4}_lookup_validate(): use stable parent inode passed by caller
Date: Thu, 23 Jan 2025 01:46:39 +0000
Message-ID: <20250123014643.1964371-16-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
References: <20250123014511.GA1962481@ZenIV>
 <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


