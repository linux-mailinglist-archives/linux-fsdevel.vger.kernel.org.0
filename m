Return-Path: <linux-fsdevel+bounces-44577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD77A6A72A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6ACE189E162
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B8E21CC55;
	Thu, 20 Mar 2025 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6OXomrq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2C2AE99
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477066; cv=none; b=b+Dd2Va2UW9GneSTCrlDat4WAQkiFENPL/of5NqiKxg66ZSquTdCBZHufwF25Nm62IND7VPDealHSFUMP8zg+QEn2BnXkCtfI+y0Dnc1JFT+mWzhM/FIv1pctOCSigluA8wjMAJe+bF7fK22G9i6YdMuFh3z6uVJvrUu5gcFXnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477066; c=relaxed/simple;
	bh=2oPuMKXAnppK07WHh02sLh41hDtkPLKu83E2A4l+cPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SeuxGYnFa55eFRLBYHSV+m6PSvVMa52Jgh7OEk3BpLPfzptbnaFhdgRLfSTmXDMJBEf+MoJ8SzLEvS24bJ3igHee/zZSuIZf2f/7yH20ED73CyGkT9ZPHgPy0+nJUBlcBkHy6xudF8Ni0c8QS8ZPt6pyEJXy7Gc6DBXt8sexVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6OXomrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10D6C4CEEC;
	Thu, 20 Mar 2025 13:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742477065;
	bh=2oPuMKXAnppK07WHh02sLh41hDtkPLKu83E2A4l+cPw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q6OXomrq/fFmUUszs/ghr8EBPk2w83o8eoMKIxd8OC98cgHtME/6+T17hiA341d5j
	 zIyr4aHtK1mOoc4boUSPGaPY+7+XQepRZIKR7y4Yk3Vc7HrVFEJ4kd44VhGALaC25b
	 uoJ/PHO7vxRypi6PVedI7yhv5bVZyH39+8cv5aJvaCFQBqCxMg5+GBGCtR8WihhHaC
	 IlD+QEdNf8vF5izCtLRJQITJhjghnAwwMehPg+NVZfq8oesF4ULJM+zatXlgoAp4dK
	 ovpSC/LuUTFcELFG/XtLTffCKBKugZx6XkelMN66g/8JJz5woZfqB7LgXmXuL0RCIh
	 yV7FG3xNfvJ9A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Mar 2025 14:24:11 +0100
Subject: [PATCH v4 4/4] selftests/pidfd: third test for multi-threaded exec
 polling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-work-pidfs-thread_group-v4-4-da678ce805bf@kernel.org>
References: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
In-Reply-To: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=5712; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2oPuMKXAnppK07WHh02sLh41hDtkPLKu83E2A4l+cPw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfEftnE+q4koP90KxMn4RtnxwOa3Lefcree1Dpw9tsJ
 pmHCySMO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbypJaR4dbLSxofO+9pPN7F
 eqJ7Ssv7wLgfIssvi2pq32GfyiCzdz4jw50fzne8dz+47njzt+N63fgNJwwsJy9fNGH28rjrHnG
 PVbgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Ensure that during a multi-threaded exec and premature thread-group
leader exit no exit notification is generated.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 147 ++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 4169780c9e55..1758a1b0457b 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -542,4 +542,151 @@ TEST_F(pidfd_info, thread_group_exec)
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
+	pid_t pid_leader, pid_poller, pid_thread;
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
+	pid_poller = fork();
+	ASSERT_GE(pid_poller, 0);
+	if (pid_poller == 0) {
+		/*
+		 * The subthread will now exec. The struct pid of the old
+		 * thread-group leader will be assumed by the subthread which
+		 * becomes the new thread-group leader. So no exit notification
+		 * must be generated. Wait for 5 seconds and call it a success
+		 * if no notification has been received.
+		 */
+		fds.events = POLLIN;
+		fds.fd = pidfd_leader_thread;
+		nevents = poll(&fds, 1, 10000 /* wait 5 seconds */);
+		if (nevents != 0)
+			_exit(EXIT_FAILURE);
+		if (fds.revents & POLLIN)
+			_exit(EXIT_FAILURE);
+		if (fds.revents & POLLHUP)
+			_exit(EXIT_FAILURE);
+		_exit(EXIT_SUCCESS);
+	}
+
+	/* Now that we've opened a thread-specific pidfd the thread can exec. */
+	ASSERT_EQ(write_nointr(ipc_sockets[0], &pid_thread, sizeof(pid_thread)), sizeof(pid_thread));
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+	ASSERT_EQ(wait_for_pid(pid_poller), 0);
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


