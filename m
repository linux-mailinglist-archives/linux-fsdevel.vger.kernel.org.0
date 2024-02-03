Return-Path: <linux-fsdevel+bounces-10158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3500E8485BE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA471F22A64
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEBF63401;
	Sat,  3 Feb 2024 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4+pK5KF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8127715E5B5;
	Sat,  3 Feb 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963469; cv=none; b=ASK9u/p27so4YD8U2OMyiSgmnGus0Z+UixWdu0znkbnYgxbFvXJ4fVee0G6kDja0Yv2STlwZ06fi62u1dLxO4iCZuVbubJoPZD1Pi3RztOLEEplBQ/GRiXa/5Cae0wkYdVjI/2GqfIDBcuRk0Ndjui+HfCB77Qk8yX76SeYrYu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963469; c=relaxed/simple;
	bh=wsC4cXHxhQJUOeMbmPuoHCyoB60s23Z9e6BRm1QhN7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L6E/nkdIwmWoIDPCEF0/Pi1rPxEnDhmKNKeb8jYJ6Ao4xRakjqTl0QwM8C56YcrqGsTaj1+/g2J4+1WR8TAcYiD5Po/l90yTPYUbDyfshLOCbuJzU04cRFt3uQsN2tMCr6Ou37Bzl4BqcxolQuEthzTN9HYGGjdIp3RnHkNVE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4+pK5KF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7804C433A6;
	Sat,  3 Feb 2024 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963469;
	bh=wsC4cXHxhQJUOeMbmPuoHCyoB60s23Z9e6BRm1QhN7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y4+pK5KFU0dncMhitlTirufT5ijd2/gZ96LtjyukVkILr1m2XXsADtfHpLiMfvgwc
	 1rVY7lygDo5aNC9i34odTMACj/89MX+Av2vjb3OmoUAV+AoVABv/QBL47arcpjvJSH
	 /xwiFwfCXeNBFi1rWGto82wLoWhGcwAptuxYErv9TSpsNME6MWd3KzeowF/TnjH4xa
	 gcgbyo/m+041r/1zvfh1UGaU0aTR1uvs5kz7umBZA6ciBv0H7mI7A30QQtbZ4ExpAm
	 YQnV9Z4kdn09sQDx3HdTh/PLbYdyReYOD0Fi3vU+pFAAaRUuYHaweLfKr4o7yYCR75
	 GzhW7CtkIkkLw==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:39 +0000
Subject: [PATCH v8 13/38] KVM: arm64: Manage GCS registers for guests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-13-c9fec77673ef@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6351; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wsC4cXHxhQJUOeMbmPuoHCyoB60s23Z9e6BRm1QhN7A=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDbJNRUJao3dWvuwPTqT3MBlEVih4ppUyFD1IDZ
 rP8CrkyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w2wAKCRAk1otyXVSH0MKDB/
 4n9gMdLyCdNGCiZo+CTMFlgQ4Wi8rMdJmgyEoJTwuG76FVrWeLymMLRG5IfLwYTUawuLoJxV8TS1kv
 /qDxZzMgPY3zCqfIes1OM6ZCSt0OWYzq1jugGcndxjBdC5NVVZoJWQTBBO/XJi/1b+bBCtj0AZtKl9
 FGzwFnbuH9pCojns2G9IlfZIChvGSwuCInxQYajCdx/S4C4hwcQooD8bIsQtFPi6i8NJ0kN9CTViuE
 MI9mBvjhfiZ2xljFpTPUpnbraIynqHE6bYxUjy8D3zAeOalsVCv9NoY8Gec6SEcx+gXe8aEB9x6x/d
 p7fDpnqOG+4FFyHk83njeAm6LZvWW8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

GCS introduces a number of system registers for EL1 and EL0, on systems
with GCS we need to context switch them and expose them to VMMs to allow
guests to use GCS, as well as describe their fine grained traps to
nested virtualisation.  Traps are already disabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h          | 12 ++++++++++++
 arch/arm64/kvm/emulate-nested.c            |  4 ++++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 17 +++++++++++++++++
 arch/arm64/kvm/sys_regs.c                  | 22 ++++++++++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 21c57b812569..6c7ea7f9cd92 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -388,6 +388,12 @@ enum vcpu_sysreg {
 	GCR_EL1,	/* Tag Control Register */
 	TFSRE0_EL1,	/* Tag Fault Status Register (EL0) */
 
+	/* Guarded Control Stack registers */
+	GCSCRE0_EL1,	/* Guarded Control Stack Control (EL0) */
+	GCSCR_EL1,	/* Guarded Control Stack Control (EL1) */
+	GCSPR_EL0,	/* Guarded Control Stack Pointer (EL0) */
+	GCSPR_EL1,	/* Guarded Control Stack Pointer (EL1) */
+
 	/* 32bit specific registers. */
 	DACR32_EL2,	/* Domain Access Control Register */
 	IFSR32_EL2,	/* Instruction Fault Status Register */
@@ -1221,6 +1227,12 @@ static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
 
 #define vcpu_has_feature(v, f)	__vcpu_has_feature(&(v)->kvm->arch, (f))
 
+static inline bool has_gcs(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_GCS) &&
+		cpus_have_final_cap(ARM64_HAS_GCS);
+}
+
 int kvm_trng_call(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_KVM
 extern phys_addr_t hyp_mem_base;
diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 431fd429932d..24eb7eccbae4 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -1098,8 +1098,12 @@ static const struct encoding_to_trap_config encoding_to_fgt[] __initconst = {
 	SR_FGT(SYS_ESR_EL1, 		HFGxTR, ESR_EL1, 1),
 	SR_FGT(SYS_DCZID_EL0, 		HFGxTR, DCZID_EL0, 1),
 	SR_FGT(SYS_CTR_EL0, 		HFGxTR, CTR_EL0, 1),
+	SR_FGT(SYS_GCSPR_EL0,		HFGxTR, nGCS_EL0, 1),
 	SR_FGT(SYS_CSSELR_EL1, 		HFGxTR, CSSELR_EL1, 1),
 	SR_FGT(SYS_CPACR_EL1, 		HFGxTR, CPACR_EL1, 1),
+	SR_FGT(SYS_GCSCR_EL1,		HFGxTR, nGCS_EL1, 1),
+	SR_FGT(SYS_GCSPR_EL1,		HFGxTR, nGCS_EL1, 1),
+	SR_FGT(SYS_GCSCRE0_EL1,		HFGxTR, nGCS_EL0, 1),
 	SR_FGT(SYS_CONTEXTIDR_EL1, 	HFGxTR, CONTEXTIDR_EL1, 1),
 	SR_FGT(SYS_CLIDR_EL1, 		HFGxTR, CLIDR_EL1, 1),
 	SR_FGT(SYS_CCSIDR_EL1, 		HFGxTR, CCSIDR_EL1, 1),
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index bb6b571ec627..ec34d4a90717 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -25,6 +25,8 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
 	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
+	if (has_gcs())
+		ctxt_sys_reg(ctxt, GCSPR_EL0) = read_sysreg_s(SYS_GCSPR_EL0);
 }
 
 static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
@@ -62,6 +64,12 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 	ctxt_sys_reg(ctxt, PAR_EL1)	= read_sysreg_par();
 	ctxt_sys_reg(ctxt, TPIDR_EL1)	= read_sysreg(tpidr_el1);
 
+	if (has_gcs()) {
+		ctxt_sys_reg(ctxt, GCSPR_EL1)	= read_sysreg_el1(SYS_GCSPR);
+		ctxt_sys_reg(ctxt, GCSCR_EL1)	= read_sysreg_el1(SYS_GCSCR);
+		ctxt_sys_reg(ctxt, GCSCRE0_EL1)	= read_sysreg_s(SYS_GCSCRE0_EL1);
+	}
+
 	if (ctxt_has_mte(ctxt)) {
 		ctxt_sys_reg(ctxt, TFSR_EL1) = read_sysreg_el1(SYS_TFSR);
 		ctxt_sys_reg(ctxt, TFSRE0_EL1) = read_sysreg_s(SYS_TFSRE0_EL1);
@@ -95,6 +103,8 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL0),	tpidr_el0);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDRRO_EL0),	tpidrro_el0);
+	if (has_gcs())
+		write_sysreg_s(ctxt_sys_reg(ctxt, GCSPR_EL0), SYS_GCSPR_EL0);
 }
 
 static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
@@ -138,6 +148,13 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
 	write_sysreg(ctxt_sys_reg(ctxt, PAR_EL1),	par_el1);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL1),	tpidr_el1);
 
+	if (has_gcs()) {
+		write_sysreg_el1(ctxt_sys_reg(ctxt, GCSPR_EL1),	SYS_GCSPR);
+		write_sysreg_el1(ctxt_sys_reg(ctxt, GCSCR_EL1),	SYS_GCSCR);
+		write_sysreg_s(ctxt_sys_reg(ctxt, GCSCRE0_EL1),
+			       SYS_GCSCRE0_EL1);
+	}
+
 	if (ctxt_has_mte(ctxt)) {
 		write_sysreg_el1(ctxt_sys_reg(ctxt, TFSR_EL1), SYS_TFSR);
 		write_sysreg_s(ctxt_sys_reg(ctxt, TFSRE0_EL1), SYS_TFSRE0_EL1);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 30253bd19917..83ba767e75d2 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2000,6 +2000,23 @@ static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
 	.visibility = mte_visibility,		\
 }
 
+static unsigned int gcs_visibility(const struct kvm_vcpu *vcpu,
+				   const struct sys_reg_desc *rd)
+{
+	if (has_gcs())
+		return 0;
+
+	return REG_HIDDEN;
+}
+
+#define GCS_REG(name) {				\
+	SYS_DESC(SYS_##name),			\
+	.access = undef_access,			\
+	.reset = reset_unknown,			\
+	.reg = name,				\
+	.visibility = gcs_visibility,		\
+}
+
 static unsigned int el2_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *rd)
 {
@@ -2376,6 +2393,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	PTRAUTH_KEY(APDB),
 	PTRAUTH_KEY(APGA),
 
+	GCS_REG(GCSCR_EL1),
+	GCS_REG(GCSPR_EL1),
+	GCS_REG(GCSCRE0_EL1),
+
 	{ SYS_DESC(SYS_SPSR_EL1), access_spsr},
 	{ SYS_DESC(SYS_ELR_EL1), access_elr},
 
@@ -2462,6 +2483,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
+	GCS_REG(GCSPR_EL0),
 	{ SYS_DESC(SYS_SVCR), undef_access },
 
 	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,

-- 
2.30.2


