Return-Path: <linux-fsdevel+bounces-30989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244179903D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9D61F23E07
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FD92178E3;
	Fri,  4 Oct 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhD7DEn7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690742139CB;
	Fri,  4 Oct 2024 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047900; cv=none; b=q6CNh2TeNLSA6iwxIXtk2kYpZGv5tBl6Ih9glWN+8l8mmNbCgR3Y0eCgJns9SyKM/5pgZUssyIrIHHcyM8QbgYK5RdOlminLaPUMlyk7JB7pTJOTFnLIt2bvj5pueJQki79CtGDL0eWZZ2aQtF71Kk2bVP5NzvFLHbzlQpPJtWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047900; c=relaxed/simple;
	bh=8C0WXBw+0DM2VhbEOKcao7vK3WlMnq5GsT1YUwXNjek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KjP6O8vQT6JHCgClvnXPdGYXtSnmEMSVt8WuPULXfX98KKVZsstMbD5uRqubiKkoRCjZQLpLj/MI34VLwvYpaddd9IJp4xCOWlQBNBTM+51fOv04272JaiJuEobD+kZm1dLnqS0oDaqm5kuZxRdNMwdbts2XcmnoyIyScd2UdZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhD7DEn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844C3C4CECE;
	Fri,  4 Oct 2024 13:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047900;
	bh=8C0WXBw+0DM2VhbEOKcao7vK3WlMnq5GsT1YUwXNjek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dhD7DEn7TBpVMBmAARvMFLKcxeNSzx8/mAuO4NVs7AHv/68WnI155MhttRa7xUWoJ
	 3WPl7Nw5HZ1pQqdLUivKj0QZLJTymBcsEUI9gkR6YgKU9c4OZjhFiiKK4C2jRLdan2
	 szB4SlS9/g3dgEY7ly73brtyDwOpe4ElzDE70uLVclxGf8WuMAQLvDm6WQ4l+DBAdV
	 pZrQfd2LJVrrSiTIRu3NyzrSBCPH7MMdY/e0gHfGW/u79FLbjtYRxx6aUxRViwNRKe
	 iDgK3aGRdu8pLMLX9DXGW/7GxfWyW919ahdP74kysv6KqbHUheS0epfXLYnwW8Cpnd
	 jJnROWbOhyafQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 04 Oct 2024 09:16:50 -0400
Subject: [PATCH v4 7/9] nfsd: implement
 OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-delstid-v4-7-62ac29c49c2e@kernel.org>
References: <20241004-delstid-v4-0-62ac29c49c2e@kernel.org>
In-Reply-To: <20241004-delstid-v4-0-62ac29c49c2e@kernel.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5955; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8C0WXBw+0DM2VhbEOKcao7vK3WlMnq5GsT1YUwXNjek=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/+sNwyzgobOEc8vGs6Ng36cwNf28fuDrK2odC
 w+WSbWldL6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv/rDQAKCRAADmhBGVaC
 FS8eEACm2UrpCEwGXvBdt58OchIefzFh5CC1/e0ZvRe+ly1jK1H+zcpWgLEdvR2wNJDah3+EKTy
 puv7Wcu2dZzyPI9H4ourWJMmVPV0Hf+/0GKh6GFFc7Sud6VUNsA1niOAR4RHiZ/xuNVDYUHMzsP
 GPNKXf9VjHwJHj1smOswNlcWNWbKjUyW3WiMjuTEl2r7wvvFn5YqTkfRDC/z0N0xMrp4fy26BL2
 ts3Uv76B8JU3AQW5zIZKhh7UE8nL2vX4ByLj1vGK3vE4C0kYgZP6xzICJKmekqXqO40Oiyu+/ty
 7l04OnWKml8+EbR/NRSYJzpZwYP0QTSIwedhrhMCBOkmr/2KiMcam+E8pJEQVdVdx6Tw2BKSXmb
 IoLZ+kFndUA55IKzxRn7H1ajFZG0kZP4IZ2zyohF2vRZ34tWbNZgqi2Pb3CT8VyhJtYQAhl9acW
 TAGJRaJ/fkVwx63l9tHlPVqyLN6kZqBoYn2YKLN1p7e79kq89G/+zhdrIIs/jm2i8x7XoEQgbSZ
 f8Ar+khcsr3xyhRHbkgADodr+cxzS10UGuoZbpAOEDLEVd7z2TUbVKn+kzeUO+uN45KOg1DDQ0u
 aJ+O5CFD0Lm04VmaOkZrRjDRRnEsFZeqekJnli9HcMS1pTd++7pxFmC3tRXsJy0Q4NJH0HBUSn1
 58qHBXlle8jbVGQ==
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
 fs/nfsd/nfs4state.c       | 33 +++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c         |  5 +++--
 include/uapi/linux/nfs4.h |  7 +++++--
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ecf02badf598d147feb5133cb43225e3611d6d8e..a9eb7cf9fd7e74a648170c60bf031fdc32533dd3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6054,6 +6054,17 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
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
@@ -6076,6 +6087,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	struct nfs4_delegation *dp = NULL;
 	__be32 status;
 	bool new_stp = false;
+	bool deleg_only = false;
 
 	/*
 	 * Lookup file; if found, lookup stateid and check open request,
@@ -6130,9 +6142,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			open->op_odstate = NULL;
 	}
 
-	nfs4_inc_and_copy_stateid(&open->op_stateid, &stp->st_stid);
-	mutex_unlock(&stp->st_mutex);
-
 	if (nfsd4_has_session(&resp->cstate)) {
 		if (open->op_deleg_want & NFS4_SHARE_WANT_NO_DELEG) {
 			open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE_EXT;
@@ -6146,7 +6155,23 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* OPEN succeeds even if we fail.
 	*/
 	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
+
+	/*
+	 * If there is an existing open stateid, it must be updated and
+	 * returned. Only respect WANT_OPEN_XOR_DELEGATION when a new
+	 * open stateid would have to be created.
+	 */
+	deleg_only = new_stp && open_xor_delegation(open);
 nodeleg:
+	if (deleg_only) {
+		memcpy(&open->op_stateid, &zero_stateid, sizeof(open->op_stateid));
+		open->op_rflags |= OPEN4_RESULT_NO_OPEN_STATEID;
+		release_open_stateid(stp);
+	} else {
+		nfs4_inc_and_copy_stateid(&open->op_stateid, &stp->st_stid);
+	}
+	mutex_unlock(&stp->st_mutex);
+
 	status = nfs_ok;
 	trace_nfsd_open(&stp->st_stid.sc_stateid);
 out:
@@ -6162,7 +6187,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	/*
 	* To finish the open response, we just need to set the rflags.
 	*/
-	open->op_rflags = NFS4_OPEN_RESULT_LOCKTYPE_POSIX;
+	open->op_rflags |= NFS4_OPEN_RESULT_LOCKTYPE_POSIX;
 	if (nfsd4_has_session(&resp->cstate))
 		open->op_rflags |= NFS4_OPEN_RESULT_MAY_NOTIFY_LOCK;
 	else if (!(open->op_openowner->oo_flags & NFS4_OO_CONFIRMED))
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9fb7764924240a8c584517bcdf682fea1b417180..dad6875aa17eb99759cdbacb814b7988848a961b 100644
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
@@ -3408,7 +3408,8 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 
 #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
-					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL))
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
 
 #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
 				 BIT(OPEN_ARGS_OPEN_CLAIM_PREVIOUS)	| \
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index caf4db2fcbb94686631ec2232a8ff189c97c8617..4273e0249fcbb54996f5642f9920826b9d68b7b9 100644
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
2.46.2


