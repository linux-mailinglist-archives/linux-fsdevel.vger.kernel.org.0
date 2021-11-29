Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE2E461899
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378419AbhK2OcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:32:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58136 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378433AbhK2OaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638196007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TuJeXBZzABBvebH6TbsfSw5ySf+nQYqZwrEw9kkWPlk=;
        b=T1W5l5sBgPYJ3CgDVBwFfwr80ArSvqAjNqjkQBQAYtNt84zjfW1L6VLSOkUu2kMPpvEFHu
        4LSBpKP4sh7mimFFBax+Fsackl3p/63PmS7XIadZhJuc8q4yw/E6u8Ab74sOf9fG1ZgUpT
        aQnJ5ngV4ZqjlIY9rm2GUjI/Wqiny90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-0cTiYTobP-iFwM0pC3RxVA-1; Mon, 29 Nov 2021 09:26:44 -0500
X-MC-Unique: 0cTiYTobP-iFwM0pC3RxVA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4C5E10168E0;
        Mon, 29 Nov 2021 14:26:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68E0C5D9DE;
        Mon, 29 Nov 2021 14:26:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/64] fscache: Implement simple cookie state machine
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
Date:   Mon, 29 Nov 2021 14:26:36 +0000
Message-ID: <163819599657.215744.15799615296912341745.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a very simple cookie state machine to handle lookup, withdrawal,
relinquishment and, eventually, timed committing and invalidation.

Three cache methods are provided: ->lookup_cookie() to look up and, if
necessary, create a data storage object; ->withdraw_cookie() to free the
resources associated with that object and potentially delete it; and
->prepare_to_write(), to do prepare for changes to the cached data to be
modified locally.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/fscache/cookie.c            |  311 ++++++++++++++++++++++++++++++++++------
 include/linux/fscache-cache.h  |   27 +++
 include/linux/fscache.h        |    2 
 include/trace/events/fscache.h |    4 +
 4 files changed, 292 insertions(+), 52 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 3dd150182d97..51bf52ea712c 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -15,7 +15,8 @@
 
 struct kmem_cache *fscache_cookie_jar;
 
-static void fscache_drop_cookie(struct fscache_cookie *cookie);
+static void fscache_cookie_worker(struct work_struct *work);
+static void fscache_unhash_cookie(struct fscache_cookie *cookie);
 
 #define fscache_cookie_hash_shift 15
 static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
@@ -57,6 +58,19 @@ static void fscache_free_cookie(struct fscache_cookie *cookie)
 	kmem_cache_free(fscache_cookie_jar, cookie);
 }
 
+static void __fscache_queue_cookie(struct fscache_cookie *cookie)
+{
+	if (!queue_work(fscache_wq, &cookie->work))
+		fscache_put_cookie(cookie, fscache_cookie_put_over_queued);
+}
+
+static void fscache_queue_cookie(struct fscache_cookie *cookie,
+				 enum fscache_cookie_trace where)
+{
+	fscache_get_cookie(cookie, where);
+	__fscache_queue_cookie(cookie);
+}
+
 /*
  * Initialise the access gate on a cookie by keeping its n_accesses counter
  * raised by 1.  This will prevent end-access from transitioning it to 0 until
@@ -72,15 +86,6 @@ static void fscache_init_access_gate(struct fscache_cookie *cookie)
 	set_bit(FSCACHE_COOKIE_NACC_ELEVATED, &cookie->flags);
 }
 
-static void __fscache_end_cookie_access(struct fscache_cookie *cookie)
-{
-	if (test_bit(FSCACHE_COOKIE_DO_RELINQUISH, &cookie->flags))
-		fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_RELINQUISHING);
-	else if (test_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags))
-		fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_WITHDRAWING);
-	// PLACEHOLDER: Schedule cookie cleanup
-}
-
 /**
  * fscache_end_cookie_access - Unpin a cache at the end of an access.
  * @cookie: A data file cookie
@@ -101,7 +106,7 @@ void fscache_end_cookie_access(struct fscache_cookie *cookie,
 	trace_fscache_access(cookie->debug_id, refcount_read(&cookie->ref),
 			     n_accesses, why);
 	if (n_accesses == 0)
-		__fscache_end_cookie_access(cookie);
+		fscache_queue_cookie(cookie, fscache_cookie_get_end_access);
 }
 EXPORT_SYMBOL(fscache_end_cookie_access);
 
@@ -172,35 +177,58 @@ static inline void wake_up_cookie_state(struct fscache_cookie *cookie)
 	wake_up_var(&cookie->state);
 }
 
+/*
+ * Change the state a cookie is at and wake up anyone waiting for that.  Impose
+ * an ordering between the stuff stored in the cookie and the state member.
+ * Paired with fscache_cookie_state().
+ */
 static void __fscache_set_cookie_state(struct fscache_cookie *cookie,
 				       enum fscache_cookie_state state)
 {
-	cookie->state = state;
+	smp_store_release(&cookie->state, state);
 }
 
-/*
- * Change the state a cookie is at and wake up anyone waiting for that - but
- * only if the cookie isn't already marked as being in a cleanup state.
- */
-void fscache_set_cookie_state(struct fscache_cookie *cookie,
-			      enum fscache_cookie_state state)
+static void fscache_set_cookie_state(struct fscache_cookie *cookie,
+				     enum fscache_cookie_state state)
 {
-	bool changed = false;
-
 	spin_lock(&cookie->lock);
-	switch (cookie->state) {
-	case FSCACHE_COOKIE_STATE_RELINQUISHING:
-		break;
-	default:
-		__fscache_set_cookie_state(cookie, state);
-		changed = true;
-		break;
-	}
+	__fscache_set_cookie_state(cookie, state);
 	spin_unlock(&cookie->lock);
-	if (changed)
-		wake_up_cookie_state(cookie);
+	wake_up_cookie_state(cookie);
+}
+
+/**
+ * fscache_cookie_lookup_negative - Note negative lookup
+ * @cookie: The cookie that was being looked up
+ *
+ * Note that some part of the metadata path in the cache doesn't exist and so
+ * we can release any waiting readers in the certain knowledge that there's
+ * nothing for them to actually read.
+ *
+ * This function uses no locking and must only be called from the state machine.
+ */
+void fscache_cookie_lookup_negative(struct fscache_cookie *cookie)
+{
+	set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+	fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_CREATING);
 }
-EXPORT_SYMBOL(fscache_set_cookie_state);
+EXPORT_SYMBOL(fscache_cookie_lookup_negative);
+
+/**
+ * fscache_caching_failed - Report that a failure stopped caching on a cookie
+ * @cookie: The cookie that was affected
+ *
+ * Tell fscache that caching on a cookie needs to be stopped due to some sort
+ * of failure.
+ *
+ * This function uses no locking and must only be called from the state machine.
+ */
+void fscache_caching_failed(struct fscache_cookie *cookie)
+{
+	clear_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags);
+	fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_FAILED);
+}
+EXPORT_SYMBOL(fscache_caching_failed);
 
 /*
  * Set the index key in a cookie.  The cookie struct has space for a 16-byte
@@ -293,10 +321,10 @@ static struct fscache_cookie *fscache_alloc_cookie(
 
 	refcount_set(&cookie->ref, 1);
 	cookie->debug_id = atomic_inc_return(&fscache_cookie_debug_id);
-	cookie->state = FSCACHE_COOKIE_STATE_QUIESCENT;
 	spin_lock_init(&cookie->lock);
 	INIT_LIST_HEAD(&cookie->commit_link);
-	INIT_WORK(&cookie->work, NULL /* PLACEHOLDER */);
+	INIT_WORK(&cookie->work, fscache_cookie_worker);
+	__fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_QUIESCENT);
 
 	write_lock(&fscache_cookies_lock);
 	list_add_tail(&cookie->proc_link, &fscache_cookies);
@@ -418,6 +446,184 @@ struct fscache_cookie *__fscache_acquire_cookie(
 }
 EXPORT_SYMBOL(__fscache_acquire_cookie);
 
+/*
+ * Prepare a cache object to be written to.
+ */
+static void fscache_prepare_to_write(struct fscache_cookie *cookie)
+{
+	cookie->volume->cache->ops->prepare_to_write(cookie);
+}
+
+/*
+ * Look up a cookie in the cache.
+ */
+static void fscache_perform_lookup(struct fscache_cookie *cookie)
+{
+	enum fscache_access_trace trace = fscache_access_lookup_cookie_end_failed;
+	bool need_withdraw = false;
+
+	_enter("");
+
+	if (!cookie->volume->cache_priv) {
+		fscache_create_volume(cookie->volume, true);
+		if (!cookie->volume->cache_priv) {
+			fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_QUIESCENT);
+			goto out;
+		}
+	}
+
+	if (!cookie->volume->cache->ops->lookup_cookie(cookie)) {
+		if (cookie->state != FSCACHE_COOKIE_STATE_FAILED)
+			fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_QUIESCENT);
+		need_withdraw = true;
+		_leave(" [fail]");
+		goto out;
+	}
+
+	fscache_see_cookie(cookie, fscache_cookie_see_active);
+	fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_ACTIVE);
+	trace = fscache_access_lookup_cookie_end;
+
+out:
+	fscache_end_cookie_access(cookie, trace);
+	if (need_withdraw)
+		fscache_withdraw_cookie(cookie);
+	fscache_end_volume_access(cookie->volume, cookie, trace);
+}
+
+/*
+ * Perform work upon the cookie, such as committing its cache state,
+ * relinquishing it or withdrawing the backing cache.  We're protected from the
+ * cache going away under us as object withdrawal must come through this
+ * non-reentrant work item.
+ */
+static void fscache_cookie_state_machine(struct fscache_cookie *cookie)
+{
+	enum fscache_cookie_state state;
+	bool wake = false;
+
+	_enter("c=%x", cookie->debug_id);
+
+again:
+	spin_lock(&cookie->lock);
+again_locked:
+	state = cookie->state;
+	switch (state) {
+	case FSCACHE_COOKIE_STATE_QUIESCENT:
+		/* The QUIESCENT state is jumped to the LOOKING_UP state by
+		 * fscache_use_cookie().
+		 */
+
+		if (atomic_read(&cookie->n_accesses) == 0 &&
+		    test_bit(FSCACHE_COOKIE_DO_RELINQUISH, &cookie->flags)) {
+			__fscache_set_cookie_state(cookie,
+						   FSCACHE_COOKIE_STATE_RELINQUISHING);
+			wake = true;
+			goto again_locked;
+		}
+		break;
+
+	case FSCACHE_COOKIE_STATE_LOOKING_UP:
+		spin_unlock(&cookie->lock);
+		fscache_init_access_gate(cookie);
+		fscache_perform_lookup(cookie);
+		goto again;
+
+	case FSCACHE_COOKIE_STATE_ACTIVE:
+		if (test_and_clear_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags)) {
+			spin_unlock(&cookie->lock);
+			fscache_prepare_to_write(cookie);
+			spin_lock(&cookie->lock);
+		}
+		fallthrough;
+
+	case FSCACHE_COOKIE_STATE_FAILED:
+		if (atomic_read(&cookie->n_accesses) != 0)
+			break;
+		if (test_bit(FSCACHE_COOKIE_DO_RELINQUISH, &cookie->flags)) {
+			__fscache_set_cookie_state(cookie,
+						   FSCACHE_COOKIE_STATE_RELINQUISHING);
+			wake = true;
+			goto again_locked;
+		}
+		if (test_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags)) {
+			__fscache_set_cookie_state(cookie,
+						   FSCACHE_COOKIE_STATE_WITHDRAWING);
+			wake = true;
+			goto again_locked;
+		}
+		break;
+
+	case FSCACHE_COOKIE_STATE_RELINQUISHING:
+	case FSCACHE_COOKIE_STATE_WITHDRAWING:
+		if (cookie->cache_priv) {
+			spin_unlock(&cookie->lock);
+			cookie->volume->cache->ops->withdraw_cookie(cookie);
+			spin_lock(&cookie->lock);
+		}
+
+		switch (state) {
+		case FSCACHE_COOKIE_STATE_RELINQUISHING:
+			fscache_see_cookie(cookie, fscache_cookie_see_relinquish);
+			fscache_unhash_cookie(cookie);
+			__fscache_set_cookie_state(cookie,
+						   FSCACHE_COOKIE_STATE_DROPPED);
+			wake = true;
+			goto out;
+		case FSCACHE_COOKIE_STATE_WITHDRAWING:
+			fscache_see_cookie(cookie, fscache_cookie_see_withdraw);
+			break;
+		default:
+			BUG();
+		}
+
+		clear_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &cookie->flags);
+		clear_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags);
+		clear_bit(FSCACHE_COOKIE_DO_LRU_DISCARD, &cookie->flags);
+		clear_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags);
+		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+		__fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_QUIESCENT);
+		wake = true;
+		break;
+
+	case FSCACHE_COOKIE_STATE_DROPPED:
+		break;
+
+	default:
+		WARN_ONCE(1, "Cookie %x in unexpected state %u\n",
+			  cookie->debug_id, state);
+		break;
+	}
+
+out:
+	spin_unlock(&cookie->lock);
+	if (wake)
+		wake_up_cookie_state(cookie);
+	_leave("");
+}
+
+static void fscache_cookie_worker(struct work_struct *work)
+{
+	struct fscache_cookie *cookie = container_of(work, struct fscache_cookie, work);
+
+	fscache_see_cookie(cookie, fscache_cookie_see_work);
+	fscache_cookie_state_machine(cookie);
+	fscache_put_cookie(cookie, fscache_cookie_put_work);
+}
+
+/*
+ * Wait for the object to become inactive.  The cookie's work item will be
+ * scheduled when someone transitions n_accesses to 0 - but if someone's
+ * already done that, schedule it anyway.
+ */
+static void __fscache_withdraw_cookie(struct fscache_cookie *cookie)
+{
+	if (test_and_clear_bit(FSCACHE_COOKIE_NACC_ELEVATED, &cookie->flags))
+		fscache_end_cookie_access(cookie, fscache_access_cache_unpin);
+	else
+		fscache_queue_cookie(cookie, fscache_cookie_get_end_access);
+}
+
 /*
  * Remove a cookie from the hash table.
  */
@@ -432,21 +638,27 @@ static void fscache_unhash_cookie(struct fscache_cookie *cookie)
 	hlist_bl_lock(h);
 	hlist_bl_del(&cookie->hash_link);
 	hlist_bl_unlock(h);
+	fscache_stat(&fscache_n_relinquishes_dropped);
 }
 
-/*
- * Finalise a cookie after all its resources have been disposed of.
- */
-static void fscache_drop_cookie(struct fscache_cookie *cookie)
+static void fscache_drop_withdraw_cookie(struct fscache_cookie *cookie)
 {
-	spin_lock(&cookie->lock);
-	__fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_DROPPED);
-	spin_unlock(&cookie->lock);
-	wake_up_cookie_state(cookie);
+	__fscache_withdraw_cookie(cookie);
+}
 
-	fscache_unhash_cookie(cookie);
-	fscache_stat(&fscache_n_relinquishes_dropped);
+/**
+ * fscache_withdraw_cookie - Mark a cookie for withdrawal
+ * @cookie: The cookie to be withdrawn.
+ *
+ * Allow the cache backend to withdraw the backing for a cookie for its own
+ * reasons, even if that cookie is in active use.
+ */
+void fscache_withdraw_cookie(struct fscache_cookie *cookie)
+{
+	set_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags);
+	fscache_drop_withdraw_cookie(cookie);
 }
+EXPORT_SYMBOL(fscache_withdraw_cookie);
 
 /*
  * Allow the netfs to release a cookie back to the cache.
@@ -473,12 +685,13 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie, bool retire)
 	ASSERTCMP(atomic_read(&cookie->volume->n_cookies), >, 0);
 	atomic_dec(&cookie->volume->n_cookies);
 
-	set_bit(FSCACHE_COOKIE_DO_RELINQUISH, &cookie->flags);
-
-	if (test_bit(FSCACHE_COOKIE_HAS_BEEN_CACHED, &cookie->flags))
-		; // PLACEHOLDER: Do something here if the cookie was cached
-	else
-		fscache_drop_cookie(cookie);
+	if (test_bit(FSCACHE_COOKIE_HAS_BEEN_CACHED, &cookie->flags)) {
+		set_bit(FSCACHE_COOKIE_DO_RELINQUISH, &cookie->flags);
+		fscache_drop_withdraw_cookie(cookie);
+	} else {
+		fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_DROPPED);
+		fscache_unhash_cookie(cookie);
+	}
 	fscache_put_cookie(cookie, fscache_cookie_put_relinquish);
 }
 EXPORT_SYMBOL(__fscache_relinquish_cookie);
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 936ef731bbc7..ae6a75976450 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -57,6 +57,15 @@ struct fscache_cache_ops {
 
 	/* Free the cache's data attached to a volume */
 	void (*free_volume)(struct fscache_volume *volume);
+
+	/* Look up a cookie in the cache */
+	bool (*lookup_cookie)(struct fscache_cookie *cookie);
+
+	/* Withdraw an object without any cookie access counts held */
+	void (*withdraw_cookie)(struct fscache_cookie *cookie);
+
+	/* Prepare to write to a live cache object */
+	void (*prepare_to_write)(struct fscache_cookie *cookie);
 };
 
 extern struct workqueue_struct *fscache_wq;
@@ -72,6 +81,7 @@ extern int fscache_add_cache(struct fscache_cache *cache,
 			     void *cache_priv);
 extern void fscache_withdraw_cache(struct fscache_cache *cache);
 extern void fscache_withdraw_volume(struct fscache_volume *volume);
+extern void fscache_withdraw_cookie(struct fscache_cookie *cookie);
 
 extern void fscache_io_error(struct fscache_cache *cache);
 
@@ -85,8 +95,21 @@ extern void fscache_put_cookie(struct fscache_cookie *cookie,
 			       enum fscache_cookie_trace where);
 extern void fscache_end_cookie_access(struct fscache_cookie *cookie,
 				      enum fscache_access_trace why);
-extern void fscache_set_cookie_state(struct fscache_cookie *cookie,
-				     enum fscache_cookie_state state);
+extern void fscache_cookie_lookup_negative(struct fscache_cookie *cookie);
+extern void fscache_caching_failed(struct fscache_cookie *cookie);
+
+/**
+ * fscache_cookie_state - Read the state of a cookie
+ * @cookie: The cookie to query
+ *
+ * Get the state of a cookie, imposing an ordering between the cookie contents
+ * and the state value.  Paired with fscache_set_cookie_state().
+ */
+static inline
+enum fscache_cookie_state fscache_cookie_state(struct fscache_cookie *cookie)
+{
+	return smp_load_acquire(&cookie->state);
+}
 
 /**
  * fscache_get_key - Get a pointer to the cookie key
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index e25e1b8bb91b..0568414bd392 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -111,7 +111,7 @@ struct fscache_cookie {
 #define FSCACHE_COOKIE_NACC_ELEVATED	8		/* T if n_accesses is incremented */
 #define FSCACHE_COOKIE_DO_RELINQUISH	9		/* T if this cookie needs relinquishment */
 #define FSCACHE_COOKIE_DO_WITHDRAW	10		/* T if this cookie needs withdrawing */
-#define FSCACHE_COOKIE_DO_COMMIT	11		/* T if this cookie needs committing */
+#define FSCACHE_COOKIE_DO_LRU_DISCARD	11		/* T if this cookie needs LRU discard */
 #define FSCACHE_COOKIE_DO_PREP_TO_WRITE	12		/* T if cookie needs write preparation */
 #define FSCACHE_COOKIE_HAVE_DATA	13		/* T if this cookie has data stored */
 
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index c16b2ca4bf3f..8b3594de9d2c 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -68,6 +68,8 @@ enum fscache_access_trace {
 	fscache_access_acquire_volume_end,
 	fscache_access_cache_pin,
 	fscache_access_cache_unpin,
+	fscache_access_lookup_cookie_end,
+	fscache_access_lookup_cookie_end_failed,
 	fscache_access_relinquish_volume,
 	fscache_access_relinquish_volume_end,
 	fscache_access_unlive,
@@ -124,6 +126,8 @@ enum fscache_access_trace {
 	EM(fscache_access_acquire_volume_end,	"END   acq_vol")	\
 	EM(fscache_access_cache_pin,		"PIN   cache  ")	\
 	EM(fscache_access_cache_unpin,		"UNPIN cache  ")	\
+	EM(fscache_access_lookup_cookie_end,	"END   lookup ")	\
+	EM(fscache_access_lookup_cookie_end_failed,"END   lookupf")	\
 	EM(fscache_access_relinquish_volume,	"BEGIN rlq_vol")	\
 	EM(fscache_access_relinquish_volume_end,"END   rlq_vol")	\
 	E_(fscache_access_unlive,		"END   unlive ")


