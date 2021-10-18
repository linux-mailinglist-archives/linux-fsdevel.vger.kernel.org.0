Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EA643209B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhJRO4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232480AbhJRO4u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634568879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DdgLG/mjrbJRCYjiH5dWoD7UAqMfjeoEF8psWJ0FG/g=;
        b=BfkQlIem3NX5d7YJAe9wNjEgvTfZLvgAj+73WRP/fWuaanXvUskyf/jD66QU7/kiyrF994
        UPcRif1OCopvkuvM2gb/2oBvanSP6NqHHgsz/yBxlXhQsP8IbBlrAhCdrkx/le4HS+H3XN
        MkxBubC9pLYQdeimTRseUqoXoeSeJ20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-hSrl2m95O5GPDAqgvMLhpA-1; Mon, 18 Oct 2021 10:54:36 -0400
X-MC-Unique: hSrl2m95O5GPDAqgvMLhpA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F39E180A5C5;
        Mon, 18 Oct 2021 14:54:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCB12ADCD;
        Mon, 18 Oct 2021 14:54:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/67] fscache: Temporarily disable fscache_invalidate()
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
Date:   Mon, 18 Oct 2021 15:54:29 +0100
Message-ID: <163456886987.2614702.639114612962029576.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Temporarily disable the fscache side of fscache_invalidate() so that the
operation managing code can be removed.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c     |    9 ++---
 fs/fscache/cookie.c           |   23 +-----------
 fs/fscache/object.c           |   78 +----------------------------------------
 include/linux/fscache-cache.h |    2 +
 4 files changed, 7 insertions(+), 105 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 4a813a490ffe..a84adf638737 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -388,7 +388,7 @@ static int cachefiles_attr_changed(struct cachefiles_object *object)
 /*
  * Invalidate an object
  */
-static void cachefiles_invalidate_object(struct fscache_operation *op)
+static void cachefiles_invalidate_object(struct fscache_object *_object)
 {
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
@@ -397,14 +397,14 @@ static void cachefiles_invalidate_object(struct fscache_operation *op)
 	uint64_t ni_size;
 	int ret;
 
-	object = container_of(op->object, struct cachefiles_object, fscache);
+	object = container_of(_object, struct cachefiles_object, fscache);
 	cache = container_of(object->fscache.cache,
 			     struct cachefiles_cache, cache);
 
-	ni_size = op->object->cookie->object_size;
+	ni_size = object->fscache.cookie->object_size;
 
 	_enter("{OBJ%x},[%llu]",
-	       op->object->debug_id, (unsigned long long)ni_size);
+	       object->fscache.debug_id, (unsigned long long)ni_size);
 
 	if (object->backer) {
 		ASSERT(d_is_reg(object->backer));
@@ -425,7 +425,6 @@ static void cachefiles_invalidate_object(struct fscache_operation *op)
 		}
 	}
 
-	fscache_op_complete(op, true);
 	_leave("");
 }
 
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 78938ea6ad1a..1a7372a1d1aa 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -612,8 +612,6 @@ static int fscache_attach_object(struct fscache_cookie *cookie,
  */
 void __fscache_invalidate(struct fscache_cookie *cookie)
 {
-	struct fscache_object *object;
-
 	_enter("{%s}", cookie->type_name);
 
 	fscache_stat(&fscache_n_invalidates);
@@ -625,26 +623,7 @@ void __fscache_invalidate(struct fscache_cookie *cookie)
 	 */
 	ASSERTCMP(cookie->type, ==, FSCACHE_COOKIE_TYPE_DATAFILE);
 
-	/* If there's an object, we tell the object state machine to handle the
-	 * invalidation on our behalf, otherwise there's nothing to do.
-	 */
-	if (!hlist_empty(&cookie->backing_objects)) {
-		spin_lock(&cookie->lock);
-
-		if (fscache_cookie_enabled(cookie) &&
-		    !hlist_empty(&cookie->backing_objects) &&
-		    !test_and_set_bit(FSCACHE_COOKIE_INVALIDATING,
-				      &cookie->flags)) {
-			object = hlist_entry(cookie->backing_objects.first,
-					     struct fscache_object,
-					     cookie_link);
-			if (fscache_object_is_live(object))
-				fscache_raise_event(
-					object, FSCACHE_OBJECT_EV_INVALIDATE);
-		}
-
-		spin_unlock(&cookie->lock);
-	}
+	/* TODO: Do invalidation */
 
 	_leave("");
 }
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 7aa1f90d978b..4941b961c079 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -899,86 +899,10 @@ static void fscache_dequeue_object(struct fscache_object *object)
 	_leave("");
 }
 
-/*
- * Asynchronously invalidate an object.
- */
-static const struct fscache_state *_fscache_invalidate_object(struct fscache_object *object,
-							      int event)
-{
-	struct fscache_operation *op;
-	struct fscache_cookie *cookie = object->cookie;
-
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	/* We're going to need the cookie.  If the cookie is not available then
-	 * retire the object instead.
-	 */
-	if (!fscache_use_cookie(object)) {
-		set_bit(FSCACHE_OBJECT_RETIRED, &object->flags);
-		_leave(" [no cookie]");
-		return transit_to(KILL_OBJECT);
-	}
-
-	/* Reject any new read/write ops and abort any that are pending. */
-	clear_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags);
-	fscache_cancel_all_ops(object);
-
-	/* Now we have to wait for in-progress reads and writes */
-	op = kzalloc(sizeof(*op), GFP_KERNEL);
-	if (!op)
-		goto nomem;
-
-	fscache_operation_init(cookie, op, object->cache->ops->invalidate_object,
-			       NULL, NULL);
-	op->flags = FSCACHE_OP_ASYNC |
-		(1 << FSCACHE_OP_EXCLUSIVE) |
-		(1 << FSCACHE_OP_UNUSE_COOKIE);
-
-	spin_lock(&cookie->lock);
-	if (fscache_submit_exclusive_op(object, op) < 0)
-		goto submit_op_failed;
-	spin_unlock(&cookie->lock);
-	fscache_put_operation(op);
-
-	/* Once we've completed the invalidation, we know there will be no data
-	 * stored in the cache and thus we can reinstate the data-check-skip
-	 * optimisation.
-	 */
-	set_bit(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
-
-	/* We can allow read and write requests to come in once again.  They'll
-	 * queue up behind our exclusive invalidation operation.
-	 */
-	if (test_and_clear_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags))
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
-	_leave(" [ok]");
-	return transit_to(UPDATE_OBJECT);
-
-nomem:
-	fscache_mark_object_dead(object);
-	fscache_unuse_cookie(object);
-	_leave(" [ENOMEM]");
-	return transit_to(KILL_OBJECT);
-
-submit_op_failed:
-	fscache_mark_object_dead(object);
-	spin_unlock(&cookie->lock);
-	fscache_unuse_cookie(object);
-	kfree(op);
-	_leave(" [EIO]");
-	return transit_to(KILL_OBJECT);
-}
-
 static const struct fscache_state *fscache_invalidate_object(struct fscache_object *object,
 							     int event)
 {
-	const struct fscache_state *s;
-
-	fscache_stat(&fscache_n_invalidates_run);
-	fscache_stat(&fscache_n_cop_invalidate_object);
-	s = _fscache_invalidate_object(object, event);
-	fscache_stat_d(&fscache_n_cop_invalidate_object);
-	return s;
+	return transit_to(UPDATE_OBJECT);
 }
 
 /*
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index d0c6c09bb5a1..436456d4ff64 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -171,7 +171,7 @@ struct fscache_cache_ops {
 	void (*update_object)(struct fscache_object *object);
 
 	/* Invalidate an object */
-	void (*invalidate_object)(struct fscache_operation *op);
+	void (*invalidate_object)(struct fscache_object *object);
 
 	/* discard the resources pinned by an object and effect retirement if
 	 * necessary */


