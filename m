Return-Path: <linux-fsdevel+bounces-22379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7F4916BBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED25E28913F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B900517CA17;
	Tue, 25 Jun 2024 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guFLMlnM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F1116F859;
	Tue, 25 Jun 2024 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327705; cv=none; b=L2FYVyHfnUdgDmZLO9ZWyM0Xh5jWmJEU1ihI9pOPPUyp+ipUGntBFoPJhdElY655rVu6l5sq32NFhQT+LfO7IMEn2ipXklZvjD+N/d2fyLblmiw++fItJohm0WnMXUHHvwXx6BL7hndTOEhqVQ77s2W7o3cwDVfL3BubG630xkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327705; c=relaxed/simple;
	bh=HBYukUfWWcYFaZwVBzBm0FRifOIeZ7AM+OQsOqT0FkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCODGhaohBtJIJ2+immqnkM+Qti1xzQXHS/W4sGMAHu8/E1otwe35KosLxOI6B9BsPgvYWqkp/055Qw3z62BGLaolfo8UlvRDaWpJoNSK4Gve9y1BlJzRmt/DTg9L7+01cV43ycb8RjQ+hGAeJr+DYCIawkjuNSYCBVqX1kZjvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guFLMlnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FBFC32782;
	Tue, 25 Jun 2024 15:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327704;
	bh=HBYukUfWWcYFaZwVBzBm0FRifOIeZ7AM+OQsOqT0FkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=guFLMlnM1QO43GlmvCb+/U/FOOQAUKPCWEgOqJfY5M5MDV6SRmAQOa8q7C9lTPBvJ
	 bCTwBCFm1G71kP5NwfiymCRgWuFdfK88BlX2BsEf4OZvoHlBG33AubZ3oA/ri9TwuR
	 x3h6i4zE6icz8GEnRzzvzKVrK4BJFmIoHUDgx/cYgO94TdAqy3duoeOcMTWTqqkl83
	 XJYk7MlKz+mCHz9ly6aD2LU/yOz2Xsh7xy2ZOaj10LsQ7cSw/hkg7Hoa8xWvYO8fgZ
	 5F+4lZS184nGsTwjJsweeg8rH9zsi87ornpjkfw9+/ddJndjUetLK/mVuxfPCyrGG0
	 cmGd+vmSRllcQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:37 +0100
Subject: [PATCH v9 09/39] arm64/cpufeature: Runtime detection of Guarded
 Control Stack (GCS)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-9-0f634469b8f0@kernel.org>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
In-Reply-To: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
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
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=2967; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HBYukUfWWcYFaZwVBzBm0FRifOIeZ7AM+OQsOqT0FkM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmett5TPImNiJ8QKbVQxAR+IKRHbeiwzvOwBa7FcIp
 VCtDJlSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbeQAKCRAk1otyXVSH0C0wB/
 9NlpCrbN55O/ocWyGWdcitxqcYlV5HNiRlaj/HXg3uyfnTgowjv1GnR10+pBR8qw6i05h/sCLgJkcW
 89w0l/rOivkbV/LHTpoMWradc1lhtcePGc8r2oqea9dHPtD1nKD632CWNTiByENihEmHnufFbWzCdD
 n/kuevX+t5HPce0qds2YCgqByhWei+20Tq3fTtGrBTDK+9DFEpFfKxnT2fuZx1e/20QT/gQaFeXkCQ
 yrzSLi6gdBWy9fG6Xpuh2j2YiYF7yaiS6DhtFjSLzwS/lGdnk3onXV/WMYzqbgrefN54gTj2hKQG03
 WFocfLobkJrHHUhGnQ39ToAgXyrPXO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add a cpufeature for GCS, allowing other code to conditionally support it
at runtime.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  6 ++++++
 arch/arm64/kernel/cpufeature.c      | 16 ++++++++++++++++
 arch/arm64/tools/cpucaps            |  1 +
 3 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8b904a757bd3..0ebed5dfe55f 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -832,6 +832,12 @@ static inline bool system_supports_lpa2(void)
 	return cpus_have_final_cap(ARM64_HAS_LPA2);
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
index 48e7029f1054..056d394920f9 100644
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
@@ -2347,6 +2349,12 @@ static void cpu_enable_mops(const struct arm64_cpu_capabilities *__unused)
 	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_MSCEn);
 }
 
+static void cpu_enable_gcs(const struct arm64_cpu_capabilities *__unused)
+{
+	/* GCS is not currently used at EL1 */
+	write_sysreg_s(0, SYS_GCSCR_EL1);
+}
+
 /* Internal helper functions to match cpu capability type */
 static bool
 cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
@@ -2869,6 +2877,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_nv1,
 		ARM64_CPUID_FIELDS_NEG(ID_AA64MMFR4_EL1, E2H0, NI_NV1)
 	},
+	{
+		.desc = "Guarded Control Stack (GCS)",
+		.capability = ARM64_HAS_GCS,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.cpu_enable = cpu_enable_gcs,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, GCS, IMP)
+	},
 	{},
 };
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index ac3429d892b9..66eff95c0824 100644
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


