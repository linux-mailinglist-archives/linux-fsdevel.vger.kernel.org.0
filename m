Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2579AFF90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 17:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfIKPGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 11:06:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbfIKPGU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:06:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E586A37188;
        Wed, 11 Sep 2019 15:06:19 +0000 (UTC)
Received: from llong.com (ovpn-125-196.rdu2.redhat.com [10.10.125.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60BA75D9E2;
        Wed, 11 Sep 2019 15:06:13 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 3/5] locking/osq: Allow early break from OSQ
Date:   Wed, 11 Sep 2019 16:05:35 +0100
Message-Id: <20190911150537.19527-4-longman@redhat.com>
In-Reply-To: <20190911150537.19527-1-longman@redhat.com>
References: <20190911150537.19527-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 11 Sep 2019 15:06:19 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current osq_lock() function will spin until it gets the lock or
when its time slice has been used up. There may be other reasons that
a task may want to back out from the OSQ before getting the lock. This
patch extends the osq_lock() function by adding two new arguments - a
break function pointer and its argument.  That break function will be
called, if defined, in each iteration of the loop to see if it should
break out early.

The optimistic_spin_node structure in osq_lock.h isn't needed by callers,
so it is moved into osq_lock.c.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/osq_lock.h  | 13 ++-----------
 kernel/locking/mutex.c    |  2 +-
 kernel/locking/osq_lock.c | 12 +++++++++++-
 kernel/locking/rwsem.c    |  2 +-
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
index 5581dbd3bd34..161eb6b26d6d 100644
--- a/include/linux/osq_lock.h
+++ b/include/linux/osq_lock.h
@@ -2,16 +2,6 @@
 #ifndef __LINUX_OSQ_LOCK_H
 #define __LINUX_OSQ_LOCK_H
 
-/*
- * An MCS like lock especially tailored for optimistic spinning for sleeping
- * lock implementations (mutex, rwsem, etc).
- */
-struct optimistic_spin_node {
-	struct optimistic_spin_node *next, *prev;
-	int locked; /* 1 if lock acquired */
-	int cpu; /* encoded CPU # + 1 value */
-};
-
 struct optimistic_spin_queue {
 	/*
 	 * Stores an encoded value of the CPU # of the tail node in the queue.
@@ -30,7 +20,8 @@ static inline void osq_lock_init(struct optimistic_spin_queue *lock)
 	atomic_set(&lock->tail, OSQ_UNLOCKED_VAL);
 }
 
-extern bool osq_lock(struct optimistic_spin_queue *lock);
+extern bool osq_lock(struct optimistic_spin_queue *lock,
+		     bool (*break_fn)(void *), void *break_arg);
 extern void osq_unlock(struct optimistic_spin_queue *lock);
 
 static inline bool osq_is_locked(struct optimistic_spin_queue *lock)
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 468a9b8422e3..8a1df82fd71a 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -654,7 +654,7 @@ mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
 		 * acquire the mutex all at once, the spinners need to take a
 		 * MCS (queued) lock first before spinning on the owner field.
 		 */
-		if (!osq_lock(&lock->osq))
+		if (!osq_lock(&lock->osq, NULL, NULL))
 			goto fail;
 	}
 
diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 6ef600aa0f47..40c94380a485 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -11,6 +11,12 @@
  * called from interrupt context and we have preemption disabled while
  * spinning.
  */
+struct optimistic_spin_node {
+	struct optimistic_spin_node *next, *prev;
+	int locked; /* 1 if lock acquired */
+	int cpu; /* encoded CPU # + 1 value */
+};
+
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
 
 /*
@@ -87,7 +93,8 @@ osq_wait_next(struct optimistic_spin_queue *lock,
 	return next;
 }
 
-bool osq_lock(struct optimistic_spin_queue *lock)
+bool osq_lock(struct optimistic_spin_queue *lock,
+	      bool (*break_fn)(void *), void *break_arg)
 {
 	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
 	struct optimistic_spin_node *prev, *next;
@@ -143,6 +150,9 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
 			goto unqueue;
 
+		if (unlikely(break_fn) && break_fn(break_arg))
+			goto unqueue;
+
 		cpu_relax();
 	}
 	return true;
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 49f052d68404..c15926ecb21e 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -807,7 +807,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock,
 	preempt_disable();
 
 	/* sem->wait_lock should not be held when doing optimistic spinning */
-	if (!osq_lock(&sem->osq))
+	if (!osq_lock(&sem->osq, NULL, NULL))
 		goto done;
 
 	curtime = timeout ? sched_clock() : 0;
-- 
2.18.1

