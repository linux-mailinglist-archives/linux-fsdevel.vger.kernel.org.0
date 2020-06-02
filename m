Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8221EC3E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 22:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgFBUmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 16:42:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51378 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgFBUmh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:42:37 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jgDk3-0001oi-9t; Tue, 02 Jun 2020 20:42:35 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, fweimer@redhat.com, jannh@google.com,
        oleg@redhat.com, arnd@arndb.de, shuah@kernel.org,
        dhowells@redhat.com, ldv@altlinux.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v5 3/3] tests: add close_range() tests
Date:   Tue,  2 Jun 2020 22:42:19 +0200
Message-Id: <20200602204219.186620-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602204219.186620-1-christian.brauner@ubuntu.com>
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds basic tests for the new close_range() syscall.
- test that no invalid flags can be passed
- test that a range of file descriptors is correctly closed
- test that a range of file descriptors is correctly closed if there there
  are already closed file descriptors in the range
- test that max_fd is correctly capped to the current fdtable maximum

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jann Horn <jannh@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Dmitry V. Levin <ldv@altlinux.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-api@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
/* v2 */
unchanged

/* v3 */
- Christian Brauner <christian@brauner.io>:
  - verify that close_range() correctly closes a single file descriptor

/* v4 */
- Christian Brauner <christian@brauner.io>:
  - add missing Cc for Shuah
  - add missing Cc for linux-kselftest

/* v5 */
- Michael Ellerman <mpe@ellerman.id.au>:
  - remove include of unexported kernel headers
- Christian Brauner <christian.brauner@ubuntu.com>:
  - add missing SPDX header to Makefile
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/core/.gitignore       |   1 +
 tools/testing/selftests/core/Makefile         |   7 +
 .../testing/selftests/core/close_range_test.c | 149 ++++++++++++++++++
 4 files changed, 158 insertions(+)
 create mode 100644 tools/testing/selftests/core/.gitignore
 create mode 100644 tools/testing/selftests/core/Makefile
 create mode 100644 tools/testing/selftests/core/close_range_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2ff68702fd41..2e387ce83311 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -6,6 +6,7 @@ TARGETS += breakpoints
 TARGETS += capabilities
 TARGETS += cgroup
 TARGETS += clone3
+TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += drivers/dma-buf
diff --git a/tools/testing/selftests/core/.gitignore b/tools/testing/selftests/core/.gitignore
new file mode 100644
index 000000000000..6e6712ce5817
--- /dev/null
+++ b/tools/testing/selftests/core/.gitignore
@@ -0,0 +1 @@
+close_range_test
diff --git a/tools/testing/selftests/core/Makefile b/tools/testing/selftests/core/Makefile
new file mode 100644
index 000000000000..f6f2d6f473c6
--- /dev/null
+++ b/tools/testing/selftests/core/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -g -I../../../../usr/include/
+
+TEST_GEN_PROGS := close_range_test
+
+include ../lib.mk
+
diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
new file mode 100644
index 000000000000..6d92e239a228
--- /dev/null
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/kernel.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+
+#ifndef __NR_close_range
+#define __NR_close_range -1
+#endif
+
+static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
+				  unsigned int flags)
+{
+	return syscall(__NR_close_range, fd, max_fd, flags);
+}
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
+int main(int argc, char **argv)
+{
+	const char *test_name = "close_range";
+	int i, ret;
+	int open_fds[101];
+	int fd_max, fd_mid, fd_min;
+
+	ksft_set_plan(9);
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		int fd;
+
+		fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+		if (fd < 0) {
+			if (errno == ENOENT)
+				ksft_exit_skip(
+					"%s test: skipping test since /dev/null does not exist\n",
+					test_name);
+
+			ksft_exit_fail_msg(
+				"%s test: %s - failed to open /dev/null\n",
+				strerror(errno), test_name);
+		}
+
+		open_fds[i] = fd;
+	}
+
+	fd_min = open_fds[0];
+	fd_max = open_fds[99];
+
+	ret = sys_close_range(fd_min, fd_max, 1);
+	if (!ret)
+		ksft_exit_fail_msg(
+			"%s test: managed to pass invalid flag value\n",
+			test_name);
+	if (errno == ENOSYS)
+		ksft_exit_skip("%s test: close_range() syscall not supported\n", test_name);
+
+	ksft_test_result_pass("do not allow invalid flag values for close_range()\n");
+
+	fd_mid = open_fds[50];
+	ret = sys_close_range(fd_min, fd_mid, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to close range of file descriptors from %d to %d\n",
+			test_name, fd_min, fd_mid);
+	ksft_test_result_pass("close_range() from %d to %d\n", fd_min, fd_mid);
+
+	for (i = 0; i <= 50; i++) {
+		ret = fcntl(open_fds[i], F_GETFL);
+		if (ret >= 0)
+			ksft_exit_fail_msg(
+				"%s test: Failed to close range of file descriptors from %d to %d\n",
+				test_name, fd_min, fd_mid);
+	}
+	ksft_test_result_pass("fcntl() verify closed range from %d to %d\n", fd_min, fd_mid);
+
+	/* create a couple of gaps */
+	close(57);
+	close(78);
+	close(81);
+	close(82);
+	close(84);
+	close(90);
+
+	fd_mid = open_fds[51];
+	/* Choose slightly lower limit and leave some fds for a later test */
+	fd_max = open_fds[92];
+	ret = sys_close_range(fd_mid, fd_max, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to close range of file descriptors from 51 to 100\n",
+			test_name);
+	ksft_test_result_pass("close_range() from %d to %d\n", fd_mid, fd_max);
+
+	for (i = 51; i <= 92; i++) {
+		ret = fcntl(open_fds[i], F_GETFL);
+		if (ret >= 0)
+			ksft_exit_fail_msg(
+				"%s test: Failed to close range of file descriptors from 51 to 100\n",
+				test_name);
+	}
+	ksft_test_result_pass("fcntl() verify closed range from %d to %d\n", fd_mid, fd_max);
+
+	fd_mid = open_fds[93];
+	fd_max = open_fds[99];
+	/* test that the kernel caps and still closes all fds */
+	ret = sys_close_range(fd_mid, UINT_MAX, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to close range of file descriptors from 51 to 100\n",
+			test_name);
+	ksft_test_result_pass("close_range() from %d to %d\n", fd_mid, fd_max);
+
+	for (i = 93; i < 100; i++) {
+		ret = fcntl(open_fds[i], F_GETFL);
+		if (ret >= 0)
+			ksft_exit_fail_msg(
+				"%s test: Failed to close range of file descriptors from 51 to 100\n",
+				test_name);
+	}
+	ksft_test_result_pass("fcntl() verify closed range from %d to %d\n", fd_mid, fd_max);
+
+	ret = sys_close_range(open_fds[100], open_fds[100], 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to close single file descriptor\n",
+			test_name);
+	ksft_test_result_pass("close_range() closed single file descriptor\n");
+
+	ret = fcntl(open_fds[100], F_GETFL);
+	if (ret >= 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to close single file descriptor\n",
+			test_name);
+	ksft_test_result_pass("fcntl() verify closed single file descriptor\n");
+
+	return ksft_exit_pass();
+}
-- 
2.26.2

