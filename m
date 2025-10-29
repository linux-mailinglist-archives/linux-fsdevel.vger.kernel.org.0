Return-Path: <linux-fsdevel+bounces-66285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC3FC1A642
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52D0E3588AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA00C36E37F;
	Wed, 29 Oct 2025 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efcNJ+8u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142EE36E364;
	Wed, 29 Oct 2025 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740804; cv=none; b=dUmlNxkuZ2nlMcAtr5LpA03TKpna64U/GnolDi9fYx3/j2BwELeO8suRxa5GIwJ8pMh9AhYZ4jOyQjihty19GCFCTqqqG7qAnxxtpE8O/r+noVGnVgOdjwO0MS8tM1iW2AKJCnfa1AUOn8c3BpasmkXfqHR2d9pU7BfrnZmOX08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740804; c=relaxed/simple;
	bh=QwDkSH3kLhu9Ya7BrIayv5fawfziMOL3Z/w1iCrFClA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kgnelzXUPcVlxlSI7qSUeg5IWGVj4exXoycE66qhMr2t5kWuA57SPUL+buhxzIhm7HPnsFZNq5mdtrbbogR2El/pA328n+n22Qk5gkT+rWhywcXvaxNAe5bDCwGGj6ZgWF11vwUDwOu0Sy82GwGgZVcup2UMHAVzrx2H6GrWmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efcNJ+8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FF3C4CEFD;
	Wed, 29 Oct 2025 12:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740803;
	bh=QwDkSH3kLhu9Ya7BrIayv5fawfziMOL3Z/w1iCrFClA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=efcNJ+8uAGYgVJbZ2+NBccn0ZQjG0fPIeB9bz8Nq0SvOmbsmZbWL2tJv0RmtWuAcT
	 6zjksw5gEJUS3CTWxDoMFibgLEB6AUF2Q7gb2xiMSUXtFtWn/R23M4jOL7ltrbeb/u
	 ol8T5k8j2uI36alxuWbyjFpN2yh7nG2YVvLZ2jnHaycmO1CiR3Mgvg7JyP2LGmIYiG
	 +rZ9q07n80+XgXbYUo7iiqhpAueRLthbXqwJfOlMJ3cZZDTiz5X3Rv/FWRu7/ys5fc
	 plACgDT26f5t1kqpEDGrpKLNv9NHobqbxbvmjqzWpAzf61uvI7d9JY44s3T43Yd6fv
	 x+fe2AFckhDvw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:25 +0100
Subject: [PATCH v4 72/72] selftests/namespace: test listns() pagination
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-72-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5137; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QwDkSH3kLhu9Ya7BrIayv5fawfziMOL3Z/w1iCrFClA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysU2Q6TYOOrAk4Uqv2a6PU97OSDk4V3iXc2lF9qw7V
 9bLNs/f0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRr7cY/ns7ZRsJZzbwPppe
 8cv9zwKpRUsNd3+Z+mvKtucPDonOmLybkWGV8ufIx7KLt98y1tn/RHRfXY2bu71myPa+d+eblx/
 4ncAFAA==
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


