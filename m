Return-Path: <linux-fsdevel+bounces-26964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C33895D4F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12641C22679
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55E1925B1;
	Fri, 23 Aug 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OF2sopOf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612A1925A4;
	Fri, 23 Aug 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436872; cv=none; b=b4hdDFbfPGKkZ72L6cSMdrWGbMurk7phbvu/zHBhp3xAMIsrcDMfR4sLGqiz3gjfZ6ZcbaYd2v0MBCq4/ewrHfGSmIJDCAAK3xdqn37th5qqpWa4kVx9PhTSZwmAdEfPGpJUJG1Ge4Q+s+ukPUkJ8iWyk5wjQyRi9vyh44JfvDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436872; c=relaxed/simple;
	bh=IPeXii0b+f08EnxPDq6PdmAm/Q9joZYPAF7DkyQKquw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrJ3UEBtvJxbI1rElIK1uk/MJk60iR7EIiMG6PfrWCqT+W6AXJdRmZvMoLFaPUd2eaSrnn7pVDpTb9bBLq+dXKgleTHa6RirmxaGNRO3fPiD2VbzQ0mYrN6NFxxGZVCTI0R6k9aqEk5jy0vV6v+6fGK/MAqTZ0NNSK2GaWborZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OF2sopOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF47C32786;
	Fri, 23 Aug 2024 18:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724436870;
	bh=IPeXii0b+f08EnxPDq6PdmAm/Q9joZYPAF7DkyQKquw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OF2sopOfxgpI0phIrnXQERZHIZYW7FzHt71acOPt08M6Oe++BXguJsZyFC0o5lAxa
	 kgZEvUBUDSdkKJ9Nd6/P1ZXyVy70RLw/M2+gBigc4USvyaEFVH4S3iKuV6Zx4Y7QCa
	 agJjsGWv2Ib9hHiehGQpVcJbAp1AQAy1lp+hwNvQZL98giVLWyYX4ueZGXMQscLT3+
	 rAD0O2q9bz/EJzFxrNdxipvSJ4kVFCw4HSiuoXWfxdCgXhptv40aiWEq11MXcvFrpI
	 mNKkiBOG336gW3EKFsEofBShUAOOt7e/UilKIdiWiz3of+YnlzAq+YI6UBYAbRFT9e
	 qn29/j4GK/nLA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 04/19] nfsd: factor out __fh_verify to allow NULL rqstp to be passed
Date: Fri, 23 Aug 2024 14:14:02 -0400
Message-ID: <20240823181423.20458-5-snitzer@kernel.org>
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
(this is a stop-gap that should be properly fixed so localio also
benefits from the utility these tracepoints provide when debugging
fh_verify issues).

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


