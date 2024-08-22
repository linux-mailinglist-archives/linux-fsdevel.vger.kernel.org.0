Return-Path: <linux-fsdevel+bounces-26756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2620095B990
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D983AB2ACB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA7C1CC8A6;
	Thu, 22 Aug 2024 15:11:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877341CC880;
	Thu, 22 Aug 2024 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339512; cv=none; b=BPkofZYMOwM4e7yEYDwc1wbYmihoG5gUF/zwV/BvCT6jtqd4pdEJ+azsT366UyKxP27C6N0EqhUj1GBqqFUG85P8RGQTNCjUyoFJTEwlQuKbbZPhmpBO54KDP9O7S+ZfqIu/1S4mgX8lGbDJ8d31vt19K+aY52PUMrlfqrLBrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339512; c=relaxed/simple;
	bh=zN8QMdXs97YSwoRbIRwYTltf8KNrcE4CZ+LADX/askg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQ9iBxGqdeYprnb8CPR5qcUn7M/nC/zMqPReJMQfLu4D/yicCnpBef4wW4G5HrceJI/QlTpGEW8M4JESMXcqWTch3eijMjwbQW2IzRgBmbjstPwkc38BdoklcUgdSSoPPP7B897jDw+PwGrXgcBNOy7wQdqhjHaVgv2A1UodwT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4605B15BF;
	Thu, 22 Aug 2024 08:12:16 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 275E73F58B;
	Thu, 22 Aug 2024 08:11:46 -0700 (PDT)
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
Subject: [PATCH v5 06/30] arm64: context switch POR_EL0 register
Date: Thu, 22 Aug 2024 16:10:49 +0100
Message-Id: <20240822151113.1479789-7-joey.gouly@arm.com>
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

POR_EL0 is a register that can be modified by userspace directly,
so it must be context switched.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  6 ++++++
 arch/arm64/include/asm/processor.h  |  1 +
 arch/arm64/include/asm/sysreg.h     |  3 +++
 arch/arm64/kernel/process.c         | 28 ++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+)

diff --git arch/arm64/include/asm/cpufeature.h arch/arm64/include/asm/cpufeature.h
index 558434267271..3d261cc123c1 100644
--- arch/arm64/include/asm/cpufeature.h
+++ arch/arm64/include/asm/cpufeature.h
@@ -832,6 +832,12 @@ static inline bool system_supports_lpa2(void)
 	return cpus_have_final_cap(ARM64_HAS_LPA2);
 }
 
+static inline bool system_supports_poe(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_POE) &&
+		alternative_has_cap_unlikely(ARM64_HAS_S1POE);
+}
+
 int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
 
diff --git arch/arm64/include/asm/processor.h arch/arm64/include/asm/processor.h
index f77371232d8c..e6376f979273 100644
--- arch/arm64/include/asm/processor.h
+++ arch/arm64/include/asm/processor.h
@@ -184,6 +184,7 @@ struct thread_struct {
 	u64			sctlr_user;
 	u64			svcr;
 	u64			tpidr2_el0;
+	u64			por_el0;
 };
 
 static inline unsigned int thread_get_vl(struct thread_struct *thread,
diff --git arch/arm64/include/asm/sysreg.h arch/arm64/include/asm/sysreg.h
index 4a9ea103817e..494e9efd856f 100644
--- arch/arm64/include/asm/sysreg.h
+++ arch/arm64/include/asm/sysreg.h
@@ -1077,6 +1077,9 @@
 #define POE_RXW		UL(0x7)
 #define POE_MASK	UL(0xf)
 
+/* Initial value for Permission Overlay Extension for EL0 */
+#define POR_EL0_INIT	POE_RXW
+
 #define ARM64_FEATURE_FIELD_BITS	4
 
 /* Defined for compatibility only, do not add new users. */
diff --git arch/arm64/kernel/process.c arch/arm64/kernel/process.c
index 4ae31b7af6c3..a3a61ecdb165 100644
--- arch/arm64/kernel/process.c
+++ arch/arm64/kernel/process.c
@@ -271,12 +271,23 @@ static void flush_tagged_addr_state(void)
 		clear_thread_flag(TIF_TAGGED_ADDR);
 }
 
+static void flush_poe(void)
+{
+	if (!system_supports_poe())
+		return;
+
+	write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
+	/* ISB required for kernel uaccess routines when changing POR_EL0 */
+	isb();
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
@@ -371,6 +382,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		if (system_supports_tpidr2())
 			p->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
 
+		if (system_supports_poe())
+			p->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
+
 		if (stack_start) {
 			if (is_compat_thread(task_thread_info(p)))
 				childregs->compat_sp = stack_start;
@@ -495,6 +509,19 @@ static void erratum_1418040_new_exec(void)
 	preempt_enable();
 }
 
+static void permission_overlay_switch(struct task_struct *next)
+{
+	if (!system_supports_poe())
+		return;
+
+	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
+	if (current->thread.por_el0 != next->thread.por_el0) {
+		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
+		/* ISB required for kernel uaccess routines when chaning POR_EL0 */
+		isb();
+	}
+}
+
 /*
  * __switch_to() checks current->thread.sctlr_user as an optimisation. Therefore
  * this function must be called with preemption disabled and the update to
@@ -530,6 +557,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(next);
 	ptrauth_thread_switch_user(next);
+	permission_overlay_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
-- 
2.25.1


