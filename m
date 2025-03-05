Return-Path: <linux-fsdevel+bounces-43230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FE6A4FB48
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B60C7A8B72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BC52066F7;
	Wed,  5 Mar 2025 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXpwtsFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE84205AA3
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169327; cv=none; b=Ja0LE/qONi1FFIa1yIkiqB77JwPCJaUeysrFcpZrxr1vmBTvUco9SfhgtVkWm57AVJCdrzSk2AalH35VANereAqscacbonlatWxpWUl+0TDzk7+bia7gDB8pipwg/DTJS4eupmKmWzNIV8NcasuYD5V5KyqshQ3gr8iAttvxcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169327; c=relaxed/simple;
	bh=P0GuDYk1qbYdo5vda3ZW6kjjrFAWoRzsB1VvsLwVEHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxN6m3cQPI0yH+/SOhbKNPkQO6qBCFLDHnqbLGTO1WN6npx2H7j8o2oej1UuCwmIW7xCPIFu/sX4T5d1nuNwAQf9E+/fS7X4LEjcDTJXJbOp56d1wj0sUPs7dunhyoF+TBV/Ehh2gwoxwKFGe+8JIgEg08Z9ySSZw0Q6ZJsBSIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXpwtsFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2FCC4CEEA;
	Wed,  5 Mar 2025 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169327;
	bh=P0GuDYk1qbYdo5vda3ZW6kjjrFAWoRzsB1VvsLwVEHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rXpwtsFPJGhGl/S6lRXYJUIc9axll7WJdK+oepw9WJtjTfqem9bxD4aghsKMVxThO
	 fVrwfBXQvnA+/F/hdr/kNLjEgpbPD/84saMYmHi8Kx1yi7LzBVrkYBypuIPXzwmsuU
	 TpqerzbNYUh7LX4maTqkOgZ9zv8a0+yIo8GniRVoIzLVUN+cLwHfXtX45TJFSfnMRu
	 wh05qjTJajuEPRJOSaBaJFuDVdzFfDhTwlaZNEWOoJwXZzGhhvkGy3UtZWt1k/0y4O
	 1eFoTVuJ5yXeBUbW1LFUElOqsyLCKdJLBHpB7Iv3c8rdpRPowXVDbgFc5wFXdkSakT
	 LdaMj6d8MJH7g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:20 +0100
Subject: [PATCH v3 10/16] selftests/pidfd: add first PIDFD_INFO_EXIT
 selftest
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-10-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=6188; i=brauner@kernel.org;
 h=from:subject:message-id; bh=P0GuDYk1qbYdo5vda3ZW6kjjrFAWoRzsB1VvsLwVEHI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJpR9YT9TNisTS/zvXaamjlP+LnsQPXED7dP6PbKR
 7Zd/Fjh3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR8oOMDE9c15+RqRTcX3k8
 6Ut7c0bSFpXFB00LNppx5dnm3mwpP8bIcMXqwIVlW5VCue8lOpc+9GAKe/Ls4JTtEx4trtSZmZf
 MxQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a selftest for PIDFD_INFO_EXIT behavior.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-10-44fdacfaa7b7@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/.gitignore        |   1 +
 tools/testing/selftests/pidfd/Makefile          |   2 +-
 tools/testing/selftests/pidfd/pidfd.h           |   6 +-
 tools/testing/selftests/pidfd/pidfd_info_test.c | 146 ++++++++++++++++++++++++
 4 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
index bf92481f925c..bddae1d4d7e4 100644
--- a/tools/testing/selftests/pidfd/.gitignore
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -8,3 +8,4 @@ pidfd_getfd_test
 pidfd_setns_test
 pidfd_file_handle_test
 pidfd_bind_mount
+pidfd_info_test
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index 301343a11b62..a94c2bc8d594 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -3,7 +3,7 @@ CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
 
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
 	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
-	pidfd_file_handle_test pidfd_bind_mount
+	pidfd_file_handle_test pidfd_bind_mount pidfd_info_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index bad518766aa5..cc8e381978df 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -127,6 +127,10 @@
 #define PIDFD_INFO_CGROUPID		(1UL << 2) /* Always returned if available, even if not requested */
 #endif
 
+#ifndef PIDFD_INFO_EXIT
+#define PIDFD_INFO_EXIT			(1UL << 3) /* Always returned if available, even if not requested */
+#endif
+
 struct pidfd_info {
 	__u64 mask;
 	__u64 cgroupid;
@@ -141,7 +145,7 @@ struct pidfd_info {
 	__u32 sgid;
 	__u32 fsuid;
 	__u32 fsgid;
-	__u32 spare0[1];
+	__s32 exit_code;
 };
 
 /*
diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
new file mode 100644
index 000000000000..cc1d3d5eba59
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/types.h>
+#include <poll.h>
+#include <pthread.h>
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
+#include <sys/stat.h>
+
+#include "pidfd.h"
+#include "../kselftest_harness.h"
+
+FIXTURE(pidfd_info)
+{
+	pid_t child_pid1;
+	int child_pidfd1;
+
+	pid_t child_pid2;
+	int child_pidfd2;
+
+	pid_t child_pid3;
+	int child_pidfd3;
+
+	pid_t child_pid4;
+	int child_pidfd4;
+};
+
+FIXTURE_SETUP(pidfd_info)
+{
+	int ret;
+	int ipc_sockets[2];
+	char c;
+
+	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	EXPECT_EQ(ret, 0);
+
+	self->child_pid1 = create_child(&self->child_pidfd1, 0);
+	EXPECT_GE(self->child_pid1, 0);
+
+	if (self->child_pid1 == 0) {
+		close(ipc_sockets[0]);
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			_exit(EXIT_FAILURE);
+
+		close(ipc_sockets[1]);
+
+		pause();
+		_exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	/* SIGKILL but don't reap. */
+	EXPECT_EQ(sys_pidfd_send_signal(self->child_pidfd1, SIGKILL, NULL, 0), 0);
+
+	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	EXPECT_EQ(ret, 0);
+
+	self->child_pid2 = create_child(&self->child_pidfd2, 0);
+	EXPECT_GE(self->child_pid2, 0);
+
+	if (self->child_pid2 == 0) {
+		close(ipc_sockets[0]);
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			_exit(EXIT_FAILURE);
+
+		close(ipc_sockets[1]);
+
+		pause();
+		_exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	/* SIGKILL and reap. */
+	EXPECT_EQ(sys_pidfd_send_signal(self->child_pidfd2, SIGKILL, NULL, 0), 0);
+	EXPECT_EQ(sys_waitid(P_PID, self->child_pid2, NULL, WEXITED), 0);
+
+	self->child_pid3 = create_child(&self->child_pidfd3, CLONE_NEWUSER | CLONE_NEWPID);
+	EXPECT_GE(self->child_pid3, 0);
+
+	if (self->child_pid3 == 0)
+		_exit(EXIT_SUCCESS);
+
+	self->child_pid4 = create_child(&self->child_pidfd4, CLONE_NEWUSER | CLONE_NEWPID);
+	EXPECT_GE(self->child_pid4, 0);
+
+	if (self->child_pid4 == 0)
+		_exit(EXIT_SUCCESS);
+
+	EXPECT_EQ(sys_waitid(P_PID, self->child_pid4, NULL, WEXITED), 0);
+}
+
+FIXTURE_TEARDOWN(pidfd_info)
+{
+	sys_pidfd_send_signal(self->child_pidfd1, SIGKILL, NULL, 0);
+	if (self->child_pidfd1 >= 0)
+		EXPECT_EQ(0, close(self->child_pidfd1));
+
+	sys_waitid(P_PID, self->child_pid1, NULL, WEXITED);
+
+	sys_pidfd_send_signal(self->child_pidfd2, SIGKILL, NULL, 0);
+	if (self->child_pidfd2 >= 0)
+		EXPECT_EQ(0, close(self->child_pidfd2));
+
+	sys_waitid(P_PID, self->child_pid2, NULL, WEXITED);
+	sys_waitid(P_PID, self->child_pid3, NULL, WEXITED);
+	sys_waitid(P_PID, self->child_pid4, NULL, WEXITED);
+}
+
+TEST_F(pidfd_info, sigkill_exit)
+{
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_CGROUPID,
+	};
+
+	/* Process has exited but not been reaped so this must work. */
+	ASSERT_EQ(ioctl(self->child_pidfd1, PIDFD_GET_INFO, &info), 0);
+
+	info.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT;
+	ASSERT_EQ(ioctl(self->child_pidfd1, PIDFD_GET_INFO, &info), 0);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_CREDS));
+	/* Process has exited but not been reaped, so no PIDFD_INFO_EXIT information yet. */
+	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_EXIT));
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.2


