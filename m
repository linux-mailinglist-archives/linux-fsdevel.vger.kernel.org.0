Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 435ED7FAAF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 15:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393831AbfHBNWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 09:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732715AbfHBNWm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:22:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0DE20880;
        Fri,  2 Aug 2019 13:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752160;
        bh=rfK09QbE/ghQch875tQmpSh/nWp6HgepiByj61gmb+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgXKGyYgvaZy5j6GzDh/+HlQk3QLReSBn6Rz1K0eji9/f2027R4+xP+qb3kKhbvKZ
         gljhaISxFAZ4R40mzrSf2iXNWdWK3gRW4FCBOD/75vcnGP7MAo0c4m6qUPgW3jd2U/
         VmGm3lL0anZFWz+szynM8FSWtsaFRTwZQheGK/pc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 68/76] sched/fair: Don't free p->numa_faults with concurrent readers
Date:   Fri,  2 Aug 2019 09:19:42 -0400
Message-Id: <20190802131951.11600-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jann Horn <jannh@google.com>

[ Upstream commit 16d51a590a8ce3befb1308e0e7ab77f3b661af33 ]

When going through execve(), zero out the NUMA fault statistics instead of
freeing them.

During execve, the task is reachable through procfs and the scheduler. A
concurrent /proc/*/sched reader can read data from a freed ->numa_faults
allocation (confirmed by KASAN) and write it back to userspace.
I believe that it would also be possible for a use-after-free read to occur
through a race between a NUMA fault and execve(): task_numa_fault() can
lead to task_numa_compare(), which invokes task_weight() on the currently
running task of a different CPU.

Another way to fix this would be to make ->numa_faults RCU-managed or add
extra locking, but it seems easier to wipe the NUMA fault statistics on
execve.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Fixes: 82727018b0d3 ("sched/numa: Call task_numa_free() from do_execve()")
Link: https://lkml.kernel.org/r/20190716152047.14424-1-jannh@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c                            |  2 +-
 include/linux/sched/numa_balancing.h |  4 ++--
 kernel/fork.c                        |  2 +-
 kernel/sched/fair.c                  | 24 ++++++++++++++++++++----
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 89a500bb897a6..39902cc9eb6f4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1828,7 +1828,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	membarrier_execve(current);
 	rseq_execve(current);
 	acct_update_integrals(current);
-	task_numa_free(current);
+	task_numa_free(current, false);
 	free_bprm(bprm);
 	kfree(pathbuf);
 	if (filename)
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index e7dd04a84ba89..3988762efe15c 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -19,7 +19,7 @@
 extern void task_numa_fault(int last_node, int node, int pages, int flags);
 extern pid_t task_numa_group_id(struct task_struct *p);
 extern void set_numabalancing_state(bool enabled);
-extern void task_numa_free(struct task_struct *p);
+extern void task_numa_free(struct task_struct *p, bool final);
 extern bool should_numa_migrate_memory(struct task_struct *p, struct page *page,
 					int src_nid, int dst_cpu);
 #else
@@ -34,7 +34,7 @@ static inline pid_t task_numa_group_id(struct task_struct *p)
 static inline void set_numabalancing_state(bool enabled)
 {
 }
-static inline void task_numa_free(struct task_struct *p)
+static inline void task_numa_free(struct task_struct *p, bool final)
 {
 }
 static inline bool should_numa_migrate_memory(struct task_struct *p,
diff --git a/kernel/fork.c b/kernel/fork.c
index fe83343da24ba..d3f006ed2f9d5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -727,7 +727,7 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(tsk == current);
 
 	cgroup_free(tsk);
-	task_numa_free(tsk);
+	task_numa_free(tsk, true);
 	security_task_free(tsk);
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528a..8adf7b303d04d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2336,13 +2336,23 @@ no_join:
 	return;
 }
 
-void task_numa_free(struct task_struct *p)
+/*
+ * Get rid of NUMA staticstics associated with a task (either current or dead).
+ * If @final is set, the task is dead and has reached refcount zero, so we can
+ * safely free all relevant data structures. Otherwise, there might be
+ * concurrent reads from places like load balancing and procfs, and we should
+ * reset the data back to default state without freeing ->numa_faults.
+ */
+void task_numa_free(struct task_struct *p, bool final)
 {
 	struct numa_group *grp = p->numa_group;
-	void *numa_faults = p->numa_faults;
+	unsigned long *numa_faults = p->numa_faults;
 	unsigned long flags;
 	int i;
 
+	if (!numa_faults)
+		return;
+
 	if (grp) {
 		spin_lock_irqsave(&grp->lock, flags);
 		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
@@ -2355,8 +2365,14 @@ void task_numa_free(struct task_struct *p)
 		put_numa_group(grp);
 	}
 
-	p->numa_faults = NULL;
-	kfree(numa_faults);
+	if (final) {
+		p->numa_faults = NULL;
+		kfree(numa_faults);
+	} else {
+		p->total_numa_faults = 0;
+		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
+			numa_faults[i] = 0;
+	}
 }
 
 /*
-- 
2.20.1

