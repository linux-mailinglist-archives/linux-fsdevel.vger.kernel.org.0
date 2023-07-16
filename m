Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04B075580F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 23:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjGPV76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 17:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjGPV7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:59:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F5C2D65;
        Sun, 16 Jul 2023 14:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 262EC60EC4;
        Sun, 16 Jul 2023 21:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA02DC433D9;
        Sun, 16 Jul 2023 21:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689544576;
        bh=SiXcnz4ZnwfGze7/qmS4licirSO3Q/5KRYcvbUHs5Eg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=OGFccAlnpu1fa6ZC9OGpFv8Zc4wgt8MoQn5TPY6tsVQqf1E3zZjXnDjkNJnXBJSIz
         lowuW2Fl8zvSqX6M9e4+37BqGMM+sKdLxZMDJ/aN7Z3WDc6Lt6FMEc4rcSXBEG3MIg
         boRyPeWz6NH5sxXf7z6Uabh+gz9H99WovpKcGGCvM1aDsMzTa4vJ0RDboNT+RVxWx1
         W6XayBcZAjFPXnIjGF+9Jqk/X71sGpLqVj6XyYkcktym+HXvmzybfjf1JB7tn8BDSR
         tlgRs2A+hywcKDhYSvWuvY5OoshQulnvr/dG53s95hHW19Akml6hNXDThYqXQvKoXm
         9G2o6gvStPQKQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 16 Jul 2023 22:51:29 +0100
Subject: [PATCH 33/35] kselftest/arm64: Add a GCS test program built with
 the system libc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-arm64-gcs-v1-33-bf567f93bba6@kernel.org>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
In-Reply-To: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7954; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SiXcnz4ZnwfGze7/qmS4licirSO3Q/5KRYcvbUHs5Eg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktGapA4B+X8ht2nuBrVxjpIflYhHilWMB/OcQuIWG
 t40RyyaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLRmqQAKCRAk1otyXVSH0FLiB/
 9E1U6uxsV0M6HJ/gTLErPHXG2euepXEA+By7UhFpjSnNkfZ5ypUK331CG/JqOa4CnRV8en6z/eB6xt
 IhLU+ZbUzW/Vele2XRVXBdRzzlN+8k+82+vnZ/HPV0b9XphWLfpjzjA1V+PX7SAG5JGGhQseQhhuKn
 WzjvCDgnv5dZlJ9yG6eXeQUS8/UYZKn6ILOI332XNT9Je7jXDFGjc+dzxcuyI/o6tOqF16TujCBgww
 lz1hAFA+5Ppra9Ax6ij0A6I4XOrUP4XIQtt6IYJNSMEE+DpcA+4RUn1DHptv/JmThUaGpQtCw84GGU
 BiI0pY7pvplp60AOdb9qImv0XEsGOZ
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

There are things like threads which nolibc struggles with which we want
to add coverage for, and the ABI allows us to test most of these even if
libc itself does not understand GCS so add a test application built
using the system libc.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/gcs/.gitignore |   1 +
 tools/testing/selftests/arm64/gcs/Makefile   |   4 +-
 tools/testing/selftests/arm64/gcs/libc-gcs.c | 217 +++++++++++++++++++++++++++
 3 files changed, 221 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/gcs/.gitignore b/tools/testing/selftests/arm64/gcs/.gitignore
index 0e5e695ecba5..5810c4a163d4 100644
--- a/tools/testing/selftests/arm64/gcs/.gitignore
+++ b/tools/testing/selftests/arm64/gcs/.gitignore
@@ -1 +1,2 @@
 basic-gcs
+libc-gcs
diff --git a/tools/testing/selftests/arm64/gcs/Makefile b/tools/testing/selftests/arm64/gcs/Makefile
index 322c40d25f2e..31fbd3a6bf27 100644
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
index 000000000000..7ac3c3a2da52
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/libc-gcs.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 ARM Limited.
+ */
+
+#include <pthread.h>
+#include <stdbool.h>
+
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+
+#include <asm/hwcap.h>
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
+static  __attribute__((noinline)) void valid_gcs_function(void)
+{
+	/* Do something the compiler can't optimise out */
+	prctl(PR_SVE_GET_VL);
+}
+
+/* Smoke test that a function call and return works*/
+TEST(can_call_function)
+{
+	valid_gcs_function();
+}
+
+/* Smoke test that GCS is enabled in the current thread */
+TEST(gcs_locked)
+{
+	unsigned long gcs_mode;
+	int ret;
+
+	ret = my_syscall2(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &gcs_mode);
+	ASSERT_EQ(ret, 0);
+	if (ret != 0)
+		return;
+
+	/* We are locked, even a noop reconfiguration should fail */
+	ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, gcs_mode);
+	ASSERT_NE(0, ret);
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
+	valid_gcs_function();
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
+	uint64_t *gcs, *cur;
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
+/* We can switch between stacks */
+TEST(switch_stacks)
+{
+	unsigned long orig_gcspr_el0, pivot_gcspr_el0;
+	unsigned long buf_base, buf_end;
+	int ret;
+	void *buf;
+
+	buf = (void *)syscall(__NR_map_shadow_stack, 0,
+			      sysconf(_SC_PAGE_SIZE), 0);
+	ASSERT_FALSE(buf == MAP_FAILED);
+	buf_base = (unsigned long)buf;
+	buf_end = buf_base + sysconf(_SC_PAGE_SIZE);
+
+	/* Skip over the stack terminator and point at the cap */
+	pivot_gcspr_el0 = buf_end - 16;
+
+	ksft_print_msg("Mapped GCS at %p-%p\n", buf, buf_end);
+
+	/* Pivot to the new GCS */
+	ksft_print_msg("pivoting to %p from %p, target has value 0x%lx\n",
+		       pivot_gcspr_el0, get_gcspr(),
+		       *((unsigned long *)pivot_gcspr_el0));
+	gcsss1(pivot_gcspr_el0);
+	orig_gcspr_el0 = gcsss2();
+	ksft_print_msg("pivoted to %p from %p, target has value 0x%lx\n",
+		       pivot_gcspr_el0, get_gcspr(),
+		       *((uint64_t *)pivot_gcspr_el0));
+
+	/* New GCS must be in the new buffer */
+	ASSERT_TRUE((unsigned long)get_gcspr() < buf_base);
+	ASSERT_TRUE((unsigned long)get_gcspr() > buf_end);
+
+	/* Make sure we can still do calls */
+	valid_gcs_function();
+	ksft_print_msg("Pivoted to %p\n", get_gcspr());
+
+	/* Pivot back to the original GCS */
+	gcsss1(orig_gcspr_el0);
+	pivot_gcspr_el0 = gcsss2();
+
+	valid_gcs_function();
+	ksft_print_msg("Pivoted back to 0x%lx\n", get_gcspr());
+
+	ret = munmap(buf, sysconf(_SC_PAGE_SIZE));
+	ASSERT_EQ(ret, 0);
+}
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
+	/* If we are already locked we can't configure */
+	if (!(gcs_mode & PR_SHADOW_STACK_LOCK)) {
+		gcs_mode |= PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_LOCK;
+
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

