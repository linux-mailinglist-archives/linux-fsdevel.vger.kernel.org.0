Return-Path: <linux-fsdevel+bounces-26296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBF99572DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617AC1F24110
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD7F189F5A;
	Mon, 19 Aug 2024 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBzxDkiB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1F189F33;
	Mon, 19 Aug 2024 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091486; cv=none; b=jRI8ZBpI/JGhNZYlskiQniMDHpHaztRGFBS1eLvPjfP2sCzYdYZ801gd67FGrldBTmtEh6ERfXNFRsObxfjDUipHqBMkGWjhQyYom1DbMllaNfeVfAUsXCeCsg6lmcoMnBsZqQTCoDr/aSXTOMlshFCRXya6UN1FNIA7y+jB5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091486; c=relaxed/simple;
	bh=5WD74DXR7BeYq0WFWnmeaPOEpv9MT5wb/IV+WpkpIiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxZ7SQmWszPzETTkzelK68+qsJ9pNfDKZljR/g6FfWwF+iSb+8TJRxgvGJwBSAxtrcncNMhmU7j3ZJzypYa5WTTQpLf6DZdnUws186Lm3SpSUfjgGf3QswAle+5Ox9GB6U5rLL2a8cF2KK1/n5UFytmBwwZwgHvgl762cPLV4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBzxDkiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9644AC32782;
	Mon, 19 Aug 2024 18:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091485;
	bh=5WD74DXR7BeYq0WFWnmeaPOEpv9MT5wb/IV+WpkpIiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBzxDkiBJQzquRShQ26Rmth3VHr8OEvsO0biEYDNPAn1a5ZZFWchacgBtT0OXG/8l
	 j5+rN9erQqnmfcznz095w/MRpkHVEVd1G5YvEvm1Lzp7ZT8f38h6G0UOuMR3qX74Xq
	 070IpGkXaMgSFOkxwXd6aHBT6m2AzoLbnP0PFnlm244HCBQkfQeLTvQUzuGwlT04E3
	 Z6wnPnnGFWJ9GygcWLgQqGf/Ip39uLrhVrzTAo/2UWxgzoKvKk8l144++fZdcyiH+p
	 O+2XvL1GgM5j6qfaL0WiYQkUxokYJzYsXGQJuXPQ8nRfV8ZnWEnAmmzRjWHtNN+krr
	 FOK3gT8ABs1kw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 10/24] nfsd: add localio support
Date: Mon, 19 Aug 2024 14:17:15 -0400
Message-ID: <20240819181750.70570-11-snitzer@kernel.org>
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

Add server support for bypassing NFS for localhost reads, writes, and
commits. This is only useful when both the client and server are
running on the same host.

If nfsd_open_local_fh() fails then the NFS client will both retry and
fallback to normal network-based read, write and commit operations if
localio is no longer supported.

Care is taken to ensure the same NFS security mechanisms are used
(authentication, etc) regardless of whether localio or regular NFS
access is used.  The auth_domain established as part of the traditional
NFS client access to the NFS server is also used for localio.  Store
auth_domain for localio in nfsd_uuid_t and transfer it to the client
if it is local to the server.

Relative to containers, localio gives the client access to the network
namespace the server has.  This is required to allow the client to
access the server's per-namespace nfsd_net struct.

CONFIG_NFSD_LOCALIO controls the server enablement for localio.
A later commit will add CONFIG_NFS_LOCALIO to allow the client
enablement.

This commit also introduces the use of a percpu_ref to interlock
nfsd_destroy_serv and nfsd_open_local_fh, and warrants a more
detailed explanation:

Introduce nfsd_serv_try_get and nfsd_serv_put and update the nfsd code
to prevent nfsd_destroy_serv from destroying nn->nfsd_serv until any
client initiated localio calls to nfsd (that are _not_ in the context
of nfsd) are complete.

nfsd_open_local_fh is updated to nfsd_serv_try_get before opening its
file handle and then drop the reference using nfsd_serv_put at the end
of nfsd_open_local_fh.

This "interlock" working relies heavily on nfsd_open_local_fh()'s
maybe_get_net() safely dealing with the possibility that the struct
net (and nfsd_net by association) may have been destroyed by
nfsd_destroy_serv() via nfsd_shutdown_net().

Verified to fix an easy to hit crash that would occur if an nfsd
instance running in a container, with a localio client mounted, is
shutdown. Upon restart of the container and associated nfsd the client
would go on to crash due to NULL pointer dereference that occuured due
to the nfs client's localio attempting to nfsd_open_local_fh(), using
nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/Kconfig          |   3 ++
 fs/nfsd/Kconfig     |  14 ++++++
 fs/nfsd/Makefile    |   1 +
 fs/nfsd/filecache.c |   2 +-
 fs/nfsd/localio.c   | 111 ++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/netns.h     |   8 +++-
 fs/nfsd/nfssvc.c    |  39 ++++++++++++++++
 fs/nfsd/trace.h     |   3 +-
 fs/nfsd/vfs.h       |  10 ++++
 9 files changed, 188 insertions(+), 3 deletions(-)
 create mode 100644 fs/nfsd/localio.c

diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f..1b8a5edbddff 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -377,6 +377,9 @@ config NFS_ACL_SUPPORT
 	tristate
 	select FS_POSIX_ACL
 
+config NFS_COMMON_LOCALIO_SUPPORT
+	bool
+
 config NFS_COMMON
 	bool
 	depends on NFSD || NFS_FS || LOCKD
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index c0bd1509ccd4..1fca57c79c60 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -90,6 +90,20 @@ config NFSD_V4
 
 	  If unsure, say N.
 
+config NFSD_LOCALIO
+	bool "NFS server support for the LOCALIO auxiliary protocol"
+	depends on NFSD
+	select NFS_COMMON_LOCALIO_SUPPORT
+	help
+	  Some NFS servers support an auxiliary NFS LOCALIO protocol
+	  that is not an official part of the NFS protocol.
+
+	  This option enables support for the LOCALIO protocol in the
+	  kernel's NFS server.  Enable this to bypass using the NFS
+	  protocol when issuing reads, writes and commits to the server.
+
+	  If unsure, say N.
+
 config NFSD_PNFS
 	bool
 
diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index b8736a82e57c..78b421778a79 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
 nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
+nfsd-$(CONFIG_NFSD_LOCALIO) += localio.o
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2cc838bbeb89..56be99a3667a 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -52,7 +52,7 @@
 #define NFSD_FILE_CACHE_UP		     (0)
 
 /* We only care about NFSD_MAY_READ/WRITE for this cache */
-#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
+#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
 
 static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
new file mode 100644
index 000000000000..ed528524b368
--- /dev/null
+++ b/fs/nfsd/localio.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NFS server support for local clients to bypass network stack
+ *
+ * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
+ * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+
+#include <linux/exportfs.h>
+#include <linux/sunrpc/svcauth_gss.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/nfs.h>
+#include <linux/nfs_common.h>
+#include <linux/nfslocalio.h>
+#include <linux/string.h>
+
+#include "nfsd.h"
+#include "vfs.h"
+#include "netns.h"
+#include "filecache.h"
+
+/**
+ * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to @file
+ *
+ * @cl_nfssvc_net: the 'struct net' to use to get the proper nfsd_net
+ * @cl_nfssvc_dom: the 'struct auth_domain' required for localio access
+ * @rpc_clnt: rpc_clnt that the client established, used for sockaddr and cred
+ * @cred: cred that the client established
+ * @nfs_fh: filehandle to lookup
+ * @fmode: fmode_t to use for open
+ * @pfilp: returned file pointer that maps to @nfs_fh
+ *
+ * This function maps a local fh to a path on a local filesystem.
+ * This is useful when the nfs client has the local server mounted - it can
+ * avoid all the NFS overhead with reads, writes and commits.
+ *
+ * On successful return, caller is responsible for calling path_put. Also
+ * note that this is called from nfs.ko via find_symbol() to avoid an explicit
+ * dependency on knfsd. So, there is no forward declaration in a header file
+ * for it that is shared with the client.
+ */
+int nfsd_open_local_fh(struct net *cl_nfssvc_net,
+			 struct auth_domain *cl_nfssvc_dom,
+			 struct rpc_clnt *rpc_clnt,
+			 const struct cred *cred,
+			 const struct nfs_fh *nfs_fh,
+			 const fmode_t fmode,
+			 struct file **pfilp)
+{
+	int mayflags = NFSD_MAY_LOCALIO;
+	int status = 0;
+	struct nfsd_net *nn;
+	const struct cred *save_cred;
+	struct svc_cred rq_cred;
+	struct svc_fh fh;
+	struct nfsd_file *nf;
+	__be32 beres;
+
+	if (nfs_fh->size > NFS4_FHSIZE)
+		return -EINVAL;
+
+	/* Not running in nfsd context, must safely get reference on nfsd_serv */
+	cl_nfssvc_net = maybe_get_net(cl_nfssvc_net);
+	if (!cl_nfssvc_net)
+		return -ENXIO;
+	nn = net_generic(cl_nfssvc_net, nfsd_net_id);
+
+	/* The server may already be shutting down, disallow new localio */
+	if (unlikely(!nfsd_serv_try_get(nn))) {
+		status = -ENXIO;
+		goto out_net;
+	}
+
+	/* Save client creds before calling nfsd_file_acquire_local which calls nfsd_setuser */
+	save_cred = get_current_cred();
+
+	/* nfs_fh -> svc_fh */
+	fh_init(&fh, NFS4_FHSIZE);
+	fh.fh_handle.fh_size = nfs_fh->size;
+	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
+
+	if (fmode & FMODE_READ)
+		mayflags |= NFSD_MAY_READ;
+	if (fmode & FMODE_WRITE)
+		mayflags |= NFSD_MAY_WRITE;
+
+	rpcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
+
+	beres = nfsd_file_acquire_local(cl_nfssvc_net, &rq_cred, rpc_clnt->cl_vers,
+					cl_nfssvc_dom, &fh, mayflags, &nf);
+	if (beres) {
+		status = nfs_stat_to_errno(be32_to_cpu(beres));
+		goto out_fh_put;
+	}
+	*pfilp = get_file(nf->nf_file);
+	nfsd_file_put(nf);
+out_fh_put:
+	fh_put(&fh);
+	if (rq_cred.cr_group_info)
+		put_group_info(rq_cred.cr_group_info);
+	revert_creds(save_cred);
+	nfsd_serv_put(nn);
+out_net:
+	put_net(cl_nfssvc_net);
+	return status;
+}
+EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
+
+/* Compile time type checking, not used by anything */
+static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 238fc4e56e53..e2d953f21dde 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -13,6 +13,7 @@
 #include <linux/filelock.h>
 #include <linux/nfs4.h>
 #include <linux/percpu_counter.h>
+#include <linux/percpu-refcount.h>
 #include <linux/siphash.h>
 #include <linux/sunrpc/stats.h>
 
@@ -139,7 +140,9 @@ struct nfsd_net {
 
 	struct svc_info nfsd_info;
 #define nfsd_serv nfsd_info.serv
-
+	struct percpu_ref nfsd_serv_ref;
+	struct completion nfsd_serv_confirm_done;
+	struct completion nfsd_serv_free_done;
 
 	/*
 	 * clientid and stateid data for construction of net unique COPY
@@ -221,6 +224,9 @@ struct nfsd_net {
 extern bool nfsd_support_version(int vers);
 extern unsigned int nfsd_net_id;
 
+bool nfsd_serv_try_get(struct nfsd_net *nn);
+void nfsd_serv_put(struct nfsd_net *nn);
+
 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
 void nfsd_reset_write_verifier(struct nfsd_net *nn);
 #endif /* __NFSD_NETNS_H__ */
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index defc430f912f..e43d440f9f0a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -193,6 +193,30 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
 	return 0;
 }
 
+bool nfsd_serv_try_get(struct nfsd_net *nn)
+{
+	return percpu_ref_tryget_live(&nn->nfsd_serv_ref);
+}
+
+void nfsd_serv_put(struct nfsd_net *nn)
+{
+	percpu_ref_put(&nn->nfsd_serv_ref);
+}
+
+static void nfsd_serv_done(struct percpu_ref *ref)
+{
+	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
+
+	complete(&nn->nfsd_serv_confirm_done);
+}
+
+static void nfsd_serv_free(struct percpu_ref *ref)
+{
+	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
+
+	complete(&nn->nfsd_serv_free_done);
+}
+
 /*
  * Maximum number of nfsd processes
  */
@@ -392,6 +416,7 @@ static void nfsd_shutdown_net(struct net *net)
 		lockd_down(net);
 		nn->lockd_up = false;
 	}
+	percpu_ref_exit(&nn->nfsd_serv_ref);
 	nn->nfsd_net_up = false;
 	nfsd_shutdown_generic();
 }
@@ -471,6 +496,13 @@ void nfsd_destroy_serv(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv = nn->nfsd_serv;
 
+	lockdep_assert_held(&nfsd_mutex);
+
+	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
+	wait_for_completion(&nn->nfsd_serv_confirm_done);
+	wait_for_completion(&nn->nfsd_serv_free_done);
+	/* percpu_ref_exit is called in nfsd_shutdown_net */
+
 	spin_lock(&nfsd_notifier_lock);
 	nn->nfsd_serv = NULL;
 	spin_unlock(&nfsd_notifier_lock);
@@ -595,6 +627,13 @@ int nfsd_create_serv(struct net *net)
 	if (nn->nfsd_serv)
 		return 0;
 
+	error = percpu_ref_init(&nn->nfsd_serv_ref, nfsd_serv_free,
+				0, GFP_KERNEL);
+	if (error)
+		return error;
+	init_completion(&nn->nfsd_serv_free_done);
+	init_completion(&nn->nfsd_serv_confirm_done);
+
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d49b3c1e3ba9..20e170f19b0b 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
 		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
 		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
 		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
-		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
+		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
+		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
 
 TRACE_EVENT(nfsd_compound,
 	TP_PROTO(
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 01947561d375..9720951c49a0 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -33,6 +33,8 @@
 
 #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >= NFSv3 */
 
+#define NFSD_MAY_LOCALIO		0x2000 /* for tracing, reflects when localio used */
+
 #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
 #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
 
@@ -158,6 +160,14 @@ __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 void		nfsd_filp_close(struct file *fp);
 
+int		nfsd_open_local_fh(struct net *net,
+				   struct auth_domain *dom,
+				   struct rpc_clnt *rpc_clnt,
+				   const struct cred *cred,
+				   const struct nfs_fh *nfs_fh,
+				   const fmode_t fmode,
+				   struct file **pfilp);
+
 static inline int fh_want_write(struct svc_fh *fh)
 {
 	int ret;
-- 
2.44.0


