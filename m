Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999D75EEE00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 08:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiI2GoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 02:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiI2GoP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:44:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A50912AEDD
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 23:44:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l9-20020a17090a4d4900b00205e295400eso462091pjh.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 23:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/vsjYa0mVNB7hxEqcjh0e4fbj05c2V9q8r7ZQBxHpwM=;
        b=taHM9fC3gawTMyKIp0dRgyeOgWlcE3tG7aO5KuMpgrd/uifguoPvOh9Ucdgdqupqe9
         MTf9Es0cSWLJkL/G7L8vzaGpbwLXy6XHr6hGfD7pb4Y8PpSDARZcaVzh6dBhHP6NKtxn
         eMHmQfoieDk+D2oS/owzPEqVgKnySxeztRglMXlm/ICt+QYTe34qqxVTqBP5Fl/7sWYL
         JMB5nhFD2HCwOd2z7CF1zIa8MdvhH7u0s0YP8JKCW7TPNeKBIbE5pw3o5fBbaCUa/jl5
         9bOvj5cuzbPZtT7plPkrMi/MeZCMBoKpM0/J1JH6VfbDnncbJFmjFv7wSyiSxonKcWjb
         5e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/vsjYa0mVNB7hxEqcjh0e4fbj05c2V9q8r7ZQBxHpwM=;
        b=q9dQArtoq8j/xUQEmb7r/TWXZgsKmTQ4gHb+okZCBu1ZnQERci9mGcRflx7oQOSIoR
         vN8TyfnNtrA2imJD3VzHmkZA5hhY/lyurbSS0I6eebpAe4sC/sauHF2uzpAL1MDxpPjX
         r2uOvDxSzrAyPJr24GwtZYDwf3noSyI/ruKsDmxOo9vACzXuoP2MJIhsEeEn1UxAJlIw
         p6q6a515NrA5NZx8/Vp6+/aJjjX3G3Y2Ijt00lYVwi9AqykJiSIlGqaajflpo9ExzPSf
         ss1RhnvkzBncdZPxJkFHSgAQJqeXr86QY/XhMsASClYTVoaTSXCGOJWMZjygMZEcmYxd
         N86Q==
X-Gm-Message-State: ACrzQf1MlAvjYtRAgeXQfP1DL1s12XumFqZCTHwLFppGAfYQeQDdxQLf
        v96rj5sI5DuYNpm8n2ThAbD1ww==
X-Google-Smtp-Source: AMsMyM7YBWdfkzRoRE4S/zqUvt7CLV44mC0samCAKxwGxcYZXq+hTWVlsCY1bMdyEMHyAcWmuIsi+w==
X-Received: by 2002:a17:902:6943:b0:178:4751:a76b with SMTP id k3-20020a170902694300b001784751a76bmr1869132plt.37.1664433851784;
        Wed, 28 Sep 2022 23:44:11 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902ea1200b00172fad607b3sm5089387plg.207.2022.09.28.23.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 23:44:11 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4] sched/numa: add per-process numa_balancing
Date:   Thu, 29 Sep 2022 14:43:58 +0800
Message-Id: <20220929064359.46932-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Changes in v4:
- code clean: add wrapper function `numa_balancing_enabled`

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
 include/linux/sched/numa_balancing.h |  8 +++++++
 include/uapi/linux/prctl.h           |  7 ++++++
 kernel/fork.c                        |  3 +++
 kernel/sched/core.c                  | 15 ++++++++++++
 kernel/sched/fair.c                  | 32 ++++++++++++++++++++-----
 kernel/sys.c                         | 35 ++++++++++++++++++++++++++++
 9 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index e7aafc82be99..b2ddffad015f 100644
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
index 8b4f3073f8f5..7358a5932e5a 100644
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
index 500e536796ca..d9bfa740d905 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -665,6 +665,9 @@ struct mm_struct {
 
 		/* numa_scan_seq prevents two threads remapping PTEs. */
 		int numa_scan_seq;
+
+		/* Controls whether NUMA balancing is active for this mm. */
+		int numab_enabled;
 #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 3988762efe15..f4a4cdf264bc 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -16,12 +16,20 @@
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
 extern void task_numa_free(struct task_struct *p, bool final);
 extern bool should_numa_migrate_memory(struct task_struct *p, struct page *page,
 					int src_nid, int dst_cpu);
+extern bool numa_balancing_enabled(struct task_struct *p);
+extern int numa_balancing_mode(struct mm_struct *mm);
 #else
 static inline void task_numa_fault(int last_node, int node, int pages,
 				   int flags)
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a5e06dcbba13..4c57724b04c3 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -284,4 +284,11 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
+/* Set/get enabled per-process numa_balancing */
+#define PR_NUMA_BALANCING		65
+# define PR_SET_NUMAB_DISABLED		NUMAB_DISABLED
+# define PR_SET_NUMAB_ENABLED		NUMAB_ENABLED
+# define PR_SET_NUMAB_DEFAULT		NUMAB_DEFAULT
+# define PR_GET_NUMAB			3
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 844dfdc8c639..1b9254315770 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1133,6 +1133,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	init_tlb_flush_pending(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	mm->pmd_huge_pte = NULL;
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	mm->numab_enabled = NUMAB_DEFAULT;
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a77e8bfbfb5b..12d171978538 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4396,6 +4396,21 @@ void set_numabalancing_state(bool enabled)
 	__set_numabalancing_state(enabled);
 }
 
+inline int numa_balancing_mode(struct mm_struct *mm)
+{
+	int numab = mm->numab_enabled;
+
+	switch (numab) {
+	case NUMAB_ENABLED:
+		return NUMA_BALANCING_NORMAL;
+	case NUMAB_DISABLED:
+		return NUMA_BALANCING_DISABLED;
+	case NUMAB_DEFAULT:
+	default:
+		return sysctl_numa_balancing_mode;
+	}
+}
+
 #ifdef CONFIG_PROC_SYSCTL
 static void reset_memory_tiering(void)
 {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ef0e6b3e08ff..87215b3776c9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2818,6 +2818,24 @@ void task_numa_free(struct task_struct *p, bool final)
 	}
 }
 
+inline bool numa_balancing_enabled(struct task_struct *p)
+{
+	if (p->mm) {
+		int numab = p->mm->numab_enabled;
+
+		switch (numab) {
+		case NUMAB_ENABLED:
+			return true;
+		case NUMAB_DISABLED:
+			return false;
+		case NUMAB_DEFAULT:
+			break;
+		}
+	}
+
+	return static_branch_unlikely(&sched_numa_balancing);
+}
+
 /*
  * Got a PROT_NONE fault for a page on @node.
  */
@@ -2830,13 +2848,13 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	struct numa_group *ng;
 	int priv;
 
-	if (!static_branch_likely(&sched_numa_balancing))
-		return;
-
 	/* for example, ksmd faulting in a user's mm */
 	if (!p->mm)
 		return;
 
+	if (!numa_balancing_enabled(p))
+		return;
+
 	/*
 	 * NUMA faults statistics are unnecessary for the slow memory
 	 * node for memory tiering mode.
@@ -3151,7 +3169,7 @@ static void update_scan_period(struct task_struct *p, int new_cpu)
 	int src_nid = cpu_to_node(task_cpu(p));
 	int dst_nid = cpu_to_node(new_cpu);
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!numa_balancing_enabled(p))
 		return;
 
 	if (!p->mm || !p->numa_faults || (p->flags & PF_EXITING))
@@ -7996,7 +8014,7 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 	unsigned long src_weight, dst_weight;
 	int src_nid, dst_nid, dist;
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!numa_balancing_enabled(p))
 		return -1;
 
 	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
@@ -11581,8 +11599,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
 
-	if (static_branch_unlikely(&sched_numa_balancing))
+#ifdef CONFIG_NUMA_BALANCING
+	if (numa_balancing_enabled(curr))
 		task_tick_numa(rq, curr);
+#endif
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
diff --git a/kernel/sys.c b/kernel/sys.c
index 8a6432465dc5..11720a35455a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -59,6 +59,7 @@
 #include <linux/sched/coredump.h>
 #include <linux/sched/task.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/numa_balancing.h>
 #include <linux/rcupdate.h>
 #include <linux/uidgid.h>
 #include <linux/cred.h>
@@ -2101,6 +2102,23 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
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
@@ -2615,6 +2633,23 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
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

