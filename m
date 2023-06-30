Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6059743201
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 02:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjF3A4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 20:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjF3A4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:56:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C162D4A
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 17:56:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5618857518dso10951727b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 17:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688086576; x=1690678576;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sgorMI4uV386GpDJgiPMhnJ8nR8p5gk6mmTxmX1Kf4Q=;
        b=MYu1MGn7YApvcxFvlt3r4VG13lz/inFz8rkIAVKakhczl5mNKpbKQJucRj3+c2Uyb8
         aLYAy5tW4lnLMet1X4jPTC5IdHeLxeXaAa8IXmhEkb/UOJc15VDm3KEDr9fh9Q/WBGS1
         1AfLxz6Vxo/GmOwPwVAMgyTlkeJgY8UJboRQtJ0QCmu1wbdqxrkM1ewTNIwJv75XZMgy
         5FjqAWs2uPLT25TlKc4bZP2L4omt0SFZKXiELHC4a9Z5J0clYgwlTj4PBTRsgVKj+mf/
         FKdJYQI7uGj+0eIi2U4k51Y5UmphHJCsVkHu5CxKUlVwGkPqWcBPvchKN3BegFZ5m5yF
         q0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688086576; x=1690678576;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sgorMI4uV386GpDJgiPMhnJ8nR8p5gk6mmTxmX1Kf4Q=;
        b=ajW+MZsHdBxtW+3GlxlgtQZD/MLVlj8oWpCvVh1UGjlzhS7g8xEwpbP+aJDjJPQckB
         RrrKvnOeHx0gD3jP3UUl31jQINgT2KfNnm/L/Z8z2p/xgIWBTTFKk/HEZ3zsXVDvZcb+
         QEPkqlUBUlzP9DGBKllQrYYC9Ye5s8a5544YXRR3yLUmGa/xUenq/WcXo3UU1GKiu4ne
         NoJ8+gb64lpN4kdH++xqzsjW4RNll5GDZhVMbkinki5PvTiEFJ5g0DAMBzGQPbtcUWHp
         O038f4bAwOfssh/nLq/3Pxpgj8D6PtpuYUg4BXKvXqErp08wbzEsXpAfEwdriB5sj012
         +FnQ==
X-Gm-Message-State: ABy/qLY8dT4n6b3d5Dvq96Rf51s33IAM/eCg3YBnEmW2u+lwgWdpiY2m
        2Na+rrdNiua7+9rB1lqUpIZz3iJK6OM=
X-Google-Smtp-Source: APBJJlFkqpALSPMGrrryA6GDbbNk761BS+AfMXIJju9RN0VtjAuYPcSOcoW1zh95K4m6yLN7z47kZjLVh14=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:1f11:a3d0:19a9:16e5])
 (user=surenb job=sendgmr) by 2002:a81:410e:0:b0:573:87b9:7ee9 with SMTP id
 o14-20020a81410e000000b0057387b97ee9mr7249ywa.4.1688086576016; Thu, 29 Jun
 2023 17:56:16 -0700 (PDT)
Date:   Thu, 29 Jun 2023 17:56:12 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630005612.1014540-1-surenb@google.com>
Subject: [PATCH v2 1/1] sched/psi: use kernfs polling functions for PSI
 trigger polling
From:   Suren Baghdasaryan <surenb@google.com>
To:     peterz@infradead.org
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, juri.lelli@redhat.com,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Destroying psi trigger in cgroup_file_release causes UAF issues when
a cgroup is removed from under a polling process. This is happening
because cgroup removal causes a call to cgroup_file_release while the
actual file is still alive. Destroying the trigger at this point would
also destroy its waitqueue head and if there is still a polling process
on that file accessing the waitqueue, it will step on the freed pointer:

do_select
  vfs_poll
                           do_rmdir
                             cgroup_rmdir
                               kernfs_drain_open_files
                                 cgroup_file_release
                                   cgroup_pressure_release
                                     psi_trigger_destroy
                                       wake_up_pollfree(&t->event_wait)
// vfs_poll is unblocked
                                       synchronize_rcu
                                       kfree(t)
  poll_freewait -> UAF access to the trigger's waitqueue head

Patch [1] fixed this issue for epoll() case using wake_up_pollfree(),
however the same issue exists for synchronous poll() case.
The root cause of this issue is that the lifecycles of the psi trigger's
waitqueue and of the file associated with the trigger are different. Fix
this by using kernfs_generic_poll function when polling on cgroup-specific
psi triggers. It internally uses kernfs_open_node->poll waitqueue head
with its lifecycle tied to the file's lifecycle. This also renders the
fix in [1] obsolete, so revert it.

[1] commit c2dbe32d5db5 ("sched/psi: Fix use-after-free in ep_remove_wait_queue()")

Fixes: 0e94682b73bf ("psi: introduce psi monitor")
Reported-by: Lu Jialin <lujialin4@huawei.com>
Closes: https://lore.kernel.org/all/20230613062306.101831-1-lujialin4@huawei.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/psi.h       |  5 +++--
 include/linux/psi_types.h |  3 +++
 kernel/cgroup/cgroup.c    |  2 +-
 kernel/sched/psi.c        | 29 +++++++++++++++++++++--------
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index ab26200c2803..e0745873e3f2 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -23,8 +23,9 @@ void psi_memstall_enter(unsigned long *flags);
 void psi_memstall_leave(unsigned long *flags);
 
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
-struct psi_trigger *psi_trigger_create(struct psi_group *group,
-			char *buf, enum psi_res res, struct file *file);
+struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
+				       enum psi_res res, struct file *file,
+				       struct kernfs_open_file *of);
 void psi_trigger_destroy(struct psi_trigger *t);
 
 __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 040c089581c6..f1fd3a8044e0 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -137,6 +137,9 @@ struct psi_trigger {
 	/* Wait queue for polling */
 	wait_queue_head_t event_wait;
 
+	/* Kernfs file for cgroup triggers */
+	struct kernfs_open_file *of;
+
 	/* Pending event flag */
 	int event;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index bfe3cd8ccf36..f55a40db065f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3730,7 +3730,7 @@ static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
 	}
 
 	psi = cgroup_psi(cgrp);
-	new = psi_trigger_create(psi, buf, res, of->file);
+	new = psi_trigger_create(psi, buf, res, of->file, of);
 	if (IS_ERR(new)) {
 		cgroup_put(cgrp);
 		return PTR_ERR(new);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 81fca77397f6..9bb3f2b3ccfc 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -493,8 +493,12 @@ static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
 			continue;
 
 		/* Generate an event */
-		if (cmpxchg(&t->event, 0, 1) == 0)
-			wake_up_interruptible(&t->event_wait);
+		if (cmpxchg(&t->event, 0, 1) == 0) {
+			if (t->of)
+				kernfs_notify(t->of->kn);
+			else
+				wake_up_interruptible(&t->event_wait);
+		}
 		t->last_event_time = now;
 		/* Reset threshold breach flag once event got generated */
 		t->pending_event = false;
@@ -1271,8 +1275,9 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 	return 0;
 }
 
-struct psi_trigger *psi_trigger_create(struct psi_group *group,
-			char *buf, enum psi_res res, struct file *file)
+struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
+				       enum psi_res res, struct file *file,
+				       struct kernfs_open_file *of)
 {
 	struct psi_trigger *t;
 	enum psi_states state;
@@ -1331,7 +1336,9 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 
 	t->event = 0;
 	t->last_event_time = 0;
-	init_waitqueue_head(&t->event_wait);
+	t->of = of;
+	if (!of)
+		init_waitqueue_head(&t->event_wait);
 	t->pending_event = false;
 	t->aggregator = privileged ? PSI_POLL : PSI_AVGS;
 
@@ -1388,7 +1395,10 @@ void psi_trigger_destroy(struct psi_trigger *t)
 	 * being accessed later. Can happen if cgroup is deleted from under a
 	 * polling process.
 	 */
-	wake_up_pollfree(&t->event_wait);
+	if (t->of)
+		kernfs_notify(t->of->kn);
+	else
+		wake_up_interruptible(&t->event_wait);
 
 	if (t->aggregator == PSI_AVGS) {
 		mutex_lock(&group->avgs_lock);
@@ -1465,7 +1475,10 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
 	if (!t)
 		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
 
-	poll_wait(file, &t->event_wait, wait);
+	if (t->of)
+		kernfs_generic_poll(t->of, wait);
+	else
+		poll_wait(file, &t->event_wait, wait);
 
 	if (cmpxchg(&t->event, 1, 0) == 1)
 		ret |= EPOLLPRI;
@@ -1535,7 +1548,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 		return -EBUSY;
 	}
 
-	new = psi_trigger_create(&psi_system, buf, res, file);
+	new = psi_trigger_create(&psi_system, buf, res, file, NULL);
 	if (IS_ERR(new)) {
 		mutex_unlock(&seq->lock);
 		return PTR_ERR(new);
-- 
2.41.0.255.g8b1d071c50-goog

