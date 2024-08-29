Return-Path: <linux-fsdevel+bounces-27717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB6963757
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20032834D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D113D55D;
	Thu, 29 Aug 2024 01:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4XKasUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791DE38F83;
	Thu, 29 Aug 2024 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893472; cv=none; b=J1B+Sm4NqZxTTVlbSqbg/pQM3xpfgykBWqM1gZm543b/eA5vu2rRU05DbXQvCUe0SjJAc/d0ZOpC520jF3HZfPfDv0KLOgCoTY+L0H7CE4745mxrPocPdc/a4iyqazvNT2HBWyhobwLZ+XS5ncPijLtLsIfekB/1lRdqTeFXj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893472; c=relaxed/simple;
	bh=quKejGGze/CBsXAZgqJBo/NPSH7vE3K8tirQXJWmAtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjslRmy1POAiHV0gOYAr1VpAv6Kqmmz3TEvy2RWOCUxIfx8AKCZ8dMlGpug23d4Dt5rh0zkU5CNSErG2rWCswmQyucanPMnWT2+/RFHrgPQjAgYZr8WtYdjsRromoVUOs2Ge08zV4tUtFon1ta9RwPU6XO+1dDGGLvYldWTOf3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4XKasUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF80C4CEC0;
	Thu, 29 Aug 2024 01:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893471;
	bh=quKejGGze/CBsXAZgqJBo/NPSH7vE3K8tirQXJWmAtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4XKasUeKg0wy7/jRZxeJGv3CCqLGwx0XT33slcsTrk5fbQcjBmv+8hl6fRfCkemV
	 bi4i+TuGChoUlmz0A28eHCpywnaeIlWipoiL6KiYHj/IgMmeiYQhIB81pUfKiMgrT/
	 NUJ4bg+ybtlfsNgaO/TThFT+S9HcmhBRlGpkQe3UgFVa6nN8sycxwaBUrNt0zav5TF
	 FMsrAiF3hxy/RdvDxy/WQDtwF/2ZoiIvYkio8PY78s+ZLpWgCYc15wfC3G/0aBocNd
	 8Lg3cXtamItFMGITgc0/NSXmDTaF5U3P9duqxNKUiQap0ceuL0moZ3U96IC2vorBFO
	 qD1IepCzr870Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 04/25] NFSD: Handle @rqstp == NULL in check_nfsd_access()
Date: Wed, 28 Aug 2024 21:03:59 -0400
Message-ID: <20240829010424.83693-5-snitzer@kernel.org>
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

LOCALIO-initiated open operations are not running in an nfsd thread
and thus do not have an associated svc_rqst context.

Signed-off-by: NeilBrown <neilb@suse.de>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/export.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 7bb4f2075ac5..c82d8e3e0d4f 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1074,10 +1074,30 @@ static struct svc_export *exp_find(struct cache_detail *cd,
 	return exp;
 }
 
+/**
+ * check_nfsd_access - check if access to export is allowed.
+ * @exp: svc_export that is being accessed.
+ * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
+ *
+ * Return values:
+ *   %nfs_ok if access is granted, or
+ *   %nfserr_wrongsec if access is denied
+ */
 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 {
 	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
-	struct svc_xprt *xprt = rqstp->rq_xprt;
+	struct svc_xprt *xprt;
+
+	/*
+	 * If rqstp is NULL, this is a LOCALIO request which will only
+	 * ever use a filehandle/credential pair for which access has
+	 * been affirmed (by ACCESS or OPEN NFS requests) over the
+	 * wire. So there is no need for further checks here.
+	 */
+	if (!rqstp)
+		return nfs_ok;
+
+	xprt = rqstp->rq_xprt;
 
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
 		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
@@ -1098,17 +1118,17 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 ok:
 	/* legacy gss-only clients are always OK: */
 	if (exp->ex_client == rqstp->rq_gssclient)
-		return 0;
+		return nfs_ok;
 	/* ip-address based client; check sec= export option: */
 	for (f = exp->ex_flavors; f < end; f++) {
 		if (f->pseudoflavor == rqstp->rq_cred.cr_flavor)
-			return 0;
+			return nfs_ok;
 	}
 	/* defaults in absence of sec= options: */
 	if (exp->ex_nflavors == 0) {
 		if (rqstp->rq_cred.cr_flavor == RPC_AUTH_NULL ||
 		    rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)
-			return 0;
+			return nfs_ok;
 	}
 
 	/* If the compound op contains a spo_must_allowed op,
@@ -1118,7 +1138,7 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 	 */
 
 	if (nfsd4_spo_must_allow(rqstp))
-		return 0;
+		return nfs_ok;
 
 denied:
 	return nfserr_wrongsec;
-- 
2.44.0


