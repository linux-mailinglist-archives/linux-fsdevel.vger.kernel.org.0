Return-Path: <linux-fsdevel+bounces-27718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BE3963758
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F01428174B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297273D97A;
	Thu, 29 Aug 2024 01:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRKcwZ52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547638F9C;
	Thu, 29 Aug 2024 01:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893472; cv=none; b=fqttLEFJPnhm5/nuk1TS4MoY/OkZPqWXRJcGwrS23sFLwAzXMMQ335UDLiMXkGn3QGrpDFrMgkhpYXj2d8qmGGThpilwce+1ToHUJ7e/l0mzt7tLHuTI/oF8Dat67lPKYzTuVmMCfzo2jS0tpwkc2PvyQxwjzJ1+zFgfE7FbkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893472; c=relaxed/simple;
	bh=Y78xZvTYL1D2xQJPtU1pNF3mbVgDl41te5GOx3JP2rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFlz5s7ivvnDanb6CjVN2jHIZkZNXPziMwVXkZ9W0st0adXhdawSJWRJ9UdM1z6j7hnqclp1abs2lmoMFKL0IrWo2jxmfStYnyAZbGDgXLKVfAHhzUZPtHiL59SvMWr/Bhs89nUbTo67kX0Q/xGLwEMo/K5JJ6MW1GwKBaYx61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRKcwZ52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E456C4CEC2;
	Thu, 29 Aug 2024 01:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893472;
	bh=Y78xZvTYL1D2xQJPtU1pNF3mbVgDl41te5GOx3JP2rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRKcwZ52hEatRGnF9s3euF8fEJCh680YIazLLyWohwEZmtMj739cN68mWyT6Vu4mj
	 b/Pt4ui4BcYnYZlKVShfR9xPpdi6l3UX1tHqWprAjFZjU1HQC8RwnvYNY3kSokI1Tw
	 Ntq3GIA1MToa13O6Qcl8yMWJcxGM408GC8rW8MQGGukVwjNbnLmKXIOmy/8waB1ZPv
	 iVUVJBsU38IXwgSBeO+znEP4fdYgpr9lIIDh03KF/eNaKP2WySYgYrmJHHd/80HeSw
	 7TPkijOc+eZI43986PMRVfqL3fAccQHDkFdd+ofztyNHrHwDy/9L1wXrElI3DzucnZ
	 2Je9aXcP4W+1Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 05/25] NFSD: Refactor nfsd_setuser_and_check_port()
Date: Wed, 28 Aug 2024 21:04:00 -0400
Message-ID: <20240829010424.83693-6-snitzer@kernel.org>
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

There are several places where __fh_verify unconditionally dereferences
rqstp to check that the connection is suitably secure.  They look at
rqstp->rq_xprt which is not meaningful in the target use case of
"localio" NFS in which the client talks directly to the local server.

Prepare these to always succeed when rqstp is NULL.

Signed-off-by: NeilBrown <neilb@suse.de>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 50d23d56f403..4b964a71a504 100644
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
@@ -219,7 +220,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 		put_cred(override_creds(new));
 		put_cred(new);
 	} else {
-		error = nfsd_setuser_and_check_port(rqstp, exp);
+		error = nfsd_setuser_and_check_port(rqstp, &rqstp->rq_cred, exp);
 		if (error)
 			goto out;
 	}
@@ -358,7 +359,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	if (error)
 		goto out;
 
-	error = nfsd_setuser_and_check_port(rqstp, exp);
+	error = nfsd_setuser_and_check_port(rqstp, &rqstp->rq_cred, exp);
 	if (error)
 		goto out;
 
-- 
2.44.0


