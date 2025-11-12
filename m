Return-Path: <linux-fsdevel+bounces-68092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F229C5437B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6BAB4F9CCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 19:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F01352943;
	Wed, 12 Nov 2025 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ra73BIaP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AC834EEEE
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975810; cv=none; b=RsbvqW4SrbValby5qul/WulKrTrDC6vZVZxIiD3z6rsd6Tktm/XM69rhi4Wenib0lP5Arv3SUmjr2r53wrF0yYPAI4DotL0bNqA4P84jaa6Y9wQsfj7s0tUG3pVaua84s4EFyUHmv4fLw3Xdwl1VN33OPQ+bBR+8PjD28q3kKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975810; c=relaxed/simple;
	bh=3eQAOWVLWYdFH8IRSCtox2dkM9KAIfvHkmeNLhZe/t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TT7OKOWag9d97jHUkCL+BdCGSqzuMSGlpR4Ut2pBm9KS4/RixNUfpLXzjezKQJg+nisBaRuBn37LSU2why/xZSj0GsXJXRvZWNC8OWcBUNMj2euJQKMIytKAPIhKviCOqM7M3icyh8nPVPTkoZIA6Ix0Q7hmxYlO7iC2LXTltgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ra73BIaP; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-88f239686f2so4952085a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 11:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975806; x=1763580606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhBmvL59ycsUz3ibQ/6uOqgLkj12C0XSyaG6LdtCjSY=;
        b=Ra73BIaPFVGmm0r33U2vrLFcTXXy999T+1/SWzTgw2hA102EnexfBxEbFL7SIT0sW9
         FlON92KJezoRn54eoUiH9rADe8DiMmvY+oifuZ8lq8xC4AvVZVJAz4YWm95BiT8TmdSI
         tgh0IUmr72TRt8T5VTwciZOcOfYY6MBXYjOvAJvePwNWZ96ui1Lvd2knTEaQ+LVa553d
         11XAxv0HYO4VSffQxsEzOhQ8XRcZ+bAF0Rz7a90gUwIuyl1JHHhc9ZLf0uIapLdFW7W2
         xFzOYfWskeJ/8zgDNGCDExulWO6JRRHNI2TMH37DuA+0Kw159Wm/TTuB9ZEvtp8Okqam
         6MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975806; x=1763580606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AhBmvL59ycsUz3ibQ/6uOqgLkj12C0XSyaG6LdtCjSY=;
        b=QFQJxS6A6NO8Ko8Aw1swVye8jyZ7FLNsbFrEbsGBm/yY9Ei7FkUwDryjwmc8/SvjMd
         dtvria+c5UuwpTTaPZLhMh1dFtgKrubsbcmT0nyBRK9eGLuilxcVABa8lvEAAgyvsOFM
         HKXj7T2+yPmMM82dqJBEwu+uJforqjp/deZTz3hQOhY8aUPILk5TWFrb8Ga98zcb3faS
         oCc194zTGZ9B7nHDrlmtZxuGMfKG2n9ZHyROHWcggkiCwZrBOboHKPXtCGPii0ODnHw3
         g5U4j3uOADov0/gqit45LNNqsUvSwgcoizeNtFnqNLvpRjPSSi7gQm2sfqxX5+8Mp1u8
         DIAg==
X-Forwarded-Encrypted: i=1; AJvYcCXlspRylVGv3ppADl8zgEC0MyOZGEZpBgEYj9EfHGJ+IOgpQF61eIKDQ1vdJhG81GomPtkmD27D1giVJ6K8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrre8+bvZeiHTwkniFXtO5NKTdHhp0ZUuRxGSSgmVlB+4RkJc/
	d6oFcKiRbeAZXis+Q1RNC3Rdi6+9CyEj5pFR+NKT8A+A0UD0DvBw4KTDJM4TbAH7EX8=
X-Gm-Gg: ASbGncvRZD7DLpbvMZ6ozTSJUwXKDloyjX4U7Y7xRKssPPJgvkj48olYnNUTgMRO7UL
	3PcaYzq4QswwnyumMSvwP16XB8ACOUaCk8p/NhsJL0QfQGsw7mAE7R7taMtoqroJIjfzNXEp9Ub
	TTwzvbkKBIlSAaD7eK80WzqiyDEUhIdVTTOC9dDPNrhUW9qtfKYF4Hr6eQm+QEXIchatm7Pja9W
	A0zPzh0UH4q6yekNwMmsD2Si70RrG9JZEd8OcL5iy6FoPgunZSVWGnsIEGWjx+VJHLySOmgW+9Q
	Xhr2nAbjrDO71L6wGCg0BkGIhTEH89ZdoCq/4MAC/ToULehesq5RRsyw7wZPhCZK7o4w55+UyIb
	/yGOY9xv5UJqbJ/yPRJyc2gE7yiZHW4o8gJ1sNvJgWhp70fcNzdOPdVkmJFNGQcjxg8j4it6AfY
	6H8bPuMhU62aU5XPCXMPDSlXivW2agCl7EM87n7inosDHD5mh4S+59IVRJ5VbdH1wL
X-Google-Smtp-Source: AGHT+IGTEVLf9O0yaDcu/kw8dFzHlv1Pot58wNRLhXzP9mTYCvcWg0Vdidkl8DHHnj9i/GN8ZNY6bg==
X-Received: by 2002:a05:620a:3941:b0:8b2:1568:82e4 with SMTP id af79cd13be357-8b29b77a0famr523474785a.25.1762975806067;
        Wed, 12 Nov 2025 11:30:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:30:05 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC PATCH v2 06/11] mm,cpusets: rename task->mems_allowed to task->sysram_nodes
Date: Wed, 12 Nov 2025 14:29:22 -0500
Message-ID: <20251112192936.2574429-7-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112192936.2574429-1-gourry@gourry.net>
References: <20251112192936.2574429-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

task->mems_allowed actually contains the value of cpuset.effective_mems

The value of cpuset.mems.effective is the intersection of mems_allowed
and the cpuset's parent's mems.effective.  This creates a confusing
naming scheme between references to task->mems_allowed, and cpuset
mems_allowed and effective_mems.

With the intent of making this nodemask only contain SystemRAM Nodes
(i.e. omitting Specific Purpose Memory Nodes), rename task->mems_allowed
to task->sysram_nodes.  This accomplishes two things:

1) Detach task->mems_allowed and cpuset.mems_allowed naming scheme,
   making it slightly clearer that these may contain different values.

2) To enable cpusets.mems_allowed to contain SPM Nodes, letting a cgroup
   still control whether SPM nodes are "allowed" for that context, even
   if these nodes are not reachable through existing means.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 fs/proc/array.c           |  2 +-
 include/linux/cpuset.h    | 54 ++++++++++++++-------------
 include/linux/mempolicy.h |  2 +-
 include/linux/sched.h     |  6 +--
 init/init_task.c          |  2 +-
 kernel/cgroup/cpuset.c    | 78 +++++++++++++++++++--------------------
 kernel/fork.c             |  2 +-
 kernel/sched/fair.c       |  4 +-
 mm/hugetlb.c              |  8 ++--
 mm/mempolicy.c            | 28 +++++++-------
 mm/oom_kill.c             |  6 +--
 mm/page_alloc.c           | 16 ++++----
 mm/show_mem.c             |  2 +-
 13 files changed, 106 insertions(+), 104 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 2ae63189091e..61ee857a5caf 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -456,7 +456,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	task_cap(m, task);
 	task_seccomp(m, task);
 	task_cpus_allowed(m, task);
-	cpuset_task_status_allowed(m, task);
+	cpuset_task_status_sysram(m, task);
 	task_context_switch_counts(m, task);
 	arch_proc_pid_thread_features(m, task);
 	return 0;
diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 548eaf7ef8d0..9baaf19431b5 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -23,14 +23,14 @@
 /*
  * Static branch rewrites can happen in an arbitrary order for a given
  * key. In code paths where we need to loop with read_mems_allowed_begin() and
- * read_mems_allowed_retry() to get a consistent view of mems_allowed, we need
- * to ensure that begin() always gets rewritten before retry() in the
+ * read_mems_allowed_retry() to get a consistent view of task->sysram_nodes, we
+ * need to ensure that begin() always gets rewritten before retry() in the
  * disabled -> enabled transition. If not, then if local irqs are disabled
  * around the loop, we can deadlock since retry() would always be
- * comparing the latest value of the mems_allowed seqcount against 0 as
+ * comparing the latest value of the sysram_nodes seqcount against 0 as
  * begin() still would see cpusets_enabled() as false. The enabled -> disabled
  * transition should happen in reverse order for the same reasons (want to stop
- * looking at real value of mems_allowed.sequence in retry() first).
+ * looking at real value of sysram_nodes.sequence in retry() first).
  */
 extern struct static_key_false cpusets_pre_enable_key;
 extern struct static_key_false cpusets_enabled_key;
@@ -78,9 +78,10 @@ extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern bool cpuset_cpu_is_isolated(int cpu);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
-#define cpuset_current_mems_allowed (current->mems_allowed)
-void cpuset_init_current_mems_allowed(void);
-int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask);
+#define cpuset_current_sysram_nodes (current->sysram_nodes)
+#define cpuset_current_mems_allowed (cpuset_current_sysram_nodes)
+void cpuset_init_current_sysram_nodes(void);
+int cpuset_nodemask_valid_sysram_nodes(const nodemask_t *nodemask);
 
 extern bool cpuset_current_node_allowed(int node, gfp_t gfp_mask);
 
@@ -96,7 +97,7 @@ static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 	return true;
 }
 
-extern int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
+extern int cpuset_sysram_nodes_intersects(const struct task_struct *tsk1,
 					  const struct task_struct *tsk2);
 
 #ifdef CONFIG_CPUSETS_V1
@@ -111,8 +112,8 @@ extern void __cpuset_memory_pressure_bump(void);
 static inline void cpuset_memory_pressure_bump(void) { }
 #endif
 
-extern void cpuset_task_status_allowed(struct seq_file *m,
-					struct task_struct *task);
+extern void cpuset_task_status_sysram(struct seq_file *m,
+				      struct task_struct *task);
 extern int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
 			    struct pid *pid, struct task_struct *tsk);
 
@@ -128,12 +129,12 @@ extern bool current_cpuset_is_being_rebound(void);
 extern void dl_rebuild_rd_accounting(void);
 extern void rebuild_sched_domains(void);
 
-extern void cpuset_print_current_mems_allowed(void);
+extern void cpuset_print_current_sysram_nodes(void);
 extern void cpuset_reset_sched_domains(void);
 
 /*
- * read_mems_allowed_begin is required when making decisions involving
- * mems_allowed such as during page allocation. mems_allowed can be updated in
+ * read_mems_allowed_begin is required when making decisions involving a task's
+ * sysram_nodes such as during page allocation. sysram_nodes can be updated in
  * parallel and depending on the new value an operation can fail potentially
  * causing process failure. A retry loop with read_mems_allowed_begin and
  * read_mems_allowed_retry prevents these artificial failures.
@@ -143,13 +144,13 @@ static inline unsigned int read_mems_allowed_begin(void)
 	if (!static_branch_unlikely(&cpusets_pre_enable_key))
 		return 0;
 
-	return read_seqcount_begin(&current->mems_allowed_seq);
+	return read_seqcount_begin(&current->sysram_nodes_seq);
 }
 
 /*
  * If this returns true, the operation that took place after
  * read_mems_allowed_begin may have failed artificially due to a concurrent
- * update of mems_allowed. It is up to the caller to retry the operation if
+ * update of sysram_nodes. It is up to the caller to retry the operation if
  * appropriate.
  */
 static inline bool read_mems_allowed_retry(unsigned int seq)
@@ -157,7 +158,7 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
 	if (!static_branch_unlikely(&cpusets_enabled_key))
 		return false;
 
-	return read_seqcount_retry(&current->mems_allowed_seq, seq);
+	return read_seqcount_retry(&current->sysram_nodes_seq, seq);
 }
 
 static inline void set_mems_allowed(nodemask_t nodemask)
@@ -166,9 +167,9 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 
 	task_lock(current);
 	local_irq_save(flags);
-	write_seqcount_begin(&current->mems_allowed_seq);
-	current->mems_allowed = nodemask;
-	write_seqcount_end(&current->mems_allowed_seq);
+	write_seqcount_begin(&current->sysram_nodes_seq);
+	current->sysram_nodes = nodemask;
+	write_seqcount_end(&current->sysram_nodes_seq);
 	local_irq_restore(flags);
 	task_unlock(current);
 }
@@ -216,10 +217,11 @@ static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
 	return node_possible_map;
 }
 
-#define cpuset_current_mems_allowed (node_states[N_MEMORY])
-static inline void cpuset_init_current_mems_allowed(void) {}
+#define cpuset_current_sysram_nodes (node_states[N_MEMORY])
+#define cpuset_current_mems_allowed (cpuset_current_sysram_nodes)
+static inline void cpuset_init_current_sysram_nodes(void) {}
 
-static inline int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask)
+static inline int cpuset_nodemask_valid_sysram_nodes(const nodemask_t *nodemask)
 {
 	return 1;
 }
@@ -234,7 +236,7 @@ static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 	return true;
 }
 
-static inline int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
+static inline int cpuset_sysram_nodes_intersects(const struct task_struct *tsk1,
 						 const struct task_struct *tsk2)
 {
 	return 1;
@@ -242,8 +244,8 @@ static inline int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
 
 static inline void cpuset_memory_pressure_bump(void) {}
 
-static inline void cpuset_task_status_allowed(struct seq_file *m,
-						struct task_struct *task)
+static inline void cpuset_task_status_sysram(struct seq_file *m,
+					     struct task_struct *task)
 {
 }
 
@@ -276,7 +278,7 @@ static inline void cpuset_reset_sched_domains(void)
 	partition_sched_domains(1, NULL, NULL);
 }
 
-static inline void cpuset_print_current_mems_allowed(void)
+static inline void cpuset_print_current_sysram_nodes(void)
 {
 }
 
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 0fe96f3ab3ef..f9a2b1bed3fa 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -52,7 +52,7 @@ struct mempolicy {
 	int home_node;		/* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
 
 	union {
-		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
+		nodemask_t cpuset_sysram_nodes;	/* relative to these nodes */
 		nodemask_t user_nodemask;	/* nodemask passed by user */
 	} w;
 };
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b469878de25c..ad2d0cb00772 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1223,7 +1223,7 @@ struct task_struct {
 	u64				parent_exec_id;
 	u64				self_exec_id;
 
-	/* Protection against (de-)allocation: mm, files, fs, tty, keyrings, mems_allowed, mempolicy: */
+	/* Protection against (de-)allocation: mm, files, fs, tty, keyrings, sysram_nodes, mempolicy: */
 	spinlock_t			alloc_lock;
 
 	/* Protection of the PI data structures: */
@@ -1314,9 +1314,9 @@ struct task_struct {
 #endif
 #ifdef CONFIG_CPUSETS
 	/* Protected by ->alloc_lock: */
-	nodemask_t			mems_allowed;
+	nodemask_t			sysram_nodes;
 	/* Sequence number to catch updates: */
-	seqcount_spinlock_t		mems_allowed_seq;
+	seqcount_spinlock_t		sysram_nodes_seq;
 	int				cpuset_mem_spread_rotor;
 #endif
 #ifdef CONFIG_CGROUPS
diff --git a/init/init_task.c b/init/init_task.c
index a55e2189206f..857a5978d403 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -173,7 +173,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.trc_blkd_node = LIST_HEAD_INIT(init_task.trc_blkd_node),
 #endif
 #ifdef CONFIG_CPUSETS
-	.mems_allowed_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
+	.sysram_nodes_seq = SEQCNT_SPINLOCK_ZERO(init_task.sysram_nodes_seq,
 						 &init_task.alloc_lock),
 #endif
 #ifdef CONFIG_RT_MUTEXES
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index cd3e2ae83d70..f0c59621a7f2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -240,7 +240,7 @@ static struct cpuset top_cpuset = {
  * If a task is only holding callback_lock, then it has read-only
  * access to cpusets.
  *
- * Now, the task_struct fields mems_allowed and mempolicy may be changed
+ * Now, the task_struct fields sysram_nodes and mempolicy may be changed
  * by other task, we use alloc_lock in the task_struct fields to protect
  * them.
  *
@@ -2678,11 +2678,11 @@ static void schedule_flush_migrate_mm(void)
 }
 
 /*
- * cpuset_change_task_nodemask - change task's mems_allowed and mempolicy
+ * cpuset_change_task_nodemask - change task's sysram_nodes and mempolicy
  * @tsk: the task to change
  * @newmems: new nodes that the task will be set
  *
- * We use the mems_allowed_seq seqlock to safely update both tsk->mems_allowed
+ * We use the sysram_nodes_seq seqlock to safely update both tsk->sysram_nodes
  * and rebind an eventual tasks' mempolicy. If the task is allocating in
  * parallel, it might temporarily see an empty intersection, which results in
  * a seqlock check and retry before OOM or allocation failure.
@@ -2693,13 +2693,13 @@ static void cpuset_change_task_nodemask(struct task_struct *tsk,
 	task_lock(tsk);
 
 	local_irq_disable();
-	write_seqcount_begin(&tsk->mems_allowed_seq);
+	write_seqcount_begin(&tsk->sysram_nodes_seq);
 
-	nodes_or(tsk->mems_allowed, tsk->mems_allowed, *newmems);
+	nodes_or(tsk->sysram_nodes, tsk->sysram_nodes, *newmems);
 	mpol_rebind_task(tsk, newmems);
-	tsk->mems_allowed = *newmems;
+	tsk->sysram_nodes = *newmems;
 
-	write_seqcount_end(&tsk->mems_allowed_seq);
+	write_seqcount_end(&tsk->sysram_nodes_seq);
 	local_irq_enable();
 
 	task_unlock(tsk);
@@ -2709,9 +2709,9 @@ static void *cpuset_being_rebound;
 
 /**
  * cpuset_update_tasks_nodemask - Update the nodemasks of tasks in the cpuset.
- * @cs: the cpuset in which each task's mems_allowed mask needs to be changed
+ * @cs: the cpuset in which each task's sysram_nodes mask needs to be changed
  *
- * Iterate through each task of @cs updating its mems_allowed to the
+ * Iterate through each task of @cs updating its sysram_nodes to the
  * effective cpuset's.  As this function is called with cpuset_mutex held,
  * cpuset membership stays stable.
  */
@@ -3763,7 +3763,7 @@ static void cpuset_fork(struct task_struct *task)
 			return;
 
 		set_cpus_allowed_ptr(task, current->cpus_ptr);
-		task->mems_allowed = current->mems_allowed;
+		task->sysram_nodes = current->sysram_nodes;
 		return;
 	}
 
@@ -4205,9 +4205,9 @@ bool cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 	return changed;
 }
 
-void __init cpuset_init_current_mems_allowed(void)
+void __init cpuset_init_current_sysram_nodes(void)
 {
-	nodes_setall(current->mems_allowed);
+	nodes_setall(current->sysram_nodes);
 }
 
 /**
@@ -4233,14 +4233,14 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
 }
 
 /**
- * cpuset_nodemask_valid_mems_allowed - check nodemask vs. current mems_allowed
+ * cpuset_nodemask_valid_sysram_nodes - check nodemask vs. current sysram_nodes
  * @nodemask: the nodemask to be checked
  *
- * Are any of the nodes in the nodemask allowed in current->mems_allowed?
+ * Are any of the nodes in the nodemask allowed in current->sysram_nodes?
  */
-int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask)
+int cpuset_nodemask_valid_sysram_nodes(const nodemask_t *nodemask)
 {
-	return nodes_intersects(*nodemask, current->mems_allowed);
+	return nodes_intersects(*nodemask, current->sysram_nodes);
 }
 
 /*
@@ -4262,7 +4262,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  * @gfp_mask: memory allocation flags
  *
  * If we're in interrupt, yes, we can always allocate.  If @node is set in
- * current's mems_allowed, yes.  If it's not a __GFP_HARDWALL request and this
+ * current's sysram_nodes, yes.  If it's not a __GFP_HARDWALL request and this
  * node is set in the nearest hardwalled cpuset ancestor to current's cpuset,
  * yes.  If current has access to memory reserves as an oom victim, yes.
  * Otherwise, no.
@@ -4276,7 +4276,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  * Scanning up parent cpusets requires callback_lock.  The
  * __alloc_pages() routine only calls here with __GFP_HARDWALL bit
  * _not_ set if it's a GFP_KERNEL allocation, and all nodes in the
- * current tasks mems_allowed came up empty on the first pass over
+ * current tasks sysram_nodes came up empty on the first pass over
  * the zonelist.  So only GFP_KERNEL allocations, if all nodes in the
  * cpuset are short of memory, might require taking the callback_lock.
  *
@@ -4304,7 +4304,7 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 
 	if (in_interrupt())
 		return true;
-	if (node_isset(node, current->mems_allowed))
+	if (node_isset(node, current->sysram_nodes))
 		return true;
 	/*
 	 * Allow tasks that have access to memory reserves because they have
@@ -4375,13 +4375,13 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
  * certain page cache or slab cache pages such as used for file
  * system buffers and inode caches, then instead of starting on the
  * local node to look for a free page, rather spread the starting
- * node around the tasks mems_allowed nodes.
+ * node around the tasks sysram_nodes nodes.
  *
  * We don't have to worry about the returned node being offline
  * because "it can't happen", and even if it did, it would be ok.
  *
  * The routines calling guarantee_online_mems() are careful to
- * only set nodes in task->mems_allowed that are online.  So it
+ * only set nodes in task->sysram_nodes that are online.  So it
  * should not be possible for the following code to return an
  * offline node.  But if it did, that would be ok, as this routine
  * is not returning the node where the allocation must be, only
@@ -4392,7 +4392,7 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
  */
 static int cpuset_spread_node(int *rotor)
 {
-	return *rotor = next_node_in(*rotor, current->mems_allowed);
+	return *rotor = next_node_in(*rotor, current->sysram_nodes);
 }
 
 /**
@@ -4402,35 +4402,35 @@ int cpuset_mem_spread_node(void)
 {
 	if (current->cpuset_mem_spread_rotor == NUMA_NO_NODE)
 		current->cpuset_mem_spread_rotor =
-			node_random(&current->mems_allowed);
+			node_random(&current->sysram_nodes);
 
 	return cpuset_spread_node(&current->cpuset_mem_spread_rotor);
 }
 
 /**
- * cpuset_mems_allowed_intersects - Does @tsk1's mems_allowed intersect @tsk2's?
+ * cpuset_sysram_nodes_intersects - Does @tsk1's sysram_nodes intersect @tsk2's?
  * @tsk1: pointer to task_struct of some task.
  * @tsk2: pointer to task_struct of some other task.
  *
- * Description: Return true if @tsk1's mems_allowed intersects the
- * mems_allowed of @tsk2.  Used by the OOM killer to determine if
+ * Description: Return true if @tsk1's sysram_nodes intersects the
+ * sysram_nodes of @tsk2.  Used by the OOM killer to determine if
  * one of the task's memory usage might impact the memory available
  * to the other.
  **/
 
-int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
+int cpuset_sysram_nodes_intersects(const struct task_struct *tsk1,
 				   const struct task_struct *tsk2)
 {
-	return nodes_intersects(tsk1->mems_allowed, tsk2->mems_allowed);
+	return nodes_intersects(tsk1->sysram_nodes, tsk2->sysram_nodes);
 }
 
 /**
- * cpuset_print_current_mems_allowed - prints current's cpuset and mems_allowed
+ * cpuset_print_current_sysram_nodes - prints current's cpuset and sysram_nodes
  *
  * Description: Prints current's name, cpuset name, and cached copy of its
- * mems_allowed to the kernel log.
+ * sysram_nodes to the kernel log.
  */
-void cpuset_print_current_mems_allowed(void)
+void cpuset_print_current_sysram_nodes(void)
 {
 	struct cgroup *cgrp;
 
@@ -4439,17 +4439,17 @@ void cpuset_print_current_mems_allowed(void)
 	cgrp = task_cs(current)->css.cgroup;
 	pr_cont(",cpuset=");
 	pr_cont_cgroup_name(cgrp);
-	pr_cont(",mems_allowed=%*pbl",
-		nodemask_pr_args(&current->mems_allowed));
+	pr_cont(",sysram_nodes=%*pbl",
+		nodemask_pr_args(&current->sysram_nodes));
 
 	rcu_read_unlock();
 }
 
-/* Display task mems_allowed in /proc/<pid>/status file. */
-void cpuset_task_status_allowed(struct seq_file *m, struct task_struct *task)
+/* Display task sysram_nodes in /proc/<pid>/status file. */
+void cpuset_task_status_sysram(struct seq_file *m, struct task_struct *task)
 {
-	seq_printf(m, "Mems_allowed:\t%*pb\n",
-		   nodemask_pr_args(&task->mems_allowed));
-	seq_printf(m, "Mems_allowed_list:\t%*pbl\n",
-		   nodemask_pr_args(&task->mems_allowed));
+	seq_printf(m, "Sysram_nodes:\t%*pb\n",
+		   nodemask_pr_args(&task->sysram_nodes));
+	seq_printf(m, "Sysram_nodes_list:\t%*pbl\n",
+		   nodemask_pr_args(&task->sysram_nodes));
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 3da0f08615a9..9ca2b59d7f0e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2120,7 +2120,7 @@ __latent_entropy struct task_struct *copy_process(
 #endif
 #ifdef CONFIG_CPUSETS
 	p->cpuset_mem_spread_rotor = NUMA_NO_NODE;
-	seqcount_spinlock_init(&p->mems_allowed_seq, &p->alloc_lock);
+	seqcount_spinlock_init(&p->sysram_nodes_seq, &p->alloc_lock);
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	memset(&p->irqtrace, 0, sizeof(p->irqtrace));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5b752324270b..667c53fc3954 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3317,8 +3317,8 @@ static void task_numa_work(struct callback_head *work)
 	 * Memory is pinned to only one NUMA node via cpuset.mems, naturally
 	 * no page can be migrated.
 	 */
-	if (cpusets_enabled() && nodes_weight(cpuset_current_mems_allowed) == 1) {
-		trace_sched_skip_cpuset_numa(current, &cpuset_current_mems_allowed);
+	if (cpusets_enabled() && nodes_weight(cpuset_current_sysram_nodes) == 1) {
+		trace_sched_skip_cpuset_numa(current, &cpuset_current_sysram_nodes);
 		return;
 	}
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0455119716ec..0d16890c1a4f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2366,7 +2366,7 @@ static nodemask_t *policy_mbind_nodemask(gfp_t gfp)
 	 */
 	if (mpol->mode == MPOL_BIND &&
 		(apply_policy_zone(mpol, gfp_zone(gfp)) &&
-		 cpuset_nodemask_valid_mems_allowed(&mpol->nodes)))
+		 cpuset_nodemask_valid_sysram_nodes(&mpol->nodes)))
 		return &mpol->nodes;
 #endif
 	return NULL;
@@ -2389,9 +2389,9 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 
 	mbind_nodemask = policy_mbind_nodemask(htlb_alloc_mask(h));
 	if (mbind_nodemask)
-		nodes_and(alloc_nodemask, *mbind_nodemask, cpuset_current_mems_allowed);
+		nodes_and(alloc_nodemask, *mbind_nodemask, cpuset_current_sysram_nodes);
 	else
-		alloc_nodemask = cpuset_current_mems_allowed;
+		alloc_nodemask = cpuset_current_sysram_nodes;
 
 	lockdep_assert_held(&hugetlb_lock);
 	needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
@@ -5084,7 +5084,7 @@ static unsigned int allowed_mems_nr(struct hstate *h)
 	gfp_t gfp_mask = htlb_alloc_mask(h);
 
 	mbind_nodemask = policy_mbind_nodemask(gfp_mask);
-	for_each_node_mask(node, cpuset_current_mems_allowed) {
+	for_each_node_mask(node, cpuset_current_sysram_nodes) {
 		if (!mbind_nodemask || node_isset(node, *mbind_nodemask))
 			nr += array[node];
 	}
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index eb83cff7db8c..735dabb9c50c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -396,7 +396,7 @@ static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
  * any, for the new policy.  mpol_new() has already validated the nodes
  * parameter with respect to the policy mode and flags.
  *
- * Must be called holding task's alloc_lock to protect task's mems_allowed
+ * Must be called holding task's alloc_lock to protect task's sysram_nodes
  * and mempolicy.  May also be called holding the mmap_lock for write.
  */
 static int mpol_set_nodemask(struct mempolicy *pol,
@@ -414,7 +414,7 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 
 	/* Check N_MEMORY */
 	nodes_and(nsc->mask1,
-		  cpuset_current_mems_allowed, node_states[N_MEMORY]);
+		  cpuset_current_sysram_nodes, node_states[N_MEMORY]);
 
 	VM_BUG_ON(!nodes);
 
@@ -426,7 +426,7 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 	if (mpol_store_user_nodemask(pol))
 		pol->w.user_nodemask = *nodes;
 	else
-		pol->w.cpuset_mems_allowed = cpuset_current_mems_allowed;
+		pol->w.cpuset_sysram_nodes = cpuset_current_sysram_nodes;
 
 	ret = mpol_ops[pol->mode].create(pol, &nsc->mask2);
 	return ret;
@@ -501,9 +501,9 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 	else if (pol->flags & MPOL_F_RELATIVE_NODES)
 		mpol_relative_nodemask(&tmp, &pol->w.user_nodemask, nodes);
 	else {
-		nodes_remap(tmp, pol->nodes, pol->w.cpuset_mems_allowed,
+		nodes_remap(tmp, pol->nodes, pol->w.cpuset_sysram_nodes,
 								*nodes);
-		pol->w.cpuset_mems_allowed = *nodes;
+		pol->w.cpuset_sysram_nodes = *nodes;
 	}
 
 	if (nodes_empty(tmp))
@@ -515,14 +515,14 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 static void mpol_rebind_preferred(struct mempolicy *pol,
 						const nodemask_t *nodes)
 {
-	pol->w.cpuset_mems_allowed = *nodes;
+	pol->w.cpuset_sysram_nodes = *nodes;
 }
 
 /*
  * mpol_rebind_policy - Migrate a policy to a different set of nodes
  *
  * Per-vma policies are protected by mmap_lock. Allocations using per-task
- * policies are protected by task->mems_allowed_seq to prevent a premature
+ * policies are protected by task->sysram_nodes_seq to prevent a premature
  * OOM/allocation failure due to parallel nodemask modification.
  */
 static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
@@ -530,7 +530,7 @@ static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
 	if (!pol || pol->mode == MPOL_LOCAL)
 		return;
 	if (!mpol_store_user_nodemask(pol) &&
-	    nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
+	    nodes_equal(pol->w.cpuset_sysram_nodes, *newmask))
 		return;
 
 	mpol_ops[pol->mode].rebind(pol, newmask);
@@ -1086,7 +1086,7 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 			return -EINVAL;
 		*policy = 0;	/* just so it's initialized */
 		task_lock(current);
-		*nmask  = cpuset_current_mems_allowed;
+		*nmask  = cpuset_current_sysram_nodes;
 		task_unlock(current);
 		return 0;
 	}
@@ -2029,7 +2029,7 @@ static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
 	unsigned int cpuset_mems_cookie;
 
 retry:
-	/* to prevent miscount use tsk->mems_allowed_seq to detect rebind */
+	/* to prevent miscount use tsk->sysram_nodes_seq to detect rebind */
 	cpuset_mems_cookie = read_mems_allowed_begin();
 	node = current->il_prev;
 	if (!current->il_weight || !node_isset(node, policy->nodes)) {
@@ -2051,7 +2051,7 @@ static unsigned int interleave_nodes(struct mempolicy *policy)
 	unsigned int nid;
 	unsigned int cpuset_mems_cookie;
 
-	/* to prevent miscount, use tsk->mems_allowed_seq to detect rebind */
+	/* to prevent miscount, use tsk->sysram_nodes_seq to detect rebind */
 	do {
 		cpuset_mems_cookie = read_mems_allowed_begin();
 		nid = next_node_in(current->il_prev, policy->nodes);
@@ -2118,7 +2118,7 @@ static unsigned int read_once_policy_nodemask(struct mempolicy *pol,
 	/*
 	 * barrier stabilizes the nodemask locally so that it can be iterated
 	 * over safely without concern for changes. Allocators validate node
-	 * selection does not violate mems_allowed, so this is safe.
+	 * selection does not violate sysram_nodes, so this is safe.
 	 */
 	barrier();
 	memcpy(mask, &pol->nodes, sizeof(nodemask_t));
@@ -2210,7 +2210,7 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
 	case MPOL_BIND:
 		/* Restrict to nodemask (but not on lower zones) */
 		if (apply_policy_zone(pol, gfp_zone(gfp)) &&
-		    cpuset_nodemask_valid_mems_allowed(&pol->nodes))
+		    cpuset_nodemask_valid_sysram_nodes(&pol->nodes))
 			nodemask = &pol->nodes;
 		if (pol->home_node != NUMA_NO_NODE)
 			*nid = pol->home_node;
@@ -2738,7 +2738,7 @@ int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
 /*
  * If mpol_dup() sees current->cpuset == cpuset_being_rebound, then it
  * rebinds the mempolicy its copying by calling mpol_rebind_policy()
- * with the mems_allowed returned by cpuset_mems_allowed().  This
+ * with the sysram_nodes returned by cpuset_mems_allowed().  This
  * keeps mempolicies cpuset relative after its cpuset moves.  See
  * further kernel/cpuset.c update_nodemask().
  *
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 386b4ceeaeb8..9d13580c21ef 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -110,7 +110,7 @@ static bool oom_cpuset_eligible(struct task_struct *start,
 			 * This is not a mempolicy constrained oom, so only
 			 * check the mems of tsk's cpuset.
 			 */
-			ret = cpuset_mems_allowed_intersects(current, tsk);
+			ret = cpuset_sysram_nodes_intersects(current, tsk);
 		}
 		if (ret)
 			break;
@@ -300,7 +300,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 
 	if (cpuset_limited) {
 		oc->totalpages = total_swap_pages;
-		for_each_node_mask(nid, cpuset_current_mems_allowed)
+		for_each_node_mask(nid, cpuset_current_sysram_nodes)
 			oc->totalpages += node_present_pages(nid);
 		return CONSTRAINT_CPUSET;
 	}
@@ -451,7 +451,7 @@ static void dump_oom_victim(struct oom_control *oc, struct task_struct *victim)
 	pr_info("oom-kill:constraint=%s,nodemask=%*pbl",
 			oom_constraint_text[oc->constraint],
 			nodemask_pr_args(oc->nodemask));
-	cpuset_print_current_mems_allowed();
+	cpuset_print_current_sysram_nodes();
 	mem_cgroup_print_oom_context(oc->memcg, victim);
 	pr_cont(",task=%s,pid=%d,uid=%d\n", victim->comm, victim->pid,
 		from_kuid(&init_user_ns, task_uid(victim)));
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ea6a50f6079..e1257cb7aea4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3964,7 +3964,7 @@ void warn_alloc(gfp_t gfp_mask, const nodemask_t *nodemask, const char *fmt, ...
 			nodemask_pr_args(nodemask));
 	va_end(args);
 
-	cpuset_print_current_mems_allowed();
+	cpuset_print_current_sysram_nodes();
 	pr_cont("\n");
 	dump_stack();
 	warn_alloc_show_mem(gfp_mask, nodemask);
@@ -4601,7 +4601,7 @@ static inline bool
 check_retry_cpuset(int cpuset_mems_cookie, struct alloc_context *ac)
 {
 	/*
-	 * It's possible that cpuset's mems_allowed and the nodemask from
+	 * It's possible that cpuset's sysram_nodes and the nodemask from
 	 * mempolicy don't intersect. This should be normally dealt with by
 	 * policy_nodemask(), but it's possible to race with cpuset update in
 	 * such a way the check therein was true, and then it became false
@@ -4612,13 +4612,13 @@ check_retry_cpuset(int cpuset_mems_cookie, struct alloc_context *ac)
 	 * caller can deal with a violated nodemask.
 	 */
 	if (cpusets_enabled() && ac->nodemask &&
-			!cpuset_nodemask_valid_mems_allowed(ac->nodemask)) {
+			!cpuset_nodemask_valid_sysram_nodes(ac->nodemask)) {
 		ac->nodemask = mt_sysram_nodemask();
 		return true;
 	}
 
 	/*
-	 * When updating a task's mems_allowed or mempolicy nodemask, it is
+	 * When updating a task's sysram_nodes or mempolicy nodemask, it is
 	 * possible to race with parallel threads in such a way that our
 	 * allocation can fail while the mask is being updated. If we are about
 	 * to fail, check if the cpuset changed during allocation and if so,
@@ -4702,7 +4702,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (cpusets_insane_config() && (gfp_mask & __GFP_HARDWALL)) {
 		struct zoneref *z = first_zones_zonelist(ac->zonelist,
 					ac->highest_zoneidx,
-					&cpuset_current_mems_allowed);
+					&cpuset_current_sysram_nodes);
 		if (!zonelist_zone(z))
 			goto nopage;
 	}
@@ -4946,7 +4946,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 		 * to the current task context. It means that any node ok.
 		 */
 		if (in_task() && !ac->nodemask)
-			ac->nodemask = &cpuset_current_mems_allowed;
+			ac->nodemask = &cpuset_current_sysram_nodes;
 		else
 			*alloc_flags |= ALLOC_CPUSET;
 	} else if (!ac->nodemask) /* sysram_nodes may be NULL during __init */
@@ -5194,7 +5194,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 
 	/*
 	 * Restore the original nodemask if it was potentially replaced with
-	 * &cpuset_current_mems_allowed to optimize the fast-path attempt.
+	 * &cpuset_current_sysram_nodes to optimize the fast-path attempt.
 	 *
 	 * If not set, default to sysram nodes.
 	 */
@@ -5819,7 +5819,7 @@ build_all_zonelists_init(void)
 		per_cpu_pages_init(&per_cpu(boot_pageset, cpu), &per_cpu(boot_zonestats, cpu));
 
 	mminit_verify_zonelist();
-	cpuset_init_current_mems_allowed();
+	cpuset_init_current_sysram_nodes();
 }
 
 /*
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 24685b5c6dcf..ca7b6872c3d8 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -128,7 +128,7 @@ static bool show_mem_node_skip(unsigned int flags, int nid,
 	 * have to be precise here.
 	 */
 	if (!nodemask)
-		nodemask = &cpuset_current_mems_allowed;
+		nodemask = &cpuset_current_sysram_nodes;
 
 	return !node_isset(nid, *nodemask);
 }
-- 
2.51.1


