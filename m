Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CB8274B9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 23:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgIVVxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 17:53:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55284 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgIVVxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:53:41 -0400
Received: from localhost.localdomain (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id CE92F20BBF7F;
        Tue, 22 Sep 2020 14:53:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CE92F20BBF7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600811619;
        bh=3qfx1/3d8ADHXgnKcsbkjWTPFHnk11ORotWaBTL6O08=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b/i4TajljKF8fHi0NxIevwUc75F8PxR/aRpgH2bmiCiY6NTom9+g/s8S2C2qrvGhA
         rTydYkef4fK5iLnZmHDr3EbALEyd7DONz4+hdEk9ErvjwM9CGtdJhmvrasT8Scc95s
         VmB6LX9WRSGxAEF5mo3n8hQDgm/bZ07U0CHZzuSU=
From:   madvenka@linux.microsoft.com
To:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com, mic@digikod.net,
        pavel@ucw.cz, madvenka@linux.microsoft.com
Subject: [PATCH v2 2/4] [RFC] x86/trampfd: Provide support for the trampoline file descriptor
Date:   Tue, 22 Sep 2020 16:53:24 -0500
Message-Id: <20200922215326.4603-3-madvenka@linux.microsoft.com>
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
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 arch/x86/include/uapi/asm/ptrace.h     |  38 ++++
 arch/x86/kernel/Makefile               |   1 +
 arch/x86/kernel/trampfd.c              | 238 +++++++++++++++++++++++++
 5 files changed, 279 insertions(+)
 create mode 100644 arch/x86/kernel/trampfd.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index d8f8a1a69ed1..d4f17806c9ab 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -443,3 +443,4 @@
 437	i386	openat2			sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd
 439	i386	faccessat2		sys_faccessat2
+440	i386	trampfd			sys_trampfd
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 78847b32e137..91b37bc4b6f0 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -360,6 +360,7 @@
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd		sys_pidfd_getfd
 439	common	faccessat2		sys_faccessat2
+440	common	trampfd			sys_trampfd
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/x86/include/uapi/asm/ptrace.h b/arch/x86/include/uapi/asm/ptrace.h
index 85165c0edafc..b4be362929b3 100644
--- a/arch/x86/include/uapi/asm/ptrace.h
+++ b/arch/x86/include/uapi/asm/ptrace.h
@@ -9,6 +9,44 @@
 
 #ifndef __ASSEMBLY__
 
+/*
+ * These register names are to be used by 32-bit applications.
+ */
+enum reg_32_name {
+	x32_min = 0,
+	x32_eax = x32_min,
+	x32_ebx,
+	x32_ecx,
+	x32_edx,
+	x32_esi,
+	x32_edi,
+	x32_ebp,
+	x32_max,
+};
+
+/*
+ * These register names are to be used by 64-bit applications.
+ */
+enum reg_64_name {
+	x64_min = x32_max,
+	x64_rax = x64_min,
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
+	x64_max,
+};
+
 #ifdef __i386__
 /* this struct defines the way the registers are stored on the
    stack during a system call. */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index e77261db2391..feb7f4f311fd 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -157,3 +157,4 @@ ifeq ($(CONFIG_X86_64),y)
 endif
 
 obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
+obj-$(CONFIG_TRAMPFD)				+= trampfd.o
diff --git a/arch/x86/kernel/trampfd.c b/arch/x86/kernel/trampfd.c
new file mode 100644
index 000000000000..7b812c200d01
--- /dev/null
+++ b/arch/x86/kernel/trampfd.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trampoline FD - X86 support.
+ *
+ * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
+ *
+ * Copyright (c) 2020, Microsoft Corporation.
+ */
+
+#include <linux/thread_info.h>
+#include <linux/trampfd.h>
+
+#define TRAMPFD_CODE_32_SIZE		24
+#define TRAMPFD_CODE_64_SIZE		40
+
+static inline bool is_compat(void)
+{
+	return (IS_ENABLED(CONFIG_X86_32) ||
+		(IS_ENABLED(CONFIG_COMPAT) && test_thread_flag(TIF_ADDR32)));
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
+		min = x32_min;
+		max = x32_max;
+		ntrampolines = PAGE_SIZE / TRAMPFD_CODE_32_SIZE;
+	} else {
+		min = x64_min;
+		max = x64_max;
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
+		min = x32_min;
+		max = x32_max;
+	} else {
+		min = x64_min;
+		max = x64_max;
+	}
+
+	if (data->reg < min || data->reg >= max)
+		return -EINVAL;
+	return 0;
+}
+
+/*
+ * X32 register encodings.
+ */
+static unsigned char	reg_32[] = {
+	0,	/* x32_eax */
+	3,	/* x32_ebx */
+	1,	/* x32_ecx */
+	2,	/* x32_edx */
+	6,	/* x32_esi */
+	7,	/* x32_edi */
+	5,	/* x32_ebp */
+};
+
+static void trampfd_code_fill_32(struct trampfd *trampfd, char *addr)
+{
+	char		*eaddr = addr + PAGE_SIZE;
+	int		creg = trampfd->code_reg - x32_min;
+	int		dreg = trampfd->data_reg - x32_min;
+	u32		*code = trampfd->code;
+	u32		*data = trampfd->data;
+	int		i;
+
+	for (i = 0; i < trampfd->ntrampolines; i++, code++, data++) {
+		/* endbr32 */
+		addr[0] = 0xf3;
+		addr[1] = 0x0f;
+		addr[2] = 0x1e;
+		addr[3] = 0xfb;
+
+		/* mov code, %creg */
+		addr[4] = 0xB8 | reg_32[creg];			/* opcode+reg */
+		memcpy(&addr[5], &code, sizeof(u32));		/* imm32 */
+
+		/* mov (%creg), %creg */
+		addr[9] = 0x8B;				/* opcode */
+		addr[10] = 0x00 |				/* MODRM.mode */
+			   reg_32[creg] << 3 |			/* MODRM.reg */
+			   reg_32[creg];			/* MODRM.r/m */
+
+		/* mov data, %dreg */
+		addr[11] = 0xB8 | reg_32[dreg];			/* opcode+reg */
+		memcpy(&addr[12], &data, sizeof(u32));		/* imm32 */
+
+		/* mov (%dreg), %dreg */
+		addr[16] = 0x8B;				/* opcode */
+		addr[17] = 0x00 |				/* MODRM.mode */
+			   reg_32[dreg] << 3 |			/* MODRM.reg */
+			   reg_32[dreg];			/* MODRM.r/m */
+
+		/* jmp *%creg */
+		addr[18] = 0xff;				/* opcode */
+		addr[19] = 0xe0 | reg_32[creg];			/* MODRM.r/m */
+
+		/* nopl (%eax) */
+		addr[20] = 0x0f;
+		addr[21] = 0x1f;
+		addr[22] = 0x00;
+
+		/* pad to 4-byte boundary */
+		memset(&addr[23], 0, TRAMPFD_CODE_32_SIZE - 23);
+		addr += TRAMPFD_CODE_32_SIZE;
+	}
+	memset(addr, 0, eaddr - addr);
+}
+
+/*
+ * X64 register encodings.
+ */
+static unsigned char	reg_64[] = {
+	0,	/* x64_rax */
+	3,	/* x64_rbx */
+	1,	/* x64_rcx */
+	2,	/* x64_rdx */
+	6,	/* x64_rsi */
+	7,	/* x64_rdi */
+	5,	/* x64_rbp */
+	8,	/* x64_r8 */
+	9,	/* x64_r9 */
+	10,	/* x64_r10 */
+	11,	/* x64_r11 */
+	12,	/* x64_r12 */
+	13,	/* x64_r13 */
+	14,	/* x64_r14 */
+	15,	/* x64_r15 */
+};
+
+static void trampfd_code_fill_64(struct trampfd *trampfd, char *addr)
+{
+	char		*eaddr = addr + PAGE_SIZE;
+	int		creg = trampfd->code_reg - x64_min;
+	int		dreg = trampfd->data_reg - x64_min;
+	u64		*code = trampfd->code;
+	u64		*data = trampfd->data;
+	int		i;
+
+	for (i = 0; i < trampfd->ntrampolines; i++, code++, data++) {
+		/* endbr64 */
+		addr[0] = 0xf3;
+		addr[1] = 0x0f;
+		addr[2] = 0x1e;
+		addr[3] = 0xfa;
+
+		/* movabs code, %creg */
+		addr[4] = 0x48 |				/* REX.W */
+			  ((reg_64[creg] & 0x8) >> 3);		/* REX.B */
+		addr[5] = 0xB8 | (reg_64[creg] & 0x7);		/* opcode+reg */
+		memcpy(&addr[6], &code, sizeof(u64));		/* imm64 */
+
+		/* movq (%creg), %creg */
+		addr[14] = 0x48 |				/* REX.W */
+			   ((reg_64[creg] & 0x8) >> 1) |	/* REX.R */
+			   ((reg_64[creg] & 0x8) >> 3);		/* REX.B */
+		addr[15] = 0x8B;				/* opcode */
+		addr[16] = 0x00 |				/* MODRM.mode */
+			   ((reg_64[creg] & 0x7)) << 3 |	/* MODRM.reg */
+			   ((reg_64[creg] & 0x7));		/* MODRM.r/m */
+
+		/* movabs data, %dreg */
+		addr[17] = 0x48 |				/* REX.W */
+			  ((reg_64[dreg] & 0x8) >> 3);		/* REX.B */
+		addr[18] = 0xB8 | (reg_64[dreg] & 0x7);		/* opcode+reg */
+		memcpy(&addr[19], &data, sizeof(u64));		/* imm64 */
+
+		/* movq (%dreg), %dreg */
+		addr[27] = 0x48 |				/* REX.W */
+			   ((reg_64[dreg] & 0x8) >> 1) |	/* REX.R */
+			   ((reg_64[dreg] & 0x8) >> 3);		/* REX.B */
+		addr[28] = 0x8B;				/* opcode */
+		addr[29] = 0x00 |				/* MODRM.mode */
+			   ((reg_64[dreg] & 0x7)) << 3 |	/* MODRM.reg */
+			   ((reg_64[dreg] & 0x7));		/* MODRM.r/m */
+
+		/* jmpq *%creg */
+		addr[30] = 0x40 |				/* REX.W */
+			   ((reg_64[creg] & 0x8) >> 3);		/* REX.B */
+		addr[31] = 0xff;				/* opcode */
+		addr[32] = 0xe0 | (reg_64[creg] & 0x7);		/* MODRM.r/m */
+
+		/* nopl (%rax) */
+		addr[33] = 0x0f;
+		addr[34] = 0x1f;
+		addr[35] = 0x00;
+
+		/* pad to 8-byte boundary */
+		memset(&addr[36], 0, TRAMPFD_CODE_64_SIZE - 36);
+		addr += TRAMPFD_CODE_64_SIZE;
+	}
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

