Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88AF230B1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 15:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgG1NLI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 09:11:08 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37808 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbgG1NLF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:11:05 -0400
Received: from localhost.localdomain (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0DFED20B490D;
        Tue, 28 Jul 2020 06:11:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DFED20B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595941863;
        bh=13WUf+vFpSs1y88gZGDgG7+CzTTQoGQm+q9JUkDCSOE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bbIPUm/uLvpqe3t3Tf9S0PC6sBFZYRseudQhdj0zWfh9UFhjeA3f5v1vtTbJknmnE
         vC+9xAiSB5k2bQnOl/iHhPvLrBV1I5NyB8fgu21tv1quHoTn+ez0O5xM5W8ZVaa8U6
         2Bpg2W2/j8pUMh2052OAGTVnCE6cifMP27GIxgaY=
From:   madvenka@linux.microsoft.com
To:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, madvenka@linux.microsoft.com
Subject: [PATCH v1 4/4] [RFC] arm/trampfd: Provide support for the trampoline file descriptor
Date:   Tue, 28 Jul 2020 08:10:50 -0500
Message-Id: <20200728131050.24443-5-madvenka@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728131050.24443-1-madvenka@linux.microsoft.com>
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

Implement 32-bit ARM support for the trampoline file descriptor.

	- Define architecture specific register names
	- Handle the trampoline invocation page fault
	- Setup the user register context on trampoline invocation
	- Setup the user stack context on trampoline invocation

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 arch/arm/include/uapi/asm/ptrace.h |  20 +++
 arch/arm/kernel/Makefile           |   1 +
 arch/arm/kernel/trampfd.c          | 214 +++++++++++++++++++++++++++++
 arch/arm/mm/fault.c                |  12 +-
 arch/arm/tools/syscall.tbl         |   1 +
 5 files changed, 246 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/kernel/trampfd.c

diff --git a/arch/arm/include/uapi/asm/ptrace.h b/arch/arm/include/uapi/asm/ptrace.h
index e61c65b4018d..47b1c5e2f32c 100644
--- a/arch/arm/include/uapi/asm/ptrace.h
+++ b/arch/arm/include/uapi/asm/ptrace.h
@@ -151,6 +151,26 @@ struct pt_regs {
 #define ARM_r0		uregs[0]
 #define ARM_ORIG_r0	uregs[17]
 
+/*
+ * These register names are to be used by 32-bit applications.
+ */
+enum reg_32_name {
+	arm_r0,
+	arm_r1,
+	arm_r2,
+	arm_r3,
+	arm_r4,
+	arm_r5,
+	arm_r6,
+	arm_r7,
+	arm_r8,
+	arm_r9,
+	arm_r10,
+	arm_ip,
+	arm_pc,
+	arm_max,
+};
+
 /*
  * The size of the user-visible VFP state as seen by PTRACE_GET/SETVFPREGS
  * and core dumps.
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 89e5d864e923..652c54c2f19a 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -105,5 +105,6 @@ obj-$(CONFIG_SMP)		+= psci_smp.o
 endif
 
 obj-$(CONFIG_HAVE_ARM_SMCCC)	+= smccc-call.o
+obj-$(CONFIG_TRAMPFD)		+= trampfd.o
 
 extra-y := $(head-y) vmlinux.lds
diff --git a/arch/arm/kernel/trampfd.c b/arch/arm/kernel/trampfd.c
new file mode 100644
index 000000000000..50fc5706e85b
--- /dev/null
+++ b/arch/arm/kernel/trampfd.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline File Descriptor - ARM support.
+ *
+ * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
+ *
+ * Copyright (c) 2020, Microsoft Corporation.
+ */
+
+#include <linux/trampfd.h>
+#include <linux/mm_types.h>
+#include <linux/uaccess.h>
+
+/* ---------------------------- Register Context ---------------------------- */
+
+static void set_reg(long *uregs, u32 name, u64 value)
+{
+	switch (name) {
+	case arm_r0:
+	case arm_r1:
+	case arm_r2:
+	case arm_r3:
+	case arm_r4:
+	case arm_r5:
+	case arm_r6:
+	case arm_r7:
+	case arm_r8:
+	case arm_r9:
+	case arm_r10:
+		uregs[name] = (__u64)value;
+		break;
+	case arm_ip:
+		ARM_ip = (__u64)value;
+		break;
+	case arm_pc:
+		ARM_pc = (__u64)value;
+		break;
+	default:
+		WARN(1, "%s: Illegal register name %d\n", __func__, name);
+		break;
+	}
+}
+
+static void set_regs(long *uregs, struct trampfd_regs *tregs)
+{
+	struct trampfd_reg	*reg = tregs->regs;
+	struct trampfd_reg	*reg_end = reg + tregs->nregs;
+
+	for (; reg < reg_end; reg++)
+		set_reg(uregs, reg->name, reg->value);
+}
+
+/*
+ * Check if the register names are valid. Check if the user PC has been set.
+ */
+bool trampfd_valid_regs(struct trampfd_regs *tregs)
+{
+	struct trampfd_reg	*reg = tregs->regs;
+	struct trampfd_reg	*reg_end = reg + tregs->nregs;
+	bool			pc_set = false;
+
+	for (; reg < reg_end; reg++) {
+		if (reg->name >= arm_max || reg->reserved)
+			return false;
+		if (reg->name == arm_pc && reg->value)
+			pc_set = true;
+	}
+	return pc_set;
+}
+EXPORT_SYMBOL_GPL(trampfd_valid_regs);
+
+/*
+ * Check if the PC specified in a register context is allowed.
+ */
+bool trampfd_allowed_pc(struct trampfd *trampfd, struct trampfd_regs *tregs)
+{
+	struct trampfd_reg	*reg = tregs->regs;
+	struct trampfd_reg	*reg_end = reg + tregs->nregs;
+	struct trampfd_values	*allowed_pcs = trampfd->allowed_pcs;
+	u64			*allowed_values, pc_value = 0;
+	u32			nvalues, pc_name;
+	int			i;
+
+	if (!allowed_pcs)
+		return true;
+
+	pc_name = arm_pc;
+
+	/*
+	 * Find the PC register and its value. If the PC register has been
+	 * specified multiple times, only the last one counts.
+	 */
+	for (; reg < reg_end; reg++) {
+		if (reg->name == pc_name)
+			pc_value = reg->value;
+	}
+
+	allowed_values = allowed_pcs->values;
+	nvalues = allowed_pcs->nvalues;
+
+	for (i = 0; i < nvalues; i++) {
+		if (pc_value == allowed_values[i])
+			return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(trampfd_allowed_pc);
+
+/* ---------------------------- Stack Context ---------------------------- */
+
+static int push_data(long *uregs, struct trampfd_stack *tstack)
+{
+	unsigned long	sp;
+
+	sp = ARM_sp - tstack->size - tstack->offset;
+	if (tstack->flags & TRAMPFD_SET_SP)
+		sp &= ~7;
+
+	if (!access_ok(sp, ARM_sp - sp))
+		return -EFAULT;
+
+	if (copy_to_user(USERPTR(sp), tstack->data, tstack->size))
+		return -EFAULT;
+
+	if (tstack->flags & TRAMPFD_SET_SP)
+		ARM_sp = sp;
+	return 0;
+}
+
+/* ---------------------------- Fault Handlers ---------------------------- */
+
+static int trampfd_user_fault(struct trampfd *trampfd,
+			      struct vm_area_struct *vma,
+			      long *uregs)
+{
+	char			buf[TRAMPFD_MAX_STACK_SIZE];
+	struct trampfd_regs	*tregs;
+	struct trampfd_stack	*tstack = NULL;
+	unsigned long		addr;
+	size_t			size;
+	int			rc;
+
+	mutex_lock(&trampfd->lock);
+
+	/*
+	 * Execution of the trampoline must start at the offset specfied by
+	 * the kernel.
+	 */
+	addr = vma->vm_start + trampfd->map.ioffset;
+	if (addr != ARM_pc) {
+		rc = -EINVAL;
+		goto unlock;
+	}
+
+	/*
+	 * At a minimum, the user PC register must be specified for a
+	 * user trampoline.
+	 */
+	tregs = trampfd->regs;
+	if (!tregs) {
+		rc = -EINVAL;
+		goto unlock;
+	}
+
+	/*
+	 * Set the register context for the trampoline.
+	 */
+	set_regs(uregs, tregs);
+
+	if (trampfd->stack) {
+		/*
+		 * Copy the stack context into a local buffer and push stack
+		 * data after dropping the lock.
+		 */
+		size = sizeof(*trampfd->stack) + trampfd->stack->size;
+		tstack = (struct trampfd_stack *) buf;
+		memcpy(tstack, trampfd->stack, size);
+	}
+unlock:
+	mutex_unlock(&trampfd->lock);
+
+	if (!rc && tstack) {
+		mmap_read_unlock(vma->vm_mm);
+		rc = push_data(uregs, tstack);
+		mmap_read_lock(vma->vm_mm);
+	}
+	return rc;
+}
+
+/*
+ * Handle it if it is a trampoline fault.
+ */
+bool trampfd_fault(struct vm_area_struct *vma, struct pt_regs *pt_regs)
+{
+	struct trampfd		*trampfd;
+	unsigned long		*uregs = pt_regs->uregs;
+
+	if (!is_trampfd_vma(vma))
+		return false;
+	trampfd = vma->vm_private_data;
+
+	if (trampfd->type == TRAMPFD_USER)
+		return !trampfd_user_fault(trampfd, vma, uregs);
+	return false;
+}
+EXPORT_SYMBOL_GPL(trampfd_fault);
+
+/* ---------------------------- Miscellaneous ---------------------------- */
+
+int trampfd_check_arch(struct trampfd *trampfd)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(trampfd_check_arch);
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index c6550eddfce1..21a81d19336b 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -17,6 +17,7 @@
 #include <linux/sched/debug.h>
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
+#include <linux/trampfd.h>
 
 #include <asm/system_misc.h>
 #include <asm/system_info.h>
@@ -202,7 +203,8 @@ static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
 
 static vm_fault_t __kprobes
 __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
-		unsigned int flags, struct task_struct *tsk)
+		unsigned int flags, struct task_struct *tsk,
+		struct pt_regs *regs)
 {
 	struct vm_area_struct *vma;
 	vm_fault_t fault;
@@ -220,6 +222,12 @@ __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 	 */
 good_area:
 	if (access_error(fsr, vma)) {
+		/*
+		 * If it is an execute fault, it could be a trampoline
+		 * invocation.
+		 */
+		if ((fsr & FSR_LNX_PF) && trampfd_fault(vma, regs))
+			return 0;
 		fault = VM_FAULT_BADACCESS;
 		goto out;
 	}
@@ -290,7 +298,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 #endif
 	}
 
-	fault = __do_page_fault(mm, addr, fsr, flags, tsk);
+	fault = __do_page_fault(mm, addr, fsr, flags, tsk, regs);
 
 	/* If we need to retry but a fatal signal is pending, handle the
 	 * signal first. We do not need to release the mmap_lock because
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index d5cae5ffede0..88cf4c45069a 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -452,3 +452,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+440	common	trampfd_create			sys_trampfd_create
-- 
2.17.1

