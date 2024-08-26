Return-Path: <linux-fsdevel+bounces-27170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C7695F203
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227401C22A62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F231991D5;
	Mon, 26 Aug 2024 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM/DRcOH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28DE1946B1;
	Mon, 26 Aug 2024 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676409; cv=none; b=My4N0gq9HLa+eQJHAQ4nNmy8oaSHhu7v5gKJE11OtTbwUXNWrK5l1cRJoyHYQLOqA90jF9vd41boA2NBINQBsK6OzEXgPoYjE+P2xTIptK7qsNVq5qZTTnorUiinZCuX170HYpMPHa1lWYON4dFJl8fCdRfcePLv11bCawNNbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676409; c=relaxed/simple;
	bh=sdSxDYPop03aiNFLgfHj/2yfQDSj1gBVwywHfAg6B1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WdppgKN2FJZKel8CXUPYlCdjisUtWPk2LebOaN0+MZiUY9pf5gVK51WY84GMYZ6jQLLXBxVfSsAl4WZvg81oO8TNPaY1xkJQnkI0nyTcOfOD47DilDaYa0xiE9Rfcuhg/afRAG7nle0yqm7doC14P/oXe3FLRC1MrYL/sqc4daE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MM/DRcOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD46FC58280;
	Mon, 26 Aug 2024 12:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676409;
	bh=sdSxDYPop03aiNFLgfHj/2yfQDSj1gBVwywHfAg6B1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MM/DRcOHVhyccozR42sW+tha1/xouT3iNeq2N3py09kH+O+3xQzRuv1NLdPAVARTD
	 kCVS0PHuHpTMttnqOLPbP1xqHj7/07yux28ZVhSagXR8fMzFmCFHvSI3SE5j3izq9g
	 fKLPpRGKobx5/luNuJ/Pn+sAlCj0RSy6CIUDX8wwKro+dXi96wQKBqXwBQyx26u7jo
	 LeHGV0YGW8kTwqat4ouN67RqVMFGkeF5WxrN6utgDcOCDBBDzgzcpm0TItWrxBu1qV
	 qsLIdNFHuIlAqz70K927XvLRG9urBHbMaUS9IcGYMI9e0fLv0BabtnAeLOWX9IXBLe
	 HZfHuPNunAWGQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 26 Aug 2024 08:46:17 -0400
Subject: [PATCH v2 7/7] nfsd: add support for delegated timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-delstid-v2-7-e8ab5c0e39cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10947; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sdSxDYPop03aiNFLgfHj/2yfQDSj1gBVwywHfAg6B1o=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGbMeSug9QeeVoMDQuldltO9W/S4C1aDARH0wCQ3weeXI15Ln
 4kCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJmzHkrAAoJEAAOaEEZVoIVuvQP/Axo
 OhT2KVqh+hY9uz7rG0VEs3br0zXvhJaCpCY1KXwASLj+Z3FST+gtB6pCktI5uGYSPjiNYgQn4WS
 hHdyKuQhZ15/axQslfqcY7uWJsVyKds2rkc/W08onS9C5y9hCrN92O9L5RNCAtKVE4h7jcC/Pqj
 yJ1eUasJg1fYbJiUJHoHgsy9Irqj3L//6GQ48GffEmlyOXqR8jo3SOYr8+VkU7etTK3NKz4DPfh
 rbIFddtEmIul4z1sgerZuuYhgdygsTRfY5flIihWp8AmilAN5qc817NK80sBgvwJkeRXSMdNC1Y
 e/t9ag8g0TRH5FgX2n/eaFPzQbLuFlXFCH4O3QYtkZrYm/qd0w3+kh40XzKwOt02Nia2rUVtsKv
 BFnfLX42zkcpTUvZkjngnP0skk0KVs1Ios21uSkXrCyJG+nD+PYKgUPDWDjI19D4wjH5WCNiBuw
 iHNhSIKnMHumcsyP7ZwkfRd5sHtbhaTUlndX3rviW3jBkPGZcdcLzV7zVNJnx31w5CjnOpxXtJg
 amRdRhKCf6LQKiZcBJAw60FUiJ0Eh0QB+Ex0jJTKaEBcoAw/RZWdO3k9ZHURPxpop7VJwxYm+ot
 j2JKrIr41Md409i/RQjUFyEwDQj/ziNmZq0cOiIBTseoxgxByhWjCGvsiZ1UbV1jnbAdj3FJ5PT
 OzJRC
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add support for the delegated timestamps on write delegations. This
allows the server to proxy timestamps from the delegation holder to
other clients that are doing GETATTRs vs. the same inode.

Add a new flag to nfs4_delegation for indicating that the client can
provide timestamps in the CB_GETATTR response. Set that when the client
sets the appropriate flag in the open request.

Add timespec64 fields to nfs4_cb_fattr and decode the timestamps into
those. Vet those timestamps according to the delstid spec and update
the inode attrs if necessary.

For multigrain timestamps, ensure that we accept the client's version of
the ctime instead of updating to the latest clock as we normally would.
That should be fine since the client holds a delegation, and nothing
else will be making changes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 42 +++++++++++++++++++++---
 fs/nfsd/nfs4state.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c      |  1 +
 fs/nfsd/nfsd.h         |  3 +-
 fs/nfsd/state.h        |  3 ++
 fs/nfsd/xdr4cb.h       | 10 ++++--
 6 files changed, 130 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 988232086589..d5004790f2b1 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -93,12 +93,35 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
 {
 	fattr->ncf_cb_change = 0;
 	fattr->ncf_cb_fsize = 0;
+	fattr->ncf_cb_atime.tv_sec = 0;
+	fattr->ncf_cb_atime.tv_nsec = 0;
+	fattr->ncf_cb_mtime.tv_sec = 0;
+	fattr->ncf_cb_mtime.tv_nsec = 0;
+
 	if (bitmap[0] & FATTR4_WORD0_CHANGE)
 		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_change) < 0)
 			return -NFSERR_BAD_XDR;
 	if (bitmap[0] & FATTR4_WORD0_SIZE)
 		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_fsize) < 0)
 			return -NFSERR_BAD_XDR;
+	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
+		fattr4_time_deleg_access access;
+
+		if (!xdrgen_decode_fattr4_time_deleg_access(xdr, &access))
+			return -NFSERR_BAD_XDR;
+		fattr->ncf_cb_atime.tv_sec = access.seconds;
+		fattr->ncf_cb_atime.tv_nsec = access.nseconds;
+
+	}
+	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
+		fattr4_time_deleg_modify modify;
+
+		if (!xdrgen_decode_fattr4_time_deleg_modify(xdr, &modify))
+			return -NFSERR_BAD_XDR;
+		fattr->ncf_cb_mtime.tv_sec = modify.seconds;
+		fattr->ncf_cb_mtime.tv_nsec = modify.nseconds;
+
+	}
 	return 0;
 }
 
@@ -364,13 +387,18 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
 	struct nfs4_delegation *dp =
 		container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
 	struct knfsd_fh *fh = &dp->dl_stid.sc_file->fi_fhandle;
-	u32 bmap[1];
+	u32 bmap[3];
+	u32 bmap_size = 1;
 
 	bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
-
+	if (dp->dl_deleg_ts) {
+		bmap[1] = 0;
+		bmap[2] = FATTR4_WORD2_TIME_DELEG_ACCESS | FATTR4_WORD2_TIME_DELEG_MODIFY;
+		bmap_size = 3;
+	}
 	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
 	encode_nfs_fh4(xdr, fh);
-	encode_bitmap4(xdr, bmap, ARRAY_SIZE(bmap));
+	encode_bitmap4(xdr, bmap, bmap_size);
 	hdr->nops++;
 }
 
@@ -595,7 +623,7 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
 	struct nfs4_cb_compound_hdr hdr;
 	int status;
 	u32 bitmap[3] = {0};
-	u32 attrlen;
+	u32 attrlen, maxlen;
 	struct nfs4_cb_fattr *ncf =
 		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
 
@@ -614,7 +642,11 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
 		return -NFSERR_BAD_XDR;
 	if (xdr_stream_decode_u32(xdr, &attrlen) < 0)
 		return -NFSERR_BAD_XDR;
-	if (attrlen > (sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize)))
+	maxlen = sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize);
+	if (bitmap[2] != 0)
+		maxlen += (sizeof(ncf->ncf_cb_mtime.tv_sec) +
+			   sizeof(ncf->ncf_cb_mtime.tv_nsec)) * 2;
+	if (attrlen > maxlen)
 		return -NFSERR_BAD_XDR;
 	status = decode_cb_fattr4(xdr, bitmap, ncf);
 	return status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f353aeb4cc0a..ea63c4f0ef0a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5975,6 +5975,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
+	if (open->op_deleg_want & NFS4_SHARE_WANT_DELEG_TIMESTAMPS)
+		dp->dl_deleg_ts = true;
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
 		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
@@ -8819,6 +8821,83 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
 	get_stateid(cstate, &u->write.wr_stateid);
 }
 
+/**
+ * set_cb_time - vet and set the timespec for a cb_getattr update
+ * @cb: timestamp from the CB_GETATTR response
+ * @orig: original timestamp in the inode
+ * @now: current time
+ *
+ * Given a timestamp in a CB_GETATTR response, check it against the
+ * current timestamp in the inode and the current time. Returns true
+ * if the inode's timestamp needs to be updated, and false otherwise.
+ * @cb may also be changed if the timestamp needs to be clamped.
+ */
+static bool set_cb_time(struct timespec64 *cb, const struct timespec64 *orig,
+			const struct timespec64 *now)
+{
+
+	/*
+	 * "When the time presented is before the original time, then the
+	 *  update is ignored." Also no need to update if there is no change.
+	 */
+	if (timespec64_compare(cb, orig) <= 0)
+		return false;
+
+	/*
+	 * "When the time presented is in the future, the server can either
+	 *  clamp the new time to the current time, or it may
+	 *  return NFS4ERR_DELAY to the client, allowing it to retry."
+	 */
+	if (timespec64_compare(cb, now) > 0) {
+		/* clamp it */
+		*cb = *now;
+	}
+
+	return true;
+}
+
+static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation *dp)
+{
+	struct timespec64 now = current_time(d_inode(dentry));
+	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
+	struct inode *inode = d_inode(dentry);
+	struct iattr attrs = { };
+	int ret;
+
+	if (dp->dl_deleg_ts) {
+		struct timespec64 atime = inode_get_atime(inode);
+		struct timespec64 mtime = inode_get_mtime(inode);
+
+		attrs.ia_atime = ncf->ncf_cb_atime;
+		attrs.ia_mtime = ncf->ncf_cb_mtime;
+
+		if (set_cb_time(&attrs.ia_atime, &atime, &now))
+			attrs.ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
+
+		if (set_cb_time(&attrs.ia_mtime, &mtime, &now)) {
+			struct timespec64 ctime = inode_get_ctime(inode);
+
+			attrs.ia_valid |= ATTR_MTIME | ATTR_MTIME_SET;
+			if (timespec64_compare(&attrs.ia_mtime, &ctime) > 0) {
+				attrs.ia_valid |= ATTR_CTIME | ATTR_CTIME_DLG;
+				attrs.ia_ctime = attrs.ia_mtime;
+			}
+		}
+	} else {
+		attrs.ia_valid |= ATTR_MTIME | ATTR_CTIME;
+		attrs.ia_mtime = attrs.ia_ctime = now;
+	}
+
+	if (!attrs.ia_valid)
+		return 0;
+
+	attrs.ia_valid |= ATTR_DELEG;
+	inode_lock(inode);
+	ret = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
+	inode_unlock(inode);
+	return ret;
+}
+
 /**
  * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
  * @rqstp: RPC transaction context
@@ -8846,7 +8925,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	struct file_lock_context *ctx;
 	struct nfs4_cb_fattr *ncf;
 	struct file_lease *fl;
-	struct iattr attrs;
 
 	*modified = false;
 	ctx = locks_inode_context(inode);
@@ -8905,11 +8983,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 				 * not update the file's metadata with the client's
 				 * modified size
 				 */
-				attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
-				attrs.ia_valid = ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
-				inode_lock(inode);
-				err = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
-				inode_unlock(inode);
+				err = cb_getattr_update_times(dentry, dp);
 				if (err) {
 					nfs4_put_stid(&dp->dl_stid);
 					return nfserrno(err);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8266f910d847..c79f7402bc30 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3411,6 +3411,7 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS)	| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
 
 #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index c98fb104ba7d..2d89b82e5453 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -421,7 +421,8 @@ enum {
  | FATTR4_WORD1_TIME_DELTA      | FATTR4_WORD1_TIME_METADATA   | FATTR4_WORD1_TIME_CREATE      \
  | FATTR4_WORD1_TIME_MODIFY     | FATTR4_WORD1_TIME_MODIFY_SET | FATTR4_WORD1_MOUNTED_ON_FILEID)
 
-#define NFSD4_SUPPORTED_ATTRS_WORD2 0
+#define NFSD4_SUPPORTED_ATTRS_WORD2 (FATTR4_WORD2_TIME_DELEG_MODIFY | \
+				     FATTR4_WORD2_TIME_DELEG_ACCESS)
 
 /* 4.1 */
 #ifdef CONFIG_NFSD_PNFS
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 65691457d9ba..b2ffb7d36721 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -141,6 +141,8 @@ struct nfs4_cb_fattr {
 	/* from CB_GETATTR reply */
 	u64 ncf_cb_change;
 	u64 ncf_cb_fsize;
+	struct timespec64 ncf_cb_mtime;
+	struct timespec64 ncf_cb_atime;
 
 	unsigned long ncf_cb_flags;
 	bool ncf_file_modified;
@@ -184,6 +186,7 @@ struct nfs4_delegation {
 	int			dl_retries;
 	struct nfsd4_callback	dl_recall;
 	bool			dl_recalled;
+	bool			dl_deleg_ts;
 
 	/* for CB_GETATTR */
 	struct nfs4_cb_fattr    dl_cb_fattr;
diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
index e8b00309c449..f1a315cd31b7 100644
--- a/fs/nfsd/xdr4cb.h
+++ b/fs/nfsd/xdr4cb.h
@@ -59,16 +59,20 @@
  * 1: CB_GETATTR opcode (32-bit)
  * N: file_handle
  * 1: number of entry in attribute array (32-bit)
- * 1: entry 0 in attribute array (32-bit)
+ * 3: entry 0-2 in attribute array (32-bit * 3)
  */
 #define NFS4_enc_cb_getattr_sz		(cb_compound_enc_hdr_sz +       \
 					cb_sequence_enc_sz +            \
-					1 + enc_nfs4_fh_sz + 1 + 1)
+					1 + enc_nfs4_fh_sz + 1 + 3)
 /*
  * 4: fattr_bitmap_maxsz
  * 1: attribute array len
  * 2: change attr (64-bit)
  * 2: size (64-bit)
+ * 2: atime.seconds (64-bit)
+ * 1: atime.nanoseconds (32-bit)
+ * 2: mtime.seconds (64-bit)
+ * 1: mtime.nanoseconds (32-bit)
  */
 #define NFS4_dec_cb_getattr_sz		(cb_compound_dec_hdr_sz  +      \
-			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + op_dec_sz)
+			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + 2 + 1 + 2 + 1 + op_dec_sz)

-- 
2.46.0


