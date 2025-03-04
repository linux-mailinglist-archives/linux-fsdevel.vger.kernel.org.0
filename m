Return-Path: <linux-fsdevel+bounces-43066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989FFA4D92D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757DD3B86DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0371FECCD;
	Tue,  4 Mar 2025 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2Y0QMxZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23471FCF44
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081298; cv=none; b=Dgy4yjBnK1y5cwfv/rVs7XDG+RDTKBBZC7u+wnAS+Tj1AvfrcuqkQFMaoVu5IXt4DGWrBJIhISqUQaHWK2Dy4RwExcgIiE1iUtwrqa5MruHzoLP+c8irKunb9/0s6uSosa4x9aXN8nUthAczCOcZqK5r3FkTmPj9BUZ6EBNj5Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081298; c=relaxed/simple;
	bh=VbhTqeaRLkm4FVHnB2shDFKLyYt42RFHeFtvkr9tcHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BTzLn/p6S7vXj3A6xnsx6eK6g1dTBiprJ3A5lCbdOoskSM6QeTsvU6ff2wmY7s71sTxl+dsqHZVFA2mnLcKAL5GGOgpHnqD2V5bkNFn8gL3JhZHs8FLI/s5zQIn9nmabJ/JvLa5WLBc2F9+J0Taj5/ax9BI4C32wG9V1SuW86sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2Y0QMxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D88C4CEE5;
	Tue,  4 Mar 2025 09:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081297;
	bh=VbhTqeaRLkm4FVHnB2shDFKLyYt42RFHeFtvkr9tcHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O2Y0QMxZpvYctd3rbZBBv7ebJhGv45vkBYA+mfNmobJJuDlYlqNuCLxaCbcIReFeP
	 O2tA1SYuJZz/8BqaGMliHTOEixByJ1tCnF+/zjnjjF0j2ALmdBGcMi0m0JlABijclb
	 N4EDdXvfkC9jQbIRfC7ioYfhOgSD12c14P4tLVkakt6NN4shro8kYjWYtoxEWsz7dD
	 N+TB4d2xMqt6vDl+nR4DAwVZOeSS3ZVu09xWzs8kZ8y5iJT47G1tdp7NMfEiSKMv1U
	 Yqfct+9pdb+R7OvH4k85gDYjFZmghINFNrOoDZdb4OGvYuaqlGoPKVj2V1xGtQPxiI
	 zO1uFPKacjxPQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:10 +0100
Subject: [PATCH v2 10/15] selftests/pidfd: add first PIDFD_INFO_EXIT
 selftest
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-10-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=6086; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VbhTqeaRLkm4FVHnB2shDFKLyYt42RFHeFtvkr9tcHI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7X77gOjy0l6XA5z5Aq+Z6nN+iL/6ETK/NZNByXEL
 6vnzA+b1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRB4YM/yy9JszqzmD/u37X
 ZPuPGZsYHE7qHxMtebnsHOO/twsEb71mZLjZmKfiqjDLge3FwittgrpdpbmzTlqtWad04Gd9kcF
 hZh4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a selftest for PIDFD_INFO_EXIT behavior.

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


