Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CFB46187D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378340AbhK2Obz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378371AbhK2O3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638195980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjUrIs2U+Q2LvWEFrPsClamAUXKZ1g9qzCJubTcSZOo=;
        b=CJov4lAmzMzpdNhk4WJcmjDZjGgHAObtGtX2ja08sH7x8vjsY7uQMZYkv6UPbsEs5i1GDD
        tKrHN5JMIa2ju05Lm3ewfczni2nbKtK/UcMaWftLzK4AGw4+xi5DA/cJzo/7J7aVLfnqDd
        NYLhxbN6Zs+zsJpBgB3cpLbJ4tofvMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-24-hzcwGNJDNje9ziXKR0UctA-1; Mon, 29 Nov 2021 09:26:15 -0500
X-MC-Unique: hzcwGNJDNje9ziXKR0UctA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0254B344B8;
        Mon, 29 Nov 2021 14:26:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1644A5D6D7;
        Mon, 29 Nov 2021 14:26:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/64] fscache: Implement functions add/remove a cache
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 14:26:00 +0000
Message-ID: <163819596022.215744.8799712491432238827.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement functions to allow the cache backend to add or remove a cache:

 (1) Declare a cache to be live:

	int fscache_add_cache(struct fscache_cache *cache,
			      const struct fscache_cache_ops *ops,
			      void *cache_priv);

     Take a previously acquired cache cookie, set the operations table and
     private data and mark the cache open for access.

 (2) Withdraw a cache from service:

	void fscache_withdraw_cache(struct fscache_cache *cache);

     This marks the cache as withdrawn and thus prevents further
     cache-level and volume-level accesses.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/fscache/cache.c            |   70 +++++++++++++++++++++++++++++++++++++++++
 include/linux/fscache-cache.h |   13 ++++++++
 2 files changed, 83 insertions(+)

diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index e867cff53a70..bbd102be91c4 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -210,12 +210,55 @@ void fscache_relinquish_cache(struct fscache_cache *cache)
 		fscache_cache_put_prep_failed :
 		fscache_cache_put_relinquish;
 
+	cache->ops = NULL;
 	cache->cache_priv = NULL;
 	smp_store_release(&cache->state, FSCACHE_CACHE_IS_NOT_PRESENT);
 	fscache_put_cache(cache, where);
 }
 EXPORT_SYMBOL(fscache_relinquish_cache);
 
+/**
+ * fscache_add_cache - Declare a cache as being open for business
+ * @cache: The cache-level cookie representing the cache
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
 /**
  * fscache_begin_cache_access - Pin a cache so it can be accessed
  * @cache: The cache-level cookie
@@ -278,6 +321,33 @@ void fscache_end_cache_access(struct fscache_cache *cache, enum fscache_access_t
 		wake_up_var(&cache->n_accesses);
 }
 
+/**
+ * fscache_withdraw_cache - Withdraw a cache from the active service
+ * @cache: The cache cookie
+ *
+ * Begin the process of withdrawing a cache from service.  This stops new
+ * cache-level and volume-level accesses from taking place and waits for
+ * currently ongoing cache-level accesses to end.
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
index 66624407ba84..f78add6e7823 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -33,6 +33,7 @@ enum fscache_cache_state {
  * Cache cookie.
  */
 struct fscache_cache {
+	const struct fscache_cache_ops *ops;
 	struct list_head	cache_link;	/* Link in cache list */
 	void			*cache_priv;	/* Private cache data (or NULL) */
 	refcount_t		ref;
@@ -44,6 +45,14 @@ struct fscache_cache {
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
 extern struct workqueue_struct *fscache_wq;
 
 /*
@@ -52,6 +61,10 @@ extern struct workqueue_struct *fscache_wq;
 extern struct rw_semaphore fscache_addremove_sem;
 extern struct fscache_cache *fscache_acquire_cache(const char *name);
 extern void fscache_relinquish_cache(struct fscache_cache *cache);
+extern int fscache_add_cache(struct fscache_cache *cache,
+			     const struct fscache_cache_ops *ops,
+			     void *cache_priv);
+extern void fscache_withdraw_cache(struct fscache_cache *cache);
 
 extern void fscache_end_volume_access(struct fscache_volume *volume,
 				      struct fscache_cookie *cookie,


