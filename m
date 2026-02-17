Return-Path: <linux-fsdevel+bounces-77391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDGfGNS8lGm4HQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 20:09:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C00E014F828
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 20:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4F323024C9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3637474D;
	Tue, 17 Feb 2026 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IgxlNwCg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E637473C;
	Tue, 17 Feb 2026 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355325; cv=none; b=JSv1DOVTrc/u5TLttTcAyFL0k0PK9FnmNVQq9zMU/q7z10x7tM7dqr+cj6dNKfmw5vU9pakfx8+2hC2UB8jPw9ShT17l/L6VR/GnAIY6y01KOyKBejuJ5fCHz22HZQVgs4WWR8AFD5911cbuIigYHKXvRqngRraw0PY9pCInyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355325; c=relaxed/simple;
	bh=2HaoEaqCL8zwpfCAm3reUWDQWV+0SqrP0agM2OtfwoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxN00LOIyzvsEz2iVY0qMHGDYo3BYjjmh2MtQkTBPhQ1ZECEDrk4xSuTuSBuD1bSHLdILH0hgx+jbHsklVoW/b4iUjbFZuh/lqfBX82228DigaDNfc2AT8yEEnBNWsgtDm7ap3IyTTBj9h28NV5HMd6XysQSnykD7wKhzi+7PC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IgxlNwCg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=g1BJmclM0DpVp6g5t24qtwHIcCxS+r+MNjOHxAFuLkg=; b=IgxlNwCgbskU1Uo51Lga1Vi197
	NogL3Bz0baZ+81xxlQco+P/S7Nv4mEhYvZAsrVGEOjJh4kbHi3AUUx4NwVRAgGboXcj6VWf+QxSOG
	UVGRJjdmZ7kDn4run5TJ5nna8Rky4Q62D8pFovrkuc0btqSmZijN9eo7QhTqEm/iduhIg0e1tubDz
	vpCL5Wy/CfZuqyv6/5oG71ZiQa0ZJQpChYQAG0NkwAxIkx4SlUhFVDlIKyEluxM2NkeWLqAzMrCBs
	7zchPz9lGAs1FRTfjjRq5C/mWuF9hzHNcIm6hq6Xj9XQUGwrEsprGcsFMDG3kh56maFmRxMczS/wv
	31vuM/Zg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsQR3-00000004pgK-2VT8;
	Tue, 17 Feb 2026 19:08:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: 
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC 1/1] rwsem: Shrink rwsem by one pointer
Date: Tue, 17 Feb 2026 19:08:34 +0000
Message-ID: <20260217190835.1151964-2-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217190835.1151964-1-willy@infradead.org>
References: <20260217190835.1151964-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,kernel.org,gmail.com,vger.kernel.org,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77391-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim,infradead.org:email]
X-Rspamd-Queue-Id: C00E014F828
X-Rspamd-Action: no action

Instead of embedding a list_head in struct rw_semaphore, store a pointer
to the first waiter.  The list of waiters remains a doubly linked list
so we can efficiently add to the tail of the list, remove from the front
(or middle) of the list.

Some of the list manipulation becomes more complicated, but it's a
reasonable tradeoff on the slow paths to shrink some core data structures
like struct inode.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/rwsem.h  |  8 ++---
 kernel/locking/rwsem.c | 74 +++++++++++++++++++++++++++++++-----------
 2 files changed, 59 insertions(+), 23 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index f1aaf676a874..1771c96a01d2 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -57,7 +57,7 @@ struct rw_semaphore {
 	struct optimistic_spin_queue osq; /* spinner MCS lock */
 #endif
 	raw_spinlock_t wait_lock;
-	struct list_head wait_list;
+	struct rwsem_waiter *first_waiter;
 #ifdef CONFIG_DEBUG_RWSEMS
 	void *magic;
 #endif
@@ -104,7 +104,7 @@ static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *
 	  .owner = ATOMIC_LONG_INIT(0),				\
 	  __RWSEM_OPT_INIT(name)				\
 	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock),\
-	  .wait_list = LIST_HEAD_INIT((name).wait_list),	\
+	  .first_waiter = NULL,					\
 	  __RWSEM_DEBUG_INIT(name)				\
 	  __RWSEM_DEP_MAP_INIT(name) }
 
@@ -127,9 +127,9 @@ do {								\
  * rwsem to see if somebody from an incompatible type is wanting access to the
  * lock.
  */
-static inline int rwsem_is_contended(struct rw_semaphore *sem)
+static inline bool rwsem_is_contended(struct rw_semaphore *sem)
 {
-	return !list_empty(&sem->wait_list);
+	return sem->first_waiter != NULL;
 }
 
 #if defined(CONFIG_DEBUG_RWSEMS) || defined(CONFIG_DETECT_HUNG_TASK_BLOCKER)
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 24df4d98f7d2..4226eb0ec5da 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -72,7 +72,7 @@
 		#c, atomic_long_read(&(sem)->count),		\
 		(unsigned long) sem->magic,			\
 		atomic_long_read(&(sem)->owner), (long)current,	\
-		list_empty(&(sem)->wait_list) ? "" : "not "))	\
+		(sem)->first_waiter ? "" : "not "))		\
 			debug_locks_off();			\
 	} while (0)
 #else
@@ -321,7 +321,7 @@ void __init_rwsem(struct rw_semaphore *sem, const char *name,
 #endif
 	atomic_long_set(&sem->count, RWSEM_UNLOCKED_VALUE);
 	raw_spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
+	sem->first_waiter = NULL;
 	atomic_long_set(&sem->owner, 0L);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	osq_lock_init(&sem->osq);
@@ -341,8 +341,7 @@ struct rwsem_waiter {
 	unsigned long timeout;
 	bool handoff_set;
 };
-#define rwsem_first_waiter(sem) \
-	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
+#define rwsem_first_waiter(sem)	sem->first_waiter
 
 enum rwsem_wake_type {
 	RWSEM_WAKE_ANY,		/* Wake whatever's at head of wait list */
@@ -368,11 +367,36 @@ enum rwsem_wake_type {
 static inline void
 rwsem_add_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
 {
+	struct rwsem_waiter *first = sem->first_waiter;
 	lockdep_assert_held(&sem->wait_lock);
-	list_add_tail(&waiter->list, &sem->wait_list);
+	if (first) {
+		list_add_tail(&waiter->list, &first->list);
+	} else {
+		INIT_LIST_HEAD(&waiter->list);
+		sem->first_waiter = waiter;
+	}
 	/* caller will set RWSEM_FLAG_WAITERS */
 }
 
+static inline
+bool __rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
+{
+	if (sem->first_waiter == waiter) {
+		if (list_empty(&waiter->list)) {
+			sem->first_waiter = NULL;
+			return true;
+		} else {
+			sem->first_waiter = list_first_entry(&waiter->list,
+					struct rwsem_waiter, list);
+			list_del(&waiter->list);
+		}
+	} else {
+		list_del(&waiter->list);
+	}
+
+	return false;
+}
+
 /*
  * Remove a waiter from the wait_list and clear flags.
  *
@@ -385,14 +409,22 @@ static inline bool
 rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
 {
 	lockdep_assert_held(&sem->wait_lock);
-	list_del(&waiter->list);
-	if (likely(!list_empty(&sem->wait_list)))
+	if (__rwsem_del_waiter(sem, waiter))
 		return true;
-
 	atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS, &sem->count);
 	return false;
 }
 
+static inline struct rwsem_waiter *next_waiter(const struct rw_semaphore *sem,
+		const struct rwsem_waiter *waiter)
+{
+	struct rwsem_waiter *next = list_first_entry(&waiter->list,
+			struct rwsem_waiter, list);
+	if (next == sem->first_waiter)
+		return NULL;
+	return next;
+}
+
 /*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
@@ -411,7 +443,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 			    enum rwsem_wake_type wake_type,
 			    struct wake_q_head *wake_q)
 {
-	struct rwsem_waiter *waiter, *tmp;
+	struct rwsem_waiter *waiter, *next;
 	long oldcount, woken = 0, adjustment = 0;
 	struct list_head wlist;
 
@@ -506,25 +538,28 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 	 *    put them into wake_q to be woken up later.
 	 */
 	INIT_LIST_HEAD(&wlist);
-	list_for_each_entry_safe(waiter, tmp, &sem->wait_list, list) {
+	do {
+		next = next_waiter(sem, waiter);
 		if (waiter->type == RWSEM_WAITING_FOR_WRITE)
 			continue;
 
 		woken++;
 		list_move_tail(&waiter->list, &wlist);
+		if (sem->first_waiter == waiter)
+			sem->first_waiter = next;
 
 		/*
 		 * Limit # of readers that can be woken up per wakeup call.
 		 */
 		if (unlikely(woken >= MAX_READERS_WAKEUP))
 			break;
-	}
+	} while ((waiter = next) != NULL);
 
 	adjustment = woken * RWSEM_READER_BIAS - adjustment;
 	lockevent_cond_inc(rwsem_wake_reader, woken);
 
 	oldcount = atomic_long_read(&sem->count);
-	if (list_empty(&sem->wait_list)) {
+	if (!sem->first_waiter) {
 		/*
 		 * Combined with list_move_tail() above, this implies
 		 * rwsem_del_waiter().
@@ -545,7 +580,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		atomic_long_add(adjustment, &sem->count);
 
 	/* 2nd pass */
-	list_for_each_entry_safe(waiter, tmp, &wlist, list) {
+	list_for_each_entry_safe(waiter, next, &wlist, list) {
 		struct task_struct *tsk;
 
 		tsk = waiter->task;
@@ -639,7 +674,7 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 			new |= RWSEM_WRITER_LOCKED;
 			new &= ~RWSEM_FLAG_HANDOFF;
 
-			if (list_is_singular(&sem->wait_list))
+			if (list_empty(&first->list))
 				new &= ~RWSEM_FLAG_WAITERS;
 		}
 	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
@@ -659,7 +694,8 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 	 * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
 	 * success.
 	 */
-	list_del(&waiter->list);
+	__rwsem_del_waiter(sem, waiter);
+
 	rwsem_set_owner(sem);
 	return true;
 }
@@ -1019,7 +1055,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 		 */
 		if ((rcnt == 1) && (count & RWSEM_FLAG_WAITERS)) {
 			raw_spin_lock_irq(&sem->wait_lock);
-			if (!list_empty(&sem->wait_list))
+			if (sem->first_waiter)
 				rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
 						&wake_q);
 			raw_spin_unlock_irq(&sem->wait_lock);
@@ -1035,7 +1071,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	waiter.handoff_set = false;
 
 	raw_spin_lock_irq(&sem->wait_lock);
-	if (list_empty(&sem->wait_list)) {
+	if (!sem->first_waiter) {
 		/*
 		 * In case the wait queue is empty and the lock isn't owned
 		 * by a writer, this reader can exit the slowpath and return
@@ -1218,7 +1254,7 @@ static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 
 	raw_spin_lock_irqsave(&sem->wait_lock, flags);
 
-	if (!list_empty(&sem->wait_list))
+	if (sem->first_waiter)
 		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 
 	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
@@ -1239,7 +1275,7 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 
 	raw_spin_lock_irqsave(&sem->wait_lock, flags);
 
-	if (!list_empty(&sem->wait_list))
+	if (sem->first_waiter)
 		rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED, &wake_q);
 
 	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
-- 
2.47.3


