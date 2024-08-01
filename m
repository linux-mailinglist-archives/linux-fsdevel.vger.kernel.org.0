Return-Path: <linux-fsdevel+bounces-24759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355EF944C0B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BAF28977D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796231A4F36;
	Thu,  1 Aug 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qScMxBIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BFB1A08A4;
	Thu,  1 Aug 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517108; cv=none; b=pJTxzqe6CCDUyOO8tWjeHGDEBAFAdQX0SE0jGqarildKLSIhQ6WTFxvABst/54AZpkEayqDUxymhWUC7t22UPpdrPGRkqIsNfJbNNGRdE9NsjE1dT+sFqoEJ9hsISxYsCcwK2KCeX83YU8A06q8GhtaBgSaAdlfg7x3kwylNPCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517108; c=relaxed/simple;
	bh=7s/gHN1rW9TWM0RWrG/NmXj1X2oouK/u/2cODr8xaC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p3H4/yA1vP6BBlWQM1B0hHTPo0FtT6ymau1j4jOnXRKfQLogrhpfFUF70bp6GlsbyE+3vbQVz2H+HGlcoi+tr/tTMotuMd8Pcc8BXW56wmzWASz4JvxCQsgR0Y/zlZc0mGcN2b5TdqL8gsm0xqAXoE7tnLkD95Du+PgGQyisw44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qScMxBIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED585C32786;
	Thu,  1 Aug 2024 12:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517108;
	bh=7s/gHN1rW9TWM0RWrG/NmXj1X2oouK/u/2cODr8xaC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qScMxBIszKrXZE6l4jPoTZd0nsXO1uelO8k1eOLYUYobg5sCv+WFBa/d9YsyPSjjE
	 Z3j6LkQGPdSakAiJyW3ywm/GCPzVnFwElgiqof7vhrJX2QXsPqq5y0pLAMme20kovg
	 4N9nUNe+fShGNxKq9paQfEnIMMwvAbMfweChUFzIn+lCsfai4eJp1X0wVoD4A0UPqJ
	 7hGh+xa1HXikFeCOdh+57VLYWktfB1I6vBg3MPem/FMEiyccc3PegQIP8kXmxbXGij
	 CL3VqAezLGfpJprR1gOrh3ZMaWOOl9hB2i8Khf5JXTuVWsbO7Xp5uOI1LAGDQrRteJ
	 74cl5kQDYkVzA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:37 +0100
Subject: [PATCH v10 10/40] arm64/cpufeature: Runtime detection of Guarded
 Control Stack (GCS)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-10-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7s/gHN1rW9TWM0RWrG/NmXj1X2oouK/u/2cODr8xaC4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YNgfqa/ixM61jewvMBym4ukRMnWI/ViFp4+3Jz
 URec3AeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGDQAKCRAk1otyXVSH0An1B/
 42nmOBfn/4sSlWSLsHjdMFjPjyaLDIR7Dx9tGlYicIgU0lkdGVZEZk/Tk/sufifPGYX8G79vGolOK/
 MczkShezUksVzrd1+DAMNjoHsukcOl8U3cqwFjCKW700My8kSSTR43ucvlPf9jlRzxlkRw+hU5upW8
 PAr3+wx1mTca/ZynY3/XuSz3Udebj7h4fkiNPBzVU/kEnE/LJDLvcvsDSg7p1TziVpg7w6sr1noMu8
 05mLN/s+AzWeWhuoJ/M774sJ6AvcfWn6lvHpKGctfqdo8u/MQ5oHFV7hUt3QR+nhcgJ8JvdKEeDRif
 TWMj6huJOHT/eJ7M+sNF3opx5AEHQG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add a cpufeature for GCS, allowing other code to conditionally support it
at runtime.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h | 6 ++++++
 arch/arm64/kernel/cpufeature.c      | 9 +++++++++
 arch/arm64/tools/cpucaps            | 1 +
 3 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 558434267271..e0f0e4c24544 100644
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
index 646ecd3069fd..315bd7be1106 100644
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
@@ -2870,6 +2872,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_nv1,
 		ARM64_CPUID_FIELDS_NEG(ID_AA64MMFR4_EL1, E2H0, NI_NV1)
 	},
+	{
+		.desc = "Guarded Control Stack (GCS)",
+		.capability = ARM64_HAS_GCS,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
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


