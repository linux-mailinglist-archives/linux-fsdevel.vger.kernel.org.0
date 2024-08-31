Return-Path: <linux-fsdevel+bounces-28117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37EE9673A9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620471F21E06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82B918594B;
	Sat, 31 Aug 2024 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op4uQemy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371F18592F;
	Sat, 31 Aug 2024 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143886; cv=none; b=LZBAD07Wn78gjbXzQGx25Qq7SwBsaNlMw/nBeEPh93DjgbrUFspvMMzfAT1FmaEafkRBBo4tKpzhwoeSXiDxfQBA9R/jYEEUjAdXaWWXke+tLV+gQ6xsywFizjjLYga9rfGLMk+UO7hoI9IDT/2+w6+urdm34HK6BRjpfY7rvmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143886; c=relaxed/simple;
	bh=iXfzEdXlBsnkhEDJKb3y3LSxVOZGX3uj+aBITXB6HxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHX7U/8Vgj8BDduF0rhf73iapj+ChVxCymMsp7AovHtcnDXCKYhALFwsXEuBrFm0VzQaK2585xqwhmYXmzUkR3ByHmwXisgdL4yGrv11HX/XiTEIAjXMSH/gd5T3taQgV4cT2eiD4yZLW/0iEnlH2Dqz2q1HKEDSSc65X9h5sPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op4uQemy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6917C4CEC4;
	Sat, 31 Aug 2024 22:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143885;
	bh=iXfzEdXlBsnkhEDJKb3y3LSxVOZGX3uj+aBITXB6HxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Op4uQemyJnA7Uh5rKNEbeo6tlGEBir2AQotGz38dNdncaGWDVqmvUHRbBaiLr54Js
	 rlvZ9arLAkloYWpKkOlygu6VLJi31iFWMZWI+iqqQs/vcFYpjOhj/trB+UmzCrcJkF
	 DZNmIHgEiDFZ+5cbHkklEzn/72QPIvXMl/Y9bQ5Bvkpp6hf4F7W2nmpqJ7b5sy4Dbe
	 FdRaxJEsYEMIMWL+r31u/voJKtV/6heqNmgyjgM0ru8cZAUkdhiRl47ECLrva/QGl0
	 K6F5qdsATEla7LNpZsYzUNfSCFNqzb0TFRFoLYnQH82R9Qf1XZ1ZS8eyr4tmgbe2a9
	 OsYXRJP0Kiy7Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 07/26] NFSD: Short-circuit fh_verify tracepoints for LOCALIO
Date: Sat, 31 Aug 2024 18:37:27 -0400
Message-ID: <20240831223755.8569-8-snitzer@kernel.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

LOCALIO will be able to call fh_verify() with a NULL rqstp. In this
case, the existing trace points need to be skipped because they
want to dereference the address fields in the passed-in rqstp.

Temporarily make these trace points conditional to avoid a seg
fault in this case. Putting the "rqstp != NULL" check in the trace
points themselves makes the check more efficient.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 77bbd23aa150..d22027e23761 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -193,7 +193,7 @@ TRACE_EVENT(nfsd_compound_encode_err,
 		{ S_IFIFO,		"FIFO" }, \
 		{ S_IFSOCK,		"SOCK" })
 
-TRACE_EVENT(nfsd_fh_verify,
+TRACE_EVENT_CONDITION(nfsd_fh_verify,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,
 		const struct svc_fh *fhp,
@@ -201,6 +201,7 @@ TRACE_EVENT(nfsd_fh_verify,
 		int access
 	),
 	TP_ARGS(rqstp, fhp, type, access),
+	TP_CONDITION(rqstp != NULL),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
 		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
@@ -239,7 +240,7 @@ TRACE_EVENT_CONDITION(nfsd_fh_verify_err,
 		__be32 error
 	),
 	TP_ARGS(rqstp, fhp, type, access, error),
-	TP_CONDITION(error),
+	TP_CONDITION(rqstp != NULL && error),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
 		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
@@ -295,12 +296,13 @@ DECLARE_EVENT_CLASS(nfsd_fh_err_class,
 		  __entry->status)
 )
 
-#define DEFINE_NFSD_FH_ERR_EVENT(name)		\
-DEFINE_EVENT(nfsd_fh_err_class, nfsd_##name,	\
-	TP_PROTO(struct svc_rqst *rqstp,	\
-		 struct svc_fh	*fhp,		\
-		 int		status),	\
-	TP_ARGS(rqstp, fhp, status))
+#define DEFINE_NFSD_FH_ERR_EVENT(name)			\
+DEFINE_EVENT_CONDITION(nfsd_fh_err_class, nfsd_##name,	\
+	TP_PROTO(struct svc_rqst *rqstp,		\
+		 struct svc_fh	*fhp,			\
+		 int		status),		\
+	TP_ARGS(rqstp, fhp, status),			\
+	TP_CONDITION(rqstp != NULL))
 
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badexport);
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badhandle);
-- 
2.44.0


