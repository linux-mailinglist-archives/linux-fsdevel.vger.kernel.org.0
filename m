Return-Path: <linux-fsdevel+bounces-64895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB21BF64DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169703ABD31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EBA34FF48;
	Tue, 21 Oct 2025 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0Lqw7b4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F7D33858A;
	Tue, 21 Oct 2025 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047262; cv=none; b=eY2fJANjBrclcyZELDeV6noeIWMrS5DtCP2WG2oseUBG78QxvS6xCWQG3+4RMD1ZvFsW4JDCYEw+wi1u5rT4HiWYU0WHOEB/59G48EtmrdBfPe4G8UB1KhCqkNJdx8cPYtG1eKGR0ZDyYR20bxJbeRgJUN1vQIlcE1G2spUdLDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047262; c=relaxed/simple;
	bh=5YqEIrDVXqnPIx61aY2UFkn7520IFi2bPLuDDoqZd4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nu9UPn2s22fwko5TowDZfqTIsgLsxoINH2wBri73oqCBN7RbreCUlAA/kfTzlsUtbXvxo4ko/l4tGz8v+1/aJTZbPZBdwNls8/X5IKiXVVTXaRLHZQpJTx+p4lulgmXZ7aKtG3b8beHuOOVVxyeSOmO8jFcSXkfdTJLG4l1yCcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0Lqw7b4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BD4C4CEFD;
	Tue, 21 Oct 2025 11:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047262;
	bh=5YqEIrDVXqnPIx61aY2UFkn7520IFi2bPLuDDoqZd4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R0Lqw7b4mBzPYBrZIxBYhBTOL5ZAM8PeqobHDUuthY0mrwapNnrrPnvqyx3K4UWYt
	 irEvjfJqXV9LrKxVBjj73j7vB6sYeuttPTIQeeBOuNyzi5ogVr2lk2C4vb2GQb2+oc
	 jP5OJC3zrT67SjWVN13QHphX73uD691X5iArZXkN0XR3xauISjIXlEFksuczC95mPg
	 v/yhNK/Tg5AYKr6j7CjueUf2J4n1G4nru7uN4V9HeQOcdXn20Ebj8q71Lb91HqbUwG
	 NRwfEo6rhKEgE4o87HTKVJQQH5VKmUOcyJmorIc04gM0qcLbuIPgw9RGmz0p030ZKj
	 Ymu0u9WShtVkQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:50 +0200
Subject: [PATCH RFC DRAFT 44/50] selftests/namespaces: first listns()
 permission test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-44-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5030; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5YqEIrDVXqnPIx61aY2UFkn7520IFi2bPLuDDoqZd4M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3y/c65cSv2/0uhZ85aF6WaUPs6Q/lzsrMz7f7d/4
 6pO1+kLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbie4Dhf6RzqUfyO5l7ggGK
 1yW8+2JiNvetv13HYLBJcEVFwWUXOUaGX35Pzn72fXfjYfB7Ffmz/7/8Efr/jZtp5cQjFnViz3/
 zsAIA
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


