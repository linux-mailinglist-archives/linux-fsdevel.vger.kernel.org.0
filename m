Return-Path: <linux-fsdevel+bounces-65164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3E2BFD413
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C714E3BB24C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0F4375720;
	Wed, 22 Oct 2025 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmhtEIrB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F335773D;
	Wed, 22 Oct 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149357; cv=none; b=LZ7kP+9bAy+Ex4CAr/r46Yysu59a2IGvF2fNbZjQ5y3oYxMB71GG737i+o1SjXmQjpsvcI467dI+GRzlPbiE4myKNntfLJC+jGu5MUHQuELJbAUE9zZ42Is8gJt55UiE+kdSrSkXPa21U7F+VthwTi7yu4GvwpP43gAurC+nwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149357; c=relaxed/simple;
	bh=NAhtGlBVfCqrlTfWbGN1zDMklE1n7EKY3e8ekT2vQ0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hOjcNQCRJrDn2FCZm3Jd/mK8V92W3SQHJp8LytHGK8fLtq42cuwsPCd0LrdBEUyyRDtOPquz6pIKQ5jw/gQ0Nh5PpS/g+oJ1VKGcbsV1tStW2nWk1adsIM2jXAP/kCmZpqUPJXHycAhnnze8M+vCxahnMGXigITHcsiJrLvKZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmhtEIrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90250C4CEF7;
	Wed, 22 Oct 2025 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149357;
	bh=NAhtGlBVfCqrlTfWbGN1zDMklE1n7EKY3e8ekT2vQ0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KmhtEIrBRkeyMEsu4AooHO/8X7U3hah6e1DRrtmxOGwN9G0ZwiI8b9qG3MdOYPUwn
	 ylzFan+Jw0iB2Bd+zdWBHnBdyK5WBSTaFScZa2HWUK3HPN8BOJsY/cRdeLKcWiIDLa
	 BRK2Oi7CUU2/SfvIobaT+tINSasLarirde8Jv0nCHSUQt2OtEhoWIRw6iwOxmojvy+
	 qcuwEuykj/lJ3WHbf56WXl/JJklZB7Jx/E+VtWjSKn/mhjNslkLiD9TEd88NCB/lcl
	 a37CgEPLPnT44TaBt886ovW3PspMKv0w/ixoIacJnZX8uxvWmduvdnTRk9pXudPoyH
	 0NRU6Ntli+g5A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:14 +0200
Subject: [PATCH v2 36/63] selftests/namespaces: first listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-36-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3148; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NAhtGlBVfCqrlTfWbGN1zDMklE1n7EKY3e8ekT2vQ0Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHh258H3vXV+Gm28XR6Pyk/81vp1a6pI6GO9pWVbu
 66u22szp6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi+ucZ/tlO3fdlTjuT36ue
 /14bduZviN3He01IRyllvcqBczMrDAUZ/pd9mlFz0dLuntEk4RnXApl31uoKnbSVPN9jdvCuduC
 EK0wA
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


