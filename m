Return-Path: <linux-fsdevel+bounces-21351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7089A90292C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 21:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1624B224BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 19:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C77F1514D4;
	Mon, 10 Jun 2024 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="diyk9bpo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594814F9F7
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047229; cv=none; b=j7b4Yc3zFA+ix/qRcHAgvUQVlTnMByFgvYIyxafuGEWdiVCxm4o/igpFyoQ7A/z7zTLW6IwcXe21URSemnqjGJKcsfr57DH1hTPxO8FaIddJIdiURYCKKWVXM+XYp7Hd/vlxeqzktY7mb0IvDTdu3SV7gsAaX3OCwkpWpMO3egM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047229; c=relaxed/simple;
	bh=J3bP5WWQGwNnDko3wlJ2Np8IavaGGsF2GF/Vli2DJlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cQ4/EdygQTG6NYc9zGfU7sXTDMtE+RxbkuXjR29ZlJ/DtVuc2lSEQAewG0TsfH/vhVAzgHrC4bJBgPhY8K2uDj1flOV/Fl/zKg1p/WI2F2pRzIOzhqeUAFM1o3oqN9i0m4fw78ueekaE0iwvFBUWypcniPUvSTVs+LOi8Nn818I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=diyk9bpo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f1bc63981so1366070f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 12:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718047225; x=1718652025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+BUyWTb5ejwb40scgMVV37IExcyB94GWmaml8ACZ5M=;
        b=diyk9bpo16+dH9GVsP6HCjqmImzIMxbU/12T1K9kYbtCWD7SJKEHZnBzMvyt3e0Djd
         cMFrs9ypkel9pNbyusSKZtU/wszewNwk8HHiPDjcYqwh0pjulAEwZmk4zerJxpSbsXDU
         kZ5rzHN1Zb9otLevFLDQGzpZxEhJvBqOr5x0lOXHDvOfTgA0gmGJqyhvpJG7UembsU8K
         eV9dqQspMZ6wO54CQX+i/Ykb7KR8r+ppS8uk3GYu/Ggim4drrOGsP24V2tDtqvEcSlAj
         q3Xl+AKIdyIpET3VWfdIUu5XLIrKBXX4qBJAFy1a2X+kcltzxBmWGHaZyG/HAfozhUuJ
         m8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718047225; x=1718652025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+BUyWTb5ejwb40scgMVV37IExcyB94GWmaml8ACZ5M=;
        b=KpPLPGWuRPf4u53I4Q4AphFezyP25043Q7PfVikpy/6qk7jLrGLVBP2mkXus6v19uk
         DaujvJvmOeAm4a8W2asvpnKJfkS11Ni2vTN7TIbh4c4uVue++2tySsCdtfWrmGs8ktEB
         kJbpysTGD/JjY/yG+QLSd1TjWRPppo7AZCFEyMJly415qECT5qqD88hf2h02Hlg+8/kA
         CLG7aRPBjfLuJ9rOVGcyjVmHg5N7qBylj8HB3D5Mo3HOByp5najhAbUs/89NlIVxQ9Tr
         b4Lk9pLep2Y9LBkwXFNGjqzkECsbMQkoLAORsFG7wIDUjsLs35zrmXZmkfQi1XoFuKNB
         xy0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDw3P0J9niKdZuWsGyLxCLc64fsS465k6SyMjh3iHLYUCBssh83gmOA1TYadioz/TIIyXd1iuRONiFhRkx2I0887mhbzzm/IVdVxejdg==
X-Gm-Message-State: AOJu0Yxwvmtg6hXfvxhOnBUOhqgfLDodJrmLKt4+HG2Jcjz32UizMwnO
	oeyvoZug0qWcPgLwlQaP6sbVEtI/kTMqolQI2QhQMUbrH17h1fXG0n2CaxW+ExI=
X-Google-Smtp-Source: AGHT+IFEmccaDRTErf+/IywJcGZdVGcKvF9RKr33D7xwLfXpEeid9aCnSjIIdSDXO7wD+fLR4ulleA==
X-Received: by 2002:adf:f38b:0:b0:354:e4da:ba52 with SMTP id ffacd0b85a97d-35f2b27ede7mr548597f8f.10.1718047225355;
        Mon, 10 Jun 2024 12:20:25 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1f30c3ccsm4988326f8f.7.2024.06.10.12.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 12:20:25 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Metin Kaya <metin.kaya@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v6 3/3] sched/rt: Rename realtime_{prio, task}() to rt_or_dl_{prio, task}()
Date: Mon, 10 Jun 2024 20:20:18 +0100
Message-Id: <20240610192018.1567075-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610192018.1567075-1-qyousef@layalina.io>
References: <20240610192018.1567075-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some find the name realtime overloaded. Use rt_or_dl() as an
alternative, hopefully better, name.

Suggested-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 fs/bcachefs/six.c                 |  2 +-
 fs/select.c                       |  2 +-
 include/linux/ioprio.h            |  2 +-
 include/linux/sched/rt.h          | 10 +++++-----
 kernel/locking/rtmutex.c          |  4 ++--
 kernel/locking/rwsem.c            |  4 ++--
 kernel/locking/ww_mutex.h         |  2 +-
 kernel/sched/core.c               |  4 ++--
 kernel/sched/syscalls.c           |  2 +-
 kernel/time/hrtimer.c             |  6 +++---
 kernel/trace/trace_sched_wakeup.c |  2 +-
 mm/page-writeback.c               |  4 ++--
 mm/page_alloc.c                   |  2 +-
 13 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/bcachefs/six.c b/fs/bcachefs/six.c
index b30870bf7e4a..9cbd3c14c94f 100644
--- a/fs/bcachefs/six.c
+++ b/fs/bcachefs/six.c
@@ -335,7 +335,7 @@ static inline bool six_owner_running(struct six_lock *lock)
 	 */
 	rcu_read_lock();
 	struct task_struct *owner = READ_ONCE(lock->owner);
-	bool ret = owner ? owner_on_cpu(owner) : !realtime_task(current);
+	bool ret = owner ? owner_on_cpu(owner) : !rt_or_dl_task(current);
 	rcu_read_unlock();
 
 	return ret;
diff --git a/fs/select.c b/fs/select.c
index 8d5c1419416c..73fce145eb72 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -82,7 +82,7 @@ u64 select_estimate_accuracy(struct timespec64 *tv)
 	 * Realtime tasks get a slack of 0 for obvious reasons.
 	 */
 
-	if (realtime_task(current))
+	if (rt_or_dl_task(current))
 		return 0;
 
 	ktime_get_ts64(&now);
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 75859b78d540..b25377b6ea98 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -40,7 +40,7 @@ static inline int task_nice_ioclass(struct task_struct *task)
 {
 	if (task->policy == SCHED_IDLE)
 		return IOPRIO_CLASS_IDLE;
-	else if (realtime_task_policy(task))
+	else if (rt_or_dl_task_policy(task))
 		return IOPRIO_CLASS_RT;
 	else
 		return IOPRIO_CLASS_BE;
diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index 91ef1ef2019f..4e3338103654 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -11,7 +11,7 @@ static inline bool rt_prio(int prio)
 	return unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO);
 }
 
-static inline bool realtime_prio(int prio)
+static inline bool rt_or_dl_prio(int prio)
 {
 	return unlikely(prio < MAX_RT_PRIO);
 }
@@ -27,19 +27,19 @@ static inline bool rt_task(struct task_struct *p)
 
 /*
  * Returns true if a task has a priority that belongs to RT or DL classes.
- * PI-boosted tasks will return true. Use realtime_task_policy() to ignore
+ * PI-boosted tasks will return true. Use rt_or_dl_task_policy() to ignore
  * PI-boosted tasks.
  */
-static inline bool realtime_task(struct task_struct *p)
+static inline bool rt_or_dl_task(struct task_struct *p)
 {
-	return realtime_prio(p->prio);
+	return rt_or_dl_prio(p->prio);
 }
 
 /*
  * Returns true if a task has a policy that belongs to RT or DL classes.
  * PI-boosted tasks will return false.
  */
-static inline bool realtime_task_policy(struct task_struct *tsk)
+static inline bool rt_or_dl_task_policy(struct task_struct *tsk)
 {
 	int policy = tsk->policy;
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 55c9dab37f33..c2a530d704b4 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -347,7 +347,7 @@ static __always_inline int __waiter_prio(struct task_struct *task)
 {
 	int prio = task->prio;
 
-	if (!realtime_prio(prio))
+	if (!rt_or_dl_prio(prio))
 		return DEFAULT_PRIO;
 
 	return prio;
@@ -435,7 +435,7 @@ static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
 	 * Note that RT tasks are excluded from same priority (lateral)
 	 * steals to prevent the introduction of an unbounded latency.
 	 */
-	if (realtime_prio(waiter->tree.prio))
+	if (rt_or_dl_prio(waiter->tree.prio))
 		return false;
 
 	return rt_waiter_node_equal(&waiter->tree, &top_waiter->tree);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index ad8d4438bc91..dcbd7b45359a 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -631,7 +631,7 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 			 * if it is an RT task or wait in the wait queue
 			 * for too long.
 			 */
-			if (has_handoff || (!realtime_task(waiter->task) &&
+			if (has_handoff || (!rt_or_dl_task(waiter->task) &&
 					    !time_after(jiffies, waiter->timeout)))
 				return false;
 
@@ -914,7 +914,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		if (owner_state != OWNER_WRITER) {
 			if (need_resched())
 				break;
-			if (realtime_task(current) &&
+			if (rt_or_dl_task(current) &&
 			   (prev_owner_state != OWNER_WRITER))
 				break;
 		}
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index fa4b416a1f62..76d204b7d29c 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -237,7 +237,7 @@ __ww_ctx_less(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
 	int a_prio = a->task->prio;
 	int b_prio = b->task->prio;
 
-	if (realtime_prio(a_prio) || realtime_prio(b_prio)) {
+	if (rt_or_dl_prio(a_prio) || rt_or_dl_prio(b_prio)) {
 
 		if (a_prio > b_prio)
 			return true;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 22c7efed83b4..001da474518e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -163,7 +163,7 @@ static inline int __task_prio(const struct task_struct *p)
 	if (p->sched_class == &stop_sched_class) /* trumps deadline */
 		return -2;
 
-	if (realtime_prio(p->prio)) /* includes deadline */
+	if (rt_or_dl_prio(p->prio))
 		return p->prio; /* [-1, 99] */
 
 	if (p->sched_class == &idle_sched_class)
@@ -8522,7 +8522,7 @@ void normalize_rt_tasks(void)
 		schedstat_set(p->stats.sleep_start, 0);
 		schedstat_set(p->stats.block_start, 0);
 
-		if (!realtime_task(p)) {
+		if (!rt_or_dl_task(p)) {
 			/*
 			 * Renice negative nice level userspace
 			 * tasks back to 0:
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 6d60326d73e4..60e70c889d91 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -57,7 +57,7 @@ static int effective_prio(struct task_struct *p)
 	 * keep the priority unchanged. Otherwise, update priority
 	 * to the normal priority:
 	 */
-	if (!realtime_prio(p->prio))
+	if (!rt_or_dl_prio(p->prio))
 		return p->normal_prio;
 	return p->prio;
 }
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 89d4da59059d..a4319131d4d0 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1973,7 +1973,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 	 * expiry.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		if (realtime_task_policy(current) && !(mode & HRTIMER_MODE_SOFT))
+		if (rt_or_dl_task_policy(current) && !(mode & HRTIMER_MODE_SOFT))
 			mode |= HRTIMER_MODE_HARD;
 	}
 
@@ -2073,7 +2073,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 	u64 slack;
 
 	slack = current->timer_slack_ns;
-	if (realtime_task(current))
+	if (rt_or_dl_task(current))
 		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
@@ -2278,7 +2278,7 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 	 * Override any slack passed by the user if under
 	 * rt contraints.
 	 */
-	if (realtime_task(current))
+	if (rt_or_dl_task(current))
 		delta = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 19d737742e29..3477fd858491 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -545,7 +545,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	 *  - wakeup_dl handles tasks belonging to sched_dl class only.
 	 */
 	if (tracing_dl || (wakeup_dl && !dl_task(p)) ||
-	    (wakeup_rt && !realtime_task(p)) ||
+	    (wakeup_rt && !rt_or_dl_task(p)) ||
 	    (!dl_task(p) && (p->prio >= wakeup_prio || p->prio >= current->prio)))
 		return;
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d9464af1d992..43c189456cef 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -418,7 +418,7 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
 	if (bg_thresh >= thresh)
 		bg_thresh = thresh / 2;
 	tsk = current;
-	if (realtime_task(tsk)) {
+	if (rt_or_dl_task(tsk)) {
 		bg_thresh += bg_thresh / 4 + global_wb_domain.dirty_limit / 32;
 		thresh += thresh / 4 + global_wb_domain.dirty_limit / 32;
 	}
@@ -468,7 +468,7 @@ static unsigned long node_dirty_limit(struct pglist_data *pgdat)
 	else
 		dirty = vm_dirty_ratio * node_memory / 100;
 
-	if (realtime_task(tsk))
+	if (rt_or_dl_task(tsk))
 		dirty += dirty / 4;
 
 	return dirty;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 807dd6aa3edb..623df61834be 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3962,7 +3962,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 		 */
 		if (alloc_flags & ALLOC_MIN_RESERVE)
 			alloc_flags &= ~ALLOC_CPUSET;
-	} else if (unlikely(realtime_task(current)) && in_task())
+	} else if (unlikely(rt_or_dl_task(current)) && in_task())
 		alloc_flags |= ALLOC_MIN_RESERVE;
 
 	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
-- 
2.34.1


