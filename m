Return-Path: <linux-fsdevel+bounces-28209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9871968020
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83534280F78
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 07:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4E9155A2F;
	Mon,  2 Sep 2024 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="vJU7RrP1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD727183CCB;
	Mon,  2 Sep 2024 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260896; cv=none; b=nqfXFd5NiGKRrXTigx1b/NUyj1yFQesn0+CCF46hllckKgLRkWp1Bo5nFUn8j72GdI91SgMnkpcnVo7oSxSUwFOUrMKQjQ9p/FT5bYwEq+Fr+A0jEU0eUoZVFkIZoAEPobGu2BpHU+Nlvhz4rZ9WMY5CnvadQf9JYk4Cglj9ORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260896; c=relaxed/simple;
	bh=E5GQk/KelJd1qt/IfY6sesWBLVH3qxbY3e/WlMrUjtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpXgGxsACbuxg0Z9Pe/kmWCRv4Mdim59GX9TLaCQSgVKjiJAlfzwbdt+TPH7L8gvm/rb+TPEen+ECN6xWXzYcAYfNXox3CBX7grzDiDpHBhE10NceXAjBRRNZmYEOzD6zB/Fykx9IiJd8iYHYWR3rISR3D8fJR3HI2++ZcKusbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=vJU7RrP1; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Wy0G34DMmz9tQG;
	Mon,  2 Sep 2024 09:08:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725260891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gu0LU3EVifMUIBL0ftvpiUawHEagDLy3T8fvvebqhSU=;
	b=vJU7RrP1FLbm+JqkFGB+xDEabpxLfq88hkugxECRh4xeGhVDMqraV0vBixoy5MFvxjR46d
	DHQF9SmClcAldCyRzI5sUNh8c+Hlf8ejdsCxFAj749iGjIygp+3nmTMiy3GyK6JqP55RMA
	H7a/DK8q1TexGB5H+mksmK1FhwVPU88r2j77+pNsncxln3S92JzEJs+M8WtRSDKSmsydmI
	ekyzztJS9YV8CtGWW6A0zBCdYGCGRDD5aD0sKrGZ7dq644kD3svksRa2PdKLHZMdN09HXK
	31/3lcM96dp2t9fXvghMSAK3fxsRjxJSttTngtOZ1kW06QST6SyoG3q2VGBlJQ==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 02 Sep 2024 17:06:30 +1000
Subject: [PATCH RFC 8/8] selftests: clone3: add CHECK_FIELDS selftests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-extensible-structs-check_fields-v1-8-545e93ede2f2@cyphar.com>
References: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
In-Reply-To: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8288; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=E5GQk/KelJd1qt/IfY6sesWBLVH3qxbY3e/WlMrUjtI=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaRdTWHdOZUlIWD++gI7D1Vf8emVzhG+BgcOna09Wrvqr
 8iclNliHaUsDGJcDLJiiizb/DxDN81ffCX500o2mDmsTCBDGLg4BWAiO6YzMrycrOr7f6uSS/P1
 64oyi8Jr5DT1gs06mlbqL9dzYZGNOcjwvzJuJ5fYs6zwmA7p6tUbvpl7FDL1Vc7a/b//dqZT1GN
 ZJgA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/clone3/.gitignore          |   1 +
 tools/testing/selftests/clone3/Makefile            |   2 +-
 .../testing/selftests/clone3/clone3_check_fields.c | 229 +++++++++++++++++++++
 3 files changed, 231 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/clone3/.gitignore b/tools/testing/selftests/clone3/.gitignore
index 83c0f6246055..4ec3e1ecd273 100644
--- a/tools/testing/selftests/clone3/.gitignore
+++ b/tools/testing/selftests/clone3/.gitignore
@@ -3,3 +3,4 @@ clone3
 clone3_clear_sighand
 clone3_set_tid
 clone3_cap_checkpoint_restore
+clone3_check_fields
diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
index 84832c369a2e..d310f2268066 100644
--- a/tools/testing/selftests/clone3/Makefile
+++ b/tools/testing/selftests/clone3/Makefile
@@ -3,6 +3,6 @@ CFLAGS += -g -std=gnu99 $(KHDR_INCLUDES)
 LDLIBS += -lcap
 
 TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
-	clone3_cap_checkpoint_restore
+	clone3_cap_checkpoint_restore clone3_check_fields
 
 include ../lib.mk
diff --git a/tools/testing/selftests/clone3/clone3_check_fields.c b/tools/testing/selftests/clone3/clone3_check_fields.c
new file mode 100644
index 000000000000..78b5cbf807a6
--- /dev/null
+++ b/tools/testing/selftests/clone3/clone3_check_fields.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2024 SUSE LLC
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <inttypes.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sched.h>
+
+#include "../kselftest.h"
+#include "clone3_selftests.h"
+
+#ifndef CHECK_FIELDS
+#define CHECK_FIELDS (1ULL << 63)
+#endif
+
+#ifndef EEXTSYS_NOOP
+#define EEXTSYS_NOOP 134
+#endif
+
+struct __clone_args_v0 {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+};
+
+struct __clone_args_v1 {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+	__aligned_u64 set_tid;
+	__aligned_u64 set_tid_size;
+};
+
+struct __clone_args_v2 {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+	__aligned_u64 set_tid;
+	__aligned_u64 set_tid_size;
+	__aligned_u64 cgroup;
+};
+
+static int call_clone3(void *clone_args, size_t size)
+{
+	int status;
+	pid_t pid;
+
+	pid = sys_clone3(clone_args, size);
+	if (pid < 0) {
+		ksft_print_msg("%d (%s) - Failed to create new process\n",
+			       errno, strerror(errno));
+		return -errno;
+	}
+
+	if (pid == 0) {
+		ksft_print_msg("I am the child, my PID is %d\n", getpid());
+		_exit(EXIT_SUCCESS);
+	}
+
+	ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
+			getpid(), pid);
+
+	if (waitpid(-1, &status, __WALL) < 0) {
+		ksft_print_msg("waitpid() returned %s\n", strerror(errno));
+		return -errno;
+	}
+	if (!WIFEXITED(status)) {
+		ksft_print_msg("Child did not exit normally, status 0x%x\n",
+			       status);
+		return EXIT_FAILURE;
+	}
+	if (WEXITSTATUS(status))
+		return WEXITSTATUS(status);
+
+	return 0;
+}
+
+static bool check(bool *failed, bool pred)
+{
+	*failed |= pred;
+	return pred;
+}
+
+static void test_clone3_check_fields(const char *test_name, size_t struct_size)
+{
+	size_t bufsize;
+	void *buffer;
+	pid_t pid;
+	bool failed = false;
+	void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
+
+	/* Allocate some bytes after clone_args to verify that the . */
+	bufsize = struct_size + 16;
+	buffer = malloc(bufsize);
+	memset(buffer, 0, bufsize);
+
+	pid = call_clone3(buffer, CHECK_FIELDS | struct_size);
+	if (check(&failed, (pid != -EEXTSYS_NOOP)))
+		ksft_print_msg("clone3(CHECK_FIELDS) returned the wrong error code: %d (%s)\n",
+			       pid, strerror(-pid));
+
+	switch (struct_size) {
+	case sizeof(struct __clone_args_v2): {
+		struct __clone_args_v2 *args = buffer;
+
+		if (check(&failed, (args->cgroup != 0xFFFFFFFFFFFFFFFF)))
+			ksft_print_msg("clone3(CHECK_FIELDS) has wrong cgroup field: 0x%.16llx != 0x%.16llx\n",
+				       args->cgroup, 0xFFFFFFFFFFFFFFFF);
+
+		/* fallthrough; */
+	}
+	case sizeof(struct __clone_args_v1): {
+		struct __clone_args_v1 *args = buffer;
+
+		if (check(&failed, (args->set_tid != 0xFFFFFFFFFFFFFFFF)))
+			ksft_print_msg("clone3(CHECK_FIELDS) has wrong set_tid field: 0x%.16llx != 0x%.16llx\n",
+				       args->set_tid, 0xFFFFFFFFFFFFFFFF);
+		if (check(&failed, (args->set_tid_size != 0xFFFFFFFFFFFFFFFF)))
+			ksft_print_msg("clone3(CHECK_FIELDS) has wrong set_tid_size field: 0x%.16llx != 0x%.16llx\n",
+				       args->set_tid_size, 0xFFFFFFFFFFFFFFFF);
+
+		/* fallthrough; */
+	}
+	case sizeof(struct __clone_args_v0): {
+		struct __clone_args_v0 *args = buffer;
+
+		if (check(&failed, !(args->flags & CLONE_NEWUSER)))
+			ksft_print_msg("clone3(CHECK_FIELDS) is missing CLONE_NEWUSER in flags: 0x%.16llx (0x%.16llx)\n",
+				       args->flags, CLONE_NEWUSER);
+		if (check(&failed, !(args->flags & CLONE_THREAD)))
+			ksft_print_msg("clone3(CHECK_FIELDS) is missing CLONE_THREAD in flags: 0x%.16llx (0x%.16llx)\n",
+				       args->flags, CLONE_THREAD);
+		/*
+		 * CLONE_INTO_CGROUP was added in v2, but it will be set even
+		 * with smaller structure sizes.
+		 */
+		if (check(&failed, !(args->flags & CLONE_INTO_CGROUP)))
+			ksft_print_msg("clone3(CHECK_FIELDS) is missing CLONE_INTO_CGROUP in flags: 0x%.16llx (0x%.16llx)\n",
+				       args->flags, CLONE_INTO_CGROUP);
+
+		if (check(&failed, (args->exit_signal != 0xFF)))
+			ksft_print_msg("clone3(CHECK_FIELDS) has wrong exit_signal field: 0x%.16llx != 0x%.16llx\n",
+				       args->exit_signal, 0xFF);
+
+		if (check(&failed, (args->stack != 0xFFFFFFFFFFFFFFFF)))
+			ksft_print_msg("clone3(CHECK_FIELDS) has wrong stack field: 0x%.16llx != 0x%.16llx\n",
+				       args->stack, 0xFFFFFFFFFFFFFFFF);
+		if (check(&failed, (args->stack_size != 0xFFFFFFFFFFFFFFFF)))
+			ksft_print_msg("clone3(CHECK_FIELDS) has wrong stack_size field: 0x%.16llx != 0x%.16llx\n",
+				       args->stack_size, 0xFFFFFFFFFFFFFFFF);
+		if (check(&failed, (args->tls != 0xFFFFFFFFFFFFFFFF)))
+			ksft_print_msg("clone3(CHECK_FIELDS) has wrong tls field: 0x%.16llx != 0x%.16llx\n",
+				       args->tls, 0xFFFFFFFFFFFFFFFF);
+
+		break;
+	}
+	default:
+		fprintf(stderr, "INVALID STRUCTURE SIZE: %d\n", struct_size);
+		abort();
+	}
+
+	/* Verify that the trailing parts of the buffer are still 0. */
+	for (size_t i = struct_size; i < bufsize; i++) {
+		char ch = ((char *)buffer)[i];
+		if (check(&failed, (ch != '\x00')))
+			ksft_print_msg("clone3(CHECK_FIELDS) touched a byte outside the size: buffer[%d] = 0x%.2x\n",
+				       i, ch);
+	}
+
+	if (failed)
+		resultfn = ksft_test_result_fail;
+
+	resultfn("clone3(CHECK_FIELDS) with %s\n", test_name);
+	free(buffer);
+}
+
+struct check_fields_test {
+	const char *name;
+	size_t struct_size;
+};
+
+static struct check_fields_test check_fields_tests[] = {
+	{"struct v0", sizeof(struct __clone_args_v0)},
+	{"struct v1", sizeof(struct __clone_args_v1)},
+	{"struct v2", sizeof(struct __clone_args_v2)},
+};
+
+int main(void)
+{
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(check_fields_tests));
+	test_clone3_supported();
+
+	for (int i = 0; i < ARRAY_SIZE(check_fields_tests); i++) {
+		struct check_fields_test *test = &check_fields_tests[i];
+		test_clone3_check_fields(test->name, test->struct_size);
+	}
+
+	ksft_finished();
+}

-- 
2.46.0


