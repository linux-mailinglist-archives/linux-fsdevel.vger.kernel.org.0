Return-Path: <linux-fsdevel+bounces-27674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AFD9635A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840BA2862E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5BE1B2EF1;
	Wed, 28 Aug 2024 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vG80HCEq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31991AE03B;
	Wed, 28 Aug 2024 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887792; cv=none; b=fZpgJQXHiUWAvK3R4h5i/9xQX6B1VJUFdbNQEAI9YCNqM8I75sflEc02RhUL4bJ0agq4xjMXqRUnSne/efT7XCybB1yajlMPyfMC+y/mid++15lkIuUdlppLM+GgbCBShyFgWwmAvliVi0DXVRxcQPK3oA+xrO2aYBbk/eCIYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887792; c=relaxed/simple;
	bh=sqQ+QKkmK52Q/49cSzsvA/P7PZLEWrgUxaLRjQV/ejo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SB5U7xdbDGY+6v0fNcBwS/3fDMQWfYOBoucOqZ8S71Cam/E0GDXpPJ1nW7uvXmEoHVKfZn5j7fhudNtiRSVB4aIJ2YACBxSJwgzJ+t8Zj8c2K2H4zd9fFQRwIXX2Uvv7ffmZKkAaSxX9qnUHkbpQ5pQocTWlT9QUFd6K1wZCdyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vG80HCEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CC5C4CEC9;
	Wed, 28 Aug 2024 23:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887791;
	bh=sqQ+QKkmK52Q/49cSzsvA/P7PZLEWrgUxaLRjQV/ejo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vG80HCEqvwmLnCMPkEsueZpCKLk3qtzddeKGLPDggKc6vRzBYEVS7ER5zmIqb1k72
	 NJ1WLhLlBb6yY4yclm2dLosi9ZONjWf9eYlc3C82IixUyhBSDuWTFQMAolAUCMkM9J
	 7SjJdVma1a2/j3wYaNDGWvEO5/vHkCsBgW1H+gnKDWcWZ9zsjhCM3a5ynw7GDeZEbI
	 RYnwHTKAJIGplNTJjfF6wbBxz/GCmTcN4Htny3mZyzgJCqIMielS4u829nwbK9k358
	 Wl+yTMciBXNs+qpqoXOF4IimaaclSmXDpNXC1NnA2XXJfC0lOLhxIv+qaKPAwihBnp
	 LgDRVDOFqlr7w==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:27 +0100
Subject: [PATCH v12 11/39] arm64/cpufeature: Runtime detection of Guarded
 Control Stack (GCS)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-11-42fec947436a@kernel.org>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
In-Reply-To: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2509; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sqQ+QKkmK52Q/49cSzsvA/P7PZLEWrgUxaLRjQV/ejo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KBb0D7nRtPjG+I2opJk4w/nm2oBnx9CZM1fZNA
 klVt8vmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+ygQAKCRAk1otyXVSH0FsFB/
 4jYAAOCvMcLn76pgsL2eJroEr/+4+Q1QK1oTGp2N5IIb1Gio3ea8VWw98RqN1INA8Mr//fr6P0TKYy
 btsGw20wDmKwt5jWc4K/dnC+VD8mes1LfawGk0hby4u5Ca7dMRld+UYbTiAZ+i6NPw+ncBK0JPmdWL
 pCOn8dL8Z2Czjd8hPQmEIEzbIjmzRjJQpPRYGtL1HNHJf3xYN3Tf5HJwqqcrk9Rg6BUiehboxjX8Q9
 OOLqAkIsvVPSqD1hbZ7miFEFFWfduQ6zIILc0lwpyTF21OKBGEGL4Kb2q3rYqKOEUbOEeV0dawvxBS
 QcMYvPUxZ4tb6LAVN5gvIu9lP4qrET
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add a cpufeature for GCS, allowing other code to conditionally support it
at runtime.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
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


