Return-Path: <linux-fsdevel+bounces-28129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3859673C1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745751C210C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5911D183CB7;
	Sat, 31 Aug 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzkePwPU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DB9183CB5;
	Sat, 31 Aug 2024 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143902; cv=none; b=mTkXnqVL3bLNTAOrRzG9xfiu3cEmwPUk4PDaRvFDWCqV3oAq3JZiiAoRMaZxo4UKwYmetyU1TRz5krp6VTN8/ULdFONRqYgGYmt0sJ0F987mkqoBRBDi8uzKE2JWQUcmmLn4vVBIQBaveX3EDseWAtVDONJu9uU3NlOWe+tfNQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143902; c=relaxed/simple;
	bh=YywFjflGPPhTShB/wevw7bUmcut77+bbIO7mI6lvsgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pghxUt1u9x+yuI6AP8AL1raLYh09XzdMWY2cnN+4AOSEmoACzdZ3Mi6I27nqU6sqJiUidT58px738hHxcgw/6j0PCxQZ4vadjvuo52xae0uN5MKM1ifIUIDYzzOsRWjh4jsZbshBFbm8TdTSkzmFRtHZtvitSz+m09l+hIpslvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzkePwPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89DCC4CEC0;
	Sat, 31 Aug 2024 22:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143902;
	bh=YywFjflGPPhTShB/wevw7bUmcut77+bbIO7mI6lvsgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NzkePwPUnbIk//Sz6plnwmLjRS/R3CjG6o2TFvcOnWYmZIRcjwSI2PhH/rBi3BEDA
	 aw+KVhteQrTNZqq1Zo41n6T15g5q9ZcBcEXTRQ0apM9Z7Yt5YXHBClHKxfhrIQqHyC
	 eJFvGe9g6XBvw/fmO293IdgTebuR1oEsxofv/PNN8KO52KyP05gnwL4V00C+PZ0eI6
	 7ERVfRhKffclQZKYe6TWNNfnlYVoepw68U+LRQSHg6ZFoaE5dit60OcErhnQZlVPyo
	 /o2KHJSlWYwKbvUzgTdwOsTWAVnYIwtGsEX340UVwwvKb29BlptckSReNEnOcgrdfL
	 NrXrj3PjJOzbQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 19/26] nfs: add LOCALIO support
Date: Sat, 31 Aug 2024 18:37:39 -0400
Message-ID: <20240831223755.8569-20-snitzer@kernel.org>
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

From: Weston Andros Adamson <dros@primarydata.com>

Add client support for bypassing NFS for localhost reads, writes, and
commits. This is only useful when the client and the server are
running on the same host.

nfs_local_probe() is stubbed out, later commits will enable client and
server handshake via a Linux-only LOCALIO auxiliary RPC protocol.

This has dynamic binding with the nfsd module (via nfs_localio module
which is part of nfs_common). LOCALIO will only work if nfsd is
already loaded.

The "localio_enabled" nfs kernel module parameter can be used to
disable and enable the ability to use LOCALIO support.

CONFIG_NFS_LOCALIO enables NFS client support for LOCALIO.

Lastly, LOCALIO uses an nfsd_file to initiate all IO. To make proper
use of nfsd_file (and nfsd's filecache) its lifetime (duration before
nfsd_file_put is called) must extend until after commit, read and
write operations. So rather than immediately drop the nfsd_file
reference in nfs_local_open_fh(), that doesn't happen until
nfs_local_pgio_release() for read/write and not until
nfs_local_release_commit_data() for commit. The same applies to the
reference held on nfsd's nn->nfsd_serv. Both objects' lifetimes and
associated references are managed through calls to
nfs_to.nfsd_file_put_local().

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de> # nfs_open_local_fh
---
 fs/nfs/Makefile            |   1 +
 fs/nfs/client.c            |  11 +
 fs/nfs/internal.h          |  45 +++
 fs/nfs/localio.c           | 600 +++++++++++++++++++++++++++++++++++++
 fs/nfs/nfstrace.h          |  61 ++++
 fs/nfs/pagelist.c          |   4 +
 fs/nfs/write.c             |   3 +
 fs/nfs_common/nfslocalio.c |  23 ++
 include/linux/nfs.h        |   2 +
 include/linux/nfs_fs_sb.h  |   9 +
 include/linux/nfslocalio.h |   4 +
 11 files changed, 763 insertions(+)
 create mode 100644 fs/nfs/localio.c

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
index 8286edd6062d..0d307878b9aa 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -178,6 +178,14 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
 	clp->cl_net = get_net(cl_init->net);
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	seqlock_init(&clp->cl_boot_lock);
+	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
+	clp->cl_uuid.net = NULL;
+	clp->cl_uuid.dom = NULL;
+	spin_lock_init(&clp->cl_localio_lock);
+#endif /* CONFIG_NFS_LOCALIO */
+
 	clp->cl_principal = "*";
 	clp->cl_xprtsec = cl_init->xprtsec;
 	return clp;
@@ -233,6 +241,8 @@ static void pnfs_init_server(struct nfs_server *server)
  */
 void nfs_free_client(struct nfs_client *clp)
 {
+	nfs_local_disable(clp);
+
 	/* -EIO all pending I/O */
 	if (!IS_ERR(clp->cl_rpcclient))
 		rpc_shutdown_client(clp->cl_rpcclient);
@@ -424,6 +434,7 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
 			list_add_tail(&new->cl_share_link,
 					&nn->nfs_client_list);
 			spin_unlock(&nn->nfs_client_lock);
+			nfs_local_probe(new);
 			return rpc_ops->init_client(new, cl_init);
 		}
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9b89294fb2ad..9707b5a3a44a 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -451,6 +451,51 @@ extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
 extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
 extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+/* localio.c */
+extern void nfs_local_disable(struct nfs_client *);
+extern void nfs_local_probe(struct nfs_client *);
+extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
+					   const struct cred *,
+					   struct nfs_fh *,
+					   const fmode_t);
+extern int nfs_local_doio(struct nfs_client *,
+			  struct nfsd_file *,
+			  struct nfs_pgio_header *,
+			  const struct rpc_call_ops *);
+extern int nfs_local_commit(struct nfsd_file *,
+			    struct nfs_commit_data *,
+			    const struct rpc_call_ops *, int);
+extern bool nfs_server_is_local(const struct nfs_client *clp);
+
+#else /* CONFIG_NFS_LOCALIO */
+static inline void nfs_local_disable(struct nfs_client *clp) {}
+static inline void nfs_local_probe(struct nfs_client *clp) {}
+static inline struct nfsd_file *
+nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
+		  struct nfs_fh *fh, const fmode_t mode)
+{
+	return NULL;
+}
+static inline int nfs_local_doio(struct nfs_client *clp,
+				 struct nfsd_file *localio,
+				 struct nfs_pgio_header *hdr,
+				 const struct rpc_call_ops *call_ops)
+{
+	return -EINVAL;
+}
+static inline int nfs_local_commit(struct nfsd_file *localio,
+				struct nfs_commit_data *data,
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
index 000000000000..c79ef15ba83b
--- /dev/null
+++ b/fs/nfs/localio.c
@@ -0,0 +1,600 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NFS client support for local clients to bypass network stack
+ *
+ * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
+ * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ * Copyright (C) 2024 NeilBrown <neilb@suse.de>
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
+	struct nfsd_file	*localio;
+};
+
+struct nfs_local_fsync_ctx {
+	struct nfsd_file	*localio;
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
+static __maybe_unused void nfs_local_enable(struct nfs_client *clp)
+{
+	spin_lock(&clp->cl_localio_lock);
+	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+	trace_nfs_local_enable(clp);
+	spin_unlock(&clp->cl_localio_lock);
+}
+
+/*
+ * nfs_local_disable - disable local i/o for an nfs_client
+ */
+void nfs_local_disable(struct nfs_client *clp)
+{
+	spin_lock(&clp->cl_localio_lock);
+	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
+		trace_nfs_local_disable(clp);
+		nfs_uuid_invalidate_one_client(&clp->cl_uuid);
+	}
+	spin_unlock(&clp->cl_localio_lock);
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
+ * nfs_local_open_fh - open a local filehandle in terms of nfsd_file
+ *
+ * Returns a pointer to a struct nfsd_file or NULL
+ */
+struct nfsd_file *
+nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
+		  struct nfs_fh *fh, const fmode_t mode)
+{
+	struct nfsd_file *localio;
+	int status;
+
+	if (!nfs_server_is_local(clp))
+		return NULL;
+	if (mode & ~(FMODE_READ | FMODE_WRITE))
+		return NULL;
+
+	localio = nfs_open_local_fh(&clp->cl_uuid, clp->cl_rpcclient,
+				    cred, fh, mode);
+	if (IS_ERR(localio)) {
+		status = PTR_ERR(localio);
+		trace_nfs_local_open_fh(fh, mode, status);
+		switch (status) {
+		case -ENOMEM:
+		case -ENXIO:
+		case -ENOENT:
+			nfs_local_disable(clp);
+		}
+		return NULL;
+	}
+	return localio;
+}
+EXPORT_SYMBOL_GPL(nfs_local_open_fh);
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
+nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
+		     struct nfsd_file *localio, gfp_t flags)
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
+	init_sync_kiocb(&iocb->kiocb, nfs_to.nfsd_file_file(localio));
+	iocb->kiocb.ki_pos = hdr->args.offset;
+	iocb->localio = localio;
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
+	nfs_to.nfsd_file_put_local(iocb->localio);
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
+nfs_do_local_read(struct nfs_pgio_header *hdr,
+		  struct nfsd_file *localio,
+		  const struct rpc_call_ops *call_ops)
+{
+	struct file *filp = nfs_to.nfsd_file_file(localio);
+	struct nfs_local_kiocb *iocb;
+	struct iov_iter iter;
+	ssize_t status;
+
+	dprintk("%s: vfs_read count=%u pos=%llu\n",
+		__func__, hdr->args.count, hdr->args.offset);
+
+	iocb = nfs_local_iocb_alloc(hdr, localio, GFP_KERNEL);
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
+nfs_do_local_write(struct nfs_pgio_header *hdr,
+		   struct nfsd_file *localio,
+		   const struct rpc_call_ops *call_ops)
+{
+	struct file *filp = nfs_to.nfsd_file_file(localio);
+	struct nfs_local_kiocb *iocb;
+	struct iov_iter iter;
+	ssize_t status;
+
+	dprintk("%s: vfs_write count=%u pos=%llu %s\n",
+		__func__, hdr->args.count, hdr->args.offset,
+		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
+
+	iocb = nfs_local_iocb_alloc(hdr, localio, GFP_NOIO);
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
+int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
+		   struct nfs_pgio_header *hdr,
+		   const struct rpc_call_ops *call_ops)
+{
+	int status = 0;
+	struct file *filp = nfs_to.nfsd_file_file(localio);
+
+	if (!hdr->args.count)
+		return 0;
+	/* Don't support filesystems without read_iter/write_iter */
+	if (!filp->f_op->read_iter || !filp->f_op->write_iter) {
+		nfs_local_disable(clp);
+		status = -EAGAIN;
+		goto out;
+	}
+
+	switch (hdr->rw_mode) {
+	case FMODE_READ:
+		status = nfs_do_local_read(hdr, localio, call_ops);
+		break;
+	case FMODE_WRITE:
+		status = nfs_do_local_write(hdr, localio, call_ops);
+		break;
+	default:
+		dprintk("%s: invalid mode: %d\n", __func__,
+			hdr->rw_mode);
+		status = -EINVAL;
+	}
+out:
+	if (status != 0) {
+		nfs_to.nfsd_file_put_local(localio);
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
+nfs_local_release_commit_data(struct nfsd_file *localio,
+		struct nfs_commit_data *data,
+		const struct rpc_call_ops *call_ops)
+{
+	nfs_to.nfsd_file_put_local(localio);
+	call_ops->rpc_call_done(&data->task, data);
+	call_ops->rpc_release(data);
+}
+
+static struct nfs_local_fsync_ctx *
+nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data,
+			  struct nfsd_file *localio, gfp_t flags)
+{
+	struct nfs_local_fsync_ctx *ctx = kmalloc(sizeof(*ctx), flags);
+
+	if (ctx != NULL) {
+		ctx->localio = localio;
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
+	nfs_local_release_commit_data(ctx->localio, ctx->data,
+				      ctx->data->task.tk_ops);
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
+	status = nfs_local_run_commit(nfs_to.nfsd_file_file(ctx->localio),
+				      ctx->data);
+	nfs_local_commit_done(ctx->data, status);
+	if (ctx->done != NULL)
+		complete(ctx->done);
+	nfs_local_fsync_ctx_free(ctx);
+}
+
+int nfs_local_commit(struct nfsd_file *localio,
+		     struct nfs_commit_data *data,
+		     const struct rpc_call_ops *call_ops, int how)
+{
+	struct nfs_local_fsync_ctx *ctx;
+
+	ctx = nfs_local_fsync_ctx_alloc(data, localio, GFP_KERNEL);
+	if (!ctx) {
+		nfs_local_commit_done(data, -ENOMEM);
+		nfs_local_release_commit_data(localio, data, call_ops);
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
index 50f3d6c9ac2a..97d5524c379a 100644
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
index 04d0b5b95f4f..404cc5281e6a 100644
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
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 64f75a3a370a..b65a2b7e12d5 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -115,6 +115,29 @@ void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
 
+struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
+		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
+		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
+{
+	struct nfsd_file *localio;
+
+	/*
+	 * uuid->net must not be NULL, otherwise NFS may not have ref
+	 * on NFSD and therefore cannot safely make 'nfs_to' calls.
+	 */
+	rcu_read_lock();
+	if (!rcu_access_pointer(uuid->net)) {
+		rcu_read_unlock();
+		return ERR_PTR(-ENXIO);
+	}
+	localio = nfs_to.nfsd_open_local_fh(uuid, rpc_clnt, cred,
+					    nfs_fh, fmode);
+	rcu_read_unlock();
+
+	return localio;
+}
+EXPORT_SYMBOL_GPL(nfs_open_local_fh);
+
 /*
  * The NFS LOCALIO code needs to call into NFSD using various symbols,
  * but cannot be statically linked, because that will make the NFS
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index 73da75908d95..9ad727ddfedb 100644
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
index 1df86ab98c77..b43e3e067e44 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -8,6 +8,7 @@
 #include <linux/wait.h>
 #include <linux/nfs_xdr.h>
 #include <linux/sunrpc/xprt.h>
+#include <linux/nfslocalio.h>
 
 #include <linux/atomic.h>
 #include <linux/refcount.h>
@@ -49,6 +50,7 @@ struct nfs_client {
 #define NFS_CS_DS		7		/* - Server is a DS */
 #define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
 #define NFS_CS_PNFS		9		/* - Server used for pnfs */
+#define NFS_CS_LOCAL_IO		10		/* - client is local */
 	struct sockaddr_storage	cl_addr;	/* server identifier */
 	size_t			cl_addrlen;
 	char *			cl_hostname;	/* hostname of server */
@@ -125,6 +127,13 @@ struct nfs_client {
 	struct net		*cl_net;
 	struct list_head	pending_cb_stateids;
 	struct rcu_head		rcu;
+
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	struct timespec64	cl_nfssvc_boot;
+	seqlock_t		cl_boot_lock;
+	nfs_uuid_t		cl_uuid;
+	spinlock_t		cl_localio_lock;
+#endif /* CONFIG_NFS_LOCALIO */
 };
 
 /*
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 5e57158e219d..65d55017c4c8 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -66,6 +66,10 @@ struct nfsd_localio_operations {
 extern void nfsd_localio_ops_init(void);
 extern struct nfsd_localio_operations nfs_to;
 
+struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
+		   struct rpc_clnt *, const struct cred *,
+		   const struct nfs_fh *, const fmode_t);
+
 #else   /* CONFIG_NFS_LOCALIO */
 static inline void nfsd_localio_ops_init(void)
 {
-- 
2.44.0


