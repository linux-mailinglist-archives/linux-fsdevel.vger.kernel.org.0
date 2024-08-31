Return-Path: <linux-fsdevel+bounces-28125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7889673B9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C70BAB212D9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE47183CAE;
	Sat, 31 Aug 2024 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQVbXUnH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6A818BC36;
	Sat, 31 Aug 2024 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143896; cv=none; b=uBdPP2aAHk+rFzMaHRHA2YYpDuRNfs+Uq4KiPsmmnEjeX1usEPhqZOqzETrLdDNChazTAIPo6XwGCI4Nkp5FRePCwjCvvXG+RWYS6q2I/C5z1THp6iR0I6JFTAfZe0dgUQuYxLW2PBIZm0aqggxLmwu53fwGpHP6j+xIMx5/aU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143896; c=relaxed/simple;
	bh=rVmlx3wZc2X0/Uf1kPvnhOTZjcIvnj3OOcS/GDUrl9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbEN0T78G7tMe5GLoX6URZqGUFSUjZEqIqFQTxZc0hGhhZNyvbM/Bb3ZODJL8+NSDOTWrZbCkdlK3gY0EqjHNV572e3mWLsOA1cNV3ibQZw3VE992cJtMjOKXaSQNFKCebCVYrPLvDA+A900bdgwnfEf9cN8hP/oQw09MirrOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQVbXUnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E56DC4CEC4;
	Sat, 31 Aug 2024 22:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143896;
	bh=rVmlx3wZc2X0/Uf1kPvnhOTZjcIvnj3OOcS/GDUrl9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oQVbXUnHy1AjqPG78/KKRhxlRDZg8V9qJ0Tj7FhE0QioPiP2YseJ8BkY5mop4vMjP
	 3KxNl1JoXa7PvMUGScOu2N8nMR41/k4npAnxCeRQIPwJGi8gQSVTWMJXmkJoiLOsDC
	 KjxiH58l07QvgDq1YZm2/3QtfEAWB1GAjc21pMm1UZ4VMKQjrqMk/h99k4OUYim3VJ
	 3DB4+MUCv0MRpoVZD61BycWFvQGjxLY5hgqLzBJBVh4Cue6NoT3IH8EOetvsnc3AkX
	 EshAiI6vgK17uN78tI0g3F3N/gzeT5Nsy54ONplZROFLF7s0vUrMgrKBgHTPD86zhN
	 MEz8UrHRxHYqg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 15/26] nfs_common: prepare for the NFS client to use nfsd_file for LOCALIO
Date: Sat, 31 Aug 2024 18:37:35 -0400
Message-ID: <20240831223755.8569-16-snitzer@kernel.org>
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

The next commit will introduce nfsd_open_local_fh() which returns an
nfsd_file structure.  This commit exposes LOCALIO's required NFSD
symbols to the NFS client:

- Make nfsd_open_local_fh() symbol and other required NFSD symbols
  available to NFS in a global 'nfs_to' nfsd_localio_operations
  struct (global access suggested by Trond, nfsd_localio_operations
  suggested by NeilBrown).  The next commit will also introduce
  nfsd_localio_ops_init() that init_nfsd() will call to initialize
  'nfs_to'.

- Introduce nfsd_file_file() that provides access to nfsd_file's
  backing file.  Keeps nfsd_file structure opaque to NFS client (as
  suggested by Jeff Layton).

- Introduce nfsd_file_put_local() that will put the reference to the
  nfsd_file's associated nn->nfsd_serv and then put the reference to
  the nfsd_file (as suggested by NeilBrown).

Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com> # nfs_to
Suggested-by: NeilBrown <neilb@suse.de> # nfsd_localio_operations
Suggested-by: Jeff Layton <jlayton@kernel.org> # nfsd_file_file
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs_common/nfslocalio.c | 23 +++++++++++++++++++++++
 fs/nfsd/filecache.c        | 30 ++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h        |  2 ++
 fs/nfsd/nfssvc.c           |  2 ++
 include/linux/nfslocalio.h | 30 ++++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 22b0ddf225ca..64f75a3a370a 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -114,3 +114,26 @@ void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
 	}
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
+
+/*
+ * The NFS LOCALIO code needs to call into NFSD using various symbols,
+ * but cannot be statically linked, because that will make the NFS
+ * module always depend on the NFSD module.
+ *
+ * 'nfs_to' provides NFS access to NFSD functions needed for LOCALIO,
+ * its lifetime is tightly coupled to the NFSD module and will always
+ * be available to NFS LOCALIO because any successful client<->server
+ * LOCALIO handshake results in a reference on the NFSD module (above),
+ * so NFS implicitly holds a reference to the NFSD module and its
+ * functions in the 'nfs_to' nfsd_localio_operations cannot disappear.
+ *
+ * If the last NFS client using LOCALIO disconnects (and its reference
+ * on NFSD dropped) then NFSD could be unloaded, resulting in 'nfs_to'
+ * functions being invalid pointers. But if NFSD isn't loaded then NFS
+ * will not be able to handshake with NFSD and will have no cause to
+ * try to call 'nfs_to' function pointers. If/when NFSD is reloaded it
+ * will reinitialize the 'nfs_to' function pointers and make LOCALIO
+ * possible.
+ */
+struct nfsd_localio_operations nfs_to;
+EXPORT_SYMBOL_GPL(nfs_to);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2dc72de31f61..89ff380ec31e 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -390,6 +390,36 @@ nfsd_file_put(struct nfsd_file *nf)
 		nfsd_file_free(nf);
 }
 
+/**
+ * nfsd_file_put_local - put the reference to nfsd_file and local nfsd_serv
+ * @nf: nfsd_file of which to put the references
+ *
+ * First put the reference of the nfsd_file's associated nn->nfsd_serv and
+ * then put the reference to the nfsd_file.
+ */
+void
+nfsd_file_put_local(struct nfsd_file *nf)
+{
+	struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
+
+	nfsd_serv_put(nn);
+	nfsd_file_put(nf);
+}
+EXPORT_SYMBOL_GPL(nfsd_file_put_local);
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
 static void
 nfsd_file_dispose_list(struct list_head *dispose)
 {
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 26ada78b8c1e..cadf3c2689c4 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -55,7 +55,9 @@ void nfsd_file_cache_shutdown(void);
 int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
+void nfsd_file_put_local(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
+struct file *nfsd_file_file(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
 void nfsd_file_net_dispose(struct nfsd_net *nn);
 bool nfsd_file_is_cached(struct inode *inode);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c639fbe4d8c2..7b9119b8dd1b 100644
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
@@ -201,6 +202,7 @@ void nfsd_serv_put(struct nfsd_net *nn)
 {
 	percpu_ref_put(&nn->nfsd_serv_ref);
 }
+EXPORT_SYMBOL_GPL(nfsd_serv_put);
 
 static void nfsd_serv_done(struct percpu_ref *ref)
 {
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 4165ff8390c1..62419c4bc8f1 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/uuid.h>
+#include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/nfs.h>
 #include <net/net_namespace.h>
@@ -33,4 +34,33 @@ void nfs_uuid_is_local(const uuid_t *, struct list_head *,
 void nfs_uuid_invalidate_clients(struct list_head *list);
 void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
 
+struct nfsd_file;
+
+/* localio needs to map filehandle -> struct nfsd_file */
+typedef struct nfsd_file *
+(*nfs_to_nfsd_open_local_fh_t)(nfs_uuid_t *, struct rpc_clnt *,
+			       const struct cred *, const struct nfs_fh *,
+			       const fmode_t);
+
+extern struct nfsd_file *
+nfsd_open_local_fh(nfs_uuid_t *, struct rpc_clnt *,
+		   const struct cred *, const struct nfs_fh *,
+		   const fmode_t) __must_hold(rcu);
+
+/* localio needs to acquire an nfsd_file */
+typedef struct nfsd_file * (*nfs_to_nfsd_file_get_t)(struct nfsd_file *);
+/* localio needs to release an nfsd_file and its associated nn->nfsd_serv */
+typedef void (*nfs_to_nfsd_file_put_local_t)(struct nfsd_file *);
+/* localio needs to access the nf->nf_file */
+typedef struct file * (*nfs_to_nfsd_file_file_t)(struct nfsd_file *);
+
+struct nfsd_localio_operations {
+	nfs_to_nfsd_open_local_fh_t	nfsd_open_local_fh;
+	nfs_to_nfsd_file_put_local_t	nfsd_file_put_local;
+	nfs_to_nfsd_file_file_t		nfsd_file_file;
+} ____cacheline_aligned;
+
+extern void nfsd_localio_ops_init(void);
+extern struct nfsd_localio_operations nfs_to;
+
 #endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


