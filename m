Return-Path: <linux-fsdevel+bounces-67510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B705C41E48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 23:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D20D24F7A71
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 22:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6C43081B8;
	Fri,  7 Nov 2025 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SdFbaD3m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604B8322C99
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555823; cv=none; b=FMkjSMFzkHvk/APXQj6cmpHq3E2tzPrPnpYvC6qvFiQd1ovGNxUP/m5TpnKH/oX06y6i/GeO4pCwXNCKOx628FFeHLdG8GOR0TSDrDC+hGdYhWL0tYWsZltJOf5nmKT88wG3B10TeLLBgwRAKaMeN/WipOvJMhGYjlRXWbRymFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555823; c=relaxed/simple;
	bh=koa/fjZCDlPKpidQ/k53aiyNwJ47G8p3nDbr9zi5tZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kb7IKPLqaVjEmZBjJuKYZBvqfvSarwBcEvjqxGpXa+jJH6UsdftZSzkycgRG7uUOtjsgbishhQANN+W9FJKWnGPsxJpkAA67PEcxH7XJTi4INw9dNboscgskufYdyajuoxeUqmDMOEZ9KIRGJJRO9bF0w8zV9zCBdfHFUczT8KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SdFbaD3m; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8a3eac7ca30so85908285a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 14:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555819; x=1763160619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQ93CDfHIH+oMfrkUgkIneMTo3fyJaVdZgvytoZjFWk=;
        b=SdFbaD3myu7kWMep+hqgptaQ1+u+3DqZwVJMflTKAunppZzKEwOXDjZavKbozVmXlR
         Nz3lhGYkiwOO6ksXzlwQ89/ygO3SuUe6GpHLL6TdkAXMlvV9US9f+xt/lUtatcXp7X6K
         Te4YIBNhZuqybO/11FT+n8b1QB+0KtNOAgmSSzcv1/3xOmbTwHydq7X7T/URRs7ecwiM
         nGPz4RpYrLvgx2tJlQjKyF8hNFJTX7xXwPq8icYgSw0VXIELwh95s+eOOXYoCndcl4qy
         SrUWczATpvvObpossYtMdkoP4lOxmlGXy6+LztfDpXPewGDbhjnBwKQqXkairdnKuZ6y
         31xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555819; x=1763160619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQ93CDfHIH+oMfrkUgkIneMTo3fyJaVdZgvytoZjFWk=;
        b=HMNJzb9qBR5eiZqud1S/qFEvlr3PvX9Pr6JA48GYRqBR/Rv5QQzPGL1tZUpX8whuSF
         2NAkKeVvaXk97CMzoub341X7wNsYTJ7UXwZkr9rS2hfRfoB8wH3JYiDX/QZUI//rMp73
         f4kC/H9Fr/ZARg3PQfM+NopeHJP4BYgGXy6F9pztBiNOQBgKQVSbmssLk/hRAuP6+mx+
         WxtV7wDmY25fIrGlqQPOOm3/6ZorPxwXXcBK/r5y6o30GyitdACT/274p9aziOTGhrlT
         tyJA2x/GGm630WK4gWjGF6iZp4LfKgOqq6WjV5xarXQcEdisEhzlwSZHPpnzAvNXNTnh
         M9ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+EgOnjj5Rjg0/bsHdadfJJ4c5jKOlZiWK0k5IveB3xpu2lobQDK/CB0fXkz82n1zY4CNHLUg0vMotGhnY@vger.kernel.org
X-Gm-Message-State: AOJu0YycUAjOAXaaT9SnJnN9fyxww8YDzT3VymBBdBSeTFToZ83reS8S
	F2UnI6GvqLswXKGSUxm2YZ6H7vBX0rkMd7fqr0XY1NXGzcb1ZV5uDbruhILVBCyBy3k=
X-Gm-Gg: ASbGncseKO3vsGJbQQkNeEtWAdH06YK95bON2J/eWV7q0hpfiXsBnnZsomSuJMAWfR9
	Xwb3BfSTdTVqIncBl6os86dhXqE+Mzl4nWQ8BlojyJXVAH9puAhCq+kMUEUlavT5OFu3n1Xfkgo
	wmk5k3A7SAXziB9wxC/kOh78yEi41rlJqeh7x9WUKjQdLcSVvLGFNdxPZfaU5qLx/Gvgw9v1XWT
	F4cxod1HoIsDDn2pu/ZR/gXzYUdupaalhRpKIZ3N/ckK30rshaEY7xHLYD131mojs3GeHOwq7VS
	3AsR8+fX064bqarfoi95OBOYzkvmBd/p3L8u0pcvbklMEjfJMwF58f654NNg1mEVjra2/8hns5x
	plnUPqOIe/E92ZGEP7xctL4wOyY9vmuGmnhF6U2UNlA9DvD2fthWAP1npgJ8irUP4Usb4TB67h1
	4VKAfdK4vUFV0P8dm/zBMhu86zZIYjwWOAyQxEgl764KUpdouFYUUvpfOO9Gnvm8GBYFDNWKqcz
	No=
X-Google-Smtp-Source: AGHT+IH4sjc29LnlFvFnAwWRtvFPqpVwQViV/HOTSPYo8yeihO6tfsYBX8y4H0P1XTIJN1n2ZtvtvA==
X-Received: by 2002:ac8:5a92:0:b0:4e8:b812:2e2a with SMTP id d75a77b69052e-4eda4e94134mr11669521cf.24.1762555819113;
        Fri, 07 Nov 2025 14:50:19 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:18 -0800 (PST)
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
Subject: [RFC PATCH 5/9] cpuset: introduce cpuset.mems.default
Date: Fri,  7 Nov 2025 17:49:50 -0500
Message-ID: <20251107224956.477056-6-gourry@gourry.net>
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

mems_default is intersect(effective_mems, default_sysram_nodes). This
allows hotplugged memory nodes to be marked "protected".  A protected
node's memory is not default-allocable via standard methods (basic
pages faults, mempolicies, etc).

When checking node_allowed, check for GFP_PROTECTED to determine if
the check should be made against mems_default or mems_allowed, since
mems_default only contains sysram nodes.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/cpuset.h          |  8 ++--
 kernel/cgroup/cpuset-internal.h |  8 ++++
 kernel/cgroup/cpuset-v1.c       |  7 +++
 kernel/cgroup/cpuset.c          | 83 ++++++++++++++++++++++++++-------
 mm/memcontrol.c                 |  2 +-
 mm/mempolicy.c                  |  8 ++--
 mm/migrate.c                    |  4 +-
 7 files changed, 93 insertions(+), 27 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 4db08c580cc3..7f683e4cf6c3 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -77,7 +77,7 @@ extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern bool cpuset_cpu_is_isolated(int cpu);
-extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
+extern nodemask_t cpuset_mems_default(struct task_struct *p);
 #define cpuset_current_mems_default (current->mems_default)
 void cpuset_init_current_mems_default(void);
 int cpuset_nodemask_valid_mems_default(const nodemask_t *nodemask);
@@ -173,7 +173,7 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 	task_unlock(current);
 }
 
-extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
+extern bool cpuset_node_default(struct cgroup *cgroup, int nid);
 #else /* !CONFIG_CPUSETS */
 
 static inline bool cpusets_enabled(void) { return false; }
@@ -211,7 +211,7 @@ static inline bool cpuset_cpu_is_isolated(int cpu)
 	return false;
 }
 
-static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
+static inline nodemask_t cpuset_mems_default(struct task_struct *p)
 {
 	return node_possible_map;
 }
@@ -294,7 +294,7 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
 	return false;
 }
 
-static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+static inline bool cpuset_node_default(struct cgroup *cgroup, int nid)
 {
 	return true;
 }
diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 337608f408ce..6978e04477b2 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -55,6 +55,7 @@ typedef enum {
 	FILE_MEMLIST,
 	FILE_EFFECTIVE_CPULIST,
 	FILE_EFFECTIVE_MEMLIST,
+	FILE_MEMS_DEFAULT,
 	FILE_SUBPARTS_CPULIST,
 	FILE_EXCLUSIVE_CPULIST,
 	FILE_EFFECTIVE_XCPULIST,
@@ -104,6 +105,13 @@ struct cpuset {
 	cpumask_var_t effective_cpus;
 	nodemask_t effective_mems;
 
+	/*
+	 * Default Memory Nodes for tasks.
+	 * This is the intersection of effective_mems and default_sysram_nodes.
+	 * Tasks will have their mems_default set to this value.
+	 */
+	nodemask_t mems_default;
+
 	/*
 	 * Exclusive CPUs dedicated to current cgroup (default hierarchy only)
 	 *
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 12e76774c75b..a06f2b032e0d 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -293,6 +293,7 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->mems_allowed = *new_mems;
 	cs->effective_mems = *new_mems;
+	cpuset_update_mems_default(cs);
 	cpuset_callback_unlock_irq();
 
 	/*
@@ -532,6 +533,12 @@ struct cftype cpuset1_files[] = {
 		.private = FILE_EFFECTIVE_MEMLIST,
 	},
 
+	{
+		.name = "mems_default",
+		.seq_show = cpuset_common_seq_show,
+		.private = FILE_MEMS_DEFAULT,
+	},
+
 	{
 		.name = "cpu_exclusive",
 		.read_u64 = cpuset_read_u64,
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b05c07489a4d..ea5ca1a05cf5 100644
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
@@ -430,9 +431,9 @@ static void guarantee_active_cpus(struct task_struct *tsk,
  */
 static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 {
-	while (!nodes_intersects(cs->effective_mems, node_states[N_MEMORY]))
+	while (!nodes_intersects(cs->mems_default, node_states[N_MEMORY]))
 		cs = parent_cs(cs);
-	nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]);
+	nodes_and(*pmask, cs->mems_default, node_states[N_MEMORY]);
 }
 
 /**
@@ -2748,7 +2749,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
 
 		migrate = is_memory_migrate(cs);
 
-		mpol_rebind_mm(mm, &cs->mems_allowed);
+		mpol_rebind_mm(mm, &cs->mems_default);
 		if (migrate)
 			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
 		else
@@ -2808,6 +2809,9 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 
 		spin_lock_irq(&callback_lock);
 		cp->effective_mems = *new_mems;
+		if (!nodes_empty(default_sysram_nodelist))
+			nodes_and(cp->mems_default, cp->effective_mems,
+				  default_sysram_nodelist);
 		spin_unlock_irq(&callback_lock);
 
 		WARN_ON(!is_in_v2_mode() &&
@@ -3234,7 +3238,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * by skipping the task iteration and update.
 	 */
 	if (cpuset_v2() && !cpus_updated && !mems_updated) {
-		cpuset_attach_nodemask_to = cs->effective_mems;
+		cpuset_attach_nodemask_to = cs->mems_default;
 		goto out;
 	}
 
@@ -3249,7 +3253,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
 	 * not set.
 	 */
-	cpuset_attach_nodemask_to = cs->effective_mems;
+	cpuset_attach_nodemask_to = cs->mems_default;
 	if (!is_memory_migrate(cs) && !mems_updated)
 		goto out;
 
@@ -3371,6 +3375,9 @@ int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	case FILE_EFFECTIVE_MEMLIST:
 		seq_printf(sf, "%*pbl\n", nodemask_pr_args(&cs->effective_mems));
 		break;
+	case FILE_MEMS_DEFAULT:
+		seq_printf(sf, "%*pbl\n", nodemask_pr_args(&cs->mems_default));
+		break;
 	case FILE_EXCLUSIVE_CPULIST:
 		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs->exclusive_cpus));
 		break;
@@ -3482,6 +3489,12 @@ static struct cftype dfl_files[] = {
 		.private = FILE_EFFECTIVE_MEMLIST,
 	},
 
+	{
+		.name = "mems.default",
+		.seq_show = cpuset_common_seq_show,
+		.private = FILE_MEMS_DEFAULT,
+	},
+
 	{
 		.name = "cpus.partition",
 		.seq_show = cpuset_partition_show,
@@ -3585,6 +3598,9 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	if (is_in_v2_mode()) {
 		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
 		cs->effective_mems = parent->effective_mems;
+		if (!nodes_empty(default_sysram_nodelist))
+			nodes_and(cs->mems_default, cs->effective_mems,
+				  default_sysram_nodelist);
 	}
 	spin_unlock_irq(&callback_lock);
 
@@ -3616,6 +3632,9 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	spin_lock_irq(&callback_lock);
 	cs->mems_allowed = parent->mems_allowed;
 	cs->effective_mems = parent->mems_allowed;
+	if (!nodes_empty(default_sysram_nodelist))
+		nodes_and(cs->mems_default, cs->effective_mems,
+			  default_sysram_nodelist);
 	cpumask_copy(cs->cpus_allowed, parent->cpus_allowed);
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
 	spin_unlock_irq(&callback_lock);
@@ -3818,6 +3837,9 @@ int __init cpuset_init(void)
 	cpumask_setall(top_cpuset.effective_xcpus);
 	cpumask_setall(top_cpuset.exclusive_cpus);
 	nodes_setall(top_cpuset.effective_mems);
+	if (!nodes_empty(default_sysram_nodelist))
+		nodes_and(top_cpuset.mems_default, top_cpuset.effective_mems,
+			  default_sysram_nodelist);
 
 	fmeter_init(&top_cpuset.fmeter);
 	INIT_LIST_HEAD(&remote_children);
@@ -3848,6 +3870,9 @@ hotplug_update_tasks(struct cpuset *cs,
 	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->effective_mems = *new_mems;
+	if (!nodes_empty(default_sysram_nodelist))
+		nodes_and(cs->mems_default, cs->effective_mems,
+			  default_sysram_nodelist);
 	spin_unlock_irq(&callback_lock);
 
 	if (cpus_updated)
@@ -4039,6 +4064,10 @@ static void cpuset_handle_hotplug(void)
 		if (!on_dfl)
 			top_cpuset.mems_allowed = new_mems;
 		top_cpuset.effective_mems = new_mems;
+		if (!nodes_empty(default_sysram_nodelist))
+			nodes_and(top_cpuset.mems_default,
+				  top_cpuset.effective_mems,
+				  default_sysram_nodelist);
 		spin_unlock_irq(&callback_lock);
 		cpuset_update_tasks_nodemask(&top_cpuset);
 	}
@@ -4109,6 +4138,9 @@ void __init cpuset_init_smp(void)
 
 	cpumask_copy(top_cpuset.effective_cpus, cpu_active_mask);
 	top_cpuset.effective_mems = node_states[N_MEMORY];
+	if (!nodes_empty(default_sysram_nodelist))
+		nodes_and(top_cpuset.mems_default, top_cpuset.effective_mems,
+			  default_sysram_nodelist);
 
 	hotplug_node_notifier(cpuset_track_online_nodes, CPUSET_CALLBACK_PRI);
 
@@ -4205,22 +4237,27 @@ bool cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 	return changed;
 }
 
+/*
+ * At this point in time, no hotplug nodes can have been added, so just set
+ * the mems_default of the init task to the set of N_MEMORY nodes.
+ */
 void __init cpuset_init_current_mems_default(void)
 {
-	nodes_setall(current->mems_default);
+	nodes_clear(current->mems_default);
+	nodes_or(current->mems_default, current->mems_default, node_states[N_MEMORY]);
 }
 
 /**
- * cpuset_mems_allowed - return mems_allowed mask from a tasks cpuset.
- * @tsk: pointer to task_struct from which to obtain cpuset->mems_allowed.
+ * cpuset_mems_default - return mems_default mask from a tasks cpuset.
+ * @tsk: pointer to task_struct from which to obtain cpuset->mems_default.
  *
- * Description: Returns the nodemask_t mems_allowed of the cpuset
+ * Description: Returns the nodemask_t mems_default of the cpuset
  * attached to the specified @tsk.  Guaranteed to return some non-empty
  * subset of node_states[N_MEMORY], even if this means going outside the
  * tasks cpuset.
  **/
 
-nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
+nodemask_t cpuset_mems_default(struct task_struct *tsk)
 {
 	nodemask_t mask;
 	unsigned long flags;
@@ -4295,17 +4332,29 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  *	tsk_is_oom_victim   - any node ok
  *	GFP_KERNEL   - any node in enclosing hardwalled cpuset ok
  *	GFP_USER     - only nodes in current tasks mems allowed ok.
+ *	GFP_PROTECTED - allow non-sysram nodes in mems_allowed
  */
 bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 {
 	struct cpuset *cs;		/* current cpuset ancestors */
 	bool allowed;			/* is allocation in zone z allowed? */
 	unsigned long flags;
+	bool protected_node = gfp_mask & __GFP_PROTECTED;
 
 	if (in_interrupt())
 		return true;
-	if (node_isset(node, current->mems_default))
-		return true;
+
+	if (protected_node) {
+		rcu_read_lock();
+		cs = task_cs(current);
+		allowed = node_isset(node, cs->mems_allowed);
+		rcu_read_unlock();
+	} else if (node_isset(node, current->mems_default))
+		allowed = true;
+
+	if (allowed)
+		return allowed;
+
 	/*
 	 * Allow tasks that have access to memory reserves because they have
 	 * been OOM killed to get memory anywhere.
@@ -4322,13 +4371,15 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	spin_lock_irqsave(&callback_lock, flags);
 
 	cs = nearest_hardwall_ancestor(task_cs(current));
-	allowed = node_isset(node, cs->mems_allowed);
+	allowed = node_isset(node, cs->mems_allowed); /* include protected */
+	if (!protected_node && !nodes_empty(default_sysram_nodelist))
+		allowed &= node_isset(node, default_sysram_nodelist);
 
 	spin_unlock_irqrestore(&callback_lock, flags);
 	return allowed;
 }
 
-bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+bool cpuset_node_default(struct cgroup *cgroup, int nid)
 {
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
@@ -4347,7 +4398,7 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
 		return true;
 
 	/*
-	 * Normally, accessing effective_mems would require the cpuset_mutex
+	 * Normally, accessing mems_default would require the cpuset_mutex
 	 * or callback_lock - but node_isset is atomic and the reference
 	 * taken via cgroup_get_e_css is sufficient to protect css.
 	 *
@@ -4359,7 +4410,7 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
 	 * cannot make strong isolation guarantees, so this is acceptable.
 	 */
 	cs = container_of(css, struct cpuset, css);
-	allowed = node_isset(nid, cs->effective_mems);
+	allowed = node_isset(nid, cs->mems_default);
 	css_put(css);
 	return allowed;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4deda33625f4..a25584cb281e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5599,5 +5599,5 @@ subsys_initcall(mem_cgroup_swap_init);
 
 bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
 {
-	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
+	return memcg ? cpuset_node_default(memcg->css.cgroup, nid) : true;
 }
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6225d4d23010..5360333dc06d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1831,14 +1831,14 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 	}
 	rcu_read_unlock();
 
-	task_nodes = cpuset_mems_allowed(task);
+	task_nodes = cpuset_mems_default(task);
 	/* Is the user allowed to access the target nodes? */
 	if (!nodes_subset(*new, task_nodes) && !capable(CAP_SYS_NICE)) {
 		err = -EPERM;
 		goto out_put;
 	}
 
-	task_nodes = cpuset_mems_allowed(current);
+	task_nodes = cpuset_mems_default(current);
 	nodes_and(*new, *new, task_nodes);
 	if (nodes_empty(*new))
 		goto out_put;
@@ -2738,7 +2738,7 @@ int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
 /*
  * If mpol_dup() sees current->cpuset == cpuset_being_rebound, then it
  * rebinds the mempolicy its copying by calling mpol_rebind_policy()
- * with the mems_default returned by cpuset_mems_allowed().  This
+ * with the mems_default returned by cpuset_mems_default().  This
  * keeps mempolicies cpuset relative after its cpuset moves.  See
  * further kernel/cpuset.c update_nodemask().
  *
@@ -2763,7 +2763,7 @@ struct mempolicy *__mpol_dup(struct mempolicy *old)
 		*new = *old;
 
 	if (current_cpuset_is_being_rebound()) {
-		nodemask_t mems = cpuset_mems_allowed(current);
+		nodemask_t mems = cpuset_mems_default(current);
 		mpol_rebind_policy(new, &mems);
 	}
 	atomic_set(&new->refcnt, 1);
diff --git a/mm/migrate.c b/mm/migrate.c
index c0e9f15be2a2..f9a910b43a9f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2526,7 +2526,7 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
 	 */
 	if (!pid) {
 		mmget(current->mm);
-		*mem_nodes = cpuset_mems_allowed(current);
+		*mem_nodes = cpuset_mems_default(current);
 		return current->mm;
 	}
 
@@ -2547,7 +2547,7 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
 	mm = ERR_PTR(security_task_movememory(task));
 	if (IS_ERR(mm))
 		goto out;
-	*mem_nodes = cpuset_mems_allowed(task);
+	*mem_nodes = cpuset_mems_default(task);
 	mm = get_task_mm(task);
 out:
 	put_task_struct(task);
-- 
2.51.1


