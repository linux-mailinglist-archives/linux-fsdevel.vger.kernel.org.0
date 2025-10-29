Return-Path: <linux-fsdevel+bounces-66283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B99C1A973
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D990C581EC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32C03683A4;
	Wed, 29 Oct 2025 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3eeTXXq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F0D368386;
	Wed, 29 Oct 2025 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740794; cv=none; b=LiBx81vf9bWltIbRIxY8PxPDPaAKAjlSU0M63lQg4ORqC69HMSIU3N5BonIB+SRfFEkwGJl2o95ueLpUTZwgsy1pH3vKThcvQv2cTavmDdAl5Yn4JVbU8rgRdU2LPWOEzhFod8otok6YPQ5Kvo18Pzn/WluEc3FlXi5lOl9mq4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740794; c=relaxed/simple;
	bh=VQz+kdDDu0oyl8QafRMlRfX35XuungB3DQURbW3q4p0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSKQOwEkOkSOnZX1u5Dry64+azOH7y4BpTj6XXs6kcMetVIqUe+BY2lHPuO03AM5N422JSmuBbcc+DxMEGgb2NJsg/dssyaEvq392rkf3fLmwNkPg8vkvHthVJAUNxP3WH/TaWLDyaW+AMSMvudOOj6BymQqD+KDakGcxH/K8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3eeTXXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B50C4CEFD;
	Wed, 29 Oct 2025 12:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740793;
	bh=VQz+kdDDu0oyl8QafRMlRfX35XuungB3DQURbW3q4p0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K3eeTXXqYfguuAWTotQcQmMtGakPYwNgF17YZEH1wd34OmpD2nkUJ3bYEG+LED6Jv
	 B5I++twudwZ2hoYLSDEJUtr+qmo0sz+flNeByEAYwSckHgTYeaM5LjGAxFvachvK/v
	 PBtrFLNYTjiooXXv75gsSux1yqOliWRWt/dONw6kG7KhRA6tHtzSr757ebN05qwLfy
	 7QcydsPfskEcLPRiYJ++6XEwtD2OMkhrHDC0cUgG+XqEkm1DsFa/nXPtyLHnJi81Qp
	 fan6XHjTErxfg0nt3lv7HZTEcr1/wOGQqJpAEIPztBZgh4JlSfnUofpu24qmTOAygW
	 mL8RSoAIYnJpw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:23 +0100
Subject: [PATCH v4 70/72] selftests/namespace: commit_creds() active
 reference tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-70-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=20385; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VQz+kdDDu0oyl8QafRMlRfX35XuungB3DQURbW3q4p0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysU0IzjD492iTUo/9u/pz1/OP21vpvers4k/j9P2zc
 dODcw+9OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYinsbI8OZO+5Pu+ukl3Zl1
 bg4f385IOPzy4jK2pH8vzVtjTs7WvcrI8NvtzvHfUUp7Rd/Hn7fIUNE/PeEpl9V22wcnM+TfqE9
 v4QcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test credential changes and their impact on namespace active references.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/.gitignore      |   1 +
 tools/testing/selftests/namespaces/Makefile        |   4 +-
 .../selftests/namespaces/cred_change_test.c        | 814 +++++++++++++++++++++
 3 files changed, 818 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testing/selftests/namespaces/.gitignore
index aeb5f2711ff6..0091a7dfff20 100644
--- a/tools/testing/selftests/namespaces/.gitignore
+++ b/tools/testing/selftests/namespaces/.gitignore
@@ -5,3 +5,4 @@ ns_active_ref_test
 listns_test
 listns_permissions_test
 siocgskns_test
+cred_change_test
diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/selftests/namespaces/Makefile
index d456505189cd..5d73f8dde6a0 100644
--- a/tools/testing/selftests/namespaces/Makefile
+++ b/tools/testing/selftests/namespaces/Makefile
@@ -8,7 +8,8 @@ TEST_GEN_PROGS := nsid_test \
 		  ns_active_ref_test \
 		  listns_test \
 		  listns_permissions_test \
-		  siocgskns_test
+		  siocgskns_test \
+		  cred_change_test
 
 include ../lib.mk
 
@@ -16,4 +17,5 @@ $(OUTPUT)/ns_active_ref_test: ../filesystems/utils.c
 $(OUTPUT)/listns_test: ../filesystems/utils.c
 $(OUTPUT)/listns_permissions_test: ../filesystems/utils.c
 $(OUTPUT)/siocgskns_test: ../filesystems/utils.c
+$(OUTPUT)/cred_change_test: ../filesystems/utils.c
 
diff --git a/tools/testing/selftests/namespaces/cred_change_test.c b/tools/testing/selftests/namespaces/cred_change_test.c
new file mode 100644
index 000000000000..7b4f5ad3f725
--- /dev/null
+++ b/tools/testing/selftests/namespaces/cred_change_test.c
@@ -0,0 +1,814 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/capability.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <linux/nsfs.h>
+#include "../kselftest_harness.h"
+#include "../filesystems/utils.h"
+#include "wrappers.h"
+
+/*
+ * Test credential changes and their impact on namespace active references.
+ */
+
+/*
+ * Test setuid() in a user namespace properly swaps active references.
+ * Create a user namespace with multiple UIDs mapped, then setuid() between them.
+ * Verify that the user namespace remains active throughout.
+ */
+TEST(setuid_preserves_active_refs)
+{
+	pid_t pid;
+	int status;
+	__u64 userns_id;
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWUSER,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids[256];
+	ssize_t ret;
+	int i;
+	bool found = false;
+	int pipefd[2];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		int fd, userns_fd;
+		__u64 child_userns_id;
+		uid_t orig_uid = getuid();
+		int setuid_count;
+
+		close(pipefd[0]);
+
+		/* Create new user namespace with multiple UIDs mapped (0-9) */
+		userns_fd = get_userns_fd(0, orig_uid, 10);
+		if (userns_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (setns(userns_fd, CLONE_NEWUSER) < 0) {
+			close(userns_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(userns_fd);
+
+		/* Get user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &child_userns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Send namespace ID to parent */
+		write(pipefd[1], &child_userns_id, sizeof(child_userns_id));
+
+		/*
+		 * Perform multiple setuid() calls.
+		 * Each setuid() triggers commit_creds() which should properly
+		 * swap active references via switch_cred_namespaces().
+		 */
+		for (setuid_count = 0; setuid_count < 50; setuid_count++) {
+			uid_t target_uid = (setuid_count % 10);
+			if (setuid(target_uid) < 0) {
+				if (errno != EPERM) {
+					close(pipefd[1]);
+					exit(1);
+				}
+			}
+		}
+
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	if (read(pipefd[0], &userns_id, sizeof(userns_id)) != sizeof(userns_id)) {
+		close(pipefd[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to get namespace ID from child");
+	}
+	close(pipefd[0]);
+
+	TH_LOG("Child user namespace ID: %llu", (unsigned long long)userns_id);
+
+	/* Verify namespace is active while child is running */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		ASSERT_GE(ret, 0);
+	}
+
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == userns_id) {
+			found = true;
+			break;
+		}
+	}
+	ASSERT_TRUE(found);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	/* Verify namespace becomes inactive after child exits */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	ASSERT_GE(ret, 0);
+
+	found = false;
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == userns_id) {
+			found = true;
+			break;
+		}
+	}
+
+	ASSERT_FALSE(found);
+	TH_LOG("setuid() correctly preserved active references (no leak)");
+}
+
+/*
+ * Test setgid() in a user namespace properly handles active references.
+ */
+TEST(setgid_preserves_active_refs)
+{
+	pid_t pid;
+	int status;
+	__u64 userns_id;
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWUSER,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids[256];
+	ssize_t ret;
+	int i;
+	bool found = false;
+	int pipefd[2];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		int fd, userns_fd;
+		__u64 child_userns_id;
+		uid_t orig_uid = getuid();
+		int setgid_count;
+
+		close(pipefd[0]);
+
+		/* Create new user namespace with multiple GIDs mapped */
+		userns_fd = get_userns_fd(0, orig_uid, 10);
+		if (userns_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (setns(userns_fd, CLONE_NEWUSER) < 0) {
+			close(userns_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(userns_fd);
+
+		/* Get user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &child_userns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		write(pipefd[1], &child_userns_id, sizeof(child_userns_id));
+
+		/* Perform multiple setgid() calls */
+		for (setgid_count = 0; setgid_count < 50; setgid_count++) {
+			gid_t target_gid = (setgid_count % 10);
+			if (setgid(target_gid) < 0) {
+				if (errno != EPERM) {
+					close(pipefd[1]);
+					exit(1);
+				}
+			}
+		}
+
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	if (read(pipefd[0], &userns_id, sizeof(userns_id)) != sizeof(userns_id)) {
+		close(pipefd[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to get namespace ID from child");
+	}
+	close(pipefd[0]);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	/* Verify namespace becomes inactive */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		ASSERT_GE(ret, 0);
+	}
+
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == userns_id) {
+			found = true;
+			break;
+		}
+	}
+
+	ASSERT_FALSE(found);
+	TH_LOG("setgid() correctly preserved active references (no leak)");
+}
+
+/*
+ * Test setresuid() which changes real, effective, and saved UIDs.
+ * This should properly swap active references via commit_creds().
+ */
+TEST(setresuid_preserves_active_refs)
+{
+	pid_t pid;
+	int status;
+	__u64 userns_id;
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWUSER,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids[256];
+	ssize_t ret;
+	int i;
+	bool found = false;
+	int pipefd[2];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		int fd, userns_fd;
+		__u64 child_userns_id;
+		uid_t orig_uid = getuid();
+		int setres_count;
+
+		close(pipefd[0]);
+
+		/* Create new user namespace */
+		userns_fd = get_userns_fd(0, orig_uid, 10);
+		if (userns_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (setns(userns_fd, CLONE_NEWUSER) < 0) {
+			close(userns_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(userns_fd);
+
+		/* Get user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &child_userns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		write(pipefd[1], &child_userns_id, sizeof(child_userns_id));
+
+		/* Perform multiple setresuid() calls */
+		for (setres_count = 0; setres_count < 30; setres_count++) {
+			uid_t uid1 = (setres_count % 5);
+			uid_t uid2 = ((setres_count + 1) % 5);
+			uid_t uid3 = ((setres_count + 2) % 5);
+
+			if (setresuid(uid1, uid2, uid3) < 0) {
+				if (errno != EPERM) {
+					close(pipefd[1]);
+					exit(1);
+				}
+			}
+		}
+
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	if (read(pipefd[0], &userns_id, sizeof(userns_id)) != sizeof(userns_id)) {
+		close(pipefd[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to get namespace ID from child");
+	}
+	close(pipefd[0]);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	/* Verify namespace becomes inactive */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		ASSERT_GE(ret, 0);
+	}
+
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == userns_id) {
+			found = true;
+			break;
+		}
+	}
+
+	ASSERT_FALSE(found);
+	TH_LOG("setresuid() correctly preserved active references (no leak)");
+}
+
+/*
+ * Test credential changes across multiple user namespaces.
+ * Create nested user namespaces and verify active reference tracking.
+ */
+TEST(cred_change_nested_userns)
+{
+	pid_t pid;
+	int status;
+	__u64 parent_userns_id, child_userns_id;
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWUSER,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids[256];
+	ssize_t ret;
+	int i;
+	bool found_parent = false, found_child = false;
+	int pipefd[2];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		int fd, userns_fd;
+		__u64 parent_id, child_id;
+		uid_t orig_uid = getuid();
+
+		close(pipefd[0]);
+
+		/* Create first user namespace */
+		userns_fd = get_userns_fd(0, orig_uid, 1);
+		if (userns_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (setns(userns_fd, CLONE_NEWUSER) < 0) {
+			close(userns_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(userns_fd);
+
+		/* Get first namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &parent_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Create nested user namespace */
+		userns_fd = get_userns_fd(0, 0, 1);
+		if (userns_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (setns(userns_fd, CLONE_NEWUSER) < 0) {
+			close(userns_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(userns_fd);
+
+		/* Get nested namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &child_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Send both IDs to parent */
+		write(pipefd[1], &parent_id, sizeof(parent_id));
+		write(pipefd[1], &child_id, sizeof(child_id));
+
+		/* Perform some credential changes in nested namespace */
+		setuid(0);
+		setgid(0);
+
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	/* Read both namespace IDs */
+	if (read(pipefd[0], &parent_userns_id, sizeof(parent_userns_id)) != sizeof(parent_userns_id)) {
+		close(pipefd[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to get parent namespace ID");
+	}
+
+	if (read(pipefd[0], &child_userns_id, sizeof(child_userns_id)) != sizeof(child_userns_id)) {
+		close(pipefd[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to get child namespace ID");
+	}
+	close(pipefd[0]);
+
+	TH_LOG("Parent userns: %llu, Child userns: %llu",
+	       (unsigned long long)parent_userns_id,
+	       (unsigned long long)child_userns_id);
+
+	/* Verify both namespaces are active */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		ASSERT_GE(ret, 0);
+	}
+
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == parent_userns_id)
+			found_parent = true;
+		if (ns_ids[i] == child_userns_id)
+			found_child = true;
+	}
+
+	ASSERT_TRUE(found_parent);
+	ASSERT_TRUE(found_child);
+
+	/* Wait for child */
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	/* Verify both namespaces become inactive */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	ASSERT_GE(ret, 0);
+
+	found_parent = false;
+	found_child = false;
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == parent_userns_id)
+			found_parent = true;
+		if (ns_ids[i] == child_userns_id)
+			found_child = true;
+	}
+
+	ASSERT_FALSE(found_parent);
+	ASSERT_FALSE(found_child);
+	TH_LOG("Nested user namespace credential changes preserved active refs (no leak)");
+}
+
+/*
+ * Test rapid credential changes don't cause refcount imbalances.
+ * This stress-tests the switch_cred_namespaces() logic.
+ */
+TEST(rapid_cred_changes_no_leak)
+{
+	pid_t pid;
+	int status;
+	__u64 userns_id;
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWUSER,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids[256];
+	ssize_t ret;
+	int i;
+	bool found = false;
+	int pipefd[2];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		int fd, userns_fd;
+		__u64 child_userns_id;
+		uid_t orig_uid = getuid();
+		int change_count;
+
+		close(pipefd[0]);
+
+		/* Create new user namespace with wider range of UIDs/GIDs */
+		userns_fd = get_userns_fd(0, orig_uid, 100);
+		if (userns_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (setns(userns_fd, CLONE_NEWUSER) < 0) {
+			close(userns_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(userns_fd);
+
+		/* Get user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &child_userns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		write(pipefd[1], &child_userns_id, sizeof(child_userns_id));
+
+		/*
+		 * Perform many rapid credential changes.
+		 * Mix setuid, setgid, setreuid, setregid, setresuid, setresgid.
+		 */
+		for (change_count = 0; change_count < 200; change_count++) {
+			switch (change_count % 6) {
+			case 0:
+				setuid(change_count % 50);
+				break;
+			case 1:
+				setgid(change_count % 50);
+				break;
+			case 2:
+				setreuid(change_count % 50, (change_count + 1) % 50);
+				break;
+			case 3:
+				setregid(change_count % 50, (change_count + 1) % 50);
+				break;
+			case 4:
+				setresuid(change_count % 50, (change_count + 1) % 50, (change_count + 2) % 50);
+				break;
+			case 5:
+				setresgid(change_count % 50, (change_count + 1) % 50, (change_count + 2) % 50);
+				break;
+			}
+		}
+
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	if (read(pipefd[0], &userns_id, sizeof(userns_id)) != sizeof(userns_id)) {
+		close(pipefd[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to get namespace ID from child");
+	}
+	close(pipefd[0]);
+
+	TH_LOG("Testing with user namespace ID: %llu", (unsigned long long)userns_id);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	/* Verify namespace becomes inactive (no leaked active refs) */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		ASSERT_GE(ret, 0);
+	}
+
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == userns_id) {
+			found = true;
+			break;
+		}
+	}
+
+	ASSERT_FALSE(found);
+	TH_LOG("200 rapid credential changes completed with no active ref leak");
+}
+
+/*
+ * Test setfsuid/setfsgid which change filesystem UID/GID.
+ * These also trigger credential changes but may have different code paths.
+ */
+TEST(setfsuid_preserves_active_refs)
+{
+	pid_t pid;
+	int status;
+	__u64 userns_id;
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWUSER,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids[256];
+	ssize_t ret;
+	int i;
+	bool found = false;
+	int pipefd[2];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		int fd, userns_fd;
+		__u64 child_userns_id;
+		uid_t orig_uid = getuid();
+		int change_count;
+
+		close(pipefd[0]);
+
+		/* Create new user namespace */
+		userns_fd = get_userns_fd(0, orig_uid, 10);
+		if (userns_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (setns(userns_fd, CLONE_NEWUSER) < 0) {
+			close(userns_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(userns_fd);
+
+		/* Get user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &child_userns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		write(pipefd[1], &child_userns_id, sizeof(child_userns_id));
+
+		/* Perform multiple setfsuid/setfsgid calls */
+		for (change_count = 0; change_count < 50; change_count++) {
+			setfsuid(change_count % 10);
+			setfsgid(change_count % 10);
+		}
+
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	if (read(pipefd[0], &userns_id, sizeof(userns_id)) != sizeof(userns_id)) {
+		close(pipefd[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to get namespace ID from child");
+	}
+	close(pipefd[0]);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	/* Verify namespace becomes inactive */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		ASSERT_GE(ret, 0);
+	}
+
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == userns_id) {
+			found = true;
+			break;
+		}
+	}
+
+	ASSERT_FALSE(found);
+	TH_LOG("setfsuid/setfsgid correctly preserved active references (no leak)");
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


