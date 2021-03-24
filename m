Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5A3347737
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 12:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhCXL0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 07:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbhCXLZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:25:35 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CFFC061763
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 04:25:34 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d11so971563qth.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 04:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZaFjuV65eN1OuecHxLplhRFaC9JE/oD9gdApL7zOyoc=;
        b=INRWAnDFjQHl9/RukpTLZhaogKEqtoMcGfqJGugCueBrm/zLoIyRAkGWVVk4EmJ938
         bYjNRccpCGaXkdzrT4HCmvG9xJ8gMDNVMhZbtCTTkdkWy3bQmjG7OYptEH2QQtJf2LvQ
         lmwoqoX9J27C4QxQOG7j3tr9dpZGgXD1mc+PjFiCYXT8KYRoDeJ30H/KpIlEhfDQcW48
         68rMPa+mJJSjbuUC87lgK5QN/Nct7cj+8u/cpQJwvKjPEyZf940CFTyvc1UdohmkimoT
         pNwSZhk6sqQdBDThE/g0y6+nljiO7CWZrjUEgl2ZO2RTTXoSoYOFnXC8tBR8m2kocphB
         brHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZaFjuV65eN1OuecHxLplhRFaC9JE/oD9gdApL7zOyoc=;
        b=irax7xiJz4EXnGL3StCgGYJswITU+CKT20G/LOhsBXHAqfEkSOpuzaxiskiE1opfz7
         tX5Qd1r5OrHyCLxQy+BmGi5P++kulFV1eShRMs2srhKf2taBBkEIyqUJM/6Ez/m6dup+
         4mSOeM34jt6bRG/YDYjPsOsT4VDc9zeNfUtWu+1AzNaYOnxaK23dpnK2aFPZLqhzz3Pw
         5Gzjlx/+L05EOiVJxb4XcdVnlIA7jwCaGFa220+PQGz0iIinsclXHxDRXEiCDuP3yzNh
         fXnGMdqbNqQBUPVE6RSVg5TnPByEhZUDPwEfkU0Lxx4QzUg3yx8BbHXibLHYep7UYX54
         yUcw==
X-Gm-Message-State: AOAM533Zr3rjC26gt26n+7jpVD9tD095fRepR5F9LCbph97LW1jfiXys
        sErFw69VJj3BCYKSk7P1anKcdMVr2A==
X-Google-Smtp-Source: ABdhPJxqIhdR7kOtPGmKVTdUpKMXrnpQ8vxCIUjm2EkZ42vzHH7tq5dwJZOM6zWcwf4Zy5KDbqG+3butoA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6489:b3f0:4af:af0])
 (user=elver job=sendgmr) by 2002:a0c:f7d1:: with SMTP id f17mr2286719qvo.38.1616585133964;
 Wed, 24 Mar 2021 04:25:33 -0700 (PDT)
Date:   Wed, 24 Mar 2021 12:24:58 +0100
In-Reply-To: <20210324112503.623833-1-elver@google.com>
Message-Id: <20210324112503.623833-7-elver@google.com>
Mime-Version: 1.0
References: <20210324112503.623833-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 06/11] perf: Add support for SIGTRAP on perf events
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
index b6434697c516..1e4c949bf75f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6391,6 +6391,17 @@ void perf_event_wakeup(struct perf_event *event)
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
@@ -6400,6 +6411,13 @@ static void perf_pending_event_disable(struct perf_event *event)
 
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
@@ -11428,6 +11446,9 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 	event->state		= PERF_EVENT_STATE_INACTIVE;
 
+	if (event->attr.sigtrap)
+		atomic_set(&event->event_limit, 1);
+
 	if (task) {
 		event->attach_state = PERF_ATTACH_TASK;
 		/*
@@ -11706,6 +11727,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (attr->remove_on_exec && attr->enable_on_exec)
 		return -EINVAL;
 
+	if (attr->sigtrap && !attr->remove_on_exec)
+		return -EINVAL;
+
 out:
 	return ret;
 
@@ -12932,7 +12956,9 @@ inherit_task_group(struct perf_event *event, struct task_struct *parent,
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
2.31.0.291.g576ba9dcdaf-goog

