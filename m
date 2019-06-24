Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE9C50ED5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfFXOnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:43:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:50380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbfFXOmE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:42:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD1ECAEBF;
        Mon, 24 Jun 2019 14:42:01 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/14] epoll: offload polling to a work in case of epfd polled from userspace
Date:   Mon, 24 Jun 2019 16:41:42 +0200
Message-Id: <20190624144151.22688-6-rpenyaev@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624144151.22688-1-rpenyaev@suse.de>
References: <20190624144151.22688-1-rpenyaev@suse.de>
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

In order not to bloat the size of `struct epitem` with `struct work_struct`
new `struct uepitem` includes original epi and work.  Thus for ep pollable
from user new `struct uepitem` will be allocated.  This will be done in
the following patches.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 131 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 107 insertions(+), 24 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4087efb1fbf3..f2a2be93bc4b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -38,6 +38,7 @@
 #include <linux/seq_file.h>
 #include <linux/compat.h>
 #include <linux/rculist.h>
+#include <linux/workqueue.h>
 #include <net/busy_poll.h>
 
 /*
@@ -184,6 +185,18 @@ struct epitem {
 	struct epoll_event event;
 };
 
+/*
+ * The only purpose of this structure is not to inflate the size of the
+ * 'struct epitem' if polling from user is not used.
+ */
+struct uepitem {
+	/* Includes ep item */
+	struct epitem epi;
+
+	/* Work for offloading event callback */
+	struct work_struct work;
+};
+
 /*
  * This structure is stored inside the "private_data" member of the file
  * structure and represents the main data structure for the eventpoll
@@ -313,6 +326,9 @@ static struct nested_calls poll_loop_ncalls;
 /* Slab cache used to allocate "struct epitem" */
 static struct kmem_cache *epi_cache __read_mostly;
 
+/* Slab cache used to allocate "struct uepitem" */
+static struct kmem_cache *uepi_cache __read_mostly;
+
 /* Slab cache used to allocate "struct eppoll_entry" */
 static struct kmem_cache *pwq_cache __read_mostly;
 
@@ -391,6 +407,12 @@ static inline struct epitem *ep_item_from_epqueue(poll_table *p)
 	return container_of(p, struct ep_pqueue, pt)->epi;
 }
 
+/* Get the "struct uepitem" from an generic epitem. */
+static inline struct uepitem *uep_item_from_epi(struct epitem *p)
+{
+	return container_of(p, struct uepitem, epi);
+}
+
 /* Tells if the epoll_ctl(2) operation needs an event copy from userspace */
 static inline int ep_op_has_event(int op)
 {
@@ -719,6 +741,14 @@ static void ep_unregister_pollwait(struct eventpoll *ep, struct epitem *epi)
 		ep_remove_wait_queue(pwq);
 		kmem_cache_free(pwq_cache, pwq);
 	}
+	if (ep_polled_by_user(ep)) {
+		/*
+		 * Events polled by user require offloading to a work,
+		 * thus we have to be sure everything which was queued
+		 * has run to a completion.
+		 */
+		flush_work(&uep_item_from_epi(epi)->work);
+	}
 }
 
 /* call only when ep->mtx is held */
@@ -1369,9 +1399,8 @@ static inline bool chain_epi_lockless(struct epitem *epi)
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
@@ -1386,14 +1415,11 @@ static inline bool chain_epi_lockless(struct epitem *epi)
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
 
@@ -1411,8 +1437,9 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
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
@@ -1472,23 +1499,68 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
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
+	struct uepitem *uepi = container_of(work, typeof(*uepi), work);
+	struct epitem *epi = &uepi->epi;
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
+		queue_work(system_highpri_wq, &uep_item_from_epi(epi)->work);
+
 		/*
-		 * ->whead != NULL protects us from the race with ep_free()
-		 * or ep_remove(), ep_remove_wait_queue() takes whead->lock
-		 * held by the caller. Once we nullify it, nothing protects
-		 * ep/epi or even wait.
+		 * Here on this path we are absolutely sure that for file
+		 * descriptors which are pollable from userspace we do not
+		 * support EPOLLEXCLUSIVE, so it is safe to return 1.
 		 */
-		smp_store_release(&ep_pwq_from_wait(wait)->whead, NULL);
+		rc = 1;
 	}
 
-	return ewake;
+	return rc;
 }
 
 /*
@@ -1502,7 +1574,7 @@ static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
 	struct eppoll_entry *pwq;
 
 	if (epi->nwait >= 0 && (pwq = kmem_cache_alloc(pwq_cache, GFP_KERNEL))) {
-		init_waitqueue_func_entry(&pwq->wait, ep_poll_callback);
+		init_waitqueue_func_entry(&pwq->wait, ep_poll_wakeup);
 		pwq->whead = whead;
 		pwq->base = epi;
 		if (epi->event.events & EPOLLEXCLUSIVE)
@@ -2575,6 +2647,10 @@ static int __init eventpoll_init(void)
 	/*
 	 * We can have many thousands of epitems, so prevent this from
 	 * using an extra cache line on 64-bit (and smaller) CPUs
+	 *
+	 * 'struct uepitem' is used for polling from userspace, it is
+	 * slightly bigger than 128b because of the work struct, thus
+	 * it is excluded from the check below.
 	 */
 	BUILD_BUG_ON(sizeof(void *) <= 8 && sizeof(struct epitem) > 128);
 
@@ -2582,6 +2658,13 @@ static int __init eventpoll_init(void)
 	epi_cache = kmem_cache_create("eventpoll_epi", sizeof(struct epitem),
 			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
 
+	/*
+	 * Allocates slab cache used to allocate "struct uepitem" items,
+	 * used only for polling from user.
+	 */
+	uepi_cache = kmem_cache_create("eventpoll_uepi", sizeof(struct uepitem),
+			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
+
 	/* Allocates slab cache used to allocate "struct eppoll_entry" */
 	pwq_cache = kmem_cache_create("eventpoll_pwq",
 		sizeof(struct eppoll_entry), 0, SLAB_PANIC|SLAB_ACCOUNT, NULL);
-- 
2.21.0

