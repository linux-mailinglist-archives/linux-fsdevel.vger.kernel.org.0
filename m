Return-Path: <linux-fsdevel+bounces-26295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EDC9572DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139C11C22E8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78818189F42;
	Mon, 19 Aug 2024 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjzBduyC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DE2189F33;
	Mon, 19 Aug 2024 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091484; cv=none; b=SMRQvqEsPNP0rWAQfpDb2SDu8Ggs/09eQzLFKxFYS8ATeZjsauL5WvtIV94l+wRpHINXSng88P+9bGlkKRNoitsVWe1C3H5MPrvy9Ayl22A/uliNkdbQ/EhKf0PC1dnHgcTI1fZLRfWljzIIxAeio/oOmd+oP0KEN+Jz7iUBpFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091484; c=relaxed/simple;
	bh=PNkd3vaN135BkXm9X90tBGpk2HmP8V5YpvH4nnGEmm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIruOQEru1OhTT6HWHDs94XGKVd4qYqebzcla1DWHSLCZPavYaG5zJ/Amy8YVf5bW6XbrbRfy7tc+GrVsRShuG/79wTkIieHXixFX/Iei++EsEn7u86GECxXxtH+UXDhtVM5T0yjEgcnoBtUmHifprGEVi86Lwyvcv3IbrX8nE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjzBduyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302C1C4AF11;
	Mon, 19 Aug 2024 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091484;
	bh=PNkd3vaN135BkXm9X90tBGpk2HmP8V5YpvH4nnGEmm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TjzBduyCdrTRJwlqHCvhJqWCjEBYUYG/4HRZTVLnjkGxlwi/PnXwH0EZ3cPDYavAQ
	 VmGpH062xrwzxdrg9fFgg/OzNxx2zBBg36m44vaKBaL07S+wmq6KNgNMXg1zmzDu5w
	 AJ2V0wFQE53bwec61mXGSI8xODBcH7FySD7hdaG4m8Mokm5IoOnKFVSDUeMDY/jTRr
	 XVE1jQrQz5/oJ7+Ie6zX3VOoQblc1F9qL2d2IVE44ZxD5FKdWwHzVGqXA5hGwfmbO3
	 Zw8cUSY3QT3dX5Kz1Z126lMpUs+dQfh3eWudRgl740WOP8fErYEb3nA4gExymx+Uid
	 PMbiGVKFBxRYw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 09/24] nfs_common: add NFS LOCALIO auxiliary protocol enablement
Date: Mon, 19 Aug 2024 14:17:14 -0400
Message-ID: <20240819181750.70570-10-snitzer@kernel.org>
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

fs/nfs_common/nfslocalio.c provides interfaces that enable an NFS client
to generate a nonce (single-use UUID) and associated short-lived
nfs_uuid_t struct, register it with nfs_common for subsequent lookup and
verification by the NFS server and if matched the NFS server populates
members in the nfs_uuid_t struct.

nfs_common's nfs_uuids list is the basis for localio enablement, as such
it has members that point to nfsd memory for direct use by the client
(e.g. 'net' is the server's network namespace, through it the client can
access nn->nfsd_serv with proper rcu read access).

This commit adds all the nfs_client members required to implement
the entire localio feature (which depends on the LOCALIO protocol).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/client.c            |  9 ++++
 fs/nfs_common/Makefile     |  3 ++
 fs/nfs_common/nfslocalio.c | 97 ++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_fs_sb.h  | 10 ++++
 include/linux/nfslocalio.h | 37 +++++++++++++++
 5 files changed, 156 insertions(+)
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 include/linux/nfslocalio.h

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 8286edd6062d..1b65a5d7af49 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -178,6 +178,15 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
 	clp->cl_net = get_net(cl_init->net);
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	seqlock_init(&clp->cl_boot_lock);
+	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
+	clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
+	clp->nfsd_open_local_fh = NULL;
+	clp->cl_nfssvc_net = NULL;
+	clp->cl_nfssvc_dom = NULL;
+#endif /* CONFIG_NFS_LOCALIO */
+
 	clp->cl_principal = "*";
 	clp->cl_xprtsec = cl_init->xprtsec;
 	return clp;
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
index 000000000000..a20ff7607707
--- /dev/null
+++ b/fs/nfs_common/nfslocalio.c
@@ -0,0 +1,97 @@
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
+ * The nfs localio code needs to call into nfsd to do the filehandle -> struct path
+ * mapping, but cannot be statically linked, because that will make the nfs module
+ * depend on the nfsd module.
+ *
+ * Instead, do dynamic linking to the nfsd module (via nfs_common module). The
+ * nfs_common module will only hold a reference on nfsd when localio is in use.
+ * This allows some sanity checking, like giving up on localio if nfsd isn't loaded.
+ */
+
+extern int nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
+			const struct cred *, const struct nfs_fh *,
+			const fmode_t, struct file **);
+
+nfs_to_nfsd_open_t get_nfsd_open_local_fh(void)
+{
+	return symbol_request(nfsd_open_local_fh);
+}
+EXPORT_SYMBOL_GPL(get_nfsd_open_local_fh);
+
+void put_nfsd_open_local_fh(void)
+{
+	symbol_put(nfsd_open_local_fh);
+}
+EXPORT_SYMBOL_GPL(put_nfsd_open_local_fh);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 1df86ab98c77..3849cc2832f0 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -8,6 +8,7 @@
 #include <linux/wait.h>
 #include <linux/nfs_xdr.h>
 #include <linux/sunrpc/xprt.h>
+#include <linux/nfslocalio.h>
 
 #include <linux/atomic.h>
 #include <linux/refcount.h>
@@ -125,6 +126,15 @@ struct nfs_client {
 	struct net		*cl_net;
 	struct list_head	pending_cb_stateids;
 	struct rcu_head		rcu;
+
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	struct timespec64	cl_nfssvc_boot;
+	seqlock_t		cl_boot_lock;
+	struct rpc_clnt *	cl_rpcclient_localio;
+	struct net *	        cl_nfssvc_net;
+	struct auth_domain *	cl_nfssvc_dom;
+	nfs_to_nfsd_open_t	nfsd_open_local_fh;
+#endif /* CONFIG_NFS_LOCALIO */
 };
 
 /*
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
new file mode 100644
index 000000000000..109cb8534e3f
--- /dev/null
+++ b/include/linux/nfslocalio.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+#ifndef __LINUX_NFSLOCALIO_H
+#define __LINUX_NFSLOCALIO_H
+
+#include <linux/list.h>
+#include <linux/uuid.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/svcauth.h>
+#include <linux/nfs.h>
+#include <net/net_namespace.h>
+
+/*
+ * Useful to allow a client to negotiate if localio
+ * possible with its server.
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
+typedef int (*nfs_to_nfsd_open_t)(struct net *, struct auth_domain *, struct rpc_clnt *,
+				const struct cred *, const struct nfs_fh *,
+				const fmode_t, struct file **);
+
+nfs_to_nfsd_open_t get_nfsd_open_local_fh(void);
+void put_nfsd_open_local_fh(void);
+
+#endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


