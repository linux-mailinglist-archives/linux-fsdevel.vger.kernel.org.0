Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352D4524489
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 06:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348701AbiELEtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 00:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348347AbiELEsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 00:48:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFBE5839A
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 21:48:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w17-20020a17090a529100b001db302efed6so3835902pjh.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 21:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1y9RB53i1x0EnR6VDo0VxXEpi1Ea3k/4xASHr+wAeNs=;
        b=ED7QnqXmFcsjrevZkcWDo0daj/zPdRmxqxw6xqqtvnvDuttbp2MpTSwPHwW489+bPL
         tB2RsBSPFwNhwz+fNmjN4qvKAgOfLFtB5kthM6noguSm7/A0Jw5ssNcpY5CjB+606hcH
         pewICu6aMniVo+HL84uLSI9AaeaFHqIt3hOfgfqvPV4CG94WseiQCu8SlAefX7VFJW+H
         FBG9f+0eUIEeb7F1FJcSgHYoxl/DL+S5r5j6BwERrGcyrtfhyms1ezRISWLyARZ1qAcU
         ID/PEGkY1BIvSemcCVHvQ9gLJiTPPgf0KTaKEbygy7NAVTuLD4SXv/2Yqc/vIoDte3jD
         f9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1y9RB53i1x0EnR6VDo0VxXEpi1Ea3k/4xASHr+wAeNs=;
        b=G67M0yqOdmz+NSFUwi5WVZZyG4NVr1wwADMaGJZjy+OG2+urwafCwCjBmCvXIfL9vy
         jHZIyoLrUxixF1O1/ykCULinzl0PDdUNq0m3cDOoFSMSwTfnurHqErFbCBS/oz/zehwF
         H0eegv6uy4K6V+fwuDzFm/jUKvaBIoJvppAavOlMedMSvp8MqdPPo9Be8us3Q5Wikgyk
         760aeSlYcqX/wKNn5dKgYJYyrgQWsMCoOxDc81FTDh8YqpbyVAIOdY/oQOG7aQIq1/Yy
         sMon68NCXhe0vb3PJyo+UQZghYHzTavRXPCfh5gXmrZGsbyc2W+Fph2TVf3oXUbmwQbG
         zwMw==
X-Gm-Message-State: AOAM5304Vl1svtm44SKn9Y8tuUkfDOCUEq7yKpnmfwtIr/1y0GpCYrN1
        PNmW1SFwqRozsobjIvFoqbxXdg==
X-Google-Smtp-Source: ABdhPJwLDnrD49kx6eQ6RD4rGeXO3R/bTrPriNq6SzUBXg+93UiGtEb7CcypgjNj2aanDmD/Vwv6LQ==
X-Received: by 2002:a17:903:292:b0:15f:171:e794 with SMTP id j18-20020a170903029200b0015f0171e794mr21359273plr.107.1652330904985;
        Wed, 11 May 2022 21:48:24 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b0015edc07dcf3sm2790824plk.21.2022.05.11.21.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:48:24 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     songmuchun@bytedance.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ebiederm@xmission.com, keescook@chromium.org,
        viro@zeniv.linux.org.uk, rostedt@goodmis.org, mingo@redhat.com,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, david@redhat.com, imbrenda@linux.ibm.com,
        apopple@nvidia.com, adobriyan@gmail.com,
        stephen.s.brennan@oracle.com, ohoono.kwon@samsung.com,
        haolee.swjtu@gmail.com, kaleshsingh@google.com,
        zhengqi.arch@bytedance.com, peterx@redhat.com, shy828301@gmail.com,
        surenb@google.com, ccross@google.com, vincent.whitchurch@axis.com,
        tglx@linutronix.de, bigeasy@linutronix.de, fenghua.yu@intel.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH 5/5 v1] mm, oom: enable per numa node oom for CONSTRAINT_MEMORY_POLICY
Date:   Thu, 12 May 2022 12:46:34 +0800
Message-Id: <20220512044634.63586-6-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220512044634.63586-1-ligang.bdlg@bytedance.com>
References: <20220512044634.63586-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Page allocator will only alloc pages on node indicated by
`nodemask`. But oom will still select bad process by total rss usage
which may reclam nothing on the node indicated by `nodemask`.

This patch let oom only calculate rss on the given node when
oc->constraint equals to CONSTRAINT_MEMORY_POLICY.

If `nodemask` is asigned, the process with the highest memory
consumption on the specific node will be killed. oom_kill dmesg will
looks like this:

```
[ 1471.436027] Tasks state (memory values in pages):
[ 1471.438518] [  pid  ]   uid  tgid total_vm      rss (01)nrss  pgtables_bytes swapents oom_score_adj name
[ 1471.554703] [   1011]     0  1011   220005     8589     1872   823296        0             0 node
[ 1471.707912] [  12399]     0 12399  1311306  1311056   262170 10534912        0             0 a.out
[ 1471.712429] [  13135]     0 13135   787018   674666   674300  5439488        0             0 a.out
[ 1471.721506] [  13295]     0 13295      597      188        0    24576        0             0 sh
[ 1471.734600] oom-kill:constraint=CONSTRAINT_MEMORY_POLICY,nodemask=1,cpuset=/,mems_allowed=0-2,global_oom,task_memcg=/user.slice/user-0.slice/session-3.scope,task=a.out,pid=13135,uid=0
[ 1471.742583] Out of memory: Killed process 13135 (a.out) total-vm:3148072kB, anon-rss:2697304kB, file-rss:1360kB, shmem-rss:0kB, UID:0 pgtables:5312kB oom_score_adj:0
[ 1471.849615] oom_reaper: reaped process 13135 (a.out), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
```

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 fs/proc/base.c      |  6 +++++-
 include/linux/oom.h |  2 +-
 mm/oom_kill.c       | 45 +++++++++++++++++++++++++++++++++++++--------
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c1031843cc6a..caf0f51284d0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -552,8 +552,12 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long totalpages = totalram_pages() + total_swap_pages;
 	unsigned long points = 0;
 	long badness;
+	struct oom_control oc = {
+		.totalpages =  totalpages,
+		.gfp_mask = 0,
+	};
 
-	badness = oom_badness(task, totalpages);
+	badness = oom_badness(task, &oc);
 	/*
 	 * Special case OOM_SCORE_ADJ_MIN for all others scale the
 	 * badness value into [0, 2000] range which we have been
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 2db9a1432511..0cb6a60be776 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -109,7 +109,7 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
 bool __oom_reap_task_mm(struct mm_struct *mm);
 
 long oom_badness(struct task_struct *p,
-		unsigned long totalpages);
+		struct oom_control *oc);
 
 extern bool out_of_memory(struct oom_control *oc);
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 757f5665ae94..75a80b5a63bf 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -198,7 +198,7 @@ static bool should_dump_unreclaim_slab(void)
  * predictable as possible.  The goal is to return the highest value for the
  * task consuming the most memory to avoid subsequent oom failures.
  */
-long oom_badness(struct task_struct *p, unsigned long totalpages)
+long oom_badness(struct task_struct *p, struct oom_control *oc)
 {
 	long points;
 	long adj;
@@ -227,12 +227,22 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
 	 * The baseline for the badness score is the proportion of RAM that each
 	 * task's rss, pagetable and swap space use.
 	 */
-	points = get_mm_rss(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS, NUMA_NO_NODE) +
-		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
+	if (unlikely(oc->constraint == CONSTRAINT_MEMORY_POLICY)) {
+		struct zoneref *zoneref = first_zones_zonelist(oc->zonelist, gfp_zone(oc->gfp_mask),
+								oc->nodemask);
+		int nid_to_find_victim = zone_to_nid(zoneref->zone);
+
+		points = get_mm_counter(p->mm, -1, nid_to_find_victim) +
+			get_mm_counter(p->mm, MM_SWAPENTS, NUMA_NO_NODE) +
+			mm_pgtables_bytes(p->mm) / PAGE_SIZE;
+	} else {
+		points = get_mm_rss(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS, NUMA_NO_NODE) +
+			mm_pgtables_bytes(p->mm) / PAGE_SIZE;
+	}
 	task_unlock(p);
 
 	/* Normalize to oom_score_adj units */
-	adj *= totalpages / 1000;
+	adj *= oc->totalpages / 1000;
 	points += adj;
 
 	return points;
@@ -338,7 +348,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 		goto select;
 	}
 
-	points = oom_badness(task, oc->totalpages);
+	points = oom_badness(task, oc);
 	if (points == LONG_MIN || points < oc->chosen_points)
 		goto next;
 
@@ -382,6 +392,7 @@ static int dump_task(struct task_struct *p, void *arg)
 {
 	struct oom_control *oc = arg;
 	struct task_struct *task;
+	unsigned long node_mm_rss;
 
 	if (oom_unkillable_task(p))
 		return 0;
@@ -399,9 +410,18 @@ static int dump_task(struct task_struct *p, void *arg)
 		return 0;
 	}
 
-	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
+	if (unlikely(oc->constraint == CONSTRAINT_MEMORY_POLICY)) {
+		struct zoneref *zoneref = first_zones_zonelist(oc->zonelist, gfp_zone(oc->gfp_mask),
+								oc->nodemask);
+		int nid_to_find_victim = zone_to_nid(zoneref->zone);
+
+		node_mm_rss = get_mm_counter(p->mm, -1, nid_to_find_victim);
+	} else {
+		node_mm_rss = 0;
+	}
+	pr_info("[%7d] %5d %5d %8lu %8lu %8lu %8ld %8lu         %5hd %s\n",
 		task->pid, from_kuid(&init_user_ns, task_uid(task)),
-		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
+		task->tgid, task->mm->total_vm, get_mm_rss(task->mm), node_mm_rss,
 		mm_pgtables_bytes(task->mm),
 		get_mm_counter(task->mm, MM_SWAPENTS, NUMA_NO_NODE),
 		task->signal->oom_score_adj, task->comm);
@@ -422,8 +442,17 @@ static int dump_task(struct task_struct *p, void *arg)
  */
 static void dump_tasks(struct oom_control *oc)
 {
+	int nid_to_find_victim;
+
+	if (oc->nodemask) {
+		struct zoneref *zoneref = first_zones_zonelist(oc->zonelist, gfp_zone(oc->gfp_mask),
+								oc->nodemask);
+		nid_to_find_victim = zone_to_nid(zoneref->zone);
+	} else {
+		nid_to_find_victim = -1;
+	}
 	pr_info("Tasks state (memory values in pages):\n");
-	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
+	pr_info("[  pid  ]   uid  tgid total_vm      rss (%02d)nrss  pgtables_bytes swapents oom_score_adj name\n", nid_to_find_victim);
 
 	if (is_memcg_oom(oc))
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
-- 
2.20.1

