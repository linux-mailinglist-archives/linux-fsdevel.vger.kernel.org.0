Return-Path: <linux-fsdevel+bounces-28128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592619673BF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0111C20E2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C960110A3D;
	Sat, 31 Aug 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODK47Tuu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344B1190049;
	Sat, 31 Aug 2024 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143901; cv=none; b=uLGIoBXbv4GuZNOwmAM0wdhuN8s5YhSRB7irqx60JpzRQRfQTw8sQ7lAIadPdg9302WszHTfLiB/i9YID+7vK/kKfb+Xb0iwe6XfCgRvrh8K2MWzfp8pGzWvDX2Hul75wJCyOLvlgaf0Doa3Nf4/odAx54Eu7YV7u4cfd97Mv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143901; c=relaxed/simple;
	bh=Hd8ooJExICXNyFDAdzVDqdF4wCNSP8LwhYY/vGNYITI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPI4qA0r0LcGq0eDxw5S76smZiLEWOXLmZIcgH8mG2wQvE++QHKl6k9DIQfXnSFKUyV36HJKt5XFG3mo2d9vHAmoBY1lktXr74IQ1t9ri3ZZmH7foKxpTJSvIKbKdAo0w4oaiBNNo13rqGGLVPjoc8MVmQD5PZ5CD/jnl09/A5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODK47Tuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C522C4CEC7;
	Sat, 31 Aug 2024 22:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143900;
	bh=Hd8ooJExICXNyFDAdzVDqdF4wCNSP8LwhYY/vGNYITI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODK47TuulECyarx9/63bYBovkF2qcq6N0AuytVl7a6Au65xTxwqSiJHmnemFEGNVq
	 G/fXT++yBbYVrsY8jY5/JCvaNEmX5AiaWv4NTx/yjt0e5qLlZaTPfS0g66kw4xSmw+
	 inV3tXJSZNfUPL1HHCN8N9oh/EgMNQX9zFI/TLE4ScJV/mZl8Oes0oxrKfKanGlxw/
	 roqmHZAsZtq8rULrlWNbXtUvHTxUzhIpKSM43Mw0Bzy34fdbQWw1ArxyVRjU8SVb3q
	 psFaVS0X62gLm65K4buCfCiX5/4s/9gAFuyouavKLBa3kVCahvQJJfB5dSEHpYD8xz
	 +h59T7CMPJfrg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 18/26] nfs: pass struct nfsd_file to nfs_init_pgio and nfs_init_commit
Date: Sat, 31 Aug 2024 18:37:38 -0400
Message-ID: <20240831223755.8569-19-snitzer@kernel.org>
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

The nfsd_file will be passed, in future commits, by callers
that enable LOCALIO support (for both regular NFS and pNFS IO).

[Derived from patch authored by Weston Andros Adamson, but switched
 from passing struct file to struct nfsd_file]

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/filelayout/filelayout.c         | 6 +++---
 fs/nfs/flexfilelayout/flexfilelayout.c | 6 +++---
 fs/nfs/internal.h                      | 7 +++++--
 fs/nfs/pagelist.c                      | 6 ++++--
 fs/nfs/pnfs_nfs.c                      | 2 +-
 fs/nfs/write.c                         | 5 +++--
 include/linux/nfslocalio.h             | 5 +++--
 7 files changed, 22 insertions(+), 15 deletions(-)

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
index 5902a9beca1f..9b89294fb2ad 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -9,6 +9,7 @@
 #include <linux/crc32.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/nfs_page.h>
+#include <linux/nfslocalio.h>
 #include <linux/wait_bit.h>
 
 #define NFS_SB_MASK (SB_RDONLY|SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
@@ -308,7 +309,8 @@ void nfs_pgio_header_free(struct nfs_pgio_header *);
 int nfs_generic_pgio(struct nfs_pageio_descriptor *, struct nfs_pgio_header *);
 int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 		      const struct cred *cred, const struct nfs_rpc_ops *rpc_ops,
-		      const struct rpc_call_ops *call_ops, int how, int flags);
+		      const struct rpc_call_ops *call_ops, int how, int flags,
+		      struct nfsd_file *localio);
 void nfs_free_request(struct nfs_page *req);
 struct nfs_pgio_mirror *
 nfs_pgio_current_mirror(struct nfs_pageio_descriptor *desc);
@@ -528,7 +530,8 @@ extern int nfs_initiate_commit(struct rpc_clnt *clnt,
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
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 61f2c781dd50..5e57158e219d 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -6,6 +6,9 @@
 #ifndef __LINUX_NFSLOCALIO_H
 #define __LINUX_NFSLOCALIO_H
 
+/* nfsd_file structure is purposely kept opaque to NFS client */
+struct nfsd_file;
+
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 
 #include <linux/module.h>
@@ -36,8 +39,6 @@ void nfs_uuid_is_local(const uuid_t *, struct list_head *,
 void nfs_uuid_invalidate_clients(struct list_head *list);
 void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
 
-struct nfsd_file;
-
 /* localio needs to map filehandle -> struct nfsd_file */
 typedef struct nfsd_file *
 (*nfs_to_nfsd_open_local_fh_t)(nfs_uuid_t *, struct rpc_clnt *,
-- 
2.44.0


