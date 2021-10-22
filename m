Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE704437D4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhJVTFW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234053AbhJVTFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zpilihmq9mmJdgp9tFupDChI2+z+t3jt4NzTH8TzhgE=;
        b=Adaqi1Fm87e0X+IYYztKgchrCM0xFrcflZHEkxrbQyWt4hDQ1/d+JLVyhRk3LRDvjfhSS+
        CuBata44Zz04llDw03BwGOFOSpRFxWqisW+IjQXJbuyqQrKfSDiCllZcPx200KeN+BdbKA
        /sB3b4wnKkmBk+0lGaOMMK57RH8Zq6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-Ihv4W8dkPjK2czJm8jp1Qg-1; Fri, 22 Oct 2021 15:02:53 -0400
X-MC-Unique: Ihv4W8dkPjK2czJm8jp1Qg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5AF1801FCE;
        Fri, 22 Oct 2021 19:02:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4C1119D9B;
        Fri, 22 Oct 2021 19:02:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 15/53] fscache: Implement functions add/remove a cache
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Oct 2021 20:02:43 +0100
Message-ID: <163492936300.1038219.11883870846619314835.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement functions to allow the cache backend to add or remove a cache.

Signed-off-by: David Howells <dhowells@redhat.com>cc: linux-cachefs@redhat.com
---

 fs/fscache/cache.c             |   67 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fscache-cache.h  |   14 ++++++++
 include/trace/events/fscache.h |    6 +++-
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index 3cde698c5015..bed491c99834 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -171,6 +171,48 @@ void fscache_put_cache(struct fscache_cache *cache,
 }
 EXPORT_SYMBOL(fscache_put_cache);
 
+/**
+ * fscache_add_cache - Declare a cache as being open for business
+ * @cache: The record describing the cache
+ * @ops: Table of cache operations to use
+ * @cache_priv: Private data for the cache record
+ *
+ * Add a cache to the system, making it available for netfs's to use.
+ *
+ * See Documentation/filesystems/caching/backend-api.rst for a complete
+ * description.
+ */
+int fscache_add_cache(struct fscache_cache *cache,
+		      const struct fscache_cache_ops *ops,
+		      void *cache_priv)
+{
+	int n_accesses;
+
+	_enter("{%s,%s}", ops->name, cache->name);
+
+	BUG_ON(fscache_cache_state(cache) != FSCACHE_CACHE_IS_PREPARING);
+
+	/* Get a ref on the cache cookie and keep its n_accesses counter raised
+	 * by 1 to prevent wakeups from transitioning it to 0 until we're
+	 * withdrawing caching services from it.
+	 */
+	n_accesses = atomic_inc_return(&cache->n_accesses);
+	trace_fscache_access_cache(cache->debug_id, refcount_read(&cache->ref),
+				   n_accesses, fscache_access_cache_pin);
+
+	down_write(&fscache_addremove_sem);
+
+	cache->ops = ops;
+	cache->cache_priv = cache_priv;
+	fscache_set_cache_state(cache, FSCACHE_CACHE_IS_ACTIVE);
+
+	up_write(&fscache_addremove_sem);
+	pr_notice("Cache \"%s\" added (type %s)\n", cache->name, ops->name);
+	_leave(" = 0 [%s]", cache->name);
+	return 0;
+}
+EXPORT_SYMBOL(fscache_add_cache);
+
 /*
  * Get an increment on a cache's access counter if the cache is live to prevent
  * it from going away whilst we're accessing it.
@@ -208,6 +250,31 @@ void fscache_end_cache_access(struct fscache_cache *cache, enum fscache_access_t
 		wake_up_var(&cache->n_accesses);
 }
 
+/**
+ * fscache_withdraw_cache - Withdraw a cache from the active service
+ * @cache: The cache cookie
+ *
+ * Begin the process of withdrawing a cache from service.
+ */
+void fscache_withdraw_cache(struct fscache_cache *cache)
+{
+	int n_accesses;
+
+	pr_notice("Withdrawing cache \"%s\" (%u objs)\n",
+		  cache->name, atomic_read(&cache->object_count));
+
+	fscache_set_cache_state(cache, FSCACHE_CACHE_IS_WITHDRAWN);
+
+	/* Allow wakeups on dec-to-0 */
+	n_accesses = atomic_dec_return(&cache->n_accesses);
+	trace_fscache_access_cache(cache->debug_id, refcount_read(&cache->ref),
+				   n_accesses, fscache_access_cache_unpin);
+
+	wait_var_event(&cache->n_accesses,
+		       atomic_read(&cache->n_accesses) == 0);
+}
+EXPORT_SYMBOL(fscache_withdraw_cache);
+
 #ifdef CONFIG_PROC_FS
 static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
 
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index a10f87421438..d2301ec88ff9 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -17,6 +17,7 @@
 #include <linux/fscache.h>
 
 struct fscache_cache;
+struct fscache_cache_ops;
 enum fscache_cache_trace;
 enum fscache_cookie_trace;
 enum fscache_access_trace;
@@ -34,6 +35,7 @@ enum fscache_cache_state {
  * Cache cookie.
  */
 struct fscache_cache {
+	const struct fscache_cache_ops *ops;
 	struct list_head	cache_link;	/* Link in cache list */
 	void			*cache_priv;	/* Private cache data (or NULL) */
 	refcount_t		ref;
@@ -45,6 +47,14 @@ struct fscache_cache {
 	char			*name;
 };
 
+/*
+ * cache operations
+ */
+struct fscache_cache_ops {
+	/* name of cache provider */
+	const char *name;
+};
+
 static inline enum fscache_cache_state fscache_cache_state(const struct fscache_cache *cache)
 {
 	return smp_load_acquire(&cache->state);
@@ -74,8 +84,12 @@ static inline bool fscache_set_cache_state_maybe(struct fscache_cache *cache,
  */
 extern struct rw_semaphore fscache_addremove_sem;
 extern struct fscache_cache *fscache_acquire_cache(const char *name);
+extern int fscache_add_cache(struct fscache_cache *cache,
+			     const struct fscache_cache_ops *ops,
+			     void *cache_priv);
 extern void fscache_put_cache(struct fscache_cache *cache,
 			      enum fscache_cache_trace where);
+extern void fscache_withdraw_cache(struct fscache_cache *cache);
 
 extern void fscache_end_volume_access(struct fscache_volume *volume,
 				      enum fscache_access_trace why);
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 132381921be9..c256f30d4dd4 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -24,7 +24,9 @@ enum fscache_cache_trace {
 	fscache_cache_get_acquire,
 	fscache_cache_new_acquire,
 	fscache_cache_put_alloc_volume,
+	fscache_cache_put_cache,
 	fscache_cache_put_volume,
+	fscache_cache_put_withdraw,
 };
 
 enum fscache_volume_trace {
@@ -76,7 +78,9 @@ enum fscache_access_trace {
 	EM(fscache_cache_get_acquire,		"GET acq  ")		\
 	EM(fscache_cache_new_acquire,		"NEW acq  ")		\
 	EM(fscache_cache_put_alloc_volume,	"PUT alvol")		\
-	E_(fscache_cache_put_volume,		"PUT vol  ")
+	EM(fscache_cache_put_cache,		"PUT cache")		\
+	EM(fscache_cache_put_volume,		"PUT vol  ")		\
+	E_(fscache_cache_put_withdraw,		"PUT withd")
 
 #define fscache_volume_traces						\
 	EM(fscache_volume_collision,		"*COLLIDE*")		\


