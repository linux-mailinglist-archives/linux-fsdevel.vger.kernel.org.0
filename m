Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF18132DD4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 19:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgAGR7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:59:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41458 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbgAGR7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:59:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id bd4so18250plb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 09:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6LG36Q0SWhG/CvbxDWW6ihwZbk0PyIKiASNL1qN4jbs=;
        b=i/0Zn/GUy4XYg4TU3s98lgrvvX6bNyDP9vudbmIx+8iTgz4X+6uXf7MtEXR+mC7YHl
         cFsxyRTyx7yzQPcgo47n0f4D5VENY/tCRYikuP5yv4gWS0q3zepcZvUUg2CEqzbETsrN
         xLppc/bO4KoFDvdBrMjsixXGJLmBcn1wSVAxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6LG36Q0SWhG/CvbxDWW6ihwZbk0PyIKiASNL1qN4jbs=;
        b=PWNc8BUpRNa57TCBWX33IufGDU0OBv7x8dnhoSFXmhJnm59SBXj6tE7MsEewJ3nZuR
         f0CSC9m2ltWq9tZrdnPumFv+JlG0nI6bdCLQyT1kOADL7h0nlN2zBT6CXg+Lnkh7+S3W
         CpZV1Po9MeuPH5BKgT1nJTK82poAty1OxrPS/69ZXGQJFzLQ2/TnU2YSMVZMrKvXYPZj
         /3CA4FpyxIUO4WeiRaGebxeT40Npz9q0SBkH+o57ztnwMQ2FsUM+1KHCROGS/gT22AI6
         l4iOlHvr6Xx4hm7xWw5viqB1F2R8ERJA274fwQLAM2IcYkjGgWAOm+m0UBOSExh0RLI5
         s21w==
X-Gm-Message-State: APjAAAWK0jfPIL4XrhGjVecezfxuWJMmMxRkqm5PvVm72LVXcONNIpDP
        FKge58vprVCVNZsFHUjZ7ZULoA==
X-Google-Smtp-Source: APXvYqysf2AXME1Qm/O7vPO/Ou6BnNuDgIMkCsdqcKGejU8Aw+TCdQtJkoA5QpSA61it64agmoHf2A==
X-Received: by 2002:a17:90a:9dc3:: with SMTP id x3mr1019412pjv.45.1578419983503;
        Tue, 07 Jan 2020 09:59:43 -0800 (PST)
Received: from ubuntu.netflix.com (166.sub-174-194-208.myvzw.com. [174.194.208.166])
        by smtp.gmail.com with ESMTPSA id g7sm210324pfq.33.2020.01.07.09.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 09:59:42 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        jannh@google.com, cyphar@cyphar.com, christian.brauner@ubuntu.com,
        oleg@redhat.com, luto@amacapital.net, viro@zeniv.linux.org.uk,
        gpascutto@mozilla.com, ealvarez@mozilla.com, fweimer@redhat.com,
        jld@mozilla.com, arnd@arndb.de
Subject: [PATCH v9 4/4] test: Add test for pidfd getfd
Date:   Tue,  7 Jan 2020 09:59:27 -0800
Message-Id: <20200107175927.4558-5-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107175927.4558-1-sargun@sargun.me>
References: <20200107175927.4558-1-sargun@sargun.me>
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
 tools/testing/selftests/pidfd/Makefile        |   2 +-
 tools/testing/selftests/pidfd/pidfd.h         |   9 +
 .../selftests/pidfd/pidfd_getfd_test.c        | 249 ++++++++++++++++++
 4 files changed, 260 insertions(+), 1 deletion(-)
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
 
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index c6bc68329f4b..d482515604db 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -36,6 +36,10 @@
 #define __NR_clone3 -1
 #endif
 
+#ifndef __NR_pidfd_getfd
+#define __NR_pidfd_getfd -1
+#endif
+
 /*
  * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
  * That means, when it wraps around any pid < 300 will be skipped.
@@ -84,4 +88,9 @@ static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
 	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
 }
 
+static inline int sys_pidfd_getfd(int pidfd, int fd, int flags)
+{
+	return syscall(__NR_pidfd_getfd, pidfd, fd, flags);
+}
+
 #endif /* __PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
new file mode 100644
index 000000000000..401a7c1d0312
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -0,0 +1,249 @@
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
+#define UID_NOBODY 65535
+
+static int sys_kcmp(pid_t pid1, pid_t pid2, int type, unsigned long idx1,
+		    unsigned long idx2)
+{
+	return syscall(__NR_kcmp, pid1, pid2, type, idx1, idx2);
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
+		return -1;
+	}
+
+	ret = send(sk, &memfd, sizeof(memfd), 0);
+	if (ret != sizeof(memfd)) {
+		fprintf(stderr, "%s: Child failed to send fd number\n",
+			strerror(errno));
+		return -1;
+	}
+
+	/*
+	 * The fixture setup is completed at this point. The tests will run.
+	 *
+	 * This blocking recv enables the parent to message the child.
+	 * Either we will read 'P' off of the sk, indicating that we need
+	 * to disable ptrace, or we will read a 0, indicating that the other
+	 * side has closed the sk. This occurs during fixture teardown time,
+	 * indicating that the child should exit.
+	 */
+	while ((ret = recv(sk, &buf, sizeof(buf), 0)) > 0) {
+		if (buf == 'P') {
+			ret = prctl(PR_SET_DUMPABLE, 0);
+			if (ret < 0) {
+				fprintf(stderr,
+					"%s: Child failed to disable ptrace\n",
+					strerror(errno));
+				return -1;
+			}
+		} else {
+			fprintf(stderr, "Child received unknown command %c\n",
+				buf);
+			return -1;
+		}
+		ret = send(sk, &buf, sizeof(buf), 0);
+		if (ret != 1) {
+			fprintf(stderr, "%s: Child failed to ack\n",
+				strerror(errno));
+			return -1;
+		}
+	}
+	if (ret < 0) {
+		fprintf(stderr, "%s: Child failed to read from socket\n",
+			strerror(errno));
+		return -1;
+	}
+
+	return 0;
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
+		ret = -1;
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
+	/*
+	 * remote_fd is the number of the FD which we are trying to retrieve
+	 * from the child.
+	 */
+	int remote_fd;
+	/* pid points to the child which we are fetching FDs from */
+	pid_t pid;
+	/* pidfd is the pidfd of the child */
+	int pidfd;
+	/*
+	 * sk is our side of the socketpair used to communicate with the child.
+	 * When it is closed, the child will exit.
+	 */
+	int sk;
+};
+
+FIXTURE_SETUP(child)
+{
+	int ret, sk_pair[2];
+
+	ASSERT_EQ(0, socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair)) {
+		TH_LOG("%s: failed to create socketpair", strerror(errno));
+	}
+	self->sk = sk_pair[0];
+
+	self->pid = fork();
+	ASSERT_GE(self->pid, 0);
+
+	if (self->pid == 0) {
+		close(sk_pair[0]);
+		if (child(sk_pair[1]))
+			_exit(EXIT_FAILURE);
+		_exit(EXIT_SUCCESS);
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
+	EXPECT_EQ(0, close(self->pidfd));
+	EXPECT_EQ(0, close(self->sk));
+
+	EXPECT_EQ(0, wait_for_pid(self->pid));
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
+		ASSERT_EQ(0, seteuid(UID_NOBODY));
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
+#if __NR_pidfd_getfd == -1
+int main(void)
+{
+	fprintf(stderr, "__NR_pidfd_getfd undefined. The pidfd_getfd syscall is unavailable. Test aborting\n");
+	return KSFT_SKIP;
+}
+#else
+TEST_HARNESS_MAIN
+#endif
-- 
2.20.1

