Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B3440AFCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 15:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhINN4h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 09:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233580AbhINN4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 09:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631627712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VG7MlYzVJkkqQdC7UXghMrjRp4ZzyHrS4GwZg0MkjU4=;
        b=TTYOj5HqNDCYftwYSZQ12SygFY2Kv8orgKhFbDirvQIyB4xoYSdZV8eYggsSySKAOVEWnx
        PMHauwl/TBbv9I/xCSZTxlqdx+3oKVYaKMt1aK/CikF6jqLNibf3pdivHg3VBopjvJ3rDn
        qwDAMzwNJLYcfzWcpyU6WL6OEmWhUhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-jFZJDpCMNGKIeaYWHGpdcA-1; Tue, 14 Sep 2021 09:55:11 -0400
X-MC-Unique: jFZJDpCMNGKIeaYWHGpdcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2B8A362F9;
        Tue, 14 Sep 2021 13:55:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A4F1100164A;
        Tue, 14 Sep 2021 13:55:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/8] fscache: Implement an alternate I/O interface to replace
 the old API
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-cachefs@redhat.com, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Sep 2021 14:55:01 +0100
Message-ID: <163162770137.438332.13788466444753625553.stgit@warthog.procyon.org.uk>
In-Reply-To: <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
References: <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement an alternative to using the netfslib-base I/O API so that we can
move forwards on getting rid of the old API.  Note that this API is
deprecated as it still uses the backing filesystem to track unfilled holes
in the backing file, though using SEEK_DATA/SEEK_HOLE rather than bmap().

This is dangerous and can lead to corrupted data as the backing filesystem
cannot be relied on not to fill in holes with blocks of zeros in order to
optimise an extent list[1].  It may also punch out blocks of zeros to
create holes for the same reason, but this is less of a problem.

Also adjust the macros that must be defined to indicate which API is to be
used:

 (*) FSCACHE_USE_OLD_IO_API - Use the current upstream API.  This will be
     deleted.

 (*) FSCACHE_USE_DEPRECATED_IO_API - Use the API added here.

 (*) FSCACHE_USE_NEW_IO_API - Use the new API or netfs API.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/YO17ZNOcq+9PajfQ@mit.edu [1]
---

 fs/9p/cache.h           |    1 
 fs/cachefiles/io.c      |   28 ++++++++-
 fs/cifs/fscache.h       |    1 
 fs/fscache/internal.h   |    3 +
 fs/fscache/io.c         |  140 +++++++++++++++++++++++++++++++++++++++++------
 fs/fscache/page.c       |    1 
 fs/fscache/stats.c      |   12 +++-
 fs/nfs/fscache.h        |    1 
 include/linux/fscache.h |  118 +++++++++++++++++++++++++++++++++++++---
 include/linux/netfs.h   |   17 +++++-
 10 files changed, 289 insertions(+), 33 deletions(-)

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
index 08b3183e0dce..1459ff6ef6c6 100644
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
@@ -345,6 +348,24 @@ static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
 	return 0;
 }
 
+/*
+ * Prepare for a write to occur from the fallback I/O API.
+ */
+static int cachefiles_prepare_write_deprecated(struct netfs_cache_resources *cres,
+					       pgoff_t index)
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
@@ -371,6 +392,7 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.write			= cachefiles_write,
 	.prepare_read		= cachefiles_prepare_read,
 	.prepare_write		= cachefiles_prepare_write,
+	.prepare_write_deprecated = cachefiles_prepare_write_deprecated,
 };
 
 /*
diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index 82e856b9cf89..cfea3cf5d2af 100644
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
index 3745a0631618..e4e5d07bb8d8 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -9,6 +9,8 @@
 #include <linux/module.h>
 #define FSCACHE_USE_NEW_IO_API
 #include <linux/fscache-cache.h>
+#include <linux/uio.h>
+#include <linux/bvec.h>
 #include <linux/slab.h>
 #include <linux/netfs.h>
 #include "internal.h"
@@ -35,7 +37,10 @@ int __fscache_begin_operation(struct netfs_cache_resources *cres,
 
 	_enter("c=%08x", cres->debug_id);
 
-	fscache_stat(&fscache_n_retrievals);
+	if (for_write)
+		fscache_stat(&fscache_n_stores);
+	else
+		fscache_stat(&fscache_n_retrievals);
 
 	if (hlist_empty(&cookie->backing_objects))
 		goto nobufs;
@@ -77,14 +82,23 @@ int __fscache_begin_operation(struct netfs_cache_resources *cres,
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
 
@@ -92,16 +106,27 @@ int __fscache_begin_operation(struct netfs_cache_resources *cres,
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
@@ -116,8 +141,87 @@ int __fscache_begin_operation(struct netfs_cache_resources *cres,
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
+ * Deprecated page reading interface.
+ */
+int __fscache_deprecated_read_page(struct fscache_cookie *cookie, struct page *page)
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
+EXPORT_SYMBOL(__fscache_deprecated_read_page);
+
+/*
+ * Deprecated page writing interface.
+ */
+int __fscache_deprecated_write_page(struct fscache_cookie *cookie, struct page *page)
+{
+	struct netfs_cache_resources cres;
+	struct iov_iter iter;
+	struct bio_vec bvec[1];
+	loff_t start;
+	size_t len;
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
+	start = page_offset(page);
+	len = PAGE_SIZE;
+	ret = cres.ops->prepare_write_deprecated(&cres, page_index(page));
+	if (ret < 0)
+		goto out;
+
+	ret = fscache_write(&cres, page_offset(page), &iter, NULL, NULL);
+out:
+	fscache_end_operation(&cres);
+	_leave(" = %d", ret);
+	return ret;
+}
+EXPORT_SYMBOL(__fscache_deprecated_write_page);
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
index 32f65c16328a..866afbd2ce6f 100644
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
@@ -198,7 +196,12 @@ extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
 #ifdef FSCACHE_USE_NEW_IO_API
 extern int __fscache_begin_operation(struct netfs_cache_resources *, struct fscache_cookie *,
 				     bool);
-#else
+#endif
+#ifdef FSCACHE_USE_DEPRECATED_IO_API
+extern int __fscache_deprecated_read_page(struct fscache_cookie *, struct page *);
+extern int __fscache_deprecated_write_page(struct fscache_cookie *, struct page *);
+#endif
+#ifdef FSCACHE_USE_OLD_IO_API
 extern int __fscache_read_or_alloc_page(struct fscache_cookie *,
 					struct page *,
 					fscache_rw_complete_t,
@@ -222,7 +225,8 @@ extern void __fscache_uncache_all_inode_pages(struct fscache_cookie *,
 					      struct inode *);
 extern void __fscache_readpages_cancel(struct fscache_cookie *cookie,
 				       struct list_head *pages);
-#endif /* FSCACHE_USE_NEW_IO_API */
+
+#endif /* FSCACHE_USE_OLD_IO_API */
 
 extern void __fscache_disable_cookie(struct fscache_cookie *, const void *, bool);
 extern void __fscache_enable_cookie(struct fscache_cookie *, const void *, loff_t,
@@ -536,7 +540,85 @@ int fscache_begin_read_operation(struct netfs_cache_resources *cres,
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
@@ -817,7 +899,7 @@ void fscache_uncache_all_inode_pages(struct fscache_cookie *cookie,
 		__fscache_uncache_all_inode_pages(cookie, inode);
 }
 
-#endif /* FSCACHE_USE_NEW_IO_API */
+#endif /* FSCACHE_USE_OLD_IO_API */
 
 /**
  * fscache_disable_cookie - Disable a cookie
@@ -873,4 +955,24 @@ void fscache_enable_cookie(struct fscache_cookie *cookie,
 					can_enable, data);
 }
 
+#ifdef FSCACHE_USE_DEPRECATED_IO_API
+
+static inline
+int fscache_deprecated_read_page(struct fscache_cookie *cookie, struct page *page)
+{
+	if (fscache_cookie_enabled(cookie))
+		return __fscache_deprecated_read_page(cookie, page);
+	return -ENOBUFS;
+}
+
+static inline
+int fscache_deprecated_write_page(struct fscache_cookie *cookie, struct page *page)
+{
+	if (fscache_cookie_enabled(cookie))
+		return __fscache_deprecated_write_page(cookie, page);
+	return -ENOBUFS;
+}
+
+#endif /* FSCACHE_USE_DEPRECATED_IO_API */
+
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5d6a4158a9a6..da83b99ecf7c 100644
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
+	int (*prepare_write_deprecated)(struct netfs_cache_resources *cres,
+					pgoff_t index);
 };
 
 struct readahead_control;


