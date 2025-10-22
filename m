Return-Path: <linux-fsdevel+bounces-65180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2CDBFD2D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65A5C357E33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AA7359FA5;
	Wed, 22 Oct 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYYCH3pi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57A359F8B;
	Wed, 22 Oct 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149443; cv=none; b=ArxCUMumJNjN7SLKh/d4MEogqmJYgVPj7bydxBgTHeS+xqIYHtM+IvjQimQg88cYCpnTydiZOGMubkbXv5SLRPFlHBQ/ZAJWXH5BKmccCcjsLvDq2yFsp8LlpjPdpf0wi6cqMiMMOvevBStMbGXC/9Mz7YwOnOFW/jHHLiY/Fv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149443; c=relaxed/simple;
	bh=YEySNnwHHlcAx8fWB+paH4j8S+yvwldW7xKcAutT9lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Au1yUX1WcmNdWQZ499PX3iUTDejc5OH2Nm2VdeUiDOvoxtsQwikS1j/krBQ9sx4aCklr3Zewbd5Ct+1vALONwyXxYrB45IB2nIjVd1QXELWriWVEmJBrjKYQGmh52atBc6P3Xl4gEVAST8cE4OMbgHme9xb40mvOSxX3QOlAckQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYYCH3pi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EB1C4CEE7;
	Wed, 22 Oct 2025 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149442;
	bh=YEySNnwHHlcAx8fWB+paH4j8S+yvwldW7xKcAutT9lM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SYYCH3piPyE/tqFlyW7bswylX36pM0Q8PLc5qrNfmZkr2hEgRZS1QqjBt0T1s46yJ
	 MSZYvmrn6sORK88o844JWiPUO7WvDQovQ7egn54vaDAFcRMF9ajwS34D9xt6C8XuDf
	 E2b9cMhMNTQlyLXyE2DaAitgdLQh3rb/Q2l6X9ipQAVsP3kAW0MiswPX5PWaixDbPd
	 w3DE2LXiZrwCKtbcJ4sY+U1AbS8OwYsxS7qqraukV3VMlio8+c+OG1RiAc7GIMPcXd
	 EPMeI8k08Cr2FXxQrqUAzfmrmodsP7hy2AeCjHZIspw9i2jTpmS4Y2ND6Ki7OZ4wIq
	 0AAD1Cd5WxDLg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:30 +0200
Subject: [PATCH v2 52/63] selftests/namespaces: first inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-52-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3689; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YEySNnwHHlcAx8fWB+paH4j8S+yvwldW7xKcAutT9lM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHh+Vn5ZZ9yVPwyOwocOe3le1mf928+/p13Oe7LKG
 kOnV10HO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyTYqRoZ3djvuJ+vmJJ09H
 3FD2tYh/FWa6ULfw4Hl3ie1N/tq3lzMyNDWX5wueq9ot+/vQfF/rkI6tdVWeLV+P7z3Qn/Sc+cR
 pVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test basic SIOCGSKNS functionality. Create a socket and verify SIOCGSKNS
returns the correct network namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/.gitignore      |  1 +
 tools/testing/selftests/namespaces/Makefile        |  9 ++-
 .../testing/selftests/namespaces/siocgskns_test.c  | 72 ++++++++++++++++++++++
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testing/selftests/namespaces/.gitignore
index 17f9c675a60b..aeb5f2711ff6 100644
--- a/tools/testing/selftests/namespaces/.gitignore
+++ b/tools/testing/selftests/namespaces/.gitignore
@@ -4,3 +4,4 @@ init_ino_test
 ns_active_ref_test
 listns_test
 listns_permissions_test
+siocgskns_test
diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/selftests/namespaces/Makefile
index 2dd22bc68b89..d456505189cd 100644
--- a/tools/testing/selftests/namespaces/Makefile
+++ b/tools/testing/selftests/namespaces/Makefile
@@ -2,11 +2,18 @@
 CFLAGS += -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS += -lcap
 
-TEST_GEN_PROGS := nsid_test file_handle_test init_ino_test ns_active_ref_test listns_test listns_permissions_test
+TEST_GEN_PROGS := nsid_test \
+		  file_handle_test \
+		  init_ino_test \
+		  ns_active_ref_test \
+		  listns_test \
+		  listns_permissions_test \
+		  siocgskns_test
 
 include ../lib.mk
 
 $(OUTPUT)/ns_active_ref_test: ../filesystems/utils.c
 $(OUTPUT)/listns_test: ../filesystems/utils.c
 $(OUTPUT)/listns_permissions_test: ../filesystems/utils.c
+$(OUTPUT)/siocgskns_test: ../filesystems/utils.c
 
diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
new file mode 100644
index 000000000000..0c9098624cd4
--- /dev/null
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -0,0 +1,72 @@
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
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <linux/if.h>
+#include <linux/sockios.h>
+#include <linux/nsfs.h>
+#include <arpa/inet.h>
+#include "../kselftest_harness.h"
+#include "../filesystems/utils.h"
+#include "wrappers.h"
+
+#ifndef SIOCGSKNS
+#define SIOCGSKNS 0x894C
+#endif
+
+#ifndef FD_NSFS_ROOT
+#define FD_NSFS_ROOT -10003
+#endif
+
+#ifndef FILEID_NSFS
+#define FILEID_NSFS 0xf1
+#endif
+
+/*
+ * Test basic SIOCGSKNS functionality.
+ * Create a socket and verify SIOCGSKNS returns the correct network namespace.
+ */
+TEST(siocgskns_basic)
+{
+	int sock_fd, netns_fd, current_netns_fd;
+	struct stat st1, st2;
+
+	/* Create a TCP socket */
+	sock_fd = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(sock_fd, 0);
+
+	/* Use SIOCGSKNS to get network namespace */
+	netns_fd = ioctl(sock_fd, SIOCGSKNS);
+	if (netns_fd < 0) {
+		close(sock_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "SIOCGSKNS not supported");
+		ASSERT_GE(netns_fd, 0);
+	}
+
+	/* Get current network namespace */
+	current_netns_fd = open("/proc/self/ns/net", O_RDONLY);
+	ASSERT_GE(current_netns_fd, 0);
+
+	/* Verify they match */
+	ASSERT_EQ(fstat(netns_fd, &st1), 0);
+	ASSERT_EQ(fstat(current_netns_fd, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+
+	close(sock_fd);
+	close(netns_fd);
+	close(current_netns_fd);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


