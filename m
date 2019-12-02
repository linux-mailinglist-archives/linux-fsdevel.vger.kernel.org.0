Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B568D10E6BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 09:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfLBIOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 03:14:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfLBIOZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:14:25 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C0039D5F8B839CDB57B6;
        Mon,  2 Dec 2019 16:14:17 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Dec 2019
 16:14:08 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <luto@kernel.org>, <adobriyan@gmail.com>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <peterz@infradead.org>, <bigeasy@linutronix.de>, <mhocko@suse.com>,
        <john.ogness@linutronix.de>, <yi.zhang@huawei.com>,
        <nixiaoming@huawei.com>
Subject: [PATCH 4.4 1/7] sched/core: Allow putting thread_info into task_struct
Date:   Mon, 2 Dec 2019 16:35:13 +0800
Message-ID: <20191202083519.23138-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191202083519.23138-1-yi.zhang@huawei.com>
References: <20191202083519.23138-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

commit c65eacbe290b8141554c71b2c94489e73ade8c8d upstream.

If an arch opts in by setting CONFIG_THREAD_INFO_IN_TASK_STRUCT,
then thread_info is defined as a single 'u32 flags' and is the first
entry of task_struct.  thread_info::task is removed (it serves no
purpose if thread_info is embedded in task_struct), and
thread_info::cpu gets its own slot in task_struct.

This is heavily based on a patch written by Linus.

Originally-from: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jann Horn <jann@thejh.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/a0898196f0476195ca02713691a5037a14f2aac5.1473801993.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 include/linux/init_task.h   |  9 +++++++++
 include/linux/sched.h       | 36 ++++++++++++++++++++++++++++++++++--
 include/linux/thread_info.h | 15 +++++++++++++++
 init/Kconfig                |  7 +++++++
 init/init_task.c            |  7 +++++--
 kernel/sched/sched.h        |  4 ++++
 6 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 1c1ff7e4faa4..d25d3f70ee99 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -15,6 +15,8 @@
 #include <net/net_namespace.h>
 #include <linux/sched/rt.h>
 
+#include <asm/thread_info.h>
+
 #ifdef CONFIG_SMP
 # define INIT_PUSHABLE_TASKS(tsk)					\
 	.pushable_tasks = PLIST_NODE_INIT(tsk.pushable_tasks, MAX_PRIO),
@@ -183,12 +185,19 @@ extern struct task_group root_task_group;
 # define INIT_KASAN(tsk)
 #endif
 
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+# define INIT_TASK_TI(tsk) .thread_info = INIT_THREAD_INFO(tsk),
+#else
+# define INIT_TASK_TI(tsk)
+#endif
+
 /*
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=0, limit=0x1fffff (=2MB)
  */
 #define INIT_TASK(tsk)	\
 {									\
+	INIT_TASK_TI(tsk)						\
 	.state		= 0,						\
 	.stack		= &init_thread_info,				\
 	.usage		= ATOMIC_INIT(2),				\
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1218980f53de..d6b2e77aad3f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1389,6 +1389,13 @@ struct tlbflush_unmap_batch {
 };
 
 struct task_struct {
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+	/*
+	 * For reasons of header soup (see current_thread_info()), this
+	 * must be the first element of task_struct.
+	 */
+	struct thread_info thread_info;
+#endif
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	void *stack;
 	atomic_t usage;
@@ -1398,6 +1405,9 @@ struct task_struct {
 #ifdef CONFIG_SMP
 	struct llist_node wake_entry;
 	int on_cpu;
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+	unsigned int cpu;	/* current CPU */
+#endif
 	unsigned int wakee_flips;
 	unsigned long wakee_flip_decay_ts;
 	struct task_struct *last_wakee;
@@ -2440,7 +2450,9 @@ extern void set_curr_task(int cpu, struct task_struct *p);
 void yield(void);
 
 union thread_union {
+#ifndef CONFIG_THREAD_INFO_IN_TASK
 	struct thread_info thread_info;
+#endif
 	unsigned long stack[THREAD_SIZE/sizeof(long)];
 };
 
@@ -2840,10 +2852,26 @@ static inline void threadgroup_change_end(struct task_struct *tsk)
 	cgroup_threadgroup_change_end(tsk);
 }
 
-#ifndef __HAVE_THREAD_FUNCTIONS
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+
+static inline struct thread_info *task_thread_info(struct task_struct *task)
+{
+	return &task->thread_info;
+}
+static inline void *task_stack_page(const struct task_struct *task)
+{
+	return task->stack;
+}
+#define setup_thread_stack(new,old)	do { } while(0)
+static inline unsigned long *end_of_stack(const struct task_struct *task)
+{
+	return task->stack;
+}
+
+#elif !defined(__HAVE_THREAD_FUNCTIONS)
 
 #define task_thread_info(task)	((struct thread_info *)(task)->stack)
-#define task_stack_page(task)	((task)->stack)
+#define task_stack_page(task)	((void *)(task)->stack)
 
 static inline void setup_thread_stack(struct task_struct *p, struct task_struct *org)
 {
@@ -3135,7 +3163,11 @@ static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 
 static inline unsigned int task_cpu(const struct task_struct *p)
 {
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+	return p->cpu;
+#else
 	return task_thread_info(p)->cpu;
+#endif
 }
 
 static inline int task_node(const struct task_struct *p)
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 646891f3bc1e..2813de75a96e 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -13,6 +13,21 @@
 struct timespec;
 struct compat_timespec;
 
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+struct thread_info {
+	u32			flags;		/* low level flags */
+};
+
+#define INIT_THREAD_INFO(tsk)			\
+{						\
+	.flags		= 0,			\
+}
+#endif
+
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+#define current_thread_info() ((struct thread_info *)current)
+#endif
+
 /*
  * System call restart block.
  */
diff --git a/init/Kconfig b/init/Kconfig
index 47b0bdcf33c2..5dec7d424980 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -26,6 +26,13 @@ config IRQ_WORK
 config BUILDTIME_EXTABLE_SORT
 	bool
 
+config THREAD_INFO_IN_TASK
+	bool
+	help
+	  Select this to move thread_info off the stack into task_struct.  To
+	  make this work, an arch will need to remove all thread_info fields
+	  except flags and fix any runtime bugs.
+
 menu "General setup"
 
 config BROKEN
diff --git a/init/init_task.c b/init/init_task.c
index ba0a7f362d9e..11f83be1fa79 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -22,5 +22,8 @@ EXPORT_SYMBOL(init_task);
  * Initial thread structure. Alignment of this is handled by a special
  * linker map entry.
  */
-union thread_union init_thread_union __init_task_data =
-	{ INIT_THREAD_INFO(init_task) };
+union thread_union init_thread_union __init_task_data = {
+#ifndef CONFIG_THREAD_INFO_IN_TASK
+	INIT_THREAD_INFO(init_task)
+#endif
+};
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8b96df04ba78..8afd9d62c56e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -978,7 +978,11 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 	 * per-task data have been completed by this moment.
 	 */
 	smp_wmb();
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+	p->cpu = cpu;
+#else
 	task_thread_info(p)->cpu = cpu;
+#endif
 	p->wake_cpu = cpu;
 #endif
 }
-- 
2.17.2

