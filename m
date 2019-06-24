Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213E350ECE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfFXOmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:42:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:50386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728770AbfFXOmE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:42:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D3D8AEC7;
        Mon, 24 Jun 2019 14:42:02 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/14] epoll: introduce helpers for adding/removing events to uring
Date:   Mon, 24 Jun 2019 16:41:43 +0200
Message-Id: <20190624144151.22688-7-rpenyaev@suse.de>
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
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c                 | 240 +++++++++++++++++++++++++++++++++
 include/uapi/linux/eventpoll.h |   3 +
 2 files changed, 243 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f2a2be93bc4b..3b1f6a210247 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -195,6 +195,9 @@ struct uepitem {
 
 	/* Work for offloading event callback */
 	struct work_struct work;
+
+	/* Bit in user bitmap for user polling */
+	unsigned int bit;
 };
 
 /*
@@ -447,6 +450,11 @@ static inline unsigned int ep_to_items_bm_length(unsigned int nr)
 	return PAGE_ALIGN(ALIGN(nr, 8) >> 3);
 }
 
+static inline unsigned int ep_max_index_nr(struct eventpoll *ep)
+{
+	return ep->index_length >> ilog2(sizeof(*ep->user_index));
+}
+
 static inline bool ep_userpoll_supported(void)
 {
 	/*
@@ -898,6 +906,238 @@ static void epi_rcu_free(struct rcu_head *head)
 	kmem_cache_free(epi_cache, epi);
 }
 
+#define set_unless_zero_atomically(ptr, flags)			\
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
+	struct uepitem *uepi = uep_item_from_epi(epi);
+	struct eventpoll *ep = epi->ep;
+	struct epoll_uitem *uitem;
+
+	lockdep_assert_held(&ep->mtx);
+
+	/* Event should not have any attached queues */
+	WARN_ON(!list_empty(&epi->pwqlist));
+
+	uitem = &ep->user_header->items[uepi->bit];
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
+	set_unless_zero_atomically(&uitem->ready_events, EPOLLREMOVED);
+	clear_bit(uepi->bit, ep->items_bm);
+}
+
+#define or_with_mask_atomically(ptr, flags, mask)		\
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
+static inline unsigned int cnt_to_monotonic(unsigned long long cnt)
+{
+	/*
+	 * Monotonic counter is the index inside the uring, so
+	 * should be big enough to hold all possible event items.
+	 */
+	BUILD_BUG_ON(EP_USERPOLL_MAX_ITEMS_NR > BIT(32));
+
+	return (cnt >> 32);
+}
+
+static inline unsigned int cnt_to_advance(unsigned long long cnt)
+{
+	/*
+	 * In worse barely possible case each registered event
+	 * item signals completion in parallel.  In order not
+	 * to overflow the counter keep it equal or bigger
+	 * than max number of items.
+	 */
+	BUILD_BUG_ON(EP_USERPOLL_MAX_ITEMS_NR > BIT(16));
+
+	return (cnt >> 16) & 0xffff;
+}
+
+static inline unsigned int cnt_to_refs(unsigned long long cnt)
+{
+	/*
+	 * Counter should be big enough to hold references of all
+	 * possible CPUs which can add events in parallel.
+	 * Although, of course, this will never happen.
+	 */
+	BUILD_BUG_ON(NR_CPUS > BIT(16));
+
+	return (cnt & 0xffff);
+}
+
+#define MONOTONIC_MASK ((1ull<<32)-1)
+#define SINGLE_COUNTER ((1ull<<32)|(1ull<<16)|1ull)
+
+/**
+ * add_event_to_uring() - adds event to the uring locklessly.
+ *
+ * The most important here is a layout of ->shadow_cnt, which includes
+ * three counters which all of them should be increased atomically, all
+ * at once.  The layout can be represented as the following:
+ *
+ *    struct counter_t {
+ *        unsigned long long monotonic :32;
+ *        unsigned long long advance   :16;
+ *        unsigned long long refs      :16;
+ *    };
+ *
+ *    'monotonic' - Monotonically increases on each event insertion,
+ *                  never decreases.  Used as an index for an event
+ *                  in the uring.
+ *
+ *    'advance'   - Represents number of events on which user ->tail
+ *                  has to be advanced.  Monotonically increases if
+ *                  events are coming in parallel from different cpus
+ *                  and reference number keeps > 1.
+ *
+ *   'refs'       - Represents reference number, i.e. number of cpus
+ *                  inserting events in parallel.  Once there is a
+ *                  last inserter (the reference is 1), it should
+ *                  zero out 'advance' member and advance the tail
+ *                  for the userspace.
+ *
+ * What this is all about?  The main problem is that since event can
+ * be inserted from many cpus in parallel, we can't advance the tail
+ * if previous insertion has not been fully completed.  The idea to
+ * solve this is simple: the last one advances the tail.  Who is
+ * exactly the last?  Who detects the reference number is equal to 1.
+ */
+static inline void add_event_to_uring(struct uepitem *uepi)
+{
+	struct eventpoll *ep = uepi->epi.ep;
+
+	unsigned int *item_idx, idx, index_mask, advance;
+	unsigned long long old, cnt;
+
+	index_mask = ep_max_index_nr(ep) - 1;
+	/* Increase all three subcounters at once */
+	cnt = atomic64_add_return_acquire(SINGLE_COUNTER, &ep->shadow_cnt);
+
+	idx = cnt_to_monotonic(cnt) - 1;
+	item_idx = &ep->user_index[idx & index_mask];
+
+	/* Add a bit to the uring */
+	WRITE_ONCE(*item_idx, uepi->bit);
+
+	do {
+		old = cnt;
+		if (cnt_to_refs(cnt) == 1) {
+			/* We are the last, we will advance the tail */
+			advance = cnt_to_advance(cnt);
+			WARN_ON(!advance);
+			/* Zero out all fields except monotonic counter */
+			cnt &= ~MONOTONIC_MASK;
+		} else {
+			/* Someone else will advance, only drop the ref */
+			advance = 0;
+			cnt -= 1;
+		}
+	} while ((cnt = atomic64_cmpxchg_release(&ep->shadow_cnt,
+						 old, cnt)) != old);
+
+	if (advance) {
+		/*
+		 * Advance the tail executing `tail += advance` operation,
+		 * but since tail is shared with userspace, we can't use
+		 * kernel atomic_t for just atomic add, so use cmpxchg().
+		 * Sigh.
+		 *
+		 * We can race here with another cpu which also advances the
+		 * tail.  This is absolutely ok, since the tail is advanced
+		 * in one direction and eventually addition is commutative.
+		 */
+		unsigned int old, tail = READ_ONCE(ep->user_header->tail);
+
+		do {
+			old = tail;
+		} while ((tail = cmpxchg(&ep->user_header->tail,
+					 old, old + advance)) != old);
+	}
+}
+
+static inline bool ep_add_event_to_uring(struct epitem *epi, __poll_t pollflags)
+{
+	struct uepitem *uepi = uep_item_from_epi(epi);
+	struct eventpoll *ep = epi->ep;
+	struct epoll_uitem *uitem;
+	bool added = false;
+
+	if (WARN_ON(!pollflags))
+		return false;
+
+	uitem = &ep->user_header->items[uepi->bit];
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
+	if (!or_with_mask_atomically(&uitem->ready_events,
+				     pollflags, EPOLLREMOVED)) {
+		/*
+		 * Item was not ready before, thus we have to insert
+		 * new index to the ring.
+		 */
+		add_event_to_uring(uepi);
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
index efd58e9177c2..d3246a02dc2b 100644
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

