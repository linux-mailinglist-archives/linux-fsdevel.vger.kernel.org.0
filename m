Return-Path: <linux-fsdevel+bounces-64886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D93BBF6449
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95D8F502609
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57BE3491FA;
	Tue, 21 Oct 2025 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWyts7lh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDD62F260B;
	Tue, 21 Oct 2025 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047216; cv=none; b=OMQL3NZxHXftl6Ym8mnWCN9w1aFlKQ080FMHiRN5R+zjeM/XkktLR4GUffxFLTZqope+oI4nkugefzrbVl2jRLjIhJWCiLL9mH1AkV5mphc45efBL4c7ZkpQ+af9YO2G99tzj6n5+odOghSKMmH3jcvHdDtgGR50vxP1BS9lz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047216; c=relaxed/simple;
	bh=NAhtGlBVfCqrlTfWbGN1zDMklE1n7EKY3e8ekT2vQ0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZZhTDutU7Qt8Jcfy3EpUoebdGnFetYkyyiE5jSta+LnHZ23pPcCzoXaKRUgzkKGOvrF2H/9XXQfzRHgM0upZnt91kiSdxMRVnXkOYytQ4azR3oPPjv/EfmwicXRWQXHuvoRGufKvhVlyOkuMLhpEgURI7ksDqjZ7nV6DcAcMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWyts7lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44049C4CEF5;
	Tue, 21 Oct 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047215;
	bh=NAhtGlBVfCqrlTfWbGN1zDMklE1n7EKY3e8ekT2vQ0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tWyts7lhRJiIhmC8lpxqxClUdh9f1ARDoMC9DTctZogcSEPpaczLihkBeuF4yHnxl
	 OG11exn1M6mwVUjxqtf3GV9fkxG0nqd4VQhiOE5m8s/xObR8Gc7k/9vgtWyD5qZlVH
	 aAn+mzZp0K3pyshJ74Tw8etgJK+XOXPCt21/VG8HdxiIz5/FZJlu+i8tBBaJn0KZfs
	 o+PrS4qQjm2PJhnDq2DmwScJsR64QLcXGI1tOOk/5kylq860zVPMEunqJi4lnAeot+
	 4Eg0CjioasPZKd9F/mtfhj9Djy8Tem81DyqfqelRPi4zGhrA/iR5qCpFpR6ljJ/Zr6
	 hYK5DJEURQKKg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:41 +0200
Subject: [PATCH RFC DRAFT 35/50] selftests/namespaces: first listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-35-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3148; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NAhtGlBVfCqrlTfWbGN1zDMklE1n7EKY3e8ekT2vQ0Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3z3fqrIBqXNV6+v2Blg7BkcbDrZ9XX9r/aXDltaf
 Hij+l0edZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEIo2R4W/P7moNrsM1SjGW
 5emM7KxrVwU/eLRU/O20LPWPXVpHNRkZ3mSoy6ZGf5t0YN0vB2mfkJ0qHcsucrvHqsnNOJ89bYY
 nLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test basic listns() functionality with the unified namespace tree.
List all active namespaces globally.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/.gitignore    |  1 +
 tools/testing/selftests/namespaces/Makefile      |  3 +-
 tools/testing/selftests/namespaces/listns_test.c | 57 ++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testing/selftests/namespaces/.gitignore
index 100cc5bfef04..5065f07e92c9 100644
--- a/tools/testing/selftests/namespaces/.gitignore
+++ b/tools/testing/selftests/namespaces/.gitignore
@@ -2,3 +2,4 @@ nsid_test
 file_handle_test
 init_ino_test
 ns_active_ref_test
+listns_test
diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/selftests/namespaces/Makefile
index 5cea938cdde8..de708f4df159 100644
--- a/tools/testing/selftests/namespaces/Makefile
+++ b/tools/testing/selftests/namespaces/Makefile
@@ -2,9 +2,10 @@
 CFLAGS += -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS += -lcap
 
-TEST_GEN_PROGS := nsid_test file_handle_test init_ino_test ns_active_ref_test
+TEST_GEN_PROGS := nsid_test file_handle_test init_ino_test ns_active_ref_test listns_test
 
 include ../lib.mk
 
 $(OUTPUT)/ns_active_ref_test: ../filesystems/utils.c
+$(OUTPUT)/listns_test: ../filesystems/utils.c
 
diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
new file mode 100644
index 000000000000..cb42827d3dfe
--- /dev/null
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -0,0 +1,57 @@
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
+#include <sys/ioctl.h>
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
+ * Test basic listns() functionality with the unified namespace tree.
+ * List all active namespaces globally.
+ */
+TEST(listns_basic_unified)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,  /* All types */
+		.spare2 = 0,
+		.user_ns_id = 0,  /* Global listing */
+	};
+	__u64 ns_ids[100];
+	ssize_t ret;
+
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		TH_LOG("listns failed: %s (errno=%d)", strerror(errno), errno);
+		ASSERT_TRUE(false);
+	}
+
+	/* Should find at least the initial namespaces */
+	ASSERT_GT(ret, 0);
+	TH_LOG("Found %zd active namespaces", ret);
+
+	/* Verify all returned IDs are non-zero */
+	for (ssize_t i = 0; i < ret; i++) {
+		ASSERT_NE(ns_ids[i], 0);
+		TH_LOG("  [%zd] ns_id: %llu", i, (unsigned long long)ns_ids[i]);
+	}
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


