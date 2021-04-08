Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383D93580C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 12:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhDHKhM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 06:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhDHKhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:37:04 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D86C061762
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 03:36:53 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id p5so820486qvr.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 03:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G3Xq6UoPycIyFKKsJYoXqIgvhMnp8KWQM7260h+GZ6k=;
        b=aOyQ4Pw35KCMpXMA3/1Bbdev4QiOiG69AmqhvJYDCzmoQ7x2atREG78OFp3TrOz80F
         DGIEAw9H0nDHyNAFB5mecBKui+VTS//jPvGqMSOkMcSdJt8+5R4qrk5yNeQ9XNM+1wza
         e9wYwen8vFyR5mYuUELLrYSqv6EcFie2LBYGk6xUoI8OJNAYmwhrhN3l+OZ7zJmhp3yj
         CLOKRBqNdg2LUNYP47t3MZfq6FNjfkduSaNUWGQK+qZ4uidci+dxd6jcFhCXLJNpidhg
         PhGwMvpTlcqF0hCLHvjXwG6kfLsgh9SS6GKg6olmRVYIJpZyzvrBfzPSpryDisLrIhZ1
         Kl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G3Xq6UoPycIyFKKsJYoXqIgvhMnp8KWQM7260h+GZ6k=;
        b=F4gAHJ4RU/z6oPylPLBye1eTRQNPucoEfSiqv5uscTfWdttOEgDLbhvHVnU6qcMTTL
         U5GB8sWUE6oDrb/UGDabPxTVNI6t+DsxxVC+IVqd7VKrrLkSmta4GwlRCQ1fygDgUpGT
         zWupDMoYfQpKC8dk6bvqppM8fndqFREXmGgrlDktRmYCaLlla07VsFbJCNK/R3yGwXUf
         0pdAfqqPs0uWf5KB/8O8FWFSFJwehCk6MhRB1LMTonO0ZyNMi2M0xlbsghDtwxWYyg7G
         VADCKXdFPoI49Uikqhlnz3J/uM0lqsbpFfayqgkfuAUrWUJi9+7IWv/m6XEBMpWluu0C
         Z5gw==
X-Gm-Message-State: AOAM5339awCmJEXfSVfJ3kpOJD2zjfDn1QSjvPNfpiimPgW0aMui4EIH
        SUj1NdGZh50ruhbiB4BrwTM7HkykXQ==
X-Google-Smtp-Source: ABdhPJwTScg+3YfrfANr9VV/l2HLcVdS5DlHeJPR/wtqfWFBcSVO3u8onJ0Efuzy3mVR1yISG6gAHvlyhg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:9038:bbd3:4a12:abda])
 (user=elver job=sendgmr) by 2002:ad4:5e8b:: with SMTP id jl11mr7930340qvb.50.1617878212820;
 Thu, 08 Apr 2021 03:36:52 -0700 (PDT)
Date:   Thu,  8 Apr 2021 12:35:58 +0200
In-Reply-To: <20210408103605.1676875-1-elver@google.com>
Message-Id: <20210408103605.1676875-4-elver@google.com>
Mime-Version: 1.0
References: <20210408103605.1676875-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v4 03/10] perf: Support only inheriting events if cloned with CLONE_THREAD
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, oleg@redhat.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds bit perf_event_attr::inherit_thread, to restricting inheriting
events only if the child was cloned with CLONE_THREAD.

This option supports the case where an event is supposed to be
process-wide only (including subthreads), but should not propagate
beyond the current process's shared environment.

Link: https://lore.kernel.org/lkml/YBvj6eJR%2FDY2TsEB@hirez.programming.kicks-ass.net/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Add patch to series.
---
 include/linux/perf_event.h      |  5 +++--
 include/uapi/linux/perf_event.h |  3 ++-
 kernel/events/core.c            | 21 ++++++++++++++-------
 kernel/fork.c                   |  2 +-
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3d478abf411c..1660039199b2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -958,7 +958,7 @@ extern void __perf_event_task_sched_in(struct task_struct *prev,
 				       struct task_struct *task);
 extern void __perf_event_task_sched_out(struct task_struct *prev,
 					struct task_struct *next);
-extern int perf_event_init_task(struct task_struct *child);
+extern int perf_event_init_task(struct task_struct *child, u64 clone_flags);
 extern void perf_event_exit_task(struct task_struct *child);
 extern void perf_event_free_task(struct task_struct *task);
 extern void perf_event_delayed_put(struct task_struct *task);
@@ -1449,7 +1449,8 @@ perf_event_task_sched_in(struct task_struct *prev,
 static inline void
 perf_event_task_sched_out(struct task_struct *prev,
 			  struct task_struct *next)			{ }
-static inline int perf_event_init_task(struct task_struct *child)	{ return 0; }
+static inline int perf_event_init_task(struct task_struct *child,
+				       u64 clone_flags)			{ return 0; }
 static inline void perf_event_exit_task(struct task_struct *child)	{ }
 static inline void perf_event_free_task(struct task_struct *task)	{ }
 static inline void perf_event_delayed_put(struct task_struct *task)	{ }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index ad15e40d7f5d..813efb65fea8 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -389,7 +389,8 @@ struct perf_event_attr {
 				cgroup         :  1, /* include cgroup events */
 				text_poke      :  1, /* include text poke events */
 				build_id       :  1, /* use build id in mmap2 events */
-				__reserved_1   : 29;
+				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
+				__reserved_1   : 28;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a9a0a46909af..de2917b3c59e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11649,6 +11649,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	    (attr->sample_type & PERF_SAMPLE_WEIGHT_STRUCT))
 		return -EINVAL;
 
+	if (!attr->inherit && attr->inherit_thread)
+		return -EINVAL;
+
 out:
 	return ret;
 
@@ -12869,12 +12872,13 @@ static int
 inherit_task_group(struct perf_event *event, struct task_struct *parent,
 		   struct perf_event_context *parent_ctx,
 		   struct task_struct *child, int ctxn,
-		   int *inherited_all)
+		   u64 clone_flags, int *inherited_all)
 {
 	int ret;
 	struct perf_event_context *child_ctx;
 
-	if (!event->attr.inherit) {
+	if (!event->attr.inherit ||
+	    (event->attr.inherit_thread && !(clone_flags & CLONE_THREAD))) {
 		*inherited_all = 0;
 		return 0;
 	}
@@ -12906,7 +12910,8 @@ inherit_task_group(struct perf_event *event, struct task_struct *parent,
 /*
  * Initialize the perf_event context in task_struct
  */
-static int perf_event_init_context(struct task_struct *child, int ctxn)
+static int perf_event_init_context(struct task_struct *child, int ctxn,
+				   u64 clone_flags)
 {
 	struct perf_event_context *child_ctx, *parent_ctx;
 	struct perf_event_context *cloned_ctx;
@@ -12946,7 +12951,8 @@ static int perf_event_init_context(struct task_struct *child, int ctxn)
 	 */
 	perf_event_groups_for_each(event, &parent_ctx->pinned_groups) {
 		ret = inherit_task_group(event, parent, parent_ctx,
-					 child, ctxn, &inherited_all);
+					 child, ctxn, clone_flags,
+					 &inherited_all);
 		if (ret)
 			goto out_unlock;
 	}
@@ -12962,7 +12968,8 @@ static int perf_event_init_context(struct task_struct *child, int ctxn)
 
 	perf_event_groups_for_each(event, &parent_ctx->flexible_groups) {
 		ret = inherit_task_group(event, parent, parent_ctx,
-					 child, ctxn, &inherited_all);
+					 child, ctxn, clone_flags,
+					 &inherited_all);
 		if (ret)
 			goto out_unlock;
 	}
@@ -13004,7 +13011,7 @@ static int perf_event_init_context(struct task_struct *child, int ctxn)
 /*
  * Initialize the perf_event context in task_struct
  */
-int perf_event_init_task(struct task_struct *child)
+int perf_event_init_task(struct task_struct *child, u64 clone_flags)
 {
 	int ctxn, ret;
 
@@ -13013,7 +13020,7 @@ int perf_event_init_task(struct task_struct *child)
 	INIT_LIST_HEAD(&child->perf_event_list);
 
 	for_each_task_context_nr(ctxn) {
-		ret = perf_event_init_context(child, ctxn);
+		ret = perf_event_init_context(child, ctxn, clone_flags);
 		if (ret) {
 			perf_event_free_task(child);
 			return ret;
diff --git a/kernel/fork.c b/kernel/fork.c
index 426cd0c51f9e..f592c9a0272a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2084,7 +2084,7 @@ static __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_policy;
 
-	retval = perf_event_init_task(p);
+	retval = perf_event_init_task(p, clone_flags);
 	if (retval)
 		goto bad_fork_cleanup_policy;
 	retval = audit_alloc(p);
-- 
2.31.0.208.g409f899ff0-goog

