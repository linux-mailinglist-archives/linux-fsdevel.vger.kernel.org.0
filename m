Return-Path: <linux-fsdevel+bounces-63985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 058D2BD3C2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 16:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 595A434DB0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB31330F54A;
	Mon, 13 Oct 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADlt6a8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7BE30F52D;
	Mon, 13 Oct 2025 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366941; cv=none; b=uRRuPft2ifHXsGPyvecRwv+XhKELGV0EW3X5WbAyWoQ2n9LQKGNpTBIpLsUxvAQfc/iOs7TvFvRICr0F0O6xyJp9P9dpVh99EJEZ/zCS66ra1XaqJ4ifi4qEX5cnFO4gkDimnrtdrS/BqAIHKXGXeNF/ApW9mdw7JYpkzQvvyP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366941; c=relaxed/simple;
	bh=aa2nwa5AUZDKL13xRk8VHTGhhxsB/IoN/NqofQpDKAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WQnpyPu59FtCwUlJ0VHjBJfeeUD50/1CGnzVt57sppTJtdjki3tUk1BprlBNCp6IjRRjeS4VljCqufLMC/1tpB8dz8hql+qDXgzdMgY1+hH9ugbACkJ8EPUp07Vd0n6L3lu0+P5HloGkwlBDmIV+C5lZsvE05CYpQng9bycOh2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADlt6a8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC74C116D0;
	Mon, 13 Oct 2025 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760366940;
	bh=aa2nwa5AUZDKL13xRk8VHTGhhxsB/IoN/NqofQpDKAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ADlt6a8UOqbXngXAy2sAICDjbTu8dQMBsS6xbt6qOQb2gm/owZ4yYhQ5aTYVHkS8K
	 PJb9QzkLF+wFcUY87kwm5HUAA3uOoENEJYmOj/O1tmK3qB0t7l3fh861lgjqOFKzx3
	 lMFFpsTlgp0IwfaoLxJIaVr4Tt1iMgqfDbsbePdRnbvSuJDpWm9zvMZICvlLx599ve
	 nRdTNQgViHLtKmVQ1xwRbpO2cvYPJ89QEE8ejkiSQ9Wwrb1rz3L8OArIUzq7nPxH1A
	 3RhzYr1BuPJ4xihBlbaYq4JV8WU38FvdnS8NZMhqZQdxPYT9dBKNPpdmXQEYauC3dW
	 A7ehVmMPCAe0Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 13 Oct 2025 10:48:11 -0400
Subject: [PATCH 13/13] nfsd: wire up GET_DIR_DELEGATION handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-dir-deleg-ro-v1-13-406780a70e5e@kernel.org>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
In-Reply-To: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4963; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aa2nwa5AUZDKL13xRk8VHTGhhxsB/IoN/NqofQpDKAc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo7REsqKBgKC2+m7edWhTDSNSDZurmHp2v1qS5S
 pJaGuMrNpCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaO0RLAAKCRAADmhBGVaC
 FWPJD/4h1UbKOkyHMkLf6qmTTkk42pMF1Jty9w9cZJcboE+925ZuYTGJJ4kyKPq4k3F9k9ZM1Uz
 xEQi80nS/XkkYixKDgVT+vBsr79wWDdetT5WTVyyMMJwjA2WguRuo3rTMkEaj+DCHOd4Ooh+wkL
 e20JG9gzFWWXdOM7Ib94E6jPFUZOle2AF3BWPI+J8jhUmWUbRrZbMmlxUyopmSaTtvSr1wx2Lf0
 SGlyWrvDqqLB90yE6M4LZrK0DIB1+TVB00odavoPm4bczI1AGUFoz1cCnW4/yoiT8kD0gYbdbsl
 c9p7eTZlL1YpQg6Bl1p8yuWsf/UPmIF/JW3sfZ1+R98HiutJkeglXhyRo061Nj+mcAlDKVZKaOT
 MCK9KBPVir+CPUvXZCf05Vkp4kpCm6Oz0KP3FSjStCBrR+L/moCPWsOmPj0kOyzaUFs+uMyQUmn
 ZcYjxu9rD6Fgap7z0XgMjtSzP+icwfkGJpWEyoIvf63htUP/68SesXIG1ShZIB2ayOukkFGX7nW
 oO4UJIp3m4oWMNXgjk2i3JC3Or6/KWn3cTkxWBsxZgvjr5Vk9WKxMAjg22AG3ODBmlJ2oTVe+s4
 Vhgd4994ReIp18pdn31CddfPRERgE5HkIJP6hBsqZ20SAZhMjRzNlxkgZr0YZu0cGnizZfzgjOw
 GI4L9WSBZOGm9qw==
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
index 7f7e6bb23a90d9a1cafd154c0f09e236df75b083..527f8dc52159803770964700170473509ec328ed 100644
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
@@ -2355,7 +2362,19 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
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
index 011e336dfd996daa82b706c3536628971369fb10..770acbee9e8dc69b6f19635638408ae4f0498b5d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9386,3 +9386,85 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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


