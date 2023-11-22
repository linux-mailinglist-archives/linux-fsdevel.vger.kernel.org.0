Return-Path: <linux-fsdevel+bounces-3397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA31D7F4298
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC352818A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 09:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D7C5674D;
	Wed, 22 Nov 2023 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ywa3gvZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F51DA53;
	Wed, 22 Nov 2023 09:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5EEC433C9;
	Wed, 22 Nov 2023 09:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700646465;
	bh=MI0LRzv/CnL02f+ePch+Fotbaf/ZIsCKXG1L5yOkLjk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ywa3gvZIzbHX19sdDR3iSXFkVjG+uXkPj0iU25B9oUD7dxQyZ9c6vPyNhwMJu15Sd
	 7xf4bOoi9bR6CLOdJE7Q30WLFlP68q2449OUPueGDVqEt1PPN8ziJQDVwajr7HXnKn
	 jenL2oigoHxOqbN9MCVCqTV26soaoYn3Z3oiMiCsmBjQLS0KN9F29E1YJHhzSYLFtc
	 2caUr0/dKKT8zHGssR/edtXcl/PX/Q63Y8n7OqqXRIAXqMtBbo9bFR8SkR92zkGBnT
	 uDu4rPIHZPJoIUwtF5NiO943tF01uc0NBUAys/gCApvYLuiVUDFxSfZh4EizaEDQ00
	 85J+73D/fQHKg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 22 Nov 2023 09:42:46 +0000
Subject: [PATCH v7 36/39] selftests/arm64: Add GCS signal tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-36-201c483bd775@kernel.org>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=7315; i=broonie@kernel.org;
 h=from:subject:message-id; bh=MI0LRzv/CnL02f+ePch+Fotbaf/ZIsCKXG1L5yOkLjk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXc0Sl2L5LlM9CvN5WixGcKmWWlz3Vh415242G
 BHROm//p6eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3NEgAKCRAk1otyXVSH
 0ENnCACEUYcUbSULpQDwN0+R82xtUdAL2izfo63h2TQ0EPelqY3WJiCaE4plzvEfbU+UevJLigk
 Erw1ScYLhpM/L69tnZNOL/azHYoQK6Qsk2bOoL5LWyHdK/JjJ5LxtENZPBpLIfR294oNMbNAJxz
 odS5jiMRa5jats+k6PfyEobikErpFyFIjnz5NlrXqvtrbClW4ampNFy5CH48nfvmGtr9xZh3h70
 buffxqOZQjWkWEAW25+SxIPLD8r6HyH1O3PjAvXSQXj0Xp+2GVmH/HPUB3FrlRTPKtRjV8Cmthp
 ggdZxNS/Xc7s/ZFQ9TC+CAvpOU0N4rRhb7aOhZM1Q0H8Hj4H
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Do some testing of the signal handling for GCS, checking that a GCS
frame has the expected information in it and that the expected signals
are delivered with invalid operations.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/.gitignore    |  1 +
 .../selftests/arm64/signal/test_signals_utils.h    | 10 +++
 .../arm64/signal/testcases/gcs_exception_fault.c   | 59 ++++++++++++++++
 .../selftests/arm64/signal/testcases/gcs_frame.c   | 78 ++++++++++++++++++++++
 .../arm64/signal/testcases/gcs_write_fault.c       | 67 +++++++++++++++++++
 5 files changed, 215 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
index 839e3a252629..26de12918890 100644
--- a/tools/testing/selftests/arm64/signal/.gitignore
+++ b/tools/testing/selftests/arm64/signal/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 mangle_*
 fake_sigreturn_*
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
index 000000000000..532d533592a1
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/gcs_exception_fault.c
@@ -0,0 +1,59 @@
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
+/* This should be includable from some standard header, but which? */
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
index 000000000000..d67cb26195a6
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/gcs_frame.c
@@ -0,0 +1,78 @@
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
index 000000000000..126b1a294a29
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
+#define __NR_map_shadow_stack 452
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


