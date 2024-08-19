Return-Path: <linux-fsdevel+bounces-26309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93C19572F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FDB0B24A2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7690218B494;
	Mon, 19 Aug 2024 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX+H8xYf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ECB18B46F;
	Mon, 19 Aug 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091503; cv=none; b=KkUjSb3SzmM/85Jl/uMRNRiP5B8vEcaUGRAcQnqhlbf+lIH4i8YmEAcHM7xs7rvJK0cWEfDLmHhDGuB15FCD/png4S5DPKSH4YiodA09eODroEGEoDu3gV6Z97hi38sLKYWmVlP+OP2ZiL/xMGqmm+LutBExVkV33GLH/Q0QC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091503; c=relaxed/simple;
	bh=sHwFqtE2NbxQxRXSVumyXwo/c68mVLc2REYswVL/EK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbHtNd+non0shwlf444/kjCDZfSHJE/TLztgqRnQ357dhzgTzyVpyWWEq/HNpBnf1pG7YBv1BIiEiuqNgNBN0+iOIzjeZmcrtoGHgjDr8yZRdpyVVyIK+7ca5spBjkbUkDquMGeF/rQXiYMrdE6rGn/uKK5BU1U1kTNK7JQzOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX+H8xYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37749C4AF0E;
	Mon, 19 Aug 2024 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091503;
	bh=sHwFqtE2NbxQxRXSVumyXwo/c68mVLc2REYswVL/EK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dX+H8xYfqz6RC1lN/nnbQPG5IXKNqot6pvb0jdCqX8KTcYvR1YGOHM1pjR5qfo389
	 frs9xBCHT5hPg14OYJC+6IFBG93T4x6SVFFBfr8XTpji1aTMyO03WvooE7mlVJOv+e
	 exT1XJY7bZ3ibYkM+T8mOHQSc3SrQxXNyd9n7G1lV/FNvFG+RrY0+oDMfB5POVwfx5
	 RrOU/KV0Dv9VGTXOfQXTbf99VGLq0risFK93+C0gxwBV9AjFFIZrLNMqp5IeA2Xpq9
	 oYqqvo1ITBpmUeChDFbAWl99lSVS9dBnFfCIzajsgoXu6z7paMs+56wKMda6ctBRw8
	 BrMEQxmPBzKPg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 23/24] nfs: switch client to use nfsd_file for localio
Date: Mon, 19 Aug 2024 14:17:28 -0400
Message-ID: <20240819181750.70570-24-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819181750.70570-1-snitzer@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The most interesting changes in this commit are those dealing with the
shift to make proper use of nfsd_file so that its lifetime (before
nfsd_file_put is called) is extended until after commit, read and
write operations.

So rather than immediately call nfsd_file_put() in
nfs_local_open_fh(), nfsd_file_put() isn't called until
nfs_local_pgio_release() for read/write and not until
nfs_local_release_commit_data() for commit.

Aside from that, the bulk of the changes are just various mechanical
changes to switch localio code from passing a file pointer to passing
an nfsd_file pointer.  But the flexfilelayout.c changes also dealt
with the unfortunate business of back-filling conditional compilation
for the non-LOCALIO case because otherwise the 'nfs_to' symbol would
be unavailable (only localio code is dependent on 'nfs_to').

With an fio test that issues 128K directio reads with 24 threads to
the same file, for 20 secs, there are noticably fewer nfsd_file
allocations and a slight performance improvement:

Before this commit:

  read: IOPS=260k, BW=31.7GiB/s (34.0GB/s)(634GiB/20001msec)

  # cat /proc/fs/nfsd/filecache
  total inodes:  0
  hash buckets:  256
  lru entries:   0
  cache hits:    4628466
  acquisitions:  5191234
  allocations:   827632
  releases:      827632
  evictions:     0
  mean age (ms): 0

After this commit:

 read: IOPS=311k, BW=38.0GiB/s (40.8GB/s)(760GiB/20001msec)

  # cat /proc/fs/nfsd/filecache
  total inodes:  0
  hash buckets:  256
  lru entries:   0
  cache hits:    6224711
  acquisitions:  6224712
  allocations:   1
  releases:      1
  evictions:     1
  mean age (ms): 23786
  mean age (ms): 23198

It should be noted that while making proper use of nfsd_file and
nfsd's filecache offers a clear performance win, it still comes up
short compared to simply caching the open file in the client:

  read: IOPS=375k, BW=45.7GiB/s (49.1GB/s)(915GiB/20002msec)

  # cat /proc/fs/nfsd/filecache
  total inodes:  0
  hash buckets:  256
  lru entries:   0
  cache hits:    11
  acquisitions:  24
  allocations:   14
  releases:      14
  evictions:     0
  mean age (ms): 0

But caching the open file in the client has object lifetime problems
and is avoided because otherwise the client would disallow proper
refcounting and release of each nfsd export's backing filesystem.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 123 ++++++++++++++++---------
 fs/nfs/flexfilelayout/flexfilelayout.h |   4 +-
 fs/nfs/internal.h                      |  31 ++++---
 fs/nfs/localio.c                       |  74 +++++++--------
 fs/nfs/pagelist.c                      |  10 +-
 fs/nfs/write.c                         |  10 +-
 6 files changed, 144 insertions(+), 108 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 206b4b524e43..d91b640f6c05 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -163,7 +163,17 @@ decode_name(struct xdr_stream *xdr, u32 *id)
 	return 0;
 }
 
-static struct file *
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
 ff_local_open_fh(struct pnfs_layout_segment *lseg,
 		 u32 ds_idx,
 		 struct nfs_client *clp,
@@ -172,7 +182,7 @@ ff_local_open_fh(struct pnfs_layout_segment *lseg,
 		 fmode_t mode)
 {
 	struct nfs4_ff_layout_mirror *mirror = FF_LAYOUT_COMP(lseg, ds_idx);
-	struct file *filp, *new, __rcu **pfile;
+	struct nfsd_file *nf, *new, __rcu **pnf;
 
 	if (!nfs_server_is_local(clp))
 		return NULL;
@@ -182,33 +192,43 @@ ff_local_open_fh(struct pnfs_layout_segment *lseg,
 		 * to a rw layout.
 		 */
 		mode |= FMODE_READ;
-		pfile = &mirror->rw_file;
+		pnf = &mirror->rw_file;
 	} else
-		pfile = &mirror->ro_file;
+		pnf = &mirror->ro_file;
 
 	new = NULL;
 	rcu_read_lock();
-	filp = rcu_dereference(*pfile);
-	if (!filp) {
+	nf = rcu_dereference(*pnf);
+	if (!nf) {
 		rcu_read_unlock();
 		new = nfs_local_open_fh(clp, cred, fh, mode);
 		if (IS_ERR(new))
 			return NULL;
 		rcu_read_lock();
 		/* try to swap in the pointer */
-		filp = cmpxchg(pfile, NULL, new);
-		if (!filp) {
-			filp = new;
+		nf = cmpxchg(pnf, NULL, new);
+		if (!nf) {
+			nf = new;
 			new = NULL;
 		}
 	}
-	filp = get_file_rcu(&filp);
+	nf = nfs_to.nfsd_file_get(nf);
 	rcu_read_unlock();
 	if (new)
-		fput(new);
-	return filp;
+		nfs_to.nfsd_file_put(new);
+	return nf;
 }
 
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
@@ -284,15 +304,17 @@ static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_flags)
 
 static void ff_layout_free_mirror(struct nfs4_ff_layout_mirror *mirror)
 {
-	struct file *filp;
-	const struct cred	*cred;
+	struct nfsd_file * __maybe_unused nf;
+	const struct cred *cred;
 
-	filp = rcu_access_pointer(mirror->ro_file);
-	if (filp)
-		fput(filp);
-	filp = rcu_access_pointer(mirror->rw_file);
-	if (filp)
-		fput(filp);
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
@@ -468,7 +490,6 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		struct nfs4_ff_layout_mirror *mirror;
 		struct cred *kcred;
 		const struct cred __rcu *cred;
-		const struct cred __rcu *old;
 		kuid_t uid;
 		kgid_t gid;
 		u32 ds_count, fh_count, id;
@@ -568,27 +589,39 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 
 		mirror = ff_layout_add_mirror(lh, fls->mirror_array[i]);
 		if (mirror != fls->mirror_array[i]) {
-			struct file *filp;
-
 			/* swap cred ptrs so free_mirror will clean up old */
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
 			if (lgr->range.iomode == IOMODE_READ) {
-				old = xchg(&mirror->ro_cred, cred);
+				const struct cred __rcu *old =
+					xchg(&mirror->ro_cred, cred);
 				rcu_assign_pointer(fls->mirror_array[i]->ro_cred, old);
 				/* drop file if creds changed */
 				if (old != cred) {
-					filp = rcu_dereference_protected(xchg(&mirror->ro_file, NULL), 1);
-					if (filp)
-						fput(filp);
+					struct nfsd_file *nf =
+						rcu_dereference_protected(xchg(&mirror->ro_file, NULL), 1);
+					if (nf)
+						nfs_to.nfsd_file_put(nf);
 				}
 			} else {
-				old = xchg(&mirror->rw_cred, cred);
+				const struct cred __rcu *old =
+					xchg(&mirror->rw_cred, cred);
 				rcu_assign_pointer(fls->mirror_array[i]->rw_cred, old);
 				if (old != cred) {
-					filp = rcu_dereference_protected(xchg(&mirror->rw_file, NULL), 1);
-					if (filp)
-						fput(filp);
+					struct nfsd_file *nf =
+						rcu_dereference_protected(xchg(&mirror->rw_file, NULL), 1);
+					if (nf)
+						nfs_to.nfsd_file_put(nf);
 				}
 			}
+#else
+			if (lgr->range.iomode == IOMODE_READ) {
+				cred = xchg(&mirror->ro_cred, cred);
+				rcu_assign_pointer(fls->mirror_array[i]->ro_cred, cred);
+			} else {
+				cred = xchg(&mirror->rw_cred, cred);
+				rcu_assign_pointer(fls->mirror_array[i]->rw_cred, cred);
+			}
+#endif /* IS_ENABLED(CONFIG_NFS_LOCALIO) */
 			ff_layout_free_mirror(fls->mirror_array[i]);
 			fls->mirror_array[i] = mirror;
 		}
@@ -1824,7 +1857,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	struct pnfs_layout_segment *lseg = hdr->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
-	struct file *filp;
+	struct nfsd_file *nf;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	loff_t offset = hdr->args.offset;
@@ -1872,9 +1905,9 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->mds_offset = offset;
 
 	/* Start IO accounting for local read */
-	filp = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
-				FMODE_READ);
-	if (filp) {
+	nf = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
+			      FMODE_READ);
+	if (nf) {
 		hdr->task.tk_start = ktime_get();
 		ff_layout_read_record_layoutstats_start(&hdr->task, hdr);
 	}
@@ -1883,7 +1916,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_read_call_ops_v3 :
 				      &ff_layout_read_call_ops_v4,
-			  0, RPC_TASK_SOFTCONN, filp);
+			  0, RPC_TASK_SOFTCONN, nf);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1903,7 +1936,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	struct pnfs_layout_segment *lseg = hdr->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
-	struct file *filp;
+	struct nfsd_file *nf;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	loff_t offset = hdr->args.offset;
@@ -1949,9 +1982,9 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	hdr->args.offset = offset;
 
 	/* Start IO accounting for local write */
-	filp = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
+	nf = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
 				FMODE_READ|FMODE_WRITE);
-	if (filp) {
+	if (nf) {
 		hdr->task.tk_start = ktime_get();
 		ff_layout_write_record_layoutstats_start(&hdr->task, hdr);
 	}
@@ -1960,7 +1993,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_write_call_ops_v3 :
 				      &ff_layout_write_call_ops_v4,
-			  sync, RPC_TASK_SOFTCONN, filp);
+			  sync, RPC_TASK_SOFTCONN, nf);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1994,7 +2027,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	struct pnfs_layout_segment *lseg = data->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
-	struct file *filp;
+	struct nfsd_file *nf;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	u32 idx;
@@ -2034,9 +2067,9 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 		data->args.fh = fh;
 
 	/* Start IO accounting for local commit */
-	filp = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
-				FMODE_READ|FMODE_WRITE);
-	if (filp) {
+	nf = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
+			      FMODE_READ|FMODE_WRITE);
+	if (nf) {
 		data->task.tk_start = ktime_get();
 		ff_layout_commit_record_layoutstats_start(&data->task, data);
 	}
@@ -2044,7 +2077,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	ret = nfs_initiate_commit(ds_clnt, data, ds->ds_clp->rpc_ops,
 				   vers == 3 ? &ff_layout_commit_call_ops_v3 :
 					       &ff_layout_commit_call_ops_v4,
-				   how, RPC_TASK_SOFTCONN, filp);
+				   how, RPC_TASK_SOFTCONN, nf);
 	put_cred(ds_cred);
 	return ret;
 out_err:
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index 8e042df5a2c9..562e7e27a8b5 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -82,9 +82,9 @@ struct nfs4_ff_layout_mirror {
 	struct nfs_fh			*fh_versions;
 	nfs4_stateid			stateid;
 	const struct cred __rcu		*ro_cred;
-	struct file __rcu		*ro_file;
+	struct nfsd_file __rcu		*ro_file;
 	const struct cred __rcu		*rw_cred;
-	struct file __rcu		*rw_file;
+	struct nfsd_file __rcu		*rw_file;
 	refcount_t			ref;
 	spinlock_t			lock;
 	unsigned long			flags;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 23f0d180fd19..a7677a16e929 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -309,7 +309,7 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *, struct nfs_pgio_header *);
 int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 		      const struct cred *cred, const struct nfs_rpc_ops *rpc_ops,
 		      const struct rpc_call_ops *call_ops, int how, int flags,
-		      struct file *localio);
+		      struct nfsd_file *localio);
 void nfs_free_request(struct nfs_page *req);
 struct nfs_pgio_mirror *
 nfs_pgio_current_mirror(struct nfs_pageio_descriptor *desc);
@@ -455,43 +455,46 @@ extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 /* localio.c */
 extern void nfs_local_disable(struct nfs_client *);
 extern void nfs_local_probe(struct nfs_client *);
-extern struct file *nfs_local_open_fh(struct nfs_client *, const struct cred *,
-				      struct nfs_fh *, const fmode_t);
-extern struct file *nfs_local_file_open(struct nfs_client *clp,
-					const struct cred *cred,
-					struct nfs_fh *fh,
-					struct nfs_open_context *ctx);
-extern int nfs_local_doio(struct nfs_client *, struct file *,
+extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
+					   const struct cred *,
+					   struct nfs_fh *,
+					   const fmode_t);
+extern struct nfsd_file *nfs_local_file_open(struct nfs_client *clp,
+					     const struct cred *cred,
+					     struct nfs_fh *fh,
+					     struct nfs_open_context *ctx);
+extern int nfs_local_doio(struct nfs_client *, struct nfsd_file *,
 			  struct nfs_pgio_header *,
 			  const struct rpc_call_ops *);
-extern int nfs_local_commit(struct file *, struct nfs_commit_data *,
+extern int nfs_local_commit(struct nfsd_file *, struct nfs_commit_data *,
 			    const struct rpc_call_ops *, int);
 extern bool nfs_server_is_local(const struct nfs_client *clp);
 
 #else
 static inline void nfs_local_disable(struct nfs_client *clp) {}
 static inline void nfs_local_probe(struct nfs_client *clp) {}
-static inline struct file *nfs_local_open_fh(struct nfs_client *clp,
+static inline struct nfsd_file *nfs_local_open_fh(struct nfs_client *clp,
 					const struct cred *cred,
 					struct nfs_fh *fh,
 					const fmode_t mode)
 {
 	return ERR_PTR(-EINVAL);
 }
-static inline struct file *nfs_local_file_open(struct nfs_client *clp,
+static inline struct nfsd_file *nfs_local_file_open(struct nfs_client *clp,
 					const struct cred *cred,
 					struct nfs_fh *fh,
 					struct nfs_open_context *ctx)
 {
 	return NULL;
 }
-static inline int nfs_local_doio(struct nfs_client *clp, struct file *filep,
+static inline int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *nf,
 				struct nfs_pgio_header *hdr,
 				const struct rpc_call_ops *call_ops)
 {
 	return -EINVAL;
 }
-static inline int nfs_local_commit(struct file *filep, struct nfs_commit_data *data,
+static inline int nfs_local_commit(struct nfsd_file *nf,
+				struct nfs_commit_data *data,
 				const struct rpc_call_ops *call_ops, int how)
 {
 	return -EINVAL;
@@ -582,7 +585,7 @@ extern int nfs_initiate_commit(struct rpc_clnt *clnt,
 			       const struct nfs_rpc_ops *nfs_ops,
 			       const struct rpc_call_ops *call_ops,
 			       int how, int flags,
-			       struct file *localio);
+			       struct nfsd_file *localio);
 extern void nfs_init_commit(struct nfs_commit_data *data,
 			    struct list_head *head,
 			    struct pnfs_layout_segment *lseg,
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 7d63d7e34643..718114e52da4 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -35,10 +35,11 @@ struct nfs_local_kiocb {
 	struct bio_vec		*bvec;
 	struct nfs_pgio_header	*hdr;
 	struct work_struct	work;
+	struct nfsd_file	*nf;
 };
 
 struct nfs_local_fsync_ctx {
-	struct file		*filp;
+	struct nfsd_file	*nf;
 	struct nfs_commit_data	*data;
 	struct work_struct	work;
 	struct kref		kref;
@@ -228,15 +229,14 @@ void nfs_local_probe(struct nfs_client *clp)
 EXPORT_SYMBOL_GPL(nfs_local_probe);
 
 /*
- * nfs_local_open_fh - open a local filehandle
+ * nfs_local_open_fh - open a local filehandle in terms of nfsd_file
  *
- * Returns a pointer to a struct file or an ERR_PTR
+ * Returns a pointer to a struct nfsd_file or an ERR_PTR
  */
-struct file *
+struct nfsd_file *
 nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		  struct nfs_fh *fh, const fmode_t mode)
 {
-	struct file *filp;
 	struct nfsd_file *nf;
 	int status;
 
@@ -258,26 +258,24 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		}
 		return ERR_PTR(status);
 	}
-	filp = get_file(nfs_to.nfsd_file_file(nf));
-	nfs_to.nfsd_file_put(nf);
-	return filp;
+	return nf;
 }
 EXPORT_SYMBOL_GPL(nfs_local_open_fh);
 
-struct file *
+struct nfsd_file *
 nfs_local_file_open(struct nfs_client *clp, const struct cred *cred,
 		    struct nfs_fh *fh, struct nfs_open_context *ctx)
 {
-	struct file *filp;
+	struct nfsd_file *nf;
 
 	if (!nfs_server_is_local(clp))
 		return NULL;
 
-	filp = nfs_local_open_fh(clp, cred, fh, ctx->mode);
-	if (IS_ERR(filp))
+	nf = nfs_local_open_fh(clp, cred, fh, ctx->mode);
+	if (IS_ERR(nf))
 		return NULL;
 
-	return filp;
+	return nf;
 }
 
 static struct bio_vec *
@@ -305,7 +303,7 @@ nfs_local_iocb_free(struct nfs_local_kiocb *iocb)
 }
 
 static struct nfs_local_kiocb *
-nfs_local_iocb_alloc(struct nfs_pgio_header *hdr, struct file *filp,
+nfs_local_iocb_alloc(struct nfs_pgio_header *hdr, struct nfsd_file *nf,
 		gfp_t flags)
 {
 	struct nfs_local_kiocb *iocb;
@@ -319,8 +317,9 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr, struct file *filp,
 		kfree(iocb);
 		return NULL;
 	}
-	init_sync_kiocb(&iocb->kiocb, filp);
+	init_sync_kiocb(&iocb->kiocb, nfs_to.nfsd_file_file(nf));
 	iocb->kiocb.ki_pos = hdr->args.offset;
+	iocb->nf = nf;
 	iocb->hdr = hdr;
 	iocb->kiocb.ki_flags &= ~IOCB_APPEND;
 	return iocb;
@@ -372,7 +371,7 @@ nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
 
-	fput(iocb->kiocb.ki_filp);
+	nfs_to.nfsd_file_put(iocb->nf);
 	nfs_local_iocb_free(iocb);
 	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
 }
@@ -415,7 +414,7 @@ static void nfs_local_call_read(struct work_struct *work)
 	revert_creds(save_cred);
 }
 
-static int nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
+static int nfs_do_local_read(struct nfs_pgio_header *hdr, struct nfsd_file *nf,
 			     const struct rpc_call_ops *call_ops)
 {
 	struct nfs_local_kiocb *iocb;
@@ -423,7 +422,7 @@ static int nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
 	dprintk("%s: vfs_read count=%u pos=%llu\n",
 		__func__, hdr->args.count, hdr->args.offset);
 
-	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_KERNEL);
+	iocb = nfs_local_iocb_alloc(hdr, nf, GFP_KERNEL);
 	if (iocb == NULL)
 		return -ENOMEM;
 
@@ -466,7 +465,6 @@ nfs_set_local_verifier(struct inode *inode,
 		struct nfs_writeverf *verf,
 		enum nfs3_stable_how how)
 {
-
 	nfs_copy_boot_verifier(&verf->verifier, inode);
 	verf->committed = how;
 }
@@ -588,7 +586,7 @@ static void nfs_local_call_write(struct work_struct *work)
 	current->flags = old_flags;
 }
 
-static int nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
+static int nfs_do_local_write(struct nfs_pgio_header *hdr, struct nfsd_file *nf,
 			      const struct rpc_call_ops *call_ops)
 {
 	struct nfs_local_kiocb *iocb;
@@ -597,7 +595,7 @@ static int nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
 		__func__, hdr->args.count, hdr->args.offset,
 		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
 
-	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_NOIO);
+	iocb = nfs_local_iocb_alloc(hdr, nf, GFP_NOIO);
 	if (iocb == NULL)
 		return -ENOMEM;
 
@@ -621,11 +619,12 @@ static int nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
 }
 
 int
-nfs_local_doio(struct nfs_client *clp, struct file *filp,
+nfs_local_doio(struct nfs_client *clp, struct nfsd_file *nf,
 	       struct nfs_pgio_header *hdr,
 	       const struct rpc_call_ops *call_ops)
 {
 	int status = 0;
+	struct file *filp = nfs_to.nfsd_file_file(nf);
 
 	if (!hdr->args.count)
 		return 0;
@@ -633,24 +632,24 @@ nfs_local_doio(struct nfs_client *clp, struct file *filp,
 	if (!filp->f_op->read_iter || !filp->f_op->write_iter) {
 		nfs_local_disable(clp);
 		status = -EAGAIN;
-		goto out_fput;
+		goto out;
 	}
 
 	switch (hdr->rw_mode) {
 	case FMODE_READ:
-		status = nfs_do_local_read(hdr, filp, call_ops);
+		status = nfs_do_local_read(hdr, nf, call_ops);
 		break;
 	case FMODE_WRITE:
-		status = nfs_do_local_write(hdr, filp, call_ops);
+		status = nfs_do_local_write(hdr, nf, call_ops);
 		break;
 	default:
 		dprintk("%s: invalid mode: %d\n", __func__,
 			hdr->rw_mode);
 		status = -EINVAL;
 	}
-out_fput:
+out:
 	if (status != 0) {
-		fput(filp);
+		nfs_to.nfsd_file_put(nf);
 		hdr->task.tk_status = status;
 		nfs_local_hdr_release(hdr, call_ops);
 	}
@@ -697,23 +696,23 @@ nfs_local_commit_done(struct nfs_commit_data *data, int status)
 }
 
 static void
-nfs_local_release_commit_data(struct file *filp,
+nfs_local_release_commit_data(struct nfsd_file *nf,
 		struct nfs_commit_data *data,
 		const struct rpc_call_ops *call_ops)
 {
-	fput(filp);
+	nfs_to.nfsd_file_put(nf);
 	call_ops->rpc_call_done(&data->task, data);
 	call_ops->rpc_release(data);
 }
 
 static struct nfs_local_fsync_ctx *
-nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data, struct file *filp,
-		gfp_t flags)
+nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data,
+			  struct nfsd_file *nf, gfp_t flags)
 {
 	struct nfs_local_fsync_ctx *ctx = kmalloc(sizeof(*ctx), flags);
 
 	if (ctx != NULL) {
-		ctx->filp = filp;
+		ctx->nf = nf;
 		ctx->data = data;
 		INIT_WORK(&ctx->work, nfs_local_fsync_work);
 		kref_init(&ctx->kref);
@@ -737,7 +736,7 @@ nfs_local_fsync_ctx_put(struct nfs_local_fsync_ctx *ctx)
 static void
 nfs_local_fsync_ctx_free(struct nfs_local_fsync_ctx *ctx)
 {
-	nfs_local_release_commit_data(ctx->filp, ctx->data,
+	nfs_local_release_commit_data(ctx->nf, ctx->data,
 			ctx->data->task.tk_ops);
 	nfs_local_fsync_ctx_put(ctx);
 }
@@ -750,7 +749,8 @@ nfs_local_fsync_work(struct work_struct *work)
 
 	ctx = container_of(work, struct nfs_local_fsync_ctx, work);
 
-	status = nfs_local_run_commit(ctx->filp, ctx->data);
+	status = nfs_local_run_commit(nfs_to.nfsd_file_file(ctx->nf),
+				      ctx->data);
 	nfs_local_commit_done(ctx->data, status);
 	if (ctx->done != NULL)
 		complete(ctx->done);
@@ -758,15 +758,15 @@ nfs_local_fsync_work(struct work_struct *work)
 }
 
 int
-nfs_local_commit(struct file *filp, struct nfs_commit_data *data,
+nfs_local_commit(struct nfsd_file *nf, struct nfs_commit_data *data,
 		 const struct rpc_call_ops *call_ops, int how)
 {
 	struct nfs_local_fsync_ctx *ctx;
 
-	ctx = nfs_local_fsync_ctx_alloc(data, filp, GFP_KERNEL);
+	ctx = nfs_local_fsync_ctx_alloc(data, nf, GFP_KERNEL);
 	if (!ctx) {
 		nfs_local_commit_done(data, -ENOMEM);
-		nfs_local_release_commit_data(filp, data, call_ops);
+		nfs_local_release_commit_data(nf, data, call_ops);
 		return -ENOMEM;
 	}
 
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 1bd0224f7ee8..6f836b66ef79 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -732,7 +732,7 @@ static void nfs_pgio_prepare(struct rpc_task *task, void *calldata)
 int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 		      const struct cred *cred, const struct nfs_rpc_ops *rpc_ops,
 		      const struct rpc_call_ops *call_ops, int how, int flags,
-		      struct file *localio)
+		      struct nfsd_file *localio)
 {
 	struct rpc_task *task;
 	struct rpc_message msg = {
@@ -960,9 +960,9 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 	if (ret == 0) {
 		struct nfs_client *clp = NFS_SERVER(hdr->inode)->nfs_client;
 
-		struct file *filp = nfs_local_file_open(clp, hdr->cred,
-							hdr->args.fh,
-							hdr->args.context);
+		struct nfsd_file *nf = nfs_local_file_open(clp, hdr->cred,
+							   hdr->args.fh,
+							   hdr->args.context);
 
 		if (NFS_SERVER(hdr->inode)->nfs_client->cl_minorversion)
 			task_flags = RPC_TASK_MOVEABLE;
@@ -973,7 +973,7 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 					desc->pg_rpc_callops,
 					desc->pg_ioflags,
 					RPC_TASK_CRED_NOREF | task_flags,
-					filp);
+					nf);
 	}
 	return ret;
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 6436db54b2fc..89a49a08bc90 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1664,7 +1664,7 @@ int nfs_initiate_commit(struct rpc_clnt *clnt, struct nfs_commit_data *data,
 			const struct nfs_rpc_ops *nfs_ops,
 			const struct rpc_call_ops *call_ops,
 			int how, int flags,
-			struct file *localio)
+			struct nfsd_file *localio)
 {
 	struct rpc_task *task;
 	int priority = flush_task_priority(how);
@@ -1795,7 +1795,7 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 		struct nfs_commit_info *cinfo)
 {
 	struct nfs_commit_data	*data;
-	struct file *filp;
+	struct nfsd_file *nf;
 	unsigned short task_flags = 0;
 
 	/* another commit raced with us */
@@ -1813,11 +1813,11 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 	if (NFS_SERVER(inode)->nfs_client->cl_minorversion)
 		task_flags = RPC_TASK_MOVEABLE;
 
-	filp = nfs_local_file_open(NFS_SERVER(inode)->nfs_client, data->cred,
-				   data->args.fh, data->context);
+	nf = nfs_local_file_open(NFS_SERVER(inode)->nfs_client, data->cred,
+				 data->args.fh, data->context);
 	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
 				   data->mds_ops, how,
-				   RPC_TASK_CRED_NOREF | task_flags, filp);
+				   RPC_TASK_CRED_NOREF | task_flags, nf);
 }
 
 /*
-- 
2.44.0


