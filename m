Return-Path: <linux-fsdevel+bounces-43172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3421DA4EE3C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 21:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3FF174D71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ACD1F8BBF;
	Tue,  4 Mar 2025 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0QcAk1Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B02E3377
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119548; cv=none; b=VzU76VZ+WP5SZ1yDoGaMy9/Cu++8gNzZKocy/apGHMDtdMehzF7/dp1tlgBIjGHFYEQh5gqeRxRCMEQ0IScZUxvzy3v5/QPc+rnsRpgzkYoRdvCI7qzkYMndI8p7u8O+Ayequ0h9w59esEWAaWqeVgnMnBEYE/KurFC3xwYxdz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119548; c=relaxed/simple;
	bh=VJcYo/O1WWxGodiRQPXRxCWmdrBiYbVH3cZrz9umSrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZit4ud3xnocj6J0r16tHWVJyGSvuZdyUo2QaktVsltJeJzvHVyiigsQ6b8fhCF/LSNPGJaHXUJzG+LR1cMKV2/E12aRMf/bFuUeBGZUWePwYvdLJXpuZgswkdL4jCoek2mC6XSWyEBkSZbBDQkAJ7ZOfo70TUYKKuYrpQHc+fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0QcAk1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31271C4CEE5;
	Tue,  4 Mar 2025 20:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741119548;
	bh=VJcYo/O1WWxGodiRQPXRxCWmdrBiYbVH3cZrz9umSrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L0QcAk1Q6/HFnxEemwS3GFE98MvwxtKxlHRJ53HI7E/UpEDSFLUqt/xiRTfV4y414
	 I7dE4x7MdMWc0SV11EwlhkxeY1jTq4u98HrUHmQ9sIqyVQWZywWpyzG+9JNHaVoLiM
	 +bMY103MCUBPQfvwUcVU6Lw5rpZoqj0a1PnICfzWuRMi9NBJmiG+uFtT29qZcdWLs/
	 fMB5+yiDwhs1bV6fbddOkd0KQ+Vkxjg55Z0itz3w2RdnhU1Ws3g72P6vycAcMu2jsx
	 ftUyCaQTGjJTHnNpxxZT6okTlkUCTgAU85Wd1ayOtntq7T4glFm5zX1b4a3WHnvKLq
	 k/NB9h6zvaYEQ==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: [PATCH v2 17/16] selftests/pidfd: test multi-threaded exec with PPIDFD_INFO_EXIT
Date: Tue,  4 Mar 2025 21:18:49 +0100
Message-ID: <20250304-paarweise-erlesen-be86ad628af7@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-15-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-15-44fdacfaa7b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6352; i=brauner@kernel.org; h=from:subject:message-id; bh=VJcYo/O1WWxGodiRQPXRxCWmdrBiYbVH3cZrz9umSrw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfT9DZc43pDePulRsPTz8Z+oO1eKW3T66np3DBr5UC7 x6djigz6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIfG1Ghv4XV9Jev2uxXX9n MZe++joeNQtLV5YYuWanti6ttC9a9gx/ZYznuV6ofbvzbY9f4I/+XS9Nf3wrnj1x9XQfZZXzi9s XMQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Add a selftest for PIDFD_INFO_EXIT behavior.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   2 +
 tools/testing/selftests/pidfd/pidfd.h         |   7 ++
 .../selftests/pidfd/pidfd_exec_helper.c       |  12 +++
 .../testing/selftests/pidfd/pidfd_info_test.c | 102 ++++++++++++++++++
 5 files changed, 124 insertions(+)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_exec_helper.c

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
index 5e86e3df323b..f159a6705a07 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -369,4 +369,106 @@ TEST_F(pidfd_info, thread_group)
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
+	int nevents, pidfd_leader, pidfd_thread, ret;
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


