Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2186C3580EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 12:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhDHKiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 06:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhDHKhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:37:22 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD7FC0613E4
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 03:37:11 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id dv7so644854ejb.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 03:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BCBGbOGg89seqk0GJ8e7eMRxQa1aJCiARfAN/gtOasU=;
        b=Abilg05WGGBatoHpAGoYZVInSdef9vyAP/aPw2pF3+K6u42MIhLRm1sClMALqLyj6I
         kI5EnTuyjZ8LEADUh38lXlk4sxI+cp7UD9DueBr/OsvTinmd4+bccadauq8EMeeKIqAK
         f89MQh18O3shRje614FI5wkCbm+h/0mDdprFhqIcYRdaNrUNPDUTalQztZqNugjHwf5O
         V2OlsC6C+pK99dr65nYJnXHeLK7lej5LUlLxgO60R7QglxTPDi9SZR9N5tDgEp99PkQ3
         auQhwe2nl3OhR/pA40i2wjWK3OdPNtUg4GbCFBsXF0adEBCi/kZjpEQpSipTfv85BmiL
         y0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BCBGbOGg89seqk0GJ8e7eMRxQa1aJCiARfAN/gtOasU=;
        b=pkI+0F8HhB3CiUbSfpem5ncQw1dLbuA0BQV2/PaUCt+wn+iFVXWIMZKWWEcoH9G/Ma
         yBRaQFWjnhCvMaTv9k3H54leWNRu5I+e15QooM3NtqJqNKLPijiT478p1UzrMH7QoE1y
         PojgSgGv34d+vu9m3VsWyz5JI8DJonn8c4KvD5pYaSdGsS/sU+9TM+UzBPbkAJSXifCg
         gDz9FbHAyx2R1To+GYrmeUrp3CQGFhLNggn43U/CpGJHqAq7dRPWQJaV/AwgfluXe4/V
         FOq6rbeIrVamDKmytKg7FKH8+2Ac8QVekk5G3RWkmifwBqvr+s7knbDfzStLyYYKCQaz
         v7yQ==
X-Gm-Message-State: AOAM533gVEBK19frPumOxFL7egneiK5Iz1N7fyn4cysdR7copxkWMiZz
        wtk2qW1P790L3IiMyZanZ5akoL49Nw==
X-Google-Smtp-Source: ABdhPJwUyB3TxRpuM73O4rL06IetXxXvzAxviPSheqdhPNzkKUHZ7b08H4mQzxLXA3ZvtpFt3rt8pum25A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:9038:bbd3:4a12:abda])
 (user=elver job=sendgmr) by 2002:a17:906:ce4e:: with SMTP id
 se14mr9777476ejb.54.1617878229875; Thu, 08 Apr 2021 03:37:09 -0700 (PDT)
Date:   Thu,  8 Apr 2021 12:36:05 +0200
In-Reply-To: <20210408103605.1676875-1-elver@google.com>
Message-Id: <20210408103605.1676875-11-elver@google.com>
Mime-Version: 1.0
References: <20210408103605.1676875-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v4 10/10] perf test: Add basic stress test for sigtrap handling
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

Add basic stress test for sigtrap handling as a perf tool built-in test.
This allows sanity checking the basic sigtrap functionality from within
the perf tool.

Note: A more elaborate kselftest version of this test can also be found
in tools/testing/selftests/perf_events/sigtrap_threads.c.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Update for new perf_event_attr::sig_data / si_perf handling.

v3:
* Added to series (per suggestion from Ian Rogers).
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   5 ++
 tools/perf/tests/sigtrap.c      | 150 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 157 insertions(+)
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
index 000000000000..c367cc2f64d5
--- /dev/null
+++ b/tools/perf/tests/sigtrap.c
@@ -0,0 +1,150 @@
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
+#define TEST_SIG_DATA (~(uint64_t)(&ctx.iterate_on))
+
+static struct perf_event_attr make_event_attr(void)
+{
+	struct perf_event_attr attr = {
+		.type		= PERF_TYPE_BREAKPOINT,
+		.size		= sizeof(attr),
+		.sample_period	= 1,
+		.disabled	= 1,
+		.bp_addr	= (unsigned long)&ctx.iterate_on,
+		.bp_type	= HW_BREAKPOINT_RW,
+		.bp_len		= HW_BREAKPOINT_LEN_1,
+		.inherit	= 1, /* Children inherit events ... */
+		.inherit_thread = 1, /* ... but only cloned with CLONE_THREAD. */
+		.remove_on_exec = 1, /* Required by sigtrap. */
+		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
+		.sig_data	= TEST_SIG_DATA,
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
+	TEST_ASSERT_VAL("unexpected si_perf", ctx.first_siginfo.si_perf == TEST_SIG_DATA);
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
2.31.0.208.g409f899ff0-goog

