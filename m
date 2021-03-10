Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F79333A59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 11:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhCJKmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 05:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbhCJKl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:41:58 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5EFC061761
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 02:41:58 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id h134so12441194qke.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 02:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dOVfTFewU2OVBxfkqxI1NPon3rxqJk0MP/D8NHNSqQA=;
        b=q1jQ16YbsnqIDBn5nBGRtDoStGi+RN0sGNM2jXfR0WlnzZ0m1QJ+LuURos4FjT52Oj
         j5GJfLS9NZbPypEgX45w2ZaWBBIqOUxMg4w/QA7kuYIyM6DGtddI7j14cXsB1uOKooJR
         xlLaN3QhYFUnc8tqDxrGszVCHf4LntSANKCervuZRhsRtUNTLSQ1BRUG2wOJXiyZRqNT
         jZYMfmSKEODrH/cBBMftUMy1ScyCkdUUwpGw2QU3syBSWkCd+bFPsH53rNOacPywjo72
         Azvh9Fk7EBMxvXkTblPINbobb5NEaGoZTrRk4PK32kIHSJtJgoINr+KfcHX+qfPyXaU5
         6Vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dOVfTFewU2OVBxfkqxI1NPon3rxqJk0MP/D8NHNSqQA=;
        b=jTteWamHzsSJd51njOOW7BB+PBMUG2pFEEGeUM6U3nQ6MrfvKGuHwajolcG2V+c/KJ
         GJtZD6YbHGYCNVqisrDubBIBe5MjCGgcCW8O/jrEfwzhT6XwB+Pa4M8xDIa3zy4fssqV
         MREqd5ZLsUfoEiRnO2x4EV8oraEVaFTwukSmckazkYf5D/wHOv4CEjlPXMO7AMiD6+SY
         Kcp5o6WtjnGwfBlWjIsthccC6/3sfipqBVtD+qVEy3dupY8BuUcaP4bPcT4m9wJAbwEn
         yi1MzfRgssyxuuAIzU2+hVBNSY0THyGM7CAcmhFPG26bZ/O9yfdpBG4wnv7LJK7SaXhP
         gEwg==
X-Gm-Message-State: AOAM53288dGTBDOl5xtfmEEgR7GRJA8vMGC3QofY/xqt1ezQKf0fPam5
        MhqJUzSZ+Lfx6dKWU3lFYUUPqCQmDQ==
X-Google-Smtp-Source: ABdhPJw2duZKZHANH9M/H/FlahCExA+5z683QS7WBEwd4bOLuqI3t5lqneYmFDDGv4KnW0XshRNEvwlpQg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e995:ac0b:b57c:49a4])
 (user=elver job=sendgmr) by 2002:ad4:4991:: with SMTP id t17mr2036844qvx.33.1615372917507;
 Wed, 10 Mar 2021 02:41:57 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:41:34 +0100
In-Reply-To: <20210310104139.679618-1-elver@google.com>
Message-Id: <20210310104139.679618-4-elver@google.com>
Mime-Version: 1.0
References: <20210310104139.679618-1-elver@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH RFC v2 3/8] perf/core: Add support for event removal on exec
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds bit perf_event_attr::remove_on_exec, to support removing an event
from a task on exec.

This option supports the case where an event is supposed to be
process-wide only, and should not propagate beyond exec, to limit
monitoring to the original process image only.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Add patch to series.
---
 include/uapi/linux/perf_event.h |  3 ++-
 kernel/events/core.c            | 45 +++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 813efb65fea8..8c5b9f5ad63f 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -390,7 +390,8 @@ struct perf_event_attr {
 				text_poke      :  1, /* include text poke events */
 				build_id       :  1, /* use build id in mmap2 events */
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
-				__reserved_1   : 28;
+				remove_on_exec :  1, /* event is removed from task on exec */
+				__reserved_1   : 27;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a8382e6c907c..bc9e6e35e414 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4195,6 +4195,46 @@ static void perf_event_enable_on_exec(int ctxn)
 		put_ctx(clone_ctx);
 }
 
+static void perf_remove_from_owner(struct perf_event *event);
+static void perf_event_exit_event(struct perf_event *child_event,
+				  struct perf_event_context *child_ctx,
+				  struct task_struct *child);
+
+/*
+ * Removes all events from the current task that have been marked
+ * remove-on-exec, and feeds their values back to parent events.
+ */
+static void perf_event_remove_on_exec(void)
+{
+	int ctxn;
+
+	for_each_task_context_nr(ctxn) {
+		struct perf_event_context *ctx;
+		struct perf_event *event, *next;
+
+		ctx = perf_pin_task_context(current, ctxn);
+		if (!ctx)
+			continue;
+		mutex_lock(&ctx->mutex);
+
+		list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
+			if (!event->attr.remove_on_exec)
+				continue;
+
+			if (!is_kernel_event(event))
+				perf_remove_from_owner(event);
+			perf_remove_from_context(event, DETACH_GROUP);
+			/*
+			 * Remove the event and feed back its values to the
+			 * parent event.
+			 */
+			perf_event_exit_event(event, ctx, current);
+		}
+		mutex_unlock(&ctx->mutex);
+		put_ctx(ctx);
+	}
+}
+
 struct perf_read_data {
 	struct perf_event *event;
 	bool group;
@@ -7519,6 +7559,8 @@ void perf_event_exec(void)
 				   true);
 	}
 	rcu_read_unlock();
+
+	perf_event_remove_on_exec();
 }
 
 struct remote_output {
@@ -11600,6 +11642,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (!attr->inherit && attr->inherit_thread)
 		return -EINVAL;
 
+	if (attr->remove_on_exec && attr->enable_on_exec)
+		return -EINVAL;
+
 out:
 	return ret;
 
-- 
2.30.1.766.gb4fecdf3b7-goog

