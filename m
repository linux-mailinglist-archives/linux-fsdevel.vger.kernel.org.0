Return-Path: <linux-fsdevel+bounces-27833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0423E964673
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A9C1F22A23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29D31AE845;
	Thu, 29 Aug 2024 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQlfhofW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463C1AD9D2;
	Thu, 29 Aug 2024 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938014; cv=none; b=edT6MCLbcesXBsEc75TJCuMNh9XjWFohlA0eD1WmyyHYVYBsow3E/s9GLMqzQOD4LD4LscZtK4vrzP+6h3zStqSX6DCUuk7yZdoHCw7a6xPV9e2fmOlHa+dPPm9BnN2eFoW6y+6hUOs7MunHp6+KUKIF0QAybQ9PlRNFkTcul8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938014; c=relaxed/simple;
	bh=PwIFk2dK5q6tuUFzoYh/qnAqes8i0hXAQB3+QDH+hyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JL6EUpaZ1NB2dRX0tfI60OfFp4ayXyQr/xxiaOsgrlIeu0xzUBxN7cH/O/iK4EFw0MfEcIyszuDQCfzPxy1bAGOIVW5mn9Kh6jgMDjDfspJLYYcnunbwLRCxKeVOkD7s1jAf+0jT7ZwCVmlZrxvaz1WUxbi8Ld3JmENCgp0CiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQlfhofW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF0AC4CEC1;
	Thu, 29 Aug 2024 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938013;
	bh=PwIFk2dK5q6tuUFzoYh/qnAqes8i0hXAQB3+QDH+hyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AQlfhofW5+r4WL2ixr0aCzI+DisyPr+42Y6bqxCjh426SLMYPNyaIJyrnzbER4Okj
	 BJzf1SzyCI8lUFEJu86bIM2ykK+gGAbmQ2XWGhm3iYEvi67hzVdn2XXrQXImXrfarr
	 9UyibVJb7WdbeHZ/4i1lzwshtYfoQjqEuGzxDL7JvM85p8DBnBfFr+u3XpUYmBNVo2
	 +vcPJKq2C+73LtFomEyfkc9Z9TQaEV1rIcH3INuz71HQh2ROqUrDjXCE5dW9ddOsIM
	 PbRwv8XcF69f8vf1QXCBJosMFyLg9AheESioU5OabUJMVvAVoivI6MAuXqUb0H9qsi
	 eDWGsyLizbKQw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Aug 2024 09:26:40 -0400
Subject: [PATCH v3 02/13] nfsd: untangle code in
 nfsd4_deleg_getattr_conflict()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-delstid-v3-2-271c60806c5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5851; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CZ+WRwWj+mXsqzim3Z0h9WP+zRKw7PARB6vUTbQEEIc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm0HcXw9IIyWz/zkGgfp2tt5r7oXNPGxULgQO2J
 zQliE9FQBSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtB3FwAKCRAADmhBGVaC
 FYKqEAC4pnNmwmjHA53D7AN8RGe0wKwbULA7e9QIYiZaWJxujWdBdjM2PiND5Nr0+2AaQyTX2uw
 yewh1n2y6nns5yMGW2zT2wn70jM46pKBEFsKZqDE9CoCbSF1QZWydZF4rswqBjwPIS8tWn4abBz
 6hzevRkg05I9N3Czvo//zhJxO9+WFAhWnE342X0Xl6fapDYI01u89Skx9Jn1Es/07NAGvWTgrzx
 ydx/+AU4yi4e1tC9tu6GED9XoU9zQIsM0RKa0qDfCPYLkDyL0JaqX6R+O5WiWsdnipVX8zt00y0
 dtXOtiT/WUaIqdLLHLVbxpg1Kr/PmEP1mzf9fnuxazudJcCg0YGwynqryiYlyN+fUWIfmh1g9Pc
 tapl3AziIE4sK3rt2v1GBOQw62ScQ+y69AzRPW2rTIrk2Jcgp3TVRtyMAnn0cSO8LmhodUDy30X
 Yp/FBgr5u1sNcm1wCkIWrePFbmzppJjqelPAiCk7mz8nc+VeKDvPLT68E2I3al46+Bp4EfcizRd
 B0AmEzpG+fD933PhVMc96V5u0SFWXZIjyyFEVRTWrP/YvlrPMqV9pm208/OVa3z5Oo823Hi+F9P
 LfpdGdN0k55sSLmEETg6Rx4DRL91BFid5Y6lyNLjDLHEqtnh8gDCQDNkZhYtNvC11TpdGx5aIDL
 lUj2z7pU1KLi+lg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

From: NeilBrown <neilb@suse.de>

The code in nfsd4_deleg_getattr_conflict() is convoluted and buggy.

With this patch we:
 - properly handle non-nfsd leases.  We must not assume flc_owner is a
    delegation unless fl_lmops == &nfsd_lease_mng_ops
 - move the main code out of the for loop
 - have a single exit which calls nfs4_put_stid()
   (and other exits which don't need to call that)

[ jlayton: refactored on top of Neil's other patch: nfsd: fix
	   nfsd4_deleg_getattr_conflict in presence of third party lease ]

Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 131 +++++++++++++++++++++++++---------------------------
 1 file changed, 62 insertions(+), 69 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index eaa11d42d1b1..8835930ecee6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8831,6 +8831,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file_lock_context *ctx;
+	struct nfs4_delegation *dp = NULL;
 	struct file_lease *fl;
 	struct iattr attrs;
 	struct nfs4_cb_fattr *ncf;
@@ -8840,84 +8841,76 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	ctx = locks_inode_context(inode);
 	if (!ctx)
 		return 0;
+
+#define NON_NFSD_LEASE ((void *)1)
+
 	spin_lock(&ctx->flc_lock);
 	for_each_file_lock(fl, &ctx->flc_lease) {
-		unsigned char type = fl->c.flc_type;
-
 		if (fl->c.flc_flags == FL_LAYOUT)
 			continue;
-		if (fl->fl_lmops != &nfsd_lease_mng_ops) {
-			/*
-			 * non-nfs lease, if it's a lease with F_RDLCK then
-			 * we are done; there isn't any write delegation
-			 * on this inode
-			 */
-			if (type == F_RDLCK)
-				break;
-
-			nfsd_stats_wdeleg_getattr_inc(nn);
-			spin_unlock(&ctx->flc_lock);
-
-			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
+		if (fl->c.flc_type == F_WRLCK) {
+			if (fl->fl_lmops == &nfsd_lease_mng_ops)
+				dp = fl->c.flc_owner;
+			else
+				dp = NON_NFSD_LEASE;
+		}
+		break;
+	}
+	if (dp == NULL || dp == NON_NFSD_LEASE ||
+	    dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
+		spin_unlock(&ctx->flc_lock);
+		if (dp == NON_NFSD_LEASE) {
+			status = nfserrno(nfsd_open_break_lease(inode,
+								NFSD_MAY_READ));
 			if (status != nfserr_jukebox ||
 			    !nfsd_wait_for_delegreturn(rqstp, inode))
 				return status;
-			return 0;
 		}
-		if (type == F_WRLCK) {
-			struct nfs4_delegation *dp = fl->c.flc_owner;
+		return 0;
+	}
 
-			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
-				spin_unlock(&ctx->flc_lock);
-				return 0;
-			}
-			nfsd_stats_wdeleg_getattr_inc(nn);
-			dp = fl->c.flc_owner;
-			refcount_inc(&dp->dl_stid.sc_count);
-			ncf = &dp->dl_cb_fattr;
-			nfs4_cb_getattr(&dp->dl_cb_fattr);
-			spin_unlock(&ctx->flc_lock);
-			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
-					TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
-			if (ncf->ncf_cb_status) {
-				/* Recall delegation only if client didn't respond */
-				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
-				if (status != nfserr_jukebox ||
-						!nfsd_wait_for_delegreturn(rqstp, inode)) {
-					nfs4_put_stid(&dp->dl_stid);
-					return status;
-				}
-			}
-			if (!ncf->ncf_file_modified &&
-					(ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
-					ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
-				ncf->ncf_file_modified = true;
-			if (ncf->ncf_file_modified) {
-				int err;
-
-				/*
-				 * Per section 10.4.3 of RFC 8881, the server would
-				 * not update the file's metadata with the client's
-				 * modified size
-				 */
-				attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
-				attrs.ia_valid = ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
-				inode_lock(inode);
-				err = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
-				inode_unlock(inode);
-				if (err) {
-					nfs4_put_stid(&dp->dl_stid);
-					return nfserrno(err);
-				}
-				ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
-				*size = ncf->ncf_cur_fsize;
-				*modified = true;
-			}
-			nfs4_put_stid(&dp->dl_stid);
-			return 0;
+	nfsd_stats_wdeleg_getattr_inc(nn);
+	refcount_inc(&dp->dl_stid.sc_count);
+	ncf = &dp->dl_cb_fattr;
+	nfs4_cb_getattr(&dp->dl_cb_fattr);
+	spin_unlock(&ctx->flc_lock);
+
+	wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
+			    TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
+	if (ncf->ncf_cb_status) {
+		/* Recall delegation only if client didn't respond */
+		status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
+		if (status != nfserr_jukebox ||
+		    !nfsd_wait_for_delegreturn(rqstp, inode))
+			goto out_status;
+	}
+	if (!ncf->ncf_file_modified &&
+	    (ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
+	     ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
+		ncf->ncf_file_modified = true;
+	if (ncf->ncf_file_modified) {
+		int err;
+
+		/*
+		 * Per section 10.4.3 of RFC 8881, the server would
+		 * not update the file's metadata with the client's
+		 * modified size
+		 */
+		attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
+		attrs.ia_valid = ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
+		inode_lock(inode);
+		err = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
+		inode_unlock(inode);
+		if (err) {
+			status = nfserrno(err);
+			goto out_status;
 		}
-		break;
+		ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
+		*size = ncf->ncf_cur_fsize;
+		*modified = true;
 	}
-	spin_unlock(&ctx->flc_lock);
-	return 0;
+	status = 0;
+out_status:
+	nfs4_put_stid(&dp->dl_stid);
+	return status;
 }

-- 
2.46.0


