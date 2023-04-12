Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88BD6DF815
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 16:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjDLOMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 10:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDLOMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:12:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C497DAF
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 07:11:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 21so3339131plg.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681308698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npZ8ffD8wKTQ6zXucxsr5OS3bboBiNDxBArrHYUiGoU=;
        b=RW7pyXIt0im4b2HqCafISgOSxeRW7KVI5ofazRV6UU+HgC/4UjmrrMphk7LM3ZnHKJ
         HMlf/2W7XVNX8xb7AK5U7X3HBb2FAsHI3zx1e3jxdivf4yOOtJYEglEwQcxfjT3b/Iic
         q/F422Wr+buwulz/CiF/ojo3L/d+AtxLVKO5MY579wUXATlAfEx8U1lScrVXciC0g+yr
         dLjWXZRqx/Yjd7Sj6KKcgQzNaPEgp9Um+0rlZ+Czw6/HiAhRcOklj98r/Y1vPRCCgFQ4
         75RNsqY9Dq8vSXZpukZ02bQqmqFCTrYXYEyBv9I3ZGf6maL2rUXoRFaCc3jDNlloQFja
         ePrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681308698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npZ8ffD8wKTQ6zXucxsr5OS3bboBiNDxBArrHYUiGoU=;
        b=2pdMf3Dhs8F7JcFhuJJ5Y39nTeUsEgD7FTCD6UwPueDhb0niuAL66WEc11gw0yUXrj
         P0TOVoWAICZDAit/Olk1jcWqQ5Y6J4ytuos8GmJESAyEsCIzFUiGhh2cKieRLxxy+Sti
         Un3f9YZtfsh9SvmxDMf6F7Oe+2PNWqsr/yXZRJKlev/f1jYfgwBljg80jSCrgN13HgBU
         w1GVF+p60hlOK93Dvdkar41K6dOmzCsyi3wbdpjbAR+K00KpaVR2CmOASUW0vXUcywSM
         lL9iX/KVo2GocSDn1ZHe+ziKG9UDX+55iM69xpICwpEMdOEBlRf6g+9DpdiM0YWc9Kvi
         CFDA==
X-Gm-Message-State: AAQBX9fKb/MU/YMrYgifzkrVCZLg/f6UmCPZwy2z1gZB/n2PsIYEtGSK
        EpHKwfmx0Or1GdZe61d569PRwg==
X-Google-Smtp-Source: AKy350YoCuaHsQdUX61YuKJKuz0LvXJlj/9npXvh+AVr5RsZIgeS2ij1dakxBeFkOvAWI5H/R3dmfQ==
X-Received: by 2002:a17:902:e5d1:b0:19d:1d32:fc7 with SMTP id u17-20020a170902e5d100b0019d1d320fc7mr8089583plf.51.1681308698215;
        Wed, 12 Apr 2023 07:11:38 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b00194caf3e975sm11653502plg.208.2023.04.12.07.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:11:37 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH v6 2/2] sched/numa: add per-process numa_balancing
Date:   Wed, 12 Apr 2023 22:11:26 +0800
Message-Id: <20230412141127.59741-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230412140701.58337-1-ligang.bdlg@bytedance.com>
References: <20230412140701.58337-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add PR_NUMA_BALANCING in prctl.

A large number of page faults will cause performance loss when numa
balancing is performing. Thus those processes which care about worst-case
performance need numa balancing disabled. Others, on the contrary, allow a
temporary performance loss in exchange for higher average performance, so
enable numa balancing is better for them.

Numa balancing can only be controlled globally by
/proc/sys/kernel/numa_balancing. Due to the above case, we want to
disable/enable numa_balancing per-process instead.

Set per-process numa balancing:
	prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING_DISABLE); //disable
	prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING_ENABLE);  //enable
	prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING_DEFAULT); //follow global
Get numa_balancing state:
	prctl(PR_NUMA_BALANCING, PR_GET_NUMA_BALANCING, &ret);
	cat /proc/<pid>/status | grep NumaB_mode

Cc: linux-api@vger.kernel.org
Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
Acked-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/filesystems/proc.rst   |  2 ++
 fs/proc/task_mmu.c                   | 20 ++++++++++++
 include/linux/mm_types.h             |  3 ++
 include/linux/sched/numa_balancing.h | 45 ++++++++++++++++++++++++++
 include/uapi/linux/prctl.h           |  8 +++++
 kernel/fork.c                        |  4 +++
 kernel/sched/fair.c                  |  9 +++---
 kernel/sys.c                         | 47 ++++++++++++++++++++++++++++
 mm/mprotect.c                        |  6 ++--
 9 files changed, 138 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index bfefcbb8f82b..c9897674fc5e 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -193,6 +193,7 @@ read the file /proc/PID/status::
   VmLib:      1412 kB
   VmPTE:        20 kb
   VmSwap:        0 kB
+  NumaB_mode:  default
   HugetlbPages:          0 kB
   CoreDumping:    0
   THP_enabled:	  1
@@ -275,6 +276,7 @@ It's slow but very precise.
  VmPTE                       size of page table entries
  VmSwap                      amount of swap used by anonymous private data
                              (shmem swap usage is not included)
+ NumaB_mode                  numa balancing mode, set by prctl(PR_NUMA_BALANCING, ...)
  HugetlbPages                size of hugetlb memory portions
  CoreDumping                 process's memory is currently being dumped
                              (killing the process may lead to a corrupted core)
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 38b19a757281..3f7263226645 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -19,6 +19,8 @@
 #include <linux/shmem_fs.h>
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
+#include <linux/sched/numa_balancing.h>
+#include <linux/prctl.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -75,6 +77,24 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 		    " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
 	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
 	seq_puts(m, " kB\n");
+#ifdef CONFIG_NUMA_BALANCING
+	seq_puts(m, "NumaB_mode:\t");
+	switch (mm->numa_balancing_mode) {
+	case PR_SET_NUMA_BALANCING_DEFAULT:
+		seq_puts(m, "default");
+		break;
+	case PR_SET_NUMA_BALANCING_DISABLED:
+		seq_puts(m, "disabled");
+		break;
+	case PR_SET_NUMA_BALANCING_ENABLED:
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
index 3fc9e680f174..bd539d8c1103 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -740,6 +740,9 @@ struct mm_struct {
 
 		/* numa_scan_seq prevents two threads remapping PTEs. */
 		int numa_scan_seq;
+
+		/* Controls whether NUMA balancing is active for this mm. */
+		int numa_balancing_mode;
 #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 3988762efe15..fa360d17f52e 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -8,6 +8,8 @@
  */
 
 #include <linux/sched.h>
+#include <linux/sched/sysctl.h>
+#include <linux/prctl.h>
 
 #define TNF_MIGRATED	0x01
 #define TNF_NO_GROUP	0x02
@@ -16,12 +18,47 @@
 #define TNF_MIGRATE_FAIL 0x10
 
 #ifdef CONFIG_NUMA_BALANCING
+DECLARE_STATIC_KEY_FALSE(sched_numa_balancing);
 extern void task_numa_fault(int last_node, int node, int pages, int flags);
 extern pid_t task_numa_group_id(struct task_struct *p);
 extern void set_numabalancing_state(bool enabled);
 extern void task_numa_free(struct task_struct *p, bool final);
 extern bool should_numa_migrate_memory(struct task_struct *p, struct page *page,
 					int src_nid, int dst_cpu);
+static inline bool numa_balancing_enabled(struct task_struct *p)
+{
+	if (!static_branch_unlikely(&sched_numa_balancing))
+		return false;
+
+	if (p->mm) switch (p->mm->numa_balancing_mode) {
+	case PR_SET_NUMA_BALANCING_ENABLED:
+		return true;
+	case PR_SET_NUMA_BALANCING_DISABLED:
+		return false;
+	default:
+		break;
+	}
+
+	return sysctl_numa_balancing_mode;
+}
+static inline int numa_balancing_mode(struct mm_struct *mm)
+{
+	if (!static_branch_unlikely(&sched_numa_balancing))
+		return PR_SET_NUMA_BALANCING_DISABLED;
+
+	if (mm) switch (mm->numa_balancing_mode) {
+	case PR_SET_NUMA_BALANCING_ENABLED:
+		return sysctl_numa_balancing_mode == NUMA_BALANCING_DISABLED ?
+			NUMA_BALANCING_NORMAL : sysctl_numa_balancing_mode;
+	case PR_SET_NUMA_BALANCING_DISABLED:
+		return NUMA_BALANCING_DISABLED;
+	case PR_SET_NUMA_BALANCING_DEFAULT:
+	default:
+		break;
+	}
+
+	return sysctl_numa_balancing_mode;
+}
 #else
 static inline void task_numa_fault(int last_node, int node, int pages,
 				   int flags)
@@ -42,6 +79,14 @@ static inline bool should_numa_migrate_memory(struct task_struct *p,
 {
 	return true;
 }
+static inline int numa_balancing_mode(struct mm_struct *mm)
+{
+	return 0;
+}
+static inline bool numa_balancing_enabled(struct task_struct *p)
+{
+	return 0;
+}
 #endif
 
 #endif /* _LINUX_SCHED_NUMA_BALANCING_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index f23d9a16507f..7f452f677c61 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -294,4 +294,12 @@ struct prctl_mm_map {
 
 #define PR_SET_MEMORY_MERGE		67
 #define PR_GET_MEMORY_MERGE		68
+
+/* Set/get enabled per-process numa_balancing */
+#define PR_NUMA_BALANCING		69
+# define PR_SET_NUMA_BALANCING_DISABLED	0
+# define PR_SET_NUMA_BALANCING_ENABLED	1
+# define PR_SET_NUMA_BALANCING_DEFAULT	2
+# define PR_GET_NUMA_BALANCING		3
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 80dca376a536..534ba3566ac0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -99,6 +99,7 @@
 #include <linux/stackprotector.h>
 #include <linux/iommu.h>
 #include <linux/user_events.h>
+#include <linux/prctl.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -1281,6 +1282,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	init_tlb_flush_pending(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	mm->pmd_huge_pte = NULL;
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	mm->numa_balancing_mode = PR_SET_NUMA_BALANCING_DEFAULT;
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a29ca11bead2..50edc4d89c64 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -47,6 +47,7 @@
 #include <linux/psi.h>
 #include <linux/ratelimit.h>
 #include <linux/task_work.h>
+#include <linux/prctl.h>
 
 #include <asm/switch_to.h>
 
@@ -2842,7 +2843,7 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	struct numa_group *ng;
 	int priv;
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!numa_balancing_enabled(p))
 		return;
 
 	/* for example, ksmd faulting in a user's mm */
@@ -3220,7 +3221,7 @@ static void update_scan_period(struct task_struct *p, int new_cpu)
 	int src_nid = cpu_to_node(task_cpu(p));
 	int dst_nid = cpu_to_node(new_cpu);
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!numa_balancing_enabled(p))
 		return;
 
 	if (!p->mm || !p->numa_faults || (p->flags & PF_EXITING))
@@ -8455,7 +8456,7 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 	unsigned long src_weight, dst_weight;
 	int src_nid, dst_nid, dist;
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!numa_balancing_enabled(p))
 		return -1;
 
 	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
@@ -12061,7 +12062,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
 
-	if (static_branch_unlikely(&sched_numa_balancing))
+	if (numa_balancing_enabled(curr))
 		task_tick_numa(rq, curr);
 
 	update_misfit_status(curr, rq);
diff --git a/kernel/sys.c b/kernel/sys.c
index a2bd2b9f5683..d3df9fab1858 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -61,6 +61,7 @@
 #include <linux/sched/coredump.h>
 #include <linux/sched/task.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/numa_balancing.h>
 #include <linux/rcupdate.h>
 #include <linux/uidgid.h>
 #include <linux/cred.h>
@@ -2118,6 +2119,35 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
 	return 0;
 }
 
+#ifdef CONFIG_NUMA_BALANCING
+static int prctl_pid_numa_balancing_write(int numa_balancing)
+{
+	int old_numa_balancing;
+
+	if (numa_balancing != PR_SET_NUMA_BALANCING_DEFAULT &&
+	    numa_balancing != PR_SET_NUMA_BALANCING_DISABLED &&
+	    numa_balancing != PR_SET_NUMA_BALANCING_ENABLED)
+		return -EINVAL;
+
+	old_numa_balancing = xchg(&current->mm->numa_balancing_mode, numa_balancing);
+
+	if (numa_balancing == old_numa_balancing)
+		return 0;
+
+	if (numa_balancing == 1)
+		static_branch_inc(&sched_numa_balancing);
+	else if (old_numa_balancing == 1)
+		static_branch_dec(&sched_numa_balancing);
+
+	return 0;
+}
+
+static int prctl_pid_numa_balancing_read(void)
+{
+	return current->mm->numa_balancing_mode;
+}
+#endif
+
 static int prctl_set_mm(int opt, unsigned long addr,
 			unsigned long arg4, unsigned long arg5)
 {
@@ -2674,6 +2704,23 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = set_syscall_user_dispatch(arg2, arg3, arg4,
 						  (char __user *) arg5);
 		break;
+#ifdef CONFIG_NUMA_BALANCING
+	case PR_NUMA_BALANCING:
+		switch (arg2) {
+		case PR_SET_NUMA_BALANCING_DEFAULT:
+		case PR_SET_NUMA_BALANCING_DISABLED:
+		case PR_SET_NUMA_BALANCING_ENABLED:
+			error = prctl_pid_numa_balancing_write((int)arg2);
+			break;
+		case PR_GET_NUMA_BALANCING:
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
diff --git a/mm/mprotect.c b/mm/mprotect.c
index afdb6723782e..eb1098f790f2 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -30,6 +30,7 @@
 #include <linux/mm_inline.h>
 #include <linux/pgtable.h>
 #include <linux/sched/sysctl.h>
+#include <linux/sched/numa_balancing.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/memory-tiers.h>
 #include <asm/cacheflush.h>
@@ -165,10 +166,11 @@ static long change_pte_range(struct mmu_gather *tlb,
 				 * Skip scanning top tier node if normal numa
 				 * balancing is disabled
 				 */
-				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
+				if (!(numa_balancing_mode(vma->vm_mm) & NUMA_BALANCING_NORMAL) &&
 				    toptier)
 					continue;
-				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+				if (numa_balancing_mode(vma->vm_mm) &
+				    NUMA_BALANCING_MEMORY_TIERING &&
 				    !toptier)
 					xchg_page_access_time(page,
 						jiffies_to_msecs(jiffies));
-- 
2.20.1

