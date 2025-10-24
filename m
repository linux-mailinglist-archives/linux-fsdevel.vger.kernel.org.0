Return-Path: <linux-fsdevel+bounces-65509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8567C05FEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2563C3AD9D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D10937575E;
	Fri, 24 Oct 2025 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6ixUWbg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5D375746;
	Fri, 24 Oct 2025 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303560; cv=none; b=YtGemGnPI+vu4EsNoUZYKD9gdU/fgs1l6qP+lN2dLZG84rw2tcoYP15saxI/blBAJFfPXi423rJaQOq9Si4HpANg/disJR/vahWKa/nB3NshCMUBCIydBvac7NwSgFvxX6BW2bLvkS+8L8Cb2YxGaPXXMxA/OHSZN3DI7WMyyY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303560; c=relaxed/simple;
	bh=g358ZvosiSM60y9eCxcqiXUo4S81KVXpq23srWS/+30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zj6MtPOqZT3m7x8oF4E787Y/izD3OGqL8P2prqybPQNN4dQ4msm7E8Vnc04f9886kFnAeMF0KlJiTjSk+YcXx3PiBfQRTCNnSMmNi8W5At1uOgOYSviLFdjkTNFr4CZPKBcwAfeqc8fsGYo2BeMGD7cfiDVGci5cpSNra5pZ4MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6ixUWbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1C0C4CEF5;
	Fri, 24 Oct 2025 10:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303560;
	bh=g358ZvosiSM60y9eCxcqiXUo4S81KVXpq23srWS/+30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y6ixUWbgyKD2ZWAR//MpakCyyePuxVTbyyzuhaYGU20BEjxPnPRvXrqF03McsRUOY
	 wypYDtbFYLOFs2t+olXG4okfek4FDTR3ALo3qLlPP1otez77M98b3hMRcEzrx0Wt28
	 MUWEJMiPyneKZ3xxHDKXYysFWWqBhZf8ZVdT82I+bcj81Y1zKEU0lXI/hrhw09NotG
	 kHikvLLQ38oD3AD1fCT8mm5SgmIlcNo7hb+MZKNOuxZLA9eBDXD1DHhMj66jhZ3utV
	 GkQTNS+VfSZEQqnqijtfkUZnjJLer4xfbZ9mJwcO6ksV4MB28VF/kKT3hasKUiT8t8
	 KyV1TAqzyGrXQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:38 +0200
Subject: [PATCH v3 69/70] selftests/namespace: add stress test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-69-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18002; i=brauner@kernel.org;
 h=from:subject:message-id; bh=g358ZvosiSM60y9eCxcqiXUo4S81KVXpq23srWS/+30=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8juqQSCnfYCaveNiCfcKE0v8u/Ov2Pb18rPnxNHbnz
 TO2Wqzb3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRompGhi2z9zcIrrqqebjF
 KGflh+pv+9n+qpy+Kiha32nLPUn3nCsjw0PTg+ddpVwjgiMnVL1m9DgmxlqwylznRv23tYnHi3T
 nsQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Stress tests for namespace active reference counting.

These tests validate that the active reference counting system can
handle high load scenarios including rapid namespace
creation/destruction, large numbers of concurrent namespaces, and
various edge cases under stress.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/.gitignore    |   1 +
 tools/testing/selftests/namespaces/Makefile      |   4 +-
 tools/testing/selftests/namespaces/stress_test.c | 626 +++++++++++++++++++++++
 3 files changed, 630 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testing/selftests/namespaces/.gitignore
index 0091a7dfff20..f6dcf769f150 100644
--- a/tools/testing/selftests/namespaces/.gitignore
+++ b/tools/testing/selftests/namespaces/.gitignore
@@ -6,3 +6,4 @@ listns_test
 listns_permissions_test
 siocgskns_test
 cred_change_test
+stress_test
diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/selftests/namespaces/Makefile
index 5d73f8dde6a0..3c776740f3ac 100644
--- a/tools/testing/selftests/namespaces/Makefile
+++ b/tools/testing/selftests/namespaces/Makefile
@@ -9,7 +9,8 @@ TEST_GEN_PROGS := nsid_test \
 		  listns_test \
 		  listns_permissions_test \
 		  siocgskns_test \
-		  cred_change_test
+		  cred_change_test \
+		  stress_test
 
 include ../lib.mk
 
@@ -18,4 +19,5 @@ $(OUTPUT)/listns_test: ../filesystems/utils.c
 $(OUTPUT)/listns_permissions_test: ../filesystems/utils.c
 $(OUTPUT)/siocgskns_test: ../filesystems/utils.c
 $(OUTPUT)/cred_change_test: ../filesystems/utils.c
+$(OUTPUT)/stress_test: ../filesystems/utils.c
 
diff --git a/tools/testing/selftests/namespaces/stress_test.c b/tools/testing/selftests/namespaces/stress_test.c
new file mode 100644
index 000000000000..dd7df7d6cb27
--- /dev/null
+++ b/tools/testing/selftests/namespaces/stress_test.c
@@ -0,0 +1,626 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
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
+ * Stress tests for namespace active reference counting.
+ *
+ * These tests validate that the active reference counting system can handle
+ * high load scenarios including rapid namespace creation/destruction, large
+ * numbers of concurrent namespaces, and various edge cases under stress.
+ */
+
+/*
+ * Test rapid creation and destruction of user namespaces.
+ * Create and destroy namespaces in quick succession to stress the
+ * active reference tracking and ensure no leaks occur.
+ */
+TEST(rapid_namespace_creation_destruction)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWUSER,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids_before[256], ns_ids_after[256];
+	ssize_t ret_before, ret_after;
+	int i;
+
+	/* Get baseline count of active user namespaces */
+	ret_before = sys_listns(&req, ns_ids_before, ARRAY_SIZE(ns_ids_before), 0);
+	if (ret_before < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		ASSERT_GE(ret_before, 0);
+	}
+
+	TH_LOG("Baseline: %zd active user namespaces", ret_before);
+
+	/* Rapidly create and destroy 100 user namespaces */
+	for (i = 0; i < 100; i++) {
+		pid_t pid = fork();
+		ASSERT_GE(pid, 0);
+
+		if (pid == 0) {
+			/* Child: create user namespace and immediately exit */
+			if (setup_userns() < 0)
+				exit(1);
+			exit(0);
+		}
+
+		/* Parent: wait for child */
+		int status;
+		waitpid(pid, &status, 0);
+		ASSERT_TRUE(WIFEXITED(status));
+		ASSERT_EQ(WEXITSTATUS(status), 0);
+	}
+
+	/* Verify we're back to baseline (no leaked namespaces) */
+	ret_after = sys_listns(&req, ns_ids_after, ARRAY_SIZE(ns_ids_after), 0);
+	ASSERT_GE(ret_after, 0);
+
+	TH_LOG("After 100 rapid create/destroy cycles: %zd active user namespaces", ret_after);
+	ASSERT_EQ(ret_before, ret_after);
+}
+
+/*
+ * Test creating many concurrent namespaces.
+ * Verify that listns() correctly tracks all of them and that they all
+ * become inactive after processes exit.
+ */
+TEST(many_concurrent_namespaces)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWUSER,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids_before[512], ns_ids_during[512], ns_ids_after[512];
+	ssize_t ret_before, ret_during, ret_after;
+	pid_t pids[50];
+	int num_children = 50;
+	int i;
+	int sv[2];
+
+	/* Get baseline */
+	ret_before = sys_listns(&req, ns_ids_before, ARRAY_SIZE(ns_ids_before), 0);
+	if (ret_before < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		ASSERT_GE(ret_before, 0);
+	}
+
+	TH_LOG("Baseline: %zd active user namespaces", ret_before);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sv), 0);
+
+	/* Create many children, each with their own user namespace */
+	for (i = 0; i < num_children; i++) {
+		pids[i] = fork();
+		ASSERT_GE(pids[i], 0);
+
+		if (pids[i] == 0) {
+			/* Child: create user namespace and wait for parent signal */
+			char c;
+
+			close(sv[0]);
+
+			if (setup_userns() < 0) {
+				close(sv[1]);
+				exit(1);
+			}
+
+			/* Signal parent we're ready */
+			if (write(sv[1], &c, 1) != 1) {
+				close(sv[1]);
+				exit(1);
+			}
+
+			/* Wait for parent signal to exit */
+			if (read(sv[1], &c, 1) != 1) {
+				close(sv[1]);
+				exit(1);
+			}
+
+			close(sv[1]);
+			exit(0);
+		}
+	}
+
+	close(sv[1]);
+
+	/* Wait for all children to signal ready */
+	for (i = 0; i < num_children; i++) {
+		char c;
+		if (read(sv[0], &c, 1) != 1) {
+			/* If we fail to read, kill all children and exit */
+			close(sv[0]);
+			for (int j = 0; j < num_children; j++)
+				kill(pids[j], SIGKILL);
+			for (int j = 0; j < num_children; j++)
+				waitpid(pids[j], NULL, 0);
+			ASSERT_TRUE(false);
+		}
+	}
+
+	/* List namespaces while all children are running */
+	ret_during = sys_listns(&req, ns_ids_during, ARRAY_SIZE(ns_ids_during), 0);
+	ASSERT_GE(ret_during, 0);
+
+	TH_LOG("With %d children running: %zd active user namespaces", num_children, ret_during);
+
+	/* Should have at least num_children more namespaces than baseline */
+	ASSERT_GE(ret_during, ret_before + num_children);
+
+	/* Signal all children to exit */
+	for (i = 0; i < num_children; i++) {
+		char c = 'X';
+		if (write(sv[0], &c, 1) != 1) {
+			/* If we fail to write, kill remaining children */
+			close(sv[0]);
+			for (int j = i; j < num_children; j++)
+				kill(pids[j], SIGKILL);
+			for (int j = 0; j < num_children; j++)
+				waitpid(pids[j], NULL, 0);
+			ASSERT_TRUE(false);
+		}
+	}
+
+	close(sv[0]);
+
+	/* Wait for all children */
+	for (i = 0; i < num_children; i++) {
+		int status;
+		waitpid(pids[i], &status, 0);
+		ASSERT_TRUE(WIFEXITED(status));
+	}
+
+	/* Verify we're back to baseline */
+	ret_after = sys_listns(&req, ns_ids_after, ARRAY_SIZE(ns_ids_after), 0);
+	ASSERT_GE(ret_after, 0);
+
+	TH_LOG("After all children exit: %zd active user namespaces", ret_after);
+	ASSERT_EQ(ret_before, ret_after);
+}
+
+/*
+ * Test rapid namespace creation with different namespace types.
+ * Create multiple types of namespaces rapidly to stress the tracking system.
+ */
+TEST(rapid_mixed_namespace_creation)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,  /* All types */
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids_before[512], ns_ids_after[512];
+	ssize_t ret_before, ret_after;
+	int i;
+
+	/* Get baseline count */
+	ret_before = sys_listns(&req, ns_ids_before, ARRAY_SIZE(ns_ids_before), 0);
+	if (ret_before < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		ASSERT_GE(ret_before, 0);
+	}
+
+	TH_LOG("Baseline: %zd active namespaces (all types)", ret_before);
+
+	/* Rapidly create and destroy namespaces with multiple types */
+	for (i = 0; i < 50; i++) {
+		pid_t pid = fork();
+		ASSERT_GE(pid, 0);
+
+		if (pid == 0) {
+			/* Child: create multiple namespace types */
+			if (setup_userns() < 0)
+				exit(1);
+
+			/* Create additional namespace types */
+			if (unshare(CLONE_NEWNET) < 0)
+				exit(1);
+			if (unshare(CLONE_NEWUTS) < 0)
+				exit(1);
+			if (unshare(CLONE_NEWIPC) < 0)
+				exit(1);
+
+			exit(0);
+		}
+
+		/* Parent: wait for child */
+		int status;
+		waitpid(pid, &status, 0);
+		ASSERT_TRUE(WIFEXITED(status));
+	}
+
+	/* Verify we're back to baseline */
+	ret_after = sys_listns(&req, ns_ids_after, ARRAY_SIZE(ns_ids_after), 0);
+	ASSERT_GE(ret_after, 0);
+
+	TH_LOG("After 50 rapid mixed namespace cycles: %zd active namespaces", ret_after);
+	ASSERT_EQ(ret_before, ret_after);
+}
+
+/*
+ * Test nested namespace creation under stress.
+ * Create deeply nested namespace hierarchies and verify proper cleanup.
+ */
+TEST(nested_namespace_stress)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWUSER,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids_before[512], ns_ids_after[512];
+	ssize_t ret_before, ret_after;
+	int i;
+
+	/* Get baseline */
+	ret_before = sys_listns(&req, ns_ids_before, ARRAY_SIZE(ns_ids_before), 0);
+	if (ret_before < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		ASSERT_GE(ret_before, 0);
+	}
+
+	TH_LOG("Baseline: %zd active user namespaces", ret_before);
+
+	/* Create 20 processes, each with nested user namespaces */
+	for (i = 0; i < 20; i++) {
+		pid_t pid = fork();
+		ASSERT_GE(pid, 0);
+
+		if (pid == 0) {
+			int userns_fd;
+			uid_t orig_uid = getuid();
+			int depth;
+
+			/* Create nested user namespaces (up to 5 levels) */
+			for (depth = 0; depth < 5; depth++) {
+				userns_fd = get_userns_fd(0, (depth == 0) ? orig_uid : 0, 1);
+				if (userns_fd < 0)
+					exit(1);
+
+				if (setns(userns_fd, CLONE_NEWUSER) < 0) {
+					close(userns_fd);
+					exit(1);
+				}
+				close(userns_fd);
+			}
+
+			exit(0);
+		}
+
+		/* Parent: wait for child */
+		int status;
+		waitpid(pid, &status, 0);
+		ASSERT_TRUE(WIFEXITED(status));
+	}
+
+	/* Verify we're back to baseline */
+	ret_after = sys_listns(&req, ns_ids_after, ARRAY_SIZE(ns_ids_after), 0);
+	ASSERT_GE(ret_after, 0);
+
+	TH_LOG("After 20 nested namespace hierarchies: %zd active user namespaces", ret_after);
+	ASSERT_EQ(ret_before, ret_after);
+}
+
+/*
+ * Test listns() pagination under stress.
+ * Create many namespaces and verify pagination works correctly.
+ */
+TEST(listns_pagination_stress)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWUSER,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	pid_t pids[30];
+	int num_children = 30;
+	int i;
+	int sv[2];
+	__u64 all_ns_ids[512];
+	int total_found = 0;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sv), 0);
+
+	/* Create many children with user namespaces */
+	for (i = 0; i < num_children; i++) {
+		pids[i] = fork();
+		ASSERT_GE(pids[i], 0);
+
+		if (pids[i] == 0) {
+			char c;
+			close(sv[0]);
+
+			if (setup_userns() < 0) {
+				close(sv[1]);
+				exit(1);
+			}
+
+			/* Signal parent we're ready */
+			if (write(sv[1], &c, 1) != 1) {
+				close(sv[1]);
+				exit(1);
+			}
+
+			/* Wait for parent signal to exit */
+			if (read(sv[1], &c, 1) != 1) {
+				close(sv[1]);
+				exit(1);
+			}
+
+			close(sv[1]);
+			exit(0);
+		}
+	}
+
+	close(sv[1]);
+
+	/* Wait for all children to signal ready */
+	for (i = 0; i < num_children; i++) {
+		char c;
+		if (read(sv[0], &c, 1) != 1) {
+			/* If we fail to read, kill all children and exit */
+			close(sv[0]);
+			for (int j = 0; j < num_children; j++)
+				kill(pids[j], SIGKILL);
+			for (int j = 0; j < num_children; j++)
+				waitpid(pids[j], NULL, 0);
+			ASSERT_TRUE(false);
+		}
+	}
+
+	/* Paginate through all namespaces using small batch sizes */
+	req.ns_id = 0;
+	while (1) {
+		__u64 batch[5];  /* Small batch size to force pagination */
+		ssize_t ret;
+
+		ret = sys_listns(&req, batch, ARRAY_SIZE(batch), 0);
+		if (ret < 0) {
+			if (errno == ENOSYS) {
+				close(sv[0]);
+				for (i = 0; i < num_children; i++)
+					kill(pids[i], SIGKILL);
+				for (i = 0; i < num_children; i++)
+					waitpid(pids[i], NULL, 0);
+				SKIP(return, "listns() not supported");
+			}
+			ASSERT_GE(ret, 0);
+		}
+
+		if (ret == 0)
+			break;
+
+		/* Store results */
+		for (i = 0; i < ret && total_found < 512; i++) {
+			all_ns_ids[total_found++] = batch[i];
+		}
+
+		/* Update cursor for next batch */
+		if (ret == ARRAY_SIZE(batch))
+			req.ns_id = batch[ret - 1];
+		else
+			break;
+	}
+
+	TH_LOG("Paginated through %d user namespaces", total_found);
+
+	/* Verify no duplicates in pagination */
+	for (i = 0; i < total_found; i++) {
+		for (int j = i + 1; j < total_found; j++) {
+			if (all_ns_ids[i] == all_ns_ids[j]) {
+				TH_LOG("Found duplicate ns_id: %llu at positions %d and %d",
+				       (unsigned long long)all_ns_ids[i], i, j);
+				ASSERT_TRUE(false);
+			}
+		}
+	}
+
+	/* Signal all children to exit */
+	for (i = 0; i < num_children; i++) {
+		char c = 'X';
+		if (write(sv[0], &c, 1) != 1) {
+			close(sv[0]);
+			for (int j = i; j < num_children; j++)
+				kill(pids[j], SIGKILL);
+			for (int j = 0; j < num_children; j++)
+				waitpid(pids[j], NULL, 0);
+			ASSERT_TRUE(false);
+		}
+	}
+
+	close(sv[0]);
+
+	/* Wait for all children */
+	for (i = 0; i < num_children; i++) {
+		int status;
+		waitpid(pids[i], &status, 0);
+	}
+}
+
+/*
+ * Test concurrent namespace operations.
+ * Multiple processes creating, querying, and destroying namespaces concurrently.
+ */
+TEST(concurrent_namespace_operations)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids_before[512], ns_ids_after[512];
+	ssize_t ret_before, ret_after;
+	pid_t pids[20];
+	int num_workers = 20;
+	int i;
+
+	/* Get baseline */
+	ret_before = sys_listns(&req, ns_ids_before, ARRAY_SIZE(ns_ids_before), 0);
+	if (ret_before < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		ASSERT_GE(ret_before, 0);
+	}
+
+	TH_LOG("Baseline: %zd active namespaces", ret_before);
+
+	/* Create worker processes that do concurrent operations */
+	for (i = 0; i < num_workers; i++) {
+		pids[i] = fork();
+		ASSERT_GE(pids[i], 0);
+
+		if (pids[i] == 0) {
+			/* Each worker: create namespaces, list them, repeat */
+			int iterations;
+
+			for (iterations = 0; iterations < 10; iterations++) {
+				int userns_fd;
+				__u64 temp_ns_ids[100];
+				ssize_t ret;
+
+				/* Create a user namespace */
+				userns_fd = get_userns_fd(0, getuid(), 1);
+				if (userns_fd < 0)
+					continue;
+
+				/* List namespaces */
+				ret = sys_listns(&req, temp_ns_ids, ARRAY_SIZE(temp_ns_ids), 0);
+				(void)ret;
+
+				close(userns_fd);
+
+				/* Small delay */
+				usleep(1000);
+			}
+
+			exit(0);
+		}
+	}
+
+	/* Wait for all workers */
+	for (i = 0; i < num_workers; i++) {
+		int status;
+		waitpid(pids[i], &status, 0);
+		ASSERT_TRUE(WIFEXITED(status));
+		ASSERT_EQ(WEXITSTATUS(status), 0);
+	}
+
+	/* Verify we're back to baseline */
+	ret_after = sys_listns(&req, ns_ids_after, ARRAY_SIZE(ns_ids_after), 0);
+	ASSERT_GE(ret_after, 0);
+
+	TH_LOG("After concurrent operations: %zd active namespaces", ret_after);
+	ASSERT_EQ(ret_before, ret_after);
+}
+
+/*
+ * Test namespace churn - continuous creation and destruction.
+ * Simulates high-churn scenarios like container orchestration.
+ */
+TEST(namespace_churn)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWUSER | CLONE_NEWNET | CLONE_NEWUTS,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids_before[512], ns_ids_after[512];
+	ssize_t ret_before, ret_after;
+	int cycle;
+
+	/* Get baseline */
+	ret_before = sys_listns(&req, ns_ids_before, ARRAY_SIZE(ns_ids_before), 0);
+	if (ret_before < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		ASSERT_GE(ret_before, 0);
+	}
+
+	TH_LOG("Baseline: %zd active namespaces", ret_before);
+
+	/* Simulate churn: batches of namespaces created and destroyed */
+	for (cycle = 0; cycle < 10; cycle++) {
+		pid_t batch_pids[10];
+		int i;
+
+		/* Create batch */
+		for (i = 0; i < 10; i++) {
+			batch_pids[i] = fork();
+			ASSERT_GE(batch_pids[i], 0);
+
+			if (batch_pids[i] == 0) {
+				/* Create multiple namespace types */
+				if (setup_userns() < 0)
+					exit(1);
+				if (unshare(CLONE_NEWNET) < 0)
+					exit(1);
+				if (unshare(CLONE_NEWUTS) < 0)
+					exit(1);
+
+				/* Keep namespaces alive briefly */
+				usleep(10000);
+				exit(0);
+			}
+		}
+
+		/* Wait for batch to complete */
+		for (i = 0; i < 10; i++) {
+			int status;
+			waitpid(batch_pids[i], &status, 0);
+		}
+	}
+
+	/* Verify we're back to baseline */
+	ret_after = sys_listns(&req, ns_ids_after, ARRAY_SIZE(ns_ids_after), 0);
+	ASSERT_GE(ret_after, 0);
+
+	TH_LOG("After 10 churn cycles (100 namespace sets): %zd active namespaces", ret_after);
+	ASSERT_EQ(ret_before, ret_after);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


