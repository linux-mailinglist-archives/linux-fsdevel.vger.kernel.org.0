Return-Path: <linux-fsdevel+bounces-28126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A0A9673BB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684D51F21866
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC46F18F2CF;
	Sat, 31 Aug 2024 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQITmTWe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B26F18E371;
	Sat, 31 Aug 2024 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143898; cv=none; b=PAE/Ydq4ELdh8PTk92qK8uSfQXAdffwqYVP1QyMsi4qg+q+9fYzlGfKdBFhFmFYe/eH4j8PCvss29pmyU067nJRbYKUbdats0giekyoczPv51w2uB2sdZWE4QuCE2UFN0IojuZPwtAy0Ev8yp3BHhwo6mzcRp8STOvrD7wKI6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143898; c=relaxed/simple;
	bh=Tfvmv8s0f1w34dT57Qs8Su+8wQYF7vdhAbirTHCY12k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LN6u3mxqeSQkk/zCYucjiUoxz4fXvMEIf3Q+0qY6emlFwdzQqybpFDJZmyugic91y5pw/7xqHotyTBotAiWVo5zpBF9leOc1f4SrVE8V+hkKL+cJe1UdP4VJSXXSzHqvMndEgOVaNzi+pwjyMaOR0X535DcITghfMLRswCiOIx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQITmTWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6D9C4CEC4;
	Sat, 31 Aug 2024 22:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143898;
	bh=Tfvmv8s0f1w34dT57Qs8Su+8wQYF7vdhAbirTHCY12k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQITmTWeKxCS8g15cybJOOoHHrOyfsJhH/tIw/Sc5NCozl9TnAj0veHTg9110jLQF
	 mCR5CvSw+PJ1Pb1mqnNi4i28BPUCUgUWqiaMtlsuFUVulESdA4GDxyQDSX+eucCXbI
	 Ne/htNgjWXrDJ/qMNg6yqXIBS61R/32Nv8EHojz9v2rfuOiCAi25HYQAN+8m5pKXOR
	 sxD2EERgVpvZV88BEcUeSJksgdNLqNbip7Anhz2vuez+W98loZgQfC+CIaJgNMysVv
	 sXRn/VaykPgdyXAGS6HooBrlfFrICHvDsT4Hi7ih9uBJyaZlkmxNHZe1WzW4AuOJw8
	 KTekuJcdvjZhQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 16/26] nfsd: add LOCALIO support
Date: Sat, 31 Aug 2024 18:37:36 -0400
Message-ID: <20240831223755.8569-17-snitzer@kernel.org>
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

This commit also introduces the use of NFSD's percpu_ref to interlock
nfsd_destroy_serv and nfsd_open_local_fh, to ensure nn->nfsd_serv is
not destroyed while in use by nfsd_open_local_fh and other LOCALIO
client code.

CONFIG_NFS_LOCALIO enables NFS server support for LOCALIO.

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Co-developed-by: NeilBrown <neilb@suse.de>
Signed-off-by: NeilBrown <neilb@suse.de>

Not-Acked-by: Chuck Lever <chuck.lever@oracle.com>
Not-Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/Makefile           |   1 +
 fs/nfsd/filecache.c        |   2 +-
 fs/nfsd/localio.c          | 112 +++++++++++++++++++++++++++++++++++++
 fs/nfsd/netns.h            |   4 ++
 fs/nfsd/nfsctl.c           |  25 ++++++++-
 fs/nfsd/trace.h            |   3 +-
 fs/nfsd/vfs.h              |   2 +
 include/linux/nfslocalio.h |   8 +++
 8 files changed, 154 insertions(+), 3 deletions(-)
 create mode 100644 fs/nfsd/localio.c

diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index b8736a82e57c..18cbd3fa7691 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
 nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
+nfsd-$(CONFIG_NFS_LOCALIO) += localio.o
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 89ff380ec31e..348c1b97092e 100644
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
index 000000000000..75df709c6903
--- /dev/null
+++ b/fs/nfsd/localio.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NFS server support for local clients to bypass network stack
+ *
+ * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
+ * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ * Copyright (C) 2024 NeilBrown <neilb@suse.de>
+ */
+
+#include <linux/exportfs.h>
+#include <linux/sunrpc/svcauth.h>
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
+static const struct nfsd_localio_operations nfsd_localio_ops = {
+	.nfsd_open_local_fh = nfsd_open_local_fh,
+	.nfsd_file_put_local = nfsd_file_put_local,
+	.nfsd_file_file = nfsd_file_file,
+};
+
+void nfsd_localio_ops_init(void)
+{
+	memcpy(&nfs_to, &nfsd_localio_ops, sizeof(nfsd_localio_ops));
+}
+
+/**
+ * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to nfsd_file
+ *
+ * @uuid: nfs_uuid_t which provides the 'struct net' to get the proper nfsd_net
+ *        and the 'struct auth_domain' required for LOCALIO access
+ * @rpc_clnt: rpc_clnt that the client established, used for sockaddr and cred
+ * @cred: cred that the client established
+ * @nfs_fh: filehandle to lookup
+ * @fmode: fmode_t to use for open
+ *
+ * This function maps a local fh to a path on a local filesystem.
+ * This is useful when the nfs client has the local server mounted - it can
+ * avoid all the NFS overhead with reads, writes and commits.
+ *
+ * On successful return, returned nfsd_file will have its nf_net member
+ * set. Caller (NFS client) is responsible for calling nfsd_serv_put and
+ * nfsd_file_put (via nfs_to.nfsd_file_put_local).
+ */
+struct nfsd_file *
+nfsd_open_local_fh(nfs_uuid_t *uuid,
+		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
+		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
+	__must_hold(rcu)
+{
+	int mayflags = NFSD_MAY_LOCALIO;
+	struct nfsd_net *nn = NULL;
+	struct net *net;
+	struct svc_cred rq_cred;
+	struct svc_fh fh;
+	struct nfsd_file *localio;
+	__be32 beres;
+
+	if (nfs_fh->size > NFS4_FHSIZE)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Not running in nfsd context, so must safely get reference on nfsd_serv.
+	 * But the server may already be shutting down, if so disallow new localio.
+	 * uuid->net is NOT a counted reference, but caller's rcu_read_lock() ensures
+	 * that if uuid->net is not NULL, then calling nfsd_serv_try_get() is safe
+	 * and if it succeeds we will have an implied reference to the net.
+	 */
+	net = rcu_dereference(uuid->net);
+	if (net)
+		nn = net_generic(net, nfsd_net_id);
+	if (unlikely(!nn || !nfsd_serv_try_get(nn)))
+		return ERR_PTR(-ENXIO);
+
+	/* Drop the rcu lock for nfsd_file_acquire_local() */
+	rcu_read_unlock();
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
+	svcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
+
+	beres = nfsd_file_acquire_local(uuid->net, &rq_cred, uuid->dom,
+					&fh, mayflags, &localio);
+	if (beres) {
+		localio = ERR_PTR(nfs_stat_to_errno(be32_to_cpu(beres)));
+		nfsd_serv_put(nn);
+	}
+
+	fh_put(&fh);
+	if (rq_cred.cr_group_info)
+		put_group_info(rq_cred.cr_group_info);
+
+	rcu_read_lock();
+	return localio;
+}
+EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index e2d953f21dde..0fd31188a951 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -216,6 +216,10 @@ struct nfsd_net {
 	/* last time an admin-revoke happened for NFSv4.0 */
 	time64_t		nfs40_last_revoke;
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	/* Local clients to be invalidated when net is shut down */
+	struct list_head	local_clients;
+#endif
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 64c1b4d649bc..3adbc05ebaac 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -18,6 +18,7 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/module.h>
 #include <linux/fsnotify.h>
+#include <linux/nfslocalio.h>
 
 #include "idmap.h"
 #include "nfsd.h"
@@ -2257,7 +2258,9 @@ static __net_init int nfsd_net_init(struct net *net)
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
 	nfsd_proc_stat_init(net);
-
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	INIT_LIST_HEAD(&nn->local_clients);
+#endif
 	return 0;
 
 out_repcache_error:
@@ -2268,6 +2271,22 @@ static __net_init int nfsd_net_init(struct net *net)
 	return retval;
 }
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+/**
+ * nfsd_net_pre_exit - Disconnect localio clients from net namespace
+ * @net: a network namespace that is about to be destroyed
+ *
+ * This invalidated ->net pointers held by localio clients
+ * while they can still safely access nn->counter.
+ */
+static __net_exit void nfsd_net_pre_exit(struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	nfs_uuid_invalidate_clients(&nn->local_clients);
+}
+#endif
+
 /**
  * nfsd_net_exit - Release the nfsd_net portion of a net namespace
  * @net: a network namespace that is about to be destroyed
@@ -2285,6 +2304,9 @@ static __net_exit void nfsd_net_exit(struct net *net)
 
 static struct pernet_operations nfsd_net_ops = {
 	.init = nfsd_net_init,
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	.pre_exit = nfsd_net_pre_exit,
+#endif
 	.exit = nfsd_net_exit,
 	.id   = &nfsd_net_id,
 	.size = sizeof(struct nfsd_net),
@@ -2322,6 +2344,7 @@ static int __init init_nfsd(void)
 	retval = genl_register_family(&nfsd_nl_family);
 	if (retval)
 		goto out_free_all;
+	nfsd_localio_ops_init();
 
 	return 0;
 out_free_all:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d22027e23761..82bcefcd1f21 100644
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
index 01947561d375..3ff146522556 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -33,6 +33,8 @@
 
 #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >= NFSv3 */
 
+#define NFSD_MAY_LOCALIO		0x2000 /* for tracing, reflects when localio used */
+
 #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
 #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 62419c4bc8f1..61f2c781dd50 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -6,6 +6,8 @@
 #ifndef __LINUX_NFSLOCALIO_H
 #define __LINUX_NFSLOCALIO_H
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/uuid.h>
@@ -63,4 +65,10 @@ struct nfsd_localio_operations {
 extern void nfsd_localio_ops_init(void);
 extern struct nfsd_localio_operations nfs_to;
 
+#else   /* CONFIG_NFS_LOCALIO */
+static inline void nfsd_localio_ops_init(void)
+{
+}
+#endif  /* CONFIG_NFS_LOCALIO */
+
 #endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


