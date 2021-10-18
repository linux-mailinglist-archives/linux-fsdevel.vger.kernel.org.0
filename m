Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B736432144
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhJRPCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233037AbhJRPCW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/gZcyOT12TFKnNipl9VJdyVU0Aa1uUb86IiYe5LXiA=;
        b=YTOhspTb+yzZo2mexDhulrNspJ4sx6UJitX3L6LPt5N5rwPTVahoA2HPGWQ9ZppXC1yPwI
        CedyyuTZBLlAcC4Hhg/I6LPMn1AZnktQZLu7KFpDI4N4re5I647r+Ah19jon0ZVtknxICm
        67G/RlfIQq1+8lJ7Bd3JAlDaA3ZkAxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-qPTHu9zDMMuiURJoIoLBmQ-1; Mon, 18 Oct 2021 11:00:07 -0400
X-MC-Unique: qPTHu9zDMMuiURJoIoLBmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 316CE9F92C;
        Mon, 18 Oct 2021 15:00:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6A8560C17;
        Mon, 18 Oct 2021 14:59:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 35/67] fscache: Automatically close a file that's been unused
 for a while
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
Date:   Mon, 18 Oct 2021 15:59:57 +0100
Message-ID: <163456919786.2614702.17176086827977019423.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a cache object becomes fully unused, schedule it to be committed and
closed after a few seconds if not re-used.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cookie.c            |  108 +++++++++++++++++++++++++++++++++++++++-
 fs/fscache/io.c                |    2 +
 include/linux/fscache.h        |    5 +-
 include/trace/events/fscache.h |    8 +++
 4 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 90a16e6d6917..dfc61b2e105d 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -15,6 +15,8 @@
 
 struct kmem_cache *fscache_cookie_jar;
 
+static void fscache_cookie_lru_timed_out(struct timer_list *timer);
+static void fscache_cookie_lru_worker(struct work_struct *work);
 static void fscache_cookie_worker(struct work_struct *work);
 static void fscache_drop_cookie(struct fscache_cookie *cookie);
 static void fscache_lookup_cookie(struct fscache_cookie *cookie);
@@ -24,7 +26,12 @@ static void fscache_invalidate_cookie(struct fscache_cookie *cookie);
 static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
 static LIST_HEAD(fscache_cookies);
 static DEFINE_RWLOCK(fscache_cookies_lock);
-static const char fscache_cookie_stages[FSCACHE_COOKIE_STAGE__NR] = "-LCAIFWRD";
+static LIST_HEAD(fscache_cookie_lru);
+static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
+static DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
+static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
+static const char fscache_cookie_stages[FSCACHE_COOKIE_STAGE__NR] = "-LCAIFMWRD";
+unsigned int fscache_lru_cookie_timeout = 10 * HZ;
 
 void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 {
@@ -49,6 +56,11 @@ void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 
 static void fscache_free_cookie(struct fscache_cookie *cookie)
 {
+	if (WARN_ON_ONCE(!list_empty(&cookie->commit_link))) {
+		spin_lock(&fscache_cookie_lru_lock);
+		list_del_init(&cookie->commit_link);
+		spin_unlock(&fscache_cookie_lru_lock);
+	}
 	write_lock(&fscache_cookies_lock);
 	list_del(&cookie->proc_link);
 	write_unlock(&fscache_cookies_lock);
@@ -265,6 +277,7 @@ static struct fscache_cookie *fscache_alloc_cookie(
 	cookie->debug_id = atomic_inc_return(&fscache_cookie_debug_id);
 	cookie->stage = FSCACHE_COOKIE_STAGE_QUIESCENT;
 	spin_lock_init(&cookie->lock);
+	INIT_LIST_HEAD(&cookie->commit_link);
 	INIT_WORK(&cookie->work, fscache_cookie_worker);
 
 	write_lock(&fscache_cookies_lock);
@@ -448,6 +461,7 @@ void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
 
 	atomic_inc(&cookie->n_active);
 
+again:
 	stage = cookie->stage;
 	switch (stage) {
 	case FSCACHE_COOKIE_STAGE_QUIESCENT:
@@ -474,6 +488,13 @@ void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
 	case FSCACHE_COOKIE_STAGE_WITHDRAWING:
 		break;
 
+	case FSCACHE_COOKIE_STAGE_COMMITTING:
+		spin_unlock(&cookie->lock);
+		wait_var_event(&cookie->stage,
+			       READ_ONCE(cookie->stage) != FSCACHE_COOKIE_STAGE_COMMITTING);
+		spin_lock(&cookie->lock);
+		goto again;
+
 	case FSCACHE_COOKIE_STAGE_DROPPED:
 	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
 		WARN(1, "Can't use cookie in stage %u\n", cookie->stage);
@@ -497,7 +518,19 @@ void __fscache_unuse_cookie(struct fscache_cookie *cookie,
 {
 	if (aux_data || object_size)
 		__fscache_update_cookie(cookie, aux_data, object_size);
-	atomic_dec(&cookie->n_active);
+	cookie->unused_at = jiffies;
+	if (atomic_dec_return(&cookie->n_active) == 0) {
+		if (test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags)) {
+			spin_lock(&fscache_cookie_lru_lock);
+			if (list_empty(&cookie->commit_link)) {
+				fscache_get_cookie(cookie, fscache_cookie_get_lru);
+				list_move_tail(&cookie->commit_link, &fscache_cookie_lru);
+			}
+			spin_unlock(&fscache_cookie_lru_lock);
+			timer_reduce(&fscache_cookie_lru_timer,
+				     jiffies + fscache_lru_cookie_timeout);
+		}
+	}
 }
 EXPORT_SYMBOL(__fscache_unuse_cookie);
 
@@ -532,6 +565,7 @@ static void __fscache_cookie_worker(struct fscache_cookie *cookie)
 	case FSCACHE_COOKIE_STAGE_FAILED:
 		break;
 
+	case FSCACHE_COOKIE_STAGE_COMMITTING:
 	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
 	case FSCACHE_COOKIE_STAGE_WITHDRAWING:
 		if (test_and_clear_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags) &&
@@ -541,6 +575,8 @@ static void __fscache_cookie_worker(struct fscache_cookie *cookie)
 			fscache_see_cookie(cookie, fscache_cookie_see_relinquish);
 			fscache_drop_cookie(cookie);
 			break;
+		} else if (cookie->stage == FSCACHE_COOKIE_STAGE_COMMITTING) {
+			fscache_see_cookie(cookie, fscache_cookie_see_committing);
 		} else {
 			fscache_see_cookie(cookie, fscache_cookie_see_withdraw);
 		}
@@ -550,6 +586,7 @@ static void __fscache_cookie_worker(struct fscache_cookie *cookie)
 	case FSCACHE_COOKIE_STAGE_DROPPED:
 		clear_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &cookie->flags);
 		clear_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags);
+		clear_bit(FSCACHE_COOKIE_DO_COMMIT, &cookie->flags);
 		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_QUIESCENT);
 		break;
@@ -578,6 +615,72 @@ static void __fscache_withdraw_cookie(struct fscache_cookie *cookie)
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
+	} else {
+		__fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_COMMITTING);
+		set_bit(FSCACHE_COOKIE_DO_COMMIT, &cookie->flags);
+		spin_unlock(&cookie->lock);
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
+			need_put = true;
+		}
+		spin_unlock(&fscache_cookie_lru_lock);
+		if (need_put)
+			fscache_put_cookie(cookie, fscache_cookie_put_lru);
+	}
+}
+
 /*
  * Ask the cache to effect invalidation of a cookie.
  */
@@ -687,6 +790,7 @@ static void fscache_drop_cookie(struct fscache_cookie *cookie)
 
 static void fscache_drop_withdraw_cookie(struct fscache_cookie *cookie)
 {
+	fscache_cookie_drop_from_lru(cookie);
 	__fscache_withdraw_cookie(cookie);
 }
 
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 2b1c9f433530..ef4b0606019d 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -43,6 +43,7 @@ bool fscache_wait_for_operation(struct netfs_cache_resources *cres,
 			goto ready; /* There can be no content */
 		fallthrough;
 	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+	case FSCACHE_COOKIE_STAGE_COMMITTING:
 		wait_var_event(&cookie->stage, READ_ONCE(cookie->stage) != stage);
 		goto again;
 
@@ -92,6 +93,7 @@ static int fscache_begin_operation(struct netfs_cache_resources *cres,
 
 	switch (stage) {
 	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+	case FSCACHE_COOKIE_STAGE_COMMITTING:
 		goto wait_and_validate;
 	case FSCACHE_COOKIE_STAGE_INVALIDATING:
 	case FSCACHE_COOKIE_STAGE_CREATING:
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index aeee14f5663a..c6ee09661351 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -59,6 +59,7 @@ enum fscache_cookie_stage {
 	FSCACHE_COOKIE_STAGE_ACTIVE,		/* The cache is active, readable and writable */
 	FSCACHE_COOKIE_STAGE_INVALIDATING,	/* The cache is being invalidated */
 	FSCACHE_COOKIE_STAGE_FAILED,		/* The cache failed, withdraw to clear */
+	FSCACHE_COOKIE_STAGE_COMMITTING,	/* The cookie is being committed */
 	FSCACHE_COOKIE_STAGE_WITHDRAWING,	/* The cookie is being withdrawn */
 	FSCACHE_COOKIE_STAGE_RELINQUISHING,	/* The cookie is being relinquished */
 	FSCACHE_COOKIE_STAGE_DROPPED,		/* The cookie has been dropped */
@@ -108,9 +109,10 @@ struct fscache_cookie {
 	void				*cache_priv;	/* Cache-side representation */
 	struct hlist_bl_node		hash_link;	/* Link in hash table */
 	struct list_head		proc_link;	/* Link in proc list */
+	struct list_head		commit_link;	/* Link in commit queue */
 	struct work_struct		work;		/* Commit/relinq/withdraw work */
 	loff_t				object_size;	/* Size of the netfs object */
-
+	unsigned long			unused_at;	/* Time at which unused (jiffies) */
 	unsigned long			flags;
 #define FSCACHE_COOKIE_RELINQUISHED	0		/* T if cookie has been relinquished */
 #define FSCACHE_COOKIE_RETIRED		1		/* T if this cookie has retired on relinq */
@@ -121,6 +123,7 @@ struct fscache_cookie {
 #define FSCACHE_COOKIE_NACC_ELEVATED	8		/* T if n_accesses is incremented */
 #define FSCACHE_COOKIE_DO_RELINQUISH	9		/* T if this cookie needs relinquishment */
 #define FSCACHE_COOKIE_DO_WITHDRAW	10		/* T if this cookie needs withdrawing */
+#define FSCACHE_COOKIE_DO_COMMIT	11		/* T if this cookie needs committing */
 
 	enum fscache_cookie_stage	stage;
 	u8				advice;		/* FSCACHE_ADV_* */
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 0d9789745a91..50f28a2a4ca8 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -52,16 +52,20 @@ enum fscache_cookie_trace {
 	fscache_cookie_get_end_access,
 	fscache_cookie_get_hash_collision,
 	fscache_cookie_get_inval_work,
+	fscache_cookie_get_lru,
 	fscache_cookie_get_use_work,
 	fscache_cookie_get_withdraw,
 	fscache_cookie_new_acquire,
 	fscache_cookie_put_hash_collision,
+	fscache_cookie_put_lru,
 	fscache_cookie_put_object,
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
@@ -127,16 +131,20 @@ enum fscache_access_trace {
 	EM(fscache_cookie_get_hash_collision,	"GET hcoll")		\
 	EM(fscache_cookie_get_end_access,	"GQ  endac")		\
 	EM(fscache_cookie_get_inval_work,	"GQ  inval")		\
+	EM(fscache_cookie_get_lru,		"GET lru  ")		\
 	EM(fscache_cookie_get_use_work,		"GQ  use  ")		\
 	EM(fscache_cookie_get_withdraw,		"GQ  wthdr")		\
 	EM(fscache_cookie_new_acquire,		"NEW acq  ")		\
 	EM(fscache_cookie_put_hash_collision,	"PUT hcoll")		\
+	EM(fscache_cookie_put_lru,		"PUT lru  ")		\
 	EM(fscache_cookie_put_object,		"PUT obj  ")		\
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


