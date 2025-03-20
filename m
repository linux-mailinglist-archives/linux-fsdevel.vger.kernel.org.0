Return-Path: <linux-fsdevel+bounces-44530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCFBA6A298
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1F07ACF85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 09:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169082222C3;
	Thu, 20 Mar 2025 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIvHc+0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A72222AB
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462965; cv=none; b=hPkA4J3xsCzrNiWP3owm38hFV6NvarWkd7R2pRAdwQSRTUyY6ZIhT89APxx8V+G60o2lplYJO4CVZPUNmbqZl3cLNKo0Ge5zAkdv8XduM6oJkK3Efqv9a+5FRj/hd4ZSXz4gG6ypOT8HMGIn4yQqvx0xQz/1sPPhctzzsuuW0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462965; c=relaxed/simple;
	bh=CAwFZ+NFSzQrP2Mr5CLbJgEZkFRBy4WeTWw8eSTlCbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sa9wyXxHyy0uhgaqcVt6eX/Xyc9sxdGY2TAJaszf/UG5gmj+vlAzlNuSqJW1Qy5SbEBv3CdNAsroyukOiXqWR/tDIe6PJD2d3Ddsh9n45dqykpBhGpyA7A5STx5FcguiJEeYEpiejkOj79EJtrrWrJLmiSUG4iIoNhTQpwPJ1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIvHc+0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25021C4CEE8;
	Thu, 20 Mar 2025 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742462964;
	bh=CAwFZ+NFSzQrP2Mr5CLbJgEZkFRBy4WeTWw8eSTlCbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bIvHc+0yUZMaXYEwF9nOr/HoWzUFUe1scgeqXQQ1+i8mcU/gZtIyOSCDmNIWkbV3i
	 idfTtswPI+upsKxP7lYLeH8sq2gnNOhiFLuorgm/68exmgVdF2BVJpYzIYN+U/Ekyb
	 d4hnnBIK6Zg7FEmCjcMPKvNOB732LQFRMFGjvTA48f9c6dEy1Uf01wS/r9xqo6r+rJ
	 sRpBAu6FByjAyuQ2lO7dFwC/I+nv/FMquNoPHKW2mCexPFkYxbO5QGKR9z0PY4Sv6o
	 36IQ8c0G/2M2pCWZ613Ck6cUYB62fJMs0aywshFyqPUQy8BW07d6mq6bVAVUN9ItYV
	 3jghVfq50ap7g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Mar 2025 10:29:08 +0100
Subject: [PATCH v3 3/4] selftests/pidfd: second test for multi-threaded
 exec polling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-work-pidfs-thread_group-v3-3-b7e5f7e2c3b1@kernel.org>
References: <20250320-work-pidfs-thread_group-v3-0-b7e5f7e2c3b1@kernel.org>
In-Reply-To: <20250320-work-pidfs-thread_group-v3-0-b7e5f7e2c3b1@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4392; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CAwFZ+NFSzQrP2Mr5CLbJgEZkFRBy4WeTWw8eSTlCbI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfvv/yEVvap7cyF0Lrp9UtSbplrXjClTN0Wd63L/dWi
 jdukPcO7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIs3kM/3MefZ+27LTUcclf
 NdxTmqrXNZ5ay6Yu6h9Y1j6Ry+H6j0mMDPNbZv6K2D2n/Knx9suBinZm90LLflx7eDtAPHubZdq
 2XmYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Ensure that during a multi-threaded exec and premature thread-group
leader exit no exit notification is generated.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 72 ++++++++++++++++---------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 28a28ae4686a..4169780c9e55 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -413,7 +413,7 @@ static void *pidfd_info_thread_exec(void *arg)
 
 TEST_F(pidfd_info, thread_group_exec)
 {
-	pid_t pid_leader, pid_thread;
+	pid_t pid_leader, pid_poller, pid_thread;
 	pthread_t thread;
 	int nevents, pidfd_leader, pidfd_leader_thread, pidfd_thread, ret;
 	int ipc_sockets[2];
@@ -439,6 +439,37 @@ TEST_F(pidfd_info, thread_group_exec)
 		syscall(__NR_exit, EXIT_SUCCESS);
 	}
 
+	/* Open a thread-specific pidfd for the thread-group leader. */
+	pidfd_leader_thread = sys_pidfd_open(pid_leader, PIDFD_THREAD);
+	ASSERT_GE(pidfd_leader_thread, 0);
+
+	pid_poller = fork();
+	ASSERT_GE(pid_poller, 0);
+	if (pid_poller == 0) {
+		/*
+		 * We can't poll and wait for the old thread-group
+		 * leader to exit using a thread-specific pidfd. The
+		 * thread-group leader exited prematurely and
+		 * notification is delayed until all subthreads have
+		 * exited.
+		 *
+		 * When the thread has execed it will taken over the old
+		 * thread-group leaders struct pid. Calling poll after
+		 * the thread execed will thus block again because a new
+		 * thread-group has started.
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
 	/* Retrieve the tid of the thread. */
 	EXPECT_EQ(close(ipc_sockets[1]), 0);
 	ASSERT_EQ(read_nointr(ipc_sockets[0], &pid_thread, sizeof(pid_thread)), sizeof(pid_thread));
@@ -447,33 +478,12 @@ TEST_F(pidfd_info, thread_group_exec)
 	pidfd_thread = sys_pidfd_open(pid_thread, PIDFD_THREAD);
 	ASSERT_GE(pidfd_thread, 0);
 
-	/* Open a thread-specific pidfd for the thread-group leader. */
-	pidfd_leader_thread = sys_pidfd_open(pid_leader, PIDFD_THREAD);
-	ASSERT_GE(pidfd_leader_thread, 0);
-
-	/*
-	 * We can poll and wait for the old thread-group leader to exit
-	 * using a thread-specific pidfd.
-	 *
-	 * This only works until the thread has execed. When the thread
-	 * has execed it will have taken over the old thread-group
-	 * leaders struct pid. Calling poll after the thread execed will
-	 * thus block again because a new thread-group has started (Yes,
-	 * it's fscked.).
-	 */
-	fds.events = POLLIN;
-	fds.fd = pidfd_leader_thread;
-	nevents = poll(&fds, 1, -1);
-	ASSERT_EQ(nevents, 1);
-	/* The thread-group leader has exited. */
-	ASSERT_TRUE(!!(fds.revents & POLLIN));
-	/* The thread-group leader hasn't been reaped. */
-	ASSERT_FALSE(!!(fds.revents & POLLHUP));
-
 	/* Now that we've opened a thread-specific pidfd the thread can exec. */
 	ASSERT_EQ(write_nointr(ipc_sockets[0], &pid_thread, sizeof(pid_thread)), sizeof(pid_thread));
 	EXPECT_EQ(close(ipc_sockets[0]), 0);
 
+	ASSERT_EQ(wait_for_pid(pid_poller), 0);
+
 	/* Wait until the kernel has SIGKILLed the thread. */
 	fds.events = POLLHUP;
 	fds.fd = pidfd_thread;
@@ -506,6 +516,20 @@ TEST_F(pidfd_info, thread_group_exec)
 
 	/* Take down the thread-group leader. */
 	EXPECT_EQ(sys_pidfd_send_signal(pidfd_leader, SIGKILL, NULL, 0), 0);
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
 	EXPECT_EQ(sys_waitid(P_PIDFD, pidfd_leader, NULL, WEXITED), 0);
 
 	/* Retrieve exit information for the thread-group leader. */

-- 
2.47.2


