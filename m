Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C780326F9C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 12:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgIRKBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 06:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRKBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:01:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27124C06174A;
        Fri, 18 Sep 2020 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I4Xx6byiSZ4S83gfBBb46u6JrAB+9m/QO0fluRypkrg=; b=E2hvbY7KPDylK8lPKl6bhX26Oy
        RUaMJEWQ2QfLY+WKO3uvYXfunzmmHqi0PALHv5K9+JRd8Bi7Mtbobm72LVlMVg6Qku44OAUI6Pou6
        yOoToP7p3SqZ6on2RM8raqyMnDEXYcell/GSGecr/U06RrlV/wV4DBen+7NQSmMaMY+0Npzmu5vC4
        /VGHVY6dJXLgpeIhQSRf51F6Fkdt7W7l3VVOXmWUB+gE4neCHlyTkekd69TK5VxBu3SkK8dXtmtYd
        i6GVl5zjHidCgKVRSBdONxi01s/u7AP63W6+xEufaQ+plI8DE9pqnr4+NgRFD2PpLm2hi7qPLUqjc
        xYuiN0oA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJDCd-0006Gs-Bc; Fri, 18 Sep 2020 10:01:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94291304B92;
        Fri, 18 Sep 2020 12:01:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 344892041904D; Fri, 18 Sep 2020 12:01:12 +0200 (CEST)
Date:   Fri, 18 Sep 2020 12:01:12 +0200
From:   peterz@infradead.org
To:     Jan Kara <jack@suse.cz>
Cc:     Oleg Nesterov <oleg@redhat.com>, Boaz Harrosh <boaz@plexistor.com>,
        Hou Tao <houtao1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200918100112.GN1362448@hirez.programming.kicks-ass.net>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
 <20200917120132.GA5602@redhat.com>
 <20200918090702.GB18920@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918090702.GB18920@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 11:07:02AM +0200, Jan Kara wrote:
> If people really wanted to avoid irq-safe inc/dec for archs where it is
> more expensive, one idea I had was that we could add 'read_count_in_irq' to
> percpu_rw_semaphore. So callers in normal context would use read_count and
> callers in irq context would use read_count_in_irq. And the writer side
> would sum over both but we don't care about performance of that one much.

That's not a bad idea... something like so I suppose.

(completely untested)

---
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 5fda40f97fe9..9c847490a86a 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -11,7 +11,7 @@
 
 struct percpu_rw_semaphore {
 	struct rcu_sync		rss;
-	unsigned int __percpu	*read_count;
+	u32 __percpu		*read_count;
 	struct rcuwait		writer;
 	wait_queue_head_t	waiters;
 	atomic_t		block;
@@ -60,7 +60,7 @@ static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 	 * anything we did within this RCU-sched read-size critical section.
 	 */
 	if (likely(rcu_sync_is_idle(&sem->rss)))
-		this_cpu_inc(*sem->read_count);
+		__this_cpu_inc(sem->read_count[0]);
 	else
 		__percpu_down_read(sem, false); /* Unconditional memory barrier */
 	/*
@@ -74,12 +74,16 @@ static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
 	bool ret = true;
 
+#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
+	WARN_ON_ONCE(!in_task());
+#endif
+
 	preempt_disable();
 	/*
 	 * Same as in percpu_down_read().
 	 */
 	if (likely(rcu_sync_is_idle(&sem->rss)))
-		this_cpu_inc(*sem->read_count);
+		__this_cpu_inc(sem->read_count[0]);
 	else
 		ret = __percpu_down_read(sem, true); /* Unconditional memory barrier */
 	preempt_enable();
@@ -98,12 +102,16 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, _RET_IP_);
 
+#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
+	WARN_ON_ONCE(!in_task());
+#endif
+
 	preempt_disable();
 	/*
 	 * Same as in percpu_down_read().
 	 */
 	if (likely(rcu_sync_is_idle(&sem->rss))) {
-		this_cpu_dec(*sem->read_count);
+		__this_cpu_dec(sem->read_count[0]);
 	} else {
 		/*
 		 * slowpath; reader will only ever wake a single blocked
@@ -115,12 +123,39 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 		 * aggregate zero, as that is the only time it matters) they
 		 * will also see our critical section.
 		 */
-		this_cpu_dec(*sem->read_count);
+		__this_cpu_dec(sem->read_count[0]);
 		rcuwait_wake_up(&sem->writer);
 	}
 	preempt_enable();
 }
 
+static inline void __percpu_up_read_irqsafe(struct percpu_rw_semaphore *sem)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	/*
+	 * Same as in percpu_down_read().
+	 */
+	if (likely(rcu_sync_is_idle(&sem->rss))) {
+		__this_cpu_dec(sem->read_count[1]);
+	} else {
+		/*
+		 * slowpath; reader will only ever wake a single blocked
+		 * writer.
+		 */
+		smp_mb(); /* B matches C */
+		/*
+		 * In other words, if they see our decrement (presumably to
+		 * aggregate zero, as that is the only time it matters) they
+		 * will also see our critical section.
+		 */
+		__this_cpu_dec(sem->read_count[1]);
+		rcuwait_wake_up(&sem->writer);
+	}
+	local_irq_restore(flags);
+}
+
 extern void percpu_down_write(struct percpu_rw_semaphore *);
 extern void percpu_up_write(struct percpu_rw_semaphore *);
 
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 70a32a576f3f..00741216a7f6 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -12,7 +12,7 @@
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 			const char *name, struct lock_class_key *key)
 {
-	sem->read_count = alloc_percpu(int);
+	sem->read_count = (u32 *)alloc_percpu(u64);
 	if (unlikely(!sem->read_count))
 		return -ENOMEM;
 
@@ -45,7 +45,7 @@ EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
 static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
-	this_cpu_inc(*sem->read_count);
+	__this_cpu_inc(sem->read_count[0]);
 
 	/*
 	 * Due to having preemption disabled the decrement happens on
@@ -71,7 +71,7 @@ static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 	if (likely(!atomic_read_acquire(&sem->block)))
 		return true;
 
-	this_cpu_dec(*sem->read_count);
+	__this_cpu_dec(sem->read_count[0]);
 
 	/* Prod writer to re-evaluate readers_active_check() */
 	rcuwait_wake_up(&sem->writer);
@@ -198,7 +198,9 @@ EXPORT_SYMBOL_GPL(__percpu_down_read);
  */
 static bool readers_active_check(struct percpu_rw_semaphore *sem)
 {
-	if (per_cpu_sum(*sem->read_count) != 0)
+	u64 sum = per_cpu_sum(*(u64 *)sem->read_count);
+
+	if (sum + (sum >> 32))
 		return false;
 
 	/*
