Return-Path: <linux-fsdevel+bounces-54956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC419B05A84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3373BE527
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25743244695;
	Tue, 15 Jul 2025 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y9fEGtpB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HpUEw0wv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776DA199223;
	Tue, 15 Jul 2025 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583621; cv=none; b=nNXr8YUuv1tNsu8ZHEaKH9qn0/sKP06RsbG150QcjBXXMhEnDLaB1s20ScQ9ZDr8vvBtiW+wn+nnrlffDwSJ0iYvtRp2u8AUxTsZbhc7jnuH0OhVbLioc6qJQKiwwRDm7/x0ff+ETavfaeDoV8an4rysNjc0j/6T6XagoBBWdG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583621; c=relaxed/simple;
	bh=IlK2bVLQ/tQpstFHQfT0c8jyZpsaLFIT3/YxkfE+4mA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFuSEDB0IQNvsPjM/Tuxa4AUWJL9VKxhuEHctVHkfW0izDO964XoSMd3roVvZD0nk3IXsObxrDGSL1pEIq19QUWK9T21DqZZjaAjB7l/oymaU60OL5yJXm6mv9ASTRm3QJRUAJydl0q3mcDkjSxBseUEuCGAk80g5ySvGBg0834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y9fEGtpB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HpUEw0wv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752583617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwCEjj0M7xjz5wgzGm0hhm67ZY2HnHyYp2wxuoRe0qU=;
	b=y9fEGtpBEQwV8nDqj7got84N0VoHGKMX3GyhqyS8TDYKndIyhJJxx/rGh1IkTpNogsjXpr
	0oaZkt+KlphOPqjvgNMP+aDF0puhxP0QpES2rMFay/tp3+ixSXMlWjI/+6Neg6rf9aTQ5x
	nOxkcm41bBGBscDgyC3xflegonc23JCipFT4w1HYPIIjWM5hKq3oIFYMVJi6OkfIFt0hwy
	/fTCxqBZ9E9KoiwmoCDjLR/e/Hg6ZiH9T4S1LUEvNY02VFLUx2gObckt+b/b/6ZUxL9w1n
	WJygf4yBmJsSMpcX1zbTJ5FcjHjw8rtZevnTibBLsaKfs1DDDq+OSmIRG7gT1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752583617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwCEjj0M7xjz5wgzGm0hhm67ZY2HnHyYp2wxuoRe0qU=;
	b=HpUEw0wvOYg45Ud/Xj/M5tv6Fwn/ONFy8wQH0E/7K0MdPNnNVrLERM1KHiXMwyW10U8/cD
	iOqQKLQtuB7BaYAA==
To: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Xi Ruoyao <xry111@xry111.site>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
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
	stable@vger.kernel.org
Subject: [PATCH v4 1/1] eventpoll: Replace rwlock with spinlock
Date: Tue, 15 Jul 2025 14:46:34 +0200
Message-Id: <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
In-Reply-To: <cover.1752581388.git.namcao@linutronix.de>
References: <cover.1752581388.git.namcao@linutronix.de>
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

Fix this problem by replacing rwlock with spinlock.

This reduces the event bandwidth, as the producers now have to contend with
each other for the spinlock. According to the benchmark from
https://github.com/rouming/test-tools/blob/master/stress-epoll.c:

    On 12 x86 CPUs:
                  Before     After        Diff
        threads  events/ms  events/ms
              8       7162       4956     -31%
             16       8733       5383     -38%
             32       7968       5572     -30%
             64      10652       5739     -46%
            128      11236       5931     -47%

    On 4 riscv CPUs:
                  Before     After        Diff
        threads  events/ms  events/ms
              8       2958       2833      -4%
             16       3323       3097      -7%
             32       3451       3240      -6%
             64       3554       3178     -11%
            128       3601       3235     -10%

Although the numbers look bad, it should be noted that this benchmark
creates multiple threads who do nothing except constantly generating new
epoll events, thus contention on the spinlock is high. For real workload,
the event rate is likely much lower, and the performance drop is not as
bad.

Using another benchmark (perf bench epoll wait) where spinlock contention
is lower, improvement is even observed on x86:

    On 12 x86 CPUs:
        Before: Averaged 110279 operations/sec (+- 1.09%), total secs =3D 8
        After:  Averaged 114577 operations/sec (+- 2.25%), total secs =3D 8

    On 4 riscv CPUs:
        Before: Averaged 175767 operations/sec (+- 0.62%), total secs =3D 8
        After:  Averaged 167396 operations/sec (+- 0.23%), total secs =3D 8

In conclusion, no one is likely to be upset over this change. After all,
spinlock was used originally for years, and the commit which converted to
rwlock didn't mention a real workload, just that the benchmark numbers are
nice.

This patch is not exactly the revert of commit a218cc491420 ("epoll: use
rwlock in order to reduce ep_poll_callback() contention"), because git
revert conflicts in some places which are not obvious on the resolution.
This patch is intended to be backported, therefore go with the obvious
approach:

  - Replace rwlock_t with spinlock_t one to one

  - Delete list_add_tail_lockless() and chain_epi_lockless(). These were
    introduced to allow producers to concurrently add items to the list.
    But now that spinlock no longer allows producers to touch the event
    list concurrently, these two functions are not necessary anymore.

Fixes: a218cc491420 ("epoll: use rwlock in order to reduce ep_poll_callback=
() contention")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
 fs/eventpoll.c | 139 +++++++++----------------------------------------
 1 file changed, 26 insertions(+), 113 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 0fbf5dfedb24..a171f7e7dacc 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -46,10 +46,10 @@
  *
  * 1) epnested_mutex (mutex)
  * 2) ep->mtx (mutex)
- * 3) ep->lock (rwlock)
+ * 3) ep->lock (spinlock)
  *
  * The acquire order is the one listed above, from 1 to 3.
- * We need a rwlock (ep->lock) because we manipulate objects
+ * We need a spinlock (ep->lock) because we manipulate objects
  * from inside the poll callback, that might be triggered from
  * a wake_up() that in turn might be called from IRQ context.
  * So we can't sleep inside the poll callback and hence we need
@@ -195,7 +195,7 @@ struct eventpoll {
 	struct list_head rdllist;
=20
 	/* Lock which protects rdllist and ovflist */
-	rwlock_t lock;
+	spinlock_t lock;
=20
 	/* RB tree root used to store monitored fd structs */
 	struct rb_root_cached rbr;
@@ -740,10 +740,10 @@ static void ep_start_scan(struct eventpoll *ep, struc=
t list_head *txlist)
 	 * in a lockless way.
 	 */
 	lockdep_assert_irqs_enabled();
-	write_lock_irq(&ep->lock);
+	spin_lock_irq(&ep->lock);
 	list_splice_init(&ep->rdllist, txlist);
 	WRITE_ONCE(ep->ovflist, NULL);
-	write_unlock_irq(&ep->lock);
+	spin_unlock_irq(&ep->lock);
 }
=20
 static void ep_done_scan(struct eventpoll *ep,
@@ -751,7 +751,7 @@ static void ep_done_scan(struct eventpoll *ep,
 {
 	struct epitem *epi, *nepi;
=20
-	write_lock_irq(&ep->lock);
+	spin_lock_irq(&ep->lock);
 	/*
 	 * During the time we spent inside the "sproc" callback, some
 	 * other events might have been queued by the poll callback.
@@ -792,7 +792,7 @@ static void ep_done_scan(struct eventpoll *ep,
 			wake_up(&ep->wq);
 	}
=20
-	write_unlock_irq(&ep->lock);
+	spin_unlock_irq(&ep->lock);
 }
=20
 static void ep_get(struct eventpoll *ep)
@@ -867,10 +867,10 @@ static bool __ep_remove(struct eventpoll *ep, struct =
epitem *epi, bool force)
=20
 	rb_erase_cached(&epi->rbn, &ep->rbr);
=20
-	write_lock_irq(&ep->lock);
+	spin_lock_irq(&ep->lock);
 	if (ep_is_linked(epi))
 		list_del_init(&epi->rdllink);
-	write_unlock_irq(&ep->lock);
+	spin_unlock_irq(&ep->lock);
=20
 	wakeup_source_unregister(ep_wakeup_source(epi));
 	/*
@@ -1151,7 +1151,7 @@ static int ep_alloc(struct eventpoll **pep)
 		return -ENOMEM;
=20
 	mutex_init(&ep->mtx);
-	rwlock_init(&ep->lock);
+	spin_lock_init(&ep->lock);
 	init_waitqueue_head(&ep->wq);
 	init_waitqueue_head(&ep->poll_wait);
 	INIT_LIST_HEAD(&ep->rdllist);
@@ -1238,100 +1238,10 @@ struct file *get_epoll_tfile_raw_ptr(struct file *=
file, int tfd,
 }
 #endif /* CONFIG_KCMP */
=20
-/*
- * Adds a new entry to the tail of the list in a lockless way, i.e.
- * multiple CPUs are allowed to call this function concurrently.
- *
- * Beware: it is necessary to prevent any other modifications of the
- *         existing list until all changes are completed, in other words
- *         concurrent list_add_tail_lockless() calls should be protected
- *         with a read lock, where write lock acts as a barrier which
- *         makes sure all list_add_tail_lockless() calls are fully
- *         completed.
- *
- *        Also an element can be locklessly added to the list only in one
- *        direction i.e. either to the tail or to the head, otherwise
- *        concurrent access will corrupt the list.
- *
- * Return: %false if element has been already added to the list, %true
- * otherwise.
- */
-static inline bool list_add_tail_lockless(struct list_head *new,
-					  struct list_head *head)
-{
-	struct list_head *prev;
-
-	/*
-	 * This is simple 'new->next =3D head' operation, but cmpxchg()
-	 * is used in order to detect that same element has been just
-	 * added to the list from another CPU: the winner observes
-	 * new->next =3D=3D new.
-	 */
-	if (!try_cmpxchg(&new->next, &new, head))
-		return false;
-
-	/*
-	 * Initially ->next of a new element must be updated with the head
-	 * (we are inserting to the tail) and only then pointers are atomically
-	 * exchanged.  XCHG guarantees memory ordering, thus ->next should be
-	 * updated before pointers are actually swapped and pointers are
-	 * swapped before prev->next is updated.
-	 */
-
-	prev =3D xchg(&head->prev, new);
-
-	/*
-	 * It is safe to modify prev->next and new->prev, because a new element
-	 * is added only to the tail and new->next is updated before XCHG.
-	 */
-
-	prev->next =3D new;
-	new->prev =3D prev;
-
-	return true;
-}
-
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
- *
- * This callback takes a read lock in order not to contend with concurrent
- * events from another file descriptor, thus all modifications to ->rdllist
- * or ->ovflist are lockless.  Read lock is paired with the write lock from
- * ep_start/done_scan(), which stops all list modifications and guarantees
- * that lists state is seen correctly.
- *
- * Another thing worth to mention is that ep_poll_callback() can be called
- * concurrently for the same @epi from different CPUs if poll table was in=
ited
- * with several wait queues entries.  Plural wakeup from different CPUs of=
 a
- * single wait queue is serialized by wq.lock, but the case when multiple =
wait
- * queues are used should be detected accordingly.  This is detected using
- * cmpxchg() operation.
  */
 static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int s=
ync, void *key)
 {
@@ -1342,7 +1252,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait,=
 unsigned mode, int sync, v
 	unsigned long flags;
 	int ewake =3D 0;
=20
-	read_lock_irqsave(&ep->lock, flags);
+	spin_lock_irqsave(&ep->lock, flags);
=20
 	ep_set_busy_poll_napi_id(epi);
=20
@@ -1371,12 +1281,15 @@ static int ep_poll_callback(wait_queue_entry_t *wai=
t, unsigned mode, int sync, v
 	 * chained in ep->ovflist and requeued later on.
 	 */
 	if (READ_ONCE(ep->ovflist) !=3D EP_UNACTIVE_PTR) {
-		if (chain_epi_lockless(epi))
+		if (epi->next =3D=3D EP_UNACTIVE_PTR) {
+			epi->next =3D READ_ONCE(ep->ovflist);
+			WRITE_ONCE(ep->ovflist, epi);
 			ep_pm_stay_awake_rcu(epi);
+		}
 	} else if (!ep_is_linked(epi)) {
 		/* In the usual case, add event to ready list. */
-		if (list_add_tail_lockless(&epi->rdllink, &ep->rdllist))
-			ep_pm_stay_awake_rcu(epi);
+		list_add_tail(&epi->rdllink, &ep->rdllist);
+		ep_pm_stay_awake_rcu(epi);
 	}
=20
 	/*
@@ -1409,7 +1322,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait,=
 unsigned mode, int sync, v
 		pwake++;
=20
 out_unlock:
-	read_unlock_irqrestore(&ep->lock, flags);
+	spin_unlock_irqrestore(&ep->lock, flags);
=20
 	/* We have to call this outside the lock */
 	if (pwake)
@@ -1744,7 +1657,7 @@ static int ep_insert(struct eventpoll *ep, const stru=
ct epoll_event *event,
 	}
=20
 	/* We have to drop the new item inside our item list to keep track of it =
*/
-	write_lock_irq(&ep->lock);
+	spin_lock_irq(&ep->lock);
=20
 	/* record NAPI ID of new item if present */
 	ep_set_busy_poll_napi_id(epi);
@@ -1761,7 +1674,7 @@ static int ep_insert(struct eventpoll *ep, const stru=
ct epoll_event *event,
 			pwake++;
 	}
=20
-	write_unlock_irq(&ep->lock);
+	spin_unlock_irq(&ep->lock);
=20
 	/* We have to call this outside the lock */
 	if (pwake)
@@ -1825,7 +1738,7 @@ static int ep_modify(struct eventpoll *ep, struct epi=
tem *epi,
 	 * list, push it inside.
 	 */
 	if (ep_item_poll(epi, &pt, 1)) {
-		write_lock_irq(&ep->lock);
+		spin_lock_irq(&ep->lock);
 		if (!ep_is_linked(epi)) {
 			list_add_tail(&epi->rdllink, &ep->rdllist);
 			ep_pm_stay_awake(epi);
@@ -1836,7 +1749,7 @@ static int ep_modify(struct eventpoll *ep, struct epi=
tem *epi,
 			if (waitqueue_active(&ep->poll_wait))
 				pwake++;
 		}
-		write_unlock_irq(&ep->lock);
+		spin_unlock_irq(&ep->lock);
 	}
=20
 	/* We have to call this outside the lock */
@@ -2088,7 +2001,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll=
_event __user *events,
 		init_wait(&wait);
 		wait.func =3D ep_autoremove_wake_function;
=20
-		write_lock_irq(&ep->lock);
+		spin_lock_irq(&ep->lock);
 		/*
 		 * Barrierless variant, waitqueue_active() is called under
 		 * the same lock on wakeup ep_poll_callback() side, so it
@@ -2107,7 +2020,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll=
_event __user *events,
 		if (!eavail)
 			__add_wait_queue_exclusive(&ep->wq, &wait);
=20
-		write_unlock_irq(&ep->lock);
+		spin_unlock_irq(&ep->lock);
=20
 		if (!eavail)
 			timed_out =3D !ep_schedule_timeout(to) ||
@@ -2123,7 +2036,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll=
_event __user *events,
 		eavail =3D 1;
=20
 		if (!list_empty_careful(&wait.entry)) {
-			write_lock_irq(&ep->lock);
+			spin_lock_irq(&ep->lock);
 			/*
 			 * If the thread timed out and is not on the wait queue,
 			 * it means that the thread was woken up after its
@@ -2134,7 +2047,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll=
_event __user *events,
 			if (timed_out)
 				eavail =3D list_empty(&wait.entry);
 			__remove_wait_queue(&ep->wq, &wait);
-			write_unlock_irq(&ep->lock);
+			spin_unlock_irq(&ep->lock);
 		}
 	}
 }
--=20
2.39.5


