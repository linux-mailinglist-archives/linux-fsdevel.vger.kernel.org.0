Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3BAFF8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 17:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfIKPGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 11:06:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbfIKPGO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:06:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11103309C386;
        Wed, 11 Sep 2019 15:06:13 +0000 (UTC)
Received: from llong.com (ovpn-125-196.rdu2.redhat.com [10.10.125.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 866675D9E2;
        Wed, 11 Sep 2019 15:06:10 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/5] locking/rwsem: Enable timeout check when spinning on owner
Date:   Wed, 11 Sep 2019 16:05:34 +0100
Message-Id: <20190911150537.19527-3-longman@redhat.com>
In-Reply-To: <20190911150537.19527-1-longman@redhat.com>
References: <20190911150537.19527-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 11 Sep 2019 15:06:13 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a task is optimistically spinning on the owner, it may do it for a
long time if there is no other running task available in the run queue.
That can be long past the given timeout value.

To prevent that from happening, the rwsem_optimistic_spin() is now
modified to check for the timeout value, if specified, to see if it
should abort early.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 67 ++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c0285749c338..49f052d68404 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -716,11 +716,13 @@ rwsem_owner_state(struct task_struct *owner, unsigned long flags, unsigned long
 }
 
 static noinline enum owner_state
-rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
+rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable,
+		    ktime_t timeout)
 {
 	struct task_struct *new, *owner;
 	unsigned long flags, new_flags;
 	enum owner_state state;
+	int loopcnt = 0;
 
 	owner = rwsem_owner_flags(sem, &flags);
 	state = rwsem_owner_state(owner, flags, nonspinnable);
@@ -749,16 +751,22 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
 		 */
 		barrier();
 
-		if (need_resched() || !owner_on_cpu(owner)) {
-			state = OWNER_NONSPINNABLE;
-			break;
-		}
+		if (need_resched() || !owner_on_cpu(owner))
+			goto stop_optspin;
+
+		if (timeout && !(++loopcnt & 0xf) &&
+		   (sched_clock() >= ktime_to_ns(timeout)))
+			goto stop_optspin;
 
 		cpu_relax();
 	}
 	rcu_read_unlock();
 
 	return state;
+
+stop_optspin:
+	rcu_read_unlock();
+	return OWNER_NONSPINNABLE;
 }
 
 /*
@@ -786,12 +794,13 @@ static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
 	return sched_clock() + delta;
 }
 
-static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
+static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock,
+				  ktime_t timeout)
 {
 	bool taken = false;
 	int prev_owner_state = OWNER_NULL;
 	int loop = 0;
-	u64 rspin_threshold = 0;
+	u64 rspin_threshold = 0, curtime;
 	unsigned long nonspinnable = wlock ? RWSEM_WR_NONSPINNABLE
 					   : RWSEM_RD_NONSPINNABLE;
 
@@ -801,6 +810,8 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 	if (!osq_lock(&sem->osq))
 		goto done;
 
+	curtime = timeout ? sched_clock() : 0;
+
 	/*
 	 * Optimistically spin on the owner field and attempt to acquire the
 	 * lock whenever the owner changes. Spinning will be stopped when:
@@ -810,7 +821,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 	for (;;) {
 		enum owner_state owner_state;
 
-		owner_state = rwsem_spin_on_owner(sem, nonspinnable);
+		owner_state = rwsem_spin_on_owner(sem, nonspinnable, timeout);
 		if (!(owner_state & OWNER_SPINNABLE))
 			break;
 
@@ -823,6 +834,21 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 		if (taken)
 			break;
 
+		/*
+		 * Check current time once every 16 iterations when
+		 *  1) spinning on reader-owned rwsem; or
+		 *  2) a timeout value is specified.
+		 *
+		 * This is to avoid calling sched_clock() too frequently
+		 * so as to reduce the average latency between the times
+		 * when the lock becomes free and when the spinner is
+		 * ready to do a trylock.
+		 */
+		if ((wlock && (owner_state == OWNER_READER)) || timeout) {
+			if (!(++loop & 0xf))
+				curtime = sched_clock();
+		}
+
 		/*
 		 * Time-based reader-owned rwsem optimistic spinning
 		 */
@@ -838,23 +864,18 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 				if (rwsem_test_oflags(sem, nonspinnable))
 					break;
 				rspin_threshold = rwsem_rspin_threshold(sem);
-				loop = 0;
 			}
 
-			/*
-			 * Check time threshold once every 16 iterations to
-			 * avoid calling sched_clock() too frequently so
-			 * as to reduce the average latency between the times
-			 * when the lock becomes free and when the spinner
-			 * is ready to do a trylock.
-			 */
-			else if (!(++loop & 0xf) && (sched_clock() > rspin_threshold)) {
+			else if (curtime > rspin_threshold) {
 				rwsem_set_nonspinnable(sem);
 				lockevent_inc(rwsem_opt_nospin);
 				break;
 			}
 		}
 
+		if (timeout && (ns_to_ktime(curtime) >= timeout))
+			break;
+
 		/*
 		 * An RT task cannot do optimistic spinning if it cannot
 		 * be sure the lock holder is running or live-lock may
@@ -968,7 +989,8 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
 	return false;
 }
 
-static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
+static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock,
+					 ktime_t timeout)
 {
 	return false;
 }
@@ -982,7 +1004,8 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
 }
 
 static inline int
-rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
+rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable,
+		    ktime_t timeout)
 {
 	return 0;
 }
@@ -1036,7 +1059,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	 */
 	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
 	adjustment = 0;
-	if (rwsem_optimistic_spin(sem, false)) {
+	if (rwsem_optimistic_spin(sem, false, 0)) {
 		/* rwsem_optimistic_spin() implies ACQUIRE on success */
 		/*
 		 * Wake up other readers in the wait list if the front
@@ -1175,7 +1198,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state, ktime_t timeout)
 
 	/* do optimistic spinning and steal lock if possible */
 	if (rwsem_can_spin_on_owner(sem, RWSEM_WR_NONSPINNABLE) &&
-	    rwsem_optimistic_spin(sem, true)) {
+	    rwsem_optimistic_spin(sem, true, timeout)) {
 		/* rwsem_optimistic_spin() implies ACQUIRE on success */
 		return sem;
 	}
@@ -1255,7 +1278,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state, ktime_t timeout)
 		 * without sleeping.
 		 */
 		if ((wstate == WRITER_HANDOFF) &&
-		    (rwsem_spin_on_owner(sem, 0) == OWNER_NULL))
+		    (rwsem_spin_on_owner(sem, 0, 0) == OWNER_NULL))
 			goto trylock_again;
 
 		/* Block until there are no active lockers. */
-- 
2.18.1

