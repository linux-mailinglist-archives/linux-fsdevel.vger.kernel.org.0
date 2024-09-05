Return-Path: <linux-fsdevel+bounces-28735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8A296D916
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE641C257D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEC81A070E;
	Thu,  5 Sep 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7+fIonL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D551A0739;
	Thu,  5 Sep 2024 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540134; cv=none; b=bzSAjQb/aADf6UH1bybU4+bdbElkOSh0snciHfdVnApJnk6FqfY4ep82bF2R7VqA+XAsUfFkHXk8jrCxT4A0w+8YQ6lEBQIJZQ1wlTa3ZyyVI5kSeM1KHZe6Wm98HUuvi+wsoAtyBrdK2q/JXA5UYT0FaKWVS2CzeY9rd7U8rWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540134; c=relaxed/simple;
	bh=pSj04UkQR35Y15vtLG/RjdqEiyJ2ZENZlNjDssJYmtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rj+X1RFqhh7egOshJ6zWB4CrQzCoGuA/zLd6/GDuPNu5B3PXR3q+HfO5EB/jcLS+kmRnx6jcRUUeOb1O78LK7vQWy6ZEoOFapMUXjR66K1xU7m2wCQbsaEjNz6kV4xUeoDdxKPBH+UFQizlbhMRHCBa0Dvb9iOhA7gQG82N6xDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7+fIonL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152ABC4CECB;
	Thu,  5 Sep 2024 12:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725540134;
	bh=pSj04UkQR35Y15vtLG/RjdqEiyJ2ZENZlNjDssJYmtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e7+fIonLCUXYSYDhpcuUCzF8yAwC06H4zgrlU/GlhKyBSd/vRGyHrC4PkzdsLAXgA
	 Ncdtc01NnIfVkYUN2erFRQAiwsym583vPMp0KIGWJ9RCLfckMzKu7Ktm9AU9eKn0Zk
	 BNU7YDlRiJ3fLlBKzDG9mMRaEXncu2o/kpwvdMf9Y4dVryM1iZrbTHuZcmkWgtjlPF
	 oYyudQUCg7qPe0ksVsI1aSzeJkSH7AVuU+YnlsAHoviDPDY/2OHfQehdrQq3FWGaiY
	 8TM7a8woq1E1gIlKV0OFNsGi7CUEGDqSRUa6pCdQlbm18z/v91MCbxVYYpBwxhsgJ4
	 wjMruorKif4xQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Sep 2024 08:41:54 -0400
Subject: [PATCH v4 10/11] nfsd: add support for delegated timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-delstid-v4-10-d3e5fd34d107@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12142; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pSj04UkQR35Y15vtLG/RjdqEiyJ2ZENZlNjDssJYmtU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm2acVgmIkuzCrqS+ua3otfUtKFJQH1BBy1wfXI
 mfi2Yh8F7WJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtmnFQAKCRAADmhBGVaC
 FUuDEACnm5mBpV4jP1Hq+Ej5by32s+mt1KsFZGgS3LBqf2bk3dcZuYxhPvrr3ts2A3RnXl6Bj5r
 Op3I9GoSuulgRbalN//5R7SFkX0cU63fTghCv/6lDPotiMFLrtR5cJbG/03VXjsQD1GVkRxaH7n
 uzlvUrY3V3iJkrzPgEeyxtWsYXeju97dnvWQiSqlqurPXO/XZCslhBG66XENF+VkpOU5VGRbdwM
 FFdzwmQS1ktGuOMOidPEc/mrjfFBY9qcCWkeBSTtF/fjeM8U1OUXoc1UmFMWSPq8m/gd3AeVI8w
 fEJ810Xug6eXdlx/Y4P199N9s4GRipKwdNX0DvjL2c9RSinvvrr4mEl4aiE8NJ6lXFfzWUK7x/D
 sjtizfImZ7Ybi5yWb6e5zwE1mngHd6izMnnpX87tFEKgkZu9igoZDKr5iNhmrNiS7iR6q7LMA3R
 WhLabBIVemgwzZd5Mfn+qUl2CKg6ZM2q9tV/0zNXZHqOW3fexRza4GgSLJZap1qciDB/nmfuEc0
 i13TKE45q/wBkhF/RlqeqqHzIugdYRp7XntgGF91HmsODNg+trTDla4S0+T7u3OnUD0iy2NS7b0
 WQm8hGvGKv/t/ZHxlZ8wJr4s4uRBV01Ib/zPM+sR9C0AG22ew0KYfictgqY0xeagH+un2p6u+xO
 NtnPd7HTryfSFeA==
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 42 +++++++++++++++++++++++---
 fs/nfsd/nfs4state.c    | 81 ++++++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c      | 15 ++++++++--
 fs/nfsd/nfsd.h         |  2 ++
 fs/nfsd/state.h        |  3 ++
 fs/nfsd/xdr4cb.h       | 10 +++++--
 include/linux/time64.h |  5 ++++
 7 files changed, 143 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index f88d4cfe9b38..43b8320c8255 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -42,6 +42,7 @@
 #include "trace.h"
 #include "xdr4cb.h"
 #include "xdr4.h"
+#include "nfs4xdr_gen.h"
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
 
@@ -93,12 +94,35 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
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
 
@@ -364,14 +388,20 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
 	struct nfs4_delegation *dp = container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
 	struct knfsd_fh *fh = &dp->dl_stid.sc_file->fi_fhandle;
 	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
-	u32 bmap[1];
+	u32 bmap_size = 1;
+	u32 bmap[3];
 
 	bmap[0] = FATTR4_WORD0_SIZE;
 	if (!ncf->ncf_file_modified)
 		bmap[0] |= FATTR4_WORD0_CHANGE;
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
 
@@ -596,7 +626,7 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
 	struct nfs4_cb_compound_hdr hdr;
 	int status;
 	u32 bitmap[3] = {0};
-	u32 attrlen;
+	u32 attrlen, maxlen;
 	struct nfs4_cb_fattr *ncf =
 		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
 
@@ -615,7 +645,11 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
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
index 40e0c9b0ef71..5e1d25624961 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6002,6 +6002,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
+	if (open->op_deleg_want & NFS4_SHARE_WANT_DELEG_TIMESTAMPS)
+		dp->dl_deleg_ts = true;
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
 		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
 			nfs4_put_stid(&dp->dl_stid);
@@ -8844,6 +8846,78 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
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
+	struct inode *inode = d_inode(dentry);
+	struct timespec64 now = current_time(inode);
+	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
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
+			attrs.ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET;
+			attrs.ia_ctime = attrs.ia_mtime;
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
@@ -8870,7 +8944,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	struct file_lock_context *ctx;
 	struct nfs4_delegation *dp = NULL;
 	struct file_lease *fl;
-	struct iattr attrs;
 	struct nfs4_cb_fattr *ncf;
 	struct inode *inode = d_inode(dentry);
 
@@ -8932,11 +9005,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 		 * not update the file's metadata with the client's
 		 * modified size
 		 */
-		attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
-		attrs.ia_valid = ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
-		inode_lock(inode);
-		err = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
-		inode_unlock(inode);
+		err = cb_getattr_update_times(dentry, dp);
 		if (err) {
 			status = nfserrno(err);
 			goto out_status;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 08d9421cd90e..b11d75f483de 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3411,6 +3411,7 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS)	| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
 
 #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
@@ -3604,7 +3605,11 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		if (status)
 			goto out;
 	}
-	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
+	if ((attrmask[0] & (FATTR4_WORD0_CHANGE |
+			    FATTR4_WORD0_SIZE)) ||
+	    (attrmask[1] & (FATTR4_WORD1_TIME_ACCESS |
+			    FATTR4_WORD1_TIME_MODIFY |
+			    FATTR4_WORD1_TIME_METADATA))) {
 		status = nfsd4_deleg_getattr_conflict(rqstp, dentry, &dp);
 		if (status)
 			goto out;
@@ -3616,8 +3621,14 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	if (dp) {
 		struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
 
-		if (ncf->ncf_file_modified)
+		if (ncf->ncf_file_modified) {
 			args.stat.size = ncf->ncf_cur_fsize;
+			if (!timespec64_is_epoch(&ncf->ncf_cb_mtime))
+				args.stat.mtime = ncf->ncf_cb_mtime;
+		}
+
+		if (!timespec64_is_epoch(&ncf->ncf_cb_atime))
+			args.stat.atime = ncf->ncf_cb_atime;
 
 		nfs4_put_stid(&dp->dl_stid);
 	}
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index c98fb104ba7d..18b8d383f73a 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -455,6 +455,8 @@ enum {
 	FATTR4_WORD2_MODE_UMASK | \
 	NFSD4_2_SECURITY_ATTRS | \
 	FATTR4_WORD2_XATTR_SUPPORT | \
+	FATTR4_WORD2_TIME_DELEG_ACCESS | \
+	FATTR4_WORD2_TIME_DELEG_MODIFY | \
 	FATTR4_WORD2_OPEN_ARGUMENTS)
 
 extern const u32 nfsd_suppattrs[3][3];
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index c7c7ec21e510..874fcab2b183 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -142,6 +142,8 @@ struct nfs4_cb_fattr {
 	/* from CB_GETATTR reply */
 	u64 ncf_cb_change;
 	u64 ncf_cb_fsize;
+	struct timespec64 ncf_cb_mtime;
+	struct timespec64 ncf_cb_atime;
 
 	unsigned long ncf_cb_flags;
 	bool ncf_file_modified;
@@ -185,6 +187,7 @@ struct nfs4_delegation {
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
diff --git a/include/linux/time64.h b/include/linux/time64.h
index f1bcea8c124a..9934331c7b86 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -49,6 +49,11 @@ static inline int timespec64_equal(const struct timespec64 *a,
 	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
 }
 
+static inline bool timespec64_is_epoch(const struct timespec64 *ts)
+{
+	return ts->tv_sec == 0 && ts->tv_nsec == 0;
+}
+
 /*
  * lhs < rhs:  return <0
  * lhs == rhs: return 0

-- 
2.46.0


