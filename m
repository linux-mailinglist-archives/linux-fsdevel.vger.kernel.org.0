Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA173EBA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 22:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjFZURX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 16:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjFZURV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:17:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AEC10A
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 13:17:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bf179fcc200so4785224276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 13:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687810639; x=1690402639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sq8+wU1+ftupKRzTavGvuGzAv+IrA9NsG4RPXvRV+Hg=;
        b=2d0SSP77yGd4ZQlpVXn6Esny2V4NSGEGR5oafruotot9uscE8sjU7Jh7A1DGeOTqy9
         CuMWKEY+FRpMia9A/yIf99c2NWkCdQ+wZHAKbW2FOxGXxyX7aZvduGJ7958Ph98CQkDu
         g7Kfp5+LOAEeEs5cXK4CeqrYApQd9Rj/qgUuwVTdstap1H6fmBPcQRRdWXzgb3dLOpoa
         lkkP4QVsYQ5JwA83o0mir5tTEY8n8DJhts7Th2lGirLGMgxwcksn5pyklD+lH2E/4Tae
         5uIu1VHl7k1u5gwH52OcxLWPX8PcO/5UV3kKAsmY/m3YgBVRz/cX2PaSWor0jCNPj5ra
         3jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687810639; x=1690402639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sq8+wU1+ftupKRzTavGvuGzAv+IrA9NsG4RPXvRV+Hg=;
        b=jMx0o7PzJmZ7DRuz4vFzue42bigv2NDjl0vLIj0ibedVnRJRbWBxpyDQXYrmxYmIxJ
         LiGKcCuFHL435o0mUTl43c1cMPRjWITCohaBwNE9dcoSZ3dwxvV9uv+Rsna+XZjEcGlN
         e/IZthv/fSZVeJXX9BfxqoM5rBGYzeqd/FVo1PwGUqVtuLREPJ5v0z/u1yAqn0W6S+TH
         p/G0R+WB9lOTyh6suZd9TxmVRhMax1qxn9jnqjx9cSwj0dIR+FwrLKHZdk8bDdMkdhO0
         VzjFmgL7/HiA7k5zypBviZ+qwv6b5WnaYppzpCasFXn5qB6O4XkCYRpWnUExm8bi/w+T
         yrxg==
X-Gm-Message-State: AC+VfDzveFIWz+40AfbkTgl+W8Xr7mxjzyvbVad2TMHowaD7g4+AMwHF
        tRyOSAlYhWtyxZhIg3krgkTYGQxzd7c=
X-Google-Smtp-Source: ACHHUZ4XnZKHuCo16a3SZOE/O+xUPoveV8UD+slKJwbV5A01nS2kTPLa1yR8bGryBYdepWpIFCoRPGNg8ac=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5075:f38d:ce2f:eb1b])
 (user=surenb job=sendgmr) by 2002:a25:dfc2:0:b0:c1d:b0f8:752a with SMTP id
 w185-20020a25dfc2000000b00c1db0f8752amr1848392ybg.3.1687810639016; Mon, 26
 Jun 2023 13:17:19 -0700 (PDT)
Date:   Mon, 26 Jun 2023 13:17:13 -0700
In-Reply-To: <20230626201713.1204982-1-surenb@google.com>
Mime-Version: 1.0
References: <20230626201713.1204982-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230626201713.1204982-2-surenb@google.com>
Subject: [PATCH 2/2] sched/psi: tie psi trigger destruction with file's lifecycle
From:   Suren Baghdasaryan <surenb@google.com>
To:     tj@kernel.org
Cc:     gregkh@linuxfoundation.org, peterz@infradead.org,
        lujialin4@huawei.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, ebiggers@kernel.org, oleg@redhat.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Destroying psi trigger in cgroup_file_release causes UAF issues when
a cgroup is removed from under a polling process. This is happening
because cgroup removal causes a call to cgroup_file_release via this
path:

do_rmdir
  cgroup_rmdir
    kernfs_drain_open_files
      cgroup_file_release
        cgroup_pressure_release

while the actual file is still alive. Destroying the trigger at this
point would also destroy its waitqueue head and if there is still a
polling process on that file accessing the waitqueue, it will step
on a freed pointer.
Patch [1] fixed this issue for epoll() case using wake_up_pollfree(),
however the same issue exists for synchronous poll() case.
The root cause of this issue is that the lifecycles of the psi trigger's
waitqueue and of the file associated with the trigger are different. Fix
this by destroying the trigger from inside kernfs_ops.free operation
which is tied to the last fput() of the file. This also renders the fix
in [1] obsolete, so revert it.

[1] commit c2dbe32d5db5 ("sched/psi: Fix use-after-free in ep_remove_wait_queue()")

Reported-by: Lu Jialin <lujialin4@huawei.com>
Closes: https://lore.kernel.org/all/20230613062306.101831-1-lujialin4@huawei.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/cgroup-defs.h |  1 +
 include/linux/psi.h         |  6 +++++-
 kernel/cgroup/cgroup.c      | 29 ++++++++++++++++++++++++++++-
 kernel/sched/psi.c          | 13 ++++++-------
 4 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 8a0d5466c7be..6f5230a8821f 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -598,6 +598,7 @@ struct cftype {
 
 	int (*open)(struct kernfs_open_file *of);
 	void (*release)(struct kernfs_open_file *of);
+	void (*free)(struct kernfs_open_file *of);
 
 	/*
 	 * read_u64() is a shortcut for the common case of returning a
diff --git a/include/linux/psi.h b/include/linux/psi.h
index ab26200c2803..ebb4c7efba84 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -25,7 +25,11 @@ void psi_memstall_leave(unsigned long *flags);
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
 struct psi_trigger *psi_trigger_create(struct psi_group *group,
 			char *buf, enum psi_res res, struct file *file);
-void psi_trigger_destroy(struct psi_trigger *t);
+void psi_trigger_disable(struct psi_trigger *t);
+static inline void psi_trigger_destroy(struct psi_trigger *t)
+{
+	kfree(t);
+}
 
 __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
 			poll_table *wait);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4d42f0cbc11e..62e91ce6ca20 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3895,6 +3895,13 @@ static void cgroup_pressure_release(struct kernfs_open_file *of)
 {
 	struct cgroup_file_ctx *ctx = of->priv;
 
+	psi_trigger_disable(ctx->psi.trigger);
+}
+
+static void cgroup_pressure_free(struct kernfs_open_file *of)
+{
+	struct cgroup_file_ctx *ctx = of->priv;
+
 	psi_trigger_destroy(ctx->psi.trigger);
 }
 
@@ -4055,7 +4062,21 @@ static void cgroup_file_release(struct kernfs_open_file *of)
 	if (cft->release)
 		cft->release(of);
 	put_cgroup_ns(ctx->ns);
-	kfree(ctx);
+	/* Keep the context alive until cft->free is called */
+	if (!cft->free)
+		kfree(ctx);
+}
+
+static void cgroup_file_free(struct kernfs_open_file *of)
+{
+	struct cftype *cft = of_cft(of);
+
+	if (cft->free) {
+		struct cgroup_file_ctx *ctx = of->priv;
+
+		cft->free(of);
+		kfree(ctx);
+	}
 }
 
 static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
@@ -4158,6 +4179,7 @@ static struct kernfs_ops cgroup_kf_single_ops = {
 	.atomic_write_len	= PAGE_SIZE,
 	.open			= cgroup_file_open,
 	.release		= cgroup_file_release,
+	.free			= cgroup_file_free,
 	.write			= cgroup_file_write,
 	.poll			= cgroup_file_poll,
 	.seq_show		= cgroup_seqfile_show,
@@ -4167,6 +4189,7 @@ static struct kernfs_ops cgroup_kf_ops = {
 	.atomic_write_len	= PAGE_SIZE,
 	.open			= cgroup_file_open,
 	.release		= cgroup_file_release,
+	.free			= cgroup_file_free,
 	.write			= cgroup_file_write,
 	.poll			= cgroup_file_poll,
 	.seq_start		= cgroup_seqfile_start,
@@ -5294,6 +5317,7 @@ static struct cftype cgroup_psi_files[] = {
 		.write = cgroup_io_pressure_write,
 		.poll = cgroup_pressure_poll,
 		.release = cgroup_pressure_release,
+		.free = cgroup_pressure_free,
 	},
 	{
 		.name = "memory.pressure",
@@ -5302,6 +5326,7 @@ static struct cftype cgroup_psi_files[] = {
 		.write = cgroup_memory_pressure_write,
 		.poll = cgroup_pressure_poll,
 		.release = cgroup_pressure_release,
+		.free = cgroup_pressure_free,
 	},
 	{
 		.name = "cpu.pressure",
@@ -5310,6 +5335,7 @@ static struct cftype cgroup_psi_files[] = {
 		.write = cgroup_cpu_pressure_write,
 		.poll = cgroup_pressure_poll,
 		.release = cgroup_pressure_release,
+		.free = cgroup_pressure_free,
 	},
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	{
@@ -5319,6 +5345,7 @@ static struct cftype cgroup_psi_files[] = {
 		.write = cgroup_irq_pressure_write,
 		.poll = cgroup_pressure_poll,
 		.release = cgroup_pressure_release,
+		.free = cgroup_pressure_free,
 	},
 #endif
 	{
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index e072f6b31bf3..b4ad50805e08 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -622,7 +622,7 @@ static void psi_schedule_rtpoll_work(struct psi_group *group, unsigned long dela
 
 	task = rcu_dereference(group->rtpoll_task);
 	/*
-	 * kworker might be NULL in case psi_trigger_destroy races with
+	 * kworker might be NULL in case psi_trigger_disable races with
 	 * psi_task_change (hotpath) which can't use locks
 	 */
 	if (likely(task))
@@ -1372,7 +1372,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	return t;
 }
 
-void psi_trigger_destroy(struct psi_trigger *t)
+void psi_trigger_disable(struct psi_trigger *t)
 {
 	struct psi_group *group;
 	struct task_struct *task_to_destroy = NULL;
@@ -1386,11 +1386,10 @@ void psi_trigger_destroy(struct psi_trigger *t)
 
 	group = t->group;
 	/*
-	 * Wakeup waiters to stop polling and clear the queue to prevent it from
-	 * being accessed later. Can happen if cgroup is deleted from under a
-	 * polling process.
+	 * Wakeup waiters to stop polling. Can happen if cgroup is deleted
+	 * from under a polling process.
 	 */
-	wake_up_pollfree(&t->event_wait);
+	wake_up_interruptible(&t->event_wait);
 
 	if (t->aggregator == PSI_AVGS) {
 		mutex_lock(&group->avgs_lock);
@@ -1446,7 +1445,6 @@ void psi_trigger_destroy(struct psi_trigger *t)
 		kthread_stop(task_to_destroy);
 		atomic_set(&group->rtpoll_scheduled, 0);
 	}
-	kfree(t);
 }
 
 __poll_t psi_trigger_poll(void **trigger_ptr,
@@ -1573,6 +1571,7 @@ static int psi_fop_release(struct inode *inode, struct file *file)
 {
 	struct seq_file *seq = file->private_data;
 
+	psi_trigger_disable(seq->private);
 	psi_trigger_destroy(seq->private);
 	return single_release(inode, file);
 }
-- 
2.41.0.162.gfafddb0af9-goog

