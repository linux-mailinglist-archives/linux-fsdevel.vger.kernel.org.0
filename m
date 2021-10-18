Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6245743214C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhJRPCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233156AbhJRPCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0Z0o/WV3mIg+DEa6x5tVtljedfdYDVPKK/rSOm0vTU=;
        b=R3iuuL71S6ECQBK/yPIWbRxHnGC9RpY67m1NiOEP1EBUjlayH9gClnpEkgW7ICgMhID9yn
        n7RwjGhOxbu9fDqzErwSiioLcgzkzoczI6g8askhosCl+k3OznqyBHefeNDhiJpiEkknt9
        ts8NgBPtd+0UoAs3CPuK0e1Mu9mOcRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-OVp8rcT5NZiDCc86yQYTJQ-1; Mon, 18 Oct 2021 11:00:16 -0400
X-MC-Unique: OVp8rcT5NZiDCc86yQYTJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D19A802682;
        Mon, 18 Oct 2021 15:00:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 511675D6D7;
        Mon, 18 Oct 2021 15:00:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 36/67] fscache: Add stats for the cookie commit LRU
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
Date:   Mon, 18 Oct 2021 16:00:07 +0100
Message-ID: <163456920740.2614702.10833323576114946075.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add some stats to indicate the state of the cookie commit LRU, including an
indication of how many are currently on it, how many have been expired,
removed (withdrawn/reused) or dropped (relinquished) from it and how long
till the next reap happens.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cookie.c   |   10 +++++++++-
 fs/fscache/internal.h |    5 +++++
 fs/fscache/stats.c    |   12 ++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index dfc61b2e105d..c6b553609f33 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -28,7 +28,7 @@ static LIST_HEAD(fscache_cookies);
 static DEFINE_RWLOCK(fscache_cookies_lock);
 static LIST_HEAD(fscache_cookie_lru);
 static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
-static DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
+DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
 static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
 static const char fscache_cookie_stages[FSCACHE_COOKIE_STAGE__NR] = "-LCAIFMWRD";
 unsigned int fscache_lru_cookie_timeout = 10 * HZ;
@@ -60,6 +60,8 @@ static void fscache_free_cookie(struct fscache_cookie *cookie)
 		spin_lock(&fscache_cookie_lru_lock);
 		list_del_init(&cookie->commit_link);
 		spin_unlock(&fscache_cookie_lru_lock);
+		fscache_stat_d(&fscache_n_cookies_lru);
+		fscache_stat(&fscache_n_cookies_lru_removed);
 	}
 	write_lock(&fscache_cookies_lock);
 	list_del(&cookie->proc_link);
@@ -525,6 +527,7 @@ void __fscache_unuse_cookie(struct fscache_cookie *cookie,
 			if (list_empty(&cookie->commit_link)) {
 				fscache_get_cookie(cookie, fscache_cookie_get_lru);
 				list_move_tail(&cookie->commit_link, &fscache_cookie_lru);
+				fscache_stat(&fscache_n_cookies_lru);
 			}
 			spin_unlock(&fscache_cookie_lru_lock);
 			timer_reduce(&fscache_cookie_lru_timer,
@@ -624,10 +627,12 @@ static void fscache_cookie_lru_do_one(struct fscache_cookie *cookie)
 	    time_before(jiffies, cookie->unused_at + fscache_lru_cookie_timeout) ||
 	    atomic_read(&cookie->n_active) > 0) {
 		spin_unlock(&cookie->lock);
+		fscache_stat(&fscache_n_cookies_lru_removed);
 	} else {
 		__fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_COMMITTING);
 		set_bit(FSCACHE_COOKIE_DO_COMMIT, &cookie->flags);
 		spin_unlock(&cookie->lock);
+		fscache_stat(&fscache_n_cookies_lru_expired);
 		_debug("lru c=%x", cookie->debug_id);
 		__fscache_withdraw_cookie(cookie);
 	}
@@ -652,6 +657,7 @@ static void fscache_cookie_lru_worker(struct work_struct *work)
 		}
 
 		list_del_init(&cookie->commit_link);
+		fscache_stat_d(&fscache_n_cookies_lru);
 		spin_unlock(&fscache_cookie_lru_lock);
 		fscache_cookie_lru_do_one(cookie);
 		spin_lock(&fscache_cookie_lru_lock);
@@ -673,6 +679,8 @@ static void fscache_cookie_drop_from_lru(struct fscache_cookie *cookie)
 		spin_lock(&fscache_cookie_lru_lock);
 		if (!list_empty(&cookie->commit_link)) {
 			list_del_init(&cookie->commit_link);
+			fscache_stat_d(&fscache_n_cookies_lru);
+			fscache_stat(&fscache_n_cookies_lru_dropped);
 			need_put = true;
 		}
 		spin_unlock(&fscache_cookie_lru_lock);
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index f74f7bdea633..62e6a5bbef8e 100644
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
 
 extern atomic_t fscache_n_retrievals;
 extern atomic_t fscache_n_retrievals_ok;
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index 13e90b940bd2..5700e5712018 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -18,6 +18,10 @@ atomic_t fscache_n_volumes;
 atomic_t fscache_n_volumes_collision;
 atomic_t fscache_n_volumes_nomem;
 atomic_t fscache_n_cookies;
+atomic_t fscache_n_cookies_lru;
+atomic_t fscache_n_cookies_lru_expired;
+atomic_t fscache_n_cookies_lru_removed;
+atomic_t fscache_n_cookies_lru_dropped;
 
 atomic_t fscache_n_retrievals;
 atomic_t fscache_n_retrievals_ok;
@@ -89,6 +93,14 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_acquires_nobufs),
 		   atomic_read(&fscache_n_acquires_oom));
 
+	seq_printf(m, "LRU    : n=%u exp=%u rmv=%u drp=%u at=%ld\n",
+		   atomic_read(&fscache_n_cookies_lru),
+		   atomic_read(&fscache_n_cookies_lru_expired),
+		   atomic_read(&fscache_n_cookies_lru_removed),
+		   atomic_read(&fscache_n_cookies_lru_dropped),
+		   timer_pending(&fscache_cookie_lru_timer) ?
+		   fscache_cookie_lru_timer.expires - jiffies : 0);
+
 	seq_printf(m, "Invals : n=%u run=%u\n",
 		   atomic_read(&fscache_n_invalidates),
 		   atomic_read(&fscache_n_invalidates_run));


