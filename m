Return-Path: <linux-fsdevel+bounces-28131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EB39673C5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F281F21EE1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B5F190660;
	Sat, 31 Aug 2024 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIvsCUdZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6520F183CC9;
	Sat, 31 Aug 2024 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143905; cv=none; b=ZM0u04XZPbmTKklcjI7bUG6Dj5hZrTThCnROPCcG4UFbrQbUynQEN6L1ImRlo9qGLfBvIvuSGM/BZ+sjA2BzaHiIQVAnA+H4tBhQkiHgA98ZsxG6O0E80mFmbhpeULu5FE7lRSpwdLcPP7qzi+H56fABxI8XDfYRARGpdkYn/dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143905; c=relaxed/simple;
	bh=i61YzyWApudiOKZCI3w9SZ6bNuf57m9J3SRzgY4SLTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhXCr3dvKPUbkiJXFcSfm3zmoslA1EgiW7mDSDlmygx15oQPbhFY0loK6N6Lj5GSkxYOyastQdIE9dvUt1QPJKj/JQyPZ2DlF3iyzvJc1X4mngPl0Vf+DudEZgYg7a3q2aElCTqZG+bjec0vJToieDqs+HGmcDarrcs4sj6iWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIvsCUdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB648C4CECB;
	Sat, 31 Aug 2024 22:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143904;
	bh=i61YzyWApudiOKZCI3w9SZ6bNuf57m9J3SRzgY4SLTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIvsCUdZ6U0h4VuH7+8TrTkdTvvBV1pU5VHP/+Px7SQQFDcCWxXviqsjKLmjgUHLn
	 teVp16b3XHdx+/RxX01XyagnI1qR5erXCmNdhpMb+4UjW5PLjiRaJnJhPbNx4DFSFW
	 uuBetMLlgxbJKMOpu4Cy7bMSHmdZHU6v4YUWIEWq55n5kITrK19nhKHbF96qF2npRh
	 N+bgLERIj3ZDtaJTs2KMcoHkp7rMuuqi0nhN+ptg+MeujR08VtEyzhN8Z/+ohHnFln
	 nT2B8bi2tDO72qaUqCsLByYUqsgWWUMXoOm645PfkBmlVYzqhQzdqkT0zHxwwytir5
	 IO5CvoF5uqvng==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 21/26] pnfs/flexfiles: enable localio support
Date: Sat, 31 Aug 2024 18:37:41 -0400
Message-ID: <20240831223755.8569-22-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240831223755.8569-1-snitzer@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
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
 fs/nfs/flexfilelayout/flexfilelayout.c    | 50 +++++++++++++++++++++--
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |  6 +++
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 01ee52551a63..f78115c6c2c1 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -11,6 +11,7 @@
 #include <linux/nfs_mount.h>
 #include <linux/nfs_page.h>
 #include <linux/module.h>
+#include <linux/file.h>
 #include <linux/sched/mm.h>
 
 #include <linux/sunrpc/metrics.h>
@@ -162,6 +163,21 @@ decode_name(struct xdr_stream *xdr, u32 *id)
 	return 0;
 }
 
+static struct nfsd_file *
+ff_local_open_fh(struct nfs_client *clp, const struct cred *cred,
+		 struct nfs_fh *fh, fmode_t mode)
+{
+	if (mode & FMODE_WRITE) {
+		/*
+		 * Always request read and write access since this corresponds
+		 * to a rw layout.
+		 */
+		mode |= FMODE_READ;
+	}
+
+	return nfs_local_open_fh(clp, cred, fh, mode);
+}
+
 static bool ff_mirror_match_fh(const struct nfs4_ff_layout_mirror *m1,
 		const struct nfs4_ff_layout_mirror *m2)
 {
@@ -237,7 +253,7 @@ static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_flags)
 
 static void ff_layout_free_mirror(struct nfs4_ff_layout_mirror *mirror)
 {
-	const struct cred	*cred;
+	const struct cred *cred;
 
 	ff_layout_remove_mirror(mirror);
 	kfree(mirror->fh_versions);
@@ -1756,6 +1772,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	struct pnfs_layout_segment *lseg = hdr->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
+	struct nfsd_file *localio;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	loff_t offset = hdr->args.offset;
@@ -1802,11 +1819,18 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->args.offset = offset;
 	hdr->mds_offset = offset;
 
+	/* Start IO accounting for local read */
+	localio = ff_local_open_fh(ds->ds_clp, ds_cred, fh, FMODE_READ);
+	if (localio) {
+		hdr->task.tk_start = ktime_get();
+		ff_layout_read_record_layoutstats_start(&hdr->task, hdr);
+	}
+
 	/* Perform an asynchronous read to ds */
 	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_read_call_ops_v3 :
 				      &ff_layout_read_call_ops_v4,
-			  0, RPC_TASK_SOFTCONN, NULL);
+			  0, RPC_TASK_SOFTCONN, localio);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1826,6 +1850,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	struct pnfs_layout_segment *lseg = hdr->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
+	struct nfsd_file *localio;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	loff_t offset = hdr->args.offset;
@@ -1870,11 +1895,19 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	 */
 	hdr->args.offset = offset;
 
+	/* Start IO accounting for local write */
+	localio = ff_local_open_fh(ds->ds_clp, ds_cred, fh,
+				   FMODE_READ|FMODE_WRITE);
+	if (localio) {
+		hdr->task.tk_start = ktime_get();
+		ff_layout_write_record_layoutstats_start(&hdr->task, hdr);
+	}
+
 	/* Perform an asynchronous write */
 	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_write_call_ops_v3 :
 				      &ff_layout_write_call_ops_v4,
-			  sync, RPC_TASK_SOFTCONN, NULL);
+			  sync, RPC_TASK_SOFTCONN, localio);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1908,6 +1941,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	struct pnfs_layout_segment *lseg = data->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
+	struct nfsd_file *localio;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	u32 idx;
@@ -1946,10 +1980,18 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	if (fh)
 		data->args.fh = fh;
 
+	/* Start IO accounting for local commit */
+	localio = ff_local_open_fh(ds->ds_clp, ds_cred, fh,
+				   FMODE_READ|FMODE_WRITE);
+	if (localio) {
+		data->task.tk_start = ktime_get();
+		ff_layout_commit_record_layoutstats_start(&data->task, data);
+	}
+
 	ret = nfs_initiate_commit(ds_clnt, data, ds->ds_clp->rpc_ops,
 				   vers == 3 ? &ff_layout_commit_call_ops_v3 :
 					       &ff_layout_commit_call_ops_v4,
-				   how, RPC_TASK_SOFTCONN, NULL);
+				   how, RPC_TASK_SOFTCONN, localio);
 	put_cred(ds_cred);
 	return ret;
 out_err:
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


