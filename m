Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89C2BAE3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgKTPOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:14:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728727AbgKTPOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NV690iUMEnxK+4gUww+IKcSHW1+hyouq6s5YjtFQLMA=;
        b=EjFyIiiCDj6V2r7fb67THOY2VKryBoz99G28/0D1c4xUIXJLUqS9byFXubBS0tOfdP6RyZ
        wQcZ8qcXZNN2HnAOfNMLXhsRHp9aQi+g2v12GhQg5Z2O7qSqbiYpX0YeMX2osrVVhQaztD
        iBhqEpyl6WgYnHvO5Rv2rM8x40gVt70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-jRPao_cVPEi0xV4NPdlp3g-1; Fri, 20 Nov 2020 10:14:16 -0500
X-MC-Unique: jRPao_cVPEi0xV4NPdlp3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4C5E1005D5A;
        Fri, 20 Nov 2020 15:14:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F5EF60BD8;
        Fri, 20 Nov 2020 15:14:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 54/76] fscache: Provide resize operation
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:14:07 +0000
Message-ID: <160588524777.3465195.17942558956161670737.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a cache operation to resize an object.  This is intended to be run
synchronously rather than being deferred as it really needs to run inside
the inode lock on the netfs inode from ->setattr() to correctly order with
respect to other truncates and writes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c      |   31 +++++++++++++++++++++++++++++++
 fs/fscache/internal.h          |    3 +++
 fs/fscache/io.c                |   28 ++++++++++++++++++++++++++++
 fs/fscache/stats.c             |    9 +++++++--
 include/linux/fscache-cache.h  |    2 ++
 include/linux/fscache.h        |   18 ++++++++++++++++++
 include/trace/events/fscache.h |   26 ++++++++++++++++++++++++++
 7 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 56ae8d956174..aca08e4227b9 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -249,6 +249,36 @@ static bool cachefiles_shorten_object(struct cachefiles_object *object, loff_t n
 	return true;
 }
 
+/*
+ * Resize the backing object.
+ */
+static void cachefiles_resize_object(struct fscache_object *_object, loff_t new_size)
+{
+	struct cachefiles_object *object =
+		container_of(_object, struct cachefiles_object, fscache);
+	struct cachefiles_cache *cache =
+		container_of(object->fscache.cache, struct cachefiles_cache, cache);
+	const struct cred *saved_cred;
+	loff_t old_size = object->fscache.cookie->object_size;
+
+	_enter("%llu->%llu", old_size, new_size);
+
+	if (new_size < old_size) {
+		cachefiles_begin_secure(cache, &saved_cred);
+		cachefiles_shorten_content_map(object, new_size);
+		cachefiles_shorten_object(object, new_size);
+		cachefiles_end_secure(cache, saved_cred);
+		object->fscache.cookie->object_size = new_size;
+		return;
+	}
+
+	/* The file is being expanded.  We don't need to do anything
+	 * particularly.  cookie->initial_size doesn't change and so the point
+	 * at which we have to download before doesn't change.
+	 */
+	object->fscache.cookie->object_size = new_size;
+}
+
 /*
  * Trim excess stored data off of an object.
  */
@@ -652,6 +682,7 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.free_lookup_data	= cachefiles_free_lookup_data,
 	.grab_object		= cachefiles_grab_object,
 	.update_object		= cachefiles_update_object,
+	.resize_object		= cachefiles_resize_object,
 	.invalidate_object	= cachefiles_invalidate_object,
 	.drop_object		= cachefiles_drop_object,
 	.put_object		= cachefiles_put_object,
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 3c408da2c837..ff193f61a4c5 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -194,6 +194,9 @@ extern atomic_t fscache_n_updates_run;
 extern atomic_t fscache_n_relinquishes;
 extern atomic_t fscache_n_relinquishes_retire;
 
+extern atomic_t fscache_n_resizes;
+extern atomic_t fscache_n_resizes_null;
+
 extern atomic_t fscache_n_cookie_index;
 extern atomic_t fscache_n_cookie_data;
 extern atomic_t fscache_n_cookie_special;
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index f13a7729bad3..5401c9ed347b 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -232,3 +232,31 @@ void fscache_put_super(struct super_block *sb,
 	}
 }
 EXPORT_SYMBOL(fscache_put_super);
+
+/*
+ * Change the size of a backing object.
+ */
+void __fscache_resize_cookie(struct fscache_cookie *cookie, loff_t new_size)
+{
+	struct fscache_op_resources opr;
+
+	ASSERT(cookie->type != FSCACHE_COOKIE_TYPE_INDEX);
+
+	trace_fscache_resize(cookie, new_size);
+	if (fscache_begin_operation(cookie, &opr, FSCACHE_WANT_WRITE) != -ENOBUFS) {
+		struct fscache_object *object = opr.object;
+
+		fscache_stat(&fscache_n_resizes);
+		set_bit(FSCACHE_OBJECT_NEEDS_UPDATE, &object->flags);
+
+		/* We cannot defer a resize as we need to do it inside the
+		 * netfs's inode lock so that we're serialised with respect to
+		 * writes.
+		 */
+		object->cache->ops->resize_object(object, new_size);
+		fscache_end_operation(&opr);
+	} else {
+		fscache_stat(&fscache_n_resizes_null);
+	}
+}
+EXPORT_SYMBOL(__fscache_resize_cookie);
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index 952214305853..2a2df9d1649e 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -28,6 +28,9 @@ atomic_t fscache_n_updates_run;
 atomic_t fscache_n_relinquishes;
 atomic_t fscache_n_relinquishes_retire;
 
+atomic_t fscache_n_resizes;
+atomic_t fscache_n_resizes_null;
+
 atomic_t fscache_n_cookie_index;
 atomic_t fscache_n_cookie_data;
 atomic_t fscache_n_cookie_special;
@@ -99,9 +102,11 @@ static int fscache_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "Invals : n=%u\n",
 		   atomic_read(&fscache_n_invalidates));
 
-	seq_printf(m, "Updates: n=%u run=%u\n",
+	seq_printf(m, "Updates: n=%u nul=%u rsz=%u rsn=%u\n",
 		   atomic_read(&fscache_n_updates),
-		   atomic_read(&fscache_n_updates_run));
+		   atomic_read(&fscache_n_updates_run),
+		   atomic_read(&fscache_n_resizes),
+		   atomic_read(&fscache_n_resizes_null));
 
 	seq_printf(m, "Relinqs: n=%u rtr=%u\n",
 		   atomic_read(&fscache_n_relinquishes),
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index eb303deb39c1..958fa899917d 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -117,6 +117,8 @@ struct fscache_cache_ops {
 
 	/* store the updated auxiliary data on an object */
 	void (*update_object)(struct fscache_object *object);
+	/* Change the size of a data object */
+	void (*resize_object)(struct fscache_object *object, loff_t new_size);
 
 	/* Invalidate an object */
 	bool (*invalidate_object)(struct fscache_object *object,
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 3c173fb660a6..1c1ea3558421 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -221,6 +221,7 @@ extern int __fscache_begin_operation(struct fscache_cookie *, struct fscache_op_
 				     enum fscache_want_stage);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
+extern void __fscache_resize_cookie(struct fscache_cookie *, loff_t);
 extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t, unsigned int);
 extern void fscache_put_super(struct super_block *,
 			      struct fscache_cookie *(*get_cookie)(struct inode *));
@@ -417,6 +418,23 @@ void fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data,
 		__fscache_update_cookie(cookie, aux_data, object_size);
 }
 
+/**
+ * fscache_resize_cookie - Request that a cache object be resized
+ * @cookie: The cookie representing the cache object
+ * @new_size: The new size of the object (may be NULL)
+ *
+ * Request that the size of an object be changed.
+ *
+ * See Documentation/filesystems/caching/netfs-api.txt for a complete
+ * description.
+ */
+static inline
+void fscache_resize_cookie(struct fscache_cookie *cookie, loff_t new_size)
+{
+	if (fscache_cookie_enabled(cookie))
+		__fscache_resize_cookie(cookie, new_size);
+}
+
 /**
  * fscache_pin_cookie - Pin a data-storage cache object in its cache
  * @cookie: The cookie representing the cache object
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index adb5618ce0c1..20bf21d12d0c 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -219,6 +219,32 @@ TRACE_EVENT(fscache_invalidate,
 		      __entry->cookie, __entry->new_size)
 	    );
 
+TRACE_EVENT(fscache_resize,
+	    TP_PROTO(struct fscache_cookie *cookie, loff_t new_size),
+
+	    TP_ARGS(cookie, new_size),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(loff_t,			old_size	)
+		    __field(loff_t,			zero_point	)
+		    __field(loff_t,			new_size	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie	= cookie->debug_id;
+		    __entry->old_size	= cookie->object_size;
+		    __entry->zero_point	= cookie->zero_point;
+		    __entry->new_size	= new_size;
+			   ),
+
+	    TP_printk("c=%08x os=%08llx zp=%08llx sz=%08llx",
+		      __entry->cookie,
+		      __entry->old_size,
+		      __entry->zero_point,
+		      __entry->new_size)
+	    );
+
 #endif /* _TRACE_FSCACHE_H */
 
 /* This part must be outside protection */


