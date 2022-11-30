Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1367C63CF7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 08:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiK3HD2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 02:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiK3HD1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:03:27 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B5754767;
        Tue, 29 Nov 2022 23:03:23 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id k79so1476789pfd.7;
        Tue, 29 Nov 2022 23:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gN674wVxI7ltPZf4Qw4m1p1kF2HlYFZ/uSwwp6MgTfM=;
        b=lTCpaPKcO8Fdzc2qvaGgTm3/m4n6NsLCr9bPXHLylhqrenJzFXcTHyAVaJu8aYS4k8
         FeGCHClrmM4q2H130fKdKEn8t+pSFEA40SCclpnSixTPLYgSc8wDwl8IrmR7fpqfll5x
         WRnTrdOLWrzIPYL1nv00hPPSFgEYquEr6zdJUzQBETzuvDW44qafPMvyTJUfoPX4NCo+
         aenErgDw5LtHMpRmV46QhQ5Gfkp4B77DXPvWE9xSfmnFYO1LAdCL9pH1aFTR2q8BQH7l
         jzlIo2EOWXR96Vzutp6Ts6e8PDIK5pFJ8/8VW1AWtp5FgfhZ8vztuWsrdDkYcO0aatTT
         uNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gN674wVxI7ltPZf4Qw4m1p1kF2HlYFZ/uSwwp6MgTfM=;
        b=XLlxP+Z+ryls2di467aiNIyC1gDyzCFmPoWnsLfxPXcv68p2tB7+9VZ/410Z0R2C4R
         j77nAYUscE+LgjSzZOEg1uZLar+fiutIoIHjsUxFboftTulQ3Tqcyl2Ve2a33ZMHDXSX
         Qj2mXlqSlyFIqYxV9s1QM7jP+2TFRctJ1cWvZQvEe8+OZT1MxWLFH1yuTPuWwXB6Urd6
         GsifJObhat+LGtNLaN+S8ij34UXSBcUJX0PWDglU+iTgwPc0yfXzqqrjNtHkUDbLkUgA
         +DZxUKvKoCYHVrZLuFiuX3HLkAkUKQ8wUlZIfP12XHPZ2b5r83ZgOtdZIMW4pnkeZtAA
         1iLw==
X-Gm-Message-State: ANoB5pmT2RsxBTvDhIkP3iqFxd3ppbgQXJBOC48pOrKTdGYiU+Ws+K7Z
        JBl8iBnU8QMMkFGEHrYAChs=
X-Google-Smtp-Source: AA0mqf6/BCgE1uGbfFfabC1txCqgo11g3bIInbrAdw20XPLJy+DsnnptsP0abwMmZ6NOGaUB0/+CWQ==
X-Received: by 2002:a63:1062:0:b0:470:a47:996a with SMTP id 34-20020a631062000000b004700a47996amr35599318pgq.377.1669791802824;
        Tue, 29 Nov 2022 23:03:22 -0800 (PST)
Received: from localhost.localdomain ([120.244.202.174])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709027e4a00b001898aa48d17sm535507pln.185.2022.11.29.23.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 23:03:22 -0800 (PST)
From:   chengkaitao <pilgrimtao@gmail.com>
X-Google-Original-From: chengkaitao <chengkaitao@didiglobal.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com
Cc:     cgel.zte@gmail.com, ran.xiaokai@zte.com.cn,
        viro@zeniv.linux.org.uk, zhengqi.arch@bytedance.com,
        ebiederm@xmission.com, Liam.Howlett@Oracle.com,
        chengzhihao1@huawei.com, pilgrimtao@gmail.com,
        haolee.swjtu@gmail.com, yuzhao@google.com, willy@infradead.org,
        vasily.averin@linux.dev, vbabka@suse.cz, surenb@google.com,
        sfr@canb.auug.org.au, mcgrof@kernel.org, sujiaxun@uniontech.com,
        feng.tang@intel.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm: memcontrol: protect the memory in cgroup from being oom killed
Date:   Wed, 30 Nov 2022 15:01:58 +0800
Message-Id: <20221130070158.44221-1-chengkaitao@didiglobal.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
1. We have the ability to protect more important processes, when there
is a memcg's OOM killer. The oom.protect only takes effect local memcg,
and does not affect the OOM killer of the host.
2. Historically, we can often use oom_score_adj to control a group of
processes, It requires that all processes in the cgroup must have a
common parent processes, we have to set the common parent process's
oom_score_adj, before it forks all children processes. So that it is
very difficult to apply it in other situations. Now oom.protect has no
such restrictions, we can protect a cgroup of processes more easily. The
cgroup can keep some memory, even if the OOM killer has to be called.

Signed-off-by: chengkaitao <pilgrimtao@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  22 +++-
 fs/proc/base.c                          |  17 ++-
 include/linux/memcontrol.h              |  45 +++++++-
 include/linux/oom.h                     |   3 +-
 include/linux/page_counter.h            |   6 ++
 mm/memcontrol.c                         | 178 ++++++++++++++++++++++++++++++++
 mm/oom_kill.c                           |  22 ++--
 mm/page_counter.c                       |  26 +++++
 8 files changed, 298 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index dc254a3cb956..f3542682fa15 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1191,7 +1191,7 @@ PAGE_SIZE multiple when read back.
 	cgroup is within its effective low boundary, the cgroup's
 	memory won't be reclaimed unless there is no reclaimable
 	memory available in unprotected cgroups.
-	Above the effective low	boundary (or 
+	Above the effective low	boundary (or
 	effective min boundary if it is higher), pages are reclaimed
 	proportionally to the overage, reducing reclaim pressure for
 	smaller overages.
@@ -1292,6 +1292,24 @@ PAGE_SIZE multiple when read back.
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
+	to its actual memory usage below memory.oom.protect.
+
   memory.events
 	A read-only flat-keyed file which exists on non-root cgroups.
 	The following entries are defined.  Unless specified
@@ -1885,7 +1903,7 @@ of the two is enforced.
 
 cgroup writeback requires explicit support from the underlying
 filesystem.  Currently, cgroup writeback is implemented on ext2, ext4,
-btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are 
+btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are
 attributed to the root cgroup.
 
 There are inherent differences in memory and writeback management
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9e479d7d202b..f169abcfbe21 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -552,8 +552,19 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
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
index e1644a24009c..0ca96d764e45 100644
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
@@ -614,6 +619,14 @@ static inline void mem_cgroup_protection(struct mem_cgroup *root,
 
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
 
 static inline bool mem_cgroup_supports_protection(struct mem_cgroup *memcg)
 {
@@ -746,10 +759,6 @@ static inline struct lruvec *folio_lruvec(struct folio *folio)
 	return mem_cgroup_lruvec(memcg, folio_pgdat(folio));
 }
 
-struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
-
-struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
-
 struct lruvec *folio_lruvec_lock(struct folio *folio);
 struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
 struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
@@ -805,6 +814,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
 void mem_cgroup_iter_break(struct mem_cgroup *, struct mem_cgroup *);
 int mem_cgroup_scan_tasks(struct mem_cgroup *,
 			  int (*)(struct task_struct *, void *), void *);
+int mem_cgroup_scan_tasks_update_eoom(struct mem_cgroup *memcg,
+		int (*fn)(struct task_struct *, void *, int), void *arg);
 
 static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 {
@@ -1209,6 +1220,16 @@ static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 {
 }
 
+static inline void mem_cgroup_calculate_oom_protection(struct mem_cgroup *root,
+						   struct mem_cgroup *memcg)
+{
+}
+
+void update_parent_oom_protection(struct mem_cgroup *root,
+						struct mem_cgroup *memcg)
+{
+}
+
 static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
 {
 	return false;
@@ -1219,6 +1240,16 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 	return false;
 }
 
+unsigned long get_task_eoom_protect(struct task_struct *p, long points)
+{
+	return 0;
+}
+
+bool is_root_oom_protect(void)
+{
+	return 0;
+}
+
 static inline int mem_cgroup_charge(struct folio *folio,
 		struct mm_struct *mm, gfp_t gfp)
 {
@@ -1338,6 +1369,12 @@ static inline int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return 0;
 }
 
+int mem_cgroup_scan_tasks_update_eoom(struct mem_cgroup *memcg,
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
index 2d8549ae1b30..6f0878619133 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1261,6 +1261,52 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
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
@@ -6569,6 +6615,29 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
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
+	err = page_counter_memparse(buf, "max", &oom_protect);
+	if (err)
+		return err;
+
+	page_counter_set_oom_protect(&memcg->memory, oom_protect);
+
+	return nbytes;
+}
+
 static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			      size_t nbytes, loff_t off)
 {
@@ -6674,6 +6743,12 @@ static struct cftype memory_files[] = {
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
@@ -6870,6 +6945,109 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
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
+		memcg->memory.eoom_protect = READ_ONCE(memcg->memory.oom_protect);
+		return;
+	}
+
+	parent_usage = page_counter_read(&parent->memory);
+
+	WRITE_ONCE(memcg->memory.eoom_protect, effective_protection(usage, parent_usage,
+			READ_ONCE(memcg->memory.oom_protect),
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
+	unsigned long usage, eoom;
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_task(p);
+
+	if (!memcg || !mem_cgroup_supports_protection(memcg)) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	usage = page_counter_read(&memcg->memory);
+	eoom = READ_ONCE(memcg->memory.eoom_protect) * points / usage;
+	rcu_read_unlock();
+
+	return eoom;
+}
+
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 			gfp_t gfp)
 {
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1276e49b31b0..16aa33323eff 100644
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
@@ -193,15 +193,15 @@ static bool should_dump_unreclaim_slab(void)
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
 
 	if (oom_unkillable_task(p))
 		return LONG_MIN;
@@ -231,9 +231,11 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
 		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
 	task_unlock(p);
 
+	if (flag == MEMCG_OOM_PROTECT)
+		val = get_task_eoom_protect(p, points);
 	/* Normalize to oom_score_adj units */
 	adj *= totalpages / 1000;
-	points += adj;
+	points = points + adj - val;
 
 	return points;
 }
@@ -305,7 +307,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	return CONSTRAINT_NONE;
 }
 
-static int oom_evaluate_task(struct task_struct *task, void *arg)
+static int oom_evaluate_task(struct task_struct *task, void *arg, int flag)
 {
 	struct oom_control *oc = arg;
 	long points;
@@ -338,7 +340,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 		goto select;
 	}
 
-	points = oom_badness(task, oc->totalpages);
+	points = oom_badness(task, oc->totalpages, flag);
 	if (points == LONG_MIN || points < oc->chosen_points)
 		goto next;
 
@@ -365,14 +367,14 @@ static void select_bad_process(struct oom_control *oc)
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
index db20d6452b71..43987cc59443 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -39,6 +39,15 @@ static void propagate_protected_usage(struct page_counter *c,
 		if (delta)
 			atomic_long_add(delta, &c->parent->children_low_usage);
 	}
+
+	protected = min(usage, READ_ONCE(c->oom_protect));
+	old_protected = atomic_long_read(&c->oom_protect_usage);
+	if (protected != old_protected) {
+		old_protected = atomic_long_xchg(&c->oom_protect_usage, protected);
+		delta = protected - old_protected;
+		if (delta)
+			atomic_long_add(delta, &c->parent->children_oom_protect_usage);
+	}
 }
 
 /**
@@ -234,6 +243,23 @@ void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages)
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

