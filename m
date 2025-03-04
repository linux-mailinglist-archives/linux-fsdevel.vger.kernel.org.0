Return-Path: <linux-fsdevel+bounces-43071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C214A4D903
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276D117885F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C441FF1B7;
	Tue,  4 Mar 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L18CJL+g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B421FC0F0
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081308; cv=none; b=qS0w/0ZsS81IKEk+HG4dfI4H47qIuHFE4ixriE2Yq5L0dBx6stdlsilJ7PNRMZmKRwSO4GVM0Xrdg6DmcP+kXexqyQpln71M8UdotGIOyFCD3a0jkqpqAvQJkCs0rs4fNOIkC9Rju73S7OpDhvwG+7RjfLexx/b4e9Zwm5I4gGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081308; c=relaxed/simple;
	bh=NB4wYrYB2xSU7+HpfTxfvQl8syAvc8zDhO/ZC76uTwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J8AWX++Qf3uWnFODzT1xnXDlqzZaNlj2rHUprteO17qVhqQwxA9wHmEABdlnR8iuAdtkJCH2ZM19fNDzDCYuj9IQMAORwjZA7/tu3jCCkfibc9PZU2K72e9pJE8ODNy4v758ib4Yd7cnuuxk3ST+fAHNvZ3vHiiaL55fxYxMJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L18CJL+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87F6C4CEE9;
	Tue,  4 Mar 2025 09:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081307;
	bh=NB4wYrYB2xSU7+HpfTxfvQl8syAvc8zDhO/ZC76uTwQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L18CJL+gODcuEjukY6CInkoiQeoawNHiaz3K/cqRRXlgxszgS3y7b8+RiYuivq51x
	 152PJGz5Wyb6J9mgVJk4nAFuwG2knDH0Mii4eLKD3VkF/ZULY1MG6BkZ6AHEfNjQC5
	 wEPEWo9CaIFiYt/RnK2xEQG3C+HdWeTDRqlMpIBQxj3hnboaQ7L6FFwKPNVtSoikOd
	 kUNV3y1ge44MK8L/HznYkdsDJ8aa2SI1QUxLMx5ogWUkNJnTakVSXTHr12Tpji8dlp
	 tCTeM7sB3l8akE0RMVYOloJ/K0Xp2QusaFtWRQImrCiOuPvbhnuYGEqH8UA1X/Jc+x
	 R/5Cok4vSr/aA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:15 +0100
Subject: [PATCH v2 15/15] selftests/pidfd: add sixth PIDFD_INFO_EXIT
 selftest
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-15-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=6642; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NB4wYrYB2xSU7+HpfTxfvQl8syAvc8zDhO/ZC76uTwQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7V7igbTu29BV7j32itM4VlcfzbxAnvNF/2EDQX3c
 z0+r7B41FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAnCTJRkZ1oZkBVV5uk1+yvK8
 8tG1GfW87S5+xyMzZ+mZ/YpYFqrPysiwN6E6b8Vx6bevlrCcnpZ8ofvp59fbJJ+XpT6NMozw3tv
 OBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a selftest for PIDFD_INFO_EXIT behavior.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd.h           |   4 +
 tools/testing/selftests/pidfd/pidfd_info_test.c | 151 ++++++++++++++++++++++++
 2 files changed, 155 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index cc8e381978df..fee6fd3e67dd 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -131,6 +131,10 @@
 #define PIDFD_INFO_EXIT			(1UL << 3) /* Always returned if available, even if not requested */
 #endif
 
+#ifndef PIDFD_THREAD
+#define PIDFD_THREAD O_EXCL
+#endif
+
 struct pidfd_info {
 	__u64 mask;
 	__u64 cgroupid;
diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 16e4be2364df..5e86e3df323b 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -218,4 +218,155 @@ TEST_F(pidfd_info, success_reaped_poll)
 	ASSERT_EQ(WTERMSIG(info.exit_code), SIGKILL);
 }
 
+static void *pidfd_info_pause_thread(void *arg)
+{
+	pid_t pid_thread = gettid();
+	int ipc_socket = *(int *)arg;
+
+	/* Inform the grand-parent what the tid of this thread is. */
+	if (write_nointr(ipc_socket, &pid_thread, sizeof(pid_thread)) != sizeof(pid_thread))
+		return NULL;
+
+	close(ipc_socket);
+
+	/* Sleep untill we're killed. */
+	pause();
+	return NULL;
+}
+
+TEST_F(pidfd_info, thread_group)
+{
+	pid_t pid_leader, pid_thread;
+	pthread_t thread;
+	int nevents, pidfd_leader, pidfd_thread, pidfd_leader_thread, ret;
+	int ipc_sockets[2];
+	struct pollfd fds = {};
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT,
+	}, info2;
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
+		if (pthread_create(&thread, NULL, pidfd_info_pause_thread, &ipc_sockets[1]))
+			syscall(__NR_exit, EXIT_FAILURE);
+
+		/* Make the thread-group leader exit prematurely. */
+		syscall(__NR_exit, EXIT_SUCCESS);
+	}
+
+	/* Retrieve the tid of the thread. */
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &pid_thread, sizeof(pid_thread)), sizeof(pid_thread));
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	/* Opening a thread as a thread-group leader must fail. */
+	pidfd_thread = sys_pidfd_open(pid_thread, 0);
+	ASSERT_LT(pidfd_thread, 0);
+
+	/* Opening a thread as a PIDFD_THREAD must succeed. */
+	pidfd_thread = sys_pidfd_open(pid_thread, PIDFD_THREAD);
+	ASSERT_GE(pidfd_thread, 0);
+
+	/*
+	 * Opening a PIDFD_THREAD aka thread-specific pidfd based on a
+	 * thread-group leader must succeed.
+	 */
+	pidfd_leader_thread = sys_pidfd_open(pid_leader, PIDFD_THREAD);
+	ASSERT_GE(pidfd_leader_thread, 0);
+
+	/*
+	 * Note that pidfd_leader is a thread-group pidfd, so polling on it
+	 * would only notify us once all thread in the thread-group have
+	 * exited. So we can't poll before we have taken down the whole
+	 * thread-group.
+	 */
+
+	/* Get PIDFD_GET_INFO using the thread-group leader pidfd. */
+	ASSERT_EQ(ioctl(pidfd_leader, PIDFD_GET_INFO, &info), 0);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_CREDS));
+	/* Process has exited but not been reaped, so no PIDFD_INFO_EXIT information yet. */
+	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_EXIT));
+	ASSERT_EQ(info.pid, pid_leader);
+
+	/*
+	 * Now retrieve the same info using the thread specific pidfd
+	 * for the thread-group leader.
+	 */
+	info2.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT;
+	ASSERT_EQ(ioctl(pidfd_leader_thread, PIDFD_GET_INFO, &info2), 0);
+	ASSERT_TRUE(!!(info2.mask & PIDFD_INFO_CREDS));
+	/* Process has exited but not been reaped, so no PIDFD_INFO_EXIT information yet. */
+	ASSERT_FALSE(!!(info2.mask & PIDFD_INFO_EXIT));
+	ASSERT_EQ(info2.pid, pid_leader);
+
+	/* Now try the thread-specific pidfd. */
+	ASSERT_EQ(ioctl(pidfd_thread, PIDFD_GET_INFO, &info), 0);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_CREDS));
+	/* The thread hasn't exited, so no PIDFD_INFO_EXIT information yet. */
+	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_EXIT));
+	ASSERT_EQ(info.pid, pid_thread);
+
+	/*
+	 * Take down the whole thread-group. The thread-group leader
+	 * exited successfully but the thread will now be SIGKILLed.
+	 * This must be reflected in the recorded exit information.
+	 */
+	EXPECT_EQ(sys_pidfd_send_signal(pidfd_leader, SIGKILL, NULL, 0), 0);
+	EXPECT_EQ(sys_waitid(P_PIDFD, pidfd_leader, NULL, WEXITED), 0);
+
+	fds.events = POLLIN;
+	fds.fd = pidfd_leader;
+	nevents = poll(&fds, 1, -1);
+	ASSERT_EQ(nevents, 1);
+	ASSERT_TRUE(!!(fds.revents & POLLIN));
+	/* The thread-group leader has been reaped. */
+	ASSERT_TRUE(!!(fds.revents & POLLHUP));
+
+	/*
+	 * Retrieve exit information for the thread-group leader via the
+	 * thread-group leader pidfd.
+	 */
+	info.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT;
+	ASSERT_EQ(ioctl(pidfd_leader, PIDFD_GET_INFO, &info), 0);
+	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_CREDS));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
+	/* The thread-group leader exited successfully. Only the specific thread was SIGKILLed. */
+	ASSERT_TRUE(WIFEXITED(info.exit_code));
+	ASSERT_EQ(WEXITSTATUS(info.exit_code), 0);
+
+	/*
+	 * Retrieve exit information for the thread-group leader via the
+	 * thread-specific pidfd.
+	 */
+	info2.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT;
+	ASSERT_EQ(ioctl(pidfd_leader_thread, PIDFD_GET_INFO, &info2), 0);
+	ASSERT_FALSE(!!(info2.mask & PIDFD_INFO_CREDS));
+	ASSERT_TRUE(!!(info2.mask & PIDFD_INFO_EXIT));
+
+	/* The thread-group leader exited successfully. Only the specific thread was SIGKILLed. */
+	ASSERT_TRUE(WIFEXITED(info2.exit_code));
+	ASSERT_EQ(WEXITSTATUS(info2.exit_code), 0);
+
+	/* Retrieve exit information for the thread. */
+	info.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT;
+	ASSERT_EQ(ioctl(pidfd_thread, PIDFD_GET_INFO, &info), 0);
+	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_CREDS));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
+
+	/* The thread got SIGKILLed. */
+	ASSERT_TRUE(WIFSIGNALED(info.exit_code));
+	ASSERT_EQ(WTERMSIG(info.exit_code), SIGKILL);
+
+	EXPECT_EQ(close(pidfd_leader), 0);
+	EXPECT_EQ(close(pidfd_thread), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


