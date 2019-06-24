Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1620850EC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfFXOmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:42:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:50404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728868AbfFXOmE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:42:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CFEBDAEFE;
        Mon, 24 Jun 2019 14:42:02 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/14] epoll: support polling from userspace for ep_insert()
Date:   Mon, 24 Jun 2019 16:41:45 +0200
Message-Id: <20190624144151.22688-9-rpenyaev@suse.de>
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

When epfd is polled by userspace and new item is inserted new bit
should be get from a bitmap and then user item is set accordingly.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 118 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 100 insertions(+), 18 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index cc4612e28e03..d0c057b73ea1 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -906,6 +906,23 @@ static void epi_rcu_free(struct rcu_head *head)
 	kmem_cache_free(epi_cache, epi);
 }
 
+static inline int ep_get_bit(struct eventpoll *ep)
+{
+	bool was_set;
+	int bit;
+
+	lockdep_assert_held(&ep->mtx);
+
+	bit = find_first_zero_bit(ep->items_bm, ep->max_items_nr);
+	if (bit >= ep->max_items_nr)
+		return -ENOSPC;
+
+	was_set = test_and_set_bit(bit, ep->items_bm);
+	WARN_ON(was_set);
+
+	return bit;
+}
+
 #define set_unless_zero_atomically(ptr, flags)			\
 ({								\
 	typeof(ptr) _ptr = (ptr);				\
@@ -2022,6 +2039,33 @@ static noinline void ep_destroy_wakeup_source(struct epitem *epi)
 	wakeup_source_unregister(ws);
 }
 
+static inline struct epitem *epi_alloc(struct eventpoll *ep)
+{
+	struct epitem *epi;
+
+	if (ep_polled_by_user(ep)) {
+		struct uepitem *uepi;
+
+		uepi = kmem_cache_alloc(uepi_cache, GFP_KERNEL);
+		if (likely(uepi))
+			epi = &uepi->epi;
+		else
+			epi = NULL;
+	} else {
+		epi = kmem_cache_alloc(epi_cache, GFP_KERNEL);
+	}
+
+	return epi;
+}
+
+static inline void epi_free(struct eventpoll *ep, struct epitem *epi)
+{
+	if (ep_polled_by_user(ep))
+		kmem_cache_free(uepi_cache, uep_item_from_epi(epi));
+	else
+		kmem_cache_free(epi_cache, epi);
+}
+
 /*
  * Must be called with "mtx" held.
  */
@@ -2034,29 +2078,55 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	struct epitem *epi;
 	struct ep_pqueue epq;
 
+	lockdep_assert_held(&ep->mtx);
 	lockdep_assert_irqs_enabled();
 
 	user_watches = atomic_long_read(&ep->user->epoll_watches);
 	if (unlikely(user_watches >= max_user_watches))
 		return -ENOSPC;
-	if (!(epi = kmem_cache_alloc(epi_cache, GFP_KERNEL)))
+	epi = epi_alloc(ep);
+	if (unlikely(!epi))
 		return -ENOMEM;
 
 	/* Item initialization follow here ... */
 	INIT_LIST_HEAD(&epi->rdllink);
 	INIT_LIST_HEAD(&epi->fllink);
 	INIT_LIST_HEAD(&epi->pwqlist);
+	RCU_INIT_POINTER(epi->ws, NULL);
 	epi->ep = ep;
 	ep_set_ffd(&epi->ffd, tfile, fd);
 	epi->event = *event;
 	epi->nwait = 0;
 	epi->next = EP_UNACTIVE_PTR;
-	if (epi->event.events & EPOLLWAKEUP) {
+
+	if (ep_polled_by_user(ep)) {
+		struct uepitem *uepi = uep_item_from_epi(epi);
+		struct epoll_uitem *uitem;
+		int bit;
+
+		INIT_WORK(&uepi->work, ep_poll_callback_work);
+
+		bit = ep_get_bit(ep);
+		if (unlikely(bit < 0)) {
+			error = bit;
+			goto error_get_bit;
+		}
+		uepi->bit = bit;
+
+		/*
+		 * Now fill-in user item.  Do not touch ready_events, since
+		 * it can be EPOLLREMOVED (has been set by previous user
+		 * item), thus user index entry can be not yet consumed
+		 * by userspace.  See ep_remove_user_item() and
+		 * ep_add_event_to_uring() for details.
+		 */
+		uitem = &ep->user_header->items[uepi->bit];
+		uitem->events = event->events;
+		uitem->data = event->data;
+	} else if (epi->event.events & EPOLLWAKEUP) {
 		error = ep_create_wakeup_source(epi);
 		if (error)
 			goto error_create_wakeup_source;
-	} else {
-		RCU_INIT_POINTER(epi->ws, NULL);
 	}
 
 	/* Initialize the poll table using the queue callback */
@@ -2103,16 +2173,23 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	/* record NAPI ID of new item if present */
 	ep_set_busy_poll_napi_id(epi);
 
-	/* If the file is already "ready" we drop it inside the ready list */
-	if (revents && !ep_is_linked(epi)) {
-		list_add_tail(&epi->rdllink, &ep->rdllist);
-		ep_pm_stay_awake(epi);
+	if (revents) {
+		bool added = false;
 
-		/* Notify waiting tasks that events are available */
-		if (waitqueue_active(&ep->wq))
-			wake_up(&ep->wq);
-		if (waitqueue_active(&ep->poll_wait))
-			pwake++;
+		if (ep_polled_by_user(ep)) {
+			added = ep_add_event_to_uring(epi, revents);
+		} else if (!ep_is_linked(epi)) {
+			list_add_tail(&epi->rdllink, &ep->rdllist);
+			ep_pm_stay_awake(epi);
+			added = true;
+		}
+		if (added) {
+			/* Notify waiting tasks that events are available */
+			if (waitqueue_active(&ep->wq))
+				wake_up(&ep->wq);
+			if (waitqueue_active(&ep->poll_wait))
+				pwake++;
+		}
 	}
 
 	write_unlock_irq(&ep->lock);
@@ -2141,15 +2218,20 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	 * list, since that is used/cleaned only inside a section bound by "mtx".
 	 * And ep_insert() is called with "mtx" held.
 	 */
-	write_lock_irq(&ep->lock);
-	if (ep_is_linked(epi))
-		list_del_init(&epi->rdllink);
-	write_unlock_irq(&ep->lock);
+	if (ep_polled_by_user(ep)) {
+		ep_remove_user_item(epi);
+	} else {
+		write_lock_irq(&ep->lock);
+		if (ep_is_linked(epi))
+			list_del_init(&epi->rdllink);
+		write_unlock_irq(&ep->lock);
+	}
 
 	wakeup_source_unregister(ep_wakeup_source(epi));
 
+error_get_bit:
 error_create_wakeup_source:
-	kmem_cache_free(epi_cache, epi);
+	epi_free(ep, epi);
 
 	return error;
 }
-- 
2.21.0

