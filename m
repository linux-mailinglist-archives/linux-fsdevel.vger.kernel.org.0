Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB7C21DD17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgGMQgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:36:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37358 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730766AbgGMQgk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594658198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qPZPF8CZHtaoL1uBXqtCN+iDfCdWcWYQMvIrZ6uG2yY=;
        b=OOdKxG8bX8eITjGE2xxhRQOhkFLDSM3vwh/VZtxvi6F1L12yDmc8desu6QzKNWVq3QInQH
        k3EvBgks4ZrAJs5XcNriQoiAFuHXaxwzusHYfX4YoUB4zr83H4Hl4mwfLCebP2v/vnx+uo
        HwR5Ef3grdImFTUgBOkFmlahl5UVGuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-9Pba6R6MNXasIO1U8nE6QA-1; Mon, 13 Jul 2020 12:36:34 -0400
X-MC-Unique: 9Pba6R6MNXasIO1U8nE6QA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACF9E1080;
        Mon, 13 Jul 2020 16:36:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F2B45D9DC;
        Mon, 13 Jul 2020 16:36:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 30/32] fscache: Provide resize operation
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:36:22 +0100
Message-ID: <159465818273.1376674.5693474446095659046.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a cache operation to resize an object.  This is intended to be run
synchronously rather than being deferred as it really needs to run inside
the inode lock on the netfs inode from ->setattr() to correctly order with
respect to other truncates and writes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c     |   24 ++++++++++++++++++++++++
 fs/fscache/internal.h         |    3 +++
 fs/fscache/io.c               |   27 +++++++++++++++++++++++++++
 fs/fscache/stats.c            |    9 +++++++--
 include/linux/fscache-cache.h |    2 ++
 include/linux/fscache.h       |   18 ++++++++++++++++++
 6 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index c626cc4248a7..d4172a40ddc9 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -248,6 +248,29 @@ static bool cachefiles_shorten_object(struct cachefiles_object *object, loff_t n
 	return true;
 }
 
+/*
+ * Resize the backing object.
+ */
+static void cachefiles_resize_object(struct fscache_object *_object, loff_t new_size)
+{
+	struct cachefiles_object *object =
+		container_of(_object, struct cachefiles_object, fscache);
+	loff_t old_size = object->fscache.cookie->object_size;
+
+	_enter("%llu->%llu", old_size, new_size);
+
+	if (new_size < old_size) {
+		cachefiles_shorten_content_map(object, new_size);
+		cachefiles_shorten_object(object, new_size);
+		return;
+	}
+
+	/* The file is being expanded.  We don't need to do anything
+	 * particularly.  cookie->initial_size doesn't change and so the point
+	 * at which we have to download before doesn't change.
+	 */
+}
+
 /*
  * Trim excess stored data off of an object.
  */
@@ -631,6 +654,7 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.free_lookup_data	= cachefiles_free_lookup_data,
 	.grab_object		= cachefiles_grab_object,
 	.update_object		= cachefiles_update_object,
+	.resize_object		= cachefiles_resize_object,
 	.invalidate_object	= cachefiles_invalidate_object,
 	.drop_object		= cachefiles_drop_object,
 	.put_object		= cachefiles_put_object,
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 120bb68f74b1..eb61e0716e20 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -178,6 +178,9 @@ extern atomic_t fscache_n_updates;
 extern atomic_t fscache_n_updates_null;
 extern atomic_t fscache_n_updates_run;
 
+extern atomic_t fscache_n_resizes;
+extern atomic_t fscache_n_resizes_null;
+
 extern atomic_t fscache_n_relinquishes;
 extern atomic_t fscache_n_relinquishes_null;
 extern atomic_t fscache_n_relinquishes_retire;
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 1885cfbe7f04..1a074f9c4bbe 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -172,3 +172,30 @@ int __fscache_write(struct fscache_io_request *req, struct iov_iter *iter)
 	}
 }
 EXPORT_SYMBOL(__fscache_write);
+
+/*
+ * Change the size of a backing object.
+ */
+void __fscache_resize_cookie(struct fscache_cookie *cookie, loff_t new_size)
+{
+	struct fscache_object *object;
+
+	ASSERT(cookie->type != FSCACHE_COOKIE_TYPE_INDEX);
+
+	object = fscache_begin_io_operation(cookie, FSCACHE_WANT_WRITE, NULL);
+	if (!IS_ERR(object)) {
+		fscache_stat(&fscache_n_resizes);
+		set_bit(FSCACHE_OBJECT_NEEDS_UPDATE, &object->flags);
+
+		/* We cannot defer a resize as we need to do it inside the
+		 * netfs's inode lock so that we're serialised with respect to
+		 * writes.
+		 */
+		object->cache->ops->resize_object(object, new_size);
+		object->cache->ops->put_object(object, fscache_obj_put_ioreq);
+		fscache_end_io_operation(cookie);
+	} else {
+		fscache_stat(&fscache_n_resizes_null);
+	}
+}
+EXPORT_SYMBOL(__fscache_resize_cookie);
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index 63fb4d831f4d..33cea7f527db 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -26,6 +26,9 @@ atomic_t fscache_n_updates;
 atomic_t fscache_n_updates_null;
 atomic_t fscache_n_updates_run;
 
+atomic_t fscache_n_resizes;
+atomic_t fscache_n_resizes_null;
+
 atomic_t fscache_n_relinquishes;
 atomic_t fscache_n_relinquishes_null;
 atomic_t fscache_n_relinquishes_retire;
@@ -132,10 +135,12 @@ int fscache_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "Invals : n=%u\n",
 		   atomic_read(&fscache_n_invalidates));
 
-	seq_printf(m, "Updates: n=%u nul=%u run=%u\n",
+	seq_printf(m, "Updates: n=%u nul=%u run=%u rsz=%u rsn=%u\n",
 		   atomic_read(&fscache_n_updates),
 		   atomic_read(&fscache_n_updates_null),
-		   atomic_read(&fscache_n_updates_run));
+		   atomic_read(&fscache_n_updates_run),
+		   atomic_read(&fscache_n_resizes),
+		   atomic_read(&fscache_n_resizes_null));
 
 	seq_printf(m, "Relinqs: n=%u nul=%u rtr=%u\n",
 		   atomic_read(&fscache_n_relinquishes),
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 3625fd431d9f..ba0ad89a968e 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -118,6 +118,8 @@ struct fscache_cache_ops {
 
 	/* store the updated auxiliary data on an object */
 	void (*update_object)(struct fscache_object *object);
+	/* Change the size of a data object */
+	void (*resize_object)(struct fscache_object *object, loff_t new_size);
 
 	/* Invalidate an object */
 	bool (*invalidate_object)(struct fscache_object *object,
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index c313950afd8a..cd8b6dc81c52 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -232,6 +232,7 @@ extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_shape_request(struct fscache_cookie *, struct fscache_request_shape *);
+extern void __fscache_resize_cookie(struct fscache_cookie *, loff_t);
 extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t, unsigned int);
 extern void __fscache_init_io_request(struct fscache_io_request *,
 				      struct fscache_cookie *);
@@ -431,6 +432,23 @@ void fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data,
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
+	if (fscache_cookie_valid(cookie))
+		__fscache_resize_cookie(cookie, new_size);
+}
+
 /**
  * fscache_pin_cookie - Pin a data-storage cache object in its cache
  * @cookie: The cookie representing the cache object


