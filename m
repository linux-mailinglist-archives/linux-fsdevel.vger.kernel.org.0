Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08718230B16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 15:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgG1NLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 09:11:07 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37780 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbgG1NLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:11:03 -0400
Received: from localhost.localdomain (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 35EF720B490C;
        Tue, 28 Jul 2020 06:11:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35EF720B490C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595941862;
        bh=8Vxha6xG5iZEw3wvrMCm+5RmpGmvMZada0wtXeD9y+A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Zelt39lGKsDTqpf+B5KIBob2G2aSNP3d2dICWZ2pAI4O7+mYJ1o3rMJZM+ta1LBFe
         My84y/3nj6OMcfg6VvYOSJHbwcHzyazxuBzfljnbMntH9BAE8jiqNR+HBZMvy6tC87
         CEAIa/3w8Z+GlTF6lqrgxbBMstTNru2mXoJYPUTU=
From:   madvenka@linux.microsoft.com
To:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, madvenka@linux.microsoft.com
Subject: [PATCH v1 3/4] [RFC] arm64/trampfd: Provide support for the trampoline file descriptor
Date:   Tue, 28 Jul 2020 08:10:49 -0500
Message-Id: <20200728131050.24443-4-madvenka@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728131050.24443-1-madvenka@linux.microsoft.com>
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

Implement 64-bit ARM support for the trampoline file descriptor.

	- Define architecture specific register names
	- Handle the trampoline invocation page fault
	- Setup the user register context on trampoline invocation
	- Setup the user stack context on trampoline invocation

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 arch/arm64/include/asm/ptrace.h      |   9 +
 arch/arm64/include/asm/unistd.h      |   2 +-
 arch/arm64/include/asm/unistd32.h    |   2 +
 arch/arm64/include/uapi/asm/ptrace.h |  57 ++++++
 arch/arm64/kernel/Makefile           |   2 +
 arch/arm64/kernel/trampfd.c          | 278 +++++++++++++++++++++++++++
 arch/arm64/mm/fault.c                |  15 +-
 7 files changed, 361 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/kernel/trampfd.c

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 953b6a1ce549..dad6cdbd59c6 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -232,6 +232,15 @@ static inline unsigned long user_stack_pointer(struct pt_regs *regs)
 	return regs->sp;
 }
 
+static inline void user_stack_pointer_set(struct pt_regs *regs,
+					  unsigned long val)
+{
+	if (compat_user_mode(regs))
+		regs->compat_sp = val;
+	else
+		regs->sp = val;
+}
+
 extern int regs_query_register_offset(const char *name);
 extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
 					       unsigned int n);
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 3b859596840d..b3b2019f8d16 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		440
+#define __NR_compat_syscalls		441
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 6d95d0c8bf2f..821ddcaf9683 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -885,6 +885,8 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
+#define __NR_trampfd_create 440
+__SYSCALL(__NR_trampfd_create, sys_trampfd_create)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 42cbe34d95ce..f4d1974dd795 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -88,6 +88,63 @@ struct user_pt_regs {
 	__u64		pstate;
 };
 
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
+/*
+ * These register names are to be used by 64-bit applications.
+ */
+enum reg_64_name {
+	arm64_r0 = arm_max,
+	arm64_r1,
+	arm64_r2,
+	arm64_r3,
+	arm64_r4,
+	arm64_r5,
+	arm64_r6,
+	arm64_r7,
+	arm64_r8,
+	arm64_r9,
+	arm64_r10,
+	arm64_r11,
+	arm64_r12,
+	arm64_r13,
+	arm64_r14,
+	arm64_r15,
+	arm64_r16,
+	arm64_r17,
+	arm64_r18,
+	arm64_r19,
+	arm64_r20,
+	arm64_r21,
+	arm64_r22,
+	arm64_r23,
+	arm64_r24,
+	arm64_r25,
+	arm64_r26,
+	arm64_r27,
+	arm64_r28,
+	arm64_pc,
+	arm64_max,
+};
+
 struct user_fpsimd_state {
 	__uint128_t	vregs[32];
 	__u32		fpsr;
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index a561cbb91d4d..18d373fb1208 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -71,3 +71,5 @@ extra-y					+= $(head-y) vmlinux.lds
 ifeq ($(CONFIG_DEBUG_EFI),y)
 AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
 endif
+
+obj-$(CONFIG_TRAMPFD)			+= trampfd.o
diff --git a/arch/arm64/kernel/trampfd.c b/arch/arm64/kernel/trampfd.c
new file mode 100644
index 000000000000..d79e749e0c30
--- /dev/null
+++ b/arch/arm64/kernel/trampfd.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline File Descriptor - ARM64 support.
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
+static inline bool is_compat(void)
+{
+	return is_compat_thread(task_thread_info(current));
+}
+
+static void set_reg_32(struct pt_regs *pt_regs, u32 name, u64 value)
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
+		pt_regs->regs[name] = (__u64)value;
+		break;
+	case arm_ip:
+		pt_regs->regs[arm64_r16 - arm_max] = (__u64)value;
+		break;
+	case arm_pc:
+		pt_regs->pc = (__u64)value;
+		break;
+	default:
+		WARN(1, "%s: Illegal register name %d\n", __func__, name);
+		break;
+	}
+}
+
+static void set_reg_64(struct pt_regs *pt_regs, u32 name, u64 value)
+{
+	switch (name) {
+	case arm64_r0:
+	case arm64_r1:
+	case arm64_r2:
+	case arm64_r3:
+	case arm64_r4:
+	case arm64_r5:
+	case arm64_r6:
+	case arm64_r7:
+	case arm64_r8:
+	case arm64_r9:
+	case arm64_r10:
+	case arm64_r11:
+	case arm64_r12:
+	case arm64_r13:
+	case arm64_r14:
+	case arm64_r15:
+	case arm64_r16:
+	case arm64_r17:
+	case arm64_r18:
+	case arm64_r19:
+	case arm64_r20:
+	case arm64_r21:
+	case arm64_r22:
+	case arm64_r23:
+	case arm64_r24:
+	case arm64_r25:
+	case arm64_r26:
+	case arm64_r27:
+	case arm64_r28:
+		pt_regs->regs[name - arm_max] = (__u64)value;
+		break;
+	case arm64_pc:
+		pt_regs->pc = (__u64)value;
+		break;
+	default:
+		WARN(1, "%s: Illegal register name %d\n", __func__, name);
+		break;
+	}
+}
+
+static void set_regs(struct pt_regs *pt_regs, struct trampfd_regs *tregs)
+{
+	struct trampfd_reg	*reg = tregs->regs;
+	struct trampfd_reg	*reg_end = reg + tregs->nregs;
+	bool			compat = is_compat();
+
+	for (; reg < reg_end; reg++) {
+		if (compat)
+			set_reg_32(pt_regs, reg->name, reg->value);
+		else
+			set_reg_64(pt_regs, reg->name, reg->value);
+	}
+}
+
+/*
+ * Check if the register names are valid. Check if the user PC has been set.
+ */
+bool trampfd_valid_regs(struct trampfd_regs *tregs)
+{
+	struct trampfd_reg	*reg = tregs->regs;
+	struct trampfd_reg	*reg_end = reg + tregs->nregs;
+	int			min, max, pc_name;
+	bool			pc_set = false;
+
+	if (is_compat()) {
+		min = 0;
+		pc_name = arm_pc;
+		max = arm_max;
+	} else {
+		min = arm_max;
+		pc_name = arm64_pc;
+		max = arm64_max;
+	}
+
+	for (; reg < reg_end; reg++) {
+		if (reg->name < min || reg->name >= max || reg->reserved)
+			return false;
+		if (reg->name == pc_name && reg->value)
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
+	pc_name = is_compat() ? arm_pc : arm64_pc;
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
+static int push_data(struct pt_regs *pt_regs, struct trampfd_stack *tstack)
+{
+	unsigned long	sp;
+
+	sp = user_stack_pointer(pt_regs) - tstack->size - tstack->offset;
+	if (tstack->flags & TRAMPFD_SET_SP)
+		sp = round_down(sp, 16);
+
+	if (!access_ok((void *)sp, user_stack_pointer(pt_regs) - sp))
+		return -EFAULT;
+
+	if (copy_to_user(USERPTR(sp), tstack->data, tstack->size))
+		return -EFAULT;
+
+	if (tstack->flags & TRAMPFD_SET_SP)
+		user_stack_pointer_set(pt_regs, sp);
+
+	return 0;
+}
+
+/* ---------------------------- Fault Handlers ---------------------------- */
+
+static int trampfd_user_fault(struct trampfd *trampfd,
+			      struct vm_area_struct *vma,
+			      struct pt_regs *pt_regs)
+{
+	char			buf[TRAMPFD_MAX_STACK_SIZE];
+	struct trampfd_regs	*tregs;
+	struct trampfd_stack	*tstack = NULL;
+	unsigned long		addr;
+	size_t			size;
+	int			rc = 0;
+
+	mutex_lock(&trampfd->lock);
+
+	/*
+	 * Execution of the trampoline must start at the offset specfied by
+	 * the kernel.
+	 */
+	addr = vma->vm_start + trampfd->map.ioffset;
+	if (addr != pt_regs->pc) {
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
+	set_regs(pt_regs, tregs);
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
+		rc = push_data(pt_regs, tstack);
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
+
+	if (!is_trampfd_vma(vma))
+		return false;
+	trampfd = vma->vm_private_data;
+
+	if (trampfd->type == TRAMPFD_USER)
+		return !trampfd_user_fault(trampfd, vma, pt_regs);
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
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 8afb238ff335..6e5e3193919a 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -23,6 +23,7 @@
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/trampfd.h>
 
 #include <asm/acpi.h>
 #include <asm/bug.h>
@@ -404,7 +405,8 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 #define VM_FAULT_BADACCESS	0x020000
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
-			   unsigned int mm_flags, unsigned long vm_flags)
+			   unsigned int mm_flags, unsigned long vm_flags,
+			   struct pt_regs *regs)
 {
 	struct vm_area_struct *vma = find_vma(mm, addr);
 
@@ -426,8 +428,15 @@ static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 	 * Check that the permissions on the VMA allow for the fault which
 	 * occurred.
 	 */
-	if (!(vma->vm_flags & vm_flags))
+	if (!(vma->vm_flags & vm_flags)) {
+		/*
+		 * If it is an execute fault, it could be a trampoline
+		 * invocation.
+		 */
+		if ((vm_flags & VM_EXEC) && trampfd_fault(vma, regs))
+			return 0;
 		return VM_FAULT_BADACCESS;
+	}
 	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags);
 }
 
@@ -516,7 +525,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 #endif
 	}
 
-	fault = __do_page_fault(mm, addr, mm_flags, vm_flags);
+	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, regs);
 	major |= fault & VM_FAULT_MAJOR;
 
 	/* Quick path to respond to signals */
-- 
2.17.1

