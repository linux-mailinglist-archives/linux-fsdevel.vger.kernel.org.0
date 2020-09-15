Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9528326A78E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 16:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgIOOwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 10:52:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727209AbgIOOvz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:51:55 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7D46D5D0ED035B7F8EAF;
        Tue, 15 Sep 2020 22:01:02 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 22:00:55 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>
CC:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        "Christoph Lameter" <cl@linux.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <houtao1@huawei.com>
Subject: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for read_count
Date:   Tue, 15 Sep 2020 22:07:50 +0800
Message-ID: <20200915140750.137881-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.25.0.4.g0ad7144999
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Under aarch64, __this_cpu_inc() is neither IRQ-safe nor atomic, so
when percpu_up_read() is invoked under IRQ-context (e.g. aio completion),
and it interrupts the process on the same CPU which is invoking
percpu_down_read(), the decreasement on read_count may lost and
the final value of read_count on the CPU will be unexpected
as shown below:

  CPU 0          CPU 0

  io_submit_one
  __sb_start_write
  percpu_down_read
  __this_cpu_inc
  // there is already an inflight IO, so
  // reading *raw_cpu_ptr(&pcp) returns 1
  // half complete, then being interrupted
  *raw_cpu_ptr(&pcp)) += 1

  		nvme_irq
  		nvme_complete_cqes
  		blk_mq_complete_request
  		nvme_pci_complete_rq
  		nvme_complete_rq
  		blk_mq_end_request
  		blk_update_request
  		bio_endio
  		dio_bio_end_aio
  		aio_complete_rw
  		__sb_end_write
  		percpu_up_read
  		*raw_cpu_ptr(&pcp)) -= 1
  		// *raw_cpu_ptr(&pcp) is 0

  // the decreasement is overwritten by the increasement
  *raw_cpu_ptr(&pcp)) += 1
  // the final value is 1 + 1 = 2 instead of 1

Fixing it by using the IRQ-safe helper this_cpu_inc|dec() for
operations on read_count.

Another plausible fix is to state that percpu-rwsem can NOT be
used under IRQ context and convert all users which may
use it under IRQ context.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/percpu-rwsem.h  | 8 ++++----
 kernel/locking/percpu-rwsem.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 5e033fe1ff4e9..5fda40f97fe91 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -60,7 +60,7 @@ static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 	 * anything we did within this RCU-sched read-size critical section.
 	 */
 	if (likely(rcu_sync_is_idle(&sem->rss)))
-		__this_cpu_inc(*sem->read_count);
+		this_cpu_inc(*sem->read_count);
 	else
 		__percpu_down_read(sem, false); /* Unconditional memory barrier */
 	/*
@@ -79,7 +79,7 @@ static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 	 * Same as in percpu_down_read().
 	 */
 	if (likely(rcu_sync_is_idle(&sem->rss)))
-		__this_cpu_inc(*sem->read_count);
+		this_cpu_inc(*sem->read_count);
 	else
 		ret = __percpu_down_read(sem, true); /* Unconditional memory barrier */
 	preempt_enable();
@@ -103,7 +103,7 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 	 * Same as in percpu_down_read().
 	 */
 	if (likely(rcu_sync_is_idle(&sem->rss))) {
-		__this_cpu_dec(*sem->read_count);
+		this_cpu_dec(*sem->read_count);
 	} else {
 		/*
 		 * slowpath; reader will only ever wake a single blocked
@@ -115,7 +115,7 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 		 * aggregate zero, as that is the only time it matters) they
 		 * will also see our critical section.
 		 */
-		__this_cpu_dec(*sem->read_count);
+		this_cpu_dec(*sem->read_count);
 		rcuwait_wake_up(&sem->writer);
 	}
 	preempt_enable();
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 8bbafe3e5203d..70a32a576f3f2 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -45,7 +45,7 @@ EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
 static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
-	__this_cpu_inc(*sem->read_count);
+	this_cpu_inc(*sem->read_count);
 
 	/*
 	 * Due to having preemption disabled the decrement happens on
@@ -71,7 +71,7 @@ static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 	if (likely(!atomic_read_acquire(&sem->block)))
 		return true;
 
-	__this_cpu_dec(*sem->read_count);
+	this_cpu_dec(*sem->read_count);
 
 	/* Prod writer to re-evaluate readers_active_check() */
 	rcuwait_wake_up(&sem->writer);
-- 
2.25.0.4.g0ad7144999

