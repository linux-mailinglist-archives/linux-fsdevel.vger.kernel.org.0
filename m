Return-Path: <linux-fsdevel+bounces-10180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA8984862C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064C128597B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346D7E791;
	Sat,  3 Feb 2024 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou0+iCIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E537E78E;
	Sat,  3 Feb 2024 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963621; cv=none; b=T4OWlTCzBzYh0huRYy9P/oK53aWCa1LXy+ckchy1UeTZbr4X314ufbGxYKR6GrNnICKCwr7lVhRiW2XhpUgGn9RIpGh/ahwMs/VHGacQJhWqA4iib8O+gZaHqgqC+5QOQdvBa1PRi26g0w7QEwKjMFAbyrhuxKaq+sUzTc7QFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963621; c=relaxed/simple;
	bh=29MX4bFmi9RjszKvoThz75zOXEvMrbFZDv9wXNIm3c0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kbcRdij6mgUf1taD1p7PZP5mFbMZkYE7/icPMV8BbTYubQ4lO/ZtwJ3OzxROyECue+8nwPYZeVkWvF4D70Nj3Jq9hlTXzzsyuF+kzwLBFyy5VdCTkb/gCcFnx1SD1EhxN65tpCylwk/wIsVUMwnyfQmTXGwQ7wqmbFSqVlM7CrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou0+iCIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16E0C433F1;
	Sat,  3 Feb 2024 12:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963621;
	bh=29MX4bFmi9RjszKvoThz75zOXEvMrbFZDv9wXNIm3c0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ou0+iCIHrfjXH8n3BCVtgt+iHJGGPftd3xtuxNQzXoESJCfCMvhUTf2x5E3rIuQXp
	 Z7X1iVJst836kXKlagMfIlHB4EcQHl98pVo+QfyapUl9k537WYC6jKYvmBdZ8DuN4f
	 swOLANkxDyBQO5rIaFMOPmeBkOOw6DHQ5/dWVmyJQJp3QN0dHZiqNYA1k3g+1/5HUb
	 wikHa/mQQOEtYIMALYfqVSNvwK7Z7N4PoorqEccGi2S8fK3zwpvpkHwGYd7sUz7j0D
	 IXCHps1tEZxuErKWv1XBKO/0kQVm6GNTaiMdxIaPagWkxXQwm+PO85dzIyxITFNfFD
	 TgmaqF/7+K36g==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:26:01 +0000
Subject: [PATCH v8 35/38] selftests/arm64: Add GCS signal tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-35-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
In-Reply-To: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
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
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=7609; i=broonie@kernel.org;
 h=from:subject:message-id; bh=29MX4bFmi9RjszKvoThz75zOXEvMrbFZDv9wXNIm3c0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDsC+adCQ5LH7Db6WhjtpyGz4I1K5rQocla/DSr
 j0dGSSyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w7AAKCRAk1otyXVSH0Eh4B/
 9VPWk1n8iVrCOX/tNVqSxjuteZ6BZ4SFxLj1NSvlrss8g9uHuY3fK+z7N8fegHs6CpMUqAp5Ps4noG
 T4tDEHp1kDKvUgiKBiVS/th0nhCtsneRDl884ghHbL+4WQ3Y9i1VA+bGTN6+/AcTuHtst3o84jo4SX
 f9Yxd4zSCAFbTw6hOzwQKUbzkj32Xtj9V05+803T5/Tbq0j6cSrjLqzF10edbtBlDaHE7owmUzqKvm
 6IhK3sBOJrT7uwbvUzBqfobQza7tQY9E2LBIzVe7WG1yqVOkKxRh0x6kji2WRdMCkL+evutA5AC/in
 +eWj3fFSAwg70jXfu4I5F02Wt9/uK7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Do some testing of the signal handling for GCS, checking that a GCS
frame has the expected information in it and that the expected signals
are delivered with invalid operations.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/.gitignore    |  1 +
 .../selftests/arm64/signal/test_signals_utils.h    | 10 +++
 .../arm64/signal/testcases/gcs_exception_fault.c   | 62 +++++++++++++++
 .../selftests/arm64/signal/testcases/gcs_frame.c   | 88 ++++++++++++++++++++++
 .../arm64/signal/testcases/gcs_write_fault.c       | 67 ++++++++++++++++
 5 files changed, 228 insertions(+)

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
2.30.2


