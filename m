Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30BBA12581A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 00:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLRXzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 18:55:53 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45491 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLRXzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:55:52 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so3848413ioi.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 15:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iTAiv8quXKS4hPnW6sSgwcFpK7vvhhF/AJU45qhXQyk=;
        b=kA5mq4Jzu7LvrOWSfHqMNLnfMmBatbn6jDLXcpyUOA1zmQO+F4Usx9rEKXucy0d66c
         Mcgw7Y4l9dj3C1WmfEdP3Q/lzu49oA1+RZpSDHui3ZYgXRsPx2HwbsVmneeiye2i5Ncu
         dQdsqU+yTn2zOdCdvgZcQjRxAURgYoY2pIMmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iTAiv8quXKS4hPnW6sSgwcFpK7vvhhF/AJU45qhXQyk=;
        b=FC2LqktR3hQLzFPxBVTiK4iWFlg/coKshO1oWAa0QqAyH6jmcPNf7KrVqQKtZtm9sW
         wPjq3rebIZgFUH1DK+Rb3XDR7Tnv6wYJwaThGOflQtCo/rGIxtXgXghvLyUkRDHMa6Zb
         YDABupDzzXVSKzoqhP2ZUrkfJiKJI9gjVllvLjqAiML7glR1hvhEvPIy1s4i+I/qjq9e
         dqKtfFj+fQwDxv3iVblzNdMBH2w9PtDS1lYHD9k4h8gviSj7rS6IkN7nnPCi8vxnBhft
         cRhaeVUBm1GMHUIva4tyJcRoXlpml2R7je9y4KXjFATWG4nv3h/a5a9fwSnf5NMy64n2
         Se7A==
X-Gm-Message-State: APjAAAVs/HgS8TXNI2wHMEhDEjoxg8jYL/ugkE962wC++4eFegV6qZkt
        0JXSJuaZIJ+3011smqQo4Wub8A==
X-Google-Smtp-Source: APXvYqyWtVRd9TMXfXith93Pu6yTQeuPGhen310X+v5/AsuM6xA9q7qEGEHa7wFriy7cQ+YnqDaZ2g==
X-Received: by 2002:a5e:d602:: with SMTP id w2mr3598937iom.94.1576713351956;
        Wed, 18 Dec 2019 15:55:51 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id g79sm1162957ilf.10.2019.12.18.15.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 15:55:51 -0800 (PST)
Date:   Wed, 18 Dec 2019 23:55:50 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: [PATCH v4 5/5] test: Add test for pidfd getfd
Message-ID: <20191218235547.GA17298@ircssh-2.c.rugged-nimbus-611.internal>
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

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   2 +-
 .../selftests/pidfd/pidfd_getfd_test.c        | 231 ++++++++++++++++++
 3 files changed, 233 insertions(+), 1 deletion(-)
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
index 000000000000..25c11a030afc
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -0,0 +1,231 @@
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
+#include <linux/pidfd.h>
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
+	return syscall(SYS_kcmp, pid1, pid2, type, idx1, idx2);
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
+	fd = ioctl(pidfd, PIDFD_IOCTL_GETFD, WELL_KNOWN_CHILD_FD);
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
+	fd = ioctl(pidfd, PIDFD_IOCTL_GETFD, WELL_KNOWN_CHILD_FD);
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
+	fd = ioctl(pidfd, PIDFD_IOCTL_GETFD, UNKNOWN_FD);
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
+int main(int argc, char **argv)
+{
+	char buf[sizeof(SECRET_MESSAGE)];
+	int ret, status, fd, pidfd;
+	pid_t child_pid;
+
+	ksft_print_header();
+	ksft_set_plan(4);
+
+	test_kcmp_and_fetch_fd();
+	test_unknown_fd();
+	test_no_ptrace();
+
+	return ksft_exit_pass();
+}
-- 
2.20.1

