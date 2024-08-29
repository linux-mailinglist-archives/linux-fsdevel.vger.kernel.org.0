Return-Path: <linux-fsdevel+bounces-27722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DAD963760
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4321C20848
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF36B50284;
	Thu, 29 Aug 2024 01:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A15fFyw0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9824D8BF;
	Thu, 29 Aug 2024 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893478; cv=none; b=urN6s7kaQWnAYd2mZ2qSNdL4izoOYkvsl83EsgR/pek+7zULgVwW1fb32NpqN9gx3Cu6Fi3uPBYKJt903u/pDYMNvv+4ZiC2uWZfiuo3053VCNUbz8rIK+y8C86CbwZB9fs3atuAceRcPWVRJmQ8yWrJO7sUkEbOhrbSeIqnBzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893478; c=relaxed/simple;
	bh=LcpwFOf9JgkBiPTcpejgUTMfQ5rVxQXydm5TC9v7Qf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUSphzlyGdWkb8uXT5igsTnN3XYUQfehCvMWk9l8zBh9d/2QBGIVqu9EhMLH8HMAhxtyv1ms6sW0pHw9IdmlGQxLWbJfuTIa5h/piCeFFEgBzJ+UdNGzWkekOEssM5h7Oxqyu8YvA0f+4Rj3YCtKx+Ahqi8X+b5eyJNb0hc70ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A15fFyw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3E1C4CEC2;
	Thu, 29 Aug 2024 01:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893477;
	bh=LcpwFOf9JgkBiPTcpejgUTMfQ5rVxQXydm5TC9v7Qf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A15fFyw0QtgKfOFb0vP7RI17gb5I/8BdtNN4OhI2SvZ/kpZW1/QaMfWAOUKomI7B7
	 lRWACHXmcXp8z2QiQVcGqcLRuhFuYjllYgQw5ihsF7KvEZQIwV4T4bga2RbLHDHJQU
	 8SJx/baSWyh8FqwC6TSHEAMjEjDSmTZsYDahPoPQYJZHnjaQFdfgYXbq5Ibj+Znsgd
	 GjYuWveJG+BdieC1P6vd9Yt9ZZBtBOw2q1xKY8rixnCzy7xDk1AFX/M0aGvdKifHRA
	 JaLGGE+naiSB+aEu9i/bTfBz2iclLWC9P7Nnf4zGd5tpqLyP1QECSN7VfeanB7zxW+
	 /H1OPe2KPbybA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 09/25] nfsd: add nfsd_file_acquire_local()
Date: Wed, 28 Aug 2024 21:04:04 -0400
Message-ID: <20240829010424.83693-10-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240829010424.83693-1-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

nfsd_file_acquire_local() can be used to look up a file by filehandle
without having a struct svc_rqst.  This can be used by NFS LOCALIO to
allow the NFS client to bypass the NFS protocol to directly access a
file provided by the NFS server which is running in the same kernel.

In nfsd_file_do_acquire() care is taken to always use fh_verify() if
rqstp is not NULL (as is the case for non-LOCALIO callers).  Otherwise
the non-LOCALIO callers will not supply the correct and required
arguments to __fh_verify (e.g. gssclient isn't passed).

Introduce fh_verify_local() wrapper around __fh_verify to make it
clear that LOCALIO is intended caller.

Also, use GC for nfsd_file returned by nfsd_file_acquire_local.  GC
offers performance improvements if/when a file is reopened before
launderette cleans it from the filecache's LRU.

Suggested-by: Jeff Layton <jlayton@kernel.org> # use filecache's GC
Signed-off-by: NeilBrown <neilb@suse.de>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 71 ++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/filecache.h |  3 ++
 fs/nfsd/nfsfh.c     | 39 +++++++++++++++++++++++++
 fs/nfsd/nfsfh.h     |  2 ++
 4 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9e9d246f993c..2dc72de31f61 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -982,12 +982,14 @@ nfsd_file_is_cached(struct inode *inode)
 }
 
 static __be32
-nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
+nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
+		     struct svc_cred *cred,
+		     struct auth_domain *client,
+		     struct svc_fh *fhp,
 		     unsigned int may_flags, struct file *file,
 		     struct nfsd_file **pnf, bool want_gc)
 {
 	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
-	struct net *net = SVC_NET(rqstp);
 	struct nfsd_file *new, *nf;
 	bool stale_retry = true;
 	bool open_retry = true;
@@ -996,8 +998,13 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	int ret;
 
 retry:
-	status = fh_verify(rqstp, fhp, S_IFREG,
-				may_flags|NFSD_MAY_OWNER_OVERRIDE);
+	if (rqstp) {
+		status = fh_verify(rqstp, fhp, S_IFREG,
+				   may_flags|NFSD_MAY_OWNER_OVERRIDE);
+	} else {
+		status = fh_verify_local(net, cred, client, fhp, S_IFREG,
+					 may_flags|NFSD_MAY_OWNER_OVERRIDE);
+	}
 	if (status != nfs_ok)
 		return status;
 	inode = d_inode(fhp->fh_dentry);
@@ -1143,7 +1150,8 @@ __be32
 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
+	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
+				    fhp, may_flags, NULL, pnf, true);
 }
 
 /**
@@ -1167,7 +1175,55 @@ __be32
 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, false);
+	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
+				    fhp, may_flags, NULL, pnf, false);
+}
+
+/**
+ * nfsd_file_acquire_local - Get a struct nfsd_file with an open file for localio
+ * @net: The network namespace in which to perform a lookup
+ * @cred: the user credential with which to validate access
+ * @client: the auth_domain for LOCALIO lookup
+ * @fhp: the NFS filehandle of the file to be opened
+ * @may_flags: NFSD_MAY_ settings for the file
+ * @pnf: OUT: new or found "struct nfsd_file" object
+ *
+ * This file lookup interface provide access to a file given the
+ * filehandle and credential.  No connection-based authorisation
+ * is performed and in that way it is quite different to other
+ * file access mediated by nfsd.  It allows a kernel module such as the NFS
+ * client to reach across network and filesystem namespaces to access
+ * a file.  The security implications of this should be carefully
+ * considered before use.
+ *
+ * The nfsd_file object returned by this API is reference-counted
+ * and garbage-collected. The object is retained for a few
+ * seconds after the final nfsd_file_put() in case the caller
+ * wants to re-use it.
+ *
+ * Return values:
+ *   %nfs_ok - @pnf points to an nfsd_file with its reference
+ *   count boosted.
+ *
+ * On error, an nfsstat value in network byte order is returned.
+ */
+__be32
+nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
+			struct auth_domain *client, struct svc_fh *fhp,
+			unsigned int may_flags, struct nfsd_file **pnf)
+{
+	/*
+	 * Save creds before calling nfsd_file_do_acquire() (which calls
+	 * nfsd_setuser). Important because caller (LOCALIO) is from
+	 * client context.
+	 */
+	const struct cred *save_cred = get_current_cred();
+	__be32 beres;
+
+	beres = nfsd_file_do_acquire(NULL, net, cred, client,
+				     fhp, may_flags, NULL, pnf, true);
+	revert_creds(save_cred);
+	return beres;
 }
 
 /**
@@ -1193,7 +1249,8 @@ nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			 unsigned int may_flags, struct file *file,
 			 struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
+	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
+				    fhp, may_flags, file, pnf, false);
 }
 
 /*
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 3fbec24eea6c..26ada78b8c1e 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -66,5 +66,8 @@ __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 __be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct file *file,
 		  struct nfsd_file **nfp);
+__be32 nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
+			       struct auth_domain *client, struct svc_fh *fhp,
+			       unsigned int may_flags, struct nfsd_file **pnf);
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
 #endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 80c06e170e9a..49468e478d23 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -301,6 +301,22 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 	return error;
 }
 
+/**
+ * __fh_verify - filehandle lookup and access checking
+ * @rqstp: RPC transaction context, or NULL
+ * @net: net namespace in which to perform the export lookup
+ * @cred: RPC user credential
+ * @client: RPC auth domain
+ * @gssclient: RPC GSS auth domain, or NULL
+ * @fhp: filehandle to be verified
+ * @type: expected type of object pointed to by filehandle
+ * @access: type of access needed to object
+ *
+ * This internal API can be used by callers who do not have an RPC
+ * transaction context (ie are not running in an nfsd thread).
+ *
+ * See fh_verify() for further descriptions of @fhp, @type, and @access.
+ */
 static __be32
 __fh_verify(struct svc_rqst *rqstp,
 	    struct net *net, struct svc_cred *cred,
@@ -382,6 +398,29 @@ __fh_verify(struct svc_rqst *rqstp,
 	return error;
 }
 
+/**
+ * fh_verify_local - filehandle lookup and access checking
+ * @net: net namespace in which to perform the export lookup
+ * @cred: RPC user credential
+ * @client: RPC auth domain
+ * @fhp: filehandle to be verified
+ * @type: expected type of object pointed to by filehandle
+ * @access: type of access needed to object
+ *
+ * This API can be used by callers who do not have an RPC
+ * transaction context (ie are not running in an nfsd thread).
+ *
+ * See fh_verify() for further descriptions of @fhp, @type, and @access.
+ */
+__be32
+fh_verify_local(struct net *net, struct svc_cred *cred,
+		struct auth_domain *client, struct svc_fh *fhp,
+		umode_t type, int access)
+{
+	return __fh_verify(NULL, net, cred, client, NULL,
+			   fhp, type, access);
+}
+
 /**
  * fh_verify - filehandle lookup and access checking
  * @rqstp: pointer to current rpc request
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 8d46e203d139..5b7394801dc4 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -217,6 +217,8 @@ extern char * SVCFH_fmt(struct svc_fh *fhp);
  * Function prototypes
  */
 __be32	fh_verify(struct svc_rqst *, struct svc_fh *, umode_t, int);
+__be32	fh_verify_local(struct net *, struct svc_cred *, struct auth_domain *,
+			struct svc_fh *, umode_t, int);
 __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct svc_fh *);
 __be32	fh_update(struct svc_fh *);
 void	fh_put(struct svc_fh *);
-- 
2.44.0


