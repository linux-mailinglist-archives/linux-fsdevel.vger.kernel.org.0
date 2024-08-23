Return-Path: <linux-fsdevel+bounces-26963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B195D4F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20CB4284C18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8344192599;
	Fri, 23 Aug 2024 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJNmPk9C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FEE42A9F;
	Fri, 23 Aug 2024 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436872; cv=none; b=ChY7XXd9SMZ+Beg6sZQBizERb54HNJreor6pSl+OAc2jikhqvr+RaH9iYpkZVfGLgNVks6IYrI47bBo6GQhT5xdjt572ZttMqTx0gNxM2nhnWXCSpzzBcPc5FunsVrMPpUvwaOgduWWRtgczxhj3xiDK0q0FK/ncFDIc/Tz+jWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436872; c=relaxed/simple;
	bh=/PcrXWFBH/a9oVLTwSi44yoG+kIq935PZYihsXOQbyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baciA0qDi9BoUOIOoLiBBvR4T9vztV1mFWmsKWjrh0YdkcAOXk+314Om+L7Z4LhvMqzpj/jBn/J/EIkNvvolbyL//Gwp4kbVKyN4P4pEXwaqakAZOVT6McAwh8FoyegkiJhLU0Hdvx71zFFIAri0VXflw82XPcBkA4jmiHA6gkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJNmPk9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7439C4AF0F;
	Fri, 23 Aug 2024 18:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724436871;
	bh=/PcrXWFBH/a9oVLTwSi44yoG+kIq935PZYihsXOQbyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RJNmPk9CFD18cqbQrq1d2g92g/k4RhC9uB2T0X63KKPuPeod+TzFDTXmLbHtODv4B
	 85OO2HlpD2wn1O+Y4PSA0FbiL1h0aRmlAk5Xn1Z9Sl8J4kHXRQYq+xVXYIOhFywqvT
	 QeG3lmUe2INJ9u443m9T59YGyqE5U/UA4sKpeseoSjFiNG4GMAUs6Hc4TN8jq0//Ba
	 g4qI9yq4Wzp6zwYfJwdpj+RGNqaRBTNSb5ukuBwN7BCO94DgsEDKw5ny29uSVDLfFc
	 SMMdCcsAdsgpGODTCRqK/94wmQtYqU4yC5C+8Km9vL2dRHg73PnfMKhhmIIvCHF+Z+
	 08r6l46JcaG5Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 05/19] nfsd: add nfsd_file_acquire_local()
Date: Fri, 23 Aug 2024 14:14:03 -0400
Message-ID: <20240823181423.20458-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240823181423.20458-1-snitzer@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>
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
arguments to __fh_verify (e.g. nfs_vers is 0, gssclient isn't passed).

Also, use GC for nfsd_file returned by nfsd_file_acquire_local.  GC
offers performance improvements if/when a file is reopened before
launderette cleans it from the filecache's LRU.

Suggested-by: Jeff Layton <jlayton@kernel.org> # use filecache's GC
Signed-off-by: NeilBrown <neilb@suse.de>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/filecache.c | 63 ++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/filecache.h |  4 +++
 fs/nfsd/nfsfh.c     |  2 +-
 fs/nfsd/nfsfh.h     |  5 ++++
 4 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9e9d246f993c..94ecb9ed0ed1 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -982,12 +982,14 @@ nfsd_file_is_cached(struct inode *inode)
 }
 
 static __be32
-nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
+nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
+		     struct svc_cred *cred, int nfs_vers,
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
+		status = __fh_verify(NULL, net, cred, nfs_vers, client, NULL, fhp,
+				     S_IFREG, may_flags|NFSD_MAY_OWNER_OVERRIDE);
+	}
 	if (status != nfs_ok)
 		return status;
 	inode = d_inode(fhp->fh_dentry);
@@ -1143,7 +1150,8 @@ __be32
 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
+	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, 0, NULL,
+				    fhp, may_flags, NULL, pnf, true);
 }
 
 /**
@@ -1167,7 +1175,47 @@ __be32
 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, false);
+	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, 0, NULL,
+				    fhp, may_flags, NULL, pnf, false);
+}
+
+/**
+ * nfsd_file_acquire_local - Get a struct nfsd_file with an open file for localio
+ * @net: The network namespace in which to perform a lookup
+ * @cred: the user credential with which to validate access
+ * @nfs_vers: NFS version number to assume for request
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
+			int nfs_vers, struct auth_domain *client,
+			struct svc_fh *fhp,
+			unsigned int may_flags, struct nfsd_file **pnf)
+{
+	return nfsd_file_do_acquire(NULL, net, cred, nfs_vers, client,
+				    fhp, may_flags, NULL, pnf, true);
 }
 
 /**
@@ -1193,7 +1241,8 @@ nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			 unsigned int may_flags, struct file *file,
 			 struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
+	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, 0, NULL,
+				    fhp, may_flags, file, pnf, false);
 }
 
 /*
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 3fbec24eea6c..6dab41f8541e 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -66,5 +66,9 @@ __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 __be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct file *file,
 		  struct nfsd_file **nfp);
+__be32 nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
+			       int nfs_vers, struct auth_domain *client,
+			       struct svc_fh *fhp,
+			       unsigned int may_flags, struct nfsd_file **pnf);
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
 #endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 19e173187ab9..3635c0390cab 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -300,7 +300,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 	return error;
 }
 
-static __be32
+__be32
 __fh_verify(struct svc_rqst *rqstp,
 	    struct net *net, struct svc_cred *cred,
 	    int nfs_vers, struct auth_domain *client,
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 8d46e203d139..1429bee0ac1c 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -217,6 +217,11 @@ extern char * SVCFH_fmt(struct svc_fh *fhp);
  * Function prototypes
  */
 __be32	fh_verify(struct svc_rqst *, struct svc_fh *, umode_t, int);
+__be32	__fh_verify(struct svc_rqst *rqstp,
+		    struct net *net, struct svc_cred *cred,
+		    int nfs_vers, struct auth_domain *client,
+		    struct auth_domain *gssclient,
+		    struct svc_fh *fhp, umode_t type, int access);
 __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct svc_fh *);
 __be32	fh_update(struct svc_fh *);
 void	fh_put(struct svc_fh *);
-- 
2.44.0


