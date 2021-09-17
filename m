Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2440FB18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 17:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244503AbhIQPF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 11:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244563AbhIQPFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631891072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJBjv7xe7X9LWz8Py8bpZtsrzYe7qmQPJQT0ow4sRjs=;
        b=CIlyxKwrhwM1/h2KTgSsn/dfS63BpjksPup+wSDCTfMBkgRPjl2jHI9LSEcv+AyrqbSI96
        ueCS+QB6FqnMFT1IilPBY+8Jf1TLQDpp6Xk74qrtSAuooApqjYh4I5Ga+xgR2xMUa9X+5v
        bHZNv06tHHBFPcH/r8GfGOUh72axXC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-HD2lvM8gPOyIu8ouWuYI3Q-1; Fri, 17 Sep 2021 11:04:30 -0400
X-MC-Unique: HD2lvM8gPOyIu8ouWuYI3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49ECE101AFB4;
        Fri, 17 Sep 2021 15:04:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BF145D6D5;
        Fri, 17 Sep 2021 15:04:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 1/8] fscache: Generalise the ->begin_read_operation method
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 17 Sep 2021 16:04:15 +0100
Message-ID: <163189105559.2509237.10649193286647776741.stgit@warthog.procyon.org.uk>
In-Reply-To: <163189104510.2509237.10805032055807259087.stgit@warthog.procyon.org.uk>
References: <163189104510.2509237.10805032055807259087.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Generalise the ->begin_read_operation() method in the fscache_cache_ops
struct so that it's not read specific by:

 (1) changing the name to ->begin_operation();

 (2) changing the netfs_read_request struct pointer parameter to be a
     netfs_cache_resources struct pointer (it only accesses the cache
     resources and an ID for debugging from the read request);

 (3) and by changing the fscache_retrieval pointer parameter to be a
     fscache_operation pointer (it only access the operation base of the
     retrieval).

Also modify the cachefiles implementation so that it stores a pointer to
the fscache_operation rather than fscache_retrieval in the cache resources.

This makes it easier to share code with the write path in future.

Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/163162768886.438332.9851931782896704604.stgit@warthog.procyon.org.uk/ # rfc
---

 fs/afs/file.c                 |    2 +-
 fs/cachefiles/interface.c     |    2 +-
 fs/cachefiles/internal.h      |    4 ++--
 fs/cachefiles/io.c            |   28 +++++++++++++---------------
 fs/ceph/cache.h               |    2 +-
 fs/fscache/io.c               |   35 +++++++++++++++++++++--------------
 include/linux/fscache-cache.h |    6 +++---
 include/linux/fscache.h       |   15 ++++++++-------
 8 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index db035ae2a134..1563e9871bf6 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -344,7 +344,7 @@ static int afs_begin_cache_operation(struct netfs_read_request *rreq)
 {
 	struct afs_vnode *vnode = AFS_FS_I(rreq->inode);
 
-	return fscache_begin_read_operation(rreq, afs_vnode_cache(vnode));
+	return fscache_begin_read_operation(&rreq->cache_resources, afs_vnode_cache(vnode));
 }
 
 static int afs_check_write_begin(struct file *file, loff_t pos, unsigned len,
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index da28ac1fa225..8a7755b86c59 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -568,5 +568,5 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.uncache_page		= cachefiles_uncache_page,
 	.dissociate_pages	= cachefiles_dissociate_pages,
 	.check_consistency	= cachefiles_check_consistency,
-	.begin_read_operation	= cachefiles_begin_read_operation,
+	.begin_operation	= cachefiles_begin_operation,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 0a511c36dab8..994f90ff12ac 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -198,8 +198,8 @@ extern void cachefiles_uncache_page(struct fscache_object *, struct page *);
 /*
  * rdwr2.c
  */
-extern int cachefiles_begin_read_operation(struct netfs_read_request *,
-					   struct fscache_retrieval *);
+extern int cachefiles_begin_operation(struct netfs_cache_resources *,
+				      struct fscache_operation *);
 
 /*
  * security.c
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index fac2e8e7b533..08b3183e0dce 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -268,7 +268,7 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subrequest *subreq,
 						      loff_t i_size)
 {
-	struct fscache_retrieval *op = subreq->rreq->cache_resources.cache_priv;
+	struct fscache_operation *op = subreq->rreq->cache_resources.cache_priv;
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
@@ -277,8 +277,7 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 
 	_enter("%zx @%llx/%llx", subreq->len, subreq->start, i_size);
 
-	object = container_of(op->op.object,
-			      struct cachefiles_object, fscache);
+	object = container_of(op->object, struct cachefiles_object, fscache);
 	cache = container_of(object->fscache.cache,
 			     struct cachefiles_cache, cache);
 
@@ -351,7 +350,7 @@ static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
  */
 static void cachefiles_end_operation(struct netfs_cache_resources *cres)
 {
-	struct fscache_retrieval *op = cres->cache_priv;
+	struct fscache_operation *op = cres->cache_priv;
 	struct file *file = cres->cache_priv2;
 
 	_enter("");
@@ -359,8 +358,8 @@ static void cachefiles_end_operation(struct netfs_cache_resources *cres)
 	if (file)
 		fput(file);
 	if (op) {
-		fscache_op_complete(&op->op, false);
-		fscache_put_retrieval(op);
+		fscache_op_complete(op, false);
+		fscache_put_operation(op);
 	}
 
 	_leave("");
@@ -377,8 +376,8 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 /*
  * Open the cache file when beginning a cache operation.
  */
-int cachefiles_begin_read_operation(struct netfs_read_request *rreq,
-				    struct fscache_retrieval *op)
+int cachefiles_begin_operation(struct netfs_cache_resources *cres,
+			       struct fscache_operation *op)
 {
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
@@ -387,8 +386,7 @@ int cachefiles_begin_read_operation(struct netfs_read_request *rreq,
 
 	_enter("");
 
-	object = container_of(op->op.object,
-			      struct cachefiles_object, fscache);
+	object = container_of(op->object, struct cachefiles_object, fscache);
 	cache = container_of(object->fscache.cache,
 			     struct cachefiles_cache, cache);
 
@@ -406,11 +404,11 @@ int cachefiles_begin_read_operation(struct netfs_read_request *rreq,
 		goto error_file;
 	}
 
-	fscache_get_retrieval(op);
-	rreq->cache_resources.cache_priv = op;
-	rreq->cache_resources.cache_priv2 = file;
-	rreq->cache_resources.ops = &cachefiles_netfs_cache_ops;
-	rreq->cache_resources.debug_id = object->fscache.debug_id;
+	atomic_inc(&op->usage);
+	cres->cache_priv = op;
+	cres->cache_priv2 = file;
+	cres->ops = &cachefiles_netfs_cache_ops;
+	cres->debug_id = object->fscache.debug_id;
 	_leave("");
 	return 0;
 
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index 058ea2a04376..b94d3f38fb25 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -54,7 +54,7 @@ static inline int ceph_begin_cache_operation(struct netfs_read_request *rreq)
 {
 	struct fscache_cookie *cookie = ceph_fscache_cookie(ceph_inode(rreq->inode));
 
-	return fscache_begin_read_operation(rreq, cookie);
+	return fscache_begin_read_operation(&rreq->cache_resources, cookie);
 }
 #else
 
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 8ecc1141802f..3745a0631618 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -14,7 +14,7 @@
 #include "internal.h"
 
 /*
- * Start a cache read operation.
+ * Start a cache operation.
  * - we return:
  *   -ENOMEM	- out of memory, some pages may be being read
  *   -ERESTARTSYS - interrupted, some pages may be being read
@@ -24,15 +24,16 @@
  *                the pages
  *   0		- dispatched a read on all pages
  */
-int __fscache_begin_read_operation(struct netfs_read_request *rreq,
-				   struct fscache_cookie *cookie)
+int __fscache_begin_operation(struct netfs_cache_resources *cres,
+			      struct fscache_cookie *cookie,
+			      bool for_write)
 {
-	struct fscache_retrieval *op;
+	struct fscache_operation *op;
 	struct fscache_object *object;
 	bool wake_cookie = false;
 	int ret;
 
-	_enter("rr=%08x", rreq->debug_id);
+	_enter("c=%08x", cres->debug_id);
 
 	fscache_stat(&fscache_n_retrievals);
 
@@ -49,10 +50,16 @@ int __fscache_begin_read_operation(struct netfs_read_request *rreq,
 	if (fscache_wait_for_deferred_lookup(cookie) < 0)
 		return -ERESTARTSYS;
 
-	op = fscache_alloc_retrieval(cookie, NULL, NULL, NULL);
+	op = kzalloc(sizeof(*op), GFP_KERNEL);
 	if (!op)
 		return -ENOMEM;
-	trace_fscache_page_op(cookie, NULL, &op->op, fscache_page_op_retr_multi);
+
+	fscache_operation_init(cookie, op, NULL, NULL, NULL);
+	op->flags = FSCACHE_OP_MYTHREAD |
+		(1UL << FSCACHE_OP_WAITING) |
+		(1UL << FSCACHE_OP_UNUSE_COOKIE);
+
+	trace_fscache_page_op(cookie, NULL, op, fscache_page_op_retr_multi);
 
 	spin_lock(&cookie->lock);
 
@@ -64,9 +71,9 @@ int __fscache_begin_read_operation(struct netfs_read_request *rreq,
 
 	__fscache_use_cookie(cookie);
 	atomic_inc(&object->n_reads);
-	__set_bit(FSCACHE_OP_DEC_READ_CNT, &op->op.flags);
+	__set_bit(FSCACHE_OP_DEC_READ_CNT, &op->flags);
 
-	if (fscache_submit_op(object, &op->op) < 0)
+	if (fscache_submit_op(object, op) < 0)
 		goto nobufs_unlock_dec;
 	spin_unlock(&cookie->lock);
 
@@ -75,14 +82,14 @@ int __fscache_begin_read_operation(struct netfs_read_request *rreq,
 	/* we wait for the operation to become active, and then process it
 	 * *here*, in this thread, and not in the thread pool */
 	ret = fscache_wait_for_operation_activation(
-		object, &op->op,
+		object, op,
 		__fscache_stat(&fscache_n_retrieval_op_waits),
 		__fscache_stat(&fscache_n_retrievals_object_dead));
 	if (ret < 0)
 		goto error;
 
 	/* ask the cache to honour the operation */
-	ret = object->cache->ops->begin_read_operation(rreq, op);
+	ret = object->cache->ops->begin_operation(cres, op);
 
 error:
 	if (ret == -ENOMEM)
@@ -96,7 +103,7 @@ int __fscache_begin_read_operation(struct netfs_read_request *rreq,
 	else
 		fscache_stat(&fscache_n_retrievals_ok);
 
-	fscache_put_retrieval(op);
+	fscache_put_operation(op);
 	_leave(" = %d", ret);
 	return ret;
 
@@ -105,7 +112,7 @@ int __fscache_begin_read_operation(struct netfs_read_request *rreq,
 	wake_cookie = __fscache_unuse_cookie(cookie);
 nobufs_unlock:
 	spin_unlock(&cookie->lock);
-	fscache_put_retrieval(op);
+	fscache_put_operation(op);
 	if (wake_cookie)
 		__fscache_wake_unused_cookie(cookie);
 nobufs:
@@ -113,4 +120,4 @@ int __fscache_begin_read_operation(struct netfs_read_request *rreq,
 	_leave(" = -ENOBUFS");
 	return -ENOBUFS;
 }
-EXPORT_SYMBOL(__fscache_begin_read_operation);
+EXPORT_SYMBOL(__fscache_begin_operation);
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 8d39491c5f9f..efa9b6f9fab1 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -304,9 +304,9 @@ struct fscache_cache_ops {
 	/* dissociate a cache from all the pages it was backing */
 	void (*dissociate_pages)(struct fscache_cache *cache);
 
-	/* Begin a read operation for the netfs lib */
-	int (*begin_read_operation)(struct netfs_read_request *rreq,
-				    struct fscache_retrieval *op);
+	/* Begin an operation for the netfs lib */
+	int (*begin_operation)(struct netfs_cache_resources *cres,
+			       struct fscache_operation *op);
 };
 
 extern struct fscache_cookie fscache_fsdef_index;
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index a4dab5998613..32f65c16328a 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -196,7 +196,8 @@ extern void __fscache_invalidate(struct fscache_cookie *);
 extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
 
 #ifdef FSCACHE_USE_NEW_IO_API
-extern int __fscache_begin_read_operation(struct netfs_read_request *, struct fscache_cookie *);
+extern int __fscache_begin_operation(struct netfs_cache_resources *, struct fscache_cookie *,
+				     bool);
 #else
 extern int __fscache_read_or_alloc_page(struct fscache_cookie *,
 					struct page *,
@@ -511,12 +512,12 @@ int fscache_reserve_space(struct fscache_cookie *cookie, loff_t size)
 
 /**
  * fscache_begin_read_operation - Begin a read operation for the netfs lib
- * @rreq: The read request being undertaken
+ * @cres: The cache resources for the read being performed
  * @cookie: The cookie representing the cache object
  *
- * Begin a read operation on behalf of the netfs helper library.  @rreq
- * indicates the read request to which the operation state should be attached;
- * @cookie indicates the cache object that will be accessed.
+ * Begin a read operation on behalf of the netfs helper library.  @cres
+ * indicates the cache resources to which the operation state should be
+ * attached; @cookie indicates the cache object that will be accessed.
  *
  * This is intended to be called from the ->begin_cache_operation() netfs lib
  * operation as implemented by the network filesystem.
@@ -527,11 +528,11 @@ int fscache_reserve_space(struct fscache_cookie *cookie, loff_t size)
  * * Other error code from the cache, such as -ENOMEM.
  */
 static inline
-int fscache_begin_read_operation(struct netfs_read_request *rreq,
+int fscache_begin_read_operation(struct netfs_cache_resources *cres,
 				 struct fscache_cookie *cookie)
 {
 	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		return __fscache_begin_read_operation(rreq, cookie);
+		return __fscache_begin_operation(cres, cookie, false);
 	return -ENOBUFS;
 }
 


