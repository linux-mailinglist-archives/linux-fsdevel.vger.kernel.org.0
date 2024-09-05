Return-Path: <linux-fsdevel+bounces-28730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0732796D901
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA2D1C25447
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35CE19F410;
	Thu,  5 Sep 2024 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mhyvkmqn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0901019EEC2;
	Thu,  5 Sep 2024 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540127; cv=none; b=FKldkn2WWqv9vBMShg8vYlGRC4dlRidjU6ji8LTHE/vf0uRo3GrUki+gD+TzNvedAr8tqdgKEXNkjtMpWgrOcdCq4GDhzVI4GpFaQko0IQdWsCL12LZpXH5LXRwWu28k/33upcNvmPztDTnaSoBWerdoOG7VOu3DxRwbLzZonCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540127; c=relaxed/simple;
	bh=/O5QB/qKD1kg5ilzN/rliLPoIbBIkPfWn/BsccJGI4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkq1yaSgNv7noo3CCTiTr1lpyGHzzqUIUPJ9Sm0vIYDfZtqzYbrV4xnqHLzZ3ZVF3mfpSyJYi+qSgADd6hQ3AqxTd1xdNP40Aa/NDQBfLbDyzgoC2ANody1MO7K9YUFvb3vuZcnkVx8KosR+YwHsy5NoHlpyGmip9Kt/CrNsucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mhyvkmqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5680C4CECB;
	Thu,  5 Sep 2024 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725540126;
	bh=/O5QB/qKD1kg5ilzN/rliLPoIbBIkPfWn/BsccJGI4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mhyvkmqn7Glxo9KX63xv8iKn0A0j6VodC1Zmvrha8D8EhAsYAX43/jVguI87NIqQR
	 ZZU3jADDb8WyFKHkwTuYN/Iwj/BHiU+b7n8tu1KAEhjHUaReKNA0DNOLuoDcbuF+Ta
	 8ocDlDbaeDrEVZ3ije5Q0Vs1lK1dPOg2LmujOqxJufT10AbgyEITC2GYp0ynBm4ebl
	 oo+1gxTPa8tSx+J9NshNhE6eOodo4oKYRSE5AuvicuCzkXNksN3zMY1KT6eFuvebEc
	 xEKs5ly+PVPIMYLvIjKggGUfUW8SenGWwXVtbXm2iohmknH2ALOgsWhAVeWcDjR3Iy
	 8IBhPu3Sr2tFA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Sep 2024 08:41:49 -0400
Subject: [PATCH v4 05/11] nfsd: have nfsd4_deleg_getattr_conflict pass back
 write deleg pointer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-delstid-v4-5-d3e5fd34d107@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4705; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/O5QB/qKD1kg5ilzN/rliLPoIbBIkPfWn/BsccJGI4o=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm2acV/irklEo/q5s+mOVAr99WpMXX08w49oWDO
 hMr3iKXLl+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtmnFQAKCRAADmhBGVaC
 FXwGD/48hcUQ3Uz1yXQDX/x+plH0OttYpdm/7Oq/Wqb40r1GlSrSNUPrY2x4fxWzpiOZP8EZ8qb
 gBxt+ESXPEAT7kE7vMSRFDSXiYq3Asaz6RB4yDPQv9uwFxX0QIgR2ofcGqKCxfkgmGMhObVcg7A
 uaDtjdR4NDn4rBpXBOibU212tAimZe+ymMgwiKHhuT5RQG1P640GDAGHO6fdd0cSqXVf7i3Kz3P
 sz/SNpcW/0U+brFaNNXeeKEyZGh9OHS6rnp9Nrl6wgOpRbQfjhuq/+e14ioTMemNIPpi/OXOVUq
 Oz0r/TqR1JazcqNBoIZCh7P1I09nz9Yz20egD3RtdKpGPdqJLuUPjy656od1k3CIEvGu0vSEQo0
 7vVShUhokTcYjrmvUddNRFSH1uuE4NLczNRGki9r5h0k5MKSXfwCqfIz4ZIFj2PKscGItBw6lKv
 ANPmC78JRnZdy8xm4t29x18OvLqmboNNs9MzCFhpDAUxnBgg0r0oH/2es6x2ZoEjKa9lGX71Urx
 +pmiWFu9Q6uh6n45Aho2SpW1Y5ZRWrz7OVRfA8lZSJZp6jlChtm5/VRACbLIzAxxUt56RenLCVC
 bTuSVX5DoT1Z0YV0pVM9uHkzTwNuej9GMZgKliMXfqllsvSWnvpXl1nxRPoINdZWft2/Mvqers8
 JqXhQdUq3u7BD0Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently we pass back the size and whether it has been modified, but
those just mirror values tracked inside the delegation. In a later
patch, we'll need to get at the timestamps in the delegation too, so
just pass back a reference to the write delegation, and use that to
properly override values in the iattr.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 17 ++++++++---------
 fs/nfsd/nfs4xdr.c   | 16 ++++++++++------
 fs/nfsd/state.h     |  2 +-
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 63b7d271cc4a..8851fc69f5c6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8828,8 +8828,7 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
  * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
  * @rqstp: RPC transaction context
  * @dentry: dentry of inode to be checked for a conflict
- * @modified: return true if file was modified
- * @size: new size of file if modified is true
+ * @pdp: returned WRITE delegation, if one was found
  *
  * This function is called when there is a conflict between a write
  * delegation and a change/size GETATTR from another client. The server
@@ -8839,11 +8838,12 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
  * 18.7.4.
  *
  * Returns 0 if there is no conflict; otherwise an nfs_stat
- * code is returned.
+ * code is returned. If @pdp is set to a non-NULL value, then the
+ * caller must put the reference.
  */
 __be32
 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
-				bool *modified, u64 *size)
+			     struct nfs4_delegation **pdp)
 {
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
@@ -8854,10 +8854,9 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	struct nfs4_cb_fattr *ncf;
 	struct inode *inode = d_inode(dentry);
 
-	*modified = false;
 	ctx = locks_inode_context(inode);
 	if (!ctx)
-		return 0;
+		return nfs_ok;
 
 #define NON_NFSD_LEASE ((void *)1)
 
@@ -8923,10 +8922,10 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 			goto out_status;
 		}
 		ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
-		*size = ncf->ncf_cur_fsize;
-		*modified = true;
+		*pdp = dp;
+		return nfs_ok;
 	}
-	status = 0;
+	status = nfs_ok;
 out_status:
 	nfs4_put_stid(&dp->dl_stid);
 	return status;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d028daf77549..ccaee73de72b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3511,6 +3511,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		    int ignore_crossmnt)
 {
 	DECLARE_BITMAP(attr_bitmap, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
+	struct nfs4_delegation *dp = NULL;
 	struct nfsd4_fattr_args args;
 	struct svc_fh *tempfh = NULL;
 	int starting_len = xdr->buf->len;
@@ -3525,8 +3526,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		.dentry	= dentry,
 	};
 	unsigned long bit;
-	bool file_modified = false;
-	u64 size = 0;
 
 	WARN_ON_ONCE(bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1);
 	WARN_ON_ONCE(!nfsd_attrs_supported(minorversion, bmval));
@@ -3555,8 +3554,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 			goto out;
 	}
 	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
-		status = nfsd4_deleg_getattr_conflict(rqstp, dentry,
-					&file_modified, &size);
+		status = nfsd4_deleg_getattr_conflict(rqstp, dentry, &dp);
 		if (status)
 			goto out;
 	}
@@ -3564,10 +3562,16 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	err = vfs_getattr(&path, &args.stat,
 			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
 			  AT_STATX_SYNC_AS_STAT);
+	if (dp) {
+		struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
+
+		if (ncf->ncf_file_modified)
+			args.stat.size = ncf->ncf_cur_fsize;
+
+		nfs4_put_stid(&dp->dl_stid);
+	}
 	if (err)
 		goto out_nfserr;
-	if (file_modified)
-		args.stat.size = size;
 
 	if (!(args.stat.result_mask & STATX_BTIME))
 		/* underlying FS does not offer btime so we can't share it */
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ac3a29224806..c7c7ec21e510 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -781,5 +781,5 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 }
 
 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
-		struct dentry *dentry, bool *file_modified, u64 *size);
+		struct dentry *dentry, struct nfs4_delegation **pdp);
 #endif   /* NFSD4_STATE_H */

-- 
2.46.0


