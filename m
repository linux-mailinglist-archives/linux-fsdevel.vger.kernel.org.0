Return-Path: <linux-fsdevel+bounces-67509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79061C41E33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 23:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B44E42492A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 22:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7866D31B108;
	Fri,  7 Nov 2025 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nQkohUek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053233168E3
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555820; cv=none; b=ITP9e0JmhGnFGEpa5bqLS+vDk9XYs8kUnJD7JTO/VkjPEYj5bMXed9cbZkaVdzVicRlgy9OCCE193S7/8czDGZu47rEPZjJW4Ob28or8+Df8ZBa6C85kIhmsmnUZtnVrS3c0lY1V/DnD/Qj+R9uDI2wE9w2/6Gy0r9F2toEJWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555820; c=relaxed/simple;
	bh=lYyosdIoxbYz9w3axtqL+tKU9BPiew89f1fkMy8IB4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiudrK/usyw0erBEBSNS6g3kV6HPmfiQHJQSP5eNALp5DwyI2+90DZD4+Iywr8wbrPbUPNDOGP6PdsgaEKnAkIg3zV9jCbx/7lZjWAF26MOtBpufkYrESTjoIxPePzlBO8MyQnXOEb4KDt7fQJgVOZtYf/u979bwRl5YUBemNZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nQkohUek; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4eb75e8e47eso9831671cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 14:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555816; x=1763160616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUZfKkcQDm2rldv2E+n8EfZ5kq8cLFn+9GIspSUABkM=;
        b=nQkohUekZsb2KBTkEfp5FggdQlo2qZBDxCjTxKnY6EueqpdnxNVKBPOggTFRC69JEr
         G5es6JaR9FjBABS627yLnx/CMtVLL2PADJ9EY2fdDPrO5Q6SJ7Toms9WCTvJnsCRXfqy
         Q7kCwOU6ebcjDX0mgKDIVRAyShUFyY2eGSz9dn0wd16vLkMAKPDRNAlR190N0eELvLwb
         tZu8ESRtogVWK93qP8+BFRgpKYYa6qtNF/bNCC0MrAGCUjNSp4PbjI43+Ylez21MjbpH
         xjbzNcLOF8LjguuFd5tWVqYGBW6HD/QadmNmWmNatntJ4vYmycs6ow6jevj8zyaJTVcA
         cC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555816; x=1763160616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MUZfKkcQDm2rldv2E+n8EfZ5kq8cLFn+9GIspSUABkM=;
        b=eGCZ/pZ2ftlMcgISETbHVoqvQifTVFA14/Jg/6eLNE8T6KkvfQcTkv0/JfDISOTFAt
         0zxaOv/Fslo4alRw6xXut8EoOXfYnwLZZDkftwdFzjgC4vHzCKZc1Es4BZiYK9gCEPIb
         7sfJWTuPdJK82je2YWP/E1hi0AZ6NbzH83/epT0jjyYa5TWM+7tj69Mpnw4rdbv44Ms2
         e2OMwbOg58mcsJIECWr0WS/Xc1xvKEbCn4hbES0r23wYGV8JJNub50qYTY+WNHdK3dgf
         1cNS8RXazYsyqKTAClZ+bvbH3QInWKHP8QgDldbCq3OjR26ELzYTTF8vI0mitHb6xkXa
         JyRw==
X-Forwarded-Encrypted: i=1; AJvYcCX+IQtKzpi1aHZwo4Dwks3wcVTFJ9hU+INm8YfsbzkPbsRN+VePi46MDMx8mE8/iTIBWsdWKH9Kd7qyYg7p@vger.kernel.org
X-Gm-Message-State: AOJu0YzIn89JR3m0/BPEFbkFQKx1qB6mM7jrGFPeS7WoZ/AljYQy3xna
	/qhjh0NG3iuVTZsCIN5d7bsFyDOXxpN6daGeHnLFIUPrvUYaa5BU4UbiwwmePEEZYgU=
X-Gm-Gg: ASbGncu9obTi36coRvtZsoQIYwYjnfbhRaoB5CJqibHFOXkiolCWjkWW9q7pM4cxXje
	//YiH2z94zqTDVDtVbIYaSwI8ghuUMcM88UbX4JLrj4NS4Dh17tc5LhxSLvKpb2VgOnfYrxy5Qa
	2AXsLFXpU/X/wAZnnDrSIbpCHzI13oMI0fl+eEEA6+gdLljEOEjgAtKns3jTC4XoKOi5WPcWwpz
	sSJSX7gsEmPZLK5Ru3sTPfsoTx1QxVGXpUQ9UtdfM8ph6QI0Yll4vqY2YFZvP8NV4KLEKfsCjGY
	V74g82S25mhBBbrv+odzRVGc3rRbw4lWcBq4T7IKo9J0IjjbrusxR5RUm1B3tfY8A8QdsefKIgT
	v6rhKxykabF3UwvZXxZ11sUZ8yRRnX8mWHMk8RINI9xm0E6PY4t/d2bkMDwLuiKJRacnJEyjvBE
	ZEiguWXXoHc4ojju3RXy0/adRLsDllJ8M3nkRRau8ItM2jrPOH4jEBzQd5lsMi8ndajRlxlD/kM
	Sc=
X-Google-Smtp-Source: AGHT+IFz/blXd9uV2Aa3F8JuKC9IAZbCzpSeju9CfCdhKPQLRQFdfy2AiTWji4h3P7jkP+8z3jZsKg==
X-Received: by 2002:a05:622a:118f:b0:4cb:9ad0:9978 with SMTP id d75a77b69052e-4eda413916dmr18499681cf.30.1762555815604;
        Fri, 07 Nov 2025 14:50:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:14 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
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
Subject: [RFC PATCH 4/9] mm,cpusets: rename task->mems_allowed to task->mems_default
Date: Fri,  7 Nov 2025 17:49:49 -0500
Message-ID: <20251107224956.477056-5-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107224956.477056-1-gourry@gourry.net>
References: <20251107224956.477056-1-gourry@gourry.net>
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

Rename task->mems_allowed to task->mems_default for two reasons.

1) To detach the task->mems_allowed and cpuset.mems_allowed naming
   scheme and make it clear the two fields may contain different values.

2) To enable mems_allowed to contain memory nodes which may not be
   present in effective_mems due to being "Special Purpose" nodes
   which require explicit GFP flags to allocate from (implemented
   in a future patch in this series).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 fs/proc/array.c           |  2 +-
 include/linux/cpuset.h    | 44 +++++++++++-----------
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
 mm/vmscan.c               |  2 +-
 14 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 2ae63189091e..3929d7cf65d5 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -456,7 +456,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	task_cap(m, task);
 	task_seccomp(m, task);
 	task_cpus_allowed(m, task);
-	cpuset_task_status_allowed(m, task);
+	cpuset_task_status_default(m, task);
 	task_context_switch_counts(m, task);
 	arch_proc_pid_thread_features(m, task);
 	return 0;
diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 548eaf7ef8d0..4db08c580cc3 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -23,14 +23,14 @@
 /*
  * Static branch rewrites can happen in an arbitrary order for a given
  * key. In code paths where we need to loop with read_mems_allowed_begin() and
- * read_mems_allowed_retry() to get a consistent view of mems_allowed, we need
+ * read_mems_allowed_retry() to get a consistent view of mems_default, we need
  * to ensure that begin() always gets rewritten before retry() in the
  * disabled -> enabled transition. If not, then if local irqs are disabled
  * around the loop, we can deadlock since retry() would always be
- * comparing the latest value of the mems_allowed seqcount against 0 as
+ * comparing the latest value of the mems_default seqcount against 0 as
  * begin() still would see cpusets_enabled() as false. The enabled -> disabled
  * transition should happen in reverse order for the same reasons (want to stop
- * looking at real value of mems_allowed.sequence in retry() first).
+ * looking at real value of mems_default.sequence in retry() first).
  */
 extern struct static_key_false cpusets_pre_enable_key;
 extern struct static_key_false cpusets_enabled_key;
@@ -78,9 +78,9 @@ extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern bool cpuset_cpu_is_isolated(int cpu);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
-#define cpuset_current_mems_allowed (current->mems_allowed)
-void cpuset_init_current_mems_allowed(void);
-int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask);
+#define cpuset_current_mems_default (current->mems_default)
+void cpuset_init_current_mems_default(void);
+int cpuset_nodemask_valid_mems_default(const nodemask_t *nodemask);
 
 extern bool cpuset_current_node_allowed(int node, gfp_t gfp_mask);
 
@@ -96,7 +96,7 @@ static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 	return true;
 }
 
-extern int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
+extern int cpuset_mems_default_intersects(const struct task_struct *tsk1,
 					  const struct task_struct *tsk2);
 
 #ifdef CONFIG_CPUSETS_V1
@@ -111,7 +111,7 @@ extern void __cpuset_memory_pressure_bump(void);
 static inline void cpuset_memory_pressure_bump(void) { }
 #endif
 
-extern void cpuset_task_status_allowed(struct seq_file *m,
+extern void cpuset_task_status_default(struct seq_file *m,
 					struct task_struct *task);
 extern int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
 			    struct pid *pid, struct task_struct *tsk);
@@ -128,12 +128,12 @@ extern bool current_cpuset_is_being_rebound(void);
 extern void dl_rebuild_rd_accounting(void);
 extern void rebuild_sched_domains(void);
 
-extern void cpuset_print_current_mems_allowed(void);
+extern void cpuset_print_current_mems_default(void);
 extern void cpuset_reset_sched_domains(void);
 
 /*
  * read_mems_allowed_begin is required when making decisions involving
- * mems_allowed such as during page allocation. mems_allowed can be updated in
+ * mems_default such as during page allocation. mems_default can be updated in
  * parallel and depending on the new value an operation can fail potentially
  * causing process failure. A retry loop with read_mems_allowed_begin and
  * read_mems_allowed_retry prevents these artificial failures.
@@ -143,13 +143,13 @@ static inline unsigned int read_mems_allowed_begin(void)
 	if (!static_branch_unlikely(&cpusets_pre_enable_key))
 		return 0;
 
-	return read_seqcount_begin(&current->mems_allowed_seq);
+	return read_seqcount_begin(&current->mems_default_seq);
 }
 
 /*
  * If this returns true, the operation that took place after
  * read_mems_allowed_begin may have failed artificially due to a concurrent
- * update of mems_allowed. It is up to the caller to retry the operation if
+ * update of mems_default. It is up to the caller to retry the operation if
  * appropriate.
  */
 static inline bool read_mems_allowed_retry(unsigned int seq)
@@ -157,7 +157,7 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
 	if (!static_branch_unlikely(&cpusets_enabled_key))
 		return false;
 
-	return read_seqcount_retry(&current->mems_allowed_seq, seq);
+	return read_seqcount_retry(&current->mems_default_seq, seq);
 }
 
 static inline void set_mems_allowed(nodemask_t nodemask)
@@ -166,9 +166,9 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 
 	task_lock(current);
 	local_irq_save(flags);
-	write_seqcount_begin(&current->mems_allowed_seq);
-	current->mems_allowed = nodemask;
-	write_seqcount_end(&current->mems_allowed_seq);
+	write_seqcount_begin(&current->mems_default_seq);
+	current->mems_default = nodemask;
+	write_seqcount_end(&current->mems_default_seq);
 	local_irq_restore(flags);
 	task_unlock(current);
 }
@@ -216,10 +216,10 @@ static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
 	return node_possible_map;
 }
 
-#define cpuset_current_mems_allowed (node_states[N_MEMORY])
-static inline void cpuset_init_current_mems_allowed(void) {}
+#define cpuset_current_mems_default (node_states[N_MEMORY])
+static inline void cpuset_init_current_mems_default(void) {}
 
-static inline int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask)
+static inline int cpuset_nodemask_valid_mems_default(const nodemask_t *nodemask)
 {
 	return 1;
 }
@@ -234,7 +234,7 @@ static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 	return true;
 }
 
-static inline int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
+static inline int cpuset_mems_default_intersects(const struct task_struct *tsk1,
 						 const struct task_struct *tsk2)
 {
 	return 1;
@@ -242,7 +242,7 @@ static inline int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
 
 static inline void cpuset_memory_pressure_bump(void) {}
 
-static inline void cpuset_task_status_allowed(struct seq_file *m,
+static inline void cpuset_task_status_default(struct seq_file *m,
 						struct task_struct *task)
 {
 }
@@ -276,7 +276,7 @@ static inline void cpuset_reset_sched_domains(void)
 	partition_sched_domains(1, NULL, NULL);
 }
 
-static inline void cpuset_print_current_mems_allowed(void)
+static inline void cpuset_print_current_mems_default(void)
 {
 }
 
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 0fe96f3ab3ef..f1a6ab8ac383 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -52,7 +52,7 @@ struct mempolicy {
 	int home_node;		/* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
 
 	union {
-		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
+		nodemask_t cpuset_mems_default;	/* relative to these nodes */
 		nodemask_t user_nodemask;	/* nodemask passed by user */
 	} w;
 };
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b469878de25c..e7030c0dfc60 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1223,7 +1223,7 @@ struct task_struct {
 	u64				parent_exec_id;
 	u64				self_exec_id;
 
-	/* Protection against (de-)allocation: mm, files, fs, tty, keyrings, mems_allowed, mempolicy: */
+	/* Protection against (de-)allocation: mm, files, fs, tty, keyrings, mems_default, mempolicy: */
 	spinlock_t			alloc_lock;
 
 	/* Protection of the PI data structures: */
@@ -1314,9 +1314,9 @@ struct task_struct {
 #endif
 #ifdef CONFIG_CPUSETS
 	/* Protected by ->alloc_lock: */
-	nodemask_t			mems_allowed;
+	nodemask_t			mems_default;
 	/* Sequence number to catch updates: */
-	seqcount_spinlock_t		mems_allowed_seq;
+	seqcount_spinlock_t		mems_default_seq;
 	int				cpuset_mem_spread_rotor;
 #endif
 #ifdef CONFIG_CGROUPS
diff --git a/init/init_task.c b/init/init_task.c
index a55e2189206f..6aaeb25327af 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -173,7 +173,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.trc_blkd_node = LIST_HEAD_INIT(init_task.trc_blkd_node),
 #endif
 #ifdef CONFIG_CPUSETS
-	.mems_allowed_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
+	.mems_default_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_default_seq,
 						 &init_task.alloc_lock),
 #endif
 #ifdef CONFIG_RT_MUTEXES
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index cd3e2ae83d70..b05c07489a4d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -240,7 +240,7 @@ static struct cpuset top_cpuset = {
  * If a task is only holding callback_lock, then it has read-only
  * access to cpusets.
  *
- * Now, the task_struct fields mems_allowed and mempolicy may be changed
+ * Now, the task_struct fields mems_default and mempolicy may be changed
  * by other task, we use alloc_lock in the task_struct fields to protect
  * them.
  *
@@ -2678,11 +2678,11 @@ static void schedule_flush_migrate_mm(void)
 }
 
 /*
- * cpuset_change_task_nodemask - change task's mems_allowed and mempolicy
+ * cpuset_change_task_nodemask - change task's mems_default and mempolicy
  * @tsk: the task to change
  * @newmems: new nodes that the task will be set
  *
- * We use the mems_allowed_seq seqlock to safely update both tsk->mems_allowed
+ * We use the mems_default_seq seqlock to safely update both tsk->mems_default
  * and rebind an eventual tasks' mempolicy. If the task is allocating in
  * parallel, it might temporarily see an empty intersection, which results in
  * a seqlock check and retry before OOM or allocation failure.
@@ -2693,13 +2693,13 @@ static void cpuset_change_task_nodemask(struct task_struct *tsk,
 	task_lock(tsk);
 
 	local_irq_disable();
-	write_seqcount_begin(&tsk->mems_allowed_seq);
+	write_seqcount_begin(&tsk->mems_default_seq);
 
-	nodes_or(tsk->mems_allowed, tsk->mems_allowed, *newmems);
+	nodes_or(tsk->mems_default, tsk->mems_default, *newmems);
 	mpol_rebind_task(tsk, newmems);
-	tsk->mems_allowed = *newmems;
+	tsk->mems_default = *newmems;
 
-	write_seqcount_end(&tsk->mems_allowed_seq);
+	write_seqcount_end(&tsk->mems_default_seq);
 	local_irq_enable();
 
 	task_unlock(tsk);
@@ -2709,9 +2709,9 @@ static void *cpuset_being_rebound;
 
 /**
  * cpuset_update_tasks_nodemask - Update the nodemasks of tasks in the cpuset.
- * @cs: the cpuset in which each task's mems_allowed mask needs to be changed
+ * @cs: the cpuset in which each task's mems_default mask needs to be changed
  *
- * Iterate through each task of @cs updating its mems_allowed to the
+ * Iterate through each task of @cs updating its mems_default to the
  * effective cpuset's.  As this function is called with cpuset_mutex held,
  * cpuset membership stays stable.
  */
@@ -3763,7 +3763,7 @@ static void cpuset_fork(struct task_struct *task)
 			return;
 
 		set_cpus_allowed_ptr(task, current->cpus_ptr);
-		task->mems_allowed = current->mems_allowed;
+		task->mems_default = current->mems_default;
 		return;
 	}
 
@@ -4205,9 +4205,9 @@ bool cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 	return changed;
 }
 
-void __init cpuset_init_current_mems_allowed(void)
+void __init cpuset_init_current_mems_default(void)
 {
-	nodes_setall(current->mems_allowed);
+	nodes_setall(current->mems_default);
 }
 
 /**
@@ -4233,14 +4233,14 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
 }
 
 /**
- * cpuset_nodemask_valid_mems_allowed - check nodemask vs. current mems_allowed
+ * cpuset_nodemask_valid_mems_default - check nodemask vs. current mems_default
  * @nodemask: the nodemask to be checked
  *
- * Are any of the nodes in the nodemask allowed in current->mems_allowed?
+ * Are any of the nodes in the nodemask allowed in current->mems_default?
  */
-int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask)
+int cpuset_nodemask_valid_mems_default(const nodemask_t *nodemask)
 {
-	return nodes_intersects(*nodemask, current->mems_allowed);
+	return nodes_intersects(*nodemask, current->mems_default);
 }
 
 /*
@@ -4262,7 +4262,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  * @gfp_mask: memory allocation flags
  *
  * If we're in interrupt, yes, we can always allocate.  If @node is set in
- * current's mems_allowed, yes.  If it's not a __GFP_HARDWALL request and this
+ * current's mems_default, yes.  If it's not a __GFP_HARDWALL request and this
  * node is set in the nearest hardwalled cpuset ancestor to current's cpuset,
  * yes.  If current has access to memory reserves as an oom victim, yes.
  * Otherwise, no.
@@ -4276,7 +4276,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  * Scanning up parent cpusets requires callback_lock.  The
  * __alloc_pages() routine only calls here with __GFP_HARDWALL bit
  * _not_ set if it's a GFP_KERNEL allocation, and all nodes in the
- * current tasks mems_allowed came up empty on the first pass over
+ * current tasks mems_default came up empty on the first pass over
  * the zonelist.  So only GFP_KERNEL allocations, if all nodes in the
  * cpuset are short of memory, might require taking the callback_lock.
  *
@@ -4304,7 +4304,7 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 
 	if (in_interrupt())
 		return true;
-	if (node_isset(node, current->mems_allowed))
+	if (node_isset(node, current->mems_default))
 		return true;
 	/*
 	 * Allow tasks that have access to memory reserves because they have
@@ -4375,13 +4375,13 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
  * certain page cache or slab cache pages such as used for file
  * system buffers and inode caches, then instead of starting on the
  * local node to look for a free page, rather spread the starting
- * node around the tasks mems_allowed nodes.
+ * node around the tasks mems_default nodes.
  *
  * We don't have to worry about the returned node being offline
  * because "it can't happen", and even if it did, it would be ok.
  *
  * The routines calling guarantee_online_mems() are careful to
- * only set nodes in task->mems_allowed that are online.  So it
+ * only set nodes in task->mems_default that are online.  So it
  * should not be possible for the following code to return an
  * offline node.  But if it did, that would be ok, as this routine
  * is not returning the node where the allocation must be, only
@@ -4392,7 +4392,7 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
  */
 static int cpuset_spread_node(int *rotor)
 {
-	return *rotor = next_node_in(*rotor, current->mems_allowed);
+	return *rotor = next_node_in(*rotor, current->mems_default);
 }
 
 /**
@@ -4402,35 +4402,35 @@ int cpuset_mem_spread_node(void)
 {
 	if (current->cpuset_mem_spread_rotor == NUMA_NO_NODE)
 		current->cpuset_mem_spread_rotor =
-			node_random(&current->mems_allowed);
+			node_random(&current->mems_default);
 
 	return cpuset_spread_node(&current->cpuset_mem_spread_rotor);
 }
 
 /**
- * cpuset_mems_allowed_intersects - Does @tsk1's mems_allowed intersect @tsk2's?
+ * cpuset_mems_default_intersects - Does @tsk1's mems_default intersect @tsk2's?
  * @tsk1: pointer to task_struct of some task.
  * @tsk2: pointer to task_struct of some other task.
  *
- * Description: Return true if @tsk1's mems_allowed intersects the
- * mems_allowed of @tsk2.  Used by the OOM killer to determine if
+ * Description: Return true if @tsk1's mems_default intersects the
+ * mems_default of @tsk2.  Used by the OOM killer to determine if
  * one of the task's memory usage might impact the memory available
  * to the other.
  **/
 
-int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
+int cpuset_mems_default_intersects(const struct task_struct *tsk1,
 				   const struct task_struct *tsk2)
 {
-	return nodes_intersects(tsk1->mems_allowed, tsk2->mems_allowed);
+	return nodes_intersects(tsk1->mems_default, tsk2->mems_default);
 }
 
 /**
- * cpuset_print_current_mems_allowed - prints current's cpuset and mems_allowed
+ * cpuset_print_current_mems_default - prints current's cpuset and mems_default
  *
  * Description: Prints current's name, cpuset name, and cached copy of its
- * mems_allowed to the kernel log.
+ * mems_default to the kernel log.
  */
-void cpuset_print_current_mems_allowed(void)
+void cpuset_print_current_mems_default(void)
 {
 	struct cgroup *cgrp;
 
@@ -4439,17 +4439,17 @@ void cpuset_print_current_mems_allowed(void)
 	cgrp = task_cs(current)->css.cgroup;
 	pr_cont(",cpuset=");
 	pr_cont_cgroup_name(cgrp);
-	pr_cont(",mems_allowed=%*pbl",
-		nodemask_pr_args(&current->mems_allowed));
+	pr_cont(",mems_default=%*pbl",
+		nodemask_pr_args(&current->mems_default));
 
 	rcu_read_unlock();
 }
 
-/* Display task mems_allowed in /proc/<pid>/status file. */
-void cpuset_task_status_allowed(struct seq_file *m, struct task_struct *task)
+/* Display task mems_default in /proc/<pid>/status file. */
+void cpuset_task_status_default(struct seq_file *m, struct task_struct *task)
 {
-	seq_printf(m, "Mems_allowed:\t%*pb\n",
-		   nodemask_pr_args(&task->mems_allowed));
-	seq_printf(m, "Mems_allowed_list:\t%*pbl\n",
-		   nodemask_pr_args(&task->mems_allowed));
+	seq_printf(m, "Mems_default:\t%*pb\n",
+		   nodemask_pr_args(&task->mems_default));
+	seq_printf(m, "Mems_default_list:\t%*pbl\n",
+		   nodemask_pr_args(&task->mems_default));
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 3da0f08615a9..26e4056ca9ac 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2120,7 +2120,7 @@ __latent_entropy struct task_struct *copy_process(
 #endif
 #ifdef CONFIG_CPUSETS
 	p->cpuset_mem_spread_rotor = NUMA_NO_NODE;
-	seqcount_spinlock_init(&p->mems_allowed_seq, &p->alloc_lock);
+	seqcount_spinlock_init(&p->mems_default_seq, &p->alloc_lock);
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	memset(&p->irqtrace, 0, sizeof(p->irqtrace));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb279..e50d79ba7ce9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3317,8 +3317,8 @@ static void task_numa_work(struct callback_head *work)
 	 * Memory is pinned to only one NUMA node via cpuset.mems, naturally
 	 * no page can be migrated.
 	 */
-	if (cpusets_enabled() && nodes_weight(cpuset_current_mems_allowed) == 1) {
-		trace_sched_skip_cpuset_numa(current, &cpuset_current_mems_allowed);
+	if (cpusets_enabled() && nodes_weight(cpuset_current_mems_default) == 1) {
+		trace_sched_skip_cpuset_numa(current, &cpuset_current_mems_default);
 		return;
 	}
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0455119716ec..7925a6973d09 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2366,7 +2366,7 @@ static nodemask_t *policy_mbind_nodemask(gfp_t gfp)
 	 */
 	if (mpol->mode == MPOL_BIND &&
 		(apply_policy_zone(mpol, gfp_zone(gfp)) &&
-		 cpuset_nodemask_valid_mems_allowed(&mpol->nodes)))
+		 cpuset_nodemask_valid_mems_default(&mpol->nodes)))
 		return &mpol->nodes;
 #endif
 	return NULL;
@@ -2389,9 +2389,9 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 
 	mbind_nodemask = policy_mbind_nodemask(htlb_alloc_mask(h));
 	if (mbind_nodemask)
-		nodes_and(alloc_nodemask, *mbind_nodemask, cpuset_current_mems_allowed);
+		nodes_and(alloc_nodemask, *mbind_nodemask, cpuset_current_mems_default);
 	else
-		alloc_nodemask = cpuset_current_mems_allowed;
+		alloc_nodemask = cpuset_current_mems_default;
 
 	lockdep_assert_held(&hugetlb_lock);
 	needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
@@ -5084,7 +5084,7 @@ static unsigned int allowed_mems_nr(struct hstate *h)
 	gfp_t gfp_mask = htlb_alloc_mask(h);
 
 	mbind_nodemask = policy_mbind_nodemask(gfp_mask);
-	for_each_node_mask(node, cpuset_current_mems_allowed) {
+	for_each_node_mask(node, cpuset_current_mems_default) {
 		if (!mbind_nodemask || node_isset(node, *mbind_nodemask))
 			nr += array[node];
 	}
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index eb83cff7db8c..6225d4d23010 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -396,7 +396,7 @@ static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
  * any, for the new policy.  mpol_new() has already validated the nodes
  * parameter with respect to the policy mode and flags.
  *
- * Must be called holding task's alloc_lock to protect task's mems_allowed
+ * Must be called holding task's alloc_lock to protect task's mems_default
  * and mempolicy.  May also be called holding the mmap_lock for write.
  */
 static int mpol_set_nodemask(struct mempolicy *pol,
@@ -414,7 +414,7 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 
 	/* Check N_MEMORY */
 	nodes_and(nsc->mask1,
-		  cpuset_current_mems_allowed, node_states[N_MEMORY]);
+		  cpuset_current_mems_default, node_states[N_MEMORY]);
 
 	VM_BUG_ON(!nodes);
 
@@ -426,7 +426,7 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 	if (mpol_store_user_nodemask(pol))
 		pol->w.user_nodemask = *nodes;
 	else
-		pol->w.cpuset_mems_allowed = cpuset_current_mems_allowed;
+		pol->w.cpuset_mems_default = cpuset_current_mems_default;
 
 	ret = mpol_ops[pol->mode].create(pol, &nsc->mask2);
 	return ret;
@@ -501,9 +501,9 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 	else if (pol->flags & MPOL_F_RELATIVE_NODES)
 		mpol_relative_nodemask(&tmp, &pol->w.user_nodemask, nodes);
 	else {
-		nodes_remap(tmp, pol->nodes, pol->w.cpuset_mems_allowed,
+		nodes_remap(tmp, pol->nodes, pol->w.cpuset_mems_default,
 								*nodes);
-		pol->w.cpuset_mems_allowed = *nodes;
+		pol->w.cpuset_mems_default = *nodes;
 	}
 
 	if (nodes_empty(tmp))
@@ -515,14 +515,14 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 static void mpol_rebind_preferred(struct mempolicy *pol,
 						const nodemask_t *nodes)
 {
-	pol->w.cpuset_mems_allowed = *nodes;
+	pol->w.cpuset_mems_default = *nodes;
 }
 
 /*
  * mpol_rebind_policy - Migrate a policy to a different set of nodes
  *
  * Per-vma policies are protected by mmap_lock. Allocations using per-task
- * policies are protected by task->mems_allowed_seq to prevent a premature
+ * policies are protected by task->mems_default_seq to prevent a premature
  * OOM/allocation failure due to parallel nodemask modification.
  */
 static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
@@ -530,7 +530,7 @@ static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
 	if (!pol || pol->mode == MPOL_LOCAL)
 		return;
 	if (!mpol_store_user_nodemask(pol) &&
-	    nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
+	    nodes_equal(pol->w.cpuset_mems_default, *newmask))
 		return;
 
 	mpol_ops[pol->mode].rebind(pol, newmask);
@@ -1086,7 +1086,7 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 			return -EINVAL;
 		*policy = 0;	/* just so it's initialized */
 		task_lock(current);
-		*nmask  = cpuset_current_mems_allowed;
+		*nmask  = cpuset_current_mems_default;
 		task_unlock(current);
 		return 0;
 	}
@@ -2029,7 +2029,7 @@ static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
 	unsigned int cpuset_mems_cookie;
 
 retry:
-	/* to prevent miscount use tsk->mems_allowed_seq to detect rebind */
+	/* to prevent miscount use tsk->mems_default_seq to detect rebind */
 	cpuset_mems_cookie = read_mems_allowed_begin();
 	node = current->il_prev;
 	if (!current->il_weight || !node_isset(node, policy->nodes)) {
@@ -2051,7 +2051,7 @@ static unsigned int interleave_nodes(struct mempolicy *policy)
 	unsigned int nid;
 	unsigned int cpuset_mems_cookie;
 
-	/* to prevent miscount, use tsk->mems_allowed_seq to detect rebind */
+	/* to prevent miscount, use tsk->mems_default_seq to detect rebind */
 	do {
 		cpuset_mems_cookie = read_mems_allowed_begin();
 		nid = next_node_in(current->il_prev, policy->nodes);
@@ -2118,7 +2118,7 @@ static unsigned int read_once_policy_nodemask(struct mempolicy *pol,
 	/*
 	 * barrier stabilizes the nodemask locally so that it can be iterated
 	 * over safely without concern for changes. Allocators validate node
-	 * selection does not violate mems_allowed, so this is safe.
+	 * selection does not violate mems_default, so this is safe.
 	 */
 	barrier();
 	memcpy(mask, &pol->nodes, sizeof(nodemask_t));
@@ -2210,7 +2210,7 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
 	case MPOL_BIND:
 		/* Restrict to nodemask (but not on lower zones) */
 		if (apply_policy_zone(pol, gfp_zone(gfp)) &&
-		    cpuset_nodemask_valid_mems_allowed(&pol->nodes))
+		    cpuset_nodemask_valid_mems_default(&pol->nodes))
 			nodemask = &pol->nodes;
 		if (pol->home_node != NUMA_NO_NODE)
 			*nid = pol->home_node;
@@ -2738,7 +2738,7 @@ int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
 /*
  * If mpol_dup() sees current->cpuset == cpuset_being_rebound, then it
  * rebinds the mempolicy its copying by calling mpol_rebind_policy()
- * with the mems_allowed returned by cpuset_mems_allowed().  This
+ * with the mems_default returned by cpuset_mems_allowed().  This
  * keeps mempolicies cpuset relative after its cpuset moves.  See
  * further kernel/cpuset.c update_nodemask().
  *
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index e0b6137835b2..a8f1f086d6a2 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -110,7 +110,7 @@ static bool oom_cpuset_eligible(struct task_struct *start,
 			 * This is not a mempolicy constrained oom, so only
 			 * check the mems of tsk's cpuset.
 			 */
-			ret = cpuset_mems_allowed_intersects(current, tsk);
+			ret = cpuset_mems_default_intersects(current, tsk);
 		}
 		if (ret)
 			break;
@@ -300,7 +300,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 
 	if (cpuset_limited) {
 		oc->totalpages = total_swap_pages;
-		for_each_node_mask(nid, cpuset_current_mems_allowed)
+		for_each_node_mask(nid, cpuset_current_mems_default)
 			oc->totalpages += node_present_pages(nid);
 		return CONSTRAINT_CPUSET;
 	}
@@ -451,7 +451,7 @@ static void dump_oom_victim(struct oom_control *oc, struct task_struct *victim)
 	pr_info("oom-kill:constraint=%s,nodemask=%*pbl",
 			oom_constraint_text[oc->constraint],
 			nodemask_pr_args(oc->nodemask));
-	cpuset_print_current_mems_allowed();
+	cpuset_print_current_mems_default();
 	mem_cgroup_print_oom_context(oc->memcg, victim);
 	pr_cont(",task=%s,pid=%d,uid=%d\n", victim->comm, victim->pid,
 		from_kuid(&init_user_ns, task_uid(victim)));
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 18213eacf974..a0c27fbb24bd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3963,7 +3963,7 @@ void warn_alloc(gfp_t gfp_mask, const nodemask_t *nodemask, const char *fmt, ...
 			nodemask_pr_args(nodemask));
 	va_end(args);
 
-	cpuset_print_current_mems_allowed();
+	cpuset_print_current_mems_default();
 	pr_cont("\n");
 	dump_stack();
 	warn_alloc_show_mem(gfp_mask, nodemask);
@@ -4599,7 +4599,7 @@ static inline bool
 check_retry_cpuset(int cpuset_mems_cookie, struct alloc_context *ac)
 {
 	/*
-	 * It's possible that cpuset's mems_allowed and the nodemask from
+	 * It's possible that cpuset's mems_default and the nodemask from
 	 * mempolicy don't intersect. This should be normally dealt with by
 	 * policy_nodemask(), but it's possible to race with cpuset update in
 	 * such a way the check therein was true, and then it became false
@@ -4610,13 +4610,13 @@ check_retry_cpuset(int cpuset_mems_cookie, struct alloc_context *ac)
 	 * caller can deal with a violated nodemask.
 	 */
 	if (cpusets_enabled() && ac->nodemask &&
-			!cpuset_nodemask_valid_mems_allowed(ac->nodemask)) {
+			!cpuset_nodemask_valid_mems_default(ac->nodemask)) {
 		ac->nodemask = default_sysram_nodes;
 		return true;
 	}
 
 	/*
-	 * When updating a task's mems_allowed or mempolicy nodemask, it is
+	 * When updating a task's mems_default or mempolicy nodemask, it is
 	 * possible to race with parallel threads in such a way that our
 	 * allocation can fail while the mask is being updated. If we are about
 	 * to fail, check if the cpuset changed during allocation and if so,
@@ -4700,7 +4700,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (cpusets_insane_config() && (gfp_mask & __GFP_HARDWALL)) {
 		struct zoneref *z = first_zones_zonelist(ac->zonelist,
 					ac->highest_zoneidx,
-					&cpuset_current_mems_allowed);
+					&cpuset_current_mems_default);
 		if (!zonelist_zone(z))
 			goto nopage;
 	}
@@ -4944,7 +4944,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 		 * to the current task context. It means that any node ok.
 		 */
 		if (in_task() && !ac->nodemask)
-			ac->nodemask = &cpuset_current_mems_allowed;
+			ac->nodemask = &cpuset_current_mems_default;
 		else
 			*alloc_flags |= ALLOC_CPUSET;
 	} else if (!ac->nodemask) /* sysram_nodes may be NULL during __init */
@@ -5191,7 +5191,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 
 	/*
 	 * Restore the original nodemask if it was potentially replaced with
-	 * &cpuset_current_mems_allowed to optimize the fast-path attempt.
+	 * &cpuset_current_mems_default to optimize the fast-path attempt.
 	 *
 	 * If not set, default to sysram nodes.
 	 */
@@ -5816,7 +5816,7 @@ build_all_zonelists_init(void)
 		per_cpu_pages_init(&per_cpu(boot_pageset, cpu), &per_cpu(boot_zonestats, cpu));
 
 	mminit_verify_zonelist();
-	cpuset_init_current_mems_allowed();
+	cpuset_init_current_mems_default();
 }
 
 /*
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 24685b5c6dcf..45dd35cae3fb 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -128,7 +128,7 @@ static bool show_mem_node_skip(unsigned int flags, int nid,
 	 * have to be precise here.
 	 */
 	if (!nodemask)
-		nodemask = &cpuset_current_mems_allowed;
+		nodemask = &cpuset_current_mems_default;
 
 	return !node_isset(nid, *nodemask);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 03e7f5206ad9..d7aa220b2707 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -355,7 +355,7 @@ static bool can_demote(int nid, struct scan_control *sc,
 	if (demotion_nid == NUMA_NO_NODE)
 		return false;
 
-	/* If demotion node isn't in the cgroup's mems_allowed, fall back */
+	/* If demotion node isn't in the cgroup's mems_default, fall back */
 	return mem_cgroup_node_allowed(memcg, demotion_nid);
 }
 
-- 
2.51.1


