Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CE73580CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 12:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhDHKhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 06:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhDHKhH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:37:07 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94466C0613DD
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 03:36:56 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id o2so787139wrm.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 03:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WFLySSLyk1OHGUPgGWpvFgqBO4Z7Oek9XA/23wsFKPA=;
        b=ed4EtZeH+APnBbaShhnDpikA39d84+dcE7IgXMK84L7kEZSQBPgxTO2+LQh5y0qWLz
         82c7Fsh+3ZLwQjCKQEME1QA3Rf6/RT8xfrkYjHplUvyo3q0N9WgXSLmqMZzpLnhiqcda
         +jDiLb/12s1VV/qQlD68zutU5E6w94rhN3r3sguOptzw1MYQdorpvdmicHzbjXgtPQk3
         3Gh/UBqKmlqBW8Ar7DUfsaZpFpk1CPkgwBzBHEPqUrli3Xh0PwGq/pQT+qNL6Rw9/3D5
         snAy2QmgPXPX911JiFcSyUu5Aj+bAaehI4+5XKXStQHEQKGWUsTDAfM+ZgWlihrdJKqW
         2F6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WFLySSLyk1OHGUPgGWpvFgqBO4Z7Oek9XA/23wsFKPA=;
        b=hbdQ/97uNjbQZkEzwyE1cGYIB6Wu0eL7TezyXS2cNPvxCS1fXriNsQN4kH2cYZMBMO
         14f01cH8WE+zZZsM/CG1O79uDR/gFQimhPULoM3Epnl9PzKhtRoxOpToP9zT5aGfHbiZ
         IV6lBRsp3F8/LUW7izUZdD8qXCcwL5W2mkob+533XSGNnX3koY3EWJuhOkxyT0+tLLhm
         ZhVwZldoOAFHgEwCSO5YoR3gVjiRJymZI1j6PU8gHCj+ZQqqVEDMIiWS4xWxr+D/W6w/
         Dvaayz/myvUI8qYHx8wawPqYPUBeHf0lmWufdnfnMSP4U6RGJa0/+wk2yNgT6oqqyQYx
         GQ7A==
X-Gm-Message-State: AOAM532lSU4PoajLTU5ZMeFDGjI/UjKuEQkIMZeJ8U815hmSMMts4ihj
        GQCLMIBSwHelIZusERuBnyAOBsqxgQ==
X-Google-Smtp-Source: ABdhPJwgdy/C6JsQsf8QJNNTHr+6HoIEV2w2bK1y9na96OL+o35QLkndYFL6stI+IsWh+fpm40ERBtN4gg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:9038:bbd3:4a12:abda])
 (user=elver job=sendgmr) by 2002:a1c:9a02:: with SMTP id c2mr7815998wme.131.1617878215147;
 Thu, 08 Apr 2021 03:36:55 -0700 (PDT)
Date:   Thu,  8 Apr 2021 12:35:59 +0200
In-Reply-To: <20210408103605.1676875-1-elver@google.com>
Message-Id: <20210408103605.1676875-5-elver@google.com>
Mime-Version: 1.0
References: <20210408103605.1676875-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v4 04/10] perf: Add support for event removal on exec
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

Adds bit perf_event_attr::remove_on_exec, to support removing an event
from a task on exec.

This option supports the case where an event is supposed to be
process-wide only, and should not propagate beyond exec, to limit
monitoring to the original process image only.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Rework based on Peter's "perf: Rework perf_event_exit_event()" added
  to the beginning of the series. Intermediate attempts between v2 and
  this v3 can be found here:
	  https://lkml.kernel.org/r/YFm6aakSRlF2nWtu@elver.google.com

v2:
* Add patch to series.
---
 include/uapi/linux/perf_event.h |  3 +-
 kernel/events/core.c            | 70 +++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 9 deletions(-)

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
index de2917b3c59e..19c045ff2b9c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4247,6 +4247,57 @@ static void perf_event_enable_on_exec(int ctxn)
 		put_ctx(clone_ctx);
 }
 
+static void perf_remove_from_owner(struct perf_event *event);
+static void perf_event_exit_event(struct perf_event *event,
+				  struct perf_event_context *ctx);
+
+/*
+ * Removes all events from the current task that have been marked
+ * remove-on-exec, and feeds their values back to parent events.
+ */
+static void perf_event_remove_on_exec(int ctxn)
+{
+	struct perf_event_context *ctx, *clone_ctx = NULL;
+	struct perf_event *event, *next;
+	LIST_HEAD(free_list);
+	unsigned long flags;
+	bool modified = false;
+
+	ctx = perf_pin_task_context(current, ctxn);
+	if (!ctx)
+		return;
+
+	mutex_lock(&ctx->mutex);
+
+	if (WARN_ON_ONCE(ctx->task != current))
+		goto unlock;
+
+	list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
+		if (!event->attr.remove_on_exec)
+			continue;
+
+		if (!is_kernel_event(event))
+			perf_remove_from_owner(event);
+
+		modified = true;
+
+		perf_event_exit_event(event, ctx);
+	}
+
+	raw_spin_lock_irqsave(&ctx->lock, flags);
+	if (modified)
+		clone_ctx = unclone_ctx(ctx);
+	--ctx->pin_count;
+	raw_spin_unlock_irqrestore(&ctx->lock, flags);
+
+unlock:
+	mutex_unlock(&ctx->mutex);
+
+	put_ctx(ctx);
+	if (clone_ctx)
+		put_ctx(clone_ctx);
+}
+
 struct perf_read_data {
 	struct perf_event *event;
 	bool group;
@@ -7559,18 +7610,18 @@ void perf_event_exec(void)
 	struct perf_event_context *ctx;
 	int ctxn;
 
-	rcu_read_lock();
 	for_each_task_context_nr(ctxn) {
-		ctx = current->perf_event_ctxp[ctxn];
-		if (!ctx)
-			continue;
-
 		perf_event_enable_on_exec(ctxn);
+		perf_event_remove_on_exec(ctxn);
 
-		perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL,
-				   true);
+		rcu_read_lock();
+		ctx = rcu_dereference(current->perf_event_ctxp[ctxn]);
+		if (ctx) {
+			perf_iterate_ctx(ctx, perf_event_addr_filters_exec,
+					 NULL, true);
+		}
+		rcu_read_unlock();
 	}
-	rcu_read_unlock();
 }
 
 struct remote_output {
@@ -11652,6 +11703,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (!attr->inherit && attr->inherit_thread)
 		return -EINVAL;
 
+	if (attr->remove_on_exec && attr->enable_on_exec)
+		return -EINVAL;
+
 out:
 	return ret;
 
-- 
2.31.0.208.g409f899ff0-goog

