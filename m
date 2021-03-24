Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A2F347744
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 12:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhCXL0T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 07:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbhCXLZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:25:42 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7124C0613E5
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 04:25:41 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id e9so361225wrg.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 04:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fK7o5DleNnJqQibEJC4DcBiUyuf/i/piGlRFLNZN3Fs=;
        b=GvCabDdvJ3u9mezTsB5Zd9Y4VkddCIPjhxpusr4NqfkRsXcPnkyfpEKnGluaZJ+u0K
         yjkhJYJy7o0BHXFGO3KdFm4tvicvAWXEvXW2IMFwumLXKWv9k7uZYedeaWyiXObRKj1W
         lkTLYttn1M4EGccT4D1gVIbRSMFrFrd4u3LO7NdvIctc+WwKcKa5s8cqDIhZqLoc3Pay
         l/vAs4Y5Q6Ln51y+TKTCFKKEGpUrcPd/6KMRKiSrbgw/kTUrHH11BhZT9ip7fIVPRZJD
         GKv5y4pzf4LU271EQyG97w4tlp15OOlsalJUJwwgOBwaml90LA4oq6FTdA2kMiCO8Jqi
         VEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fK7o5DleNnJqQibEJC4DcBiUyuf/i/piGlRFLNZN3Fs=;
        b=o6G/WnRTgfUY0kxt12yZ9vDSxwyzZmf061gQoh7vIdKwR7mJ7485IcxjLdXyqluVto
         SUEinq4gmtq65D5sAEs/ginVsq254hXHJwlq8LqAwzT2Xm0wMHJ7tmFTtIuNuWHeYDlD
         5Nh30o5RG2IE8Sci2yOZ8pZSugOAPLKRh/AZOl3jN8i8jU6KPUhRERCtTkFPMs57Kpqr
         UxBPT/PopUBMRcvx05VxqHtd/pN+vWdqXqkVX9Vum5owNFexuCCJ8dJRQxro0fobqCX9
         4TJNBLvjIgnQ8nhFVf9ywmtypZkdbD8p349VLsfm2PI8GJtfOWf3hqNkKyalxTR07vvd
         Aopw==
X-Gm-Message-State: AOAM530A841VGA7Eu6K7J3PpG43OKNFcWop2tC2Udno/tBTlzxrHcCXv
        GsvnOCyMWEsoViRatHKcx8/yTzi/rw==
X-Google-Smtp-Source: ABdhPJyCcjT7RlsnbmfMXmJ00w6aZpPsutzuk172tkabP+1HCGn8+jlvdy0KrzlyRbbS5EHFKsk6nmUv/w==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6489:b3f0:4af:af0])
 (user=elver job=sendgmr) by 2002:a7b:c24e:: with SMTP id b14mr2415183wmj.73.1616585140432;
 Wed, 24 Mar 2021 04:25:40 -0700 (PDT)
Date:   Wed, 24 Mar 2021 12:25:01 +0100
In-Reply-To: <20210324112503.623833-1-elver@google.com>
Message-Id: <20210324112503.623833-10-elver@google.com>
Mime-Version: 1.0
References: <20210324112503.623833-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 09/11] selftests/perf_events: Add kselftest for remove_on_exec
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

Add kselftest to test that remove_on_exec removes inherited events from
child tasks.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Fix for latest libc signal.h.

v2:
* Add patch to series.
---
 .../testing/selftests/perf_events/.gitignore  |   1 +
 tools/testing/selftests/perf_events/Makefile  |   2 +-
 .../selftests/perf_events/remove_on_exec.c    | 260 ++++++++++++++++++
 3 files changed, 262 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/perf_events/remove_on_exec.c

diff --git a/tools/testing/selftests/perf_events/.gitignore b/tools/testing/selftests/perf_events/.gitignore
index 4dc43e1bd79c..790c47001e77 100644
--- a/tools/testing/selftests/perf_events/.gitignore
+++ b/tools/testing/selftests/perf_events/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 sigtrap_threads
+remove_on_exec
diff --git a/tools/testing/selftests/perf_events/Makefile b/tools/testing/selftests/perf_events/Makefile
index 973a2c39ca83..fcafa5f0d34c 100644
--- a/tools/testing/selftests/perf_events/Makefile
+++ b/tools/testing/selftests/perf_events/Makefile
@@ -2,5 +2,5 @@
 CFLAGS += -Wl,-no-as-needed -Wall -I../../../../usr/include
 LDFLAGS += -lpthread
 
-TEST_GEN_PROGS := sigtrap_threads
+TEST_GEN_PROGS := sigtrap_threads remove_on_exec
 include ../lib.mk
diff --git a/tools/testing/selftests/perf_events/remove_on_exec.c b/tools/testing/selftests/perf_events/remove_on_exec.c
new file mode 100644
index 000000000000..5814611a1dc7
--- /dev/null
+++ b/tools/testing/selftests/perf_events/remove_on_exec.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test for remove_on_exec.
+ *
+ * Copyright (C) 2021, Google LLC.
+ */
+
+#define _GNU_SOURCE
+
+/* We need the latest siginfo from the kernel repo. */
+#include <sys/types.h>
+#include <asm/siginfo.h>
+#define __have_siginfo_t 1
+#define __have_sigval_t 1
+#define __have_sigevent_t 1
+#define __siginfo_t_defined
+#define __sigval_t_defined
+#define __sigevent_t_defined
+#define _BITS_SIGINFO_CONSTS_H 1
+#define _BITS_SIGEVENT_CONSTS_H 1
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <linux/perf_event.h>
+#include <pthread.h>
+#include <signal.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+static volatile int signal_count;
+
+static struct perf_event_attr make_event_attr(void)
+{
+	struct perf_event_attr attr = {
+		.type		= PERF_TYPE_HARDWARE,
+		.size		= sizeof(attr),
+		.config		= PERF_COUNT_HW_INSTRUCTIONS,
+		.sample_period	= 1000,
+		.exclude_kernel = 1,
+		.exclude_hv	= 1,
+		.disabled	= 1,
+		.inherit	= 1,
+		/*
+		 * Children normally retain their inherited event on exec; with
+		 * remove_on_exec, we'll remove their event, but the parent and
+		 * any other non-exec'd children will keep their events.
+		 */
+		.remove_on_exec = 1,
+		.sigtrap	= 1,
+	};
+	return attr;
+}
+
+static void sigtrap_handler(int signum, siginfo_t *info, void *ucontext)
+{
+	if (info->si_code != TRAP_PERF) {
+		fprintf(stderr, "%s: unexpected si_code %d\n", __func__, info->si_code);
+		return;
+	}
+
+	signal_count++;
+}
+
+FIXTURE(remove_on_exec)
+{
+	struct sigaction oldact;
+	int fd;
+};
+
+FIXTURE_SETUP(remove_on_exec)
+{
+	struct perf_event_attr attr = make_event_attr();
+	struct sigaction action = {};
+
+	signal_count = 0;
+
+	/* Initialize sigtrap handler. */
+	action.sa_flags = SA_SIGINFO | SA_NODEFER;
+	action.sa_sigaction = sigtrap_handler;
+	sigemptyset(&action.sa_mask);
+	ASSERT_EQ(sigaction(SIGTRAP, &action, &self->oldact), 0);
+
+	/* Initialize perf event. */
+	self->fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
+	ASSERT_NE(self->fd, -1);
+}
+
+FIXTURE_TEARDOWN(remove_on_exec)
+{
+	close(self->fd);
+	sigaction(SIGTRAP, &self->oldact, NULL);
+}
+
+/* Verify event propagates to fork'd child. */
+TEST_F(remove_on_exec, fork_only)
+{
+	int status;
+	pid_t pid = fork();
+
+	if (pid == 0) {
+		ASSERT_EQ(signal_count, 0);
+		ASSERT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+		while (!signal_count);
+		_exit(42);
+	}
+
+	while (!signal_count); /* Child enables event. */
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WEXITSTATUS(status), 42);
+}
+
+/*
+ * Verify that event does _not_ propagate to fork+exec'd child; event enabled
+ * after fork+exec.
+ */
+TEST_F(remove_on_exec, fork_exec_then_enable)
+{
+	pid_t pid_exec, pid_only_fork;
+	int pipefd[2];
+	int tmp;
+
+	/*
+	 * Non-exec child, to ensure exec does not affect inherited events of
+	 * other children.
+	 */
+	pid_only_fork = fork();
+	if (pid_only_fork == 0) {
+		/* Block until parent enables event. */
+		while (!signal_count);
+		_exit(42);
+	}
+
+	ASSERT_NE(pipe(pipefd), -1);
+	pid_exec = fork();
+	if (pid_exec == 0) {
+		ASSERT_NE(dup2(pipefd[1], STDOUT_FILENO), -1);
+		close(pipefd[0]);
+		execl("/proc/self/exe", "exec_child", NULL);
+		_exit((perror("exec failed"), 1));
+	}
+	close(pipefd[1]);
+
+	ASSERT_EQ(waitpid(pid_exec, &tmp, WNOHANG), 0); /* Child is running. */
+	/* Wait for exec'd child to start spinning. */
+	EXPECT_EQ(read(pipefd[0], &tmp, sizeof(int)), sizeof(int));
+	EXPECT_EQ(tmp, 42);
+	close(pipefd[0]);
+	/* Now we can enable the event, knowing the child is doing work. */
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	/* If the event propagated to the exec'd child, it will exit normally... */
+	usleep(100000); /* ... give time for event to trigger (in case of bug). */
+	EXPECT_EQ(waitpid(pid_exec, &tmp, WNOHANG), 0); /* Should still be running. */
+	EXPECT_EQ(kill(pid_exec, SIGKILL), 0);
+
+	/* Verify removal from child did not affect this task's event. */
+	tmp = signal_count;
+	while (signal_count == tmp); /* Should not hang! */
+	/* Nor should it have affected the first child. */
+	EXPECT_EQ(waitpid(pid_only_fork, &tmp, 0), pid_only_fork);
+	EXPECT_EQ(WEXITSTATUS(tmp), 42);
+}
+
+/*
+ * Verify that event does _not_ propagate to fork+exec'd child; event enabled
+ * before fork+exec.
+ */
+TEST_F(remove_on_exec, enable_then_fork_exec)
+{
+	pid_t pid_exec;
+	int tmp;
+
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+
+	pid_exec = fork();
+	if (pid_exec == 0) {
+		execl("/proc/self/exe", "exec_child", NULL);
+		_exit((perror("exec failed"), 1));
+	}
+
+	/*
+	 * The child may exit abnormally at any time if the event propagated and
+	 * a SIGTRAP is sent before the handler was set up.
+	 */
+	usleep(100000); /* ... give time for event to trigger (in case of bug). */
+	EXPECT_EQ(waitpid(pid_exec, &tmp, WNOHANG), 0); /* Should still be running. */
+	EXPECT_EQ(kill(pid_exec, SIGKILL), 0);
+
+	/* Verify removal from child did not affect this task's event. */
+	tmp = signal_count;
+	while (signal_count == tmp); /* Should not hang! */
+}
+
+TEST_F(remove_on_exec, exec_stress)
+{
+	pid_t pids[30];
+	int i, tmp;
+
+	for (i = 0; i < sizeof(pids) / sizeof(pids[0]); i++) {
+		pids[i] = fork();
+		if (pids[i] == 0) {
+			execl("/proc/self/exe", "exec_child", NULL);
+			_exit((perror("exec failed"), 1));
+		}
+
+		/* Some forked with event disabled, rest with enabled. */
+		if (i > 10)
+			EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	}
+
+	usleep(100000); /* ... give time for event to trigger (in case of bug). */
+
+	for (i = 0; i < sizeof(pids) / sizeof(pids[0]); i++) {
+		/* All children should still be running. */
+		EXPECT_EQ(waitpid(pids[i], &tmp, WNOHANG), 0);
+		EXPECT_EQ(kill(pids[i], SIGKILL), 0);
+	}
+
+	/* Verify event is still alive. */
+	tmp = signal_count;
+	while (signal_count == tmp);
+}
+
+/* For exec'd child. */
+static void exec_child(void)
+{
+	struct sigaction action = {};
+	const int val = 42;
+
+	/* Set up sigtrap handler in case we erroneously receive a trap. */
+	action.sa_flags = SA_SIGINFO | SA_NODEFER;
+	action.sa_sigaction = sigtrap_handler;
+	sigemptyset(&action.sa_mask);
+	if (sigaction(SIGTRAP, &action, NULL))
+		_exit((perror("sigaction failed"), 1));
+
+	/* Signal parent that we're starting to spin. */
+	if (write(STDOUT_FILENO, &val, sizeof(int)) == -1)
+		_exit((perror("write failed"), 1));
+
+	/* Should hang here until killed. */
+	while (!signal_count);
+}
+
+#define main test_main
+TEST_HARNESS_MAIN
+#undef main
+int main(int argc, char *argv[])
+{
+	if (!strcmp(argv[0], "exec_child")) {
+		exec_child();
+		return 1;
+	}
+
+	return test_main(argc, argv);
+}
-- 
2.31.0.291.g576ba9dcdaf-goog

