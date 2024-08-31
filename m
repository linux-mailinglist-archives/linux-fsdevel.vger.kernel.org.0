Return-Path: <linux-fsdevel+bounces-28115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7A79673A5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D1C281FB9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D810B16F8E5;
	Sat, 31 Aug 2024 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HembWy3W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45190184529;
	Sat, 31 Aug 2024 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143883; cv=none; b=QKojEKL/PgTRFGVuvGjFkq2aXfJbXFTgp7F086N93UORgJtaKSAxSL47fMZwmdU+eUj134e0ezXnL/vx/RgJlCq+uVW9wPbE0f/iUpdPTQDsGar8otR+Gn8mF4Ebpa70gxtpAGhGs2cL9gSkWXhLHoNzNXQH/vcgIJq/+xMPcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143883; c=relaxed/simple;
	bh=7ydj7uFNVevw/icsB23/X3dzVXLeH84MRGvl2kgrFcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MY29/vvgRNLsILRAB2apkd1J4cDEkJZhEm2gEiBzz2ZGYIH4WLgd6g72AJOVoE5/O3ZfQt9j+j4RNPEHft/NGT/2edkXe17YWYP1grzVhvXrmwtGbNevyamnQbZUAZpUf2B0l71mZIhcIQ4im0frGMI2yAUp04Bv1nHXzZVQuv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HembWy3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8859C4CEC0;
	Sat, 31 Aug 2024 22:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143883;
	bh=7ydj7uFNVevw/icsB23/X3dzVXLeH84MRGvl2kgrFcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HembWy3WBopHMqkq854wvPyapbFWxwlu+hzXfGwnx4DfK+ufuXMIZcYtTrl2h16vP
	 sAys3Irdb4RqTzoexrq4jPnXdgYykcP7JVOIH5P9Yy/5OWZc3HWr7uJlBTOEk1Rhrt
	 h4QUVr3O3bOBJ+RQ+JFmBkw95xYYYnz5ASpL0kGDkksKuopSPyYPeKg9q+6f0FIq/w
	 9isgpWC81ZzLcfJcD9BQlyPRgQMdlPmQwmSN08fx1nDylAMeKHL4BexrcAKukBne/E
	 Rogt8fS/BwDuluVrxF++BPQaaFjlwLDzUa0cTkY6nK4h+CbwkcPLwSLxZ8RTNQK/Wn
	 3FQB+4+gWvpiw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 05/26] NFSD: Refactor nfsd_setuser_and_check_port()
Date: Sat, 31 Aug 2024 18:37:25 -0400
Message-ID: <20240831223755.8569-6-snitzer@kernel.org>
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

There are several places where __fh_verify unconditionally dereferences
rqstp to check that the connection is suitably secure.  They look at
rqstp->rq_xprt which is not meaningful in the target use case of
"localio" NFS in which the client talks directly to the local server.

Prepare these to always succeed when rqstp is NULL.

Signed-off-by: NeilBrown <neilb@suse.de>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


