Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92328432075
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhJROzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232360AbhJROzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634568822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53rHR2JQiSk7mdrXzJPxTn/iYK4ompTtsc4UWiHJO7g=;
        b=bq2gVwz69RiNva3yPV+HWshxrfCYKgyrR8JvDFXNXotRooiyzYXSn4DNeoP8XdeYs1Vmyu
        Ly8JdIStYmqpxSZShDtrgfADlDgZePbUQeQGVS1J5iXeAuWNf2Jbk3CTobnsSCiX4TERHv
        yiVy9F8ZWpi1jf5sxgDAvyBNumOebcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-MZmnuUFDMhOdBcqw9K4VFA-1; Mon, 18 Oct 2021 10:53:39 -0400
X-MC-Unique: MZmnuUFDMhOdBcqw9K4VFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2029A362FA;
        Mon, 18 Oct 2021 14:53:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFEE35BB06;
        Mon, 18 Oct 2021 14:53:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/67] fscache: Remove fscache_check_consistency()
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
Date:   Mon, 18 Oct 2021 15:53:13 +0100
Message-ID: <163456879308.2614702.3008093259379620191.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove fscache_check_consistency() as that allows the netfs to pry into the
inner working of the cache - and what's in the cookie should be taken as
consistent with the disk (possibly lazily).

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c     |   26 -------------
 fs/fscache/cookie.c           |   79 -----------------------------------------
 include/linux/fscache-cache.h |    4 --
 include/linux/fscache.h       |   23 ------------
 4 files changed, 132 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 48f7de947a16..460dd190dad5 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -320,31 +320,6 @@ static void cachefiles_sync_cache(struct fscache_cache *_cache)
 				    ret);
 }
 
-/*
- * check if the backing cache is updated to FS-Cache
- * - called by FS-Cache when evaluates if need to invalidate the cache
- */
-static int cachefiles_check_consistency(struct fscache_operation *op)
-{
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	const struct cred *saved_cred;
-	int ret;
-
-	_enter("{OBJ%x}", op->object->debug_id);
-
-	object = container_of(op->object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
-
-	cachefiles_begin_secure(cache, &saved_cred);
-	ret = cachefiles_check_auxdata(object);
-	cachefiles_end_secure(cache, saved_cred);
-
-	_leave(" = %d", ret);
-	return ret;
-}
-
 /*
  * notification the attributes on an object have changed
  * - called with reads/writes excluded by FS-Cache
@@ -468,6 +443,5 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.put_object		= cachefiles_put_object,
 	.sync_cache		= cachefiles_sync_cache,
 	.attr_changed		= cachefiles_attr_changed,
-	.check_consistency	= cachefiles_check_consistency,
 	.begin_operation	= cachefiles_begin_operation,
 };
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 02998ec9f7c9..78938ea6ad1a 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -880,85 +880,6 @@ struct fscache_cookie *fscache_cookie_get(struct fscache_cookie *cookie,
 	return cookie;
 }
 
-/*
- * check the consistency between the netfs inode and the backing cache
- *
- * NOTE: it only serves no-index type
- */
-int __fscache_check_consistency(struct fscache_cookie *cookie,
-				const void *aux_data)
-{
-	struct fscache_operation *op;
-	struct fscache_object *object;
-	bool wake_cookie = false;
-	int ret;
-
-	_enter("%p,", cookie);
-
-	ASSERTCMP(cookie->type, ==, FSCACHE_COOKIE_TYPE_DATAFILE);
-
-	if (fscache_wait_for_deferred_lookup(cookie) < 0)
-		return -ERESTARTSYS;
-
-	if (hlist_empty(&cookie->backing_objects))
-		return 0;
-
-	op = kzalloc(sizeof(*op), GFP_NOIO | __GFP_NOMEMALLOC | __GFP_NORETRY);
-	if (!op)
-		return -ENOMEM;
-
-	fscache_operation_init(cookie, op, NULL, NULL, NULL);
-	op->flags = FSCACHE_OP_MYTHREAD |
-		(1 << FSCACHE_OP_WAITING) |
-		(1 << FSCACHE_OP_UNUSE_COOKIE);
-	trace_fscache_page_op(cookie, NULL, op, fscache_page_op_check_consistency);
-
-	spin_lock(&cookie->lock);
-
-	fscache_update_aux(cookie, aux_data);
-
-	if (!fscache_cookie_enabled(cookie) ||
-	    hlist_empty(&cookie->backing_objects))
-		goto inconsistent;
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
-	if (test_bit(FSCACHE_IOERROR, &object->cache->flags))
-		goto inconsistent;
-
-	op->debug_id = atomic_inc_return(&fscache_op_debug_id);
-
-	__fscache_use_cookie(cookie);
-	if (fscache_submit_op(object, op) < 0)
-		goto submit_failed;
-
-	/* the work queue now carries its own ref on the object */
-	spin_unlock(&cookie->lock);
-
-	ret = fscache_wait_for_operation_activation(object, op, NULL, NULL);
-	if (ret == 0) {
-		/* ask the cache to honour the operation */
-		ret = object->cache->ops->check_consistency(op);
-		fscache_op_complete(op, false);
-	} else if (ret == -ENOBUFS) {
-		ret = 0;
-	}
-
-	fscache_put_operation(op);
-	_leave(" = %d", ret);
-	return ret;
-
-submit_failed:
-	wake_cookie = __fscache_unuse_cookie(cookie);
-inconsistent:
-	spin_unlock(&cookie->lock);
-	if (wake_cookie)
-		__fscache_wake_unused_cookie(cookie);
-	kfree(op);
-	_leave(" = -ESTALE");
-	return -ESTALE;
-}
-EXPORT_SYMBOL(__fscache_check_consistency);
-
 /*
  * Generate a list of extant cookies in /proc/fs/fscache/cookies
  */
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 15cd2f04c9e6..15683b7876ff 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -167,10 +167,6 @@ struct fscache_cache_ops {
 	/* unpin an object in the cache */
 	void (*unpin_object)(struct fscache_object *object);
 
-	/* check the consistency between the backing cache and the FS-Cache
-	 * cookie */
-	int (*check_consistency)(struct fscache_operation *op);
-
 	/* store the updated auxiliary data on an object */
 	void (*update_object)(struct fscache_object *object);
 
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 98685bd7204b..75ca4fda93d5 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -131,7 +131,6 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
 	const void *, size_t,
 	loff_t, bool);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, const void *, bool);
-extern int __fscache_check_consistency(struct fscache_cookie *, const void *);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *);
 extern int __fscache_attr_changed(struct fscache_cookie *);
 extern void __fscache_invalidate(struct fscache_cookie *);
@@ -290,28 +289,6 @@ void fscache_relinquish_cookie(struct fscache_cookie *cookie,
 		__fscache_relinquish_cookie(cookie, aux_data, retire);
 }
 
-/**
- * fscache_check_consistency - Request validation of a cache's auxiliary data
- * @cookie: The cookie representing the cache object
- * @aux_data: The updated auxiliary data for the cookie (may be NULL)
- *
- * Request an consistency check from fscache, which passes the request to the
- * backing cache.  The auxiliary data on the cookie will be updated first if
- * @aux_data is set.
- *
- * Returns 0 if consistent and -ESTALE if inconsistent.  May also
- * return -ENOMEM and -ERESTARTSYS.
- */
-static inline
-int fscache_check_consistency(struct fscache_cookie *cookie,
-			      const void *aux_data)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		return __fscache_check_consistency(cookie, aux_data);
-	else
-		return 0;
-}
-
 /**
  * fscache_update_cookie - Request that a cache object be updated
  * @cookie: The cookie representing the cache object


