Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12CE21D4BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 13:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgGMLVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgGMLVy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:21:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449DFC061755;
        Mon, 13 Jul 2020 04:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Er5eSed6oodIKtDRn/8NH0pK3nR3KiCNpE66Fg/24oY=; b=liwS1peY5qvlYgqfY2c+q6YkD9
        8dKtChcfECxFZZrZENPRmVjHPeT3kK7GksqM71mF1rIRCTnYIKgy7zis2tOiocnual8cpUOpP2J/x
        /VGG4VWhZhnnRWkBj3Wp3nzpndIvFPq9IBlXNhtz42NJ5fHp5YVKBgEbUW2WHDhNa0sk6W54MP+Lr
        TOrp9VU08inzEPUuMHrAtCw8Hye1cX2smoPW3SRB7JwOIT/+fVYgmKhRU4scz0tc4L1Y3C2DryBbE
        qik2b5LgslEv1/IB5jRYXrrFAZAV7o9uBlDu30BDVMCAoyLkTJ/b1wz7aCBPyj0DiWjKREna+DswM
        1wiqnluA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juwWV-00034E-HW; Mon, 13 Jul 2020 11:21:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EDCB53007CD;
        Mon, 13 Jul 2020 13:21:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B702220D28B50; Mon, 13 Jul 2020 13:21:25 +0200 (CEST)
Date:   Mon, 13 Jul 2020 13:21:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Doug Anderson <dianders@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200713112125.GG10769@hirez.programming.kicks-ass.net>
References: <20200706142839.26629-1-qais.yousef@arm.com>
 <20200706142839.26629-2-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706142839.26629-2-qais.yousef@arm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 06, 2020 at 03:28:38PM +0100, Qais Yousef wrote:

> +static void __uclamp_sync_util_min_rt_default(struct task_struct *p)
> +{
> +	unsigned int default_util_min;
> +	struct uclamp_se *uc_se;
> +
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +
> +	if (!rt_task(p))
> +		return;
> +
> +	uc_se = &p->uclamp_req[UCLAMP_MIN];
> +
> +	/* Only sync if user didn't override the default */
> +	if (uc_se->user_defined)
> +		return;
> +
> +	/* Sync with smp_wmb() in uclamp_sync_util_min_rt_default() */
> +	smp_rmb();
> +	default_util_min = sysctl_sched_uclamp_util_min_rt_default;
> +	uclamp_se_set(uc_se, default_util_min, false);
> +}
> +
> +static void uclamp_sync_util_min_rt_default(void)
> +{
> +	struct task_struct *g, *p;
> +
> +	/*
> +	 * Make sure the updated sysctl_sched_uclamp_util_min_rt_default which
> +	 * was just written is synchronized against any future read on another
> +	 * cpu.
> +	 */
> +	smp_wmb();
> +
> +	/*
> +	 * Wait for all updaters to observe the new change.
> +	 *
> +	 * There are 2 races to deal with here:
> +	 *
> +	 * 1. fork()->copy_process()
> +	 *
> +	 *	If a task was concurrently forking, for_each_process_thread()
> +	 *	will not see it, hence it could have copied the old value and
> +	 *	we missed the opportunity to update it.
> +	 *
> +	 *	This should be handled by sched_post_fork() where it'll ensure
> +	 *	it performs the sync after the fork.
> +	 *
> +	 * 2. fork()->sched_post_fork()
> +	 *    __setscheduler_uclamp()
> +	 *
> +	 *	Both of these functions could read the old value but then get
> +	 *	preempted, during which a user might write new value to
> +	 *	sysctl_sched_uclamp_util_min_rt_default.
> +	 *
> +	 *	// read sysctl_sched_uclamp_util_min_rt_default;
> +	 *	// PREEMPT-OUT
> +	 *	.
> +	 *	.                  <-- sync happens here
> +	 *	.
> +	 *	// PREEMPT-IN
> +	 *	// write p->uclamp_req[UCLAMP_MIN]
> +	 *
> +	 *	That section is protected with rcu_read_lock(), so
> +	 *	synchronize_rcu() will guarantee it has finished before we
> +	 *	perform the update. Hence ensure that this sync happens after
> +	 *	any concurrent sync which should guarantee correctness.
> +	 */
> +	synchronize_rcu();
> +
> +	rcu_read_lock();
> +	for_each_process_thread(g, p)
> +		__uclamp_sync_util_min_rt_default(p);
> +	rcu_read_unlock();
> +}

It's monday, and I cannot get my brain working.. I cannot decipher the
comments you have with the smp_[rw]mb(), what actual ordering do they
enforce?

Also, your synchronize_rcu() relies on write_lock() beeing
non-preemptible, which isn't true on PREEMPT_RT.

The below seems simpler...

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1013,8 +1013,6 @@ static void __uclamp_sync_util_min_rt_de
 	unsigned int default_util_min;
 	struct uclamp_se *uc_se;
 
-	WARN_ON_ONCE(!rcu_read_lock_held());
-
 	if (!rt_task(p))
 		return;
 
@@ -1024,8 +1022,6 @@ static void __uclamp_sync_util_min_rt_de
 	if (uc_se->user_defined)
 		return;
 
-	/* Sync with smp_wmb() in uclamp_sync_util_min_rt_default() */
-	smp_rmb();
 	default_util_min = sysctl_sched_uclamp_util_min_rt_default;
 	uclamp_se_set(uc_se, default_util_min, false);
 }
@@ -1035,47 +1031,21 @@ static void uclamp_sync_util_min_rt_defa
 	struct task_struct *g, *p;
 
 	/*
-	 * Make sure the updated sysctl_sched_uclamp_util_min_rt_default which
-	 * was just written is synchronized against any future read on another
-	 * cpu.
-	 */
-	smp_wmb();
-
-	/*
-	 * Wait for all updaters to observe the new change.
-	 *
-	 * There are 2 races to deal with here:
-	 *
-	 * 1. fork()->copy_process()
-	 *
-	 *	If a task was concurrently forking, for_each_process_thread()
-	 *	will not see it, hence it could have copied the old value and
-	 *	we missed the opportunity to update it.
-	 *
-	 *	This should be handled by sched_post_fork() where it'll ensure
-	 *	it performs the sync after the fork.
-	 *
-	 * 2. fork()->sched_post_fork()
-	 *    __setscheduler_uclamp()
-	 *
-	 *	Both of these functions could read the old value but then get
-	 *	preempted, during which a user might write new value to
-	 *	sysctl_sched_uclamp_util_min_rt_default.
-	 *
-	 *	// read sysctl_sched_uclamp_util_min_rt_default;
-	 *	// PREEMPT-OUT
-	 *	.
-	 *	.                  <-- sync happens here
-	 *	.
-	 *	// PREEMPT-IN
-	 *	// write p->uclamp_req[UCLAMP_MIN]
-	 *
-	 *	That section is protected with rcu_read_lock(), so
-	 *	synchronize_rcu() will guarantee it has finished before we
-	 *	perform the update. Hence ensure that this sync happens after
-	 *	any concurrent sync which should guarantee correctness.
-	 */
-	synchronize_rcu();
+	 * copy_process()			sysctl_uclamp
+	 *					  uclamp_min_rt = X;
+	 *   write_lock(&tasklist_lock)		  read_lock(&tasklist_lock)
+	 *   // link thread			  smp_mb__after_spinlock()
+	 *   write_unlock(&tasklist_lock)	  read_unlock(&tasklist_lock);
+	 *   sched_post_fork()			  for_each_process_thread()
+	 *     __uclamp_sync_rt()		    __uclamp_sync_rt()
+	 *
+	 * Ensures that either sched_post_fork() will observe the new
+	 * uclamp_min_rt or for_each_process_thread() will observe the new
+	 * task.
+	 */
+	read_lock(&tasklist_lock);
+	smp_mb__after_spinlock();
+	read_unlock(&tasklist_lock);
 
 	rcu_read_lock();
 	for_each_process_thread(g, p)
@@ -1408,6 +1378,9 @@ int sysctl_sched_uclamp_handler(struct c
 		uclamp_update_root_tg();
 	}
 
+	if (old_min_rt != sysctl_sched_uclamp_util_min_rt_default)
+		uclamp_sync_util_min_rt_default();
+
 	/*
 	 * We update all RUNNABLE tasks only when task groups are in use.
 	 * Otherwise, keep it simple and do just a lazy update at each next
@@ -1466,9 +1439,7 @@ static void __setscheduler_uclamp(struct
 		 * at runtime.
 		 */
 		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN)) {
-			rcu_read_lock();
 			__uclamp_sync_util_min_rt_default(p);
-			rcu_read_unlock();
 		} else {
 			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
 		}
@@ -1521,6 +1492,11 @@ static void __init init_uclamp_rq(struct
 	rq->uclamp_flags = 0;
 }
 
+static void uclamp_post_fork(struct task_struct *p)
+{
+	__uclamp_sync_util_min_rt_default(p);
+}
+
 static void __init init_uclamp(void)
 {
 	struct uclamp_se uc_max = {};
