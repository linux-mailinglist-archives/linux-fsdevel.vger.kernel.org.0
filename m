Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2708347747
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 12:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhCXL0Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 07:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbhCXLZs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:25:48 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C02C0613DF
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 04:25:47 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id k16so769368ejg.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 04:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SXHD/uvUmQlMKu8n5JwtEEFXBwNpAPsrMpvny8SPQ1E=;
        b=vvCpa9HND78wqcF7JFp7r/2FIG3PfUY1b2aBiwcU/PUw5DgAtl0ApCtkZwymEMXk/3
         Fgu4tvpHw83d23HMAg9Yze+0affNBKwI4WjfG8Gocxma86yk8NN7/mUI1osLwZXEl89Q
         5vhkDgtzbtSOQZDoKqNzpuildjMay7AYwZjdv+Anol70e+aSrEvctY1VeAKnuDqR4DTJ
         rQhqwKlBIwplNv9R/mR7JTtGoOzj8p9RlDLKmoJcaMmYPTgm61rP4Ll9vCTCK4zCsIUy
         /ZoGoGZFfARImjVdqS6BWpfXvU68it7d6umbSXaE90K1d4+4KU8w8DVfGlT92xBDcdHZ
         JCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SXHD/uvUmQlMKu8n5JwtEEFXBwNpAPsrMpvny8SPQ1E=;
        b=g7ngGxXsEW/YAjI3/sLSQjRqp7sGuC0mUgJ9VbmmJKV/OBObomaiizLwQ9kqO7V5yt
         gOH/O0cXjo8AQvAmE/mfduuNFM54/Xinxl1M5/9WBuC0dUG1DWMOfoL3suUlZJhA5Zhr
         ZcuId7jvCa+aYuccNK/H8Oe9Z2+4VrAzaT/Mtb7PfCJU5MrliZLCtkJ5wv/FJZDWpsLW
         cwzM6iDbqd8Nz0E4okWTCNrbND8kZxDyFK6Ykm4qVKxxFKgBHP1sAnm1gjzkpXIaU+Jh
         ZwxlzAtF/5ElpbktAeqzVLEUL4/lmXo5NwF1t1R8OjiWMpTaDaacpUeXzpZASTO+etwS
         oqUA==
X-Gm-Message-State: AOAM5313181HWE7m3cw/pEi4LjKCnAASrnf8JBsXCLHF1DMQcYL24wfZ
        ieLwGVZlprDT15PwE5K7BDb5twqh3w==
X-Google-Smtp-Source: ABdhPJyZha8NDkWJdWXS93mUgqdBXoxsEhkLAwhgs2SpdkL5SBYnAeEXydgCyvOlLVAyR1sG9cBu9ttXHQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6489:b3f0:4af:af0])
 (user=elver job=sendgmr) by 2002:a17:906:ecb8:: with SMTP id
 qh24mr3238409ejb.162.1616585145705; Wed, 24 Mar 2021 04:25:45 -0700 (PDT)
Date:   Wed, 24 Mar 2021 12:25:03 +0100
In-Reply-To: <20210324112503.623833-1-elver@google.com>
Message-Id: <20210324112503.623833-12-elver@google.com>
Mime-Version: 1.0
References: <20210324112503.623833-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 11/11] perf test: Add basic stress test for sigtrap handling
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

Add basic stress test for sigtrap handling as a perf tool built-in test.
This allows sanity checking the basic sigtrap functionality from within
the perf tool.

Note: A more elaborate kselftest version of this test can also be found
in tools/testing/selftests/perf_events/sigtrap_threads.c.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Added to series (per suggestion from Ian Rogers).
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   5 ++
 tools/perf/tests/sigtrap.c      | 148 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 155 insertions(+)
 create mode 100644 tools/perf/tests/sigtrap.c

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
index 000000000000..b3f4006c22fd
--- /dev/null
+++ b/tools/perf/tests/sigtrap.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Basic test for sigtrap support.
+ *
+ * Copyright (C) 2021, Google LLC.
+ */
+
+#include <stdint.h>
+#include <stdlib.h>
+#include <linux/hw_breakpoint.h>
+#include <pthread.h>
+#include <signal.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "cloexec.h"
+#include "debug.h"
+#include "event.h"
+#include "tests.h"
+#include "../perf-sys.h"
+
+#define NUM_THREADS 5
+
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
+	return TEST_OK;
+}
+
+static int run_stress_test(int fd, pthread_t *threads, pthread_barrier_t *barrier)
+{
+	int ret;
+
+	ctx.iterate_on = 3000;
+
+	TEST_ASSERT_EQUAL("misfired signal?", ctx.signal_count, 0);
+	TEST_ASSERT_EQUAL("enable failed", ioctl(fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	ret = run_test_threads(threads, barrier);
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
+	return ret;
+}
+
+int test__sigtrap(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct perf_event_attr attr = make_event_attr();
+	struct sigaction action = {};
+	struct sigaction oldact;
+	pthread_t threads[NUM_THREADS];
+	pthread_barrier_t barrier;
+	int i, fd, ret = TEST_FAIL;
+
+	pthread_barrier_init(&barrier, NULL, NUM_THREADS + 1);
+
+	action.sa_flags = SA_SIGINFO | SA_NODEFER;
+	action.sa_sigaction = sigtrap_handler;
+	sigemptyset(&action.sa_mask);
+	if (sigaction(SIGTRAP, &action, &oldact)) {
+		pr_debug("FAILED sigaction()\n");
+		goto out;
+	}
+
+	fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
+	if (fd < 0) {
+		pr_debug("FAILED sys_perf_event_open()\n");
+		goto out_restore_sigaction;
+	}
+
+	for (i = 0; i < NUM_THREADS; i++) {
+		if (pthread_create(&threads[i], NULL, test_thread, &barrier)) {
+			pr_debug("FAILED pthread_create()");
+			goto out_close_perf_event;
+		}
+	}
+
+	ret = run_stress_test(fd, threads, &barrier);
+
+out_close_perf_event:
+	close(fd);
+out_restore_sigaction:
+	sigaction(SIGTRAP, &oldact, NULL);
+out:
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
-- 
2.31.0.291.g576ba9dcdaf-goog

