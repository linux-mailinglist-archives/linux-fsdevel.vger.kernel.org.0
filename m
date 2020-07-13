Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FBF21DC04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbgGMQ3v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:29:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34814 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730240AbgGMQ3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594657790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0x+RB40tGqBs9eY+a+QbcqZos81z+ES4knWY5yzXwgg=;
        b=Kb/TDBNR1sa2X+j+2RT9VLRd9vLlb78utKsmz11VoMpRuiIXkQtevO9893fW95ymhskswv
        rKwPXQMBgYc1JshN5ACBOdoGhT1U7ZioUX05BioHWsnoLtrvz4Ye23H3PFyek2A4zswwWl
        LRVht2ke9byP52WEn02W0M5SQPQEsk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-ZZkmnqkUNV6c5Qt8k1mwKA-1; Mon, 13 Jul 2020 12:29:48 -0400
X-MC-Unique: ZZkmnqkUNV6c5Qt8k1mwKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E389C8018A1;
        Mon, 13 Jul 2020 16:29:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76CF672AC8;
        Mon, 13 Jul 2020 16:29:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/14] fscache: Remove fscache_attr_changed()
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
Date:   Mon, 13 Jul 2020 17:29:40 +0100
Message-ID: <159465778073.1376105.8734566018842067911.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465766378.1376105.11619976251039287525.stgit@warthog.procyon.org.uk>
References: <159465766378.1376105.11619976251039287525.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove fscache_attr_changed() as it's unused.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c     |   13 ++---
 fs/fscache/Makefile           |    3 -
 fs/fscache/page.c             |   98 -----------------------------------------
 include/linux/fscache-cache.h |    4 --
 include/linux/fscache.h       |   21 ---------
 5 files changed, 6 insertions(+), 133 deletions(-)
 delete mode 100644 fs/fscache/page.c

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index a3837ed090a8..81322e3acadd 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -10,7 +10,7 @@
 #include <linux/xattr.h>
 #include "internal.h"
 
-static int cachefiles_attr_changed(struct fscache_object *_object);
+static int cachefiles_attr_changed(struct cachefiles_object *object);
 
 /*
  * allocate an object record for a cookie lookup and prepare the lookup data
@@ -110,7 +110,7 @@ static int cachefiles_lookup_object(struct fscache_object *_object)
 	/* polish off by setting the attributes of non-index files */
 	if (ret == 0 &&
 	    object->fscache.cookie->type != FSCACHE_COOKIE_TYPE_INDEX)
-		cachefiles_attr_changed(&object->fscache);
+		cachefiles_attr_changed(object);
 
 	if (ret < 0 && ret != -ETIMEDOUT) {
 		if (ret != -ENOBUFS)
@@ -324,9 +324,8 @@ static void cachefiles_sync_cache(struct fscache_cache *_cache)
  * notification the attributes on an object have changed
  * - called with reads/writes excluded by FS-Cache
  */
-static int cachefiles_attr_changed(struct fscache_object *_object)
+static int cachefiles_attr_changed(struct cachefiles_object *object)
 {
-	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
 	struct iattr newattrs;
@@ -334,12 +333,11 @@ static int cachefiles_attr_changed(struct fscache_object *_object)
 	loff_t oi_size;
 	int ret;
 
-	ni_size = _object->cookie->object_size;
+	ni_size = object->fscache.cookie->object_size;
 
 	_enter("{OBJ%x},[%llu]",
-	       _object->debug_id, (unsigned long long) ni_size);
+	       object->fscache.debug_id, (unsigned long long) ni_size);
 
-	object = container_of(_object, struct cachefiles_object, fscache);
 	cache = container_of(object->fscache.cache,
 			     struct cachefiles_cache, cache);
 
@@ -442,5 +440,4 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.drop_object		= cachefiles_drop_object,
 	.put_object		= cachefiles_put_object,
 	.sync_cache		= cachefiles_sync_cache,
-	.attr_changed		= cachefiles_attr_changed,
 };
diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index 79e08e05ef84..565a3441d31d 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -10,8 +10,7 @@ fscache-y := \
 	main.o \
 	netfs.o \
 	object.o \
-	operation.o \
-	page.o
+	operation.o
 
 fscache-$(CONFIG_PROC_FS) += proc.o
 fscache-$(CONFIG_FSCACHE_STATS) += stats.o
diff --git a/fs/fscache/page.c b/fs/fscache/page.c
deleted file mode 100644
index 73636e9d652d..000000000000
--- a/fs/fscache/page.c
+++ /dev/null
@@ -1,98 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Cache page management and data I/O routines
- *
- * Copyright (C) 2004-2008 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define FSCACHE_DEBUG_LEVEL PAGE
-#include <linux/module.h>
-#include <linux/fscache-cache.h>
-#include <linux/buffer_head.h>
-#include <linux/pagevec.h>
-#include <linux/slab.h>
-#include "internal.h"
-
-/*
- * actually apply the changed attributes to a cache object
- */
-static void fscache_attr_changed_op(struct fscache_operation *op)
-{
-	struct fscache_object *object = op->object;
-	int ret;
-
-	_enter("{OBJ%x OP%x}", object->debug_id, op->debug_id);
-
-	fscache_stat(&fscache_n_attr_changed_calls);
-
-	if (fscache_object_is_active(object)) {
-		fscache_stat(&fscache_n_cop_attr_changed);
-		ret = object->cache->ops->attr_changed(object);
-		fscache_stat_d(&fscache_n_cop_attr_changed);
-		if (ret < 0)
-			fscache_abort_object(object);
-		fscache_op_complete(op, ret < 0);
-	} else {
-		fscache_op_complete(op, true);
-	}
-
-	_leave("");
-}
-
-/*
- * notification that the attributes on an object have changed
- */
-int __fscache_attr_changed(struct fscache_cookie *cookie)
-{
-	struct fscache_operation *op;
-	struct fscache_object *object;
-	bool wake_cookie = false;
-
-	_enter("%p", cookie);
-
-	ASSERTCMP(cookie->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
-
-	fscache_stat(&fscache_n_attr_changed);
-
-	op = kzalloc(sizeof(*op), GFP_KERNEL);
-	if (!op) {
-		fscache_stat(&fscache_n_attr_changed_nomem);
-		_leave(" = -ENOMEM");
-		return -ENOMEM;
-	}
-
-	fscache_operation_init(cookie, op, fscache_attr_changed_op, NULL, NULL);
-	trace_fscache_page_op(cookie, NULL, op, fscache_page_op_attr_changed);
-	op->flags = FSCACHE_OP_ASYNC |
-		(1 << FSCACHE_OP_EXCLUSIVE) |
-		(1 << FSCACHE_OP_UNUSE_COOKIE);
-
-	spin_lock(&cookie->lock);
-
-	if (!fscache_cookie_enabled(cookie) ||
-	    hlist_empty(&cookie->backing_objects))
-		goto nobufs;
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
-
-	__fscache_use_cookie(cookie);
-	if (fscache_submit_exclusive_op(object, op) < 0)
-		goto nobufs_dec;
-	spin_unlock(&cookie->lock);
-	fscache_stat(&fscache_n_attr_changed_ok);
-	fscache_put_operation(op);
-	_leave(" = 0");
-	return 0;
-
-nobufs_dec:
-	wake_cookie = __fscache_unuse_cookie(cookie);
-nobufs:
-	spin_unlock(&cookie->lock);
-	fscache_put_operation(op);
-	if (wake_cookie)
-		__fscache_wake_unused_cookie(cookie);
-	fscache_stat(&fscache_n_attr_changed_nobufs);
-	_leave(" = %d", -ENOBUFS);
-	return -ENOBUFS;
-}
-EXPORT_SYMBOL(__fscache_attr_changed);
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index bd9411cd466f..60b2f8288668 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -184,10 +184,6 @@ struct fscache_cache_ops {
 	/* sync a cache */
 	void (*sync_cache)(struct fscache_cache *cache);
 
-	/* notification that the attributes of a non-index object (such as
-	 * i_size) have changed */
-	int (*attr_changed)(struct fscache_object *object);
-
 	/* reserve space for an object's data and associated metadata */
 	int (*reserve_space)(struct fscache_object *object, loff_t i_size);
 };
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 76cfec6868de..c62b62938c4d 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -140,7 +140,6 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
 	loff_t, bool);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, const void *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *);
-extern int __fscache_attr_changed(struct fscache_cookie *);
 extern void __fscache_invalidate(struct fscache_cookie *);
 extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
 extern void __fscache_disable_cookie(struct fscache_cookie *, const void *, bool);
@@ -337,26 +336,6 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
 {
 }
 
-/**
- * fscache_attr_changed - Notify cache that an object's attributes changed
- * @cookie: The cookie representing the cache object
- *
- * Send a notification to the cache indicating that an object's attributes have
- * changed.  This includes the data size.  These attributes will be obtained
- * through the get_attr() cookie definition op.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-int fscache_attr_changed(struct fscache_cookie *cookie)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		return __fscache_attr_changed(cookie);
-	else
-		return -ENOBUFS;
-}
-
 /**
  * fscache_invalidate - Notify cache that an object needs invalidation
  * @cookie: The cookie representing the cache object


