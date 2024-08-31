Return-Path: <linux-fsdevel+bounces-28124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E99673B7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487381C21083
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5CD183CA7;
	Sat, 31 Aug 2024 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msYFArb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFAC183CA0;
	Sat, 31 Aug 2024 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143895; cv=none; b=jRdr5dZb6ybh7LWF9OCVPxBdzyThz7WJEWWHTlNq2ezOk6IM5tFljFGi3yPglLVDuo4ug/X4qpdyw4PUTYjWgJRtUJDnVY3ME3HeY+40QXZunYruJTKIaaBgcSNTocsufe84ziNwNMqNq6k6hqcYIFfKASk7G3jQ837IpRB/0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143895; c=relaxed/simple;
	bh=dBu+8U3baqWAFwfM7F/PRu5N8FJJR1ddicYx38oOSFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQf7lBbrWYn2WIWK//z4P35rp8DpQYraW0bViOJo727LhUZtdPRqd2A517ndoyTIjKCl3Z0L4tQjKgZDzY+ybV/rpB6iMMBqnM9CLyeHxUYYJZMETdhr+T47vfCjilotdUXSHk9+9Sj3dDLhmL4rgEcys31JmFFrOPHDIRukDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msYFArb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCA2C4CEC0;
	Sat, 31 Aug 2024 22:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143895;
	bh=dBu+8U3baqWAFwfM7F/PRu5N8FJJR1ddicYx38oOSFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msYFArb7ctp/FH/F1gNekNxFWC6HzCGjfdau/mEDesxAYqx29CMU4m3vPuBJc089P
	 17FAoIRHNyszPEXcKe7zGL2lA1GnJpxB2BESaSUQXNdPWr4oFpcsc8ZXTKYOTx4Fy+
	 ClN6UpignJJwXPgprSnnUw574GUKf6NDnX+KtgmPEf2gI9nEWoil2m92iLu1vr8RQ/
	 5BcSniLplE7eVb8A5j9zszwlCIdB3E9KrrdLLiI2WDnqME+1J3xDXO4Uj40bFwOrlc
	 bkWtYQGHhy2wX8imVvsS9/p2BHIC5cCpMXCNDSo8S5R3qC9FD2KIgvDQl7HrI7CHNJ
	 IRIVNYGBAdi8w==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 14/26] nfs_common: add NFS LOCALIO auxiliary protocol enablement
Date: Sat, 31 Aug 2024 18:37:34 -0400
Message-ID: <20240831223755.8569-15-snitzer@kernel.org>
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

fs/nfs_common/nfslocalio.c provides interfaces that enable an NFS
client to generate a nonce (single-use UUID) and associated
short-lived nfs_uuid_t struct, register it with nfs_common for
subsequent lookup and verification by the NFS server and if matched
the NFS server populates members in the nfs_uuid_t struct.

nfs_common's nfs_uuids list is the basis for localio enablement, as
such it has members that point to nfsd memory for direct use by the
client (e.g. 'net' is the server's network namespace, through it the
client can access nn->nfsd_serv).

This commit also provides the base nfs_uuid_t interfaces to allow
proper net namespace refcounting for the LOCALIO use case.

CONFIG_NFS_LOCALIO controls the nfs_common, NFS server and NFS client
enablement for LOCALIO. If both NFS_FS=m and NFSD=m then
NFS_COMMON_LOCALIO_SUPPORT=m and nfs_localio.ko is built (and provides
nfs_common's LOCALIO support).

  # lsmod | grep nfs_localio
  nfs_localio            12288  2 nfsd,nfs
  sunrpc                745472  35 nfs_localio,nfsd,auth_rpcgss,lockd,nfsv3,nfs

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Co-developed-by: NeilBrown <neilb@suse.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/Kconfig                 |  23 ++++++++
 fs/nfs_common/Makefile     |   3 +
 fs/nfs_common/nfslocalio.c | 116 +++++++++++++++++++++++++++++++++++++
 include/linux/nfslocalio.h |  36 ++++++++++++
 4 files changed, 178 insertions(+)
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 include/linux/nfslocalio.h

diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f..24d4e4b419d1 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -382,6 +382,29 @@ config NFS_COMMON
 	depends on NFSD || NFS_FS || LOCKD
 	default y
 
+config NFS_COMMON_LOCALIO_SUPPORT
+	tristate
+	default n
+	default y if NFSD=y || NFS_FS=y
+	default m if NFSD=m && NFS_FS=m
+	select SUNRPC
+
+config NFS_LOCALIO
+	bool "NFS client and server support for LOCALIO auxiliary protocol"
+	depends on NFSD && NFS_FS
+	select NFS_COMMON_LOCALIO_SUPPORT
+	default n
+	help
+	  Some NFS servers support an auxiliary NFS LOCALIO protocol
+	  that is not an official part of the NFS protocol.
+
+	  This option enables support for the LOCALIO protocol in the
+	  kernel's NFS server and client. Enable this to permit local
+	  NFS clients to bypass the network when issuing reads and
+	  writes to the local NFS server.
+
+	  If unsure, say N.
+
 config NFS_V4_2_SSC_HELPER
 	bool
 	default y if NFS_V4_2
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
index 000000000000..22b0ddf225ca
--- /dev/null
+++ b/fs/nfs_common/nfslocalio.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ * Copyright (C) 2024 NeilBrown <neilb@suse.de>
+ */
+
+#include <linux/module.h>
+#include <linux/rculist.h>
+#include <linux/nfslocalio.h>
+#include <net/netns/generic.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("NFS localio protocol bypass support");
+
+static DEFINE_SPINLOCK(nfs_uuid_lock);
+
+/*
+ * Global list of nfs_uuid_t instances
+ * that is protected by nfs_uuid_lock.
+ */
+LIST_HEAD(nfs_uuids);
+
+void nfs_uuid_begin(nfs_uuid_t *nfs_uuid)
+{
+	nfs_uuid->net = NULL;
+	nfs_uuid->dom = NULL;
+	uuid_gen(&nfs_uuid->uuid);
+
+	spin_lock(&nfs_uuid_lock);
+	list_add_tail_rcu(&nfs_uuid->list, &nfs_uuids);
+	spin_unlock(&nfs_uuid_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_begin);
+
+void nfs_uuid_end(nfs_uuid_t *nfs_uuid)
+{
+	if (nfs_uuid->net == NULL) {
+		spin_lock(&nfs_uuid_lock);
+		list_del_init(&nfs_uuid->list);
+		spin_unlock(&nfs_uuid_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_end);
+
+static nfs_uuid_t * nfs_uuid_lookup_locked(const uuid_t *uuid)
+{
+	nfs_uuid_t *nfs_uuid;
+
+	list_for_each_entry(nfs_uuid, &nfs_uuids, list)
+		if (uuid_equal(&nfs_uuid->uuid, uuid))
+			return nfs_uuid;
+
+	return NULL;
+}
+
+struct module *nfsd_mod;
+
+void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
+		       struct net *net, struct auth_domain *dom,
+		       struct module *mod)
+{
+	nfs_uuid_t *nfs_uuid;
+
+	spin_lock(&nfs_uuid_lock);
+	nfs_uuid = nfs_uuid_lookup_locked(uuid);
+	if (nfs_uuid) {
+		kref_get(&dom->ref);
+		nfs_uuid->dom = dom;
+		/*
+		 * We don't hold a ref on the net, but instead put
+		 * ourselves on a list so the net pointer can be
+		 * invalidated.
+		 */
+		list_move(&nfs_uuid->list, list);
+		nfs_uuid->net = net;
+
+		__module_get(mod);
+		nfsd_mod = mod;
+	}
+	spin_unlock(&nfs_uuid_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
+
+static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
+{
+	if (nfs_uuid->net) {
+		module_put(nfsd_mod);
+		nfs_uuid->net = NULL;
+	}
+	if (nfs_uuid->dom) {
+		auth_domain_put(nfs_uuid->dom);
+		nfs_uuid->dom = NULL;
+	}
+	list_del_init(&nfs_uuid->list);
+}
+
+void nfs_uuid_invalidate_clients(struct list_head *list)
+{
+	nfs_uuid_t *nfs_uuid, *tmp;
+
+	spin_lock(&nfs_uuid_lock);
+	list_for_each_entry_safe(nfs_uuid, tmp, list, list)
+		nfs_uuid_put_locked(nfs_uuid);
+	spin_unlock(&nfs_uuid_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_clients);
+
+void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
+{
+	if (nfs_uuid->net) {
+		spin_lock(&nfs_uuid_lock);
+		nfs_uuid_put_locked(nfs_uuid);
+		spin_unlock(&nfs_uuid_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
new file mode 100644
index 000000000000..4165ff8390c1
--- /dev/null
+++ b/include/linux/nfslocalio.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ * Copyright (C) 2024 NeilBrown <neilb@suse.de>
+ */
+#ifndef __LINUX_NFSLOCALIO_H
+#define __LINUX_NFSLOCALIO_H
+
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/uuid.h>
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
+void nfs_uuid_is_local(const uuid_t *, struct list_head *,
+		       struct net *, struct auth_domain *, struct module *);
+void nfs_uuid_invalidate_clients(struct list_head *list);
+void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
+
+#endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


