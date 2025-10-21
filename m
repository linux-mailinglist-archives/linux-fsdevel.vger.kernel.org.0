Return-Path: <linux-fsdevel+bounces-64956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B9FBF767B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE823B0C8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4226434DB52;
	Tue, 21 Oct 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyYUYCgH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F503370ED;
	Tue, 21 Oct 2025 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060403; cv=none; b=ClXINiWtOGFN8XzChdrBC8AjSzLI1xvaR333ndf2J4W/KUAzRtrEmK/GnnX0y8d4Iuj2ppSxQORpi6lztjoFRHX7dJwPcs/VaC35ufomxnuM93O8twJ1dFDznCRValG/jfyMfzCoIsnP+OA3USB7n6JyhU2S5znGX/eTJY0O058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060403; c=relaxed/simple;
	bh=tbkhNU6XkoF0KbeOuYLiTK96TlpVye1DLh0q82UO25c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sP/S7lGde0YuhkKCwNb+0xXCQL07Odg4q0u4reTDzfT5NXQs43cHFG3ajPwk73WWtalGskcv0tfzMj6HZSZjxHJMv8EcAX6l7Yrwqm+hM7qjHlOlrPr8gOLN8v/mDoP43TcDeLLwF+3IWPrPdXu/oSc6pUmQ/bSl4MkGMfmcpZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyYUYCgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AC1C116B1;
	Tue, 21 Oct 2025 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060403;
	bh=tbkhNU6XkoF0KbeOuYLiTK96TlpVye1DLh0q82UO25c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dyYUYCgHKc5Ydqi5NnksRf9NuhISqnWwhfKBP4CKOPxsgE5lja4NX6bRM97mF5kJE
	 a0g0qCtaDNi908QtGf1X/2GzXay4lak8GrS6lti16Frd7k7sN+CpkFM3JQtdAj42rV
	 2zGgLdF1xHO82NflAHi2A7+gXyTMM+GeWsdzEq4R6hJomKN7I7RzKCiI+XoJyRxLUk
	 kafPmITrcRMkJxO6yaeufoMJB7nS7uQttbx4SBTpJHYsxSobxo1WMs0YrGXeXinRUO
	 VEursqIlxPE3dYJ5cerLY9x4e3b9FIvYZvT37WSRUxvsaJiGDWOQGYt2lALOrDp5w7
	 R9Lf2QF6ELqpg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 21 Oct 2025 11:25:47 -0400
Subject: [PATCH v3 12/13] nfsd: wire up GET_DIR_DELEGATION handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dir-deleg-ro-v3-12-a08b1cde9f4c@kernel.org>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
In-Reply-To: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5526; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tbkhNU6XkoF0KbeOuYLiTK96TlpVye1DLh0q82UO25c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo96YGPIpUTjMhlpZiqNkjCVNhEOGJcwNKwTAnS
 Qk/24pWq8iJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPemBgAKCRAADmhBGVaC
 FbPCD/sFGLUqbjJhuX8T756oh/4AhmcZa75nhq5H0yqdAlrYDuz++cDN9XQwd1x68RpQLvMmb1m
 gnTyabXCVMqs6upJBuN7AU5QPvevE/DrnVQU46rSHC3B8oTyxb1SpOKiQypv35uYSB0j0knLlFm
 quwgqrr3f3d/41Cpt3Q9dmiON4aUFGdLtDV7/xIQIP59Np1n7LPlccIRURuURhnKRlAfYO9OjVu
 8bm081ymhykRnxvVNnV0Yn1Ao69lgldFTqFbNEX/lz4L4V90/ObjZsUpYzrTg1peYmIjhOuuQYC
 TXdg2imhtJ5rNTCjCu7O4aT3YFjIyq4tNdSBBbCTYoxLccmaq+f0z7ghWoCzDwB21uP5LGIohxg
 9icYHZZ9kL51pIiygML6BuBWkkDEhlCIw1Ph4Qssl7jC2YfJVoou7oTequfuzodjhV2eXSOjRdq
 w4uzmupwpdP6p21z79iI+GcE1lDcw40yrrgZwgmYBfTwPLfyNeDZ2F323tT841Qx/ABe/QGMYM4
 heLBuchPk693WFHJTO8hmlvNLO8zwHKXJwAf/7QflMnxqT4De66rBGzEs8qbm5ZsNgtRrMrUxKR
 tgu16XsmQHVbhBGCfjqPhuy3Zz02XEkOC06u+ty0NSg9/xvmBhb3bnjaWJGtvmdZc6PIsu5Itmg
 eAkfSUinIxbbyjw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new routine for acquiring a read delegation on a directory. These
are recallable-only delegations with no support for CB_NOTIFY. That will
be added in a later phase.

Since the same CB_RECALL/DELEGRETURN infrastructure is used for regular
and directory delegations, a normal nfs4_delegation is used to represent
a directory delegation.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  22 +++++++++++-
 fs/nfsd/nfs4state.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h     |   5 +++
 3 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2222bb283baff35703b4035fa0fc593b54d8b937..4f0b1210702ecf4eaa20c74e548aabbee33b7fd1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2342,6 +2342,13 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 			 union nfsd4_op_u *u)
 {
 	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
+	struct nfs4_delegation *dd;
+	struct nfsd_file *nf;
+	__be32 status;
+
+	status = nfsd_file_acquire_dir(rqstp, &cstate->current_fh, &nf);
+	if (status != nfs_ok)
+		return status;
 
 	/*
 	 * RFC 8881, section 18.39.3 says:
@@ -2355,7 +2362,20 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 	 * return NFS4_OK with a non-fatal status of GDD4_UNAVAIL in this
 	 * situation.
 	 */
-	gdd->gddrnf_status = GDD4_UNAVAIL;
+	dd = nfsd_get_dir_deleg(cstate, gdd, nf);
+	nfsd_file_put(nf);
+	if (IS_ERR(dd)) {
+		int err = PTR_ERR(dd);
+
+		if (err != -EAGAIN)
+			return nfserrno(err);
+		gdd->gddrnf_status = GDD4_UNAVAIL;
+		return nfs_ok;
+	}
+
+	gdd->gddrnf_status = GDD4_OK;
+	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->gddr_stateid));
+	nfs4_put_stid(&dd->dl_stid);
 	return nfs_ok;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8efa37055b21ca2202488e90377d5162613b9343..808c24fb5c9a0b432d3271c051b409fcb75970cd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9367,3 +9367,103 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	nfs4_put_stid(&dp->dl_stid);
 	return status;
 }
+
+/**
+ * nfsd_get_dir_deleg - attempt to get a directory delegation
+ * @cstate: compound state
+ * @gdd: GET_DIR_DELEGATION arg/resp structure
+ * @nf: nfsd_file opened on the directory
+ *
+ * Given a GET_DIR_DELEGATION request @gdd, attempt to acquire a delegation
+ * on the directory to which @nf refers. Note that this does not set up any
+ * sort of async notifications for the delegation.
+ */
+struct nfs4_delegation *
+nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
+		   struct nfsd4_get_dir_delegation *gdd,
+		   struct nfsd_file *nf)
+{
+	struct nfs4_client *clp = cstate->clp;
+	struct nfs4_delegation *dp;
+	struct file_lease *fl;
+	struct nfs4_file *fp, *rfp;
+	int status = 0;
+
+	fp = nfsd4_alloc_file();
+	if (!fp)
+		return ERR_PTR(-ENOMEM);
+
+	nfsd4_file_init(&cstate->current_fh, fp);
+
+	rfp = nfsd4_file_hash_insert(fp, &cstate->current_fh);
+	if (unlikely(!rfp)) {
+		put_nfs4_file(fp);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (rfp != fp) {
+		put_nfs4_file(fp);
+		fp = rfp;
+	}
+
+	/* if this client already has one, return that it's unavailable */
+	spin_lock(&state_lock);
+	spin_lock(&fp->fi_lock);
+	/* existing delegation? */
+	if (nfs4_delegation_exists(clp, fp)) {
+		status = -EAGAIN;
+	} else if (!fp->fi_deleg_file) {
+		fp->fi_deleg_file = nfsd_file_get(nf);
+		fp->fi_delegees = 1;
+	} else {
+		++fp->fi_delegees;
+	}
+	spin_unlock(&fp->fi_lock);
+	spin_unlock(&state_lock);
+
+	if (status) {
+		put_nfs4_file(fp);
+		return ERR_PTR(status);
+	}
+
+	/* Try to set up the lease */
+	status = -ENOMEM;
+	dp = alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ);
+	if (!dp)
+		goto out_delegees;
+
+	fl = nfs4_alloc_init_lease(dp);
+	if (!fl)
+		goto out_put_stid;
+
+	status = kernel_setlease(nf->nf_file,
+				 fl->c.flc_type, &fl, NULL);
+	if (fl)
+		locks_free_lease(fl);
+	if (status)
+		goto out_put_stid;
+
+	/*
+	 * Now, try to hash it. This can fail if we race another nfsd task
+	 * trying to set a delegation on the same file. If that happens,
+	 * then just say UNAVAIL.
+	 */
+	spin_lock(&state_lock);
+	spin_lock(&clp->cl_lock);
+	spin_lock(&fp->fi_lock);
+	status = hash_delegation_locked(dp, fp);
+	spin_unlock(&fp->fi_lock);
+	spin_unlock(&clp->cl_lock);
+	spin_unlock(&state_lock);
+
+	if (!status)
+		return dp;
+
+	/* Something failed. Drop the lease and clean up the stid */
+	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
+out_put_stid:
+	nfs4_put_stid(&dp->dl_stid);
+out_delegees:
+	put_deleg_file(fp);
+	return ERR_PTR(status);
+}
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 1e736f4024263ffa9c93bcc9ec48f44566a8cc77..b052c1effdc5356487c610db9728df8ecfe851d4 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -867,4 +867,9 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 
 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
 		struct dentry *dentry, struct nfs4_delegation **pdp);
+
+struct nfsd4_get_dir_delegation;
+struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
+						struct nfsd4_get_dir_delegation *gdd,
+						struct nfsd_file *nf);
 #endif   /* NFSD4_STATE_H */

-- 
2.51.0


