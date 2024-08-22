Return-Path: <linux-fsdevel+bounces-26761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0F295B992
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3BFB2BBF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0E51CCB24;
	Thu, 22 Aug 2024 15:12:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB071CC8B5;
	Thu, 22 Aug 2024 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339533; cv=none; b=YSysoqNj8JIfr1C9oqUep9IHNc0daXx0oJ+OnUI/oFvCUfUtOcpFguu2DjcIiTfp1UIrP9ubol3Q65atuQRkIObM7JYCH9Wb50aLGtgxz5zYe74EpuFELtCtomG+1k8Yf3JM8zpqRSL1vIPSnk094UY8HUsLNct8FL0OgfrMaks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339533; c=relaxed/simple;
	bh=EC6N0oXuu0xwG3WgG1oCx4RMipcnnL0h+uAED9gMGFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YKg61YPRHe66AdGdET2CMb9rIpSKnZH4tqsWOUEfE4atZXosykODzyE9D5ak8JpYfhj0wUCWGYKro16tWETb9nyaDrH2STuNx23RWFjyB7qvz9p6Ks22JrcQzphd55QxJbcDMX2fKLIacd13xd4FhAoHw/2Eq+PqchXwf3WFyyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAB8B1576;
	Thu, 22 Aug 2024 08:12:37 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC5FA3F58B;
	Thu, 22 Aug 2024 08:12:07 -0700 (PDT)
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
Subject: [PATCH v5 11/30] arm64: enable the Permission Overlay Extension for EL0
Date: Thu, 22 Aug 2024 16:10:54 +0100
Message-Id: <20240822151113.1479789-12-joey.gouly@arm.com>
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

Expose a HWCAP and ID_AA64MMFR3_EL1_S1POE to userspace, so they can be used to
check if the CPU supports the feature.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/arch/arm64/elf_hwcaps.rst |  2 ++
 arch/arm64/include/asm/hwcap.h          |  1 +
 arch/arm64/include/uapi/asm/hwcap.h     |  1 +
 arch/arm64/kernel/cpufeature.c          | 14 ++++++++++++++
 arch/arm64/kernel/cpuinfo.c             |  1 +
 5 files changed, 19 insertions(+)

diff --git Documentation/arch/arm64/elf_hwcaps.rst Documentation/arch/arm64/elf_hwcaps.rst
index 448c1664879b..694f67fa07d1 100644
--- Documentation/arch/arm64/elf_hwcaps.rst
+++ Documentation/arch/arm64/elf_hwcaps.rst
@@ -365,6 +365,8 @@ HWCAP2_SME_SF8DP2
 HWCAP2_SME_SF8DP4
     Functionality implied by ID_AA64SMFR0_EL1.SF8DP4 == 0b1.
 
+HWCAP2_POE
+    Functionality implied by ID_AA64MMFR3_EL1.S1POE == 0b0001.
 
 4. Unused AT_HWCAP bits
 -----------------------
diff --git arch/arm64/include/asm/hwcap.h arch/arm64/include/asm/hwcap.h
index 4edd3b61df11..a775adddecf2 100644
--- arch/arm64/include/asm/hwcap.h
+++ arch/arm64/include/asm/hwcap.h
@@ -157,6 +157,7 @@
 #define KERNEL_HWCAP_SME_SF8FMA		__khwcap2_feature(SME_SF8FMA)
 #define KERNEL_HWCAP_SME_SF8DP4		__khwcap2_feature(SME_SF8DP4)
 #define KERNEL_HWCAP_SME_SF8DP2		__khwcap2_feature(SME_SF8DP2)
+#define KERNEL_HWCAP_POE		__khwcap2_feature(POE)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git arch/arm64/include/uapi/asm/hwcap.h arch/arm64/include/uapi/asm/hwcap.h
index 285610e626f5..055381b2c615 100644
--- arch/arm64/include/uapi/asm/hwcap.h
+++ arch/arm64/include/uapi/asm/hwcap.h
@@ -122,5 +122,6 @@
 #define HWCAP2_SME_SF8FMA	(1UL << 60)
 #define HWCAP2_SME_SF8DP4	(1UL << 61)
 #define HWCAP2_SME_SF8DP2	(1UL << 62)
+#define HWCAP2_POE		(1UL << 63)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git arch/arm64/kernel/cpufeature.c arch/arm64/kernel/cpufeature.c
index 2daf5597cd65..718728a85430 100644
--- arch/arm64/kernel/cpufeature.c
+++ arch/arm64/kernel/cpufeature.c
@@ -466,6 +466,8 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64mmfr3[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_POE),
+		       FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR3_EL1_S1POE_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR3_EL1_S1PIE_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR3_EL1_TCRX_SHIFT, 4, 0),
 	ARM64_FTR_END,
@@ -2348,6 +2350,14 @@ static void cpu_enable_mops(const struct arm64_cpu_capabilities *__unused)
 	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_MSCEn);
 }
 
+#ifdef CONFIG_ARM64_POE
+static void cpu_enable_poe(const struct arm64_cpu_capabilities *__unused)
+{
+	sysreg_clear_set(REG_TCR2_EL1, 0, TCR2_EL1x_E0POE);
+	sysreg_clear_set(CPACR_EL1, 0, CPACR_ELx_E0POE);
+}
+#endif
+
 /* Internal helper functions to match cpu capability type */
 static bool
 cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
@@ -2876,6 +2886,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_S1POE,
 		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
 		.matches = has_cpuid_feature,
+		.cpu_enable = cpu_enable_poe,
 		ARM64_CPUID_FIELDS(ID_AA64MMFR3_EL1, S1POE, IMP)
 	},
 #endif
@@ -3043,6 +3054,9 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8DP2, IMP, CAP_HWCAP, KERNEL_HWCAP_F8DP2),
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8E4M3, IMP, CAP_HWCAP, KERNEL_HWCAP_F8E4M3),
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8E5M2, IMP, CAP_HWCAP, KERNEL_HWCAP_F8E5M2),
+#ifdef CONFIG_ARM64_POE
+	HWCAP_CAP(ID_AA64MMFR3_EL1, S1POE, IMP, CAP_HWCAP, KERNEL_HWCAP_POE),
+#endif
 	{},
 };
 
diff --git arch/arm64/kernel/cpuinfo.c arch/arm64/kernel/cpuinfo.c
index 09eeaa24d456..b9db812082b3 100644
--- arch/arm64/kernel/cpuinfo.c
+++ arch/arm64/kernel/cpuinfo.c
@@ -143,6 +143,7 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_SME_SF8FMA]	= "smesf8fma",
 	[KERNEL_HWCAP_SME_SF8DP4]	= "smesf8dp4",
 	[KERNEL_HWCAP_SME_SF8DP2]	= "smesf8dp2",
+	[KERNEL_HWCAP_POE]		= "poe",
 };
 
 #ifdef CONFIG_COMPAT
-- 
2.25.1


