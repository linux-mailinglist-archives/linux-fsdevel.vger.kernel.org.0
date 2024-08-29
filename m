Return-Path: <linux-fsdevel+bounces-27841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42C89646D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884B3B26128
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFBD1B3F00;
	Thu, 29 Aug 2024 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBMcz1CB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D261B3B06;
	Thu, 29 Aug 2024 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938027; cv=none; b=I29RlZPLrCKFr63SrVNBhqnrfTkRHFKurbgDUDQQ0MjKlOK4NsGMv4Yt28Zb+fmiH4Xtvgr5TDdwZxTOHOoOgO/4zAOp6Gqnrj/WLaJyYYyQCfMxuwRGjIkyLeWs7yTAYHWQHE9YncG32p0oa33c89TXw02XsaqMqKYdqBHhIjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938027; c=relaxed/simple;
	bh=JfSKC4ZiR8VXhh79ygO1NACM2pqc9kL0Q+Pv7T9qm5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YvLF9ESnwbjDCOQf6UEQ8fyKb9rREwOf6HN3dKAc7WL+08j0GkhHJGyYuthQPZxedAfW6G0PSeDCEOLuzBAHMetFp4//BvIKJD4GYLELOrirXPuYB50WbTzy6fzK4HctY49NCt1lECWXlBboitnMX49NxO5xbR8/GdTdICJ8vLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBMcz1CB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAADFC4CECA;
	Thu, 29 Aug 2024 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938027;
	bh=JfSKC4ZiR8VXhh79ygO1NACM2pqc9kL0Q+Pv7T9qm5w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SBMcz1CB3cDw68kftO6jXjH6N2H12TgJnWSp10fJ/3PgC3QqF65XlNQETjGxuE0UN
	 HN28t7Q8TNA0PtZtsR4Y9q1zGC3xvBfzMgGV0U4dbgSyGcuz0PEHr9ByTbq3RdLx4L
	 I9rvmUimMob9UzXltTvGp51B1ia+1YhIHD3+zLXwtC+BBgfBM3zCLTSMsS7nwTr1ao
	 fQFQ5lUI2jl0T4s72wt1K1sTaT+IADI3ih9Mvk4y7dx04+iULctxKLzRNAC/opLv/v
	 i9oYQsikM8MEA5uBrqPA8Y4mUSR7sEMCSnctjvlMYfl671LTZiwiwFeQLP0R5/yBmL
	 y2lHp1R42nMkA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Aug 2024 09:26:48 -0400
Subject: [PATCH v3 10/13] nfsd: implement
 OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-delstid-v3-10-271c60806c5d@kernel.org>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
In-Reply-To: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5596; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JfSKC4ZiR8VXhh79ygO1NACM2pqc9kL0Q+Pv7T9qm5w=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm0HcY3VmreDvMgGpOswDK+ElxO7fff+tZqeY/+
 DhA8R82516JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtB3GAAKCRAADmhBGVaC
 FeEKD/wM7NUk4k/t0RaUvKNn/hkPN9YRxAJXGw8fJ1uOviu+XGyaLBTWVL5Cv5GBj0PjrRgkoEf
 hDqV/2R1O5KdYLShyzQ5snhLuBzmQoA6n73bJJp+uG2VnqbTzoOquXT1Jip0EMzomu916XAy0Gy
 XIOL+q5hSOKBFzW7Cu17usocQQjHDe+qQpBKcHtvrr2zJHct/r74lglrbOnzkbTyr9G+eTxBEjZ
 xnXIkwVyk+ta5ANVqrlhmU/hEu5x3lqyQ3q0nEJZzFtTYKJHruxJyAkKPfPypYqKrIKbdk22d4R
 uwFPRGIolRBHa3wvUOBGuux6yAaLxT6H6GxOTFoQywL85KXuNTUcVfB02vqHb9x0YF7a7HEakf0
 2DHccfB/KaIE6CZCgCwiyx8URli0m90rKTBWQQyLu68VfWrIFxxd7SZ3hX2Xs/CoCMEWpEY+KfV
 y0+ViAe1UEB3t6bXKWVSn0CG58ySaZbaB6J/jo8H3Jr3Xbi+jU23VmlbbiEYKxp7Fs3DUWT3sV2
 Ypt9Jud4SYVRMs9Ih/lglahkBxvQ+h2AC+UTPaLfGno7u1QEnyFfx9xcteeJk0oZpQkniJtu+lS
 ru0GD5KbeZ74y391TERE5iWDHJZhZZOELvENHIq+iyc7ukRTRZZpAc/rGnQ46Cknr2He3yG6QuW
 8Zi0tfZ5oPrTTuA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Allow clients to request getting a delegation xor an open stateid if a
delegation isn't available. This allows the client to avoid sending a
final CLOSE for the (useless) open stateid, when it is granted a
delegation.

This is done by moving the increment of the open stateid and unlocking
of the st_mutex until after we acquire a delegation. If we get a
delegation, we zero out the op_stateid field and set the NO_OPEN_STATEID
flag. If the open stateid was brand new, then unhash it too in this case
since it won't be needed.

If we can't get a delegation or the new flag wasn't requested, then just
increment and copy the open stateid as usual.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c       | 28 ++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c         |  5 +++--
 include/uapi/linux/nfs4.h |  7 +++++--
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index dce27420ae31..c4e76427af92 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6035,6 +6035,17 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
 	 */
 }
 
+/* Are we only returning a delegation stateid? */
+static bool open_xor_delegation(struct nfsd4_open *open)
+{
+	if (!(open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
+		return false;
+	if (open->op_delegate_type != NFS4_OPEN_DELEGATE_READ &&
+	    open->op_delegate_type != NFS4_OPEN_DELEGATE_WRITE)
+		return false;
+	return true;
+}
+
 /**
  * nfsd4_process_open2 - finish open processing
  * @rqstp: the RPC transaction being executed
@@ -6057,6 +6068,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	struct nfs4_delegation *dp = NULL;
 	__be32 status;
 	bool new_stp = false;
+	bool deleg_only = false;
 
 	/*
 	 * Lookup file; if found, lookup stateid and check open request,
@@ -6111,9 +6123,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			open->op_odstate = NULL;
 	}
 
-	nfs4_inc_and_copy_stateid(&open->op_stateid, &stp->st_stid);
-	mutex_unlock(&stp->st_mutex);
-
 	if (nfsd4_has_session(&resp->cstate)) {
 		if (open->op_deleg_want & NFS4_SHARE_WANT_NO_DELEG) {
 			open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE_EXT;
@@ -6127,7 +6136,18 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* OPEN succeeds even if we fail.
 	*/
 	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
+	deleg_only = open_xor_delegation(open);
 nodeleg:
+	if (deleg_only) {
+		memcpy(&open->op_stateid, &zero_stateid, sizeof(open->op_stateid));
+		open->op_rflags |= OPEN4_RESULT_NO_OPEN_STATEID;
+		if (new_stp)
+			release_open_stateid(stp);
+	} else {
+		nfs4_inc_and_copy_stateid(&open->op_stateid, &stp->st_stid);
+	}
+	mutex_unlock(&stp->st_mutex);
+
 	status = nfs_ok;
 	trace_nfsd_open(&stp->st_stid.sc_stateid);
 out:
@@ -6143,7 +6163,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	/*
 	* To finish the open response, we just need to set the rflags.
 	*/
-	open->op_rflags = NFS4_OPEN_RESULT_LOCKTYPE_POSIX;
+	open->op_rflags |= NFS4_OPEN_RESULT_LOCKTYPE_POSIX;
 	if (nfsd4_has_session(&resp->cstate))
 		open->op_rflags |= NFS4_OPEN_RESULT_MAY_NOTIFY_LOCK;
 	else if (!(open->op_openowner->oo_flags & NFS4_OO_CONFIRMED))
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c25dbfa0e7ea..11c6079e7dea 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1066,7 +1066,7 @@ static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *sh
 		return nfs_ok;
 	if (!argp->minorversion)
 		return nfserr_bad_xdr;
-	switch (w & NFS4_SHARE_WANT_MASK) {
+	switch (w & NFS4_SHARE_WANT_TYPE_MASK) {
 	case NFS4_SHARE_WANT_NO_PREFERENCE:
 	case NFS4_SHARE_WANT_READ_DELEG:
 	case NFS4_SHARE_WANT_WRITE_DELEG:
@@ -3407,7 +3407,8 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 
 #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
-					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL))
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
 
 #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
 				 BIT(OPEN_ARGS_OPEN_CLAIM_PREVIOUS)	| \
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index caf4db2fcbb9..4273e0249fcb 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -58,7 +58,7 @@
 #define NFS4_SHARE_DENY_BOTH	0x0003
 
 /* nfs41 */
-#define NFS4_SHARE_WANT_MASK		0xFF00
+#define NFS4_SHARE_WANT_TYPE_MASK	0xFF00
 #define NFS4_SHARE_WANT_NO_PREFERENCE	0x0000
 #define NFS4_SHARE_WANT_READ_DELEG	0x0100
 #define NFS4_SHARE_WANT_WRITE_DELEG	0x0200
@@ -66,13 +66,16 @@
 #define NFS4_SHARE_WANT_NO_DELEG	0x0400
 #define NFS4_SHARE_WANT_CANCEL		0x0500
 
-#define NFS4_SHARE_WHEN_MASK		0xF0000
+#define NFS4_SHARE_WHEN_MASK				0xF0000
 #define NFS4_SHARE_SIGNAL_DELEG_WHEN_RESRC_AVAIL	0x10000
 #define NFS4_SHARE_PUSH_DELEG_WHEN_UNCONTENDED		0x20000
 
+#define NFS4_SHARE_WANT_MOD_MASK			0xF00000
 #define NFS4_SHARE_WANT_DELEG_TIMESTAMPS		0x100000
 #define NFS4_SHARE_WANT_OPEN_XOR_DELEGATION		0x200000
 
+#define NFS4_SHARE_WANT_MASK	(NFS4_SHARE_WANT_TYPE_MASK | NFS4_SHARE_WANT_MOD_MASK)
+
 #define NFS4_CDFC4_FORE	0x1
 #define NFS4_CDFC4_BACK 0x2
 #define NFS4_CDFC4_BOTH 0x3

-- 
2.46.0


