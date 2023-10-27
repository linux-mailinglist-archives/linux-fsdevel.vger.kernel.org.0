Return-Path: <linux-fsdevel+bounces-1391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2254C7D9F70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFE91C2082B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5557E3C075;
	Fri, 27 Oct 2023 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A343C071
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:09:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A2F3C0;
	Fri, 27 Oct 2023 11:09:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37C331570;
	Fri, 27 Oct 2023 11:09:53 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69FAF3F64C;
	Fri, 27 Oct 2023 11:09:09 -0700 (PDT)
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
Subject: [PATCH v2 03/24] arm64: cpufeature: add Permission Overlay Extension cpucap
Date: Fri, 27 Oct 2023 19:08:29 +0100
Message-Id: <20231027180850.1068089-4-joey.gouly@arm.com>
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

This indicates if the system supports POE. This is a CPUCAP_BOOT_CPU_FEATURE
as the boot CPU will enable POE if it has it, so secondary CPUs must also
have this feature.

Add a new config option: ARM64_POE

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig             | 16 ++++++++++++++++
 arch/arm64/kernel/cpufeature.c |  9 +++++++++
 arch/arm64/tools/cpucaps       |  1 +
 3 files changed, 26 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b10515c0200b..1f1a12e28c3f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2060,6 +2060,22 @@ config ARM64_EPAN
 	  if the cpu does not implement the feature.
 endmenu # "ARMv8.7 architectural features"
 
+menu "ARMv8.9 architectural features"
+config ARM64_POE
+	prompt "Permission Overlay Extension"
+	def_bool y
+	help
+	  The Permission Overlay Extension is used to implement Memory
+	  Protection Keys. Memory Protection Keys provides a mechanism for
+	  enforcing page-based protections, but without requiring modification
+	  of the page tables when an application changes protection domains.
+
+	  For details, see Documentation/core-api/protection-keys.rst
+
+	  If unsure, say y.
+
+endmenu # "ARMv8.9 architectural features"
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 444a73c2e638..f1c1f348a31d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2719,6 +2719,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
 	},
+#ifdef CONFIG_ARM64_POE
+	{
+		.desc = "Stage-1 Permission Overlay Extension (S1POE)",
+		.capability = ARM64_HAS_S1POE,
+		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR3_EL1, S1POE, IMP)
+	},
+#endif
 	{},
 };
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index c3f06fdef609..b8348e40f6d9 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -43,6 +43,7 @@ HAS_NO_FPSIMD
 HAS_NO_HW_PREFETCH
 HAS_PAN
 HAS_S1PIE
+HAS_S1POE
 HAS_RAS_EXTN
 HAS_RNG
 HAS_SB
-- 
2.25.1


