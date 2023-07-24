Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C1675F750
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjGXMyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 08:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjGXMx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:53:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121343A8F;
        Mon, 24 Jul 2023 05:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BF7361166;
        Mon, 24 Jul 2023 12:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE19AC433C7;
        Mon, 24 Jul 2023 12:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690203019;
        bh=PDX/i4+fFmNinWArKmgCBD81AP/VqydBiUWqO2kyXWw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=FxXy0+nfT98Opbzb3MyUz+BtkZmXTeyXRJBFJBXZkGEq+pk6x+ro/XAqRU7rCNNhV
         jykXMa4Wd9kYUX9NumwRN5uaaTjeC2hLJ5WuMdplRumE+1B5LHQRHf7f9Lli1lf4UL
         cu6vcjah6gv/CW4ZE8Sa+r9D4za1sOn8HbRe8KFK/mqmwLDmZSIvSJES2tOx6oS97V
         wzTydx8cwMAOnN36ErUWRfTKLRMbv8tRtP9Sglv8nKUodVto8j0l3NCMzLviyhBMby
         NPEFlXjK+od4N8fqavmgy/b7QziLMZSallylKi97pQUuQeIwheKB2CFlI8WGeevHhA
         3PdTg6toJoh7Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 24 Jul 2023 13:46:18 +0100
Subject: [PATCH v2 31/35] kselftest/arm64: Add very basic GCS test program
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-arm64-gcs-v2-31-dc2c1d44c2eb@kernel.org>
References: <20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org>
In-Reply-To: <20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=12863; i=broonie@kernel.org;
 h=from:subject:message-id; bh=PDX/i4+fFmNinWArKmgCBD81AP/VqydBiUWqO2kyXWw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkvnK5s4F26dClHtsRv7gKsv/4cmzaQ4WjiEO4cN26
 f87F5UOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZL5yuQAKCRAk1otyXVSH0CBOB/
 9HDBmt9W+5APBJ6ecYRNvR8/bjOgN50IN3Sr93T9CgULfi0fI8E8mWb/wHwsUFJ74StiLlcPAuGpP4
 2Sf6kyqk0wz06Qc7Wu8KvGD0OI7ZGFSVRnKQqqrKC2HekLvpLl5TtOLGJqw11w+WZdOV76mBYFO9D5
 FIs2JRfn5agF2cmNG4FbLSVyJh1i1dxr/M5R4wBilTaBQZ2n9peMk9I61mRkwC8Os+eH+1wVEKvJJ/
 ALvzm5DTOfuAcNewuonFo+USnzWulLigGPOlNsEelVH3EqkEsBO5KP6wAifURsL++5p1ym4MwD4TPQ
 3zHJk0jEGFmB1Oynwj+kMTGZs60Xoh
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This test program just covers the basic GCS ABI, covering aspects of the
ABI as standalone features without attempting to integrate things.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/gcs/.gitignore  |   1 +
 tools/testing/selftests/arm64/gcs/Makefile    |  17 ++
 tools/testing/selftests/arm64/gcs/basic-gcs.c | 351 ++++++++++++++++++++++++++
 tools/testing/selftests/arm64/gcs/gcs-util.h  |  87 +++++++
 5 files changed, 457 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index ace8b67fb22d..66877a879a9d 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,7 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
-ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi
+ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi gcs
 else
 ARM64_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/arm64/gcs/.gitignore b/tools/testing/selftests/arm64/gcs/.gitignore
new file mode 100644
index 000000000000..0e5e695ecba5
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/.gitignore
@@ -0,0 +1 @@
+basic-gcs
diff --git a/tools/testing/selftests/arm64/gcs/Makefile b/tools/testing/selftests/arm64/gcs/Makefile
new file mode 100644
index 000000000000..322c40d25f2e
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 ARM Limited
+#
+# In order to avoid interaction with the toolchain and dynamic linker the
+# portions of these tests that interact with the GCS are implemented using
+# nolibc.
+#
+
+TEST_GEN_PROGS := basic-gcs
+
+include ../../lib.mk
+
+$(OUTPUT)/basic-gcs: basic-gcs.c
+	$(CC) -g -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
+		-static -include ../../../../include/nolibc/nolibc.h \
+		-std=gnu99 -I../.. -g \
+		-ffreestanding -Wall $^ -o $@ -lgcc
diff --git a/tools/testing/selftests/arm64/gcs/basic-gcs.c b/tools/testing/selftests/arm64/gcs/basic-gcs.c
new file mode 100644
index 000000000000..625258e00302
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/basic-gcs.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 ARM Limited.
+ */
+
+#include <limits.h>
+#include <stdbool.h>
+
+#include <linux/prctl.h>
+
+#include "kselftest.h"
+#include "gcs-util.h"
+
+/* nolibc doesn't have sysconf(), just hard code the maximum */
+static size_t page_size = 65536;
+
+static  __attribute__((noinline)) void valid_gcs_function(void)
+{
+	/* Do something the compiler can't optimise out */
+	my_syscall1(__NR_prctl, PR_SVE_GET_VL);
+}
+
+static inline int gcs_set_status(unsigned long mode)
+{
+	bool enabling = mode & PR_SHADOW_STACK_ENABLE;
+	int ret;
+	unsigned long new_mode;
+
+	/*
+	 * The prctl takes 1 argument but we need to ensure that the
+	 * other 3 values passed in registers to the syscall are zero
+	 * since the kernel validates them.
+	 */
+	ret = my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, mode,
+			  0, 0, 0);
+
+	if (ret == 0) {
+		ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
+				  &new_mode, 0, 0, 0);
+		if (ret == 0) {
+			if (new_mode != mode) {
+				ksft_print_msg("Mode set to %x not %x\n",
+					       new_mode, mode);
+				ret = -EINVAL;
+			}
+		} else {
+			ksft_print_msg("Failed to validate mode: %d\n", ret);
+		}
+
+		if (enabling != chkfeat_gcs()) {
+			ksft_print_msg("%senabled by prctl but %senabled in CHKFEAT\n",
+				       enabling ? "" : "not ",
+				       chkfeat_gcs() ? "" : "not ");
+			ret = -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+/* Try to read the status */
+static bool read_status(void)
+{
+	unsigned long state;
+	int ret;
+
+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
+			  &state, 0, 0, 0);
+	if (ret != 0) {
+		ksft_print_msg("Failed to read state: %d\n", ret);
+		return false;
+	}
+
+	return state & PR_SHADOW_STACK_ENABLE;
+}
+
+/* Just a straight enable */
+static bool base_enable(void)
+{
+	int ret;
+
+	ret = gcs_set_status(PR_SHADOW_STACK_ENABLE);
+	if (ret) {
+		ksft_print_msg("PR_SHADOW_STACK_ENABLE failed %d\n", ret);
+		return false;
+	}
+
+	return true;
+}
+
+/* Check we can read GCSPR_EL0 when GCS is enabled */
+static bool read_gcspr_el0(void)
+{
+	unsigned long *gcspr_el0;
+
+	ksft_print_msg("GET GCSPR\n");
+	gcspr_el0 = get_gcspr();
+	ksft_print_msg("GCSPR_EL0 is %p\n", gcspr_el0);
+
+	return true;
+}
+
+/* Also allow writes to stack */
+static bool enable_writeable(void)
+{
+	int ret;
+
+	ret = gcs_set_status(PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE);
+	if (ret) {
+		ksft_print_msg("PR_SHADOW_STACK_ENABLE writeable failed: %d\n", ret);
+		return false;
+	}
+
+	ret = gcs_set_status(PR_SHADOW_STACK_ENABLE);
+	if (ret) {
+		ksft_print_msg("failed to restore plain enable %d\n", ret);
+		return false;
+	}
+
+	return true;
+}
+
+/* Also allow writes to stack */
+static bool enable_push_pop(void)
+{
+	int ret;
+
+	ret = gcs_set_status(PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_PUSH);
+	if (ret) {
+		ksft_print_msg("PR_SHADOW_STACK_ENABLE with push failed: %d\n",
+			       ret);
+		return false;
+	}
+
+	ret = gcs_set_status(PR_SHADOW_STACK_ENABLE);
+	if (ret) {
+		ksft_print_msg("failed to restore plain enable %d\n", ret);
+		return false;
+	}
+
+	return true;
+}
+
+/* Enable GCS and allow everything */
+static bool enable_all(void)
+{
+	int ret;
+
+	ret = gcs_set_status(PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_PUSH |
+			     PR_SHADOW_STACK_WRITE);
+	if (ret) {
+		ksft_print_msg("PR_SHADOW_STACK_ENABLE with everything failed: %d\n",
+			       ret);
+		return false;
+	}
+
+	ret = gcs_set_status(PR_SHADOW_STACK_ENABLE);
+	if (ret) {
+		ksft_print_msg("failed to restore plain enable %d\n", ret);
+		return false;
+	}
+
+	return true;
+}
+
+static bool enable_invalid(void)
+{
+	int ret = gcs_set_status(ULONG_MAX);
+	if (ret == 0) {
+		ksft_print_msg("GCS_SET_STATUS %lx succeeded\n", ULONG_MAX);
+		return false;
+	}
+
+	return true;
+}
+
+/* Map a GCS */
+static bool map_guarded_stack(void)
+{
+	int ret;
+	uint64_t *buf;
+	uint64_t expected_cap;
+	int elem;
+	bool pass = true;
+
+	buf = (void *)my_syscall3(__NR_map_shadow_stack, 0, page_size, 0);
+	if (buf == MAP_FAILED) {
+		ksft_print_msg("Failed to map %d byte GCS: %d\n",
+			       page_size, errno);
+		return false;
+	}
+	ksft_print_msg("Mapped GCS at %p-%p\n", buf,
+		       (uint64_t)buf + page_size);
+
+	/* The top of the newly allocated region should be 0 */
+	elem = (page_size / sizeof(uint64_t)) - 1;
+	if (buf[elem]) {
+		ksft_print_msg("Last entry is 0x%lx not 0x0\n", buf[elem]);
+		pass = false;
+	}
+
+	/* Then a valid cap token */
+	elem--;
+	expected_cap = ((uint64_t)buf + page_size - 16);
+	expected_cap &= GCS_CAP_ADDR_MASK;
+	expected_cap |= GCS_CAP_VALID_TOKEN;
+	if (buf[elem] != expected_cap) {
+		ksft_print_msg("Cap entry is 0x%lx not 0x%lx\n",
+			       buf[elem], expected_cap);
+		pass = false;
+	}
+	ksft_print_msg("cap token is 0x%lx\n", buf[elem]);
+
+	/* The rest should be zeros */
+	for (elem = 0; elem < page_size / sizeof(uint64_t) - 2; elem++) {
+		if (!buf[elem])
+			continue;
+		ksft_print_msg("GCS slot %d is 0x%lx not 0x0\n",
+			       elem, buf[elem]);
+		pass = false;
+	}
+
+	ret = munmap(buf, page_size);
+	if (ret != 0) {
+		ksft_print_msg("Failed to unmap %d byte GCS: %d\n",
+			       page_size, errno);
+		pass = false;
+	}
+
+	return pass;
+}
+
+/* A fork()ed process can run */
+static bool test_fork(void)
+{
+	unsigned long child_mode;
+	int ret, status;
+	pid_t pid;
+	bool pass = true;
+
+	pid = fork();
+	if (pid == -1) {
+		ksft_print_msg("fork() failed: %d\n", errno);
+		pass = false;
+		goto out;
+	}
+	if (pid == 0) {
+		/* In child, make sure we can call a function, read
+		 * the GCS pointer and status and then exit */
+		valid_gcs_function();
+		get_gcspr();
+
+		ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
+				  &child_mode, 0, 0, 0);
+		if (ret == 0 && !(child_mode & PR_SHADOW_STACK_ENABLE)) {
+			ksft_print_msg("GCS not enabled in child\n");
+			ret = -EINVAL;
+		}
+
+		exit(ret);
+	}
+
+	/*
+	 * In parent, check we can still do function calls then block
+	 * for the child.
+	 */
+	valid_gcs_function();
+
+	ksft_print_msg("Waiting for child %d\n", pid);
+
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		ksft_print_msg("Failed to wait for child: %d\n",
+			       errno);
+		return false;
+	}
+
+	if (!WIFEXITED(status)) {
+		ksft_print_msg("Child exited due to signal %d\n",
+			       WTERMSIG(status));
+		pass = false;
+	} else {
+		if (WEXITSTATUS(status)) {
+			ksft_print_msg("Child exited with status %d\n",
+				       WEXITSTATUS(status));
+			pass = false;
+		}
+	}
+
+out:
+
+	return pass;
+}
+
+typedef bool (*gcs_test)(void);
+
+static struct {
+	char *name;
+	gcs_test test;
+	bool needs_enable;
+} tests[] = {
+	{ "read_status", read_status },
+	{ "base_enable", base_enable, true },
+	{ "read_gcspr_el0", read_gcspr_el0 },
+	{ "enable_writeable", enable_writeable, true },
+	{ "enable_push_pop", enable_push_pop, true },
+	{ "enable_all", enable_all, true },
+	{ "enable_invalid", enable_invalid, true },
+	{ "map_guarded_stack", map_guarded_stack },
+	{ "fork", test_fork },
+};
+
+int main(void)
+{
+	int i, ret;
+	unsigned long gcs_mode;
+
+	ksft_print_header();
+
+	/*
+	 * We don't have getauxval() with nolibc so treat a failure to
+	 * read GCS state as a lack of support and skip.
+	 */
+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
+			  &gcs_mode, 0, 0, 0);
+	if (ret != 0)
+		ksft_exit_skip("Failed to read GCS state: %d\n", ret);
+
+	if (!(gcs_mode & PR_SHADOW_STACK_ENABLE)) {
+		gcs_mode = PR_SHADOW_STACK_ENABLE;
+		ret = my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
+				  gcs_mode, 0, 0, 0);
+		if (ret != 0)
+			ksft_exit_fail_msg("Failed to enable GCS: %d\n", ret);
+	}
+
+	ksft_set_plan(ARRAY_SIZE(tests));
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		ksft_test_result((*tests[i].test)(), "%s\n", tests[i].name);
+	}
+
+	/* One last test: disable GCS, we can do this one time */
+	my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0, 0, 0, 0);
+	if (ret != 0)
+		ksft_print_msg("Failed to disable GCS: %d\n", ret);
+
+	ksft_finished();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/arm64/gcs/gcs-util.h b/tools/testing/selftests/arm64/gcs/gcs-util.h
new file mode 100644
index 000000000000..c517f1a710c5
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/gcs-util.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 ARM Limited.
+ */
+
+#ifndef GCS_UTIL_H
+#define GCS_UTIL_H
+
+#include <stdbool.h>
+
+#ifndef __NR_map_shadow_stack
+#define __NR_map_shadow_stack 452
+#endif
+
+#ifndef __NR_prctl
+#define __NR_prctl 167
+#endif
+
+/* Shadow Stack/Guarded Control Stack interface */
+#define PR_GET_SHADOW_STACK_STATUS	71
+#define PR_SET_SHADOW_STACK_STATUS      72
+#define PR_LOCK_SHADOW_STACK_STATUS     73
+
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+# define PR_SHADOW_STACK_WRITE		(1UL << 1)
+# define PR_SHADOW_STACK_PUSH		(1UL << 2)
+
+#define PR_SHADOW_STACK_ALL_MODES \
+	PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE | PR_SHADOW_STACK_PUSH
+
+#define GCS_CAP_ADDR_MASK		(0xfffffffffffff000UL)
+#define GCS_CAP_TOKEN_MASK		(0x0000000000000fffUL)
+#define GCS_CAP_VALID_TOKEN		1
+#define GCS_CAP_IN_PROGRESS_TOKEN	5
+
+#define GCS_CAP(x) (((unsigned long)(x) & GCS_CAP_ADDR_MASK) | \
+		    GCS_CAP_VALID_TOKEN)
+
+static inline unsigned long *get_gcspr(void)
+{
+	unsigned long *gcspr;
+
+	asm volatile(
+		"mrs	%0, S3_3_C2_C5_1"
+	: "=r" (gcspr)
+	:
+	: "cc");
+
+	return gcspr;
+}
+
+static inline void __attribute__((always_inline)) gcsss1(unsigned long *Xt)
+{
+	asm volatile (
+		"sys #3, C7, C7, #2, %0\n"
+		:
+		: "rZ" (Xt)
+		: "memory");
+}
+
+static inline unsigned long __attribute__((always_inline)) *gcsss2(void)
+{
+	unsigned long *Xt;
+
+	asm volatile(
+		"SYSL %0, #3, C7, C7, #3\n"
+		: "=r" (Xt)
+		:
+		: "memory");
+
+	return Xt;
+}
+
+static inline bool chkfeat_gcs(void)
+{
+	register long val __asm__ ("x16") = 1;
+
+	/* CHKFEAT x16 */
+	asm volatile(
+		"hint #0x28\n"
+		: "=r" (val)
+		: "r" (val));
+
+	return val != 1;
+}
+
+#endif

-- 
2.30.2

