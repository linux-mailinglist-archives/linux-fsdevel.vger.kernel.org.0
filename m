Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029B9333A61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 11:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhCJKm1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 05:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbhCJKmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:42:03 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DC3C061760
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 02:42:03 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id h20so12410620qkj.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 02:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MwMG/Kl+Surl9jPDmtCK7rCt1fJ8HAEyxyLN1urbLCM=;
        b=mybq0plUmvYmI72EWYXiOTM/z+pmWe/T7eOI5ncxtQXULTQ/eIjS4yMr79NE5RLEoU
         BDqnmznSj/VfvFVMtKJs+1SSQpY6JPOBG8JS/bqL3OIMjVNE7suld3CaDuKskjM3ApjZ
         X/jhXLzlo3vYCNwFPkuw+B1u+9AEXl6/D8GVFvcQFq9cnr4jHSERZVbrx0o8m3MSbrMv
         SAOpqnUmeubvpYOTtcHrw1ynnvMgBNxZZgPJ7zlnpWr22vnRA6qMfuK6pPsMqZS/7Irn
         497QpzekPMKfCwIG3l0DRSnRgxzQZRGF61/4ocpwSx3ZJU+Q0fepqNepcHpltjfNvb+b
         Ds7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MwMG/Kl+Surl9jPDmtCK7rCt1fJ8HAEyxyLN1urbLCM=;
        b=JeNv2h/KHl9UkPz9Dk41lcuv2del4pGX4UOqRGDoOlxlVp9LYGb1j3bJdtFrnbnMz6
         F2PTIQWn+iyZTgp+PeesTVK6OHrN/NFama1IJQ0Lb871CKo1+RMcAo0tDCrZyc1rFemJ
         W4VgwADQAnV1zzz0jCHAQ0IfRXDZ599DqzcWEXW/HF5PKA/N2SZJx0pYwRtm7eicd5j4
         YuGmCU7LaKfG03b/I4ftHti8LsO+Dg1Z/PiVnma3ACgBSbxOtKZPlnIjflITRd5mr1Lk
         9yKFTbSDqS23iMJmDyEyyxRVQQ8hreQ1bErzbNPA761wbZJuG5Rvv6+knfQhP2tg6c9M
         Wu6w==
X-Gm-Message-State: AOAM533INDKdFcGVsQG0KrRaaT9tAGQB9UAXJ04gtawWuhiXBqhPhRfC
        G9utij0o15MQ9GsT+CtorsEIqYH7yg==
X-Google-Smtp-Source: ABdhPJyh6J1KNJC8N7PIOcGv/D8kM2z9fZ1+ioUy4PGqKbYgUIWbpbWVJTzSZv3In2DrIJwc9zqYibtbPw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e995:ac0b:b57c:49a4])
 (user=elver job=sendgmr) by 2002:ad4:5a14:: with SMTP id ei20mr2068906qvb.1.1615372922271;
 Wed, 10 Mar 2021 02:42:02 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:41:36 +0100
In-Reply-To: <20210310104139.679618-1-elver@google.com>
Message-Id: <20210310104139.679618-6-elver@google.com>
Mime-Version: 1.0
References: <20210310104139.679618-1-elver@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH RFC v2 5/8] perf/core: Add support for SIGTRAP on perf events
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

Adds bit perf_event_attr::sigtrap, which can be set to cause events to
send SIGTRAP (with si_code TRAP_PERF) to the task where the event
occurred. To distinguish perf events and allow user space to decode
si_perf (if set), the event type is set in si_errno.

The primary motivation is to support synchronous signals on perf events
in the task where an event (such as breakpoints) triggered.

Link: https://lore.kernel.org/lkml/YBv3rAT566k+6zjg@hirez.programming.kicks-ass.net/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Use atomic_set(&event_count, 1), since it must always be 0 in
  perf_pending_event_disable().
* Implicitly restrict inheriting events if sigtrap, but the child was
  cloned with CLONE_CLEAR_SIGHAND, because it is not generally safe if
  the child cleared all signal handlers to continue sending SIGTRAP.
---
 include/uapi/linux/perf_event.h |  3 ++-
 kernel/events/core.c            | 28 +++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 8c5b9f5ad63f..3a4dbb1688f0 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -391,7 +391,8 @@ struct perf_event_attr {
 				build_id       :  1, /* use build id in mmap2 events */
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
-				__reserved_1   : 27;
+				sigtrap        :  1, /* send synchronous SIGTRAP on event */
+				__reserved_1   : 26;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bc9e6e35e414..e70c411b0b16 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6328,6 +6328,17 @@ void perf_event_wakeup(struct perf_event *event)
 	}
 }
 
+static void perf_sigtrap(struct perf_event *event)
+{
+	struct kernel_siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = SIGTRAP;
+	info.si_code = TRAP_PERF;
+	info.si_errno = event->attr.type;
+	force_sig_info(&info);
+}
+
 static void perf_pending_event_disable(struct perf_event *event)
 {
 	int cpu = READ_ONCE(event->pending_disable);
@@ -6337,6 +6348,13 @@ static void perf_pending_event_disable(struct perf_event *event)
 
 	if (cpu == smp_processor_id()) {
 		WRITE_ONCE(event->pending_disable, -1);
+
+		if (event->attr.sigtrap) {
+			atomic_set(&event->event_limit, 1); /* rearm event */
+			perf_sigtrap(event);
+			return;
+		}
+
 		perf_event_disable_local(event);
 		return;
 	}
@@ -11367,6 +11385,9 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 	event->state		= PERF_EVENT_STATE_INACTIVE;
 
+	if (event->attr.sigtrap)
+		atomic_set(&event->event_limit, 1);
+
 	if (task) {
 		event->attach_state = PERF_ATTACH_TASK;
 		/*
@@ -11645,6 +11666,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (attr->remove_on_exec && attr->enable_on_exec)
 		return -EINVAL;
 
+	if (attr->sigtrap && !attr->remove_on_exec)
+		return -EINVAL;
+
 out:
 	return ret;
 
@@ -12874,7 +12898,9 @@ inherit_task_group(struct perf_event *event, struct task_struct *parent,
 	struct perf_event_context *child_ctx;
 
 	if (!event->attr.inherit ||
-	    (event->attr.inherit_thread && !(clone_flags & CLONE_THREAD))) {
+	    (event->attr.inherit_thread && !(clone_flags & CLONE_THREAD)) ||
+	    /* Do not inherit if sigtrap and signal handlers were cleared. */
+	    (event->attr.sigtrap && (clone_flags & CLONE_CLEAR_SIGHAND))) {
 		*inherited_all = 0;
 		return 0;
 	}
-- 
2.30.1.766.gb4fecdf3b7-goog

