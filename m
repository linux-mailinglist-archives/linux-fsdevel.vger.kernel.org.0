Return-Path: <linux-fsdevel+bounces-67174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAE4C37162
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 18:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1919D6E1F30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5820834E751;
	Wed,  5 Nov 2025 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5Oenf/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF934DB46;
	Wed,  5 Nov 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361704; cv=none; b=OPDO5NDYrGQlRK0djNyfoWL1RzdJzGJb8eFNtB4P3yxmBXROVjvJ7OyGUA5HguXBTJoI1dSVisBd+auPF0QN4T6H0JxbNZrlky5nfxGsUe1vtHxfymjY2hNjSUh35dEXvASbZIYx5d6xQ6ttOv0hTwUy/hipltHXAqNC4uyE3RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361704; c=relaxed/simple;
	bh=8uFhmfmnSTsd3LwYNioQRWlGjzSH6flkvXdmZ7xJmTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ORNKYIM1wbi5GGEwOOwvAgELcBH1kV6V03jbTobn5hGoHfF14iVa9Beh4vh4iHbUqXNgkl2CsR1erF4hdBcmCdKXlKmQt2AHgSqW+tnJCq8S6/nLiz5h7GYEWgzYox5apN5SC+Hhe6JGwYHtp8OhQnrSZt2Fb4DYRLrfq6uXa80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5Oenf/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473F2C116B1;
	Wed,  5 Nov 2025 16:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762361704;
	bh=8uFhmfmnSTsd3LwYNioQRWlGjzSH6flkvXdmZ7xJmTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f5Oenf/SvFAFjRdyni7XQijTep2IHierotWbgMU2UbOTpksiQsROt1aF+dPbNuCH2
	 1oUKbKzhFqYLnyn8JhgnONeFClnDzW8M9TGesb6LwYtWJuKxjsSbbs1h8WxRaWYIku
	 FJ57ri0MQ0uxUTufrEk5zhCmAkFAQ7VmW8mldA2Yz/ApMrrQ3+dm/w0Pz4iAWkG5LJ
	 umYmGXuujNQbIo8Zte0Td4zJfysJEylWTl2UYkVi1/93DRbi1KJjqDd9Ga6ZVgLDh6
	 SZR74lxKruPDtv3zTQmLrs+cJRcNK2D6HFXXlPN4jtgbao5GWNEqIhb64uOsS1Te5i
	 qsZlLrSUFn8qw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 05 Nov 2025 11:54:02 -0500
Subject: [PATCH v5 16/17] nfsd: wire up GET_DIR_DELEGATION handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-dir-deleg-ro-v5-16-7ebc168a88ac@kernel.org>
References: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
In-Reply-To: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5577; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8uFhmfmnSTsd3LwYNioQRWlGjzSH6flkvXdmZ7xJmTo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpC4EtKjXEEAavufgz3/17T2+K75udF1YHhM8p1
 kLLoOFSASaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQuBLQAKCRAADmhBGVaC
 Fb9xD/0SrANaaUs/KwJlwN9tPXS96N80QDXhAa3/aQiaUd38olFHdxjgtSPwz6fVN7C1NS/8N2M
 Y9GmCgY8SHLYhnxhx/iCJwOleWwCFWmuMdkZFV9/1gA3tOQOLBL865n/f5m+ZRStY5poVfIIILu
 QfhhswKVyGxN0uHjsPfRuudcAVBU/1eUk3RdxpE8MChbCbgBCzFmpK94I+Xy2hCSAKUPDzjLXFc
 jauSu6SmQzJhluP3AP5KxGBgsizOV/8ZwakjK+qL3eOw2E9awNueo7rijaJnKpkKsn13pZwPYRP
 NMdz0PoSm1sZDc9jsPjYjRV954z1kT5USy2LsMU5Boo6/0LopQ+Q1ohSQYIvq9t2QeQYK0O8z57
 jzSivucdoTuLJkMX1HjMQ1K0CExea8CqgWo8lz+yUWu9d+WBxkXXePCSzKXXwSjZiNymqx09lFG
 G7lHF9Eu5wiZMYrLtWkdcWEZG1H0LSJndAcF+RuyqV/icgFU1vwqvQPdgDk4WcPoYopYUXx/FhQ
 nhM83yNV3bpUQ/m46YDkW7zjaHpU3Zsm7GCpG110w2rp2Wx7fgcjX+nOwXu6AkFjJ6inHLsMpnl
 rgvcZDfAZmpEEtQ7rwDEo9e0HORqkLdmWFuD5q3hFC0gYkUis+Ww48x201kxjnMS/iWMZJ3xkaA
 yKs0Ihu73wXrnuQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new routine for acquiring a read delegation on a directory. These
are recallable-only delegations with no support for CB_NOTIFY. That will
be added in a later phase.

Since the same CB_RECALL/DELEGRETURN infrastructure is used for regular
and directory delegations, a normal nfs4_delegation is used to represent
a directory delegation.

Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  22 +++++++++++-
 fs/nfsd/nfs4state.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h     |   5 +++
 3 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e466cf52d7d7e1a78c3a469613a85ab3546d6d17..517968dddf4a33651313658d300f9f929f83c5af 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2341,6 +2341,13 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
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
@@ -2354,7 +2361,20 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
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
index da66798023aba4c36c38208cec7333db237e46e0..8f8c9385101e15b64883eabec71775f26b14f890 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9347,3 +9347,103 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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
2.51.1


