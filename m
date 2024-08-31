Return-Path: <linux-fsdevel+bounces-28114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8A59673A4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE28B21E1A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74AD184522;
	Sat, 31 Aug 2024 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKL+K4yc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5829A5;
	Sat, 31 Aug 2024 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143882; cv=none; b=KU09IM7KpXhd97TD78NfZvgJCpVGxXg1OAcBpt+DR/xTJaxWjO9EKJ3HL2tQAuOKhbfl74QU3VWv7VnJIccZouGtk2dbKM0dIe1pUgwSm/3TE4Q3TVvAdGNG0yuLgtVdfWL+whX5aefygGDJBsVct+ounmcNBRHvyTYSZ9c2c2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143882; c=relaxed/simple;
	bh=iUatsXEnTmL3rn9cQJVw/n3/YwziO1sK8/B0fwSrp1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5g0xLwRD8J6JDUv/jOaKxSD8LzMgG3QY9bUFPiXwJL0KFTm/m+lThZfj+4+2nbRhgpwBIRLOzCzOZNlzWeGMN3zwuUULexU94FVDqXMTeW2ranAI14x6lns6Ee+rB/7TCBVJxsVdvLYUWfh0yZFMQaXIbyJ9knODdFuluxeGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKL+K4yc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED0BC4CEC0;
	Sat, 31 Aug 2024 22:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143881;
	bh=iUatsXEnTmL3rn9cQJVw/n3/YwziO1sK8/B0fwSrp1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKL+K4yc5SbVUKN/shBBUiVDRFMEXOlx2uoYRzYI2QLfZoGrfBzAEqggqxdRPFR2i
	 HdLYyFe1b8i5q3S77QtzC1GF9yohu8Tek5Qly+2m2vZ9ZsA86pHf+HmiNNShePzjP2
	 OChUkB8sH/OwhDBasJD9u6e3LEr6TcebDUCIBI/1136jruyncKSRE3OK5PesAxWG5J
	 srDniIEkeK2G+QHnsuSEunJTvGVGds95WTL8F/Y2BusJC1TQxKRyFTVXD66spFteGL
	 P9t7WHQ13Lotc4xEUU7wiMlpru66a1ygjHCL4wW0tdphUVdgbe58jkKN3W2+oqN7ZX
	 n8Ad25/B160qQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 04/26] NFSD: Handle @rqstp == NULL in check_nfsd_access()
Date: Sat, 31 Aug 2024 18:37:24 -0400
Message-ID: <20240831223755.8569-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240831223755.8569-1-snitzer@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


