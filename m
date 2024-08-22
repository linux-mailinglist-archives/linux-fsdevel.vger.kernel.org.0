Return-Path: <linux-fsdevel+bounces-26757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A27A95B976
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D61285718
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9E81CC8B0;
	Thu, 22 Aug 2024 15:11:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166D71CC892;
	Thu, 22 Aug 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339516; cv=none; b=WIHx06YnuaHR546JcOqRS6NxPvNsWeceiN+Eu3yb8X1kgNNn/I37mClvQiSB2WIlslO4XactjuJiOFz2xN5mc93c8pW8RHR6phJ072T1mpJDRhBYiXhnLwO+gNeuSZBanbQXi6qSTy6N4ww5m4mD+5nTjz85rYuLXb2pA/3N08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339516; c=relaxed/simple;
	bh=gf5tLIIEvDkVhHwDy5vN719lR9Hhu711YIGz7dd2Rmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ARsfBXmSfBZpeKuQvEef8SzcWkuIceD1Y0SrnljslG7hOn/xpfX+UMhN4J5W+q5AXDaNV1g46sQ5hXpxYyVPJFzW4kjorlgcS4e3UHHLORZotvNJ2y+yarVKEZe3CPPu/Fro34egN/7SJSboIe9EfFw+4rkDgZe6jWrHHwTmQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 955EA15DB;
	Thu, 22 Aug 2024 08:12:20 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76AB93F58B;
	Thu, 22 Aug 2024 08:11:50 -0700 (PDT)
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
Subject: [PATCH v5 07/30] KVM: arm64: Save/restore POE registers
Date: Thu, 22 Aug 2024 16:10:50 +0100
Message-Id: <20240822151113.1479789-8-joey.gouly@arm.com>
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

Define the new system registers that POE introduces and context switch them.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h          |  4 ++++
 arch/arm64/include/asm/vncr_mapping.h      |  1 +
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 27 ++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c                  | 19 +++++++++++++--
 4 files changed, 49 insertions(+), 2 deletions(-)

diff --git arch/arm64/include/asm/kvm_host.h arch/arm64/include/asm/kvm_host.h
index a33f5996ca9f..5c9de7692201 100644
--- arch/arm64/include/asm/kvm_host.h
+++ arch/arm64/include/asm/kvm_host.h
@@ -446,6 +446,8 @@ enum vcpu_sysreg {
 	GCR_EL1,	/* Tag Control Register */
 	TFSRE0_EL1,	/* Tag Fault Status Register (EL0) */
 
+	POR_EL0,	/* Permission Overlay Register 0 (EL0) */
+
 	/* 32bit specific registers. */
 	DACR32_EL2,	/* Domain Access Control Register */
 	IFSR32_EL2,	/* Instruction Fault Status Register */
@@ -517,6 +519,8 @@ enum vcpu_sysreg {
 	VNCR(PIR_EL1),	 /* Permission Indirection Register 1 (EL1) */
 	VNCR(PIRE0_EL1), /*  Permission Indirection Register 0 (EL1) */
 
+	VNCR(POR_EL1),	/* Permission Overlay Register 1 (EL1) */
+
 	VNCR(HFGRTR_EL2),
 	VNCR(HFGWTR_EL2),
 	VNCR(HFGITR_EL2),
diff --git arch/arm64/include/asm/vncr_mapping.h arch/arm64/include/asm/vncr_mapping.h
index df2c47c55972..06f8ec0906a6 100644
--- arch/arm64/include/asm/vncr_mapping.h
+++ arch/arm64/include/asm/vncr_mapping.h
@@ -52,6 +52,7 @@
 #define VNCR_PIRE0_EL1		0x290
 #define VNCR_PIRE0_EL2		0x298
 #define VNCR_PIR_EL1		0x2A0
+#define VNCR_POR_EL1		0x2A8
 #define VNCR_ICH_LR0_EL2        0x400
 #define VNCR_ICH_LR1_EL2        0x408
 #define VNCR_ICH_LR2_EL2        0x410
diff --git arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 4c0fdabaf8ae..1579a3c08a36 100644
--- arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -16,9 +16,15 @@
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 
+static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt);
+
 static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, MDSCR_EL1)	= read_sysreg(mdscr_el1);
+
+	// POR_EL0 can affect uaccess, so must be saved/restored early.
+	if (ctxt_has_s1poe(ctxt))
+		ctxt_sys_reg(ctxt, POR_EL0)	= read_sysreg_s(SYS_POR_EL0);
 }
 
 static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
@@ -66,6 +72,17 @@ static inline bool ctxt_has_tcrx(struct kvm_cpu_context *ctxt)
 	return kvm_has_feat(kern_hyp_va(vcpu->kvm), ID_AA64MMFR3_EL1, TCRX, IMP);
 }
 
+static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt)
+{
+	struct kvm_vcpu *vcpu;
+
+	if (!system_supports_poe())
+		return false;
+
+	vcpu = ctxt_to_vcpu(ctxt);
+	return kvm_has_feat(kern_hyp_va(vcpu->kvm), ID_AA64MMFR3_EL1, S1POE, IMP);
+}
+
 static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, SCTLR_EL1)	= read_sysreg_el1(SYS_SCTLR);
@@ -80,6 +97,9 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 			ctxt_sys_reg(ctxt, PIR_EL1)	= read_sysreg_el1(SYS_PIR);
 			ctxt_sys_reg(ctxt, PIRE0_EL1)	= read_sysreg_el1(SYS_PIRE0);
 		}
+
+		if (ctxt_has_s1poe(ctxt))
+			ctxt_sys_reg(ctxt, POR_EL1)	= read_sysreg_el1(SYS_POR);
 	}
 	ctxt_sys_reg(ctxt, ESR_EL1)	= read_sysreg_el1(SYS_ESR);
 	ctxt_sys_reg(ctxt, AFSR0_EL1)	= read_sysreg_el1(SYS_AFSR0);
@@ -120,6 +140,10 @@ static inline void __sysreg_save_el2_return_state(struct kvm_cpu_context *ctxt)
 static inline void __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, MDSCR_EL1),  mdscr_el1);
+
+	// POR_EL0 can affect uaccess, so must be saved/restored early.
+	if (ctxt_has_s1poe(ctxt))
+		write_sysreg_s(ctxt_sys_reg(ctxt, POR_EL0),	SYS_POR_EL0);
 }
 
 static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
@@ -158,6 +182,9 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
 			write_sysreg_el1(ctxt_sys_reg(ctxt, PIR_EL1),	SYS_PIR);
 			write_sysreg_el1(ctxt_sys_reg(ctxt, PIRE0_EL1),	SYS_PIRE0);
 		}
+
+		if (ctxt_has_s1poe(ctxt))
+			write_sysreg_el1(ctxt_sys_reg(ctxt, POR_EL1),	SYS_POR);
 	}
 	write_sysreg_el1(ctxt_sys_reg(ctxt, ESR_EL1),	SYS_ESR);
 	write_sysreg_el1(ctxt_sys_reg(ctxt, AFSR0_EL1),	SYS_AFSR0);
diff --git arch/arm64/kvm/sys_regs.c arch/arm64/kvm/sys_regs.c
index c90324060436..e7208b59ea12 100644
--- arch/arm64/kvm/sys_regs.c
+++ arch/arm64/kvm/sys_regs.c
@@ -2255,6 +2255,15 @@ static bool access_zcr_el2(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static unsigned int s1poe_visibility(const struct kvm_vcpu *vcpu,
+				     const struct sys_reg_desc *rd)
+{
+	if (kvm_has_feat(vcpu->kvm, ID_AA64MMFR3_EL1, S1POE, IMP))
+		return 0;
+
+	return REG_HIDDEN;
+}
+
 /*
  * Architected system registers.
  * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
@@ -2492,6 +2501,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_MAIR_EL1), access_vm_reg, reset_unknown, MAIR_EL1 },
 	{ SYS_DESC(SYS_PIRE0_EL1), NULL, reset_unknown, PIRE0_EL1 },
 	{ SYS_DESC(SYS_PIR_EL1), NULL, reset_unknown, PIR_EL1 },
+	{ SYS_DESC(SYS_POR_EL1), NULL, reset_unknown, POR_EL1,
+	  .visibility = s1poe_visibility },
 	{ SYS_DESC(SYS_AMAIR_EL1), access_vm_reg, reset_amair_el1, AMAIR_EL1 },
 
 	{ SYS_DESC(SYS_LORSA_EL1), trap_loregion },
@@ -2578,6 +2589,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  .access = access_pmovs, .reg = PMOVSSET_EL0,
 	  .get_user = get_pmreg, .set_user = set_pmreg },
 
+	{ SYS_DESC(SYS_POR_EL0), NULL, reset_unknown, POR_EL0,
+	  .visibility = s1poe_visibility },
 	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
 	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
 	{ SYS_DESC(SYS_TPIDR2_EL0), undef_access },
@@ -4568,8 +4581,6 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
 	kvm->arch.fgu[HFGxTR_GROUP] = (HFGxTR_EL2_nAMAIR2_EL1		|
 				       HFGxTR_EL2_nMAIR2_EL1		|
 				       HFGxTR_EL2_nS2POR_EL1		|
-				       HFGxTR_EL2_nPOR_EL1		|
-				       HFGxTR_EL2_nPOR_EL0		|
 				       HFGxTR_EL2_nACCDATA_EL1		|
 				       HFGxTR_EL2_nSMPRI_EL1_MASK	|
 				       HFGxTR_EL2_nTPIDR2_EL0_MASK);
@@ -4604,6 +4615,10 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
 		kvm->arch.fgu[HFGxTR_GROUP] |= (HFGxTR_EL2_nPIRE0_EL1 |
 						HFGxTR_EL2_nPIR_EL1);
 
+	if (!kvm_has_feat(kvm, ID_AA64MMFR3_EL1, S1POE, IMP))
+		kvm->arch.fgu[HFGxTR_GROUP] |= (HFGxTR_EL2_nPOR_EL1 |
+						HFGxTR_EL2_nPOR_EL0);
+
 	if (!kvm_has_feat(kvm, ID_AA64PFR0_EL1, AMU, IMP))
 		kvm->arch.fgu[HAFGRTR_GROUP] |= ~(HAFGRTR_EL2_RES0 |
 						  HAFGRTR_EL2_RES1);
-- 
2.25.1


