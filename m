Return-Path: <linux-fsdevel+bounces-30985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D979903C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8121F2826CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285BA2141A5;
	Fri,  4 Oct 2024 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4ElXL6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED12139CB;
	Fri,  4 Oct 2024 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047893; cv=none; b=F8hGUW/0Rtdqg7p/FHMN24ibJ6hziKoj8cGA5ftWbkZoudBaFLEMFoBoWb3KZeHzW560Ut5/cG8KZDKG0k+lZ7o7GF/f4DpipUQDHrJ2aw4tEj8OtUI0hoDByQopKx88p+Tf6Rd56ob49xUtGZd1JBOagIozWA95vLV3h0noJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047893; c=relaxed/simple;
	bh=wdyYzZq0+G9ux3/rTIfsXgQJrGKaLW5LmDc1q+J42rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EA4bhU4gX+xWcOGZzxGXrWao35DCgzO8a3e2wNZitl5WihiwLGouJsQsssp24++iwPjQ6IVrheCTxDb/gA1hH7+wajljlR/sRf5H9T/4Y7vc17kSVZyt49CC1j2aCnag7pF172Q3cXTs32rkbg46P/EMRRTzajT9ZJnvA1zFsrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4ElXL6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1076C4CECF;
	Fri,  4 Oct 2024 13:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047893;
	bh=wdyYzZq0+G9ux3/rTIfsXgQJrGKaLW5LmDc1q+J42rc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O4ElXL6zhPGPLtMH/7UytZRdX/vhodfBlLVvvA5lT3NAjBVquML/uHW8nsCKz/wqc
	 irlv38n413ws8sQmqtngGEwxtviLMQchb3CQTovbJqhChOoCdYXDpuHOz9nDbL0f+X
	 amnRIkBldgjwFsmWDeyGr2pq3gO3GinLsHombSZhSSW9iALpsrWeDD08/rfbMQ2RD5
	 DrMtbfMjUTlP46kurCrHOBWB6yBYGvxPGqU/2P54uFdc2+gwnt7ix+lUYYUk8BJRqe
	 UlTrH868U8weZ/QoVuq9OfYLH/4cJwd9XkMf9AvJGFEr6fb+ziy8tfTsX6gozR2pW4
	 PwCqE0gzwWWIg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 04 Oct 2024 09:16:46 -0400
Subject: [PATCH v4 3/9] nfsd: have nfsd4_deleg_getattr_conflict pass back
 write deleg pointer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-delstid-v4-3-62ac29c49c2e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4873; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=wdyYzZq0+G9ux3/rTIfsXgQJrGKaLW5LmDc1q+J42rc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/+sNw3fB1vxMaL4GxIKXO2DXC7BVNXG2Y5bD5
 nQIHhxNROmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv/rDQAKCRAADmhBGVaC
 FSTKD/421tVlQzGBDN4CZ5TMFPBHb6Fc1aDfaux1BSHaqcTJja0Q6ptEJSMXJVcXBDdHH2uQg2P
 4J8SM6VzeFwbmYXiuAhBIvLkCv0ytT07DFUBXR+cHrzWWBgtYG+j6ODS5to/CENMEVkg3N0lTHH
 IdOEJ+JpZxPyH6mTNRdL2QY55UM7heS4XY3XP6eUpiPu/8epgxqFnf/CAoZ7Qsu/nYxTxYyRzd1
 7QlpSUG/Si7OYT5VZm6xexQOc9ldHolPDIpo4dTGJVXfcJv4hvv8oErZ/YW0AqraeZFLNIDXbOO
 m1PtEQ/uGwi8oxicHv92epcrDpwYh1GbebL3FH6df3pT5ULgh4MrdqLoCAFOzrYA81NcO0Tge06
 ecFG6Sd5GqwS78ENkegPAVtVm/GmB7o3enmPijPDIypWprvT3DtEgk46bBVTite1/AD/pP8ZB7I
 hi3JUCquT9U2DKQutP4PzqYRBV3peuMDGphug7f60LEvie9tmHtp/wTkhcwWoOe5zuxDoycs9zg
 teGXCjKvN5mp+X62qt78IS63WF68jIDkXjFMh/34vUd9+owsaxZ7x55721tzbdyPXpUGxXuSeWt
 x83iINHSiVWKtvB5fPtuvtup27JEvy8ZY7ql0jX/yvUd0DjNSSaFdz0+I9QVwnjNRj6Rro8Iozs
 4T1mDIESSf78AZQ==
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
index 1cb09daa7dc2033af37e4e5b2c6d500217d67cf3..ecf02badf598d147feb5133cb43225e3611d6d8e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8831,8 +8831,7 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
  * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
  * @rqstp: RPC transaction context
  * @dentry: dentry of inode to be checked for a conflict
- * @modified: return true if file was modified
- * @size: new size of file if modified is true
+ * @pdp: returned WRITE delegation, if one was found
  *
  * This function is called when there is a conflict between a write
  * delegation and a change/size GETATTR from another client. The server
@@ -8842,11 +8841,12 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
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
@@ -8857,10 +8857,9 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	struct nfs4_cb_fattr *ncf;
 	struct inode *inode = d_inode(dentry);
 
-	*modified = false;
 	ctx = locks_inode_context(inode);
 	if (!ctx)
-		return 0;
+		return nfs_ok;
 
 #define NON_NFSD_LEASE ((void *)1)
 
@@ -8926,10 +8925,10 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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
index d028daf77549c75ba1bb5e4b7c11ffd9896ff320..ccaee73de72bfd85b6b1ff595708a99e9bd5b8a4 100644
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
index ac3a29224806498fb84bacf2bf046ae78cbfac82..c7c7ec21e5104761221bd78b31110d902df1dc9b 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -781,5 +781,5 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 }
 
 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
-		struct dentry *dentry, bool *file_modified, u64 *size);
+		struct dentry *dentry, struct nfs4_delegation **pdp);
 #endif   /* NFSD4_STATE_H */

-- 
2.46.2


