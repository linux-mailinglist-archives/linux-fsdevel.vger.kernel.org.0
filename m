Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF8C437D61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhJVTFz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233084AbhJVTFt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEfe6lR+qYZYzVj4yxqkRultAkrJujyyAETGqSzEksk=;
        b=hzzdZOact9/rVANR6i3i+dKsZeC2Lc7kvIjf8l2YA9X5e0xZALgYAPl1Xc400s1V9Fg6A2
        /NMikZwCQ+B1PA6+EDJN4khfkfTXHdsVrH2KCacLmXtLMsAmL2lwyc9wQhunmJ9gjtapCn
        lf1CAk463uK/TGeutzJbQeCUEcz+nzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-UTZcjr9WNumVSmgp13rYCA-1; Fri, 22 Oct 2021 15:03:30 -0400
X-MC-Unique: UTZcjr9WNumVSmgp13rYCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E925801B00;
        Fri, 22 Oct 2021 19:03:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA3E660C04;
        Fri, 22 Oct 2021 19:03:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 18/53] fscache: Implement simple cookie state machine
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
Date:   Fri, 22 Oct 2021 20:03:22 +0100
Message-ID: <163492940195.1038219.17728963178964131703.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a very simple cookie state machine to handle lookup, withdrawal,
relinquishment and, eventually, timed committing and invalidation.

Changes
=======
ver #2)
  - Fix a number of oopses when the cache tries to access cookie->object,
    but the cache withdrew the object due to lookup failure at just the
    wrong time (fscache_lookup_cookie() should call
    fscache_withdraw_cookie() rather than calling the cache directly).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/CAB9dFdumxi0U_339S3PfC4TL83Srqn+qGz2AAbJ995NiLhbxnw@mail.gmail.com/
---

 fs/fscache/cookie.c            |  170 +++++++++++++++++++++++++++++++++++++++-
 include/linux/fscache-cache.h  |   10 ++
 include/trace/events/fscache.h |    2 
 3 files changed, 179 insertions(+), 3 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 9b6ddbc01825..b7373ebcaf56 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -15,7 +15,9 @@
 
 struct kmem_cache *fscache_cookie_jar;
 
+static void fscache_cookie_worker(struct work_struct *work);
 static void fscache_drop_cookie(struct fscache_cookie *cookie);
+static void fscache_lookup_cookie(struct fscache_cookie *cookie);
 
 #define fscache_cookie_hash_shift 15
 static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
@@ -57,13 +59,26 @@ static void fscache_free_cookie(struct fscache_cookie *cookie)
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
 static void __fscache_end_cookie_access(struct fscache_cookie *cookie)
 {
 	if (test_bit(FSCACHE_COOKIE_DO_RELINQUISH, &cookie->flags))
 		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_RELINQUISHING);
 	else if (test_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags))
 		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_WITHDRAWING);
-	// PLACEHOLDER: Schedule cookie cleanup
+	fscache_queue_cookie(cookie, fscache_cookie_get_end_access);
 }
 
 /*
@@ -252,7 +267,7 @@ static struct fscache_cookie *fscache_alloc_cookie(
 	cookie->stage = FSCACHE_COOKIE_STAGE_QUIESCENT;
 	spin_lock_init(&cookie->lock);
 	INIT_LIST_HEAD(&cookie->commit_link);
-	INIT_WORK(&cookie->work, NULL /* PLACEHOLDER */);
+	INIT_WORK(&cookie->work, fscache_cookie_worker);
 
 	write_lock(&fscache_cookies_lock);
 	list_add_tail(&cookie->proc_link, &fscache_cookies);
@@ -374,6 +389,136 @@ struct fscache_cookie *__fscache_acquire_cookie(
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
+ * Look up a cookie to the cache.
+ */
+static void fscache_lookup_cookie(struct fscache_cookie *cookie)
+{
+	bool changed_stage = false, need_withdraw = false, prep_write = false;
+
+	_enter("");
+
+	if (!cookie->volume->cache_priv) {
+		fscache_create_volume(cookie->volume, true);
+		if (!cookie->volume->cache_priv) {
+			fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_QUIESCENT);
+			goto out;
+		}
+	}
+
+	if (!cookie->volume->cache->ops->lookup_cookie(cookie)) {
+		if (cookie->stage != FSCACHE_COOKIE_STAGE_FAILED)
+			fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_QUIESCENT);
+		need_withdraw = true;
+		_leave(" [fail]");
+		goto out;
+	}
+
+	spin_lock(&cookie->lock);
+	if (cookie->stage != FSCACHE_COOKIE_STAGE_RELINQUISHING) {
+		prep_write = test_bit(FSCACHE_COOKIE_LOCAL_WRITE, &cookie->flags);
+		__fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_ACTIVE);
+		fscache_see_cookie(cookie, fscache_cookie_see_active);
+		changed_stage = true;
+	}
+	spin_unlock(&cookie->lock);
+	if (changed_stage)
+		wake_up_cookie_stage(cookie);
+	if (prep_write)
+		fscache_prepare_to_write(cookie);
+
+out:
+	fscache_end_cookie_access(cookie, fscache_access_lookup_cookie_end);
+	if (need_withdraw)
+		fscache_withdraw_cookie(cookie);
+	fscache_end_volume_access(cookie->volume, fscache_access_lookup_cookie_end);
+}
+
+/*
+ * Perform work upon the cookie, such as committing its cache state,
+ * relinquishing it or withdrawing the backing cache.  We're protected from the
+ * cache going away under us as object withdrawal must come through this
+ * non-reentrant work item.
+ */
+static void __fscache_cookie_worker(struct fscache_cookie *cookie)
+{
+	_enter("c=%x", cookie->debug_id);
+
+again:
+	switch (READ_ONCE(cookie->stage)) {
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+		if (test_and_clear_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags))
+			fscache_prepare_to_write(cookie);
+		break;
+
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+		fscache_lookup_cookie(cookie);
+		goto again;
+
+	case FSCACHE_COOKIE_STAGE_CREATING:
+		WARN_ONCE(1, "Cookie %x in unexpected stage %u\n",
+			  cookie->debug_id, cookie->stage);
+		break;
+
+	case FSCACHE_COOKIE_STAGE_FAILED:
+		break;
+
+	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
+	case FSCACHE_COOKIE_STAGE_WITHDRAWING:
+		if (test_and_clear_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags) &&
+		    cookie->cache_priv)
+			cookie->volume->cache->ops->withdraw_cookie(cookie);
+		if (cookie->stage == FSCACHE_COOKIE_STAGE_RELINQUISHING) {
+			fscache_see_cookie(cookie, fscache_cookie_see_relinquish);
+			fscache_drop_cookie(cookie);
+			break;
+		} else {
+			fscache_see_cookie(cookie, fscache_cookie_see_withdraw);
+		}
+		fallthrough;
+
+	case FSCACHE_COOKIE_STAGE_QUIESCENT:
+	case FSCACHE_COOKIE_STAGE_DROPPED:
+		clear_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &cookie->flags);
+		clear_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags);
+		clear_bit(FSCACHE_COOKIE_DO_COMMIT, &cookie->flags);
+		clear_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags);
+		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_QUIESCENT);
+		break;
+	}
+	_leave("");
+}
+
+static void fscache_cookie_worker(struct work_struct *work)
+{
+	struct fscache_cookie *cookie = container_of(work, struct fscache_cookie, work);
+
+	fscache_see_cookie(cookie, fscache_cookie_see_work);
+	__fscache_cookie_worker(cookie);
+	fscache_put_cookie(cookie, fscache_cookie_put_work);
+}
+
+/*
+ * Wait for the object to become inactive.  The cookie's work item will be
+ * scheduled when someone transitions n_accesses to 0.
+ */
+static void __fscache_withdraw_cookie(struct fscache_cookie *cookie)
+{
+	if (test_and_clear_bit(FSCACHE_COOKIE_NACC_ELEVATED, &cookie->flags))
+		fscache_end_cookie_access(cookie, fscache_access_cache_unpin);
+	else
+		__fscache_end_cookie_access(cookie);
+}
+
 /*
  * Remove a cookie from the hash table.
  */
@@ -404,6 +549,25 @@ static void fscache_drop_cookie(struct fscache_cookie *cookie)
 	fscache_stat(&fscache_n_relinquishes_dropped);
 }
 
+static void fscache_drop_withdraw_cookie(struct fscache_cookie *cookie)
+{
+	__fscache_withdraw_cookie(cookie);
+}
+
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
+}
+EXPORT_SYMBOL(fscache_withdraw_cookie);
+
 /*
  * Allow the netfs to release a cookie back to the cache.
  * - the object will be marked as recyclable on disk if retire is true
@@ -432,7 +596,7 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie, bool retire)
 	set_bit(FSCACHE_COOKIE_DO_RELINQUISH, &cookie->flags);
 
 	if (test_bit(FSCACHE_COOKIE_HAS_BEEN_CACHED, &cookie->flags))
-		; // PLACEHOLDER: Do something here if the cookie was cached
+		fscache_drop_withdraw_cookie(cookie);
 	else
 		fscache_drop_cookie(cookie);
 	fscache_put_cookie(cookie, fscache_cookie_put_relinquish);
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index dfecabfd4a0e..f6d63dc0ffa9 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -59,6 +59,15 @@ struct fscache_cache_ops {
 
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
 
 static inline enum fscache_cache_state fscache_cache_state(const struct fscache_cache *cache)
@@ -96,6 +105,7 @@ extern int fscache_add_cache(struct fscache_cache *cache,
 extern void fscache_put_cache(struct fscache_cache *cache,
 			      enum fscache_cache_trace where);
 extern void fscache_withdraw_cache(struct fscache_cache *cache);
+extern void fscache_withdraw_cookie(struct fscache_cookie *cookie);
 
 extern void fscache_io_error(struct fscache_cache *cache);
 
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 3476cc7fdb25..00ffe0f8e6d3 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -67,6 +67,7 @@ enum fscache_access_trace {
 	fscache_access_acquire_volume_end,
 	fscache_access_cache_pin,
 	fscache_access_cache_unpin,
+	fscache_access_lookup_cookie_end,
 	fscache_access_relinquish_volume,
 	fscache_access_relinquish_volume_end,
 	fscache_access_unlive,
@@ -122,6 +123,7 @@ enum fscache_access_trace {
 	EM(fscache_access_acquire_volume_end,	"END   acq_vol")	\
 	EM(fscache_access_cache_pin,		"PIN   cache  ")	\
 	EM(fscache_access_cache_unpin,		"UNPIN cache  ")	\
+	EM(fscache_access_lookup_cookie_end,	"END   lookup ")	\
 	EM(fscache_access_relinquish_volume,	"BEGIN rlq_vol")	\
 	EM(fscache_access_relinquish_volume_end,"END   rlq_vol")	\
 	E_(fscache_access_unlive,		"END   unlive ")


