Return-Path: <linux-fsdevel+bounces-44305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B67B7A67056
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 10:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9BEA7A5D97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E00D207E0E;
	Tue, 18 Mar 2025 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+DCXs1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECCE207DEE
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291557; cv=none; b=Xi9y9h2od951bJRiMZ6e6jBQkS1rDIxEOAfOhaCk1GURCmCpwafJPg5cq/IbU0AUkM94i/lJ4KwEaMOhCMuJCxPNh2MYooE2RttSmtyYVFJnAvnJAu4dUU77fH/+kSbrR+Q5l56AryBSqZ6HYvNjZJdJ3kZ8UCfiVnxplKIylyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291557; c=relaxed/simple;
	bh=48L0rXuRmbKbnU8ZJxRjmReXIG9hmCA13naUO/++Rn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cTsadN+5ELBZErYnJh8Q9hKev0u+ZrKt4f0rBTAkq8m2y0efOAkCoLZ/fOA3+52mSi3zafhzq+3ETW/9HbSrG8WhC8WCffC2DbEF4pXS8d/R/7nsjUbe/zRlAbUjyoQ0WTmDYUV4jgAkWFcpX15nnY3L1yZ0idlc6yjnm21k8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+DCXs1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE799C4CEDD;
	Tue, 18 Mar 2025 09:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742291556;
	bh=48L0rXuRmbKbnU8ZJxRjmReXIG9hmCA13naUO/++Rn4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y+DCXs1vM8VljXeek6SpXtsBnxdVaqwdY3wYbT2EY6N6wp6VSUKwFPw9VmFKkLXyM
	 jqOy55MSfkxwAqnOuQ/HEX+REsQrPHAs6o/V+n00YHOek9M0355+2lu/WVyH8LVV8O
	 61P3UsuwCI3tt+iCnuPX9bXGleLJfWetnD/Mb8WnhskYHcrnZ64InYKDqDay1ZMtLH
	 C4BE2rDgm/Kl7yL3eR4WcmPf2vpAGIJxTDJ1E9YMMDjYgAw/+Yz9TtCqtd/Pm8IvAY
	 Mnd7a2ZbOITxmcBRt2G6E7VKnalbmZ8zYWxKlr97E46TVMqChiHHpUZSZeNbBK0np4
	 bOxKysU4PMu4A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Mar 2025 10:52:18 +0100
Subject: [PATCH RFC v2 3/3] selftests/pidfd: second test for multi-threaded
 exec polling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-work-pidfs-thread_group-v2-3-2677898ffa2e@kernel.org>
References: <20250318-work-pidfs-thread_group-v2-0-2677898ffa2e@kernel.org>
In-Reply-To: <20250318-work-pidfs-thread_group-v2-0-2677898ffa2e@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=5489; i=brauner@kernel.org;
 h=from:subject:message-id; bh=48L0rXuRmbKbnU8ZJxRjmReXIG9hmCA13naUO/++Rn4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfdIrqOxyhFntpWmF1GO8MYXe3z8+W+F3/+vtl6rrFc
 4pfuze4dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkIZGR4fGyss1mwhrRE7m+
 3Z3i6cI0c+M54ZnrHBN2Re6qDWLe/orhF1P/deG2UDXGxV0fFLhKczq3lxfu/vvX6mYnw4aQrAu
 qTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Ensure that during a multi-threaded exec and premature thread-group
leader exit no exit notification is generated.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 138 ++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index f06b8e2f969a..f6ead7993f7e 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -519,4 +519,142 @@ TEST_F(pidfd_info, thread_group_exec)
 	EXPECT_EQ(close(pidfd_thread), 0);
 }
 
+static void *pidfd_info_thread_exec_sane(void *arg)
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
+TEST_F(pidfd_info, thread_group_exec_thread)
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
+		if (pthread_create(&thread, NULL, pidfd_info_thread_exec_sane, &ipc_sockets[1]))
+			syscall(__NR_exit, EXIT_FAILURE);
+
+		/*
+		 * Pause the thread-group leader. It will be killed once
+		 * the subthread execs.
+		 */
+		pause();
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
+	/* Now that we've opened a thread-specific pidfd the thread can exec. */
+	ASSERT_EQ(write_nointr(ipc_sockets[0], &pid_thread, sizeof(pid_thread)), sizeof(pid_thread));
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	/*
+	 * The subthread will now exec. The struct pid of the old
+	 * thread-group leader will be assumed by the subthread which
+	 * becomes the new thread-group leader. So no exit notification
+	 * must be generated. Wait for 5 seconds and call it a success
+	 * if no notification has been received.
+	 */
+	fds.events = POLLIN;
+	fds.fd = pidfd_leader_thread;
+	nevents = poll(&fds, 1, 5000 /* wait 5 seconds */);
+	ASSERT_EQ(nevents, 0);
+	ASSERT_FALSE(!!(fds.revents & POLLIN));
+	ASSERT_FALSE(!!(fds.revents & POLLHUP));
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
+
+	/*
+	 * Afte the exec we're dealing with an empty thread-group so now
+	 * we must see an exit notification on the thread-specific pidfd
+	 * for the thread-group leader as there's no subthread that can
+	 * revive the struct pid.
+	 */
+	fds.events = POLLIN;
+	fds.fd = pidfd_leader_thread;
+	nevents = poll(&fds, 1, -1);
+	ASSERT_EQ(nevents, 1);
+	ASSERT_TRUE(!!(fds.revents & POLLIN));
+	ASSERT_FALSE(!!(fds.revents & POLLHUP));
+
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


