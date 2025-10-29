Return-Path: <linux-fsdevel+bounces-66268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E258AC1A951
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEFC427C72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC5532936E;
	Wed, 29 Oct 2025 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alegEg+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBE532721D;
	Wed, 29 Oct 2025 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740718; cv=none; b=iDZxmPAZLED/X3/mehEOstZzuXDpC69dXpRoDdaBR0leuPqidO7Mc3rcnCjPzPCOySxVGZ1qJTkmIpEyuR4tVW6YmjF/B2hFCLyFf23MTnw3fNIashDrJHAggVByXBRFJcpjHxKO0vGj0SS3gWTt8uZW5prOXxtvwiUz0+axYBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740718; c=relaxed/simple;
	bh=YEySNnwHHlcAx8fWB+paH4j8S+yvwldW7xKcAutT9lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXttWv/mfMzrk2+Orc0HZ0csS60qHX0Ayo1TREvDgqI2Bb0UXKBJpPLsGE7G2M4LLXaw9/fiu9uBeS0erUWPsG9HFPnUuHODDjrawzJWAdReLm8KcO8YWpTiZvr/yZnZzkoB+0gH1DZcoq+3ySaE0rnMykFnDG9b84ti0TSqiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alegEg+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF2BC4CEF7;
	Wed, 29 Oct 2025 12:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740717;
	bh=YEySNnwHHlcAx8fWB+paH4j8S+yvwldW7xKcAutT9lM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=alegEg+WcJzxaHq0d3Mu8J/r0uwNGYiPGYY6J50eS9OgmZdIDS1rOhiMcZ8Ue6AQV
	 5Ma4HSSoCyxrfDHOQ19AnfRTtvVGfbjifJsz6TjkRAOzaSSTuyhgNp0k9xGZzQ+/Q5
	 Zs19Ss1bmLsB2cB8Vl901HKmXv31WAU4Qg0tYQUOQlYJxjpyBfaer9b3wIkhnNUPct
	 xsq0Bw5xSSPDKfwq/k/7GPyk36Nig28WnY6GnmOTB29o77K9HXzCEBuV/+GgryEY1W
	 bvAp7IbI3uJjvS2APMhb32HnzguypJIA8tDFlkBXH4/esX2eBgQ320w8wxTb7oWwWN
	 Hk0i71EbikrrQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:08 +0100
Subject: [PATCH v4 55/72] selftests/namespaces: first inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-55-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3689; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YEySNnwHHlcAx8fWB+paH4j8S+yvwldW7xKcAutT9lM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfW32czN1b10LU/Q+8wn9tSeqffV3Tlexbxa2XdB2
 ecQu25aRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESOlTL8j7TxDCn4xve3Mcln
 TVTt9abCeypL0sJuf+Vza/TcpuM/gZFh8p8DnIb5gpJ2V1r6emZI6b3tl4usYLr65dLSoj1LlV+
 wAwA=
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


