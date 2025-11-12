Return-Path: <linux-fsdevel+bounces-68093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89674C543A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAFF3BCAED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 19:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49925352F9A;
	Wed, 12 Nov 2025 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XQPrCBO0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04727B50F
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975813; cv=none; b=s8ir5xHz+3+onFWPm6+aI1xl17aXMeCF78J6fhz3Ky3zhD+hjQDe4E/FfidE5ZN+8NrWFrkgEBrVQUcL+F0IrHidGzsneh59+4TevrZDex58nbaeporndP7akim6MA6n7O4cOal85v8uMD3wrDaFuyY7kINuDbq5vafggfEo3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975813; c=relaxed/simple;
	bh=6BwwMBgEL/VCSv0hU+JRwWUReqTxvIqTXz0u7krmCXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWb/Soq7tBMm8KRQjvMkMx7iFvsPijVNEcmbEao3phGGi0QRl6xYt1AdMiT+ydYgtxKJ+ZnrsyZB1Wch72awveUn53w1Xqc6PT8JrZWAgJ1UZ9QuQPQKPrWqvK30j6SYEa84k9Tp3+0Gse1ezex6+4PXM+VkCGH9zFPQMuWuo/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XQPrCBO0; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b22a30986fso3527885a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 11:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975809; x=1763580609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3IcU6Qzmbokcc6SWwuh5Ibj7p8oAnPPqespIDCjwME=;
        b=XQPrCBO0XBRF/9jTJbtRssz1MKYQsSHIe7/dNbwmBS+o8gmseH5+6xK4eOm4h/no/h
         9jgkZCLLFuDzrObX0jC15tVmLm0PHyQKlMRnZdiHuuGlqYgf7SM24vAj6t91O1sqmmFI
         B90I9yNZPr8WxHJa6gva3D9PBBFJpvDj8MiaMiQcmZEBCv3n/k2zN9CSZy9d9Eih57hE
         aBmZMPtg8/4ikO9+znv4tj2pE8yEzaxD7fzcpYzTTvRtr1bdIusmFQT+rzIgcETcvvbH
         zL98EBhIlgXplKyAP/NH0YewQ2Tncd+hURWUHogc1pYBsbDp/1CmP/tZGiHVxKJ3sEgy
         GgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975809; x=1763580609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q3IcU6Qzmbokcc6SWwuh5Ibj7p8oAnPPqespIDCjwME=;
        b=vjCMKoMdqtkelw4DJPPeeaF37l+B0n/QjUo+ETCOFuGWJhVrqCDvoDIugkSCg6ZuGH
         Ez6yxsaa3gaBgd7NHqZtmQQNFw2eQdoOBeQ8uYxk7kSlXFJZKxqiViVD7P2sSfnwmO0n
         E1OXeyd6stK/9ipJ8Mo1RdXkDOlUJWTm9Z1hkrcefiG4RcgSRjXZFc44lHoyy8Hz6f50
         I0KurkteOF63HLhklMZpe71IjawKLiTZHZQP9lw5LmxuQszCV4sQHtPoB6gtw0dM5S6e
         mXxMNBeSF8khmSBaoOQex17MVmcGPJ+SJy1rEe2cENFvaQgyRcWOv584WsitkaloqOgU
         +ieA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ4uGankLrcktaP7zeCV93qq87BTX3qjW4K/L6C8z6yEEd5BGEag3EonP8ICTrqcS9nYFY16zX0JVspVtJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxB2YVivGsJJzxj6JU33/XOQo8ojhwEZ5yI7V2ZcuZCWa6m2oP1
	uF2tsTHzbooqs3QahsNZ+QdnkjzWoObzHhHlW0KKodaMWlw/4TxqsV4S+rt4ClkQwZQ=
X-Gm-Gg: ASbGnct9kZZNKmGsWDG2kgBtbl8SLtsaqMUd/CQ/P+FHIgInqet4q0CIDYjpHh3nxDK
	qoWpROHqZX+MKKEY5WElcfOq/kzAQz/LYvnuyO779pCuMANStxJCFe8YEbRLjwveK61Nuv1aDN4
	7mXDcca54x6FQ920H9bq29npclP+QGsFO5V9wGrMxH1brSQq1k0X3jWFf+jeporZY62tiwy9xPJ
	NTARe9vjtPE/xtp3vLoo6JXLNB0GHYs8qAnEaR4dlEA06qJc4fUpMo4ji4CVjv0j4p5d9hrfvMW
	Je8a6tYrXOAag1rJLFwS88/+zb64ecMroN6DYLcR2HxSw7O0NTa7cz8NR/jQKvMkFnpP9yUPPCo
	Y+KAABYHUIcoazJqmpqy1pKcjWrZF21CsFdUTdnA3XG+V3EQ8YJ0NSrR1B0UOuKiqpj0jNh0icY
	ntOf9cGmKn7Vwo5HjR2dZ+DLUVXd4LwKf8G8vgr6jq6YHmzrZ3TepdD1jtx+0hlnhyPzZ7XPoHF
	4A=
X-Google-Smtp-Source: AGHT+IGzXDA3pFOlRkp+KwBypVXBUVkP9rTexoWChXscaSu4KBqspgRTeSQKPufdx+F4Isa7aW22uA==
X-Received: by 2002:a05:620a:f05:b0:86e:ff4e:d55e with SMTP id af79cd13be357-8b29b78aa43mr510566785a.39.1762975809008;
        Wed, 12 Nov 2025 11:30:09 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:30:08 -0800 (PST)
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
Subject: [RFC PATCH v2 07/11] cpuset: introduce cpuset.mems.sysram
Date: Wed, 12 Nov 2025 14:29:23 -0500
Message-ID: <20251112192936.2574429-8-gourry@gourry.net>
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

mems_sysram contains only SystemRAM nodes (omitting SPM Nodes). The
nodelist is effectively intersect(effective_mems, mt_sysram_nodelist).

When checking mems_allowed, check for GFP_SPM_NODE to determine if
the check should be made against mems_sysram or mems_allowed, since
mems_sysram only contains sysram nodes.

This omits "Specific Purpose Memory Nodes" from default mems_allowed
checks, making those nodes unreachable via "normal" allocation paths
(page faults, mempolicies, etc).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/cpuset.h          |  8 ++--
 kernel/cgroup/cpuset-internal.h |  8 ++++
 kernel/cgroup/cpuset-v1.c       |  7 +++
 kernel/cgroup/cpuset.c          | 84 ++++++++++++++++++++++++---------
 mm/memcontrol.c                 |  3 +-
 mm/mempolicy.c                  |  6 +--
 mm/migrate.c                    |  4 +-
 7 files changed, 88 insertions(+), 32 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 9baaf19431b5..375bf446b66e 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -77,7 +77,7 @@ extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern bool cpuset_cpu_is_isolated(int cpu);
-extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
+extern nodemask_t cpuset_sysram_nodes_allowed(struct task_struct *p);
 #define cpuset_current_sysram_nodes (current->sysram_nodes)
 #define cpuset_current_mems_allowed (cpuset_current_sysram_nodes)
 void cpuset_init_current_sysram_nodes(void);
@@ -174,7 +174,7 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 	task_unlock(current);
 }
 
-extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
+extern bool cpuset_sysram_node_allowed(struct cgroup *cgroup, int nid);
 #else /* !CONFIG_CPUSETS */
 
 static inline bool cpusets_enabled(void) { return false; }
@@ -212,7 +212,7 @@ static inline bool cpuset_cpu_is_isolated(int cpu)
 	return false;
 }
 
-static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
+static inline nodemask_t cpuset_sysram_nodes_allowed(struct task_struct *p)
 {
 	return node_possible_map;
 }
@@ -296,7 +296,7 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
 	return false;
 }
 
-static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+static inline bool cpuset_sysram_node_allowed(struct cgroup *cgroup, int nid)
 {
 	return true;
 }
diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 337608f408ce..64e48fe040ed 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -53,6 +53,7 @@ typedef enum {
 	FILE_MEMORY_MIGRATE,
 	FILE_CPULIST,
 	FILE_MEMLIST,
+	FILE_MEMS_SYSRAM,
 	FILE_EFFECTIVE_CPULIST,
 	FILE_EFFECTIVE_MEMLIST,
 	FILE_SUBPARTS_CPULIST,
@@ -104,6 +105,13 @@ struct cpuset {
 	cpumask_var_t effective_cpus;
 	nodemask_t effective_mems;
 
+	/*
+	 * SystemRAM Memory Nodes for tasks.
+	 * This is the intersection of effective_mems and mt_sysram_nodelist.
+	 * Tasks will have their sysram_nodes set to this value.
+	 */
+	nodemask_t mems_sysram;
+
 	/*
 	 * Exclusive CPUs dedicated to current cgroup (default hierarchy only)
 	 *
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 12e76774c75b..c58215d7230e 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -293,6 +293,7 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->mems_allowed = *new_mems;
 	cs->effective_mems = *new_mems;
+	cpuset_update_tasks_nodemask(cs);
 	cpuset_callback_unlock_irq();
 
 	/*
@@ -532,6 +533,12 @@ struct cftype cpuset1_files[] = {
 		.private = FILE_EFFECTIVE_MEMLIST,
 	},
 
+	{
+		.name = "mems_sysram",
+		.seq_show = cpuset_common_seq_show,
+		.private = FILE_MEMS_SYSRAM,
+	},
+
 	{
 		.name = "cpu_exclusive",
 		.read_u64 = cpuset_read_u64,
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f0c59621a7f2..e08b59a0cf99 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -29,6 +29,7 @@
 #include <linux/mempolicy.h>
 #include <linux/mm.h>
 #include <linux/memory.h>
+#include <linux/memory-tiers.h>
 #include <linux/export.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
@@ -428,11 +429,11 @@ static void guarantee_active_cpus(struct task_struct *tsk,
  *
  * Call with callback_lock or cpuset_mutex held.
  */
-static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
+static void guarantee_online_sysram_nodes(struct cpuset *cs, nodemask_t *pmask)
 {
-	while (!nodes_intersects(cs->effective_mems, node_states[N_MEMORY]))
+	while (!nodes_intersects(cs->mems_sysram, node_states[N_MEMORY]))
 		cs = parent_cs(cs);
-	nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]);
+	nodes_and(*pmask, cs->mems_sysram, node_states[N_MEMORY]);
 }
 
 /**
@@ -2723,7 +2724,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
 
 	cpuset_being_rebound = cs;		/* causes mpol_dup() rebind */
 
-	guarantee_online_mems(cs, &newmems);
+	guarantee_online_sysram_nodes(cs, &newmems);
 
 	/*
 	 * The mpol_rebind_mm() call takes mmap_lock, which we couldn't
@@ -2748,7 +2749,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
 
 		migrate = is_memory_migrate(cs);
 
-		mpol_rebind_mm(mm, &cs->mems_allowed);
+		mpol_rebind_mm(mm, &cs->mems_sysram);
 		if (migrate)
 			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
 		else
@@ -2808,6 +2809,7 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 
 		spin_lock_irq(&callback_lock);
 		cp->effective_mems = *new_mems;
+		mt_nodemask_sysram_mask(&cp->mems_sysram, &cp->effective_mems);
 		spin_unlock_irq(&callback_lock);
 
 		WARN_ON(!is_in_v2_mode() &&
@@ -3234,11 +3236,11 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * by skipping the task iteration and update.
 	 */
 	if (cpuset_v2() && !cpus_updated && !mems_updated) {
-		cpuset_attach_nodemask_to = cs->effective_mems;
+		cpuset_attach_nodemask_to = cs->mems_sysram;
 		goto out;
 	}
 
-	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
+	guarantee_online_sysram_nodes(cs, &cpuset_attach_nodemask_to);
 
 	cgroup_taskset_for_each(task, css, tset)
 		cpuset_attach_task(cs, task);
@@ -3249,7 +3251,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
 	 * not set.
 	 */
-	cpuset_attach_nodemask_to = cs->effective_mems;
+	cpuset_attach_nodemask_to = cs->mems_sysram;
 	if (!is_memory_migrate(cs) && !mems_updated)
 		goto out;
 
@@ -3371,6 +3373,9 @@ int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	case FILE_EFFECTIVE_MEMLIST:
 		seq_printf(sf, "%*pbl\n", nodemask_pr_args(&cs->effective_mems));
 		break;
+	case FILE_MEMS_SYSRAM:
+		seq_printf(sf, "%*pbl\n", nodemask_pr_args(&cs->mems_sysram));
+		break;
 	case FILE_EXCLUSIVE_CPULIST:
 		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs->exclusive_cpus));
 		break;
@@ -3482,6 +3487,12 @@ static struct cftype dfl_files[] = {
 		.private = FILE_EFFECTIVE_MEMLIST,
 	},
 
+	{
+		.name = "mems.sysram",
+		.seq_show = cpuset_common_seq_show,
+		.private = FILE_MEMS_SYSRAM,
+	},
+
 	{
 		.name = "cpus.partition",
 		.seq_show = cpuset_partition_show,
@@ -3585,6 +3596,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	if (is_in_v2_mode()) {
 		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
 		cs->effective_mems = parent->effective_mems;
+		mt_nodemask_sysram_mask(&cs->mems_sysram, &cs->effective_mems);
 	}
 	spin_unlock_irq(&callback_lock);
 
@@ -3616,6 +3628,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	spin_lock_irq(&callback_lock);
 	cs->mems_allowed = parent->mems_allowed;
 	cs->effective_mems = parent->mems_allowed;
+	mt_nodemask_sysram_mask(&cs->mems_sysram, &cs->effective_mems);
 	cpumask_copy(cs->cpus_allowed, parent->cpus_allowed);
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
 	spin_unlock_irq(&callback_lock);
@@ -3769,7 +3782,7 @@ static void cpuset_fork(struct task_struct *task)
 
 	/* CLONE_INTO_CGROUP */
 	mutex_lock(&cpuset_mutex);
-	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
+	guarantee_online_sysram_nodes(cs, &cpuset_attach_nodemask_to);
 	cpuset_attach_task(cs, task);
 
 	dec_attach_in_progress_locked(cs);
@@ -3818,7 +3831,8 @@ int __init cpuset_init(void)
 	cpumask_setall(top_cpuset.effective_xcpus);
 	cpumask_setall(top_cpuset.exclusive_cpus);
 	nodes_setall(top_cpuset.effective_mems);
-
+	mt_nodemask_sysram_mask(&top_cpuset.mems_sysram,
+				&top_cpuset.effective_mems);
 	fmeter_init(&top_cpuset.fmeter);
 	INIT_LIST_HEAD(&remote_children);
 
@@ -3848,6 +3862,7 @@ hotplug_update_tasks(struct cpuset *cs,
 	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->effective_mems = *new_mems;
+	mt_nodemask_sysram_mask(&cs->mems_sysram, &cs->effective_mems);
 	spin_unlock_irq(&callback_lock);
 
 	if (cpus_updated)
@@ -4039,6 +4054,8 @@ static void cpuset_handle_hotplug(void)
 		if (!on_dfl)
 			top_cpuset.mems_allowed = new_mems;
 		top_cpuset.effective_mems = new_mems;
+		mt_nodemask_sysram_mask(&top_cpuset.mems_sysram,
+					&top_cpuset.effective_mems);
 		spin_unlock_irq(&callback_lock);
 		cpuset_update_tasks_nodemask(&top_cpuset);
 	}
@@ -4109,6 +4126,8 @@ void __init cpuset_init_smp(void)
 
 	cpumask_copy(top_cpuset.effective_cpus, cpu_active_mask);
 	top_cpuset.effective_mems = node_states[N_MEMORY];
+	mt_nodemask_sysram_mask(&top_cpuset.mems_sysram,
+				&top_cpuset.effective_mems);
 
 	hotplug_node_notifier(cpuset_track_online_nodes, CPUSET_CALLBACK_PRI);
 
@@ -4205,14 +4224,18 @@ bool cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 	return changed;
 }
 
+/*
+ * At this point in time, no hotplug nodes can have been added, so just set
+ * the sysram_nodes of the init task to the set of N_MEMORY nodes.
+ */
 void __init cpuset_init_current_sysram_nodes(void)
 {
-	nodes_setall(current->sysram_nodes);
+	current->sysram_nodes = node_states[N_MEMORY];
 }
 
 /**
- * cpuset_mems_allowed - return mems_allowed mask from a tasks cpuset.
- * @tsk: pointer to task_struct from which to obtain cpuset->mems_allowed.
+ * cpuset_sysram_nodes_allowed - return mems_sysram mask from a tasks cpuset.
+ * @tsk: pointer to task_struct from which to obtain cpuset->mems_sysram.
  *
  * Description: Returns the nodemask_t mems_allowed of the cpuset
  * attached to the specified @tsk.  Guaranteed to return some non-empty
@@ -4220,13 +4243,13 @@ void __init cpuset_init_current_sysram_nodes(void)
  * tasks cpuset.
  **/
 
-nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
+nodemask_t cpuset_sysram_nodes_allowed(struct task_struct *tsk)
 {
 	nodemask_t mask;
 	unsigned long flags;
 
 	spin_lock_irqsave(&callback_lock, flags);
-	guarantee_online_mems(task_cs(tsk), &mask);
+	guarantee_online_sysram_nodes(task_cs(tsk), &mask);
 	spin_unlock_irqrestore(&callback_lock, flags);
 
 	return mask;
@@ -4295,17 +4318,30 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  *	tsk_is_oom_victim   - any node ok
  *	GFP_KERNEL   - any node in enclosing hardwalled cpuset ok
  *	GFP_USER     - only nodes in current tasks mems allowed ok.
+ *	GFP_SPM_NODE - allow specific purpose memory nodes in mems_allowed
  */
 bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 {
 	struct cpuset *cs;		/* current cpuset ancestors */
 	bool allowed;			/* is allocation in zone z allowed? */
 	unsigned long flags;
+	bool sp_node = gfp_mask & __GFP_SPM_NODE;
 
+	/* Only SysRAM nodes are valid in interrupt context */
 	if (in_interrupt())
-		return true;
-	if (node_isset(node, current->sysram_nodes))
-		return true;
+		return (!sp_node || node_isset(node, mt_sysram_nodelist));
+
+	if (sp_node) {
+		rcu_read_lock();
+		cs = task_cs(current);
+		allowed = node_isset(node, cs->mems_allowed);
+		rcu_read_unlock();
+	} else
+		allowed = node_isset(node, current->sysram_nodes);
+
+	if (allowed)
+		return allowed;
+
 	/*
 	 * Allow tasks that have access to memory reserves because they have
 	 * been OOM killed to get memory anywhere.
@@ -4324,11 +4360,15 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	cs = nearest_hardwall_ancestor(task_cs(current));
 	allowed = node_isset(node, cs->mems_allowed);
 
+	/* If not a SP Node allocation, restrict to sysram nodes */
+	if (!sp_node && !nodes_empty(mt_sysram_nodelist))
+		allowed &= node_isset(node, mt_sysram_nodelist);
+
 	spin_unlock_irqrestore(&callback_lock, flags);
 	return allowed;
 }
 
-bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+bool cpuset_sysram_node_allowed(struct cgroup *cgroup, int nid)
 {
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
@@ -4347,7 +4387,7 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
 		return true;
 
 	/*
-	 * Normally, accessing effective_mems would require the cpuset_mutex
+	 * Normally, accessing mems_sysram would require the cpuset_mutex
 	 * or callback_lock - but node_isset is atomic and the reference
 	 * taken via cgroup_get_e_css is sufficient to protect css.
 	 *
@@ -4359,7 +4399,7 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
 	 * cannot make strong isolation guarantees, so this is acceptable.
 	 */
 	cs = container_of(css, struct cpuset, css);
-	allowed = node_isset(nid, cs->effective_mems);
+	allowed = node_isset(nid, cs->mems_sysram);
 	css_put(css);
 	return allowed;
 }
@@ -4380,7 +4420,7 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
  * We don't have to worry about the returned node being offline
  * because "it can't happen", and even if it did, it would be ok.
  *
- * The routines calling guarantee_online_mems() are careful to
+ * The routines calling guarantee_online_sysram_nodes() are careful to
  * only set nodes in task->sysram_nodes that are online.  So it
  * should not be possible for the following code to return an
  * offline node.  But if it did, that would be ok, as this routine
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4deda33625f4..7cac7ff013a7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5599,5 +5599,6 @@ subsys_initcall(mem_cgroup_swap_init);
 
 bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
 {
-	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
+	return memcg ? cpuset_sysram_node_allowed(memcg->css.cgroup, nid) :
+		       true;
 }
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 735dabb9c50c..e1e8a1f3e1a2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1831,14 +1831,14 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 	}
 	rcu_read_unlock();
 
-	task_nodes = cpuset_mems_allowed(task);
+	task_nodes = cpuset_sysram_nodes_allowed(task);
 	/* Is the user allowed to access the target nodes? */
 	if (!nodes_subset(*new, task_nodes) && !capable(CAP_SYS_NICE)) {
 		err = -EPERM;
 		goto out_put;
 	}
 
-	task_nodes = cpuset_mems_allowed(current);
+	task_nodes = cpuset_sysram_nodes_allowed(current);
 	nodes_and(*new, *new, task_nodes);
 	if (nodes_empty(*new))
 		goto out_put;
@@ -2763,7 +2763,7 @@ struct mempolicy *__mpol_dup(struct mempolicy *old)
 		*new = *old;
 
 	if (current_cpuset_is_being_rebound()) {
-		nodemask_t mems = cpuset_mems_allowed(current);
+		nodemask_t mems = cpuset_sysram_nodes_allowed(current);
 		mpol_rebind_policy(new, &mems);
 	}
 	atomic_set(&new->refcnt, 1);
diff --git a/mm/migrate.c b/mm/migrate.c
index c0e9f15be2a2..c612f05d23db 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2526,7 +2526,7 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
 	 */
 	if (!pid) {
 		mmget(current->mm);
-		*mem_nodes = cpuset_mems_allowed(current);
+		*mem_nodes = cpuset_sysram_nodes_allowed(current);
 		return current->mm;
 	}
 
@@ -2547,7 +2547,7 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
 	mm = ERR_PTR(security_task_movememory(task));
 	if (IS_ERR(mm))
 		goto out;
-	*mem_nodes = cpuset_mems_allowed(task);
+	*mem_nodes = cpuset_sysram_nodes_allowed(task);
 	mm = get_task_mm(task);
 out:
 	put_task_struct(task);
-- 
2.51.1


