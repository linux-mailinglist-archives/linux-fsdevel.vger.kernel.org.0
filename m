Return-Path: <linux-fsdevel+bounces-30585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E57C198C8C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3612286B37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B33F1D048B;
	Tue,  1 Oct 2024 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3BTEar0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7FA1CF7B2;
	Tue,  1 Oct 2024 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823727; cv=none; b=dx8xYWyGohvCf4YceXNSwUTWiSZO2yGTBitzaV0HX3kqFAvA2BFqZdU+hB/CLIVCDfwRUkVO8ygFOmXJDV0SriLReFvQUxoaAtR5F2/pPW5xBsSXCs5KaLvJ9XRcgazhMsblY1IY/BFplvtFo5wE38NxCxo8VrW2wuzwSCSu/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823727; c=relaxed/simple;
	bh=XlTxOnAiHFAYZKJpgoxrD4q5MOzDKmN/oDFlTiS+t2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=biXSYgAsTkzCpXxyYx1Zfryk07jK24ZcPPjgxDu0lLtgs35Hvobv14QLVLukzaGKuuy1GpsnAP3+1KH/FD2CjeUQfEqlo9Qh7bZCP/G9m+1NTn39uFjhdnX1HYTyAjHEo5SY6r5Wlfp9t22Ey0qgB9+rRDNIh9OhVgVOIn1lOB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3BTEar0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05C7C4CEC6;
	Tue,  1 Oct 2024 23:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823727;
	bh=XlTxOnAiHFAYZKJpgoxrD4q5MOzDKmN/oDFlTiS+t2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B3BTEar0kxUHPMC45mb/3guTN8GQteT2abMPsEuayS/m7o/yinbVqAofmSJC4hI07
	 laDxHf5pNum6w1MgF0Hatb12IwvGiUudPyBa5N4Lt0ph/FDLQj0IrCG80UZ4dteOWt
	 XJG3OqTG+iwCn6+Fiu3D3SBDbLpx8k0b0D1D1SkkUNBVUJQkyY7/m5wtvgBalleSbX
	 4pyK+RBR1fyMn0UP6jxDTF7ofARSEdkfZyOYkMdlcsrO4Qe9cMDsXpQvv2nlGPcp9a
	 8j+QRwqde2ItoCzSxkbWyhuBcdhMtzUYyjW/LsolvPgDftd4DhYtR1Y2evktbviPm1
	 ib8H5QFYnP7+g==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:58:51 +0100
Subject: [PATCH v13 12/40] arm64/cpufeature: Runtime detection of Guarded
 Control Stack (GCS)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-12-222b78d87eee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3078; i=broonie@kernel.org;
 h=from:subject:message-id; bh=XlTxOnAiHFAYZKJpgoxrD4q5MOzDKmN/oDFlTiS+t2w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7NyUyYZXa21wFdz0TjX5+sLCx8XfO60DxVZUCX
 Ab4QUCaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+zQAKCRAk1otyXVSH0ICIB/
 9K3rESouHqLdfEcbd40qOHOSuEGRBwHV6r7EoMItNYD0N1F1ziysWvW4clA/0BqTgCI6dGSee3B91k
 +f7Xyfzxw77OGGlWSXBX5JMWqi4pK6xKeSJ/AeuZu09I7/HFcv96y1I5UD+VKmusZVKYYAKCw4Fdk9
 5ke/xGqI/ii3mk2LZC+9Bow39wLizLWVo+OoaZ24iIsppW3pn3yl3hKpQHeN6x3ktjtfP3D7zVPPSI
 Jv7cZIjxEhD32jwR+vKPxyYD/GoepBE6abKyD4a9TO1br+AU0iNCfaAkKQvL/6FmYDLfsgHvYfjAk7
 G4HaapPWfssm48QGOmIYG8CK2nU+4C
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add a cpufeature for GCS, allowing other code to conditionally support it
at runtime.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  6 ++++++
 arch/arm64/kernel/cpufeature.c      | 20 ++++++++++++++++++++
 arch/arm64/tools/cpucaps            |  1 +
 3 files changed, 27 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 3d261cc123c1..69470795f5d2 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -838,6 +838,12 @@ static inline bool system_supports_poe(void)
 		alternative_has_cap_unlikely(ARM64_HAS_S1POE);
 }
 
+static inline bool system_supports_gcs(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_GCS) &&
+		alternative_has_cap_unlikely(ARM64_HAS_GCS);
+}
+
 int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 718728a85430..d1e758e99e0a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -291,6 +291,8 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_GCS),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_GCS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_SME_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_MPAM_frac_SHIFT, 4, 0),
@@ -2358,6 +2360,14 @@ static void cpu_enable_poe(const struct arm64_cpu_capabilities *__unused)
 }
 #endif
 
+#ifdef CONFIG_ARM64_GCS
+static void cpu_enable_gcs(const struct arm64_cpu_capabilities *__unused)
+{
+	/* GCSPR_EL0 is always readable */
+	write_sysreg_s(GCSCRE0_EL1_nTR, SYS_GCSCRE0_EL1);
+}
+#endif
+
 /* Internal helper functions to match cpu capability type */
 static bool
 cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
@@ -2889,6 +2899,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_enable_poe,
 		ARM64_CPUID_FIELDS(ID_AA64MMFR3_EL1, S1POE, IMP)
 	},
+#endif
+#ifdef CONFIG_ARM64_GCS
+	{
+		.desc = "Guarded Control Stack (GCS)",
+		.capability = ARM64_HAS_GCS,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.cpu_enable = cpu_enable_gcs,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, GCS, IMP)
+	},
 #endif
 	{},
 };
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index eedb5acc21ed..867d25d4a45a 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -29,6 +29,7 @@ HAS_EVT
 HAS_FPMR
 HAS_FGT
 HAS_FPSIMD
+HAS_GCS
 HAS_GENERIC_AUTH
 HAS_GENERIC_AUTH_ARCH_QARMA3
 HAS_GENERIC_AUTH_ARCH_QARMA5

-- 
2.39.2


