Return-Path: <linux-fsdevel+bounces-26968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DDA95D503
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326771F232F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAD5193072;
	Fri, 23 Aug 2024 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tScCBhUq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAB91922C5;
	Fri, 23 Aug 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436877; cv=none; b=Ly8f5gGbj0vWKnyVvvyxCmcxPw0wP+LQtFp2fKsGauybdFhJ1TZsuMVecK1qkb9LIntxROvCJnHRqWPg69MoE9S/ECB/jE+yebaZl6gaN5Z8CpH6EoNdSXXUQCS5ru0jXpqnF8Jssp8kyWmO4x+ldsaMAME8Zr+AFmbZnh5GhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436877; c=relaxed/simple;
	bh=y1KHKQbQryRN3+h8INqz7R8ZCyxyn23vrNoIBxYeFfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGVlVpn65zF6IuKt7CpCFvlAkzruxP9TVyK1eN7MI1OJMIYGvxLw6r0TWRvETU66lr4Q/1c7b1ORwFmvaV21I+XfgJfQAw0nDE6iqlnlLj9kpeHZEewfArmMbbWqI5kzUw6a3I+A9Eum5LlLUiMVBdmgcEug9obQju3BQxDlMNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tScCBhUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A23CC4AF13;
	Fri, 23 Aug 2024 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724436877;
	bh=y1KHKQbQryRN3+h8INqz7R8ZCyxyn23vrNoIBxYeFfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tScCBhUqYSih3DpfIAakeCnRc51/gAHv6/Alv8Scjk+tON4Der2VLpqoEmvK0kFGG
	 WlVCfBt/ketpqZ4K/l7Yja0L0guq/PkCqcb9FaPOn8+1aA/YqFC8j8qhmCbQTQvEjq
	 gR0tUKEM6rg0FySG0f3XdjZ+O1Fdcf4zFqgG8m2/tEI2AptuBwPCBndL+02y066+J/
	 0jIVOHI4gOkWkITa2VQJzoefHYrz8lhMuBQzj6nslORrTGndunS4P8eKE19cD5onSO
	 UTx6pJD9NHMIDqhgf9gf5SQeEsw/pyflUO+RIuoaCrtzWiw1katG+FCjsiVFfevNJe
	 lKyz2cU24123w==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 09/19] nfs_common: add NFS LOCALIO auxiliary protocol enablement
Date: Fri, 23 Aug 2024 14:14:07 -0400
Message-ID: <20240823181423.20458-10-snitzer@kernel.org>
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

fs/nfs_common/nfslocalio.c provides interfaces that enable an NFS
client to generate a nonce (single-use UUID) and associated
short-lived nfs_uuid_t struct, register it with nfs_common for
subsequent lookup and verification by the NFS server and if matched
the NFS server populates members in the nfs_uuid_t struct.

nfs_common's nfs_uuids list is the basis for localio enablement, as
such it has members that point to nfsd memory for direct use by the
client (e.g. 'net' is the server's network namespace, through it the
client can access nn->nfsd_serv with proper rcu read access).

Also, expose localio's required nfsd symbols to NFS client:
- Cache nfsd_open_local_fh symbol (defined in next commit) and other
  required nfsd symbols in a globally accessible 'nfs_to'
  nfs_to_nfsd_t struct.

- Introduce nfsd_file_file() wrapper that provides access to
  nfsd_file's backing file.  Keeps nfsd_file structure opaque to NFS
  client (as suggested by Jeff Layton).

- The addition of nfsd_file_get, nfsd_file_put and nfsd_file_file
  symbols prepares for the NFS client to use nfsd_file for localio.

- Despite the use of indirect function calls, caching these nfsd
  symbols for use by the client offers a ~10% performance win
  (compared to always doing get+call+put) for high IOPS workloads.

Suggested-by: Jeff Layton <jlayton@kernel.org> # nfsd_file_file
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs_common/Makefile     |   3 +
 fs/nfs_common/nfslocalio.c | 194 +++++++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.c        |  25 +++++
 fs/nfsd/filecache.h        |   1 +
 include/linux/nfslocalio.h |  56 +++++++++++
 5 files changed, 279 insertions(+)
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 include/linux/nfslocalio.h

diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
index e58b01bb8dda..a5e54809701e 100644
--- a/fs/nfs_common/Makefile
+++ b/fs/nfs_common/Makefile
@@ -6,6 +6,9 @@
 obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
 nfs_acl-objs := nfsacl.o
 
+obj-$(CONFIG_NFS_COMMON_LOCALIO_SUPPORT) += nfs_localio.o
+nfs_localio-objs := nfslocalio.o
+
 obj-$(CONFIG_GRACE_PERIOD) += grace.o
 obj-$(CONFIG_NFS_V4_2_SSC_HELPER) += nfs_ssc.o
 
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
new file mode 100644
index 000000000000..f59167e596d3
--- /dev/null
+++ b/fs/nfs_common/nfslocalio.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+
+#include <linux/module.h>
+#include <linux/rculist.h>
+#include <linux/nfslocalio.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("NFS localio protocol bypass support");
+
+DEFINE_MUTEX(nfs_uuid_mutex);
+
+/*
+ * Global list of nfs_uuid_t instances, add/remove
+ * is protected by nfs_uuid_mutex.
+ * Reads are protected by RCU read lock (see below).
+ */
+LIST_HEAD(nfs_uuids);
+
+void nfs_uuid_begin(nfs_uuid_t *nfs_uuid)
+{
+	nfs_uuid->net = NULL;
+	nfs_uuid->dom = NULL;
+	uuid_gen(&nfs_uuid->uuid);
+
+	mutex_lock(&nfs_uuid_mutex);
+	list_add_tail_rcu(&nfs_uuid->list, &nfs_uuids);
+	mutex_unlock(&nfs_uuid_mutex);
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_begin);
+
+void nfs_uuid_end(nfs_uuid_t *nfs_uuid)
+{
+	mutex_lock(&nfs_uuid_mutex);
+	list_del_rcu(&nfs_uuid->list);
+	mutex_unlock(&nfs_uuid_mutex);
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_end);
+
+/* Must be called with RCU read lock held. */
+static nfs_uuid_t * nfs_uuid_lookup(const uuid_t *uuid)
+{
+	nfs_uuid_t *nfs_uuid;
+
+	list_for_each_entry_rcu(nfs_uuid, &nfs_uuids, list)
+		if (uuid_equal(&nfs_uuid->uuid, uuid))
+			return nfs_uuid;
+
+	return NULL;
+}
+
+bool nfs_uuid_is_local(const uuid_t *uuid, struct net *net, struct auth_domain *dom)
+{
+	bool is_local = false;
+	nfs_uuid_t *nfs_uuid;
+
+	rcu_read_lock();
+	nfs_uuid = nfs_uuid_lookup(uuid);
+	if (nfs_uuid) {
+		is_local = true;
+		nfs_uuid->net = net;
+		kref_get(&dom->ref);
+		nfs_uuid->dom = dom;
+	}
+	rcu_read_unlock();
+
+	return is_local;
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
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
+DEFINE_MUTEX(nfs_to_nfsd_mutex);
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
+extern int nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
+			      const struct cred *, const struct nfs_fh *,
+			      const fmode_t, struct nfsd_file **);
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
+#undef DEFINE_NFS_TO_NFSD_SYMBOL
+
+bool get_nfs_to_nfsd_symbols(void)
+{
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
+}
+EXPORT_SYMBOL_GPL(get_nfs_to_nfsd_symbols);
+
+void put_nfs_to_nfsd_symbols(void)
+{
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
+}
+
+static void __exit nfslocalio_exit(void)
+{
+}
+
+module_init(nfslocalio_init);
+module_exit(nfslocalio_exit);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 94ecb9ed0ed1..2a79c45ca27a 100644
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
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
new file mode 100644
index 000000000000..7e09ff621d93
--- /dev/null
+++ b/include/linux/nfslocalio.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+#ifndef __LINUX_NFSLOCALIO_H
+#define __LINUX_NFSLOCALIO_H
+
+#include <linux/list.h>
+#include <linux/uuid.h>
+#include <linux/refcount.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/svcauth.h>
+#include <linux/nfs.h>
+#include <net/net_namespace.h>
+
+/*
+ * Useful to allow a client to negotiate if localio
+ * possible with its server.
+ *
+ * See Documentation/filesystems/nfs/localio.rst for more detail.
+ */
+typedef struct {
+	uuid_t uuid;
+	struct list_head list;
+	struct net *net; /* nfsd's network namespace */
+	struct auth_domain *dom; /* auth_domain for localio */
+} nfs_uuid_t;
+
+void nfs_uuid_begin(nfs_uuid_t *);
+void nfs_uuid_end(nfs_uuid_t *);
+bool nfs_uuid_is_local(const uuid_t *, struct net *, struct auth_domain *);
+
+struct nfsd_file;
+
+typedef int (*nfs_to_nfsd_open_local_fh_t)(struct net *, struct auth_domain *,
+				struct rpc_clnt *, const struct cred *,
+				const struct nfs_fh *, const fmode_t,
+				struct nfsd_file **);
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
+
+#endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


