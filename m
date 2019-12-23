Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4EA129AFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 22:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfLWVJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 16:09:21 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35452 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfLWVJV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 16:09:21 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so15044698ild.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2019 13:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bPqgNMTJzQmzrywWwoE8PfxRJUCLVkppnZuFF1F78Ng=;
        b=H+aNYaDUPZ5Q9XgsW5I6/jy4ExFxrxB9LKiZIQDaeMJsVx0tR7TCm/svKWbOvZfFo4
         8XFO19CwyO5h8BHzAW2Kxc3PAP8pn/d+1lqUGV0Kmw797GWYBiRZfu5vaJ2OY0QYbPYX
         2qgbUYrRXSgSc5v9+u9/Uwt6cI1xAEOGfTaD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bPqgNMTJzQmzrywWwoE8PfxRJUCLVkppnZuFF1F78Ng=;
        b=jqwY8lA00qCFjMm/3PsAltjk7/3lKvMIlGjJ+cU8XnKDJSQa47B/zxGb7Sp2XvV/h+
         qpU69T+RCYAxVPqzIHl56taQdh8C0th5Wuyt0IgcOeEKFwymErq/bLOMwLtSRpirLONL
         JOkY5EuToD2jPM01xrit+oTP4pF4nyHkiHU0kIfgB/BE3IvO11NkjJB8knGG6kaZh4Cu
         9o/PRRyG0UrjsxBijmQtNz3bYepjQtwlF4Te6gItmco5W+n8JRWpS0m5HB6FHLdl9FJA
         3lmikcJF9tZbYcj2XgBZs2arzKwkK5YdHxTHP4AFChQSmWoyzq4Z3If9hZ2TPDGc3Vwr
         Mg6Q==
X-Gm-Message-State: APjAAAUfAs8VJDnwdD2QySrZA6kzEOXCuQDPwn9yz77p7HV6732OrGdg
        I7gz+B/Rgk61oKnBvWUySTtCig==
X-Google-Smtp-Source: APXvYqzj8K5Ah5gJvpePoAUtbePAnpylCZRLdEVBNsKWUdVJ99cgevNTiirCbE/hOE9wraofKqWH7A==
X-Received: by 2002:a92:9603:: with SMTP id g3mr27607060ilh.231.1577135360539;
        Mon, 23 Dec 2019 13:09:20 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id x10sm6467036ioh.11.2019.12.23.13.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 13:09:19 -0800 (PST)
Date:   Mon, 23 Dec 2019 21:09:18 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: [PATCH v6 3/3] test: Add test for pidfd getfd
Message-ID: <20191223210916.GA25119@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds four tests:
  * Fetch FD, and then compare via kcmp
  * Read data from FD to make sure it works
  * Make sure getfd can be blocked by blocking ptrace_may_access
  * Making sure fetching bad FDs fails
  * Make sure trying to set flags to non-zero results in an
    EINVAL

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   2 +-
 .../selftests/pidfd/pidfd_getfd_test.c        | 253 ++++++++++++++++++
 3 files changed, 255 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_getfd_test.c

diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
index 8d069490e17b..3a779c084d96 100644
--- a/tools/testing/selftests/pidfd/.gitignore
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -2,3 +2,4 @@ pidfd_open_test
 pidfd_poll_test
 pidfd_test
 pidfd_wait
+pidfd_getfd_test
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index 43db1b98e845..75a545861375 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -g -I../../../../usr/include/ -pthread
 
-TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test pidfd_poll_test pidfd_wait
+TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test pidfd_poll_test pidfd_wait pidfd_getfd_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
new file mode 100644
index 000000000000..376eace726c3
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <linux/kcmp.h>
+#include <linux/capability.h>
+
+#include "pidfd.h"
+#include "../kselftest.h"
+
+#define WELL_KNOWN_CHILD_FD	100
+#define UNKNOWN_FD		111
+#define SECRET_MESSAGE		"secret"
+
+static int kcmp(pid_t pid1, pid_t pid2, int type, unsigned long idx1,
+		unsigned long idx2)
+{
+	errno = 0;
+	return syscall(SYS_kcmp, pid1, pid2, type, idx1, idx2);
+}
+
+static int pidfd_getfd(int pidfd, int fd)
+{
+	errno = 0;
+	return syscall(__NR_pidfd_getfd, pidfd, fd, 0);
+}
+
+static int child(bool disable_ptrace, int sk)
+{
+	char buf[1024];
+	int ret, fd;
+
+	ret = prctl(PR_SET_PDEATHSIG, SIGKILL);
+	if (ret)
+		ksft_exit_fail_msg("%s: Child could not set DEATHSIG\n",
+				   strerror(errno));
+
+	fd = syscall(SYS_memfd_create, "test", 0);
+	if (fd < 0)
+		ksft_exit_fail_msg("%s: Child could not create memfd\n",
+				   strerror(errno));
+
+	ret = write(fd, SECRET_MESSAGE, sizeof(SECRET_MESSAGE));
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: Child could not write secret message\n",
+				   strerror(errno));
+
+	ret = dup2(fd, WELL_KNOWN_CHILD_FD);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: Could not dup fd into well-known FD\n",
+				   strerror(errno));
+
+	ret = close(fd);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: Child could close old fd\n",
+				   strerror(errno));
+
+	if (disable_ptrace) {
+		ret = prctl(PR_SET_DUMPABLE, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("%s: Child failed to disable ptrace\n",
+					   strerror(errno));
+	}
+	ret = send(sk, "L", 1, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: Child failed to send launched message\n",
+				   strerror(errno));
+	if (ret == 0)
+		ksft_exit_fail_msg("Failed to send launch message; other side is closed\n");
+
+	close(sk);
+	pause();
+
+	return EXIT_SUCCESS;
+}
+
+static int start_child(bool disable_ptrace, pid_t *childpid)
+{
+	int pidfd, ret, sk_pair[2];
+	char buf[1];
+
+	if (socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair) < 0)
+		ksft_exit_fail_msg("%s: failed to create socketpair\n",
+				   strerror(errno));
+	*childpid = fork();
+	if (*childpid < 0)
+		ksft_exit_fail_msg("%s: failed to fork a child process\n",
+				   strerror(errno));
+
+	if (*childpid == 0)
+		exit(child(disable_ptrace, sk_pair[1]));
+
+	close(sk_pair[1]);
+
+	pidfd = sys_pidfd_open(*childpid, 0);
+	if (pidfd < 0)
+		ksft_exit_fail_msg("%s: failed to pidfd_open\n",
+				   strerror(errno));
+
+	ret = recv(sk_pair[0], &buf, 1, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: failed read from launch socket\n",
+				   strerror(errno));
+	if (ret == 0)
+		ksft_exit_fail_msg("Failed to read from launch socket, child failed\n");
+
+	return pidfd;
+}
+
+static void test_kcmp_and_fetch_fd(void)
+{
+	char buf[sizeof(SECRET_MESSAGE)];
+	int fd, pidfd, ret;
+	pid_t child_pid;
+
+	pidfd = start_child(false, &child_pid);
+
+	fd = pidfd_getfd(pidfd, WELL_KNOWN_CHILD_FD);
+	if (fd < 0)
+		ksft_exit_fail_msg("%s: getfd failed\n", strerror(errno));
+
+	ret = kcmp(getpid(), child_pid, KCMP_FILE, fd, WELL_KNOWN_CHILD_FD);
+	if (ret != 0)
+		ksft_exit_fail_msg("Our FD not equal to child FD\n");
+
+	ksft_test_result_pass("kcmp\n");
+
+	ret = lseek(fd, 0, SEEK_SET);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: seek failed\n", strerror(errno));
+	if (ret != 0)
+		ksft_exit_fail_msg("%d: unexpected seek position\n", ret);
+
+	ret = read(fd, buf, sizeof(buf));
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: failed to read secret message\n",
+				   strerror(errno));
+
+	if (strncmp(SECRET_MESSAGE, buf, sizeof(buf)) != 0)
+		ksft_exit_fail_msg("%s: Secret message not correct\n", buf);
+
+	ret = sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
+	close(pidfd);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: failed to send kill to child\n",
+				   strerror(errno));
+
+	ksft_test_result_pass("fetch_and_read\n");
+}
+
+static void test_no_ptrace(void)
+{
+	int fd, pidfd, ret, uid;
+	pid_t child_pid;
+
+	/* turn into nobody if we're root, to avoid CAP_SYS_PTRACE */
+	uid = getuid();
+	if (uid == 0)
+		seteuid(USHRT_MAX);
+
+	pidfd = start_child(true, &child_pid);
+
+	fd = pidfd_getfd(pidfd, WELL_KNOWN_CHILD_FD);
+	if (fd != -1)
+		ksft_exit_fail_msg("%s: getfd succeeded when ptrace blocked\n",
+				   strerror(errno));
+	if (errno != EPERM)
+		ksft_exit_fail_msg("%s: getfd did not get EPERM\n",
+				   strerror(errno));
+
+	ret = sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
+	close(pidfd);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: failed to send kill to child\n",
+				   strerror(errno));
+
+	if (uid == 0)
+		seteuid(0);
+
+	ksft_test_result_pass("no_ptrace\n");
+}
+
+static void test_unknown_fd(void)
+{
+	int fd, pidfd, ret;
+	pid_t child_pid;
+
+	pidfd = start_child(false, &child_pid);
+
+	fd = pidfd_getfd(pidfd, UNKNOWN_FD);
+	if (fd != -1)
+		ksft_exit_fail_msg("%s: getfd succeeded when fetching unknown FD\n",
+				   strerror(errno));
+	if (errno != EBADF)
+		ksft_exit_fail_msg("%s: getfd did not get EBADF\n",
+				   strerror(errno));
+
+	ret = sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
+	close(pidfd);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: failed to send kill to child\n",
+				   strerror(errno));
+
+	ksft_test_result_pass("unknown_fd\n");
+}
+
+static void test_flags_set(void)
+{
+	int ret;
+
+	errno = 0;
+	ret = syscall(__NR_pidfd_getfd, 0, 1, 1);
+	if (ret != -1)
+		ksft_exit_fail_msg("getfd succeeded with invalid flags\n");
+	if (errno != EINVAL)
+		ksft_exit_fail_msg("%s: getfd did not get EINVAL\n",
+				   strerror(errno));
+
+	ksft_test_result_pass("flags_set\n");
+}
+
+int main(int argc, char **argv)
+{
+	char buf[sizeof(SECRET_MESSAGE)];
+	int ret, status, fd, pidfd;
+	pid_t child_pid;
+
+	ksft_print_header();
+	ksft_set_plan(5);
+
+	test_kcmp_and_fetch_fd();
+	test_unknown_fd();
+	test_no_ptrace();
+	test_flags_set();
+
+	return ksft_exit_pass();
+}
-- 
2.20.1

