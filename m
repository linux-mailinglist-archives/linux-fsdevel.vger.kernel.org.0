Return-Path: <linux-fsdevel+bounces-64875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7C4BF6358
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61EB234B92C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB8434215D;
	Tue, 21 Oct 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1fi4Gr1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0169342149;
	Tue, 21 Oct 2025 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047158; cv=none; b=evz+BpbcM3mZ7orFsZBigajAJLkUFQ0WYxFVRNfJVg8DE2XPpwW0ITqiah2SaB+cjHk3dRNiyUBR6aP+PaNOdyMYdJWr+rnQ7mOZ6huFS4cBGLfBVvtBILF+bmXv9mI0e4T1STvlUFgKrw7YKRvmSwwUNnd+1x/L2JKutZI4oT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047158; c=relaxed/simple;
	bh=uOH3CT+OUgM5Z/Sy7CrxJmBWupBsQ4/yDAh+nMm1LYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TlQiXPnzMXbPjz3wHfofHlkQ5SNOZ5gSCfiaIOjEA59lHKyrgkZhuTqLFIF5rN1iLGtzd32PGPLdRvsUtDSMb2u9o9P5hAFsYuVJZur8stp3bxLgxQyh6uKo/MAVMv63FW7ZMaebVzPV1FmAnEvE44oWKyrOVFqMxfFi5mQhbFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1fi4Gr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBC7C4CEF5;
	Tue, 21 Oct 2025 11:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047158;
	bh=uOH3CT+OUgM5Z/Sy7CrxJmBWupBsQ4/yDAh+nMm1LYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H1fi4Gr1EFMYDUL1pzIJeZIZDzQ/JHPbq1JUifXDaByHwA1mJ8p5FmttWqDmceJbP
	 dONWJKpu8Gy/+14E5zseA9FBiERE7lY65IrvdMxIO1gCrogPd+0kNRDcH+BFdPzZ1D
	 nTq2qCUgfGIeeSVM1Ppqq5jL3lITA9gibMnOdqOhgHHc08iBFtMlrJmwvZqiA4vdtt
	 BQYfngfQYSAUyey6+PW4mnlumXPniQIbuDlYUX151DA15/rw0orrcwMmokxH9B5u3E
	 /UJuOoFRKvdEb6R5AUJk9zi0U7KcD+lTwJhwDY+WXvPJUghcwx/jAjnQBOj2fH2eoL
	 ze6HPLUp1lGMA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:30 +0200
Subject: [PATCH RFC DRAFT 24/50] selftests/namespaces: sixth active
 reference count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-24-ad44261a8a5b@kernel.org>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6091; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uOH3CT+OUgM5Z/Sy7CrxJmBWupBsQ4/yDAh+nMm1LYg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3y7e5/o7xv/EhY+i315crLvttDN6j4dkTOcn02Sd
 Gxo5ObW6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIjjYjw/ujKpImcTJM85P4
 t5TaLZnWN3mf5Od1Agr/pEy0vnnsK2b4ZxOtK8pknJ2QYnqMeTr/v9NcjPMzv5vfeThp9ef+3B2
 BTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that an open file descriptor keeps a namespace active.
Even after the creating process exits, the namespace should remain
active as long as an fd is held open.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 168 +++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 66665bd39e9b..dbb1eb8a04b2 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -473,4 +473,172 @@ TEST(pidns_active_ref_lifecycle)
 	}
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
+
+	if (WEXITSTATUS(status) != 0) {
+		close(nsfd);
+		SKIP(return, "Child failed to create namespace");
+	}
+
+	TH_LOG("Child exited, parent holds fd %d to namespace", nsfd);
+
+	/*
+	 * Namespace should still be ACTIVE because we hold an fd.
+	 * We should be able to reopen it via file handle.
+	 */
+	TH_LOG("Attempting to reopen namespace via file handle (should succeed - fd held)");
+	int fd2 = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (fd2 < 0) {
+		close(nsfd);
+		TH_LOG("ERROR: Failed to reopen active namespace (fd held): %s (errno=%d)",
+		       strerror(errno), errno);
+		ASSERT_TRUE(false);
+	}
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
+	if (fd2 >= 0) {
+		close(fd2);
+		TH_LOG("ERROR: Namespace still active after closing all fds (fd=%d)", fd2);
+	} else {
+		/* Should fail with ENOENT (inactive) or ESTALE (gone) */
+		TH_LOG("Reopen failed as expected: %s (errno=%d)", strerror(errno), errno);
+		ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


