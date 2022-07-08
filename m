Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15CD56B461
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbiGHIXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 04:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbiGHIXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:23:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DD174DEC
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 01:23:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id j3so10305979pfb.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jul 2022 01:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dk6MSmK/j/2WDmJxChg2RYSfGISqV2zU0kSVVWJjs+I=;
        b=5apM4sq9VnuX/zLwjXMB3gG7Nl0vvvbBy8OuUw3xkRiNW+vqc/BBW4TCScfsi4530M
         I0QL8U92qHJXbgm1cnI0F++kzIbhh9prCWsCYlLoxkKIb0Zc0Mg4ERo7QCZWQj++l1g8
         y/dIEke9Tb155Z0S/Qn03ldboWFKYQL+Nl+LgbSnsoSs3H8tHbYtpLh3CcWW2xjDcN/q
         ld3hgH1ZJmnIqZmZVYAVQ+P1SApLObvt+Ks5bZ+hpI/ST1LIlNR2kA3uIOXKCSRfXoSe
         DA5ofD5QUrvbLnEUA8L2lGJgbAxfXBAZYDv05p2NcCfaZ8EFxwCVSMCze1J6lU1g9gOJ
         2XGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dk6MSmK/j/2WDmJxChg2RYSfGISqV2zU0kSVVWJjs+I=;
        b=0uPGgEzTygh+XEaMunymZdKbqzP7bfJCpgj9VSNQr7mS74fsAhfT8Po4rWaHBjLqoM
         CebS4LgpucEihVW6tCCOHVBBa/qh0jUoM2iYggHk0FOvf2M2qNV/JbhSjLxqj+jr07Qj
         Orhw3aMq/r9qxDr9IHhMrzjcgBA6ETLfhkIKqshdq9wbbR/BZVqzs3WzUh6DR+dG3e+C
         gOOb6ID7rgJ3jzOf3ejUSoItmQ7Vgu6TmInSGSlSY/dRQbklEIaLnh3zZ4B6Znu1A6xG
         Qlu76IopCGLBtDG4CKc5aEoa8h+DMXSj1xf2mp1+JoT2IQOMw+WVtr9LQDrOQh05FoWL
         7Hhg==
X-Gm-Message-State: AJIora/G8QWh3vdUfcA2jZpnVptvUVJkktz+t5rkOYlP3RosHqMP9wj2
        pcchI3o2XTaY+P83ac7ZGZrSxA==
X-Google-Smtp-Source: AGRyM1t2bSeyc+ZhkHZ+dbx7rBPltXk5Bo6WNvlPOj227m8dkbBZjTwJpct0sr4HcWPiEcTQqqV7uQ==
X-Received: by 2002:a05:6a00:1312:b0:528:2ed8:7e35 with SMTP id j18-20020a056a00131200b005282ed87e35mr2567724pfu.13.1657268622398;
        Fri, 08 Jul 2022 01:23:42 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id x65-20020a636344000000b00412b1043f33sm3329291pgb.39.2022.07.08.01.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 01:23:41 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     mhocko@suse.com, akpm@linux-foundation.org, surenb@google.com
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, david@redhat.com, imbrenda@linux.ibm.com,
        adobriyan@gmail.com, yang.yang29@zte.com.cn, brauner@kernel.org,
        stephen.s.brennan@oracle.com, zhengqi.arch@bytedance.com,
        haolee.swjtu@gmail.com, xu.xin16@zte.com.cn,
        Liam.Howlett@Oracle.com, ohoono.kwon@samsung.com,
        peterx@redhat.com, arnd@arndb.de, shy828301@gmail.com,
        alex.sierra@amd.com, xianting.tian@linux.alibaba.com,
        willy@infradead.org, ccross@google.com, vbabka@suse.cz,
        sujiaxun@uniontech.com, sfr@canb.auug.org.au,
        vasily.averin@linux.dev, mgorman@suse.de, vvghjk1234@gmail.com,
        tglx@linutronix.de, luto@kernel.org, bigeasy@linutronix.de,
        fenghua.yu@intel.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH v2 5/5] mm, oom: enable per numa node oom for CONSTRAINT_{MEMORY_POLICY,CPUSET}
Date:   Fri,  8 Jul 2022 16:21:29 +0800
Message-Id: <20220708082129.80115-6-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220708082129.80115-1-ligang.bdlg@bytedance.com>
References: <20220708082129.80115-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Page allocator will only alloc pages on node indicated by mempolicy or
cpuset. But oom will still select bad process by total rss usage.

This patch let oom only calculate rss on the given node when
oc->constraint equals to CONSTRAINT_{MEMORY_POLICY,CPUSET}.

With those constraint, the process with the highest memory consumption on
the specific node will be killed. oom_kill dmesg now have a new column
`(%d)nrss`.

It looks like this:
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
 fs/proc/base.c      |  6 ++++-
 include/linux/oom.h |  2 +-
 mm/oom_kill.c       | 55 ++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 617816168748..92075e9dca06 100644
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
index 7d0c9c48a0c5..19eaa447ac57 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -98,7 +98,7 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
 }
 
 long oom_badness(struct task_struct *p,
-		unsigned long totalpages);
+		struct oom_control *oc);
 
 extern bool out_of_memory(struct oom_control *oc);
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index e25c37e2e90d..921539e29ae9 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -189,6 +189,18 @@ static bool should_dump_unreclaim_slab(void)
 	return (global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B) > nr_lru);
 }
 
+static inline int get_nid_from_oom_control(struct oom_control *oc)
+{
+	nodemask_t *nodemask;
+	struct zoneref *zoneref;
+
+	nodemask = oc->constraint == CONSTRAINT_MEMORY_POLICY
+			? oc->nodemask : &cpuset_current_mems_allowed;
+
+	zoneref = first_zones_zonelist(oc->zonelist, gfp_zone(oc->gfp_mask), nodemask);
+	return zone_to_nid(zoneref->zone);
+}
+
 /**
  * oom_badness - heuristic function to determine which candidate task to kill
  * @p: task struct of which task we should calculate
@@ -198,7 +210,7 @@ static bool should_dump_unreclaim_slab(void)
  * predictable as possible.  The goal is to return the highest value for the
  * task consuming the most memory to avoid subsequent oom failures.
  */
-long oom_badness(struct task_struct *p, unsigned long totalpages)
+long oom_badness(struct task_struct *p, struct oom_control *oc)
 {
 	long points;
 	long adj;
@@ -227,12 +239,21 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
 	 * The baseline for the badness score is the proportion of RAM that each
 	 * task's rss, pagetable and swap space use.
 	 */
-	points = get_mm_rss(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS, NUMA_NO_NODE) +
-		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
+	if (unlikely(oc->constraint == CONSTRAINT_MEMORY_POLICY ||
+		     oc->constraint == CONSTRAINT_CPUSET)) {
+		int nid_to_find_victim = get_nid_from_oom_control(oc);
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
@@ -338,7 +359,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 		goto select;
 	}
 
-	points = oom_badness(task, oc->totalpages);
+	points = oom_badness(task, oc);
 	if (points == LONG_MIN || points < oc->chosen_points)
 		goto next;
 
@@ -382,6 +403,7 @@ static int dump_task(struct task_struct *p, void *arg)
 {
 	struct oom_control *oc = arg;
 	struct task_struct *task;
+	unsigned long node_mm_rss;
 
 	if (oom_unkillable_task(p))
 		return 0;
@@ -399,9 +421,17 @@ static int dump_task(struct task_struct *p, void *arg)
 		return 0;
 	}
 
-	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
+	if (unlikely(oc->constraint == CONSTRAINT_MEMORY_POLICY ||
+		     oc->constraint == CONSTRAINT_CPUSET)) {
+		int nid_to_find_victim = get_nid_from_oom_control(oc);
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
@@ -422,8 +452,17 @@ static int dump_task(struct task_struct *p, void *arg)
  */
 static void dump_tasks(struct oom_control *oc)
 {
+	int nid_to_find_victim;
+
+	if (unlikely(oc->constraint == CONSTRAINT_MEMORY_POLICY ||
+		     oc->constraint == CONSTRAINT_CPUSET)) {
+		nid_to_find_victim = get_nid_from_oom_control(oc);
+	} else {
+		nid_to_find_victim = -1;
+	}
 	pr_info("Tasks state (memory values in pages):\n");
-	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
+	pr_info("[  pid  ]   uid  tgid total_vm      rss (%02d)nrss  pgtables_bytes swapents"
+		" oom_score_adj name\n", nid_to_find_victim);
 
 	if (is_memcg_oom(oc))
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
-- 
2.20.1

