Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA79403999
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 14:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351707AbhIHMQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 08:16:51 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:36727 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351686AbhIHMQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:16:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=escape@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Ungmnt5_1631103340;
Received: from localhost(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0Ungmnt5_1631103340)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Sep 2021 20:15:40 +0800
From:   Yi Tao <escape@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shanpeic@linux.alibaba.com
Subject: [RFC PATCH 2/2] support cgroup pool in v1
Date:   Wed,  8 Sep 2021 20:15:13 +0800
Message-Id: <03e2b37678c9b2aef4f5dee303b3fb87a565d56b.1631102579.git.escape@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <e753e449240bfc43fcb7aa26dca196e2f51e0836.1631102579.git.escape@linux.alibaba.com>
References: <cover.1631102579.git.escape@linux.alibaba.com>
 <e753e449240bfc43fcb7aa26dca196e2f51e0836.1631102579.git.escape@linux.alibaba.com>
In-Reply-To: <cover.1631102579.git.escape@linux.alibaba.com>
References: <cover.1631102579.git.escape@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add pool_size interface and delay_time interface. When the user writes
pool_size, a cgroup pool will be created, and then when the user needs
to create a cgroup, it will take the fast path protected by spinlock to
obtain it from the resource pool. Performance is improved by the
following aspects:
	1.reduce the critical area for creating cgroups
	2.reduce the scheduling time of sleep
	3.avoid competition with other cgroup behaviors which protected
	  by cgroup_mutex

The essence of obtaining resources from the pool is kernfs rename. With
the help of the previous pinned kernfs node function, when the pool is
enabled, these cgroups will be in the pinned state, and the protection
of the kernfs data structure will be protected by the specified
spinlock, thus getting rid of the cgroup_mutex and kernfs_rwsem.

In order to avoid random operations by users, the kernfs nodes of the
cgroups in the pool will be placed under a hidden kernfs tree, and users
can not directly touch them. When a user creates a cgroup, it will take
the fast path, select a node from the hidden tree, and move it to the
correct position.

As users continue to obtain resources from the pool, the number of
cgroups in the pool will gradually decrease. When the number is less
than a certain value, it will be supplemented. In order to avoid
competition with the currently created cgroup, you can delay this by
setting delay_time process

Suggested-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Yi Tao <escape@linux.alibaba.com>
---
 include/linux/cgroup-defs.h |  16 +++++
 include/linux/cgroup.h      |   2 +
 kernel/cgroup/cgroup-v1.c   | 139 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/cgroup/cgroup.c      | 113 ++++++++++++++++++++++++++++++++++-
 kernel/sysctl.c             |   8 +++
 5 files changed, 277 insertions(+), 1 deletion(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index e1c705fdfa7c..e3e486d1b678 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -486,6 +486,22 @@ struct cgroup {
 	/* Used to store internal freezer state */
 	struct cgroup_freezer_state freezer;
 
+	/*
+	 * cgroup pool related members. lock protects cgroup's kernfs node in
+	 * pool. pool_index records index of cgroup which put into pool next.
+	 * pool_amount records how many cgroups pool remains. pool_size is set
+	 * by user, supply pool util pool_amount reach 2*pool_size if
+	 * pool_amount is less than pool_size to retain enough cgroup in pool to
+	 * guarantee cgroup_mkdir take the fast path.
+	 */
+	spinlock_t lock;
+	atomic64_t pool_index;
+	atomic64_t pool_amount;
+	u64 pool_size;
+	bool enable_pool;
+	struct kernfs_root *hidden_place;
+	struct delayed_work supply_pool_work;
+
 	/* ids of the ancestors at each level including self */
 	u64 ancestor_ids[];
 };
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 7bf60454a313..ade614b78040 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -432,6 +432,8 @@ static inline void cgroup_put(struct cgroup *cgrp)
 	css_put(&cgrp->self);
 }
 
+extern unsigned int cgroup_supply_delay_time;
+
 /**
  * task_css_set_check - obtain a task's css_set with extra access conditions
  * @task: the task to obtain css_set for
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 35b920328344..8964c4d0741b 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -609,6 +609,136 @@ static int cgroup_clone_children_write(struct cgroup_subsys_state *css,
 	return 0;
 }
 
+/*
+ * kernfs_open_file->mutex can't avoid competition if writing to pool_size
+ * of parent cgroup and child cgroup at the same time. use cgroup_pool_mutex
+ * to serialize any write operation to pool_size.
+ */
+DEFINE_MUTEX(cgroup_pool_mutex);
+
+static u64 cgroup_pool_size_read(struct cgroup_subsys_state *css,
+				 struct cftype *cft)
+{
+	/* kernfs r/w access is serialized by kernfs_open_file->mutex */
+	return css->cgroup->pool_size;
+}
+
+extern struct kernfs_node *kernfs_get_active(struct kernfs_node *kn);
+extern void kernfs_put_active(struct kernfs_node *kn);
+
+static ssize_t cgroup_pool_size_write(struct kernfs_open_file *of,
+				  char *buf, size_t nbytes, loff_t off)
+{
+	char name[NAME_MAX + 1];
+	struct cgroup *cgrp;
+	ssize_t ret = -EPERM;
+	u64 val;
+	int i;
+
+	cgrp = of->kn->parent->priv;
+
+	if (kstrtoull(buf, 0, &val))
+		return -EINVAL;
+
+	if (!cgroup_tryget(cgrp))
+		return -ENODEV;
+
+	kernfs_break_active_protection(of->kn);
+	mutex_lock(&cgroup_pool_mutex);
+	mutex_lock(&cgroup_mutex);
+	spin_lock(&cgrp->lock);
+
+	/*
+	 * only non-zero -> zero or zero -> non-zero settings are invalid.
+	 */
+	if ((cgrp->pool_size && val) || (!cgrp->pool_size && !val))
+		goto out_fail;
+
+	if (cgroup_is_dead(cgrp)) {
+		ret = -ENODEV;
+		goto out_fail;
+	}
+
+	cgrp->pool_size = val;
+	spin_unlock(&cgrp->lock);
+	mutex_unlock(&cgroup_mutex);
+
+	if (val) {
+		/* create kernfs root to hide cgroup which belongs to pool */
+		cgrp->hidden_place = kernfs_create_root(NULL, 0, NULL);
+
+		/*
+		 * names of cgroups in pool obey the rule of pool-*, it may
+		 * fail if cgroup has the same name already exists, if failed,
+		 * try again with different name.
+		 *
+		 * cgroup_mkdir called here is under context of writing
+		 * pool_size, so we need to call kernfs_get_active to simulate
+		 * kernfs mkdir context.
+		 *
+		 * normally, the mode of 0xffff is intercepted at the VFS layer
+		 * because it is invalid. use 0xffff to tell cgroup_mkdir it is
+		 * create a cgroup for cgroup pool.
+		 */
+		for (i = 0; i < val * 2;) {
+			sprintf(name, "pool-%llu", atomic64_add_return(1, &cgrp->pool_index));
+			kernfs_get_active(cgrp->kn);
+			if (!cgroup_mkdir(cgrp->kn, name, 0xffff))
+				i++;
+			kernfs_put_active(cgrp->kn);
+		}
+		atomic64_set(&cgrp->pool_amount, val * 2);
+
+		/* set kernfs node pinned after generating pool */
+		mutex_lock(&cgroup_mutex);
+		spin_lock(&cgrp->lock);
+		cgrp->enable_pool = true;
+		kernfs_set_pinned(cgrp->kn, &cgrp->lock);
+		kernfs_set_pinned(cgrp->hidden_place->kn, &cgrp->lock);
+		spin_unlock(&cgrp->lock);
+		mutex_unlock(&cgroup_mutex);
+	} else {
+		struct kernfs_node *child, *n;
+		struct rb_root *hidden_root = &cgrp->hidden_place->kn->dir.children;
+
+		/* clear kernfs node pinned before removing pool */
+		mutex_lock(&cgroup_mutex);
+		spin_lock(&cgrp->lock);
+		cgrp->enable_pool = false;
+		kernfs_clear_pinned(cgrp->kn);
+		kernfs_clear_pinned(cgrp->hidden_place->kn);
+		spin_unlock(&cgrp->lock);
+		mutex_unlock(&cgroup_mutex);
+
+		/* pool is disabled, cancel supply work */
+		cancel_delayed_work_sync(&cgrp->supply_pool_work);
+
+		/* traverse cgroup in pool and remove them */
+		while (hidden_root->rb_node) {
+			rbtree_postorder_for_each_entry_safe(child, n, hidden_root, rb) {
+				kernfs_get_active(child);
+				ret = cgroup_rmdir(child);
+				kernfs_put_active(child);
+			}
+		}
+		kernfs_destroy_root(cgrp->hidden_place);
+		atomic64_set(&cgrp->pool_amount, 0);
+	}
+
+
+	ret = nbytes;
+	goto out_success;
+
+out_fail:
+	spin_unlock(&cgrp->lock);
+	mutex_unlock(&cgroup_mutex);
+out_success:
+	mutex_unlock(&cgroup_pool_mutex);
+	kernfs_unbreak_active_protection(of->kn);
+	cgroup_put(cgrp);
+	return ret;
+}
+
 /* cgroup core interface files for the legacy hierarchies */
 struct cftype cgroup1_base_files[] = {
 	{
@@ -651,6 +781,11 @@ struct cftype cgroup1_base_files[] = {
 		.write = cgroup_release_agent_write,
 		.max_write_len = PATH_MAX - 1,
 	},
+	{
+		.name = "pool_size",
+		.read_u64 = cgroup_pool_size_read,
+		.write = cgroup_pool_size_write,
+	},
 	{ }	/* terminate */
 };
 
@@ -845,9 +980,13 @@ static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent
 
 	mutex_lock(&cgroup_mutex);
 
+	if (kn->parent->pinned)
+		spin_lock(kn->parent->lock);
 	ret = kernfs_rename(kn, new_parent, new_name_str);
 	if (!ret)
 		TRACE_CGROUP_PATH(rename, cgrp);
+	if (kn->parent->pinned)
+		spin_unlock(kn->parent->lock);
 
 	mutex_unlock(&cgroup_mutex);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 881ce1470beb..d259e3bdca2a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -245,6 +245,7 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 static int cgroup_addrm_files(struct cgroup_subsys_state *css,
 			      struct cgroup *cgrp, struct cftype cfts[],
 			      bool is_add);
+static void cgroup_supply_work(struct work_struct *work);
 
 /**
  * cgroup_ssid_enabled - cgroup subsys enabled test by subsys ID
@@ -1925,6 +1926,7 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 	INIT_LIST_HEAD(&cgrp->cset_links);
 	INIT_LIST_HEAD(&cgrp->pidlists);
 	mutex_init(&cgrp->pidlist_mutex);
+	spin_lock_init(&cgrp->lock);
 	cgrp->self.cgroup = cgrp;
 	cgrp->self.flags |= CSS_ONLINE;
 	cgrp->dom_cgrp = cgrp;
@@ -1938,6 +1940,7 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 
 	init_waitqueue_head(&cgrp->offline_waitq);
 	INIT_WORK(&cgrp->release_agent_work, cgroup1_release_agent);
+	INIT_DELAYED_WORK(&cgrp->supply_pool_work, cgroup_supply_work);
 }
 
 void init_cgroup_root(struct cgroup_fs_context *ctx)
@@ -5419,15 +5422,113 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 	return ret;
 }
 
+extern struct kernfs_node *kernfs_get_active(struct kernfs_node *kn);
+extern void kernfs_put_active(struct kernfs_node *kn);
+
+unsigned int cgroup_supply_delay_time;
+
+/* supply pool_amount to 2*pool_size */
+static void cgroup_supply_work(struct work_struct *work)
+{
+	char name[NAME_MAX + 1];
+	struct cgroup *parent = container_of((struct delayed_work *)work,
+				struct cgroup, supply_pool_work);
+	struct kernfs_node *parent_kn = parent->kn;
+
+	while (atomic64_read(&parent->pool_amount) < 2 * parent->pool_size) {
+		sprintf(name, "pool-%llu", atomic64_add_return(1, &parent->pool_index));
+		kernfs_get_active(parent_kn);
+		if (!cgroup_mkdir(parent_kn, name, 0xffff))
+			atomic64_add(1, &parent->pool_amount);
+		kernfs_put_active(parent_kn);
+	}
+}
+
+static int cgroup_mkdir_fast_path(struct kernfs_node *parent_kn, const char *name)
+{
+	struct cgroup *parent;
+	struct rb_root *hidden_root;
+	int ret;
+
+	parent = parent_kn->priv;
+
+	if (!cgroup_tryget(parent))
+		return -ENODEV;
+
+	/*
+	 * acquire spinlock outside kernfs_rename because choosing kernfs node
+	 * and renaming need to be atomic.
+	 */
+	spin_lock(&parent->lock);
+
+	/* if pool is disabled or empty, return and take the slowpath */
+	if (!parent->enable_pool) {
+		ret = 1;
+		goto out_unlock;
+	}
+
+	hidden_root = &parent->hidden_place->kn->dir.children;
+	if (!hidden_root->rb_node) {
+		ret = 1;
+		goto out_unlock;
+	}
+
+#define rb_to_kn(X) rb_entry((X), struct kernfs_node, rb)
+	ret = kernfs_rename(rb_to_kn(rb_first(hidden_root)), parent_kn, name);
+	if (ret)
+		goto out_unlock;
+
+	/* supply pool if pool_amount is less than pool_size */
+	if (atomic64_sub_return(1, &parent->pool_amount) < parent->pool_size)
+		schedule_delayed_work(&parent->supply_pool_work,
+				msecs_to_jiffies(cgroup_supply_delay_time));
+
+out_unlock:
+	spin_unlock(&parent->lock);
+	cgroup_put(parent);
+	return ret;
+}
+
+/* hide cgroup which belongs to pool */
+static void cgroup_hide(struct cgroup *parent, struct cgroup *cgrp, const char *name)
+{
+	/*
+	 * if cgroup_hide is called by cgroup_supply_work, pool is enabled,
+	 * it needs to acquire spinlock to protect kernfs_rename
+	 */
+	if (parent->enable_pool)
+		spin_lock(&parent->lock);
+	kernfs_get_active(parent->hidden_place->kn);
+	BUG_ON(kernfs_rename(cgrp->kn, parent->hidden_place->kn, name));
+	kernfs_put_active(parent->hidden_place->kn);
+	if (parent->enable_pool) {
+		spin_unlock(&parent->lock);
+		kernfs_set_pinned(cgrp->kn, &parent->lock);
+	}
+}
+
 int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 {
 	struct cgroup *parent, *cgrp;
-	int ret;
+	struct kernfs_node *kn;
+	int ret = 1;
+	bool hide = false;
 
 	/* do not accept '\n' to prevent making /proc/<pid>/cgroup unparsable */
 	if (strchr(name, '\n'))
 		return -EINVAL;
 
+	/* 0xffff means cgroup is created for pool, set to default mode 0x1ed */
+	if (mode == 0xffff) {
+		hide = true;
+		mode = 0x1ed;
+	}
+
+	if (!hide)
+		ret = cgroup_mkdir_fast_path(parent_kn, name);
+	if (ret <= 0)
+		return ret;
+
 	parent = cgroup_kn_lock_live(parent_kn, false);
 	if (!parent)
 		return -ENODEV;
@@ -5466,6 +5567,9 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 	/* let's create and online css's */
 	kernfs_activate(cgrp->kn);
 
+	if (hide)
+		cgroup_hide(parent, cgrp, name);
+
 	ret = 0;
 	goto out_unlock;
 
@@ -5658,10 +5762,17 @@ int cgroup_rmdir(struct kernfs_node *kn)
 	if (!cgrp)
 		return 0;
 
+	/* it may creating cgroup in pool */
+	if (cgrp->pool_size) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	ret = cgroup_destroy_locked(cgrp);
 	if (!ret)
 		TRACE_CGROUP_PATH(rmdir, cgrp);
 
+out_unlock:
 	cgroup_kn_unlock(kn);
 	return ret;
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 083be6af29d7..9406111a30cb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -73,6 +73,7 @@
 #include <linux/latencytop.h>
 #include <linux/pid.h>
 #include <linux/delayacct.h>
+#include <linux/cgroup.h>
 
 #include "../lib/kstrtox.h"
 
@@ -2718,6 +2719,13 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
+	{
+		.procname       = "cgroup_supply_delay_time",
+		.data           = &cgroup_supply_delay_time,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
 	{ }
 };
 
-- 
1.8.3.1

