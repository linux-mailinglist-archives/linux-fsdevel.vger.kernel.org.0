Return-Path: <linux-fsdevel+bounces-1394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E67D07D9F76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2340C1C210CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D533C07C;
	Fri, 27 Oct 2023 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C153C061
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:09:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2451AC1;
	Fri, 27 Oct 2023 11:09:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DCB5143D;
	Fri, 27 Oct 2023 11:10:00 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B073B3F64C;
	Fri, 27 Oct 2023 11:09:16 -0700 (PDT)
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
Subject: [PATCH v2 06/24] KVM: arm64: Save/restore POE registers
Date: Fri, 27 Oct 2023 19:08:32 +0100
Message-Id: <20231027180850.1068089-7-joey.gouly@arm.com>
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

Define the new system registers that POE introduces and context switch them.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h           |  4 ++--
 arch/arm64/include/asm/kvm_host.h          |  4 ++++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 10 ++++++++++
 arch/arm64/kvm/sys_regs.c                  |  2 ++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 5882b2415596..4022e69e17fd 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -344,14 +344,14 @@
  */
 #define __HFGRTR_EL2_RES0	(GENMASK(63, 56) | GENMASK(53, 51))
 #define __HFGRTR_EL2_MASK	GENMASK(49, 0)
-#define __HFGRTR_EL2_nMASK	(GENMASK(55, 54) | BIT(50))
+#define __HFGRTR_EL2_nMASK	(GENMASK(60, 59) | GENMASK(55, 54) | BIT(50))
 
 #define __HFGWTR_EL2_RES0	(GENMASK(63, 56) | GENMASK(53, 51) |	\
 				 BIT(46) | BIT(42) | BIT(40) | BIT(28) | \
 				 GENMASK(26, 25) | BIT(21) | BIT(18) |	\
 				 GENMASK(15, 14) | GENMASK(10, 9) | BIT(2))
 #define __HFGWTR_EL2_MASK	GENMASK(49, 0)
-#define __HFGWTR_EL2_nMASK	(GENMASK(55, 54) | BIT(50))
+#define __HFGWTR_EL2_nMASK	(GENMASK(60, 59) | GENMASK(55, 54) | BIT(50))
 
 #define __HFGITR_EL2_RES0	GENMASK(63, 57)
 #define __HFGITR_EL2_MASK	GENMASK(54, 0)
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index af06ccb7ee34..205653bc5c2c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -365,6 +365,10 @@ enum vcpu_sysreg {
 	PIR_EL1,       /* Permission Indirection Register 1 (EL1) */
 	PIRE0_EL1,     /*  Permission Indirection Register 0 (EL1) */
 
+	/* Permission Overlay Extension registers */
+	POR_EL1,	/* Permission Overlay Register 1 (EL1) */
+	POR_EL0,	/* Permission Overlay Register 0 (EL0) */
+
 	/* 32bit specific registers. */
 	DACR32_EL2,	/* Domain Access Control Register */
 	IFSR32_EL2,	/* Instruction Fault Status Register */
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index bb6b571ec627..22f07ee43e7e 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -19,6 +19,9 @@
 static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, MDSCR_EL1)	= read_sysreg(mdscr_el1);
+
+	if (system_supports_poe())
+		ctxt_sys_reg(ctxt, POR_EL0)	= read_sysreg_s(SYS_POR_EL0);
 }
 
 static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
@@ -59,6 +62,8 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 		ctxt_sys_reg(ctxt, PIR_EL1)	= read_sysreg_el1(SYS_PIR);
 		ctxt_sys_reg(ctxt, PIRE0_EL1)	= read_sysreg_el1(SYS_PIRE0);
 	}
+	if (system_supports_poe())
+		ctxt_sys_reg(ctxt, POR_EL1)	= read_sysreg_el1(SYS_POR);
 	ctxt_sys_reg(ctxt, PAR_EL1)	= read_sysreg_par();
 	ctxt_sys_reg(ctxt, TPIDR_EL1)	= read_sysreg(tpidr_el1);
 
@@ -89,6 +94,9 @@ static inline void __sysreg_save_el2_return_state(struct kvm_cpu_context *ctxt)
 static inline void __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, MDSCR_EL1),  mdscr_el1);
+
+	if (system_supports_poe())
+		write_sysreg_s(ctxt_sys_reg(ctxt, POR_EL0),	SYS_POR_EL0);
 }
 
 static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
@@ -135,6 +143,8 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
 		write_sysreg_el1(ctxt_sys_reg(ctxt, PIR_EL1),	SYS_PIR);
 		write_sysreg_el1(ctxt_sys_reg(ctxt, PIRE0_EL1),	SYS_PIRE0);
 	}
+	if (system_supports_poe())
+		write_sysreg_el1(ctxt_sys_reg(ctxt, POR_EL1),	SYS_POR);
 	write_sysreg(ctxt_sys_reg(ctxt, PAR_EL1),	par_el1);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL1),	tpidr_el1);
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index e92ec810d449..7d66cc7e104c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2124,6 +2124,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_MAIR_EL1), access_vm_reg, reset_unknown, MAIR_EL1 },
 	{ SYS_DESC(SYS_PIRE0_EL1), access_vm_reg, reset_unknown, PIRE0_EL1 },
 	{ SYS_DESC(SYS_PIR_EL1), access_vm_reg, reset_unknown, PIR_EL1 },
+	{ SYS_DESC(SYS_POR_EL1), NULL, reset_unknown, POR_EL1 },
 	{ SYS_DESC(SYS_AMAIR_EL1), access_vm_reg, reset_amair_el1, AMAIR_EL1 },
 
 	{ SYS_DESC(SYS_LORSA_EL1), trap_loregion },
@@ -2203,6 +2204,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ PMU_SYS_REG(PMOVSSET_EL0),
 	  .access = access_pmovs, .reg = PMOVSSET_EL0 },
 
+	{ SYS_DESC(SYS_POR_EL0), NULL, reset_unknown, POR_EL0 },
 	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
 	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
 	{ SYS_DESC(SYS_TPIDR2_EL0), undef_access },
-- 
2.25.1


