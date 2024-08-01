Return-Path: <linux-fsdevel+bounces-24786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5B7944CA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3081F24485
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3861A0B00;
	Thu,  1 Aug 2024 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeLlBHsh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C21A38D4;
	Thu,  1 Aug 2024 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517301; cv=none; b=m9osG56oF02+FjJKjfbwW2mLCewWtIKx5lAGfJj78A6IAw5tv7l8W1D6I6fW0+VBnIp/KfILeI1bxCTjThygcmaBvjd0OCOM4l4v13QzZzs9HVE3pUq+5hsaYYYnayFvYBUOjBoNthnVKS3OJoWnfrl7NEvBygZPbJZGopRMi3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517301; c=relaxed/simple;
	bh=6kf8vUeE2/3/9q62BhJqQa6tQ8qTDalv3nPeOQkuUQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RrM1Ks0epZdEmATOV8XAXAbzLVzPK8MnCpcivx8+V+L9Z0jRALRmZVdM5KFkDm5BzQVl23RhcgtRifCLBjLIDhn4TtnCPi+adlgOmq9gzj5W7mDxQSaPOkxNKUNIZyoJUHE1uFSARm6iFpnciqesDYvtUqx7bBOpNmDKRdju06I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeLlBHsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AD9C4AF0F;
	Thu,  1 Aug 2024 13:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517300;
	bh=6kf8vUeE2/3/9q62BhJqQa6tQ8qTDalv3nPeOQkuUQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QeLlBHshq5P3qUUyfk8CRsRNpyqn0q57xNSDHPTQ6q1hGzJWNs7qGlaOJIGObFmE+
	 +K7CJRAveGuipAwXMwq5q9D8OTdH+cPigG3T08ObXRZTQed2/245kPDwVGxjlfU372
	 U6lz/IxwXQuNFMD41f8cTskuzUxtBh4ekcSGDr8Jlns1YvB+6SFED8gkTLAiZcnTrn
	 LuJQ9+urmKyxyHj5P3x+s/TaASKq6bDfBdnLZzBjGtM9XuHa2bhbrUEN9xmS8k3GKd
	 oOV40cTBc967x5JL8iSK1RpHh3zhNfJksh6haNjSxsR3JLWpGbQkXVyzSTeJKcJdtY
	 pqLjCVcN/gdgA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:07:04 +0100
Subject: [PATCH v10 37/40] kselftest/arm64: Add GCS signal tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-37-699e2bd2190b@kernel.org>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
In-Reply-To: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=7642; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6kf8vUeE2/3/9q62BhJqQa6tQ8qTDalv3nPeOQkuUQk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YiilzosoycWemp86oXN2aAuvoGrtbZAHaiddpG
 iIMJiUGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGIgAKCRAk1otyXVSH0DZUB/
 0TviaWwxSqh8BYp1zmU3cW61qEV3ideNIDwUSV+cLGZ+YR5Qzcp9E26Z7asPuhrUPHthXHL707fs8D
 VjVJzMku6aMeNJYxh360l8WTipPLqNFZ+UJ0cU9fbdPhbo8IyITKMmqn+EZIuFfLEMgfVjraFT5ggf
 fGE/19A+C75FGjCKT66LLzTU9WERRUohuNmyY95fidM8uuYcZdlP8IebAYK63KxpNM0gUmi8/MVQuZ
 YVKh30mJt7L+oZQA1xXtHAez0wx8f3oBLc9GWjftEtdDAayngF6ZffIKlEiNHKxXQQevQqnBwDBZ6x
 sLbAlttxAm9Ek0MvtSwXEYqHV01QSq
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Do some testing of the signal handling for GCS, checking that a GCS
frame has the expected information in it and that the expected signals
are delivered with invalid operations.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/.gitignore    |  1 +
 .../selftests/arm64/signal/test_signals_utils.h    | 10 +++
 .../arm64/signal/testcases/gcs_exception_fault.c   | 62 +++++++++++++++
 .../selftests/arm64/signal/testcases/gcs_frame.c   | 88 ++++++++++++++++++++++
 .../arm64/signal/testcases/gcs_write_fault.c       | 67 ++++++++++++++++
 5 files changed, 228 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
index 1ce5b5eac386..75d691c13207 100644
--- a/tools/testing/selftests/arm64/signal/.gitignore
+++ b/tools/testing/selftests/arm64/signal/.gitignore
@@ -2,6 +2,7 @@
 mangle_*
 fake_sigreturn_*
 fpmr_*
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


