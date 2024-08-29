Return-Path: <linux-fsdevel+bounces-27720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB2D96375D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C59AB24D67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E012D47A76;
	Thu, 29 Aug 2024 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH1KJB12"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A044C77;
	Thu, 29 Aug 2024 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893475; cv=none; b=bWEXCxcmmj2fzaVOSw5W0JEZAZpchQaIpgjYcLRQDmjiSv4LhER6XrNo9udycRHNl6/kzjAykCGIV7vbsk1BcotYOg/iJLKC+jOE9U22+Xqvh08ZOCc3UtMdBtbNnTGgXX93gIdizU3e8J2fabwLcdGw0v6a5NsAv86AMQJYawU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893475; c=relaxed/simple;
	bh=HC2rLX7ArhOQmIr0odZxfM9tyNgghHA3EI1DpS8Sxv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1YKhw/Pdqvj5rDURhoKIPxDtyg1+SU2CZrYpIlEix5NIQ7RY5qsP0FlGXcFoeeskJEYBYLOvr7QivbJ5n8C1s1pb8STVxEzX8NlUOdynwkUugSbU9zWCo+5qf5X2jo6Vo/hqpgQ+7sAbRlwN4vNpTzMRCWlUVNlJkzZHO7NlrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH1KJB12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC5DC4CEC4;
	Thu, 29 Aug 2024 01:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893475;
	bh=HC2rLX7ArhOQmIr0odZxfM9tyNgghHA3EI1DpS8Sxv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DH1KJB12myzTrl/dJx+Fbwk2cWjPJVWMs/AJZnXnm9iK6Ds26YMGFC9eSbF13bykR
	 6geXcbBS1lRkmcVrJy6yFu7uJiYxaDmLKiUXZyOl1W7YEekY7d5Xti0o70rHbXVZOb
	 +A+NeYccIcCAc6jvqDHxPU6G5+u3RO690J2rkohFThsg5EEaCYw7DbdZs7Y7KqcvC3
	 yXADd/ZEchhuhenNTC/rGHmmgkRRyxPz1XfwlgrApfiIhAU3oLLTbFNVmPE6MvN2id
	 owyPFxJ6esvwvCC22ntNH8v1+XzNJOiD8BcGjtKqMnH2TWfNdveR5lDKMxfXTQAdjn
	 FijhJrerYfwng==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 07/25] NFSD: Short-circuit fh_verify tracepoints for LOCALIO
Date: Wed, 28 Aug 2024 21:04:02 -0400
Message-ID: <20240829010424.83693-8-snitzer@kernel.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

LOCALIO will be able to call fh_verify() with a NULL rqstp. In this
case, the existing trace points need to be skipped because they
want to dereference the address fields in the passed-in rqstp.

Temporarily make these trace points conditional to avoid a seg
fault in this case. Putting the "rqstp != NULL" check in the trace
points themselves makes the check more efficient.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
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


