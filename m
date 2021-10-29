Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E42543FE07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 16:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhJ2OM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 10:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231849AbhJ2OMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635516623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMSMZdHL+b4iGfOcRTVs5jnCyEYsAarV3npGJJDSt2w=;
        b=FuGkJmAisDTqIZwc4tW3Inop5s58lriFvq7ncT8hVWnFoWpSw/keV1lG5/rVindWMwrN7w
        bjhgSLUkkwGjFZ/5Cgijl+zPzxTPWdrKkAsHuVwTX8MwopN2NJxA1LbVxp5H0Tu1Sr14QH
        cfCyPnqylFc93b0+47+DO59drdjXJGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-MKK7tvioMAK5BDc58lrnqQ-1; Fri, 29 Oct 2021 10:10:15 -0400
X-MC-Unique: MKK7tvioMAK5BDc58lrnqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE78A1006AA3;
        Fri, 29 Oct 2021 14:10:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9201560C13;
        Fri, 29 Oct 2021 14:10:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 04/10] fscache: Implement a fallback I/O interface to
 replace the old API
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Dave Wysochanski <dwysocha@redhat.com>, linux-cachefs@redhat.com,
        dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Oct 2021 15:10:01 +0100
Message-ID: <163551660175.1877519.17630241595380785887.stgit@warthog.procyon.org.uk>
In-Reply-To: <163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk>
References: <163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement an alternative to using the netfslib-base I/O API so that we can
move forwards on getting rid of the old API.  Note that this API is should
not be used by new filesystems as it still uses the backing filesystem to
track unfilled holes in the backing file, though using SEEK_DATA/SEEK_HOLE
rather than bmap().

This is dangerous and can lead to corrupted data as the backing filesystem
cannot be relied on not to fill in holes with blocks of zeros in order to
optimise an extent list[1].  It may also punch out blocks of zeros to
create holes for the same reason, but this is less of a problem.

Also adjust the macros that must be defined to indicate which API is to be
used:

 (*) FSCACHE_USE_OLD_IO_API - Use the current upstream API.  This will be
     deleted.

 (*) FSCACHE_USE_FALLBACK_IO_API - Use the API added here.

 (*) FSCACHE_USE_NEW_IO_API - Use the new API or netfs API.

Changes
=======
ver #2:
  - Changed "deprecated" to "fallback" in the new function names[2].
  - Need to define FSCACHE_USE_FALLBACK_IO_API in fscache/io.c to enable
    the prototypes of the functions[3].
  - Removed a couple of unused variables[3].
  - Make netfs/read_helpers.c use NETFS_READ_HOLE_*.

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Dave Wysochanski <dwysocha@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/YO17ZNOcq+9PajfQ@mit.edu/ [1]
Link: https://lore.kernel.org/r/CAHk-=wiVK+1CyEjW8u71zVPK8msea=qPpznX35gnX+s8sXnJTg@mail.gmail.com/ [2]
Link: https://lore.kernel.org/r/202109150420.QX7dDzSE-lkp@intel.com/ [3]
Link: https://lore.kernel.org/r/163162770137.438332.13788466444753625553.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/163189107352.2509237.759630157032861275.stgit@warthog.procyon.org.uk/ # rfc v2
---

 fs/9p/cache.h           |    1 
 fs/cachefiles/io.c      |   28 ++++++++-
 fs/cifs/fscache.h       |    1 
 fs/fscache/internal.h   |    3 +
 fs/fscache/io.c         |  137 +++++++++++++++++++++++++++++++++++++++------
 fs/fscache/page.c       |    1 
 fs/fscache/stats.c      |   12 +++-
 fs/netfs/read_helper.c  |    8 +--
 fs/nfs/fscache.h        |    1 
 include/linux/fscache.h |  142 ++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/netfs.h   |   17 +++++-
 11 files changed, 314 insertions(+), 37 deletions(-)

diff --git a/fs/9p/cache.h b/fs/9p/cache.h
index 00f107af443e..c7e74776ce90 100644
--- a/fs/9p/cache.h
+++ b/fs/9p/cache.h
@@ -8,6 +8,7 @@
 #ifndef _9P_CACHE_H
 #define _9P_CACHE_H
 #ifdef CONFIG_9P_FSCACHE
+#define FSCACHE_USE_OLD_IO_API
 #include <linux/fscache.h>
 #include <linux/spinlock.h>
 
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index dbc1c4421116..5ead97de4bb7 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -58,14 +58,14 @@ static void cachefiles_read_complete(struct kiocb *iocb, long ret, long ret2)
 static int cachefiles_read(struct netfs_cache_resources *cres,
 			   loff_t start_pos,
 			   struct iov_iter *iter,
-			   bool seek_data,
+			   enum netfs_read_from_hole read_hole,
 			   netfs_io_terminated_t term_func,
 			   void *term_func_priv)
 {
 	struct cachefiles_kiocb *ki;
 	struct file *file = cres->cache_priv2;
 	unsigned int old_nofs;
-	ssize_t ret = -ENOBUFS;
+	ssize_t ret = -ENODATA;
 	size_t len = iov_iter_count(iter), skipped = 0;
 
 	_enter("%pD,%li,%llx,%zx/%llx",
@@ -75,7 +75,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	/* If the caller asked us to seek for data before doing the read, then
 	 * we should do that now.  If we find a gap, we fill it with zeros.
 	 */
-	if (seek_data) {
+	if (read_hole != NETFS_READ_HOLE_IGNORE) {
 		loff_t off = start_pos, off2;
 
 		off2 = vfs_llseek(file, off, SEEK_DATA);
@@ -90,6 +90,9 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 			 * in the region, so clear the rest of the buffer and
 			 * return success.
 			 */
+			if (read_hole == NETFS_READ_HOLE_FAIL)
+				goto presubmission_error;
+
 			iov_iter_zero(len, iter);
 			skipped = len;
 			ret = 0;
@@ -350,6 +353,24 @@ static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
 	return 0;
 }
 
+/*
+ * Prepare for a write to occur from the fallback I/O API.
+ */
+static int cachefiles_prepare_fallback_write(struct netfs_cache_resources *cres,
+					     pgoff_t index)
+{
+	struct fscache_operation *op = cres->cache_priv;
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+
+	_enter("%lx", index);
+
+	object = container_of(op->object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+	return cachefiles_has_space(cache, 0, 1);
+}
+
 /*
  * Clean up an operation.
  */
@@ -376,6 +397,7 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.write			= cachefiles_write,
 	.prepare_read		= cachefiles_prepare_read,
 	.prepare_write		= cachefiles_prepare_write,
+	.prepare_fallback_write	= cachefiles_prepare_fallback_write,
 };
 
 /*
diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index 9baa1d0f22bd..729b51100a6d 100644
--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -9,6 +9,7 @@
 #ifndef _CIFS_FSCACHE_H
 #define _CIFS_FSCACHE_H
 
+#define FSCACHE_USE_OLD_IO_API
 #include <linux/fscache.h>
 
 #include "cifsglob.h"
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index c3e4804b8fcb..1d1046408311 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -180,12 +180,15 @@ extern atomic_t fscache_n_stores;
 extern atomic_t fscache_n_stores_ok;
 extern atomic_t fscache_n_stores_again;
 extern atomic_t fscache_n_stores_nobufs;
+extern atomic_t fscache_n_stores_intr;
 extern atomic_t fscache_n_stores_oom;
 extern atomic_t fscache_n_store_ops;
 extern atomic_t fscache_n_store_calls;
 extern atomic_t fscache_n_store_pages;
 extern atomic_t fscache_n_store_radix_deletes;
 extern atomic_t fscache_n_store_pages_over_limit;
+extern atomic_t fscache_n_stores_object_dead;
+extern atomic_t fscache_n_store_op_waits;
 
 extern atomic_t fscache_n_store_vmscan_not_storing;
 extern atomic_t fscache_n_store_vmscan_gone;
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 3745a0631618..e633808ba813 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -8,7 +8,10 @@
 #define FSCACHE_DEBUG_LEVEL PAGE
 #include <linux/module.h>
 #define FSCACHE_USE_NEW_IO_API
+#define FSCACHE_USE_FALLBACK_IO_API
 #include <linux/fscache-cache.h>
+#include <linux/uio.h>
+#include <linux/bvec.h>
 #include <linux/slab.h>
 #include <linux/netfs.h>
 #include "internal.h"
@@ -35,7 +38,10 @@ int __fscache_begin_operation(struct netfs_cache_resources *cres,
 
 	_enter("c=%08x", cres->debug_id);
 
-	fscache_stat(&fscache_n_retrievals);
+	if (for_write)
+		fscache_stat(&fscache_n_stores);
+	else
+		fscache_stat(&fscache_n_retrievals);
 
 	if (hlist_empty(&cookie->backing_objects))
 		goto nobufs;
@@ -77,14 +83,23 @@ int __fscache_begin_operation(struct netfs_cache_resources *cres,
 		goto nobufs_unlock_dec;
 	spin_unlock(&cookie->lock);
 
-	fscache_stat(&fscache_n_retrieval_ops);
-
 	/* we wait for the operation to become active, and then process it
 	 * *here*, in this thread, and not in the thread pool */
-	ret = fscache_wait_for_operation_activation(
-		object, op,
-		__fscache_stat(&fscache_n_retrieval_op_waits),
-		__fscache_stat(&fscache_n_retrievals_object_dead));
+	if (for_write) {
+		fscache_stat(&fscache_n_store_ops);
+
+		ret = fscache_wait_for_operation_activation(
+			object, op,
+			__fscache_stat(&fscache_n_store_op_waits),
+			__fscache_stat(&fscache_n_stores_object_dead));
+	} else {
+		fscache_stat(&fscache_n_retrieval_ops);
+
+		ret = fscache_wait_for_operation_activation(
+			object, op,
+			__fscache_stat(&fscache_n_retrieval_op_waits),
+			__fscache_stat(&fscache_n_retrievals_object_dead));
+	}
 	if (ret < 0)
 		goto error;
 
@@ -92,16 +107,27 @@ int __fscache_begin_operation(struct netfs_cache_resources *cres,
 	ret = object->cache->ops->begin_operation(cres, op);
 
 error:
-	if (ret == -ENOMEM)
-		fscache_stat(&fscache_n_retrievals_nomem);
-	else if (ret == -ERESTARTSYS)
-		fscache_stat(&fscache_n_retrievals_intr);
-	else if (ret == -ENODATA)
-		fscache_stat(&fscache_n_retrievals_nodata);
-	else if (ret < 0)
-		fscache_stat(&fscache_n_retrievals_nobufs);
-	else
-		fscache_stat(&fscache_n_retrievals_ok);
+	if (for_write) {
+		if (ret == -ENOMEM)
+			fscache_stat(&fscache_n_stores_oom);
+		else if (ret == -ERESTARTSYS)
+			fscache_stat(&fscache_n_stores_intr);
+		else if (ret < 0)
+			fscache_stat(&fscache_n_stores_nobufs);
+		else
+			fscache_stat(&fscache_n_stores_ok);
+	} else {
+		if (ret == -ENOMEM)
+			fscache_stat(&fscache_n_retrievals_nomem);
+		else if (ret == -ERESTARTSYS)
+			fscache_stat(&fscache_n_retrievals_intr);
+		else if (ret == -ENODATA)
+			fscache_stat(&fscache_n_retrievals_nodata);
+		else if (ret < 0)
+			fscache_stat(&fscache_n_retrievals_nobufs);
+		else
+			fscache_stat(&fscache_n_retrievals_ok);
+	}
 
 	fscache_put_operation(op);
 	_leave(" = %d", ret);
@@ -116,8 +142,83 @@ int __fscache_begin_operation(struct netfs_cache_resources *cres,
 	if (wake_cookie)
 		__fscache_wake_unused_cookie(cookie);
 nobufs:
-	fscache_stat(&fscache_n_retrievals_nobufs);
+	if (for_write)
+		fscache_stat(&fscache_n_stores_nobufs);
+	else
+		fscache_stat(&fscache_n_retrievals_nobufs);
 	_leave(" = -ENOBUFS");
 	return -ENOBUFS;
 }
 EXPORT_SYMBOL(__fscache_begin_operation);
+
+/*
+ * Clean up an operation.
+ */
+static void fscache_end_operation(struct netfs_cache_resources *cres)
+{
+	cres->ops->end_operation(cres);
+}
+
+/*
+ * Fallback page reading interface.
+ */
+int __fscache_fallback_read_page(struct fscache_cookie *cookie, struct page *page)
+{
+	struct netfs_cache_resources cres;
+	struct iov_iter iter;
+	struct bio_vec bvec[1];
+	int ret;
+
+	_enter("%lx", page->index);
+
+	memset(&cres, 0, sizeof(cres));
+	bvec[0].bv_page		= page;
+	bvec[0].bv_offset	= 0;
+	bvec[0].bv_len		= PAGE_SIZE;
+	iov_iter_bvec(&iter, READ, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+
+	ret = fscache_begin_read_operation(&cres, cookie);
+	if (ret < 0)
+		return ret;
+
+	ret = fscache_read(&cres, page_offset(page), &iter, NETFS_READ_HOLE_FAIL,
+			   NULL, NULL);
+	fscache_end_operation(&cres);
+	_leave(" = %d", ret);
+	return ret;
+}
+EXPORT_SYMBOL(__fscache_fallback_read_page);
+
+/*
+ * Fallback page writing interface.
+ */
+int __fscache_fallback_write_page(struct fscache_cookie *cookie, struct page *page)
+{
+	struct netfs_cache_resources cres;
+	struct iov_iter iter;
+	struct bio_vec bvec[1];
+	int ret;
+
+	_enter("%lx", page->index);
+
+	memset(&cres, 0, sizeof(cres));
+	bvec[0].bv_page		= page;
+	bvec[0].bv_offset	= 0;
+	bvec[0].bv_len		= PAGE_SIZE;
+	iov_iter_bvec(&iter, WRITE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+
+	ret = __fscache_begin_operation(&cres, cookie, true);
+	if (ret < 0)
+		return ret;
+
+	ret = cres.ops->prepare_fallback_write(&cres, page_index(page));
+	if (ret < 0)
+		goto out;
+
+	ret = fscache_write(&cres, page_offset(page), &iter, NULL, NULL);
+out:
+	fscache_end_operation(&cres);
+	_leave(" = %d", ret);
+	return ret;
+}
+EXPORT_SYMBOL(__fscache_fallback_write_page);
diff --git a/fs/fscache/page.c b/fs/fscache/page.c
index 27df94ef0e0b..ed41a00b861c 100644
--- a/fs/fscache/page.c
+++ b/fs/fscache/page.c
@@ -7,6 +7,7 @@
 
 #define FSCACHE_DEBUG_LEVEL PAGE
 #include <linux/module.h>
+#define FSCACHE_USE_OLD_IO_API
 #include <linux/fscache-cache.h>
 #include <linux/buffer_head.h>
 #include <linux/pagevec.h>
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index a7c3ed89a3e0..3ffa34c99977 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -54,12 +54,15 @@ atomic_t fscache_n_stores;
 atomic_t fscache_n_stores_ok;
 atomic_t fscache_n_stores_again;
 atomic_t fscache_n_stores_nobufs;
+atomic_t fscache_n_stores_intr;
 atomic_t fscache_n_stores_oom;
 atomic_t fscache_n_store_ops;
 atomic_t fscache_n_store_calls;
 atomic_t fscache_n_store_pages;
 atomic_t fscache_n_store_radix_deletes;
 atomic_t fscache_n_store_pages_over_limit;
+atomic_t fscache_n_stores_object_dead;
+atomic_t fscache_n_store_op_waits;
 
 atomic_t fscache_n_store_vmscan_not_storing;
 atomic_t fscache_n_store_vmscan_gone;
@@ -221,18 +224,21 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_retrieval_op_waits),
 		   atomic_read(&fscache_n_retrievals_object_dead));
 
-	seq_printf(m, "Stores : n=%u ok=%u agn=%u nbf=%u oom=%u\n",
+	seq_printf(m, "Stores : n=%u ok=%u agn=%u nbf=%u int=%u oom=%u\n",
 		   atomic_read(&fscache_n_stores),
 		   atomic_read(&fscache_n_stores_ok),
 		   atomic_read(&fscache_n_stores_again),
 		   atomic_read(&fscache_n_stores_nobufs),
+		   atomic_read(&fscache_n_stores_intr),
 		   atomic_read(&fscache_n_stores_oom));
-	seq_printf(m, "Stores : ops=%u run=%u pgs=%u rxd=%u olm=%u\n",
+	seq_printf(m, "Stores : ops=%u owt=%u run=%u pgs=%u rxd=%u olm=%u abt=%u\n",
 		   atomic_read(&fscache_n_store_ops),
+		   atomic_read(&fscache_n_store_op_waits),
 		   atomic_read(&fscache_n_store_calls),
 		   atomic_read(&fscache_n_store_pages),
 		   atomic_read(&fscache_n_store_radix_deletes),
-		   atomic_read(&fscache_n_store_pages_over_limit));
+		   atomic_read(&fscache_n_store_pages_over_limit),
+		   atomic_read(&fscache_n_stores_object_dead));
 
 	seq_printf(m, "VmScan : nos=%u gon=%u bsy=%u can=%u wt=%u\n",
 		   atomic_read(&fscache_n_store_vmscan_not_storing),
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 994ec22d4040..dfc60c79a9f3 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -170,7 +170,7 @@ static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error
  */
 static void netfs_read_from_cache(struct netfs_read_request *rreq,
 				  struct netfs_read_subrequest *subreq,
-				  bool seek_data)
+				  enum netfs_read_from_hole read_hole)
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
 	struct iov_iter iter;
@@ -180,7 +180,7 @@ static void netfs_read_from_cache(struct netfs_read_request *rreq,
 			subreq->start + subreq->transferred,
 			subreq->len   - subreq->transferred);
 
-	cres->ops->read(cres, subreq->start, &iter, seek_data,
+	cres->ops->read(cres, subreq->start, &iter, read_hole,
 			netfs_cache_read_terminated, subreq);
 }
 
@@ -468,7 +468,7 @@ static void netfs_rreq_short_read(struct netfs_read_request *rreq,
 	netfs_get_read_subrequest(subreq);
 	atomic_inc(&rreq->nr_rd_ops);
 	if (subreq->source == NETFS_READ_FROM_CACHE)
-		netfs_read_from_cache(rreq, subreq, true);
+		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_CLEAR);
 	else
 		netfs_read_from_server(rreq, subreq);
 }
@@ -796,7 +796,7 @@ static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
 		netfs_read_from_server(rreq, subreq);
 		break;
 	case NETFS_READ_FROM_CACHE:
-		netfs_read_from_cache(rreq, subreq, false);
+		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_IGNORE);
 		break;
 	default:
 		BUG();
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 6754c8607230..6118cdd2e1d7 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -11,6 +11,7 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
+#define FSCACHE_USE_OLD_IO_API
 #include <linux/fscache.h>
 
 #ifdef CONFIG_NFS_FSCACHE
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 5e3ddb11715a..715fb830e982 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -24,15 +24,13 @@
 #if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
 #define fscache_available() (1)
 #define fscache_cookie_valid(cookie) (cookie)
+#define fscache_resources_valid(cres) ((cres)->cache_priv)
 #else
 #define fscache_available() (0)
 #define fscache_cookie_valid(cookie) (0)
+#define fscache_resources_valid(cres) (false)
 #endif
 
-
-/* pattern used to fill dead space in an index entry */
-#define FSCACHE_INDEX_DEADFILL_PATTERN 0x79
-
 struct pagevec;
 struct fscache_cache_tag;
 struct fscache_cookie;
@@ -199,7 +197,12 @@ extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
 #ifdef FSCACHE_USE_NEW_IO_API
 extern int __fscache_begin_operation(struct netfs_cache_resources *, struct fscache_cookie *,
 				     bool);
-#else
+#endif
+#ifdef FSCACHE_USE_FALLBACK_IO_API
+extern int __fscache_fallback_read_page(struct fscache_cookie *, struct page *);
+extern int __fscache_fallback_write_page(struct fscache_cookie *, struct page *);
+#endif
+#ifdef FSCACHE_USE_OLD_IO_API
 extern int __fscache_read_or_alloc_page(struct fscache_cookie *,
 					struct page *,
 					fscache_rw_complete_t,
@@ -223,7 +226,8 @@ extern void __fscache_uncache_all_inode_pages(struct fscache_cookie *,
 					      struct inode *);
 extern void __fscache_readpages_cancel(struct fscache_cookie *cookie,
 				       struct list_head *pages);
-#endif /* FSCACHE_USE_NEW_IO_API */
+
+#endif /* FSCACHE_USE_OLD_IO_API */
 
 extern void __fscache_disable_cookie(struct fscache_cookie *, const void *, bool);
 extern void __fscache_enable_cookie(struct fscache_cookie *, const void *, loff_t,
@@ -537,7 +541,85 @@ int fscache_begin_read_operation(struct netfs_cache_resources *cres,
 	return -ENOBUFS;
 }
 
-#else /* FSCACHE_USE_NEW_IO_API */
+/**
+ * fscache_operation_valid - Return true if operations resources are usable
+ * @cres: The resources to check.
+ *
+ * Returns a pointer to the operations table if usable or NULL if not.
+ */
+static inline
+const struct netfs_cache_ops *fscache_operation_valid(const struct netfs_cache_resources *cres)
+{
+	return fscache_resources_valid(cres) ? cres->ops : NULL;
+}
+
+/**
+ * fscache_read - Start a read from the cache.
+ * @cres: The cache resources to use
+ * @start_pos: The beginning file offset in the cache file
+ * @iter: The buffer to fill - and also the length
+ * @read_hole: How to handle a hole in the data.
+ * @term_func: The function to call upon completion
+ * @term_func_priv: The private data for @term_func
+ *
+ * Start a read from the cache.  @cres indicates the cache object to read from
+ * and must be obtained by a call to fscache_begin_operation() beforehand.
+ *
+ * The data is read into the iterator, @iter, and that also indicates the size
+ * of the operation.  @start_pos is the start position in the file, though if
+ * @seek_data is set appropriately, the cache can use SEEK_DATA to find the
+ * next piece of data, writing zeros for the hole into the iterator.
+ *
+ * Upon termination of the operation, @term_func will be called and supplied
+ * with @term_func_priv plus the amount of data written, if successful, or the
+ * error code otherwise.
+ */
+static inline
+int fscache_read(struct netfs_cache_resources *cres,
+		 loff_t start_pos,
+		 struct iov_iter *iter,
+		 enum netfs_read_from_hole read_hole,
+		 netfs_io_terminated_t term_func,
+		 void *term_func_priv)
+{
+	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	return ops->read(cres, start_pos, iter, read_hole,
+			 term_func, term_func_priv);
+}
+
+/**
+ * fscache_write - Start a write to the cache.
+ * @cres: The cache resources to use
+ * @start_pos: The beginning file offset in the cache file
+ * @iter: The data to write - and also the length
+ * @term_func: The function to call upon completion
+ * @term_func_priv: The private data for @term_func
+ *
+ * Start a write to the cache.  @cres indicates the cache object to write to and
+ * must be obtained by a call to fscache_begin_operation() beforehand.
+ *
+ * The data to be written is obtained from the iterator, @iter, and that also
+ * indicates the size of the operation.  @start_pos is the start position in
+ * the file.
+ *
+ * Upon termination of the operation, @term_func will be called and supplied
+ * with @term_func_priv plus the amount of data written, if successful, or the
+ * error code otherwise.
+ */
+static inline
+int fscache_write(struct netfs_cache_resources *cres,
+		  loff_t start_pos,
+		  struct iov_iter *iter,
+		  netfs_io_terminated_t term_func,
+		  void *term_func_priv)
+{
+	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	return ops->write(cres, start_pos, iter, term_func, term_func_priv);
+}
+
+#endif /* FSCACHE_USE_NEW_IO_API */
+
+#ifdef FSCACHE_USE_OLD_IO_API
 
 /**
  * fscache_read_or_alloc_page - Read a page from the cache or allocate a block
@@ -818,7 +900,7 @@ void fscache_uncache_all_inode_pages(struct fscache_cookie *cookie,
 		__fscache_uncache_all_inode_pages(cookie, inode);
 }
 
-#endif /* FSCACHE_USE_NEW_IO_API */
+#endif /* FSCACHE_USE_OLD_IO_API */
 
 /**
  * fscache_disable_cookie - Disable a cookie
@@ -874,4 +956,48 @@ void fscache_enable_cookie(struct fscache_cookie *cookie,
 					can_enable, data);
 }
 
+#ifdef FSCACHE_USE_FALLBACK_IO_API
+
+/**
+ * fscache_fallback_read_page - Read a page from a cache object (DANGEROUS)
+ * @cookie: The cookie representing the cache object
+ * @page: The page to be read to
+ *
+ * Synchronously read a page from the cache.  The page's offset is used to
+ * indicate where to read.
+ *
+ * This is dangerous and should be moved away from as it relies on the
+ * assumption that the backing filesystem will exactly record the blocks we
+ * have stored there.
+ */
+static inline
+int fscache_fallback_read_page(struct fscache_cookie *cookie, struct page *page)
+{
+	if (fscache_cookie_enabled(cookie))
+		return __fscache_fallback_read_page(cookie, page);
+	return -ENOBUFS;
+}
+
+/**
+ * fscache_fallback_write_page - Write a page to a cache object (DANGEROUS)
+ * @cookie: The cookie representing the cache object
+ * @page: The page to be written from
+ *
+ * Synchronously write a page to the cache.  The page's offset is used to
+ * indicate where to write.
+ *
+ * This is dangerous and should be moved away from as it relies on the
+ * assumption that the backing filesystem will exactly record the blocks we
+ * have stored there.
+ */
+static inline
+int fscache_fallback_write_page(struct fscache_cookie *cookie, struct page *page)
+{
+	if (fscache_cookie_enabled(cookie))
+		return __fscache_fallback_write_page(cookie, page);
+	return -ENOBUFS;
+}
+
+#endif /* FSCACHE_USE_FALLBACK_IO_API */
+
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5d6a4158a9a6..014fb502fd91 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -174,6 +174,15 @@ struct netfs_read_request_ops {
 	void (*cleanup)(struct address_space *mapping, void *netfs_priv);
 };
 
+/*
+ * How to handle reading from a hole.
+ */
+enum netfs_read_from_hole {
+	NETFS_READ_HOLE_IGNORE,
+	NETFS_READ_HOLE_CLEAR,
+	NETFS_READ_HOLE_FAIL,
+};
+
 /*
  * Table of operations for access to a cache.  This is obtained by
  * rreq->ops->begin_cache_operation().
@@ -186,7 +195,7 @@ struct netfs_cache_ops {
 	int (*read)(struct netfs_cache_resources *cres,
 		    loff_t start_pos,
 		    struct iov_iter *iter,
-		    bool seek_data,
+		    enum netfs_read_from_hole read_hole,
 		    netfs_io_terminated_t term_func,
 		    void *term_func_priv);
 
@@ -212,6 +221,12 @@ struct netfs_cache_ops {
 	 */
 	int (*prepare_write)(struct netfs_cache_resources *cres,
 			     loff_t *_start, size_t *_len, loff_t i_size);
+
+	/* Prepare a write operation for the fallback fscache API, working out
+	 * whether we can cache a page or not.
+	 */
+	int (*prepare_fallback_write)(struct netfs_cache_resources *cres,
+				      pgoff_t index);
 };
 
 struct readahead_control;


