Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5714D432193
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhJRPFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233658AbhJRPDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AiokSUHP63IAgtyhFtYg1E8iTK1oEkZZd/Ii+eTDS9s=;
        b=RGuBT9o95BM7j1RNKnDHg4EhqswqB1NcnpwJtGaizQDSBQ6Gw4UX108Kbwqvew22z2wuRJ
        I5IZB8KUwIgK5RApG0gsKcSE7diXlJ3v6kWtmJU4izpRO9H9J8mEMT4X4nYUqYXW4MA2RP
        pXcCaJTSnTIE3qjQmmIY1tKDZm0WMWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-16xKwpWINGSbwVakiWdDLA-1; Mon, 18 Oct 2021 11:01:21 -0400
X-MC-Unique: 16xKwpWINGSbwVakiWdDLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92B4C100CCC3;
        Mon, 18 Oct 2021 15:01:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59B1A60BF4;
        Mon, 18 Oct 2021 15:01:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 43/67] fscache: Rewrite invalidation
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 16:01:15 +0100
Message-ID: <163456927548.2614702.9118810769340245220.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rewrite the fscache_invalidate() function.  The following changes are made
to fscache:

 (1) Invalidation is now ignored or allowed to proceed depending on the
     'stage' a non-index cookie is in with respect to the backing object.

 (2) If invalidation is proceeds, it pins the object and holds a cookie
     access count for the duration to prevent the cache from going away.

 (3) The fscache_object struct is given an invalidation counter that is
     incremented every time fscache_invalidate() is called, even if the
     cookie is at a stage in which it cannot be applied.  The counter,
     however, can be noted and applied retroactively later.

 (4) The invalidation counter is noted in the operation struct when a cache
     operation is begun and can be checked on operation completion to find
     out if any consequent metadata changes should be dropped.

 (5) New operations aren't allowed to proceed if the object is being
     invalidated.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c                 |    4 +---
 fs/afs/internal.h              |    9 +++++++++
 fs/cachefiles/interface.c      |    3 +--
 fs/cachefiles/io.c             |    4 ++--
 fs/fscache/cookie.c            |   14 +++++++-------
 fs/fscache/io.c                |    1 +
 include/linux/fscache-cache.h  |    3 +--
 include/linux/fscache.h        |   16 ++++++++++++----
 include/linux/netfs.h          |    1 +
 include/trace/events/fscache.h |   19 +++++++++++++++++++
 10 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 842570e4470f..32038ccbce67 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -564,9 +564,7 @@ static void afs_zap_data(struct afs_vnode *vnode)
 {
 	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
-#ifdef CONFIG_AFS_FSCACHE
-	fscache_invalidate(vnode->cache, i_size_read(&vnode->vfs_inode));
-#endif
+	afs_invalidate_cache(vnode, 0);
 
 	/* nuke all the non-dirty pages that aren't locked, mapped or being
 	 * written back in a regular file and completely discard the pages in a
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 3180ba6bd46d..6c591b7c55f1 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -878,6 +878,15 @@ static inline void afs_set_cache_aux(struct afs_vnode *vnode,
 	aux->data_version = cpu_to_be64(vnode->status.data_version);
 }
 
+static inline void afs_invalidate_cache(struct afs_vnode *vnode, unsigned int flags)
+{
+	struct afs_vnode_cache_aux aux;
+
+	afs_set_cache_aux(vnode, &aux);
+	fscache_invalidate(afs_vnode_cache(vnode), &aux,
+			   i_size_read(&vnode->vfs_inode), flags);
+}
+
 /*
  * We use page->private to hold the amount of the page that we've written to,
  * splitting the field into two parts.  However, we need to represent a range
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index a114b59e5b29..96a703d5f62c 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -376,8 +376,7 @@ static int cachefiles_attr_changed(struct cachefiles_object *object)
 /*
  * Invalidate the storage associated with a cookie.
  */
-static bool cachefiles_invalidate_cookie(struct fscache_cookie *cookie,
-					 unsigned int flags)
+static bool cachefiles_invalidate_cookie(struct fscache_cookie *cookie)
 {
 	struct cachefiles_object *object = cookie->cache_priv;
 	struct file *new_file, *old_file;
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 350243b45dd5..67ea9f44931f 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -134,7 +134,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	ki->iocb.ki_ioprio	= get_current_ioprio();
 	ki->skipped		= skipped;
 	ki->object		= object;
-	ki->inval_counter	= object->cookie->inval_counter;
+	ki->inval_counter	= cres->inval_counter;
 	ki->term_func		= term_func;
 	ki->term_func_priv	= term_func_priv;
 	ki->was_async		= true;
@@ -239,7 +239,7 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
 	ki->iocb.ki_ioprio	= get_current_ioprio();
 	ki->object		= object;
-	ki->inval_counter	= object->cookie->inval_counter;
+	ki->inval_counter	= cres->inval_counter;
 	ki->start		= start_pos;
 	ki->len			= len;
 	ki->term_func		= term_func;
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 6b49c2321256..8731188a5ac7 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -694,17 +694,16 @@ static void fscache_cookie_drop_from_lru(struct fscache_cookie *cookie)
  */
 static void fscache_invalidate_cookie(struct fscache_cookie *cookie)
 {
-	if (cookie->volume->cache->ops->invalidate_cookie(cookie, 0))
-		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_ACTIVE);
-	else
-		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_FAILED);
+	cookie->volume->cache->ops->invalidate_cookie(cookie);
 	fscache_end_cookie_access(cookie, fscache_access_invalidate_cookie_end);
 }
 
 /*
- * Invalidate an object.  Callable with spinlocks held.
+ * Invalidate an object.
  */
-void __fscache_invalidate(struct fscache_cookie *cookie, loff_t new_size)
+void __fscache_invalidate(struct fscache_cookie *cookie,
+			  const void *aux_data, loff_t new_size,
+			  unsigned int flags)
 {
 	bool is_caching;
 
@@ -718,8 +717,9 @@ void __fscache_invalidate(struct fscache_cookie *cookie, loff_t new_size)
 
 	spin_lock(&cookie->lock);
 	set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
-	cookie->object_size = new_size;
+	fscache_update_aux(cookie, aux_data, &new_size);
 	cookie->inval_counter++;
+	trace_fscache_invalidate(cookie, new_size);
 
 	switch (cookie->stage) {
 	case FSCACHE_COOKIE_STAGE_INVALIDATING: /* is_still_valid will catch it */
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 25976413fe34..ad9798f0c850 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -81,6 +81,7 @@ static int fscache_begin_operation(struct netfs_cache_resources *cres,
 	cres->cache_priv	= cookie;
 	cres->cache_priv2	= NULL;
 	cres->debug_id		= cookie->debug_id;
+	cres->inval_counter	= cookie->inval_counter;
 
 	if (!fscache_begin_cookie_access(cookie, why))
 		return -ENOBUFS;
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index bf0d3e862915..22064611d182 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -67,8 +67,7 @@ struct fscache_cache_ops {
 	void (*withdraw_cookie)(struct fscache_cookie *cookie);
 
 	/* Invalidate an object */
-	bool (*invalidate_cookie)(struct fscache_cookie *cookie,
-				  unsigned int flags);
+	bool (*invalidate_cookie)(struct fscache_cookie *cookie);
 
 	/* Begin an operation for the netfs lib */
 	bool (*begin_operation)(struct netfs_cache_resources *cres,
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index abf5413c3151..a29bd81996ea 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -159,7 +159,7 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
 extern void __fscache_use_cookie(struct fscache_cookie *, bool);
 extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
-extern void __fscache_invalidate(struct fscache_cookie *, loff_t);
+extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t, unsigned int);
 #ifdef FSCACHE_USE_NEW_IO_API
 extern int __fscache_begin_read_operation(struct netfs_cache_resources *, struct fscache_cookie *);
 #endif
@@ -388,22 +388,30 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
 /**
  * fscache_invalidate - Notify cache that an object needs invalidation
  * @cookie: The cookie representing the cache object
+ * @aux_data: The updated auxiliary data for the cookie (may be NULL)
  * @size: The revised size of the object.
+ * @flags: Invalidation flags (FSCACHE_INVAL_*)
  *
  * Notify the cache that an object is needs to be invalidated and that it
  * should abort any retrievals or stores it is doing on the cache.  The object
  * is then marked non-caching until such time as the invalidation is complete.
  *
- * This can be called with spinlocks held.
+ * FSCACHE_INVAL_LIGHT indicates that if the object has been invalidated and
+ * replaced by a temporary object, the temporary object need not be replaced
+ * again.  This is primarily intended for use with FSCACHE_ADV_SINGLE_CHUNK.
+ *
+ * FSCACHE_INVAL_DIO_WRITE indicates that this is due to a direct I/O write and
+ * may cause caching to be suspended on this cookie.
  *
  * See Documentation/filesystems/caching/netfs-api.rst for a complete
  * description.
  */
 static inline
-void fscache_invalidate(struct fscache_cookie *cookie, loff_t size)
+void fscache_invalidate(struct fscache_cookie *cookie,
+			const void *aux_data, loff_t size, unsigned int flags)
 {
 	if (fscache_cookie_valid(cookie))
-		__fscache_invalidate(cookie, size);
+		__fscache_invalidate(cookie, aux_data, size, flags);
 }
 
 /**
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 99137486d351..3c70eef56599 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -103,6 +103,7 @@ struct netfs_cache_resources {
 	void				*cache_priv;
 	void				*cache_priv2;
 	unsigned int			debug_id;	/* Cookie debug ID */
+	unsigned int			inval_counter;	/* object->inval_counter at begin_op */
 };
 
 /*
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 50f28a2a4ca8..adde3bb61f0f 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -410,6 +410,25 @@ TRACE_EVENT(fscache_relinquish,
 		      __entry->n_active, __entry->flags, __entry->retire)
 	    );
 
+TRACE_EVENT(fscache_invalidate,
+	    TP_PROTO(struct fscache_cookie *cookie, loff_t new_size),
+
+	    TP_ARGS(cookie, new_size),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(loff_t,			new_size	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie	= cookie->debug_id;
+		    __entry->new_size	= new_size;
+			   ),
+
+	    TP_printk("c=%08x sz=%llx",
+		      __entry->cookie, __entry->new_size)
+	    );
+
 #endif /* _TRACE_FSCACHE_H */
 
 /* This part must be outside protection */


