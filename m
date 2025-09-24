Return-Path: <linux-fsdevel+bounces-62631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9720FB9B3F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422EF2E1449
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C361332340F;
	Wed, 24 Sep 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4yTIDPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2C31A57A;
	Wed, 24 Sep 2025 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737220; cv=none; b=NApEOv9BnJXzyS/927d1Cy8kkpyNWcjphW30gtYMYiJfwxMzWNmfMytJLuy97VL+yYM6kY5MbG319+VvTEt9eez6Ehu+e6xX+yOuDVYTuLsnXvjY8ASb1CzEJ2eDjMue0yim1OQxF30zkPda4IPdhaIvwCjbkd8f+34J1nLQCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737220; c=relaxed/simple;
	bh=rDKpJPFejZjasH/qw3UA9zn/j7p7JdlkPlHncPl+pCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNLKDNj8CsDIZ7PyWPuk7nJ/fmr/liUnYtOshqLDi3zPzEseqOO4cpuECB+O7AwwJlKYAAP3ImjzTPAnp2wJ1mZ6doZQoKrZB21kkkxSKKAa9D2j/9DD81B+nIBkjb7QNnLEhjKqJ8djGH1owkWAn3N1egaQ5gLE5sCDhlKTTqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4yTIDPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C0FC4CEF0;
	Wed, 24 Sep 2025 18:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737219;
	bh=rDKpJPFejZjasH/qw3UA9zn/j7p7JdlkPlHncPl+pCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c4yTIDPaB1exAN9wscHE1zRJ1JHTgwc1x8cV01DfBVfJNsKOUfVjESZtp+wDFBS31
	 q5+sbAFvy1f2y9hLLmeQ3tZ1oEGu+PFYkSZv+MbYvWCpUwQCNTQM2NnLRQKDdPi8K6
	 8K1NREognz0N2aeOZWkXv0gA3S+mM8gJMyangg8w1v9Zby5Jez5Ujd/0MT93fRqlcd
	 Jgi+cu6NYRnArrN7ZJnZ+AtcIAvmYIqaNAEuATxh8Cen96OnErWyRjYV9LRG8O1e+Q
	 S0ZvBO3Es8YR/V2tIPc+SjfFscpCbeCT6/w3SuzrYsbTsRkm3Le0euyy03VLyuNbeZ
	 3LGNkzfAN83LQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:05:59 -0400
Subject: [PATCH v3 13/38] nfsd: wire up GET_DIR_DELEGATION handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-13-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4963; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rDKpJPFejZjasH/qw3UA9zn/j7p7JdlkPlHncPl+pCA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMNpTV7Y8X/WeRG8fRIHDX2DN5r+EcKJndZP
 v4VaOF/+dyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDQAKCRAADmhBGVaC
 FYziD/9Gavcitu9ItfM/DZYmUGsSv6I3dzwqq73uSIal3TpB+DLdQ5QyUhmjlYAJe0jFgHS5JPG
 2cFDzM35fG9wgeZsFtw/PnPqOy1fk/QD3a8mjABA6B8IOroFomJCfRPJTXYbnO2DMl+Q/Dqhu/R
 t98VZMUEffi3ea1IXDgU8+tdK11IkWcq6HsjJoY0g8y1gh6OWApt3gcWq6BXy9aBH8i4vEH9r/J
 eZzKpNgQDgGAzAvfqG5XFCKSre5an/S2inzeZueS5GGiSbR7yz4h8ahIRogzt0adncU46maY0Jv
 PEIkHf0QL6pRfOTxalf1uwo5ndDrWWFFSvOihpTK9Vd7yrIdBT63e9H/xTf5CEiZe7NThjqrHRp
 hoQn1vWGGflvjqXCNWDX3aCj5aC3/KTXiKxGKYZMl4pV8LGNAK+91iLNQVgZDAF5hIwY0a691Xw
 54Gr2ZMAoI5ZBvKI9khAr773tHqI2tnsKnzjGDL7plsl02+BhalThMWG3a/a+myj6zS5bg69LQU
 1LU0glkk/NPgcqYBZceqe904mzj6hiriOmJgiTcR7DDpRL1+oLovysdH4xMW/91LCWVWaQvEnu8
 ZEUwyMO6+N7mE58ethLd3V3lgUm2XbMZiYBIiQuXfVPCwgZpnhujPwdZcEd/SZuiFo0xKEApgdJ
 hnnEaF64CI0VWxQ==
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
index e466cf52d7d7e1a78c3a469613a85ab3546d6d17..277022d437cec18e527c836f108f0e97c6844b23 100644
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
@@ -2354,7 +2361,19 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
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
index 87857b351cd92c509ab7101645e17474f2dabcd4..d1d586ec0e4e2bef908dc0671c34edab9cad5ba2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9421,3 +9421,85 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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


