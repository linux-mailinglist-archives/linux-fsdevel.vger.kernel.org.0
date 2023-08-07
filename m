Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9057732AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 00:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjHGWHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 18:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjHGWHS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78521FE2;
        Mon,  7 Aug 2023 15:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76EC7622B2;
        Mon,  7 Aug 2023 22:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F51BC433CB;
        Mon,  7 Aug 2023 22:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691445891;
        bh=bmXffNPLeGaR3X6mpkasbCD4Gs6j+7nWIYlPeJrCXTY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fUygPdqLjkrxjLy22vj8i76tpvGawZv9Py2Eh55A/wfNKxkQGJ4By0SaWpA4+2Eps
         AW1Imv7LTlCQqFF6NzkF0ZfSD2IPlxqFturpav9CmOZV/E7DN3wVY73neNxLbrMxTW
         mXXLGItkfnYpkXDgUXZpvqfZ7mNFz7rdk7mBo+M3yMyrBJd/Pgab8MVRYMtsBrA8b6
         sYDL0MPsmp+iPJg192b093mlGsZGZmascmzsQ81yiovkfAgKChZo3YmURMSZ+11QaT
         8HUFcFLJeGTb/iI9cUBd4aQ6hF84jFqnrWncHQ0hdnpp3M/DJSdTIQJHG+oVYENS/p
         N3/TCgrMGAtRA==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 07 Aug 2023 23:00:37 +0100
Subject: [PATCH v4 32/36] kselftest/arm64: Add a GCS test program built
 with the system libc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-arm64-gcs-v4-32-68cfa37f9069@kernel.org>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
In-Reply-To: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
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
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14855; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bmXffNPLeGaR3X6mpkasbCD4Gs6j+7nWIYlPeJrCXTY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk0Wmx63lI+lu/Evu7qwfdS81OeuA5MjudXJ7LKFZY
 S8lHFu2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZNFpsQAKCRAk1otyXVSH0KWlB/
 9mNm5Cpi2zJRzMzJX2W4pz/CGSgVpkhLOCGzI8npNwI7Ecn6KnpKlzd0ggfrkca5lRtavL73KHUJYL
 QSvEVLJz9h3G/sYM77kyzluXaF1bLhbK3GcK0j37EEzrTQZYBTgNJn2b4R40yYsfuktQcM0BTp+f+V
 TIDNw/ED6pRKXuReODAGoo/0RX+UR+4zayOfLm+iRSYvy7rDM0i6Yc1y5AYLe2AAsdNs3O/baeKh2l
 WzsXb9uPrXeQSDmU4am9okT3f/Xk8D3HHCVFOnjbTWugTbc3Ilr/0g8E78Mf0ETEjpumGBD357ZTB1
 FtZFq+OjZB1VK+ChP1Qorze2ErJZFx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are things like threads which nolibc struggles with which we want
to add coverage for, and the ABI allows us to test most of these even if
libc itself does not understand GCS so add a test application built
using the system libc.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/gcs/.gitignore |   1 +
 tools/testing/selftests/arm64/gcs/Makefile   |   4 +-
 tools/testing/selftests/arm64/gcs/libc-gcs.c | 500 +++++++++++++++++++++++++++
 3 files changed, 504 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/gcs/.gitignore b/tools/testing/selftests/arm64/gcs/.gitignore
index 0e5e695ecba5..5810c4a163d4 100644
--- a/tools/testing/selftests/arm64/gcs/.gitignore
+++ b/tools/testing/selftests/arm64/gcs/.gitignore
@@ -1 +1,2 @@
 basic-gcs
+libc-gcs
diff --git a/tools/testing/selftests/arm64/gcs/Makefile b/tools/testing/selftests/arm64/gcs/Makefile
index 61a30f483429..a8fdf21e9a47 100644
--- a/tools/testing/selftests/arm64/gcs/Makefile
+++ b/tools/testing/selftests/arm64/gcs/Makefile
@@ -6,7 +6,9 @@
 # nolibc.
 #
 
-TEST_GEN_PROGS := basic-gcs
+TEST_GEN_PROGS := basic-gcs libc-gcs
+
+LDLIBS+=-lpthread
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/arm64/gcs/libc-gcs.c b/tools/testing/selftests/arm64/gcs/libc-gcs.c
new file mode 100644
index 000000000000..5d20442358ed
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/libc-gcs.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 ARM Limited.
+ */
+
+#include <pthread.h>
+#include <stdbool.h>
+
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+
+#include <asm/hwcap.h>
+#include <asm/mman.h>
+
+#include <linux/compiler.h>
+
+#include "kselftest_harness.h"
+
+#include "gcs-util.h"
+
+#define my_syscall2(num, arg1, arg2)                                          \
+({                                                                            \
+	register long _num  __asm__ ("x8") = (num);                           \
+	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("x2") = 0;                               \
+	register long _arg4 __asm__ ("x3") = 0;                               \
+	register long _arg5 __asm__ ("x4") = 0;                               \
+	                                                                      \
+	__asm__  volatile (                                                   \
+		"svc #0\n"                                                    \
+		: "=r"(_arg1)                                                 \
+		: "r"(_arg1), "r"(_arg2),                                     \
+		  "r"(_arg3), "r"(_arg4),                                     \
+		  "r"(_arg5), "r"(_num)					      \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+static noinline void gcs_recurse(int depth)
+{
+	if (depth)
+		gcs_recurse(depth - 1);
+
+	/* Prevent tail call optimization so we actually recurse */
+	asm volatile("dsb sy" : : : "memory");
+}
+
+/* Smoke test that a function call and return works*/
+TEST(can_call_function)
+{
+	gcs_recurse(0);
+}
+
+static void *gcs_test_thread(void *arg)
+{
+	int ret;
+	unsigned long mode;
+
+	/*
+	 * Some libcs don't seem to fill unused arguments with 0 but
+	 * the kernel validates this so we supply all 5 arguments.
+	 */
+	ret = prctl(PR_GET_SHADOW_STACK_STATUS, &mode, 0, 0, 0);
+	if (ret != 0) {
+		ksft_print_msg("PR_GET_SHADOW_STACK_STATUS failed: %d\n", ret);
+		return NULL;
+	}
+
+	if (!(mode & PR_SHADOW_STACK_ENABLE)) {
+		ksft_print_msg("GCS not enabled in thread, mode is %u\n",
+			       mode);
+		return NULL;
+	}
+
+	/* Just in case... */
+	gcs_recurse(0);
+
+	/* Use a non-NULL value to indicate a pass */
+	return &gcs_test_thread;
+}
+
+/* Verify that if we start a new thread it has GCS enabled */
+TEST(gcs_enabled_thread)
+{
+	pthread_t thread;
+	void *thread_ret;
+	int ret;
+
+	ret = pthread_create(&thread, NULL, gcs_test_thread, NULL);
+	ASSERT_TRUE(ret == 0);
+	if (ret != 0)
+		return;
+
+	ret = pthread_join(thread, &thread_ret);
+	ASSERT_TRUE(ret == 0);
+	if (ret != 0)
+		return;
+
+	ASSERT_TRUE(thread_ret != NULL);
+}
+
+/* Read the GCS until we find the terminator */
+TEST(gcs_find_terminator)
+{
+	unsigned long *gcs, *cur;
+
+	gcs = get_gcspr();
+	cur = gcs;
+	while (*cur)
+		cur++;
+
+	ksft_print_msg("GCS in use from %p-%p\n", gcs, cur);
+
+	/*
+	 * We should have at least whatever called into this test so
+	 * the two pointer should differ.
+	 */
+	ASSERT_TRUE(gcs != cur);
+}
+
+FIXTURE(map_gcs)
+{
+	unsigned long *stack;
+};
+
+FIXTURE_VARIANT(map_gcs)
+{
+	size_t stack_size;
+	unsigned long flags;
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s2k_cap_marker)
+{
+	.stack_size = 2 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s2k_cap)
+{
+	.stack_size = 2 * 1024,
+	.flags = SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s2k_marker)
+{
+	.stack_size = 2 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s2k)
+{
+	.stack_size = 2 * 1024,
+	.flags = 0,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s4k_cap_marker)
+{
+	.stack_size = 4 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s4k_cap)
+{
+	.stack_size = 4 * 1024,
+	.flags = SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s3k_marker)
+{
+	.stack_size = 4 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s4k)
+{
+	.stack_size = 4 * 1024,
+	.flags = 0,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s16k_cap_marker)
+{
+	.stack_size = 16 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s16k_cap)
+{
+	.stack_size = 16 * 1024,
+	.flags = SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s16k_marker)
+{
+	.stack_size = 16 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s16k)
+{
+	.stack_size = 16 * 1024,
+	.flags = 0,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s64k_cap_marker)
+{
+	.stack_size = 64 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s64k_cap)
+{
+	.stack_size = 64 * 1024,
+	.flags = SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s64k_marker)
+{
+	.stack_size = 64 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s64k)
+{
+	.stack_size = 64 * 1024,
+	.flags = 0,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s128k_cap_marker)
+{
+	.stack_size = 128 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s128k_cap)
+{
+	.stack_size = 128 * 1024,
+	.flags = SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s128k_marker)
+{
+	.stack_size = 128 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s128k)
+{
+	.stack_size = 128 * 1024,
+	.flags = 0,
+};
+
+FIXTURE_SETUP(map_gcs)
+{
+	self->stack = (void *)syscall(__NR_map_shadow_stack, 0,
+				      variant->stack_size, 
+				      variant->flags);
+	ASSERT_FALSE(self->stack == MAP_FAILED);
+	ksft_print_msg("Allocated stack from %p-%p\n", self->stack,
+		       (unsigned long)self->stack + variant->stack_size);
+}
+
+FIXTURE_TEARDOWN(map_gcs)
+{
+	int ret;
+
+	if (self->stack != MAP_FAILED) {
+		ret = munmap(self->stack, variant->stack_size);
+		ASSERT_EQ(ret, 0);
+	}
+}
+
+/* The stack has a cap token */
+TEST_F(map_gcs, stack_capped)
+{
+	unsigned long *stack = self->stack;
+	size_t cap_index;
+
+	cap_index = (variant->stack_size / sizeof(unsigned long));
+
+	switch (variant->flags & (SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN)) {
+	case SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN:
+		cap_index -= 2;
+		break;
+	case SHADOW_STACK_SET_TOKEN:
+		cap_index -= 1;
+		break;
+	case SHADOW_STACK_SET_MARKER:
+	case 0:
+		/* No cap, no test */
+		return;
+	}
+
+	ASSERT_EQ(stack[cap_index], GCS_CAP(&stack[cap_index]));
+}
+
+/* The top of the stack is 0 */
+TEST_F(map_gcs, stack_terminated)
+{
+	unsigned long *stack = self->stack;
+	size_t term_index;
+
+	if (!(variant->flags & SHADOW_STACK_SET_MARKER))
+		return;
+
+	term_index = (variant->stack_size / sizeof(unsigned long)) - 1;
+
+	ASSERT_EQ(stack[term_index], 0);
+}
+
+/* Writes should fault */
+TEST_F_SIGNAL(map_gcs, not_writeable, SIGSEGV)
+{
+	self->stack[0] = 0;
+}
+
+/* Put it all together, we can safely switch to and from the stack */
+TEST_F(map_gcs, stack_switch)
+{
+	size_t cap_index;
+	cap_index = (variant->stack_size / sizeof(unsigned long));
+	unsigned long *orig_gcspr_el0, *pivot_gcspr_el0;
+
+	/* Skip over the stack terminator and point at the cap */
+	switch (variant->flags & (SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN)) {
+	case SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN:
+		cap_index -= 2;
+		break;
+	case SHADOW_STACK_SET_TOKEN:
+		cap_index -= 1;
+		break;
+	case SHADOW_STACK_SET_MARKER:
+	case 0:
+		/* No cap, no test */
+		return;
+	}
+	pivot_gcspr_el0 = &self->stack[cap_index];
+
+	/* Pivot to the new GCS */
+	ksft_print_msg("Pivoting to %p from %p, target has value 0x%lx\n",
+		       pivot_gcspr_el0, get_gcspr(),
+		       *pivot_gcspr_el0);
+	gcsss1(pivot_gcspr_el0);
+	orig_gcspr_el0 = gcsss2();
+	ksft_print_msg("Pivoted to %p from %p, target has value 0x%lx\n",
+		       pivot_gcspr_el0, get_gcspr(),
+		       *pivot_gcspr_el0);
+
+	ksft_print_msg("Pivoted, GCSPR_EL0 now %p\n", get_gcspr());
+
+	/* New GCS must be in the new buffer */
+	ASSERT_TRUE((unsigned long)get_gcspr() > (unsigned long)self->stack);
+	ASSERT_TRUE((unsigned long)get_gcspr() <=
+		    (unsigned long)self->stack + variant->stack_size);
+
+	/* We should be able to use all but 2 slots of the new stack */
+	ksft_print_msg("Recursing %d levels\n", cap_index - 1);
+	gcs_recurse(cap_index - 1);
+
+	/* Pivot back to the original GCS */
+	gcsss1(orig_gcspr_el0);
+	pivot_gcspr_el0 = gcsss2();
+
+	gcs_recurse(0);
+	ksft_print_msg("Pivoted back to GCSPR_EL0 0x%lx\n", get_gcspr());
+}
+
+/* We fault if we try to go beyond the end of the stack */
+TEST_F_SIGNAL(map_gcs, stack_overflow, SIGSEGV)
+{
+	size_t cap_index;
+	cap_index = (variant->stack_size / sizeof(unsigned long));
+	unsigned long *orig_gcspr_el0, *pivot_gcspr_el0;
+
+	/* Skip over the stack terminator and point at the cap */
+	switch (variant->flags & (SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN)) {
+	case SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN:
+		cap_index -= 2;
+		break;
+	case SHADOW_STACK_SET_TOKEN:
+		cap_index -= 1;
+		break;
+	case SHADOW_STACK_SET_MARKER:
+	case 0:
+		/* No cap, no test but we need to SEGV to avoid a false fail */
+		orig_gcspr_el0 = get_gcspr();
+		*orig_gcspr_el0 = 0;
+		return;
+	}
+	pivot_gcspr_el0 = &self->stack[cap_index];
+
+	/* Pivot to the new GCS */
+	ksft_print_msg("Pivoting to %p from %p, target has value 0x%lx\n",
+		       pivot_gcspr_el0, get_gcspr(),
+		       *pivot_gcspr_el0);
+	gcsss1(pivot_gcspr_el0);
+	orig_gcspr_el0 = gcsss2();
+	ksft_print_msg("Pivoted to %p from %p, target has value 0x%lx\n",
+		       pivot_gcspr_el0, get_gcspr(),
+		       *pivot_gcspr_el0);
+
+	ksft_print_msg("Pivoted, GCSPR_EL0 now %p\n", get_gcspr());
+
+	/* New GCS must be in the new buffer */
+	ASSERT_TRUE((unsigned long)get_gcspr() > (unsigned long)self->stack);
+	ASSERT_TRUE((unsigned long)get_gcspr() <=
+		    (unsigned long)self->stack + variant->stack_size);
+
+	/* Now try to recurse, we should fault doing this. */
+	ksft_print_msg("Recursing %d levels...\n", cap_index + 1);
+	gcs_recurse(cap_index + 1);
+	ksft_print_msg("...done\n");
+
+	/* Clean up properly to try to guard against spurious passes. */
+	gcsss1(orig_gcspr_el0);
+	pivot_gcspr_el0 = gcsss2();
+	ksft_print_msg("Pivoted back to GCSPR_EL0 0x%lx\n", get_gcspr());
+}
+
+FIXTURE(map_invalid_gcs)
+{
+};
+
+FIXTURE_VARIANT(map_invalid_gcs)
+{
+	size_t stack_size;
+};
+
+FIXTURE_SETUP(map_invalid_gcs)
+{
+}
+
+FIXTURE_TEARDOWN(map_invalid_gcs)
+{
+}
+
+/* GCS must be larger than 16 bytes */
+FIXTURE_VARIANT_ADD(map_invalid_gcs, too_small)
+{
+	.stack_size = 8,
+};
+
+/* GCS size must be 16 byte aligned */
+FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_1)  { .stack_size = 1024 + 1  };
+FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_2)  { .stack_size = 1024 + 2  };
+FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_3)  { .stack_size = 1024 + 3  };
+FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_4)  { .stack_size = 1024 + 4  };
+FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_5)  { .stack_size = 1024 + 5  };
+FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_6)  { .stack_size = 1024 + 6  };
+FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_7)  { .stack_size = 1024 + 7  };
+
+TEST_F(map_invalid_gcs, do_map)
+{
+	void *stack;
+
+	stack = (void *)syscall(__NR_map_shadow_stack, 0,
+				variant->stack_size, 0);
+	ASSERT_TRUE(stack == MAP_FAILED);
+	if (stack != MAP_FAILED)
+		munmap(stack, variant->stack_size);
+}
+
+
+int main(int argc, char **argv)
+{
+	unsigned long gcs_mode;
+	int ret;
+
+	if (!(getauxval(AT_HWCAP2) & HWCAP2_GCS))
+		ksft_exit_skip("SKIP GCS not supported\n");
+
+	/* 
+	 * Force shadow stacks on, our tests *should* be fine with or
+	 * without libc support and with or without this having ended
+	 * up tagged for GCS and enabled by the dynamic linker.  We
+	 * can't use the libc prctl() function since we can't return
+	 * from enabling the stack.  Also lock GCS if not already
+	 * locked so we can test behaviour when it's locked.
+	 */
+	ret = my_syscall2(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &gcs_mode);
+	if (ret) {
+		ksft_print_msg("Failed to read GCS state: %d\n", ret);
+		return EXIT_FAILURE;
+	}
+	
+	if (!(gcs_mode & PR_SHADOW_STACK_ENABLE)) {
+		gcs_mode = PR_SHADOW_STACK_ENABLE;
+		ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
+				  gcs_mode);
+		if (ret) {
+			ksft_print_msg("Failed to configure GCS: %d\n", ret);
+			return EXIT_FAILURE;
+		}
+	}
+
+	/* Avoid returning in case libc doesn't understand GCS */
+	exit(test_harness_run(argc, argv));
+}

-- 
2.30.2

