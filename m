Return-Path: <linux-fsdevel+bounces-30990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836989903DB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A337F1C21C82
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC02C217909;
	Fri,  4 Oct 2024 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOJ0wuYw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C981216A31;
	Fri,  4 Oct 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047902; cv=none; b=uj81iSBzcvpXzQmx08jxWYJBZs2gw1fDA2dcQTNN2TUpjLAdIxjaP19xuul7u+7RoZ2alOTb0bYs2ma75hFlunklUY+5YzYBZoESi0ELTfvi84mhKB0bNsbhhhak01GKXp2hVa9j5+AmdgPShoMvvMlHeGxqcW1BWGpG1TK2qOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047902; c=relaxed/simple;
	bh=idYW2JQck3N1v1eUkrY8KA4zGPHRRQmY2wTqAK8T0iI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fCTBnY6pqrTqknx+NbEr+vKAvcxFJ8qCVsdF6pF1OayIVUOuCNdksvhtb14iFL0HpBmHz85VXO4Y6CKqk2p0+hjwFXW02A6xAcrTXMz+Ej92cHVHyfY5NoZoAIgCYzi0XgqkKR1pwkYd1deHo7Y/T0665WEmUD5XE3SsOA0UNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOJ0wuYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367FBC4CECF;
	Fri,  4 Oct 2024 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047901;
	bh=idYW2JQck3N1v1eUkrY8KA4zGPHRRQmY2wTqAK8T0iI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YOJ0wuYwgAfnfPz1CAmO8Gl01/eLJmhVoyG6DWFL+1LzRM6ovrbJ1sCr4kbEqQO+G
	 axNshxOgcGh3Vw0SqtiRfx1rZ4A606FlIeOl2se67rAyW41obyU+xKzrCVro3TZXUG
	 5WCnIxCojdRbCf3HEIoJjzpV3viE7VSYKhHbqke8YeM6VPpC4hP/DMHYhw6gB5Eb/O
	 T2x7IQck9CrSGbf8++DogJUnXjuuqX3MNoW4XN9JZMtmgQMXHtFr7izAhwNaF61q1C
	 PUMOa+5bKpfKrMwr14GrAJAuZjRhJH6XnQJ2O5CkaxlWZ7OiWRiz7bHirv5mmQV0/y
	 nWAlt8qM0L1yA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 04 Oct 2024 09:16:51 -0400
Subject: [PATCH v4 8/9] nfsd: add support for delegated timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-delstid-v4-8-62ac29c49c2e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12598; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=idYW2JQck3N1v1eUkrY8KA4zGPHRRQmY2wTqAK8T0iI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/+sO6iJW0VxEbWj5DI1ZeQtM5zeWZCImufIu0
 3Tm1+S17zGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv/rDgAKCRAADmhBGVaC
 FUb+EACKhw2kXSkiB9IcxFRd9Y+8Y7Oj7xDJTzQWD5OmNaRQtBj4a5C0qlYzUCS9Viv8pMjxY6h
 KhDrMnf3dGn/+rJEKbxf9elQnd8RbI3k1pTAnD77UQJ7QWWkyO3ebV+FkxWjYHSKAuwNxtJpWHt
 ah4VNNCHV5QaJDxeYKPiOjBUeeUzU3RHAm1MetX9u3uQtfS4OZeVlP0OoTHfpZ+hmHknaDPurDt
 lEFiIljR3heIbNpZGK922HnTzC32EgObZCPYEaXgusaRrD5jhEh4pb2FCc6pNQDblU/vfEfVHwO
 vlFCvj9xy/VhrNy6HCnYh9+biTZkT8H9Zgo2oKLsMu8gZl3fOZxYbHqlV8R23K7AXnl2VekSJ0u
 SI6Z7ubVZRMUXTRL6ZNZcrKnpEHgkfOTAAtQgcphk9F8AY1cKNlDRr7FCUWDUMRW2ZUOeQ46Tcc
 6jrHjO5pvJCIVGDjkcH3FzN+WnjSmbm+aoeUUy0tbtjqWsKcSMXOLPmTgPmLxMJwKHBu1epxRtV
 Efg7w7YLnSh35mbwjuFSKP/jtTuHExpa2lMxPOj41pZVfn0T1gdYjjT9l1y5W3Sm9cgb/hAu++T
 r3uwCGIPVzb/ZbUEpMqLdLe0jNHAui5b+zFd0Abt3IFQEtkyb6PONRhF+K+zP/Q37HdbFbZ6cjv
 YQeZrUtB8M+5SwA==
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
 fs/nfsd/nfs4xdr.c      | 13 +++++++-
 fs/nfsd/nfsd.h         |  2 ++
 fs/nfsd/state.h        |  3 ++
 fs/nfsd/xdr4cb.h       | 10 +++++--
 include/linux/time64.h |  5 ++++
 7 files changed, 142 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 776838bb83e6b707a4df76326cdc68f32daf1755..d86a7b98378549b6c8dbcb6c937dd109d6f50b34 100644
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
 
@@ -364,15 +388,21 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
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
 
@@ -597,7 +627,7 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
 	struct nfs4_cb_compound_hdr hdr;
 	int status;
 	u32 bitmap[3] = {0};
-	u32 attrlen;
+	u32 attrlen, maxlen;
 	struct nfs4_cb_fattr *ncf =
 		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
 
@@ -616,7 +646,11 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
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
index a9eb7cf9fd7e74a648170c60bf031fdc32533dd3..de6d8cfc975726be2cf3e80678d587e62ed61d76 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6005,6 +6005,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
+	if (open->op_deleg_want & NFS4_SHARE_WANT_DELEG_TIMESTAMPS)
+		dp->dl_deleg_ts = true;
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
 		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
 			nfs4_put_stid(&dp->dl_stid);
@@ -8852,6 +8854,78 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
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
@@ -8878,7 +8952,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	struct file_lock_context *ctx;
 	struct nfs4_delegation *dp = NULL;
 	struct file_lease *fl;
-	struct iattr attrs;
 	struct nfs4_cb_fattr *ncf;
 	struct inode *inode = d_inode(dentry);
 
@@ -8940,11 +9013,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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
index dad6875aa17eb99759cdbacb814b7988848a961b..6241e93e9e13410b4fa926c0992127b1cc757b5e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3409,6 +3409,7 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS)	| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
 
 #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
@@ -3602,7 +3603,11 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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
@@ -3617,8 +3622,14 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		if (ncf->ncf_file_modified) {
 			++ncf->ncf_initial_cinfo;
 			args.stat.size = ncf->ncf_cur_fsize;
+			if (!timespec64_is_epoch(&ncf->ncf_cb_mtime))
+				args.stat.mtime = ncf->ncf_cb_mtime;
 		}
 		args.change_attr = ncf->ncf_initial_cinfo;
+
+		if (!timespec64_is_epoch(&ncf->ncf_cb_atime))
+			args.stat.atime = ncf->ncf_cb_atime;
+
 		nfs4_put_stid(&dp->dl_stid);
 	} else {
 		args.change_attr = nfsd4_change_attribute(&args.stat, d_inode(dentry));
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1955c8e9c4c793728fa75dd136cadc735245483f..004415651295891b3440f52a4c986e3a668a48cb 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -459,6 +459,8 @@ enum {
 	FATTR4_WORD2_MODE_UMASK | \
 	NFSD4_2_SECURITY_ATTRS | \
 	FATTR4_WORD2_XATTR_SUPPORT | \
+	FATTR4_WORD2_TIME_DELEG_ACCESS | \
+	FATTR4_WORD2_TIME_DELEG_MODIFY | \
 	FATTR4_WORD2_OPEN_ARGUMENTS)
 
 extern const u32 nfsd_suppattrs[3][3];
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index c7c7ec21e5104761221bd78b31110d902df1dc9b..874fcab2b18381a442b651c3d6eb3742f501b4a5 100644
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
index e8b00309c449fe2667f7d48cda88ec0cff924f93..f1a315cd31b74f73f1d52702ae7b5c93d51ddf82 100644
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
index f1bcea8c124a361b6c1e3c98ef915840c22a8413..9934331c7b86b7fb981c7aec0494ac2f5e72977e 100644
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
2.46.2


