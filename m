Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF812DE530
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 15:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgLROzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 09:55:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34478 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgLROzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:55:24 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kqH9V-0006v9-8S; Fri, 18 Dec 2020 14:54:41 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 4/4] selftests/core: add regression test for CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC
Date:   Fri, 18 Dec 2020 15:54:15 +0100
Message-Id: <20201218145415.801063-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <https://lore.kernel.org/linux-fsdevel/20201217213303.722643-1-christian.brauner@ubuntu.com>
References: <https://lore.kernel.org/linux-fsdevel/20201217213303.722643-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This test is a minimalized version of the reproducer given by syzbot
(cf. [1]).

After introducing CLOSE_RANGE_CLOEXEC syzbot reported a crash when
CLOSE_RANGE_CLOEXEC is specified in conjunction with
CLOSE_RANGE_UNSHARE.  When CLOSE_RANGE_UNSHARE is specified the caller
will receive a private file descriptor table in case their file
descriptor table is currently shared. When the caller requests that all
file descriptors are supposed to be operated on via e.g. a call like
close_range(3, ~0U) and the caller shares their file descriptor table
then the kernel will only copy all files in the range from 0 to 3 and no
others.
The original bug used the maximum of the old file descriptor table not
the new one. In order to test this bug we need to first create a huge
large gap in the fd table. When we now call CLOSE_RANGE_UNSHARE with a
shared fd table and and with ~0U as upper bound the kernel will only
copy up to fd1 file descriptors into the new fd table. If max_fd in the
close_range() codepaths isn't correctly set when requesting
CLOSE_RANGE_CLOEXEC with all of these fds we will see NULL pointer
derefs!

This test passes on a fixed kernel.

Cc: Giuseppe Scrivano <gscrivan@redhat.com>
[1]: https://syzkaller.appspot.com/text?tag=KernelConfig&x=db720fe37a6a41d8
Link: syzbot+96cfd2b22b3213646a93@syzkaller.appspotmail.com
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 tools/testing/selftests/core/Makefile         |   2 +-
 .../testing/selftests/core/close_range_test.c | 231 +++++++++++++++++-
 2 files changed, 230 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/core/Makefile b/tools/testing/selftests/core/Makefile
index f6f2d6f473c6..5ceb3ba1ca9c 100644
--- a/tools/testing/selftests/core/Makefile
+++ b/tools/testing/selftests/core/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS += -g -I../../../../usr/include/
+CFLAGS += -g -I../../../../usr/include/ -pthread
 
 TEST_GEN_PROGS := close_range_test
 
diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 862444f1c244..65f071d8fd16 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -3,15 +3,22 @@
 #define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
-#include <linux/kernel.h>
 #include <limits.h>
+#include <linux/futex.h>
+#include <pthread.h>
+#include <signal.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/prctl.h>
+#include <sys/resource.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 #include <syscall.h>
 #include <unistd.h>
-#include <sys/resource.h>
 
 #include "../kselftest_harness.h"
 #include "../clone3/clone3_selftests.h"
@@ -384,4 +391,224 @@ TEST(close_range_cloexec_unshare)
 	}
 }
 
+static uint64_t current_time_ms(void)
+{
+	struct timespec ts;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &ts))
+		exit(EXIT_FAILURE);
+
+	return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
+}
+
+static void thread_start(void *(*fn)(void *), void *arg)
+{
+	int i;
+	pthread_t th;
+	pthread_attr_t attr;
+
+	pthread_attr_init(&attr);
+	pthread_attr_setstacksize(&attr, 128 << 10);
+
+	for (i = 0; i < 100; i++) {
+		if (pthread_create(&th, &attr, fn, arg) == 0) {
+			pthread_attr_destroy(&attr);
+			return;
+		}
+
+		if (errno == EAGAIN) {
+			usleep(50);
+			continue;
+		}
+
+		break;
+	}
+
+	exit(EXIT_FAILURE);
+}
+
+static void event_init(int *state)
+{
+	*state = 0;
+}
+
+static void event_reset(int *state)
+{
+	*state = 0;
+}
+
+static void event_set(int *state)
+{
+	if (*state)
+		exit(EXIT_FAILURE);
+
+	__atomic_store_n(state, 1, __ATOMIC_RELEASE);
+	syscall(SYS_futex, state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
+}
+
+static void event_wait(int *state)
+{
+	while (!__atomic_load_n(state, __ATOMIC_ACQUIRE))
+		syscall(SYS_futex, state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
+}
+
+static int event_isset(int *state)
+{
+	return __atomic_load_n(state, __ATOMIC_ACQUIRE);
+}
+
+static int event_timedwait(int *state, uint64_t timeout)
+{
+	uint64_t start = current_time_ms();
+	uint64_t now = start;
+	for (;;) {
+		struct timespec ts;
+		uint64_t remain = timeout - (now - start);
+
+		ts.tv_sec = remain / 1000;
+		ts.tv_nsec = (remain % 1000) * 1000 * 1000;
+
+		syscall(SYS_futex, state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
+
+		if (__atomic_load_n(state, __ATOMIC_ACQUIRE))
+			return 1;
+
+		now = current_time_ms();
+		if (now - start > timeout)
+			return 0;
+	}
+}
+
+struct thread_t {
+	int created;
+	int call;
+	int ready;
+	int done;
+};
+
+static struct thread_t threads[4];
+static int running;
+
+static void thread_close_range_call(int call)
+{
+	int fd = 0;
+
+	switch (call) {
+	case 0:
+		fd = openat(-1, "/dev/null", 0, 0);
+		if (fd < 0)
+			fd = 0;
+		break;
+	case 1:
+		sys_close_range(fd, -1, CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC);
+		break;
+	}
+}
+
+static void *thread_close_range(void *arg)
+{
+	struct thread_t *th = (struct thread_t *)arg;
+	for (;;) {
+		event_wait(&th->ready);
+		event_reset(&th->ready);
+		thread_close_range_call(th->call);
+		__atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
+		event_set(&th->done);
+	}
+	return 0;
+}
+
+static void threaded_close_range(void)
+{
+	int i, fd, call, thread;
+	for (call = 0; call < 2; call++) {
+		for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0])); thread++) {
+			struct thread_t *th = &threads[thread];
+			if (!th->created) {
+				th->created = 1;
+				event_init(&th->ready);
+				event_init(&th->done);
+				event_set(&th->done);
+				thread_start(thread_close_range, th);
+			}
+
+			if (!event_isset(&th->done))
+				continue;
+
+			event_reset(&th->done);
+			th->call = call;
+			__atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
+			event_set(&th->ready);
+			event_timedwait(&th->done, 45);
+			break;
+		}
+	}
+
+	for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
+		usleep(1000);
+
+	for (fd = 3; fd < 30; fd++)
+		close(fd);
+}
+
+/*
+ * Regression test for syzbot+96cfd2b22b3213646a93@syzkaller.appspotmail.com
+ */
+TEST(close_range_cloexec_unshare_threaded_syzbot)
+{
+	int iter;
+	int fd1, fd2, fd3;
+
+	/*
+	 * Create a huge gap in the fd table. When we now call
+	 * CLOSE_RANGE_UNSHARE with a shared fd table and and with ~0U as upper
+	 * bound the kernel will only copy up to fd1 file descriptors into the
+	 * new fd table. If max_fd in the close_range() codepaths isn't
+	 * correctly set when requesting CLOSE_RANGE_CLOEXEC with all of these
+	 * fds we will see NULL pointer derefs!
+	 */
+	fd1 = open("/dev/null", O_RDWR);
+	EXPECT_GT(fd1, 0);
+
+	fd3 = dup2(fd1, 1000);
+	EXPECT_GT(fd3, 0);
+
+	for (iter = 0; iter <= 1000; iter++) {
+		pid_t pid;
+		int status;
+		uint64_t start;
+
+		pid = fork();
+		if (pid < 0)
+			exit(EXIT_FAILURE);
+		if (pid == 0) {
+			EXPECT_EQ(prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0), 0);
+			setpgrp();
+
+			threaded_close_range();
+			exit(EXIT_SUCCESS);
+		}
+
+		status = 0;
+		start = current_time_ms();
+		for (;;) {
+			if (waitpid(-1, &status, WNOHANG | __WALL) == pid)
+				break;
+
+			usleep(1000);
+
+			if (current_time_ms() - start < 5 * 1000)
+				continue;
+
+			kill(pid, SIGKILL);
+
+			EXPECT_EQ(waitpid(pid, &status, 0), pid);
+
+			EXPECT_EQ(true, WIFEXITED(status));
+
+			EXPECT_EQ(0, WEXITSTATUS(status));
+		}
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.29.2

