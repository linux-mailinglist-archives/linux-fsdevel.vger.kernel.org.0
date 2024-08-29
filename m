Return-Path: <linux-fsdevel+bounces-27729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C38696376F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CA42841DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B34B14A4EB;
	Thu, 29 Aug 2024 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9gpOBu4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26DC1494AF;
	Thu, 29 Aug 2024 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893487; cv=none; b=fWBxL40hotXvCQWgWTt6qUyHhIo/NavAkKW++H0zimyp3OV8fkZ3MdwqKOZ0b4Rw3D+HVBW+U91Mi7uB/rfmLsSt8h8qu4Zurim9x0AcE7NknjlJaJJM0uv4hgvWVN9QWvLmqlrU2XelFKug0wKLTrvwbCTLjs5KvqjN/oUuV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893487; c=relaxed/simple;
	bh=ENsCOxk0HB8LVPeA/W8v9vMQPRHf5Tc5UmuLZBOj1NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sucMBjXUQF8kwTBfVlkXLAcYZ1tzc7LMD41oTu8q0RsxyRbgDgtu4q5uOHhyHU9aGV3wf9j1jh0l9AGeX0Lx+I5EhrxttGZ8kkqaM6OVo9QU1CH17hDkz5Kd7c4m15Vbo6mUYz86vyJdw9rhhSB4aqARoK/b3batyeDfpHasi60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9gpOBu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4BFC4CEC4;
	Thu, 29 Aug 2024 01:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893487;
	bh=ENsCOxk0HB8LVPeA/W8v9vMQPRHf5Tc5UmuLZBOj1NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h9gpOBu4w5JFGPuWhlfKBiS8H/IDRE7CfTBbYsnlpQJfyCbf/Q+oLnGv/CuI4Nun1
	 Go3d0iFb2+fI4H55AN5U9lcoVeBo3t6motbKcNP5HPydIP6RD4hzKytAT7oOUl+ky6
	 EYZ1LqdQNeJz90d2w3u5vij8RJ1+Gjd8U74SseWMjfWW0NfzzQ3HT/hVU3BB+WEmnN
	 GV0K4U2I2sWViU5cWU6l3jmKPio1KgfByz81XlYSC58fgdhGH6ALrF8wLZRuLjnAue
	 CG5FaBvFOQ6ZbQZNM0S7MSU/29xQfqobzrTFhgosndIcwWQ+v1kgs1E/H0Iecvj8uA
	 /oj7sB0oBHPIQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 16/25] nfsd: add localio support
Date: Wed, 28 Aug 2024 21:04:11 -0400
Message-ID: <20240829010424.83693-17-snitzer@kernel.org>
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

This commit also introduces the use of nfsd's percpu_ref to interlock
nfsd_destroy_serv and nfsd_open_local_fh, to ensure nn->nfsd_serv is
not destroyed while in use by nfsd_open_local_fh, and warrants a more
detailed explanation:

nfsd_open_local_fh uses nfsd_serv_try_get before opening its file
handle and then the reference must be dropped by the caller using
nfsd_serv_put (via nfs_localio_ctx_free).

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
 fs/nfsd/Kconfig     |  16 +++++++
 fs/nfsd/Makefile    |   1 +
 fs/nfsd/filecache.c |   2 +-
 fs/nfsd/localio.c   | 105 ++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/trace.h     |   3 +-
 fs/nfsd/vfs.h       |   7 +++
 7 files changed, 135 insertions(+), 2 deletions(-)
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
index c0bd1509ccd4..e6fa7eaa1db0 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -90,6 +90,22 @@ config NFSD_V4
 
 	  If unsure, say N.
 
+config NFSD_LOCALIO
+	bool "NFS server support for the LOCALIO auxiliary protocol"
+	depends on NFSD
+	select NFS_COMMON_LOCALIO_SUPPORT
+	default n
+	help
+	  Some NFS servers support an auxiliary NFS LOCALIO protocol
+	  that is not an official part of the NFS protocol.
+
+	  This option enables support for the LOCALIO protocol in the
+	  kernel's NFS server.  Enable this to permit local NFS clients
+	  to bypass the network when issuing reads and writes to the
+	  local NFS server.
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
index a83d469bca6b..49f4aab3208a 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -53,7 +53,7 @@
 #define NFSD_FILE_CACHE_UP		     (0)
 
 /* We only care about NFSD_MAY_READ/WRITE for this cache */
-#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
+#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
 
 static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
new file mode 100644
index 000000000000..4b65c66be129
--- /dev/null
+++ b/fs/nfsd/localio.c
@@ -0,0 +1,105 @@
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
+/**
+ * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to nfsd_file
+ *
+ * @cl_nfssvc_net: the 'struct net' to use to get the proper nfsd_net
+ * @cl_nfssvc_dom: the 'struct auth_domain' required for localio access
+ * @rpc_clnt: rpc_clnt that the client established, used for sockaddr and cred
+ * @cred: cred that the client established
+ * @nfs_fh: filehandle to lookup
+ * @fmode: fmode_t to use for open
+ *
+ * This function maps a local fh to a path on a local filesystem.
+ * This is useful when the nfs client has the local server mounted - it can
+ * avoid all the NFS overhead with reads, writes and commits.
+ *
+ * On successful return, returned nfs_localio_ctx will have its nfsd_file and
+ * nfsd_net members set. Caller is responsible for calling nfsd_file_put and
+ * nfsd_serv_put (via nfs_localio_ctx_free).
+ */
+struct nfs_localio_ctx *
+nfsd_open_local_fh(struct net *cl_nfssvc_net, struct auth_domain *cl_nfssvc_dom,
+		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
+		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
+{
+	int mayflags = NFSD_MAY_LOCALIO;
+	int status = 0;
+	struct nfsd_net *nn;
+	struct svc_cred rq_cred;
+	struct svc_fh fh;
+	struct nfs_localio_ctx *localio;
+	__be32 beres;
+
+	if (nfs_fh->size > NFS4_FHSIZE)
+		return ERR_PTR(-EINVAL);
+
+	localio = nfs_localio_ctx_alloc();
+	if (!localio)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Not running in nfsd context, so must safely get reference on nfsd_serv.
+	 * But the server may already be shutting down, if so disallow new localio.
+	 */
+	nn = net_generic(cl_nfssvc_net, nfsd_net_id);
+	if (unlikely(!nfsd_serv_try_get(nn))) {
+		status = -ENXIO;
+		goto out_nfsd_serv;
+	}
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
+	beres = nfsd_file_acquire_local(cl_nfssvc_net, &rq_cred, cl_nfssvc_dom,
+					&fh, mayflags, &localio->nf);
+	if (beres) {
+		status = nfs_stat_to_errno(be32_to_cpu(beres));
+		goto out_fh_put;
+	}
+	localio->nn = nn;
+
+out_fh_put:
+	fh_put(&fh);
+	if (rq_cred.cr_group_info)
+		put_group_info(rq_cred.cr_group_info);
+out_nfsd_serv:
+	if (status) {
+		nfs_localio_ctx_free(localio);
+		return ERR_PTR(status);
+	}
+	return localio;
+}
+EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
+
+/* Compile time type checking, not used by anything */
+static nfs_to_nfsd_open_local_fh_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
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
index 01947561d375..e12310dd5f4c 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -33,6 +33,8 @@
 
 #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >= NFSv3 */
 
+#define NFSD_MAY_LOCALIO		0x2000 /* for tracing, reflects when localio used */
+
 #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
 #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
 
@@ -158,6 +160,11 @@ __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 void		nfsd_filp_close(struct file *fp);
 
+struct nfs_localio_ctx *
+nfsd_open_local_fh(struct net *, struct auth_domain *,
+		   struct rpc_clnt *, const struct cred *,
+		   const struct nfs_fh *, const fmode_t);
+
 static inline int fh_want_write(struct svc_fh *fh)
 {
 	int ret;
-- 
2.44.0


