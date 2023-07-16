Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D263A7557FA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 23:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGPV6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 17:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjGPV6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:58:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB09A4213;
        Sun, 16 Jul 2023 14:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBFB760EBC;
        Sun, 16 Jul 2023 21:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79391C433D9;
        Sun, 16 Jul 2023 21:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689544564;
        bh=Nuasx9Ylf/ySuoGV/J7jU7muHvsTQeng/1l4pki2YVk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=P1h9KVdbbAprE9cGnSst8fVG40lH+zlIEa0ULjrrdOGPLgDW4ZLLFEN5ZvPGWvuMa
         gwFumvj9BBOTlWawxnw/4K3oU/Lx7yaLI8jpeumEkP1wRajuWGl4CNn0PcnQ4fCbKV
         CN8DSHDH2z1aSTnQsbqAKpaQjDfLYXvHO4x5r+odKnwAdtD5L8GlPXto7ze09j0d7/
         facbXKzFyqhBddfWjNd/+oUmRRXmprqLZavow9m1hLr1dACcQuJQmZgJzl0K6Ti/XD
         KCGb2Ik4YuAZH6f4OVAXQ9VVA9bJtItttNHqhR/A7QU8GcLnra6YSP0t1K5xfmQ2+/
         Eyj0qahxmHYwQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 16 Jul 2023 22:51:27 +0100
Subject: [PATCH 31/35] kselftest/arm64: Always run signals tests with GCS
 enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-arm64-gcs-v1-31-bf567f93bba6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3590; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Nuasx9Ylf/ySuoGV/J7jU7muHvsTQeng/1l4pki2YVk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktGan2iFZRR56liRBNgBrNa8Q9jM0eX1IYZHjq6q7
 hHCAKcaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLRmpwAKCRAk1otyXVSH0NcQB/
 9J49ekWpVX8qtcugCCDHGBMz9he4/VOu9aJ5NstPp1veTJmUV3yzY3JsDEPe24a923q6CqdQgcnzA6
 RomVBFbK42eFR/gYU4dXyyGnrtStUF9uj09jC/gDfRgkT/PD/PR9hFgn4oTwlVX6hwWJyeKFTicWKU
 VOqcNSm+8D3R4cdhbVMqYWEOW7Vok3SwbcBa6X3UEVoqSed9j2MPxW+iYYyZfF8HiggQErBUqMKk7e
 9Cf8LbFP6DgjzMI5DTg4Qc5zcRTZ+IxsBv8KNdFJOhxdymzByoF05oqQXaf+xJ/IdpkWIeCqWhWYqd
 6tR4dDTM9BacjC7TIEH5zv3ob5DiSp
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

Since it is not possible to return from the function that enabled GCS
without disabling GCS it is very inconvenient to use the signal handling
tests to cover GCS when GCS is not enabled by the toolchain and runtime,
something that no current distribution does. Since none of the testcases
do anything with stacks that would cause problems with GCS we can sidestep
this issue by unconditionally enabling GCS on startup and exiting with a
call to exit() rather than a return from main().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/arm64/signal/test_signals.c  | 17 ++++++++++++-
 .../selftests/arm64/signal/test_signals_utils.h    | 29 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals.c b/tools/testing/selftests/arm64/signal/test_signals.c
index 00051b40d71e..30e95f50db19 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.c
+++ b/tools/testing/selftests/arm64/signal/test_signals.c
@@ -7,6 +7,10 @@
  * Each test provides its own tde struct tdescr descriptor to link with
  * this wrapper. Framework provides common helpers.
  */
+
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+
 #include <kselftest.h>
 
 #include "test_signals.h"
@@ -16,6 +20,16 @@ struct tdescr *current = &tde;
 
 int main(int argc, char *argv[])
 {
+	/*
+	 * Ensure GCS is at least enabled throughout the tests if
+	 * supported, otherwise the inability to return from the
+	 * function that enabled GCS makes it very inconvenient to set
+	 * up test cases.  The prctl() may fail if GCS was locked by
+	 * libc setup code.
+	 */
+	if (getauxval(AT_HWCAP2) & HWCAP2_GCS)
+		gcs_set_state(PR_SHADOW_STACK_ENABLE);
+
 	ksft_print_msg("%s :: %s\n", current->name, current->descr);
 	if (test_setup(current) && test_init(current)) {
 		test_run(current);
@@ -23,5 +37,6 @@ int main(int argc, char *argv[])
 	}
 	test_result(current);
 
-	return current->result;
+	/* Do not return in case GCS was enabled */
+	exit(current->result);
 }
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
index 222093f51b67..1cea64986baa 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
@@ -16,6 +16,35 @@ void test_cleanup(struct tdescr *td);
 int test_run(struct tdescr *td);
 void test_result(struct tdescr *td);
 
+#ifndef __NR_prctl
+#define __NR_prctl 167
+#endif
+
+/*
+ * The prctl takes 1 argument but we need to ensure that the other
+ * values passed in registers to the syscall are zero since the kernel
+ * validates them.
+ */
+#define gcs_set_state(state)					\
+	({								\
+		register long _num  __asm__ ("x8") = __NR_prctl;	\
+		register long _arg1 __asm__ ("x0") =  PR_SET_SHADOW_STACK_STATUS; \
+		register long _arg2 __asm__ ("x1") = (long)(state);	\
+		register long _arg3 __asm__ ("x2") = 0;			\
+		register long _arg4 __asm__ ("x3") = 0;			\
+		register long _arg5 __asm__ ("x4") = 0;			\
+	                                                                      \
+		__asm__  volatile (					\
+			"svc #0\n"					\
+			: "=r"(_arg1)					\
+			: "r"(_arg1), "r"(_arg2),			\
+			  "r"(_arg3), "r"(_arg4),			\
+			  "r"(_arg5), "r"(_num)				\
+			: "memory", "cc"				\
+			);						\
+		_arg1;							\
+	})
+
 static inline bool feats_ok(struct tdescr *td)
 {
 	if (td->feats_incompatible & td->feats_supported)

-- 
2.30.2

