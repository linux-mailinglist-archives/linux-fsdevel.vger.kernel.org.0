Return-Path: <linux-fsdevel+bounces-3696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438607F7926
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F23281472
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4362D364A1;
	Fri, 24 Nov 2023 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 597181FE1;
	Fri, 24 Nov 2023 08:35:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D8C81BD0;
	Fri, 24 Nov 2023 08:36:21 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE04C3F73F;
	Fri, 24 Nov 2023 08:35:32 -0800 (PST)
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
Subject: [PATCH v3 05/25] arm64: context switch POR_EL0 register
Date: Fri, 24 Nov 2023 16:34:50 +0000
Message-Id: <20231124163510.1835740-6-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124163510.1835740-1-joey.gouly@arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

POR_EL0 is a register that can be modified by userspace directly,
so it must be context switched.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  6 ++++++
 arch/arm64/include/asm/processor.h  |  1 +
 arch/arm64/include/asm/sysreg.h     |  3 +++
 arch/arm64/kernel/process.c         | 22 ++++++++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f6d416fe49b0..6870e4d46334 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -819,6 +819,12 @@ static inline bool system_supports_tlb_range(void)
 	return alternative_has_cap_unlikely(ARM64_HAS_TLB_RANGE);
 }
 
+static inline bool system_supports_poe(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_POE) &&
+		alternative_has_cap_unlikely(ARM64_HAS_S1POE);
+}
+
 int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index e5bc54522e71..b3ad719c2d0c 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -179,6 +179,7 @@ struct thread_struct {
 	u64			sctlr_user;
 	u64			svcr;
 	u64			tpidr2_el0;
+	u64			por_el0;
 };
 
 static inline unsigned int thread_get_vl(struct thread_struct *thread,
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9c2caf0efdc7..77a4797d0d54 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1052,6 +1052,9 @@
 #define POE_RXW		UL(0x7)
 #define POE_MASK	UL(0xf)
 
+/* Initial value for Permission Overlay Extension for EL0 */
+#define POR_EL0_INIT	POE_RXW
+
 #define ARM64_FEATURE_FIELD_BITS	4
 
 /* Defined for compatibility only, do not add new users. */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 7387b68c745b..fc899c12d759 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -271,12 +271,19 @@ static void flush_tagged_addr_state(void)
 		clear_thread_flag(TIF_TAGGED_ADDR);
 }
 
+static void flush_poe(void)
+{
+	if (system_supports_poe())
+		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
+}
+
 void flush_thread(void)
 {
 	fpsimd_flush_thread();
 	tls_thread_flush();
 	flush_ptrace_hw_breakpoint(current);
 	flush_tagged_addr_state();
+	flush_poe();
 }
 
 void arch_release_task_struct(struct task_struct *tsk)
@@ -374,6 +381,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		if (system_supports_tpidr2())
 			p->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
 
+		if (system_supports_poe())
+			p->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
+
 		if (stack_start) {
 			if (is_compat_thread(task_thread_info(p)))
 				childregs->compat_sp = stack_start;
@@ -498,6 +508,17 @@ static void erratum_1418040_new_exec(void)
 	preempt_enable();
 }
 
+static void permission_overlay_switch(struct task_struct *next)
+{
+	if (system_supports_poe()) {
+		current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
+		if (current->thread.por_el0 != next->thread.por_el0) {
+			write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
+			isb();
+		}
+	}
+}
+
 /*
  * __switch_to() checks current->thread.sctlr_user as an optimisation. Therefore
  * this function must be called with preemption disabled and the update to
@@ -533,6 +554,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(next);
 	ptrauth_thread_switch_user(next);
+	permission_overlay_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
-- 
2.25.1


