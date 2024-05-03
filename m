Return-Path: <linux-fsdevel+bounces-18618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DA98BACFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 15:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23092B221DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125A915380B;
	Fri,  3 May 2024 13:02:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4E915357D
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741340; cv=none; b=QZIFP5pMSFaR6OTcLW8RMsl/P88+LkE1DjAFM+gVKljs96LxJ5MM3/DtIuy6FQuazCrPiPW0nQON/+Zj/Xa9ot+aoaISiZTZ2DYPpbWIvURvmi9/1Rl4cGCws+HZD2z6UgDBQgOUlNMcFVFzqZdH6B/rfpnRNUbpTFbjxJxnGBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741340; c=relaxed/simple;
	bh=+MyK3qKTpi+FlBWljfY1gf5QkRwhXdTu6txfvJBr0J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fv6jaXmyv5WJIXFt+Ti/Y2Bg5ZXiDZ7sZAaTbUSd/X0nJTveLwIDqAmD1A4vwlBY5k7CXPh1DmdEgonHG+SrdVm/RbzsjQaoZKLXt01+6kvsypIr0E8vq2BKl0uVKzXcx4OA2H+Tx+TnkUbYOEccclC2rfDeb4nvBZ8qLxKFlcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1EAB1655;
	Fri,  3 May 2024 06:02:43 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A036D3F73F;
	Fri,  3 May 2024 06:02:15 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
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
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: [PATCH v4 07/29] KVM: arm64: Save/restore POE registers
Date: Fri,  3 May 2024 14:01:25 +0100
Message-Id: <20240503130147.1154804-8-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240503130147.1154804-1-joey.gouly@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
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
---
 arch/arm64/include/asm/kvm_host.h          |  4 +++
 arch/arm64/include/asm/vncr_mapping.h      |  1 +
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 29 ++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c                  |  8 ++++--
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 9e8a496fb284..28042da0befd 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -419,6 +419,8 @@ enum vcpu_sysreg {
 	GCR_EL1,	/* Tag Control Register */
 	TFSRE0_EL1,	/* Tag Fault Status Register (EL0) */
 
+	POR_EL0,	/* Permission Overlay Register 0 (EL0) */
+
 	/* 32bit specific registers. */
 	DACR32_EL2,	/* Domain Access Control Register */
 	IFSR32_EL2,	/* Instruction Fault Status Register */
@@ -489,6 +491,8 @@ enum vcpu_sysreg {
 	VNCR(PIR_EL1),	 /* Permission Indirection Register 1 (EL1) */
 	VNCR(PIRE0_EL1), /*  Permission Indirection Register 0 (EL1) */
 
+	VNCR(POR_EL1),	/* Permission Overlay Register 1 (EL1) */
+
 	VNCR(HFGRTR_EL2),
 	VNCR(HFGWTR_EL2),
 	VNCR(HFGITR_EL2),
diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
index df2c47c55972..06f8ec0906a6 100644
--- a/arch/arm64/include/asm/vncr_mapping.h
+++ b/arch/arm64/include/asm/vncr_mapping.h
@@ -52,6 +52,7 @@
 #define VNCR_PIRE0_EL1		0x290
 #define VNCR_PIRE0_EL2		0x298
 #define VNCR_PIR_EL1		0x2A0
+#define VNCR_POR_EL1		0x2A8
 #define VNCR_ICH_LR0_EL2        0x400
 #define VNCR_ICH_LR1_EL2        0x408
 #define VNCR_ICH_LR2_EL2        0x410
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 4be6a7fa0070..1c9536557bae 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
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
@@ -55,6 +61,17 @@ static inline bool ctxt_has_s1pie(struct kvm_cpu_context *ctxt)
 	return kvm_has_feat(kern_hyp_va(vcpu->kvm), ID_AA64MMFR3_EL1, S1PIE, IMP);
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
@@ -77,6 +94,10 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 		ctxt_sys_reg(ctxt, PIR_EL1)	= read_sysreg_el1(SYS_PIR);
 		ctxt_sys_reg(ctxt, PIRE0_EL1)	= read_sysreg_el1(SYS_PIRE0);
 	}
+
+	if (ctxt_has_s1poe(ctxt))
+		ctxt_sys_reg(ctxt, POR_EL1)	= read_sysreg_el1(SYS_POR);
+
 	ctxt_sys_reg(ctxt, PAR_EL1)	= read_sysreg_par();
 	ctxt_sys_reg(ctxt, TPIDR_EL1)	= read_sysreg(tpidr_el1);
 
@@ -107,6 +128,10 @@ static inline void __sysreg_save_el2_return_state(struct kvm_cpu_context *ctxt)
 static inline void __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, MDSCR_EL1),  mdscr_el1);
+
+	// POR_EL0 can affect uaccess, so must be saved/restored early.
+	if (ctxt_has_s1poe(ctxt))
+		write_sysreg_s(ctxt_sys_reg(ctxt, POR_EL0),	SYS_POR_EL0);
 }
 
 static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
@@ -153,6 +178,10 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
 		write_sysreg_el1(ctxt_sys_reg(ctxt, PIR_EL1),	SYS_PIR);
 		write_sysreg_el1(ctxt_sys_reg(ctxt, PIRE0_EL1),	SYS_PIRE0);
 	}
+
+	if (ctxt_has_s1poe(ctxt))
+		write_sysreg_el1(ctxt_sys_reg(ctxt, POR_EL1),	SYS_POR);
+
 	write_sysreg(ctxt_sys_reg(ctxt, PAR_EL1),	par_el1);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL1),	tpidr_el1);
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c9f4f387155f..be04fae35afb 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2423,6 +2423,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_MAIR_EL1), access_vm_reg, reset_unknown, MAIR_EL1 },
 	{ SYS_DESC(SYS_PIRE0_EL1), NULL, reset_unknown, PIRE0_EL1 },
 	{ SYS_DESC(SYS_PIR_EL1), NULL, reset_unknown, PIR_EL1 },
+	{ SYS_DESC(SYS_POR_EL1), NULL, reset_unknown, POR_EL1 },
 	{ SYS_DESC(SYS_AMAIR_EL1), access_vm_reg, reset_amair_el1, AMAIR_EL1 },
 
 	{ SYS_DESC(SYS_LORSA_EL1), trap_loregion },
@@ -2506,6 +2507,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  .access = access_pmovs, .reg = PMOVSSET_EL0,
 	  .get_user = get_pmreg, .set_user = set_pmreg },
 
+	{ SYS_DESC(SYS_POR_EL0), NULL, reset_unknown, POR_EL0 },
 	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
 	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
 	{ SYS_DESC(SYS_TPIDR2_EL0), undef_access },
@@ -4057,8 +4059,6 @@ void kvm_init_sysreg(struct kvm_vcpu *vcpu)
 	kvm->arch.fgu[HFGxTR_GROUP] = (HFGxTR_EL2_nAMAIR2_EL1		|
 				       HFGxTR_EL2_nMAIR2_EL1		|
 				       HFGxTR_EL2_nS2POR_EL1		|
-				       HFGxTR_EL2_nPOR_EL1		|
-				       HFGxTR_EL2_nPOR_EL0		|
 				       HFGxTR_EL2_nACCDATA_EL1		|
 				       HFGxTR_EL2_nSMPRI_EL1_MASK	|
 				       HFGxTR_EL2_nTPIDR2_EL0_MASK);
@@ -4093,6 +4093,10 @@ void kvm_init_sysreg(struct kvm_vcpu *vcpu)
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


