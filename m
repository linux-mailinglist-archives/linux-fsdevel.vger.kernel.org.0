Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A1D246824
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 16:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgHQOLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 10:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728902AbgHQOJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597673394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=q6IDd4y0Wmc1pB+WUrbCZSOFrVKno+kl6q8vuBHV27s=;
        b=cYeHhJ8YhRsPrjHH4i39oSlN7/EIANNNP21jQaKfNiRfhyhltbGdqX49KFUI10hOn8UC0L
        AWEpiDr+uJjbaLDw5Z1M3YCQ+zWcSG2be+szy7WOn3ItQi/AMSanqGlctXoriLM9fA7vGu
        dNLAiEG9YaBcAamq1a0OmQaT+zu++y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-_fp1mGjUP7-SFPCxlAKsFQ-1; Mon, 17 Aug 2020 10:09:52 -0400
X-MC-Unique: _fp1mGjUP7-SFPCxlAKsFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB74F81F004;
        Mon, 17 Aug 2020 14:09:49 +0000 (UTC)
Received: from llong.com (ovpn-118-35.rdu2.redhat.com [10.10.118.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAF9F21E9E;
        Mon, 17 Aug 2020 14:09:47 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 1/8] memcg: Enable fine-grained control of over memory.high action
Date:   Mon, 17 Aug 2020 10:08:24 -0400
Message-Id: <20200817140831.30260-2-longman@redhat.com>
In-Reply-To: <20200817140831.30260-1-longman@redhat.com>
References: <20200817140831.30260-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Memory controller can be used to control and limit the amount of
physical memory used by a task. When a limit is set in "memory.high"
in a non-root memory cgroup, the memory controller will try to reclaim
memory if the limit has been exceeded. Normally, that will be enough
to keep the physical memory consumption of tasks in the memory cgroup
to be around or below the "memory.high" limit.

Sometimes, memory reclaim may not be able to recover memory in a rate
that can catch up to the physical memory allocation rate especially
when rotating disks are used for swapping or writing dirty pages. In
this case, the physical memory consumption will keep on increasing.
When it reaches "memory.max" or the system is really running out of
memory, the OOM killer will be invoked to kill some tasks to free up
additional memory. However, one has little control of which tasks are
going to be killed by an OOM killer.

Users who do not want the OOM killer to be invoked to kill random tasks
in an out-of-memory situation will require a better way to manage memory
and deal with applications that are out of control in term of physical
memory consumption rate.

A new set of prctl(2) commands are added to provide a facility to
allow users to manage the physical memory consumption of each of their
applications and control the mitigation actions that should be taken
when those applications consume more physical memory than what they
are supposed to use.

The new prctl(2) commands are PR_SET_MEMCONTROL and PR_GET_MEMCONTROL
to set the memory control parameters and retrieve those parameters
respectively.  The four possible mitigation actions for a task that
exceeds their designated memory limit are:

 1) Return ENOMEM for some syscalls that allocate or handle memory
 2) Slow down the process for memory reclaim to catch up
 3) Send a specific signal to the task
 4) Kill the task

The parameters that can be specified in the new PR_SET_MEMCONTROL
commands are:

 arg2 - the mitigation action (bits 0-7), signal number (bits 8-15)
	and flags (bits 16-31).
 arg3 - the additional memory limit (in bytes) that will be added to
	memory.high as the real limit that will trigger the mitigation
	action.

The PR_MEMFLAG_SIGCONT flag is used to specify continuous signal delivery
instead of a one-shot signal.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/memcontrol.h |   4 ++
 include/linux/sched.h      |   7 +++
 include/uapi/linux/prctl.h |  37 ++++++++++++
 kernel/sys.c               |  16 ++++++
 mm/memcontrol.c            | 114 +++++++++++++++++++++++++++++++++++++
 5 files changed, 178 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d0b036123c6a..40e6ceb8209b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -445,6 +445,10 @@ void mem_cgroup_uncharge_list(struct list_head *page_list);
 
 void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
 
+long mem_cgroup_over_high_get(struct task_struct *task, unsigned long item);
+long mem_cgroup_over_high_set(struct task_struct *task, unsigned long action,
+			      unsigned long limit);
+
 static struct mem_cgroup_per_node *
 mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
 {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 93ecd930efd3..c79d606d27ab 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1265,6 +1265,13 @@ struct task_struct {
 	/* Number of pages to reclaim on returning to userland: */
 	unsigned int			memcg_nr_pages_over_high;
 
+	/* Memory over-high action, flags, signal and limit */
+	unsigned char			memcg_over_high_action;
+	unsigned char			memcg_over_high_signal;
+	unsigned short			memcg_over_high_flags;
+	unsigned int			memcg_over_high_climit;
+	unsigned int			memcg_over_limit;
+
 	/* Used by memcontrol for targeted memcg charge: */
 	struct mem_cgroup		*active_memcg;
 #endif
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 07b4f8131e36..87970ae7b32c 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -238,4 +238,41 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Per task fine-grained memory cgroup control */
+#define PR_GET_MEMCONTROL		59
+#define PR_SET_MEMCONTROL		60
+
+/*
+ * PR_SET_MEMCONTROL:
+ * 2 parameters are passed:
+ *  - Action word
+ *  - Memory cgroup additional memory limit
+ *
+ * The action word consists of 3 bit fields:
+ *  - Bits  0-7 : over-memory-limit action code
+ *  - Bits  8-15: signal number
+ *  - Bits 16-32: action flags
+ */
+
+/* Control values for PR_SET_MEMCONTROL over limit action */
+# define PR_MEMACT_NONE			0
+# define PR_MEMACT_ENOMEM		1	/* Deny memory request */
+# define PR_MEMACT_SLOWDOWN		2	/* Slow down the process */
+# define PR_MEMACT_SIGNAL		3	/* Send signal */
+# define PR_MEMACT_KILL			4	/* Kill the process */
+# define PR_MEMACT_MAX			PR_MEMACT_KILL
+
+/* Flags for PR_SET_MEMCONTROL */
+# define PR_MEMFLAG_SIGCONT		(1UL << 0) /* Continuous signal delivery */
+# define PR_MEMFLAG_MASK		PR_MEMFLAG_SIGCONT
+
+/* Action word masks */
+# define PR_MEMACT_MASK			0xff
+# define PR_MEMACT_SIG_SHIFT		8
+# define PR_MEMACT_FLG_SHIFT		16
+
+/* Return specified value for PR_GET_MEMCONTROL */
+# define PR_MEMGET_ACTION		0
+# define PR_MEMGET_CLIMIT		1
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index ca11af9d815d..644b86235d7f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -64,6 +64,10 @@
 
 #include <linux/nospec.h>
 
+#ifdef CONFIG_MEMCG
+#include <linux/memcontrol.h>
+#endif
+
 #include <linux/kmsg_dump.h>
 /* Move somewhere else to avoid recompiling? */
 #include <generated/utsrelease.h>
@@ -2530,6 +2534,18 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
 		break;
+#ifdef CONFIG_MEMCG
+	case PR_GET_MEMCONTROL:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = mem_cgroup_over_high_get(me, arg2);
+		break;
+	case PR_SET_MEMCONTROL:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error = mem_cgroup_over_high_set(me, arg2, arg3);
+		break;
+#endif
 	default:
 		error = -EINVAL;
 		break;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b807952b4d43..1106dac024ac 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -59,6 +59,7 @@
 #include <linux/tracehook.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
+#include <linux/prctl.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -2628,6 +2629,71 @@ void mem_cgroup_handle_over_high(void)
 	css_put(&memcg->css);
 }
 
+/*
+ * Task specific action when over the high limit.
+ * Return true if an action has been taken or further check is not needed,
+ * false otherwise.
+ */
+static bool __mem_cgroup_over_high_action(struct mem_cgroup *memcg, u8 action)
+{
+	unsigned long mem;
+	bool ret = false;
+	struct mm_struct *mm = get_task_mm(current);
+	u8  signal = READ_ONCE(current->memcg_over_high_signal);
+	u16 flags  = READ_ONCE(current->memcg_over_high_flags);
+	u32 limit  = READ_ONCE(current->memcg_over_high_climit);
+
+	if (!mm)
+		return true;	/* No more check is needed */
+
+	current->memcg_over_limit = false;
+	if ((action == PR_MEMACT_SIGNAL) && !signal)
+		goto out;
+
+	mem = page_counter_read(&memcg->memory);
+	if (mem <= memcg->memory.high + limit)
+		goto out;
+
+	ret = true;
+	switch (action) {
+	case PR_MEMACT_ENOMEM:
+		WRITE_ONCE(current->memcg_over_limit, true);
+		break;
+	case PR_MEMACT_SLOWDOWN:
+		/* Slow down by yielding the cpu */
+		set_tsk_need_resched(current);
+		set_preempt_need_resched();
+		break;
+	case PR_MEMACT_KILL:
+		signal = SIGKILL;
+		fallthrough;
+	case PR_MEMACT_SIGNAL:
+		force_sig(signal);
+
+		/* Deliver signal only once if !PR_MEMFLAG_SIGCONT */
+		if (!(flags & PR_MEMFLAG_SIGCONT))
+			WRITE_ONCE(current->memcg_over_high_signal, 0);
+		break;
+	}
+
+out:
+	mmput(mm);
+	return ret;
+}
+
+/*
+ * Return true if an action has been taken or further check is not needed,
+ * false otherwise.
+ */
+static inline bool mem_cgroup_over_high_action(struct mem_cgroup *memcg)
+{
+	u8 action = READ_ONCE(current->memcg_over_high_action);
+
+	if (!action)
+		return true;	/* No more check is needed */
+	return __mem_cgroup_over_high_action(memcg, action);
+}
+
 static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		      unsigned int nr_pages)
 {
@@ -2639,6 +2705,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	unsigned long nr_reclaimed;
 	bool may_swap = true;
 	bool drained = false;
+	bool taken = false;
 	unsigned long pflags;
 
 	if (mem_cgroup_is_root(memcg))
@@ -2797,6 +2864,9 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		swap_high = page_counter_read(&memcg->swap) >
 			READ_ONCE(memcg->swap.high);
 
+		if (mem_high && !taken)
+			taken = mem_cgroup_over_high_action(memcg);
+
 		/* Don't bother a random interrupted task */
 		if (in_interrupt()) {
 			if (mem_high) {
@@ -6959,6 +7029,50 @@ void mem_cgroup_sk_free(struct sock *sk)
 		css_put(&sk->sk_memcg->css);
 }
 
+/*
+ * Get and set cgroup memory-over-high attributes.
+ */
+long mem_cgroup_over_high_get(struct task_struct *task, unsigned long item)
+{
+	switch (item) {
+	case PR_MEMGET_ACTION:
+		return task->memcg_over_high_action |
+		      (task->memcg_over_high_signal << PR_MEMACT_SIG_SHIFT) |
+		      (task->memcg_over_high_flags  << PR_MEMACT_FLG_SHIFT);
+
+	case PR_MEMGET_CLIMIT:
+		return (long)task->memcg_over_high_climit * PAGE_SIZE;
+	}
+	return -EINVAL;
+}
+
+long mem_cgroup_over_high_set(struct task_struct *task, unsigned long action,
+			      unsigned long limit)
+{
+	unsigned char  cmd   = action & PR_MEMACT_MASK;
+	unsigned char  sig   = (action >> PR_MEMACT_SIG_SHIFT) & PR_MEMACT_MASK;
+	unsigned short flags = action >> PR_MEMACT_FLG_SHIFT;
+
+	if ((cmd > PR_MEMACT_MAX) || (flags & ~PR_MEMFLAG_MASK) ||
+	    (sig >= _NSIG))
+		return -EINVAL;
+
+	WRITE_ONCE(task->memcg_over_high_action, cmd);
+	WRITE_ONCE(task->memcg_over_high_signal, sig);
+	WRITE_ONCE(task->memcg_over_high_flags, flags);
+
+	if (cmd == PR_MEMACT_NONE) {
+		WRITE_ONCE(task->memcg_over_high_climit, 0);
+	} else {
+		/*
+		 * Convert limits to # of pages
+		 */
+		limit = DIV_ROUND_UP(limit, PAGE_SIZE);
+		WRITE_ONCE(task->memcg_over_high_climit, limit);
+	}
+	return 0;
+}
+
 /**
  * mem_cgroup_charge_skmem - charge socket memory
  * @memcg: memcg to charge
-- 
2.18.1

