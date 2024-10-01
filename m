Return-Path: <linux-fsdevel+bounces-30610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4309298C944
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA9F1F21289
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8871CF7D4;
	Tue,  1 Oct 2024 23:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbbkJUPB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC891CF5C4;
	Tue,  1 Oct 2024 23:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727824010; cv=none; b=mj6pRIUR0lyPVRXman7mtAroDituW8dUWDPMA7ysiLGN1XNk4oamS9ypBe1NSNieo1Eylj42sb23gNi1aJusXeBjaiZ2oikr1L3JGp10C9qkY5KSxT0H+7za3myROTBjHmbnHM4HE2BL0f+J2Hx9jp0qZfxZ3Zlc/5E3aEj05is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727824010; c=relaxed/simple;
	bh=upHGZblTuLizXaQNMQxngoEnM6NYFrLpBNo8BN2MbdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEKkdTaXAqWoYUNme5D9f+9uOZuhvZjFrQ/f6GFshpzCm8DwpUMQ1i7b1L18ZbvF1dXWhPg3HKSKxeMgEdv9SSyBCzKviVWWOmFO0M0OZvbNjGePHhlNd5ETDDd1MX5/ywcI76ucWVV5kOIyfnPaAHRB8epQzAofYUfCTUWwLp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbbkJUPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16857C4CEC6;
	Tue,  1 Oct 2024 23:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727824010;
	bh=upHGZblTuLizXaQNMQxngoEnM6NYFrLpBNo8BN2MbdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tbbkJUPBmRMqyIaBDd6Q63wpK0zxwau0IVmLoz+0ujSCe/HvZ26zswb/mwvcHBVf/
	 /H047g2MCGX5UsJ2vEGDux/2ltWHuT3XAktEEPs0gN1VzWQQvOH1TwD1HBhv+m/wD1
	 2mvSUwmJl6+FN/kjwP62P1dq1k2junQvamqoXbvS5hJSM3EahSkFIFnh1Y5aXAL5VI
	 Z9LB8i0+OJtGb7cQrQpJVh5eWrsETnT4zTcBAMciXZYZpig6v3NYjpspmPmyPRWDlP
	 DmWKnD3Bnq9WewEtED337smlplmjpqdhhS5QHo3UtNCjQS9zwv0754YGKxAZzOs/f4
	 /rPAcIcpMd7dw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:59:16 +0100
Subject: [PATCH v13 37/40] kselftest/arm64: Add GCS signal tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-37-222b78d87eee@kernel.org>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
In-Reply-To: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, David Spickett <david.spickett@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=7712; i=broonie@kernel.org;
 h=from:subject:message-id; bh=upHGZblTuLizXaQNMQxngoEnM6NYFrLpBNo8BN2MbdE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7gM/OWu2x9+hKafeCVH+LGEoGo2V4EZNpUgOge
 B4SJHUiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+4AAKCRAk1otyXVSH0LQLB/
 9wIkVJw+VOo8XI3Ks6OkRHiWvCjUBSz1o/k8tBn/+V+a0EtOLElpoOEmhwfcPAxw6kvGKtT51ZLKzr
 A8c//P1qQuW0US7tI2nljQILXL2eRsvpIFHQ+mKetzLvOF3I9LB/mJzW6d47BHGb3lxA5sB3SiSxXY
 CCWmU1FUfFouvzFnYOGVs572LFfiCFjVGAwTdQSQYgo8vZsLg901QipsINFCso2tu/XhT06eNzOKmn
 G5nnln3wXU0kRoWYEGT2KRNMIJJAlb7kWRGnSU5XxITdS9aONhBwJw3A6e0H0EkXmg2H2K8fI3VtTt
 Je/pOK9N1hdlgoyXdmCxYxkUsGxSpC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Do some testing of the signal handling for GCS, checking that a GCS
frame has the expected information in it and that the expected signals
are delivered with invalid operations.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/.gitignore    |  1 +
 .../selftests/arm64/signal/test_signals_utils.h    | 10 +++
 .../arm64/signal/testcases/gcs_exception_fault.c   | 62 +++++++++++++++
 .../selftests/arm64/signal/testcases/gcs_frame.c   | 88 ++++++++++++++++++++++
 .../arm64/signal/testcases/gcs_write_fault.c       | 67 ++++++++++++++++
 5 files changed, 228 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
index b2f2bfd5c6aa..b257db665a35 100644
--- a/tools/testing/selftests/arm64/signal/.gitignore
+++ b/tools/testing/selftests/arm64/signal/.gitignore
@@ -3,6 +3,7 @@ mangle_*
 fake_sigreturn_*
 fpmr_*
 poe_*
+gcs_*
 sme_*
 ssve_*
 sve_*
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
index 1e80808ee105..36fc12b3cd60 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
@@ -6,6 +6,7 @@
 
 #include <assert.h>
 #include <stdio.h>
+#include <stdint.h>
 #include <string.h>
 
 #include <linux/compiler.h>
@@ -47,6 +48,15 @@ void test_result(struct tdescr *td);
 		_arg1;							\
 	})
 
+static inline __attribute__((always_inline)) uint64_t get_gcspr_el0(void)
+{
+	uint64_t val;
+
+	asm volatile("mrs %0, S3_3_C2_C5_1" : "=r" (val));
+
+	return val;
+}
+
 static inline bool feats_ok(struct tdescr *td)
 {
 	if (td->feats_incompatible & td->feats_supported)
diff --git a/tools/testing/selftests/arm64/signal/testcases/gcs_exception_fault.c b/tools/testing/selftests/arm64/signal/testcases/gcs_exception_fault.c
new file mode 100644
index 000000000000..6228448b2ae7
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/gcs_exception_fault.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 ARM Limited
+ */
+
+#include <errno.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include <sys/mman.h>
+#include <sys/prctl.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+/*
+ * We should get this from asm/siginfo.h but the testsuite is being
+ * clever with redefining siginfo_t.
+ */
+#ifndef SEGV_CPERR
+#define SEGV_CPERR 10
+#endif
+
+static inline void gcsss1(uint64_t Xt)
+{
+	asm volatile (
+		"sys #3, C7, C7, #2, %0\n"
+		:
+		: "rZ" (Xt)
+		: "memory");
+}
+
+static int gcs_op_fault_trigger(struct tdescr *td)
+{
+	/*
+	 * The slot below our current GCS should be in a valid GCS but
+	 * must not have a valid cap in it.
+	 */
+	gcsss1(get_gcspr_el0() - 8);
+
+	return 0;
+}
+
+static int gcs_op_fault_signal(struct tdescr *td, siginfo_t *si,
+				  ucontext_t *uc)
+{
+	ASSERT_GOOD_CONTEXT(uc);
+
+	return 1;
+}
+
+struct tdescr tde = {
+	.name = "Invalid GCS operation",
+	.descr = "An invalid GCS operation generates the expected signal",
+	.feats_required = FEAT_GCS,
+	.timeout = 3,
+	.sig_ok = SIGSEGV,
+	.sig_ok_code = SEGV_CPERR,
+	.sanity_disabled = true,
+	.trigger = gcs_op_fault_trigger,
+	.run = gcs_op_fault_signal,
+};
diff --git a/tools/testing/selftests/arm64/signal/testcases/gcs_frame.c b/tools/testing/selftests/arm64/signal/testcases/gcs_frame.c
new file mode 100644
index 000000000000..b405d82321da
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/gcs_frame.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 ARM Limited
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+#include <sys/prctl.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static union {
+	ucontext_t uc;
+	char buf[1024 * 64];
+} context;
+
+static int gcs_regs(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	size_t offset;
+	struct _aarch64_ctx *head = GET_BUF_RESV_HEAD(context);
+	struct gcs_context *gcs;
+	unsigned long expected, gcspr;
+	uint64_t *u64_val;
+	int ret;
+
+	ret = prctl(PR_GET_SHADOW_STACK_STATUS, &expected, 0, 0, 0);
+	if (ret != 0) {
+		fprintf(stderr, "Unable to query GCS status\n");
+		return 1;
+	}
+
+	/* We expect a cap to be added to the GCS in the signal frame */
+	gcspr = get_gcspr_el0();
+	gcspr -= 8;
+	fprintf(stderr, "Expecting GCSPR_EL0 %lx\n", gcspr);
+
+	if (!get_current_context(td, &context.uc, sizeof(context))) {
+		fprintf(stderr, "Failed getting context\n");
+		return 1;
+	}
+
+	/* Ensure that the signal restore token was consumed */
+	u64_val = (uint64_t *)get_gcspr_el0() + 1;
+	if (*u64_val) {
+		fprintf(stderr, "GCS value at %p is %lx not 0\n",
+			u64_val, *u64_val);
+		return 1;
+	}
+
+	fprintf(stderr, "Got context\n");
+
+	head = get_header(head, GCS_MAGIC, GET_BUF_RESV_SIZE(context),
+			  &offset);
+	if (!head) {
+		fprintf(stderr, "No GCS context\n");
+		return 1;
+	}
+
+	gcs = (struct gcs_context *)head;
+
+	/* Basic size validation is done in get_current_context() */
+
+	if (gcs->features_enabled != expected) {
+		fprintf(stderr, "Features enabled %llx but expected %lx\n",
+			gcs->features_enabled, expected);
+		return 1;
+	}
+
+	if (gcs->gcspr != gcspr) {
+		fprintf(stderr, "Got GCSPR %llx but expected %lx\n",
+			gcs->gcspr, gcspr);
+		return 1;
+	}
+
+	fprintf(stderr, "GCS context validated\n");
+	td->pass = 1;
+
+	return 0;
+}
+
+struct tdescr tde = {
+	.name = "GCS basics",
+	.descr = "Validate a GCS signal context",
+	.feats_required = FEAT_GCS,
+	.timeout = 3,
+	.run = gcs_regs,
+};
diff --git a/tools/testing/selftests/arm64/signal/testcases/gcs_write_fault.c b/tools/testing/selftests/arm64/signal/testcases/gcs_write_fault.c
new file mode 100644
index 000000000000..faeabb18c4b2
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/gcs_write_fault.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 ARM Limited
+ */
+
+#include <errno.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include <sys/mman.h>
+#include <sys/prctl.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static uint64_t *gcs_page;
+
+#ifndef __NR_map_shadow_stack
+#define __NR_map_shadow_stack 453
+#endif
+
+static bool alloc_gcs(struct tdescr *td)
+{
+	long page_size = sysconf(_SC_PAGE_SIZE);
+
+	gcs_page = (void *)syscall(__NR_map_shadow_stack, 0,
+				   page_size, 0);
+	if (gcs_page == MAP_FAILED) {
+		fprintf(stderr, "Failed to map %ld byte GCS: %d\n",
+			page_size, errno);
+		return false;
+	}
+
+	return true;
+}
+
+static int gcs_write_fault_trigger(struct tdescr *td)
+{
+	/* Verify that the page is readable (ie, not completely unmapped) */
+	fprintf(stderr, "Read value 0x%lx\n", gcs_page[0]);
+
+	/* A regular write should trigger a fault */
+	gcs_page[0] = EINVAL;
+
+	return 0;
+}
+
+static int gcs_write_fault_signal(struct tdescr *td, siginfo_t *si,
+				  ucontext_t *uc)
+{
+	ASSERT_GOOD_CONTEXT(uc);
+
+	return 1;
+}
+
+
+struct tdescr tde = {
+	.name = "GCS write fault",
+	.descr = "Normal writes to a GCS segfault",
+	.feats_required = FEAT_GCS,
+	.timeout = 3,
+	.sig_ok = SIGSEGV,
+	.sanity_disabled = true,
+	.init = alloc_gcs,
+	.trigger = gcs_write_fault_trigger,
+	.run = gcs_write_fault_signal,
+};

-- 
2.39.2


