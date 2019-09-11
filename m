Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C55AFF8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 17:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfIKPGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 11:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbfIKPGL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:06:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D53885360;
        Wed, 11 Sep 2019 15:06:10 +0000 (UTC)
Received: from llong.com (ovpn-125-196.rdu2.redhat.com [10.10.125.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7408B5D9E2;
        Wed, 11 Sep 2019 15:06:07 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/5] locking/rwsem: Add down_write_timedlock()
Date:   Wed, 11 Sep 2019 16:05:33 +0100
Message-Id: <20190911150537.19527-2-longman@redhat.com>
In-Reply-To: <20190911150537.19527-1-longman@redhat.com>
References: <20190911150537.19527-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 11 Sep 2019 15:06:10 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are cases where a task wants to acquire a rwsem but doesn't want
to wait for an indefinite period of time. Instead, a task may want
an alternative way of dealing with the inability to acquire the lock
after a certain period of time. There are also cases where waiting
indefinitely can potentially lead to deadlock. Doing it by using a
trylock loop is inelegant as it increases cacheline contention and is
difficult to control the actual wait time.

To address this dilemma, a new down_write_timedlock() variant
is introduced which allows an additional ktime_t timeout argument
(currently in ns) relative to now. With this new API, a task can now
wait for a given period of time and bail out when the lock cannot be
acquired within the given period.

In reality, the actual wait time is likely to be longer than the
given time. Timeout checking isn't done when doing optimistic spinning.
Therefore a short timeout smaller than the scheduling period may be
less accurate.

From the lockdep perspective, down_write_timedlock() is treated similar
to down_write_trylock().

A similar down_read_timedlock() may be added later on when the need
arises.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/rwsem.h             |  4 +-
 kernel/locking/lock_events_list.h |  1 +
 kernel/locking/rwsem.c            | 85 +++++++++++++++++++++++++++++--
 3 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 00d6054687dd..b3c7c5afde46 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
+#include <linux/ktime.h>
 #include <linux/err.h>
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 #include <linux/osq_lock.h>
@@ -139,9 +140,10 @@ extern void down_write(struct rw_semaphore *sem);
 extern int __must_check down_write_killable(struct rw_semaphore *sem);
 
 /*
- * trylock for writing -- returns 1 if successful, 0 if contention
+ * trylock or timedlock for writing -- returns 1 if successful, 0 if failed
  */
 extern int down_write_trylock(struct rw_semaphore *sem);
+extern int down_write_timedlock(struct rw_semaphore *sem, ktime_t timeout);
 
 /*
  * release a read lock
diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 239039d0ce21..c2345e0472b0 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -69,3 +69,4 @@ LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
 LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
 LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
 LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
+LOCK_EVENT(rwsem_wlock_timeout)	/* # of write lock timeouts		*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index eef04551eae7..c0285749c338 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
+#include <linux/hrtimer.h>
 
 #include "rwsem.h"
 #include "lock_events.h"
@@ -988,6 +989,26 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
 #define OWNER_NULL	1
 #endif
 
+/*
+ * Set up the hrtimer to fire at a future time relative to now.
+ * Return: The hrtimer_sleeper pointer if success, or NULL if it
+ *	   has timed out.
+ */
+static inline struct hrtimer_sleeper *
+rwsem_setup_hrtimer(struct hrtimer_sleeper *to, ktime_t timeout)
+{
+	ktime_t curtime = ns_to_ktime(sched_clock());
+
+	if (ktime_compare(curtime, timeout) >= 0)
+		return NULL;
+
+	hrtimer_init_sleeper_on_stack(to, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_set_expires_range_ns(&to->timer, timeout - curtime,
+				     current->timer_slack_ns);
+	hrtimer_start_expires(&to->timer, HRTIMER_MODE_REL);
+	return to;
+}
+
 /*
  * Wait for the read lock to be granted
  */
@@ -1136,7 +1157,7 @@ static inline void rwsem_disable_reader_optspin(struct rw_semaphore *sem,
  * Wait until we successfully acquire the write lock
  */
 static struct rw_semaphore *
-rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
+rwsem_down_write_slowpath(struct rw_semaphore *sem, int state, ktime_t timeout)
 {
 	long count;
 	bool disable_rspin;
@@ -1144,6 +1165,13 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
+	struct hrtimer_sleeper timer_sleeper, *to = NULL;
+
+	/*
+	 * The timeuot value is now the end time when the timer will expire.
+	 */
+	if (timeout)
+		timeout = ktime_add_ns(timeout, sched_clock());
 
 	/* do optimistic spinning and steal lock if possible */
 	if (rwsem_can_spin_on_owner(sem, RWSEM_WR_NONSPINNABLE) &&
@@ -1235,6 +1263,15 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 			if (signal_pending_state(state, current))
 				goto out_nolock;
 
+			if (timeout) {
+				if (!to)
+					to = rwsem_setup_hrtimer(&timer_sleeper,
+								 timeout);
+				if (!to || !to->task) {
+					lockevent_inc(rwsem_wlock_timeout);
+					goto out_nolock;
+				}
+			}
 			schedule();
 			lockevent_inc(rwsem_sleep_writer);
 			set_current_state(state);
@@ -1273,6 +1310,11 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	raw_spin_unlock_irq(&sem->wait_lock);
 	lockevent_inc(rwsem_wlock);
 
+out:
+	if (to) {
+		hrtimer_cancel(&to->timer);
+		destroy_hrtimer_on_stack(&to->timer);
+	}
 	return ret;
 
 out_nolock:
@@ -1291,7 +1333,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	wake_up_q(&wake_q);
 	lockevent_inc(rwsem_wlock_fail);
 
-	return ERR_PTR(-EINTR);
+	ret = ERR_PTR(timeout ? -ETIMEDOUT : -EINTR);
+	goto out;
 }
 
 /*
@@ -1389,7 +1432,7 @@ static inline void __down_write(struct rw_semaphore *sem)
 
 	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
 						      RWSEM_WRITER_LOCKED)))
-		rwsem_down_write_slowpath(sem, TASK_UNINTERRUPTIBLE);
+		rwsem_down_write_slowpath(sem, TASK_UNINTERRUPTIBLE, 0);
 	else
 		rwsem_set_owner(sem);
 }
@@ -1400,7 +1443,7 @@ static inline int __down_write_killable(struct rw_semaphore *sem)
 
 	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
 						      RWSEM_WRITER_LOCKED))) {
-		if (IS_ERR(rwsem_down_write_slowpath(sem, TASK_KILLABLE)))
+		if (IS_ERR(rwsem_down_write_slowpath(sem, TASK_KILLABLE, 0)))
 			return -EINTR;
 	} else {
 		rwsem_set_owner(sem);
@@ -1408,6 +1451,25 @@ static inline int __down_write_killable(struct rw_semaphore *sem)
 	return 0;
 }
 
+static inline int __down_write_timedlock(struct rw_semaphore *sem,
+					 ktime_t timeout)
+{
+	long tmp = RWSEM_UNLOCKED_VALUE;
+
+	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
+						      RWSEM_WRITER_LOCKED))) {
+		if (unlikely(timeout <= 0))
+			return false;
+
+		if (IS_ERR(rwsem_down_write_slowpath(sem, TASK_UNINTERRUPTIBLE,
+						     timeout)))
+			return false;
+	} else {
+		rwsem_set_owner(sem);
+	}
+	return true;
+}
+
 static inline int __down_write_trylock(struct rw_semaphore *sem)
 {
 	long tmp;
@@ -1568,6 +1630,21 @@ int down_write_trylock(struct rw_semaphore *sem)
 }
 EXPORT_SYMBOL(down_write_trylock);
 
+/*
+ * lock for writing with timeout (relative to now in ns)
+ */
+int down_write_timedlock(struct rw_semaphore *sem, ktime_t timeout)
+{
+	might_sleep();
+	if (__down_write_timedlock(sem, timeout)) {
+		rwsem_acquire(&sem->dep_map, 0, 1, _RET_IP_);
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(down_write_timedlock);
+
 /*
  * release a read lock
  */
-- 
2.18.1

