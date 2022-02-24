Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371B94C24C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 08:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiBXHxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 02:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiBXHxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 02:53:11 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4736C192E39
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 23:52:41 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 195so1087485pgc.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 23:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJyuo8HW0lgEwQiaSel5I2dm34XpPXh2hRkNyXXESgk=;
        b=1+Al6T7d8JaIDCsSMmZoAtJwuloPstMDy7VUT2a1ijuiOAp+mK3KPuYJPIrQogNe5E
         tnqY1bWMAMN0FQ/U01Ta/EJbWnC8xYGp9e2yb+QgC1bGuH/BweVUJUz0ZDZTn8HznZey
         /FisA4GbvwOBE7yXGO5a0z6tuhrFwgULI4pjYxmwU8HnQBX+a8IHrAATTu0lLVnUnOXx
         jpvsmWAQGE7mBHUOXXq0vBckSSwV0I/siStfSVuS40Ev2dEwOOl51q08Q7DklfXbbWY6
         Tk+eWh39vwUTJA8FaNJtTWm1dxfpg1ABniXjWFDBLSUwpQdLIdHy8AxIFR6V//49wk27
         p4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJyuo8HW0lgEwQiaSel5I2dm34XpPXh2hRkNyXXESgk=;
        b=S/wEyOx7VrtVmNxisNlpg3LsAZdlAD+2mBETaUBtSuU2hLROF66LR/KkoDt3/n3CZk
         PsUKHFZs+BxQ6YaXi20dn2EyEKEMouEobMQLR1P5qlw+znJP+pnx6wLXnLZ43sU9Dkn1
         601AVg5PDWP/xLgF1FakudIMk+vJmu+mXDWLKJDZb2vab57iOHyRHLQ6MmwaXA437kcG
         h8Yt/ZEGA69cpm+ePCW+Hugz7YWiBfDkiI9LCUIV8vwbnz+fPkoCNl6yYJhkBdd1mQ/N
         2lM9+J3faBsxPamkQr+InPPxvgdNXQc+FB8Vupr/gXPhuv4aD17Wp2IOOgWEUpqdXqaW
         7aMg==
X-Gm-Message-State: AOAM532r6kO+nXOGJ1CdVD/gtWiorjPnK+KPdX29FWkoCgUOI7sKsepV
        Rk7BI1DHSPn8m34tYQnzxj9HzQ==
X-Google-Smtp-Source: ABdhPJxYRU8+dpxknEz41BQHzlG1JTyRKzw8MJMPIV02iy2tOa7mG2eF9X+xwSDvPyIotLAHoaRNQg==
X-Received: by 2002:a05:6a00:2296:b0:4e1:3029:ee2 with SMTP id f22-20020a056a00229600b004e130290ee2mr1434080pfe.22.1645689160684;
        Wed, 23 Feb 2022 23:52:40 -0800 (PST)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id t9sm1752969pgp.5.2022.02.23.23.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 23:52:39 -0800 (PST)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     songmuchun@bytedance.com, zhengqi.arch@bytedance.com,
        Gang Li <ligang.bdlg@bytedance.com>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] sched/numa: add per-process numa_balancing
Date:   Thu, 24 Feb 2022 15:52:25 +0800
Message-Id: <20220224075227.27127-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch add a new api PR_PROCESS_NUMAB in prctl.

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
	prctl(PR_PROCESS_NUMAB, PR_SET_PROCESS_NUMAB_DISABLED);
	prctl(PR_PROCESS_NUMAB, PR_SET_PROCESS_NUMAB_ENABLED);
	prctl(PR_PROCESS_NUMAB, PR_SET_PROCESS_NUMAB_DEFAULT);
Get numa_balancing state:
	prctl(PR_PROCESS_NUMAB, PR_GET_PROCESS_NUMAB, &ret);
	cat /proc/<pid>/status | grep NumaB_enabled

Cc: linux-api@vger.kernel.org
Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---

Changes in v4:
- Adaptation of new feature: optimize page placement for memory tiering system.
  https://lore.kernel.org/all/20220128082751.593478-3-ying.huang@intel.com/
- warp sched_numa_balancing and mm->numab_enabled with process_sched_numab_enabled().

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
 include/linux/sched/sysctl.h         | 19 +++++++++++++++
 include/uapi/linux/prctl.h           |  7 ++++++
 kernel/fork.c                        |  3 +++
 kernel/sched/fair.c                  | 34 ++++++++++++++++++++++-----
 kernel/sys.c                         | 35 ++++++++++++++++++++++++++++
 mm/huge_memory.c                     |  2 +-
 mm/mprotect.c                        |  6 ++---
 11 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 061744c436d9..00f6503f0793 100644
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
+ NumaB_enabled               numa balancing state, set by prctl(PR_PROCESS_NUMAB, ...)
  HugetlbPages                size of hugetlb memory portions
  CoreDumping                 process's memory is currently being dumped
                              (killing the process may lead to a corrupted core)
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6e97ed775074..b1aa100b8711 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -20,6 +20,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
+#include <linux/sched/numa_balancing.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -76,6 +77,24 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 		    " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
 	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
 	seq_puts(m, " kB\n");
+#ifdef CONFIG_NUMA_BALANCING
+	seq_puts(m, "NumaB_enabled:\t");
+	switch (mm->numab_enabled) {
+	case PROCESS_NUMAB_DEFAULT:
+		seq_puts(m, "default");
+		break;
+	case PROCESS_NUMAB_DISABLED:
+		seq_puts(m, "disabled");
+		break;
+	case PROCESS_NUMAB_ENABLED:
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
index 9f05ffa12265..5a42aba3b17f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -626,6 +626,9 @@ struct mm_struct {
 
 		/* numa_scan_seq prevents two threads setting pte_numa */
 		int numa_scan_seq;
+
+		/* Controls whether NUMA balancing is active for this mm. */
+		int numab_enabled;
 #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 3988762efe15..c7dc08d6ba6a 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -16,6 +16,12 @@
 #define TNF_MIGRATE_FAIL 0x10
 
 #ifdef CONFIG_NUMA_BALANCING
+enum {
+	PROCESS_NUMAB_DISABLED,
+	PROCESS_NUMAB_ENABLED,
+	PROCESS_NUMAB_DEFAULT
+};
+DECLARE_STATIC_KEY_FALSE(sched_numa_balancing);
 extern void task_numa_fault(int last_node, int node, int pages, int flags);
 extern pid_t task_numa_group_id(struct task_struct *p);
 extern void set_numabalancing_state(bool enabled);
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index c1076b5e17fb..77d010942481 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -3,6 +3,7 @@
 #define _LINUX_SCHED_SYSCTL_H
 
 #include <linux/types.h>
+#include <linux/sched/numa_balancing.h>
 
 struct ctl_table;
 
@@ -29,8 +30,26 @@ enum sched_tunable_scaling {
 
 #ifdef CONFIG_NUMA_BALANCING
 extern int sysctl_numa_balancing_mode;
+static inline int process_sysctl_numab_mode(struct mm_struct *mm)
+{
+	int numab = mm->numab_enabled;
+
+	switch (numab) {
+	case PROCESS_NUMAB_ENABLED:
+		return NUMA_BALANCING_NORMAL;
+	case PROCESS_NUMAB_DISABLED:
+		return NUMA_BALANCING_DISABLED;
+	case PROCESS_NUMAB_DEFAULT:
+	default:
+		return sysctl_numa_balancing_mode;
+	}
+}
 #else
 #define sysctl_numa_balancing_mode	0
+static inline int process_sysctl_numab_mode(struct mm_struct *mm)
+{
+	return NUMA_BALANCING_DISABLED;
+}
 #endif
 
 /*
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index e998764f0262..d06a904c35c1 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -275,4 +275,11 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
+/* Set/get enabled per-process numa_balancing */
+#define PR_PROCESS_NUMAB		63
+# define PR_SET_PROCESS_NUMAB_DISABLED	PROCESS_NUMAB_DISABLED
+# define PR_SET_PROCESS_NUMAB_ENABLED	PROCESS_NUMAB_ENABLED
+# define PR_SET_PROCESS_NUMAB_DEFAULT	PROCESS_NUMAB_DEFAULT
+# define PR_GET_PROCESS_NUMAB		3
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 64dbfb9426fd..2f93b240ebab 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1059,6 +1059,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	init_tlb_flush_pending(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	mm->pmd_huge_pte = NULL;
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	mm->numab_enabled = PROCESS_NUMAB_DEFAULT;
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 28b91f11b618..7ff5831c5b33 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2575,6 +2575,23 @@ void task_numa_free(struct task_struct *p, bool final)
 	}
 }
 
+static inline bool process_sched_numab_enabled(struct task_struct *p)
+{
+	if (p->mm) {
+		int numab = p->mm->numab_enabled;
+
+		switch (numab) {
+		case PROCESS_NUMAB_ENABLED:
+			return true;
+		case PROCESS_NUMAB_DISABLED:
+			return false;
+		case PROCESS_NUMAB_DEFAULT:
+			break;
+		}
+	}
+	return static_branch_unlikely(&sched_numa_balancing);
+}
+
 /*
  * Got a PROT_NONE fault for a page on @node.
  */
@@ -2587,13 +2604,13 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	struct numa_group *ng;
 	int priv;
 
-	if (!static_branch_likely(&sched_numa_balancing))
-		return;
-
 	/* for example, ksmd faulting in a user's mm */
 	if (!p->mm)
 		return;
 
+	if (!process_sched_numab_enabled(p))
+		return;
+
 	/* Allocate buffer to track faults on a per-node basis */
 	if (unlikely(!p->numa_faults)) {
 		int size = sizeof(*p->numa_faults) *
@@ -2894,7 +2911,7 @@ static void update_scan_period(struct task_struct *p, int new_cpu)
 	int src_nid = cpu_to_node(task_cpu(p));
 	int dst_nid = cpu_to_node(new_cpu);
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!process_sched_numab_enabled(p))
 		return;
 
 	if (!p->mm || !p->numa_faults || (p->flags & PF_EXITING))
@@ -2928,6 +2945,11 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 {
 }
 
+static inline bool process_sched_numab_enabled(struct task_struct *p)
+{
+	return false;
+}
+
 static inline void account_numa_enqueue(struct rq *rq, struct task_struct *p)
 {
 }
@@ -7687,7 +7709,7 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 	unsigned long src_weight, dst_weight;
 	int src_nid, dst_nid, dist;
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!process_sched_numab_enabled(p))
 		return -1;
 
 	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
@@ -11164,7 +11186,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
 
-	if (static_branch_unlikely(&sched_numa_balancing))
+	if (process_sched_numab_enabled(curr))
 		task_tick_numa(rq, curr);
 
 	update_misfit_status(curr, rq);
diff --git a/kernel/sys.c b/kernel/sys.c
index ecc4cf019242..04cb73e39926 100644
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
+	if (numa_balancing != PR_SET_PROCESS_NUMAB_DEFAULT
+	    && numa_balancing != PR_SET_PROCESS_NUMAB_DISABLED
+	    && numa_balancing != PR_SET_PROCESS_NUMAB_ENABLED)
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
+	case PR_PROCESS_NUMAB:
+		switch (arg2) {
+		case PR_SET_PROCESS_NUMAB_DEFAULT:
+		case PR_SET_PROCESS_NUMAB_DISABLED:
+		case PR_SET_PROCESS_NUMAB_ENABLED:
+			error = prctl_pid_numa_balancing_write((int)arg2);
+			break;
+		case PR_GET_PROCESS_NUMAB:
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
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 09fb65a80e63..25a660065af1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1760,7 +1760,7 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		 * Skip scanning top tier node if normal numa
 		 * balancing is disabled
 		 */
-		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
+		if (!(process_sysctl_numab_mode(vma->vm_mm) & NUMA_BALANCING_NORMAL) &&
 		    node_is_toptier(page_to_nid(page)))
 			goto unlock;
 	}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 2fe03e695c81..2ae0127f46e8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -33,7 +33,7 @@
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
-
+#include <linux/sched/numa_balancing.h>
 #include "internal.h"
 
 static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
@@ -119,8 +119,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				 * Skip scanning top tier node if normal numa
 				 * balancing is disabled
 				 */
-				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
-				    node_is_toptier(nid))
+				if (!(process_sysctl_numab_mode(vma->vm_mm) & NUMA_BALANCING_NORMAL)
+				    && node_is_toptier(nid))
 					continue;
 			}
 
-- 
2.20.1

