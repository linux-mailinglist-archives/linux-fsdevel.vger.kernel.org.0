Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865C3322C81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 15:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhBWOgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 09:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhBWOgV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:36:21 -0500
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D368BC06121C
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 06:34:53 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id r12so14645937ljc.17
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 06:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=M7IgukK9IFY6YerKyONO0wWjLsd7r1LevWvp+F7nZVo=;
        b=pvodb754jpNQprcBsG3I7muKaw7xW8mdWXHhqvdCBF+9SX6xY5KgLkbFo76yqevNdU
         +yb12QsncW2TTwVyTUPh6nnTYlzOCftmsKEavW7GHCtKH3vUcovHiz4eIrzn9yyz9X1J
         IPiVVFsG72pQjAuidovMBM4zzqXTfF2w7FZyuKmqTvsmYrPgVGO2QHe6f8C/iL4QidZm
         4nAVcfpfn9Br37gkIZTslmRqxbJKJvCAJ8BaKVv4Fpxm+XYG9VlYz9BrL71DcGsqWFb1
         wjPoK7V1dSFb9VXzpYsDRlSusnnuW9wzqcK8k0nqgtGxVfXkAEhps93dGXNTK8w+xZFV
         8KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M7IgukK9IFY6YerKyONO0wWjLsd7r1LevWvp+F7nZVo=;
        b=E2hhXgmsrU9nmQaZ65ZoaWxxpC576n5JS+8Wpuf1lMji9Plf65BQSYJIAQbfocXpUS
         91ptPOTVYT45M1kczHU+PjfqIZ+vbmJ7VDhfOVwHkOzJGfm7iQ33Gay1YMzD1m0GGxTo
         1guxCN9sxSBkjSwFAj3uVeVI/mG1TMknMegk26WLUsa1hUdZ0cgNG9give9cmFH0txmD
         TLQzTNc0eKMli9S5MH70lxVrvb+vFeUJCr80GiMhAK+E54/r11gkHd1I69xRrWjc+XCY
         IdJoMZklDR367XhmfQDrbZpdxJzqKz3y4eqyhWTvnTPIiU8MP+cCO/TLHT5WIXGgSOEW
         E/qQ==
X-Gm-Message-State: AOAM533EAhb7igxoJF93NfDWeev8X8S4Qxdo51MDO1bei69f6k9M6xjD
        GvhjpUmfPZVmXmuffYJbabyFDsEr1g==
X-Google-Smtp-Source: ABdhPJwrCOAFO0zyfGr4o5YxJU4bOcL92Ho8UegdKXZUGw4UKKf0Kkx8tRcBD/kGfXVlI8QkVOz/8Dttqg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:855b:f924:6e71:3d5d])
 (user=elver job=sendgmr) by 2002:ac2:5184:: with SMTP id u4mr11572002lfi.487.1614090892105;
 Tue, 23 Feb 2021 06:34:52 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:34:25 +0100
In-Reply-To: <20210223143426.2412737-1-elver@google.com>
Message-Id: <20210223143426.2412737-4-elver@google.com>
Mime-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH RFC 3/4] perf/core: Add support for SIGTRAP on perf events
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
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        x86@kernel.org
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
Signed-off-by: Marco Elver <elver@google.com>
---
 include/uapi/linux/perf_event.h |  3 ++-
 kernel/events/core.c            | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index ad15e40d7f5d..b9cc6829a40c 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -389,7 +389,8 @@ struct perf_event_attr {
 				cgroup         :  1, /* include cgroup events */
 				text_poke      :  1, /* include text poke events */
 				build_id       :  1, /* use build id in mmap2 events */
-				__reserved_1   : 29;
+				sigtrap        :  1, /* send synchronous SIGTRAP on event */
+				__reserved_1   : 28;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 37a8297be164..8718763045fd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6288,6 +6288,17 @@ void perf_event_wakeup(struct perf_event *event)
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
@@ -6297,6 +6308,13 @@ static void perf_pending_event_disable(struct perf_event *event)
 
 	if (cpu == smp_processor_id()) {
 		WRITE_ONCE(event->pending_disable, -1);
+
+		if (event->attr.sigtrap) {
+			atomic_inc(&event->event_limit); /* rearm event */
+			perf_sigtrap(event);
+			return;
+		}
+
 		perf_event_disable_local(event);
 		return;
 	}
@@ -11325,6 +11343,9 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 	event->state		= PERF_EVENT_STATE_INACTIVE;
 
+	if (event->attr.sigtrap)
+		atomic_set(&event->event_limit, 1);
+
 	if (task) {
 		event->attach_state = PERF_ATTACH_TASK;
 		/*
-- 
2.30.0.617.g56c4b15f3c-goog

