Return-Path: <linux-fsdevel+bounces-27843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C79B964698
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7A51C2135E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466131B4C58;
	Thu, 29 Aug 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFA/vFJ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC41B4C3C;
	Thu, 29 Aug 2024 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938030; cv=none; b=PrID5VerKUvjA/4T/vCSon/tIdtwJcjngbkXVA513x4OEI09/5MqQ0u+8V4y8ph1QcZLF6lOebkVCaN7eRlPKJDVq8Jlui+cNLUELwL6i1k1K/IkyXztg/PcV4lTqzGSPjPhbEHmrlJ0IGdH8jORUvBLCCqrTZuhmp6hbYBJzog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938030; c=relaxed/simple;
	bh=q4G/KFRqS/1IAOt8tP8YVw4o6RDhY+bh95uMblQQo1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULerjC/mulOEzQKCHiVmw72dgpX7UJ+812Fna1+HHr53zSYbYJc8ZF8ySByL+2PJISgCT0VOownZY3O9ArXAmCnYO/sfNodRzmY1Yx/bTDNkwjFyfUqWR2Hb/bCck1T2bRgDvR0aYxd45GmNwDePLfI5MT4eB/MxI+RYSPVh9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFA/vFJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4F4C4CECB;
	Thu, 29 Aug 2024 13:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938030;
	bh=q4G/KFRqS/1IAOt8tP8YVw4o6RDhY+bh95uMblQQo1E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mFA/vFJ9X1KCmf12CO52g+a4quwtam1fBoWQowvMjG6x936eZqC0z2DYRbTDKnWk2
	 uJMwfmzhQfbYmab//clt5Hz8/DLDjN5ySSwiMHihKdRaWTfgYmw1fLU+VRirF65lXJ
	 58u0ZNh0O+AzfXHwJBIPBL5yvemEmUzSRQfO20cFjBs8tdof/x7fGccnKYo9XPrcIK
	 OCASg73a21iiIMYuFqg3v0zQmj1xdVT28UEquLbiryuCZ65P6FsRkIVTaBCAR/jSCq
	 l2RWV9DtH+35ezqCdOE/V5TB/W9zHQoRK3nWcxe0AHj8Js7CTUtdVXvXyCYC2N5wUY
	 e9XBKcGvtEnBQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Aug 2024 09:26:50 -0400
Subject: [PATCH v3 12/13] nfsd: add support for delegated timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-delstid-v3-12-271c60806c5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11916; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=q4G/KFRqS/1IAOt8tP8YVw4o6RDhY+bh95uMblQQo1E=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm0HcYKTYq7xyI/pCXxoXquNcssfniGOMteYyVb
 URTsumMxweJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtB3GAAKCRAADmhBGVaC
 FcrUD/9no7zvcsTLlfUrshMnKHaSBLInAPOe183W1sujhKpzs/cwH4o/JSn0UWChsxHb1KwF0bU
 dC1GQ4Jd/06OM19ejqTKKT+kY1n7wu4Q45odKoFBavEkQL4QChwmmW3oIitu8feLqCG+jdS3+05
 5xy4PLqAI4BuwQgagBkaAY4V7KvBZk5GgK9A7Wre+xmc6A5qZ6sryP/Up82uCTkSuma4tRXzldj
 G/3wnQW51cIfobY1yiQ2WW1zM/Aj8RYXCrBgou8G/2Pbt1wx7UfAzllPe0LHyC6JRUyJbhstlSk
 8DScnlUWQ5jDHEjx01Ri5ope/LCfgq9eFRWxbLGvCro5EHPCpflDAvl29Sgvnj2pW5SqgWF/l2B
 li+opJd49o/XGIbsZ5PpO7aIkEgWpEAjH+TrQhoniKocpBkxuOYVUCDa6YYK1Wxtkz75NUYGpZ9
 nlx1eFNi+3kAfp+/An1O9Oaz0IRaMTMDcRred0j+1WvDU6dzmooAatHLNlzHKfk7wOJF7ar+aPq
 f6/nmMQjIHPe1WYQCJsrtzppvRnj/c2Wp8fsCR4WTJPxSmv0pcm4Yk4t0TzVf7RwIwR3SzHlYma
 MWSoY4WWCrumJgRff782xThDEXKL8hlmFYZn79Dg0NK7eSsX5Z+kaT2TohgUW5vgAvdqzBGupHW
 UMwvuzdUmj+nhbg==
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
 fs/nfsd/nfs4callback.c | 42 ++++++++++++++++++++++----
 fs/nfsd/nfs4state.c    | 81 ++++++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c      | 13 +++++++-
 fs/nfsd/nfsd.h         |  2 ++
 fs/nfsd/state.h        |  3 ++
 fs/nfsd/xdr4cb.h       | 10 +++++--
 include/linux/time64.h |  5 ++++
 7 files changed, 141 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 0c49e31d4350..11bf7439a253 100644
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
index c4e76427af92..06dff11c3e51 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5982,6 +5982,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
+	if (open->op_deleg_want & NFS4_SHARE_WANT_DELEG_TIMESTAMPS)
+		dp->dl_deleg_ts = true;
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
 		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
@@ -8826,6 +8828,78 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
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
@@ -8852,7 +8926,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	struct file_lock_context *ctx;
 	struct nfs4_delegation *dp = NULL;
 	struct file_lease *fl;
-	struct iattr attrs;
 	struct nfs4_cb_fattr *ncf;
 	struct inode *inode = d_inode(dentry);
 
@@ -8914,11 +8987,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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
index 11c6079e7dea..557f4c8767ff 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3408,6 +3408,7 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS)	| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
 
 #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
@@ -3601,7 +3602,11 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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
@@ -3619,7 +3624,13 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 			/* If there have been no changes, report the initial cinfo + 1 */
 			if (args.change_attr == ncf->ncf_initial_cinfo)
 				args.change_attr = ncf->ncf_initial_cinfo + 1;
+			if (!timespec64_is_epoch(&ncf->ncf_cb_mtime))
+				args.stat.mtime = ncf->ncf_cb_mtime;
 		}
+
+		if (!timespec64_is_epoch(&ncf->ncf_cb_atime))
+			args.stat.atime = ncf->ncf_cb_atime;
+
 		nfs4_put_stid(&dp->dl_stid);
 	}
 	if (err)
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


