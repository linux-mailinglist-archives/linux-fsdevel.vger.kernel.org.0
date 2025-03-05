Return-Path: <linux-fsdevel+bounces-43235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D4CA4FB4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887A5169823
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39504206F1B;
	Wed,  5 Mar 2025 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAO6mqOu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4562063EE
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169338; cv=none; b=ECm3wdmB8prCILgic2crZ5kPfMhUNnI7dWQ86OxTQXGR4ES6uYnE0JM8KhH9Wv1xzQsYnRaqFC8L324eOMEtYTg6mTOWTas0ZUcPpCgOkmt91rYaJB/HBOjK3VcwQ7oVayeCMe3UQnfhRXAfc322TLKYAPc4TimDJzaToFY/AJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169338; c=relaxed/simple;
	bh=n1AmvJGTE+dyEb9yOEMqfK/t0tSBbHA/ZFXA20F2ATU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbRZOO6PLMrkXCFdAkw6j6VPtFr6IavIM0GqnoHiNFc0tVX3XzYZvLZo7RZi2OiwY08h3BKIVQf9NCkDGxR7rtN6nq+bDs7jGpIOCjGkQ3biFgdSYwse9vQsPxOX0yXcnksJeZK6TFyhh1aXyUa3e+rwzXgZou8HctQ2TudLb64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAO6mqOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9354DC4CEE8;
	Wed,  5 Mar 2025 10:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169338;
	bh=n1AmvJGTE+dyEb9yOEMqfK/t0tSBbHA/ZFXA20F2ATU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GAO6mqOudhuBr0X7TUoV8q9nKy/A0crUZIXYAqwRa8y41v48IyYwIakLf62LaXz7g
	 gqN1Rt33wwm1mjwo6LWKIZ7y5xgZRbppgLCCtyI8OfvbumkFq209vIv9pMidlL9enj
	 6jmUsEhPG84BH1ltW8Ln+4EyQOox25tsPFOGD5kiY1eZVhj2T2ZzHI5yHgZnWfc/Xb
	 Ciov+yM3aD+GbOyIJZ7uqTgb4XxdMdH/PQbqKIvkR5NotGRWr1ilCNJs4aDkCW7mGG
	 +p3/a07RU8MWcdqYEV4mKWeLBHicw7vmalve1i6t6KA/RG3UOp8OyZEvduUdLJrQt0
	 Mrol90+Bap+HQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:25 +0100
Subject: [PATCH v3 15/16] selftests/pidfd: add sixth PIDFD_INFO_EXIT
 selftest
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-15-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=6744; i=brauner@kernel.org;
 h=from:subject:message-id; bh=n1AmvJGTE+dyEb9yOEMqfK/t0tSBbHA/ZFXA20F2ATU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJphzuXmrXnT4mJ36KTVB9gtDog76PwO3cXrPTP6N
 GOB1fbDHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZaMjIMMtpSfX2OrftnWVS
 a/n/mpdYsLqeiFSo/dnarM9hk50ewMjQsCE9921h4B7L8Fl75sXEsh6fIRWzy9YmtShAbfKe+ay
 cAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a selftest for PIDFD_INFO_EXIT behavior.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-15-44fdacfaa7b7@kernel.org
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


