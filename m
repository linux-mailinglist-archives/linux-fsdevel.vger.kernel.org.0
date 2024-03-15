Return-Path: <linux-fsdevel+bounces-14502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B9B87D1FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9050A283B48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06555CDCF;
	Fri, 15 Mar 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wb+Qc0GX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AAA5C915;
	Fri, 15 Mar 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521632; cv=none; b=SRhE03AmPwqc9U6OPyTvZ27pEUnFQhIUBLqizULbwo5dDR7179tlqsY6qv3quzQGp9lg9nmpcArCpoxeDPZVjD8qGFoGyHyH5K/kuqbS9gbFmUwoGNqmwNVcuLfxWoAYtQhJAdIxvEkcX0nERMzSxrMylOpYwsVXQeCqfnTjUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521632; c=relaxed/simple;
	bh=E3Rg3kkD+gy8X3aCYOuF+O+8BvFkDxP+5wAmPwAh5m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tfPcMAb0UZ26dX9YbReNqvsEVvQZlD2CuJt4q0iQG/bX/BTzOhJFQ689rCEZeGr2Y7eyNluh6bFcRVKE3AC4WTjpLqCgMMHgCkdK9ThrSoUiWzR3HMuOBiVqca9HQxSXAmKFShJ4mQAxTMRBcp3zjsprb9InT8wIT89y1WeoPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wb+Qc0GX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB99C433B2;
	Fri, 15 Mar 2024 16:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521631;
	bh=E3Rg3kkD+gy8X3aCYOuF+O+8BvFkDxP+5wAmPwAh5m0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wb+Qc0GXVF7eeAiW+XKy9AlNdqMfznl8Erywiln6xVKUveWp7DHTWR8N4bRH2hN7p
	 DY1AzJudXZV5DoG5S3GUsGHEXj4Y2TlBSYqkvVtW7St0VrMIBWxpR7DD7FfgklOmbG
	 +S8c31NjUoVOhxjxD+hJ659/eqLloGuUEqt7UDDdSqlji0yWpJLVzSfCvwP/v5Hni5
	 t/TuD+hL9QpTMDwo+eVSvJ/QPWPw1YdshOg3gTRDXbYQLffp5QBaSExcZcNynbLvdn
	 llYD0SbHZ3xYfzyB86BsPO6yN0kL+XnJEEr/OyJ5GiF/3HDWexqo4P/G6F2OfjCAuO
	 DCKg3OFRQqtiQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:05 -0400
Subject: [PATCH RFC 14/24] nfsd: wire up GET_DIR_DELEGATION handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-14-a1d6209a3654@kernel.org>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
In-Reply-To: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4280; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=E3Rg3kkD+gy8X3aCYOuF+O+8BvFkDxP+5wAmPwAh5m0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9Hzu4JN3etDmC5GP88NjXXGCimqbuhBMctpmW
 a/PlYZk/9+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87gAKCRAADmhBGVaC
 FYJGD/4sn1x3g06/fMwln0LglXhz+4hJ9Bu4hx1uvW3du3FRFkKsGBFWg2NzpMmcUWNti1x8MgQ
 YVfYP3Ewh2aWAahDrQvRnbJ5R0esrxyqsGHHmPKLmIKNw0mn/6kS/cZzKa9kLx8kBwPaYS5yje2
 t/3vTIKXj3B5ktY+2Lb5v5yuyxmAchDQaw3dvtRRV4cTh4nM7VqjTOMUtaR/9TTzsHosB0V2sJo
 2uNy1mWyvpd5/mc23wMhFZtNCUVM8AbAiXbzWAHZz6HmWncsBJNHsAUhnOk4pE8jqNhqFzXxdjb
 tvSLeLxNSEgpEkSPLFkfYawn7LLCWYBTtMST8cK6AMbBJDgLhmZZ/FY881vGWXhfWceg7xXZC2M
 BPHDpz6u64ISPl6R19Kzgjf0CILwSwZuljdm+aU9v3c9tX/J75sOOUFvteCHTK7vHjWUWQs1nmg
 WqosuPrKt7cJGx9G+SHArcIPSYw58Q+xPVOre8oSYuojtVjNJkS7jfpCKVKI90vjGkx0dwkq2cm
 qB8Clgab166AYivaYzaniYr+B0riJuJezZ7J1q+n2LATX40ogD2MAGULw6FxzIpZAyc6sLJdfpF
 RBhFbi7Iv5sqEFTPhMDx86jeMzVtyV67ThY+FFt//dVTZE2+P+PN2iuMbzIoBUMSXKDiIEJlPQ0
 22I4esVSA1gdzKw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new routine for acquiring a read delegation on a directory. Since
the same CB_RECALL/DELEGRETURN infrastrure is used for regular and
directory delegations, we can just use a normal nfs4_delegation to
represent it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  | 23 ++++++++++++++++--
 fs/nfsd/nfs4state.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/state.h     |  5 ++++
 3 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7973fe17bf3c..1a2c90f4ea53 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2179,9 +2179,28 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
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
+
+	dd = nfsd_get_dir_deleg(cstate, gdd, nf);
+	if (IS_ERR(dd)) {
+		int err = PTR_ERR(dd);
+
+		if (err != -EAGAIN)
+			return nfserrno(err);
+		gdd->nf_status = GDD4_UNAVAIL;
+		return nfs_ok;
+	}
 
-	/* FIXME: actually return a delegation */
-	gdd->nf_status = GDD4_UNAVAIL;
+	gdd->nf_status = GDD4_OK;
+	memcpy(&gdd->stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->stateid));
+	memset(&gdd->cookieverf, '\0', sizeof(gdd->cookieverf));
+	nfs4_put_stid(&dd->dl_stid);
 	return nfs_ok;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 778c1c6e3b54..36574aedc211 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8874,7 +8874,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
 			}
 break_lease:
 			nfsd_stats_wdeleg_getattr_inc(nn);
-			dp = fl->fl_owner;
+			dp = fl->c.flc_owner;
 			ncf = &dp->dl_cb_fattr;
 			nfs4_cb_getattr(&dp->dl_cb_fattr);
 			spin_unlock(&ctx->flc_lock);
@@ -8912,3 +8912,70 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
 	spin_unlock(&ctx->flc_lock);
 	return 0;
 }
+
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
+	status = -ENOMEM;
+	dp = alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ);
+	if (!dp)
+		goto out_delegees;
+
+	fl = nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
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
+	spin_lock(&state_lock);
+	spin_lock(&clp->cl_lock);
+	spin_lock(&fp->fi_lock);
+	status = hash_delegation_locked(dp, fp);
+	spin_unlock(&fp->fi_lock);
+	spin_unlock(&clp->cl_lock);
+	spin_unlock(&state_lock);
+
+	if (status)
+		goto out_unlock;
+
+	return dp;
+out_unlock:
+	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
+out_put_stid:
+	nfs4_put_stid(&dp->dl_stid);
+out_delegees:
+	put_deleg_file(fp);
+	return ERR_PTR(status);
+}
+
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 01c6f3445646..20551483cc7b 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -782,4 +782,9 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 
 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
 		struct inode *inode, bool *file_modified, u64 *size);
+
+struct nfsd4_get_dir_delegation;
+struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
+						struct nfsd4_get_dir_delegation *gdd,
+						struct nfsd_file *nf);
 #endif   /* NFSD4_STATE_H */

-- 
2.44.0


