Return-Path: <linux-fsdevel+bounces-50350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B578ACB0C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8990F7A99B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B266F23909C;
	Mon,  2 Jun 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb9f9a9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50B237717;
	Mon,  2 Jun 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872986; cv=none; b=jU30tVfzNooZp2aLrRqQolR7mPpJpCo4em7/qVMN7CjdY11U+IA0Chrn9ZhlcVE6pBMIHzN+hmC2JU4jnfjkc4f52zx8kKviwp2nhVI8RoJ5KSJZxmYdylp3BQN6cmAKDt5WhobR/oUlJrLLGScWSZ4JL94xV6oC1DGyhck2dQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872986; c=relaxed/simple;
	bh=cgNaQOGbQUuNTbDBhZE4Xhl8ZE+uZe9DaW6C0He81Zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEi7igU5YrDUQTpgX/l/15eqnCvJ+jtFggvBsj8M5+jEBSQmhGc8Z6IjY2sOGKscVd7f8KzkXrsUBxmojDllLknb8wXAhw7OyhQcivk9Pyp8y9OwszRGX/uYG/1AiSrK/etopQ4MIY0Gbktw+HGj/6T35rKJMrZZWIW3X/c+Qgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb9f9a9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F16C4CEF3;
	Mon,  2 Jun 2025 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872984;
	bh=cgNaQOGbQUuNTbDBhZE4Xhl8ZE+uZe9DaW6C0He81Zs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Eb9f9a9robfK75PtoOQpFCkn82rlKRabrkNZFeDaPWA0LYRrui4JKCo8CbRZkLCk6
	 zBPUMerp/giGE4g7ta0BNUGuLnp1atMKlFh+WFSDR7el0ZeuSFKAMY6R6h41sV/ux1
	 PnOY/GDZW5Momms2CG/QwdbIjQEo6AyKUjsNBIeCJHSUKQI8kBQMyOrwWlKo8ZZs50
	 FZFviFfpAFz9c1euHwI/hI1KTiHm6h8T2xbbKXhlZ9m1SvlwfmSAS1BK1aGrWz1qpS
	 +n5sGs0dpASAUe6KcOjzIHpyLUUw0pcu+qaAf2HT0fcQp//8uJTirtGLXK9rp+znoz
	 hkQPrOz4+JsAg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:02:03 -0400
Subject: [PATCH RFC v2 20/28] nfsd: add data structures for handling
 CB_NOTIFY to directory delegation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-20-a7919700de86@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8261; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cgNaQOGbQUuNTbDBhZE4Xhl8ZE+uZe9DaW6C0He81Zs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7oXfZDf9eb2xiJM9kokQlrmhspGllCmzveP
 zX2IvU0BnGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u6AAKCRAADmhBGVaC
 FcarD/491grrAfE+Ggf+lUZ/apYA+svEJW6WklIyT5c1q72Czmsnk5OsJwbjZKtRbQpDO2dMISc
 RjbATljjOvPqWEdL+PQEnnyTZ2thGWXtSVQMy8bo+TQfgFdpRMVKH9uB5I1f9hl/J/VC5IlMkMk
 FbN52OrUM2KKzgizODGwTr8nCozqII77zfRjXZIeZp62zD38Odb2kzKYhW4bN5FDQRrwHm6jy8a
 nKLGXDTrP/urE168xkWuIFGmUtsUvsEigHezfOkrzXcaEk6cTgkoDLWddnUBqNiNu5QJzqkriLC
 ZLsHqS/RBJYxNl048h2w6EKlC2qcO3KP0f0tC/BDbruH+XvVzvnfr4qTC+Ng6LLTp+A1NCYlBus
 hzeyu4+zyf3h3oIDDzGoZpxEFQQzyjnuqCHTW6iZJiKf0KO4VdrFHZcsKR1r0w3/taZMTffD3dZ
 dVqX5hP2Xi/7CV7pbUEK8HE/QJ5Gu4LaLC+WflUBklCfLq2mFmzeHG+GkTHfSWk1nPHDh51BI7d
 Cu481fix+HfCvbQv2mGQbOB0ysiFPJaNkQ5IPOo6Gzvc7z9eBqBWAx1+Uy+JMF9Nzi9cobwUN/0
 haidfId2wovFXI4zx/Kh4rdSCFem7yCMAUp3osdBEJPXRrIbDBbp7v8ozCi3KgcihYtIi6WfAaR
 Zu4szjZ67nVrkYw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When a directory delegation is created, have it allocate the necessary
data structures to collect events and run a CB_NOTIFY callback.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 143 +++++++++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/state.h     |  33 +++++++++++-
 2 files changed, 157 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ed5d6486d171ea0c886bd1f1ea1129bf4ccf429c..ebebfd6d304627d6c82bae5b84ea6c599d9e9474 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -130,6 +130,7 @@ static void free_session(struct nfsd4_session *);
 static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
+static const struct nfsd4_callback_ops nfsd4_cb_notify_ops;
 
 static struct workqueue_struct *laundry_wq;
 
@@ -1048,6 +1049,45 @@ static void nfs4_free_deleg(struct nfs4_stid *stid)
 	atomic_long_dec(&num_delegations);
 }
 
+static struct nfsd4_notify_spool *alloc_notify_spool(void)
+{
+	struct nfsd4_notify_spool *spool;
+
+	spool = kmalloc(sizeof(*spool), GFP_KERNEL);
+	if (!spool)
+		return NULL;
+
+	spool->nns_page = alloc_page(GFP_KERNEL);
+	if (!spool->nns_page) {
+		kfree(spool);
+		return NULL;
+	}
+
+	spool->nns_idx = 0;
+	spool->nns_xdr.buflen = PAGE_SIZE;
+	spool->nns_xdr.pages = &spool->nns_page;
+
+	xdr_init_encode_pages(&spool->nns_stream, &spool->nns_xdr);
+	return spool;
+}
+
+static void free_notify_spool(struct nfsd4_notify_spool *spool)
+{
+	if (spool) {
+		put_page(spool->nns_page);
+		kfree(spool);
+	}
+}
+
+static void nfs4_free_dir_deleg(struct nfs4_stid *stid)
+{
+	struct nfs4_delegation *dp = delegstateid(stid);
+
+	free_notify_spool(dp->dl_cb_notify.ncn_gather);
+	free_notify_spool(dp->dl_cb_notify.ncn_send);
+	nfs4_free_deleg(stid);
+}
+
 /*
  * When we recall a delegation, we should be careful not to hand it
  * out again straight away.
@@ -1126,29 +1166,22 @@ static void block_delegations(struct knfsd_fh *fh)
 }
 
 static struct nfs4_delegation *
-alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
-		 struct nfs4_clnt_odstate *odstate, u32 dl_type)
+__alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
+		   struct nfs4_clnt_odstate *odstate, u32 dl_type,
+		   void (*sc_free)(struct nfs4_stid *))
 {
+	struct nfs4_stid *stid = nfs4_alloc_stid(clp, deleg_slab, sc_free);
 	struct nfs4_delegation *dp;
-	struct nfs4_stid *stid;
-	long n;
 
-	dprintk("NFSD alloc_init_deleg\n");
-	n = atomic_long_inc_return(&num_delegations);
-	if (n < 0 || n > max_delegations)
-		goto out_dec;
-	if (delegation_blocked(&fp->fi_fhandle))
-		goto out_dec;
-	stid = nfs4_alloc_stid(clp, deleg_slab, nfs4_free_deleg);
 	if (stid == NULL)
-		goto out_dec;
-	dp = delegstateid(stid);
+		return NULL;
 
 	/*
 	 * delegation seqid's are never incremented.  The 4.1 special
 	 * meaning of seqid 0 isn't meaningful, really, but let's avoid
-	 * 0 anyway just for consistency and use 1:
+	 * 0 anyway just for consistency and use 1.
 	 */
+	dp = delegstateid(stid);
 	dp->dl_stid.sc_stateid.si_generation = 1;
 	INIT_LIST_HEAD(&dp->dl_perfile);
 	INIT_LIST_HEAD(&dp->dl_perclnt);
@@ -1158,19 +1191,65 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	dp->dl_type = dl_type;
 	dp->dl_retries = 1;
 	dp->dl_recalled = false;
+	get_nfs4_file(fp);
+	dp->dl_stid.sc_file = fp;
 	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
 		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
+	return dp;
+}
+
+static struct nfs4_delegation *
+alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
+		 struct nfs4_clnt_odstate *odstate, u32 dl_type)
+{
+	struct nfs4_delegation *dp;
+	long n;
+
+	dprintk("NFSD alloc_init_deleg\n");
+	n = atomic_long_inc_return(&num_delegations);
+	if (n < 0 || n > max_delegations)
+		goto out_dec;
+	if (delegation_blocked(&fp->fi_fhandle))
+		goto out_dec;
+
+	dp = __alloc_init_deleg(clp, fp, odstate, dl_type, nfs4_free_deleg);
+	if (!dp)
+		goto out_dec;
+
 	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
 			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
 	dp->dl_cb_fattr.ncf_file_modified = false;
-	get_nfs4_file(fp);
-	dp->dl_stid.sc_file = fp;
 	return dp;
 out_dec:
 	atomic_long_dec(&num_delegations);
 	return NULL;
 }
 
+static struct nfs4_delegation *
+alloc_init_dir_deleg(struct nfs4_client *clp, struct nfs4_file *fp)
+{
+	struct nfs4_delegation *dp;
+	struct nfsd4_cb_notify *cbn;
+	struct nfsd4_notify_spool *ncn;
+
+	ncn = alloc_notify_spool();
+	if (!ncn)
+		return NULL;
+
+	dp = __alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ,
+				nfs4_free_dir_deleg);
+	if (!dp) {
+		free_notify_spool(ncn);
+		return NULL;
+	}
+
+	cbn = &dp->dl_cb_notify;
+	cbn->ncn_gather = ncn;
+	nfsd4_init_cb(&cbn->ncn_cb, dp->dl_stid.sc_client,
+			&nfsd4_cb_notify_ops, NFSPROC4_CLNT_CB_NOTIFY);
+	return dp;
+}
+
 void
 nfs4_put_stid(struct nfs4_stid *s)
 {
@@ -3197,6 +3276,30 @@ nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
 	nfs4_put_stid(&dp->dl_stid);
 }
 
+static int
+nfsd4_cb_notify_done(struct nfsd4_callback *cb,
+				struct rpc_task *task)
+{
+	switch (task->tk_status) {
+	case -NFS4ERR_DELAY:
+		rpc_delay(task, 2 * HZ);
+		return 0;
+	default:
+		return 1;
+	}
+}
+
+static void
+nfsd4_cb_notify_release(struct nfsd4_callback *cb)
+{
+	struct nfsd4_cb_notify *ncn =
+			container_of(cb, struct nfsd4_cb_notify, ncn_cb);
+	struct nfs4_delegation *dp =
+			container_of(ncn, struct nfs4_delegation, dl_cb_notify);
+
+	nfs4_put_stid(&dp->dl_stid);
+}
+
 static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
 	.done		= nfsd4_cb_recall_any_done,
 	.release	= nfsd4_cb_recall_any_release,
@@ -3209,6 +3312,12 @@ static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
 	.opcode		= OP_CB_GETATTR,
 };
 
+static const struct nfsd4_callback_ops nfsd4_cb_notify_ops = {
+	.done		= nfsd4_cb_notify_done,
+	.release	= nfsd4_cb_notify_release,
+	.opcode		= OP_CB_NOTIFY,
+};
+
 static void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
 {
 	struct nfs4_delegation *dp =
@@ -9350,7 +9459,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 
 	/* Try to set up the lease */
 	status = -ENOMEM;
-	dp = alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ);
+	dp = alloc_init_dir_deleg(clp, fp);
 	if (!dp)
 		goto out_delegees;
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 5f21c79be032cc1334a301aad73e6bbcc8da5eb0..706bbc7076a4f1d0be3ea7067d193683821d74eb 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -188,6 +188,31 @@ struct nfs4_cb_fattr {
 	u64 ncf_cur_fsize;
 };
 
+#define NFSD4_NOTIFY_SPOOL_SZ	16
+
+/* A place to collect notifications */
+struct nfsd4_notify_spool {
+	struct xdr_stream	nns_stream;
+	struct xdr_buf		nns_xdr;
+	struct page		*nns_page;
+	struct notify4		nns_ent[NFSD4_NOTIFY_SPOOL_SZ];
+	u32			nns_idx;
+};
+
+/*
+ * Represents a directory delegation. The callback is for handling CB_NOTIFYs.
+ * As notifications from fsnotify come in, encode the relevant notify_*4 in the
+ * ncn_stream, and append a new ncn_notify_array value.
+ *
+ * Periodically, fire off a CB_NOTIFY request to the server. Replace the with
+ * new ones and send the request.
+ */
+struct nfsd4_cb_notify {
+	struct nfsd4_callback		ncn_cb;
+	struct nfsd4_notify_spool	*ncn_gather;
+	struct nfsd4_notify_spool	*ncn_send;
+};
+
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is
@@ -222,8 +247,12 @@ struct nfs4_delegation {
 	struct nfsd4_callback	dl_recall;
 	bool			dl_recalled;
 
-	/* for CB_GETATTR */
-	struct nfs4_cb_fattr    dl_cb_fattr;
+	union {
+		/* for CB_GETATTR */
+		struct nfs4_cb_fattr    dl_cb_fattr;
+		/* for CB_NOTIFY */
+		struct nfsd4_cb_notify	dl_cb_notify;
+	};
 };
 
 static inline bool deleg_is_read(u32 dl_type)

-- 
2.49.0


