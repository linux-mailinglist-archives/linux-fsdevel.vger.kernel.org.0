Return-Path: <linux-fsdevel+bounces-66282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19520C1A71A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4A6B506BEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21E93678D7;
	Wed, 29 Oct 2025 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8OBkH8p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443C83678C0;
	Wed, 29 Oct 2025 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740789; cv=none; b=Bh8q/rWSKWftShQx3YYdVtpw9ARWisSgkSkgHmMVNVLBAOosVLlsZRXXXepnPkPBRncTGWbVJuEvgMe/ODe66H24zTQSSaF2mdheCk6TIN7rVR4nPNdla3z9UmadNu5XZE+BKO86GuXAD0yru0nJyukiN80SFk0zi/1SW1lOgMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740789; c=relaxed/simple;
	bh=wjpkLSx2K2iB/mWZZQZcuIqQ514ywG7UHLGyzr0x04k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ncLRibd+KFTYXoDOzwtgF+SinqRAlyGtxWgatpnfa/Jj2Waa9GtiOlT5Bhct/JlbI5GLMUakV9Pk/Tu6qswF3tnFau7D71Oa6fAHDzZwERhEmKSe5en2+qtOv7iU9DsfqEBS462kvlE8Axs+FVEvTsZKAptB9bsG0s160etYxQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8OBkH8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2920BC4CEFF;
	Wed, 29 Oct 2025 12:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740788;
	bh=wjpkLSx2K2iB/mWZZQZcuIqQ514ywG7UHLGyzr0x04k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M8OBkH8piqK2Y5pAot3tsHUlnkJCbJUyH9a+5eGu2e17vFEOcAAurdN8Hr3VfvRdX
	 GVpBmcARBaj+i8KpD35MPKBtrx2qlcH9s6XLQon3bbKg8X4Y/6kLwlJPRFCJ736o2U
	 yJt2YoqyU4nkzHXcgEMHvDIqYW9sPAFwxywceW8AvAsDvggkjBscLb/cRRlnrRJogU
	 TXMR2yZWM+3z+UxpbveAaTexHcKSq59wmAu8bUjZl+vMn2Z9+MxROxstPN/mKNxXEz
	 tQhEz3/UvYKdrgnxJCtx2iLxGT+8wkl4jnJ0Sj0EEWiZ3SwZkNLKH1uqrKGdX9L2+/
	 Ud5lTlmtZJk1w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:22 +0100
Subject: [PATCH v4 69/72] selftests/namespace: third threaded active
 reference count test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-69-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11371; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wjpkLSx2K2iB/mWZZQZcuIqQ514ywG7UHLGyzr0x04k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysU14rPMrrcN2Fq9Zqo3RgZCJT6cGrc/NXN5xIWgV1
 4YlOrMiOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiycfIcPa2b7Pe3k1lb07U
 9GWHenDtnzpdniX/6d9Jm9I4vtf/+cvwP2d9+d78OU8DxF+GXvwffkbDS2CtwoM/E/y93zxM7vn
 ykR0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that namespaces become inactive after subprocess with multiple
threads exits. Create a subprocess that unshares user and network
namespaces, then creates two threads that share those namespaces. Verify
that after all threads and subprocess exit, the namespaces are no longer
listed by listns() and cannot be opened by open_by_handle_at().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 319 +++++++++++++++++++++
 1 file changed, 319 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 24dc8ef106b9..093268f0efaa 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <linux/nsfs.h>
 #include <sys/mount.h>
+#include <sys/socket.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -2350,4 +2351,322 @@ TEST(thread_ns_fd_keeps_active)
 	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
 }
 
+/* Structure for thread data in subprocess */
+struct thread_sleep_data {
+	int syncfd_read;
+};
+
+static void *thread_sleep_and_wait(void *arg)
+{
+	struct thread_sleep_data *data = (struct thread_sleep_data *)arg;
+	char sync_byte;
+
+	/* Wait for signal to exit - read will unblock when pipe is closed */
+	(void)read(data->syncfd_read, &sync_byte, 1);
+	return NULL;
+}
+
+/*
+ * Test that namespaces become inactive after subprocess with multiple threads exits.
+ * Create a subprocess that unshares user and network namespaces, then creates two
+ * threads that share those namespaces. Verify that after all threads and subprocess
+ * exit, the namespaces are no longer listed by listns() and cannot be opened by
+ * open_by_handle_at().
+ */
+TEST(thread_subprocess_ns_inactive_after_all_exit)
+{
+	int pipefd[2];
+	int sv[2];
+	pid_t pid;
+	int status;
+	__u64 user_id, net_id;
+	struct file_handle *user_handle, *net_handle;
+	char user_buf[sizeof(*user_handle) + MAX_HANDLE_SZ];
+	char net_buf[sizeof(*net_handle) + MAX_HANDLE_SZ];
+	char sync_byte;
+	int ret;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sv), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+		close(sv[0]);
+
+		/* Create user namespace with mappings */
+		if (setup_userns() < 0) {
+			fprintf(stderr, "Child: setup_userns() failed: %s\n", strerror(errno));
+			close(pipefd[1]);
+			close(sv[1]);
+			exit(1);
+		}
+		fprintf(stderr, "Child: setup_userns() succeeded\n");
+
+		/* Get user namespace ID */
+		int user_fd = open("/proc/self/ns/user", O_RDONLY);
+		if (user_fd < 0) {
+			fprintf(stderr, "Child: open(/proc/self/ns/user) failed: %s\n", strerror(errno));
+			close(pipefd[1]);
+			close(sv[1]);
+			exit(1);
+		}
+
+		if (ioctl(user_fd, NS_GET_ID, &user_id) < 0) {
+			fprintf(stderr, "Child: ioctl(NS_GET_ID) for user ns failed: %s\n", strerror(errno));
+			close(user_fd);
+			close(pipefd[1]);
+			close(sv[1]);
+			exit(1);
+		}
+		close(user_fd);
+		fprintf(stderr, "Child: user ns ID = %llu\n", (unsigned long long)user_id);
+
+		/* Unshare network namespace */
+		if (unshare(CLONE_NEWNET) < 0) {
+			fprintf(stderr, "Child: unshare(CLONE_NEWNET) failed: %s\n", strerror(errno));
+			close(pipefd[1]);
+			close(sv[1]);
+			exit(1);
+		}
+		fprintf(stderr, "Child: unshare(CLONE_NEWNET) succeeded\n");
+
+		/* Get network namespace ID */
+		int net_fd = open("/proc/self/ns/net", O_RDONLY);
+		if (net_fd < 0) {
+			fprintf(stderr, "Child: open(/proc/self/ns/net) failed: %s\n", strerror(errno));
+			close(pipefd[1]);
+			close(sv[1]);
+			exit(1);
+		}
+
+		if (ioctl(net_fd, NS_GET_ID, &net_id) < 0) {
+			fprintf(stderr, "Child: ioctl(NS_GET_ID) for net ns failed: %s\n", strerror(errno));
+			close(net_fd);
+			close(pipefd[1]);
+			close(sv[1]);
+			exit(1);
+		}
+		close(net_fd);
+		fprintf(stderr, "Child: net ns ID = %llu\n", (unsigned long long)net_id);
+
+		/* Send namespace IDs to parent */
+		if (write(pipefd[1], &user_id, sizeof(user_id)) != sizeof(user_id)) {
+			fprintf(stderr, "Child: write(user_id) failed: %s\n", strerror(errno));
+			exit(1);
+		}
+		if (write(pipefd[1], &net_id, sizeof(net_id)) != sizeof(net_id)) {
+			fprintf(stderr, "Child: write(net_id) failed: %s\n", strerror(errno));
+			exit(1);
+		}
+		close(pipefd[1]);
+		fprintf(stderr, "Child: sent namespace IDs to parent\n");
+
+		/* Create two threads that share the namespaces */
+		pthread_t thread1, thread2;
+		struct thread_sleep_data data;
+		data.syncfd_read = sv[1];
+
+		int ret_thread = pthread_create(&thread1, NULL, thread_sleep_and_wait, &data);
+		if (ret_thread != 0) {
+			fprintf(stderr, "Child: pthread_create(thread1) failed: %s\n", strerror(ret_thread));
+			close(sv[1]);
+			exit(1);
+		}
+		fprintf(stderr, "Child: created thread1\n");
+
+		ret_thread = pthread_create(&thread2, NULL, thread_sleep_and_wait, &data);
+		if (ret_thread != 0) {
+			fprintf(stderr, "Child: pthread_create(thread2) failed: %s\n", strerror(ret_thread));
+			close(sv[1]);
+			pthread_cancel(thread1);
+			exit(1);
+		}
+		fprintf(stderr, "Child: created thread2\n");
+
+		/* Wait for threads to complete - they will unblock when parent writes */
+		fprintf(stderr, "Child: waiting for threads to exit\n");
+		pthread_join(thread1, NULL);
+		fprintf(stderr, "Child: thread1 exited\n");
+		pthread_join(thread2, NULL);
+		fprintf(stderr, "Child: thread2 exited\n");
+
+		close(sv[1]);
+
+		/* Exit - namespaces should become inactive */
+		fprintf(stderr, "Child: all threads joined, exiting with success\n");
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+	close(sv[1]);
+
+	TH_LOG("Parent: waiting to read namespace IDs from child");
+
+	/* Read namespace IDs from child */
+	ret = read(pipefd[0], &user_id, sizeof(user_id));
+	if (ret != sizeof(user_id)) {
+		TH_LOG("Parent: failed to read user_id, ret=%d, errno=%s", ret, strerror(errno));
+		close(pipefd[0]);
+		sync_byte = 'X';
+		(void)write(sv[0], &sync_byte, 1);
+		close(sv[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read user namespace ID from child");
+	}
+
+	ret = read(pipefd[0], &net_id, sizeof(net_id));
+	close(pipefd[0]);
+	if (ret != sizeof(net_id)) {
+		TH_LOG("Parent: failed to read net_id, ret=%d, errno=%s", ret, strerror(errno));
+		sync_byte = 'X';
+		(void)write(sv[0], &sync_byte, 1);
+		close(sv[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read network namespace ID from child");
+	}
+
+	TH_LOG("Child created user ns %llu and net ns %llu with 2 threads",
+	       (unsigned long long)user_id, (unsigned long long)net_id);
+
+	/* Construct file handles */
+	user_handle = (struct file_handle *)user_buf;
+	user_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	user_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *user_fh = (struct nsfs_file_handle *)user_handle->f_handle;
+	user_fh->ns_id = user_id;
+	user_fh->ns_type = 0;
+	user_fh->ns_inum = 0;
+
+	net_handle = (struct file_handle *)net_buf;
+	net_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	net_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *net_fh = (struct nsfs_file_handle *)net_handle->f_handle;
+	net_fh->ns_id = net_id;
+	net_fh->ns_type = 0;
+	net_fh->ns_inum = 0;
+
+	/* Verify namespaces are active while subprocess and threads are alive */
+	TH_LOG("Verifying namespaces are active while subprocess with threads is running");
+	int user_fd = open_by_handle_at(FD_NSFS_ROOT, user_handle, O_RDONLY);
+	ASSERT_GE(user_fd, 0);
+
+	int net_fd = open_by_handle_at(FD_NSFS_ROOT, net_handle, O_RDONLY);
+	ASSERT_GE(net_fd, 0);
+
+	close(user_fd);
+	close(net_fd);
+
+	/* Also verify they appear in listns() */
+	TH_LOG("Verifying namespaces appear in listns() while active");
+	struct ns_id_req req = {
+		.size = sizeof(struct ns_id_req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWUSER,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids[256];
+	int nr_ids = sys_listns(&req, ns_ids, 256, 0);
+	if (nr_ids < 0) {
+		TH_LOG("listns() not available, skipping listns verification");
+	} else {
+		/* Check if user_id is in the list */
+		int found_user = 0;
+		for (int i = 0; i < nr_ids; i++) {
+			if (ns_ids[i] == user_id) {
+				found_user = 1;
+				break;
+			}
+		}
+		ASSERT_TRUE(found_user);
+		TH_LOG("User namespace found in listns() as expected");
+
+		/* Check network namespace */
+		req.ns_type = CLONE_NEWNET;
+		nr_ids = sys_listns(&req, ns_ids, 256, 0);
+		if (nr_ids >= 0) {
+			int found_net = 0;
+			for (int i = 0; i < nr_ids; i++) {
+				if (ns_ids[i] == net_id) {
+					found_net = 1;
+					break;
+				}
+			}
+			ASSERT_TRUE(found_net);
+			TH_LOG("Network namespace found in listns() as expected");
+		}
+	}
+
+	/* Signal threads to exit */
+	TH_LOG("Signaling threads to exit");
+	sync_byte = 'X';
+	/* Write two bytes - one for each thread */
+	ASSERT_EQ(write(sv[0], &sync_byte, 1), 1);
+	ASSERT_EQ(write(sv[0], &sync_byte, 1), 1);
+	close(sv[0]);
+
+	/* Wait for child process to exit */
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	if (WEXITSTATUS(status) != 0) {
+		TH_LOG("Child process failed with exit code %d", WEXITSTATUS(status));
+		SKIP(return, "Child process failed");
+	}
+
+	TH_LOG("Subprocess and all threads have exited successfully");
+
+	/* Verify namespaces are now inactive - open_by_handle_at should fail */
+	TH_LOG("Verifying namespaces are inactive after subprocess and threads exit");
+	user_fd = open_by_handle_at(FD_NSFS_ROOT, user_handle, O_RDONLY);
+	ASSERT_LT(user_fd, 0);
+	TH_LOG("User namespace inactive as expected: %s (errno=%d)",
+	       strerror(errno), errno);
+	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
+
+	net_fd = open_by_handle_at(FD_NSFS_ROOT, net_handle, O_RDONLY);
+	ASSERT_LT(net_fd, 0);
+	TH_LOG("Network namespace inactive as expected: %s (errno=%d)",
+	       strerror(errno), errno);
+	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
+
+	/* Verify namespaces do NOT appear in listns() */
+	TH_LOG("Verifying namespaces do NOT appear in listns() when inactive");
+	memset(&req, 0, sizeof(req));
+	req.size = sizeof(struct ns_id_req);
+	req.ns_type = CLONE_NEWUSER;
+	nr_ids = sys_listns(&req, ns_ids, 256, 0);
+	if (nr_ids >= 0) {
+		int found_user = 0;
+		for (int i = 0; i < nr_ids; i++) {
+			if (ns_ids[i] == user_id) {
+				found_user = 1;
+				break;
+			}
+		}
+		ASSERT_FALSE(found_user);
+		TH_LOG("User namespace correctly not listed in listns()");
+
+		/* Check network namespace */
+		req.ns_type = CLONE_NEWNET;
+		nr_ids = sys_listns(&req, ns_ids, 256, 0);
+		if (nr_ids >= 0) {
+			int found_net = 0;
+			for (int i = 0; i < nr_ids; i++) {
+				if (ns_ids[i] == net_id) {
+					found_net = 1;
+					break;
+				}
+			}
+			ASSERT_FALSE(found_net);
+			TH_LOG("Network namespace correctly not listed in listns()");
+		}
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


