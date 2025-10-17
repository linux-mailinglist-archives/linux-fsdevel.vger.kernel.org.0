Return-Path: <linux-fsdevel+bounces-64488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3594DBE8691
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20261887231
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C2833031C;
	Fri, 17 Oct 2025 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W16aB5Ac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0042B331A66;
	Fri, 17 Oct 2025 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700780; cv=none; b=ImPOsq8BHpWb2hgypCtycBGeVhjjLZJUzlBLLzEZOEUN97PYUAT2E8qTjjKCFmWmJ/C7b12TaMF0sQUYTeBZ9OoOTPyCJf0Rj3H8xlCRR8Dx0X8Aw4jcr4UbDU8mfS3YhuhMfc70nXe80CXK2kxG0pr5IUsnaQzejh/9h2/vZ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700780; c=relaxed/simple;
	bh=8yVl2NH8wCRWT0BWB4xJxse7JadeLBTgspo6OepmR18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3Xkq9jw7Av4ShijT7rJ02wlnYlGF5pR3SJxnCDIIPGi1/9kUBRzF20BdNZRHJcB/ozEjmEOMyK3wl98hlHlhjIy2XexL2RKfEKOQ0BuU2TxDjYaYSaJwh5rHP7bLmIrH6QKTs0HpS3Sd40P/bQoCRyBVjLNqPMkQ6nbSBCHkSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W16aB5Ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA284C4CEFB;
	Fri, 17 Oct 2025 11:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760700779;
	bh=8yVl2NH8wCRWT0BWB4xJxse7JadeLBTgspo6OepmR18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W16aB5AchRRIDFkXWh+tG5tlaQdVC1I34WsnKRmiAAJAWSmro3WLSZmQJse1q4OCj
	 +aZNpXcLflrNtR0mCD36w96dlD4PZUDDMqhNxDoALx9q1i5CTP6ESbJCpuzkXqWNmU
	 L5/JFM5WTwtg4Q5N2sVlbZvu986nCzrY8XWnP1Y+lDtNYQYyHS0qb2zFQQDA1Ply5B
	 sO4pLudramXjUFoh37oPEH0lA3uHBbSJyWTjfE0c8Cuoj91WUTkugWUXADQe96AfMA
	 eHaFNitHGpSoHvJrQr9vwfo/qrGD6nwLD8uFIqM96xSIPEi6YzY1g5ynHCKqdJbW9D
	 jI8BfyxirEgeA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 17 Oct 2025 07:32:03 -0400
Subject: [PATCH v2 11/11] nfsd: wire up GET_DIR_DELEGATION handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-dir-deleg-ro-v2-11-8c8f6dd23c8b@kernel.org>
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
In-Reply-To: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5443; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8yVl2NH8wCRWT0BWB4xJxse7JadeLBTgspo6OepmR18=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo8ilCIHz7Y0CKC7YnK6gfkIqnxpWome0thgPpR
 +g2yqAYRpCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPIpQgAKCRAADmhBGVaC
 FTAaEAC+dHlJR18HGmzM64QSsr15Nzgmjhjn3B4u34VdeVcki8Z0M1Ia7NY+zBx2Mk+BlcfuhGh
 Du2a9DTnQHF+2TtGb71pGXempYuWufDsfnjvgtez9bbdvWgi2+owN3X1s9x55akZ83ymiItyl6y
 EthK4NbcNEaPSo0QQ3gEmkT3ZdS3ZTlg56NgRAkvLbVGAu6wNLHXMxMxPqht583P5mwLLcNoAHL
 6WSQQjaxSg2K/tOOe/daEzD+Ip7I7QzrTTmqhYReiFc2r4qfv8/ZFlR7KHDYifTwKqOVJRJqbbL
 QZLjAvFOd01wTr/avX5rzPmDSlRrzlb107pBBh4VVVhdZgnFhg5fnM1P42OkpfcBYmrCDZgL/xo
 +70YWd7yaitvOg1ZTSQKqslBYMJ6hr/8xlOcNvuHXvhZ8ZR+LjFPP7X7Qhy7Z1z1jqrU7m3E09b
 GnT9b11qbWeu9a6Abuml6pf65yauM6Md2eQTfuaext5+hYSlc0qlwn5Wpp0dvxKjwjdyx5YsyFA
 RdZQzWOqkEgv0UwB5/P9ypSeSdMmi4FDDAMOT56+mJNBnkTHUFrcF+XYks+xlyUZVHwTh/Gi8F4
 vRdvqGFLDThioSiuu1KtPF111VJG5853+p2RXcd3rvh/q5WS/CX12iya21b+CcLZvToFG6lIuy2
 bsS1IsMN5vPKs0g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new routine for acquiring a read delegation on a directory. These
are recallable-only delegations with no support for CB_NOTIFY. That will
be added in a later phase.

Since the same CB_RECALL/DELEGRETURN infrastrure is used for regular and
directory delegations, a normal nfs4_delegation is used to represent a
directory delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  21 ++++++++++-
 fs/nfsd/nfs4state.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h     |   5 +++
 3 files changed, 125 insertions(+), 1 deletion(-)

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
index b06591f154aa372db710e071c69260f4639956d7..a63e8c885291fc377163f3255f26f5f693704437 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9359,3 +9359,103 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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
+		fp->fi_deleg_file = nf;
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


