Return-Path: <linux-fsdevel+bounces-27728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5263996376E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D641C21C26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08691494DF;
	Thu, 29 Aug 2024 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb1JmfNf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E67148FF7;
	Thu, 29 Aug 2024 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893487; cv=none; b=ZJFkDDRvSrM4BeIuyAVQI09qKq31DgAR0nL3/8pX7KjT1FWeDFhcicN8ZBu2K93bkmTARrlRMLo4uH0HztGiyGsiAkSSKn5hmDff6oP0V8Nhtcr1MoVUJ/id/JyglsWa4uwzyDtPqOHoV7NAebibhw83XBfmADqr4QgMqdn9sPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893487; c=relaxed/simple;
	bh=Y2vuv21WOezVAO71uDRpS07JmmYcZ1p5OKZIxZVUsgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Buzq/2+8QTo0Pv1nKNJRepNAAoVL1v/3J672s/P5Di6cRsiuEUryZQzNQTiSE/IGACMkHjjwCKwV+B9eToCfwyp9rhm6gU/bHd6Rb47jDUkPTUlBKqivKPjfObciejXgycIXtnk1JhuMn2NciNAKtlX8BxQjclisTTdwuqAcmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb1JmfNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF69C4CEC0;
	Thu, 29 Aug 2024 01:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893485;
	bh=Y2vuv21WOezVAO71uDRpS07JmmYcZ1p5OKZIxZVUsgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yb1JmfNfOLtWZNf+52Z5GeLuxMif5IW0I9VTogOU6Qd+TPdH8AUrW7iR01B4FMd0R
	 i2/XKbOrMC1O86SzCxsv0uN4NnHhsyKRnKUfPZms84aEeJ0T3XagYdIAy5AlvhhKTt
	 QxrRam5LCTSZDEfxQZ5mMIbIR2vqU4QPojG9tqx39BXFPvSVpAHZzn5FECWDeSZSqP
	 CeK74Y+vP5TO/SSb6DeQvO2Hge/vSoSUZtuW2Yc/+g5yLDlLlvFrYVC1vqLZ2M1JQJ
	 zUumId0Pq+fTn1pIBLFo0Pf443QQpQH0gOziInslcfO7DGlgIb1evuG+I6FUdusRva
	 Z3zfmn572V6gg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 15/25] nfs_common: introduce nfs_localio_ctx struct and interfaces
Date: Wed, 28 Aug 2024 21:04:10 -0400
Message-ID: <20240829010424.83693-16-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240829010424.83693-1-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce struct nfs_localio_ctx and the interfaces
nfs_localio_ctx_alloc() and nfs_localio_ctx_free().  The next commit
will introduce nfsd_open_local_fh() which returns a nfs_localio_ctx
structure.

Also, expose localio's required NFSD symbols to NFS client:
- Cache nfsd_open_local_fh symbol and other required NFSD symbols in a
  globally accessible 'nfs_to' nfs_to_nfsd_t struct.  Add interfaces
  get_nfs_to_nfsd_symbols() and put_nfs_to_nfsd_symbols() to allow
  each NFS client to take a reference on NFSD symbols.

- Apologies for the DEFINE_NFS_TO_NFSD_SYMBOL macro that makes
  defining get_##NFSD_SYMBOL() and put_##NFSD_SYMBOL() functions far
  simpler (and avoids cut-n-paste bugs, which is what motivated the
  development and use of a macro for this). But as C macros go it is a
  very simple one and there are many like it all over the kernel.

- Given the unique nature of NFS LOCALIO being an optional feature
  that when used requires NFS share access to NFSD memory: a unique
  bridging of NFSD resources to NFS (via nfs_common) is needed.  But
  that bridge must be dynamic, hence the use of symbol_request() and
  symbol_put().  Proposed ideas to accomolish the same without using
  symbol_{request,put} would be far more tedious to implement and
  very likely no easier to review.  Anyway: sorry NeilBrown...

- Despite the use of indirect function calls, caching these nfsd
  symbols for use by the client offers a ~10% performance win
  (compared to always doing get+call+put) for high IOPS workloads.

- Introduce nfsd_file_file() wrapper that provides access to
  nfsd_file's backing file.  Keeps nfsd_file structure opaque to NFS
  client (as suggested by Jeff Layton).

- The addition of nfsd_file_get, nfsd_file_put and nfsd_file_file
  symbols prepares for the NFS client to use nfsd_file for localio.

Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com> # nfs_to
Suggested-by: Jeff Layton <jlayton@kernel.org> # nfsd_file_file
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs_common/nfslocalio.c | 159 +++++++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.c        |  25 ++++++
 fs/nfsd/filecache.h        |   1 +
 fs/nfsd/nfssvc.c           |   5 ++
 include/linux/nfslocalio.h |  38 +++++++++
 5 files changed, 228 insertions(+)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 1a35a4a6dbe0..cc30fdb0cb46 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -72,3 +72,162 @@ bool nfs_uuid_is_local(const uuid_t *uuid, struct net *net, struct auth_domain *
 	return is_local;
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
+
+/*
+ * The nfs localio code needs to call into nfsd using various symbols (below),
+ * but cannot be statically linked, because that will make the nfs module
+ * depend on the nfsd module.
+ *
+ * Instead, do dynamic linking to the nfsd module (via nfs_common module). The
+ * nfs_common module will only hold a reference on nfsd when localio is in use.
+ * This allows some sanity checking, like giving up on localio if nfsd isn't loaded.
+ */
+static DEFINE_SPINLOCK(nfs_to_nfsd_lock);
+nfs_to_nfsd_t nfs_to;
+EXPORT_SYMBOL_GPL(nfs_to);
+
+/* Macro to define nfs_to get and put methods, avoids copy-n-paste bugs */
+#define DEFINE_NFS_TO_NFSD_SYMBOL(NFSD_SYMBOL)		\
+static nfs_to_##NFSD_SYMBOL##_t get_##NFSD_SYMBOL(void)	\
+{							\
+	return symbol_request(NFSD_SYMBOL);		\
+}							\
+static void put_##NFSD_SYMBOL(void)			\
+{							\
+	symbol_put(NFSD_SYMBOL);			\
+	nfs_to.NFSD_SYMBOL = NULL;			\
+}
+
+/* The nfs localio code needs to call into nfsd to map filehandle -> struct nfsd_file */
+extern struct nfs_localio_ctx *
+nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
+		   const struct cred *, const struct nfs_fh *, const fmode_t);
+DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_open_local_fh);
+
+/* The nfs localio code needs to call into nfsd to acquire the nfsd_file */
+extern struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
+DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_get);
+
+/* The nfs localio code needs to call into nfsd to release the nfsd_file */
+extern void nfsd_file_put(struct nfsd_file *nf);
+DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_put);
+
+/* The nfs localio code needs to call into nfsd to access the nf->nf_file */
+extern struct file * nfsd_file_file(struct nfsd_file *nf);
+DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_file);
+
+/* The nfs localio code needs to call into nfsd to release nn->nfsd_serv */
+extern void nfsd_serv_put(struct nfsd_net *nn);
+DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_serv_put);
+#undef DEFINE_NFS_TO_NFSD_SYMBOL
+
+static struct kmem_cache *nfs_localio_ctx_cache;
+
+struct nfs_localio_ctx *nfs_localio_ctx_alloc(void)
+{
+	return kmem_cache_alloc(nfs_localio_ctx_cache,
+				GFP_KERNEL | __GFP_ZERO);
+}
+EXPORT_SYMBOL_GPL(nfs_localio_ctx_alloc);
+
+void nfs_localio_ctx_free(struct nfs_localio_ctx *localio)
+{
+	if (localio->nf)
+		nfs_to.nfsd_file_put(localio->nf);
+	if (localio->nn)
+		nfs_to.nfsd_serv_put(localio->nn);
+	kmem_cache_free(nfs_localio_ctx_cache, localio);
+}
+EXPORT_SYMBOL_GPL(nfs_localio_ctx_free);
+
+bool get_nfs_to_nfsd_symbols(void)
+{
+	spin_lock(&nfs_to_nfsd_lock);
+
+	/* Only get symbols on first reference */
+	if (refcount_read(&nfs_to.ref) == 0)
+		refcount_set(&nfs_to.ref, 1);
+	else {
+		refcount_inc(&nfs_to.ref);
+		spin_unlock(&nfs_to_nfsd_lock);
+		return true;
+	}
+
+	nfs_to.nfsd_open_local_fh = get_nfsd_open_local_fh();
+	if (!nfs_to.nfsd_open_local_fh)
+		goto out_nfsd_open_local_fh;
+
+	nfs_to.nfsd_file_get = get_nfsd_file_get();
+	if (!nfs_to.nfsd_file_get)
+		goto out_nfsd_file_get;
+
+	nfs_to.nfsd_file_put = get_nfsd_file_put();
+	if (!nfs_to.nfsd_file_put)
+		goto out_nfsd_file_put;
+
+	nfs_to.nfsd_file_file = get_nfsd_file_file();
+	if (!nfs_to.nfsd_file_file)
+		goto out_nfsd_file_file;
+
+	nfs_to.nfsd_serv_put = get_nfsd_serv_put();
+	if (!nfs_to.nfsd_serv_put)
+		goto out_nfsd_serv_put;
+
+	spin_unlock(&nfs_to_nfsd_lock);
+	return true;
+
+out_nfsd_serv_put:
+	put_nfsd_file_file();
+out_nfsd_file_file:
+	put_nfsd_file_put();
+out_nfsd_file_put:
+	put_nfsd_file_get();
+out_nfsd_file_get:
+	put_nfsd_open_local_fh();
+out_nfsd_open_local_fh:
+	spin_unlock(&nfs_to_nfsd_lock);
+	return false;
+}
+EXPORT_SYMBOL_GPL(get_nfs_to_nfsd_symbols);
+
+void put_nfs_to_nfsd_symbols(void)
+{
+	spin_lock(&nfs_to_nfsd_lock);
+
+	if (!refcount_dec_and_test(&nfs_to.ref))
+		goto out;
+
+	put_nfsd_open_local_fh();
+	put_nfsd_file_get();
+	put_nfsd_file_put();
+	put_nfsd_file_file();
+	put_nfsd_serv_put();
+out:
+	spin_unlock(&nfs_to_nfsd_lock);
+}
+EXPORT_SYMBOL_GPL(put_nfs_to_nfsd_symbols);
+
+static int __init nfslocalio_init(void)
+{
+	refcount_set(&nfs_to.ref, 0);
+
+	nfs_to.nfsd_open_local_fh = NULL;
+	nfs_to.nfsd_file_get = NULL;
+	nfs_to.nfsd_file_put = NULL;
+	nfs_to.nfsd_file_file = NULL;
+	nfs_to.nfsd_serv_put = NULL;
+
+	nfs_localio_ctx_cache = KMEM_CACHE(nfs_localio_ctx, 0);
+	if (!nfs_localio_ctx_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void __exit nfslocalio_exit(void)
+{
+	kmem_cache_destroy(nfs_localio_ctx_cache);
+}
+
+module_init(nfslocalio_init);
+module_exit(nfslocalio_exit);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2dc72de31f61..a83d469bca6b 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -39,6 +39,7 @@
 #include <linux/fsnotify.h>
 #include <linux/seq_file.h>
 #include <linux/rhashtable.h>
+#include <linux/nfslocalio.h>
 
 #include "vfs.h"
 #include "nfsd.h"
@@ -345,6 +346,10 @@ nfsd_file_get(struct nfsd_file *nf)
 		return nf;
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(nfsd_file_get);
+
+/* Compile time type checking, not used by anything */
+static nfs_to_nfsd_file_get_t __maybe_unused nfsd_file_get_typecheck = nfsd_file_get;
 
 /**
  * nfsd_file_put - put the reference to a nfsd_file
@@ -389,6 +394,26 @@ nfsd_file_put(struct nfsd_file *nf)
 	if (refcount_dec_and_test(&nf->nf_ref))
 		nfsd_file_free(nf);
 }
+EXPORT_SYMBOL_GPL(nfsd_file_put);
+
+/* Compile time type checking, not used by anything */
+static nfs_to_nfsd_file_put_t __maybe_unused nfsd_file_put_typecheck = nfsd_file_put;
+
+/**
+ * nfsd_file_file - get the backing file of an nfsd_file
+ * @nf: nfsd_file of which to access the backing file.
+ *
+ * Return backing file for @nf.
+ */
+struct file *
+nfsd_file_file(struct nfsd_file *nf)
+{
+	return nf->nf_file;
+}
+EXPORT_SYMBOL_GPL(nfsd_file_file);
+
+/* Compile time type checking, not used by anything */
+static nfs_to_nfsd_file_file_t __maybe_unused nfsd_file_file_typecheck = nfsd_file_file;
 
 static void
 nfsd_file_dispose_list(struct list_head *dispose)
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 26ada78b8c1e..6fbbb2e32e95 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -56,6 +56,7 @@ int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
+struct file *nfsd_file_file(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
 void nfsd_file_net_dispose(struct nfsd_net *nn);
 bool nfsd_file_is_cached(struct inode *inode);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c639fbe4d8c2..13c69aa40d1c 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -19,6 +19,7 @@
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/lockd/bind.h>
 #include <linux/nfsacl.h>
+#include <linux/nfslocalio.h>
 #include <linux/seq_file.h>
 #include <linux/inetdevice.h>
 #include <net/addrconf.h>
@@ -201,6 +202,10 @@ void nfsd_serv_put(struct nfsd_net *nn)
 {
 	percpu_ref_put(&nn->nfsd_serv_ref);
 }
+EXPORT_SYMBOL_GPL(nfsd_serv_put);
+
+/* Compile time type checking, not used by anything */
+static nfs_to_nfsd_serv_put_t __maybe_unused nfsd_serv_put_typecheck = nfsd_serv_put;
 
 static void nfsd_serv_done(struct percpu_ref *ref)
 {
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 9735ae8d3e5e..68f5b39f1940 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -7,6 +7,8 @@
 
 #include <linux/list.h>
 #include <linux/uuid.h>
+#include <linux/refcount.h>
+#include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/nfs.h>
 #include <net/net_namespace.h>
@@ -28,4 +30,40 @@ void nfs_uuid_begin(nfs_uuid_t *);
 void nfs_uuid_end(nfs_uuid_t *);
 bool nfs_uuid_is_local(const uuid_t *, struct net *, struct auth_domain *);
 
+struct nfsd_file;
+struct nfsd_net;
+
+struct nfs_localio_ctx {
+	struct nfsd_file *nf;
+	struct nfsd_net *nn;
+};
+
+typedef struct nfs_localio_ctx *
+(*nfs_to_nfsd_open_local_fh_t)(struct net *, struct auth_domain *,
+			       struct rpc_clnt *, const struct cred *,
+			       const struct nfs_fh *, const fmode_t);
+typedef struct nfsd_file * (*nfs_to_nfsd_file_get_t)(struct nfsd_file *);
+typedef void (*nfs_to_nfsd_file_put_t)(struct nfsd_file *);
+typedef struct file * (*nfs_to_nfsd_file_file_t)(struct nfsd_file *);
+typedef unsigned int (*nfs_to_nfsd_net_id_value_t)(void);
+typedef void (*nfs_to_nfsd_serv_put_t)(struct nfsd_net *);
+
+typedef struct {
+	refcount_t			ref;
+	nfs_to_nfsd_open_local_fh_t	nfsd_open_local_fh;
+	nfs_to_nfsd_file_get_t		nfsd_file_get;
+	nfs_to_nfsd_file_put_t		nfsd_file_put;
+	nfs_to_nfsd_file_file_t		nfsd_file_file;
+	nfs_to_nfsd_net_id_value_t	nfsd_net_id_value;
+	nfs_to_nfsd_serv_put_t		nfsd_serv_put;
+} nfs_to_nfsd_t;
+
+extern nfs_to_nfsd_t nfs_to;
+
+bool get_nfs_to_nfsd_symbols(void);
+void put_nfs_to_nfsd_symbols(void);
+
+struct nfs_localio_ctx *nfs_localio_ctx_alloc(void);
+void nfs_localio_ctx_free(struct nfs_localio_ctx *);
+
 #endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


