Return-Path: <linux-fsdevel+bounces-27167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C0C95F1F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE851C215BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDB1198A29;
	Mon, 26 Aug 2024 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCI9jWeo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D27B198853;
	Mon, 26 Aug 2024 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676404; cv=none; b=MTiWNcMJmxeo19N4XNRGNc8nSfraAL9VYqJs/Xnd0h+RQhf/MQgpqzJZj905pKWFIhl1hmO1rU15+0pzGwNfYOfXcAl5RiQopK5WFcT5KO+lSBHa8EdpbjyrH4cQu3syg6YGLRwI6kBJ9/eGEuoDy5z3kFiIw0mzbHDpcOC28So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676404; c=relaxed/simple;
	bh=sVpxrgIziSW8Pox+j3rWuGkFmCBxDs6hJ/Qy+5YLVr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=flpfWrQHgvZe3nU7DF1DUCZSECyqiMC/0OLo+lFcsKK089ty4NYCU1t6faWJQj9G9+7ME5S6T0ORhcUqe3ESzyEJU6k4amXmko8S6IANpqFd4DOmijTtx2Mm1+P/QZvdzJDeU3JvEE27BlsjFFwQ+2iFi+YAmxSFdKhEeFqFg8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCI9jWeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02D1C58280;
	Mon, 26 Aug 2024 12:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676404;
	bh=sVpxrgIziSW8Pox+j3rWuGkFmCBxDs6hJ/Qy+5YLVr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BCI9jWeoEzDiJBlol7jAJppyphKl7zrKfn076kkJPE+mM5MLwKOQZTgxCMke7OUij
	 0hJTvTvNoKDDjK6IzKarhsua2U4OQjN7z83ZjymriTpJauVNhcJeTYfd9IBpI0HZEO
	 iOQx/bkc9dWmZ+kLy9od83tEpWZKzutkOfVBJ72mjPN/0dIfOP6l4vX4HPz65cX4A0
	 ji4K/cukMelXTqB0iNfStTnrs9U5fv+6NAgV+3mxg+yGiit8uQ6UrcrGi/VDZJdewt
	 0MBqE3bzFBXKlDaIOUqiOQ4ELLp1bqzRJCeTJ+7WwXWOAnA5mg4SnJ46zcy/AlwHen
	 Ep5HxTvA2+rlA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 26 Aug 2024 08:46:14 -0400
Subject: [PATCH v2 4/7] nfsd: implement
 OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-delstid-v2-4-e8ab5c0e39cc@kernel.org>
References: <20240826-delstid-v2-0-e8ab5c0e39cc@kernel.org>
In-Reply-To: <20240826-delstid-v2-0-e8ab5c0e39cc@kernel.org>
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5596; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sVpxrgIziSW8Pox+j3rWuGkFmCBxDs6hJ/Qy+5YLVr0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmzHkrmZZRnuYFixPQFcBX8dKlXQRH74gaS7OaQ
 qRI7ltDSKaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsx5KwAKCRAADmhBGVaC
 FfsDD/9RNBUr7+ZYVFVpwJFIB8MlNcYCrsUOVuuzNIL8J3vPn3VhcpHq0ZXTi0bSLkIVrUSMSaI
 CVU/vyl0OCGNQmP089KRc8B0O7kF6Hh8MhOx41jcLew7pwccNixySSfV5vAEwrv9xVGbGUyBhxU
 Ztqd/jT3I4a3dQ/bDCAGIjpbejV/YWI0W9SDwl/pvKc1mubbInq4ub4emC9xrnIjcWUlxdGthe4
 3kmxONOpoybhGPzY/JtqLnyqR8wYg964oEfxia0XOUeXD8DwFmQ9oArmrNhtoOGYiGqol1DPeZF
 vGEJr0T1zuqdxxjJbc1oK/LZ0Um/j3UWrqUYCtCVkiIWWcK/M92C8O/3YKDbtTIkMTz4Jj6q82R
 2X2nWMXvyqwk8/bGs7G0Lu0F8/MPH1d6Oq9dxZdW350C7Z+tkybnlspk9iH5hO25njCX3IDki+Z
 KTtwsufrV7v8VEjerCSY4wC41ERERtf/IMRS96daLMYNL9jbpxV1G218RBUzmlzh1MdDQpssVrt
 vz79E+uHqOgfFVFSy0jHeHRvqhhyciNl/U4tEg8afyqqWkqlEcoXialv2R3XvTb0WAfQSHvPOJ2
 7teHEEms4p1eICs26MEWNQNnvGqbKW1TdjC7UCl0AjE+nY4gZX7dM72f17IVR4YQA9SMyO91z2g
 TqPtn19BZGymzYA==
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
index 9fe67c412f9b..b544320246bf 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6029,6 +6029,17 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
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
@@ -6051,6 +6062,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	struct nfs4_delegation *dp = NULL;
 	__be32 status;
 	bool new_stp = false;
+	bool deleg_only = false;
 
 	/*
 	 * Lookup file; if found, lookup stateid and check open request,
@@ -6105,9 +6117,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			open->op_odstate = NULL;
 	}
 
-	nfs4_inc_and_copy_stateid(&open->op_stateid, &stp->st_stid);
-	mutex_unlock(&stp->st_mutex);
-
 	if (nfsd4_has_session(&resp->cstate)) {
 		if (open->op_deleg_want & NFS4_SHARE_WANT_NO_DELEG) {
 			open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE_EXT;
@@ -6121,7 +6130,18 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
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
@@ -6137,7 +6157,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	/*
 	* To finish the open response, we just need to set the rflags.
 	*/
-	open->op_rflags = NFS4_OPEN_RESULT_LOCKTYPE_POSIX;
+	open->op_rflags |= NFS4_OPEN_RESULT_LOCKTYPE_POSIX;
 	if (nfsd4_has_session(&resp->cstate))
 		open->op_rflags |= NFS4_OPEN_RESULT_MAY_NOTIFY_LOCK;
 	else if (!(open->op_openowner->oo_flags & NFS4_OO_CONFIRMED))
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1c8219ea8af7..8266f910d847 100644
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


