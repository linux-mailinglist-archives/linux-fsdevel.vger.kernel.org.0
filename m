Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4360179B1E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 22:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387931AbgCDVkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 16:40:06 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:57616 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbgCDVkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:40:06 -0500
Received: by mail-pj1-f74.google.com with SMTP id ca1so1659839pjb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2020 13:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qZ8if+Ch4cFUq+p9Td5MU18RPQJ1fprXY5s5kw9wj+E=;
        b=NzXkPw5INYLzoOt54Fe0tr8pbefBrriYHknUVnnDzv9Z1vqmmGadAq3R5xbPfUoz0p
         0V7oaQizSxwtazlhV8PQ/MaOhz2jwurQZFcGNW0lMdZae5innCu9m8LHI6TAzKHyg9xO
         vDacJv+36aqVrmoBJ9SMNwwd1655bL4gniN4hYgXB/VK3eMLWbs1/axQeTTynE9QjKH4
         +bKgOqVtf25Po4LE8cPzkGXbUiCcKMCZNB3SsrTnMy95qDQ1x37YY677zZswVNhNjPDB
         T41OJD9KghQy+b0z80TWVgNKOW6l8hJBMhqXLyI3i1f99hEjleYbqTITqQ18Qlwd6hAb
         j1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qZ8if+Ch4cFUq+p9Td5MU18RPQJ1fprXY5s5kw9wj+E=;
        b=B81oT1Hg4VzEDPw1X3KgNOO5DT8+AltMEReu4U0iCPcD+bYkPQRVJrBEFx9QvzrOTw
         AI5tvL+4Bjry8hnhLR45v0hDIeR8c/zoe6CTZBX/h9P2Xes9fMFqZnG4ox8XaKJLxw84
         2u9z3PbdWv9F00TNHEmbXtwqT27MzTx7wWVsyxaW744EohYMV/O4HjFJP357knqlMrZV
         6+tfKJvPi5RUYYPmJ1vzbjzbR+w5cs/ZbHYbH22/AB3vTXKkzaI68mUiMbjDjNp6bJ78
         8/bFQv2hham3onir2KckRgRv7wfae7UltG190lzAQNzQVks9g6xPNuAGHW5UIUaESmn/
         +Jkw==
X-Gm-Message-State: ANhLgQ1JjVdlTnA48Sg+XgQaDRItZcnWyslnT/mT4+pqqMyfUuJfLlFy
        dvNbdd/k/+k4abd8klmUOsXv2c0=
X-Google-Smtp-Source: ADFU+vvBJl4b2tNe0jcyk1rfgRMrYda87mLj0u87GFE6qjl/MecY+OFdsSCVwPWrDN2KbNoP+Pnxv1c=
X-Received: by 2002:a63:441e:: with SMTP id r30mr4273492pga.51.1583358004604;
 Wed, 04 Mar 2020 13:40:04 -0800 (PST)
Date:   Wed,  4 Mar 2020 13:39:41 -0800
Message-Id: <20200304213941.112303-1-xii@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
From:   Xi Wang <xii@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Xi Wang <xii@google.com>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The main purpose of kernel watchdog is to test whether scheduler can
still schedule tasks on a cpu. In order to reduce latency from
periodically invoking watchdog reset in thread context, we can simply
touch watchdog from pick_next_task in scheduler. Compared to actually
resetting watchdog from cpu stop / migration threads, we lose coverage
on: a migration thread actually get picked and we actually context
switch to the migration thread. Both steps are heavily protected by
kernel locks and unlikely to silently fail. Thus the change would
provide the same level of protection with less overhead.

The new way vs the old way to touch the watchdogs is configurable
from:

/proc/sys/kernel/watchdog_touch_in_thread_interval

The value means:
0: Always touch watchdog from pick_next_task
1: Always touch watchdog from migration thread
N (N>0): Touch watchdog from migration thread once in every N
         invocations, and touch watchdog from pick_next_task for
         other invocations.

Suggested-by: Paul Turner <pjt@google.com>
Signed-off-by: Xi Wang <xii@google.com>
---
 kernel/sched/core.c | 36 ++++++++++++++++++++++++++++++++++--
 kernel/sysctl.c     | 11 ++++++++++-
 kernel/watchdog.c   | 39 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 78 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a9983da4408..9d8e00760d1c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3898,6 +3898,27 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 	schedstat_inc(this_rq()->sched_count);
 }
 
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
+
+DEFINE_PER_CPU(bool, sched_should_touch_watchdog);
+
+void touch_watchdog_from_sched(void);
+
+/* Helper called by watchdog code */
+void resched_for_watchdog(void)
+{
+	unsigned long flags;
+	struct rq *rq = this_rq();
+
+	this_cpu_write(sched_should_touch_watchdog, true);
+	raw_spin_lock_irqsave(&rq->lock, flags);
+	/* Trigger resched for code in pick_next_task to touch watchdog */
+	resched_curr(rq);
+	raw_spin_unlock_irqrestore(&rq->lock, flags);
+}
+
+#endif /* CONFIG_SOFTLOCKUP_DETECTOR */
+
 /*
  * Pick up the highest-prio task:
  */
@@ -3927,7 +3948,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			p = pick_next_task_idle(rq);
 		}
 
-		return p;
+		goto out;
 	}
 
 restart:
@@ -3951,11 +3972,22 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)
-			return p;
+			goto out;
 	}
 
 	/* The idle class should always have a runnable task: */
 	BUG();
+
+out:
+
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
+	if (this_cpu_read(sched_should_touch_watchdog)) {
+		touch_watchdog_from_sched();
+		this_cpu_write(sched_should_touch_watchdog, false);
+	}
+#endif
+
+	return p;
 }
 
 /*
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ad5b88a53c5a..adb4b11fbccb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -118,6 +118,9 @@ extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
 #ifndef CONFIG_MMU
 extern int sysctl_nr_trim_pages;
 #endif
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
+extern unsigned int sysctl_watchdog_touch_in_thread_interval;
+#endif
 
 /* Constants used for minimum and  maximum */
 #ifdef CONFIG_LOCKUP_DETECTOR
@@ -961,6 +964,13 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "watchdog_touch_in_thread_interval",
+		.data		= &sysctl_watchdog_touch_in_thread_interval,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 #ifdef CONFIG_SMP
 	{
 		.procname	= "softlockup_all_cpu_backtrace",
@@ -996,7 +1006,6 @@ static struct ctl_table kern_table[] = {
 #endif /* CONFIG_SMP */
 #endif
 #endif
-
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 	{
 		.procname       = "unknown_nmi_panic",
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index b6b1f54a7837..f9138c29db48 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -49,6 +49,16 @@ static struct cpumask watchdog_allowed_mask __read_mostly;
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
 
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
+/*
+ * 0: Always touch watchdog from pick_next_task
+ * 1: Always touch watchdog from migration thread
+ * N (N>0): Touch watchdog from migration thread once in every N invocations,
+ *          and touch watchdog from pick_next_task for other invocations.
+ */
+unsigned int sysctl_watchdog_touch_in_thread_interval = 10;
+#endif
+
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
 /*
  * Should we panic when a soft-lockup or hard-lockup occurs:
@@ -356,6 +366,9 @@ static int softlockup_fn(void *data)
 	return 0;
 }
 
+static DEFINE_PER_CPU(unsigned int, num_watchdog_wakeup_skipped);
+void resched_for_watchdog(void);
+
 /* watchdog kicker functions */
 static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
@@ -371,11 +384,20 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	watchdog_interrupt_count();
 
 	/* kick the softlockup detector */
-	if (completion_done(this_cpu_ptr(&softlockup_completion))) {
-		reinit_completion(this_cpu_ptr(&softlockup_completion));
-		stop_one_cpu_nowait(smp_processor_id(),
-				softlockup_fn, NULL,
-				this_cpu_ptr(&softlockup_stop_work));
+	if ((!sysctl_watchdog_touch_in_thread_interval ||
+	  sysctl_watchdog_touch_in_thread_interval > this_cpu_read(num_watchdog_wakeup_skipped) + 1)) {
+		this_cpu_write(num_watchdog_wakeup_skipped, sysctl_watchdog_touch_in_thread_interval ?
+		  this_cpu_read(num_watchdog_wakeup_skipped) + 1 : 0);
+		/* touch watchdog from pick_next_task */
+		resched_for_watchdog();
+	} else {
+		this_cpu_write(num_watchdog_wakeup_skipped, 0);
+		if (completion_done(this_cpu_ptr(&softlockup_completion))) {
+			reinit_completion(this_cpu_ptr(&softlockup_completion));
+			stop_one_cpu_nowait(smp_processor_id(),
+					softlockup_fn, NULL,
+					this_cpu_ptr(&softlockup_stop_work));
+		}
 	}
 
 	/* .. and repeat */
@@ -526,6 +548,13 @@ static int softlockup_start_fn(void *data)
 	return 0;
 }
 
+
+/* Similar to watchdog thread function but called from pick_next_task */
+void touch_watchdog_from_sched(void)
+{
+	__touch_watchdog();
+}
+
 static void softlockup_start_all(void)
 {
 	int cpu;
-- 
2.25.1.481.gfbce0eb801-goog

