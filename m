Return-Path: <linux-fsdevel+bounces-26308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 690F49572F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21615283CF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D080918B47F;
	Mon, 19 Aug 2024 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIZNykQf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958818B46F;
	Mon, 19 Aug 2024 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091502; cv=none; b=BsXdEyORxsw5Zwxq26LjdhxjS1O0Csm83SyqGNR2zRcAF1u2uNtaF+PuZLwjAm+aBDG//FCaNy5/WiidICbPK4LiE5gNi4kzqea9K8iN3KQyA1YoJzvh2fi6eUoKG1WMVwkJbpdLzq2o/bnK77dGfiOvHUcKzGjnNSTYNRkKS5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091502; c=relaxed/simple;
	bh=ftw0vMv3HaFnOmejPIHrAE9siQzKsk6CGD9W9QIRQwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOLdcJR6cnCViUPbnuJcqvj1G3VK1IF/PAzsmgMUaKDmLT+3YsfIWZdCjPuJECG3BGpEPNv+aBNMWe0rIUAlMxp0zwJHi6HhKuFktbGPkaQNlJpUrTLLtlFTPzKNL6rl8MSE/fN5/qLk9jaNqhknEYQshAS1Sf/FCJYZrxnhH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIZNykQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E29C32782;
	Mon, 19 Aug 2024 18:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091502;
	bh=ftw0vMv3HaFnOmejPIHrAE9siQzKsk6CGD9W9QIRQwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tIZNykQfiFdhu17zjqpGC4nycz+WMgZMI9N497qTfQxvlpYUTtrha+qa00s+vOv51
	 NeXyzh89cKrmVfCEg2Es0roQW8LGNaJMTdpVv+AAhuVgxkGeNJm4fMC9DufCxuM0vp
	 9iN4D++rkYQFs+9qq+htN6BgRtQEJf8fyfNpMuekgPxCgEQwqBfFfeUPFBl7RzB3eP
	 w1/2qWE5IpoyDzqZbQbUSEwZZTD6K7kA51wlqAFX4w8TypKFTuFy9XpUxf7DETVFXz
	 dqddJJNp3WPY+m4bx8/FrQS6fiA4cU7fZKqzaBHk6gWWQp4o7Oij5/8MKs5cPFFD4v
	 Vju+pupcy2q2Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 22/24] nfs: push localio nfsd_file_put call out to client
Date: Mon, 19 Aug 2024 14:17:27 -0400
Message-ID: <20240819181750.70570-23-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819181750.70570-1-snitzer@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change nfsd_open_local_fh() to return an nfsd_file, instead of file,
and move associated reference counting to the nfs client's
nfs_local_open_fh().

This is the first step in allowing proper use of nfsd_file for localio
(such that the benefits of nfsd's filecache can be realized).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c           |  7 +++++--
 fs/nfs_common/nfslocalio.c |  2 +-
 fs/nfsd/localio.c          | 11 ++++-------
 fs/nfsd/vfs.h              |  2 +-
 include/linux/nfslocalio.h |  2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 38303427e0b3..7d63d7e34643 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -237,13 +237,14 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		  struct nfs_fh *fh, const fmode_t mode)
 {
 	struct file *filp;
+	struct nfsd_file *nf;
 	int status;
 
 	if (mode & ~(FMODE_READ | FMODE_WRITE))
 		return ERR_PTR(-EINVAL);
 
 	status = nfs_to.nfsd_open_local_fh(clp->cl_nfssvc_net, clp->cl_nfssvc_dom,
-					   clp->cl_rpcclient, cred, fh, mode, &filp);
+					   clp->cl_rpcclient, cred, fh, mode, &nf);
 	if (status < 0) {
 		trace_nfs_local_open_fh(fh, mode, status);
 		switch (status) {
@@ -255,8 +256,10 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		case -ETIMEDOUT:
 			status = -EAGAIN;
 		}
-		filp = ERR_PTR(status);
+		return ERR_PTR(status);
 	}
+	filp = get_file(nfs_to.nfsd_file_file(nf));
+	nfs_to.nfsd_file_put(nf);
 	return filp;
 }
 EXPORT_SYMBOL_GPL(nfs_local_open_fh);
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 087649911b52..f59167e596d3 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -98,7 +98,7 @@ static void put_##NFSD_SYMBOL(void)			\
 /* The nfs localio code needs to call into nfsd to map filehandle -> struct nfsd_file */
 extern int nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
 			      const struct cred *, const struct nfs_fh *,
-			      const fmode_t, struct file **);
+			      const fmode_t, struct nfsd_file **);
 DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_open_local_fh);
 
 /* The nfs localio code needs to call into nfsd to acquire the nfsd_file */
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 008b935a3a6c..2ceab49f3cb6 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -32,13 +32,13 @@
  * @cred: cred that the client established
  * @nfs_fh: filehandle to lookup
  * @fmode: fmode_t to use for open
- * @pfilp: returned file pointer that maps to @nfs_fh
+ * @pnf: returned nfsd_file pointer that maps to @nfs_fh
  *
  * This function maps a local fh to a path on a local filesystem.
  * This is useful when the nfs client has the local server mounted - it can
  * avoid all the NFS overhead with reads, writes and commits.
  *
- * On successful return, caller is responsible for calling path_put. Also
+ * On successful return, caller is responsible for calling nfsd_file_put. Also
  * note that this is called from nfs.ko via find_symbol() to avoid an explicit
  * dependency on knfsd. So, there is no forward declaration in a header file
  * for it that is shared with the client.
@@ -49,7 +49,7 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
 			 const struct cred *cred,
 			 const struct nfs_fh *nfs_fh,
 			 const fmode_t fmode,
-			 struct file **pfilp)
+			 struct nfsd_file **pnf)
 {
 	int mayflags = NFSD_MAY_LOCALIO;
 	int status = 0;
@@ -57,7 +57,6 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
 	const struct cred *save_cred;
 	struct svc_cred rq_cred;
 	struct svc_fh fh;
-	struct nfsd_file *nf;
 	__be32 beres;
 
 	if (nfs_fh->size > NFS4_FHSIZE)
@@ -91,13 +90,11 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
 	rpcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
 
 	beres = nfsd_file_acquire_local(cl_nfssvc_net, &rq_cred, rpc_clnt->cl_vers,
-					cl_nfssvc_dom, &fh, mayflags, &nf);
+					cl_nfssvc_dom, &fh, mayflags, pnf);
 	if (beres) {
 		status = nfs_stat_to_errno(be32_to_cpu(beres));
 		goto out_fh_put;
 	}
-	*pfilp = get_file(nf->nf_file);
-	nfsd_file_put(nf);
 out_fh_put:
 	fh_put(&fh);
 	if (rq_cred.cr_group_info)
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 9720951c49a0..ec8a8aae540b 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -166,7 +166,7 @@ int		nfsd_open_local_fh(struct net *net,
 				   const struct cred *cred,
 				   const struct nfs_fh *nfs_fh,
 				   const fmode_t fmode,
-				   struct file **pfilp);
+				   struct nfsd_file **pnf);
 
 static inline int fh_want_write(struct svc_fh *fh)
 {
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 6302d36f9112..7e09ff621d93 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -35,7 +35,7 @@ struct nfsd_file;
 typedef int (*nfs_to_nfsd_open_local_fh_t)(struct net *, struct auth_domain *,
 				struct rpc_clnt *, const struct cred *,
 				const struct nfs_fh *, const fmode_t,
-				struct file **);
+				struct nfsd_file **);
 typedef struct nfsd_file * (*nfs_to_nfsd_file_get_t)(struct nfsd_file *);
 typedef void (*nfs_to_nfsd_file_put_t)(struct nfsd_file *);
 typedef struct file * (*nfs_to_nfsd_file_file_t)(struct nfsd_file *);
-- 
2.44.0


