Return-Path: <linux-fsdevel+bounces-65461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3F2C05C74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20C08567346
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DB8326D75;
	Fri, 24 Oct 2025 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL8T81k6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157BE325484;
	Fri, 24 Oct 2025 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303289; cv=none; b=g1N637+BrqpMffpoLx8tOx+qgeR50K2/qIat34qeDkJA+3ZOEkAdceNIoN4VaHJW64Uq4yY0nK8ayD6m5wnucqFdtj8mMoIv9Pi1JE7kj7isr0whvbK+S7M7G+bfPBCkrMwDUzFPdg5NB5ddBvgxzFFpRjUmp+PoFrLlET2bHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303289; c=relaxed/simple;
	bh=zTxekEdjlVJZprVoI/00FXYGRRSOiQasmJAHzIPasqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJU+t67hyPed3DHU9O1ONLTj31JQbFa4dozoat6rzTr9nyxypumFvnJKU+mXR4YO1zlMp/IXZfZV8a2kb1rTthNKQ6n192TaNSLbIWzuVEpLUU1jLDizDVnZmmR66ji4g/j+F+ApaQMSHZKxuuh5HjW6bOvCAygeUa9bNfJR9Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL8T81k6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251ABC4CEF5;
	Fri, 24 Oct 2025 10:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303287;
	bh=zTxekEdjlVJZprVoI/00FXYGRRSOiQasmJAHzIPasqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NL8T81k6ruIE0BffChAF5qn47PPeGcsAzLCXOGXfje3uLxdINc8YNrGm4QVgB5k0v
	 DwUAlwUkgLCjTHpi1a6trZmL2FJQ0LQ8/uTe7DHGy0Ed6mKBTYt0PjhVou+4YQmSSZ
	 RMDuU7O3ucX330C/RkiJWEQX03nVx/ToUE172ePLMqhMhSxX0OglMVdqMPDmAJrV2z
	 a6draJ2gOIDgjQrSIXgQxlUBe8F8YuTHx0nfZDFCoo3Gestpn/OH6iOXbEKcmNa1vN
	 lu5TtAF5bSb0x/jT3LXum3Um5tvVF3HssJ6gT/P25edbqQjCNZy5dajVmn3UfmjqVi
	 xzHZNFiVFpalw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:52:50 +0200
Subject: [PATCH v3 21/70] selftests/namespaces: first active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-21-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3703; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zTxekEdjlVJZprVoI/00FXYGRRSOiQasmJAHzIPasqQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmq98vhNYEHJNq6VPRmhMbNM4696rZ7izHhcq+RE2
 FSpP65JHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPR3MPwv2LSryeh3QK/Vtz5
 9nPCty8Sy6fFe/Re2/j3m9zNhguNeSaMDEtXfd75w6VQQ0DH4lRcQf5Vxx1zd8/YPV9n1uLAk2+
 FNvEBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that initial namespaces can be reopened via file handle. Initial
namespaces should always have a ref count of one from boot.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/.gitignore      |  1 +
 tools/testing/selftests/namespaces/Makefile        |  5 +-
 .../selftests/namespaces/ns_active_ref_test.c      | 74 ++++++++++++++++++++++
 3 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testing/selftests/namespaces/.gitignore
index ccfb40837a73..100cc5bfef04 100644
--- a/tools/testing/selftests/namespaces/.gitignore
+++ b/tools/testing/selftests/namespaces/.gitignore
@@ -1,3 +1,4 @@
 nsid_test
 file_handle_test
 init_ino_test
+ns_active_ref_test
diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/selftests/namespaces/Makefile
index 5fe4b3dc07d3..5cea938cdde8 100644
--- a/tools/testing/selftests/namespaces/Makefile
+++ b/tools/testing/selftests/namespaces/Makefile
@@ -1,7 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+LDLIBS += -lcap
 
-TEST_GEN_PROGS := nsid_test file_handle_test init_ino_test
+TEST_GEN_PROGS := nsid_test file_handle_test init_ino_test ns_active_ref_test
 
 include ../lib.mk
 
+$(OUTPUT)/ns_active_ref_test: ../filesystems/utils.c
+
diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
new file mode 100644
index 000000000000..21514a537b26
--- /dev/null
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -0,0 +1,74 @@
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
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "../kselftest_harness.h"
+#include "../filesystems/utils.h"
+
+#ifndef FD_NSFS_ROOT
+#define FD_NSFS_ROOT -10003 /* Root of the nsfs filesystem */
+#endif
+
+/*
+ * Test that initial namespaces can be reopened via file handle.
+ * Initial namespaces should have active ref count of 1 from boot.
+ */
+TEST(init_ns_always_active)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd1, fd2;
+	struct stat st1, st2;
+
+	handle = malloc(sizeof(*handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(handle, NULL);
+
+	/* Open initial network namespace */
+	fd1 = open("/proc/1/ns/net", O_RDONLY);
+	ASSERT_GE(fd1, 0);
+
+	/* Get file handle for initial namespace */
+	handle->handle_bytes = MAX_HANDLE_SZ;
+	ret = name_to_handle_at(fd1, "", handle, &mount_id, AT_EMPTY_PATH);
+	if (ret < 0 && errno == EOPNOTSUPP) {
+		SKIP(free(handle); close(fd1);
+		     return, "nsfs doesn't support file handles");
+	}
+	ASSERT_EQ(ret, 0);
+
+	/* Close the namespace fd */
+	close(fd1);
+
+	/* Try to reopen via file handle - should succeed since init ns is always active */
+	fd2 = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (fd2 < 0 && (errno == EINVAL || errno == EOPNOTSUPP)) {
+		SKIP(free(handle);
+		     return, "open_by_handle_at with FD_NSFS_ROOT not supported");
+	}
+	ASSERT_GE(fd2, 0);
+
+	/* Verify we opened the same namespace */
+	fd1 = open("/proc/1/ns/net", O_RDONLY);
+	ASSERT_GE(fd1, 0);
+	ASSERT_EQ(fstat(fd1, &st1), 0);
+	ASSERT_EQ(fstat(fd2, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+
+	close(fd1);
+	close(fd2);
+	free(handle);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


