Return-Path: <linux-fsdevel+bounces-26974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C9495D50F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E573B2160F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C35C1940AB;
	Fri, 23 Aug 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xaf8SDd1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E304194090;
	Fri, 23 Aug 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436885; cv=none; b=uIkGYx7dwfoG8CK7iMDZA75ClGlGfRtn6RkMsmEzd1eEZiPDfW9RvADvUnQVnO0/U4uqjksAL1mp2RUFXHgUpMsGpHJ7CkQAIhOHFuRlyQ7++Yieh5Bp3B14CIlZ3p3WPPen42ETdgqaA7RStz0L/KuyPFvLta1K7sKUQcBFSgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436885; c=relaxed/simple;
	bh=ZSOsdfmqntsWB9xOX5d1iwsg8Ev03dDtx2QAYiq+4xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8EVydbDLmDPmX2CTZB83/KzeTkJfyUL0biPrymyTj8IcoPOG8g3LdWv1IPk6ppo8N7rkkpg1UAadjg5G+42PEzmL1JUwBnrInKKGQWrIzsgfQj83z57Z/+C+x2okQVhoN2Cp8ztU8uOY5NL9LfvfRHwPqJW3VAwrYnDdgQCGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xaf8SDd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9F3C4AF09;
	Fri, 23 Aug 2024 18:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724436885;
	bh=ZSOsdfmqntsWB9xOX5d1iwsg8Ev03dDtx2QAYiq+4xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xaf8SDd1OP5blG4TTn042/mGsXV9UpYRizmmS9fF9kQpShDWHZGs8RWIA4IxoRV0x
	 mqumm6HEtRphFWItvpr3DXhYdnrxMJ8lSfNNPIVwFIyYERAP5rzpzXKxtcWSflsuej
	 TH64dSEU4xWXZbtugAsJfSHROeXO6ZDFsUC/oxFAwx5Bh330fyP3yGypzKCpnGfsRl
	 c8zejZC5gT+ZKmquMxlBnYgiqNB01O/tTf6EPutGAF6nwoOVhfJJCVJKAmak2UAJM0
	 NgRjr/CKsFBUTmsOugbxTHPcQYzXlXvNnTYFA0tqs09j9gBMPWH3UNveHmZKc/wE/b
	 NI2ePD5rpQfwg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 15/19] pnfs/flexfiles: enable localio support
Date: Fri, 23 Aug 2024 14:14:13 -0400
Message-ID: <20240823181423.20458-16-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240823181423.20458-1-snitzer@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the DS is local to this client use localio to write the data.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c    | 136 +++++++++++++++++++++-
 fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
 3 files changed, 140 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 01ee52551a63..d91b640f6c05 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -11,6 +11,7 @@
 #include <linux/nfs_mount.h>
 #include <linux/nfs_page.h>
 #include <linux/module.h>
+#include <linux/file.h>
 #include <linux/sched/mm.h>
 
 #include <linux/sunrpc/metrics.h>
@@ -162,6 +163,72 @@ decode_name(struct xdr_stream *xdr, u32 *id)
 	return 0;
 }
 
+/*
+ * A dummy definition to make RCU (and non-LOCALIO compilation) happy.
+ * struct nfsd_file should never be dereferenced in this file.
+ */
+struct nfsd_file {
+       int undefined__;
+};
+
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+
+static struct nfsd_file *
+ff_local_open_fh(struct pnfs_layout_segment *lseg,
+		 u32 ds_idx,
+		 struct nfs_client *clp,
+		 const struct cred *cred,
+		 struct nfs_fh *fh,
+		 fmode_t mode)
+{
+	struct nfs4_ff_layout_mirror *mirror = FF_LAYOUT_COMP(lseg, ds_idx);
+	struct nfsd_file *nf, *new, __rcu **pnf;
+
+	if (!nfs_server_is_local(clp))
+		return NULL;
+	if (mode & FMODE_WRITE) {
+		/*
+		 * Always request read and write access since this corresponds
+		 * to a rw layout.
+		 */
+		mode |= FMODE_READ;
+		pnf = &mirror->rw_file;
+	} else
+		pnf = &mirror->ro_file;
+
+	new = NULL;
+	rcu_read_lock();
+	nf = rcu_dereference(*pnf);
+	if (!nf) {
+		rcu_read_unlock();
+		new = nfs_local_open_fh(clp, cred, fh, mode);
+		if (IS_ERR(new))
+			return NULL;
+		rcu_read_lock();
+		/* try to swap in the pointer */
+		nf = cmpxchg(pnf, NULL, new);
+		if (!nf) {
+			nf = new;
+			new = NULL;
+		}
+	}
+	nf = nfs_to.nfsd_file_get(nf);
+	rcu_read_unlock();
+	if (new)
+		nfs_to.nfsd_file_put(new);
+	return nf;
+}
+
+#else
+static struct nfsd_file *
+ff_local_open_fh(struct pnfs_layout_segment *lseg, u32 ds_idx,
+		 struct nfs_client *clp, const struct cred *cred,
+		 struct nfs_fh *fh, fmode_t mode)
+{
+	return NULL;
+}
+#endif /* IS_ENABLED(CONFIG_NFS_LOCALIO) */
+
 static bool ff_mirror_match_fh(const struct nfs4_ff_layout_mirror *m1,
 		const struct nfs4_ff_layout_mirror *m2)
 {
@@ -237,8 +304,17 @@ static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_flags)
 
 static void ff_layout_free_mirror(struct nfs4_ff_layout_mirror *mirror)
 {
-	const struct cred	*cred;
+	struct nfsd_file * __maybe_unused nf;
+	const struct cred *cred;
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	nf = rcu_access_pointer(mirror->ro_file);
+	if (nf)
+		nfs_to.nfsd_file_put(nf);
+	nf = rcu_access_pointer(mirror->rw_file);
+	if (nf)
+		nfs_to.nfsd_file_put(nf);
+#endif
 	ff_layout_remove_mirror(mirror);
 	kfree(mirror->fh_versions);
 	cred = rcu_access_pointer(mirror->ro_cred);
@@ -514,6 +590,30 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		mirror = ff_layout_add_mirror(lh, fls->mirror_array[i]);
 		if (mirror != fls->mirror_array[i]) {
 			/* swap cred ptrs so free_mirror will clean up old */
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+			if (lgr->range.iomode == IOMODE_READ) {
+				const struct cred __rcu *old =
+					xchg(&mirror->ro_cred, cred);
+				rcu_assign_pointer(fls->mirror_array[i]->ro_cred, old);
+				/* drop file if creds changed */
+				if (old != cred) {
+					struct nfsd_file *nf =
+						rcu_dereference_protected(xchg(&mirror->ro_file, NULL), 1);
+					if (nf)
+						nfs_to.nfsd_file_put(nf);
+				}
+			} else {
+				const struct cred __rcu *old =
+					xchg(&mirror->rw_cred, cred);
+				rcu_assign_pointer(fls->mirror_array[i]->rw_cred, old);
+				if (old != cred) {
+					struct nfsd_file *nf =
+						rcu_dereference_protected(xchg(&mirror->rw_file, NULL), 1);
+					if (nf)
+						nfs_to.nfsd_file_put(nf);
+				}
+			}
+#else
 			if (lgr->range.iomode == IOMODE_READ) {
 				cred = xchg(&mirror->ro_cred, cred);
 				rcu_assign_pointer(fls->mirror_array[i]->ro_cred, cred);
@@ -521,6 +621,7 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 				cred = xchg(&mirror->rw_cred, cred);
 				rcu_assign_pointer(fls->mirror_array[i]->rw_cred, cred);
 			}
+#endif /* IS_ENABLED(CONFIG_NFS_LOCALIO) */
 			ff_layout_free_mirror(fls->mirror_array[i]);
 			fls->mirror_array[i] = mirror;
 		}
@@ -1756,6 +1857,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	struct pnfs_layout_segment *lseg = hdr->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
+	struct nfsd_file *nf;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	loff_t offset = hdr->args.offset;
@@ -1802,11 +1904,19 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->args.offset = offset;
 	hdr->mds_offset = offset;
 
+	/* Start IO accounting for local read */
+	nf = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
+			      FMODE_READ);
+	if (nf) {
+		hdr->task.tk_start = ktime_get();
+		ff_layout_read_record_layoutstats_start(&hdr->task, hdr);
+	}
+
 	/* Perform an asynchronous read to ds */
 	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_read_call_ops_v3 :
 				      &ff_layout_read_call_ops_v4,
-			  0, RPC_TASK_SOFTCONN, NULL);
+			  0, RPC_TASK_SOFTCONN, nf);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1826,6 +1936,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	struct pnfs_layout_segment *lseg = hdr->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
+	struct nfsd_file *nf;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	loff_t offset = hdr->args.offset;
@@ -1870,11 +1981,19 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	 */
 	hdr->args.offset = offset;
 
+	/* Start IO accounting for local write */
+	nf = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
+				FMODE_READ|FMODE_WRITE);
+	if (nf) {
+		hdr->task.tk_start = ktime_get();
+		ff_layout_write_record_layoutstats_start(&hdr->task, hdr);
+	}
+
 	/* Perform an asynchronous write */
 	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_write_call_ops_v3 :
 				      &ff_layout_write_call_ops_v4,
-			  sync, RPC_TASK_SOFTCONN, NULL);
+			  sync, RPC_TASK_SOFTCONN, nf);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1908,6 +2027,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	struct pnfs_layout_segment *lseg = data->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
+	struct nfsd_file *nf;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	u32 idx;
@@ -1946,10 +2066,18 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	if (fh)
 		data->args.fh = fh;
 
+	/* Start IO accounting for local commit */
+	nf = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
+			      FMODE_READ|FMODE_WRITE);
+	if (nf) {
+		data->task.tk_start = ktime_get();
+		ff_layout_commit_record_layoutstats_start(&data->task, data);
+	}
+
 	ret = nfs_initiate_commit(ds_clnt, data, ds->ds_clp->rpc_ops,
 				   vers == 3 ? &ff_layout_commit_call_ops_v3 :
 					       &ff_layout_commit_call_ops_v4,
-				   how, RPC_TASK_SOFTCONN, NULL);
+				   how, RPC_TASK_SOFTCONN, nf);
 	put_cred(ds_cred);
 	return ret;
 out_err:
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index f84b3fb0dddd..562e7e27a8b5 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -82,7 +82,9 @@ struct nfs4_ff_layout_mirror {
 	struct nfs_fh			*fh_versions;
 	nfs4_stateid			stateid;
 	const struct cred __rcu		*ro_cred;
+	struct nfsd_file __rcu		*ro_file;
 	const struct cred __rcu		*rw_cred;
+	struct nfsd_file __rcu		*rw_file;
 	refcount_t			ref;
 	spinlock_t			lock;
 	unsigned long			flags;
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index e028f5a0ef5f..e58bedfb1dcc 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -395,6 +395,12 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 
 	/* connect success, check rsize/wsize limit */
 	if (!status) {
+		/*
+		 * ds_clp is put in destroy_ds().
+		 * keep ds_clp even if DS is local, so that if local IO cannot
+		 * proceed somehow, we can fall back to NFS whenever we want.
+		 */
+		nfs_local_probe(ds->ds_clp);
 		max_payload =
 			nfs_block_size(rpc_max_payload(ds->ds_clp->cl_rpcclient),
 				       NULL);
-- 
2.44.0


