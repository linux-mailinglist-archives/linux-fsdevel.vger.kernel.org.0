Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34533461870
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245425AbhK2Obi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:31:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378195AbhK2O3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638195960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9XjuMt78gXUZmOcKgW3fQLemJXdAKoOgxZQZDYQsxWM=;
        b=EXJS0woBkKy+3bB5DPkcJG6lW1FtIJv6r2uocJiGWSsmKBZ2JKAcZW1rQ3jbzPxzGAxWRk
        J3KhNVLIWcK2jqyN0kTv+YdmbRwNUcX/qsHGVIVuTgNT0yNBEBMBWmaNkTzx7g3YdwoAlq
        B6wZMyI/54DfGH3kH9Ge7j8N7VDc5M8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-SAOgnYhwP1iqCyj7uZeaEw-1; Mon, 29 Nov 2021 09:25:57 -0500
X-MC-Unique: SAOgnYhwP1iqCyj7uZeaEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02D371018725;
        Mon, 29 Nov 2021 14:25:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA18757CD2;
        Mon, 29 Nov 2021 14:25:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/64] fscache: Implement cookie-level access helpers
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
Date:   Mon, 29 Nov 2021 14:25:50 +0000
Message-ID: <163819595085.215744.1706073049250505427.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a number of helper functions to manage access to a cookie, pinning the
cache object in place for the duration to prevent cache withdrawal from
removing it:

 (1) void fscache_init_access_gate(struct fscache_cookie *cookie);

     This function initialises the access count when a cache binds to a
     cookie.  An extra ref is taken on the access count to prevent wakeups
     while the cache is active.  We're only interested in the wakeup when a
     cookie is being withdrawn and we're waiting for it to quiesce - at
     which point the counter will be decremented before the wait.

     The FSCACHE_COOKIE_NACC_ELEVATED flag is set on the cookie to keep
     track of the extra ref in order to handle a race between
     relinquishment and withdrawal both trying to drop the extra ref.

 (2) bool fscache_begin_cookie_access(struct fscache_cookie *cookie,
				      enum fscache_access_trace why);

     This function attempts to begin access upon a cookie, pinning it in
     place if it's cached.  If successful, it returns true and leaves a the
     access count incremented.

 (3) void fscache_end_cookie_access(struct fscache_cookie *cookie,
				    enum fscache_access_trace why);

     This function drops the access count obtained by (2), permitting
     object withdrawal to take place when it reaches zero.

A tracepoint is provided to track changes to the access counter on a
cookie.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/fscache/cookie.c            |  104 ++++++++++++++++++++++++++++++++++++++++
 fs/fscache/internal.h          |    3 +
 fs/fscache/main.c              |    1 
 include/linux/fscache-cache.h  |    2 +
 include/trace/events/fscache.h |   29 +++++++++++
 5 files changed, 139 insertions(+)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index c790f08e2f52..3dd150182d97 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -57,6 +57,110 @@ static void fscache_free_cookie(struct fscache_cookie *cookie)
 	kmem_cache_free(fscache_cookie_jar, cookie);
 }
 
+/*
+ * Initialise the access gate on a cookie by keeping its n_accesses counter
+ * raised by 1.  This will prevent end-access from transitioning it to 0 until
+ * we decrement when we withdraw caching services from the cookie.
+ */
+static void fscache_init_access_gate(struct fscache_cookie *cookie)
+{
+	int n_accesses;
+
+	n_accesses = atomic_inc_return(&cookie->n_accesses);
+	trace_fscache_access(cookie->debug_id, refcount_read(&cookie->ref),
+			     n_accesses, fscache_access_cache_pin);
+	set_bit(FSCACHE_COOKIE_NACC_ELEVATED, &cookie->flags);
+}
+
+static void __fscache_end_cookie_access(struct fscache_cookie *cookie)
+{
+	if (test_bit(FSCACHE_COOKIE_DO_RELINQUISH, &cookie->flags))
+		fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_RELINQUISHING);
+	else if (test_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags))
+		fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_WITHDRAWING);
+	// PLACEHOLDER: Schedule cookie cleanup
+}
+
+/**
+ * fscache_end_cookie_access - Unpin a cache at the end of an access.
+ * @cookie: A data file cookie
+ * @why: An indication of the circumstances of the access for tracing
+ *
+ * Unpin a cache cookie after we've accessed it and bring a deferred
+ * relinquishment or withdrawal state into effect.
+ *
+ * The @why indicator is provided for tracing purposes.
+ */
+void fscache_end_cookie_access(struct fscache_cookie *cookie,
+			       enum fscache_access_trace why)
+{
+	int n_accesses;
+
+	smp_mb__before_atomic();
+	n_accesses = atomic_dec_return(&cookie->n_accesses);
+	trace_fscache_access(cookie->debug_id, refcount_read(&cookie->ref),
+			     n_accesses, why);
+	if (n_accesses == 0)
+		__fscache_end_cookie_access(cookie);
+}
+EXPORT_SYMBOL(fscache_end_cookie_access);
+
+/*
+ * Pin the cache behind a cookie so that we can access it.
+ */
+static void __fscache_begin_cookie_access(struct fscache_cookie *cookie,
+					  enum fscache_access_trace why)
+{
+	int n_accesses;
+
+	n_accesses = atomic_inc_return(&cookie->n_accesses);
+	smp_mb__after_atomic(); /* (Future) read state after is-caching.
+				 * Reread n_accesses after is-caching
+				 */
+	trace_fscache_access(cookie->debug_id, refcount_read(&cookie->ref),
+			     n_accesses, why);
+}
+
+/**
+ * fscache_begin_cookie_access - Pin a cache so data can be accessed
+ * @cookie: A data file cookie
+ * @why: An indication of the circumstances of the access for tracing
+ *
+ * Attempt to pin the cache to prevent it from going away whilst we're
+ * accessing data and returns true if successful.  This works as follows:
+ *
+ *  (1) If the cookie is not being cached (ie. FSCACHE_COOKIE_IS_CACHING is not
+ *      set), we return false to indicate access was not permitted.
+ *
+ *  (2) If the cookie is being cached, we increment its n_accesses count and
+ *      then recheck the IS_CACHING flag, ending the access if it got cleared.
+ *
+ *  (3) When we end the access, we decrement the cookie's n_accesses and wake
+ *      up the any waiters if it reaches 0.
+ *
+ *  (4) Whilst the cookie is actively being cached, its n_accesses is kept
+ *      artificially incremented to prevent wakeups from happening.
+ *
+ *  (5) When the cache is taken offline or if the cookie is culled, the flag is
+ *      cleared to prevent new accesses, the cookie's n_accesses is decremented
+ *      and we wait for it to become 0.
+ *
+ * The @why indicator are merely provided for tracing purposes.
+ */
+bool fscache_begin_cookie_access(struct fscache_cookie *cookie,
+				 enum fscache_access_trace why)
+{
+	if (!test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags))
+		return false;
+	__fscache_begin_cookie_access(cookie, why);
+	if (!test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags) ||
+	    !fscache_cache_is_live(cookie->volume->cache)) {
+		fscache_end_cookie_access(cookie, fscache_access_unlive);
+		return false;
+	}
+	return true;
+}
+
 static inline void wake_up_cookie_state(struct fscache_cookie *cookie)
 {
 	/* Use a barrier to ensure that waiters see the state variable
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 8727419870aa..712be6819297 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -59,6 +59,9 @@ extern struct kmem_cache *fscache_cookie_jar;
 extern const struct seq_operations fscache_cookies_seq_ops;
 
 extern void fscache_print_cookie(struct fscache_cookie *cookie, char prefix);
+extern bool fscache_begin_cookie_access(struct fscache_cookie *cookie,
+					enum fscache_access_trace why);
+
 static inline void fscache_see_cookie(struct fscache_cookie *cookie,
 				      enum fscache_cookie_trace where)
 {
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index 6a024c45eb0b..01d57433702c 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -23,6 +23,7 @@ MODULE_PARM_DESC(fscache_debug,
 
 EXPORT_TRACEPOINT_SYMBOL(fscache_access_cache);
 EXPORT_TRACEPOINT_SYMBOL(fscache_access_volume);
+EXPORT_TRACEPOINT_SYMBOL(fscache_access);
 
 struct workqueue_struct *fscache_wq;
 EXPORT_SYMBOL(fscache_wq);
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index fbbd8a2afe12..66624407ba84 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -61,6 +61,8 @@ extern struct fscache_cookie *fscache_get_cookie(struct fscache_cookie *cookie,
 						 enum fscache_cookie_trace where);
 extern void fscache_put_cookie(struct fscache_cookie *cookie,
 			       enum fscache_cookie_trace where);
+extern void fscache_end_cookie_access(struct fscache_cookie *cookie,
+				      enum fscache_access_trace why);
 extern void fscache_set_cookie_state(struct fscache_cookie *cookie,
 				     enum fscache_cookie_state state);
 
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 104aad12021b..33ef0b23cd6a 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -279,6 +279,35 @@ TRACE_EVENT(fscache_access_volume,
 		      __entry->n_accesses)
 	    );
 
+TRACE_EVENT(fscache_access,
+	    TP_PROTO(unsigned int cookie_debug_id,
+		     int ref,
+		     int n_accesses,
+		     enum fscache_access_trace why),
+
+	    TP_ARGS(cookie_debug_id, ref, n_accesses, why),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(int,			ref		)
+		    __field(int,			n_accesses	)
+		    __field(enum fscache_access_trace,	why		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie	= cookie_debug_id;
+		    __entry->ref	= ref;
+		    __entry->n_accesses	= n_accesses;
+		    __entry->why	= why;
+			   ),
+
+	    TP_printk("c=%08x %s r=%d a=%d",
+		      __entry->cookie,
+		      __print_symbolic(__entry->why, fscache_access_traces),
+		      __entry->ref,
+		      __entry->n_accesses)
+	    );
+
 TRACE_EVENT(fscache_acquire,
 	    TP_PROTO(struct fscache_cookie *cookie),
 


