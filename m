Return-Path: <linux-fsdevel+bounces-26291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A310F9572D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30130B23403
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C52189915;
	Mon, 19 Aug 2024 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/GDtgyg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7613BAC6;
	Mon, 19 Aug 2024 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091479; cv=none; b=GfVy6pP4Qc3ahkoEOE5vpIbaxshoeGxZsoIfRBKGiYr8cez8i6xxLwuABRjM+3gcQcjqafwfOypdSy1HIcBO6ncC7uHceqb22qgEw259YfFecNHT40B9Ku7zQ2nHcL9PZ98sU4ndBqq1ukhcuCEmY7o/955tkScqda8ITsvutvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091479; c=relaxed/simple;
	bh=xp46w2XPQ1+9n25BOW0sy7euMG8U+rFu4BOmLblYQ2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImfMXXYzhTkz1UakrY0elmfXWSHlwJh6oOTdOkVckbz6VuzJnyzan4EOfMC6OXVfMxNxaLO/M0FiIAEkEsueWsZ+kYE+5nxySj7NYmIVecbyPqpLryjBg9jVD69LuG3R6+plGHZD1ZndQu0MNJS6dXFagtKKYzU8sCibqORmBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/GDtgyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87676C4AF0C;
	Mon, 19 Aug 2024 18:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091478;
	bh=xp46w2XPQ1+9n25BOW0sy7euMG8U+rFu4BOmLblYQ2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/GDtgygkysrDNBKJIVtXWKsGTL8NW2iIs33FGLtrlXePZgQwwTsTVYc4szhI5GRO
	 pIxU8K2O1c4+eCeC9QaavfHPAlNeLzckU58wZFJd36c2otT7GNN2CbEvB49l0QXy8T
	 sxpnaZvK2KcnsJmAaTwnphVGrcucrGWTdDR+fd8oPZDHjOBAHFf00Wlspmp2RExZAX
	 dFVRgI8qvkVa1J1bG/1EqZqD2spKetBIDwoi2KquJfZ0rjfqZagbMH7D6N1ukABU1R
	 4E12GUjFKx2l35QQPu+dlaWOQ6M2KsIyLfmebrSvm/CgmMf56bj+1oA12OjoEPJhH4
	 iPv+yN80nVSKA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 05/24] nfsd: fix nfsfh tracepoints to properly handle NULL rqstp
Date: Mon, 19 Aug 2024 14:17:10 -0400
Message-ID: <20240819181750.70570-6-snitzer@kernel.org>
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

Fixes stop-gap used in previous commit where caller avoided using
tracepoint if rqstp is NULL.  Instead, have each tracepoint avoid
dereferencing NULL rqstp.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/nfsfh.c | 12 ++++--------
 fs/nfsd/trace.h | 36 +++++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 19e173187ab9..bae727e65214 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -195,8 +195,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 
 	error = nfserr_stale;
 	if (IS_ERR(exp)) {
-		if (rqstp)
-			trace_nfsd_set_fh_dentry_badexport(rqstp, fhp, PTR_ERR(exp));
+		trace_nfsd_set_fh_dentry_badexport(rqstp, fhp, PTR_ERR(exp));
 
 		if (PTR_ERR(exp) == -ENOENT)
 			return error;
@@ -244,8 +243,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 						data_left, fileid_type, 0,
 						nfsd_acceptable, exp);
 		if (IS_ERR_OR_NULL(dentry)) {
-			if (rqstp)
-				trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
+			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
 					dentry ?  PTR_ERR(dentry) : -ESTALE);
 			switch (PTR_ERR(dentry)) {
 			case -ENOMEM:
@@ -321,8 +319,7 @@ __fh_verify(struct svc_rqst *rqstp,
 	dentry = fhp->fh_dentry;
 	exp = fhp->fh_export;
 
-	if (rqstp)
-		trace_nfsd_fh_verify(rqstp, fhp, type, access);
+	trace_nfsd_fh_verify(net, rqstp, fhp, type, access);
 
 	/*
 	 * We still have to do all these permission checks, even when
@@ -376,8 +373,7 @@ __fh_verify(struct svc_rqst *rqstp,
 	/* Finally, check access permissions. */
 	error = nfsd_permission(cred, exp, dentry, access);
 out:
-	if (rqstp)
-		trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
+	trace_nfsd_fh_verify_err(net, rqstp, fhp, type, access, error);
 	if (error == nfserr_stale)
 		nfsd_stats_fh_stale_inc(nn, exp);
 	return error;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 77bbd23aa150..d49b3c1e3ba9 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -195,12 +195,13 @@ TRACE_EVENT(nfsd_compound_encode_err,
 
 TRACE_EVENT(nfsd_fh_verify,
 	TP_PROTO(
+		const struct net *net,
 		const struct svc_rqst *rqstp,
 		const struct svc_fh *fhp,
 		umode_t type,
 		int access
 	),
-	TP_ARGS(rqstp, fhp, type, access),
+	TP_ARGS(net, rqstp, fhp, type, access),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
 		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
@@ -212,12 +213,14 @@ TRACE_EVENT(nfsd_fh_verify,
 		__field(unsigned long, access)
 	),
 	TP_fast_assign(
-		__entry->netns_ino = SVC_NET(rqstp)->ns.inum;
-		__assign_sockaddr(server, &rqstp->rq_xprt->xpt_local,
-		       rqstp->rq_xprt->xpt_locallen);
-		__assign_sockaddr(client, &rqstp->rq_xprt->xpt_remote,
-				  rqstp->rq_xprt->xpt_remotelen);
-		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->netns_ino = net->ns.inum;
+		if (rqstp) {
+			__assign_sockaddr(server, &rqstp->rq_xprt->xpt_local,
+					  rqstp->rq_xprt->xpt_locallen);
+			__assign_sockaddr(client, &rqstp->rq_xprt->xpt_remote,
+					  rqstp->rq_xprt->xpt_remotelen);
+		}
+		__entry->xid = rqstp ? be32_to_cpu(rqstp->rq_xid) : 0;
 		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
 		__entry->inode = d_inode(fhp->fh_dentry);
 		__entry->type = type;
@@ -232,13 +235,14 @@ TRACE_EVENT(nfsd_fh_verify,
 
 TRACE_EVENT_CONDITION(nfsd_fh_verify_err,
 	TP_PROTO(
+		const struct net *net,
 		const struct svc_rqst *rqstp,
 		const struct svc_fh *fhp,
 		umode_t type,
 		int access,
 		__be32 error
 	),
-	TP_ARGS(rqstp, fhp, type, access, error),
+	TP_ARGS(net, rqstp, fhp, type, access, error),
 	TP_CONDITION(error),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
@@ -252,12 +256,14 @@ TRACE_EVENT_CONDITION(nfsd_fh_verify_err,
 		__field(int, error)
 	),
 	TP_fast_assign(
-		__entry->netns_ino = SVC_NET(rqstp)->ns.inum;
-		__assign_sockaddr(server, &rqstp->rq_xprt->xpt_local,
-		       rqstp->rq_xprt->xpt_locallen);
-		__assign_sockaddr(client, &rqstp->rq_xprt->xpt_remote,
-				  rqstp->rq_xprt->xpt_remotelen);
-		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->netns_ino = net->ns.inum;
+		if (rqstp) {
+			__assign_sockaddr(server, &rqstp->rq_xprt->xpt_local,
+					  rqstp->rq_xprt->xpt_locallen);
+			__assign_sockaddr(client, &rqstp->rq_xprt->xpt_remote,
+					  rqstp->rq_xprt->xpt_remotelen);
+		}
+		__entry->xid = rqstp ? be32_to_cpu(rqstp->rq_xid) : 0;
 		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
 		if (fhp->fh_dentry)
 			__entry->inode = d_inode(fhp->fh_dentry);
@@ -286,7 +292,7 @@ DECLARE_EVENT_CLASS(nfsd_fh_err_class,
 		__field(int, status)
 	),
 	TP_fast_assign(
-		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->xid = rqstp ? be32_to_cpu(rqstp->rq_xid) : 0;
 		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
 		__entry->status = status;
 	),
-- 
2.44.0


