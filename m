Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAA3468F64
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 03:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhLFCtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Dec 2021 21:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbhLFCtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:49:24 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCEEC061354
        for <linux-fsdevel@vger.kernel.org>; Sun,  5 Dec 2021 18:45:55 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso7149481pjb.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Dec 2021 18:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rc/TsbWnd0eH/qb4JVzBc6sjmVgafYMjpP2Yzhzs994=;
        b=AZx9M2CcDIuwgCDoJNMyVhBkCE5hvOr4yG57oDF60uFMJjL3MCXkL4YRBoerR8mT9s
         Dtycd1DKtRlHqS+iT04dmO1PMJnfgQ3/8pEJXa/f0VT6M/LUF5p6YOH8qth//dRJSHst
         1HwE/1EwOJTAoY0m1+7H7PJl22jI0PeSR+EU3j3xKNV0mYBGOULI1NQQPALIJWsU60x9
         9Ls75hNsbtl+MsJc0QGyyDu7Ahn2m2Ha6IsmVJffO6ZHj2J3rBHWliKt1vzFusvEmZHf
         NzgKLlOMfoiLFxayd1ehqmnFKIMAnBJfR32ccoGGuPxEyxgKFWcXwe9HzMZZccLSaOkh
         GixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rc/TsbWnd0eH/qb4JVzBc6sjmVgafYMjpP2Yzhzs994=;
        b=OVlws8Y5Srf2oqPi63y3uUBM5ZLVlgaRVnIFsNscl0D3iTX8VQvXB4/YWX2+EhTuCO
         Oe9dJIgHAVxSieViAeVLQv8e8r+Q+2ZOjN00fi2yGE0kj3hH8cZSd1DcFoWsj8q6qWw2
         KO0mE8gASV+fOFl1JV8l645Kuh0rWMl/M8C4RuuE1rRzCSiALb8EmIZP2mA8Df4oxmSE
         OziOG3uzRv3+3WWKEBhVA3BTkQmkUFF9IRl5Mi2nxcNoKe2fjtEhBFR9aU1z0GxjQqDS
         EUSbR6L8ZJtfUQXpSt6/f6KCK4zbs8CZMUahgEdju6uQ+3qk2cY+3tZaB8jok+7jz6Iz
         VcMA==
X-Gm-Message-State: AOAM532M3MDUVIlN0TlPos7gptJ57aL9Fg2gX1U0Aii6zC2xmjZV6/NF
        kgsvvJWOH2IoKEeeLNNkxgTzjA==
X-Google-Smtp-Source: ABdhPJx/osn+ke9DUI89o2r1DwYWqj69Gnygrg4CjJI+5IbZVTkGraG+h3CGQqgQVhlK6sN7hk1JJQ==
X-Received: by 2002:a17:90a:3045:: with SMTP id q5mr33714094pjl.58.1638758755335;
        Sun, 05 Dec 2021 18:45:55 -0800 (PST)
Received: from C02FT5A6MD6R.tiktokd.org ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id a2sm8040722pgn.20.2021.12.05.18.45.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Dec 2021 18:45:54 -0800 (PST)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3] sched/numa: add per-process numa_balancing
Date:   Mon,  6 Dec 2021 10:45:28 +0800
Message-Id: <20211206024530.11336-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch add a new api PR_NUMA_BALANCING in prctl.

A large number of page faults will cause performance loss when numa
balancing is performing. Thus those processes which care about worst-case
performance need numa balancing disabled. Others, on the contrary, allow a
temporary performance loss in exchange for higher average performance, so
enable numa balancing is better for them.

Numa balancing can only be controlled globally by
/proc/sys/kernel/numa_balancing. Due to the above case, we want to
disable/enable numa_balancing per-process instead.

Add numa_balancing under mm_struct. Then use it in task_tick_fair.

Set per-process numa balancing:
	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DISABLE); //disable
	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_ENABLE);  //enable
	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DEFAULT); //follow global
Get numa_balancing state:
	prctl(PR_NUMA_BALANCING, PR_GET_NUMAB, &ret);
	cat /proc/<pid>/status | grep NumaB_enabled

Cc: linux-api@vger.kernel.org
Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---

Changes in v3:
- Fix compile error.

Changes in v2:
- Now PR_NUMA_BALANCING support three states: enabled, disabled, default.
  enabled and disabled will ignore global setting, and default will follow
  global setting.
---
 Documentation/filesystems/proc.rst   |  2 ++
 fs/proc/task_mmu.c                   | 19 +++++++++++++++
 include/linux/mm_types.h             |  3 +++
 include/linux/sched/numa_balancing.h |  6 +++++
 include/uapi/linux/prctl.h           |  7 ++++++
 kernel/fork.c                        |  3 +++
 kernel/sched/fair.c                  |  6 ++++-
 kernel/sys.c                         | 35 ++++++++++++++++++++++++++++
 8 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 061744c436d9..767e8d893fb5 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -192,6 +192,7 @@ read the file /proc/PID/status::
   VmLib:      1412 kB
   VmPTE:        20 kb
   VmSwap:        0 kB
+  NumaB_enabled:  default
   HugetlbPages:          0 kB
   CoreDumping:    0
   THP_enabled:	  1
@@ -273,6 +274,7 @@ It's slow but very precise.
  VmPTE                       size of page table entries
  VmSwap                      amount of swap used by anonymous private data
                              (shmem swap usage is not included)
+ NumaB_enabled               numa balancing state, set by prctl(PR_NUMA_BALANCING, ...)
  HugetlbPages                size of hugetlb memory portions
  CoreDumping                 process's memory is currently being dumped
                              (killing the process may lead to a corrupted core)
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e6998652fd67..c5bc00ab0460 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -19,6 +19,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
+#include <linux/sched/numa_balancing.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -75,6 +76,24 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 		    " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
 	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
 	seq_puts(m, " kB\n");
+#ifdef CONFIG_NUMA_BALANCING
+	seq_puts(m, "NumaB_enabled:\t");
+	switch (mm->numab_enabled) {
+	case NUMAB_DEFAULT:
+		seq_puts(m, "default");
+		break;
+	case NUMAB_DISABLED:
+		seq_puts(m, "disabled");
+		break;
+	case NUMAB_ENABLED:
+		seq_puts(m, "enabled");
+		break;
+	default:
+		seq_puts(m, "unknown");
+		break;
+	}
+	seq_putc(m, '\n');
+#endif
 	hugetlb_report_usage(m, mm);
 }
 #undef SEQ_PUT_DEC
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 850e71986b9d..96607e43e00f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -638,6 +638,9 @@ struct mm_struct {
 
 		/* numa_scan_seq prevents two threads setting pte_numa */
 		int numa_scan_seq;
+
+		/* Controls whether NUMA balancing is active for this mm. */
+		int numab_enabled;
 #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 3988762efe15..35a1c79925ea 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -16,6 +16,12 @@
 #define TNF_MIGRATE_FAIL 0x10
 
 #ifdef CONFIG_NUMA_BALANCING
+enum {
+	NUMAB_DISABLED,
+	NUMAB_ENABLED,
+	NUMAB_DEFAULT
+};
+DECLARE_STATIC_KEY_FALSE(sched_numa_balancing);
 extern void task_numa_fault(int last_node, int node, int pages, int flags);
 extern pid_t task_numa_group_id(struct task_struct *p);
 extern void set_numabalancing_state(bool enabled);
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index e998764f0262..d120cdde5d27 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -275,4 +275,11 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
+/* Set/get enabled per-process numa_balancing */
+#define PR_NUMA_BALANCING		63
+# define PR_SET_NUMAB_DISABLED		NUMAB_DISABLED
+# define PR_SET_NUMAB_ENABLED		NUMAB_ENABLED
+# define PR_SET_NUMAB_DEFAULT		NUMAB_DEFAULT
+# define PR_GET_NUMAB			3
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 7c06be0ca31b..5d4f876b588b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1061,6 +1061,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	init_tlb_flush_pending(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	mm->pmd_huge_pte = NULL;
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	mm->numab_enabled = NUMAB_DEFAULT;
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 884f29d07963..2980f33ac61f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11169,8 +11169,12 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
 
-	if (static_branch_unlikely(&sched_numa_balancing))
+#ifdef CONFIG_NUMA_BALANCING
+	if (curr->mm && (curr->mm->numab_enabled == NUMAB_ENABLED
+	    || (static_branch_unlikely(&sched_numa_balancing)
+	    && curr->mm->numab_enabled == NUMAB_DEFAULT)))
 		task_tick_numa(rq, curr);
+#endif
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
diff --git a/kernel/sys.c b/kernel/sys.c
index 2450a9f33cb0..4a5a2bd57248 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -58,6 +58,7 @@
 #include <linux/sched/coredump.h>
 #include <linux/sched/task.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/numa_balancing.h>
 #include <linux/rcupdate.h>
 #include <linux/uidgid.h>
 #include <linux/cred.h>
@@ -2081,6 +2082,23 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
 	return 0;
 }
 
+#ifdef CONFIG_NUMA_BALANCING
+static int prctl_pid_numa_balancing_write(int numa_balancing)
+{
+	if (numa_balancing != PR_SET_NUMAB_DEFAULT
+	    && numa_balancing != PR_SET_NUMAB_DISABLED
+	    && numa_balancing != PR_SET_NUMAB_ENABLED)
+		return -EINVAL;
+	current->mm->numab_enabled = numa_balancing;
+	return 0;
+}
+
+static int prctl_pid_numa_balancing_read(void)
+{
+	return current->mm->numab_enabled;
+}
+#endif
+
 static int prctl_set_mm(int opt, unsigned long addr,
 			unsigned long arg4, unsigned long arg5)
 {
@@ -2585,6 +2603,23 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = set_syscall_user_dispatch(arg2, arg3, arg4,
 						  (char __user *) arg5);
 		break;
+#ifdef CONFIG_NUMA_BALANCING
+	case PR_NUMA_BALANCING:
+		switch (arg2) {
+		case PR_SET_NUMAB_DEFAULT:
+		case PR_SET_NUMAB_DISABLED:
+		case PR_SET_NUMAB_ENABLED:
+			error = prctl_pid_numa_balancing_write((int)arg2);
+			break;
+		case PR_GET_NUMAB:
+			error = put_user(prctl_pid_numa_balancing_read(), (int __user *)arg3);
+			break;
+		default:
+			error = -EINVAL;
+			break;
+		}
+		break;
+#endif
 #ifdef CONFIG_SCHED_CORE
 	case PR_SCHED_CORE:
 		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
-- 
2.20.1

