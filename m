Return-Path: <linux-fsdevel+bounces-1411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED2A7D9F96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 645DCB2150C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC113F4C4;
	Fri, 27 Oct 2023 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB123E465
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:10:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C82DC0;
	Fri, 27 Oct 2023 11:10:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E91801424;
	Fri, 27 Oct 2023 11:10:41 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 273E23F64C;
	Fri, 27 Oct 2023 11:09:58 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	will@kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 23/24] kselftest/arm64: Add test case for POR_EL0 signal frame records
Date: Fri, 27 Oct 2023 19:08:49 +0100
Message-Id: <20231027180850.1068089-24-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027180850.1068089-1-joey.gouly@arm.com>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
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
---
 .../testing/selftests/arm64/signal/.gitignore |  1 +
 .../arm64/signal/testcases/poe_siginfo.c      | 86 +++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/poe_siginfo.c

diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
index 839e3a252629..6bcb27bd506b 100644
--- a/tools/testing/selftests/arm64/signal/.gitignore
+++ b/tools/testing/selftests/arm64/signal/.gitignore
@@ -5,6 +5,7 @@ sme_*
 ssve_*
 sve_*
 tpidr2_*
+poe_siginfo
 za_*
 zt_*
 !*.[ch]
diff --git a/tools/testing/selftests/arm64/signal/testcases/poe_siginfo.c b/tools/testing/selftests/arm64/signal/testcases/poe_siginfo.c
new file mode 100644
index 000000000000..d890029304c4
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/poe_siginfo.c
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
+	asm volatile (
+		"mrs	%0, " SYS_POR_EL0 "\n"
+		: "=r"(val)
+		:
+		: "cc");
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


