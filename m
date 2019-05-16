Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 058DE201DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 10:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfEPI6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 04:58:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:34976 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbfEPI62 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 04:58:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9470CAF7D;
        Thu, 16 May 2019 08:58:26 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Azat Khuzhin <azat@libevent.org>, Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/13] epoll: support polling from userspace for ep_insert()
Date:   Thu, 16 May 2019 10:58:05 +0200
Message-Id: <20190516085810.31077-9-rpenyaev@suse.de>
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

When epfd is polled by userspace and new item is inserted new bit
should be get from a bitmap and then user item is set accordingly.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 55612da9651e..f1ffccfcca67 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -865,6 +865,23 @@ static void epi_rcu_free(struct rcu_head *head)
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
 #define atomic_set_unless_zero(ptr, flags)			\
 ({								\
 	typeof(ptr) _ptr = (ptr);				\
@@ -1875,6 +1892,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	struct epitem *epi;
 	struct ep_pqueue epq;
 
+	lockdep_assert_held(&ep->mtx);
 	lockdep_assert_irqs_enabled();
 
 	user_watches = atomic_long_read(&ep->user->epoll_watches);
@@ -1901,6 +1919,29 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 		RCU_INIT_POINTER(epi->ws, NULL);
 	}
 
+	if (ep_polled_by_user(ep)) {
+		struct epoll_uitem *uitem;
+		int bit;
+
+		bit = ep_get_bit(ep);
+		if (unlikely(bit < 0)) {
+			error = bit;
+			goto error_get_bit;
+		}
+		epi->bit = bit;
+
+		/*
+		 * Now fill-in user item.  Do not touch ready_events, since
+		 * it can be EPOLLREMOVED (has been set by previous user
+		 * item), thus user index entry can be not yet consumed
+		 * by userspace.  See ep_remove_user_item() and
+		 * ep_add_event_to_uring() for details.
+		 */
+		uitem = &ep->user_header->items[epi->bit];
+		uitem->events = event->events;
+		uitem->data = event->data;
+	}
+
 	/* Initialize the poll table using the queue callback */
 	epq.epi = epi;
 	init_poll_funcptr(&epq.pt, ep_ptable_queue_proc);
@@ -1945,16 +1986,23 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
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
@@ -1983,11 +2031,16 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
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
 
+error_get_bit:
 	wakeup_source_unregister(ep_wakeup_source(epi));
 
 error_create_wakeup_source:
-- 
2.21.0

