Return-Path: <linux-fsdevel+bounces-26307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E759572F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D541F223E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FCA18A934;
	Mon, 19 Aug 2024 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIWQP9MW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35AC189B99;
	Mon, 19 Aug 2024 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091500; cv=none; b=aLL2NZLsT5x3ieVp1zP33fokfqx6SnxSobCsomIjVkwZxfQuZ6MSLxhk/tnN7MZAHeGNwzucpEEPHJaayuwj5xhGI6zWhpSzDxOlInHPpS0eH+44C9bxDrDh2GMumsfHG/h0Mk0ma2xjwsAZsU1xhMj/jHZYS7lqTi9EvFgXiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091500; c=relaxed/simple;
	bh=aFPdln082tJMXxadR13hHMY+SiAhF/nnmGGNZcmP2h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zn+t7r/zaBaZoWsguIxyJBY3GGxKcW5xgFrpJGFIId41+p0AqdHYOul+MRy5olO3tylqLIqnez6YbklY+2QYb5BbygXYJ1t01sQv54wUtV5DtAv4oNTWzIxAZtd7Oi8Z22nUn440PZ8WTCQQY0qeRyvC8TkRq7hjyLic9gftyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIWQP9MW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70689C4AF0F;
	Mon, 19 Aug 2024 18:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091500;
	bh=aFPdln082tJMXxadR13hHMY+SiAhF/nnmGGNZcmP2h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GIWQP9MWtiwxX1RCJT0EpAXPjMlI35BFEvCdQ72TyMlDtmDqLBV/WPSmaanq8wTTY
	 hmYNBr646esWWDRNv9E8ujqjMbFVP1Z9tcQpk6rWvf+dvVgTz5Kga6CmqUQ7mmpbj3
	 Fud0VCW/2R2S254UcADTsRoUNxLZL9cqYUTpFYgUBzySn/6U+HsDATW6KtvoxA96/8
	 KirkB8GGqNawHsZL7Q2ss/LLnSApsj6qIPmpNWXcnKXyVARDgDYWk5qop/SYEvhLCo
	 ea2GKpeh6DkV1kFRnQln3dihK7XMgb+g28YsfagSEth4ZAO0Zt2Ij7JCtezeOjrf+M
	 uRaF2j6BMhLYg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 21/24] nfs_common: expose localio's required nfsd symbols to nfs client
Date: Mon, 19 Aug 2024 14:17:26 -0400
Message-ID: <20240819181750.70570-22-snitzer@kernel.org>
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

From: Mike Snitzer <snitzer@hammerspace.com>

Switch the caching of nfsd_open_local_fh symbol from being within each
nfs_client struct to being globally maintained within nfs_common
(accessible via the global 'nfs_to' nfs_to_nfsd_t struct).

Introduce nfsd_file_file() wrapper that provides access to nfsd_file's
backing file.  Keeps nfsd_file structure opaque to NFS client (as
suggested by Jeff Layton).

The addition of nfsd_file_get, nfsd_file_put and nfsd_file_file
symbols prepares for switching the NFS client to using nfsd_file for
localio.

Despite the use of indirect function calls, caching these nfsd symbols
for use by the client offers a ~10% performance win (compared to
always doing get+call+put) for high IOPS workloads.

Suggested-by: Jeff Layton <jlayton@kernel.org> # nfsd_file_file
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/client.c            |   1 -
 fs/nfs/localio.c           |  17 +++---
 fs/nfs_common/nfslocalio.c | 117 +++++++++++++++++++++++++++++++++----
 fs/nfsd/filecache.c        |  25 ++++++++
 fs/nfsd/filecache.h        |   1 +
 fs/nfsd/localio.c          |   2 +-
 include/linux/nfs_fs_sb.h  |   1 -
 include/linux/nfslocalio.h |  27 +++++++--
 8 files changed, 163 insertions(+), 28 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 23fe1611cc9f..fe60a82f06d8 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -182,7 +182,6 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	seqlock_init(&clp->cl_boot_lock);
 	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
 	clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
-	clp->nfsd_open_local_fh = NULL;
 	clp->cl_nfssvc_net = NULL;
 	clp->cl_nfssvc_dom = NULL;
 #endif /* CONFIG_NFS_LOCALIO */
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index f5ecbd9fefb6..38303427e0b3 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -121,7 +121,7 @@ const struct rpc_program nfslocalio_program = {
  */
 static void nfs_local_enable(struct nfs_client *clp, nfs_uuid_t *nfs_uuid)
 {
-	if (READ_ONCE(clp->nfsd_open_local_fh)) {
+	if (!IS_ERR(clp->cl_rpcclient_localio)) {
 		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
 		clp->cl_nfssvc_net = nfs_uuid->net;
 		clp->cl_nfssvc_dom = nfs_uuid->dom;
@@ -136,8 +136,7 @@ void nfs_local_disable(struct nfs_client *clp)
 {
 	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
 		trace_nfs_local_disable(clp);
-		put_nfsd_open_local_fh();
-		clp->nfsd_open_local_fh = NULL;
+		put_nfs_to_nfsd_symbols();
 		if (!IS_ERR(clp->cl_rpcclient_localio)) {
 			rpc_shutdown_client(clp->cl_rpcclient_localio);
 			clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
@@ -162,16 +161,14 @@ static void nfs_init_localioclient(struct nfs_client *clp)
 	if (IS_ERR(clp->cl_rpcclient_localio))
 		goto out;
 	/* No errors! Assume that localio is supported */
-	clp->nfsd_open_local_fh = get_nfsd_open_local_fh();
-	if (!clp->nfsd_open_local_fh) {
+	if (!get_nfs_to_nfsd_symbols()) {
 		rpc_shutdown_client(clp->cl_rpcclient_localio);
 		clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
 	}
 out:
-	dprintk_rcu("%s: server (%s) %s NFS LOCALIO, nfsd_open_local_fh is %s.\n",
+	dprintk_rcu("%s: server (%s) %s NFS LOCALIO.\n",
 		__func__, rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR),
-		(IS_ERR(clp->cl_rpcclient_localio) ? "does not support" : "supports"),
-		(clp->nfsd_open_local_fh ? "set" : "not set"));
+		(IS_ERR(clp->cl_rpcclient_localio) ? "does not support" : "supports"));
 }
 
 static bool nfs_server_uuid_is_local(struct nfs_client *clp, nfs_uuid_t *nfs_uuid)
@@ -245,8 +242,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 	if (mode & ~(FMODE_READ | FMODE_WRITE))
 		return ERR_PTR(-EINVAL);
 
-	status = clp->nfsd_open_local_fh(clp->cl_nfssvc_net, clp->cl_nfssvc_dom,
-					 clp->cl_rpcclient, cred, fh, mode, &filp);
+	status = nfs_to.nfsd_open_local_fh(clp->cl_nfssvc_net, clp->cl_nfssvc_dom,
+					   clp->cl_rpcclient, cred, fh, mode, &filp);
 	if (status < 0) {
 		trace_nfs_local_open_fh(fh, mode, status);
 		switch (status) {
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index a20ff7607707..087649911b52 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -71,27 +71,124 @@ bool nfs_uuid_is_local(const uuid_t *uuid, struct net *net, struct auth_domain *
 EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
 
 /*
- * The nfs localio code needs to call into nfsd to do the filehandle -> struct path
- * mapping, but cannot be statically linked, because that will make the nfs module
+ * The nfs localio code needs to call into nfsd using various symbols (below),
+ * but cannot be statically linked, because that will make the nfs module
  * depend on the nfsd module.
  *
  * Instead, do dynamic linking to the nfsd module (via nfs_common module). The
  * nfs_common module will only hold a reference on nfsd when localio is in use.
  * This allows some sanity checking, like giving up on localio if nfsd isn't loaded.
  */
+DEFINE_MUTEX(nfs_to_nfsd_mutex);
+nfs_to_nfsd_t nfs_to;
+EXPORT_SYMBOL_GPL(nfs_to);
 
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
 extern int nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
-			const struct cred *, const struct nfs_fh *,
-			const fmode_t, struct file **);
+			      const struct cred *, const struct nfs_fh *,
+			      const fmode_t, struct file **);
+DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_open_local_fh);
 
-nfs_to_nfsd_open_t get_nfsd_open_local_fh(void)
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
+#undef DEFINE_NFS_TO_NFSD_SYMBOL
+
+bool get_nfs_to_nfsd_symbols(void)
 {
-	return symbol_request(nfsd_open_local_fh);
+	mutex_lock(&nfs_to_nfsd_mutex);
+
+	/* Only get symbols on first reference */
+	if (refcount_read(&nfs_to.ref) == 0)
+		refcount_set(&nfs_to.ref, 1);
+	else {
+		refcount_inc(&nfs_to.ref);
+		mutex_unlock(&nfs_to_nfsd_mutex);
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
+	mutex_unlock(&nfs_to_nfsd_mutex);
+	return true;
+
+out_nfsd_file_file:
+	put_nfsd_file_put();
+out_nfsd_file_put:
+	put_nfsd_file_get();
+out_nfsd_file_get:
+	put_nfsd_open_local_fh();
+out_nfsd_open_local_fh:
+	mutex_unlock(&nfs_to_nfsd_mutex);
+	return false;
 }
-EXPORT_SYMBOL_GPL(get_nfsd_open_local_fh);
+EXPORT_SYMBOL_GPL(get_nfs_to_nfsd_symbols);
 
-void put_nfsd_open_local_fh(void)
+void put_nfs_to_nfsd_symbols(void)
 {
-	symbol_put(nfsd_open_local_fh);
+	mutex_lock(&nfs_to_nfsd_mutex);
+
+	if (!refcount_dec_and_test(&nfs_to.ref))
+		goto out;
+
+	put_nfsd_open_local_fh();
+	put_nfsd_file_get();
+	put_nfsd_file_put();
+	put_nfsd_file_file();
+out:
+	mutex_unlock(&nfs_to_nfsd_mutex);
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
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(put_nfsd_open_local_fh);
+
+static void __exit nfslocalio_exit(void)
+{
+}
+
+module_init(nfslocalio_init);
+module_exit(nfslocalio_exit);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 447faa194166..d7c6122231f4 100644
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
index 6dab41f8541e..ab8a4423edd9 100644
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
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 9cdea1d1c28a..008b935a3a6c 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -111,7 +111,7 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
 EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
 
 /* Compile time type checking, not used by anything */
-static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
+static nfs_to_nfsd_open_local_fh_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
 
 /*
  * UUID_IS_LOCAL XDR functions
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 5edc57657985..10453c6f8ca8 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -134,7 +134,6 @@ struct nfs_client {
 	struct rpc_clnt *	cl_rpcclient_localio;
 	struct net *	        cl_nfssvc_net;
 	struct auth_domain *	cl_nfssvc_dom;
-	nfs_to_nfsd_open_t	nfsd_open_local_fh;
 #endif /* CONFIG_NFS_LOCALIO */
 };
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index c6edcb7c0dcd..6302d36f9112 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -7,6 +7,7 @@
 
 #include <linux/list.h>
 #include <linux/uuid.h>
+#include <linux/refcount.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/nfs.h>
@@ -29,11 +30,27 @@ void nfs_uuid_begin(nfs_uuid_t *);
 void nfs_uuid_end(nfs_uuid_t *);
 bool nfs_uuid_is_local(const uuid_t *, struct net *, struct auth_domain *);
 
-typedef int (*nfs_to_nfsd_open_t)(struct net *, struct auth_domain *, struct rpc_clnt *,
-				const struct cred *, const struct nfs_fh *,
-				const fmode_t, struct file **);
+struct nfsd_file;
 
-nfs_to_nfsd_open_t get_nfsd_open_local_fh(void);
-void put_nfsd_open_local_fh(void);
+typedef int (*nfs_to_nfsd_open_local_fh_t)(struct net *, struct auth_domain *,
+				struct rpc_clnt *, const struct cred *,
+				const struct nfs_fh *, const fmode_t,
+				struct file **);
+typedef struct nfsd_file * (*nfs_to_nfsd_file_get_t)(struct nfsd_file *);
+typedef void (*nfs_to_nfsd_file_put_t)(struct nfsd_file *);
+typedef struct file * (*nfs_to_nfsd_file_file_t)(struct nfsd_file *);
+
+typedef struct {
+	refcount_t			ref;
+	nfs_to_nfsd_open_local_fh_t	nfsd_open_local_fh;
+	nfs_to_nfsd_file_get_t		nfsd_file_get;
+	nfs_to_nfsd_file_put_t		nfsd_file_put;
+	nfs_to_nfsd_file_file_t		nfsd_file_file;
+} nfs_to_nfsd_t;
+
+extern nfs_to_nfsd_t nfs_to;
+
+bool get_nfs_to_nfsd_symbols(void);
+void put_nfs_to_nfsd_symbols(void);
 
 #endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


