Return-Path: <linux-fsdevel+bounces-61077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BA1B54CBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E632A3B9122
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B906D3568F1;
	Fri, 12 Sep 2025 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ef+FOTLm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC83090D4;
	Fri, 12 Sep 2025 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678167; cv=none; b=HKoYl2LePMQzEYcVKkMWXiOR6EiFJoNpK7Rro/LMDy/g3bVenEGFt2pPXAtvGKUngaVHUyjoGM9ShQ1rQjKUTl/RI7v41LdFCDzYogLwhJ5FQ7c1wxPo3gUZHzIiKJOrSzvmdV5d4h8SYAbLYKHh+EPLc9YLeG7DLKLE4LYpXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678167; c=relaxed/simple;
	bh=pSvB6NT/ZaRp29mjjp+z4cgjXclmpbfs/Rcmmhtea88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gL7rpW2o/OZQKE4JTNoeWZIVMMueFdOLyBioOuQH6X0yrhUb/1TzkMMIIpFxgqwLUptSXRiF9IVGR+Xb87GuPe6mZkkYd/ugbL7xC69Zv5Z3ZxZ6gkVssgprH4baLPIz9FRyGb5zQRwy0cTqNuoAvljARwROrBNbFAkIcuQJ1tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ef+FOTLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4CFC4CEF4;
	Fri, 12 Sep 2025 11:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678166;
	bh=pSvB6NT/ZaRp29mjjp+z4cgjXclmpbfs/Rcmmhtea88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ef+FOTLmCNkAS4/h3waGVZzaBOXAgh19WS8yZk/3B8No2JcWL4qQRGNwQGXj3vrys
	 JeZRh5hCUFZqcIyATj9QFmDaE2xo2yBDFKh15t3W3VhdQo2yWRj8+5JvhEVvD6JAxm
	 q8osozs47vjoufD3UVcQCw573AgYwguiIOAeMTXSDq7wOeFxh+GV1IBSz277jCE7eC
	 O4WzzmZPn/bU6QFRXialQYlrgHmtaa0kGw0R2c6wdBEY3+kE0DOKGIwgHIB1XpQ+yX
	 KhdgHAlBKvDSO9Io+2dR53hRySSnhQr0j6Z7502cbzcS7fOSMLcX/GSj0uNxlCGRP9
	 Ndsa9pSmI4OtQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:55 +0200
Subject: [PATCH v2 32/33] selftests/namespaces: add identifier selftests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-32-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=26294; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pSvB6NT/ZaRp29mjjp+z4cgjXclmpbfs/Rcmmhtea88=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZxWoiW3JvBrh2uWVePTNXP8PhYsfXqQh++v7+d9s
 5Z9Xe5d21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR8GZGhiN+H8TNg26GF0fm
 N3MXnzepmlV/vVJE6mYp+9xqHzf3jwz/nWNXvp4yrSLxspJG+aJtpw5l8p2Zs237B9Etn3OUXgU
 18wIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a bunch of selftests for the identifier retrieval ioctls.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/.gitignore  |   1 +
 tools/testing/selftests/namespaces/Makefile    |   7 +
 tools/testing/selftests/namespaces/config      |   7 +
 tools/testing/selftests/namespaces/nsid_test.c | 986 +++++++++++++++++++++++++
 4 files changed, 1001 insertions(+)

diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testing/selftests/namespaces/.gitignore
new file mode 100644
index 000000000000..c1e8d634dd21
--- /dev/null
+++ b/tools/testing/selftests/namespaces/.gitignore
@@ -0,0 +1 @@
+nsid_test
diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/selftests/namespaces/Makefile
new file mode 100644
index 000000000000..9280c703533e
--- /dev/null
+++ b/tools/testing/selftests/namespaces/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+
+TEST_GEN_PROGS := nsid_test
+
+include ../lib.mk
+
diff --git a/tools/testing/selftests/namespaces/config b/tools/testing/selftests/namespaces/config
new file mode 100644
index 000000000000..d09836260262
--- /dev/null
+++ b/tools/testing/selftests/namespaces/config
@@ -0,0 +1,7 @@
+CONFIG_UTS_NS=y
+CONFIG_TIME_NS=y
+CONFIG_IPC_NS=y
+CONFIG_USER_NS=y
+CONFIG_PID_NS=y
+CONFIG_NET_NS=y
+CONFIG_CGROUPS=y
diff --git a/tools/testing/selftests/namespaces/nsid_test.c b/tools/testing/selftests/namespaces/nsid_test.c
new file mode 100644
index 000000000000..e28accd74a57
--- /dev/null
+++ b/tools/testing/selftests/namespaces/nsid_test.c
@@ -0,0 +1,986 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <assert.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <libgen.h>
+#include <limits.h>
+#include <pthread.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <poll.h>
+#include <sys/epoll.h>
+#include <sys/resource.h>
+#include <sys/stat.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+#include <linux/fs.h>
+#include <linux/limits.h>
+#include <linux/nsfs.h>
+#include "../kselftest_harness.h"
+
+TEST(nsid_mntns_basic)
+{
+	__u64 mnt_ns_id = 0;
+	int fd_mntns;
+	int ret;
+
+	/* Open the current mount namespace */
+	fd_mntns = open("/proc/self/ns/mnt", O_RDONLY);
+	ASSERT_GE(fd_mntns, 0);
+
+	/* Get the mount namespace ID */
+	ret = ioctl(fd_mntns, NS_GET_MNTNS_ID, &mnt_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(mnt_ns_id, 0);
+
+	/* Verify we can get the same ID again */
+	__u64 mnt_ns_id2 = 0;
+	ret = ioctl(fd_mntns, NS_GET_ID, &mnt_ns_id2);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(mnt_ns_id, mnt_ns_id2);
+
+	close(fd_mntns);
+}
+
+TEST(nsid_mntns_separate)
+{
+	__u64 parent_mnt_ns_id = 0;
+	__u64 child_mnt_ns_id = 0;
+	int fd_parent_mntns, fd_child_mntns;
+	int ret;
+	pid_t pid;
+	int pipefd[2];
+
+	/* Get parent's mount namespace ID */
+	fd_parent_mntns = open("/proc/self/ns/mnt", O_RDONLY);
+	ASSERT_GE(fd_parent_mntns, 0);
+	ret = ioctl(fd_parent_mntns, NS_GET_ID, &parent_mnt_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(parent_mnt_ns_id, 0);
+
+	/* Create a pipe for synchronization */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* Create new mount namespace */
+		ret = unshare(CLONE_NEWNS);
+		if (ret != 0) {
+			/* Skip test if we don't have permission */
+			if (errno == EPERM || errno == EACCES) {
+				write(pipefd[1], "S", 1); /* Signal skip */
+				_exit(0);
+			}
+			_exit(1);
+		}
+
+		/* Signal success */
+		write(pipefd[1], "Y", 1);
+		close(pipefd[1]);
+
+		/* Keep namespace alive */
+		pause();
+		_exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	char buf;
+	ASSERT_EQ(read(pipefd[0], &buf, 1), 1);
+	close(pipefd[0]);
+
+	if (buf == 'S') {
+		/* Child couldn't create namespace, skip test */
+		kill(pid, SIGTERM);
+		waitpid(pid, NULL, 0);
+		close(fd_parent_mntns);
+		SKIP(return, "No permission to create mount namespace");
+	}
+
+	ASSERT_EQ(buf, 'Y');
+
+	/* Open child's mount namespace */
+	char path[256];
+	snprintf(path, sizeof(path), "/proc/%d/ns/mnt", pid);
+	fd_child_mntns = open(path, O_RDONLY);
+	ASSERT_GE(fd_child_mntns, 0);
+
+	/* Get child's mount namespace ID */
+	ret = ioctl(fd_child_mntns, NS_GET_ID, &child_mnt_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(child_mnt_ns_id, 0);
+
+	/* Parent and child should have different mount namespace IDs */
+	ASSERT_NE(parent_mnt_ns_id, child_mnt_ns_id);
+
+	close(fd_parent_mntns);
+	close(fd_child_mntns);
+
+	/* Clean up child process */
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+}
+
+TEST(nsid_cgroupns_basic)
+{
+	__u64 cgroup_ns_id = 0;
+	int fd_cgroupns;
+	int ret;
+
+	/* Open the current cgroup namespace */
+	fd_cgroupns = open("/proc/self/ns/cgroup", O_RDONLY);
+	ASSERT_GE(fd_cgroupns, 0);
+
+	/* Get the cgroup namespace ID */
+	ret = ioctl(fd_cgroupns, NS_GET_ID, &cgroup_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(cgroup_ns_id, 0);
+
+	/* Verify we can get the same ID again */
+	__u64 cgroup_ns_id2 = 0;
+	ret = ioctl(fd_cgroupns, NS_GET_ID, &cgroup_ns_id2);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(cgroup_ns_id, cgroup_ns_id2);
+
+	close(fd_cgroupns);
+}
+
+TEST(nsid_cgroupns_separate)
+{
+	__u64 parent_cgroup_ns_id = 0;
+	__u64 child_cgroup_ns_id = 0;
+	int fd_parent_cgroupns, fd_child_cgroupns;
+	int ret;
+	pid_t pid;
+	int pipefd[2];
+
+	/* Get parent's cgroup namespace ID */
+	fd_parent_cgroupns = open("/proc/self/ns/cgroup", O_RDONLY);
+	ASSERT_GE(fd_parent_cgroupns, 0);
+	ret = ioctl(fd_parent_cgroupns, NS_GET_ID, &parent_cgroup_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(parent_cgroup_ns_id, 0);
+
+	/* Create a pipe for synchronization */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* Create new cgroup namespace */
+		ret = unshare(CLONE_NEWCGROUP);
+		if (ret != 0) {
+			/* Skip test if we don't have permission */
+			if (errno == EPERM || errno == EACCES) {
+				write(pipefd[1], "S", 1); /* Signal skip */
+				_exit(0);
+			}
+			_exit(1);
+		}
+
+		/* Signal success */
+		write(pipefd[1], "Y", 1);
+		close(pipefd[1]);
+
+		/* Keep namespace alive */
+		pause();
+		_exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	char buf;
+	ASSERT_EQ(read(pipefd[0], &buf, 1), 1);
+	close(pipefd[0]);
+
+	if (buf == 'S') {
+		/* Child couldn't create namespace, skip test */
+		kill(pid, SIGTERM);
+		waitpid(pid, NULL, 0);
+		close(fd_parent_cgroupns);
+		SKIP(return, "No permission to create cgroup namespace");
+	}
+
+	ASSERT_EQ(buf, 'Y');
+
+	/* Open child's cgroup namespace */
+	char path[256];
+	snprintf(path, sizeof(path), "/proc/%d/ns/cgroup", pid);
+	fd_child_cgroupns = open(path, O_RDONLY);
+	ASSERT_GE(fd_child_cgroupns, 0);
+
+	/* Get child's cgroup namespace ID */
+	ret = ioctl(fd_child_cgroupns, NS_GET_ID, &child_cgroup_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(child_cgroup_ns_id, 0);
+
+	/* Parent and child should have different cgroup namespace IDs */
+	ASSERT_NE(parent_cgroup_ns_id, child_cgroup_ns_id);
+
+	close(fd_parent_cgroupns);
+	close(fd_child_cgroupns);
+
+	/* Clean up child process */
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+}
+
+TEST(nsid_ipcns_basic)
+{
+	__u64 ipc_ns_id = 0;
+	int fd_ipcns;
+	int ret;
+
+	/* Open the current IPC namespace */
+	fd_ipcns = open("/proc/self/ns/ipc", O_RDONLY);
+	ASSERT_GE(fd_ipcns, 0);
+
+	/* Get the IPC namespace ID */
+	ret = ioctl(fd_ipcns, NS_GET_ID, &ipc_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(ipc_ns_id, 0);
+
+	/* Verify we can get the same ID again */
+	__u64 ipc_ns_id2 = 0;
+	ret = ioctl(fd_ipcns, NS_GET_ID, &ipc_ns_id2);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(ipc_ns_id, ipc_ns_id2);
+
+	close(fd_ipcns);
+}
+
+TEST(nsid_ipcns_separate)
+{
+	__u64 parent_ipc_ns_id = 0;
+	__u64 child_ipc_ns_id = 0;
+	int fd_parent_ipcns, fd_child_ipcns;
+	int ret;
+	pid_t pid;
+	int pipefd[2];
+
+	/* Get parent's IPC namespace ID */
+	fd_parent_ipcns = open("/proc/self/ns/ipc", O_RDONLY);
+	ASSERT_GE(fd_parent_ipcns, 0);
+	ret = ioctl(fd_parent_ipcns, NS_GET_ID, &parent_ipc_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(parent_ipc_ns_id, 0);
+
+	/* Create a pipe for synchronization */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* Create new IPC namespace */
+		ret = unshare(CLONE_NEWIPC);
+		if (ret != 0) {
+			/* Skip test if we don't have permission */
+			if (errno == EPERM || errno == EACCES) {
+				write(pipefd[1], "S", 1); /* Signal skip */
+				_exit(0);
+			}
+			_exit(1);
+		}
+
+		/* Signal success */
+		write(pipefd[1], "Y", 1);
+		close(pipefd[1]);
+
+		/* Keep namespace alive */
+		pause();
+		_exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	char buf;
+	ASSERT_EQ(read(pipefd[0], &buf, 1), 1);
+	close(pipefd[0]);
+
+	if (buf == 'S') {
+		/* Child couldn't create namespace, skip test */
+		kill(pid, SIGTERM);
+		waitpid(pid, NULL, 0);
+		close(fd_parent_ipcns);
+		SKIP(return, "No permission to create IPC namespace");
+	}
+
+	ASSERT_EQ(buf, 'Y');
+
+	/* Open child's IPC namespace */
+	char path[256];
+	snprintf(path, sizeof(path), "/proc/%d/ns/ipc", pid);
+	fd_child_ipcns = open(path, O_RDONLY);
+	ASSERT_GE(fd_child_ipcns, 0);
+
+	/* Get child's IPC namespace ID */
+	ret = ioctl(fd_child_ipcns, NS_GET_ID, &child_ipc_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(child_ipc_ns_id, 0);
+
+	/* Parent and child should have different IPC namespace IDs */
+	ASSERT_NE(parent_ipc_ns_id, child_ipc_ns_id);
+
+	close(fd_parent_ipcns);
+	close(fd_child_ipcns);
+
+	/* Clean up child process */
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+}
+
+TEST(nsid_utsns_basic)
+{
+	__u64 uts_ns_id = 0;
+	int fd_utsns;
+	int ret;
+
+	/* Open the current UTS namespace */
+	fd_utsns = open("/proc/self/ns/uts", O_RDONLY);
+	ASSERT_GE(fd_utsns, 0);
+
+	/* Get the UTS namespace ID */
+	ret = ioctl(fd_utsns, NS_GET_ID, &uts_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(uts_ns_id, 0);
+
+	/* Verify we can get the same ID again */
+	__u64 uts_ns_id2 = 0;
+	ret = ioctl(fd_utsns, NS_GET_ID, &uts_ns_id2);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(uts_ns_id, uts_ns_id2);
+
+	close(fd_utsns);
+}
+
+TEST(nsid_utsns_separate)
+{
+	__u64 parent_uts_ns_id = 0;
+	__u64 child_uts_ns_id = 0;
+	int fd_parent_utsns, fd_child_utsns;
+	int ret;
+	pid_t pid;
+	int pipefd[2];
+
+	/* Get parent's UTS namespace ID */
+	fd_parent_utsns = open("/proc/self/ns/uts", O_RDONLY);
+	ASSERT_GE(fd_parent_utsns, 0);
+	ret = ioctl(fd_parent_utsns, NS_GET_ID, &parent_uts_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(parent_uts_ns_id, 0);
+
+	/* Create a pipe for synchronization */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* Create new UTS namespace */
+		ret = unshare(CLONE_NEWUTS);
+		if (ret != 0) {
+			/* Skip test if we don't have permission */
+			if (errno == EPERM || errno == EACCES) {
+				write(pipefd[1], "S", 1); /* Signal skip */
+				_exit(0);
+			}
+			_exit(1);
+		}
+
+		/* Signal success */
+		write(pipefd[1], "Y", 1);
+		close(pipefd[1]);
+
+		/* Keep namespace alive */
+		pause();
+		_exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	char buf;
+	ASSERT_EQ(read(pipefd[0], &buf, 1), 1);
+	close(pipefd[0]);
+
+	if (buf == 'S') {
+		/* Child couldn't create namespace, skip test */
+		kill(pid, SIGTERM);
+		waitpid(pid, NULL, 0);
+		close(fd_parent_utsns);
+		SKIP(return, "No permission to create UTS namespace");
+	}
+
+	ASSERT_EQ(buf, 'Y');
+
+	/* Open child's UTS namespace */
+	char path[256];
+	snprintf(path, sizeof(path), "/proc/%d/ns/uts", pid);
+	fd_child_utsns = open(path, O_RDONLY);
+	ASSERT_GE(fd_child_utsns, 0);
+
+	/* Get child's UTS namespace ID */
+	ret = ioctl(fd_child_utsns, NS_GET_ID, &child_uts_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(child_uts_ns_id, 0);
+
+	/* Parent and child should have different UTS namespace IDs */
+	ASSERT_NE(parent_uts_ns_id, child_uts_ns_id);
+
+	close(fd_parent_utsns);
+	close(fd_child_utsns);
+
+	/* Clean up child process */
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+}
+
+TEST(nsid_userns_basic)
+{
+	__u64 user_ns_id = 0;
+	int fd_userns;
+	int ret;
+
+	/* Open the current user namespace */
+	fd_userns = open("/proc/self/ns/user", O_RDONLY);
+	ASSERT_GE(fd_userns, 0);
+
+	/* Get the user namespace ID */
+	ret = ioctl(fd_userns, NS_GET_ID, &user_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(user_ns_id, 0);
+
+	/* Verify we can get the same ID again */
+	__u64 user_ns_id2 = 0;
+	ret = ioctl(fd_userns, NS_GET_ID, &user_ns_id2);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(user_ns_id, user_ns_id2);
+
+	close(fd_userns);
+}
+
+TEST(nsid_userns_separate)
+{
+	__u64 parent_user_ns_id = 0;
+	__u64 child_user_ns_id = 0;
+	int fd_parent_userns, fd_child_userns;
+	int ret;
+	pid_t pid;
+	int pipefd[2];
+
+	/* Get parent's user namespace ID */
+	fd_parent_userns = open("/proc/self/ns/user", O_RDONLY);
+	ASSERT_GE(fd_parent_userns, 0);
+	ret = ioctl(fd_parent_userns, NS_GET_ID, &parent_user_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(parent_user_ns_id, 0);
+
+	/* Create a pipe for synchronization */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* Create new user namespace */
+		ret = unshare(CLONE_NEWUSER);
+		if (ret != 0) {
+			/* Skip test if we don't have permission */
+			if (errno == EPERM || errno == EACCES) {
+				write(pipefd[1], "S", 1); /* Signal skip */
+				_exit(0);
+			}
+			_exit(1);
+		}
+
+		/* Signal success */
+		write(pipefd[1], "Y", 1);
+		close(pipefd[1]);
+
+		/* Keep namespace alive */
+		pause();
+		_exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	char buf;
+	ASSERT_EQ(read(pipefd[0], &buf, 1), 1);
+	close(pipefd[0]);
+
+	if (buf == 'S') {
+		/* Child couldn't create namespace, skip test */
+		kill(pid, SIGTERM);
+		waitpid(pid, NULL, 0);
+		close(fd_parent_userns);
+		SKIP(return, "No permission to create user namespace");
+	}
+
+	ASSERT_EQ(buf, 'Y');
+
+	/* Open child's user namespace */
+	char path[256];
+	snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
+	fd_child_userns = open(path, O_RDONLY);
+	ASSERT_GE(fd_child_userns, 0);
+
+	/* Get child's user namespace ID */
+	ret = ioctl(fd_child_userns, NS_GET_ID, &child_user_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(child_user_ns_id, 0);
+
+	/* Parent and child should have different user namespace IDs */
+	ASSERT_NE(parent_user_ns_id, child_user_ns_id);
+
+	close(fd_parent_userns);
+	close(fd_child_userns);
+
+	/* Clean up child process */
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+}
+
+TEST(nsid_timens_basic)
+{
+	__u64 time_ns_id = 0;
+	int fd_timens;
+	int ret;
+
+	/* Open the current time namespace */
+	fd_timens = open("/proc/self/ns/time", O_RDONLY);
+	if (fd_timens < 0) {
+		SKIP(return, "Time namespaces not supported");
+	}
+
+	/* Get the time namespace ID */
+	ret = ioctl(fd_timens, NS_GET_ID, &time_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(time_ns_id, 0);
+
+	/* Verify we can get the same ID again */
+	__u64 time_ns_id2 = 0;
+	ret = ioctl(fd_timens, NS_GET_ID, &time_ns_id2);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(time_ns_id, time_ns_id2);
+
+	close(fd_timens);
+}
+
+TEST(nsid_timens_separate)
+{
+	__u64 parent_time_ns_id = 0;
+	__u64 child_time_ns_id = 0;
+	int fd_parent_timens, fd_child_timens;
+	int ret;
+	pid_t pid;
+	int pipefd[2];
+
+	/* Open the current time namespace */
+	fd_parent_timens = open("/proc/self/ns/time", O_RDONLY);
+	if (fd_parent_timens < 0) {
+		SKIP(return, "Time namespaces not supported");
+	}
+
+	/* Get parent's time namespace ID */
+	ret = ioctl(fd_parent_timens, NS_GET_ID, &parent_time_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(parent_time_ns_id, 0);
+
+	/* Create a pipe for synchronization */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* Create new time namespace */
+		ret = unshare(CLONE_NEWTIME);
+		if (ret != 0) {
+			/* Skip test if we don't have permission */
+			if (errno == EPERM || errno == EACCES || errno == EINVAL) {
+				write(pipefd[1], "S", 1); /* Signal skip */
+				_exit(0);
+			}
+			_exit(1);
+		}
+
+		/* Fork a grandchild to actually enter the new namespace */
+		pid_t grandchild = fork();
+		if (grandchild == 0) {
+			/* Grandchild is in the new namespace */
+			write(pipefd[1], "Y", 1);
+			close(pipefd[1]);
+			pause();
+			_exit(0);
+		} else if (grandchild > 0) {
+			/* Child writes grandchild PID and waits */
+			write(pipefd[1], "Y", 1);
+			write(pipefd[1], &grandchild, sizeof(grandchild));
+			close(pipefd[1]);
+			pause(); /* Keep the parent alive to maintain the grandchild */
+			_exit(0);
+		} else {
+			_exit(1);
+		}
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	char buf;
+	ASSERT_EQ(read(pipefd[0], &buf, 1), 1);
+
+	if (buf == 'S') {
+		/* Child couldn't create namespace, skip test */
+		kill(pid, SIGTERM);
+		waitpid(pid, NULL, 0);
+		close(fd_parent_timens);
+		close(pipefd[0]);
+		SKIP(return, "Cannot create time namespace");
+	}
+
+	ASSERT_EQ(buf, 'Y');
+
+	pid_t grandchild_pid;
+	ASSERT_EQ(read(pipefd[0], &grandchild_pid, sizeof(grandchild_pid)), sizeof(grandchild_pid));
+	close(pipefd[0]);
+
+	/* Open grandchild's time namespace */
+	char path[256];
+	snprintf(path, sizeof(path), "/proc/%d/ns/time", grandchild_pid);
+	fd_child_timens = open(path, O_RDONLY);
+	ASSERT_GE(fd_child_timens, 0);
+
+	/* Get child's time namespace ID */
+	ret = ioctl(fd_child_timens, NS_GET_ID, &child_time_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(child_time_ns_id, 0);
+
+	/* Parent and child should have different time namespace IDs */
+	ASSERT_NE(parent_time_ns_id, child_time_ns_id);
+
+	close(fd_parent_timens);
+	close(fd_child_timens);
+
+	/* Clean up child process */
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+}
+
+TEST(nsid_pidns_basic)
+{
+	__u64 pid_ns_id = 0;
+	int fd_pidns;
+	int ret;
+
+	/* Open the current PID namespace */
+	fd_pidns = open("/proc/self/ns/pid", O_RDONLY);
+	ASSERT_GE(fd_pidns, 0);
+
+	/* Get the PID namespace ID */
+	ret = ioctl(fd_pidns, NS_GET_ID, &pid_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(pid_ns_id, 0);
+
+	/* Verify we can get the same ID again */
+	__u64 pid_ns_id2 = 0;
+	ret = ioctl(fd_pidns, NS_GET_ID, &pid_ns_id2);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(pid_ns_id, pid_ns_id2);
+
+	close(fd_pidns);
+}
+
+TEST(nsid_pidns_separate)
+{
+	__u64 parent_pid_ns_id = 0;
+	__u64 child_pid_ns_id = 0;
+	int fd_parent_pidns, fd_child_pidns;
+	int ret;
+	pid_t pid;
+	int pipefd[2];
+
+	/* Get parent's PID namespace ID */
+	fd_parent_pidns = open("/proc/self/ns/pid", O_RDONLY);
+	ASSERT_GE(fd_parent_pidns, 0);
+	ret = ioctl(fd_parent_pidns, NS_GET_ID, &parent_pid_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(parent_pid_ns_id, 0);
+
+	/* Create a pipe for synchronization */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* Create new PID namespace */
+		ret = unshare(CLONE_NEWPID);
+		if (ret != 0) {
+			/* Skip test if we don't have permission */
+			if (errno == EPERM || errno == EACCES) {
+				write(pipefd[1], "S", 1); /* Signal skip */
+				_exit(0);
+			}
+			_exit(1);
+		}
+
+		/* Fork a grandchild to actually enter the new namespace */
+		pid_t grandchild = fork();
+		if (grandchild == 0) {
+			/* Grandchild is in the new namespace */
+			write(pipefd[1], "Y", 1);
+			close(pipefd[1]);
+			pause();
+			_exit(0);
+		} else if (grandchild > 0) {
+			/* Child writes grandchild PID and waits */
+			write(pipefd[1], "Y", 1);
+			write(pipefd[1], &grandchild, sizeof(grandchild));
+			close(pipefd[1]);
+			pause(); /* Keep the parent alive to maintain the grandchild */
+			_exit(0);
+		} else {
+			_exit(1);
+		}
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	char buf;
+	ASSERT_EQ(read(pipefd[0], &buf, 1), 1);
+
+	if (buf == 'S') {
+		/* Child couldn't create namespace, skip test */
+		kill(pid, SIGTERM);
+		waitpid(pid, NULL, 0);
+		close(fd_parent_pidns);
+		close(pipefd[0]);
+		SKIP(return, "No permission to create PID namespace");
+	}
+
+	ASSERT_EQ(buf, 'Y');
+
+	pid_t grandchild_pid;
+	ASSERT_EQ(read(pipefd[0], &grandchild_pid, sizeof(grandchild_pid)), sizeof(grandchild_pid));
+	close(pipefd[0]);
+
+	/* Open grandchild's PID namespace */
+	char path[256];
+	snprintf(path, sizeof(path), "/proc/%d/ns/pid", grandchild_pid);
+	fd_child_pidns = open(path, O_RDONLY);
+	ASSERT_GE(fd_child_pidns, 0);
+
+	/* Get child's PID namespace ID */
+	ret = ioctl(fd_child_pidns, NS_GET_ID, &child_pid_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(child_pid_ns_id, 0);
+
+	/* Parent and child should have different PID namespace IDs */
+	ASSERT_NE(parent_pid_ns_id, child_pid_ns_id);
+
+	close(fd_parent_pidns);
+	close(fd_child_pidns);
+
+	/* Clean up child process */
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+}
+
+TEST(nsid_netns_basic)
+{
+	__u64 net_ns_id = 0;
+	__u64 netns_cookie = 0;
+	int fd_netns;
+	int sock;
+	socklen_t optlen;
+	int ret;
+
+	/* Open the current network namespace */
+	fd_netns = open("/proc/self/ns/net", O_RDONLY);
+	ASSERT_GE(fd_netns, 0);
+
+	/* Get the network namespace ID via ioctl */
+	ret = ioctl(fd_netns, NS_GET_ID, &net_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(net_ns_id, 0);
+
+	/* Create a socket to get the SO_NETNS_COOKIE */
+	sock = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_GE(sock, 0);
+
+	/* Get the network namespace cookie via socket option */
+	optlen = sizeof(netns_cookie);
+	ret = getsockopt(sock, SOL_SOCKET, SO_NETNS_COOKIE, &netns_cookie, &optlen);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(optlen, sizeof(netns_cookie));
+
+	/* The namespace ID and cookie should be identical */
+	ASSERT_EQ(net_ns_id, netns_cookie);
+
+	/* Verify we can get the same ID again */
+	__u64 net_ns_id2 = 0;
+	ret = ioctl(fd_netns, NS_GET_ID, &net_ns_id2);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(net_ns_id, net_ns_id2);
+
+	close(sock);
+	close(fd_netns);
+}
+
+TEST(nsid_netns_separate)
+{
+	__u64 parent_net_ns_id = 0;
+	__u64 parent_netns_cookie = 0;
+	__u64 child_net_ns_id = 0;
+	__u64 child_netns_cookie = 0;
+	int fd_parent_netns, fd_child_netns;
+	int parent_sock, child_sock;
+	socklen_t optlen;
+	int ret;
+	pid_t pid;
+	int pipefd[2];
+
+	/* Get parent's network namespace ID */
+	fd_parent_netns = open("/proc/self/ns/net", O_RDONLY);
+	ASSERT_GE(fd_parent_netns, 0);
+	ret = ioctl(fd_parent_netns, NS_GET_ID, &parent_net_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(parent_net_ns_id, 0);
+
+	/* Get parent's network namespace cookie */
+	parent_sock = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_GE(parent_sock, 0);
+	optlen = sizeof(parent_netns_cookie);
+	ret = getsockopt(parent_sock, SOL_SOCKET, SO_NETNS_COOKIE, &parent_netns_cookie, &optlen);
+	ASSERT_EQ(ret, 0);
+
+	/* Verify parent's ID and cookie match */
+	ASSERT_EQ(parent_net_ns_id, parent_netns_cookie);
+
+	/* Create a pipe for synchronization */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* Create new network namespace */
+		ret = unshare(CLONE_NEWNET);
+		if (ret != 0) {
+			/* Skip test if we don't have permission */
+			if (errno == EPERM || errno == EACCES) {
+				write(pipefd[1], "S", 1); /* Signal skip */
+				_exit(0);
+			}
+			_exit(1);
+		}
+
+		/* Signal success */
+		write(pipefd[1], "Y", 1);
+		close(pipefd[1]);
+
+		/* Keep namespace alive */
+		pause();
+		_exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	char buf;
+	ASSERT_EQ(read(pipefd[0], &buf, 1), 1);
+	close(pipefd[0]);
+
+	if (buf == 'S') {
+		/* Child couldn't create namespace, skip test */
+		kill(pid, SIGTERM);
+		waitpid(pid, NULL, 0);
+		close(fd_parent_netns);
+		close(parent_sock);
+		SKIP(return, "No permission to create network namespace");
+	}
+
+	ASSERT_EQ(buf, 'Y');
+
+	/* Open child's network namespace */
+	char path[256];
+	snprintf(path, sizeof(path), "/proc/%d/ns/net", pid);
+	fd_child_netns = open(path, O_RDONLY);
+	ASSERT_GE(fd_child_netns, 0);
+
+	/* Get child's network namespace ID */
+	ret = ioctl(fd_child_netns, NS_GET_ID, &child_net_ns_id);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(child_net_ns_id, 0);
+
+	/* Create socket in child's namespace to get cookie */
+	ret = setns(fd_child_netns, CLONE_NEWNET);
+	if (ret == 0) {
+		child_sock = socket(AF_UNIX, SOCK_STREAM, 0);
+		ASSERT_GE(child_sock, 0);
+
+		optlen = sizeof(child_netns_cookie);
+		ret = getsockopt(child_sock, SOL_SOCKET, SO_NETNS_COOKIE, &child_netns_cookie, &optlen);
+		ASSERT_EQ(ret, 0);
+
+		/* Verify child's ID and cookie match */
+		ASSERT_EQ(child_net_ns_id, child_netns_cookie);
+
+		close(child_sock);
+
+		/* Return to parent namespace */
+		setns(fd_parent_netns, CLONE_NEWNET);
+	}
+
+	/* Parent and child should have different network namespace IDs */
+	ASSERT_NE(parent_net_ns_id, child_net_ns_id);
+	if (child_netns_cookie != 0) {
+		ASSERT_NE(parent_netns_cookie, child_netns_cookie);
+	}
+
+	close(fd_parent_netns);
+	close(fd_child_netns);
+	close(parent_sock);
+
+	/* Clean up child process */
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


