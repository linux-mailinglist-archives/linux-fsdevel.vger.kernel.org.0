Return-Path: <linux-fsdevel+bounces-20713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3C88D71FE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 23:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B239A1C20DA7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 21:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DB936B17;
	Sat,  1 Jun 2024 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="hVEci24q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E341EF1D
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Jun 2024 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717277615; cv=none; b=b7sW6Vh6Pez/sAG8kC5cSN2mIgDHBweWVm4TzzkiSevP2NLadfknV/wbleFBWA5Nhtjmnqkhj0fmWwnl5crWf+ruw419/YhtItnWaTuG+ItUqi/teKZDdIeNGJqG4RKAQ7Ta2fm7H6/b9PwmaJslME+VGG1gJaCE+iaOwjqanvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717277615; c=relaxed/simple;
	bh=WcLKIok6lrt+bvPY32ICPSnt5O5/geZeyMq2jK4Dhno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=neTbufQmf8r0GIvDlZSWD9dMoOaupQnnxmO0axnllDKdhv4snv54JU5FgPNJnL52d38Sfg/x9xI/0+4wE7Wnx+o6FgKEsCo4149PAexH2AK1oX1mNtFgGi0eAtFnFdsqScnaM7LHxNM2QTzHMaMo5yZEzmPOVCaUSEnpEonBy4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=hVEci24q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4211245e889so28711365e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Jun 2024 14:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717277611; x=1717882411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXEctD+/EB3461EYts4njlT0zGyad7Kh+tMqKCzOAgc=;
        b=hVEci24q/Hn6sHJUT+iRCIBLzzJwbTxxkAqFJXi4O0xHHP30hP51DEJZTnfIxm29vJ
         713DDocpmYvkhgrjLQC5vZknSd6M7GBQSSvUfW/x77MUUIWvxvHODZGh4IRIuv1Zdi65
         ktYnQBoWlJ3iZR/0+lcZYzLOI/XrmsxDeteiMFGlAwJW8UnUtquOwUyPf1Uzy6PiNBWi
         4LC18VgBi65x6pA9F1h89TdZqyzop3K/eTV8F5/xQXLocxycbFImEXVuC5Rrzvwls8ZX
         Nf+bIvruq3E3KdHiWCGzo5XXZFlzdZDe3nB0oYNLaPgiS2Zbq79ieG4/FTNAo1FS05w6
         os9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717277611; x=1717882411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXEctD+/EB3461EYts4njlT0zGyad7Kh+tMqKCzOAgc=;
        b=SRPrsr77xml5hMoHsjphStIt9yLQgBcoSnN52/c2qJ90rRC2hTNe8j9YmJR8RoRigE
         WWaWDvQQ9ye4jkG4BpvPY/xiDAeaiQKHVMVt3bOKrYNnkJT7IaFn+BdB/FKk6jn78s85
         62UP8jRzyzDyg23ZWAZX0DsUhqPqW6cKYl9drzflcg9+Tao4LMze8D9tTRal7FvWKkKi
         8yqQMnyJdCCQtrpx9tkb0ebFyvBR4Igf0Zv63RT1IHVEAMbEaW8MVEbx8A4IccNKr2LN
         kQTOgkwGnknavfc92lv8NSKb/LQIHDvajd4/mznubO0JsbAs3sXjYmHmo6Y+DS3624ab
         g7/w==
X-Forwarded-Encrypted: i=1; AJvYcCVLIoAUVlMt6Ql/d+ZJ8Rdd6/ffb8qQkRt/nmgo8AqEJa+8cCWLX492H/Aw/wwyXDyHu0wUmhDqFno5X+a1+UHn7J4+3VIE8+6LwXmwqw==
X-Gm-Message-State: AOJu0YzxAxN00R1XCoLR9FGsBD+SkD7uY3LDNO9KFwcSYASuP022SfnY
	W4HincPRiKmUJ7wytZzV1tTVoUHg813uxJKdxCgUT1cOZC4qlZ8ePlylod7taxs=
X-Google-Smtp-Source: AGHT+IFf3j/N5xUTr7a6XrrbbattC9gyfqiFjLNQnpzGM0ZL9+BCAHYBb4yf6WNo3o6k2OktMieuUQ==
X-Received: by 2002:a5d:4905:0:b0:343:efb7:8748 with SMTP id ffacd0b85a97d-35e0f32f33fmr3959639f8f.66.1717277610698;
        Sat, 01 Jun 2024 14:33:30 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0839sm4751324f8f.23.2024.06.01.14.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 14:33:30 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qais Yousef <qyousef@layalina.io>,
	Phil Auld <pauld@redhat.com>
Subject: [PATCH v4 1/2] sched/rt: Clean up usage of rt_task()
Date: Sat,  1 Jun 2024 22:33:08 +0100
Message-Id: <20240601213309.1262206-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240601213309.1262206-1-qyousef@layalina.io>
References: <20240601213309.1262206-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt_task() checks if a task has RT priority. But depends on your
dictionary, this could mean it belongs to RT class, or is a 'realtime'
task, which includes RT and DL classes.

Since this has caused some confusion already on discussion [1], it
seemed a clean up is due.

I define the usage of rt_task() to be tasks that belong to RT class.
Make sure that it returns true only for RT class and audit the users and
replace the ones required the old behavior with the new realtime_task()
which returns true for RT and DL classes. Introduce similar
realtime_prio() to create similar distinction to rt_prio() and update
the users that required the old behavior to use the new function.

Move MAX_DL_PRIO to prio.h so it can be used in the new definitions.

Document the functions to make it more obvious what is the difference
between them. PI-boosted tasks is a factor that must be taken into
account when choosing which function to use.

Rename task_is_realtime() to realtime_task_policy() as the old name is
confusing against the new realtime_task().

No functional changes were intended.

[1] https://lore.kernel.org/lkml/20240506100509.GL40213@noisy.programming.kicks-ass.net/

Reviewed-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 fs/bcachefs/six.c                 |  2 +-
 fs/select.c                       |  2 +-
 include/linux/ioprio.h            |  2 +-
 include/linux/sched/deadline.h    |  6 ++++--
 include/linux/sched/prio.h        |  1 +
 include/linux/sched/rt.h          | 27 ++++++++++++++++++++++++++-
 kernel/locking/rtmutex.c          |  4 ++--
 kernel/locking/rwsem.c            |  4 ++--
 kernel/locking/ww_mutex.h         |  2 +-
 kernel/sched/core.c               |  4 ++--
 kernel/sched/syscalls.c           |  2 +-
 kernel/time/hrtimer.c             |  6 +++---
 kernel/trace/trace_sched_wakeup.c |  2 +-
 mm/page-writeback.c               |  4 ++--
 mm/page_alloc.c                   |  2 +-
 15 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/fs/bcachefs/six.c b/fs/bcachefs/six.c
index 3a494c5d1247..b30870bf7e4a 100644
--- a/fs/bcachefs/six.c
+++ b/fs/bcachefs/six.c
@@ -335,7 +335,7 @@ static inline bool six_owner_running(struct six_lock *lock)
 	 */
 	rcu_read_lock();
 	struct task_struct *owner = READ_ONCE(lock->owner);
-	bool ret = owner ? owner_on_cpu(owner) : !rt_task(current);
+	bool ret = owner ? owner_on_cpu(owner) : !realtime_task(current);
 	rcu_read_unlock();
 
 	return ret;
diff --git a/fs/select.c b/fs/select.c
index 9515c3fa1a03..8d5c1419416c 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -82,7 +82,7 @@ u64 select_estimate_accuracy(struct timespec64 *tv)
 	 * Realtime tasks get a slack of 0 for obvious reasons.
 	 */
 
-	if (rt_task(current))
+	if (realtime_task(current))
 		return 0;
 
 	ktime_get_ts64(&now);
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index db1249cd9692..75859b78d540 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -40,7 +40,7 @@ static inline int task_nice_ioclass(struct task_struct *task)
 {
 	if (task->policy == SCHED_IDLE)
 		return IOPRIO_CLASS_IDLE;
-	else if (task_is_realtime(task))
+	else if (realtime_task_policy(task))
 		return IOPRIO_CLASS_RT;
 	else
 		return IOPRIO_CLASS_BE;
diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index df3aca89d4f5..5cb88b748ad6 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -10,8 +10,6 @@
 
 #include <linux/sched.h>
 
-#define MAX_DL_PRIO		0
-
 static inline int dl_prio(int prio)
 {
 	if (unlikely(prio < MAX_DL_PRIO))
@@ -19,6 +17,10 @@ static inline int dl_prio(int prio)
 	return 0;
 }
 
+/*
+ * Returns true if a task has a priority that belongs to DL class. PI-boosted
+ * tasks will return true. Use dl_policy() to ignore PI-boosted tasks.
+ */
 static inline int dl_task(struct task_struct *p)
 {
 	return dl_prio(p->prio);
diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
index ab83d85e1183..6ab43b4f72f9 100644
--- a/include/linux/sched/prio.h
+++ b/include/linux/sched/prio.h
@@ -14,6 +14,7 @@
  */
 
 #define MAX_RT_PRIO		100
+#define MAX_DL_PRIO		0
 
 #define MAX_PRIO		(MAX_RT_PRIO + NICE_WIDTH)
 #define DEFAULT_PRIO		(MAX_RT_PRIO + NICE_WIDTH / 2)
diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index b2b9e6eb9683..a055dd68a77c 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -7,18 +7,43 @@
 struct task_struct;
 
 static inline int rt_prio(int prio)
+{
+	if (unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO))
+		return 1;
+	return 0;
+}
+
+static inline int realtime_prio(int prio)
 {
 	if (unlikely(prio < MAX_RT_PRIO))
 		return 1;
 	return 0;
 }
 
+/*
+ * Returns true if a task has a priority that belongs to RT class. PI-boosted
+ * tasks will return true. Use rt_policy() to ignore PI-boosted tasks.
+ */
 static inline int rt_task(struct task_struct *p)
 {
 	return rt_prio(p->prio);
 }
 
-static inline bool task_is_realtime(struct task_struct *tsk)
+/*
+ * Returns true if a task has a priority that belongs to RT or DL classes.
+ * PI-boosted tasks will return true. Use realtime_task_policy() to ignore
+ * PI-boosted tasks.
+ */
+static inline int realtime_task(struct task_struct *p)
+{
+	return realtime_prio(p->prio);
+}
+
+/*
+ * Returns true if a task has a policy that belongs to RT or DL classes.
+ * PI-boosted tasks will return false.
+ */
+static inline bool realtime_task_policy(struct task_struct *tsk)
 {
 	int policy = tsk->policy;
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 88d08eeb8bc0..55c9dab37f33 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -347,7 +347,7 @@ static __always_inline int __waiter_prio(struct task_struct *task)
 {
 	int prio = task->prio;
 
-	if (!rt_prio(prio))
+	if (!realtime_prio(prio))
 		return DEFAULT_PRIO;
 
 	return prio;
@@ -435,7 +435,7 @@ static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
 	 * Note that RT tasks are excluded from same priority (lateral)
 	 * steals to prevent the introduction of an unbounded latency.
 	 */
-	if (rt_prio(waiter->tree.prio) || dl_prio(waiter->tree.prio))
+	if (realtime_prio(waiter->tree.prio))
 		return false;
 
 	return rt_waiter_node_equal(&waiter->tree, &top_waiter->tree);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c6d17aee4209..ad8d4438bc91 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -631,7 +631,7 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 			 * if it is an RT task or wait in the wait queue
 			 * for too long.
 			 */
-			if (has_handoff || (!rt_task(waiter->task) &&
+			if (has_handoff || (!realtime_task(waiter->task) &&
 					    !time_after(jiffies, waiter->timeout)))
 				return false;
 
@@ -914,7 +914,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		if (owner_state != OWNER_WRITER) {
 			if (need_resched())
 				break;
-			if (rt_task(current) &&
+			if (realtime_task(current) &&
 			   (prev_owner_state != OWNER_WRITER))
 				break;
 		}
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 3ad2cc4823e5..fa4b416a1f62 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -237,7 +237,7 @@ __ww_ctx_less(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
 	int a_prio = a->task->prio;
 	int b_prio = b->task->prio;
 
-	if (rt_prio(a_prio) || rt_prio(b_prio)) {
+	if (realtime_prio(a_prio) || realtime_prio(b_prio)) {
 
 		if (a_prio > b_prio)
 			return true;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5d861b59d737..22c7efed83b4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -163,7 +163,7 @@ static inline int __task_prio(const struct task_struct *p)
 	if (p->sched_class == &stop_sched_class) /* trumps deadline */
 		return -2;
 
-	if (rt_prio(p->prio)) /* includes deadline */
+	if (realtime_prio(p->prio)) /* includes deadline */
 		return p->prio; /* [-1, 99] */
 
 	if (p->sched_class == &idle_sched_class)
@@ -8522,7 +8522,7 @@ void normalize_rt_tasks(void)
 		schedstat_set(p->stats.sleep_start, 0);
 		schedstat_set(p->stats.block_start, 0);
 
-		if (!dl_task(p) && !rt_task(p)) {
+		if (!realtime_task(p)) {
 			/*
 			 * Renice negative nice level userspace
 			 * tasks back to 0:
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ae1b42775ef9..6d60326d73e4 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -57,7 +57,7 @@ static int effective_prio(struct task_struct *p)
 	 * keep the priority unchanged. Otherwise, update priority
 	 * to the normal priority:
 	 */
-	if (!rt_prio(p->prio))
+	if (!realtime_prio(p->prio))
 		return p->normal_prio;
 	return p->prio;
 }
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 492c14aac642..89d4da59059d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1973,7 +1973,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 	 * expiry.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
+		if (realtime_task_policy(current) && !(mode & HRTIMER_MODE_SOFT))
 			mode |= HRTIMER_MODE_HARD;
 	}
 
@@ -2073,7 +2073,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 	u64 slack;
 
 	slack = current->timer_slack_ns;
-	if (rt_task(current))
+	if (realtime_task(current))
 		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
@@ -2278,7 +2278,7 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 	 * Override any slack passed by the user if under
 	 * rt contraints.
 	 */
-	if (rt_task(current))
+	if (realtime_task(current))
 		delta = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 0469a04a355f..19d737742e29 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -545,7 +545,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	 *  - wakeup_dl handles tasks belonging to sched_dl class only.
 	 */
 	if (tracing_dl || (wakeup_dl && !dl_task(p)) ||
-	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
+	    (wakeup_rt && !realtime_task(p)) ||
 	    (!dl_task(p) && (p->prio >= wakeup_prio || p->prio >= current->prio)))
 		return;
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 12c9297ed4a7..d9464af1d992 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -418,7 +418,7 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
 	if (bg_thresh >= thresh)
 		bg_thresh = thresh / 2;
 	tsk = current;
-	if (rt_task(tsk)) {
+	if (realtime_task(tsk)) {
 		bg_thresh += bg_thresh / 4 + global_wb_domain.dirty_limit / 32;
 		thresh += thresh / 4 + global_wb_domain.dirty_limit / 32;
 	}
@@ -468,7 +468,7 @@ static unsigned long node_dirty_limit(struct pglist_data *pgdat)
 	else
 		dirty = vm_dirty_ratio * node_memory / 100;
 
-	if (rt_task(tsk))
+	if (realtime_task(tsk))
 		dirty += dirty / 4;
 
 	return dirty;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e22ce5675ca..807dd6aa3edb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3962,7 +3962,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 		 */
 		if (alloc_flags & ALLOC_MIN_RESERVE)
 			alloc_flags &= ~ALLOC_CPUSET;
-	} else if (unlikely(rt_task(current)) && in_task())
+	} else if (unlikely(realtime_task(current)) && in_task())
 		alloc_flags |= ALLOC_MIN_RESERVE;
 
 	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
-- 
2.34.1


