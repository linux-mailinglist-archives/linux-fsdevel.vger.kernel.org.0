Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C88201D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 10:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfEPI63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 04:58:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:34956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbfEPI62 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 04:58:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D103AF79;
        Thu, 16 May 2019 08:58:26 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Azat Khuzhin <azat@libevent.org>, Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/13] epoll: introduce helpers for adding/removing events to uring
Date:   Thu, 16 May 2019 10:58:03 +0200
Message-Id: <20190516085810.31077-7-rpenyaev@suse.de>
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

Both add and remove events are lockless and can be called in parallel.

ep_add_event_to_uring():
	o user item is marked atomically as ready
	o if on previous stem user item was observed as not ready,
	  then new entry is created for the index uring.

ep_remove_user_item():
	o user item is marked as EPOLLREMOVED only if it was ready,
	  thus userspace will obseve previously added entry in index
	  uring and correct "removed" state of the item.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 9d3905c0afbf..2f551c005640 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -189,6 +189,9 @@ struct epitem {
 
 	/* Work for offloading event callback */
 	struct work_struct work;
+
+	/* Bit in user bitmap for user polling */
+	unsigned int bit;
 };
 
 /*
@@ -427,6 +430,11 @@ static inline unsigned int ep_to_items_bm_length(unsigned int nr)
 	return PAGE_ALIGN(ALIGN(nr, 8) >> 3);
 }
 
+static inline unsigned int ep_max_index_nr(struct eventpoll *ep)
+{
+	return ep->index_length >> ilog2(sizeof(*ep->user_index));
+}
+
 static inline bool ep_polled_by_user(struct eventpoll *ep)
 {
 	return !!ep->user_header;
@@ -857,6 +865,127 @@ static void epi_rcu_free(struct rcu_head *head)
 	kmem_cache_free(epi_cache, epi);
 }
 
+#define atomic_set_unless_zero(ptr, flags)			\
+({								\
+	typeof(ptr) _ptr = (ptr);				\
+	typeof(flags) _flags = (flags);				\
+	typeof(*_ptr) _old, _val = READ_ONCE(*_ptr);		\
+								\
+	for (;;) {						\
+		if (!_val)					\
+			break;					\
+		_old = cmpxchg(_ptr, _val, _flags);		\
+		if (_old == _val)				\
+			break;					\
+		_val = _old;					\
+	}							\
+	_val;							\
+})
+
+static inline void ep_remove_user_item(struct epitem *epi)
+{
+	struct eventpoll *ep = epi->ep;
+	struct epoll_uitem *uitem;
+
+	lockdep_assert_held(&ep->mtx);
+
+	/* Event should not have any attached queues */
+	WARN_ON(!list_empty(&epi->pwqlist));
+
+	uitem = &ep->user_header->items[epi->bit];
+
+	/*
+	 * User item can be in two states: signaled (read_events is set
+	 * and userspace has not yet consumed this event) and not signaled
+	 * (no events yet fired or already consumed by userspace).
+	 * We reset ready_events to EPOLLREMOVED only if ready_events is
+	 * in signaled state (we expect that userspace will come soon and
+	 * fetch this event).  In case of not signaled leave read_events
+	 * as 0.
+	 *
+	 * Why it is important to mark read_events as EPOLLREMOVED in case
+	 * of already signaled state?  ep_insert() op can be immediately
+	 * called after ep_remove(), thus the same bit can be reused and
+	 * then new event comes, which corresponds to the same entry inside
+	 * user items array.  For this particular case ep_add_event_to_uring()
+	 * does not allocate a new index entry, but simply masks EPOLLREMOVED,
+	 * and userspace uses old index entry, but meanwhile old user item
+	 * has been removed, new item has been added and event updated.
+	 */
+	atomic_set_unless_zero(&uitem->ready_events, EPOLLREMOVED);
+	clear_bit(epi->bit, ep->items_bm);
+}
+
+#define atomic_or_with_mask(ptr, flags, mask)			\
+({								\
+	typeof(ptr) _ptr = (ptr);				\
+	typeof(flags) _flags = (flags);				\
+	typeof(flags) _mask = (mask);				\
+	typeof(*_ptr) _old, _new, _val = READ_ONCE(*_ptr);	\
+								\
+	for (;;) {						\
+		_new = (_val & ~_mask) | _flags;		\
+		_old = cmpxchg(_ptr, _val, _new);		\
+		if (_old == _val)				\
+			break;					\
+		_val = _old;					\
+	}							\
+	_val;							\
+})
+
+static inline bool ep_add_event_to_uring(struct epitem *epi, __poll_t pollflags)
+{
+	struct eventpoll *ep = epi->ep;
+	struct epoll_uitem *uitem;
+	bool added = false;
+
+	if (WARN_ON(!pollflags))
+		return false;
+
+	uitem = &ep->user_header->items[epi->bit];
+	/*
+	 * Can be represented as:
+	 *
+	 *    was_ready = uitem->ready_events;
+	 *    uitem->ready_events &= ~EPOLLREMOVED;
+	 *    uitem->ready_events |= pollflags;
+	 *    if (!was_ready) {
+	 *         // create index entry
+	 *    }
+	 *
+	 * See the big comment inside ep_remove_user_item(), why it is
+	 * important to mask EPOLLREMOVED.
+	 */
+	if (!atomic_or_with_mask(&uitem->ready_events,
+				 pollflags, EPOLLREMOVED)) {
+		unsigned int i, *item_idx, index_mask;
+
+		/*
+		 * Item was not ready before, thus we have to insert
+		 * new index to the ring.
+		 */
+
+		index_mask = ep_max_index_nr(ep) - 1;
+		i = __atomic_fetch_add(&ep->user_header->tail, 1,
+				       __ATOMIC_ACQUIRE);
+		item_idx = &ep->user_index[i & index_mask];
+
+		/* Signal with a bit, which is > 0 */
+		*item_idx = epi->bit + 1;
+
+		/*
+		 * Want index update be flushed from CPU write buffer and
+		 * immediately visible on userspace side to avoid long busy
+		 * loops.
+		 */
+		smp_wmb();
+
+		added = true;
+	}
+
+	return added;
+}
+
 /*
  * Removes a "struct epitem" from the eventpoll RB tree and deallocates
  * all the associated resources. Must be called with "mtx" held.
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index 95ac0b564529..70aa80ddff25 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -42,6 +42,9 @@
 #define EPOLLMSG	(__force __poll_t)0x00000400
 #define EPOLLRDHUP	(__force __poll_t)0x00002000
 
+/* User item marked as removed for EPOLL_USERPOLL */
+#define EPOLLREMOVED	((__force __poll_t)(1U << 27))
+
 /* Set exclusive wakeup mode for the target file descriptor */
 #define EPOLLEXCLUSIVE	((__force __poll_t)(1U << 28))
 
-- 
2.21.0

