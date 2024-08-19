Return-Path: <linux-fsdevel+bounces-26300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8201E9572E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3895A284C90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8B418A922;
	Mon, 19 Aug 2024 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siCcRT9h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACBA18A6C3;
	Mon, 19 Aug 2024 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091491; cv=none; b=kZ02wpII2V3vjU7RiLc3iHkNCoupL+42rR9/fcqfhmiutD3lk6um8gGCiTqtzJZ390qYVFFOYWhgRJ859L5nwCVv29WPvGHVGIrwTm6pPL8hXcqoMOAzYMRHwRKVg7XwYvtgy6/T1Ie/yxLRciKoF929y0vh8/DG8j/fRa7h2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091491; c=relaxed/simple;
	bh=XCdOSeXB+NQJQDD4of1vkcJGYX2LMI3CHpPNXJC55l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnvYkNoEAitudrYe8pFYyD7fXeI6FwgwN+AwnzjVbKoygxNvKh5QVcoXvD38rlp5yrCtH61pQvuEz/2SCxNBbhgmZ36f6UM797gr/i2Oao0XhyLiCBl3Tns3K5YK2wmJHQimWPs535npn+0VLFMjeCjJdEenc9oR/CU8TchpYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siCcRT9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0510AC4AF14;
	Mon, 19 Aug 2024 18:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091491;
	bh=XCdOSeXB+NQJQDD4of1vkcJGYX2LMI3CHpPNXJC55l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=siCcRT9hxKgfKsuYCacA6n2yJRF+ttyLW8V0KY6sUXz5N7wNbvTc4fIZS8mqXOzbx
	 pnf2pk0fkcJELmvlL6QQP8Clubwn9wxZx4EzX9+fC03F1g+66/tTrXcnmvp7bpzvUw
	 6rba6IZSfWWbOpCVwolozDRD+W+SUVB2CH3hnoZNL9P7IZgqn9XFmf2lDEvpYi3MQi
	 ppQJ/rLiYJryCeIikY7hJIMHhYAuADO4ycmSNezGILV11Byop9R9iBM609fLLrbGOg
	 FCQecLsLKsLnpPSN5MiDnYi0zQZMtdWIIJYOIN5VIKVPkbVo7rcarhXQ0EiYbkivLa
	 wzApgr38BSugQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 14/24] nfs: add localio support
Date: Mon, 19 Aug 2024 14:17:19 -0400
Message-ID: <20240819181750.70570-15-snitzer@kernel.org>
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

From: Weston Andros Adamson <dros@primarydata.com>

Add client support for bypassing NFS for localhost reads, writes, and
commits. This is only useful when the client and the server are
running on the same host.

nfs_local_probe() is stubbed out, later commits will enable client and
server handshake via a Linux-only LOCALIO auxiliary RPC protocol.

This has dynamic binding with the nfsd module (via nfs_localio module
which is part of nfs_common). Localio will only work if nfsd is
already loaded.

The "localio_enabled" nfs kernel module parameter can be used to
disable and enable the ability to use localio support.

CONFIG_NFS_LOCALIO controls the client enablement.

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/Kconfig            |  14 +
 fs/nfs/Makefile           |   1 +
 fs/nfs/client.c           |   3 +
 fs/nfs/internal.h         |  51 ++++
 fs/nfs/localio.c          | 613 ++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfstrace.h         |  61 ++++
 fs/nfs/pagelist.c         |   4 +
 fs/nfs/write.c            |   3 +
 include/linux/nfs.h       |   2 +
 include/linux/nfs_fs_sb.h |   1 +
 10 files changed, 753 insertions(+)
 create mode 100644 fs/nfs/localio.c

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 0eb20012792f..d52a1df28f69 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -87,6 +87,20 @@ config NFS_V4
 
 	  If unsure, say Y.
 
+config NFS_LOCALIO
+	bool "NFS client support for the LOCALIO auxiliary protocol"
+	depends on NFS_FS
+	select NFS_COMMON_LOCALIO_SUPPORT
+	help
+	  Some NFS servers support an auxiliary NFS LOCALIO protocol
+	  that is not an official part of the NFS protocol.
+
+	  This option enables support for the LOCALIO protocol in the
+	  kernel's NFS client.  Enable this to bypass using the NFS
+	  protocol when issuing reads, writes and commits to the server.
+
+	  If unsure, say N.
+
 config NFS_SWAP
 	bool "Provide swap over NFS support"
 	default n
diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 5f6db37f461e..9fb2f2cac87e 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -13,6 +13,7 @@ nfs-y 			:= client.o dir.o file.o getroot.o inode.o super.o \
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o
 nfs-$(CONFIG_SYSCTL)	+= sysctl.o
 nfs-$(CONFIG_NFS_FSCACHE) += fscache.o
+nfs-$(CONFIG_NFS_LOCALIO) += localio.o
 
 obj-$(CONFIG_NFS_V2) += nfsv2.o
 nfsv2-y := nfs2super.o proc.o nfs2xdr.o
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 1b65a5d7af49..bf327ddbdd25 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -242,6 +242,8 @@ static void pnfs_init_server(struct nfs_server *server)
  */
 void nfs_free_client(struct nfs_client *clp)
 {
+	nfs_local_disable(clp);
+
 	/* -EIO all pending I/O */
 	if (!IS_ERR(clp->cl_rpcclient))
 		rpc_shutdown_client(clp->cl_rpcclient);
@@ -433,6 +435,7 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
 			list_add_tail(&new->cl_share_link,
 					&nn->nfs_client_list);
 			spin_unlock(&nn->nfs_client_lock);
+			nfs_local_probe(new);
 			return rpc_ops->init_client(new, cl_init);
 		}
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9fc6c1a41ee4..acb9d8bb4076 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -450,6 +450,57 @@ extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
 extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
 extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+/* localio.c */
+extern void nfs_local_disable(struct nfs_client *);
+extern void nfs_local_probe(struct nfs_client *);
+extern struct file *nfs_local_open_fh(struct nfs_client *, const struct cred *,
+				      struct nfs_fh *, const fmode_t);
+extern struct file *nfs_local_file_open(struct nfs_client *clp,
+					const struct cred *cred,
+					struct nfs_fh *fh,
+					struct nfs_open_context *ctx);
+extern int nfs_local_doio(struct nfs_client *, struct file *,
+			  struct nfs_pgio_header *,
+			  const struct rpc_call_ops *);
+extern int nfs_local_commit(struct file *, struct nfs_commit_data *,
+			    const struct rpc_call_ops *, int);
+extern bool nfs_server_is_local(const struct nfs_client *clp);
+
+#else
+static inline void nfs_local_disable(struct nfs_client *clp) {}
+static inline void nfs_local_probe(struct nfs_client *clp) {}
+static inline struct file *nfs_local_open_fh(struct nfs_client *clp,
+					const struct cred *cred,
+					struct nfs_fh *fh,
+					const fmode_t mode)
+{
+	return ERR_PTR(-EINVAL);
+}
+static inline struct file *nfs_local_file_open(struct nfs_client *clp,
+					const struct cred *cred,
+					struct nfs_fh *fh,
+					struct nfs_open_context *ctx)
+{
+	return NULL;
+}
+static inline int nfs_local_doio(struct nfs_client *clp, struct file *filep,
+				struct nfs_pgio_header *hdr,
+				const struct rpc_call_ops *call_ops)
+{
+	return -EINVAL;
+}
+static inline int nfs_local_commit(struct file *filep, struct nfs_commit_data *data,
+				const struct rpc_call_ops *call_ops, int how)
+{
+	return -EINVAL;
+}
+static inline bool nfs_server_is_local(const struct nfs_client *clp)
+{
+	return false;
+}
+#endif /* CONFIG_NFS_LOCALIO */
+
 /* super.c */
 extern const struct super_operations nfs_sops;
 bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
new file mode 100644
index 000000000000..d6ec425bf6f0
--- /dev/null
+++ b/fs/nfs/localio.c
@@ -0,0 +1,613 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NFS client support for local clients to bypass network stack
+ *
+ * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
+ * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/vfs.h>
+#include <linux/file.h>
+#include <linux/inet.h>
+#include <linux/sunrpc/addr.h>
+#include <linux/inetdevice.h>
+#include <net/addrconf.h>
+#include <linux/nfs_common.h>
+#include <linux/nfslocalio.h>
+#include <linux/module.h>
+#include <linux/bvec.h>
+
+#include <linux/nfs.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_xdr.h>
+
+#include "internal.h"
+#include "pnfs.h"
+#include "nfstrace.h"
+
+#define NFSDBG_FACILITY		NFSDBG_VFS
+
+struct nfs_local_kiocb {
+	struct kiocb		kiocb;
+	struct bio_vec		*bvec;
+	struct nfs_pgio_header	*hdr;
+	struct work_struct	work;
+};
+
+struct nfs_local_fsync_ctx {
+	struct file		*filp;
+	struct nfs_commit_data	*data;
+	struct work_struct	work;
+	struct kref		kref;
+	struct completion	*done;
+};
+static void nfs_local_fsync_work(struct work_struct *work);
+
+static bool localio_enabled __read_mostly = true;
+module_param(localio_enabled, bool, 0644);
+
+bool nfs_server_is_local(const struct nfs_client *clp)
+{
+	return test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags) != 0 &&
+		localio_enabled;
+}
+EXPORT_SYMBOL_GPL(nfs_server_is_local);
+
+/*
+ * nfs_local_enable - enable local i/o for an nfs_client
+ */
+static __maybe_unused void nfs_local_enable(struct nfs_client *clp,
+					    nfs_uuid_t *nfs_uuid)
+{
+	if (READ_ONCE(clp->nfsd_open_local_fh)) {
+		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+		clp->cl_nfssvc_net = nfs_uuid->net;
+		clp->cl_nfssvc_dom = nfs_uuid->dom;
+		trace_nfs_local_enable(clp);
+	}
+}
+
+/*
+ * nfs_local_disable - disable local i/o for an nfs_client
+ */
+void nfs_local_disable(struct nfs_client *clp)
+{
+	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
+		trace_nfs_local_disable(clp);
+		clp->cl_nfssvc_net = NULL;
+		if (clp->cl_nfssvc_dom) {
+			auth_domain_put(clp->cl_nfssvc_dom);
+			clp->cl_nfssvc_dom = NULL;
+		}
+	}
+}
+
+/*
+ * nfs_local_probe - probe local i/o support for an nfs_server and nfs_client
+ */
+void nfs_local_probe(struct nfs_client *clp)
+{
+}
+EXPORT_SYMBOL_GPL(nfs_local_probe);
+
+/*
+ * nfs_local_open_fh - open a local filehandle
+ *
+ * Returns a pointer to a struct file or an ERR_PTR
+ */
+struct file *
+nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
+		  struct nfs_fh *fh, const fmode_t mode)
+{
+	struct file *filp;
+	int status;
+
+	if (mode & ~(FMODE_READ | FMODE_WRITE))
+		return ERR_PTR(-EINVAL);
+
+	status = clp->nfsd_open_local_fh(clp->cl_nfssvc_net, clp->cl_nfssvc_dom,
+					 clp->cl_rpcclient, cred, fh, mode, &filp);
+	if (status < 0) {
+		trace_nfs_local_open_fh(fh, mode, status);
+		switch (status) {
+		case -ENXIO:
+		case -ENOENT:
+			nfs_local_disable(clp);
+			fallthrough;
+		case -ETIMEDOUT:
+			status = -EAGAIN;
+		}
+		filp = ERR_PTR(status);
+	}
+	return filp;
+}
+EXPORT_SYMBOL_GPL(nfs_local_open_fh);
+
+struct file *
+nfs_local_file_open(struct nfs_client *clp, const struct cred *cred,
+		    struct nfs_fh *fh, struct nfs_open_context *ctx)
+{
+	struct file *filp;
+
+	if (!nfs_server_is_local(clp))
+		return NULL;
+
+	filp = nfs_local_open_fh(clp, cred, fh, ctx->mode);
+	if (IS_ERR(filp))
+		return NULL;
+
+	return filp;
+}
+
+static struct bio_vec *
+nfs_bvec_alloc_and_import_pagevec(struct page **pagevec,
+		unsigned int npages, gfp_t flags)
+{
+	struct bio_vec *bvec, *p;
+
+	bvec = kmalloc_array(npages, sizeof(*bvec), flags);
+	if (bvec != NULL) {
+		for (p = bvec; npages > 0; p++, pagevec++, npages--) {
+			p->bv_page = *pagevec;
+			p->bv_len = PAGE_SIZE;
+			p->bv_offset = 0;
+		}
+	}
+	return bvec;
+}
+
+static void
+nfs_local_iocb_free(struct nfs_local_kiocb *iocb)
+{
+	kfree(iocb->bvec);
+	kfree(iocb);
+}
+
+static struct nfs_local_kiocb *
+nfs_local_iocb_alloc(struct nfs_pgio_header *hdr, struct file *filp,
+		gfp_t flags)
+{
+	struct nfs_local_kiocb *iocb;
+
+	iocb = kmalloc(sizeof(*iocb), flags);
+	if (iocb == NULL)
+		return NULL;
+	iocb->bvec = nfs_bvec_alloc_and_import_pagevec(hdr->page_array.pagevec,
+			hdr->page_array.npages, flags);
+	if (iocb->bvec == NULL) {
+		kfree(iocb);
+		return NULL;
+	}
+	init_sync_kiocb(&iocb->kiocb, filp);
+	iocb->kiocb.ki_pos = hdr->args.offset;
+	iocb->hdr = hdr;
+	iocb->kiocb.ki_flags &= ~IOCB_APPEND;
+	return iocb;
+}
+
+static void
+nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
+{
+	struct nfs_pgio_header *hdr = iocb->hdr;
+
+	iov_iter_bvec(i, dir, iocb->bvec, hdr->page_array.npages,
+		      hdr->args.count + hdr->args.pgbase);
+	if (hdr->args.pgbase != 0)
+		iov_iter_advance(i, hdr->args.pgbase);
+}
+
+static void
+nfs_local_hdr_release(struct nfs_pgio_header *hdr,
+		const struct rpc_call_ops *call_ops)
+{
+	call_ops->rpc_call_done(&hdr->task, hdr);
+	call_ops->rpc_release(hdr);
+}
+
+static void
+nfs_local_pgio_init(struct nfs_pgio_header *hdr,
+		const struct rpc_call_ops *call_ops)
+{
+	hdr->task.tk_ops = call_ops;
+	if (!hdr->task.tk_start)
+		hdr->task.tk_start = ktime_get();
+}
+
+static void
+nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
+{
+	if (status >= 0) {
+		hdr->res.count = status;
+		hdr->res.op_status = NFS4_OK;
+		hdr->task.tk_status = 0;
+	} else {
+		hdr->res.op_status = nfs4_stat_to_errno(status);
+		hdr->task.tk_status = status;
+	}
+}
+
+static void
+nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
+{
+	struct nfs_pgio_header *hdr = iocb->hdr;
+
+	fput(iocb->kiocb.ki_filp);
+	nfs_local_iocb_free(iocb);
+	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
+}
+
+static void
+nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
+{
+	struct nfs_pgio_header *hdr = iocb->hdr;
+	struct file *filp = iocb->kiocb.ki_filp;
+
+	nfs_local_pgio_done(hdr, status);
+
+	if (hdr->res.count != hdr->args.count ||
+	    hdr->args.offset + hdr->res.count >= i_size_read(file_inode(filp)))
+		hdr->res.eof = true;
+
+	dprintk("%s: read %ld bytes eof %d.\n", __func__,
+			status > 0 ? status : 0, hdr->res.eof);
+}
+
+static int
+nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
+		const struct rpc_call_ops *call_ops)
+{
+	struct nfs_local_kiocb *iocb;
+	struct iov_iter iter;
+	ssize_t status;
+
+	dprintk("%s: vfs_read count=%u pos=%llu\n",
+		__func__, hdr->args.count, hdr->args.offset);
+
+	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_KERNEL);
+	if (iocb == NULL)
+		return -ENOMEM;
+	nfs_local_iter_init(&iter, iocb, READ);
+
+	nfs_local_pgio_init(hdr, call_ops);
+	hdr->res.eof = false;
+
+	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
+	WARN_ON_ONCE(status == -EIOCBQUEUED);
+
+	nfs_local_read_done(iocb, status);
+	nfs_local_pgio_release(iocb);
+
+	return 0;
+}
+
+static void
+nfs_copy_boot_verifier(struct nfs_write_verifier *verifier, struct inode *inode)
+{
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
+	u32 *verf = (u32 *)verifier->data;
+	int seq = 0;
+
+	do {
+		read_seqbegin_or_lock(&clp->cl_boot_lock, &seq);
+		verf[0] = (u32)clp->cl_nfssvc_boot.tv_sec;
+		verf[1] = (u32)clp->cl_nfssvc_boot.tv_nsec;
+	} while (need_seqretry(&clp->cl_boot_lock, seq));
+	done_seqretry(&clp->cl_boot_lock, seq);
+}
+
+static void
+nfs_reset_boot_verifier(struct inode *inode)
+{
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
+
+	write_seqlock(&clp->cl_boot_lock);
+	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
+	write_sequnlock(&clp->cl_boot_lock);
+}
+
+static void
+nfs_set_local_verifier(struct inode *inode,
+		struct nfs_writeverf *verf,
+		enum nfs3_stable_how how)
+{
+
+	nfs_copy_boot_verifier(&verf->verifier, inode);
+	verf->committed = how;
+}
+
+/* Factored out from fs/nfsd/vfs.h:fh_getattr() */
+static int __vfs_getattr(struct path *p, struct kstat *stat, int version)
+{
+	u32 request_mask = STATX_BASIC_STATS;
+
+	if (version == 4)
+		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
+	return vfs_getattr(p, stat, request_mask, AT_STATX_SYNC_AS_STAT);
+}
+
+/* Copied from fs/nfsd/nfsfh.c:nfsd4_change_attribute() */
+static u64 __nfsd4_change_attribute(const struct kstat *stat,
+				    const struct inode *inode)
+{
+	u64 chattr;
+
+	if (stat->result_mask & STATX_CHANGE_COOKIE) {
+		chattr = stat->change_cookie;
+		if (S_ISREG(inode->i_mode) &&
+		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
+			chattr += (u64)stat->ctime.tv_sec << 30;
+			chattr += stat->ctime.tv_nsec;
+		}
+	} else {
+		chattr = time_to_chattr(&stat->ctime);
+	}
+	return chattr;
+}
+
+static void nfs_local_vfs_getattr(struct nfs_local_kiocb *iocb)
+{
+	struct kstat stat;
+	struct file *filp = iocb->kiocb.ki_filp;
+	struct nfs_pgio_header *hdr = iocb->hdr;
+	struct nfs_fattr *fattr = hdr->res.fattr;
+	int version = NFS_PROTO(hdr->inode)->version;
+
+	if (unlikely(!fattr) || __vfs_getattr(&filp->f_path, &stat, version))
+		return;
+
+	fattr->valid = (NFS_ATTR_FATTR_FILEID |
+			NFS_ATTR_FATTR_CHANGE |
+			NFS_ATTR_FATTR_SIZE |
+			NFS_ATTR_FATTR_ATIME |
+			NFS_ATTR_FATTR_MTIME |
+			NFS_ATTR_FATTR_CTIME |
+			NFS_ATTR_FATTR_SPACE_USED);
+
+	fattr->fileid = stat.ino;
+	fattr->size = stat.size;
+	fattr->atime = stat.atime;
+	fattr->mtime = stat.mtime;
+	fattr->ctime = stat.ctime;
+	if (version == 4) {
+		fattr->change_attr =
+			__nfsd4_change_attribute(&stat, file_inode(filp));
+	} else
+		fattr->change_attr = nfs_timespec_to_change_attr(&fattr->ctime);
+	fattr->du.nfs3.used = stat.blocks << 9;
+}
+
+static void
+nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
+{
+	struct nfs_pgio_header *hdr = iocb->hdr;
+	struct inode *inode = hdr->inode;
+
+	dprintk("%s: wrote %ld bytes.\n", __func__, status > 0 ? status : 0);
+
+	/* Handle short writes as if they are ENOSPC */
+	if (status > 0 && status < hdr->args.count) {
+		hdr->mds_offset += status;
+		hdr->args.offset += status;
+		hdr->args.pgbase += status;
+		hdr->args.count -= status;
+		nfs_set_pgio_error(hdr, -ENOSPC, hdr->args.offset);
+		status = -ENOSPC;
+	}
+	if (status < 0)
+		nfs_reset_boot_verifier(inode);
+	else if (nfs_should_remove_suid(inode)) {
+		/* Deal with the suid/sgid bit corner case */
+		spin_lock(&inode->i_lock);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
+		spin_unlock(&inode->i_lock);
+	}
+	nfs_local_pgio_done(hdr, status);
+}
+
+static int
+nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
+		const struct rpc_call_ops *call_ops)
+{
+	struct nfs_local_kiocb *iocb;
+	struct iov_iter iter;
+	ssize_t status;
+
+	dprintk("%s: vfs_write count=%u pos=%llu %s\n",
+		__func__, hdr->args.count, hdr->args.offset,
+		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
+
+	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_NOIO);
+	if (iocb == NULL)
+		return -ENOMEM;
+	nfs_local_iter_init(&iter, iocb, WRITE);
+
+	switch (hdr->args.stable) {
+	default:
+		break;
+	case NFS_DATA_SYNC:
+		iocb->kiocb.ki_flags |= IOCB_DSYNC;
+		break;
+	case NFS_FILE_SYNC:
+		iocb->kiocb.ki_flags |= IOCB_DSYNC|IOCB_SYNC;
+	}
+	nfs_local_pgio_init(hdr, call_ops);
+
+	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
+
+	file_start_write(filp);
+	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
+	file_end_write(filp);
+	WARN_ON_ONCE(status == -EIOCBQUEUED);
+
+	nfs_local_write_done(iocb, status);
+	nfs_local_vfs_getattr(iocb);
+	nfs_local_pgio_release(iocb);
+
+	return 0;
+}
+
+int
+nfs_local_doio(struct nfs_client *clp, struct file *filp,
+	       struct nfs_pgio_header *hdr,
+	       const struct rpc_call_ops *call_ops)
+{
+	int status = 0;
+
+	if (!hdr->args.count)
+		return 0;
+	/* Don't support filesystems without read_iter/write_iter */
+	if (!filp->f_op->read_iter || !filp->f_op->write_iter) {
+		nfs_local_disable(clp);
+		status = -EAGAIN;
+		goto out_fput;
+	}
+
+	switch (hdr->rw_mode) {
+	case FMODE_READ:
+		status = nfs_do_local_read(hdr, filp, call_ops);
+		break;
+	case FMODE_WRITE:
+		status = nfs_do_local_write(hdr, filp, call_ops);
+		break;
+	default:
+		dprintk("%s: invalid mode: %d\n", __func__,
+			hdr->rw_mode);
+		status = -EINVAL;
+	}
+out_fput:
+	if (status != 0) {
+		fput(filp);
+		hdr->task.tk_status = status;
+		nfs_local_hdr_release(hdr, call_ops);
+	}
+	return status;
+}
+
+static void
+nfs_local_init_commit(struct nfs_commit_data *data,
+		const struct rpc_call_ops *call_ops)
+{
+	data->task.tk_ops = call_ops;
+}
+
+static int
+nfs_local_run_commit(struct file *filp, struct nfs_commit_data *data)
+{
+	loff_t start = data->args.offset;
+	loff_t end = LLONG_MAX;
+
+	if (data->args.count > 0) {
+		end = start + data->args.count - 1;
+		if (end < start)
+			end = LLONG_MAX;
+	}
+
+	dprintk("%s: commit %llu - %llu\n", __func__, start, end);
+	return vfs_fsync_range(filp, start, end, 0);
+}
+
+static void
+nfs_local_commit_done(struct nfs_commit_data *data, int status)
+{
+	if (status >= 0) {
+		nfs_set_local_verifier(data->inode,
+				data->res.verf,
+				NFS_FILE_SYNC);
+		data->res.op_status = NFS4_OK;
+		data->task.tk_status = 0;
+	} else {
+		nfs_reset_boot_verifier(data->inode);
+		data->res.op_status = nfs4_stat_to_errno(status);
+		data->task.tk_status = status;
+	}
+}
+
+static void
+nfs_local_release_commit_data(struct file *filp,
+		struct nfs_commit_data *data,
+		const struct rpc_call_ops *call_ops)
+{
+	fput(filp);
+	call_ops->rpc_call_done(&data->task, data);
+	call_ops->rpc_release(data);
+}
+
+static struct nfs_local_fsync_ctx *
+nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data, struct file *filp,
+		gfp_t flags)
+{
+	struct nfs_local_fsync_ctx *ctx = kmalloc(sizeof(*ctx), flags);
+
+	if (ctx != NULL) {
+		ctx->filp = filp;
+		ctx->data = data;
+		INIT_WORK(&ctx->work, nfs_local_fsync_work);
+		kref_init(&ctx->kref);
+		ctx->done = NULL;
+	}
+	return ctx;
+}
+
+static void
+nfs_local_fsync_ctx_kref_free(struct kref *kref)
+{
+	kfree(container_of(kref, struct nfs_local_fsync_ctx, kref));
+}
+
+static void
+nfs_local_fsync_ctx_put(struct nfs_local_fsync_ctx *ctx)
+{
+	kref_put(&ctx->kref, nfs_local_fsync_ctx_kref_free);
+}
+
+static void
+nfs_local_fsync_ctx_free(struct nfs_local_fsync_ctx *ctx)
+{
+	nfs_local_release_commit_data(ctx->filp, ctx->data,
+			ctx->data->task.tk_ops);
+	nfs_local_fsync_ctx_put(ctx);
+}
+
+static void
+nfs_local_fsync_work(struct work_struct *work)
+{
+	struct nfs_local_fsync_ctx *ctx;
+	int status;
+
+	ctx = container_of(work, struct nfs_local_fsync_ctx, work);
+
+	status = nfs_local_run_commit(ctx->filp, ctx->data);
+	nfs_local_commit_done(ctx->data, status);
+	if (ctx->done != NULL)
+		complete(ctx->done);
+	nfs_local_fsync_ctx_free(ctx);
+}
+
+int
+nfs_local_commit(struct file *filp, struct nfs_commit_data *data,
+		 const struct rpc_call_ops *call_ops, int how)
+{
+	struct nfs_local_fsync_ctx *ctx;
+
+	ctx = nfs_local_fsync_ctx_alloc(data, filp, GFP_KERNEL);
+	if (!ctx) {
+		nfs_local_commit_done(data, -ENOMEM);
+		nfs_local_release_commit_data(filp, data, call_ops);
+		return -ENOMEM;
+	}
+
+	nfs_local_init_commit(data, call_ops);
+	kref_get(&ctx->kref);
+	if (how & FLUSH_SYNC) {
+		DECLARE_COMPLETION_ONSTACK(done);
+		ctx->done = &done;
+		queue_work(nfsiod_workqueue, &ctx->work);
+		wait_for_completion(&done);
+	} else
+		queue_work(nfsiod_workqueue, &ctx->work);
+	nfs_local_fsync_ctx_put(ctx);
+	return 0;
+}
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 352fdaed4075..1eab98c277fa 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1685,6 +1685,67 @@ TRACE_EVENT(nfs_mount_path,
 	TP_printk("path='%s'", __get_str(path))
 );
 
+TRACE_EVENT(nfs_local_open_fh,
+		TP_PROTO(
+			const struct nfs_fh *fh,
+			fmode_t fmode,
+			int error
+		),
+
+		TP_ARGS(fh, fmode, error),
+
+		TP_STRUCT__entry(
+			__field(int, error)
+			__field(u32, fhandle)
+			__field(unsigned int, fmode)
+		),
+
+		TP_fast_assign(
+			__entry->error = error;
+			__entry->fhandle = nfs_fhandle_hash(fh);
+			__entry->fmode = (__force unsigned int)fmode;
+		),
+
+		TP_printk(
+			"error=%d fhandle=0x%08x mode=%s",
+			__entry->error,
+			__entry->fhandle,
+			show_fs_fmode_flags(__entry->fmode)
+		)
+);
+
+DECLARE_EVENT_CLASS(nfs_local_client_event,
+		TP_PROTO(
+			const struct nfs_client *clp
+		),
+
+		TP_ARGS(clp),
+
+		TP_STRUCT__entry(
+			__field(unsigned int, protocol)
+			__string(server, clp->cl_hostname)
+		),
+
+		TP_fast_assign(
+			__entry->protocol = clp->rpc_ops->version;
+			__assign_str(server);
+		),
+
+		TP_printk(
+			"server=%s NFSv%u", __get_str(server), __entry->protocol
+		)
+);
+
+#define DEFINE_NFS_LOCAL_CLIENT_EVENT(name) \
+	DEFINE_EVENT(nfs_local_client_event, name, \
+			TP_PROTO( \
+				const struct nfs_client *clp \
+			), \
+			TP_ARGS(clp))
+
+DEFINE_NFS_LOCAL_CLIENT_EVENT(nfs_local_enable);
+DEFINE_NFS_LOCAL_CLIENT_EVENT(nfs_local_disable);
+
 DECLARE_EVENT_CLASS(nfs_xdr_event,
 		TP_PROTO(
 			const struct xdr_stream *xdr,
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 532cfaf79813..c4160edd377e 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -762,6 +762,10 @@ int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 		hdr->args.count,
 		(unsigned long long)hdr->args.offset);
 
+	if (localio)
+		return nfs_local_doio(NFS_SERVER(hdr->inode)->nfs_client,
+				      localio, hdr, call_ops);
+
 	task = rpc_run_task(&task_setup_data);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index ad9e98e46a0d..8bc807a3e041 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1693,6 +1693,9 @@ int nfs_initiate_commit(struct rpc_clnt *clnt, struct nfs_commit_data *data,
 
 	dprintk("NFS: initiated commit call\n");
 
+	if (localio)
+		return nfs_local_commit(localio, data, call_ops, how);
+
 	task = rpc_run_task(&task_setup_data);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index 5ff1a5b3b00c..89ef8c5e98db 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -8,6 +8,8 @@
 #ifndef _LINUX_NFS_H
 #define _LINUX_NFS_H
 
+#include <linux/cred.h>
+#include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/string.h>
 #include <linux/crc32.h>
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 3849cc2832f0..5edc57657985 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -50,6 +50,7 @@ struct nfs_client {
 #define NFS_CS_DS		7		/* - Server is a DS */
 #define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
 #define NFS_CS_PNFS		9		/* - Server used for pnfs */
+#define NFS_CS_LOCAL_IO		10		/* - client is local */
 	struct sockaddr_storage	cl_addr;	/* server identifier */
 	size_t			cl_addrlen;
 	char *			cl_hostname;	/* hostname of server */
-- 
2.44.0


