Return-Path: <linux-fsdevel+bounces-30594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7CA98C8F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B14B20FA0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E7D1D042F;
	Tue,  1 Oct 2024 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUx8wIEC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D41CEEB5;
	Tue,  1 Oct 2024 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823831; cv=none; b=Rm1Xx+fCQ0GZArfgeT0vSFLZdvhhlKmuYMHWQ3yYN381hdSDMtFggbQa+D6dszCuyY49HL5nbksbczQlegkYUUvZ6oeA4um3i/z2YJjrtpMi/iw6VQvlcOF3mhRYwivFYrq2QyJQhz9Aiyh10Shew/P/XlsJjzaDOg4iohhtp+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823831; c=relaxed/simple;
	bh=B+jxXTUkTSef0cvYwALMxetqKDkj+z2yhbykonxuIvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cbotcb9sgDwEGDC3ERzbQYOJvSug3UetHzddIjLwNQQxm5wsiNx4VR4qx2XC6F/Pkg9sFMFWyED01wdYD8gbnuVXyZgQaOQQwPFueYBY4v5YSqyTCuqseqipnYgpzBs/y32ymqy1HlITkNOGVAR1hMGOCEQqOiS2BEP98p4Yfx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUx8wIEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9525BC4CEC6;
	Tue,  1 Oct 2024 23:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823831;
	bh=B+jxXTUkTSef0cvYwALMxetqKDkj+z2yhbykonxuIvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HUx8wIECR9lToVgEuuRmL1LTcof2SadUqhIeeq87HK6Vh5V0HYCpD8XsImAgHM0+i
	 t9MgwEkfFPeiUZrwIsl1rbxozChdiha+NTSyAa1S7yVv7u6cfe+F5QUsqLXI7DHTOH
	 px22G4UkMeFRmJidB5PidQ7keLIJUIo/fue980rAKoStkksx0adimrxQVGaZpjzIOk
	 qm0jRfMf3bI1fSa9ha3mn9r6pDP84uJzOaF2uEuMJ0I72tNBqhhgMzrm6m/EqHGi+B
	 kUtOj7EaSX2hkutQLSZ3Ozf5B0Y83qSLL/ev1DtwcbqyiH4Dfsjk+WQQXjCKMF1iPO
	 k2Z0V5P25+TqA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:59:00 +0100
Subject: [PATCH v13 21/40] arm64/gcs: Context switch GCS state for EL0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-21-222b78d87eee@kernel.org>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
In-Reply-To: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, David Spickett <david.spickett@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=7335; i=broonie@kernel.org;
 h=from:subject:message-id; bh=B+jxXTUkTSef0cvYwALMxetqKDkj+z2yhbykonxuIvw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7UABcgRepLC8/BSr/31M9cejBZhSyBGfKixQ4S
 CY8NnOqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+1AAKCRAk1otyXVSH0C3MB/
 9LkMlFMmSzQNqWzPn4u2mp4miFf2NFWEYmSg15LjV8XbEQl6b8hH0BEHWBfNCxBQOtDj/yW/9fkL4/
 1GS6g9GYcoXPS8j4UBZVxHhFOS5d1nATMSVL4vmF2wVD7HeHxcLbLnU+jnfoyM58HBHLRhiwcyyXrO
 CKZTtB1PWAIwtA8YMiTSPURfF/u+ngYFysvvoizBewFLIIg08trjdUoSjHZ2yefmXcif6Z4UMao5fh
 Jt+OQEWq6p/cgvHM4d/H2L95mmxDgM/w61k+s/R/bP91pdTY2mFnsYL/21j/lZPLw7LykOnCK5mHn6
 numrEQSMpJt8eRfpLOQwyzWjsIyudp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There are two registers controlling the GCS state of EL0, GCSPR_EL0 which
is the current GCS pointer and GCSCRE0_EL1 which has enable bits for the
specific GCS functionality enabled for EL0. Manage these on context switch
and process lifetime events, GCS is reset on exec().  Also ensure that
any changes to the GCS memory are visible to other PEs and that changes
from other PEs are visible on this one by issuing a GCSB DSYNC when
moving to or from a thread with GCS.

Since the current GCS configuration of a thread will be visible to
userspace we store the configuration in the format used with userspace
and provide a helper which configures the system register as needed.

On systems that support GCS we always allow access to GCSPR_EL0, this
facilitates reporting of GCS faults if userspace implements disabling of
GCS on error - the GCS can still be discovered and examined even if GCS
has been disabled.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h       | 24 +++++++++++++++
 arch/arm64/include/asm/processor.h |  6 ++++
 arch/arm64/kernel/process.c        | 62 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/Makefile             |  1 +
 arch/arm64/mm/gcs.c                | 42 ++++++++++++++++++++++++++
 5 files changed, 135 insertions(+)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index 7c5e95218db6..04594ef59dad 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -48,4 +48,28 @@ static inline u64 gcsss2(void)
 	return Xt;
 }
 
+#ifdef CONFIG_ARM64_GCS
+
+static inline bool task_gcs_el0_enabled(struct task_struct *task)
+{
+	return current->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE;
+}
+
+void gcs_set_el0_mode(struct task_struct *task);
+void gcs_free(struct task_struct *task);
+void gcs_preserve_current_state(void);
+
+#else
+
+static inline bool task_gcs_el0_enabled(struct task_struct *task)
+{
+	return false;
+}
+
+static inline void gcs_set_el0_mode(struct task_struct *task) { }
+static inline void gcs_free(struct task_struct *task) { }
+static inline void gcs_preserve_current_state(void) { }
+
+#endif
+
 #endif
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 1438424f0064..5260788247d8 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -185,6 +185,12 @@ struct thread_struct {
 	u64			svcr;
 	u64			tpidr2_el0;
 	u64			por_el0;
+#ifdef CONFIG_ARM64_GCS
+	unsigned int		gcs_el0_mode;
+	u64			gcspr_el0;
+	u64			gcs_base;
+	u64			gcs_size;
+#endif
 };
 
 static inline unsigned int thread_get_vl(struct thread_struct *thread,
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 0540653fbf38..aedcf332f422 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -49,6 +49,7 @@
 #include <asm/cacheflush.h>
 #include <asm/exec.h>
 #include <asm/fpsimd.h>
+#include <asm/gcs.h>
 #include <asm/mmu_context.h>
 #include <asm/mte.h>
 #include <asm/processor.h>
@@ -280,6 +281,25 @@ static void flush_poe(void)
 	write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
 }
 
+#ifdef CONFIG_ARM64_GCS
+
+static void flush_gcs(void)
+{
+	if (!system_supports_gcs())
+		return;
+
+	gcs_free(current);
+	current->thread.gcs_el0_mode = 0;
+	write_sysreg_s(GCSCRE0_EL1_nTR, SYS_GCSCRE0_EL1);
+	write_sysreg_s(0, SYS_GCSPR_EL0);
+}
+
+#else
+
+static void flush_gcs(void) { }
+
+#endif
+
 void flush_thread(void)
 {
 	fpsimd_flush_thread();
@@ -287,6 +307,7 @@ void flush_thread(void)
 	flush_ptrace_hw_breakpoint(current);
 	flush_tagged_addr_state();
 	flush_poe();
+	flush_gcs();
 }
 
 void arch_release_task_struct(struct task_struct *tsk)
@@ -484,6 +505,46 @@ static void entry_task_switch(struct task_struct *next)
 	__this_cpu_write(__entry_task, next);
 }
 
+#ifdef CONFIG_ARM64_GCS
+
+void gcs_preserve_current_state(void)
+{
+	current->thread.gcspr_el0 = read_sysreg_s(SYS_GCSPR_EL0);
+}
+
+static void gcs_thread_switch(struct task_struct *next)
+{
+	if (!system_supports_gcs())
+		return;
+
+	/* GCSPR_EL0 is always readable */
+	gcs_preserve_current_state();
+	write_sysreg_s(next->thread.gcspr_el0, SYS_GCSPR_EL0);
+
+	if (current->thread.gcs_el0_mode != next->thread.gcs_el0_mode)
+		gcs_set_el0_mode(next);
+
+	/*
+	 * Ensure that GCS memory effects of the 'prev' thread are
+	 * ordered before other memory accesses with release semantics
+	 * (or preceded by a DMB) on the current PE. In addition, any
+	 * memory accesses with acquire semantics (or succeeded by a
+	 * DMB) are ordered before GCS memory effects of the 'next'
+	 * thread. This will ensure that the GCS memory effects are
+	 * visible to other PEs in case of migration.
+	 */
+	if (task_gcs_el0_enabled(current) || task_gcs_el0_enabled(next))
+		gcsb_dsync();
+}
+
+#else
+
+static void gcs_thread_switch(struct task_struct *next)
+{
+}
+
+#endif
+
 /*
  * Handle sysreg updates for ARM erratum 1418040 which affects the 32bit view of
  * CNTVCT, various other errata which require trapping all CNTVCT{,_EL0}
@@ -580,6 +641,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	cntkctl_thread_switch(prev, next);
 	ptrauth_thread_switch_user(next);
 	permission_overlay_switch(next);
+	gcs_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 2fc8c6dd0407..fc92170a8f37 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd.o
 obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd-asm.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
+obj-$(CONFIG_ARM64_GCS)		+= gcs.o
 KASAN_SANITIZE_physaddr.o	+= n
 
 obj-$(CONFIG_KASAN)		+= kasan_init.o
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
new file mode 100644
index 000000000000..f8f4f984a247
--- /dev/null
+++ b/arch/arm64/mm/gcs.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+
+#include <asm/cpufeature.h>
+#include <asm/page.h>
+
+/*
+ * Apply the GCS mode configured for the specified task to the
+ * hardware.
+ */
+void gcs_set_el0_mode(struct task_struct *task)
+{
+	u64 gcscre0_el1 = GCSCRE0_EL1_nTR;
+
+	if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE)
+		gcscre0_el1 |= GCSCRE0_EL1_RVCHKEN | GCSCRE0_EL1_PCRSEL;
+
+	if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_WRITE)
+		gcscre0_el1 |= GCSCRE0_EL1_STREn;
+
+	if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_PUSH)
+		gcscre0_el1 |= GCSCRE0_EL1_PUSHMEn;
+
+	write_sysreg_s(gcscre0_el1, SYS_GCSCRE0_EL1);
+}
+
+void gcs_free(struct task_struct *task)
+{
+	if (!system_supports_gcs())
+		return;
+
+	if (task->thread.gcs_base)
+		vm_munmap(task->thread.gcs_base, task->thread.gcs_size);
+
+	task->thread.gcspr_el0 = 0;
+	task->thread.gcs_base = 0;
+	task->thread.gcs_size = 0;
+}

-- 
2.39.2


