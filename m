Return-Path: <linux-fsdevel+bounces-49329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AB3ABB652
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142E21720D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3855C267F43;
	Mon, 19 May 2025 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tdkNlpK7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fbCaoz/l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1B267B86;
	Mon, 19 May 2025 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747640430; cv=none; b=FCAAxic4/HTCLn1P9KxxvQT0juBglrfNHwEX75Us183bkEbA+imNYqKaaXxRZwtFoyIC+lW+0q6UyzQmMiM6kxem6S25dl/T+VYGjIPSiO89Dwe54FxK7R3U/DoCdTNywR120mnthuIbxp1+jT5x8DnEYk+RRjoC9YAFZNEyLLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747640430; c=relaxed/simple;
	bh=IHA3NsPAAw5JM6tyzUiRbDSmBGErIkGqNyyxncZLsp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ic5exuEFQ1s0TlJ2FQMKmhRcB5Xyy0SkdocTej41SVFOV1uRz2d/H0P4RWU9MWnSjnzeyiX3IG9nOv9x7Qn/UdUynXSc51JSS5TGKuKv/x+BO6RfCuFVIAKALLhlyQS+p3MTKE42jl2GSbD7RIH/PqW5zxNJjlCr/UllIy5SSqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tdkNlpK7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fbCaoz/l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747640425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p7r7GRKQBydnLR8bjavjuORSd62j4R4leXkGB1/LY/I=;
	b=tdkNlpK7BKW5vAMI0TqLx9oinLnFvyyPfDjcrwmhBhHR0NN7QASCkLbdUDV+s3XgYyAsWd
	iwMl0gDi4Kaw+cp0UxbOQr3L1f073QIQKBi4kB+Yl92RrHojpE5ZbLa5Ml1WGaiedXqhJp
	lnhWHGVhrwSOxDtPoMX57/70WURwb+T61d92scEOnJxTmgEOYoHL2DX3aLRhFv7l0mXryF
	OpPhhlxLvm66GUVZhgqPhRsBbt7BMxeTBJL17qdAR6jqvJbUhkJVzsP4iCWKKfb/vluDAe
	4Tb4tmMHwNz9a9ktW8xN60504IJ/BxiRT94SxKLzfLEcarHV8KlYgCcYKwNxSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747640425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p7r7GRKQBydnLR8bjavjuORSd62j4R4leXkGB1/LY/I=;
	b=fbCaoz/l2jr2DhQYGx8KMjG5RuhhsK5Fb419c2YtOvB3GYmytyI6y94PAao+CSL0v663lW
	wLuNiKskbD4alKDg==
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>
Cc: Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] eventpoll: Fix priority inversion problem
Date: Mon, 19 May 2025 09:40:16 +0200
Message-Id: <20250519074016.3337326-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ready event list of an epoll object is protected by read-write
semaphore:

  - The consumer (waiter) acquires the write lock and takes items.
  - the producer (waker) takes the read lock and adds items.

The point of this design is enabling epoll to scale well with large number
of producers, as multiple producers can hold the read lock at the same
time.

Unfortunately, this implementation may cause scheduling priority inversion
problem. Suppose the consumer has higher scheduling priority than the
producer. The consumer needs to acquire the write lock, but may be blocked
by the producer holding the read lock. Since read-write semaphore does not
support priority-boosting for the readers (even with CONFIG_PREEMPT_RT=3Dy),
we have a case of priority inversion: a higher priority consumer is blocked
by a lower priority producer. This problem was reported in [1].

Furthermore, this could also cause stall problem, as described in [2].

To fix this problem, make the event list half-lockless:

  - The consumer acquires a mutex (ep->mtx) and takes items.
  - The producer locklessly adds items to the list.

Performance is not the main goal of this patch, but as the producer now can
add items without waiting for consumer to release the lock, performance
improvement is observed using the stress test from
https://github.com/rouming/test-tools/blob/master/stress-epoll.c. This is
the same test that justified using read-write semaphore in the past.

Testing using 12 x86_64 CPUs:

          Before     After        Diff
threads  events/ms  events/ms
      8       6944      20151    +190%
     16       9367      27972    +199%
     32       8707      31872    +266%
     64      10342      38577    +273%
    128      10860      40062    +269%

Testing using 1 riscv64 CPU (averaged over 10 runs, as the numbers are
noisy):

          Before     After        Diff
threads  events/ms  events/ms
      1         75         96     +28%
      2        153        158      +3%
      4        229        257     +12%
      8        250        270      +8%
     16        263        275      +5%

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Closes: https://lore.kernel.org/linux-rt-users/20210825132754.GA895675@loth=
ringen/ [1]
Reported-by: Valentin Schneider <vschneid@redhat.com>
Closes: https://lore.kernel.org/linux-rt-users/xhsmhttqvnall.mognet@vschnei=
d.remote.csb/ [2]
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 fs/eventpoll.c | 443 +++++++++++++++++++++----------------------------
 1 file changed, 187 insertions(+), 256 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d4dbffdedd08..a1e8e206f5f2 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -136,14 +136,28 @@ struct epitem {
 		struct rcu_head rcu;
 	};
=20
-	/* List header used to link this structure to the eventpoll ready list */
-	struct list_head rdllink;
+	/*
+	 * Whether this item can be added to the eventpoll ready list. Adding to =
the list can be
+	 * blocked for two reasons:
+	 *
+	 *  1. This item is already on the list.
+	 *  2. A waiter is consuming the ready list and has consumed this item. T=
he waiter therefore
+	 *     is blocking this item from being added again, preventing seeing th=
e same item twice.
+	 *     If adding is blocked due to this reason, the waiter will add this =
item to the list
+	 *     once consuming is done.
+	 */
+	bool link_locked;
=20
 	/*
-	 * Works together "struct eventpoll"->ovflist in keeping the
-	 * single linked chain of items.
+	 * Indicate whether this item is ready for consumption. All items on the =
ready list has this
+	 * flag set. Item that should be on the ready list, but cannot be added b=
ecause of
+	 * link_locked (in other words, a waiter is consuming the ready list), al=
so has this flag
+	 * set. When a waiter is done consuming, the waiter will add ready items =
to the ready list.
 	 */
-	struct epitem *next;
+	bool ready;
+
+	/* List header used to link this structure to the eventpoll ready list */
+	struct llist_node rdllink;
=20
 	/* The file descriptor information this item refers to */
 	struct epoll_filefd ffd;
@@ -191,22 +205,15 @@ struct eventpoll {
 	/* Wait queue used by file->poll() */
 	wait_queue_head_t poll_wait;
=20
-	/* List of ready file descriptors */
-	struct list_head rdllist;
-
-	/* Lock which protects rdllist and ovflist */
-	rwlock_t lock;
+	/*
+	 * List of ready file descriptors. Adding to this list is lockless. Only =
one task can remove
+	 * from this list at a time, which is ensured by the mutex "mtx".
+	 */
+	struct llist_head rdllist;
=20
 	/* RB tree root used to store monitored fd structs */
 	struct rb_root_cached rbr;
=20
-	/*
-	 * This is a single linked list that chains all the "struct epitem" that
-	 * happened while transferring ready events to userspace w/out
-	 * holding ->lock.
-	 */
-	struct epitem *ovflist;
-
 	/* wakeup_source used when ep_send_events or __ep_eventpoll_poll is runni=
ng */
 	struct wakeup_source *ws;
=20
@@ -361,10 +368,27 @@ static inline int ep_cmp_ffd(struct epoll_filefd *p1,
 	        (p1->file < p2->file ? -1 : p1->fd - p2->fd));
 }
=20
-/* Tells us if the item is currently linked */
-static inline int ep_is_linked(struct epitem *epi)
+static void epitem_ready(struct epitem *epi)
 {
-	return !list_empty(&epi->rdllink);
+	/*
+	 * Mark it ready, just in case a waiter is blocking this item from going =
into the ready
+	 * list. This will tell the waiter to add this item to the ready list, af=
ter the waiter is
+	 * finished.
+	 */
+	xchg(&epi->ready, true);
+
+	/*
+	 * If this item is not blocked, add it to the ready list. This item could=
 be blocked for two
+	 * reasons:
+	 *
+	 * 1. It is already on the ready list. Then nothing further is required.
+	 * 2. A waiter is consuming the ready list, and has consumed this item. T=
he waiter is now
+	 *    blocking this item, so that this item won't be seen twice. In this =
case, the waiter
+	 *    will add this item to the ready list after the waiter is finished.
+	 */
+	if (!cmpxchg(&epi->link_locked, false, true))
+		llist_add(&epi->rdllink, &epi->ep->rdllist);
+
 }
=20
 static inline struct eppoll_entry *ep_pwq_from_wait(wait_queue_entry_t *p)
@@ -383,13 +407,27 @@ static inline struct epitem *ep_item_from_wait(wait_q=
ueue_entry_t *p)
  *
  * @ep: Pointer to the eventpoll context.
  *
- * Return: a value different than %zero if ready events are available,
- *          or %zero otherwise.
+ * Return: true if ready events might be available, false otherwise.
  */
-static inline int ep_events_available(struct eventpoll *ep)
+static inline bool ep_events_available(struct eventpoll *ep)
 {
-	return !list_empty_careful(&ep->rdllist) ||
-		READ_ONCE(ep->ovflist) !=3D EP_UNACTIVE_PTR;
+	bool available;
+	int locked;
+
+	locked =3D mutex_trylock(&ep->mtx);
+	if (!locked) {
+		/*
+		 * Someone else is holding the lock and may be removing/adding items to =
rdllist,
+		 * therefore the llist_empty() test below is not reliable. Return true i=
n this case,
+		 * as in "events might be available". We will know for sure if there is =
event in
+		 * ep_try_send_events().
+		 */
+		return true;
+	}
+
+	available =3D !llist_empty(&ep->rdllist);
+	mutex_unlock(&ep->mtx);
+	return available;
 }
=20
 #ifdef CONFIG_NET_RX_BUSY_POLL
@@ -724,77 +762,6 @@ static inline void ep_pm_stay_awake_rcu(struct epitem =
*epi)
 	rcu_read_unlock();
 }
=20
-
-/*
- * ep->mutex needs to be held because we could be hit by
- * eventpoll_release_file() and epoll_ctl().
- */
-static void ep_start_scan(struct eventpoll *ep, struct list_head *txlist)
-{
-	/*
-	 * Steal the ready list, and re-init the original one to the
-	 * empty list. Also, set ep->ovflist to NULL so that events
-	 * happening while looping w/out locks, are not lost. We cannot
-	 * have the poll callback to queue directly on ep->rdllist,
-	 * because we want the "sproc" callback to be able to do it
-	 * in a lockless way.
-	 */
-	lockdep_assert_irqs_enabled();
-	write_lock_irq(&ep->lock);
-	list_splice_init(&ep->rdllist, txlist);
-	WRITE_ONCE(ep->ovflist, NULL);
-	write_unlock_irq(&ep->lock);
-}
-
-static void ep_done_scan(struct eventpoll *ep,
-			 struct list_head *txlist)
-{
-	struct epitem *epi, *nepi;
-
-	write_lock_irq(&ep->lock);
-	/*
-	 * During the time we spent inside the "sproc" callback, some
-	 * other events might have been queued by the poll callback.
-	 * We re-insert them inside the main ready-list here.
-	 */
-	for (nepi =3D READ_ONCE(ep->ovflist); (epi =3D nepi) !=3D NULL;
-	     nepi =3D epi->next, epi->next =3D EP_UNACTIVE_PTR) {
-		/*
-		 * We need to check if the item is already in the list.
-		 * During the "sproc" callback execution time, items are
-		 * queued into ->ovflist but the "txlist" might already
-		 * contain them, and the list_splice() below takes care of them.
-		 */
-		if (!ep_is_linked(epi)) {
-			/*
-			 * ->ovflist is LIFO, so we have to reverse it in order
-			 * to keep in FIFO.
-			 */
-			list_add(&epi->rdllink, &ep->rdllist);
-			ep_pm_stay_awake(epi);
-		}
-	}
-	/*
-	 * We need to set back ep->ovflist to EP_UNACTIVE_PTR, so that after
-	 * releasing the lock, events will be queued in the normal way inside
-	 * ep->rdllist.
-	 */
-	WRITE_ONCE(ep->ovflist, EP_UNACTIVE_PTR);
-
-	/*
-	 * Quickly re-inject items left on "txlist".
-	 */
-	list_splice(txlist, &ep->rdllist);
-	__pm_relax(ep->ws);
-
-	if (!list_empty(&ep->rdllist)) {
-		if (waitqueue_active(&ep->wq))
-			wake_up(&ep->wq);
-	}
-
-	write_unlock_irq(&ep->lock);
-}
-
 static void ep_get(struct eventpoll *ep)
 {
 	refcount_inc(&ep->refcount);
@@ -832,8 +799,10 @@ static void ep_free(struct eventpoll *ep)
 static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool for=
ce)
 {
 	struct file *file =3D epi->ffd.file;
+	struct llist_node *put_back_last;
 	struct epitems_head *to_free;
 	struct hlist_head *head;
+	LLIST_HEAD(put_back);
=20
 	lockdep_assert_irqs_enabled();
=20
@@ -867,10 +836,25 @@ static bool __ep_remove(struct eventpoll *ep, struct =
epitem *epi, bool force)
=20
 	rb_erase_cached(&epi->rbn, &ep->rbr);
=20
-	write_lock_irq(&ep->lock);
-	if (ep_is_linked(epi))
-		list_del_init(&epi->rdllink);
-	write_unlock_irq(&ep->lock);
+	/*
+	 * ep->mtx is held, which means no waiter is touching the ready list. Thi=
s item is also no
+	 * longer being added. Therefore, the ready flag can only mean one thing:=
 this item is on
+	 * the ready list.
+	 */
+	if (smp_load_acquire(&epi->ready)) {
+		put_back_last =3D NULL;
+		while (true) {
+			struct llist_node *n =3D llist_del_first(&ep->rdllist);
+
+			if (&epi->rdllink =3D=3D n || WARN_ON(!n))
+				break;
+			if (!put_back_last)
+				put_back_last =3D n;
+			llist_add(n, &put_back);
+		}
+		if (put_back_last)
+			llist_add_batch(put_back.first, put_back_last, &ep->rdllist);
+	}
=20
 	wakeup_source_unregister(ep_wakeup_source(epi));
 	/*
@@ -974,8 +958,9 @@ static __poll_t ep_item_poll(const struct epitem *epi, =
poll_table *pt, int depth
 static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, i=
nt depth)
 {
 	struct eventpoll *ep =3D file->private_data;
-	LIST_HEAD(txlist);
-	struct epitem *epi, *tmp;
+	struct wakeup_source *ws;
+	struct llist_node *n;
+	struct epitem *epi;
 	poll_table pt;
 	__poll_t res =3D 0;
=20
@@ -989,22 +974,58 @@ static __poll_t __ep_eventpoll_poll(struct file *file=
, poll_table *wait, int dep
 	 * the ready list.
 	 */
 	mutex_lock_nested(&ep->mtx, depth);
-	ep_start_scan(ep, &txlist);
-	list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
+	while (true) {
+		n =3D llist_del_first(&ep->rdllist);
+		if (!n)
+			break;
+
+		epi =3D llist_entry(n, struct epitem, rdllink);
+
+		/*
+		 * Clear the ready flag now. If it is actually ready, we will set it bac=
k.
+		 *
+		 * However, if it is not ready now, it could become ready after ep_item_=
poll() and
+		 * before we release list_locked this item, and it wouldn't be added to =
the ready
+		 * list. To detect that case, we look at this flag again after releasing
+		 * link_locked, so that it can be added to the ready list if required.
+		 */
+		xchg(&epi->ready, false);
+
 		if (ep_item_poll(epi, &pt, depth + 1)) {
 			res =3D EPOLLIN | EPOLLRDNORM;
+			xchg(&epi->ready, true);
+			llist_add(n, &ep->rdllist);
 			break;
 		} else {
 			/*
-			 * Item has been dropped into the ready list by the poll
-			 * callback, but it's not actually ready, as far as
-			 * caller requested events goes. We can remove it here.
+			 * We need to activate ep before deactivating epi, to prevent autosuspe=
nd
+			 * just in case epi becomes active after ep_item_poll() above.
+			 *
+			 * This is similar to ep_send_events().
 			 */
+			ws =3D ep_wakeup_source(epi);
+			if (ws) {
+				if (ws->active)
+					__pm_stay_awake(ep->ws);
+				__pm_relax(ws);
+			}
 			__pm_relax(ep_wakeup_source(epi));
-			list_del_init(&epi->rdllink);
+
+			xchg(&epi->link_locked, false);
+
+			/*
+			 * Check the ready flag, just in case the item becomes ready after
+			 * ep_item_poll() but before releasing link_locked above. The item was
+			 * blocked from being added, so we add it now.
+			 */
+			if (smp_load_acquire(&epi->ready)) {
+				ep_pm_stay_awake(epi);
+				epitem_ready(epi);
+			}
+
+			__pm_relax(ep->ws);
 		}
 	}
-	ep_done_scan(ep, &txlist);
 	mutex_unlock(&ep->mtx);
 	return res;
 }
@@ -1153,12 +1174,10 @@ static int ep_alloc(struct eventpoll **pep)
 		return -ENOMEM;
=20
 	mutex_init(&ep->mtx);
-	rwlock_init(&ep->lock);
 	init_waitqueue_head(&ep->wq);
 	init_waitqueue_head(&ep->poll_wait);
-	INIT_LIST_HEAD(&ep->rdllist);
+	init_llist_head(&ep->rdllist);
 	ep->rbr =3D RB_ROOT_CACHED;
-	ep->ovflist =3D EP_UNACTIVE_PTR;
 	ep->user =3D get_current_user();
 	refcount_set(&ep->refcount, 1);
=20
@@ -1293,41 +1312,11 @@ static inline bool list_add_tail_lockless(struct li=
st_head *new,
 	return true;
 }
=20
-/*
- * Chains a new epi entry to the tail of the ep->ovflist in a lockless way,
- * i.e. multiple CPUs are allowed to call this function concurrently.
- *
- * Return: %false if epi element has been already chained, %true otherwise.
- */
-static inline bool chain_epi_lockless(struct epitem *epi)
-{
-	struct eventpoll *ep =3D epi->ep;
-
-	/* Fast preliminary check */
-	if (epi->next !=3D EP_UNACTIVE_PTR)
-		return false;
-
-	/* Check that the same epi has not been just chained from another CPU */
-	if (cmpxchg(&epi->next, EP_UNACTIVE_PTR, NULL) !=3D EP_UNACTIVE_PTR)
-		return false;
-
-	/* Atomically exchange tail */
-	epi->next =3D xchg(&ep->ovflist, epi);
-
-	return true;
-}
-
 /*
  * This is the callback that is passed to the wait queue wakeup
  * mechanism. It is called by the stored file descriptors when they
  * have events to report.
  *
- * This callback takes a read lock in order not to contend with concurrent
- * events from another file descriptor, thus all modifications to ->rdllist
- * or ->ovflist are lockless.  Read lock is paired with the write lock from
- * ep_start/done_scan(), which stops all list modifications and guarantees
- * that lists state is seen correctly.
- *
  * Another thing worth to mention is that ep_poll_callback() can be called
  * concurrently for the same @epi from different CPUs if poll table was in=
ited
  * with several wait queues entries.  Plural wakeup from different CPUs of=
 a
@@ -1337,15 +1326,11 @@ static inline bool chain_epi_lockless(struct epitem=
 *epi)
  */
 static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int s=
ync, void *key)
 {
-	int pwake =3D 0;
 	struct epitem *epi =3D ep_item_from_wait(wait);
 	struct eventpoll *ep =3D epi->ep;
 	__poll_t pollflags =3D key_to_poll(key);
-	unsigned long flags;
 	int ewake =3D 0;
=20
-	read_lock_irqsave(&ep->lock, flags);
-
 	ep_set_busy_poll_napi_id(epi);
=20
 	/*
@@ -1355,7 +1340,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait,=
 unsigned mode, int sync, v
 	 * until the next EPOLL_CTL_MOD will be issued.
 	 */
 	if (!(epi->event.events & ~EP_PRIVATE_BITS))
-		goto out_unlock;
+		goto out;
=20
 	/*
 	 * Check the events coming with the callback. At this stage, not
@@ -1364,22 +1349,10 @@ static int ep_poll_callback(wait_queue_entry_t *wai=
t, unsigned mode, int sync, v
 	 * test for "key" !=3D NULL before the event match test.
 	 */
 	if (pollflags && !(pollflags & epi->event.events))
-		goto out_unlock;
+		goto out;
=20
-	/*
-	 * If we are transferring events to userspace, we can hold no locks
-	 * (because we're accessing user memory, and because of linux f_op->poll()
-	 * semantics). All the events that happen during that period of time are
-	 * chained in ep->ovflist and requeued later on.
-	 */
-	if (READ_ONCE(ep->ovflist) !=3D EP_UNACTIVE_PTR) {
-		if (chain_epi_lockless(epi))
-			ep_pm_stay_awake_rcu(epi);
-	} else if (!ep_is_linked(epi)) {
-		/* In the usual case, add event to ready list. */
-		if (list_add_tail_lockless(&epi->rdllink, &ep->rdllist))
-			ep_pm_stay_awake_rcu(epi);
-	}
+	ep_pm_stay_awake_rcu(epi);
+	epitem_ready(epi);
=20
 	/*
 	 * Wake up ( if active ) both the eventpoll wait list and the ->poll()
@@ -1408,15 +1381,9 @@ static int ep_poll_callback(wait_queue_entry_t *wait=
, unsigned mode, int sync, v
 			wake_up(&ep->wq);
 	}
 	if (waitqueue_active(&ep->poll_wait))
-		pwake++;
-
-out_unlock:
-	read_unlock_irqrestore(&ep->lock, flags);
-
-	/* We have to call this outside the lock */
-	if (pwake)
 		ep_poll_safewake(ep, epi, pollflags & EPOLL_URING_WAKE);
=20
+out:
 	if (!(epi->event.events & EPOLLEXCLUSIVE))
 		ewake =3D 1;
=20
@@ -1674,11 +1641,10 @@ static int ep_insert(struct eventpoll *ep, const st=
ruct epoll_event *event,
 	}
=20
 	/* Item initialization follow here ... */
-	INIT_LIST_HEAD(&epi->rdllink);
+	init_llist_node(&epi->rdllink);
 	epi->ep =3D ep;
 	ep_set_ffd(&epi->ffd, tfile, fd);
 	epi->event =3D *event;
-	epi->next =3D EP_UNACTIVE_PTR;
=20
 	if (tep)
 		mutex_lock_nested(&tep->mtx, 1);
@@ -1745,16 +1711,13 @@ static int ep_insert(struct eventpoll *ep, const st=
ruct epoll_event *event,
 		return -ENOMEM;
 	}
=20
-	/* We have to drop the new item inside our item list to keep track of it =
*/
-	write_lock_irq(&ep->lock);
-
 	/* record NAPI ID of new item if present */
 	ep_set_busy_poll_napi_id(epi);
=20
 	/* If the file is already "ready" we drop it inside the ready list */
-	if (revents && !ep_is_linked(epi)) {
-		list_add_tail(&epi->rdllink, &ep->rdllist);
+	if (revents) {
 		ep_pm_stay_awake(epi);
+		epitem_ready(epi);
=20
 		/* Notify waiting tasks that events are available */
 		if (waitqueue_active(&ep->wq))
@@ -1763,8 +1726,6 @@ static int ep_insert(struct eventpoll *ep, const stru=
ct epoll_event *event,
 			pwake++;
 	}
=20
-	write_unlock_irq(&ep->lock);
-
 	/* We have to call this outside the lock */
 	if (pwake)
 		ep_poll_safewake(ep, NULL, 0);
@@ -1779,7 +1740,6 @@ static int ep_insert(struct eventpoll *ep, const stru=
ct epoll_event *event,
 static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 		     const struct epoll_event *event)
 {
-	int pwake =3D 0;
 	poll_table pt;
=20
 	lockdep_assert_irqs_enabled();
@@ -1827,24 +1787,16 @@ static int ep_modify(struct eventpoll *ep, struct e=
pitem *epi,
 	 * list, push it inside.
 	 */
 	if (ep_item_poll(epi, &pt, 1)) {
-		write_lock_irq(&ep->lock);
-		if (!ep_is_linked(epi)) {
-			list_add_tail(&epi->rdllink, &ep->rdllist);
-			ep_pm_stay_awake(epi);
+		ep_pm_stay_awake(epi);
+		epitem_ready(epi);
=20
-			/* Notify waiting tasks that events are available */
-			if (waitqueue_active(&ep->wq))
-				wake_up(&ep->wq);
-			if (waitqueue_active(&ep->poll_wait))
-				pwake++;
-		}
-		write_unlock_irq(&ep->lock);
+		/* Notify waiting tasks that events are available */
+		if (waitqueue_active(&ep->wq))
+			wake_up(&ep->wq);
+		if (waitqueue_active(&ep->poll_wait))
+			ep_poll_safewake(ep, NULL, 0);
 	}
=20
-	/* We have to call this outside the lock */
-	if (pwake)
-		ep_poll_safewake(ep, NULL, 0);
-
 	return 0;
 }
=20
@@ -1852,7 +1804,7 @@ static int ep_send_events(struct eventpoll *ep,
 			  struct epoll_event __user *events, int maxevents)
 {
 	struct epitem *epi, *tmp;
-	LIST_HEAD(txlist);
+	LLIST_HEAD(txlist);
 	poll_table pt;
 	int res =3D 0;
=20
@@ -1867,19 +1819,20 @@ static int ep_send_events(struct eventpoll *ep,
 	init_poll_funcptr(&pt, NULL);
=20
 	mutex_lock(&ep->mtx);
-	ep_start_scan(ep, &txlist);
=20
-	/*
-	 * We can loop without lock because we are passed a task private list.
-	 * Items cannot vanish during the loop we are holding ep->mtx.
-	 */
-	list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
+	while (res < maxevents) {
 		struct wakeup_source *ws;
+		struct llist_node *n;
 		__poll_t revents;
=20
-		if (res >=3D maxevents)
+		n =3D llist_del_first(&ep->rdllist);
+		if (!n)
 			break;
=20
+		epi =3D llist_entry(n, struct epitem, rdllink);
+		llist_add(n, &txlist);
+		xchg(&epi->ready, false);
+
 		/*
 		 * Activate ep->ws before deactivating epi->ws to prevent
 		 * triggering auto-suspend here (in case we reactive epi->ws
@@ -1896,8 +1849,6 @@ static int ep_send_events(struct eventpoll *ep,
 			__pm_relax(ws);
 		}
=20
-		list_del_init(&epi->rdllink);
-
 		/*
 		 * If the event mask intersect the caller-requested one,
 		 * deliver the event to userspace. Again, we are holding ep->mtx,
@@ -1909,8 +1860,7 @@ static int ep_send_events(struct eventpoll *ep,
=20
 		events =3D epoll_put_uevent(revents, epi->event.data, events);
 		if (!events) {
-			list_add(&epi->rdllink, &txlist);
-			ep_pm_stay_awake(epi);
+			xchg(&epi->ready, true);
 			if (!res)
 				res =3D -EFAULT;
 			break;
@@ -1924,19 +1874,39 @@ static int ep_send_events(struct eventpoll *ep,
 			 * Trigger mode, we need to insert back inside
 			 * the ready list, so that the next call to
 			 * epoll_wait() will check again the events
-			 * availability. At this point, no one can insert
-			 * into ep->rdllist besides us. The epoll_ctl()
-			 * callers are locked out by
-			 * ep_send_events() holding "mtx" and the
-			 * poll callback will queue them in ep->ovflist.
+			 * availability.
 			 */
-			list_add_tail(&epi->rdllink, &ep->rdllist);
+			xchg(&epi->ready, true);
+		}
+	}
+
+	llist_for_each_entry_safe(epi, tmp, txlist.first, rdllink) {
+		/*
+		 * We are done iterating. Allow the items we took to be added back to th=
e ready
+		 * list.
+		 */
+		xchg(&epi->link_locked, false);
+
+		/*
+		 * In the loop above, we may mark some items ready, and they should be a=
dded back.
+		 *
+		 * Additionally, someone else may also attempt to add the item to the re=
ady list,
+		 * but got blocked by us. Add those blocked items now.
+		 */
+		if (smp_load_acquire(&epi->ready)) {
 			ep_pm_stay_awake(epi);
+			epitem_ready(epi);
 		}
 	}
-	ep_done_scan(ep, &txlist);
+
+	__pm_relax(ep->ws);
 	mutex_unlock(&ep->mtx);
=20
+	if (!llist_empty(&ep->rdllist)) {
+		if (waitqueue_active(&ep->wq))
+			wake_up(&ep->wq);
+	}
+
 	return res;
 }
=20
@@ -2090,54 +2060,15 @@ static int ep_poll(struct eventpoll *ep, struct epo=
ll_event __user *events,
 		init_wait(&wait);
 		wait.func =3D ep_autoremove_wake_function;
=20
-		write_lock_irq(&ep->lock);
-		/*
-		 * Barrierless variant, waitqueue_active() is called under
-		 * the same lock on wakeup ep_poll_callback() side, so it
-		 * is safe to avoid an explicit barrier.
-		 */
-		__set_current_state(TASK_INTERRUPTIBLE);
+		prepare_to_wait_exclusive(&ep->wq, &wait, TASK_INTERRUPTIBLE);
=20
-		/*
-		 * Do the final check under the lock. ep_start/done_scan()
-		 * plays with two lists (->rdllist and ->ovflist) and there
-		 * is always a race when both lists are empty for short
-		 * period of time although events are pending, so lock is
-		 * important.
-		 */
-		eavail =3D ep_events_available(ep);
-		if (!eavail)
-			__add_wait_queue_exclusive(&ep->wq, &wait);
-
-		write_unlock_irq(&ep->lock);
-
-		if (!eavail)
+		if (!ep_events_available(ep))
 			timed_out =3D !ep_schedule_timeout(to) ||
 				!schedule_hrtimeout_range(to, slack,
 							  HRTIMER_MODE_ABS);
-		__set_current_state(TASK_RUNNING);
-
-		/*
-		 * We were woken up, thus go and try to harvest some events.
-		 * If timed out and still on the wait queue, recheck eavail
-		 * carefully under lock, below.
-		 */
-		eavail =3D 1;
=20
-		if (!list_empty_careful(&wait.entry)) {
-			write_lock_irq(&ep->lock);
-			/*
-			 * If the thread timed out and is not on the wait queue,
-			 * it means that the thread was woken up after its
-			 * timeout expired before it could reacquire the lock.
-			 * Thus, when wait.entry is empty, it needs to harvest
-			 * events.
-			 */
-			if (timed_out)
-				eavail =3D list_empty(&wait.entry);
-			__remove_wait_queue(&ep->wq, &wait);
-			write_unlock_irq(&ep->lock);
-		}
+		finish_wait(&ep->wq, &wait);
+		eavail =3D ep_events_available(ep);
 	}
 }
=20
--=20
2.39.5


