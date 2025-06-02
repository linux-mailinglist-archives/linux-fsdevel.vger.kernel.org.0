Return-Path: <linux-fsdevel+bounces-50343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 635D6ACB0EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB16A1BA7C27
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877D72222DA;
	Mon,  2 Jun 2025 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp3N8wjq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D53230BC3;
	Mon,  2 Jun 2025 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872970; cv=none; b=gUZ2DLmnXGhEnxlSac2XluWB/EXXp5qTocMxFcI6cd8+ONAs3vcPKatVDytU1KSYoYqrLy/koSpULa76u4a64twVr6+PyX48VGs3mtZfQh8iwcZaBslr9FNo7yyoAJzrsV3y/MTe6yJWZW2JKUUuPHsFjD5O/wKhTIKog4jlE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872970; c=relaxed/simple;
	bh=hYLRQ8v788ftgkpEhYsLTSyg0Nr10YJX5mZ5C9KFksk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LdgcSA/xAzdlICyOa3vrWy60OFnvz89w4hFF8aN5VWT2UQzJ0T2GMLPJA5sHVe6AvtI8SoxQ0GWmSAKFzdw8Omi00nMUNfqmF32/FSYDkAGOjnnUQK31816yPkWJCXO53bYp1Mhtp6DSWpte9IUcCwZYpHjZOFwhJt9DcbT7UB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp3N8wjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2677C4CEEB;
	Mon,  2 Jun 2025 14:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872969;
	bh=hYLRQ8v788ftgkpEhYsLTSyg0Nr10YJX5mZ5C9KFksk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sp3N8wjqCEIq5C0H+crBQt+k+PkUxUZFqd1uW2JxFp1ERegi2SQzAlIhO1qCWsj/K
	 22eDdQp+0vJZy+s96O/8XGHoxz8zfHi6dhTkjNfhV+SpHqd9qPtddyZTyo1SCu2T0h
	 Hsp/ldQ6CbmM05/UGYRXQM/ywIbizsyh+V76Ay5j0fs5IhBg+G85rEzRGGcvJJoaDP
	 cQ9g4s5HRgrKJTszkABSjRwg3ubrNmMmXo/NZrvB6k8pxXx8fBT+ss6CpsuUjo+/u/
	 sphvYtx3SMa/h0b5+bqfgCI69hMcaCEYLvFlOjh2JGagv699vWkNC7wXI2Wy+5R8Wy
	 PZje7bOcuSDRg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:56 -0400
Subject: [PATCH RFC v2 13/28] nfsd: wire up GET_DIR_DELEGATION handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-13-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4963; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hYLRQ8v788ftgkpEhYsLTSyg0Nr10YJX5mZ5C9KFksk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7n0atl1ii6zmc/TBC6kmriNVQJyCfmy9cb1
 Jh0yDKgX0CJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5wAKCRAADmhBGVaC
 FS++D/9YV6d68qV5iRsui3V1GgS2bRY/r7U+0uqV1XtoqVqTPCkAtgr0rLSt59YcTK3YNR3RBfP
 J0oHNjl0wqhckZFOi80pM2VcPoEaEZQ49gaHTphp5BGuvai8xKL97O01wWdeBjVAe+1JWPhCEik
 Lf9UxGXl80dZhg1GcSMJnLHpdFO52sqms+NzSfrVd8gcuSf/XcclZSOftofzeih/jxN9D6aUXbS
 aAVoopMibvfHPHePnlONTNF8vRLMR+ll52JOrx+kS9yp2EOtHioPcpQiPLupbjLrr7ZgaF503Vz
 tfZKbyxam5804r34nSHDNNMN4AHc4HyidmRKacK0o8YMkuse/7dq4vH75CXFcq0uSjUVHwLf5PF
 pdxogVzaXvQ3irlZYVdOWJ9s8r7613457l/9AOlqGFm5oXuprRKvlhlT3SlI2CXNojKpr3EX1bP
 Pec0iDDDRylTRG5zAlaKYsW2VZAmXgbtWzGhXiGX2rtKwKII1t01uDvBCwpNWalspZt3D6ZmXIE
 rbnI9Gv/KM7QmPbhQ8BczYE4KgGXiePgYvUOXokNu0Vsf3XKUHG8tKViSXyb0YJaPQOoNSvqt2H
 4o7Ycx3Tbfj7z0ir8BrDbrekIOjD6DS6RMRV26wSLDxBbLDUWY3R/PZPOA4Yt3ejduNdnw0Oz6G
 WyiCJiPXteElMPw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new routine for acquiring a read delegation on a directory. Since
the same CB_RECALL/DELEGRETURN infrastrure is used for regular and
directory delegations, we can just use a normal nfs4_delegation to
represent it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  | 21 +++++++++++++-
 fs/nfsd/nfs4state.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h     |  5 ++++
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f13abbb13b388d223165b1168dc2c07eafb259cb..fa6f2980bcacd798c41387c71d55a59fdbc8043c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2298,6 +2298,13 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
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
@@ -2311,7 +2318,19 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 	 * return NFS4_OK with a non-fatal status of GDD4_UNAVAIL in this
 	 * situation.
 	 */
-	gdd->gddrnf_status = GDD4_UNAVAIL;
+	dd = nfsd_get_dir_deleg(cstate, gdd, nf);
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
index 12f20e3c9c54b68cdd4c62aa2904c22c9ccfae0a..ed5d6486d171ea0c886bd1f1ea1129bf4ccf429c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9307,3 +9307,85 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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
+	struct nfs4_file *fp;
+	int status = 0;
+
+	fp = nfsd4_alloc_file();
+	if (!fp)
+		return ERR_PTR(-ENOMEM);
+
+	nfsd4_file_init(&cstate->current_fh, fp);
+	fp->fi_deleg_file = nf;
+	fp->fi_delegees = 1;
+
+	/* if this client already has one, return that it's unavailable */
+	spin_lock(&state_lock);
+	spin_lock(&fp->fi_lock);
+	if (nfs4_delegation_exists(clp, fp))
+		status = -EAGAIN;
+	spin_unlock(&fp->fi_lock);
+	spin_unlock(&state_lock);
+
+	if (status)
+		goto out_delegees;
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
index 8adc2550129e67a4e6646395fa2811e1c2acb98e..0eeecd824770c4df8e1cc29fc738e568d91d5e5f 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -855,4 +855,9 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 
 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
 		struct dentry *dentry, struct nfs4_delegation **pdp);
+
+struct nfsd4_get_dir_delegation;
+struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
+						struct nfsd4_get_dir_delegation *gdd,
+						struct nfsd_file *nf);
 #endif   /* NFSD4_STATE_H */

-- 
2.49.0


