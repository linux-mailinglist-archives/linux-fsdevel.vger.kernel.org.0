Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8373B274BAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 23:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgIVVxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 17:53:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55318 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgIVVxn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:53:43 -0400
Received: from localhost.localdomain (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id DA8CD20C27C2;
        Tue, 22 Sep 2020 14:53:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA8CD20C27C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600811621;
        bh=7zXFDd5e9gQDRl70elYDzZIUqUSxDlwg1R6LYZvjU+I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=R8hQixnwCw7jKlbVUp2WcLjT2B1eBsMGQhRGCHNCB47lVsvQkkqkE3GV8ZKHy6wm3
         vjRjNeec0yvuNQGVTYgEsDBiFlWgGUdbCIl0J/1RtyjlTOyS71ozka1LIzRDkzafYK
         4hr5haytbkwGkefRtLhPALrM+xuyoPG5a6DtkxXU=
From:   madvenka@linux.microsoft.com
To:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com, mic@digikod.net,
        pavel@ucw.cz, madvenka@linux.microsoft.com
Subject: [PATCH v2 3/4] [RFC] arm64/trampfd: Provide support for the trampoline file descriptor
Date:   Tue, 22 Sep 2020 16:53:25 -0500
Message-Id: <20200922215326.4603-4-madvenka@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922215326.4603-1-madvenka@linux.microsoft.com>
References: <210d7cd762d5307c2aa1676705b392bd445f1baa>
 <20200922215326.4603-1-madvenka@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

	- Define architecture specific register names
	- Architecture specific functions for:
		- system call init
		- code descriptor check
		- data descriptor check
	- Fill a page with a trampoline table for:
		- 32-bit user process
		- 64-bit user process

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 arch/arm64/include/asm/unistd.h      |   2 +-
 arch/arm64/include/asm/unistd32.h    |   2 +
 arch/arm64/include/uapi/asm/ptrace.h |  59 +++++++
 arch/arm64/kernel/Makefile           |   2 +
 arch/arm64/kernel/trampfd.c          | 244 +++++++++++++++++++++++++++
 5 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/trampfd.c

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
index 6d95d0c8bf2f..c0493c5322d9 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -885,6 +885,8 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
+#define __NR_trampfd 440
+__SYSCALL(__NR_trampfd, sys_trampfd)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 42cbe34d95ce..2778789c1cbe 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -88,6 +88,65 @@ struct user_pt_regs {
 	__u64		pstate;
 };
 
+/*
+ * These register names are to be used by 32-bit applications.
+ */
+enum reg_32_name {
+	arm_min,
+	arm_r0 = arm_min,
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
+	arm_r11,
+	arm_r12,
+	arm_max,
+};
+
+/*
+ * These register names are to be used by 64-bit applications.
+ */
+enum reg_64_name {
+	arm64_min = arm_max,
+	arm64_r0 = arm64_min,
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
+	arm64_r29,
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
index 000000000000..3b40ebb12907
--- /dev/null
+++ b/arch/arm64/kernel/trampfd.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline FD - ARM64 support.
+ *
+ * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
+ *
+ * Copyright (c) 2020, Microsoft Corporation.
+ */
+
+#include <linux/thread_info.h>
+#include <asm/compat.h>
+#include <linux/trampfd.h>
+
+#define TRAMPFD_CODE_32_SIZE		28
+#define TRAMPFD_CODE_64_SIZE		48
+
+static inline bool is_compat(void)
+{
+	return is_compat_thread(task_thread_info(current));
+}
+
+/*
+ * trampfd syscall.
+ */
+void trampfd_arch(struct trampfd_info *info)
+{
+	if (is_compat())
+		info->code_size = TRAMPFD_CODE_32_SIZE;
+	else
+		info->code_size = TRAMPFD_CODE_64_SIZE;
+	info->ntrampolines = PAGE_SIZE / info->code_size;
+	info->code_offset = TRAMPFD_CODE_PGOFF << PAGE_SHIFT;
+	info->reserved = 0;
+}
+
+/*
+ * trampfd code descriptor check.
+ */
+int trampfd_code_arch(struct trampfd_code *code)
+{
+	int	ntrampolines;
+	int	min, max;
+
+	if (is_compat()) {
+		min = arm_min;
+		max = arm_max;
+		ntrampolines = PAGE_SIZE / TRAMPFD_CODE_32_SIZE;
+	} else {
+		min = arm64_min;
+		max = arm64_max;
+		ntrampolines = PAGE_SIZE / TRAMPFD_CODE_64_SIZE;
+	}
+
+	if (code->reg < min || code->reg >= max)
+		return -EINVAL;
+
+	if (!code->ntrampolines || code->ntrampolines > ntrampolines)
+		return -EINVAL;
+	return 0;
+}
+
+/*
+ * trampfd data descriptor check.
+ */
+int trampfd_data_arch(struct trampfd_data *data)
+{
+	int	min, max;
+
+	if (is_compat()) {
+		min = arm_min;
+		max = arm_max;
+	} else {
+		min = arm64_min;
+		max = arm64_max;
+	}
+
+	if (data->reg < min || data->reg >= max)
+		return -EINVAL;
+	return 0;
+}
+
+#define MOVARM(ins, reg, imm32)						\
+{									\
+	u16	*_imm16 = (u16 *) &(imm32);	/* little endian */	\
+	int	_hw, _opcode;						\
+									\
+	for (_hw = 0; _hw < 2; _hw++) {					\
+		/* movw or movt */					\
+		_opcode = _hw ? 0xe3400000 : 0xe3000000;		\
+		*ins++ = _opcode | (_imm16[_hw] >> 12) << 16 |		\
+			 (reg) << 12 | (_imm16[_hw] & 0xFFF);		\
+	}								\
+}
+
+#define LDRARM(ins, reg)						\
+{									\
+	*ins++ = 0xe5900000 | (reg) << 16 | (reg) << 12;		\
+}
+
+#define BXARM(ins, reg)							\
+{									\
+	*ins++ = 0xe12fff10 | (reg);					\
+}
+
+static void trampfd_code_fill_32(struct trampfd *trampfd, char *addr)
+{
+	char		*eaddr = addr + PAGE_SIZE;
+	int		creg = trampfd->code_reg - arm_min;
+	int		dreg = trampfd->data_reg - arm_min;
+	u32		*code = trampfd->code;
+	u32		*data = trampfd->data;
+	u32		*instruction = (u32 *) addr;
+	int		i;
+
+	for (i = 0; i < trampfd->ntrampolines; i++, code++, data++) {
+		/*
+		 * movw creg, code & 0xFFFF
+		 * movt creg, code >> 16
+		 */
+		MOVARM(instruction, creg, code);
+
+		/*
+		 * ldr	creg, [creg]
+		 */
+		LDRARM(instruction, creg);
+
+		/*
+		 * movw dreg, data & 0xFFFF
+		 * movt dreg, data >> 16
+		 */
+		MOVARM(instruction, dreg, data);
+
+		/*
+		 * ldr	dreg, [dreg]
+		 */
+		LDRARM(instruction, dreg);
+
+		/*
+		 * bx	creg
+		 */
+		BXARM(instruction, creg);
+	}
+	addr = (char *) instruction;
+	memset(addr, 0, eaddr - addr);
+}
+
+#define MOVQ(ins, reg, imm64)						\
+{									\
+	u16	*_imm16 = (u16 *) &(imm64);	/* little endian */	\
+	int	_hw, _opcode;						\
+									\
+	for (_hw = 0; _hw < 4; _hw++) {					\
+		/* movz or movk */					\
+		_opcode = _hw ? 0xf2800000 : 0xd2800000;		\
+		*ins++ = _opcode | _hw << 21 | _imm16[_hw] << 5 | (reg);\
+	}								\
+}
+
+#define LDR(ins, reg)							\
+{									\
+	*ins++ = 0xf9400000 | (reg) << 5 | (reg);			\
+}
+
+#define BR(ins, reg)							\
+{									\
+	*ins++ = 0xd61f0000 | (reg) << 5;				\
+}
+
+#define PAD(ins)							\
+{									\
+	while ((uintptr_t) ins & 7)					\
+		*ins++ = 0;						\
+}
+
+static void trampfd_code_fill_64(struct trampfd *trampfd, char *addr)
+{
+	char		*eaddr = addr + PAGE_SIZE;
+	int		creg = trampfd->code_reg - arm64_min;
+	int		dreg = trampfd->data_reg - arm64_min;
+	u64		*code = trampfd->code;
+	u64		*data = trampfd->data;
+	u32		*instruction = (u32 *) addr;
+	int		i;
+
+	for (i = 0; i < trampfd->ntrampolines; i++, code++, data++) {
+		/*
+		 * Pseudo instruction:
+		 *
+		 * movq creg, code
+		 *
+		 * Actual instructions:
+		 *
+		 * movz	creg, code & 0xFFFF
+		 * movk	creg, (code >> 16) & 0xFFFF, lsl 16
+		 * movk	creg, (code >> 32) & 0xFFFF, lsl 32
+		 * movk	creg, (code >> 48) & 0xFFFF, lsl 48
+		 */
+		MOVQ(instruction, creg, code);
+
+		/*
+		 * ldr	creg, [creg]
+		 */
+		LDR(instruction, creg);
+
+		/*
+		 * Pseudo instruction:
+		 *
+		 * movq dreg, data
+		 *
+		 * Actual instructions:
+		 *
+		 * movz	dreg, data & 0xFFFF
+		 * movk	dreg, (data >> 16) & 0xFFFF, lsl 16
+		 * movk	dreg, (data >> 32) & 0xFFFF, lsl 32
+		 * movk	dreg, (data >> 48) & 0xFFFF, lsl 48
+		 */
+		MOVQ(instruction, dreg, data);
+
+		/*
+		 * ldr	dreg, [dreg]
+		 */
+		LDR(instruction, dreg);
+
+		/*
+		 * br	creg
+		 */
+		BR(instruction, creg);
+
+		/*
+		 * Pad to 8-byte boundary
+		 */
+		PAD(instruction);
+	}
+	addr = (char *) instruction;
+	memset(addr, 0, eaddr - addr);
+}
+
+void trampfd_code_fill(struct trampfd *trampfd, char *addr)
+{
+	if (is_compat())
+		trampfd_code_fill_32(trampfd, addr);
+	else
+		trampfd_code_fill_64(trampfd, addr);
+}
-- 
2.17.1

