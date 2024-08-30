Return-Path: <linux-fsdevel+bounces-27974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F959656BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 07:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4D41F24972
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 05:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8C114C5B0;
	Fri, 30 Aug 2024 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcT906ox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1A353389;
	Fri, 30 Aug 2024 05:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724994534; cv=none; b=JMnJX+pIzKDBczoh6NWSvAQ82sGMrTOJWvSEXC4ourVG5k0l8IOolrl++3Mn5N1FrTn1fqsCllgiEpnJh2GhP3kdRqJnU9d3Skjp95PucA0ANoMmJKk77O6FPE5NBldKH7gCeJD2DIgaB+Lr9edHi4NcaKOaT6C2JHc19Y2VwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724994534; c=relaxed/simple;
	bh=+2LXkvlpBpkhKod7sOqlDO/anaaBO3d08LbaGG4CbE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJdhZt0wURqdvCqo4hPicgyn7c8EHLcY+LB6IgIkVpjt92HIY+yzlCOivvJ6ly9sbHI6xFkKHQooJtEiuJSMXYb508bd4K3PTBJLHMlHemOJ8wMAot7JVqos/5y/s6smb0PMyfLn6/CFmR0N9F/LSw/oSF+0SEjsCHFBPOzRIE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcT906ox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E524C4CEC4;
	Fri, 30 Aug 2024 05:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724994533;
	bh=+2LXkvlpBpkhKod7sOqlDO/anaaBO3d08LbaGG4CbE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XcT906oxOAg7R+DOqKXUntBkQbGBSLebgSBU3C2SRF8aHtaAoPK7WgIJWRb0vnvBp
	 rFvU0DYT1vhkvM7aLYhcuV44455DEeZ1yX3HhcpCKseaC9optS0Z/6JsQTncWF7hUn
	 +UpOdXdRkW+ZWwsuX6cn+lHlxxzOrLYsv8X9LfXxLAdyfeaf/QLOIlr1eYRMIzLbhO
	 0YuHcEU/hXnReKr21dvsIS4AZPvYw5VpuCmh/4YHE6d6vgv0t8MvuQYNnHyzYkeLJh
	 zpq6v7m16DyJ/zUAlkL1Yr9iMApiJOE6EylD34fl229wxypOljrOuC574pRRGHVeJS
	 +ZLekflSHPMhA==
Date: Fri, 30 Aug 2024 01:08:52 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 15/25] nfs_common: introduce nfs_localio_ctx struct
 and interfaces
Message-ID: <ZtFT5LDW7BIkqKDf@kernel.org>
References: <>
 <95776943752608072e60f185e98f35a97175eecd.camel@kernel.org>
 <172499257359.4433.13078012410547323207@noble.neil.brown.name>
 <ZtFSQz8YaD3A4r3Y@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtFSQz8YaD3A4r3Y@kernel.org>

On Fri, Aug 30, 2024 at 01:01:55AM -0400, Mike Snitzer wrote:
> On Fri, Aug 30, 2024 at 02:36:13PM +1000, NeilBrown wrote:
> > On Fri, 30 Aug 2024, Jeff Layton wrote:
> > > 
> > > Have a pointer to a struct nfsd_localio_ops or something in the
> > > nfs_common module. That's initially set to NULL. Then, have a static
> > > structure of that type in nfsd.ko, and have its __init routine set the
> > > pointer in nfs_common to point to the right structure. The __exit
> > > routine will later set it to NULL.
> > > 
> > > > I really don't want all calls in NFS client (or nfs_common) to have to
> > > > first check if nfs_common's 'nfs_to' ops structure is NULL or not.
> > > 
> > > Neil seems to think that's not necessary:
> > > 
> > > "If nfs/localio holds an auth_domain, then it implicitly holds a
> > > reference to the nfsd module and the functions cannot disappear."
> > 
> > On reflection that isn't quite right, but it is the sort of approach
> > that I think we need to take.
> > There are several things that the NFS client needs to hold one to.
> > 
> > 1/ It needs a reference to the nfsd module (or symbols in the module).
> >    I think this can be held long term but we need a clear mechanism for
> >    it to be dropped.
> > 2/ It needs a reference to the nfsd_serv which it gets through the
> >    'struct net' pointer.  I've posted patches to handle that better.
> > 3/ It needs a reference to an auth_domain.  This can safely be a long
> >    term reference.  It can already be invalidated and the code to free
> >    it is in sunrpc which nfs already pins.  Any delay in freeing it only
> >    wastes memory (not much), it doesn't impact anything else.
> > 4/ It needs a reference to the nfsd_file and/or file.  This is currently
> >    done only while the ref to the nfsd_serv is held, so I think there is
> >    no problem there.
> > 
> > So possibly we could take a reference to the nfsd module whenever we
> > store a net in nfs_uuid. and drop the ref whenever we clear that.
> > 
> > That means we cannot call nfsd_open_local_fh() without first getting a
> > ref on the nfsd_serv which my latest code doesn't do.  That is easily
> > fixed.  I'll send a patch for consideration...
> 
> I already implemented 2 different versions today, meant for v15.
> 
> First is a relaxed version of the v14 code (less code, only using
> symbol_request on nfsd_open_local_fh.

This is the corresponding code that is needed in fs/nfsd/localio.c

+static const struct nfsd_localio_operations nfsd_localio_ops = {
+       .nfsd_open_local_fh = nfsd_open_local_fh,
+       .nfsd_file_get = nfsd_file_get,
+       .nfsd_file_put = nfsd_file_put,
+       .nfsd_file_file = nfsd_file_file,
+       .nfsd_serv_put = nfsd_serv_put,
+};
+
+void init_nfs_to_nfsd_localio_ops(void)
+{
+       memcpy(&nfs_to, &nfsd_localio_ops, sizeof(nfsd_localio_ops));
+}
+EXPORT_SYMBOL_GPL(init_nfs_to_nfsd_localio_ops);

From: Mike Snitzer <snitzer@kernel.org>
Date: Wed, 28 Aug 2024 17:04:44 -0500
Subject: [PATCH v15.option1] nfs_common: introduce nfs_localio_ctx struct and interfaces

Introduce struct nfs_localio_ctx (which has nfsd_file and nfsd_net
members) and the interfaces nfs_localio_ctx_alloc() and
nfs_localio_ctx_free().  The next commit will introduce
nfsd_open_local_fh() which returns a nfs_localio_ctx structure.

Also, expose localio's required NFSD symbols to NFS client:
- Make nfsd_open_local_fh() symbol and other required NFSD symbols
  available to NFS in a global 'nfs_to' nfsd_localio_operations
  struct.  Add interfaces get_nfs_to_nfsd_localio_ops() and
  put_nfs_to_nfsd_localio_ops() to allow each NFS client to take a
  reference on NFSD (indirectly through nfs_common).

- Given the unique nature of NFS LOCALIO being an optional feature
  that when used requires NFS share access to NFSD memory: a unique
  bridging of NFSD resources to NFS (via nfs_common) is needed.  But
  that bridge must be dynamic, hence the use of symbol_request() and
  symbol_put() of the one init_nfs_to_nfsd_localio_ops() symbol which
  nfs_common's LOCALIO code uses as a bellwether for both if NFSD is
  available and supports LOCALIO.

- Use of a refcount_t (managed by {get,put}_nfs_to_nfsd_localio_ops)
  is required to ensure NFS doesn't become disjoint from NFSD's
  availability in the face of LOCALIO support being toggled on/off
  coupled with the NFSD module (possibly) being unloaded.

- Introduce nfsd_file_file() wrapper that provides access to
  nfsd_file's backing file.  Keeps nfsd_file structure opaque to NFS
  client (as suggested by Jeff Layton).

- The addition of nfsd_file_get, nfsd_file_put and nfsd_file_file
  symbols prepares for the NFS client to use nfsd_file for localio.

Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com> # nfs_to
Suggested-by: NeilBrown <neilb@suse.de> # nfsd_localio_operations
Suggested-by: Jeff Layton <jlayton@kernel.org> # nfsd_file_file
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs_common/nfslocalio.c | 107 +++++++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.c        |  16 ++++++
 fs/nfsd/filecache.h        |   1 +
 fs/nfsd/nfssvc.c           |   2 +
 include/linux/nfslocalio.h |  47 ++++++++++++++++
 5 files changed, 173 insertions(+)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 0b2e17c2068f..5f12610a877c 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -5,6 +5,7 @@
 
 #include <linux/module.h>
 #include <linux/rculist.h>
+#include <linux/refcount.h>
 #include <linux/nfslocalio.h>
 #include <net/netns/generic.h>
 
@@ -72,3 +73,109 @@ bool nfs_uuid_is_local(const uuid_t *uuid, struct net *net, struct auth_domain *
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
+static refcount_t nfs_to_ref;
+struct nfsd_localio_operations nfs_to;
+EXPORT_SYMBOL_GPL(nfs_to);
+
+bool get_nfs_to_nfsd_localio_ops(void)
+{
+	bool ret = false;
+	init_nfs_to_nfsd_localio_ops_t init_nfs_to;
+
+	spin_lock(&nfs_to_nfsd_lock);
+
+	/* Only get nfsd_localio_operations on first reference */
+	if (refcount_read(&nfs_to_ref) == 0)
+		refcount_set(&nfs_to_ref, 1);
+	else {
+		refcount_inc(&nfs_to_ref);
+		ret = true;
+		goto out;
+	}
+
+	/*
+	 * If NFSD isn't available LOCALIO isn't possible.
+	 * Use init_nfs_to_nfsd_ops symbol as the bellwether,
+	 * if available then nfs_common has NFSD module reference
+	 * on NFS's behalf and can initialize global 'nfs_to'.
+	 */
+	init_nfs_to = symbol_request(init_nfs_to_nfsd_localio_ops);
+	if (init_nfs_to) {
+		init_nfs_to();
+		if (WARN_ON_ONCE(!nfs_to.nfsd_open_local_fh)) {
+			symbol_put(init_nfs_to_nfsd_localio_ops);
+			goto out;
+		}
+		ret = true;
+	}
+out:
+	spin_unlock(&nfs_to_nfsd_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(get_nfs_to_nfsd_localio_ops);
+
+void put_nfs_to_nfsd_localio_ops(void)
+{
+	spin_lock(&nfs_to_nfsd_lock);
+
+	if (!refcount_dec_and_test(&nfs_to_ref))
+		goto out;
+
+	symbol_put(init_nfs_to_nfsd_localio_ops);
+	memset(&nfs_to, 0, sizeof(nfs_to));
+out:
+	spin_unlock(&nfs_to_nfsd_lock);
+}
+EXPORT_SYMBOL_GPL(put_nfs_to_nfsd_localio_ops);
+
+/*
+ * nfs_localio_ctx cache and alloc/free interfaces.
+ */
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
+static int __init nfslocalio_init(void)
+{
+	refcount_set(&nfs_to_ref, 0);
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
index 2dc72de31f61..1a26f5812578 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -39,6 +39,7 @@
 #include <linux/fsnotify.h>
 #include <linux/seq_file.h>
 #include <linux/rhashtable.h>
+#include <linux/nfslocalio.h>
 
 #include "vfs.h"
 #include "nfsd.h"
@@ -345,6 +346,7 @@ nfsd_file_get(struct nfsd_file *nf)
 		return nf;
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(nfsd_file_get);
 
 /**
  * nfsd_file_put - put the reference to a nfsd_file
@@ -389,6 +391,20 @@ nfsd_file_put(struct nfsd_file *nf)
 	if (refcount_dec_and_test(&nf->nf_ref))
 		nfsd_file_free(nf);
 }
+EXPORT_SYMBOL_GPL(nfsd_file_put);
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
index 9735ae8d3e5e..6cc870122e2a 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -7,6 +7,7 @@
 
 #include <linux/list.h>
 #include <linux/uuid.h>
+#include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/nfs.h>
 #include <net/net_namespace.h>
@@ -28,4 +29,50 @@ void nfs_uuid_begin(nfs_uuid_t *);
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
+/* localio needs to map filehandle -> struct nfsd_file */
+typedef struct nfs_localio_ctx *
+(*nfs_to_nfsd_open_local_fh_t)(struct net *, struct auth_domain *,
+			       struct rpc_clnt *, const struct cred *,
+			       const struct nfs_fh *, const fmode_t);
+
+extern struct nfs_localio_ctx *
+nfsd_open_local_fh(struct net *, struct auth_domain *,
+		   struct rpc_clnt *, const struct cred *,
+		   const struct nfs_fh *, const fmode_t);
+
+/* localio needs to acquire an nfsd_file */
+typedef struct nfsd_file * (*nfs_to_nfsd_file_get_t)(struct nfsd_file *);
+/* localio needs to release an nfsd_file */
+typedef void (*nfs_to_nfsd_file_put_t)(struct nfsd_file *);
+/* localio needs to access the nf->nf_file */
+typedef struct file * (*nfs_to_nfsd_file_file_t)(struct nfsd_file *);
+/* localio needs to release nn->nfsd_serv */
+typedef void (*nfs_to_nfsd_serv_put_t)(struct nfsd_net *);
+
+struct nfsd_localio_operations {
+	nfs_to_nfsd_open_local_fh_t	nfsd_open_local_fh;
+	nfs_to_nfsd_file_get_t		nfsd_file_get;
+	nfs_to_nfsd_file_put_t		nfsd_file_put;
+	nfs_to_nfsd_file_file_t		nfsd_file_file;
+	nfs_to_nfsd_serv_put_t		nfsd_serv_put;
+} ____cacheline_aligned;
+
+extern struct nfsd_localio_operations nfs_to;
+
+typedef void (*init_nfs_to_nfsd_localio_ops_t)(void);
+extern void init_nfs_to_nfsd_localio_ops(void);
+bool get_nfs_to_nfsd_localio_ops(void);
+void put_nfs_to_nfsd_localio_ops(void);
+
+struct nfs_localio_ctx *nfs_localio_ctx_alloc(void);
+void nfs_localio_ctx_free(struct nfs_localio_ctx *);
+
 #endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


