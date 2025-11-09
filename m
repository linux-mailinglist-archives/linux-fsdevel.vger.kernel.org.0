Return-Path: <linux-fsdevel+bounces-67616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41894C44790
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 22:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98AA64ECE93
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 21:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B5E27FB37;
	Sun,  9 Nov 2025 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPMHRWMn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3483C263F38;
	Sun,  9 Nov 2025 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762722839; cv=none; b=myz+wL4YXDsg80rA5/Fzn1bRw1SvfXOBC5/IH5o1TreybJ3RLLdALkGCtcPo5Q07jPEeYav+kAMqnt8IMiWpLY2JD10STkBaJuBlmElGoVgl0TgsfMt1amgTgLHVbQY6xhPYk0oLthQEt76cRqtmDFBoxQS4VrUUoUUtHebaFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762722839; c=relaxed/simple;
	bh=6df/qcuFKGvBEaRawblBEmuTMzDVDKNeLPHCBkB1I/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WQViQ80hDM4Wu2sR2Cmak5jcwUEraoqXDQ6iErRbuDB0Tm78ZvQ0SiMoP0YwyVSCozJgEohYjgUCgExcKzYSJbcezfWREs/0P/f9/ICCeeokVLp+gyA/2GrpdhlaCkIBWltT8MlFn0NPOA4gLGOa5HGv22KFjCGNdwqSS9rXcQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPMHRWMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A511C19422;
	Sun,  9 Nov 2025 21:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762722839;
	bh=6df/qcuFKGvBEaRawblBEmuTMzDVDKNeLPHCBkB1I/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kPMHRWMn2qNPBQbx3/s6FWTdlMcKqgGs3J2KtkgmM/37ZuGssFcyEeNf4ld7rkol2
	 tlBY8sODrhh9bhmshSjMnUb/I18514YuDVSe/H5D14sTW7PxEb2NTdnrKrEBVUnByO
	 2pqQhUkrzngIslRqh5ZIFjCY+wSdrUcAfa3sijXF9DunDLOJIEqKNLIlaWfVuWy4Da
	 YZkSsERfIQ9IYKsXcF/0KDZNNOhiyEOhlaWBS/P+LCKn4PgvDgJk7CeoqAnkhyqCZA
	 QuLvHCVX4dU49zWFV6U+HOxgHt2lbXPUfHHWa5sh3KqnnKF7T8GfvjjxqyFGFlJ8qc
	 C8OpcOmNiAhjQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 09 Nov 2025 22:11:29 +0100
Subject: [PATCH 8/8] selftests/namespaces: test for efault
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-namespace-6-19-fixes-v1-8-ae8a4ad5a3b3@kernel.org>
References: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
In-Reply-To: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
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
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=15334; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6df/qcuFKGvBEaRawblBEmuTMzDVDKNeLPHCBkB1I/Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKMr+IvxG5/LPH+WUSBQa/jikzXV358EH6s8zJv/rrN
 s9m/6jO01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRCdyMDH/Td9k1MwoF+X7P
 1upgbXm66m5gIsNKrRNJpzgcNq1WmsLwT2vGTf3ad6sj94W2/XdIm//stl7HZ+eP6vMl2c8uPDs
 9kAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Ensure that put_user() can fail and that namespace cleanup works
correctly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/.gitignore      |   1 +
 tools/testing/selftests/namespaces/Makefile        |   2 +
 .../selftests/namespaces/listns_efault_test.c      | 521 +++++++++++++++++++++
 3 files changed, 524 insertions(+)

diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testing/selftests/namespaces/.gitignore
index 4cb428d77659..0989e80da457 100644
--- a/tools/testing/selftests/namespaces/.gitignore
+++ b/tools/testing/selftests/namespaces/.gitignore
@@ -4,6 +4,7 @@ init_ino_test
 ns_active_ref_test
 listns_test
 listns_permissions_test
+listns_efault_test
 siocgskns_test
 cred_change_test
 stress_test
diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/selftests/namespaces/Makefile
index 1f36c7bf7728..fbb821652c17 100644
--- a/tools/testing/selftests/namespaces/Makefile
+++ b/tools/testing/selftests/namespaces/Makefile
@@ -8,6 +8,7 @@ TEST_GEN_PROGS := nsid_test \
 		  ns_active_ref_test \
 		  listns_test \
 		  listns_permissions_test \
+		  listns_efault_test \
 		  siocgskns_test \
 		  cred_change_test \
 		  stress_test \
@@ -19,6 +20,7 @@ include ../lib.mk
 $(OUTPUT)/ns_active_ref_test: ../filesystems/utils.c
 $(OUTPUT)/listns_test: ../filesystems/utils.c
 $(OUTPUT)/listns_permissions_test: ../filesystems/utils.c
+$(OUTPUT)/listns_efault_test: ../filesystems/utils.c
 $(OUTPUT)/siocgskns_test: ../filesystems/utils.c
 $(OUTPUT)/cred_change_test: ../filesystems/utils.c
 $(OUTPUT)/stress_test: ../filesystems/utils.c
diff --git a/tools/testing/selftests/namespaces/listns_efault_test.c b/tools/testing/selftests/namespaces/listns_efault_test.c
new file mode 100644
index 000000000000..906d8df90ab2
--- /dev/null
+++ b/tools/testing/selftests/namespaces/listns_efault_test.c
@@ -0,0 +1,521 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/nsfs.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "../kselftest_harness.h"
+#include "../filesystems/utils.h"
+#include "../pidfd/pidfd.h"
+#include "wrappers.h"
+
+/*
+ * Test listns() error handling with invalid buffer addresses.
+ *
+ * When the buffer pointer is invalid (e.g., crossing page boundaries
+ * into unmapped memory), listns() returns EINVAL.
+ *
+ * This test also creates mount namespaces that get destroyed during
+ * iteration, testing that namespace cleanup happens outside the RCU
+ * read lock.
+ */
+TEST(listns_partial_fault_with_ns_cleanup)
+{
+	void *map;
+	__u64 *ns_ids;
+	ssize_t ret;
+	long page_size;
+	pid_t pid, iter_pid;
+	int pidfds[5];
+	int sv[5][2];
+	int iter_pidfd;
+	int i, status;
+	char c;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	ASSERT_GT(page_size, 0);
+
+	/*
+	 * Map two pages:
+	 * - First page: readable and writable
+	 * - Second page: will be unmapped to trigger EFAULT
+	 */
+	map = mmap(NULL, page_size * 2, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(map, MAP_FAILED);
+
+	/* Unmap the second page */
+	ret = munmap((char *)map + page_size, page_size);
+	ASSERT_EQ(ret, 0);
+
+	/*
+	 * Position the buffer pointer so there's room for exactly one u64
+	 * before the page boundary. The second u64 would fall into the
+	 * unmapped page.
+	 */
+	ns_ids = ((__u64 *)((char *)map + page_size)) - 1;
+
+	/*
+	 * Create a separate process to run listns() in a loop concurrently
+	 * with namespace creation and destruction.
+	 */
+	iter_pid = create_child(&iter_pidfd, 0);
+	ASSERT_NE(iter_pid, -1);
+
+	if (iter_pid == 0) {
+		struct ns_id_req req = {
+			.size = sizeof(req),
+			.spare = 0,
+			.ns_id = 0,
+			.ns_type = 0,  /* All types */
+			.spare2 = 0,
+			.user_ns_id = 0,  /* Global listing */
+		};
+		int iter_ret;
+
+		/*
+		 * Loop calling listns() until killed.
+		 * The kernel should:
+		 * 1. Successfully write the first namespace ID (within valid page)
+		 * 2. Fail with EFAULT when trying to write the second ID (unmapped page)
+		 * 3. Handle concurrent namespace destruction without deadlock
+		 */
+		while (1) {
+			iter_ret = sys_listns(&req, ns_ids, 2, 0);
+
+			if (iter_ret == -1 && errno == ENOSYS)
+				_exit(PIDFD_SKIP);
+		}
+	}
+
+	/* Small delay to let iterator start looping */
+	usleep(50000);
+
+	/*
+	 * Create several child processes, each in its own mount namespace.
+	 * These will be destroyed while the iterator is running listns().
+	 */
+	for (i = 0; i < 5; i++) {
+		/* Create socketpair for synchronization */
+		ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sv[i]), 0);
+
+		pid = create_child(&pidfds[i], CLONE_NEWNS);
+		ASSERT_NE(pid, -1);
+
+		if (pid == 0) {
+			close(sv[i][0]); /* Close parent end */
+
+			/* Child: create a couple of tmpfs mounts */
+			if (mkdir("/tmp/test_mnt1", 0755) == -1 && errno != EEXIST)
+				_exit(1);
+			if (mkdir("/tmp/test_mnt2", 0755) == -1 && errno != EEXIST)
+				_exit(1);
+
+			if (mount("tmpfs", "/tmp/test_mnt1", "tmpfs", 0, NULL) == -1)
+				_exit(1);
+			if (mount("tmpfs", "/tmp/test_mnt2", "tmpfs", 0, NULL) == -1)
+				_exit(1);
+
+			/* Signal parent that setup is complete */
+			if (write_nointr(sv[i][1], "R", 1) != 1)
+				_exit(1);
+
+			/* Wait for parent to signal us to exit */
+			if (read_nointr(sv[i][1], &c, 1) != 1)
+				_exit(1);
+
+			close(sv[i][1]);
+			_exit(0);
+		}
+
+		close(sv[i][1]); /* Close child end */
+	}
+
+	/* Wait for all children to finish setup */
+	for (i = 0; i < 5; i++) {
+		ret = read_nointr(sv[i][0], &c, 1);
+		ASSERT_EQ(ret, 1);
+		ASSERT_EQ(c, 'R');
+	}
+
+	/*
+	 * Signal children to exit. This will destroy their mount namespaces
+	 * while listns() is iterating the namespace tree.
+	 * This tests that cleanup happens outside the RCU read lock.
+	 */
+	for (i = 0; i < 5; i++)
+		write_nointr(sv[i][0], "X", 1);
+
+	/* Wait for all mount namespace children to exit and cleanup */
+	for (i = 0; i < 5; i++) {
+		waitpid(-1, NULL, 0);
+		close(sv[i][0]);
+		close(pidfds[i]);
+	}
+
+	/* Kill iterator and wait for it */
+	sys_pidfd_send_signal(iter_pidfd, SIGKILL, NULL, 0);
+	ret = waitpid(iter_pid, &status, 0);
+	ASSERT_EQ(ret, iter_pid);
+	close(iter_pidfd);
+
+	/* Should have been killed */
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_EQ(WTERMSIG(status), SIGKILL);
+
+	/* Clean up */
+	munmap(map, page_size);
+}
+
+/*
+ * Test listns() error handling when the entire buffer is invalid.
+ * This is a sanity check that basic invalid pointer detection works.
+ */
+TEST(listns_complete_fault)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 *ns_ids;
+	ssize_t ret;
+
+	/* Use a clearly invalid pointer */
+	ns_ids = (__u64 *)0xdeadbeef;
+
+	ret = sys_listns(&req, ns_ids, 10, 0);
+
+	if (ret == -1 && errno == ENOSYS)
+		SKIP(return, "listns() not supported");
+
+	/* Should fail with EFAULT */
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EFAULT);
+}
+
+/*
+ * Test listns() error handling when the buffer is NULL.
+ */
+TEST(listns_null_buffer)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	ssize_t ret;
+
+	/* NULL buffer with non-zero count should fail */
+	ret = sys_listns(&req, NULL, 10, 0);
+
+	if (ret == -1 && errno == ENOSYS)
+		SKIP(return, "listns() not supported");
+
+	/* Should fail with EFAULT */
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EFAULT);
+}
+
+/*
+ * Test listns() with a buffer that becomes invalid mid-iteration
+ * (after several successful writes), combined with mount namespace
+ * destruction to test RCU cleanup logic.
+ */
+TEST(listns_late_fault_with_ns_cleanup)
+{
+	void *map;
+	__u64 *ns_ids;
+	ssize_t ret;
+	long page_size;
+	pid_t pid, iter_pid;
+	int pidfds[10];
+	int sv[10][2];
+	int iter_pidfd;
+	int i, status;
+	char c;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	ASSERT_GT(page_size, 0);
+
+	/* Map two pages */
+	map = mmap(NULL, page_size * 2, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(map, MAP_FAILED);
+
+	/* Unmap the second page */
+	ret = munmap((char *)map + page_size, page_size);
+	ASSERT_EQ(ret, 0);
+
+	/*
+	 * Position buffer so we can write several u64s successfully
+	 * before hitting the page boundary.
+	 */
+	ns_ids = ((__u64 *)((char *)map + page_size)) - 5;
+
+	/*
+	 * Create a separate process to run listns() concurrently.
+	 */
+	iter_pid = create_child(&iter_pidfd, 0);
+	ASSERT_NE(iter_pid, -1);
+
+	if (iter_pid == 0) {
+		struct ns_id_req req = {
+			.size = sizeof(req),
+			.spare = 0,
+			.ns_id = 0,
+			.ns_type = 0,
+			.spare2 = 0,
+			.user_ns_id = 0,
+		};
+		int iter_ret;
+
+		/*
+		 * Loop calling listns() until killed.
+		 * Request 10 namespace IDs while namespaces are being destroyed.
+		 * This tests:
+		 * 1. EFAULT handling when buffer becomes invalid
+		 * 2. Namespace cleanup outside RCU read lock during iteration
+		 */
+		while (1) {
+			iter_ret = sys_listns(&req, ns_ids, 10, 0);
+
+			if (iter_ret == -1 && errno == ENOSYS)
+				_exit(PIDFD_SKIP);
+		}
+	}
+
+	/* Small delay to let iterator start looping */
+	usleep(50000);
+
+	/*
+	 * Create more children with mount namespaces to increase the
+	 * likelihood that namespace cleanup happens during iteration.
+	 */
+	for (i = 0; i < 10; i++) {
+		/* Create socketpair for synchronization */
+		ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sv[i]), 0);
+
+		pid = create_child(&pidfds[i], CLONE_NEWNS);
+		ASSERT_NE(pid, -1);
+
+		if (pid == 0) {
+			close(sv[i][0]); /* Close parent end */
+
+			/* Child: create tmpfs mounts */
+			if (mkdir("/tmp/test_mnt1", 0755) == -1 && errno != EEXIST)
+				_exit(1);
+			if (mkdir("/tmp/test_mnt2", 0755) == -1 && errno != EEXIST)
+				_exit(1);
+
+			if (mount("tmpfs", "/tmp/test_mnt1", "tmpfs", 0, NULL) == -1)
+				_exit(1);
+			if (mount("tmpfs", "/tmp/test_mnt2", "tmpfs", 0, NULL) == -1)
+				_exit(1);
+
+			/* Signal parent that setup is complete */
+			if (write_nointr(sv[i][1], "R", 1) != 1)
+				_exit(1);
+
+			/* Wait for parent to signal us to exit */
+			if (read_nointr(sv[i][1], &c, 1) != 1)
+				_exit(1);
+
+			close(sv[i][1]);
+			_exit(0);
+		}
+
+		close(sv[i][1]); /* Close child end */
+	}
+
+	/* Wait for all children to finish setup */
+	for (i = 0; i < 10; i++) {
+		ret = read_nointr(sv[i][0], &c, 1);
+		ASSERT_EQ(ret, 1);
+		ASSERT_EQ(c, 'R');
+	}
+
+	/* Kill half the children */
+	for (i = 0; i < 5; i++)
+		write_nointr(sv[i][0], "X", 1);
+
+	/* Small delay to let some exit */
+	usleep(10000);
+
+	/* Kill remaining children */
+	for (i = 5; i < 10; i++)
+		write_nointr(sv[i][0], "X", 1);
+
+	/* Wait for all children and cleanup */
+	for (i = 0; i < 10; i++) {
+		waitpid(-1, NULL, 0);
+		close(sv[i][0]);
+		close(pidfds[i]);
+	}
+
+	/* Kill iterator and wait for it */
+	sys_pidfd_send_signal(iter_pidfd, SIGKILL, NULL, 0);
+	ret = waitpid(iter_pid, &status, 0);
+	ASSERT_EQ(ret, iter_pid);
+	close(iter_pidfd);
+
+	/* Should have been killed */
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_EQ(WTERMSIG(status), SIGKILL);
+
+	/* Clean up */
+	munmap(map, page_size);
+}
+
+/*
+ * Test specifically focused on mount namespace cleanup during EFAULT.
+ * Filter for mount namespaces only.
+ */
+TEST(listns_mnt_ns_cleanup_on_fault)
+{
+	void *map;
+	__u64 *ns_ids;
+	ssize_t ret;
+	long page_size;
+	pid_t pid, iter_pid;
+	int pidfds[8];
+	int sv[8][2];
+	int iter_pidfd;
+	int i, status;
+	char c;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	ASSERT_GT(page_size, 0);
+
+	/* Set up partial fault buffer */
+	map = mmap(NULL, page_size * 2, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(map, MAP_FAILED);
+
+	ret = munmap((char *)map + page_size, page_size);
+	ASSERT_EQ(ret, 0);
+
+	/* Position for 3 successful writes, then fault */
+	ns_ids = ((__u64 *)((char *)map + page_size)) - 3;
+
+	/*
+	 * Create a separate process to run listns() concurrently.
+	 */
+	iter_pid = create_child(&iter_pidfd, 0);
+	ASSERT_NE(iter_pid, -1);
+
+	if (iter_pid == 0) {
+		struct ns_id_req req = {
+			.size = sizeof(req),
+			.spare = 0,
+			.ns_id = 0,
+			.ns_type = CLONE_NEWNS,  /* Only mount namespaces */
+			.spare2 = 0,
+			.user_ns_id = 0,
+		};
+		int iter_ret;
+
+		/*
+		 * Loop calling listns() until killed.
+		 * Call listns() to race with namespace destruction.
+		 */
+		while (1) {
+			iter_ret = sys_listns(&req, ns_ids, 10, 0);
+
+			if (iter_ret == -1 && errno == ENOSYS)
+				_exit(PIDFD_SKIP);
+		}
+	}
+
+	/* Small delay to let iterator start looping */
+	usleep(50000);
+
+	/* Create children with mount namespaces */
+	for (i = 0; i < 8; i++) {
+		/* Create socketpair for synchronization */
+		ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sv[i]), 0);
+
+		pid = create_child(&pidfds[i], CLONE_NEWNS);
+		ASSERT_NE(pid, -1);
+
+		if (pid == 0) {
+			close(sv[i][0]); /* Close parent end */
+
+			/* Do some mount operations to make cleanup more interesting */
+			if (mkdir("/tmp/test_mnt1", 0755) == -1 && errno != EEXIST)
+				_exit(1);
+			if (mkdir("/tmp/test_mnt2", 0755) == -1 && errno != EEXIST)
+				_exit(1);
+
+			if (mount("tmpfs", "/tmp/test_mnt1", "tmpfs", 0, NULL) == -1)
+				_exit(1);
+			if (mount("tmpfs", "/tmp/test_mnt2", "tmpfs", 0, NULL) == -1)
+				_exit(1);
+
+			/* Signal parent that setup is complete */
+			if (write_nointr(sv[i][1], "R", 1) != 1)
+				_exit(1);
+
+			/* Wait for parent to signal us to exit */
+			if (read_nointr(sv[i][1], &c, 1) != 1)
+				_exit(1);
+
+			close(sv[i][1]);
+			_exit(0);
+		}
+
+		close(sv[i][1]); /* Close child end */
+	}
+
+	/* Wait for all children to finish setup */
+	for (i = 0; i < 8; i++) {
+		ret = read_nointr(sv[i][0], &c, 1);
+		ASSERT_EQ(ret, 1);
+		ASSERT_EQ(c, 'R');
+	}
+
+	/* Kill children to trigger namespace destruction during iteration */
+	for (i = 0; i < 8; i++)
+		write_nointr(sv[i][0], "X", 1);
+
+	/* Wait for children and cleanup */
+	for (i = 0; i < 8; i++) {
+		waitpid(-1, NULL, 0);
+		close(sv[i][0]);
+		close(pidfds[i]);
+	}
+
+	/* Kill iterator and wait for it */
+	sys_pidfd_send_signal(iter_pidfd, SIGKILL, NULL, 0);
+	ret = waitpid(iter_pid, &status, 0);
+	ASSERT_EQ(ret, iter_pid);
+	close(iter_pidfd);
+
+	/* Should have been killed */
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_EQ(WTERMSIG(status), SIGKILL);
+
+	munmap(map, page_size);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


