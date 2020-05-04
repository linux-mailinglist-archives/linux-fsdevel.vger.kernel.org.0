Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655A61C411E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgEDRJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:09:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38834 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730189AbgEDRJm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/IYZhuHPsRjdF240Q1/z3a4igodJ3Q8RgoNPBPM/OU=;
        b=R9W1ZPuBB2G5mn4t8nukj+TGZc9JtaCWgIVmc1BFuEQ/AtvVTJnWobHtL0b4e1FOKHk/Q9
        X3MBtLmq1cu0eZXVP6fqzdcbhtfr9XCDbFkaXBSa1i3Cox/QiN7Yu+fmojLhb5z2hw+98N
        kfIGC8OpwLiyU6JBPBZvRfktgbWrcRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-wXH_2MNKMjWsJk-XjuX1Pg-1; Mon, 04 May 2020 13:09:36 -0400
X-MC-Unique: wXH_2MNKMjWsJk-XjuX1Pg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 294058730EB;
        Mon,  4 May 2020 17:09:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D69F60BEC;
        Mon,  4 May 2020 17:09:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 14/61] fscache: Remove fscache_check_consistency()
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:09:30 +0100
Message-ID: <158861217055.340223.17464479642843198381.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove fscache_check_consistency() as that allows the netfs to pry into the
inner working of the cache - and what's in the cookie should be taken as
consistent with the disk (possibly lazily).

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c     |   26 -------------
 fs/fscache/cookie.c           |   79 ----------------------------------------
 fs/fscache/internal.h         |    9 -----
 fs/fscache/page.c             |   82 -----------------------------------------
 include/linux/fscache-cache.h |    4 --
 include/linux/fscache.h       |   23 ------------
 6 files changed, 223 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index a5d348581bcc..a3837ed090a8 100644
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
@@ -468,5 +443,4 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.put_object		= cachefiles_put_object,
 	.sync_cache		= cachefiles_sync_cache,
 	.attr_changed		= cachefiles_attr_changed,
-	.check_consistency	= cachefiles_check_consistency,
 };
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index bcaadbcaa0b2..cd2e166d5f29 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -883,85 +883,6 @@ void fscache_cookie_put(struct fscache_cookie *cookie,
 	_leave("");
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
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index bc66bf7182ed..20cbd1288b5a 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -151,15 +151,6 @@ extern void fscache_abort_object(struct fscache_object *);
 extern void fscache_start_operations(struct fscache_object *);
 extern void fscache_operation_gc(struct work_struct *);
 
-/*
- * page.c
- */
-extern int fscache_wait_for_deferred_lookup(struct fscache_cookie *);
-extern int fscache_wait_for_operation_activation(struct fscache_object *,
-						 struct fscache_operation *,
-						 atomic_t *,
-						 atomic_t *);
-
 /*
  * proc.c
  */
diff --git a/fs/fscache/page.c b/fs/fscache/page.c
index fd9cc16abc18..73636e9d652d 100644
--- a/fs/fscache/page.c
+++ b/fs/fscache/page.c
@@ -96,85 +96,3 @@ int __fscache_attr_changed(struct fscache_cookie *cookie)
 	return -ENOBUFS;
 }
 EXPORT_SYMBOL(__fscache_attr_changed);
-
-/*
- * wait for a deferred lookup to complete
- */
-int fscache_wait_for_deferred_lookup(struct fscache_cookie *cookie)
-{
-	unsigned long jif;
-
-	_enter("");
-
-	if (!test_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags)) {
-		_leave(" = 0 [imm]");
-		return 0;
-	}
-
-	fscache_stat(&fscache_n_retrievals_wait);
-
-	jif = jiffies;
-	if (wait_on_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP,
-			TASK_INTERRUPTIBLE) != 0) {
-		fscache_stat(&fscache_n_retrievals_intr);
-		_leave(" = -ERESTARTSYS");
-		return -ERESTARTSYS;
-	}
-
-	ASSERT(!test_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags));
-
-	smp_rmb();
-	fscache_hist(fscache_retrieval_delay_histogram, jif);
-	_leave(" = 0 [dly]");
-	return 0;
-}
-
-/*
- * wait for an object to become active (or dead)
- */
-int fscache_wait_for_operation_activation(struct fscache_object *object,
-					  struct fscache_operation *op,
-					  atomic_t *stat_op_waits,
-					  atomic_t *stat_object_dead)
-{
-	int ret;
-
-	if (!test_bit(FSCACHE_OP_WAITING, &op->flags))
-		goto check_if_dead;
-
-	_debug(">>> WT");
-	if (stat_op_waits)
-		fscache_stat(stat_op_waits);
-	if (wait_on_bit(&op->flags, FSCACHE_OP_WAITING,
-			TASK_INTERRUPTIBLE) != 0) {
-		trace_fscache_op(object->cookie, op, fscache_op_signal);
-		ret = fscache_cancel_op(op, false);
-		if (ret == 0)
-			return -ERESTARTSYS;
-
-		/* it's been removed from the pending queue by another party,
-		 * so we should get to run shortly */
-		wait_on_bit(&op->flags, FSCACHE_OP_WAITING,
-			    TASK_UNINTERRUPTIBLE);
-	}
-	_debug("<<< GO");
-
-check_if_dead:
-	if (op->state == FSCACHE_OP_ST_CANCELLED) {
-		if (stat_object_dead)
-			fscache_stat(stat_object_dead);
-		_leave(" = -ENOBUFS [cancelled]");
-		return -ENOBUFS;
-	}
-	if (unlikely(fscache_object_is_dying(object) ||
-		     fscache_cache_is_broken(object))) {
-		enum fscache_operation_state state = op->state;
-		trace_fscache_op(object->cookie, op, fscache_op_signal);
-		fscache_cancel_op(op, true);
-		if (stat_object_dead)
-			fscache_stat(stat_object_dead);
-		_leave(" = -ENOBUFS [obj dead %d]", state);
-		return -ENOBUFS;
-	}
-	return 0;
-}
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 81418056f43f..3a78e41d2338 100644
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
index 64d9ef34da49..82e871a3dc6a 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -139,7 +139,6 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
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


