Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069091B19A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 00:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgDTWlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 18:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgDTWlb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:41:31 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701AFC061A0C;
        Mon, 20 Apr 2020 15:41:31 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p19so5650576qve.0;
        Mon, 20 Apr 2020 15:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I53GuE/PpryNkjZAMmbvbjvTLp76oWX+vv7/Vav/aVI=;
        b=L9z7d6ElJQd/6gEEUGAg434Q0L+P99t4FngUseYUNBcQKomHG5udaf7w4S8UU/g9U9
         IO3s8UdjtJ99I9jbpGht9XifOB7/ANCNaq8yRr4kbnbH5wR/amOnD6C1Phei1GWu1Plf
         z4SkSoysYKSbcyXiTsmb4j/gyGzf/ARtz+V2Pkpyow3YujXb9WHP/bGHHZFfX7Tia5sR
         JuYrU+qN3HErhDx/9qYUqMnuf5GvCIursi4MK9Ypm0hUWLnCw91Dxkb9cGfO3ASHrcv6
         sLqteZ/a7uJgVauXLGR16sSVFG7Q78g+etC3CT/o/IvN6SLsXUoGv6IXn9NXeHPPvwFa
         AiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I53GuE/PpryNkjZAMmbvbjvTLp76oWX+vv7/Vav/aVI=;
        b=PUgBd0uu9INnjS6Q+f7u+BbPvxki5pE93oW9117xjMWxTXFyPHdLQUQjYcll16bT3R
         Prgk1VEK99UMvCPhKqJpw3qVvcMlu0KyC/kzBhYx3CpsXmQgR/Z7zJ5fgk4cqFLk+LFx
         pJh/3RjV6PNW2YVmboe+7/LN2T3x3z3nLrUaXemRTHns60Bbl5RnW2qHsac8H9gtUDMH
         ZxAm71r9qz+5DEdPNUjwyN19Pbv4/AQyEyZQAOC/Z6Fvc0by1x+oJqlt0qbIrfIhGdrm
         22xWjkJbjdtD4dFcTZZ51YNQ8/77O6iKvp+RJepCEB1fp+CrlleQ7wb5BKeV23qnSD6V
         C2Sw==
X-Gm-Message-State: AGi0Pub3Tyk6ufD/oCfs2wh4weS6rv6fbju2GCKh71XmT7xmLf3+C6HD
        JAzEbwCewTCp9sj5vWzeDXs=
X-Google-Smtp-Source: APiQypJNjAIXQw726NC6gLPclR5KgakscQJxzfArhJX+NkNQ9hVK+Q2rmE3PSI6OTj1ce/oUA+8dYQ==
X-Received: by 2002:a0c:ed26:: with SMTP id u6mr17005587qvq.220.1587422490480;
        Mon, 20 Apr 2020 15:41:30 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:480::1:b0d9])
        by smtp.gmail.com with ESMTPSA id j90sm511052qte.20.2020.04.20.15.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:41:29 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH 1/4] loop: Use worker per cgroup instead of kworker
Date:   Mon, 20 Apr 2020 18:39:29 -0400
Message-Id: <20200420223936.6773-2-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420223936.6773-1-schatzberg.dan@gmail.com>
References: <20200420223936.6773-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Existing uses of loop device may have multiple cgroups reading/writing
to the same device. Simply charging resources for I/O to the backing
file could result in priority inversion where one cgroup gets
synchronously blocked, holding up all other I/O to the loop device.

In order to avoid this priority inversion, we use a single workqueue
where each work item is a "struct loop_worker" which contains a queue of
struct loop_cmds to issue. The loop device maintains a tree mapping blk
css_id -> loop_worker. This allows each cgroup to independently make
forward progress issuing I/O to the backing file.

There is also a single queue for I/O associated with the rootcg which
can be used in cases of extreme memory shortage where we cannot allocate
a loop_worker.

The locking for the tree and queues is fairly heavy handed - we acquire
the per-loop-device spinlock any time either is accessed. The existing
implementation serializes all I/O through a single thread anyways, so I
don't believe this is any worse.

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 drivers/block/loop.c | 207 ++++++++++++++++++++++++++++++++++++-------
 drivers/block/loop.h |  11 ++-
 2 files changed, 180 insertions(+), 38 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index da693e6a834e..3a109975d2df 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -70,7 +70,6 @@
 #include <linux/writeback.h>
 #include <linux/completion.h>
 #include <linux/highmem.h>
-#include <linux/kthread.h>
 #include <linux/splice.h>
 #include <linux/sysfs.h>
 #include <linux/miscdevice.h>
@@ -83,6 +82,8 @@
 
 #include <linux/uaccess.h>
 
+#define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
+
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 
@@ -778,12 +779,18 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 {
 	ssize_t ret;
 	char *p = NULL;
+	struct file *filp = NULL;
 
 	spin_lock_irq(&lo->lo_lock);
 	if (lo->lo_backing_file)
-		p = file_path(lo->lo_backing_file, buf, PAGE_SIZE - 1);
+		filp = get_file(lo->lo_backing_file);
 	spin_unlock_irq(&lo->lo_lock);
 
+	if (filp) {
+		p = file_path(filp, buf, PAGE_SIZE - 1);
+		fput(filp);
+	}
+
 	if (IS_ERR_OR_NULL(p))
 		ret = PTR_ERR(p);
 	else {
@@ -911,27 +918,83 @@ static void loop_config_discard(struct loop_device *lo)
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
 }
 
-static void loop_unprepare_queue(struct loop_device *lo)
-{
-	kthread_flush_worker(&lo->worker);
-	kthread_stop(lo->worker_task);
-}
+struct loop_worker {
+	struct rb_node rb_node;
+	struct work_struct work;
+	struct list_head cmd_list;
+	struct list_head idle_list;
+	struct loop_device *lo;
+	struct cgroup_subsys_state *css;
+	unsigned long last_ran_at;
+};
 
-static int loop_kthread_worker_fn(void *worker_ptr)
-{
-	current->flags |= PF_LESS_THROTTLE | PF_MEMALLOC_NOIO;
-	return kthread_worker_fn(worker_ptr);
-}
+static void loop_workfn(struct work_struct *work);
+static void loop_rootcg_workfn(struct work_struct *work);
+static void loop_free_idle_workers(struct timer_list *timer);
 
-static int loop_prepare_queue(struct loop_device *lo)
+static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 {
-	kthread_init_worker(&lo->worker);
-	lo->worker_task = kthread_run(loop_kthread_worker_fn,
-			&lo->worker, "loop%d", lo->lo_number);
-	if (IS_ERR(lo->worker_task))
-		return -ENOMEM;
-	set_user_nice(lo->worker_task, MIN_NICE);
-	return 0;
+	struct rb_node **node = &(lo->worker_tree.rb_node), *parent = NULL;
+	struct loop_worker *cur_worker, *worker = NULL;
+	struct work_struct *work;
+	struct list_head *cmd_list;
+
+	spin_lock_irq(&lo->lo_lock);
+
+	if (!cmd->css)
+		goto queue_work;
+
+	node = &lo->worker_tree.rb_node;
+
+	while (*node) {
+		parent = *node;
+		cur_worker = container_of(*node, struct loop_worker, rb_node);
+		if (cur_worker->css == cmd->css) {
+			worker = cur_worker;
+			break;
+		} else if ((long)cur_worker->css < (long)cmd->css) {
+			node = &(*node)->rb_left;
+		} else {
+			node = &(*node)->rb_right;
+		}
+	}
+	if (worker)
+		goto queue_work;
+
+	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT | __GFP_NOWARN);
+	/*
+	 * In the event we cannot allocate a worker, just queue on the
+	 * rootcg worker
+	 */
+	if (!worker)
+		goto queue_work;
+
+	worker->css = cmd->css;
+	css_get(worker->css);
+	INIT_WORK(&worker->work, loop_workfn);
+	INIT_LIST_HEAD(&worker->cmd_list);
+	INIT_LIST_HEAD(&worker->idle_list);
+	worker->lo = lo;
+	rb_link_node(&worker->rb_node, parent, node);
+	rb_insert_color(&worker->rb_node, &lo->worker_tree);
+queue_work:
+	if (worker) {
+		/*
+		 * We need to remove from the idle list here while
+		 * holding the lock so that the idle timer doesn't
+		 * free the worker
+		 */
+		if (!list_empty(&worker->idle_list))
+			list_del_init(&worker->idle_list);
+		work = &worker->work;
+		cmd_list = &worker->cmd_list;
+	} else {
+		work = &lo->rootcg_work;
+		cmd_list = &lo->rootcg_cmd_list;
+	}
+	list_add_tail(&cmd->list_entry, cmd_list);
+	queue_work(lo->workqueue, work);
+	spin_unlock_irq(&lo->lo_lock);
 }
 
 static void loop_update_rotational(struct loop_device *lo)
@@ -1007,14 +1070,25 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	size = get_loop_size(lo, file);
 	if ((loff_t)(sector_t)size != size)
 		goto out_unlock;
-	error = loop_prepare_queue(lo);
-	if (error)
+	lo->workqueue = alloc_workqueue("loop%d",
+					WQ_UNBOUND | WQ_FREEZABLE |
+					WQ_MEM_RECLAIM,
+					lo->lo_number);
+	if (!lo->workqueue) {
+		error = -ENOMEM;
 		goto out_unlock;
+	}
 
 	error = 0;
 
 	set_device_ro(bdev, (lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
+	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
+	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
+	INIT_LIST_HEAD(&lo->idle_worker_list);
+	lo->worker_tree = RB_ROOT;
+	timer_setup(&lo->timer, loop_free_idle_workers,
+		TIMER_DEFERRABLE);
 	lo->use_dio = false;
 	lo->lo_device = bdev;
 	lo->lo_flags = lo_flags;
@@ -1123,6 +1197,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	int err = 0;
 	bool partscan = false;
 	int lo_number;
+	struct loop_worker *pos, *worker;
 
 	mutex_lock(&loop_ctl_mutex);
 	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
@@ -1140,8 +1215,17 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	blk_mq_freeze_queue(lo->lo_queue);
 
 	spin_lock_irq(&lo->lo_lock);
+	destroy_workqueue(lo->workqueue);
 	lo->lo_backing_file = NULL;
+	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
+				idle_list) {
+		list_del(&worker->idle_list);
+		rb_erase(&worker->rb_node, &lo->worker_tree);
+		css_put(worker->css);
+		kfree(worker);
+	}
 	spin_unlock_irq(&lo->lo_lock);
+	del_timer_sync(&lo->timer);
 
 	loop_release_xfer(lo);
 	lo->transfer = NULL;
@@ -1176,7 +1260,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
 	lo_number = lo->lo_number;
-	loop_unprepare_queue(lo);
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan) {
@@ -1954,7 +2037,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	} else
 #endif
 		cmd->css = NULL;
-	kthread_queue_work(&lo->worker, &cmd->work);
+	loop_queue_work(lo, cmd);
 
 	return BLK_STS_OK;
 }
@@ -1983,26 +2066,82 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	}
 }
 
-static void loop_queue_work(struct kthread_work *work)
+static void loop_set_timer(struct loop_device *lo)
+{
+	timer_reduce(&lo->timer, jiffies + LOOP_IDLE_WORKER_TIMEOUT);
+}
+
+static void loop_process_work(struct loop_worker *worker,
+			struct list_head *cmd_list, struct loop_device *lo)
 {
-	struct loop_cmd *cmd =
-		container_of(work, struct loop_cmd, work);
+	int orig_flags = current->flags;
+	struct loop_cmd *cmd;
 
-	loop_handle_cmd(cmd);
+	current->flags |= PF_LESS_THROTTLE | PF_MEMALLOC_NOIO;
+	spin_lock_irq(&lo->lo_lock);
+	while (!list_empty(cmd_list)) {
+		cmd = container_of(
+			cmd_list->next, struct loop_cmd, list_entry);
+		list_del(cmd_list->next);
+		spin_unlock_irq(&lo->lo_lock);
+
+		loop_handle_cmd(cmd);
+		cond_resched();
+
+		spin_lock_irq(&lo->lo_lock);
+	}
+
+	/*
+	 * We only add to the idle list if there are no pending cmds
+	 * *and* the worker will not run again which ensures that it
+	 * is safe to free any worker on the idle list
+	 */
+	if (worker && !work_pending(&worker->work)) {
+		worker->last_ran_at = jiffies;
+		list_add_tail(&worker->idle_list, &lo->idle_worker_list);
+		loop_set_timer(lo);
+	}
+	spin_unlock_irq(&lo->lo_lock);
+	current->flags = orig_flags;
 }
 
-static int loop_init_request(struct blk_mq_tag_set *set, struct request *rq,
-		unsigned int hctx_idx, unsigned int numa_node)
+static void loop_workfn(struct work_struct *work)
 {
-	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
+	struct loop_worker *worker =
+		container_of(work, struct loop_worker, work);
+	loop_process_work(worker, &worker->cmd_list, worker->lo);
+}
 
-	kthread_init_work(&cmd->work, loop_queue_work);
-	return 0;
+static void loop_rootcg_workfn(struct work_struct *work)
+{
+	struct loop_device *lo =
+		container_of(work, struct loop_device, rootcg_work);
+	loop_process_work(NULL, &lo->rootcg_cmd_list, lo);
+}
+
+static void loop_free_idle_workers(struct timer_list *timer)
+{
+	struct loop_device *lo = container_of(timer, struct loop_device, timer);
+	struct loop_worker *pos, *worker;
+
+	spin_lock_irq(&lo->lo_lock);
+	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
+				idle_list) {
+		if (time_is_after_jiffies(worker->last_ran_at +
+						LOOP_IDLE_WORKER_TIMEOUT))
+			break;
+		list_del(&worker->idle_list);
+		rb_erase(&worker->rb_node, &lo->worker_tree);
+		css_put(worker->css);
+		kfree(worker);
+	}
+	if (!list_empty(&lo->idle_worker_list))
+		loop_set_timer(lo);
+	spin_unlock_irq(&lo->lo_lock);
 }
 
 static const struct blk_mq_ops loop_mq_ops = {
 	.queue_rq       = loop_queue_rq,
-	.init_request	= loop_init_request,
 	.complete	= lo_complete_rq,
 };
 
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index af75a5ee4094..87fd0e372227 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -14,7 +14,6 @@
 #include <linux/blk-mq.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
-#include <linux/kthread.h>
 #include <uapi/linux/loop.h>
 
 /* Possible states of device */
@@ -54,8 +53,12 @@ struct loop_device {
 
 	spinlock_t		lo_lock;
 	int			lo_state;
-	struct kthread_worker	worker;
-	struct task_struct	*worker_task;
+	struct workqueue_struct *workqueue;
+	struct work_struct      rootcg_work;
+	struct list_head        rootcg_cmd_list;
+	struct list_head        idle_worker_list;
+	struct rb_root          worker_tree;
+	struct timer_list       timer;
 	bool			use_dio;
 	bool			sysfs_inited;
 
@@ -65,7 +68,7 @@ struct loop_device {
 };
 
 struct loop_cmd {
-	struct kthread_work work;
+	struct list_head list_entry;
 	bool use_aio; /* use AIO interface to handle I/O */
 	atomic_t ref; /* only for aio */
 	long ret;
-- 
2.24.1

