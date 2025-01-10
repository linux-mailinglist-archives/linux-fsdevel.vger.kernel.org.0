Return-Path: <linux-fsdevel+bounces-38796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CF0A085AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0EB316A22E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C88A208984;
	Fri, 10 Jan 2025 02:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jWHcCZmB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67A1E2834;
	Fri, 10 Jan 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476993; cv=none; b=LIrBO6y69YzXXTRu+mG5+/0c1UTinCtF1RJ5Iv5yNG8WC15UNY11hCipGEDfl9JFeRY/bSWOUV1G/fWnUtuxJPG7evoWSuqmPCljwnv3iHeGFKKe3fST4gAqwV0ipz6yH2EpAiJiRnCwQfab2hg4erWnSbXM4eItHJMizgUhRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476993; c=relaxed/simple;
	bh=WjnWhmgt9zuygTIGD9dWA4MFBxRpoq0A9ieZxKN31bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCKn2bWHkU4ibpZBZqC3ABNah5JvEpue5evwljq9XfZ7++daZupckvc4mtU3K3wct2CbKWAhtt6Mg5J1aKDrTwPRNuRdVI9LuwxTcUjQ12bOUBG1uk4tPD8Js+ktS8X5zIoCFcMW5po/eCpaFerOyxnRfALr1McL99Yj1OwPkNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jWHcCZmB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TcX3HdLjp4/G/keqTn54A6aHLaiivHSK4H9LiSfHyBY=; b=jWHcCZmBNznQP7dFotUoUkd01X
	skh6xNZilUbxCzrhemRboOzjR9mf1pfhrekhkZvXNZosq2l1uGNPvKG9FfVcS9AOsEBj7P4vWaZbP
	Zc0GaMjtRY4zTO7ZubD7bAC5627DIDED4rXnrbfQji+Y4iJk6Xmi0rhYcySwdfA3Cs7fVf3PDMBc/
	+7NraT12eeKZYKLPp/ouhXjYyDieFsdLONX0v6ZIN2Z0JUHrkwnOSMJHDSuOAK/GCN1GXPsdH2Ptt
	/K6ClqTmMgQLsuwcg+WDbur3CAPiaasHcLKxUQs+i5dBzwXKUr+6UTOhjP6XWUwvmSoIx88ArHz+Y
	IxLbr/xA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4zJ-0000000HRcs-1bzr;
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
Subject: [PATCH 17/20] nfs: fix ->d_revalidate() UAF on ->d_name accesses
Date: Fri, 10 Jan 2025 02:43:00 +0000
Message-ID: <20250110024303.4157645-17-viro@zeniv.linux.org.uk>
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

Pass the stable name all the way down to ->rpc_ops->lookup() instances.

Note that passing &dentry->d_name is safe in e.g. nfs_lookup() - it *is*
stable there, as it is in ->create() et.al.

dget_parent() in nfs_instantiate() should be redundant - it'd better be
stable there; if it's not, we have more trouble, since ->d_name would
also be unsafe in such case.

nfs_submount() and nfs4_submount() may or may not require fixes - if
they ever get moved on server with fhandle preserved, we are in trouble
there...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/dir.c            | 14 ++++++++------
 fs/nfs/namespace.c      |  2 +-
 fs/nfs/nfs3proc.c       |  5 ++---
 fs/nfs/nfs4proc.c       | 20 ++++++++++----------
 fs/nfs/proc.c           |  6 +++---
 include/linux/nfs_xdr.h |  2 +-
 6 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c28983ee75ca..2b04038b0e40 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1672,7 +1672,7 @@ nfs_lookup_revalidate_delegated(struct inode *dir, struct dentry *dentry,
 	return nfs_lookup_revalidate_done(dir, dentry, inode, 1);
 }
 
-static int nfs_lookup_revalidate_dentry(struct inode *dir,
+static int nfs_lookup_revalidate_dentry(struct inode *dir, const struct qstr *name,
 					struct dentry *dentry,
 					struct inode *inode, unsigned int flags)
 {
@@ -1690,7 +1690,7 @@ static int nfs_lookup_revalidate_dentry(struct inode *dir,
 		goto out;
 
 	dir_verifier = nfs_save_change_attribute(dir);
-	ret = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
+	ret = NFS_PROTO(dir)->lookup(dir, dentry, name, fhandle, fattr);
 	if (ret < 0)
 		goto out;
 
@@ -1775,7 +1775,7 @@ nfs_do_lookup_revalidate(struct inode *dir, const struct qstr *name,
 	if (NFS_STALE(inode))
 		goto out_bad;
 
-	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
+	return nfs_lookup_revalidate_dentry(dir, name, dentry, inode, flags);
 out_valid:
 	return nfs_lookup_revalidate_done(dir, dentry, inode, 1);
 out_bad:
@@ -1970,7 +1970,8 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 
 	dir_verifier = nfs_save_change_attribute(dir);
 	trace_nfs_lookup_enter(dir, dentry, flags);
-	error = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
+	error = NFS_PROTO(dir)->lookup(dir, dentry, &dentry->d_name,
+				       fhandle, fattr);
 	if (error == -ENOENT) {
 		if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
 			dir_verifier = inode_peek_iversion_raw(dir);
@@ -2246,7 +2247,7 @@ nfs4_lookup_revalidate(struct inode *dir, const struct qstr *name,
 reval_dentry:
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
-	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
+	return nfs_lookup_revalidate_dentry(dir, name, dentry, inode, flags);
 
 full_reval:
 	return nfs_do_lookup_revalidate(dir, name, dentry, flags);
@@ -2305,7 +2306,8 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 	d_drop(dentry);
 
 	if (fhandle->size == 0) {
-		error = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
+		error = NFS_PROTO(dir)->lookup(dir, dentry, &dentry->d_name,
+					       fhandle, fattr);
 		if (error)
 			goto out_error;
 	}
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 2d53574da605..973aed9cc5fe 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -308,7 +308,7 @@ int nfs_submount(struct fs_context *fc, struct nfs_server *server)
 	int err;
 
 	/* Look it up again to get its attributes */
-	err = server->nfs_client->rpc_ops->lookup(d_inode(parent), dentry,
+	err = server->nfs_client->rpc_ops->lookup(d_inode(parent), dentry, &dentry->d_name,
 						  ctx->mntfh, ctx->clone_data.fattr);
 	dput(parent);
 	if (err != 0)
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1566163c6d85..ce70768e0201 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -192,7 +192,7 @@ __nfs3_proc_lookup(struct inode *dir, const char *name, size_t len,
 }
 
 static int
-nfs3_proc_lookup(struct inode *dir, struct dentry *dentry,
+nfs3_proc_lookup(struct inode *dir, struct dentry *dentry, const struct qstr *name,
 		 struct nfs_fh *fhandle, struct nfs_fattr *fattr)
 {
 	unsigned short task_flags = 0;
@@ -202,8 +202,7 @@ nfs3_proc_lookup(struct inode *dir, struct dentry *dentry,
 		task_flags |= RPC_TASK_TIMEOUT;
 
 	dprintk("NFS call  lookup %pd2\n", dentry);
-	return __nfs3_proc_lookup(dir, dentry->d_name.name,
-				  dentry->d_name.len, fhandle, fattr,
+	return __nfs3_proc_lookup(dir, name->name, name->len, fhandle, fattr,
 				  task_flags);
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 405f17e6e0b4..4d85068e820d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4536,15 +4536,15 @@ nfs4_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 }
 
 static int _nfs4_proc_lookup(struct rpc_clnt *clnt, struct inode *dir,
-		struct dentry *dentry, struct nfs_fh *fhandle,
-		struct nfs_fattr *fattr)
+		struct dentry *dentry, const struct qstr *name,
+		struct nfs_fh *fhandle, struct nfs_fattr *fattr)
 {
 	struct nfs_server *server = NFS_SERVER(dir);
 	int		       status;
 	struct nfs4_lookup_arg args = {
 		.bitmask = server->attr_bitmask,
 		.dir_fh = NFS_FH(dir),
-		.name = &dentry->d_name,
+		.name = name,
 	};
 	struct nfs4_lookup_res res = {
 		.server = server,
@@ -4586,17 +4586,16 @@ static void nfs_fixup_secinfo_attributes(struct nfs_fattr *fattr)
 }
 
 static int nfs4_proc_lookup_common(struct rpc_clnt **clnt, struct inode *dir,
-				   struct dentry *dentry, struct nfs_fh *fhandle,
-				   struct nfs_fattr *fattr)
+				   struct dentry *dentry, const struct qstr *name,
+				   struct nfs_fh *fhandle, struct nfs_fattr *fattr)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
 	struct rpc_clnt *client = *clnt;
-	const struct qstr *name = &dentry->d_name;
 	int err;
 	do {
-		err = _nfs4_proc_lookup(client, dir, dentry, fhandle, fattr);
+		err = _nfs4_proc_lookup(client, dir, dentry, name, fhandle, fattr);
 		trace_nfs4_lookup(dir, name, err);
 		switch (err) {
 		case -NFS4ERR_BADNAME:
@@ -4631,13 +4630,13 @@ static int nfs4_proc_lookup_common(struct rpc_clnt **clnt, struct inode *dir,
 	return err;
 }
 
-static int nfs4_proc_lookup(struct inode *dir, struct dentry *dentry,
+static int nfs4_proc_lookup(struct inode *dir, struct dentry *dentry, const struct qstr *name,
 			    struct nfs_fh *fhandle, struct nfs_fattr *fattr)
 {
 	int status;
 	struct rpc_clnt *client = NFS_CLIENT(dir);
 
-	status = nfs4_proc_lookup_common(&client, dir, dentry, fhandle, fattr);
+	status = nfs4_proc_lookup_common(&client, dir, dentry, name, fhandle, fattr);
 	if (client != NFS_CLIENT(dir)) {
 		rpc_shutdown_client(client);
 		nfs_fixup_secinfo_attributes(fattr);
@@ -4652,7 +4651,8 @@ nfs4_proc_lookup_mountpoint(struct inode *dir, struct dentry *dentry,
 	struct rpc_clnt *client = NFS_CLIENT(dir);
 	int status;
 
-	status = nfs4_proc_lookup_common(&client, dir, dentry, fhandle, fattr);
+	status = nfs4_proc_lookup_common(&client, dir, dentry, &dentry->d_name,
+					 fhandle, fattr);
 	if (status < 0)
 		return ERR_PTR(status);
 	return (client == NFS_CLIENT(dir)) ? rpc_clone_client(client) : client;
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 6c09cd090c34..77920a2e3cef 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -153,13 +153,13 @@ nfs_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 }
 
 static int
-nfs_proc_lookup(struct inode *dir, struct dentry *dentry,
+nfs_proc_lookup(struct inode *dir, struct dentry *dentry, const struct qstr *name,
 		struct nfs_fh *fhandle, struct nfs_fattr *fattr)
 {
 	struct nfs_diropargs	arg = {
 		.fh		= NFS_FH(dir),
-		.name		= dentry->d_name.name,
-		.len		= dentry->d_name.len
+		.name		= name->name,
+		.len		= name->len
 	};
 	struct nfs_diropok	res = {
 		.fh		= fhandle,
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 559273a0f16d..08b62bbf59f0 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1785,7 +1785,7 @@ struct nfs_rpc_ops {
 			    struct nfs_fattr *, struct inode *);
 	int	(*setattr) (struct dentry *, struct nfs_fattr *,
 			    struct iattr *);
-	int	(*lookup)  (struct inode *, struct dentry *,
+	int	(*lookup)  (struct inode *, struct dentry *, const struct qstr *,
 			    struct nfs_fh *, struct nfs_fattr *);
 	int	(*lookupp) (struct inode *, struct nfs_fh *,
 			    struct nfs_fattr *);
-- 
2.39.5


