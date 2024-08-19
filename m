Return-Path: <linux-fsdevel+bounces-26290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642629572D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C431C23731
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294D4189907;
	Mon, 19 Aug 2024 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNRfk7Iy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1F13BAC6;
	Mon, 19 Aug 2024 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091477; cv=none; b=SkRr2fyoVplNaP37WSA+rTFX0lfuhCxSjsWf0EuSFSzPwE7b08w+oNXJ1ypVMD1iro0M330AVzwPq2qy91TMIwz0zFbuyfKvsPN4BQIhRuLVuDwFvVt9f5lHi6Pk0umgsrwULuLeF9HaIlzPC9XRWbAji1kG+4ovS5RUzbAzORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091477; c=relaxed/simple;
	bh=aYdATA38A+TwkIIsetF8MEPAu7A+MWMvdfXrRs73iOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+/WYtAFn9VzC3M5H/bYSsdzZjwrYkNnssIgmikIMvhN4vYQx9LpW01NiijWRTe+yjWxfdhE03dzh0IhfBvm5J8U8b5j+k6Eywp+0EGXJ+go2VLxPNWLOT/2Msj01yoz8ksOZlfMC0h9PqrXK+S6IDZ1SlphIYc6hoc0wmLUnCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNRfk7Iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF58C4AF0E;
	Mon, 19 Aug 2024 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091477;
	bh=aYdATA38A+TwkIIsetF8MEPAu7A+MWMvdfXrRs73iOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNRfk7IyeEa+u8pes0UCXsRMd/20R6dyFgEGkrHbb8PZUIVhWSoidC3++YdME5MPy
	 nZaOJjxaXiGiuV0SPq6muuFSZ8u3kMcCFC6zZ+NbHrFAi1dmyMEBPd9ADBA62WyS1K
	 K83VNFeSRJHx7UbGrLAum/WozhL2MFf1NrA32t8LbRMnA/6scTUM5qVicGrcEZAHqP
	 CMm+npdmvYq4FZFpJBpKf65xYbHWOi8MFbkNQze95zpqF8Er3Lvf7WAFYt6g+MM9TP
	 /quq5IQ/QzyMicLYtzaaWwNM0j9S2aonhVEwHX66KA60ZZAltwI6qHxlkiA7Oe6xJM
	 w0ZMSzmZ1QlmQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 04/24] nfsd: factor out __fh_verify to allow NULL rqstp to be passed
Date: Mon, 19 Aug 2024 14:17:09 -0400
Message-ID: <20240819181750.70570-5-snitzer@kernel.org>
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

From: NeilBrown <neilb@suse.de>

__fh_verify() offers an interface like fh_verify() but doesn't require
a struct svc_rqst *, instead it also takes the specific parts as
explicit required arguments.  So it is safe to call __fh_verify() with
a NULL rqstp, but the net, cred, and client args must not be NULL.

__fh_verify() does not use SVC_NET(), nor does the functions it calls.

Rather then depending on rqstp->rq_vers to determine nfs version, pass
it in explicitly.  This removes another dependency on rqstp and ensures
the correct version is checked.  The rqstp can be for an NLM request and
while some code tests that, other code does not.

Rather than using rqstp->rq_client pass the client and gssclient
explicitly to __fh_verify and then to nfsd_set_fh_dentry().

The final places where __fh_verify unconditionally dereferences rqstp
involve checking if the connection is suitably secure.  They look at
rqstp->rq_xprt which is not meaningful in the target use case of
"localio" NFS in which the client talks directly to the local server.
So have these always succeed when rqstp is NULL.

Lastly, 4 associated tracepoints are only used if rqstp is not NULL
(this is stop-gap that will be properly fixed in the next commit).

Signed-off-by: NeilBrown <neilb@suse.de>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/export.c |   8 ++-
 fs/nfsd/nfsfh.c  | 124 ++++++++++++++++++++++++++++-------------------
 2 files changed, 82 insertions(+), 50 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 7bb4f2075ac5..fe36f441d1d9 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1077,7 +1077,13 @@ static struct svc_export *exp_find(struct cache_detail *cd,
 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 {
 	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
-	struct svc_xprt *xprt = rqstp->rq_xprt;
+	struct svc_xprt *xprt;
+
+	if (!rqstp)
+		/* Always allow LOCALIO */
+		return 0;
+
+	xprt = rqstp->rq_xprt;
 
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
 		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 50d23d56f403..19e173187ab9 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -87,23 +87,24 @@ nfsd_mode_check(struct dentry *dentry, umode_t requested)
 	return nfserr_wrong_type;
 }
 
-static bool nfsd_originating_port_ok(struct svc_rqst *rqstp, int flags)
+static bool nfsd_originating_port_ok(struct svc_rqst *rqstp,
+				     struct svc_cred *cred,
+				     struct svc_export *exp)
 {
-	if (flags & NFSEXP_INSECURE_PORT)
+	if (nfsexp_flags(cred, exp) & NFSEXP_INSECURE_PORT)
 		return true;
 	/* We don't require gss requests to use low ports: */
-	if (rqstp->rq_cred.cr_flavor >= RPC_AUTH_GSS)
+	if (cred->cr_flavor >= RPC_AUTH_GSS)
 		return true;
 	return test_bit(RQ_SECURE, &rqstp->rq_flags);
 }
 
 static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
+					  struct svc_cred *cred,
 					  struct svc_export *exp)
 {
-	int flags = nfsexp_flags(&rqstp->rq_cred, exp);
-
 	/* Check if the request originated from a secure port. */
-	if (!nfsd_originating_port_ok(rqstp, flags)) {
+	if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
 		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
 		dprintk("nfsd: request from insecure port %s!\n",
 		        svc_print_addr(rqstp, buf, sizeof(buf)));
@@ -111,7 +112,7 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 	}
 
 	/* Set user creds for this exportpoint */
-	return nfserrno(nfsd_setuser(&rqstp->rq_cred, exp));
+	return nfserrno(nfsd_setuser(cred, exp));
 }
 
 static inline __be32 check_pseudo_root(struct dentry *dentry,
@@ -141,7 +142,11 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
  * dentry.  On success, the results are used to set fh_export and
  * fh_dentry.
  */
-static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
+static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
+				 struct svc_cred *cred, int nfs_vers,
+				 struct auth_domain *client,
+				 struct auth_domain *gssclient,
+				 struct svc_fh *fhp)
 {
 	struct knfsd_fh	*fh = &fhp->fh_handle;
 	struct fid *fid = NULL;
@@ -183,14 +188,15 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	data_left -= len;
 	if (data_left < 0)
 		return error;
-	exp = rqst_exp_find(&rqstp->rq_chandle, SVC_NET(rqstp),
-			    rqstp->rq_client, rqstp->rq_gssclient,
+	exp = rqst_exp_find(rqstp ? &rqstp->rq_chandle : NULL,
+			    net, client, gssclient,
 			    fh->fh_fsid_type, fh->fh_fsid);
 	fid = (struct fid *)(fh->fh_fsid + len);
 
 	error = nfserr_stale;
 	if (IS_ERR(exp)) {
-		trace_nfsd_set_fh_dentry_badexport(rqstp, fhp, PTR_ERR(exp));
+		if (rqstp)
+			trace_nfsd_set_fh_dentry_badexport(rqstp, fhp, PTR_ERR(exp));
 
 		if (PTR_ERR(exp) == -ENOENT)
 			return error;
@@ -219,7 +225,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 		put_cred(override_creds(new));
 		put_cred(new);
 	} else {
-		error = nfsd_setuser_and_check_port(rqstp, exp);
+		error = nfsd_setuser_and_check_port(rqstp, cred, exp);
 		if (error)
 			goto out;
 	}
@@ -238,7 +244,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 						data_left, fileid_type, 0,
 						nfsd_acceptable, exp);
 		if (IS_ERR_OR_NULL(dentry)) {
-			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
+			if (rqstp)
+				trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
 					dentry ?  PTR_ERR(dentry) : -ESTALE);
 			switch (PTR_ERR(dentry)) {
 			case -ENOMEM:
@@ -266,7 +273,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	fhp->fh_dentry = dentry;
 	fhp->fh_export = exp;
 
-	switch (rqstp->rq_vers) {
+	switch (nfs_vers) {
 	case 4:
 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOATOMIC_ATTR)
 			fhp->fh_no_atomic_attr = true;
@@ -293,50 +300,29 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	return error;
 }
 
-/**
- * fh_verify - filehandle lookup and access checking
- * @rqstp: pointer to current rpc request
- * @fhp: filehandle to be verified
- * @type: expected type of object pointed to by filehandle
- * @access: type of access needed to object
- *
- * Look up a dentry from the on-the-wire filehandle, check the client's
- * access to the export, and set the current task's credentials.
- *
- * Regardless of success or failure of fh_verify(), fh_put() should be
- * called on @fhp when the caller is finished with the filehandle.
- *
- * fh_verify() may be called multiple times on a given filehandle, for
- * example, when processing an NFSv4 compound.  The first call will look
- * up a dentry using the on-the-wire filehandle.  Subsequent calls will
- * skip the lookup and just perform the other checks and possibly change
- * the current task's credentials.
- *
- * @type specifies the type of object expected using one of the S_IF*
- * constants defined in include/linux/stat.h.  The caller may use zero
- * to indicate that it doesn't care, or a negative integer to indicate
- * that it expects something not of the given type.
- *
- * @access is formed from the NFSD_MAY_* constants defined in
- * fs/nfsd/vfs.h.
- */
-__be32
-fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
+static __be32
+__fh_verify(struct svc_rqst *rqstp,
+	    struct net *net, struct svc_cred *cred,
+	    int nfs_vers, struct auth_domain *client,
+	    struct auth_domain *gssclient,
+	    struct svc_fh *fhp, umode_t type, int access)
 {
-	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_export *exp = NULL;
 	struct dentry	*dentry;
 	__be32		error;
 
 	if (!fhp->fh_dentry) {
-		error = nfsd_set_fh_dentry(rqstp, fhp);
+		error = nfsd_set_fh_dentry(rqstp, net, cred, nfs_vers,
+					   client, gssclient, fhp);
 		if (error)
 			goto out;
 	}
 	dentry = fhp->fh_dentry;
 	exp = fhp->fh_export;
 
-	trace_nfsd_fh_verify(rqstp, fhp, type, access);
+	if (rqstp)
+		trace_nfsd_fh_verify(rqstp, fhp, type, access);
 
 	/*
 	 * We still have to do all these permission checks, even when
@@ -358,7 +344,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	if (error)
 		goto out;
 
-	error = nfsd_setuser_and_check_port(rqstp, exp);
+	error = nfsd_setuser_and_check_port(rqstp, cred, exp);
 	if (error)
 		goto out;
 
@@ -388,14 +374,54 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 
 skip_pseudoflavor_check:
 	/* Finally, check access permissions. */
-	error = nfsd_permission(&rqstp->rq_cred, exp, dentry, access);
+	error = nfsd_permission(cred, exp, dentry, access);
 out:
-	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
+	if (rqstp)
+		trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
 	if (error == nfserr_stale)
 		nfsd_stats_fh_stale_inc(nn, exp);
 	return error;
 }
 
+/**
+ * fh_verify - filehandle lookup and access checking
+ * @rqstp: pointer to current rpc request
+ * @fhp: filehandle to be verified
+ * @type: expected type of object pointed to by filehandle
+ * @access: type of access needed to object
+ *
+ * Look up a dentry from the on-the-wire filehandle, check the client's
+ * access to the export, and set the current task's credentials.
+ *
+ * Regardless of success or failure of fh_verify(), fh_put() should be
+ * called on @fhp when the caller is finished with the filehandle.
+ *
+ * fh_verify() may be called multiple times on a given filehandle, for
+ * example, when processing an NFSv4 compound.  The first call will look
+ * up a dentry using the on-the-wire filehandle.  Subsequent calls will
+ * skip the lookup and just perform the other checks and possibly change
+ * the current task's credentials.
+ *
+ * @type specifies the type of object expected using one of the S_IF*
+ * constants defined in include/linux/stat.h.  The caller may use zero
+ * to indicate that it doesn't care, or a negative integer to indicate
+ * that it expects something not of the given type.
+ *
+ * @access is formed from the NFSD_MAY_* constants defined in
+ * fs/nfsd/vfs.h.
+ */
+__be32
+fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
+{
+	int nfs_vers;
+	if (rqstp->rq_prog == NFS_PROGRAM)
+		nfs_vers = rqstp->rq_vers;
+	else /* must be NLM */
+		nfs_vers = rqstp->rq_vers == 4 ? 3 : 2;
+	return __fh_verify(rqstp, SVC_NET(rqstp), &rqstp->rq_cred, nfs_vers,
+			   rqstp->rq_client, rqstp->rq_gssclient,
+			   fhp, type, access);
+}
 
 /*
  * Compose a file handle for an NFS reply.
-- 
2.44.0


