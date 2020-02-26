Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A46170379
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 16:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgBZP5b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 10:57:31 -0500
Received: from foss.arm.com ([217.140.110.172]:37992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728726AbgBZP53 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:57:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6699106F;
        Wed, 26 Feb 2020 07:57:28 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAECF3F819;
        Wed, 26 Feb 2020 07:57:27 -0800 (PST)
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v7 03/11] arm64: Basic Branch Target Identification support
Date:   Wed, 26 Feb 2020 15:57:06 +0000
Message-Id: <20200226155714.43937-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226155714.43937-1-broonie@kernel.org>
References: <20200226155714.43937-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Martin <Dave.Martin@arm.com>

This patch adds the bare minimum required to expose the ARMv8.5
Branch Target Identification feature to userspace.

By itself, this does _not_ automatically enable BTI for any initial
executable pages mapped by execve().  This will come later, but for
now it should be possible to enable BTI manually on those pages by
using mprotect() from within the target process.

Other arches already using the generic mman.h are already using
0x10 for arch-specific prot flags, so we use that for PROT_BTI
here.

For consistency, signal handler entry points in BTI guarded pages
are required to be annotated as such, just like any other function.
This blocks a relatively minor attack vector, but comforming
userspace will have the annotations anyway, so we may as well
enforce them.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/arm64/cpu-feature-registers.rst |  2 +
 Documentation/arm64/elf_hwcaps.rst            |  5 +++
 arch/arm64/Kconfig                            | 22 +++++++++++
 arch/arm64/include/asm/cpucaps.h              |  3 +-
 arch/arm64/include/asm/cpufeature.h           |  6 +++
 arch/arm64/include/asm/esr.h                  |  2 +-
 arch/arm64/include/asm/exception.h            |  1 +
 arch/arm64/include/asm/hwcap.h                |  1 +
 arch/arm64/include/asm/mman.h                 | 37 +++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h        |  1 +
 arch/arm64/include/asm/pgtable.h              |  2 +-
 arch/arm64/include/asm/ptrace.h               |  1 +
 arch/arm64/include/asm/sysreg.h               |  4 ++
 arch/arm64/include/uapi/asm/hwcap.h           |  1 +
 arch/arm64/include/uapi/asm/mman.h            |  9 +++++
 arch/arm64/include/uapi/asm/ptrace.h          |  9 +++++
 arch/arm64/kernel/cpufeature.c                | 33 +++++++++++++++++
 arch/arm64/kernel/cpuinfo.c                   |  1 +
 arch/arm64/kernel/entry-common.c              | 11 ++++++
 arch/arm64/kernel/ptrace.c                    |  2 +-
 arch/arm64/kernel/signal.c                    | 16 ++++++++
 arch/arm64/kernel/syscall.c                   | 18 +++++++++
 arch/arm64/kernel/traps.c                     |  8 ++++
 include/linux/mm.h                            |  3 ++
 24 files changed, 194 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/include/asm/mman.h
 create mode 100644 arch/arm64/include/uapi/asm/mman.h

diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
index 41937a8091aa..314fa5bc2655 100644
--- a/Documentation/arm64/cpu-feature-registers.rst
+++ b/Documentation/arm64/cpu-feature-registers.rst
@@ -176,6 +176,8 @@ infrastructure:
      +------------------------------+---------+---------+
      | SSBS                         | [7-4]   |    y    |
      +------------------------------+---------+---------+
+     | BT                           | [3-0]   |    y    |
+     +------------------------------+---------+---------+
 
 
   4) MIDR_EL1 - Main ID Register
diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index 7dfb97dfe416..84a9fd2d41b4 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -236,6 +236,11 @@ HWCAP2_RNG
 
     Functionality implied by ID_AA64ISAR0_EL1.RNDR == 0b0001.
 
+HWCAP2_BTI
+
+    Functionality implied by ID_AA64PFR0_EL1.BT == 0b0001.
+
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0b30e884e088..e37f4f07b990 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1519,6 +1519,28 @@ endmenu
 
 menu "ARMv8.5 architectural features"
 
+config ARM64_BTI
+	bool "Branch Target Identification support"
+	default y
+	help
+	  Branch Target Identification (part of the ARMv8.5 Extensions)
+	  provides a mechanism to limit the set of locations to which computed
+	  branch instructions such as BR or BLR can jump.
+
+	  To make use of BTI on CPUs that support it, say Y.
+
+	  BTI is intended to provide complementary protection to other control
+	  flow integrity protection mechanisms, such as the Pointer
+	  authentication mechanism provided as part of the ARMv8.3 Extensions.
+	  For this reason, it does not make sense to enable this option without
+	  also enabling support for pointer authentication.  Thus, when
+	  enabling this option you should also select ARM64_PTR_AUTH=y.
+
+	  Userspace binaries must also be specifically compiled to make use of
+	  this mechanism.  If you say N here or the hardware does not support
+	  BTI, such binaries can still run, but you get no additional
+	  enforcement of branch destinations.
+
 config ARM64_E0PD
 	bool "Enable support for E0PD"
 	default y
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 865e0253fc1e..58e776c22aab 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -58,7 +58,8 @@
 #define ARM64_WORKAROUND_SPECULATIVE_AT_NVHE	48
 #define ARM64_HAS_E0PD				49
 #define ARM64_HAS_RNG				50
+#define ARM64_BTI				51
 
-#define ARM64_NCAPS				51
+#define ARM64_NCAPS				52
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 92ef9539874a..e3ebcc59e83b 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -613,6 +613,12 @@ static inline bool system_has_prio_mask_debugging(void)
 	       system_uses_irq_prio_masking();
 }
 
+static inline bool system_supports_bti(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_BTI) &&
+		cpus_have_const_cap(ARM64_BTI);
+}
+
 static inline bool system_capabilities_finalized(void)
 {
 	return static_branch_likely(&arm64_const_caps_ready);
diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index cb29253ae86b..390b8ba67830 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -22,7 +22,7 @@
 #define ESR_ELx_EC_PAC		(0x09)	/* EL2 and above */
 /* Unallocated EC: 0x0A - 0x0B */
 #define ESR_ELx_EC_CP14_64	(0x0C)
-/* Unallocated EC: 0x0d */
+#define ESR_ELx_EC_BTI		(0x0D)
 #define ESR_ELx_EC_ILL		(0x0E)
 /* Unallocated EC: 0x0F - 0x10 */
 #define ESR_ELx_EC_SVC32	(0x11)
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 7a6e81ca23a8..7577a754d443 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -34,6 +34,7 @@ static inline u32 disr_to_esr(u64 disr)
 asmlinkage void enter_from_user_mode(void);
 void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
 void do_undefinstr(struct pt_regs *regs);
+void do_bti(struct pt_regs *regs);
 asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr);
 void do_debug_exception(unsigned long addr_if_watchpoint, unsigned int esr,
 			struct pt_regs *regs);
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 0f00265248b5..d683bcbf1e7c 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -94,6 +94,7 @@
 #define KERNEL_HWCAP_BF16		__khwcap2_feature(BF16)
 #define KERNEL_HWCAP_DGH		__khwcap2_feature(DGH)
 #define KERNEL_HWCAP_RNG		__khwcap2_feature(RNG)
+#define KERNEL_HWCAP_BTI		__khwcap2_feature(BTI)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
new file mode 100644
index 000000000000..081ec8de9ea6
--- /dev/null
+++ b/arch/arm64/include/asm/mman.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <uapi/asm/mman.h>
+
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+	unsigned long pkey __always_unused)
+{
+	if (system_supports_bti() && (prot & PROT_BTI))
+		return VM_ARM64_BTI;
+
+	return 0;
+}
+#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
+
+static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
+{
+	return (vm_flags & VM_ARM64_BTI) ? __pgprot(PTE_GP) : __pgprot(0);
+}
+#define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
+
+static inline bool arch_validate_prot(unsigned long prot,
+	unsigned long addr __always_unused)
+{
+	unsigned long supported = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM;
+
+	if (system_supports_bti())
+		supported |= PROT_BTI;
+
+	return (prot & ~supported) == 0;
+}
+#define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)
+
+#endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 6bf5e650da78..167f1d1d48aa 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -151,6 +151,7 @@
 #define PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
 #define PTE_AF			(_AT(pteval_t, 1) << 10)	/* Access Flag */
 #define PTE_NG			(_AT(pteval_t, 1) << 11)	/* nG */
+#define PTE_GP			(_AT(pteval_t, 1) << 50)	/* BTI guarded */
 #define PTE_DBM			(_AT(pteval_t, 1) << 51)	/* Dirty Bit Management */
 #define PTE_CONT		(_AT(pteval_t, 1) << 52)	/* Contiguous range */
 #define PTE_PXN			(_AT(pteval_t, 1) << 53)	/* Privileged XN */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 538c85e62f86..4fbf516d8cb2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -660,7 +660,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
-			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE;
+			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP;
 	/* preserve the hardware dirty information */
 	if (pte_hw_dirty(pte))
 		pte = pte_mkdirty(pte);
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index bf57308fcd63..2172ec7594ba 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -35,6 +35,7 @@
 #define GIC_PRIO_PSR_I_SET		(1 << 4)
 
 /* Additional SPSR bits not exposed in the UABI */
+
 #define PSR_IL_BIT		(1 << 20)
 
 /* AArch32-specific ptrace requests */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index b91570ff9db1..db08ceb4cc9a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -514,6 +514,8 @@
 #endif
 
 /* SCTLR_EL1 specific flags. */
+#define SCTLR_EL1_BT1		(BIT(36))
+#define SCTLR_EL1_BT0		(BIT(35))
 #define SCTLR_EL1_UCI		(BIT(26))
 #define SCTLR_EL1_E0E		(BIT(24))
 #define SCTLR_EL1_SPAN		(BIT(23))
@@ -620,10 +622,12 @@
 
 /* id_aa64pfr1 */
 #define ID_AA64PFR1_SSBS_SHIFT		4
+#define ID_AA64PFR1_BT_SHIFT		0
 
 #define ID_AA64PFR1_SSBS_PSTATE_NI	0
 #define ID_AA64PFR1_SSBS_PSTATE_ONLY	1
 #define ID_AA64PFR1_SSBS_PSTATE_INSNS	2
+#define ID_AA64PFR1_BT_BTI		0x1
 
 /* id_aa64zfr0 */
 #define ID_AA64ZFR0_F64MM_SHIFT		56
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 7752d93bb50f..2d6ba1c2592e 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -73,5 +73,6 @@
 #define HWCAP2_BF16		(1 << 14)
 #define HWCAP2_DGH		(1 << 15)
 #define HWCAP2_RNG		(1 << 16)
+#define HWCAP2_BTI		(1 << 17)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/include/uapi/asm/mman.h b/arch/arm64/include/uapi/asm/mman.h
new file mode 100644
index 000000000000..6fdd71eb644f
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/mman.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__ASM_MMAN_H
+#define _UAPI__ASM_MMAN_H
+
+#include <asm-generic/mman.h>
+
+#define PROT_BTI	0x10		/* BTI guarded page */
+
+#endif /* ! _UAPI__ASM_MMAN_H */
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index d1bb5b69f1ce..42cbe34d95ce 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -46,6 +46,7 @@
 #define PSR_I_BIT	0x00000080
 #define PSR_A_BIT	0x00000100
 #define PSR_D_BIT	0x00000200
+#define PSR_BTYPE_MASK	0x00000c00
 #define PSR_SSBS_BIT	0x00001000
 #define PSR_PAN_BIT	0x00400000
 #define PSR_UAO_BIT	0x00800000
@@ -55,6 +56,8 @@
 #define PSR_Z_BIT	0x40000000
 #define PSR_N_BIT	0x80000000
 
+#define PSR_BTYPE_SHIFT		10
+
 /*
  * Groups of PSR bits
  */
@@ -63,6 +66,12 @@
 #define PSR_x		0x0000ff00	/* Extension		*/
 #define PSR_c		0x000000ff	/* Control		*/
 
+/* Convenience names for the values of PSTATE.BTYPE */
+#define PSR_BTYPE_NONE		(0b00 << PSR_BTYPE_SHIFT)
+#define PSR_BTYPE_JC		(0b01 << PSR_BTYPE_SHIFT)
+#define PSR_BTYPE_C		(0b10 << PSR_BTYPE_SHIFT)
+#define PSR_BTYPE_J		(0b11 << PSR_BTYPE_SHIFT)
+
 /* syscall emulation path in ptrace */
 #define PTRACE_SYSEMU		  31
 #define PTRACE_SYSEMU_SINGLESTEP  32
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0b6715625cf6..e6d31776e49b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -179,6 +179,8 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SSBS_SHIFT, 4, ID_AA64PFR1_SSBS_PSTATE_NI),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_BTI),
+				    FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_BT_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -1347,6 +1349,21 @@ static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
 }
 #endif
 
+#ifdef CONFIG_ARM64_BTI
+static void bti_enable(const struct arm64_cpu_capabilities *__unused)
+{
+	/*
+	 * Use of X16/X17 for tail-calls and trampolines that jump to
+	 * function entry points using BR is a requirement for
+	 * marking binaries with GNU_PROPERTY_AARCH64_FEATURE_1_BTI.
+	 * So, be strict and forbid other BRs using other registers to
+	 * jump onto a PACIxSP instruction:
+	 */
+	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_BT0 | SCTLR_EL1_BT1);
+	isb();
+}
+#endif /* CONFIG_ARM64_BTI */
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -1671,6 +1688,19 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
 	},
+#endif
+#ifdef CONFIG_ARM64_BTI
+	{
+		.desc = "Branch Target Identification",
+		.capability = ARM64_BTI,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_cpuid_feature,
+		.cpu_enable = bti_enable,
+		.sys_reg = SYS_ID_AA64PFR1_EL1,
+		.field_pos = ID_AA64PFR1_BT_SHIFT,
+		.min_field_value = ID_AA64PFR1_BT_BTI,
+		.sign = FTR_UNSIGNED,
+	},
 #endif
 	{},
 };
@@ -1781,6 +1811,9 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_F64MM_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_F64MM, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
 #endif
 	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_SSBS_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_SSBS_PSTATE_INSNS, CAP_HWCAP, KERNEL_HWCAP_SSBS),
+#ifdef CONFIG_ARM64_BTI
+	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_BT_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_BT_BTI, CAP_HWCAP, KERNEL_HWCAP_BTI),
+#endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	HWCAP_MULTI_CAP(ptr_auth_hwcap_addr_matches, CAP_HWCAP, KERNEL_HWCAP_PACA),
 	HWCAP_MULTI_CAP(ptr_auth_hwcap_gen_matches, CAP_HWCAP, KERNEL_HWCAP_PACG),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 86136075ae41..5e47e93b5dc1 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -92,6 +92,7 @@ static const char *const hwcap_str[] = {
 	"bf16",
 	"dgh",
 	"rng",
+	"bti",
 	NULL
 };
 
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index fde59981445c..55ec0627f5a7 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -188,6 +188,14 @@ static void notrace el0_undef(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(el0_undef);
 
+static void notrace el0_bti(struct pt_regs *regs)
+{
+	user_exit_irqoff();
+	local_daif_restore(DAIF_PROCCTX);
+	do_bti(regs);
+}
+NOKPROBE_SYMBOL(el0_bti);
+
 static void notrace el0_inv(struct pt_regs *regs, unsigned long esr)
 {
 	user_exit_irqoff();
@@ -255,6 +263,9 @@ asmlinkage void notrace el0_sync_handler(struct pt_regs *regs)
 	case ESR_ELx_EC_UNKNOWN:
 		el0_undef(regs);
 		break;
+	case ESR_ELx_EC_BTI:
+		el0_bti(regs);
+		break;
 	case ESR_ELx_EC_BREAKPT_LOW:
 	case ESR_ELx_EC_SOFTSTP_LOW:
 	case ESR_ELx_EC_WATCHPT_LOW:
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index cd6e5fa48b9c..fd8ac7cf68e7 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1874,7 +1874,7 @@ void syscall_trace_exit(struct pt_regs *regs)
  */
 #define SPSR_EL1_AARCH64_RES0_BITS \
 	(GENMASK_ULL(63, 32) | GENMASK_ULL(27, 25) | GENMASK_ULL(23, 22) | \
-	 GENMASK_ULL(20, 13) | GENMASK_ULL(11, 10) | GENMASK_ULL(5, 5))
+	 GENMASK_ULL(20, 13) | GENMASK_ULL(5, 5))
 #define SPSR_EL1_AARCH32_RES0_BITS \
 	(GENMASK_ULL(63, 32) | GENMASK_ULL(22, 22) | GENMASK_ULL(20, 20))
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 339882db5a91..801d56cdf701 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -732,6 +732,22 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	regs->regs[29] = (unsigned long)&user->next_frame->fp;
 	regs->pc = (unsigned long)ka->sa.sa_handler;
 
+	/*
+	 * Signal delivery is a (wacky) indirect function call in
+	 * userspace, so simulate the same setting of BTYPE as a BLR
+	 * <register containing the signal handler entry point>.
+	 * Signal delivery to a location in a PROT_BTI guarded page
+	 * that is not a function entry point will now trigger a
+	 * SIGILL in userspace.
+	 *
+	 * If the signal handler entry point is not in a PROT_BTI
+	 * guarded page, this is harmless.
+	 */
+	if (system_supports_bti()) {
+		regs->pstate &= ~PSR_BTYPE_MASK;
+		regs->pstate |= PSR_BTYPE_C;
+	}
+
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
 	else
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index a12c0c88d345..5f5b868292f5 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -98,6 +98,24 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	regs->orig_x0 = regs->regs[0];
 	regs->syscallno = scno;
 
+	/*
+	 * BTI note:
+	 * The architecture does not guarantee that SPSR.BTYPE is zero
+	 * on taking an SVC, so we could return to userspace with a
+	 * non-zero BTYPE after the syscall.
+	 *
+	 * This shouldn't matter except when userspace is explicitly
+	 * doing something stupid, such as setting PROT_BTI on a page
+	 * that lacks conforming BTI/PACIxSP instructions, falling
+	 * through from one executable page to another with differing
+	 * PROT_BTI, or messing with BTYPE via ptrace: in such cases,
+	 * userspace should not be surprised if a SIGILL occurs on
+	 * syscall return.
+	 *
+	 * So, don't touch regs->pstate & PSR_BTYPE_MASK here.
+	 * (Similarly for HVC and SMC elsewhere.)
+	 */
+
 	cortex_a76_erratum_1463225_svc_handler();
 	local_daif_restore(DAIF_PROCCTX);
 	user_exit();
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cf402be5c573..b8c714dda851 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -411,6 +411,13 @@ void do_undefinstr(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(do_undefinstr);
 
+void do_bti(struct pt_regs *regs)
+{
+	BUG_ON(!user_mode(regs));
+	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc);
+}
+NOKPROBE_SYMBOL(do_bti);
+
 #define __user_cache_maint(insn, address, res)			\
 	if (address >= user_addr_max()) {			\
 		res = -EFAULT;					\
@@ -753,6 +760,7 @@ static const char *esr_class_str[] = {
 	[ESR_ELx_EC_CP10_ID]		= "CP10 MRC/VMRS",
 	[ESR_ELx_EC_PAC]		= "PAC",
 	[ESR_ELx_EC_CP14_64]		= "CP14 MCRR/MRRC",
+	[ESR_ELx_EC_BTI]		= "BTI",
 	[ESR_ELx_EC_ILL]		= "PSTATE.IL",
 	[ESR_ELx_EC_SVC32]		= "SVC (AArch32)",
 	[ESR_ELx_EC_HVC32]		= "HVC (AArch32)",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..9e5fce1b2099 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -324,6 +324,9 @@ extern unsigned int kobjsize(const void *objp);
 #elif defined(CONFIG_SPARC64)
 # define VM_SPARC_ADI	VM_ARCH_1	/* Uses ADI tag for access control */
 # define VM_ARCH_CLEAR	VM_SPARC_ADI
+#elif defined(CONFIG_ARM64)
+# define VM_ARM64_BTI	VM_ARCH_1	/* BTI guarded page, a.k.a. GP bit */
+# define VM_ARCH_CLEAR	VM_ARM64_BTI
 #elif !defined(CONFIG_MMU)
 # define VM_MAPPED_COPY	VM_ARCH_1	/* T if mapped copy of data (nommu mmap) */
 #endif
-- 
2.20.1

