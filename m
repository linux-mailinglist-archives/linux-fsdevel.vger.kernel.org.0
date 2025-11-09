Return-Path: <linux-fsdevel+bounces-67615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E844C44781
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 22:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C27F4E983A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 21:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110CD27C84B;
	Sun,  9 Nov 2025 21:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdhwGjva"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D6426CE07;
	Sun,  9 Nov 2025 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762722834; cv=none; b=Yr4RT05iZ/xVMbKsdjiIaoFFomXaVpzkaGtsY/CYiIQz0RThXJ6ef5DiwV+dcYVI0vJAIKus55doWK8yhb7MJNtzCS4jKBvTTVrR8t+mZs3bNZqymcHPcphWkkfvDPyZNizaLA4ifhFyRe01G7YVK13GW4Yz4qVhcsRARYOfHXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762722834; c=relaxed/simple;
	bh=hjIC8MoMy22tTyZzN7VrtnIt0FY8IbJnB2GTuhPLsjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+dE/415bJCi9FZE7kytUyRc5wNMSvBcgsEDhYqBzP5czfqpqkaB5+COC5s2I4nIvb6xNa1AGMdH+WQhq1ux9jWs+vl6QBs/qknRUJGj5sSkKxF1rDSUdA73JOquEtMJ+NH2dA+2zzQygdDr5u0N8DgYlYcrZsiwUKJZj9sdypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdhwGjva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6D7C4CEF7;
	Sun,  9 Nov 2025 21:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762722833;
	bh=hjIC8MoMy22tTyZzN7VrtnIt0FY8IbJnB2GTuhPLsjc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PdhwGjvaxle3BHuwErRwea24DSGUj6VsFwvL/i35en7+On7B8fTQqr3M3VbthI459
	 TXhpGx2uiqhbkLjHydc5H4QKQVGC8FKp5awqU4DVYcEpdBJKhdD67UWYDzN5JX1yaD
	 SEaL+BkA7aKlasQRWo7oj4Pju3hDeleTgqHXj9/o1MUw9Hkeyj7B8bFWChGmrnZ8Mb
	 la7La2IzdDAmjQDksrKII7oHr9ohYp7PsRYvqnwGFgUoAWFtf/+UXcK4FBcH6QaZMF
	 i6ILu6R/uC8ONonjuy4FzRhTGSHSs65NfHBxQZRC0wbVjGEbTrPP6HQyhwkrakd/YN
	 R9t4i7c3jLt9w==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 09 Nov 2025 22:11:28 +0100
Subject: [PATCH 7/8] selftests/namespaces: add active reference count
 regression test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-namespace-6-19-fixes-v1-7-ae8a4ad5a3b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4949; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hjIC8MoMy22tTyZzN7VrtnIt0FY8IbJnB2GTuhPLsjc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKMr9Ytectw83jb9NCRYVZy571HzMSXv4nqiNNnKv7R
 ldGWU5IRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEROizP84e/ZbChy0G6P3oSl
 utGvdnYsWmPxOu76zYVqjEwCtZkdnAx/BY8rNccK/y4/167Vf4m3cI2DwwXXC7/W8uq7/Zs328i
 GFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a regression test for setns() with pidfd.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/.gitignore      |   1 +
 tools/testing/selftests/namespaces/Makefile        |   4 +-
 .../namespaces/regression_pidfd_setns_test.c       | 113 +++++++++++++++++++++
 3 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testing/selftests/namespaces/.gitignore
index f4d2209ca4e4..4cb428d77659 100644
--- a/tools/testing/selftests/namespaces/.gitignore
+++ b/tools/testing/selftests/namespaces/.gitignore
@@ -8,3 +8,4 @@ siocgskns_test
 cred_change_test
 stress_test
 listns_pagination_bug
+regression_pidfd_setns_test
diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/selftests/namespaces/Makefile
index 01569e0abbdb..1f36c7bf7728 100644
--- a/tools/testing/selftests/namespaces/Makefile
+++ b/tools/testing/selftests/namespaces/Makefile
@@ -11,7 +11,8 @@ TEST_GEN_PROGS := nsid_test \
 		  siocgskns_test \
 		  cred_change_test \
 		  stress_test \
-		  listns_pagination_bug
+		  listns_pagination_bug \
+		  regression_pidfd_setns_test
 
 include ../lib.mk
 
@@ -22,4 +23,5 @@ $(OUTPUT)/siocgskns_test: ../filesystems/utils.c
 $(OUTPUT)/cred_change_test: ../filesystems/utils.c
 $(OUTPUT)/stress_test: ../filesystems/utils.c
 $(OUTPUT)/listns_pagination_bug: ../filesystems/utils.c
+$(OUTPUT)/regression_pidfd_setns_test: ../filesystems/utils.c
 
diff --git a/tools/testing/selftests/namespaces/regression_pidfd_setns_test.c b/tools/testing/selftests/namespaces/regression_pidfd_setns_test.c
new file mode 100644
index 000000000000..753fd29dffd8
--- /dev/null
+++ b/tools/testing/selftests/namespaces/regression_pidfd_setns_test.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <unistd.h>
+#include "../pidfd/pidfd.h"
+#include "../kselftest_harness.h"
+
+/*
+ * Regression tests for the setns(pidfd) active reference counting bug.
+ *
+ * These tests are based on the reproducers that triggered the race condition
+ * fixed by commit 1c465d0518dc ("ns: handle setns(pidfd, ...) cleanly").
+ *
+ * The bug: When using setns() with a pidfd, if the target task exits between
+ * prepare_nsset() and commit_nsset(), the namespaces would become inactive.
+ * Then ns_ref_active_get() would increment from 0 without properly resurrecting
+ * the owner chain, causing active reference count underflows.
+ */
+
+/*
+ * Simple pidfd setns test using create_child()+unshare().
+ *
+ * Without the fix, this would trigger active refcount warnings when the
+ * parent exits after doing setns(pidfd) on a child that has already exited.
+ */
+TEST(simple_pidfd_setns)
+{
+	pid_t child_pid;
+	int pidfd = -1;
+	int ret;
+	int sv[2];
+	char c;
+
+	/* Ignore SIGCHLD for autoreap */
+	ASSERT_NE(signal(SIGCHLD, SIG_IGN), SIG_ERR);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sv), 0);
+
+	/* Create a child process without namespaces initially */
+	child_pid = create_child(&pidfd, 0);
+	ASSERT_GE(child_pid, 0);
+
+	if (child_pid == 0) {
+		close(sv[0]);
+
+		if (unshare(CLONE_NEWUTS | CLONE_NEWIPC | CLONE_NEWNET | CLONE_NEWUSER) < 0) {
+			close(sv[1]);
+			_exit(1);
+		}
+
+		/* Signal parent that namespaces are ready */
+		if (write_nointr(sv[1], "1", 1) < 0) {
+			close(sv[1]);
+			_exit(1);
+		}
+
+		close(sv[1]);
+		_exit(0);
+	}
+	ASSERT_GE(pidfd, 0);
+	EXPECT_EQ(close(sv[1]), 0);
+
+	ret = read_nointr(sv[0], &c, 1);
+	ASSERT_EQ(ret, 1);
+	EXPECT_EQ(close(sv[0]), 0);
+
+	/* Set to child's namespaces via pidfd */
+	ret = setns(pidfd, CLONE_NEWUTS | CLONE_NEWIPC);
+	TH_LOG("setns() returned %d", ret);
+	close(pidfd);
+}
+
+/*
+ * Simple pidfd setns test using create_child().
+ *
+ * This variation uses create_child() with namespace flags directly.
+ * Namespaces are created immediately at clone time.
+ */
+TEST(simple_pidfd_setns_clone)
+{
+	pid_t child_pid;
+	int pidfd = -1;
+	int ret;
+
+	/* Ignore SIGCHLD for autoreap */
+	ASSERT_NE(signal(SIGCHLD, SIG_IGN), SIG_ERR);
+
+	/* Create a child process with new namespaces using create_child() */
+	child_pid = create_child(&pidfd, CLONE_NEWUSER | CLONE_NEWUTS | CLONE_NEWIPC | CLONE_NEWNET);
+	ASSERT_GE(child_pid, 0);
+
+	if (child_pid == 0) {
+		/* Child: sleep for a while so parent can setns to us */
+		sleep(2);
+		_exit(0);
+	}
+
+	/* Parent: pidfd was already created by create_child() */
+	ASSERT_GE(pidfd, 0);
+
+	/* Set to child's namespaces via pidfd */
+	ret = setns(pidfd, CLONE_NEWUTS | CLONE_NEWIPC);
+	close(pidfd);
+	TH_LOG("setns() returned %d", ret);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


