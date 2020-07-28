Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0318230B11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 15:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgG1NLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 09:11:07 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37764 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgG1NLE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:11:04 -0400
Received: from localhost.localdomain (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5F08A20B490A;
        Tue, 28 Jul 2020 06:11:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F08A20B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595941862;
        bh=OZu1yPFbyEzIVjDAN8OqyOEkz38xe1dWw+AeD/DACgE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VG2Osgg9paicCBTa6gJkRmLr9Ki9+dDbqrV+zYqWR7A/SsLcPSkA9wYYE1gA6kPjm
         hC9FEcLgF+8jD9V9A31OBvIYHWE8Km10/AkOh3U4ExKlW7vBlzhzVJNYSU086AdSm+
         6kd70Oqr4vSqDmsjHrXWyaFjTW5WpOmmzKqjLAI0=
From:   madvenka@linux.microsoft.com
To:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, madvenka@linux.microsoft.com
Subject: [PATCH v1 2/4] [RFC] x86/trampfd: Provide support for the trampoline file descriptor
Date:   Tue, 28 Jul 2020 08:10:48 -0500
Message-Id: <20200728131050.24443-3-madvenka@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728131050.24443-1-madvenka@linux.microsoft.com>
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

Implement 32-bit and 64-bit X86 support for the trampoline file descriptor.

	- Define architecture specific register names
	- Handle the trampoline invocation page fault
	- Setup the user register context on trampoline invocation
	- Setup the user stack context on trampoline invocation

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 arch/x86/include/uapi/asm/ptrace.h     |  38 +++
 arch/x86/kernel/Makefile               |   2 +
 arch/x86/kernel/trampfd.c              | 313 +++++++++++++++++++++++++
 arch/x86/mm/fault.c                    |  11 +
 6 files changed, 366 insertions(+)
 create mode 100644 arch/x86/kernel/trampfd.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index d8f8a1a69ed1..77eb50414591 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -443,3 +443,4 @@
 437	i386	openat2			sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd
 439	i386	faccessat2		sys_faccessat2
+440	i386	trampfd_create		sys_trampfd_create
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 78847b32e137..9d962de1d21f 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -360,6 +360,7 @@
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd		sys_pidfd_getfd
 439	common	faccessat2		sys_faccessat2
+440	common	trampfd_create		sys_trampfd_create
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/x86/include/uapi/asm/ptrace.h b/arch/x86/include/uapi/asm/ptrace.h
index 85165c0edafc..b031598f857e 100644
--- a/arch/x86/include/uapi/asm/ptrace.h
+++ b/arch/x86/include/uapi/asm/ptrace.h
@@ -9,6 +9,44 @@
 
 #ifndef __ASSEMBLY__
 
+/*
+ * These register names are to be used by 32-bit applications.
+ */
+enum reg_32_name {
+	x32_eax,
+	x32_ebx,
+	x32_ecx,
+	x32_edx,
+	x32_esi,
+	x32_edi,
+	x32_ebp,
+	x32_eip,
+	x32_max,
+};
+
+/*
+ * These register names are to be used by 64-bit applications.
+ */
+enum reg_64_name {
+	x64_rax = x32_max,
+	x64_rbx,
+	x64_rcx,
+	x64_rdx,
+	x64_rsi,
+	x64_rdi,
+	x64_rbp,
+	x64_r8,
+	x64_r9,
+	x64_r10,
+	x64_r11,
+	x64_r12,
+	x64_r13,
+	x64_r14,
+	x64_r15,
+	x64_rip,
+	x64_max,
+};
+
 #ifdef __i386__
 /* this struct defines the way the registers are stored on the
    stack during a system call. */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index e77261db2391..5d968ac4c7d9 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -157,3 +157,5 @@ ifeq ($(CONFIG_X86_64),y)
 endif
 
 obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
+
+obj-$(CONFIG_TRAMPFD)			+= trampfd.o
diff --git a/arch/x86/kernel/trampfd.c b/arch/x86/kernel/trampfd.c
new file mode 100644
index 000000000000..f6b5507134d2
--- /dev/null
+++ b/arch/x86/kernel/trampfd.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline File Descriptor - X86 support.
+ *
+ * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
+ *
+ * Copyright (c) 2020, Microsoft Corporation.
+ */
+
+#include <linux/thread_info.h>
+#include <linux/mm_types.h>
+#include <linux/trampfd.h>
+#include <linux/uaccess.h>
+
+/* ---------------------------- Register Context ---------------------------- */
+
+static inline bool is_compat(void)
+{
+	return (IS_ENABLED(CONFIG_X86_32) ||
+		(IS_ENABLED(CONFIG_COMPAT) && test_thread_flag(TIF_ADDR32)));
+}
+
+static void set_reg_32(struct pt_regs *pt_regs, u32 name, u64 value)
+{
+	switch (name) {
+	case x32_eax:
+		pt_regs->ax = (unsigned long)value;
+		break;
+	case x32_ebx:
+		pt_regs->bx = (unsigned long)value;
+		break;
+	case x32_ecx:
+		pt_regs->cx = (unsigned long)value;
+		break;
+	case x32_edx:
+		pt_regs->dx = (unsigned long)value;
+		break;
+	case x32_esi:
+		pt_regs->si = (unsigned long)value;
+		break;
+	case x32_edi:
+		pt_regs->di = (unsigned long)value;
+		break;
+	case x32_ebp:
+		pt_regs->bp = (unsigned long)value;
+		break;
+	case x32_eip:
+		pt_regs->ip = (unsigned long)value;
+		break;
+	default:
+		WARN(1, "%s: Illegal register name %d\n", __func__, name);
+		break;
+	}
+}
+
+#ifdef __i386__
+
+static void set_reg_64(struct pt_regs *pt_regs, u32 name, u64 value)
+{
+}
+
+#else
+
+static void set_reg_64(struct pt_regs *pt_regs, u32 name, u64 value)
+{
+	switch (name) {
+	case x64_rax:
+		pt_regs->ax = (unsigned long)value;
+		break;
+	case x64_rbx:
+		pt_regs->bx = (unsigned long)value;
+		break;
+	case x64_rcx:
+		pt_regs->cx = (unsigned long)value;
+		break;
+	case x64_rdx:
+		pt_regs->dx = (unsigned long)value;
+		break;
+	case x64_rsi:
+		pt_regs->si = (unsigned long)value;
+		break;
+	case x64_rdi:
+		pt_regs->di = (unsigned long)value;
+		break;
+	case x64_rbp:
+		pt_regs->bp = (unsigned long)value;
+		break;
+	case x64_r8:
+		pt_regs->r8 = (unsigned long)value;
+		break;
+	case x64_r9:
+		pt_regs->r9 = (unsigned long)value;
+		break;
+	case x64_r10:
+		pt_regs->r10 = (unsigned long)value;
+		break;
+	case x64_r11:
+		pt_regs->r11 = (unsigned long)value;
+		break;
+	case x64_r12:
+		pt_regs->r12 = (unsigned long)value;
+		break;
+	case x64_r13:
+		pt_regs->r13 = (unsigned long)value;
+		break;
+	case x64_r14:
+		pt_regs->r14 = (unsigned long)value;
+		break;
+	case x64_r15:
+		pt_regs->r15 = (unsigned long)value;
+		break;
+	case x64_rip:
+		pt_regs->ip = (unsigned long)value;
+		break;
+	default:
+		WARN(1, "%s: Illegal register name %d\n", __func__, name);
+		break;
+	}
+}
+
+#endif /* __i386__ */
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
+		pc_name = x32_eip;
+		max = x32_max;
+	} else {
+		min = x32_max;
+		pc_name = x64_rip;
+		max = x64_max;
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
+	pc_name = is_compat() ? x32_eip : x64_rip;
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
+	if (tstack->flags & TRAMPFD_SET_SP) {
+		if (is_compat())
+			sp = ((sp + 4) & -16ul) - 4;
+		else
+			sp = round_down(sp, 16) - 8;
+	}
+
+	if (!access_ok(sp, user_stack_pointer(pt_regs) - sp))
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
+	if (addr != pt_regs->ip) {
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
+/* ------------------------- Arch Initialization ------------------------- */
+
+int trampfd_check_arch(struct trampfd *trampfd)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(trampfd_check_arch);
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 1ead568c0101..a1432ee2a1a2 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
 #include <linux/efi.h>			/* efi_recover_from_page_fault()*/
 #include <linux/mm_types.h>
+#include <linux/trampfd.h>		/* trampoline invocation */
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1142,6 +1143,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	struct mm_struct *mm;
 	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
+	unsigned long tflags = X86_PF_INSTR | X86_PF_USER;
 
 	tsk = current;
 	mm = tsk->mm;
@@ -1275,6 +1277,15 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 */
 good_area:
 	if (unlikely(access_error(hw_error_code, vma))) {
+		/*
+		 * If it is a user execute fault, it could be a trampoline
+		 * invocation.
+		 */
+		if ((hw_error_code & tflags) == tflags &&
+		    trampfd_fault(vma, regs)) {
+			mmap_read_unlock(mm);
+			return;
+		}
 		bad_area_access_error(regs, hw_error_code, address, vma);
 		return;
 	}
-- 
2.17.1

