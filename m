Return-Path: <linux-fsdevel+bounces-26779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E75FC95B9D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCE3B25999
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF30F1CDA1C;
	Thu, 22 Aug 2024 15:13:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175B31CCEDD;
	Thu, 22 Aug 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339611; cv=none; b=BBiMaYHS7cRqIrIX0ZmTuWKzoJOPEB0snmYXyz4TH486WOJm9q+jX4HC+lnFgF9jVxsEuPCNLd8+8vyOkvP41TtwvYZOQtIZcOgc2naZmD98H9vPXlwrorBzpz9bkBiLqL+hXVuAQXMfF9orLCTkXSJqQxBWPRDJoD9GkjKEiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339611; c=relaxed/simple;
	bh=96mBV9RiHbkJ8v17sWh/sBwNly5VcAydYywmKRjKko0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u3DGdaRxkX6hiT6/GErJ00cyy2XmXyV+W4Crl9xZCBpJrurMuIm9jsT1fxN9o5wj1qRRm9lTf9E3Shi2UzWPAlbG0rnne6uZlSc3nhG/8R5iOQNiBlNQwbBDi4/aCwV66djWv0YUyRuxTGkA2jsaoNLmOI09hNIkhk6Pr9VqLm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C52391691;
	Thu, 22 Aug 2024 08:13:55 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A68193F58B;
	Thu, 22 Aug 2024 08:13:25 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	anshuman.khandual@arm.com,
	bp@alien8.de,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	maz@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	npiggin@gmail.com,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 29/30] kselftest/arm64: Add test case for POR_EL0 signal frame records
Date: Thu, 22 Aug 2024 16:11:12 +0100
Message-Id: <20240822151113.1479789-30-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822151113.1479789-1-joey.gouly@arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that we get signal context for POR_EL0 if and only if POE is present
on the system.

Copied from the TPIDR2 test.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../testing/selftests/arm64/signal/.gitignore |  1 +
 .../arm64/signal/testcases/poe_siginfo.c      | 86 +++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/poe_siginfo.c

diff --git tools/testing/selftests/arm64/signal/.gitignore tools/testing/selftests/arm64/signal/.gitignore
index 1ce5b5eac386..b2f2bfd5c6aa 100644
--- tools/testing/selftests/arm64/signal/.gitignore
+++ tools/testing/selftests/arm64/signal/.gitignore
@@ -2,6 +2,7 @@
 mangle_*
 fake_sigreturn_*
 fpmr_*
+poe_*
 sme_*
 ssve_*
 sve_*
diff --git tools/testing/selftests/arm64/signal/testcases/poe_siginfo.c tools/testing/selftests/arm64/signal/testcases/poe_siginfo.c
new file mode 100644
index 000000000000..36bd9940ee05
--- /dev/null
+++ tools/testing/selftests/arm64/signal/testcases/poe_siginfo.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Arm Limited
+ *
+ * Verify that the POR_EL0 register context in signal frames is set up as
+ * expected.
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <unistd.h>
+#include <asm/sigcontext.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static union {
+	ucontext_t uc;
+	char buf[1024 * 128];
+} context;
+
+#define SYS_POR_EL0 "S3_3_C10_C2_4"
+
+static uint64_t get_por_el0(void)
+{
+	uint64_t val;
+
+	asm volatile(
+		"mrs	%0, " SYS_POR_EL0 "\n"
+		: "=r"(val)
+		:
+		: );
+
+	return val;
+}
+
+int poe_present(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	struct _aarch64_ctx *head = GET_BUF_RESV_HEAD(context);
+	struct poe_context *poe_ctx;
+	size_t offset;
+	bool in_sigframe;
+	bool have_poe;
+	__u64 orig_poe;
+
+	have_poe = getauxval(AT_HWCAP2) & HWCAP2_POE;
+	if (have_poe)
+		orig_poe = get_por_el0();
+
+	if (!get_current_context(td, &context.uc, sizeof(context)))
+		return 1;
+
+	poe_ctx = (struct poe_context *)
+		get_header(head, POE_MAGIC, td->live_sz, &offset);
+
+	in_sigframe = poe_ctx != NULL;
+
+	fprintf(stderr, "POR_EL0 sigframe %s on system %s POE\n",
+		in_sigframe ? "present" : "absent",
+		have_poe ? "with" : "without");
+
+	td->pass = (in_sigframe == have_poe);
+
+	/*
+	 * Check that the value we read back was the one present at
+	 * the time that the signal was triggered.
+	 */
+	if (have_poe && poe_ctx) {
+		if (poe_ctx->por_el0 != orig_poe) {
+			fprintf(stderr, "POR_EL0 in frame is %llx, was %llx\n",
+				poe_ctx->por_el0, orig_poe);
+			td->pass = false;
+		}
+	}
+
+	return 0;
+}
+
+struct tdescr tde = {
+	.name = "POR_EL0",
+	.descr = "Validate that POR_EL0 is present as expected",
+	.timeout = 3,
+	.run = poe_present,
+};
-- 
2.25.1


