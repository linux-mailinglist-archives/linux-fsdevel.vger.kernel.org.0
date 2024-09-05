Return-Path: <linux-fsdevel+bounces-28733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C189B96D90A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2AD286FE0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E6E1A0700;
	Thu,  5 Sep 2024 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcJyyKC1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723691A01B8;
	Thu,  5 Sep 2024 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540131; cv=none; b=AO6ax2MRCRXu8fEFBMwgTBMaXrTuFSnVhf3goB8ga+xwYX9iskImrit6n6GUUz9AvlfJxhpot9O1FoI+e0K6QUn767ou4DuiXr+3sAiuxaqBzMjFjGbHPL9mWQbkr77KVO3qpbFIvqPdyLzBnIuGl5yFwmHKjiNbQX9CRBcPC7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540131; c=relaxed/simple;
	bh=MxOPfiLDr3waUK1Qzm+p8NQ94i5UzU3rpW+2ExXilF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LytsNbDBYG0RUMAmtcc/eFbycZRzB5uKtyV20iLC/ZUYvUPsDYuOcSyT2IsLwncRvEZ9Y3GoGdMeHiQEUvBkA6df5+cWFi+bxubROiikmCj8AbML7A7I9kbn7kqu8xSLJZPrDOmLfAhBes3S/wq4FYSBGM79ZYi7xZ/TybX918o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcJyyKC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C88EC4CEC3;
	Thu,  5 Sep 2024 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725540131;
	bh=MxOPfiLDr3waUK1Qzm+p8NQ94i5UzU3rpW+2ExXilF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bcJyyKC17cH20bvo3xTK5rLqOsEb+ikyYZk/2aQPYZkiLH8ELq37IIb42+Br8FtcK
	 zZTRf0g2sYPpx49B3MXRtxvfOyJSvfYTwjbio/sYoPA1H5qw8C3taCxNbQoYAzDO0X
	 hAvkIAifuir8TU/sfcZMeWeT1uQ16PUUURN53BA8DLJlMbOuJTdo6Z9bqvnudl4+TB
	 FINDc+Ki2e6TmC2ybFV3/6CegbXUFqSQZUb5frGqHzr5r/1oIw7T49pbR4+dXWhxOj
	 J2JCUJXDJt8nM+T4QK3IkiiI9eUxv63DRnXBq2DUHxxt1ZvpPphaDPPjMWjxdQzsKN
	 AAr4o9o7bFISg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Sep 2024 08:41:52 -0400
Subject: [PATCH v4 08/11] nfsd: implement
 OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-delstid-v4-8-d3e5fd34d107@kernel.org>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
In-Reply-To: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5596; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MxOPfiLDr3waUK1Qzm+p8NQ94i5UzU3rpW+2ExXilF8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm2acVsF3KFmSerRwJYZKYFXS+1VmFkJASg1rHi
 6uXtNokxLeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtmnFQAKCRAADmhBGVaC
 FWxaEACvl/RbPhKbYcEzlFxvODRVPKn8fErUduxQjgFFnTBXV1MSqm22ONNttxoZDXryxw5AFVL
 IBMdO6OKS7NTdOjxg5hLiujBJKxjJ9yM/mOJkZOBgfhGhkHRjyR6U0b5362cvcLajzNGAORhhuq
 ZAxk47csBq27hbQentyysUXICE1ax5qRfYRabUINvaNFiSByg+tdOeNpkIqxwjpkGaKYAg1t1Es
 4v5wrDM4zGA9QWf/tLnmU2auyXkRdBxgiRQLW/RsQpVryU2fUcYEbdP+5RG1vX7UwuUCydxQvzc
 QVIbtw9eClz4kuKoLugsecHsHC5AKnNDGcJy9C5GM9yILKizak9T1M7EEMOr3cociF0HrH0hA6z
 OQCCUwL93RjWfhO6+nHhbddeu4HTBLcwVYN1CQXmXXietO/C7uHVju9TuPUkHIMIrvT3DQ+lsfn
 WHlT4d3y7acM3hkiHWt3+tqRew2YXzE9Cw6po/yappffVJreHdw3Jm+AsmTeeKLkpWNotIj+LMu
 esOQeFNAv3vuGLbkC8uTKc6pgIHiU1YLuI9XUliwQcxBE0KIpemtSrk65ihnxf/drOfHDRBmONT
 RASx7hMe1E21YAiVZoHmmnxDxlLOToRSw+Lj7jOaGjyj9Ag1muc4xGCWkdpUL42YzSaq0MVCeUQ
 bAsn75R8mNFNTXA==
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
index 8851fc69f5c6..40e0c9b0ef71 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6051,6 +6051,17 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
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
@@ -6073,6 +6084,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	struct nfs4_delegation *dp = NULL;
 	__be32 status;
 	bool new_stp = false;
+	bool deleg_only = false;
 
 	/*
 	 * Lookup file; if found, lookup stateid and check open request,
@@ -6127,9 +6139,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			open->op_odstate = NULL;
 	}
 
-	nfs4_inc_and_copy_stateid(&open->op_stateid, &stp->st_stid);
-	mutex_unlock(&stp->st_mutex);
-
 	if (nfsd4_has_session(&resp->cstate)) {
 		if (open->op_deleg_want & NFS4_SHARE_WANT_NO_DELEG) {
 			open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE_EXT;
@@ -6143,7 +6152,18 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
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
@@ -6159,7 +6179,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	/*
 	* To finish the open response, we just need to set the rflags.
 	*/
-	open->op_rflags = NFS4_OPEN_RESULT_LOCKTYPE_POSIX;
+	open->op_rflags |= NFS4_OPEN_RESULT_LOCKTYPE_POSIX;
 	if (nfsd4_has_session(&resp->cstate))
 		open->op_rflags |= NFS4_OPEN_RESULT_MAY_NOTIFY_LOCK;
 	else if (!(open->op_openowner->oo_flags & NFS4_OO_CONFIRMED))
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 4cedcb252aa1..08d9421cd90e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1067,7 +1067,7 @@ static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *sh
 		return nfs_ok;
 	if (!argp->minorversion)
 		return nfserr_bad_xdr;
-	switch (w & NFS4_SHARE_WANT_MASK) {
+	switch (w & NFS4_SHARE_WANT_TYPE_MASK) {
 	case NFS4_SHARE_WANT_NO_PREFERENCE:
 	case NFS4_SHARE_WANT_READ_DELEG:
 	case NFS4_SHARE_WANT_WRITE_DELEG:
@@ -3410,7 +3410,8 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 
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


