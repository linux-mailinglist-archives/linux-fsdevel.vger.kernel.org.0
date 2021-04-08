Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D782B3580D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 12:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhDHKhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 06:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhDHKhL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:37:11 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16EAC061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 03:37:00 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id p2so817049qvi.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p4IAv4qy7NYDvKdM7TwKfxu2qzw/9tstIJL5I3FPPz8=;
        b=UNw+Kg5tlp1Z71kQThctHs7JKPi5+JOPQREHKp1OSNV3GT8x6Vs7kzEBJa4lasA3bM
         dYg+lNwByFIgqnANE7d3G2pnnRFgO9KwYA8xgyBfRIppQB1/HoLdlEl517QkWDAJrAak
         RP7dAmEEKMzMofu/g6fVGVKNDfZViJXFNpFaIc4J3eeS8FlpPbaU0oHNDtBvSnBRUUzf
         gpZfnepPW9Zwnzgt9u9ln6YjjjT7q1cij6cdi5CJkRPjdbe517RZAfWbPIsCAqkUK/Bc
         tj3EmSBOOIZ3ZHDFaM4+DQjq2IFXj9Vh0v42JKUkv4y+kpYrLJ+pph3VQVHIQt7fQ4Ag
         gUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p4IAv4qy7NYDvKdM7TwKfxu2qzw/9tstIJL5I3FPPz8=;
        b=RmN4RkEXlVKiTp/2Bc4qTLzwwy93X/tqBvh06qNknNuJMuZyuuAAMho70218hig6ju
         GeVIIexCJP/HFrlS8OwTH1Lgvncpa0nlDU7HdTZPvZUQRf2aSOE7HmbinKn38VDMskZZ
         TiS0smY2oQjECAU6Cr9+fHitaaT59v2NUvVEVI1yk2s0saKUIYjYRKCR0zi52m/oExD6
         z4H0INyyflmqQwjMvWr7Hzmcw2m1+95kq4RfzT3rxT1yKuM6ZDpYUMnnLBoHmb4tMwY6
         OuTaaSi7Me6tJW0Xo0PeC9l6Tc7euuUPIvLzRdwozUrb4XrCnk5pkbHaAWrs7NNMZ2dC
         JDQw==
X-Gm-Message-State: AOAM533ylg3+c+5O7Pswdr3cL+nqNYvlqb5z8X0kCF1iRJ0c6d6x4Cwo
        oRD9jknVWgFRmJdYWDbs44cBr8uxfA==
X-Google-Smtp-Source: ABdhPJxo4lVhY7HBrmBRWOR61huP4vBkFPpBdnCDDeabYcuy3gE05+tzLwuo/4mobNDta+IAAeUG4q+pfA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:9038:bbd3:4a12:abda])
 (user=elver job=sendgmr) by 2002:a0c:908d:: with SMTP id p13mr8445880qvp.11.1617878219837;
 Thu, 08 Apr 2021 03:36:59 -0700 (PDT)
Date:   Thu,  8 Apr 2021 12:36:01 +0200
In-Reply-To: <20210408103605.1676875-1-elver@google.com>
Message-Id: <20210408103605.1676875-7-elver@google.com>
Mime-Version: 1.0
References: <20210408103605.1676875-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v4 06/10] perf: Add support for SIGTRAP on perf events
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

Adds bit perf_event_attr::sigtrap, which can be set to cause events to
send SIGTRAP (with si_code TRAP_PERF) to the task where the event
occurred. The primary motivation is to support synchronous signals on
perf events in the task where an event (such as breakpoints) triggered.

To distinguish perf events based on the event type, the type is set in
si_errno. For events that are associated with an address, si_addr is
copied from perf_sample_data.

The new field perf_event_attr::sig_data is copied to si_perf, which
allows user space to disambiguate which event (of the same type)
triggered the signal. For example, user space could encode the relevant
information it cares about in sig_data.

We note that the choice of an opaque u64 provides the simplest and most
flexible option. Alternatives where a reference to some user space data
is passed back suffer from the problem that modification of referenced
data (be it the event fd, or the perf_event_attr) can race with the
signal being delivered (of course, the same caveat applies if user space
decides to store a pointer in sig_data, but the ABI explicitly avoids
prescribing such a design).

Link: https://lore.kernel.org/lkml/YBv3rAT566k+6zjg@hirez.programming.kicks-ass.net/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Generalize setting si_perf and si_addr independent of event type;
  introduces perf_event_attr::sig_data, which can be set by user space to
  be propagated to si_perf.
* Fix race between irq_work running and task's sighand being released by
  release_task().
* Warning in perf_sigtrap() if ctx->task and current mismatch; we expect
  this on architectures that do not properly implement
  arch_irq_work_raise().
* Require events that want sigtrap to be associated with a task.

v2:
* Use atomic_set(&event_count, 1), since it must always be 0 in
  perf_pending_event_disable().
* Implicitly restrict inheriting events if sigtrap, but the child was
  cloned with CLONE_CLEAR_SIGHAND, because it is not generally safe if
  the child cleared all signal handlers to continue sending SIGTRAP.
---
 include/linux/perf_event.h      |  3 ++
 include/uapi/linux/perf_event.h | 10 ++++++-
 kernel/events/core.c            | 49 ++++++++++++++++++++++++++++++++-
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1660039199b2..18ba1282c5c7 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -778,6 +778,9 @@ struct perf_event {
 	void *security;
 #endif
 	struct list_head		sb_list;
+
+	/* Address associated with event, which can be passed to siginfo_t. */
+	u64				sig_addr;
 #endif /* CONFIG_PERF_EVENTS */
 };
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 8c5b9f5ad63f..31b00e3b69c9 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -311,6 +311,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER4	104	/* add: sample_regs_intr */
 #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
+#define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -391,7 +392,8 @@ struct perf_event_attr {
 				build_id       :  1, /* use build id in mmap2 events */
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
-				__reserved_1   : 27;
+				sigtrap        :  1, /* send synchronous SIGTRAP on event */
+				__reserved_1   : 26;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -443,6 +445,12 @@ struct perf_event_attr {
 	__u16	__reserved_2;
 	__u32	aux_sample_size;
 	__u32	__reserved_3;
+
+	/*
+	 * User provided data if sigtrap=1, passed back to user via
+	 * siginfo_t::si_perf, e.g. to permit user to identify the event.
+	 */
+	__u64	sig_data;
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 19c045ff2b9c..1d2077389c0c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6391,6 +6391,33 @@ void perf_event_wakeup(struct perf_event *event)
 	}
 }
 
+static void perf_sigtrap(struct perf_event *event)
+{
+	struct kernel_siginfo info;
+
+	/*
+	 * We'd expect this to only occur if the irq_work is delayed and either
+	 * ctx->task or current has changed in the meantime. This can be the
+	 * case on architectures that do not implement arch_irq_work_raise().
+	 */
+	if (WARN_ON_ONCE(event->ctx->task != current))
+		return;
+
+	/*
+	 * perf_pending_event() can race with the task exiting.
+	 */
+	if (current->flags & PF_EXITING)
+		return;
+
+	clear_siginfo(&info);
+	info.si_signo = SIGTRAP;
+	info.si_code = TRAP_PERF;
+	info.si_errno = event->attr.type;
+	info.si_perf = event->attr.sig_data;
+	info.si_addr = (void *)event->sig_addr;
+	force_sig_info(&info);
+}
+
 static void perf_pending_event_disable(struct perf_event *event)
 {
 	int cpu = READ_ONCE(event->pending_disable);
@@ -6400,6 +6427,13 @@ static void perf_pending_event_disable(struct perf_event *event)
 
 	if (cpu == smp_processor_id()) {
 		WRITE_ONCE(event->pending_disable, -1);
+
+		if (event->attr.sigtrap) {
+			perf_sigtrap(event);
+			atomic_set_release(&event->event_limit, 1); /* rearm event */
+			return;
+		}
+
 		perf_event_disable_local(event);
 		return;
 	}
@@ -9102,6 +9136,7 @@ static int __perf_event_overflow(struct perf_event *event,
 	if (events && atomic_dec_and_test(&event->event_limit)) {
 		ret = 1;
 		event->pending_kill = POLL_HUP;
+		event->sig_addr = data->addr;
 
 		perf_event_disable_inatomic(event);
 	}
@@ -11382,6 +11417,10 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		if (!task || cpu != -1)
 			return ERR_PTR(-EINVAL);
 	}
+	if (attr->sigtrap && !task) {
+		/* Requires a task: avoid signalling random tasks. */
+		return ERR_PTR(-EINVAL);
+	}
 
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
 	if (!event)
@@ -11428,6 +11467,9 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 	event->state		= PERF_EVENT_STATE_INACTIVE;
 
+	if (event->attr.sigtrap)
+		atomic_set(&event->event_limit, 1);
+
 	if (task) {
 		event->attach_state = PERF_ATTACH_TASK;
 		/*
@@ -11706,6 +11748,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (attr->remove_on_exec && attr->enable_on_exec)
 		return -EINVAL;
 
+	if (attr->sigtrap && !attr->remove_on_exec)
+		return -EINVAL;
+
 out:
 	return ret;
 
@@ -12932,7 +12977,9 @@ inherit_task_group(struct perf_event *event, struct task_struct *parent,
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
2.31.0.208.g409f899ff0-goog

