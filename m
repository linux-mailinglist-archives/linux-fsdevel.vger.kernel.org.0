Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C71C12FA5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgACQ3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 11:29:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36546 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgACQ3u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:29:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so23648614pgc.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2020 08:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f2KzEV6yvleUl4LG7o3Y4vJO/Ei5aF/Um2DDb/uCHxw=;
        b=PPC9+5rkZGFQ+fSsmeWiqO0HfA4TSizywzAeM20euoM1pSNBmhf6Hdu/SZNmNyT3az
         cMZzByNroe2vjaMHOSSmyEOiLsEkrIKsILdQwP/AnW8bZcg0TueC6rvfZQTFFg0CMh57
         JP661m7wYe0KTvMb3GHXVcfO/yUM6ifx38opE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2KzEV6yvleUl4LG7o3Y4vJO/Ei5aF/Um2DDb/uCHxw=;
        b=c4fRTf4OzWBP9evwMlScvJ99aidBtT4Kw25Cm43IjYdL4wwPdM+Z8I3FlaasVDjUxK
         JpBHq5DWfDfuEQjbxfvqrahngzpxkzNYNZtd7ldJMRLU7mGkI+fksJeMSZqoukRYDzQ+
         msFtAeLSpzaVACWJirKH7mSD28LUXMw/9k2SQ0+IWgHhygi7U7BMVuWkvwhTNt5xQxWk
         S9E9Z0HPp7pWmJP2GMFC/HA7/ekgrjumhCKy8Bjh1DWt9v/jtiWtgraEJ3soGUXmCCCP
         6QTXTE5H91xqlbFy3QV3ydVg7IBIsRQ9nplfVHtd8uw+fP0BZsjdQHLgTk87R0+ZQtBJ
         H5pQ==
X-Gm-Message-State: APjAAAWzIspC07AFDUmAmNtEEK6AyQFlDoeegE9vbaTyQGr3/xC1sGoP
        eJmHCxWxQOinbSEE8N7glAChrw==
X-Google-Smtp-Source: APXvYqw5b+Jfv6lUnRXz2SfQWJkxkpzBaIPQLAkIaR4eS3WLkHnDe7PwvMkdM9aac3NeA5sEU/1R/g==
X-Received: by 2002:a62:1857:: with SMTP id 84mr96224320pfy.257.1578068989857;
        Fri, 03 Jan 2020 08:29:49 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id m22sm67373970pgn.8.2020.01.03.08.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 08:29:49 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        jannh@google.com, cyphar@cyphar.com, christian.brauner@ubuntu.com,
        oleg@redhat.com, luto@amacapital.net, viro@zeniv.linux.org.uk,
        gpascutto@mozilla.com, ealvarez@mozilla.com, fweimer@redhat.com,
        jld@mozilla.com, arnd@arndb.de
Subject: [PATCH v8 3/3] test: Add test for pidfd getfd
Date:   Fri,  3 Jan 2020 08:29:28 -0800
Message-Id: <20200103162928.5271-4-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103162928.5271-1-sargun@sargun.me>
References: <20200103162928.5271-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following tests:
  * Fetch FD, and then compare via kcmp
  * Make sure getfd can be blocked by blocking ptrace_may_access
  * Making sure fetching bad FDs fails
  * Make sure trying to set flags to non-zero results in an EINVAL

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   4 +-
 .../selftests/pidfd/pidfd_getfd_test.c        | 227 ++++++++++++++++++
 3 files changed, 230 insertions(+), 2 deletions(-)
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
index 43db1b98e845..2071f7ab5dc9 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS += -g -I../../../../usr/include/ -pthread
+CFLAGS += -g -I../../../../usr/include/ -pthread -Wall
 
-TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test pidfd_poll_test pidfd_wait
+TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test pidfd_poll_test pidfd_wait pidfd_getfd_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
new file mode 100644
index 000000000000..26ca75597812
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <linux/kcmp.h>
+
+#include "pidfd.h"
+#include "../kselftest.h"
+#include "../kselftest_harness.h"
+
+/*
+ * UNKNOWN_FD is an fd number that should never exist in the child, as it is
+ * used to check the negative case.
+ */
+#define UNKNOWN_FD 111
+
+static int sys_kcmp(pid_t pid1, pid_t pid2, int type, unsigned long idx1,
+		    unsigned long idx2)
+{
+	return syscall(__NR_kcmp, pid1, pid2, type, idx1, idx2);
+}
+
+static int sys_pidfd_getfd(int pidfd, int fd, int flags)
+{
+	return syscall(__NR_pidfd_getfd, pidfd, fd, flags);
+}
+
+static int sys_memfd_create(const char *name, unsigned int flags)
+{
+	return syscall(__NR_memfd_create, name, flags);
+}
+
+static int __child(int sk, int memfd)
+{
+	int ret;
+	char buf;
+
+	/*
+	 * Ensure we don't leave around a bunch of orphaned children if our
+	 * tests fail.
+	 */
+	ret = prctl(PR_SET_PDEATHSIG, SIGKILL);
+	if (ret) {
+		fprintf(stderr, "%s: Child could not set DEATHSIG\n",
+			strerror(errno));
+		return EXIT_FAILURE;
+	}
+
+	ret = send(sk, &memfd, sizeof(memfd), 0);
+	if (ret != sizeof(memfd)) {
+		fprintf(stderr, "%s: Child failed to send fd number\n",
+			strerror(errno));
+		return EXIT_FAILURE;
+	}
+
+	while ((ret = recv(sk, &buf, sizeof(buf), 0)) > 0) {
+		if (buf == 'P') {
+			ret = prctl(PR_SET_DUMPABLE, 0);
+			if (ret < 0) {
+				fprintf(stderr,
+					"%s: Child failed to disable ptrace\n",
+					strerror(errno));
+				return EXIT_FAILURE;
+			}
+		} else {
+			fprintf(stderr, "Child received unknown command %c\n",
+				buf);
+			return EXIT_FAILURE;
+		}
+		ret = send(sk, &buf, sizeof(buf), 0);
+		if (ret != 1) {
+			fprintf(stderr, "%s: Child failed to ack\n",
+				strerror(errno));
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (ret < 0) {
+		fprintf(stderr, "%s: Child failed to read from socket\n",
+			strerror(errno));
+	}
+
+	return EXIT_SUCCESS;
+}
+
+static int child(int sk)
+{
+	int memfd, ret;
+
+	memfd = sys_memfd_create("test", 0);
+	if (memfd < 0) {
+		fprintf(stderr, "%s: Child could not create memfd\n",
+			strerror(errno));
+		ret = EXIT_FAILURE;
+	} else {
+		ret = __child(sk, memfd);
+		close(memfd);
+	}
+
+	close(sk);
+	return ret;
+}
+
+FIXTURE(child)
+{
+	pid_t pid;
+	int pidfd, sk, remote_fd;
+};
+
+FIXTURE_SETUP(child)
+{
+	int ret, sk_pair[2];
+
+	ASSERT_EQ(0, socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair))
+	{
+		TH_LOG("%s: failed to create socketpair", strerror(errno));
+	}
+	self->sk = sk_pair[0];
+
+	self->pid = fork();
+	ASSERT_GE(self->pid, 0);
+
+	if (self->pid == 0) {
+		close(sk_pair[0]);
+		exit(child(sk_pair[1]));
+	}
+
+	close(sk_pair[1]);
+
+	self->pidfd = sys_pidfd_open(self->pid, 0);
+	ASSERT_GE(self->pidfd, 0);
+
+	/*
+	 * Wait for the child to complete setup. It'll send the remote memfd's
+	 * number when ready.
+	 */
+	ret = recv(sk_pair[0], &self->remote_fd, sizeof(self->remote_fd), 0);
+	ASSERT_EQ(sizeof(self->remote_fd), ret);
+}
+
+FIXTURE_TEARDOWN(child)
+{
+	int status;
+
+	EXPECT_EQ(0, close(self->pidfd));
+	EXPECT_EQ(0, close(self->sk));
+
+	EXPECT_EQ(waitpid(self->pid, &status, 0), self->pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+TEST_F(child, disable_ptrace)
+{
+	int uid, fd;
+	char c;
+
+	/*
+	 * Turn into nobody if we're root, to avoid CAP_SYS_PTRACE
+	 *
+	 * The tests should run in their own process, so even this test fails,
+	 * it shouldn't result in subsequent tests failing.
+	 */
+	uid = getuid();
+	if (uid == 0)
+		ASSERT_EQ(0, seteuid(USHRT_MAX));
+
+	ASSERT_EQ(1, send(self->sk, "P", 1, 0));
+	ASSERT_EQ(1, recv(self->sk, &c, 1, 0));
+
+	fd = sys_pidfd_getfd(self->pidfd, self->remote_fd, 0);
+	EXPECT_EQ(-1, fd);
+	EXPECT_EQ(EPERM, errno);
+
+	if (uid == 0)
+		ASSERT_EQ(0, seteuid(0));
+}
+
+TEST_F(child, fetch_fd)
+{
+	int fd, ret;
+
+	fd = sys_pidfd_getfd(self->pidfd, self->remote_fd, 0);
+	ASSERT_GE(fd, 0);
+
+	EXPECT_EQ(0, sys_kcmp(getpid(), self->pid, KCMP_FILE, fd, self->remote_fd));
+
+	ret = fcntl(fd, F_GETFD);
+	ASSERT_GE(ret, 0);
+	EXPECT_GE(ret & FD_CLOEXEC, 0);
+
+	close(fd);
+}
+
+TEST_F(child, test_unknown_fd)
+{
+	int fd;
+
+	fd = sys_pidfd_getfd(self->pidfd, UNKNOWN_FD, 0);
+	EXPECT_EQ(-1, fd) {
+		TH_LOG("getfd succeeded while fetching unknown fd");
+	};
+	EXPECT_EQ(EBADF, errno) {
+		TH_LOG("%s: getfd did not get EBADF", strerror(errno));
+	}
+}
+
+TEST(flags_set)
+{
+	ASSERT_EQ(-1, sys_pidfd_getfd(0, 0, 1));
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_HARNESS_MAIN
-- 
2.20.1

