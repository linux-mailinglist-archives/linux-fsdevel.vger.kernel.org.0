Return-Path: <linux-fsdevel+bounces-43236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8233A4FB4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2703A7A911F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D224B206F1D;
	Wed,  5 Mar 2025 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8xHPRgV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408782063DA
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169340; cv=none; b=IkYfZm+l5SMBdhS86UQTEJjc9xbMC+hUrNWCI6vyvf6xyxcuKtYHPTHqONucWtH8eXKjdG6L+em7XY7WIodwcOAgjZmRzuhLKfJRHf8vj85EOJPWbCUBDg65n7EjRoUH+P0Dlk/JN5EjpMBSmMw991nUiXlntxqt5y5uvYatk9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169340; c=relaxed/simple;
	bh=2vzwBgldpyiPOQOL4Gu0EW3tT0G1/GW/7QIQOyUINnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PonrNt2FIFKkXi1TwiAWtHKrqIu6jN1k8LrnNNPDed4Fh5Uxx5gtcIbHYHqQgwNc+/vvCXGLjqzSkG/oWSmy+a+/WHHpMx9UShvgImjCyfTz+FwNRk3A4O8uLTkN2Y7SmKZ/xAY0W8AjSmxBLn5gpVcuWmjLRUA2nVZ1fbBUBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8xHPRgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95782C4CEEB;
	Wed,  5 Mar 2025 10:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169340;
	bh=2vzwBgldpyiPOQOL4Gu0EW3tT0G1/GW/7QIQOyUINnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A8xHPRgVwsEPlUHmwA5n+qAwErJhBXHRUwM2y75ZNplXxcwmwWRkYd5esQj68zYKV
	 7tAXp37oszlDtL7LYEWwTYBzPQLXNJBWvb+Coi8tw/+0ZmViXarSE5H9A42azLq7lD
	 JpMuvIjNGObj9AyE+SgK46kAKJXiNLRlup++Go2TDBVA8HN2dU8i8S2sb+bM43rcnE
	 bD8CiqRm8BNWkOWDtM4MqPEGz6zhnjJcfmPiLxM/W0crPyWM+qdttMS3yiVuoGnjUW
	 crZpaO9eYkLQpHBDOBYfdNWJU48lrL2VADsPp9Er99ZWywT4OynQ+77IyPEBIMJXkU
	 yP2qh4nzv2WUQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:26 +0100
Subject: [PATCH v3 16/16] selftests/pidfd: add seventh PIDFD_INFO_EXIT
 selftest
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-16-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=7214; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2vzwBgldpyiPOQOL4Gu0EW3tT0G1/GW/7QIQOyUINnw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJrRODmWWVRuYYaD2Jc78z0Uj2Wuuak6a9FhLfmf/
 xaqbru1sKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiKuYMv5jfl94O0fFIPb9v
 zkzvMpmm+S7vju166tcn1u3/bOoWq0OMDB0upw4J6Dvmitb8mTVDzLGDc++16O/R3fEi05jKrn9
 YwwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a selftest for PIDFD_INFO_EXIT behavior.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/.gitignore          |   1 +
 tools/testing/selftests/pidfd/Makefile            |   2 +
 tools/testing/selftests/pidfd/pidfd.h             |   7 ++
 tools/testing/selftests/pidfd/pidfd_exec_helper.c |  12 +++
 tools/testing/selftests/pidfd/pidfd_info_test.c   | 125 ++++++++++++++++++++++
 5 files changed, 147 insertions(+)

diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
index bddae1d4d7e4..0406a065deb4 100644
--- a/tools/testing/selftests/pidfd/.gitignore
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -9,3 +9,4 @@ pidfd_setns_test
 pidfd_file_handle_test
 pidfd_bind_mount
 pidfd_info_test
+pidfd_exec_helper
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index a94c2bc8d594..fcbefc0d77f6 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -5,5 +5,7 @@ TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
 	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
 	pidfd_file_handle_test pidfd_bind_mount pidfd_info_test
 
+TEST_GEN_PROGS_EXTENDED := pidfd_exec_helper
+
 include ../lib.mk
 
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index fee6fd3e67dd..cec22aa11cdf 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -254,4 +254,11 @@ static inline ssize_t write_nointr(int fd, const void *buf, size_t count)
 	return ret;
 }
 
+static inline int sys_execveat(int dirfd, const char *pathname,
+			       char *const argv[], char *const envp[],
+			       int flags)
+{
+        return syscall(__NR_execveat, dirfd, pathname, argv, envp, flags);
+}
+
 #endif /* __PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_exec_helper.c b/tools/testing/selftests/pidfd/pidfd_exec_helper.c
new file mode 100644
index 000000000000..5516808c95f2
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_exec_helper.c
@@ -0,0 +1,12 @@
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+int main(int argc, char *argv[])
+{
+	if (pause())
+		_exit(EXIT_FAILURE);
+
+	_exit(EXIT_SUCCESS);
+}
diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 5e86e3df323b..09bc4ae7aed5 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -369,4 +369,129 @@ TEST_F(pidfd_info, thread_group)
 	EXPECT_EQ(close(pidfd_thread), 0);
 }
 
+static void *pidfd_info_thread_exec(void *arg)
+{
+	pid_t pid_thread = gettid();
+	int ipc_socket = *(int *)arg;
+
+	/* Inform the grand-parent what the tid of this thread is. */
+	if (write_nointr(ipc_socket, &pid_thread, sizeof(pid_thread)) != sizeof(pid_thread))
+		return NULL;
+
+	if (read_nointr(ipc_socket, &pid_thread, sizeof(pid_thread)) != sizeof(pid_thread))
+		return NULL;
+
+	close(ipc_socket);
+
+	sys_execveat(AT_FDCWD, "pidfd_exec_helper", NULL, NULL, 0);
+	return NULL;
+}
+
+TEST_F(pidfd_info, thread_group_exec)
+{
+	pid_t pid_leader, pid_thread;
+	pthread_t thread;
+	int nevents, pidfd_leader, pidfd_leader_thread, pidfd_thread, ret;
+	int ipc_sockets[2];
+	struct pollfd fds = {};
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT,
+	};
+
+	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	EXPECT_EQ(ret, 0);
+
+	pid_leader = create_child(&pidfd_leader, 0);
+	EXPECT_GE(pid_leader, 0);
+
+	if (pid_leader == 0) {
+		close(ipc_sockets[0]);
+
+		/* The thread will outlive the thread-group leader. */
+		if (pthread_create(&thread, NULL, pidfd_info_thread_exec, &ipc_sockets[1]))
+			syscall(__NR_exit, EXIT_FAILURE);
+
+		/* Make the thread-group leader exit prematurely. */
+		syscall(__NR_exit, EXIT_SUCCESS);
+	}
+
+	/* Retrieve the tid of the thread. */
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &pid_thread, sizeof(pid_thread)), sizeof(pid_thread));
+
+	/* Opening a thread as a PIDFD_THREAD must succeed. */
+	pidfd_thread = sys_pidfd_open(pid_thread, PIDFD_THREAD);
+	ASSERT_GE(pidfd_thread, 0);
+
+	/* Open a thread-specific pidfd for the thread-group leader. */
+	pidfd_leader_thread = sys_pidfd_open(pid_leader, PIDFD_THREAD);
+	ASSERT_GE(pidfd_leader_thread, 0);
+
+	/*
+	 * We can poll and wait for the old thread-group leader to exit
+	 * using a thread-specific pidfd.
+	 *
+	 * This only works until the thread has execed. When the thread
+	 * has execed it will have taken over the old thread-group
+	 * leaders struct pid. Calling poll after the thread execed will
+	 * thus block again because a new thread-group has started (Yes,
+	 * it's fscked.).
+	 */
+	fds.events = POLLIN;
+	fds.fd = pidfd_leader_thread;
+	nevents = poll(&fds, 1, -1);
+	ASSERT_EQ(nevents, 1);
+	/* The thread-group leader has exited. */
+	ASSERT_TRUE(!!(fds.revents & POLLIN));
+	/* The thread-group leader hasn't been reaped. */
+	ASSERT_FALSE(!!(fds.revents & POLLHUP));
+
+	/* Now that we've opened a thread-specific pidfd the thread can exec. */
+	ASSERT_EQ(write_nointr(ipc_sockets[0], &pid_thread, sizeof(pid_thread)), sizeof(pid_thread));
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	/* Wait until the kernel has SIGKILLed the thread. */
+	fds.events = POLLHUP;
+	fds.fd = pidfd_thread;
+	nevents = poll(&fds, 1, -1);
+	ASSERT_EQ(nevents, 1);
+	/* The thread has been reaped. */
+	ASSERT_TRUE(!!(fds.revents & POLLHUP));
+
+	/* Retrieve thread-specific exit info from pidfd. */
+	ASSERT_EQ(ioctl(pidfd_thread, PIDFD_GET_INFO, &info), 0);
+	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_CREDS));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
+	/*
+	 * While the kernel will have SIGKILLed the whole thread-group
+	 * during exec it will cause the individual threads to exit
+	 * cleanly.
+	 */
+	ASSERT_TRUE(WIFEXITED(info.exit_code));
+	ASSERT_EQ(WEXITSTATUS(info.exit_code), 0);
+
+	/*
+	 * The thread-group leader is still alive, the thread has taken
+	 * over its struct pid and thus its pid number.
+	 */
+	info.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT;
+	ASSERT_EQ(ioctl(pidfd_leader, PIDFD_GET_INFO, &info), 0);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_CREDS));
+	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_EXIT));
+	ASSERT_EQ(info.pid, pid_leader);
+
+	/* Take down the thread-group leader. */
+	EXPECT_EQ(sys_pidfd_send_signal(pidfd_leader, SIGKILL, NULL, 0), 0);
+	EXPECT_EQ(sys_waitid(P_PIDFD, pidfd_leader, NULL, WEXITED), 0);
+
+	/* Retrieve exit information for the thread-group leader. */
+	info.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT;
+	ASSERT_EQ(ioctl(pidfd_leader, PIDFD_GET_INFO, &info), 0);
+	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_CREDS));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
+
+	EXPECT_EQ(close(pidfd_leader), 0);
+	EXPECT_EQ(close(pidfd_thread), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


