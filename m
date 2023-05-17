Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A464C705DED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 05:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjEQDU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 23:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjEQDUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 23:20:51 -0400
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2FE2A2130;
        Tue, 16 May 2023 20:20:45 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.71.35])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 6D7F8110056400;
        Wed, 17 May 2023 11:20:43 +0800 (CST)
Received: from localhost.localdomain (10.79.71.101) by
 ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 11:20:42 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.71.35
From:   chengkaitao <chengkaitao@didiglobal.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <corbet@lwn.net>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>, <akpm@linux-foundation.org>,
        <brauner@kernel.org>, <muchun.song@linux.dev>
CC:     <viro@zeniv.linux.org.uk>, <zhengqi.arch@bytedance.com>,
        <ebiederm@xmission.com>, <Liam.Howlett@Oracle.com>,
        <chengzhihao1@huawei.com>, <pilgrimtao@gmail.com>,
        <haolee.swjtu@gmail.com>, <yuzhao@google.com>,
        <willy@infradead.org>, <vasily.averin@linux.dev>, <vbabka@suse.cz>,
        <surenb@google.com>, <sfr@canb.auug.org.au>, <mcgrof@kernel.org>,
        <sujiaxun@uniontech.com>, <feng.tang@intel.com>,
        <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH v4 1/2] mm: memcontrol: protect the memory in cgroup from being oom killed
Date:   Wed, 17 May 2023 11:20:31 +0800
Message-ID: <20230517032032.76334-2-chengkaitao@didiglobal.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230517032032.76334-1-chengkaitao@didiglobal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.79.71.101]
X-ClientProxiedBy: ZJY02-PUBMBX-01.didichuxing.com (10.79.65.31) To
 ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: chengkaitao <pilgrimtao@gmail.com>

We created a new interface <memory.oom.protect> for memory, If there is
the OOM killer under parent memory cgroup, and the memory usage of a
child cgroup is within its effective oom.protect boundary, the cgroup's
tasks won't be OOM killed unless there is no unprotected tasks in other
children cgroups. It draws on the logic of <memory.min/low> in the
inheritance relationship.

It has the following advantages,
1. The minimum granularity adjusted by oom_protect is one page (4K).
2. We have the ability to protect more important processes, when there
is a memcg's OOM killer. The oom.protect only takes effect local memcg,
and does not affect the OOM killer of the host.
3. We can protect a cgroup of processes more easily. The cgroup can keep
some memory, even if the OOM killer has to be called. The new patch
provides new protection for machine memory oversold, while also
preventing some processes with low memory usage from being killed.
4. All the shared memory will also consume the oom_protect quota of the
memcg, and the process's oom_protect quota of the memcg will decrease,
the probability of they being killed will increase.

If the memory.oom.protect of a nonleaf cgroup is set to "auto", it will
automatically calculate the sum of the effective oom.protect of its own
subcgroups.

Signed-off-by: chengkaitao <pilgrimtao@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  25 ++++-
 fs/proc/base.c                          |  17 ++-
 include/linux/memcontrol.h              |  45 +++++++-
 include/linux/oom.h                     |   3 +-
 include/linux/page_counter.h            |   6 +
 mm/memcontrol.c                         | 193 ++++++++++++++++++++++++++++++++
 mm/oom_kill.c                           |  25 +++--
 mm/page_counter.c                       |  30 +++++
 8 files changed, 323 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f67c0829350b..51e9a84d508a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1194,7 +1194,7 @@ PAGE_SIZE multiple when read back.
 	cgroup is within its effective low boundary, the cgroup's
 	memory won't be reclaimed unless there is no reclaimable
 	memory available in unprotected cgroups.
-	Above the effective low	boundary (or 
+	Above the effective low	boundary (or
 	effective min boundary if it is higher), pages are reclaimed
 	proportionally to the overage, reducing reclaim pressure for
 	smaller overages.
@@ -1295,6 +1295,27 @@ PAGE_SIZE multiple when read back.
 	to kill any tasks outside of this cgroup, regardless
 	memory.oom.group values of ancestor cgroups.
 
+  memory.oom.protect
+	A read-write single value file which exists on non-root
+	cgroups. The default value is "0".
+
+	If there is the OOM killer under parent memory cgroup, and
+	the memory usage of a child cgroup is within its effective
+	oom.protect boundary, the cgroup's processes won't be oom killed
+	unless there is no unprotected processes in other children
+	cgroups. About the effective oom.protect boundary, we assign it
+	to each process in this cgroup in proportion to the actual usage.
+	this factor will be taken into account when calculating the
+	oom_score. Effective oom.protect boundary is limited by
+	memory.oom.protect values of all ancestor cgroups. If there is
+	memory.oom.protect overcommitment (child cgroup or cgroups are
+	requiring more protected memory than parent will allow), then each
+	child cgroup will get the part of parent's protection proportional
+	to its actual memory usage below memory.oom.protect. If the
+	memory.oom.protect of a nonleaf cgroup is set to "auto", it will
+	automatically calculate the sum of the effective oom.protect of
+	its own subcgroups.
+
   memory.events
 	A read-only flat-keyed file which exists on non-root cgroups.
 	The following entries are defined.  Unless specified
@@ -1894,7 +1915,7 @@ of the two is enforced.
 
 cgroup writeback requires explicit support from the underlying
 filesystem.  Currently, cgroup writeback is implemented on ext2, ext4,
-btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are 
+btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are
 attributed to the root cgroup.
 
 There are inherent differences in memory and writeback management
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 05452c3b9872..a34e007a7292 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -553,8 +553,19 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long totalpages = totalram_pages() + total_swap_pages;
 	unsigned long points = 0;
 	long badness;
+#ifdef CONFIG_MEMCG
+	struct mem_cgroup *memcg;
 
-	badness = oom_badness(task, totalpages);
+	rcu_read_lock();
+	memcg = mem_cgroup_from_task(task);
+	if (memcg && !css_tryget(&memcg->css))
+		memcg = NULL;
+	rcu_read_unlock();
+
+	update_parent_oom_protection(root_mem_cgroup, memcg);
+	css_put(&memcg->css);
+#endif
+	badness = oom_badness(task, totalpages, MEMCG_OOM_PROTECT);
 	/*
 	 * Special case OOM_SCORE_ADJ_MIN for all others scale the
 	 * badness value into [0, 2000] range which we have been
@@ -2657,7 +2668,7 @@ static struct dentry *proc_pident_instantiate(struct dentry *dentry,
 	return d_splice_alias(inode, dentry);
 }
 
-static struct dentry *proc_pident_lookup(struct inode *dir, 
+static struct dentry *proc_pident_lookup(struct inode *dir,
 					 struct dentry *dentry,
 					 const struct pid_entry *p,
 					 const struct pid_entry *end)
@@ -2870,7 +2881,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 
 static int proc_attr_dir_readdir(struct file *file, struct dir_context *ctx)
 {
-	return proc_pident_readdir(file, ctx, 
+	return proc_pident_readdir(file, ctx,
 				   attr_dir_stuff, ARRAY_SIZE(attr_dir_stuff));
 }
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 00a88cf947e1..23ea28d98c0e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -53,6 +53,11 @@ enum memcg_memory_event {
 	MEMCG_NR_MEMORY_EVENTS,
 };
 
+enum memcg_oom_evaluate {
+	MEMCG_OOM_EVALUATE_NONE,
+	MEMCG_OOM_PROTECT,
+};
+
 struct mem_cgroup_reclaim_cookie {
 	pg_data_t *pgdat;
 	unsigned int generation;
@@ -622,6 +627,14 @@ static inline void mem_cgroup_protection(struct mem_cgroup *root,
 
 void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 				     struct mem_cgroup *memcg);
+void mem_cgroup_calculate_oom_protection(struct mem_cgroup *root,
+				     struct mem_cgroup *memcg);
+void update_parent_oom_protection(struct mem_cgroup *root,
+				     struct mem_cgroup *memcg);
+unsigned long get_task_eoom_protect(struct task_struct *p, long points);
+struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
+struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
+bool is_root_oom_protect(void);
 
 static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
 					  struct mem_cgroup *memcg)
@@ -758,10 +771,6 @@ static inline struct lruvec *folio_lruvec(struct folio *folio)
 	return mem_cgroup_lruvec(memcg, folio_pgdat(folio));
 }
 
-struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
-
-struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
-
 struct lruvec *folio_lruvec_lock(struct folio *folio);
 struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
 struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
@@ -822,6 +831,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
 void mem_cgroup_iter_break(struct mem_cgroup *, struct mem_cgroup *);
 int mem_cgroup_scan_tasks(struct mem_cgroup *,
 			  int (*)(struct task_struct *, void *), void *);
+int mem_cgroup_scan_tasks_update_eoom(struct mem_cgroup *memcg,
+		int (*fn)(struct task_struct *, void *, int), void *arg);
 
 static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 {
@@ -1231,6 +1242,16 @@ static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 {
 }
 
+static inline void mem_cgroup_calculate_oom_protection(struct mem_cgroup *root,
+						   struct mem_cgroup *memcg)
+{
+}
+
+static inline void update_parent_oom_protection(struct mem_cgroup *root,
+						   struct mem_cgroup *memcg)
+{
+}
+
 static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
 					  struct mem_cgroup *memcg)
 {
@@ -1248,6 +1269,16 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 	return false;
 }
 
+static inline unsigned long get_task_eoom_protect(struct task_struct *p, long points)
+{
+	return 0;
+}
+
+static inline bool is_root_oom_protect(void)
+{
+	return 0;
+}
+
 static inline int mem_cgroup_charge(struct folio *folio,
 		struct mm_struct *mm, gfp_t gfp)
 {
@@ -1372,6 +1403,12 @@ static inline int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return 0;
 }
 
+static inline int mem_cgroup_scan_tasks_update_eoom(struct mem_cgroup *memcg,
+		int (*fn)(struct task_struct *, void *, int), void *arg)
+{
+	return 0;
+}
+
 static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 {
 	return 0;
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 7d0c9c48a0c5..04b6daca5a9c 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -97,8 +97,7 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
 	return 0;
 }
 
-long oom_badness(struct task_struct *p,
-		unsigned long totalpages);
+long oom_badness(struct task_struct *p, unsigned long totalpages, int flags);
 
 extern bool out_of_memory(struct oom_control *oc);
 
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index c141ea9a95ef..d730a7373c1d 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -25,6 +25,10 @@ struct page_counter {
 	atomic_long_t low_usage;
 	atomic_long_t children_low_usage;
 
+	unsigned long eoom_protect;
+	atomic_long_t oom_protect_usage;
+	atomic_long_t children_oom_protect_usage;
+
 	unsigned long watermark;
 	unsigned long failcnt;
 
@@ -35,6 +39,7 @@ struct page_counter {
 	unsigned long low;
 	unsigned long high;
 	unsigned long max;
+	unsigned long oom_protect;
 	struct page_counter *parent;
 } ____cacheline_internodealigned_in_smp;
 
@@ -65,6 +70,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages);
 void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages);
 void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages);
+void page_counter_set_oom_protect(struct page_counter *counter, unsigned long nr_pages);
 
 static inline void page_counter_set_high(struct page_counter *counter,
 					 unsigned long nr_pages)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d31fb1e2cb33..8ee67abb415f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1288,6 +1288,52 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return ret;
 }
 
+/**
+ * mem_cgroup_scan_tasks_update_eoom - iterate over tasks of a memory cgroup
+ * hierarchy and update memcg's eoom_protect
+ * @memcg: hierarchy root
+ * @fn: function to call for each task
+ * @arg: argument passed to @fn
+ *
+ * This function iterates over tasks attached to @memcg or to any of its
+ * descendants and update all memcg's eoom_protect, then calls @fn for each
+ * task. If @fn returns a non-zero value, the function breaks the iteration
+ * loop and returns the value. Otherwise, it will iterate over all tasks and
+ * return 0.
+ *
+ * This function may be called for the root memory cgroup.
+ */
+int mem_cgroup_scan_tasks_update_eoom(struct mem_cgroup *memcg,
+		int (*fn)(struct task_struct *, void *, int), void *arg)
+{
+	struct mem_cgroup *iter;
+	int ret = 0;
+
+	for_each_mem_cgroup_tree(iter, memcg) {
+		struct css_task_iter it;
+		struct task_struct *task;
+
+		mem_cgroup_calculate_oom_protection(memcg, iter);
+		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
+		while (!ret && (task = css_task_iter_next(&it)))
+			ret = fn(task, arg, MEMCG_OOM_PROTECT);
+		css_task_iter_end(&it);
+		if (ret) {
+			mem_cgroup_iter_break(memcg, iter);
+			break;
+		}
+	}
+	return ret;
+}
+
+bool is_root_oom_protect(void)
+{
+	if (mem_cgroup_disabled())
+		return 0;
+
+	return !!atomic_long_read(&root_mem_cgroup->memory.children_oom_protect_usage);
+}
+
 #ifdef CONFIG_DEBUG_VM
 void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
 {
@@ -6396,6 +6442,8 @@ static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long value)
 {
 	if (value == PAGE_COUNTER_MAX)
 		seq_puts(m, "max\n");
+	else if (value == PAGE_COUNTER_MAX - 1)
+		seq_puts(m, "auto\n");
 	else
 		seq_printf(m, "%llu\n", (u64)value * PAGE_SIZE);
 
@@ -6677,6 +6725,34 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static int memory_oom_protect_show(struct seq_file *m, void *v)
+{
+	return seq_puts_memcg_tunable(m,
+		READ_ONCE(mem_cgroup_from_seq(m)->memory.oom_protect));
+}
+
+static ssize_t memory_oom_protect_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	unsigned long oom_protect;
+	int err;
+
+	buf = strstrip(buf);
+	if (!strcmp(buf, "auto")) {
+		oom_protect = PAGE_COUNTER_MAX - 1;
+		goto set;
+	}
+
+	err = page_counter_memparse(buf, "max", &oom_protect);
+	if (err)
+		return err;
+
+set:
+	page_counter_set_oom_protect(&memcg->memory, oom_protect);
+	return nbytes;
+}
+
 static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			      size_t nbytes, loff_t off)
 {
@@ -6782,6 +6858,12 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_oom_group_show,
 		.write = memory_oom_group_write,
 	},
+	{
+		.name = "oom.protect",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_oom_protect_show,
+		.write = memory_oom_protect_write,
+	},
 	{
 		.name = "reclaim",
 		.flags = CFTYPE_NS_DELEGATABLE,
@@ -6978,6 +7060,117 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 			atomic_long_read(&parent->memory.children_low_usage)));
 }
 
+static void __mem_cgroup_calculate_oom_protection(struct mem_cgroup *root,
+				     struct mem_cgroup *memcg)
+{
+	unsigned long usage, parent_usage;
+	struct mem_cgroup *parent;
+
+	usage = page_counter_read(&memcg->memory);
+	if (!usage)
+		return;
+
+	parent = parent_mem_cgroup(memcg);
+
+	if (parent == root) {
+		memcg->memory.eoom_protect = atomic_long_read(&memcg->memory.oom_protect_usage);
+		return;
+	}
+
+	parent_usage = page_counter_read(&parent->memory);
+
+	WRITE_ONCE(memcg->memory.eoom_protect, effective_protection(usage, parent_usage,
+			atomic_long_read(&memcg->memory.oom_protect_usage),
+			READ_ONCE(parent->memory.eoom_protect),
+			atomic_long_read(&parent->memory.children_oom_protect_usage)));
+}
+
+/**
+ * mem_cgroup_calculate_oom_protection - check if memory consumption is in the
+ * normal range of oom's protection
+ * @root: the top ancestor of the sub-tree being checked
+ * @memcg: the memory cgroup to check
+ *
+ * WARNING: This function is not stateless! It can only be used as part
+ *          of a top-down tree iteration, not for isolated queries.
+ */
+void mem_cgroup_calculate_oom_protection(struct mem_cgroup *root,
+				     struct mem_cgroup *memcg)
+{
+	if (mem_cgroup_disabled())
+		return;
+
+	if (!root)
+		root = root_mem_cgroup;
+
+	/*
+	 * Effective values of the reclaim targets are ignored so they
+	 * can be stale. Have a look at mem_cgroup_protection for more
+	 * details.
+	 * TODO: calculation should be more robust so that we do not need
+	 * that special casing.
+	 */
+	if (memcg == root)
+		return;
+
+	__mem_cgroup_calculate_oom_protection(root, memcg);
+}
+
+static void lsit_postorder_for_memcg_parent(
+		struct mem_cgroup *root, struct mem_cgroup *memcg,
+		void (*fn)(struct mem_cgroup *, struct mem_cgroup *))
+{
+	struct mem_cgroup *parent;
+
+	if (!memcg || memcg == root)
+		return;
+
+	parent = parent_mem_cgroup(memcg);
+	lsit_postorder_for_memcg_parent(root, parent, fn);
+	fn(root, memcg);
+}
+
+void update_parent_oom_protection(struct mem_cgroup *root,
+						struct mem_cgroup *memcg)
+{
+	if (mem_cgroup_disabled())
+		return;
+
+	if (!root)
+		root = root_mem_cgroup;
+
+	lsit_postorder_for_memcg_parent(root, memcg,
+			__mem_cgroup_calculate_oom_protection);
+}
+
+unsigned long get_task_eoom_protect(struct task_struct *p, long points)
+{
+	struct mem_cgroup *memcg;
+	unsigned long usage, eoom = 0;
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_task(p);
+
+	if (mem_cgroup_unprotected(NULL, memcg))
+		goto end;
+
+	if (do_memsw_account())
+		usage = page_counter_read(&memcg->memsw);
+	else
+		usage = page_counter_read(&memcg->memory)
+			+ page_counter_read(&memcg->swap);
+
+	/* To avoid division errors, when we don't move charge at immigrate */
+	if (!usage)
+		goto end;
+
+	eoom = READ_ONCE(memcg->memory.eoom_protect) * points / usage;
+
+end:
+	rcu_read_unlock();
+	return eoom;
+}
+
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 			gfp_t gfp)
 {
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 612b5597d3af..2a80e2d91afe 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  *  linux/mm/oom_kill.c
- * 
+ *
  *  Copyright (C)  1998,2000  Rik van Riel
  *	Thanks go out to Claus Fischer for some serious inspiration and
  *	for goading me into coding this file...
@@ -193,15 +193,16 @@ static bool should_dump_unreclaim_slab(void)
  * oom_badness - heuristic function to determine which candidate task to kill
  * @p: task struct of which task we should calculate
  * @totalpages: total present RAM allowed for page allocation
+ * @flag: if you want to skip oom_protect function
  *
  * The heuristic for determining which task to kill is made to be as simple and
  * predictable as possible.  The goal is to return the highest value for the
  * task consuming the most memory to avoid subsequent oom failures.
  */
-long oom_badness(struct task_struct *p, unsigned long totalpages)
+long oom_badness(struct task_struct *p, unsigned long totalpages, int flag)
 {
-	long points;
-	long adj;
+	long points, adj, val = 0;
+	unsigned long shmem;
 
 	if (oom_unkillable_task(p))
 		return LONG_MIN;
@@ -229,11 +230,15 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
 	 */
 	points = get_mm_rss(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS) +
 		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
+
+	shmem = get_mm_counter(p->mm, MM_SHMEMPAGES);
 	task_unlock(p);
 
+	if (flag == MEMCG_OOM_PROTECT)
+		val = get_task_eoom_protect(p, points - shmem);
 	/* Normalize to oom_score_adj units */
 	adj *= totalpages / 1000;
-	points += adj;
+	points = points + adj - val;
 
 	return points;
 }
@@ -305,7 +310,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	return CONSTRAINT_NONE;
 }
 
-static int oom_evaluate_task(struct task_struct *task, void *arg)
+static int oom_evaluate_task(struct task_struct *task, void *arg, int flag)
 {
 	struct oom_control *oc = arg;
 	long points;
@@ -338,7 +343,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 		goto select;
 	}
 
-	points = oom_badness(task, oc->totalpages);
+	points = oom_badness(task, oc->totalpages, flag);
 	if (points == LONG_MIN || points < oc->chosen_points)
 		goto next;
 
@@ -365,14 +370,14 @@ static void select_bad_process(struct oom_control *oc)
 {
 	oc->chosen_points = LONG_MIN;
 
-	if (is_memcg_oom(oc))
-		mem_cgroup_scan_tasks(oc->memcg, oom_evaluate_task, oc);
+	if (is_memcg_oom(oc) || is_root_oom_protect())
+		mem_cgroup_scan_tasks_update_eoom(oc->memcg, oom_evaluate_task, oc);
 	else {
 		struct task_struct *p;
 
 		rcu_read_lock();
 		for_each_process(p)
-			if (oom_evaluate_task(p, oc))
+			if (oom_evaluate_task(p, oc, MEMCG_OOM_EVALUATE_NONE))
 				break;
 		rcu_read_unlock();
 	}
diff --git a/mm/page_counter.c b/mm/page_counter.c
index db20d6452b71..72a6f3543008 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -39,6 +39,19 @@ static void propagate_protected_usage(struct page_counter *c,
 		if (delta)
 			atomic_long_add(delta, &c->parent->children_low_usage);
 	}
+
+	protected = READ_ONCE(c->oom_protect);
+	if (protected == PAGE_COUNTER_MAX - 1)
+		protected = atomic_long_read(&c->children_oom_protect_usage);
+	else
+		protected = min(usage, protected);
+	old_protected = atomic_long_read(&c->oom_protect_usage);
+	if (protected != old_protected) {
+		old_protected = atomic_long_xchg(&c->oom_protect_usage, protected);
+		delta = protected - old_protected;
+		if (delta)
+			atomic_long_add(delta, &c->parent->children_oom_protect_usage);
+	}
 }
 
 /**
@@ -234,6 +247,23 @@ void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages)
 		propagate_protected_usage(c, atomic_long_read(&c->usage));
 }
 
+/**
+ * page_counter_set_oom_protect - set the amount of oom protected memory
+ * @counter: counter
+ * @nr_pages: value to set
+ *
+ * The caller must serialize invocations on the same counter.
+ */
+void page_counter_set_oom_protect(struct page_counter *counter, unsigned long nr_pages)
+{
+	struct page_counter *c;
+
+	WRITE_ONCE(counter->oom_protect, nr_pages);
+
+	for (c = counter; c; c = c->parent)
+		propagate_protected_usage(c, atomic_long_read(&c->usage));
+}
+
 /**
  * page_counter_memparse - memparse() for page counter limits
  * @buf: string to parse
-- 
2.14.1

