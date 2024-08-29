Return-Path: <linux-fsdevel+bounces-27721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F5F96375E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1DC283AAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41AC4C62A;
	Thu, 29 Aug 2024 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOrKU85J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7EF482EF;
	Thu, 29 Aug 2024 01:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893477; cv=none; b=BPQdvz+DawncYsgHFTqT2o1eVFu3gHt91nfnCZdvmDz7NXzlRFFkXFuLViSAk6ywvSnmxKkf1azNLCHxwuXBAyWxHcrPDwVpr/YKH1ly58G/l466ua3Nm0EMuFqrzGlydug/b2qFM7nbFgM/rVE1u8Gu1mtRL7hwK7JAweDJV4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893477; c=relaxed/simple;
	bh=pPDK3TvOhfeQywYSqTTt9a43OeK4SEnhC1DCZAX6X+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9LuteMq+WlR9K8y8WlRzTnL8HzWQzBWfBxR8+Fjl5h4Rd2yNI8NnNtWhQHPLGR8faCl+vF3m56UY0DJkkS/oPvCH+ZCoPcF3l5W+Zpscw9eVsXXSl4OG6Fo6lznqHY9200LMPsjQNAnSxcO0PfWUPsKfjvvcMt98t0nyFMbjtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOrKU85J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E17C4CEC7;
	Thu, 29 Aug 2024 01:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893476;
	bh=pPDK3TvOhfeQywYSqTTt9a43OeK4SEnhC1DCZAX6X+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nOrKU85Jn/TflS8H4EAgGrHeIn7CwCqoD+1uTXblv7K7yh1WxP5DDTgjnbewkiXNF
	 c1zYJPC7izlleNLeCrzTLJUvSYRLb6cN/deWtP9i7BWhywB7U0gCcjPfaaPKiAzPjB
	 9ljEB4inrT464T3WV5rhl7gQDvysm4rWbxHJLiq3TBy9rU8feoM7klrQVE/pkXm00L
	 48GcjTPaQpH7oIz/fO/uU5HeYj9I99kNV2U3J5rlR1/PJTZhdfK4aktEq1hp4BIFn7
	 z9IFvC4uRs3Vkyq006W5gENaJTlYf4yrknSZ8Y0+UgY8ZiZV2KE5pIwj7wgxdMJzpN
	 M8St/xChVSkcg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 08/25] nfsd: factor out __fh_verify to allow NULL rqstp to be passed
Date: Wed, 28 Aug 2024 21:04:03 -0400
Message-ID: <20240829010424.83693-9-snitzer@kernel.org>
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

__fh_verify() offers an interface like fh_verify() but doesn't require
a struct svc_rqst *, instead it also takes the specific parts as
explicit required arguments.  So it is safe to call __fh_verify() with
a NULL rqstp, but the net, cred, and client args must not be NULL.

__fh_verify() does not use SVC_NET(), nor does the functions it calls.

Rather than using rqstp->rq_client pass the client and gssclient
explicitly to __fh_verify and then to nfsd_set_fh_dentry().

Lastly, 4 associated tracepoints are only used if rqstp is not NULL
(this is a stop-gap that should be properly fixed so localio also
benefits from the utility these tracepoints provide when debugging
fh_verify issues).

Signed-off-by: NeilBrown <neilb@suse.de>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.c | 90 +++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 37 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 77acc26e8b02..80c06e170e9a 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -142,7 +142,11 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
  * dentry.  On success, the results are used to set fh_export and
  * fh_dentry.
  */
-static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
+static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
+				 struct svc_cred *cred,
+				 struct auth_domain *client,
+				 struct auth_domain *gssclient,
+				 struct svc_fh *fhp)
 {
 	struct knfsd_fh	*fh = &fhp->fh_handle;
 	struct fid *fid = NULL;
@@ -184,8 +188,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	data_left -= len;
 	if (data_left < 0)
 		return error;
-	exp = rqst_exp_find(&rqstp->rq_chandle, SVC_NET(rqstp),
-			    rqstp->rq_client, rqstp->rq_gssclient,
+	exp = rqst_exp_find(rqstp ? &rqstp->rq_chandle : NULL,
+			    net, client, gssclient,
 			    fh->fh_fsid_type, fh->fh_fsid);
 	fid = (struct fid *)(fh->fh_fsid + len);
 
@@ -220,7 +224,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 		put_cred(override_creds(new));
 		put_cred(new);
 	} else {
-		error = nfsd_setuser_and_check_port(rqstp, &rqstp->rq_cred, exp);
+		error = nfsd_setuser_and_check_port(rqstp, cred, exp);
 		if (error)
 			goto out;
 	}
@@ -297,43 +301,21 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
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
+	    struct auth_domain *client,
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
+		error = nfsd_set_fh_dentry(rqstp, net, cred, client,
+					   gssclient, fhp);
 		if (error)
 			goto out;
 	}
@@ -362,7 +344,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	if (error)
 		goto out;
 
-	error = nfsd_setuser_and_check_port(rqstp, &rqstp->rq_cred, exp);
+	error = nfsd_setuser_and_check_port(rqstp, cred, exp);
 	if (error)
 		goto out;
 
@@ -392,7 +374,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 
 skip_pseudoflavor_check:
 	/* Finally, check access permissions. */
-	error = nfsd_permission(&rqstp->rq_cred, exp, dentry, access);
+	error = nfsd_permission(cred, exp, dentry, access);
 out:
 	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
 	if (error == nfserr_stale)
@@ -400,6 +382,40 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
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
+	return __fh_verify(rqstp, SVC_NET(rqstp), &rqstp->rq_cred,
+			   rqstp->rq_client, rqstp->rq_gssclient,
+			   fhp, type, access);
+}
 
 /*
  * Compose a file handle for an NFS reply.
-- 
2.44.0


