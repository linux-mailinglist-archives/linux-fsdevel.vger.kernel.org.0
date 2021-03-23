Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004053468C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 20:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhCWTRB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 15:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhCWTQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:16:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43B6C061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 12:16:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so1671768wma.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 12:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tNS+z+6QvyvEx8iMwg0Sa9sQJaEBMryjtauXMfUQXsg=;
        b=mI5F3aFOIe/mAhDiuSQnPZIA9HNNew1MolHTGbNOmJqKkXu6a0VIPwJUcmWee297OD
         wkr9SloIeaER3jqaqc3SzUZvkm15n28g9c360eLRWpOdIqQ/1Tvntr/b9UInFVQoniUc
         DQH4dtuFQPNKXNlHRLkf47W5VKv2eIr72mhasMsOFlsispiZu4nbcSuPBG3+ZLNvCqTG
         qlGsewcIFEqo0aTzKIws6wiO5iOpW39351Fe5ePVOot+X9/sOQpGTS4c/s9tyuGVvJJV
         OtstntnD/pgERiv6qawFok8+BMX2A8WGuydE8L1nHR6go76dj8HG8ypIZujMqAI7gZtB
         iD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tNS+z+6QvyvEx8iMwg0Sa9sQJaEBMryjtauXMfUQXsg=;
        b=IDEeeXhIrZCxYifLvSZ73IrwQzNduSYe5RKl5p9UAGbx+uWWTqRC3p4BJxy26uawfp
         MQ575wlUEJI+v7zy8IdDzOqxmmRo7CITBDSznN62O4dIYBd2vxW6MiZqJRRQdZ8gqnBm
         umQXx2INvDAHxhKD6O+T5rMkzz/6A/ceK5tLVuV4qJ3Lj6C3SeLXXPux+fFbkM8+topq
         jU44J6+4Y3agcDnzDJEkGe0IOOXJai42oQOogDM7+Bq7muBZQd0hyONWqJiFeSucZ3Z6
         sVJ+W4qZl0Vzg3WgwXxisr6OwL2TMb+q0c1EI/XIc77HNe6/6DxVxOToDYnf6Aga3KQ4
         I+UA==
X-Gm-Message-State: AOAM5331zHuTSAV6OySF6NFBexk5pvFfd75HKmu+kkve/Wn1CJFUh1Mf
        8oIkMM+bdAK4Qq0YAi/BKBsx9Q==
X-Google-Smtp-Source: ABdhPJwRTFeuUShdjMWV5kyhdyH3xDdCP6w717rvFqgvQ7AXSFmYXzmVNBLzrOGFbFSYf8XGBAE1/g==
X-Received: by 2002:a05:600c:3515:: with SMTP id h21mr4870837wmq.9.1616526996154;
        Tue, 23 Mar 2021 12:16:36 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:4cfd:1405:ab5d:85f8])
        by smtp.gmail.com with ESMTPSA id m10sm3547153wmh.13.2021.03.23.12.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 12:16:35 -0700 (PDT)
Date:   Tue, 23 Mar 2021 20:16:29 +0100
From:   Marco Elver <elver@google.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH RFC v2 8/8] selftests/perf: Add kselftest for
 remove_on_exec
Message-ID: <YFo+jdlJt9WpTVu4@elver.google.com>
References: <20210310104139.679618-1-elver@google.com>
 <20210310104139.679618-9-elver@google.com>
 <YFiamKX+xYH2HJ4E@elver.google.com>
 <CAP-5=fW8NnLFbnK8UwLuYFzkwk6Yjvxv=LdOpE8qgXbyL6=CCg@mail.gmail.com>
 <CANpmjNN6_jO5vK8fteJ7bEi1gM6Ho2kZxSq9avocM3A5TyFL=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNN6_jO5vK8fteJ7bEi1gM6Ho2kZxSq9avocM3A5TyFL=g@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 10:47AM +0100, Marco Elver wrote:
> On Tue, 23 Mar 2021 at 04:10, Ian Rogers <irogers@google.com> wrote:
> > On Mon, Mar 22, 2021 at 6:24 AM Marco Elver <elver@google.com> wrote:
> > > On Wed, Mar 10, 2021 at 11:41AM +0100, Marco Elver wrote:
> > > > Add kselftest to test that remove_on_exec removes inherited events from
> > > > child tasks.
> > > >
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > >
> > > To make compatible with more recent libc, we'll need to fixup the tests
> > > with the below.
> > >
> > > Also, I've seen that tools/perf/tests exists, however it seems to be
> > > primarily about perf-tool related tests. Is this correct?
> > >
> > > I'd propose to keep these purely kernel ABI related tests separate, and
> > > that way we can also make use of the kselftests framework which will
> > > also integrate into various CI systems such as kernelci.org.
> >
> > Perhaps there is a way to have both? Having the perf tool spot an
> > errant kernel feels like a feature. There are also
> > tools/lib/perf/tests and Vince Weaver's tests [1]. It is possible to
> > run standalone tests from within perf test by having them be executed
> > by a shell test.
> 
> Thanks for the pointers. Sure, I'd support more additional tests.
> 
> But I had another look and it seems the tests in
> tools/{perf,lib/perf}/tests do focus on perf-tool or the library
> respectively, so adding kernel ABI tests there feels wrong. (If
> perf-tool somehow finds use for sigtrap, or remove_on_exec, then
> having a perf-tool specific test for those would make sense again.)

Ok, I checked once more, and I did find a few pure kernel ABI tests e.g.
in "wp.c".

[...]
> Because I'd much prefer in-tree tests with little boilerplate, that
> are structured with parsable output; in the kernel we have the
> kselftest framework for tests with a user space component, and KUnit
> for pure in-kernel tests.

So let's try to have both... but from what I could tell, the
remove_on_exec test just can't be turned into a perf tool built-in test,
at least not easily. In perf tool I also can't use the new "si_perf"
field yet.

I'll add the patch below at the end of the series, so that we can have
both. Too many tests probably don't hurt...

Thanks,
-- Marco

------ >8 ------


commit 6a98611ace59c867aa135f780b1879990180548e
Author: Marco Elver <elver@google.com>
Date:   Tue Mar 23 19:51:12 2021 +0100

    perf test: Add basic stress test for sigtrap handling
    
    Ports the stress test from tools/testing/selftests/sigtrap_threads.c,
    and add as a perf tool built-in test. This allows checking the basic
    sigtrap functionality from within the perf tool.
    
    Signed-off-by: Marco Elver <elver@google.com>

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 650aec19d490..a429c7a02b37 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -64,6 +64,7 @@ perf-y += parse-metric.o
 perf-y += pe-file-parsing.o
 perf-y += expand-cgroup.o
 perf-y += perf-time-to-tsc.o
+perf-y += sigtrap.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c4b888f18e9c..28a1cb5eaa77 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -359,6 +359,11 @@ static struct test generic_tests[] = {
 		.func = test__perf_time_to_tsc,
 		.is_supported = test__tsc_is_supported,
 	},
+	{
+		.desc = "Sigtrap support",
+		.func = test__sigtrap,
+		.is_supported = test__wp_is_supported, /* uses wp for test */
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
new file mode 100644
index 000000000000..0888a4e02222
--- /dev/null
+++ b/tools/perf/tests/sigtrap.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Basic stress-test for sigtrap support.
+ *
+ * Copyright (C) 2021, Google LLC.
+ */
+
+#include <pthread.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/kernel.h>
+#include "tests.h"
+#include "debug.h"
+#include "event.h"
+#include "cloexec.h"
+#include "../perf-sys.h"
+
+#define NUM_THREADS 5
+
+/* Data shared between test body, threads, and signal handler. */
+static struct {
+	int tids_want_signal;		/* Which threads still want a signal. */
+	int signal_count;		/* Sanity check number of signals received. */
+	volatile int iterate_on;	/* Variable to set breakpoint on. */
+	siginfo_t first_siginfo;	/* First observed siginfo_t. */
+} ctx;
+
+static struct perf_event_attr make_event_attr(void)
+{
+	struct perf_event_attr attr = {
+		.type		= PERF_TYPE_BREAKPOINT,
+		.size		= sizeof(attr),
+		.sample_period	= 1,
+		.disabled	= 1,
+		.bp_addr	= (long)&ctx.iterate_on,
+		.bp_type	= HW_BREAKPOINT_RW,
+		.bp_len		= HW_BREAKPOINT_LEN_1,
+		.inherit	= 1, /* Children inherit events ... */
+		.inherit_thread = 1, /* ... but only cloned with CLONE_THREAD. */
+		.remove_on_exec = 1, /* Required by sigtrap. */
+		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
+	};
+	return attr;
+}
+
+static void
+sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
+{
+	if (!__atomic_fetch_add(&ctx.signal_count, 1, __ATOMIC_RELAXED))
+		ctx.first_siginfo = *info;
+	__atomic_fetch_sub(&ctx.tids_want_signal, syscall(SYS_gettid), __ATOMIC_RELAXED);
+}
+
+static void *test_thread(void *arg)
+{
+	pthread_barrier_t *barrier = (pthread_barrier_t *)arg;
+	pid_t tid = syscall(SYS_gettid);
+	int i;
+
+	pthread_barrier_wait(barrier);
+
+	__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
+	for (i = 0; i < ctx.iterate_on - 1; i++)
+		__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
+
+	return NULL;
+}
+
+static int run_test_threads(pthread_t *threads, pthread_barrier_t *barrier)
+{
+	int i;
+
+	pthread_barrier_wait(barrier);
+	for (i = 0; i < NUM_THREADS; i++)
+		TEST_ASSERT_EQUAL("pthread_join() failed", pthread_join(threads[i], NULL), 0);
+
+	return 0;
+}
+
+static int run_stress_test(int fd, pthread_t *threads, pthread_barrier_t *barrier)
+{
+	ctx.iterate_on = 3000;
+
+	TEST_ASSERT_EQUAL("misfired signal?", ctx.signal_count, 0);
+	TEST_ASSERT_EQUAL("enable failed", ioctl(fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	if (run_test_threads(threads, barrier))
+		return -1;
+	TEST_ASSERT_EQUAL("disable failed", ioctl(fd, PERF_EVENT_IOC_DISABLE, 0), 0);
+
+	TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count, NUM_THREADS * ctx.iterate_on);
+	TEST_ASSERT_EQUAL("missing signals or incorrectly delivered", ctx.tids_want_signal, 0);
+	TEST_ASSERT_VAL("unexpected si_addr", ctx.first_siginfo.si_addr == &ctx.iterate_on);
+	TEST_ASSERT_EQUAL("unexpected si_errno", ctx.first_siginfo.si_errno, PERF_TYPE_BREAKPOINT);
+#if 0 /* FIXME: test build and enable when libc's signal.h has si_perf. */
+	TEST_ASSERT_VAL("unexpected si_perf", ctx.first_siginfo.si_perf ==
+			((HW_BREAKPOINT_LEN_1 << 16) | HW_BREAKPOINT_RW));
+#endif
+
+	return 0;
+}
+
+int test__sigtrap(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct perf_event_attr attr = make_event_attr();
+	struct sigaction action = {};
+	struct sigaction oldact;
+	pthread_t threads[NUM_THREADS];
+	pthread_barrier_t barrier;
+	int i, fd, ret = 0;
+
+	pthread_barrier_init(&barrier, NULL, NUM_THREADS + 1);
+
+	action.sa_flags = SA_SIGINFO | SA_NODEFER;
+	action.sa_sigaction = sigtrap_handler;
+	sigemptyset(&action.sa_mask);
+	if (sigaction(SIGTRAP, &action, &oldact)) {
+		pr_debug("FAILED sigaction()\n");
+		ret = -1;
+		goto out_sigaction;
+	}
+
+
+	fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
+	if (fd < 0) {
+		pr_debug("FAILED sys_perf_event_open()\n");
+		ret = -1;
+		goto out_sigaction;
+	}
+
+	/* Spawn threads inheriting perf event. */
+	for (i = 0; i < NUM_THREADS; i++) {
+		if (pthread_create(&threads[i], NULL, test_thread, &barrier)) {
+			pr_debug("FAILED pthread_create()");
+			ret = -1;
+			goto out_perf_event;
+		}
+	}
+
+	ret |= run_stress_test(fd, threads, &barrier);
+
+out_perf_event:
+	close(fd);
+out_sigaction:
+	sigaction(SIGTRAP, &oldact, NULL);
+	pthread_barrier_destroy(&barrier);
+	return ret;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index b85f005308a3..c3f2e2ecbfd6 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -127,6 +127,7 @@ int test__parse_metric(struct test *test, int subtest);
 int test__pe_file_parsing(struct test *test, int subtest);
 int test__expand_cgroup_events(struct test *test, int subtest);
 int test__perf_time_to_tsc(struct test *test, int subtest);
+int test__sigtrap(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
