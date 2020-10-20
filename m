Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052D4293FD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 17:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436776AbgJTPpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 11:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436743AbgJTPpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:45:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C393CC061755;
        Tue, 20 Oct 2020 08:45:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e2so2463781wme.1;
        Tue, 20 Oct 2020 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+AoXC3EzbJKgwn1kacgBLBmXWh5IxY6XMSSNuFAlmA=;
        b=G4BIwcc3o23aFBmNh8h4grqyZCGFB+dOkZ0zb0zKUqz4EfLawGc+MgxTNChrURo+jv
         +ygqVDxTTaxIj9f+ZV0X1JM35rhcDDSzKF0HAHYJeP2Ors2ApXMzeG6Zte2sR+309Z+D
         lyKnQVq86r7SZyE6+YmiiMN1g4ld1Tet3wb3BKXfkCpjK7r4Fl6xu8P3YhwbujUnUHF3
         bNBZBrR9D6W9xqlNpck8GrM8LrCgOu462wZ1ZkBmb7LhxhWQ6eoviWlSwmq6UMNVQsbK
         7o4UtWI77zGuopfE+tjHXiVx9EMCjOB41gKYWEl3ehwbDStb8aZoXu6bAZ7oWdP+UpCz
         QdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+AoXC3EzbJKgwn1kacgBLBmXWh5IxY6XMSSNuFAlmA=;
        b=mvTbGiukF7DLamF1pZ4FkkPuBqm7qpzwUR1wvfRwGvKQbBTN8Nhj6qdJrfHzA/eBaM
         7Xu8qlMocfzxBwej8Wo8gCdLBNsKTR1umBgtte7cypIafFO5rbn2OaSHBuDDICRcpoRo
         O42JbhBEDGyG3YzbTwVDkPBRZN78SefouhSM9h2VE6i/lnnSRMNa5EzUXo2ag6o8zUqq
         aQOAl73rUdxYDEOiMhUfByanQBrRjLbA7G9GyV9ZP86cNjzCVz7DmtLCeBearCX0X7z8
         23ZD2rwKNTOKUer2oNnvGe+vz+uaUbqLajv7QQctLAeBCwwSn5KrrsZYmkJ4roe2GddO
         NoCw==
X-Gm-Message-State: AOAM5334iztvD42om2w1KSmEtu0b2tL2Zj5UHemoSaxnU3EivcgDbkQo
        YN5M8bIf3cZQM1A/luleJoU=
X-Google-Smtp-Source: ABdhPJxG2OMqY8zaXeIfy/mqA5/alMJhqg5on2yeOr/kXF/+cZROKXHpslE3nkQVS+nrlqZZrZorZg==
X-Received: by 2002:a1c:5f84:: with SMTP id t126mr3553689wmb.89.1603208712360;
        Tue, 20 Oct 2020 08:45:12 -0700 (PDT)
Received: from stormsend.lip6.fr (dell-redha.rsr.lip6.fr. [132.227.76.3])
        by smtp.googlemail.com with ESMTPSA id y21sm3070464wma.19.2020.10.20.08.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 08:45:11 -0700 (PDT)
From:   Redha Gouicem <redha.gouicem@gmail.com>
Cc:     julien.sopena@lip6.fr, julia.lawall@inria.fr,
        gilles.muller@inria.fr, carverdamien@gmail.com,
        jean-pierre.lozi@oracle.com, baptiste.lepers@sydney.edu.au,
        nicolas.palix@univ-grenoble-alpes.fr,
        willy.zwaenepoel@sydney.edu.au,
        Redha Gouicem <redha.gouicem@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrey Ignatov <rdna@fb.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] sched/fair: delay thread migration on fork/wakeup/exec
Date:   Tue, 20 Oct 2020 17:44:41 +0200
Message-Id: <20201020154445.119701-4-redha.gouicem@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020154445.119701-1-redha.gouicem@gmail.com>
References: <20201020154445.119701-1-redha.gouicem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On CPUs that implement per-core frequency scaling (and not per-socket), it
is beneficial to try to use cores running at a higher frequency. One way to
do this on fork/exec/wakeup is to keep the targeted thread on its
parent/previous/waker core, since it should already be running at a high
frequency.

This is how this works:
   - choose the new_cpu as usual in select_task_rq_fair()
   - if we are in a fork/exec/wakeup and new_cpu runs at a low frequency,
     start a timer in 50us and place the
     thread on its parent/previous/waker core
   - if the thread is scheduled, cancel the timer
   - if the timer expires, migrate the thread to new_cpu

This way, if the previous cpu is too busy to be used, the thread will use
another cpu. This is particularly useful in fork/wait patterns where the
child thread is placed on an idle core (low frequency) and the parent
thread waits and makes its core idle (high frequency). This patch avoids
using a low frequency core if a higher frquency one is available.

There are two configuration parameters for this feature:
   - the frequency threshold under which we consider the core to be running
     at a low frequency, in kHz (/proc/sys/kernel/sched_lowfreq). By
     default, this is set to 0, which disables the delayed thread migration
     feature.
   - the delay of the timer, in ns
     (/proc/sys/kernel/sched_delayed_placement)

Co-developed-by: Damien Carver <carverdamien@gmail.com>
Signed-off-by: Damien Carver <carverdamien@gmail.com>
Signed-off-by: Redha Gouicem <redha.gouicem@gmail.com>
---
 include/linux/sched.h        |  4 ++++
 include/linux/sched/sysctl.h |  3 +++
 kernel/sched/core.c          | 32 +++++++++++++++++++++++++++
 kernel/sched/fair.c          | 42 +++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h         |  3 +++
 kernel/sysctl.c              | 14 ++++++++++++
 6 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2bf0af19a62a..ae823d458f94 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -662,6 +662,10 @@ struct task_struct {
 	unsigned long			wakee_flip_decay_ts;
 	struct task_struct		*last_wakee;
 
+	/* Delayed placement */
+	struct hrtimer                  delay_placement_timer;
+	int                             delay_placement_cpu;
+
 	/*
 	 * recent_used_cpu is initially set as the last CPU used by a task
 	 * that wakes affine another task. Waker/wakee relationships can
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 3c31ba88aca5..97a1f4489910 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -52,6 +52,9 @@ int sched_proc_update_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos);
 #endif
 
+extern __read_mostly unsigned int sysctl_sched_delayed_placement;
+extern __read_mostly unsigned int sysctl_sched_lowfreq;
+
 /*
  *  control realtime throttling:
  *
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d6d27a6fc23c..9958b38a5b6f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3217,6 +3217,33 @@ int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 static inline void init_schedstats(void) {}
 #endif /* CONFIG_SCHEDSTATS */
 
+static enum hrtimer_restart delayed_placement_fn(struct hrtimer *data)
+{
+	struct task_struct *p = container_of(data, struct task_struct,
+					     delay_placement_timer);
+	struct rq *rq;
+	struct rq_flags rf;
+	bool queued, running;
+
+	/*
+	 * If, by chance, p was already migrated to this cpu, no need to do
+	 * anything. This can happen because of load balancing for example.
+	 */
+	if (task_cpu(p) == p->delay_placement_cpu)
+		return HRTIMER_NORESTART;
+
+	rq = task_rq_lock(p, &rf);
+
+	queued = task_on_rq_queued(p);
+	running = task_current(rq, p);
+	if (queued && !running)
+		rq = __migrate_task(rq, &rf, p, p->delay_placement_cpu);
+
+	task_rq_unlock(rq, p, &rf);
+
+	return HRTIMER_NORESTART;
+}
+
 /*
  * fork()/clone()-time setup:
  */
@@ -3299,6 +3326,11 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 #endif
+
+	hrtimer_init(&p->delay_placement_timer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL);
+	p->delay_placement_timer.function = delayed_placement_fn;
+
 	return 0;
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33699db27ed5..99c42c215477 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -84,6 +84,15 @@ static unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
+/*
+ * After fork, exec or wakeup, thread placement is delayed. This option gives
+ * the delay in nanoseconds.
+ *
+ * (default: 50us)
+ */
+unsigned int sysctl_sched_delayed_placement = 50000;
+unsigned int sysctl_sched_lowfreq;
+
 int sched_thermal_decay_shift;
 static int __init setup_sched_thermal_decay_shift(char *str)
 {
@@ -6656,6 +6665,13 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	return -1;
 }
 
+static bool is_cpu_low_freq(int cpu)
+{
+	if (!sysctl_sched_lowfreq)
+		return false;
+	return cpu_rq(cpu)->freq <= sysctl_sched_lowfreq;
+}
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
@@ -6683,7 +6699,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 		if (sched_energy_enabled()) {
 			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
 			if (new_cpu >= 0)
-				return new_cpu;
+				goto local;
 			new_cpu = prev_cpu;
 		}
 
@@ -6724,6 +6740,28 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	}
 	rcu_read_unlock();
 
+local:
+	if (!is_cpu_low_freq(new_cpu))
+		goto end;
+	/*
+	 * If fork/wake/exec, trigger an interrupt in 50us (default) to eventually steal the thread
+	 * and place the thread locally.
+	 */
+	if (new_cpu == task_cpu(p))
+		goto end;
+
+	if (sd_flag & (SD_BALANCE_FORK | SD_BALANCE_WAKE | SD_BALANCE_EXEC)) {
+		p->delay_placement_cpu = new_cpu;
+		new_cpu = task_cpu(current);
+
+		/* Arm timer in 50us */
+		hrtimer_start(&p->delay_placement_timer,
+			      ktime_set(0,
+					sysctl_sched_delayed_placement),
+			      HRTIMER_MODE_REL);
+	}
+
+end:
 	return new_cpu;
 }
 
@@ -7085,6 +7123,8 @@ done: __maybe_unused;
 	if (hrtick_enabled(rq))
 		hrtick_start_fair(rq, p);
 
+	hrtimer_try_to_cancel(&p->delay_placement_timer);
+
 	update_misfit_status(p, rq);
 
 	return p;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7d794ab756d2..02da9ca69b4a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2018,6 +2018,9 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
+extern unsigned int sysctl_sched_delayed_placement;
+extern unsigned int sysctl_sched_lowfreq;
+
 #ifdef CONFIG_SCHED_HRTICK
 
 /*
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 287862f91717..e8cc36624330 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1712,6 +1712,20 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname       = "sched_delayed_placement",
+		.data           = &sysctl_sched_delayed_placement,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+	{
+		.procname       = "sched_lowfreq",
+		.data           = &sysctl_sched_lowfreq,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
 #ifdef CONFIG_SCHEDSTATS
 	{
 		.procname	= "sched_schedstats",
-- 
2.28.0

