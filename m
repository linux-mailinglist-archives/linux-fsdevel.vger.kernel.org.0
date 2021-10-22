Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F58437D68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhJVTGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39772 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234116AbhJVTGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uPsK2EET8IEJnMJtpmULmLqWGURd7EYlMjrboTBSb/U=;
        b=eHY5R/eX2DfctZ11tOlUPCaLkiBPutCmfRkcYA/FSpp5heYuCLTeq1cXMddcEsbGv3W2rc
        z4taOzkt44yTrKe4ZVD0wMiE13Lnk4Dubai9gW1euKVX+nF0g9kZYiOMoBsbYglQ1xAOaE
        g0fqIMXWfcmcgOXXkF2tALVXAJV8u0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-58CjRBA3PSSLEnhO8aQFrA-1; Fri, 22 Oct 2021 15:03:42 -0400
X-MC-Unique: 58CjRBA3PSSLEnhO8aQFrA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B11D936302;
        Fri, 22 Oct 2021 19:03:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DEE45F4E9;
        Fri, 22 Oct 2021 19:03:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 19/53] fscache: Implement cookie user counting and resource
 pinning
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Oct 2021 20:03:33 +0100
Message-ID: <163492941360.1038219.11197146473296223355.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a pair of functions to count the number of users of a cookie
(open files, writeback, invalidation, resizing, reads, writes) and to pin
cache resources for the whilst there are users.

The first function gets a usage on a cookie:

	void fscache_use_cookie(struct fscache_cookie *cookie,
				bool will_modify);

The caller should indicate the cookie to use and whether or not the caller
is in a context that may modify the cookie (e.g. a file open O_RDWR).

If not already open, this will trigger lookup and/or creation of the
backing store in the background and resources may be pinned to the cookie
by the cache.

The second function drops a usage on a cookie and, optionally, updates the
coherency data:

	void fscache_unuse_cookie(struct fscache_cookie *cookie,
				  const void *aux_data,
				  const loff_t *object_size);

If non-NULL, the aux_data buffer and/or the object_size will be saved into
the cookie and will be set on the backing store when the object is
committed.

If this removes the last usage on a cookie, the cookie is placed onto an
LRU list from which it will be removed and closed after a couple of seconds
if it doesn't get reused.  This prevents resource overload in the cache -
in particular it prevents it from holding too many files open.

Changes
=======
ver #2:
  - Fix fscache_unuse_cookie() to use atomic_dec_and_lock() to avoid a
    potential race if the cookie gets reused before it completes the
    unusement.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/fscache/cookie.c            |  207 ++++++++++++++++++++++++++++++++++++++++
 fs/fscache/internal.h          |    5 +
 fs/fscache/stats.c             |   12 ++
 include/linux/fscache-cache.h  |   14 +++
 include/linux/fscache.h        |   82 ++++++++++++++++
 include/trace/events/fscache.h |   12 ++
 6 files changed, 331 insertions(+), 1 deletion(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index b7373ebcaf56..cf987756534c 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -15,6 +15,8 @@
 
 struct kmem_cache *fscache_cookie_jar;
 
+static void fscache_cookie_lru_timed_out(struct timer_list *timer);
+static void fscache_cookie_lru_worker(struct work_struct *work);
 static void fscache_cookie_worker(struct work_struct *work);
 static void fscache_drop_cookie(struct fscache_cookie *cookie);
 static void fscache_lookup_cookie(struct fscache_cookie *cookie);
@@ -23,7 +25,12 @@ static void fscache_lookup_cookie(struct fscache_cookie *cookie);
 static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
 static LIST_HEAD(fscache_cookies);
 static DEFINE_RWLOCK(fscache_cookies_lock);
-static const char fscache_cookie_stages[FSCACHE_COOKIE_STAGE__NR] = "-LCAFWRD";
+static LIST_HEAD(fscache_cookie_lru);
+static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
+DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
+static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
+static const char fscache_cookie_stages[FSCACHE_COOKIE_STAGE__NR] = "-LCAFMWRD";
+unsigned int fscache_lru_cookie_timeout = 10 * HZ;
 
 void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 {
@@ -48,6 +55,13 @@ void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 
 static void fscache_free_cookie(struct fscache_cookie *cookie)
 {
+	if (WARN_ON_ONCE(!list_empty(&cookie->commit_link))) {
+		spin_lock(&fscache_cookie_lru_lock);
+		list_del_init(&cookie->commit_link);
+		spin_unlock(&fscache_cookie_lru_lock);
+		fscache_stat_d(&fscache_n_cookies_lru);
+		fscache_stat(&fscache_n_cookies_lru_removed);
+	}
 	write_lock(&fscache_cookies_lock);
 	list_del(&cookie->proc_link);
 	write_unlock(&fscache_cookies_lock);
@@ -442,6 +456,122 @@ static void fscache_lookup_cookie(struct fscache_cookie *cookie)
 	fscache_end_volume_access(cookie->volume, fscache_access_lookup_cookie_end);
 }
 
+/*
+ * Start using the cookie for I/O.  This prevents the backing object from being
+ * reaped by VM pressure.
+ */
+void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
+{
+	enum fscache_cookie_stage stage;
+	bool changed_stage = false, queue = false;
+
+	_enter("c=%08x", cookie->debug_id);
+
+	if (WARN(test_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags),
+		 "Trying to use relinquished cookie\n"))
+		return;
+
+	spin_lock(&cookie->lock);
+
+	atomic_inc(&cookie->n_active);
+
+again:
+	stage = cookie->stage;
+	switch (stage) {
+	case FSCACHE_COOKIE_STAGE_QUIESCENT:
+		if (will_modify) {
+			set_bit(FSCACHE_COOKIE_LOCAL_WRITE, &cookie->flags);
+			set_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags);
+		}
+		if (!fscache_begin_volume_access(cookie->volume,
+						 fscache_access_lookup_cookie))
+			break;
+
+		__fscache_begin_cookie_access(cookie, fscache_access_lookup_cookie);
+		__fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_LOOKING_UP);
+		smp_mb__before_atomic(); /* Set stage before is-caching
+					  * vs __fscache_begin_cookie_access()
+					  */
+		set_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags);
+		set_bit(FSCACHE_COOKIE_HAS_BEEN_CACHED, &cookie->flags);
+		changed_stage = true;
+		queue = true;
+		break;
+
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+	case FSCACHE_COOKIE_STAGE_CREATING:
+		if (will_modify)
+			set_bit(FSCACHE_COOKIE_LOCAL_WRITE, &cookie->flags);
+		break;
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+		if (will_modify &&
+		    !test_and_set_bit(FSCACHE_COOKIE_LOCAL_WRITE, &cookie->flags)) {
+			set_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags);
+			queue = true;
+		}
+		break;
+
+	case FSCACHE_COOKIE_STAGE_FAILED:
+	case FSCACHE_COOKIE_STAGE_WITHDRAWING:
+		break;
+
+	case FSCACHE_COOKIE_STAGE_COMMITTING:
+		spin_unlock(&cookie->lock);
+		wait_var_event(&cookie->stage,
+			       READ_ONCE(cookie->stage) != FSCACHE_COOKIE_STAGE_COMMITTING);
+		spin_lock(&cookie->lock);
+		goto again;
+
+	case FSCACHE_COOKIE_STAGE_DROPPED:
+	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
+		WARN(1, "Can't use cookie in stage %u\n", cookie->stage);
+		break;
+	}
+
+	spin_unlock(&cookie->lock);
+	if (changed_stage)
+		wake_up_cookie_stage(cookie);
+	if (queue)
+		fscache_queue_cookie(cookie, fscache_cookie_get_use_work);
+	_leave("");
+}
+EXPORT_SYMBOL(__fscache_use_cookie);
+
+static void fscache_unuse_cookie_locked(struct fscache_cookie *cookie)
+{
+	clear_bit(FSCACHE_COOKIE_DISABLED, &cookie->flags);
+	if (!test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags))
+		return;
+
+	cookie->unused_at = jiffies;
+	spin_lock(&fscache_cookie_lru_lock);
+	if (list_empty(&cookie->commit_link)) {
+		fscache_get_cookie(cookie, fscache_cookie_get_lru);
+		fscache_stat(&fscache_n_cookies_lru);
+	}
+	list_move_tail(&cookie->commit_link, &fscache_cookie_lru);
+
+	spin_unlock(&fscache_cookie_lru_lock);
+	timer_reduce(&fscache_cookie_lru_timer,
+		     jiffies + fscache_lru_cookie_timeout);
+}
+
+/*
+ * Stop using the cookie for I/O.
+ */
+void __fscache_unuse_cookie(struct fscache_cookie *cookie,
+			    const void *aux_data, const loff_t *object_size)
+{
+	if (aux_data || object_size)
+		__fscache_update_cookie(cookie, aux_data, object_size);
+
+	if (atomic_dec_and_lock(&cookie->n_active, &cookie->lock)) {
+		fscache_unuse_cookie_locked(cookie);
+		spin_unlock(&cookie->lock);
+	}
+}
+EXPORT_SYMBOL(__fscache_unuse_cookie);
+
 /*
  * Perform work upon the cookie, such as committing its cache state,
  * relinquishing it or withdrawing the backing cache.  We're protected from the
@@ -471,6 +601,7 @@ static void __fscache_cookie_worker(struct fscache_cookie *cookie)
 	case FSCACHE_COOKIE_STAGE_FAILED:
 		break;
 
+	case FSCACHE_COOKIE_STAGE_COMMITTING:
 	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
 	case FSCACHE_COOKIE_STAGE_WITHDRAWING:
 		if (test_and_clear_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags) &&
@@ -480,6 +611,8 @@ static void __fscache_cookie_worker(struct fscache_cookie *cookie)
 			fscache_see_cookie(cookie, fscache_cookie_see_relinquish);
 			fscache_drop_cookie(cookie);
 			break;
+		} else if (cookie->stage == FSCACHE_COOKIE_STAGE_COMMITTING) {
+			fscache_see_cookie(cookie, fscache_cookie_see_committing);
 		} else {
 			fscache_see_cookie(cookie, fscache_cookie_see_withdraw);
 		}
@@ -519,6 +652,77 @@ static void __fscache_withdraw_cookie(struct fscache_cookie *cookie)
 		__fscache_end_cookie_access(cookie);
 }
 
+static void fscache_cookie_lru_do_one(struct fscache_cookie *cookie)
+{
+	fscache_see_cookie(cookie, fscache_cookie_see_lru_do_one);
+
+	spin_lock(&cookie->lock);
+	if (cookie->stage != FSCACHE_COOKIE_STAGE_ACTIVE ||
+	    time_before(jiffies, cookie->unused_at + fscache_lru_cookie_timeout) ||
+	    atomic_read(&cookie->n_active) > 0) {
+		spin_unlock(&cookie->lock);
+		fscache_stat(&fscache_n_cookies_lru_removed);
+	} else {
+		__fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_COMMITTING);
+		set_bit(FSCACHE_COOKIE_DO_COMMIT, &cookie->flags);
+		spin_unlock(&cookie->lock);
+		fscache_stat(&fscache_n_cookies_lru_expired);
+		_debug("lru c=%x", cookie->debug_id);
+		__fscache_withdraw_cookie(cookie);
+	}
+
+	fscache_put_cookie(cookie, fscache_cookie_put_lru);
+}
+
+static void fscache_cookie_lru_worker(struct work_struct *work)
+{
+	struct fscache_cookie *cookie;
+	unsigned long unused_at;
+
+	spin_lock(&fscache_cookie_lru_lock);
+
+	while (!list_empty(&fscache_cookie_lru)) {
+		cookie = list_first_entry(&fscache_cookie_lru,
+					  struct fscache_cookie, commit_link);
+		unused_at = cookie->unused_at + fscache_lru_cookie_timeout;
+		if (time_before(jiffies, unused_at)) {
+			timer_reduce(&fscache_cookie_lru_timer, unused_at);
+			break;
+		}
+
+		list_del_init(&cookie->commit_link);
+		fscache_stat_d(&fscache_n_cookies_lru);
+		spin_unlock(&fscache_cookie_lru_lock);
+		fscache_cookie_lru_do_one(cookie);
+		spin_lock(&fscache_cookie_lru_lock);
+	}
+
+	spin_unlock(&fscache_cookie_lru_lock);
+}
+
+static void fscache_cookie_lru_timed_out(struct timer_list *timer)
+{
+	queue_work(fscache_wq, &fscache_cookie_lru_work);
+}
+
+static void fscache_cookie_drop_from_lru(struct fscache_cookie *cookie)
+{
+	bool need_put = false;
+
+	if (!list_empty(&cookie->commit_link)) {
+		spin_lock(&fscache_cookie_lru_lock);
+		if (!list_empty(&cookie->commit_link)) {
+			list_del_init(&cookie->commit_link);
+			fscache_stat_d(&fscache_n_cookies_lru);
+			fscache_stat(&fscache_n_cookies_lru_dropped);
+			need_put = true;
+		}
+		spin_unlock(&fscache_cookie_lru_lock);
+		if (need_put)
+			fscache_put_cookie(cookie, fscache_cookie_put_lru);
+	}
+}
+
 /*
  * Remove a cookie from the hash table.
  */
@@ -551,6 +755,7 @@ static void fscache_drop_cookie(struct fscache_cookie *cookie)
 
 static void fscache_drop_withdraw_cookie(struct fscache_cookie *cookie)
 {
+	fscache_cookie_drop_from_lru(cookie);
 	__fscache_withdraw_cookie(cookie);
 }
 
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 5669ba4bc8a9..5aff9c143616 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -32,6 +32,7 @@ struct fscache_cache *fscache_lookup_cache(const char *name, bool is_cache);
  */
 extern struct kmem_cache *fscache_cookie_jar;
 extern const struct seq_operations fscache_cookies_seq_ops;
+extern struct timer_list fscache_cookie_lru_timer;
 
 extern void fscache_print_cookie(struct fscache_cookie *cookie, char prefix);
 extern bool fscache_begin_cookie_access(struct fscache_cookie *cookie,
@@ -70,6 +71,10 @@ extern atomic_t fscache_n_volumes;
 extern atomic_t fscache_n_volumes_collision;
 extern atomic_t fscache_n_volumes_nomem;
 extern atomic_t fscache_n_cookies;
+extern atomic_t fscache_n_cookies_lru;
+extern atomic_t fscache_n_cookies_lru_expired;
+extern atomic_t fscache_n_cookies_lru_removed;
+extern atomic_t fscache_n_cookies_lru_dropped;
 
 extern atomic_t fscache_n_acquires;
 extern atomic_t fscache_n_acquires_null;
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index fd2bd08c1ecb..17bf57374595 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -17,6 +17,10 @@ atomic_t fscache_n_volumes;
 atomic_t fscache_n_volumes_collision;
 atomic_t fscache_n_volumes_nomem;
 atomic_t fscache_n_cookies;
+atomic_t fscache_n_cookies_lru;
+atomic_t fscache_n_cookies_lru_expired;
+atomic_t fscache_n_cookies_lru_removed;
+atomic_t fscache_n_cookies_lru_dropped;
 
 atomic_t fscache_n_acquires;
 atomic_t fscache_n_acquires_null;
@@ -51,6 +55,14 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_acquires_ok),
 		   atomic_read(&fscache_n_acquires_oom));
 
+	seq_printf(m, "LRU    : n=%u exp=%u rmv=%u drp=%u at=%ld\n",
+		   atomic_read(&fscache_n_cookies_lru),
+		   atomic_read(&fscache_n_cookies_lru_expired),
+		   atomic_read(&fscache_n_cookies_lru_removed),
+		   atomic_read(&fscache_n_cookies_lru_dropped),
+		   timer_pending(&fscache_cookie_lru_timer) ?
+		   fscache_cookie_lru_timer.expires - jiffies : 0);
+
 	seq_printf(m, "Updates: n=%u\n",
 		   atomic_read(&fscache_n_updates));
 
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index f6d63dc0ffa9..a67c29207ad5 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -132,6 +132,20 @@ static inline void *fscache_get_key(struct fscache_cookie *cookie)
 		return cookie->key;
 }
 
+/**
+ * fscache_cookie_lookup_negative - Note negative lookup
+ * @cookie: The cookie that was being looked up
+ *
+ * Note that some part of the metadata path in the cache doesn't exist and so
+ * we can release any waiting readers in the certain knowledge that there's
+ * nothing for them to actually read.
+ */
+static inline void fscache_cookie_lookup_negative(struct fscache_cookie *cookie)
+{
+	set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+	fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_CREATING);
+}
+
 extern struct workqueue_struct *fscache_wq;
 
 #endif /* _LINUX_FSCACHE_CACHE_H */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index ebdc0fd1f309..df985507fa5e 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -27,11 +27,15 @@
 #define fscache_available() (1)
 #define fscache_volume_valid(volume) (volume)
 #define fscache_cookie_valid(cookie) (cookie)
+#define fscache_resources_valid(cres) ((cres)->cache_priv)
+#define fscache_cookie_enabled(cookie) (cookie && !test_bit(FSCACHE_COOKIE_DISABLED, &cookie->flags))
 #else
 #define __fscache_available (0)
 #define fscache_available() (0)
 #define fscache_volume_valid(volume) (0)
 #define fscache_cookie_valid(cookie) (0)
+#define fscache_resources_valid(cres) (false)
+#define fscache_cookie_enabled(cookie) (0)
 #endif
 
 struct fscache_cookie;
@@ -50,6 +54,7 @@ enum fscache_cookie_stage {
 	FSCACHE_COOKIE_STAGE_CREATING,		/* The cache object is being created */
 	FSCACHE_COOKIE_STAGE_ACTIVE,		/* The cache is active, readable and writable */
 	FSCACHE_COOKIE_STAGE_FAILED,		/* The cache failed, withdraw to clear */
+	FSCACHE_COOKIE_STAGE_COMMITTING,	/* The cookie is being committed */
 	FSCACHE_COOKIE_STAGE_WITHDRAWING,	/* The cookie is being withdrawn */
 	FSCACHE_COOKIE_STAGE_RELINQUISHING,	/* The cookie is being relinquished */
 	FSCACHE_COOKIE_STAGE_DROPPED,		/* The cookie has been dropped */
@@ -150,6 +155,8 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
 	const void *, size_t,
 	const void *, size_t,
 	loff_t);
+extern void __fscache_use_cookie(struct fscache_cookie *, bool);
+extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 
 /**
@@ -224,6 +231,39 @@ struct fscache_cookie *fscache_acquire_cookie(struct fscache_volume *volume,
 					object_size);
 }
 
+/**
+ * fscache_use_cookie - Request usage of cookie attached to an object
+ * @object: Object description
+ * @will_modify: If cache is expected to be modified locally
+ *
+ * Request usage of the cookie attached to an object.  The caller should tell
+ * the cache if the object's contents are about to be modified locally and then
+ * the cache can apply the policy that has been set to handle this case.
+ */
+static inline void fscache_use_cookie(struct fscache_cookie *cookie,
+				      bool will_modify)
+{
+	if (fscache_cookie_valid(cookie))
+		__fscache_use_cookie(cookie, will_modify);
+}
+
+/**
+ * fscache_unuse_cookie - Cease usage of cookie attached to an object
+ * @object: Object description
+ * @aux_data: Updated auxiliary data (or NULL)
+ * @object_size: Revised size of the object (or NULL)
+ *
+ * Cease usage of the cookie attached to an object.  When the users count
+ * reaches zero then the cookie relinquishment will be permitted to proceed.
+ */
+static inline void fscache_unuse_cookie(struct fscache_cookie *cookie,
+					const void *aux_data,
+					const loff_t *object_size)
+{
+	if (fscache_cookie_valid(cookie))
+		__fscache_unuse_cookie(cookie, aux_data, object_size);
+}
+
 /**
  * fscache_relinquish_cookie - Return the cookie to the cache, maybe discarding
  * it
@@ -243,4 +283,46 @@ void fscache_relinquish_cookie(struct fscache_cookie *cookie, bool retire)
 		__fscache_relinquish_cookie(cookie, retire);
 }
 
+/*
+ * Find the auxiliary data on a cookie.
+ */
+static inline void *fscache_get_aux(struct fscache_cookie *cookie)
+{
+	if (cookie->aux_len <= sizeof(cookie->inline_aux))
+		return cookie->inline_aux;
+	else
+		return cookie->aux;
+}
+
+/*
+ * Update the auxiliary data on a cookie.
+ */
+static inline
+void fscache_update_aux(struct fscache_cookie *cookie,
+			const void *aux_data, const loff_t *object_size)
+{
+	void *p = fscache_get_aux(cookie);
+
+	if (aux_data && p)
+		memcpy(p, aux_data, cookie->aux_len);
+	if (object_size)
+		cookie->object_size = *object_size;
+}
+
+#ifdef CONFIG_FSCACHE_STATS
+extern atomic_t fscache_n_updates;
+#endif
+
+static inline
+void __fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data,
+			     const loff_t *object_size)
+{
+#ifdef CONFIG_FSCACHE_STATS
+	atomic_inc(&fscache_n_updates);
+#endif
+	fscache_update_aux(cookie, aux_data, object_size);
+	smp_wmb();
+	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &cookie->flags);
+}
+
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 00ffe0f8e6d3..2b31ef34efa2 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -50,13 +50,18 @@ enum fscache_cookie_trace {
 	fscache_cookie_discard,
 	fscache_cookie_get_end_access,
 	fscache_cookie_get_hash_collision,
+	fscache_cookie_get_lru,
+	fscache_cookie_get_use_work,
 	fscache_cookie_new_acquire,
 	fscache_cookie_put_hash_collision,
+	fscache_cookie_put_lru,
 	fscache_cookie_put_over_queued,
 	fscache_cookie_put_relinquish,
 	fscache_cookie_put_withdrawn,
 	fscache_cookie_put_work,
 	fscache_cookie_see_active,
+	fscache_cookie_see_lru_do_one,
+	fscache_cookie_see_committing,
 	fscache_cookie_see_relinquish,
 	fscache_cookie_see_withdraw,
 	fscache_cookie_see_work,
@@ -67,6 +72,7 @@ enum fscache_access_trace {
 	fscache_access_acquire_volume_end,
 	fscache_access_cache_pin,
 	fscache_access_cache_unpin,
+	fscache_access_lookup_cookie,
 	fscache_access_lookup_cookie_end,
 	fscache_access_relinquish_volume,
 	fscache_access_relinquish_volume_end,
@@ -107,13 +113,18 @@ enum fscache_access_trace {
 	EM(fscache_cookie_discard,		"DISCARD  ")		\
 	EM(fscache_cookie_get_hash_collision,	"GET hcoll")		\
 	EM(fscache_cookie_get_end_access,	"GQ  endac")		\
+	EM(fscache_cookie_get_lru,		"GET lru  ")		\
+	EM(fscache_cookie_get_use_work,		"GQ  use  ")		\
 	EM(fscache_cookie_new_acquire,		"NEW acq  ")		\
 	EM(fscache_cookie_put_hash_collision,	"PUT hcoll")		\
+	EM(fscache_cookie_put_lru,		"PUT lru  ")		\
 	EM(fscache_cookie_put_over_queued,	"PQ  overq")		\
 	EM(fscache_cookie_put_relinquish,	"PUT relnq")		\
 	EM(fscache_cookie_put_withdrawn,	"PUT wthdn")		\
 	EM(fscache_cookie_put_work,		"PQ  work ")		\
 	EM(fscache_cookie_see_active,		"-   active")		\
+	EM(fscache_cookie_see_lru_do_one,	"-   lrudo")		\
+	EM(fscache_cookie_see_committing,	"-   x-cmt")		\
 	EM(fscache_cookie_see_relinquish,	"-   x-rlq")		\
 	EM(fscache_cookie_see_withdraw,		"-   x-wth")		\
 	E_(fscache_cookie_see_work,		"-   work ")
@@ -123,6 +134,7 @@ enum fscache_access_trace {
 	EM(fscache_access_acquire_volume_end,	"END   acq_vol")	\
 	EM(fscache_access_cache_pin,		"PIN   cache  ")	\
 	EM(fscache_access_cache_unpin,		"UNPIN cache  ")	\
+	EM(fscache_access_lookup_cookie,	"BEGIN lookup ")	\
 	EM(fscache_access_lookup_cookie_end,	"END   lookup ")	\
 	EM(fscache_access_relinquish_volume,	"BEGIN rlq_vol")	\
 	EM(fscache_access_relinquish_volume_end,"END   rlq_vol")	\


