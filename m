Return-Path: <linux-fsdevel+bounces-42853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DA4A499B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 13:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161CF188FC46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 12:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D37826D5DD;
	Fri, 28 Feb 2025 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVvp0dI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4026B2A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746680; cv=none; b=LEdNg3N848PHgoX6BQTV1rnkCFJduZgMDmTBoSr38PEhvmJozOclwkjS2PWhtoOgvDMLhcjATXQSupR5Cl5d8Oq4M+QapcpMZdkek3iFccJP+gMTyyiVo3DgyTXjN6Kk/PP30K5GIoXhVmz/7AMXuP3uLfgbsHurjH3h7qq8SoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746680; c=relaxed/simple;
	bh=f7P6OUeEAvDGFqnznapWB8YeHZzAf5r70IdxbCqXrBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bcO4Nt5heC10ZzXG0JlpjgyqheOz/lRD8iowU8MOI4uu/eqDt6gZCGV82hVOSN9yyaEwanEs0V33mDoKjU52nK0TjSHlhHgLGKWZPolb6DHGr32k4phuWBS2IkLMNvG4rEJACzQl0y9Q1p6mmSk0qf+iEfGE4rvZoIRN4Ju5gVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVvp0dI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C09C4CEE7;
	Fri, 28 Feb 2025 12:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740746680;
	bh=f7P6OUeEAvDGFqnznapWB8YeHZzAf5r70IdxbCqXrBo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KVvp0dI4WPdYE8a8DffyNTrj7VLdG8YCVvRHIp9eXIR6uChajSxIJSKijtTNwZPB+
	 ouAjaHED0GxapVR6fq/C8K35l4Ht5eUNuhX5dwSwZebss2q2gnheA5vW82LA1qgfa4
	 17omRELwvvaxE1jqP/wsHdXImj2yYlJJY/fTg6LDp9JfW95JLFL38LD6E3Y15y/UxM
	 mqdN8JfSGa0WktqmAF5gwD5KcMJnW4pPCB3XJPJPKGcerTRmLMMbcEEgGs5/aoPKtk
	 9LL3UabxNzifaxtfpeuoaj2W23j1Aa+RVkroyDx7JUb1pVnhIq504lLjDRyN6H5CL3
	 AgGFr4mm0VYzg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 28 Feb 2025 13:44:10 +0100
Subject: [PATCH RFC 10/10] selftests/pidfd: add PIDFD_INFO_EXIT tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-work-pidfs-kill_on_last_close-v1-10-5bd7e6bb428e@kernel.org>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
In-Reply-To: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=7121; i=brauner@kernel.org;
 h=from:subject:message-id; bh=f7P6OUeEAvDGFqnznapWB8YeHZzAf5r70IdxbCqXrBo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfXL/IXHpu8PHFylMerKvdvGbyvi0VLWsndRvP2Fl33
 lGgt5YhqaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiKgKMDP0mXO3t+Zo89872
 VdxOcWFOu6zlZ8/h9ojDtrD3bdJ6QUaGJ7M5w3z9XjHP2+bC/HVy0dkz3Nz7/xvEKN/Mjv3ofZy
 fBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that PIDFD_INFO_EXIT works correctly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/.gitignore        |   1 +
 tools/testing/selftests/pidfd/Makefile          |   2 +-
 tools/testing/selftests/pidfd/pidfd.h           |   6 +-
 tools/testing/selftests/pidfd/pidfd_info_test.c | 185 ++++++++++++++++++++++++
 4 files changed, 192 insertions(+), 2 deletions(-)

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
index 000000000000..e2368ba271fb
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/types.h>
+#include <poll.h>
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
+		.mask = PIDFD_INFO_EXIT,
+	};
+
+	ASSERT_EQ(ioctl(self->child_pidfd1, PIDFD_GET_INFO, &info), 0);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_CREDS));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
+	ASSERT_TRUE(WIFSIGNALED(info.exit_code));
+	ASSERT_EQ(WTERMSIG(info.exit_code), SIGKILL);
+}
+
+TEST_F(pidfd_info, sigkill_reaped)
+{
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_CGROUPID,
+		.mask = PIDFD_INFO_EXIT,
+	};
+
+	ASSERT_EQ(ioctl(self->child_pidfd2, PIDFD_GET_INFO, &info), 0);
+	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_CREDS));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
+	ASSERT_TRUE(WIFSIGNALED(info.exit_code));
+	ASSERT_EQ(WTERMSIG(info.exit_code), SIGKILL);
+}
+
+TEST_F(pidfd_info, success_exit)
+{
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_CGROUPID,
+		.mask = PIDFD_INFO_EXIT,
+	};
+
+	ASSERT_EQ(ioctl(self->child_pidfd3, PIDFD_GET_INFO, &info), 0);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_CREDS));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
+	ASSERT_TRUE(WIFEXITED(info.exit_code));
+	ASSERT_EQ(WEXITSTATUS(info.exit_code), 0);
+}
+
+TEST_F(pidfd_info, success_reaped)
+{
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_CGROUPID,
+		.mask = PIDFD_INFO_EXIT,
+	};
+
+	ASSERT_EQ(ioctl(self->child_pidfd4, PIDFD_GET_INFO, &info), 0);
+	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_CREDS));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
+	ASSERT_TRUE(WIFEXITED(info.exit_code));
+	ASSERT_EQ(WEXITSTATUS(info.exit_code), 0);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.2


