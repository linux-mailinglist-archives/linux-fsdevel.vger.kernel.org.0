Return-Path: <linux-fsdevel+bounces-27836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DFD96467E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8DA1F200F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05781B1435;
	Thu, 29 Aug 2024 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6SiqbJQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F11B1414;
	Thu, 29 Aug 2024 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938019; cv=none; b=Hchz0Yf9eMAxet6HxzeazHGFvUNQJofeQSbZOBOQnR7eUElquHG8Q4Y62PSId/fg7QKLubiIPcoEwM0sExdL7J72YUYm+CS7LGs3exBEB9ului1WQd0Q+bzo2JQLJIky6Hl9U9v9ltMP8okGinPv2EUgO5SCTrv7fNZlRJk1Uoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938019; c=relaxed/simple;
	bh=Py7V2TezOV5i6M8TumjM3litrx+m92p6vW6sSsvwfIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nYcEIrKLxnseVvg0/XMDV0Z7qWm8nNCBFe/dc5QsKGlFQm/UIAljpfhibdgFkfxNu398Xms0XSppWTh27eVqjhyPvv9Bi4V742bVfXF/h44LhUUbxExnxjNyyCXSDO9r7Tr8pXX/SLgn/U1NaYw2Aee+c8Wb3b0HtvIrVA/owJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6SiqbJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABD1C4CEC7;
	Thu, 29 Aug 2024 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938018;
	bh=Py7V2TezOV5i6M8TumjM3litrx+m92p6vW6sSsvwfIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r6SiqbJQL7SkEqYpuWjRzKn/O2DSMVJbbB9oY62C7V92HXE+ZJELLqMmdahqdmPHw
	 LYpDEqLR0riplZjvfMFPf2os875uNgQQsDpsJb/tjbF+N1LmYz4MDUeYYKrI9DEAJl
	 pLbn4FyO8ChVPjC1eVTnPYpHmDhV1+KuRRqs8Cym0yHAJBP0x4y+u/2NsNnAqxgwBt
	 7wVKXQ1d9rS9+k+2hmvxoFW5l3Hq5B5PaY8GhS73jf8y2HZWd2vQ+ovJEVCpnnvIgn
	 QQMJsBWzJebum4Cn8U1WH3OmE1LFxd6Hm0lbCcpXwIwpyJJS0DPBNhkHEaqrwI0Zv7
	 rNCcllj12UQrQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Aug 2024 09:26:43 -0400
Subject: [PATCH v3 05/13] nfsd: have nfsd4_deleg_getattr_conflict pass back
 write deleg pointer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-delstid-v3-5-271c60806c5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4705; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Py7V2TezOV5i6M8TumjM3litrx+m92p6vW6sSsvwfIo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm0HcXBGB3QGlLF9cFPT1o9pNMsrfkB0OE+86Ox
 A4X/QMlageJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtB3FwAKCRAADmhBGVaC
 FQjdD/9TBRqObrgimJSopCjAxnb7v+ULm6jz2S0ugsqFUpVp2OPSs5q1cN77YDlGzKiN8wJfuxR
 XuNz8kHIGAeZN8N7eDOs1EHKfVHKlphgCjnIp+I0irx51rN576iEVVyiFi2pOI5uzbvpEQotxO+
 Fnl7zJwd51w+x4+iOLWc9hwPxY30foguvSW2PQ9DsMlEqeqblt4uFxYZ/6PRu1x5DUpfHi/VLBW
 JYsJJAKdus6BVQtM9EUAxleBQ/1wgPTceGomR6fhJtOu9Pd2YZgBZsbnwu9sUAhgqjJQldGdMYB
 liDk9+3UsLs24XHZo/4funvj7qwe8os1KOCncL4osoWPc0OrTSD0QQhtZTmZd4et5xv08XIX3X2
 W0T9B4Rvoro3rC1utwgLyL9yGSXI2ZslYiutBauiLULk78IuHAfLdTeVvBOnSTs10TM4utHMY/l
 wLCPebf7PncXheUeT0VN9TEKbnmcwthOknccYcGiLATBu+h50/hugJ1bTok31m58QIuozuXmxzx
 s/tc3fW/8XHyX2uKG9xgcIhjAseNVDwPQrNzihKjuh4nu7qg4y6hs67wWNbMB8ElKsvCtrw3V0H
 pLo2lKAigTtAVS/fdsf513xLpWGVyqispqp32l9nvIBN40SDgPVTYVTL9hL3WuZYP5HPANHDZnP
 vkXfqjX57VNNtpQ==
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
index 6844ae9ea350..dce27420ae31 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8810,8 +8810,7 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
  * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
  * @rqstp: RPC transaction context
  * @dentry: dentry of inode to be checked for a conflict
- * @modified: return true if file was modified
- * @size: new size of file if modified is true
+ * @pdp: returned WRITE delegation, if one was found
  *
  * This function is called when there is a conflict between a write
  * delegation and a change/size GETATTR from another client. The server
@@ -8821,11 +8820,12 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
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
@@ -8836,10 +8836,9 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	struct nfs4_cb_fattr *ncf;
 	struct inode *inode = d_inode(dentry);
 
-	*modified = false;
 	ctx = locks_inode_context(inode);
 	if (!ctx)
-		return 0;
+		return nfs_ok;
 
 #define NON_NFSD_LEASE ((void *)1)
 
@@ -8905,10 +8904,10 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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


