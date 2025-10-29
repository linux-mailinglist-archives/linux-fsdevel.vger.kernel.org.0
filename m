Return-Path: <linux-fsdevel+bounces-66241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEF3C1A3CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8635335656C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB4835A15A;
	Wed, 29 Oct 2025 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pF3sY0bU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB9283124;
	Wed, 29 Oct 2025 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740580; cv=none; b=SjaKaD/aIdeMzcOUK3RWFWtPB1SbxFx5eXhBI1uengvx8+xlR7ZErcQnfOK6W0vtw+zWM3ZFZwnbxZUuTsV0m7cnk47fOJB7A02x5UEDXvgVsTc4Qx5AoJzrJfsaWcBd9PTZIyH3GMtrRnPNSAtumFflFCbALkfEt61UsFpZZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740580; c=relaxed/simple;
	bh=zOSZXXVQ1jVkT7WHK+88OLa6Cp/PXPPixfxVAVT9vUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=intvNTD/3o0mZiWqEuRol36GnNd1ImiJRcrUUauwEdC6eqbZzcrGjrc76aB0dHgmzT62YJZK4WFO2o9XMVWrx2yJwf0BIPznaz7kiM5n1SUi0/Z6f3xDg7V9myhMV4Fz6f7TGbJKSDWjuWys09F5acDYXvCbVToFpZKWAr5fscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pF3sY0bU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C7DC4CEFF;
	Wed, 29 Oct 2025 12:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740580;
	bh=zOSZXXVQ1jVkT7WHK+88OLa6Cp/PXPPixfxVAVT9vUI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pF3sY0bUKeKQKSFV/M0SbqE1dcZRoZgodV95fy7X6SlAlverqnHXm6yBcWz6J5l+c
	 qeAT6DQkcvHcHQoR58sG+W+CWwlaKlXgunPWbAMVz4sUXd9CP2s0TUHClGeKqu3SkK
	 TfK0Rmtcs0qUHSCqLs4jWfjg94RNlPpI1lsxllBl0XQTx+ZN/Wo4L3nKfDMb1cqYWa
	 kKGG394cJMTycufOgA4Tjus+UKL3lFhDbWKpuJ2AwHk18LCRRDBg0crecPHYD6v+Jg
	 //JPS9lwjqE7dG+bMqZLJSV9XwfMw04hYNCMQBLOMR489NNXzvxyxDPYKRx9HanhWV
	 hu361/j6hntLg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:41 +0100
Subject: [PATCH v4 28/72] selftests/namespaces: sixth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-28-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5791; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zOSZXXVQ1jVkT7WHK+88OLa6Cp/PXPPixfxVAVT9vUI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfX+M7oQ9CqwSdg3c477bg91fWabd9bhbDuYd35tl
 NnwSKqmo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLJ9xj+B3q0nz/044Z5R/dS
 30uze3TMvsUcVuY12hjbviVGN+N4IcP/XLZLwbaGDz4E3eX/qPLqpP6OiatsOnrfzk+M9+YrlD3
 ODwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that an open file descriptor keeps a namespace active.
Even after the creating process exits, the namespace should remain
active as long as an fd is held open.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 155 +++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index f4e92b772f70..50653096fcb6 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -448,4 +448,159 @@ TEST(pidns_active_ref_lifecycle)
 	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
 }
 
+/*
+ * Test that an open file descriptor keeps a namespace active.
+ * Even after the creating process exits, the namespace should remain
+ * active as long as an fd is held open.
+ */
+TEST(ns_fd_keeps_active)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int nsfd;
+	int pipe_child_ready[2];
+	int pipe_parent_ready[2];
+	pid_t pid;
+	int status;
+	char buf[sizeof(*handle) + MAX_HANDLE_SZ];
+	char sync_byte;
+	char proc_path[64];
+
+	ASSERT_EQ(pipe(pipe_child_ready), 0);
+	ASSERT_EQ(pipe(pipe_parent_ready), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipe_child_ready[0]);
+		close(pipe_parent_ready[1]);
+
+		TH_LOG("Child: creating new network namespace");
+
+		/* Create new network namespace */
+		ret = unshare(CLONE_NEWNET);
+		if (ret < 0) {
+			TH_LOG("Child: unshare(CLONE_NEWNET) failed: %s", strerror(errno));
+			close(pipe_child_ready[1]);
+			close(pipe_parent_ready[0]);
+			exit(1);
+		}
+
+		TH_LOG("Child: network namespace created successfully");
+
+		/* Get file handle for the namespace */
+		nsfd = open("/proc/self/ns/net", O_RDONLY);
+		if (nsfd < 0) {
+			TH_LOG("Child: failed to open /proc/self/ns/net: %s", strerror(errno));
+			close(pipe_child_ready[1]);
+			close(pipe_parent_ready[0]);
+			exit(1);
+		}
+
+		TH_LOG("Child: opened namespace fd %d", nsfd);
+
+		handle = (struct file_handle *)buf;
+		handle->handle_bytes = MAX_HANDLE_SZ;
+		ret = name_to_handle_at(nsfd, "", handle, &mount_id, AT_EMPTY_PATH);
+		close(nsfd);
+
+		if (ret < 0) {
+			TH_LOG("Child: name_to_handle_at failed: %s", strerror(errno));
+			close(pipe_child_ready[1]);
+			close(pipe_parent_ready[0]);
+			exit(1);
+		}
+
+		TH_LOG("Child: got file handle (bytes=%u)", handle->handle_bytes);
+
+		/* Send file handle to parent */
+		ret = write(pipe_child_ready[1], buf, sizeof(*handle) + handle->handle_bytes);
+		TH_LOG("Child: sent %d bytes of file handle to parent", ret);
+		close(pipe_child_ready[1]);
+
+		/* Wait for parent to open the fd */
+		TH_LOG("Child: waiting for parent to open fd");
+		ret = read(pipe_parent_ready[0], &sync_byte, 1);
+		close(pipe_parent_ready[0]);
+
+		TH_LOG("Child: parent signaled (read %d bytes), exiting now", ret);
+		/* Exit - namespace should stay active because parent holds fd */
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipe_child_ready[1]);
+	close(pipe_parent_ready[0]);
+
+	TH_LOG("Parent: reading file handle from child");
+
+	/* Read file handle from child */
+	ret = read(pipe_child_ready[0], buf, sizeof(buf));
+	close(pipe_child_ready[0]);
+	ASSERT_GT(ret, 0);
+	handle = (struct file_handle *)buf;
+
+	TH_LOG("Parent: received %d bytes, handle size=%u", ret, handle->handle_bytes);
+
+	/* Open the child's namespace while it's still alive */
+	snprintf(proc_path, sizeof(proc_path), "/proc/%d/ns/net", pid);
+	TH_LOG("Parent: opening child's namespace at %s", proc_path);
+	nsfd = open(proc_path, O_RDONLY);
+	if (nsfd < 0) {
+		TH_LOG("Parent: failed to open %s: %s", proc_path, strerror(errno));
+		close(pipe_parent_ready[1]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to open child's namespace");
+	}
+
+	TH_LOG("Parent: opened child's namespace, got fd %d", nsfd);
+
+	/* Signal child that we have the fd */
+	sync_byte = 'G';
+	write(pipe_parent_ready[1], &sync_byte, 1);
+	close(pipe_parent_ready[1]);
+	TH_LOG("Parent: signaled child that we have the fd");
+
+	/* Wait for child to exit */
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	TH_LOG("Child exited, parent holds fd %d to namespace", nsfd);
+
+	/*
+	 * Namespace should still be ACTIVE because we hold an fd.
+	 * We should be able to reopen it via file handle.
+	 */
+	TH_LOG("Attempting to reopen namespace via file handle (should succeed - fd held)");
+	int fd2 = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	ASSERT_GE(fd2, 0);
+
+	TH_LOG("Successfully reopened namespace via file handle, got fd %d", fd2);
+
+	/* Verify it's the same namespace */
+	struct stat st1, st2;
+	ASSERT_EQ(fstat(nsfd, &st1), 0);
+	ASSERT_EQ(fstat(fd2, &st2), 0);
+	TH_LOG("Namespace inodes: nsfd=%lu, fd2=%lu", st1.st_ino, st2.st_ino);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+	close(fd2);
+
+	/* Now close the fd - namespace should become inactive */
+	TH_LOG("Closing fd %d - namespace should become inactive", nsfd);
+	close(nsfd);
+
+	/* Now reopening should fail - namespace is inactive */
+	TH_LOG("Attempting to reopen namespace via file handle (should fail - inactive)");
+	fd2 = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	ASSERT_LT(fd2, 0);
+	/* Should fail with ENOENT (inactive) or ESTALE (gone) */
+	TH_LOG("Reopen failed as expected: %s (errno=%d)", strerror(errno), errno);
+	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


