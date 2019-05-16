Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447B9201CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 10:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfEPI6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 04:58:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:34950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726964AbfEPI6a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 04:58:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AFA95AF68;
        Thu, 16 May 2019 08:58:25 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Azat Khuzhin <azat@libevent.org>, Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/13] epoll: offload polling to a work in case of epfd polled from userspace
Date:   Thu, 16 May 2019 10:58:02 +0200
Message-Id: <20190516085810.31077-6-rpenyaev@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516085810.31077-1-rpenyaev@suse.de>
References: <20190516085810.31077-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Not every device reports pollflags on wake_up(), expecting that it will be
polled later.  vfs_poll() can't be called from ep_poll_callback(), because
ep_poll_callback() is called under the spinlock.  Obviously userspace can't
call vfs_poll(), thus epoll has to offload vfs_poll() to a work and then to
call ep_poll_callback() with pollflags in a hand.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 81da4571f1e0..9d3905c0afbf 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -44,6 +44,7 @@
 #include <linux/seq_file.h>
 #include <linux/compat.h>
 #include <linux/rculist.h>
+#include <linux/workqueue.h>
 #include <net/busy_poll.h>
 
 /*
@@ -185,6 +186,9 @@ struct epitem {
 
 	/* The structure that describe the interested events and the source fd */
 	struct epoll_event event;
+
+	/* Work for offloading event callback */
+	struct work_struct work;
 };
 
 /*
@@ -696,6 +700,14 @@ static void ep_unregister_pollwait(struct eventpoll *ep, struct epitem *epi)
 		ep_remove_wait_queue(pwq);
 		kmem_cache_free(pwq_cache, pwq);
 	}
+	if (ep_polled_by_user(ep)) {
+		/*
+		 * Events polled by user require offloading to a work,
+		 * thus we have to be sure everything which was queued
+		 * has run to a completion.
+		 */
+		flush_work(&epi->work);
+	}
 }
 
 /* call only when ep->mtx is held */
@@ -1340,9 +1352,8 @@ static inline bool chain_epi_lockless(struct epitem *epi)
 }
 
 /*
- * This is the callback that is passed to the wait queue wakeup
- * mechanism. It is called by the stored file descriptors when they
- * have events to report.
+ * This is the callback that is called directly from wake queue wakeup or
+ * from a work.
  *
  * This callback takes a read lock in order not to content with concurrent
  * events from another file descriptors, thus all modifications to ->rdllist
@@ -1357,14 +1368,11 @@ static inline bool chain_epi_lockless(struct epitem *epi)
  * queues are used should be detected accordingly.  This is detected using
  * cmpxchg() operation.
  */
-static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
+static int ep_poll_callback(struct epitem *epi, __poll_t pollflags)
 {
-	int pwake = 0;
-	struct epitem *epi = ep_item_from_wait(wait);
 	struct eventpoll *ep = epi->ep;
-	__poll_t pollflags = key_to_poll(key);
+	int pwake = 0, ewake = 0;
 	unsigned long flags;
-	int ewake = 0;
 
 	read_lock_irqsave(&ep->lock, flags);
 
@@ -1382,8 +1390,9 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	/*
 	 * Check the events coming with the callback. At this stage, not
 	 * every device reports the events in the "key" parameter of the
-	 * callback. We need to be able to handle both cases here, hence the
-	 * test for "key" != NULL before the event match test.
+	 * callback (for ep_poll_callback() case special worker is used).
+	 * We need to be able to handle both cases here, hence the test
+	 * for "key" != NULL before the event match test.
 	 */
 	if (pollflags && !(pollflags & epi->event.events))
 		goto out_unlock;
@@ -1443,23 +1452,67 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	if (!(epi->event.events & EPOLLEXCLUSIVE))
 		ewake = 1;
 
-	if (pollflags & POLLFREE) {
-		/*
-		 * If we race with ep_remove_wait_queue() it can miss
-		 * ->whead = NULL and do another remove_wait_queue() after
-		 * us, so we can't use __remove_wait_queue().
-		 */
-		list_del_init(&wait->entry);
+	return ewake;
+}
+
+static void ep_poll_callback_work(struct work_struct *work)
+{
+	struct epitem *epi = container_of(work, typeof(*epi), work);
+	__poll_t pollflags;
+	poll_table pt;
+
+	WARN_ON(!ep_polled_by_user(epi->ep));
+
+	init_poll_funcptr(&pt, NULL);
+	pollflags = ep_item_poll(epi, &pt, 1);
+	if (pollflags)
+		(void)ep_poll_callback(epi, pollflags);
+}
+
+/*
+ * This is the callback that is passed to the wait queue wakeup
+ * mechanism. It is called by the stored file descriptors when they
+ * have events to report.
+ */
+static int ep_poll_wakeup(wait_queue_entry_t *wait, unsigned int mode,
+			  int sync, void *key)
+{
+
+	struct epitem *epi = ep_item_from_wait(wait);
+	struct eventpoll *ep = epi->ep;
+	__poll_t pollflags = key_to_poll(key);
+	int rc;
+
+	if (!ep_polled_by_user(ep) || pollflags) {
+		rc = ep_poll_callback(epi, pollflags);
+
+		if (pollflags & POLLFREE) {
+			/*
+			 * If we race with ep_remove_wait_queue() it can miss
+			 * ->whead = NULL and do another remove_wait_queue()
+			 * after us, so we can't use __remove_wait_queue().
+			 */
+			list_del_init(&wait->entry);
+			/*
+			 * ->whead != NULL protects us from the race with
+			 * ep_free() or ep_remove(), ep_remove_wait_queue()
+			 * takes whead->lock held by the caller. Once we nullify
+			 * it, nothing protects ep/epi or even wait.
+			 */
+			smp_store_release(&ep_pwq_from_wait(wait)->whead, NULL);
+		}
+	} else {
+		schedule_work(&epi->work);
+
 		/*
-		 * ->whead != NULL protects us from the race with ep_free()
-		 * or ep_remove(), ep_remove_wait_queue() takes whead->lock
-		 * held by the caller. Once we nullify it, nothing protects
-		 * ep/epi or even wait.
+		 * Here on this path we are absolutely sure that for file
+		 * descriptors* which are pollable from userspace we do not
+		 * support EPOLLEXCLUSIVE, so it is safe to return 1.
 		 */
-		smp_store_release(&ep_pwq_from_wait(wait)->whead, NULL);
+		rc = 1;
 	}
 
-	return ewake;
+	return rc;
 }
 
 /*
@@ -1473,7 +1526,7 @@ static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
 	struct eppoll_entry *pwq;
 
 	if (epi->nwait >= 0 && (pwq = kmem_cache_alloc(pwq_cache, GFP_KERNEL))) {
-		init_waitqueue_func_entry(&pwq->wait, ep_poll_callback);
+		init_waitqueue_func_entry(&pwq->wait, ep_poll_wakeup);
 		pwq->whead = whead;
 		pwq->base = epi;
 		if (epi->event.events & EPOLLEXCLUSIVE)
@@ -1667,6 +1720,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	INIT_LIST_HEAD(&epi->rdllink);
 	INIT_LIST_HEAD(&epi->fllink);
 	INIT_LIST_HEAD(&epi->pwqlist);
+	INIT_WORK(&epi->work, ep_poll_callback_work);
 	epi->ep = ep;
 	ep_set_ffd(&epi->ffd, tfile, fd);
 	epi->event = *event;
@@ -2547,12 +2601,6 @@ static int __init eventpoll_init(void)
 	ep_nested_calls_init(&poll_safewake_ncalls);
 #endif
 
-	/*
-	 * We can have many thousands of epitems, so prevent this from
-	 * using an extra cache line on 64-bit (and smaller) CPUs
-	 */
-	BUILD_BUG_ON(sizeof(void *) <= 8 && sizeof(struct epitem) > 128);
-
 	/* Allocates slab cache used to allocate "struct epitem" items */
 	epi_cache = kmem_cache_create("eventpoll_epi", sizeof(struct epitem),
 			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
-- 
2.21.0

