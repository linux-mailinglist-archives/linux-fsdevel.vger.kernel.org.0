Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2CE46EF06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 17:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbhLIRCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:02:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241538AbhLIRB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UC6ZIhZTnSNbOMbnZ2CGZUTUdTlNZZeuvjwqO+7o13w=;
        b=DtVYQcEn/bNhmmjyNeD4rN91PVejMlutjK3GZVx3JYPlHzvJEds6wWJZ7qgVR4bfF5FUmV
        U/KE0y4WyFFtPYcmp0Lp5Jxqe2fhIpEw25xgWcWBchEwjQYy3LbZvQQO8l22P/oBlHeLqv
        4aEXuJ27KWMvHi0Mx5gN1ceMpqSyRZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-1PjIlYbuNoqRNxQGfDwOxA-1; Thu, 09 Dec 2021 11:58:24 -0500
X-MC-Unique: 1PjIlYbuNoqRNxQGfDwOxA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7989910144E1;
        Thu,  9 Dec 2021 16:58:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3F2419724;
        Thu,  9 Dec 2021 16:58:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 19/67] fscache: Implement cookie invalidation
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
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Dec 2021 16:58:17 +0000
Message-ID: <163906909707.143852.18056070560477964891.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function to invalidate the cache behind a cookie:

	void fscache_invalidate(struct fscache_cookie *cookie,
				const void *aux_data,
				loff_t size,
				unsigned int flags)

This causes any cached data for the specified cookie to be discarded.  If
the cookie is marked as being in use, a new cache object will be created if
possible and future I/O will use that instead.  In-flight I/O should be
abandoned (writes) or reconsidered (reads).  Each time it is called
cookie->inval_counter is incremented and this can be used to detect
invalidation at the end of an I/O operation.

The coherency data attached to the cookie can be updated and the cookie
size should be reset.  One flag is available, FSCACHE_INVAL_DIO_WRITE,
which should be used to indicate invalidation due to a DIO write on a
file.  This will temporarily disable caching for this cookie.

Changes
=======
ver #2:
 - Should only change to inval state if can get access to cache.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819602231.215744.11206598147269491575.stgit@warthog.procyon.org.uk/ # v1
---

 fs/fscache/cookie.c            |   88 ++++++++++++++++++++++++++++++++++++++++
 fs/fscache/internal.h          |    2 +
 fs/fscache/stats.c             |    5 ++
 include/linux/fscache-cache.h  |    4 ++
 include/linux/fscache.h        |   31 ++++++++++++++
 include/linux/netfs.h          |    1 
 include/trace/events/fscache.h |   25 +++++++++++
 7 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index f2b539c71b91..e287952292c5 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -19,6 +19,7 @@ static void fscache_cookie_lru_timed_out(struct timer_list *timer);
 static void fscache_cookie_lru_worker(struct work_struct *work);
 static void fscache_cookie_worker(struct work_struct *work);
 static void fscache_unhash_cookie(struct fscache_cookie *cookie);
+static void fscache_perform_invalidation(struct fscache_cookie *cookie);
 
 #define fscache_cookie_hash_shift 15
 static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
@@ -28,7 +29,7 @@ static LIST_HEAD(fscache_cookie_lru);
 static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
 DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
 static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
-static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAFUWRD";
+static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
 unsigned int fscache_lru_cookie_timeout = 10 * HZ;
 
 void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
@@ -230,6 +231,19 @@ void fscache_cookie_lookup_negative(struct fscache_cookie *cookie)
 }
 EXPORT_SYMBOL(fscache_cookie_lookup_negative);
 
+/**
+ * fscache_resume_after_invalidation - Allow I/O to resume after invalidation
+ * @cookie: The cookie that was invalidated
+ *
+ * Tell fscache that invalidation is sufficiently complete that I/O can be
+ * allowed again.
+ */
+void fscache_resume_after_invalidation(struct fscache_cookie *cookie)
+{
+	fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_ACTIVE);
+}
+EXPORT_SYMBOL(fscache_resume_after_invalidation);
+
 /**
  * fscache_caching_failed - Report that a failure stopped caching on a cookie
  * @cookie: The cookie that was affected
@@ -560,6 +574,7 @@ void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
 			set_bit(FSCACHE_COOKIE_LOCAL_WRITE, &cookie->flags);
 		break;
 	case FSCACHE_COOKIE_STATE_ACTIVE:
+	case FSCACHE_COOKIE_STATE_INVALIDATING:
 		if (will_modify &&
 		    !test_and_set_bit(FSCACHE_COOKIE_LOCAL_WRITE, &cookie->flags)) {
 			set_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags);
@@ -665,6 +680,11 @@ static void fscache_cookie_state_machine(struct fscache_cookie *cookie)
 		fscache_perform_lookup(cookie);
 		goto again;
 
+	case FSCACHE_COOKIE_STATE_INVALIDATING:
+		spin_unlock(&cookie->lock);
+		fscache_perform_invalidation(cookie);
+		goto again;
+
 	case FSCACHE_COOKIE_STATE_ACTIVE:
 		if (test_and_clear_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags)) {
 			spin_unlock(&cookie->lock);
@@ -955,6 +975,72 @@ struct fscache_cookie *fscache_get_cookie(struct fscache_cookie *cookie,
 }
 EXPORT_SYMBOL(fscache_get_cookie);
 
+/*
+ * Ask the cache to effect invalidation of a cookie.
+ */
+static void fscache_perform_invalidation(struct fscache_cookie *cookie)
+{
+	if (!cookie->volume->cache->ops->invalidate_cookie(cookie))
+		fscache_caching_failed(cookie);
+	fscache_end_cookie_access(cookie, fscache_access_invalidate_cookie_end);
+}
+
+/*
+ * Invalidate an object.
+ */
+void __fscache_invalidate(struct fscache_cookie *cookie,
+			  const void *aux_data, loff_t new_size,
+			  unsigned int flags)
+{
+	bool is_caching;
+
+	_enter("c=%x", cookie->debug_id);
+
+	fscache_stat(&fscache_n_invalidates);
+
+	if (WARN(test_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags),
+		 "Trying to invalidate relinquished cookie\n"))
+		return;
+
+	if ((flags & FSCACHE_INVAL_DIO_WRITE) &&
+	    test_and_set_bit(FSCACHE_COOKIE_DISABLED, &cookie->flags))
+		return;
+
+	spin_lock(&cookie->lock);
+	set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+	fscache_update_aux(cookie, aux_data, &new_size);
+	cookie->inval_counter++;
+	trace_fscache_invalidate(cookie, new_size);
+
+	switch (cookie->state) {
+	case FSCACHE_COOKIE_STATE_INVALIDATING: /* is_still_valid will catch it */
+	default:
+		spin_unlock(&cookie->lock);
+		_leave(" [no %u]", cookie->state);
+		return;
+
+	case FSCACHE_COOKIE_STATE_LOOKING_UP:
+	case FSCACHE_COOKIE_STATE_CREATING:
+		spin_unlock(&cookie->lock);
+		_leave(" [look %x]", cookie->inval_counter);
+		return;
+
+	case FSCACHE_COOKIE_STATE_ACTIVE:
+		is_caching = fscache_begin_cookie_access(
+			cookie, fscache_access_invalidate_cookie);
+		if (is_caching)
+			__fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_INVALIDATING);
+		spin_unlock(&cookie->lock);
+		wake_up_cookie_state(cookie);
+
+		if (is_caching)
+			fscache_queue_cookie(cookie, fscache_cookie_get_inval_work);
+		_leave(" [inv]");
+		return;
+	}
+}
+EXPORT_SYMBOL(__fscache_invalidate);
+
 /*
  * Generate a list of extant cookies in /proc/fs/fscache/cookies
  */
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 9af8de906bf0..e4f3a1a993f6 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -105,6 +105,8 @@ extern atomic_t fscache_n_acquires;
 extern atomic_t fscache_n_acquires_ok;
 extern atomic_t fscache_n_acquires_oom;
 
+extern atomic_t fscache_n_invalidates;
+
 extern atomic_t fscache_n_relinquishes;
 extern atomic_t fscache_n_relinquishes_retire;
 extern atomic_t fscache_n_relinquishes_dropped;
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index 5aa4bd9fe207..cdbb672a274f 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -26,6 +26,8 @@ atomic_t fscache_n_acquires;
 atomic_t fscache_n_acquires_ok;
 atomic_t fscache_n_acquires_oom;
 
+atomic_t fscache_n_invalidates;
+
 atomic_t fscache_n_updates;
 EXPORT_SYMBOL(fscache_n_updates);
 
@@ -59,6 +61,9 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   timer_pending(&fscache_cookie_lru_timer) ?
 		   fscache_cookie_lru_timer.expires - jiffies : 0);
 
+	seq_printf(m, "Invals : n=%u\n",
+		   atomic_read(&fscache_n_invalidates));
+
 	seq_printf(m, "Updates: n=%u\n",
 		   atomic_read(&fscache_n_updates));
 
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index ae6a75976450..1ad56bfd9d72 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -64,6 +64,9 @@ struct fscache_cache_ops {
 	/* Withdraw an object without any cookie access counts held */
 	void (*withdraw_cookie)(struct fscache_cookie *cookie);
 
+	/* Invalidate an object */
+	bool (*invalidate_cookie)(struct fscache_cookie *cookie);
+
 	/* Prepare to write to a live cache object */
 	void (*prepare_to_write)(struct fscache_cookie *cookie);
 };
@@ -96,6 +99,7 @@ extern void fscache_put_cookie(struct fscache_cookie *cookie,
 extern void fscache_end_cookie_access(struct fscache_cookie *cookie,
 				      enum fscache_access_trace why);
 extern void fscache_cookie_lookup_negative(struct fscache_cookie *cookie);
+extern void fscache_resume_after_invalidation(struct fscache_cookie *cookie);
 extern void fscache_caching_failed(struct fscache_cookie *cookie);
 
 /**
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 97f66c88d6f1..39913ccae07f 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -39,6 +39,8 @@ struct fscache_cookie;
 #define FSCACHE_ADV_WRITE_CACHE		0x00 /* Do cache if written to locally */
 #define FSCACHE_ADV_WRITE_NOCACHE	0x02 /* Don't cache if written to locally */
 
+#define FSCACHE_INVAL_DIO_WRITE		0x01 /* Invalidate due to DIO write */
+
 /*
  * Data object state.
  */
@@ -47,6 +49,7 @@ enum fscache_cookie_state {
 	FSCACHE_COOKIE_STATE_LOOKING_UP,	/* The cache object is being looked up */
 	FSCACHE_COOKIE_STATE_CREATING,		/* The cache object is being created */
 	FSCACHE_COOKIE_STATE_ACTIVE,		/* The cache is active, readable and writable */
+	FSCACHE_COOKIE_STATE_INVALIDATING,	/* The cache is being invalidated */
 	FSCACHE_COOKIE_STATE_FAILED,		/* The cache failed, withdraw to clear */
 	FSCACHE_COOKIE_STATE_LRU_DISCARDING,	/* The cookie is being discarded by the LRU */
 	FSCACHE_COOKIE_STATE_WITHDRAWING,	/* The cookie is being withdrawn */
@@ -152,6 +155,7 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
 extern void __fscache_use_cookie(struct fscache_cookie *, bool);
 extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
+extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t, unsigned int);
 
 /**
  * fscache_acquire_volume - Register a volume as desiring caching services
@@ -323,4 +327,31 @@ void __fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data
 	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &cookie->flags);
 }
 
+/**
+ * fscache_invalidate - Notify cache that an object needs invalidation
+ * @cookie: The cookie representing the cache object
+ * @aux_data: The updated auxiliary data for the cookie (may be NULL)
+ * @size: The revised size of the object.
+ * @flags: Invalidation flags (FSCACHE_INVAL_*)
+ *
+ * Notify the cache that an object is needs to be invalidated and that it
+ * should abort any retrievals or stores it is doing on the cache.  This
+ * increments inval_counter on the cookie which can be used by the caller to
+ * reconsider I/O requests as they complete.
+ *
+ * If @flags has FSCACHE_INVAL_DIO_WRITE set, this indicates that this is due
+ * to a direct I/O write and will cause caching to be disabled on this cookie
+ * until it is completely unused.
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
+ * description.
+ */
+static inline
+void fscache_invalidate(struct fscache_cookie *cookie,
+			const void *aux_data, loff_t size, unsigned int flags)
+{
+	if (fscache_cookie_enabled(cookie))
+		__fscache_invalidate(cookie, aux_data, size, flags);
+}
+
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 1ea22fc48818..5a46fde65759 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -124,6 +124,7 @@ struct netfs_cache_resources {
 	void				*cache_priv;
 	void				*cache_priv2;
 	unsigned int			debug_id;	/* Cookie debug ID */
+	unsigned int			inval_counter;	/* object->inval_counter at begin_op */
 };
 
 /*
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index b0409b1fad23..294792881434 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -51,6 +51,7 @@ enum fscache_cookie_trace {
 	fscache_cookie_discard,
 	fscache_cookie_get_end_access,
 	fscache_cookie_get_hash_collision,
+	fscache_cookie_get_inval_work,
 	fscache_cookie_get_lru,
 	fscache_cookie_get_use_work,
 	fscache_cookie_new_acquire,
@@ -73,6 +74,8 @@ enum fscache_access_trace {
 	fscache_access_acquire_volume_end,
 	fscache_access_cache_pin,
 	fscache_access_cache_unpin,
+	fscache_access_invalidate_cookie,
+	fscache_access_invalidate_cookie_end,
 	fscache_access_lookup_cookie,
 	fscache_access_lookup_cookie_end,
 	fscache_access_lookup_cookie_end_failed,
@@ -116,6 +119,7 @@ enum fscache_access_trace {
 	EM(fscache_cookie_discard,		"DISCARD  ")		\
 	EM(fscache_cookie_get_hash_collision,	"GET hcoll")		\
 	EM(fscache_cookie_get_end_access,	"GQ  endac")		\
+	EM(fscache_cookie_get_inval_work,	"GQ  inval")		\
 	EM(fscache_cookie_get_lru,		"GET lru  ")		\
 	EM(fscache_cookie_get_use_work,		"GQ  use  ")		\
 	EM(fscache_cookie_new_acquire,		"NEW acq  ")		\
@@ -137,6 +141,8 @@ enum fscache_access_trace {
 	EM(fscache_access_acquire_volume_end,	"END   acq_vol")	\
 	EM(fscache_access_cache_pin,		"PIN   cache  ")	\
 	EM(fscache_access_cache_unpin,		"UNPIN cache  ")	\
+	EM(fscache_access_invalidate_cookie,	"BEGIN inval  ")	\
+	EM(fscache_access_invalidate_cookie_end,"END   inval  ")	\
 	EM(fscache_access_lookup_cookie,	"BEGIN lookup ")	\
 	EM(fscache_access_lookup_cookie_end,	"END   lookup ")	\
 	EM(fscache_access_lookup_cookie_end_failed,"END   lookupf")	\
@@ -385,6 +391,25 @@ TRACE_EVENT(fscache_relinquish,
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


