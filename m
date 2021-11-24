Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2F045B66C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 09:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhKXI1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 03:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhKXI1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:27:11 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A1C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 00:24:02 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b68so1914039pfg.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 00:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pd3L21t6usac8YG8wguBE1VQxDXVkFkmT941urDOFp8=;
        b=tRIxyRrfzpI8BTRuJHrhMEOxfaPvKyNq93QubZbckg1DxYITjGsJXf4kavDhoRKB4x
         yxxoKrzE2uet5L+cQjClIhr+Wt9CyWur+EOKDYvSTYF5cIndCPF6s7VzdQvWbuqGnbmf
         z6lJn9CyuFQJLYBrI3xJ2NBrb18FM+Q61q/kEJn/JxlmZ0DhaeWENmt4q3a23EtMWgub
         LdasYZtUFlR8Pu2XSk5V4XOWFJFq0Ma0B2Z/ZgnfIs1hQLOMMYTAQ0vNFk3im9iaO3qs
         5EDB8Ez0r82Od1ye+CAYrrck7MOJBex592tD+61243ypU/z0drh4SGlr2JN0qHwJiakf
         A3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pd3L21t6usac8YG8wguBE1VQxDXVkFkmT941urDOFp8=;
        b=oQfvIou9pkvAv93uG8c/OIgUgj6iWzdixu+D7tG2FmuneOBru/bzT+5AYHOBXjt/6T
         TS3Xrb5cIx7i9PxG2InB2OBWu1MbucpFLe+8wsjpIICrjQNPeRo5Id1fnnUQGmRilZDa
         m/rMZCVqGQ8313qKK22F+FoawLyPRe7qO9DjncFQgnuaJHgpvdsov1XzB1mfRpuLScfe
         i84psVopKG5snnchBmn+TsxP8KuoMNvKvzaYHQ7ZfhZ2aOZv3aTAco/1v/T+Z/a5Ska8
         tTbr2Fi00chTBZKTXC7yQ63cKDjjaGNDLvzj6M42nTK3Y5rLiXrNtfQOBFoMmJT3ohw1
         mTxg==
X-Gm-Message-State: AOAM5316WnI1E0rkGNR0hGi2aSPm3WG1d6R5fVcuVk/6lcfsdy+7L8tZ
        gW2Ih/khdyPob074ykQ1AqLVHQ==
X-Google-Smtp-Source: ABdhPJw7voXYhhphMNoIJU87/mjv7I3/1hmR/2Fhbil59GV9ksDucs9L8fJsUSvFuaEfa5i/Akr4SA==
X-Received: by 2002:a63:2255:: with SMTP id t21mr9091123pgm.186.1637742242076;
        Wed, 24 Nov 2021 00:24:02 -0800 (PST)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id k18sm10615228pfc.155.2021.11.24.00.23.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Nov 2021 00:24:00 -0800 (PST)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2] sched/numa: add per-process numa_balancing
Date:   Wed, 24 Nov 2021 16:23:38 +0800
Message-Id: <20211124082340.5496-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch add a new api PR_NUMA_BALANCING in prctl.

A large number of page faults will cause performance loss when numa balancing
is performing. Thus those processes which care about worst-case performance
need numa balancing disabled. Others, on the contrary, allow a temporary
performance loss in exchange for higher average performance, so enable numa
balancing is better for them.

Numa balancing can only be controlled globally by /proc/sys/kernel/numa_balancing.
Due to the above case, we want to disable/enable numa_balancing per-process
instead.

Add numa_balancing under mm_struct. Then use it in task_tick_numa.

Set per-process numa balancing:
	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DISABLE); //disable
	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_ENABLE);  //enable
	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DEFAULT); //follow global
Get numa_balancing state:
	prctl(PR_NUMA_BALANCING, PR_GET_NUMAB, &ret);
	cat /proc/<pid>/status | grep NumaB_enabled

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 Documentation/filesystems/proc.rst   |  2 ++
 fs/proc/task_mmu.c                   | 25 ++++++++++++++++++++
 include/linux/mm_types.h             |  3 +++
 include/linux/sched/numa_balancing.h |  6 +++++
 include/uapi/linux/prctl.h           |  7 ++++++
 kernel/fork.c                        |  3 +++
 kernel/sched/fair.c                  |  6 +++--
 kernel/sys.c                         | 35 ++++++++++++++++++++++++++++
 8 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 8d7f141c6fc7..fc44723a821a 100644
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
index ad667dbc96f5..5f340f1c926e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -19,6 +19,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
+#include <linux/sched/numa_balancing.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -31,10 +32,16 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 {
 	unsigned long text, lib, swap, anon, file, shmem;
 	unsigned long hiwater_vm, total_vm, hiwater_rss, total_rss;
+#ifdef CONFIG_NUMA_BALANCING
+	int numab_enabled;
+#endif
 
 	anon = get_mm_counter(mm, MM_ANONPAGES);
 	file = get_mm_counter(mm, MM_FILEPAGES);
 	shmem = get_mm_counter(mm, MM_SHMEMPAGES);
+#ifdef CONFIG_NUMA_BALANCING
+	numab_enabled = mm->numab_enabled;
+#endif
 
 	/*
 	 * Note: to minimize their overhead, mm maintains hiwater_vm and
@@ -75,6 +82,24 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
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
index bb8c6f5f19bc..3f827b3c0e75 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -612,6 +612,9 @@ struct mm_struct {
 
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
index bb73e9a0b24f..525f174a56f5 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -272,4 +272,11 @@ struct prctl_mm_map {
 # define PR_SCHED_CORE_SCOPE_THREAD_GROUP	1
 # define PR_SCHED_CORE_SCOPE_PROCESS_GROUP	2
 
+/* Set/get enabled per-process numa_balancing */
+#define PR_NUMA_BALANCING		63
+# define PR_SET_NUMAB_DISABLED		NUMAB_DISABLED
+# define PR_SET_NUMAB_ENABLED		NUMAB_ENABLED
+# define PR_SET_NUMAB_DEFAULT		NUMAB_DEFAULT
+# define PR_GET_NUMAB				3
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 01af6129aa38..d028822d551f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1110,6 +1110,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
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
index 6e476f6d9435..1245be1223c8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11169,8 +11169,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
 
-	if (static_branch_unlikely(&sched_numa_balancing))
-		task_tick_numa(rq, curr);
+	if (curr->mm && (curr->mm->numab_enabled == NUMAB_ENABLED \
+	    || (static_branch_unlikely(&sched_numa_balancing) \
+	    && curr->mm->numab_enabled == NUMAB_DEFAULT)))
+	    task_tick_numa(rq, curr);
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
diff --git a/kernel/sys.c b/kernel/sys.c
index 8fdac0d90504..de3112e537b8 100644
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
+	if (numa_balancing != PR_SET_NUMAB_DEFAULT \
+	    && numa_balancing != PR_SET_NUMAB_DISABLED \
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
@@ -2525,6 +2543,23 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
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

