Return-Path: <linux-fsdevel+bounces-65173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B97BBFD2C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3D11889319
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CBA3590A6;
	Wed, 22 Oct 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkQBdlrq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD437EE2F;
	Wed, 22 Oct 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149405; cv=none; b=ueMdRK/fDFKJMTLWxc3VJXvUGu5zg7y2vKTyMwo2z/bQiJG0jaSI+7GfxAamfLcJJE+FlLAYIzl9RAkbAltLv2SOK4ZyxbIZ0GKGITPHZst8mHrxbmtcD/OELx0dEs09+S2pZy77gB3MpB9Slx7B9JoVdeFaUAOYY8FgfOpd8JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149405; c=relaxed/simple;
	bh=5YqEIrDVXqnPIx61aY2UFkn7520IFi2bPLuDDoqZd4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spVX0JLy0Lj7N3NOQc7hz+Dr47I9Trhpyi+RwO/CQPvtoPksW+K2CvVDR+ofqh6uaTj501xze4jiK8yv5egv6Zpp56T1n5I6S3HeTkKQIdcSh2u1onmyq0gtcjidCn1PmXUvgzgOk7RTNW38na+OswL0GsFPHkfI/uJeFt4I8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkQBdlrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5700C4CEE7;
	Wed, 22 Oct 2025 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149405;
	bh=5YqEIrDVXqnPIx61aY2UFkn7520IFi2bPLuDDoqZd4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IkQBdlrq/Foh5U4Si0HKsuRF2nrTlbOKWCMtKyopgFeyUoIR8G1BnEEGtvXYRbbie
	 ZB/x5/qgnqMem9FgkHzGbd9vgUMHfK/syK/lLjkEayhVPJFRMQrBBiCrvUg422cLQg
	 w/9nhJJi+eu2MS98+n+IRuZOG5B8bYohKkZawdmnkq+3qgVQugOD78knMu2R4ACm5/
	 NrFh9cydNE0GX1bxw8KvBhx5pktqvrAGUQCWvJuddCknBQ+GQhzr89dCJak/4QHcox
	 H/FK9Z265JTjKNZ6o/Uv8VDBvNi6Ka+Ffit+UrsfCaWmPNy023UZX+so8uPgYtQntD
	 /LQqtalc6lUFQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:23 +0200
Subject: [PATCH v2 45/63] selftests/namespaces: first listns() permission
 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-45-71a588572371@kernel.org>
References: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5030; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5YqEIrDVXqnPIx61aY2UFkn7520IFi2bPLuDDoqZd4M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHgmFXGmnTHkXO/U4vmOQZ2y5drTjCQuVPnlrtpnt
 ngf3+mejlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk0OTAyXEj9o6jj+VBCoat9
 dlpU/lX7d9FOLmvfqbtIGqs0t8cpMzI09v6sONfOLL5y2tNvs0tOKHRxusWUfn+ffVHYoUxo21R
 mAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that unprivileged users can only see namespaces they're currently
in. Create a namespace, drop privileges, verify we can only see our own
namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/.gitignore      |   1 +
 tools/testing/selftests/namespaces/Makefile        |   3 +-
 .../selftests/namespaces/listns_permissions_test.c | 134 +++++++++++++++++++++
 3 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testing/selftests/namespaces/.gitignore
index 5065f07e92c9..17f9c675a60b 100644
--- a/tools/testing/selftests/namespaces/.gitignore
+++ b/tools/testing/selftests/namespaces/.gitignore
@@ -3,3 +3,4 @@ file_handle_test
 init_ino_test
 ns_active_ref_test
 listns_test
+listns_permissions_test
diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/selftests/namespaces/Makefile
index de708f4df159..2dd22bc68b89 100644
--- a/tools/testing/selftests/namespaces/Makefile
+++ b/tools/testing/selftests/namespaces/Makefile
@@ -2,10 +2,11 @@
 CFLAGS += -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS += -lcap
 
-TEST_GEN_PROGS := nsid_test file_handle_test init_ino_test ns_active_ref_test listns_test
+TEST_GEN_PROGS := nsid_test file_handle_test init_ino_test ns_active_ref_test listns_test listns_permissions_test
 
 include ../lib.mk
 
 $(OUTPUT)/ns_active_ref_test: ../filesystems/utils.c
 $(OUTPUT)/listns_test: ../filesystems/utils.c
+$(OUTPUT)/listns_permissions_test: ../filesystems/utils.c
 
diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
new file mode 100644
index 000000000000..87ec71560d99
--- /dev/null
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/nsfs.h>
+#include <sys/capability.h>
+#include <sys/ioctl.h>
+#include <sys/prctl.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "../kselftest_harness.h"
+#include "../filesystems/utils.h"
+#include "wrappers.h"
+
+/*
+ * Test that unprivileged users can only see namespaces they're currently in.
+ * Create a namespace, drop privileges, verify we can only see our own namespaces.
+ */
+TEST(listns_unprivileged_current_only)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWNET,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids[100];
+	ssize_t ret;
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	bool found_ours;
+	int unexpected_count;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		__u64 our_netns_id;
+		bool found_ours;
+		int unexpected_count;
+
+		close(pipefd[0]);
+
+		/* Create user namespace to be unprivileged */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Create a network namespace */
+		if (unshare(CLONE_NEWNET) < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Get our network namespace ID */
+		fd = open("/proc/self/ns/net", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &our_netns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Now we're unprivileged - list all network namespaces */
+		ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+		if (ret < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* We should only see our own network namespace */
+		found_ours = false;
+		unexpected_count = 0;
+
+		for (ssize_t i = 0; i < ret; i++) {
+			if (ns_ids[i] == our_netns_id) {
+				found_ours = true;
+			} else {
+				/* This is either init_net (which we can see) or unexpected */
+				unexpected_count++;
+			}
+		}
+
+		/* Send results to parent */
+		write(pipefd[1], &found_ours, sizeof(found_ours));
+		write(pipefd[1], &unexpected_count, sizeof(unexpected_count));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(pipefd[1]);
+
+	found_ours = false;
+	unexpected_count = 0;
+	read(pipefd[0], &found_ours, sizeof(found_ours));
+	read(pipefd[0], &unexpected_count, sizeof(unexpected_count));
+	close(pipefd[0]);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	if (WEXITSTATUS(status) != 0) {
+		SKIP(return, "Child failed to setup namespaces or run listns");
+	}
+
+	/* Child should have seen its own namespace */
+	ASSERT_TRUE(found_ours);
+
+	TH_LOG("Unprivileged child saw its own namespace, plus %d others (likely init_net)",
+			unexpected_count);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


