Return-Path: <linux-fsdevel+bounces-65505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C209C05F2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D8C1B87E75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8F536CA62;
	Fri, 24 Oct 2025 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSlzC7e4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785C36C245;
	Fri, 24 Oct 2025 10:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303540; cv=none; b=olPEyT52tU05obqgEwS1ua7r1zo1ORhbz+F1qHu25fmmm4IPsgxJPI19YwaZIJBMHS+ifG6VPMbFF9xPAGEmsKVviEXCbQFPRbEGxEtCr7nCR5xphNrOgiiZCu9wXl1nwOropuoYQ8Gz1XNabBOHnEVM3kjemfv7nxmA6A5rsSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303540; c=relaxed/simple;
	bh=WqVUkxH4ZBiU30MvQT3O+adj44+G6SHOGkbS5VtGikk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLaPrdxmR1iW8Q4Tppgdip/Fpif2gQg2oH4y7CmRRsK/EH2agaNRbvFUNrYUmwtnVmHLQt7fy0L2jPjE5pBtdfllQaz2GUCphvNoxmQWQ/QWSrRwVEJGSsRgp+dKJLY/ULRG32ha8MaYXH46luIIMBMd9PSAVI3Yf+1moVL2XmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSlzC7e4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE48C113D0;
	Fri, 24 Oct 2025 10:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303540;
	bh=WqVUkxH4ZBiU30MvQT3O+adj44+G6SHOGkbS5VtGikk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tSlzC7e4j3jM0TnsmBpG9ygZRTDeG0oCzatX7Bx62nyYTJFAPnZbArKHQkMbOwGmw
	 2ppZzY2Y0lN+A+fEqVOlmwMZ/YPhJbi7hbL7xWHlzn0WBF6qXc7QkJi1Mb0770lIbo
	 I0E3ndgQCiXDHjm4QCP+Ppt2gU0hSp8Dj2++2jPTUxMeEa54FhceUaM/SEzDlM8Y+6
	 82y85nJ4IFzxy3WVYH7Hz6ZawXYFim/U+Xku/RhiTIXv35PI3aNKDVyUm7IwEhBzgQ
	 QQJXqrbeZxhx/vOvOr9d3Cb2Cxklc1gPgm6L1C5LdFZ6D1i90tEdcdGi+G2HxPqqP/
	 JjIZfRtnr+yqw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:34 +0200
Subject: [PATCH v3 65/70] selftests/namespace: first threaded active
 reference count test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-65-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=4736; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WqVUkxH4ZBiU30MvQT3O+adj44+G6SHOGkbS5VtGikk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8juqo3ZfBdH/T7Zvp5xadnHbn69FfaksSrRPfbNc29
 Dv7nb3KqaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi4jcZ/qf87ftsHjwpNLOI
 95hR7WXT7Uft1m61/RP6py929t1HaW8YGU56vmaYxsYYukzTTPq3UltjuaXUPJsDSWVnY3j5G7f
 d5AQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that namespace becomes inactive after thread exits. This verifies
active reference counting works with threads, not just processes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 138 +++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index b7fa973a2572..0c6c4869bb16 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -12,9 +12,12 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/syscall.h>
 #include <unistd.h>
+#include <pthread.h>
 #include "../kselftest_harness.h"
 #include "../filesystems/utils.h"
+#include "wrappers.h"
 
 #ifndef FD_NSFS_ROOT
 #define FD_NSFS_ROOT -10003 /* Root of the nsfs filesystem */
@@ -2113,4 +2116,139 @@ TEST(ns_mixed_types_same_owner)
 	ASSERT_LT(u_fd, 0);
 }
 
+/* Thread test helpers and structures */
+struct thread_ns_info {
+	__u64 ns_id;
+	int pipefd;
+	int syncfd_read;
+	int syncfd_write;
+	int exit_code;
+};
+
+static void *thread_create_namespace(void *arg)
+{
+	struct thread_ns_info *info = (struct thread_ns_info *)arg;
+	int ret;
+
+	/* Create new network namespace */
+	ret = unshare(CLONE_NEWNET);
+	if (ret < 0) {
+		info->exit_code = 1;
+		return NULL;
+	}
+
+	/* Get namespace ID */
+	int fd = open("/proc/thread-self/ns/net", O_RDONLY);
+	if (fd < 0) {
+		info->exit_code = 2;
+		return NULL;
+	}
+
+	ret = ioctl(fd, NS_GET_ID, &info->ns_id);
+	close(fd);
+	if (ret < 0) {
+		info->exit_code = 3;
+		return NULL;
+	}
+
+	/* Send namespace ID to main thread */
+	if (write(info->pipefd, &info->ns_id, sizeof(info->ns_id)) != sizeof(info->ns_id)) {
+		info->exit_code = 4;
+		return NULL;
+	}
+
+	/* Wait for signal to exit */
+	char sync_byte;
+	if (read(info->syncfd_read, &sync_byte, 1) != 1) {
+		info->exit_code = 5;
+		return NULL;
+	}
+
+	info->exit_code = 0;
+	return NULL;
+}
+
+/*
+ * Test that namespace becomes inactive after thread exits.
+ * This verifies active reference counting works with threads, not just processes.
+ */
+TEST(thread_ns_inactive_after_exit)
+{
+	pthread_t thread;
+	struct thread_ns_info info;
+	struct file_handle *handle;
+	int pipefd[2];
+	int syncpipe[2];
+	int ret;
+	char sync_byte;
+	char buf[sizeof(*handle) + MAX_HANDLE_SZ];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+	ASSERT_EQ(pipe(syncpipe), 0);
+
+	info.pipefd = pipefd[1];
+	info.syncfd_read = syncpipe[0];
+	info.syncfd_write = -1;
+	info.exit_code = -1;
+
+	/* Create thread that will create a namespace */
+	ret = pthread_create(&thread, NULL, thread_create_namespace, &info);
+	ASSERT_EQ(ret, 0);
+
+	/* Read namespace ID from thread */
+	__u64 ns_id;
+	ret = read(pipefd[0], &ns_id, sizeof(ns_id));
+	if (ret != sizeof(ns_id)) {
+		sync_byte = 'X';
+		write(syncpipe[1], &sync_byte, 1);
+		pthread_join(thread, NULL);
+		close(pipefd[0]);
+		close(pipefd[1]);
+		close(syncpipe[0]);
+		close(syncpipe[1]);
+		SKIP(return, "Failed to read namespace ID from thread");
+	}
+
+	TH_LOG("Thread created namespace with ID %llu", (unsigned long long)ns_id);
+
+	/* Construct file handle */
+	handle = (struct file_handle *)buf;
+	handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *fh = (struct nsfs_file_handle *)handle->f_handle;
+	fh->ns_id = ns_id;
+	fh->ns_type = 0;
+	fh->ns_inum = 0;
+
+	/* Namespace should be active while thread is alive */
+	TH_LOG("Attempting to open namespace while thread is alive (should succeed)");
+	int nsfd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	ASSERT_GE(nsfd, 0);
+	close(nsfd);
+
+	/* Signal thread to exit */
+	TH_LOG("Signaling thread to exit");
+	sync_byte = 'X';
+	ASSERT_EQ(write(syncpipe[1], &sync_byte, 1), 1);
+	close(syncpipe[1]);
+
+	/* Wait for thread to exit */
+	ASSERT_EQ(pthread_join(thread, NULL), 0);
+	close(pipefd[0]);
+	close(pipefd[1]);
+	close(syncpipe[0]);
+
+	if (info.exit_code != 0)
+		SKIP(return, "Thread failed to create namespace");
+
+	TH_LOG("Thread exited, namespace should be inactive");
+
+	/* Namespace should now be inactive */
+	nsfd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	ASSERT_LT(nsfd, 0);
+	/* Should fail with ENOENT (inactive) or ESTALE (gone) */
+	TH_LOG("Namespace inactive as expected: %s (errno=%d)", strerror(errno), errno);
+	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


