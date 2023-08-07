Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B847732C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 00:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjHGWIi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjHGWIF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:08:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B2BC2;
        Mon,  7 Aug 2023 15:05:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C92D622B6;
        Mon,  7 Aug 2023 22:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE5BC433C7;
        Mon,  7 Aug 2023 22:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691445898;
        bh=IP7maWyjZ0dh+q8gDfrxLaUB03tkGEoqGc+9eYXpRWY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Viub0+3YDdK96RLbvcjS48dbEXvfC5pa4QoAORz0LyXsMAVUG/1zaxs0PxUrdcUiX
         NCjOXJfXYjXr7amwGBUMbzpr8BvJe8lFacFAe06AYCVERrNDx7zI7VRwwVD4bawlQP
         M48sWzBfrzWqs6MZ9Yz1mcHhXzt3SMHVxRFWzw3TEti5LfaPhFR4NsrYaM6gQbu++o
         YFxFB9SJvBeQWMPrswz++R27gWk7HgZren2w97TDPZV4RcOee5zEku1tkCjqiiBjwd
         lOnDaqcdOwmP/h1UVDDEfNdlYZ37MfXEHJafRMBUOkibjZYhZF3TgsMnZL62xzgI3X
         GRm7UXieTEefw==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 07 Aug 2023 23:00:38 +0100
Subject: [PATCH v4 33/36] kselftest/arm64: Add test coverage for GCS mode
 locking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-arm64-gcs-v4-33-68cfa37f9069@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7316; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IP7maWyjZ0dh+q8gDfrxLaUB03tkGEoqGc+9eYXpRWY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk0Wmy833RI05pBQJNTz7t1U3vX5cr4i3ZM+8P5Xms
 Y5DjP0qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZNFpsgAKCRAk1otyXVSH0FcMB/
 43hvcuUQh5Evd2eYzgjYV0lbil23x9rREejqSJUUALiEoOFErGVQ6fa6WHJEJAj1dId34JBlPbxfhk
 GFdJtCNFxXrQ0Y7EoCyP0Xfto4Ej2fanrsOxMzOTXMQVF1I3G0i/4ZE4wJg0QzWZ80s2wOy8M2zYtR
 sSQS52tRAwNx86hra9QGVZ8Cngx47vZXC6sNyeKRP5sn9ulHNtOfMxt68VPkpoVep13UNJVcZbpF31
 BdgSWDEH+K/Bg3z6asIFWnV9C3i2Y60ONLoOVBu00A673IoDdp7ygVa4bTiWzyfRRWUYxM9BzoSdtm
 bhZVw8/PeXFKs8u3ehyXx3aAPzorvW
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

Verify that we can lock individual GCS mode bits, that other modes
aren't affected and as a side effect also that every combination of
modes can be enabled.

Normally the inability to reenable GCS after disabling it would be an
issue with testing but fortunately the kselftest_harness runs each test
within a fork()ed child.  This can be inconvenient for some kinds of
testing but here it means that each test is in a separate thread and
therefore won't be affected by other tests in the suite.

Once we get toolchains with support for enabling GCS by default we will
need to take care to not do that in the build system but there are no
such toolchains yet so it is not yet an issue.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/gcs/.gitignore    |   1 +
 tools/testing/selftests/arm64/gcs/Makefile      |   2 +-
 tools/testing/selftests/arm64/gcs/gcs-locking.c | 200 ++++++++++++++++++++++++
 3 files changed, 202 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/gcs/.gitignore b/tools/testing/selftests/arm64/gcs/.gitignore
index 5810c4a163d4..0c86f53f68ad 100644
--- a/tools/testing/selftests/arm64/gcs/.gitignore
+++ b/tools/testing/selftests/arm64/gcs/.gitignore
@@ -1,2 +1,3 @@
 basic-gcs
 libc-gcs
+gcs-locking
diff --git a/tools/testing/selftests/arm64/gcs/Makefile b/tools/testing/selftests/arm64/gcs/Makefile
index a8fdf21e9a47..2173d6275956 100644
--- a/tools/testing/selftests/arm64/gcs/Makefile
+++ b/tools/testing/selftests/arm64/gcs/Makefile
@@ -6,7 +6,7 @@
 # nolibc.
 #
 
-TEST_GEN_PROGS := basic-gcs libc-gcs
+TEST_GEN_PROGS := basic-gcs libc-gcs gcs-locking
 
 LDLIBS+=-lpthread
 
diff --git a/tools/testing/selftests/arm64/gcs/gcs-locking.c b/tools/testing/selftests/arm64/gcs/gcs-locking.c
new file mode 100644
index 000000000000..f6a73254317e
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/gcs-locking.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 ARM Limited.
+ *
+ * Tests for GCS mode locking.  These tests rely on both having GCS
+ * unconfigured on entry and on the kselftest harness running each
+ * test in a fork()ed process which will have it's own mode.
+ */
+
+#include <limits.h>
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
+/* No mode bits are rejected for locking */
+TEST(lock_all_modes)
+{
+	int ret;
+
+	ret = prctl(PR_LOCK_SHADOW_STACK_STATUS, ULONG_MAX, 0, 0, 0);
+	ASSERT_EQ(ret, 0);
+}
+
+FIXTURE(valid_modes)
+{
+};
+
+FIXTURE_VARIANT(valid_modes)
+{
+	unsigned long mode;
+};
+
+FIXTURE_VARIANT_ADD(valid_modes, enable)
+{
+	.mode = PR_SHADOW_STACK_ENABLE,
+};
+
+FIXTURE_VARIANT_ADD(valid_modes, enable_write)
+{
+	.mode = PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE,
+};
+
+FIXTURE_VARIANT_ADD(valid_modes, enable_push)
+{
+	.mode = PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_PUSH,
+};
+
+FIXTURE_VARIANT_ADD(valid_modes, enable_write_push)
+{
+	.mode = PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE |
+		PR_SHADOW_STACK_PUSH,
+};
+
+FIXTURE_SETUP(valid_modes)
+{
+}
+
+FIXTURE_TEARDOWN(valid_modes)
+{
+}
+
+/* We can set the mode at all */
+TEST_F(valid_modes, set)
+{
+	int ret;
+
+	ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
+			  variant->mode);
+	ASSERT_EQ(ret, 0);
+
+	_exit(0);
+}
+
+/* Enabling, locking then disabling is rejected */
+TEST_F(valid_modes, enable_lock_disable)
+{
+	unsigned long mode;
+	int ret;
+
+	ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
+			  variant->mode);
+	ASSERT_EQ(ret, 0);
+
+	ret = prctl(PR_GET_SHADOW_STACK_STATUS, &mode, 0, 0, 0);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(mode, variant->mode);
+
+	ret = prctl(PR_LOCK_SHADOW_STACK_STATUS, variant->mode, 0, 0, 0);
+	ASSERT_EQ(ret, 0);
+
+	ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0);
+	ASSERT_EQ(ret, -EBUSY);
+
+	_exit(0);
+}
+
+/* Locking then enabling is rejected */
+TEST_F(valid_modes, lock_enable)
+{
+	unsigned long mode;
+	int ret;
+
+	ret = prctl(PR_LOCK_SHADOW_STACK_STATUS, variant->mode, 0, 0, 0);
+	ASSERT_EQ(ret, 0);
+
+	ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
+			  variant->mode);
+	ASSERT_EQ(ret, -EBUSY);
+
+	ret = prctl(PR_GET_SHADOW_STACK_STATUS, &mode, 0, 0, 0);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(mode, 0);
+
+	_exit(0);
+}
+
+/* Locking then changing other modes is fine */
+TEST_F(valid_modes, lock_enable_disable_others)
+{
+	unsigned long mode;
+	int ret;
+
+	ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
+			  variant->mode);
+	ASSERT_EQ(ret, 0);
+
+	ret = prctl(PR_GET_SHADOW_STACK_STATUS, &mode, 0, 0, 0);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(mode, variant->mode);
+
+	ret = prctl(PR_LOCK_SHADOW_STACK_STATUS, variant->mode, 0, 0, 0);
+	ASSERT_EQ(ret, 0);
+
+	ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
+			  PR_SHADOW_STACK_ALL_MODES);
+	ASSERT_EQ(ret, 0);
+
+	ret = prctl(PR_GET_SHADOW_STACK_STATUS, &mode, 0, 0, 0);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(mode, PR_SHADOW_STACK_ALL_MODES);
+
+
+	ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
+			  variant->mode);
+	ASSERT_EQ(ret, 0);
+
+	ret = prctl(PR_GET_SHADOW_STACK_STATUS, &mode, 0, 0, 0);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(mode, variant->mode);
+
+	_exit(0);
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long mode;
+	int ret;
+
+	if (!(getauxval(AT_HWCAP2) & HWCAP2_GCS))
+		ksft_exit_skip("SKIP GCS not supported\n");
+
+	ret = prctl(PR_GET_SHADOW_STACK_STATUS, &mode, 0, 0, 0);
+	if (ret) {
+		ksft_print_msg("Failed to read GCS state: %d\n", ret);
+		return EXIT_FAILURE;
+	}
+
+	if (mode & PR_SHADOW_STACK_ENABLE) {
+		ksft_print_msg("GCS was enabled, test unsupported\n");
+		return KSFT_SKIP;
+	}
+
+	return test_harness_run(argc, argv);
+}

-- 
2.30.2

