Return-Path: <linux-fsdevel+bounces-61078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6092CB54CC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AC23BFB28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7550235AAA5;
	Fri, 12 Sep 2025 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNX6XGjQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655A3090E8;
	Fri, 12 Sep 2025 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678172; cv=none; b=gX2JXVbHtjUFc3+NtT/szp5fV2D89Ovvg5cVeF81n2FRQBJa2oB3qMRu+zy+S3SIkeqzRDwrGj7uvKXOPFE2xa8MHqzCDHkwdQBvlncg44LZ41WcsYu4GiFKERhhTu6jh96/w6JkbqIk63CHOkI+LWR7fZPM9zu4x6G9tzN6eL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678172; c=relaxed/simple;
	bh=0lf69fcoJEVSbJRnzhG//sWj5zVzTHTOi+HnNmbRaIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/Wmmwx8XIEnUV+HiR1XhN5Da0m18+6GQAfi3VXdQKdyYoZXwIsE+9oNAObIlurNKaBVTYjq6a0YUahbjnATp65ssNGYz/+H85mSc41wv7d3mAMAa9lLETL4xx6ecDeFHXJz6gU007iSKDhCvxxu/9ACyB1PkWhD3CScQG8geXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNX6XGjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C619C4CEF7;
	Fri, 12 Sep 2025 11:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678172;
	bh=0lf69fcoJEVSbJRnzhG//sWj5zVzTHTOi+HnNmbRaIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CNX6XGjQ4jEDcOur/+nOItheDSMovqeL+TkE8WqG3hZO1ZDrz1i+xOk9TF/C6Dhk9
	 HmDoxF1nHzMzLQWhcswYRSxnalhSBYlZ8nKxgqsYbwyFr2lfFftPe31NlNDRHfCs94
	 OBBffHvMeF6qRoH3Zo3isqhBbGq7Xcpztihzv+A9c+PAUUyNARXSlYDK31Rqk561Ww
	 kSP1r+w0d92jmKiE0CKEljCMQ3R2RcQr/xji39NYoXoT5z2+O2L/WsiZIF5gtEQnOE
	 hJCKNMRjv2TFtd2XoL4swzemm3fw2JlL7q7jRYzGkOLkAN3o2zoWx1q07Xzfh8Q0iO
	 96io81cspw0qg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:56 +0200
Subject: [PATCH v2 33/33] selftests/namespaces: add file handle selftests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-33-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=40878; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0lf69fcoJEVSbJRnzhG//sWj5zVzTHTOi+HnNmbRaIw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zy20uxi5TZVKx6R6p13tM0Lz/7in/JgWap9d4cIz
 60pjQ2zOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbydwUjw96WH43XV+5WDraf
 yz9j+e26H1tN5ie9OLP7wJNjTQW/LjYzMrRZBD09YbRFcc2rq2yRt1eUT3BZ3nZn4a/+v3mHty5
 MzeUFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a bunch of selftests for namespace file handles.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/.gitignore      |    1 +
 tools/testing/selftests/namespaces/Makefile        |    2 +-
 .../selftests/namespaces/file_handle_test.c        | 1429 ++++++++++++++++++++
 3 files changed, 1431 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testing/selftests/namespaces/.gitignore
index c1e8d634dd21..7639dbf58bbf 100644
--- a/tools/testing/selftests/namespaces/.gitignore
+++ b/tools/testing/selftests/namespaces/.gitignore
@@ -1 +1,2 @@
 nsid_test
+file_handle_test
diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/selftests/namespaces/Makefile
index 9280c703533e..f6c117ce2c2b 100644
--- a/tools/testing/selftests/namespaces/Makefile
+++ b/tools/testing/selftests/namespaces/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 
-TEST_GEN_PROGS := nsid_test
+TEST_GEN_PROGS := nsid_test file_handle_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/namespaces/file_handle_test.c b/tools/testing/selftests/namespaces/file_handle_test.c
new file mode 100644
index 000000000000..f1bc5773f552
--- /dev/null
+++ b/tools/testing/selftests/namespaces/file_handle_test.c
@@ -0,0 +1,1429 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <grp.h>
+#include <limits.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <linux/unistd.h>
+#include "../kselftest_harness.h"
+
+#ifndef FD_NSFS_ROOT
+#define FD_NSFS_ROOT -10003 /* Root of the nsfs filesystem */
+#endif
+
+TEST(nsfs_net_handle)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	struct stat st1, st2;
+
+	/* Drop to unprivileged uid/gid */
+	ASSERT_EQ(setresgid(65534, 65534, 65534), 0); /* nogroup */
+	ASSERT_EQ(setresuid(65534, 65534, 65534), 0); /* nobody */
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Open a namespace file descriptor */
+	ns_fd = open("/proc/self/ns/net", O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+
+	/* Get handle for the namespace */
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	ASSERT_GT(handle->handle_bytes, 0);
+
+	/* Try to open using FD_NSFS_ROOT as unprivileged user */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (fd < 0 && (errno == EINVAL || errno == EOPNOTSUPP)) {
+		SKIP(free(handle); close(ns_fd);
+		     return,
+			   "open_by_handle_at with FD_NSFS_ROOT not supported");
+	}
+	if (fd < 0 && errno == EPERM) {
+		SKIP(free(handle); close(ns_fd);
+		     return,
+			   "Permission denied for unprivileged user (expected)");
+	}
+	ASSERT_GE(fd, 0);
+
+	/* Verify we opened the correct namespace */
+	ASSERT_EQ(fstat(ns_fd, &st1), 0);
+	ASSERT_EQ(fstat(fd, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+	ASSERT_EQ(st1.st_dev, st2.st_dev);
+
+	close(fd);
+	close(ns_fd);
+	free(handle);
+}
+
+TEST(nsfs_uts_handle)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	struct stat st1, st2;
+
+	/* Drop to unprivileged uid/gid */
+	ASSERT_EQ(setresgid(65534, 65534, 65534), 0); /* nogroup */
+	ASSERT_EQ(setresuid(65534, 65534, 65534), 0); /* nobody */
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Open UTS namespace file descriptor */
+	ns_fd = open("/proc/self/ns/uts", O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+
+	/* Get handle for the namespace */
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	ASSERT_GT(handle->handle_bytes, 0);
+
+	/* Try to open using FD_NSFS_ROOT */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (fd < 0 && (errno == EINVAL || errno == EOPNOTSUPP)) {
+		SKIP(free(handle); close(ns_fd);
+		     return,
+			   "open_by_handle_at with FD_NSFS_ROOT not supported");
+	}
+	ASSERT_GE(fd, 0);
+
+	/* Verify we opened the correct namespace */
+	ASSERT_EQ(fstat(ns_fd, &st1), 0);
+	ASSERT_EQ(fstat(fd, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+	ASSERT_EQ(st1.st_dev, st2.st_dev);
+
+	close(fd);
+	close(ns_fd);
+	free(handle);
+}
+
+TEST(nsfs_ipc_handle)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	struct stat st1, st2;
+
+	/* Drop to unprivileged uid/gid */
+	ASSERT_EQ(setresgid(65534, 65534, 65534), 0); /* nogroup */
+	ASSERT_EQ(setresuid(65534, 65534, 65534), 0); /* nobody */
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Open IPC namespace file descriptor */
+	ns_fd = open("/proc/self/ns/ipc", O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+
+	/* Get handle for the namespace */
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	ASSERT_GT(handle->handle_bytes, 0);
+
+	/* Try to open using FD_NSFS_ROOT */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (fd < 0 && (errno == EINVAL || errno == EOPNOTSUPP)) {
+		SKIP(free(handle); close(ns_fd);
+		     return,
+			   "open_by_handle_at with FD_NSFS_ROOT not supported");
+	}
+	ASSERT_GE(fd, 0);
+
+	/* Verify we opened the correct namespace */
+	ASSERT_EQ(fstat(ns_fd, &st1), 0);
+	ASSERT_EQ(fstat(fd, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+	ASSERT_EQ(st1.st_dev, st2.st_dev);
+
+	close(fd);
+	close(ns_fd);
+	free(handle);
+}
+
+TEST(nsfs_pid_handle)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	struct stat st1, st2;
+
+	/* Drop to unprivileged uid/gid */
+	ASSERT_EQ(setresgid(65534, 65534, 65534), 0); /* nogroup */
+	ASSERT_EQ(setresuid(65534, 65534, 65534), 0); /* nobody */
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Open PID namespace file descriptor */
+	ns_fd = open("/proc/self/ns/pid", O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+
+	/* Get handle for the namespace */
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	ASSERT_GT(handle->handle_bytes, 0);
+
+	/* Try to open using FD_NSFS_ROOT */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (fd < 0 && (errno == EINVAL || errno == EOPNOTSUPP)) {
+		SKIP(free(handle); close(ns_fd);
+		     return,
+			   "open_by_handle_at with FD_NSFS_ROOT not supported");
+	}
+	ASSERT_GE(fd, 0);
+
+	/* Verify we opened the correct namespace */
+	ASSERT_EQ(fstat(ns_fd, &st1), 0);
+	ASSERT_EQ(fstat(fd, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+	ASSERT_EQ(st1.st_dev, st2.st_dev);
+
+	close(fd);
+	close(ns_fd);
+	free(handle);
+}
+
+TEST(nsfs_mnt_handle)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	struct stat st1, st2;
+
+	/* Drop to unprivileged uid/gid */
+	ASSERT_EQ(setresgid(65534, 65534, 65534), 0); /* nogroup */
+	ASSERT_EQ(setresuid(65534, 65534, 65534), 0); /* nobody */
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Open mount namespace file descriptor */
+	ns_fd = open("/proc/self/ns/mnt", O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+
+	/* Get handle for the namespace */
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	ASSERT_GT(handle->handle_bytes, 0);
+
+	/* Try to open using FD_NSFS_ROOT */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (fd < 0 && (errno == EINVAL || errno == EOPNOTSUPP)) {
+		SKIP(free(handle); close(ns_fd);
+		     return,
+			   "open_by_handle_at with FD_NSFS_ROOT not supported");
+	}
+	ASSERT_GE(fd, 0);
+
+	/* Verify we opened the correct namespace */
+	ASSERT_EQ(fstat(ns_fd, &st1), 0);
+	ASSERT_EQ(fstat(fd, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+	ASSERT_EQ(st1.st_dev, st2.st_dev);
+
+	close(fd);
+	close(ns_fd);
+	free(handle);
+}
+
+TEST(nsfs_user_handle)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	struct stat st1, st2;
+
+	/* Drop to unprivileged uid/gid */
+	ASSERT_EQ(setresgid(65534, 65534, 65534), 0); /* nogroup */
+	ASSERT_EQ(setresuid(65534, 65534, 65534), 0); /* nobody */
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Open user namespace file descriptor */
+	ns_fd = open("/proc/self/ns/user", O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+
+	/* Get handle for the namespace */
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	ASSERT_GT(handle->handle_bytes, 0);
+
+	/* Try to open using FD_NSFS_ROOT */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (fd < 0 && (errno == EINVAL || errno == EOPNOTSUPP)) {
+		SKIP(free(handle); close(ns_fd);
+		     return,
+			   "open_by_handle_at with FD_NSFS_ROOT not supported");
+	}
+	ASSERT_GE(fd, 0);
+
+	/* Verify we opened the correct namespace */
+	ASSERT_EQ(fstat(ns_fd, &st1), 0);
+	ASSERT_EQ(fstat(fd, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+	ASSERT_EQ(st1.st_dev, st2.st_dev);
+
+	close(fd);
+	close(ns_fd);
+	free(handle);
+}
+
+TEST(nsfs_cgroup_handle)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	struct stat st1, st2;
+
+	/* Drop to unprivileged uid/gid */
+	ASSERT_EQ(setresgid(65534, 65534, 65534), 0); /* nogroup */
+	ASSERT_EQ(setresuid(65534, 65534, 65534), 0); /* nobody */
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Open cgroup namespace file descriptor */
+	ns_fd = open("/proc/self/ns/cgroup", O_RDONLY);
+	if (ns_fd < 0) {
+		SKIP(free(handle); return, "cgroup namespace not available");
+	}
+
+	/* Get handle for the namespace */
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	ASSERT_GT(handle->handle_bytes, 0);
+
+	/* Try to open using FD_NSFS_ROOT */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (fd < 0 && (errno == EINVAL || errno == EOPNOTSUPP)) {
+		SKIP(free(handle); close(ns_fd);
+		     return,
+			   "open_by_handle_at with FD_NSFS_ROOT not supported");
+	}
+	ASSERT_GE(fd, 0);
+
+	/* Verify we opened the correct namespace */
+	ASSERT_EQ(fstat(ns_fd, &st1), 0);
+	ASSERT_EQ(fstat(fd, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+	ASSERT_EQ(st1.st_dev, st2.st_dev);
+
+	close(fd);
+	close(ns_fd);
+	free(handle);
+}
+
+TEST(nsfs_time_handle)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	struct stat st1, st2;
+
+	/* Drop to unprivileged uid/gid */
+	ASSERT_EQ(setresgid(65534, 65534, 65534), 0); /* nogroup */
+	ASSERT_EQ(setresuid(65534, 65534, 65534), 0); /* nobody */
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Open time namespace file descriptor */
+	ns_fd = open("/proc/self/ns/time", O_RDONLY);
+	if (ns_fd < 0) {
+		SKIP(free(handle); return, "time namespace not available");
+	}
+
+	/* Get handle for the namespace */
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	ASSERT_GT(handle->handle_bytes, 0);
+
+	/* Try to open using FD_NSFS_ROOT */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (fd < 0 && (errno == EINVAL || errno == EOPNOTSUPP)) {
+		SKIP(free(handle); close(ns_fd);
+		     return,
+			   "open_by_handle_at with FD_NSFS_ROOT not supported");
+	}
+	ASSERT_GE(fd, 0);
+
+	/* Verify we opened the correct namespace */
+	ASSERT_EQ(fstat(ns_fd, &st1), 0);
+	ASSERT_EQ(fstat(fd, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+	ASSERT_EQ(st1.st_dev, st2.st_dev);
+
+	close(fd);
+	close(ns_fd);
+	free(handle);
+}
+
+TEST(nsfs_user_net_namespace_isolation)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	pid_t pid;
+	int status;
+	int pipefd[2];
+	char result;
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Create pipe for communication */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	/* Get handle for current network namespace */
+	ns_fd = open("/proc/self/ns/net", O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd); close(pipefd[0]);
+		     close(pipefd[1]);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	close(ns_fd);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* First create new user namespace to drop privileges */
+		ret = unshare(CLONE_NEWUSER);
+		if (ret < 0) {
+			write(pipefd[1], "U",
+			      1); /* Unable to create user namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Write uid/gid mappings to maintain some capabilities */
+		int uid_map_fd = open("/proc/self/uid_map", O_WRONLY);
+		int gid_map_fd = open("/proc/self/gid_map", O_WRONLY);
+		int setgroups_fd = open("/proc/self/setgroups", O_WRONLY);
+
+		if (uid_map_fd < 0 || gid_map_fd < 0 || setgroups_fd < 0) {
+			write(pipefd[1], "M", 1); /* Unable to set mappings */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Disable setgroups to allow gid mapping */
+		write(setgroups_fd, "deny", 4);
+		close(setgroups_fd);
+
+		/* Map current uid/gid to root in the new namespace */
+		char mapping[64];
+		snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
+		write(uid_map_fd, mapping, strlen(mapping));
+		close(uid_map_fd);
+
+		snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
+		write(gid_map_fd, mapping, strlen(mapping));
+		close(gid_map_fd);
+
+		/* Now create new network namespace */
+		ret = unshare(CLONE_NEWNET);
+		if (ret < 0) {
+			write(pipefd[1], "N",
+			      1); /* Unable to create network namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Try to open parent's network namespace handle from new user+net namespace */
+		fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+
+		if (fd >= 0) {
+			/* Should NOT succeed - we're in a different user namespace */
+			write(pipefd[1], "S", 1); /* Unexpected success */
+			close(fd);
+		} else if (errno == ESTALE) {
+			/* Expected: Stale file handle */
+			write(pipefd[1], "P", 1);
+		} else {
+			/* Other error */
+			write(pipefd[1], "F", 1);
+		}
+
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+	ASSERT_EQ(read(pipefd[0], &result, 1), 1);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	if (result == 'U') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot create new user namespace");
+	}
+	if (result == 'M') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot set uid/gid mappings");
+	}
+	if (result == 'N') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot create new network namespace");
+	}
+
+	/* Should fail with permission denied since we're in a different user namespace */
+	ASSERT_EQ(result, 'P');
+
+	close(pipefd[0]);
+	free(handle);
+}
+
+TEST(nsfs_user_uts_namespace_isolation)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	pid_t pid;
+	int status;
+	int pipefd[2];
+	char result;
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Create pipe for communication */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	/* Get handle for current UTS namespace */
+	ns_fd = open("/proc/self/ns/uts", O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd); close(pipefd[0]);
+		     close(pipefd[1]);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	close(ns_fd);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* First create new user namespace to drop privileges */
+		ret = unshare(CLONE_NEWUSER);
+		if (ret < 0) {
+			write(pipefd[1], "U",
+			      1); /* Unable to create user namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Write uid/gid mappings to maintain some capabilities */
+		int uid_map_fd = open("/proc/self/uid_map", O_WRONLY);
+		int gid_map_fd = open("/proc/self/gid_map", O_WRONLY);
+		int setgroups_fd = open("/proc/self/setgroups", O_WRONLY);
+
+		if (uid_map_fd < 0 || gid_map_fd < 0 || setgroups_fd < 0) {
+			write(pipefd[1], "M", 1); /* Unable to set mappings */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Disable setgroups to allow gid mapping */
+		write(setgroups_fd, "deny", 4);
+		close(setgroups_fd);
+
+		/* Map current uid/gid to root in the new namespace */
+		char mapping[64];
+		snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
+		write(uid_map_fd, mapping, strlen(mapping));
+		close(uid_map_fd);
+
+		snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
+		write(gid_map_fd, mapping, strlen(mapping));
+		close(gid_map_fd);
+
+		/* Now create new UTS namespace */
+		ret = unshare(CLONE_NEWUTS);
+		if (ret < 0) {
+			write(pipefd[1], "N",
+			      1); /* Unable to create UTS namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Try to open parent's UTS namespace handle from new user+uts namespace */
+		fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+
+		if (fd >= 0) {
+			/* Should NOT succeed - we're in a different user namespace */
+			write(pipefd[1], "S", 1); /* Unexpected success */
+			close(fd);
+		} else if (errno == ESTALE) {
+			/* Expected: Stale file handle */
+			write(pipefd[1], "P", 1);
+		} else {
+			/* Other error */
+			write(pipefd[1], "F", 1);
+		}
+
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+	ASSERT_EQ(read(pipefd[0], &result, 1), 1);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	if (result == 'U') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot create new user namespace");
+	}
+	if (result == 'M') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot set uid/gid mappings");
+	}
+	if (result == 'N') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot create new UTS namespace");
+	}
+
+	/* Should fail with ESTALE since we're in a different user namespace */
+	ASSERT_EQ(result, 'P');
+
+	close(pipefd[0]);
+	free(handle);
+}
+
+TEST(nsfs_user_ipc_namespace_isolation)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	pid_t pid;
+	int status;
+	int pipefd[2];
+	char result;
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Create pipe for communication */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	/* Get handle for current IPC namespace */
+	ns_fd = open("/proc/self/ns/ipc", O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd); close(pipefd[0]);
+		     close(pipefd[1]);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	close(ns_fd);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* First create new user namespace to drop privileges */
+		ret = unshare(CLONE_NEWUSER);
+		if (ret < 0) {
+			write(pipefd[1], "U",
+			      1); /* Unable to create user namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Write uid/gid mappings to maintain some capabilities */
+		int uid_map_fd = open("/proc/self/uid_map", O_WRONLY);
+		int gid_map_fd = open("/proc/self/gid_map", O_WRONLY);
+		int setgroups_fd = open("/proc/self/setgroups", O_WRONLY);
+
+		if (uid_map_fd < 0 || gid_map_fd < 0 || setgroups_fd < 0) {
+			write(pipefd[1], "M", 1); /* Unable to set mappings */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Disable setgroups to allow gid mapping */
+		write(setgroups_fd, "deny", 4);
+		close(setgroups_fd);
+
+		/* Map current uid/gid to root in the new namespace */
+		char mapping[64];
+		snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
+		write(uid_map_fd, mapping, strlen(mapping));
+		close(uid_map_fd);
+
+		snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
+		write(gid_map_fd, mapping, strlen(mapping));
+		close(gid_map_fd);
+
+		/* Now create new IPC namespace */
+		ret = unshare(CLONE_NEWIPC);
+		if (ret < 0) {
+			write(pipefd[1], "N",
+			      1); /* Unable to create IPC namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Try to open parent's IPC namespace handle from new user+ipc namespace */
+		fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+
+		if (fd >= 0) {
+			/* Should NOT succeed - we're in a different user namespace */
+			write(pipefd[1], "S", 1); /* Unexpected success */
+			close(fd);
+		} else if (errno == ESTALE) {
+			/* Expected: Stale file handle */
+			write(pipefd[1], "P", 1);
+		} else {
+			/* Other error */
+			write(pipefd[1], "F", 1);
+		}
+
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+	ASSERT_EQ(read(pipefd[0], &result, 1), 1);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	if (result == 'U') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot create new user namespace");
+	}
+	if (result == 'M') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot set uid/gid mappings");
+	}
+	if (result == 'N') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot create new IPC namespace");
+	}
+
+	/* Should fail with ESTALE since we're in a different user namespace */
+	ASSERT_EQ(result, 'P');
+
+	close(pipefd[0]);
+	free(handle);
+}
+
+TEST(nsfs_user_mnt_namespace_isolation)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	pid_t pid;
+	int status;
+	int pipefd[2];
+	char result;
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Create pipe for communication */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	/* Get handle for current mount namespace */
+	ns_fd = open("/proc/self/ns/mnt", O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd); close(pipefd[0]);
+		     close(pipefd[1]);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	close(ns_fd);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* First create new user namespace to drop privileges */
+		ret = unshare(CLONE_NEWUSER);
+		if (ret < 0) {
+			write(pipefd[1], "U",
+			      1); /* Unable to create user namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Write uid/gid mappings to maintain some capabilities */
+		int uid_map_fd = open("/proc/self/uid_map", O_WRONLY);
+		int gid_map_fd = open("/proc/self/gid_map", O_WRONLY);
+		int setgroups_fd = open("/proc/self/setgroups", O_WRONLY);
+
+		if (uid_map_fd < 0 || gid_map_fd < 0 || setgroups_fd < 0) {
+			write(pipefd[1], "M", 1); /* Unable to set mappings */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Disable setgroups to allow gid mapping */
+		write(setgroups_fd, "deny", 4);
+		close(setgroups_fd);
+
+		/* Map current uid/gid to root in the new namespace */
+		char mapping[64];
+		snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
+		write(uid_map_fd, mapping, strlen(mapping));
+		close(uid_map_fd);
+
+		snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
+		write(gid_map_fd, mapping, strlen(mapping));
+		close(gid_map_fd);
+
+		/* Now create new mount namespace */
+		ret = unshare(CLONE_NEWNS);
+		if (ret < 0) {
+			write(pipefd[1], "N",
+			      1); /* Unable to create mount namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Try to open parent's mount namespace handle from new user+mnt namespace */
+		fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+
+		if (fd >= 0) {
+			/* Should NOT succeed - we're in a different user namespace */
+			write(pipefd[1], "S", 1); /* Unexpected success */
+			close(fd);
+		} else if (errno == ESTALE) {
+			/* Expected: Stale file handle */
+			write(pipefd[1], "P", 1);
+		} else {
+			/* Other error */
+			write(pipefd[1], "F", 1);
+		}
+
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+	ASSERT_EQ(read(pipefd[0], &result, 1), 1);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	if (result == 'U') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot create new user namespace");
+	}
+	if (result == 'M') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot set uid/gid mappings");
+	}
+	if (result == 'N') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot create new mount namespace");
+	}
+
+	/* Should fail with ESTALE since we're in a different user namespace */
+	ASSERT_EQ(result, 'P');
+
+	close(pipefd[0]);
+	free(handle);
+}
+
+TEST(nsfs_user_cgroup_namespace_isolation)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	pid_t pid;
+	int status;
+	int pipefd[2];
+	char result;
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Create pipe for communication */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	/* Get handle for current cgroup namespace */
+	ns_fd = open("/proc/self/ns/cgroup", O_RDONLY);
+	if (ns_fd < 0) {
+		SKIP(free(handle); close(pipefd[0]); close(pipefd[1]);
+		     return, "cgroup namespace not available");
+	}
+
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd); close(pipefd[0]);
+		     close(pipefd[1]);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	close(ns_fd);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* First create new user namespace to drop privileges */
+		ret = unshare(CLONE_NEWUSER);
+		if (ret < 0) {
+			write(pipefd[1], "U",
+			      1); /* Unable to create user namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Write uid/gid mappings to maintain some capabilities */
+		int uid_map_fd = open("/proc/self/uid_map", O_WRONLY);
+		int gid_map_fd = open("/proc/self/gid_map", O_WRONLY);
+		int setgroups_fd = open("/proc/self/setgroups", O_WRONLY);
+
+		if (uid_map_fd < 0 || gid_map_fd < 0 || setgroups_fd < 0) {
+			write(pipefd[1], "M", 1); /* Unable to set mappings */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Disable setgroups to allow gid mapping */
+		write(setgroups_fd, "deny", 4);
+		close(setgroups_fd);
+
+		/* Map current uid/gid to root in the new namespace */
+		char mapping[64];
+		snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
+		write(uid_map_fd, mapping, strlen(mapping));
+		close(uid_map_fd);
+
+		snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
+		write(gid_map_fd, mapping, strlen(mapping));
+		close(gid_map_fd);
+
+		/* Now create new cgroup namespace */
+		ret = unshare(CLONE_NEWCGROUP);
+		if (ret < 0) {
+			write(pipefd[1], "N",
+			      1); /* Unable to create cgroup namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Try to open parent's cgroup namespace handle from new user+cgroup namespace */
+		fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+
+		if (fd >= 0) {
+			/* Should NOT succeed - we're in a different user namespace */
+			write(pipefd[1], "S", 1); /* Unexpected success */
+			close(fd);
+		} else if (errno == ESTALE) {
+			/* Expected: Stale file handle */
+			write(pipefd[1], "P", 1);
+		} else {
+			/* Other error */
+			write(pipefd[1], "F", 1);
+		}
+
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+	ASSERT_EQ(read(pipefd[0], &result, 1), 1);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	if (result == 'U') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot create new user namespace");
+	}
+	if (result == 'M') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot set uid/gid mappings");
+	}
+	if (result == 'N') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot create new cgroup namespace");
+	}
+
+	/* Should fail with ESTALE since we're in a different user namespace */
+	ASSERT_EQ(result, 'P');
+
+	close(pipefd[0]);
+	free(handle);
+}
+
+TEST(nsfs_user_pid_namespace_isolation)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	pid_t pid;
+	int status;
+	int pipefd[2];
+	char result;
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Create pipe for communication */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	/* Get handle for current PID namespace */
+	ns_fd = open("/proc/self/ns/pid", O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd); close(pipefd[0]);
+		     close(pipefd[1]);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	close(ns_fd);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* First create new user namespace to drop privileges */
+		ret = unshare(CLONE_NEWUSER);
+		if (ret < 0) {
+			write(pipefd[1], "U",
+			      1); /* Unable to create user namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Write uid/gid mappings to maintain some capabilities */
+		int uid_map_fd = open("/proc/self/uid_map", O_WRONLY);
+		int gid_map_fd = open("/proc/self/gid_map", O_WRONLY);
+		int setgroups_fd = open("/proc/self/setgroups", O_WRONLY);
+
+		if (uid_map_fd < 0 || gid_map_fd < 0 || setgroups_fd < 0) {
+			write(pipefd[1], "M", 1); /* Unable to set mappings */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Disable setgroups to allow gid mapping */
+		write(setgroups_fd, "deny", 4);
+		close(setgroups_fd);
+
+		/* Map current uid/gid to root in the new namespace */
+		char mapping[64];
+		snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
+		write(uid_map_fd, mapping, strlen(mapping));
+		close(uid_map_fd);
+
+		snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
+		write(gid_map_fd, mapping, strlen(mapping));
+		close(gid_map_fd);
+
+		/* Now create new PID namespace - requires fork to take effect */
+		ret = unshare(CLONE_NEWPID);
+		if (ret < 0) {
+			write(pipefd[1], "N",
+			      1); /* Unable to create PID namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Fork again for PID namespace to take effect */
+		pid_t child_pid = fork();
+		if (child_pid < 0) {
+			write(pipefd[1], "N",
+			      1); /* Unable to fork in PID namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		if (child_pid == 0) {
+			/* Grandchild in new PID namespace */
+			/* Try to open parent's PID namespace handle from new user+pid namespace */
+			fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+
+			if (fd >= 0) {
+				/* Should NOT succeed - we're in a different user namespace */
+				write(pipefd[1], "S",
+				      1); /* Unexpected success */
+				close(fd);
+			} else if (errno == ESTALE) {
+				/* Expected: Stale file handle */
+				write(pipefd[1], "P", 1);
+			} else {
+				/* Other error */
+				write(pipefd[1], "F", 1);
+			}
+
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Wait for grandchild */
+		waitpid(child_pid, NULL, 0);
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+	ASSERT_EQ(read(pipefd[0], &result, 1), 1);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	if (result == 'U') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot create new user namespace");
+	}
+	if (result == 'M') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot set uid/gid mappings");
+	}
+	if (result == 'N') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot create new PID namespace");
+	}
+
+	/* Should fail with ESTALE since we're in a different user namespace */
+	ASSERT_EQ(result, 'P');
+
+	close(pipefd[0]);
+	free(handle);
+}
+
+TEST(nsfs_user_time_namespace_isolation)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+	pid_t pid;
+	int status;
+	int pipefd[2];
+	char result;
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Create pipe for communication */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	/* Get handle for current time namespace */
+	ns_fd = open("/proc/self/ns/time", O_RDONLY);
+	if (ns_fd < 0) {
+		SKIP(free(handle); close(pipefd[0]); close(pipefd[1]);
+		     return, "time namespace not available");
+	}
+
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd); close(pipefd[0]);
+		     close(pipefd[1]);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	close(ns_fd);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* First create new user namespace to drop privileges */
+		ret = unshare(CLONE_NEWUSER);
+		if (ret < 0) {
+			write(pipefd[1], "U",
+			      1); /* Unable to create user namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Write uid/gid mappings to maintain some capabilities */
+		int uid_map_fd = open("/proc/self/uid_map", O_WRONLY);
+		int gid_map_fd = open("/proc/self/gid_map", O_WRONLY);
+		int setgroups_fd = open("/proc/self/setgroups", O_WRONLY);
+
+		if (uid_map_fd < 0 || gid_map_fd < 0 || setgroups_fd < 0) {
+			write(pipefd[1], "M", 1); /* Unable to set mappings */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Disable setgroups to allow gid mapping */
+		write(setgroups_fd, "deny", 4);
+		close(setgroups_fd);
+
+		/* Map current uid/gid to root in the new namespace */
+		char mapping[64];
+		snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
+		write(uid_map_fd, mapping, strlen(mapping));
+		close(uid_map_fd);
+
+		snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
+		write(gid_map_fd, mapping, strlen(mapping));
+		close(gid_map_fd);
+
+		/* Now create new time namespace - requires fork to take effect */
+		ret = unshare(CLONE_NEWTIME);
+		if (ret < 0) {
+			write(pipefd[1], "N",
+			      1); /* Unable to create time namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Fork again for time namespace to take effect */
+		pid_t child_pid = fork();
+		if (child_pid < 0) {
+			write(pipefd[1], "N",
+			      1); /* Unable to fork in time namespace */
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		if (child_pid == 0) {
+			/* Grandchild in new time namespace */
+			/* Try to open parent's time namespace handle from new user+time namespace */
+			fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+
+			if (fd >= 0) {
+				/* Should NOT succeed - we're in a different user namespace */
+				write(pipefd[1], "S",
+				      1); /* Unexpected success */
+				close(fd);
+			} else if (errno == ESTALE) {
+				/* Expected: Stale file handle */
+				write(pipefd[1], "P", 1);
+			} else {
+				/* Other error */
+				write(pipefd[1], "F", 1);
+			}
+
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Wait for grandchild */
+		waitpid(child_pid, NULL, 0);
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+	ASSERT_EQ(read(pipefd[0], &result, 1), 1);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	if (result == 'U') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot create new user namespace");
+	}
+	if (result == 'M') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot set uid/gid mappings");
+	}
+	if (result == 'N') {
+		SKIP(free(handle); close(pipefd[0]);
+		     return, "Cannot create new time namespace");
+	}
+
+	/* Should fail with ESTALE since we're in a different user namespace */
+	ASSERT_EQ(result, 'P');
+
+	close(pipefd[0]);
+	free(handle);
+}
+
+TEST(nsfs_open_flags)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int ns_fd;
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Open a namespace file descriptor */
+	ns_fd = open("/proc/self/ns/net", O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+
+	/* Get handle for the namespace */
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(ns_fd);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+	ASSERT_GT(handle->handle_bytes, 0);
+
+	/* Test invalid flags that should fail */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_WRONLY);
+	ASSERT_LT(fd, 0);
+	ASSERT_EQ(errno, EPERM);
+
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDWR);
+	ASSERT_LT(fd, 0);
+	ASSERT_EQ(errno, EPERM);
+
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_TRUNC);
+	ASSERT_LT(fd, 0);
+	ASSERT_EQ(errno, EPERM);
+
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_DIRECT);
+	ASSERT_LT(fd, 0);
+	ASSERT_EQ(errno, EINVAL);
+
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_TMPFILE);
+	ASSERT_LT(fd, 0);
+	ASSERT_EQ(errno, EINVAL);
+
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_DIRECTORY);
+	ASSERT_LT(fd, 0);
+	ASSERT_EQ(errno, ENOTDIR);
+
+	close(ns_fd);
+	free(handle);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


