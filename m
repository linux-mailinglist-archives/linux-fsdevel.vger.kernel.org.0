Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF763250147
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgHXPj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgHXPik (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:38:40 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB2AC061797;
        Mon, 24 Aug 2020 08:38:05 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k18so6434062qtm.10;
        Mon, 24 Aug 2020 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ckAtjHcJOwaVSUeYgTAhDX9DuJ7NFFHp2LflIRMsvo=;
        b=nnLzC/Tbu8EG4EQLUh1rQ1oWrrSDBUwLwvqXQZkdi3E75Vr9vGDLW8E3ki69yT2+Hr
         IB/B2nKt/JANUz1txl8ltQ1BkIn7BCW1uV/c5jsaz2yh6gQj6ZSJO4ypr0T10vHhEDle
         s5P53ZlmeWinIAcJ0Izp3UgG3C7XMkm1Wl9OzT05ADa7VM1sAbJiBS45gdkgovrth1TR
         hDfS6OzS7OyNhkVEtQW/5oorykjMRWzFz8gQBesKSb2VmJiLh0Z9c1RnyltHXwJCjAsF
         i/qJJKHIFfsXoEt34WyaptEakC1unEVUyAU+9dB7OmUBPziBzMpDpg5T5Vsi37IaVUHW
         5cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ckAtjHcJOwaVSUeYgTAhDX9DuJ7NFFHp2LflIRMsvo=;
        b=LTWlWF2RowMe0sHgpqlDrHKzDoJs/57z7As5LqEPNFd/insiTfXIRymANrxwFuAodo
         0t25Dy53BH6UeGZdtVQv6CrHwN3LegzJA5IK1ROTLGydB/ibIIetCCLdij2oeVkoNDJ2
         V1daF25fpVZbXYx2uzsUV6/NPd7YUK4gC6PkQiXZ7OmwqF/yqYry2AhAndgRHa3hAiZ/
         clDTMEHs7wyPACuft9u1Gk8KUjuvE/uOmKM795jZhnAWssXQSdYGEXeA8y7OKWY9SHrT
         2rICdKMXzl8kv7MinPAczDGoinvci43yucSGqQzfenba/daPJUpViK0WA6mCbq/wl81b
         BHYA==
X-Gm-Message-State: AOAM531s+B2X6TZcSVCYjnc+XmY7TsFOLHV0BQAZ24nUdgRR9bt4PI/d
        xgSb7F8d1pepfe6KqZHOVR4=
X-Google-Smtp-Source: ABdhPJz1Hwbu5Otr/qHLJUXZggCdoNRReRZhCYBmY+Cl8rQhpiWRbW8QX6AqXd8ZPiUxQrknN2wkxg==
X-Received: by 2002:ac8:4514:: with SMTP id q20mr5393116qtn.122.1598283484416;
        Mon, 24 Aug 2020 08:38:04 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:480::1:dd21])
        by smtp.gmail.com with ESMTPSA id m17sm10942758qkn.45.2020.08.24.08.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:38:03 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michel Lespinasse <walken@google.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH 4/4] loop: Charge i/o to mem and blk cg
Date:   Mon, 24 Aug 2020 11:36:02 -0400
Message-Id: <20200824153607.6595-5-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824153607.6595-1-schatzberg.dan@gmail.com>
References: <20200824153607.6595-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current code only associates with the existing blkcg when aio is
used to access the backing file. This patch covers all types of i/o to
the backing file and also associates the memcg so if the backing file is
on tmpfs, memory is charged appropriately.

This patch also exports cgroup_get_e_css so it can be used by the loop
module.

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 drivers/block/loop.c       | 61 +++++++++++++++++++++++++-------------
 drivers/block/loop.h       |  3 +-
 include/linux/memcontrol.h |  6 ++++
 kernel/cgroup/cgroup.c     |  1 +
 mm/shmem.c                 |  1 -
 5 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c8dae53f3914..102d236d1540 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -77,6 +77,7 @@
 #include <linux/uio.h>
 #include <linux/ioprio.h>
 #include <linux/blk-cgroup.h>
+#include <linux/sched/mm.h>
 
 #include "loop.h"
 
@@ -518,8 +519,6 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
 {
 	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
 
-	if (cmd->css)
-		css_put(cmd->css);
 	cmd->ret = ret;
 	lo_rw_aio_do_completion(cmd);
 }
@@ -580,8 +579,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
-	if (cmd->css)
-		kthread_associate_blkcg(cmd->css);
 
 	if (rw == WRITE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
@@ -589,7 +586,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		ret = call_read_iter(file, &cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);
-	kthread_associate_blkcg(NULL);
 
 	if (ret != -EIOCBQUEUED)
 		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
@@ -929,7 +925,7 @@ struct loop_worker {
 	struct list_head cmd_list;
 	struct list_head idle_list;
 	struct loop_device *lo;
-	struct cgroup_subsys_state *css;
+	struct cgroup_subsys_state *blkcg_css;
 	unsigned long last_ran_at;
 };
 
@@ -946,7 +942,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 
 	spin_lock_irq(&lo->lo_work_lock);
 
-	if (!cmd->css)
+	if (!cmd->blkcg_css)
 		goto queue_work;
 
 	node = &lo->worker_tree.rb_node;
@@ -954,10 +950,10 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	while (*node) {
 		parent = *node;
 		cur_worker = container_of(*node, struct loop_worker, rb_node);
-		if (cur_worker->css == cmd->css) {
+		if (cur_worker->blkcg_css == cmd->blkcg_css) {
 			worker = cur_worker;
 			break;
-		} else if ((long)cur_worker->css < (long)cmd->css) {
+		} else if ((long)cur_worker->blkcg_css < (long)cmd->blkcg_css) {
 			node = &(*node)->rb_left;
 		} else {
 			node = &(*node)->rb_right;
@@ -969,13 +965,18 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT | __GFP_NOWARN);
 	/*
 	 * In the event we cannot allocate a worker, just queue on the
-	 * rootcg worker
+	 * rootcg worker and issue the I/O as the rootcg
 	 */
-	if (!worker)
+	if (!worker) {
+		cmd->blkcg_css = NULL;
+		if (cmd->memcg_css)
+			css_put(cmd->memcg_css);
+		cmd->memcg_css = NULL;
 		goto queue_work;
+	}
 
-	worker->css = cmd->css;
-	css_get(worker->css);
+	worker->blkcg_css = cmd->blkcg_css;
+	css_get(worker->blkcg_css);
 	INIT_WORK(&worker->work, loop_workfn);
 	INIT_LIST_HEAD(&worker->cmd_list);
 	INIT_LIST_HEAD(&worker->idle_list);
@@ -1301,7 +1302,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 				idle_list) {
 		list_del(&worker->idle_list);
 		rb_erase(&worker->rb_node, &lo->worker_tree);
-		css_put(worker->css);
+		css_put(worker->blkcg_css);
 		kfree(worker);
 	}
 	spin_unlock_irq(&lo->lo_work_lock);
@@ -2102,13 +2103,18 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	/* always use the first bio's css */
+	cmd->blkcg_css = NULL;
+	cmd->memcg_css = NULL;
 #ifdef CONFIG_BLK_CGROUP
-	if (cmd->use_aio && rq->bio && rq->bio->bi_blkg) {
-		cmd->css = &bio_blkcg(rq->bio)->css;
-		css_get(cmd->css);
-	} else
+	if (rq->bio && rq->bio->bi_blkg) {
+		cmd->blkcg_css = &bio_blkcg(rq->bio)->css;
+#ifdef CONFIG_MEMCG
+		cmd->memcg_css =
+			cgroup_get_e_css(cmd->blkcg_css->cgroup,
+					&memory_cgrp_subsys);
+#endif
+	}
 #endif
-		cmd->css = NULL;
 	loop_queue_work(lo, cmd);
 
 	return BLK_STS_OK;
@@ -2120,13 +2126,28 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	const bool write = op_is_write(req_op(rq));
 	struct loop_device *lo = rq->q->queuedata;
 	int ret = 0;
+	struct mem_cgroup *old_memcg = NULL;
 
 	if (write && (lo->lo_flags & LO_FLAGS_READ_ONLY)) {
 		ret = -EIO;
 		goto failed;
 	}
 
+	if (cmd->blkcg_css)
+		kthread_associate_blkcg(cmd->blkcg_css);
+	if (cmd->memcg_css)
+		old_memcg = memalloc_use_memcg(
+			mem_cgroup_from_css(cmd->memcg_css));
+
 	ret = do_req_filebacked(lo, rq);
+
+	if (cmd->blkcg_css)
+		kthread_associate_blkcg(NULL);
+
+	if (cmd->memcg_css) {
+		memalloc_use_memcg(old_memcg);
+		css_put(cmd->memcg_css);
+	}
  failed:
 	/* complete non-aio request */
 	if (!cmd->use_aio || ret) {
@@ -2205,7 +2226,7 @@ static void loop_free_idle_workers(struct timer_list *timer)
 			break;
 		list_del(&worker->idle_list);
 		rb_erase(&worker->rb_node, &lo->worker_tree);
-		css_put(worker->css);
+		css_put(worker->blkcg_css);
 		kfree(worker);
 	}
 	if (!list_empty(&lo->idle_worker_list))
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 0162b55a68e1..4d6886d9855a 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -75,7 +75,8 @@ struct loop_cmd {
 	long ret;
 	struct kiocb iocb;
 	struct bio_vec *bvec;
-	struct cgroup_subsys_state *css;
+	struct cgroup_subsys_state *blkcg_css;
+	struct cgroup_subsys_state *memcg_css;
 };
 
 /* Support for loadable transfer modules */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d0b036123c6a..fceac9f66d96 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1031,6 +1031,12 @@ static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
 	return NULL;
 }
 
+static inline
+struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
+{
+	return NULL;
+}
+
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index dd247747ec14..16d059a89a68 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -580,6 +580,7 @@ struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgrp,
 	rcu_read_unlock();
 	return css;
 }
+EXPORT_SYMBOL_GPL(cgroup_get_e_css);
 
 static void cgroup_get_live(struct cgroup *cgrp)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index 77c908730be4..1139f52ac4ee 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1696,7 +1696,6 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
-	struct mem_cgroup *memcg;
 	struct page *page;
 	swp_entry_t swap;
 	int error;
-- 
2.24.1

