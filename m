Return-Path: <linux-fsdevel+bounces-65510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AA4C06025
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B57B584BCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE5C37DBF3;
	Fri, 24 Oct 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5fkK2O6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC9931A053;
	Fri, 24 Oct 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303565; cv=none; b=sPh+42rNnvXvX63m1qQkHCMgl517SpdG8W2TgT+6i8upuaThxTR2V/hbzC2gxSL6vmsMRehpsUaYvOurOXM6z9q/1IJ3zQjGQFwwkhTmfO6S6000MR0/oUvcgM3XStEDoOav7UG8e8HTdrD1JuCrWsku/EteCoTsvAKR2BARXrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303565; c=relaxed/simple;
	bh=QwDkSH3kLhu9Ya7BrIayv5fawfziMOL3Z/w1iCrFClA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scrvy6DTZvMuHGWqDqsrhJeUwj3xve6ij20nk6eAVriiUpqAhB98iobvoXHXYIis3lAqbRBGzsk7eCyR3HaDE3He72G9nsWOF5TARkDNK8b5L3lQ+of3uLIAGCCai4/v2uOCFicM5D/lPIrFaylr761nD31biCKE+0eS2c64qPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5fkK2O6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4C7C4CEF5;
	Fri, 24 Oct 2025 10:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303565;
	bh=QwDkSH3kLhu9Ya7BrIayv5fawfziMOL3Z/w1iCrFClA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W5fkK2O6ood/eZ2MioGr5FOn8MmFQgD5BK6WGd1JeyrwnpVvGLZEYHcG6bPgBzYIs
	 Y+336uTvHOglol8wNJCZvPtXdrEDGJr4/0OcjlAuY+mxGIcIEuObbol67F3Ii3jfVV
	 Iy1UQBgGyesZQTK5pQbEefGHsZvUC+QOVj2H+/F/Iu9S7Yv4KF2asv4dJdfdkLCY28
	 qa1eswPqtIUJdHU6A7XqqiCl3+FUGq9ClRaPm+U/Q4t5jLyv48rZCJpWIsJt85elvp
	 tdW4PRDx09+DGk8pMigmVYFmFDaO60Tn5v9TOqWXs6ioFnNYyYhBw57oOFoDrh54l2
	 qyZcM9wQG2ZKw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:39 +0200
Subject: [PATCH v3 70/70] selftests/namespace: test listns() pagination
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-70-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5137; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QwDkSH3kLhu9Ya7BrIayv5fawfziMOL3Z/w1iCrFClA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8juow+zIx/fDv6H+C/RdiSyec6pjWoPXUwj55555dR
 3/7KAqHdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkohnDf++O1yWdBXr3tb58
 LF/AfGue19KoIBGbV0IrKy3uGN2UzGH47/LuQgrz69u3Zqt6P6tNbtzx4MXKx5ei2U5WWRV9z5C
 6wwgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Minimal test case to reproduce KASAN out-of-bounds in listns pagination.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/.gitignore      |   1 +
 tools/testing/selftests/namespaces/Makefile        |   4 +-
 .../selftests/namespaces/listns_pagination_bug.c   | 138 +++++++++++++++++++++
 3 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testing/selftests/namespaces/.gitignore
index f6dcf769f150..f4d2209ca4e4 100644
--- a/tools/testing/selftests/namespaces/.gitignore
+++ b/tools/testing/selftests/namespaces/.gitignore
@@ -7,3 +7,4 @@ listns_permissions_test
 siocgskns_test
 cred_change_test
 stress_test
+listns_pagination_bug
diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/selftests/namespaces/Makefile
index 3c776740f3ac..01569e0abbdb 100644
--- a/tools/testing/selftests/namespaces/Makefile
+++ b/tools/testing/selftests/namespaces/Makefile
@@ -10,7 +10,8 @@ TEST_GEN_PROGS := nsid_test \
 		  listns_permissions_test \
 		  siocgskns_test \
 		  cred_change_test \
-		  stress_test
+		  stress_test \
+		  listns_pagination_bug
 
 include ../lib.mk
 
@@ -20,4 +21,5 @@ $(OUTPUT)/listns_permissions_test: ../filesystems/utils.c
 $(OUTPUT)/siocgskns_test: ../filesystems/utils.c
 $(OUTPUT)/cred_change_test: ../filesystems/utils.c
 $(OUTPUT)/stress_test: ../filesystems/utils.c
+$(OUTPUT)/listns_pagination_bug: ../filesystems/utils.c
 
diff --git a/tools/testing/selftests/namespaces/listns_pagination_bug.c b/tools/testing/selftests/namespaces/listns_pagination_bug.c
new file mode 100644
index 000000000000..da7d33f96397
--- /dev/null
+++ b/tools/testing/selftests/namespaces/listns_pagination_bug.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "../kselftest_harness.h"
+#include "../filesystems/utils.h"
+#include "wrappers.h"
+
+/*
+ * Minimal test case to reproduce KASAN out-of-bounds in listns pagination.
+ *
+ * The bug occurs when:
+ * 1. Filtering by a specific namespace type (e.g., CLONE_NEWUSER)
+ * 2. Using pagination (req.ns_id != 0)
+ * 3. The lookup_ns_id_at() call in do_listns() passes ns_type=0 instead of
+ *    the filtered type, causing it to search the unified tree and potentially
+ *    return a namespace of the wrong type.
+ */
+TEST(pagination_with_type_filter)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWUSER,  /* Filter by user namespace */
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	pid_t pids[10];
+	int num_children = 10;
+	int i;
+	int sv[2];
+	__u64 first_batch[3];
+	ssize_t ret;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sv), 0);
+
+	/* Create children with user namespaces */
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
+			close(sv[0]);
+			for (int j = 0; j < num_children; j++)
+				kill(pids[j], SIGKILL);
+			for (int j = 0; j < num_children; j++)
+				waitpid(pids[j], NULL, 0);
+			ASSERT_TRUE(false);
+		}
+	}
+
+	/* First batch - this should work */
+	ret = sys_listns(&req, first_batch, 3, 0);
+	if (ret < 0) {
+		if (errno == ENOSYS) {
+			close(sv[0]);
+			for (i = 0; i < num_children; i++)
+				kill(pids[i], SIGKILL);
+			for (i = 0; i < num_children; i++)
+				waitpid(pids[i], NULL, 0);
+			SKIP(return, "listns() not supported");
+		}
+		ASSERT_GE(ret, 0);
+	}
+
+	TH_LOG("First batch returned %zd entries", ret);
+
+	if (ret == 3) {
+		__u64 second_batch[3];
+
+		/* Second batch - pagination triggers the bug */
+		req.ns_id = first_batch[2];  /* Continue from last ID */
+		ret = sys_listns(&req, second_batch, 3, 0);
+
+		TH_LOG("Second batch returned %zd entries", ret);
+		ASSERT_GE(ret, 0);
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
+	/* Cleanup */
+	for (i = 0; i < num_children; i++) {
+		int status;
+		waitpid(pids[i], &status, 0);
+	}
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


