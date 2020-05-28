Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF1D1E6303
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 15:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390826AbgE1Nzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 09:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390819AbgE1Nzg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 09:55:36 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBB5C08C5C6;
        Thu, 28 May 2020 06:55:35 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id fb16so12936666qvb.5;
        Thu, 28 May 2020 06:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yCJxjVJiob7hrGW2G0hac/uRBBnyrQcSugyMn+QGSV8=;
        b=i53O/UF2kb4RA4KjhpHC1Gs+OtOPnxOi5MfZ4OSSy2trR0+NlLFc/GosjZ+mzjL19N
         5mCHWxF97TRry2CrW8OkXlh9bCrYVtgP9n681qY9kjTsUKGVgT5HrZ3eTp2sOpJpgaFr
         KxJsoprg8zR10dxc5jhPtGhLP3h8/W+qnYEUhhiBvLJT+CwKSwFTjMjhkjmotCyfe/RR
         01QErMQa66u0OitMD/t56OwLwCvo3ys3+rjVXYf1++f2ziwb0OGuwy2/7Y22HAmSKPeT
         F9XUq0SiEkdYISJDWbzHbqJVkJ4N7Z6rqxs5UeWM7I0CY0rPj6wwIrcUOoncNsNZ+Ef0
         I+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCJxjVJiob7hrGW2G0hac/uRBBnyrQcSugyMn+QGSV8=;
        b=NSbT4us+0Es2WpPID4FB+Em5QH3WFixODiVTMZA2sk1n4/o0MVyk3pdlceM8vIvvYl
         LOCYZLVIew0T9ZNK5GjkwoBPzXWmLoV0tstLsKI9Dn84AxV809wjxbM/LUWu4N/jeVfb
         Mgi9hnXRN1uGHHHfF1GduQedNnAI6jrB1KZrTqFdh+cvnfYhvpf08UrWc1MePuvg1jrl
         yZkLHGs1CeIh8BX9wohhMIFimvZg6BPDcla6eyaI40HhtRm4yG/Kjh1t6pjo8OJmOBkc
         Nhp8ofNrVITRhvwQgE64plNVupVhgsc5h18ZxqAs9dW9dS6EFTKHpvQfUCS6x2OESvM/
         8QjQ==
X-Gm-Message-State: AOAM533bCFx2HZ0dAyeaZ3p8zNjCntCoib9tjrtpRyBl8KvQkiyrHDqM
        UEhgkrKEFtJOiF7Vrm2g3eU=
X-Google-Smtp-Source: ABdhPJylE92oI6jHfDbTTrXTlaHaVrUvMYYQ9jygJwokJdb7mbT1IW4tfg5rcEVPwZO1V1DoJXTHmA==
X-Received: by 2002:a0c:8c4a:: with SMTP id o10mr3220133qvb.123.1590674134267;
        Thu, 28 May 2020 06:55:34 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:480::1:1cb7])
        by smtp.gmail.com with ESMTPSA id l186sm4890889qkf.89.2020.05.28.06.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:55:33 -0700 (PDT)
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
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH 4/4] loop: Charge i/o to mem and blk cg
Date:   Thu, 28 May 2020 09:54:39 -0400
Message-Id: <20200528135444.11508-5-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200528135444.11508-1-schatzberg.dan@gmail.com>
References: <20200528135444.11508-1-schatzberg.dan@gmail.com>
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
 4 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 378a68e5ccf3..c238e274788e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -77,6 +77,7 @@
 #include <linux/uio.h>
 #include <linux/ioprio.h>
 #include <linux/blk-cgroup.h>
+#include <linux/sched/mm.h>
 
 #include "loop.h"
 
@@ -507,8 +508,6 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
 {
 	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
 
-	if (cmd->css)
-		css_put(cmd->css);
 	cmd->ret = ret;
 	lo_rw_aio_do_completion(cmd);
 }
@@ -569,8 +568,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
-	if (cmd->css)
-		kthread_associate_blkcg(cmd->css);
 
 	if (rw == WRITE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
@@ -578,7 +575,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		ret = call_read_iter(file, &cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);
-	kthread_associate_blkcg(NULL);
 
 	if (ret != -EIOCBQUEUED)
 		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
@@ -918,7 +914,7 @@ struct loop_worker {
 	struct list_head cmd_list;
 	struct list_head idle_list;
 	struct loop_device *lo;
-	struct cgroup_subsys_state *css;
+	struct cgroup_subsys_state *blkcg_css;
 	unsigned long last_ran_at;
 };
 
@@ -935,7 +931,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 
 	spin_lock_irq(&lo->lo_work_lock);
 
-	if (!cmd->css)
+	if (!cmd->blkcg_css)
 		goto queue_work;
 
 	node = &lo->worker_tree.rb_node;
@@ -943,10 +939,10 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
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
@@ -958,13 +954,18 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
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
@@ -1214,7 +1215,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 				idle_list) {
 		list_del(&worker->idle_list);
 		rb_erase(&worker->rb_node, &lo->worker_tree);
-		css_put(worker->css);
+		css_put(worker->blkcg_css);
 		kfree(worker);
 	}
 	spin_unlock_irq(&lo->lo_work_lock);
@@ -2027,13 +2028,18 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
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
@@ -2045,13 +2051,28 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
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
@@ -2129,7 +2150,7 @@ static void loop_free_idle_workers(struct timer_list *timer)
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
index 977edd3b7bd8..67a98db5be9e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -925,6 +925,12 @@ static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
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
index 06b5ea9d899d..a3c64d961d68 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -587,6 +587,7 @@ struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgrp,
 	rcu_read_unlock();
 	return css;
 }
+EXPORT_SYMBOL_GPL(cgroup_get_e_css);
 
 static void cgroup_get_live(struct cgroup *cgrp)
 {
-- 
2.24.1

