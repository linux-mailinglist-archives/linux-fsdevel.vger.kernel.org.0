Return-Path: <linux-fsdevel+bounces-34303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71AD9C474D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436681F211D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 20:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E716D1C7287;
	Mon, 11 Nov 2024 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mHLLtsxP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDB41C32FD
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358454; cv=none; b=MjN3brc1ULQNIZVwMTZ3+aXJylyxVKH0GpEpW0g5ZZHJ8mMriYK6QrfqDn2WkysbNrF8P8q6js7N1Oyj3cbl4M6sVex9GAhzwjWsTQEDT20gZIf5AdeZLvcJNVUH8b0wUjOFaP9sK/maXxlBAsyk3nZ04pzG5NYZ1rhEU0TmRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358454; c=relaxed/simple;
	bh=paD4kFJTOMNCQapdmU7vF58hNKyPDsR/BQZ80pyfH2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgOpFjOxiI6s/2ORMsGx4HjwiQ7AaJOsrwevF/koCENTjgj5hvKuVx7KcljXEPsvWz+ZAO3TOwygU358/jnmpDOurYLPZ2b+L6l+ejeg2MHLv8IxBdPcQaO7Kq3F8eN7INduh1t+BzsSRDC14/JyYD1J2qlK9CHueSoLyVhp6cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mHLLtsxP; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so3466430a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358451; x=1731963251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wlYhlTfRbz917f0tizIL6fD52nDOL2jxneRKObslEg=;
        b=mHLLtsxP2yGHS+1JjkQsdmhJ0jTZ1alds5EI/VzFJFLWKpMzbdOKp99YI+QUjVzxkt
         7dEfmrTYmjZ+QuM/62mdzFYADPM4f61/xZ/8jBTCUHfkqtuEv7ckOeFJxd5sOHxqTmNQ
         InwURK88Y34V6Q7wVB9Ch6y9UAWcLf+SljVUwEujYa7wRIk+5ino0bCGRYkqAp2ov1kb
         sA8BIwmR5yH4ncC19pGLxHnQoDv0QBasSmX/UErsHzA9mNyEJtz5AiC9oY+jfy2s9AJI
         k87L6qw+445LPCpNvM9ZBR/wgD6jryoAJnCEqK1Y0ij+LYwnZUq1ehJzlumHOrneY4iP
         sRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358451; x=1731963251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wlYhlTfRbz917f0tizIL6fD52nDOL2jxneRKObslEg=;
        b=v2d+Ikq5mO4QRfScEuXQxf0GPk/Mw2mEZIs8Ea+FdUYvDNWFlhZB6Sp2+iB/Gz6B8o
         mIA6G7NPM+StZ9lmX2RORlNdO6k8G9GXususvpX9iSoo2aZWFS8EaHKWqv5BCw6/mKcN
         E4OwFBZ6J56iK7sghMy/RB8jVvuKSA5pohq+E50sRlCGeEwSmVjFNDnb85BA+iMh5p/a
         zMljhZjjXHMZMApFYAKodC7d6chX3eSDossEGqDyS9QJYk7enpzjhtEqc80CqyqrzEwj
         4g4DH5GskrzDptYt4kxhkwVU5mvs9FvY8skO8lc6q6Ec4LHSD2kRgJvHLp/qRvfI3dc/
         NRVw==
X-Forwarded-Encrypted: i=1; AJvYcCU8bHngdbb5uCGbtT6ZQ2d3mjUFhtXqZUhxTrEXAofURhRn+7i/pO/e8CJ/5i8hlVcPHZLELNPBI3jdkh0k@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmu+VMuhk5NbCpRy+DRcdfVRx5gNtwkGG/T/WOTfT5z7vTs2t9
	p9z86dqjM3T1I87eyTlPUxpSCAFoXgIovlWoAk6mW+yo5K5F0NUS5DJ3mrEgBDI=
X-Google-Smtp-Source: AGHT+IHCStdYWzF0a25kqcOGnG0Pu4JGvRjMiuZ8NNCn1MCLP5RJQJdVrm6DVqL2Hypx+qG3O/OjVw==
X-Received: by 2002:a17:90b:2747:b0:2e2:cf5c:8ee3 with SMTP id 98e67ed59e1d1-2e9b17138bcmr21222036a91.10.1731358450607;
        Mon, 11 Nov 2024 12:54:10 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:54:10 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:53:51 -0800
Subject: [PATCH v8 06/29] riscv: usercfi state for task and save/restore of
 CSR_SSP on trap entry/exit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-6-dce14aa30207@rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

Carves out space in arch specific thread struct for cfi status and shadow
stack in usermode on riscv.

This patch does following
- defines a new structure cfi_status with status bit for cfi feature
- defines shadow stack pointer, base and size in cfi_status structure
- defines offsets to new member fields in thread in asm-offsets.c
- Saves and restore shadow stack pointer on trap entry (U --> S) and exit
  (S --> U)

Shadow stack save/restore is gated on feature availiblity and implemented
using alternative. CSR can be context switched in `switch_to` as well but
soon as kernel shadow stack support gets rolled in, shadow stack pointer
will need to be switched at trap entry/exit point (much like `sp`). It can
be argued that kernel using shadow stack deployment scenario may not be as
prevalant as user mode using this feature. But even if there is some
minimal deployment of kernel shadow stack, that means that it needs to be
supported. And thus save/restore of shadow stack pointer in entry.S instead
of in `switch_to.h`.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/processor.h   |  1 +
 arch/riscv/include/asm/thread_info.h |  3 +++
 arch/riscv/include/asm/usercfi.h     | 24 ++++++++++++++++++++++++
 arch/riscv/kernel/asm-offsets.c      |  4 ++++
 arch/riscv/kernel/entry.S            | 26 ++++++++++++++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index e3aba3336e63..d851bb5c6da0 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -14,6 +14,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/hwcap.h>
+#include <asm/usercfi.h>
 
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 9c10fb180f43..bb20bb7d17c3 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -62,6 +62,9 @@ struct thread_info {
 	long			user_sp;	/* User stack pointer */
 	int			cpu;
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
+#ifdef CONFIG_RISCV_USER_CFI
+	struct cfi_status	user_cfi_state;
+#endif
 #ifdef CONFIG_SHADOW_CALL_STACK
 	void			*scs_base;
 	void			*scs_sp;
diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
new file mode 100644
index 000000000000..4fa201b4fc4e
--- /dev/null
+++ b/arch/riscv/include/asm/usercfi.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2024 Rivos, Inc.
+ * Deepak Gupta <debug@rivosinc.com>
+ */
+#ifndef _ASM_RISCV_USERCFI_H
+#define _ASM_RISCV_USERCFI_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+#ifdef CONFIG_RISCV_USER_CFI
+struct cfi_status {
+	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
+	unsigned long rsvd : ((sizeof(unsigned long)*8) - 1);
+	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
+	unsigned long shdw_stk_base; /* Base address of shadow stack */
+	unsigned long shdw_stk_size; /* size of shadow stack */
+};
+
+#endif /* CONFIG_RISCV_USER_CFI */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_USERCFI_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index e94180ba432f..766bd33f10cb 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -52,6 +52,10 @@ void asm_offsets(void)
 #endif
 
 	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
+#ifdef CONFIG_RISCV_USER_CFI
+	OFFSET(TASK_TI_CFI_STATUS, task_struct, thread_info.user_cfi_state);
+	OFFSET(TASK_TI_USER_SSP, task_struct, thread_info.user_cfi_state.user_shdw_stk);
+#endif
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
 	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index c200d329d4bd..8f7f477517e3 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -147,6 +147,20 @@ SYM_CODE_START(handle_exception)
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
+	/*
+	 * If previous mode was U, capture shadow stack pointer and save it away
+	 * Zero CSR_SSP at the same time for sanitization.
+	 */
+	ALTERNATIVE("nop; nop; nop; nop",
+				__stringify(			\
+				andi s2, s1, SR_SPP;	\
+				bnez s2, skip_ssp_save;	\
+				csrrw s2, CSR_SSP, x0;	\
+				REG_S s2, TASK_TI_USER_SSP(tp); \
+				skip_ssp_save:),
+				0,
+				RISCV_ISA_EXT_ZICFISS,
+				CONFIG_RISCV_USER_CFI)
 	csrr s2, CSR_EPC
 	csrr s3, CSR_TVAL
 	csrr s4, CSR_CAUSE
@@ -236,6 +250,18 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	 * structures again.
 	 */
 	csrw CSR_SCRATCH, tp
+
+	/*
+	 * Going back to U mode, restore shadow stack pointer
+	 */
+	ALTERNATIVE("nop; nop",
+				__stringify(					\
+				REG_L s3, TASK_TI_USER_SSP(tp); \
+				csrw CSR_SSP, s3),
+				0,
+				RISCV_ISA_EXT_ZICFISS,
+				CONFIG_RISCV_USER_CFI)
+
 1:
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
 	move a0, sp

-- 
2.45.0


