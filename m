Return-Path: <linux-fsdevel+bounces-62217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B74B88BD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 12:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686DF1C80B56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281AE2F5308;
	Fri, 19 Sep 2025 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzJdZoGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A482222B4
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276108; cv=none; b=AMiL/nYUzR9+Wp1+PnHbHvITsS80Ej/TILS2ao3i2Z7Tt7v/Z4dOQedXzEif9qyYKTLrwlERBBE2+q5AC+UD3H/I98d9Nkl9Lmf6b03MjrZ6Zbxv2bHf7Al+CGo7ksMawJLtNaQ1A+3b1u+2z9DhJ1ZCoe8ANa45l8aBTeGeY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276108; c=relaxed/simple;
	bh=11pW80UJmh9+JzxjU76gGgINsCsgjYUo14K91xAJe9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NvJDm9trXVtikNg3PYmBgH64Yq5cx4iIAdJjLku8ZIWFVubFHiwrBi/BEtegvwN/IGkZ/RHtJfLw8Cra+hnyR2KT3iEKcWAQOSyjRIJ2QyzxFN/wdFkrVbhlu6gBdWSl1Nkm54jSw4ldQ8XwW8nPG922jL9FMUahnNFqOrpIKOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzJdZoGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56F7C4CEF0;
	Fri, 19 Sep 2025 10:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758276108;
	bh=11pW80UJmh9+JzxjU76gGgINsCsgjYUo14K91xAJe9E=;
	h=From:Date:Subject:To:Cc:From;
	b=KzJdZoGMWm0r6lXZWkMYoVSe+1CmmxM9LyN0A+No4n5b6dwFJyzq+LiqU3zHE7oYE
	 gtyw3O/9RMw+CPIml9Rv6gSdA9RMSyVBbhIEtkSk7anPrA8psIlMX747XC3aurbHLC
	 gHHSpBou7m33Wig1U0r7ox+giJV0moU6KeJUZySdwMmUl6Djpfm1n2YLAdnNi+3AJN
	 ReWC8nHdALTNkGiIuj0i5neVbyyc6VVZHK+39XTg8z9PG6hxgtJlNh0AGUZDfiDjN/
	 X7MQGxSJRDW8O5+s1tcYjBL3Bs6h7S8RMNrsnIGvtn1/Xp58c9FK6LW8Hydt6e5irn
	 DrdvqXzvNC+pg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 19 Sep 2025 12:01:38 +0200
Subject: [PATCH] selftests/namespaces: verify initial namespace inode
 numbers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-work-namespace-selftests-v1-1-be04cbf4bc37@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAEqzWgC/0XMMQ7CMAxA0atUnjFqopY0XAUxOMGhEZBWdgVIV
 e9OYGF8w/8rKEtmhWOzgvAza55Khdk1EEcqV8Z8qQbb2r71xuNrkhsWerDOFBmV72lhXRRd6Ny
 QOtM7b6Hms3DK79/6dK4OpIxBqMTxO/wvDnszwLZ9AH0GVwWLAAAA
X-Change-ID: 20250919-work-namespace-selftests-7b478f415792
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=3425; i=brauner@kernel.org;
 h=from:subject:message-id; bh=11pW80UJmh9+JzxjU76gGgINsCsgjYUo14K91xAJe9E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc1eKMtss8Xepv+/+U6rFjtZzyEqrHE6KMy72v58suO
 lr+2FO2o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKL5zH8M34k0sfQosYkfdkg
 /d/Ggle8a/vunpjRfqboXaDKqvczjRn+GdTFX71s+5YjfYcRz9VN0/27aksmi67y2pPrpmRcbz2
 PCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make sure that all works correctly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/.gitignore      |  1 +
 tools/testing/selftests/namespaces/Makefile        |  2 +-
 tools/testing/selftests/namespaces/init_ino_test.c | 60 ++++++++++++++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testing/selftests/namespaces/.gitignore
index 7639dbf58bbf..ccfb40837a73 100644
--- a/tools/testing/selftests/namespaces/.gitignore
+++ b/tools/testing/selftests/namespaces/.gitignore
@@ -1,2 +1,3 @@
 nsid_test
 file_handle_test
+init_ino_test
diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/selftests/namespaces/Makefile
index f6c117ce2c2b..5fe4b3dc07d3 100644
--- a/tools/testing/selftests/namespaces/Makefile
+++ b/tools/testing/selftests/namespaces/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 
-TEST_GEN_PROGS := nsid_test file_handle_test
+TEST_GEN_PROGS := nsid_test file_handle_test init_ino_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/namespaces/init_ino_test.c b/tools/testing/selftests/namespaces/init_ino_test.c
new file mode 100644
index 000000000000..ddd5008d46a6
--- /dev/null
+++ b/tools/testing/selftests/namespaces/init_ino_test.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2025 Christian Brauner <brauner@kernel.org>
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <linux/nsfs.h>
+
+#include "../kselftest_harness.h"
+
+struct ns_info {
+	const char *name;
+	const char *proc_path;
+	unsigned int expected_ino;
+};
+
+static struct ns_info namespaces[] = {
+	{ "ipc",    "/proc/1/ns/ipc",    IPC_NS_INIT_INO },
+	{ "uts",    "/proc/1/ns/uts",    UTS_NS_INIT_INO },
+	{ "user",   "/proc/1/ns/user",   USER_NS_INIT_INO },
+	{ "pid",    "/proc/1/ns/pid",    PID_NS_INIT_INO },
+	{ "cgroup", "/proc/1/ns/cgroup", CGROUP_NS_INIT_INO },
+	{ "time",   "/proc/1/ns/time",   TIME_NS_INIT_INO },
+	{ "net",    "/proc/1/ns/net",    NET_NS_INIT_INO },
+	{ "mnt",    "/proc/1/ns/mnt",    MNT_NS_INIT_INO },
+};
+
+TEST(init_namespace_inodes)
+{
+	struct stat st;
+
+	for (int i = 0; i < sizeof(namespaces) / sizeof(namespaces[0]); i++) {
+		int ret = stat(namespaces[i].proc_path, &st);
+		
+		/* Some namespaces might not be available (e.g., time namespace on older kernels) */
+		if (ret < 0) {
+			if (errno == ENOENT) {
+				ksft_test_result_skip("%s namespace not available\n", namespaces[i].name);
+				continue;
+			}
+			ASSERT_GE(ret, 0)
+				TH_LOG("Failed to stat %s: %s", namespaces[i].proc_path, strerror(errno));
+		}
+
+		ASSERT_EQ(st.st_ino, namespaces[i].expected_ino) {
+			TH_LOG("Namespace %s has inode 0x%lx, expected 0x%x",
+			       namespaces[i].name, st.st_ino, namespaces[i].expected_ino);
+		}
+
+		ksft_print_msg("Namespace %s: inode 0x%lx matches expected 0x%x\n",
+			       namespaces[i].name, st.st_ino, namespaces[i].expected_ino);
+	}
+}
+
+TEST_HARNESS_MAIN

---
base-commit: 5a9b4dfe901cecd4e06692bb877b393459e4d50d
change-id: 20250919-work-namespace-selftests-7b478f415792


