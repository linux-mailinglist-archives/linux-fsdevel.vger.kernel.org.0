Return-Path: <linux-fsdevel+bounces-26971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287A495D509
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C246A284A64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE2419341E;
	Fri, 23 Aug 2024 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/ip+1g9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD84193411;
	Fri, 23 Aug 2024 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436881; cv=none; b=BaJIoWx2UouvFw9ICI68mOC229pL6iNdF+KfhGiCkbv+BzQZzg0AEkXIiLeA+oNLzFWR5vKVhHyuB8gNzHS5sbk/l8vSy9XyC3q5eDQbzDQZqsBHJl1tP+dBsFVFmZCbBWyqxNuwHWlYtgtxNnPJRCOt+Qdp40sZ3AN66ECKdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436881; c=relaxed/simple;
	bh=Su0hD6p6tnHD+EYd64hyhVmH31LRjUUb7wdP/cuaDl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0LN+3sHgDHq/ddnsM/Ohgw6XAajFAoaUaFQvWaivs0GbncE6ngdW8rk0rmJroRlin2SKOXEnp2RHp/H5SDNgtIKIXcwf4U/X272xUhCVIyo3r3aBC1eNM8coEQHWOlBSKUjAkLZIOE3MQH9cXL3NZTPAUjY2DR5HPfCOQTnsSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/ip+1g9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210F6C32786;
	Fri, 23 Aug 2024 18:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724436881;
	bh=Su0hD6p6tnHD+EYd64hyhVmH31LRjUUb7wdP/cuaDl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/ip+1g9QOS2YaL+IR5vcI5sFi8soKIeCxH646+UEoOyKE6UwylsvmvnjvXTL0PJj
	 uU37qYa+VLOGtnp0yev+ydYmrkAtoCP72pKnGx4h5ElYgrJI0LGtYfO+L2aVaP+wCE
	 V7l9BsSUMp1tpnvLPvDRI/E0THo+dsNqgNuUgZ8HuCbSjNa5vGxciob2XU/5fY/mYj
	 yx2KixXht8Tw1jTfYhSoUDeob2kp6NBs0Cp7V7dGxBhzkiLXpCLQ9NRGHMy8Udwlbg
	 r9TRr7h8pUuDBx2xc0C9BHJn0m4iLBx+ouqQWkWwiDO9Be9VKonnSw5RFC0U0itd4c
	 q6sQrHNv2S7mg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 12/19] nfs: pass struct nfsd_file to nfs_init_pgio and nfs_init_commit
Date: Fri, 23 Aug 2024 14:14:10 -0400
Message-ID: <20240823181423.20458-13-snitzer@kernel.org>
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

The localio nfsd_file will be passed, in future commits, by callers
that enable localio support (for both regular NFS and pNFS IO).

[Derived from patch authored by Weston Andros Adamson, but switched
 from passing struct file to struct nfsd_file]

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/filelayout/filelayout.c         | 6 +++---
 fs/nfs/flexfilelayout/flexfilelayout.c | 6 +++---
 fs/nfs/internal.h                      | 6 ++++--
 fs/nfs/pagelist.c                      | 6 ++++--
 fs/nfs/pnfs_nfs.c                      | 2 +-
 fs/nfs/write.c                         | 5 +++--
 6 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index b6e9aeaf4ce2..d39a1f58e18d 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -488,7 +488,7 @@ filelayout_read_pagelist(struct nfs_pgio_header *hdr)
 	/* Perform an asynchronous read to ds */
 	nfs_initiate_pgio(ds_clnt, hdr, hdr->cred,
 			  NFS_PROTO(hdr->inode), &filelayout_read_call_ops,
-			  0, RPC_TASK_SOFTCONN);
+			  0, RPC_TASK_SOFTCONN, NULL);
 	return PNFS_ATTEMPTED;
 }
 
@@ -530,7 +530,7 @@ filelayout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	/* Perform an asynchronous write */
 	nfs_initiate_pgio(ds_clnt, hdr, hdr->cred,
 			  NFS_PROTO(hdr->inode), &filelayout_write_call_ops,
-			  sync, RPC_TASK_SOFTCONN);
+			  sync, RPC_TASK_SOFTCONN, NULL);
 	return PNFS_ATTEMPTED;
 }
 
@@ -1011,7 +1011,7 @@ static int filelayout_initiate_commit(struct nfs_commit_data *data, int how)
 		data->args.fh = fh;
 	return nfs_initiate_commit(ds_clnt, data, NFS_PROTO(data->inode),
 				   &filelayout_commit_call_ops, how,
-				   RPC_TASK_SOFTCONN);
+				   RPC_TASK_SOFTCONN, NULL);
 out_err:
 	pnfs_generic_prepare_to_resend_writes(data);
 	pnfs_generic_commit_release(data);
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index d4d551ffea7b..01ee52551a63 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1806,7 +1806,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_read_call_ops_v3 :
 				      &ff_layout_read_call_ops_v4,
-			  0, RPC_TASK_SOFTCONN);
+			  0, RPC_TASK_SOFTCONN, NULL);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1874,7 +1874,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_write_call_ops_v3 :
 				      &ff_layout_write_call_ops_v4,
-			  sync, RPC_TASK_SOFTCONN);
+			  sync, RPC_TASK_SOFTCONN, NULL);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1949,7 +1949,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	ret = nfs_initiate_commit(ds_clnt, data, ds->ds_clp->rpc_ops,
 				   vers == 3 ? &ff_layout_commit_call_ops_v3 :
 					       &ff_layout_commit_call_ops_v4,
-				   how, RPC_TASK_SOFTCONN);
+				   how, RPC_TASK_SOFTCONN, NULL);
 	put_cred(ds_cred);
 	return ret;
 out_err:
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 5902a9beca1f..eed35dcff54f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -308,7 +308,8 @@ void nfs_pgio_header_free(struct nfs_pgio_header *);
 int nfs_generic_pgio(struct nfs_pageio_descriptor *, struct nfs_pgio_header *);
 int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 		      const struct cred *cred, const struct nfs_rpc_ops *rpc_ops,
-		      const struct rpc_call_ops *call_ops, int how, int flags);
+		      const struct rpc_call_ops *call_ops, int how, int flags,
+		      struct nfsd_file *localio);
 void nfs_free_request(struct nfs_page *req);
 struct nfs_pgio_mirror *
 nfs_pgio_current_mirror(struct nfs_pageio_descriptor *desc);
@@ -528,7 +529,8 @@ extern int nfs_initiate_commit(struct rpc_clnt *clnt,
 			       struct nfs_commit_data *data,
 			       const struct nfs_rpc_ops *nfs_ops,
 			       const struct rpc_call_ops *call_ops,
-			       int how, int flags);
+			       int how, int flags,
+			       struct nfsd_file *localio);
 extern void nfs_init_commit(struct nfs_commit_data *data,
 			    struct list_head *head,
 			    struct pnfs_layout_segment *lseg,
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 04124f226665..50f3d6c9ac2a 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -731,7 +731,8 @@ static void nfs_pgio_prepare(struct rpc_task *task, void *calldata)
 
 int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 		      const struct cred *cred, const struct nfs_rpc_ops *rpc_ops,
-		      const struct rpc_call_ops *call_ops, int how, int flags)
+		      const struct rpc_call_ops *call_ops, int how, int flags,
+		      struct nfsd_file *localio)
 {
 	struct rpc_task *task;
 	struct rpc_message msg = {
@@ -961,7 +962,8 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 					NFS_PROTO(hdr->inode),
 					desc->pg_rpc_callops,
 					desc->pg_ioflags,
-					RPC_TASK_CRED_NOREF | task_flags);
+					RPC_TASK_CRED_NOREF | task_flags,
+					NULL);
 	}
 	return ret;
 }
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index a74ee69a2fa6..dbef837e871a 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -490,7 +490,7 @@ pnfs_generic_commit_pagelist(struct inode *inode, struct list_head *mds_pages,
 			nfs_initiate_commit(NFS_CLIENT(inode), data,
 					    NFS_PROTO(data->inode),
 					    data->mds_ops, how,
-					    RPC_TASK_CRED_NOREF);
+					    RPC_TASK_CRED_NOREF, NULL);
 		} else {
 			nfs_init_commit(data, NULL, data->lseg, cinfo);
 			initiate_commit(data, how);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index d074d0ceb4f0..04d0b5b95f4f 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1663,7 +1663,8 @@ EXPORT_SYMBOL_GPL(nfs_commitdata_release);
 int nfs_initiate_commit(struct rpc_clnt *clnt, struct nfs_commit_data *data,
 			const struct nfs_rpc_ops *nfs_ops,
 			const struct rpc_call_ops *call_ops,
-			int how, int flags)
+			int how, int flags,
+			struct nfsd_file *localio)
 {
 	struct rpc_task *task;
 	int priority = flush_task_priority(how);
@@ -1809,7 +1810,7 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 		task_flags = RPC_TASK_MOVEABLE;
 	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
 				   data->mds_ops, how,
-				   RPC_TASK_CRED_NOREF | task_flags);
+				   RPC_TASK_CRED_NOREF | task_flags, NULL);
 }
 
 /*
-- 
2.44.0


