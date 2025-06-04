Return-Path: <linux-fsdevel+bounces-50646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0D2ACE326
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 19:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CF5189B2FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5DF23C506;
	Wed,  4 Jun 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vPn3u4yC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF5F236A79
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057410; cv=none; b=QxS+IeJPIr+dAVL61Ec3mbBTfemNdDfQebULlwClSyllG2mmZkwQchmLnDiDq1Lse83/PYdZxed+sNZmmepRTUa5+yyTT+rk1sVkDEWr+QG16BBDZHNjqf+xydr5Mgd3uEqH4knk2NNkKEbwNCN9k8RuA/xqU927aBoh1xGCKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057410; c=relaxed/simple;
	bh=C7ks50ikNOOOGz0rAMPvdaV+qpFKBmIGG1rjxsnPvAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u0VGbeWeLbhoi6Xgc4FSjuTt9JCFEsnO78tcBwy1sb/NHfKPjrwLpWa9z7kGNMKXNz3uKA183j6NH2avTB6gaPe7YIuGHtkWQY9KWii3J+mWIzqqQP9w/nR3R/CrMfboH8WPSA7IKQmolkSrsmPAooEylOrnysCBmC+6tTNqBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vPn3u4yC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2347012f81fso781705ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749057408; x=1749662208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/8dVnIOzdzC1nuKUYhAi1mzOdRHXwnCzbO7JbF3xaI=;
        b=vPn3u4yCiKoPFHdhjixxUuSz2sW7TzjW5XmC1qFY0iiyVDR4fqxfP4upxMyqLke7Di
         jU8yf99LDCYk2dciU4BbrEgFDKrHitamlSW2RDTULM+/e6jBVYKEQk345oT66Dob0iWx
         6ZSbVNh+B5a0nItAV99vcqp1+KUlWrn1QbHCLc1PrlaBJfKqZFUyvNSQbROXBahE00fc
         VsNIQ5tIe09tFkXGMU66vM/NGzcvD+wmkaPF7UowCKWgsIsOaZHpDfNDKX636EcEzq85
         WCaiXVr1GcjWcg3JDRCdife0hT49C6rLXxaB04g4KtcJ/As8SrYrhLN3YPwvVOn7TLRV
         JEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057408; x=1749662208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/8dVnIOzdzC1nuKUYhAi1mzOdRHXwnCzbO7JbF3xaI=;
        b=mC5v/78m0ayJrr6NDaAVhxILyNuRlXnDfXtFm2/lefo0+m/MXK/HEwnkNMyriNqbyA
         avsxnMX6N7unE8oGu8DWlgQTIhzw3LiE6a33xPNaujIIQW6A8VTC6xpPwEfrar3OEI6a
         Pf02yydKKvyB54Z+fyxyjhwskv7Obx+zjHnwLS7aPmrwE3c6Ri7D3bJpf/8BfyzHL9Fn
         7q/5bSioB740gjQq1mwkoJaIItm5moX3jEo5pQWQo49UjrSULCHyP28jx5FtXD+KeqYr
         FwEDdyybG5E0UfDaWqHYUtNxIZZWLBqMGTXYtfB1o1Cm4cdQaKXIHav1D9D/h262Q8YL
         BP1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/2Uvl6gCznTnfpEGtMElrtMhpTHFnpCJj217Y3SVDf6CCt9ICEqP62pnmcZUNK20c1sgDGSc4DBwnwK5g@vger.kernel.org
X-Gm-Message-State: AOJu0YyE6YAzmx3yFQUDGiXIH/wSvTHx7WlUv49QIGYdTD/mUPOHp97M
	E8eB+WT5AMS9f7tzoWT1DJRrncVPRQaw6wpVsjEAyXW4+ZawySbnDGoyFrpxopKrz58=
X-Gm-Gg: ASbGncushvQcy1W1s4sBerzplrZoPDCMGCrCOFtV2q9z33vGK90WoLLhpCh2NJEdIad
	YNkrtORcdkAOJGx45pdJhGOleyN9ex+PNACfZs5WpFX3QrnHf5h1G7FNAQm5qXb4cEOIsbD8R5a
	pjqWd9XWN9BO1YmAOC3Kb0dz2425Aqj921YNX9lj+kW/46eJstOHgxaNFJKYvrvMw//a5H1+4oL
	ACSKxgOuXJxGKSwkBQ7dCf1BCka1EwYuwM9WpDqQO7Cw2ow3b7SuF2Cthrvrwy0V/bPg0XlF7G6
	TFwSqJdQAUbz+h0X1CeyTslzG8PlfnFVa+kQxxa2fngg0uAlsL0U5A0IdfOcVQ==
X-Google-Smtp-Source: AGHT+IHNmPq2kRFPpP/2Xfnnj9OgV1dbK4DhifLrHJ4EBa0EpdqwFqn7tJV9R6Wj9Bf2iZgpfOyyEQ==
X-Received: by 2002:a17:902:f683:b0:234:ef42:5d5b with SMTP id d9443c01a7336-235e11501f9mr50138895ad.16.1749057407461;
        Wed, 04 Jun 2025 10:16:47 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e9c9fsm9178972a91.30.2025.06.04.10.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:16:47 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 04 Jun 2025 10:15:35 -0700
Subject: [PATCH v17 11/27] riscv/shstk: If needed allocate a new shadow
 stack on clone
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-v5_user_cfi_series-v17-11-4565c2cf869f@rivosinc.com>
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
In-Reply-To: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Userspace specifies CLONE_VM to share address space and spawn new thread.
`clone` allow userspace to specify a new stack for new thread. However
there is no way to specify new shadow stack base address without changing
API. This patch allocates a new shadow stack whenever CLONE_VM is given.

In case of CLONE_VFORK, parent is suspended until child finishes and thus
can child use parent shadow stack. In case of !CLONE_VM, COW kicks in
because entire address space is copied from parent to child.

`clone3` is extensible and can provide mechanisms using which shadow stack
as an input parameter can be provided. This is not settled yet and being
extensively discussed on mailing list. Once that's settled, this commit
will adapt to that.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/mmu_context.h |   7 ++
 arch/riscv/include/asm/usercfi.h     |  25 ++++++++
 arch/riscv/kernel/process.c          |  10 +++
 arch/riscv/kernel/usercfi.c          | 120 +++++++++++++++++++++++++++++++++++
 4 files changed, 162 insertions(+)

diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 8c4bc49a3a0f..dbf27a78df6c 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -48,6 +48,13 @@ static inline unsigned long mm_untag_mask(struct mm_struct *mm)
 }
 #endif
 
+#define deactivate_mm deactivate_mm
+static inline void deactivate_mm(struct task_struct *tsk,
+				 struct mm_struct *mm)
+{
+	shstk_release(tsk);
+}
+
 #include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index 94b214c295c0..0c81cc9a2b6d 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -8,6 +8,9 @@
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 
+struct task_struct;
+struct kernel_clone_args;
+
 #ifdef CONFIG_RISCV_USER_CFI
 struct cfi_state {
 	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
@@ -16,6 +19,28 @@ struct cfi_state {
 	unsigned long shdw_stk_size; /* size of shadow stack */
 };
 
+unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
+				       const struct kernel_clone_args *args);
+void shstk_release(struct task_struct *tsk);
+void set_shstk_base(struct task_struct *task, unsigned long shstk_addr, unsigned long size);
+unsigned long get_shstk_base(struct task_struct *task, unsigned long *size);
+void set_active_shstk(struct task_struct *task, unsigned long shstk_addr);
+bool is_shstk_enabled(struct task_struct *task);
+
+#else
+
+#define shstk_alloc_thread_stack(tsk, args) 0
+
+#define shstk_release(tsk)
+
+#define get_shstk_base(task, size) 0UL
+
+#define set_shstk_base(task, shstk_addr, size) do {} while (0)
+
+#define set_active_shstk(task, shstk_addr) do {} while (0)
+
+#define is_shstk_enabled(task) false
+
 #endif /* CONFIG_RISCV_USER_CFI */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 7c244de77180..46f38e53ddec 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -29,6 +29,7 @@
 #include <asm/vector.h>
 #include <asm/cpufeature.h>
 #include <asm/exec.h>
+#include <asm/usercfi.h>
 
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
@@ -211,6 +212,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	unsigned long clone_flags = args->flags;
 	unsigned long usp = args->stack;
 	unsigned long tls = args->tls;
+	unsigned long ssp = 0;
 	struct pt_regs *childregs = task_pt_regs(p);
 
 	/* Ensure all threads in this mm have the same pointer masking mode. */
@@ -229,11 +231,19 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		p->thread.s[0] = (unsigned long)args->fn;
 		p->thread.s[1] = (unsigned long)args->fn_arg;
 	} else {
+		/* allocate new shadow stack if needed. In case of CLONE_VM we have to */
+		ssp = shstk_alloc_thread_stack(p, args);
+		if (IS_ERR_VALUE(ssp))
+			return PTR_ERR((void *)ssp);
+
 		*childregs = *(current_pt_regs());
 		/* Turn off status.VS */
 		riscv_v_vstate_off(childregs);
 		if (usp) /* User fork */
 			childregs->sp = usp;
+		/* if needed, set new ssp */
+		if (ssp)
+			set_active_shstk(p, ssp);
 		if (clone_flags & CLONE_SETTLS)
 			childregs->tp = tls;
 		childregs->a0 = 0; /* Return value of fork() */
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 0b3bbb41490a..ec3d78efd6f3 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -19,6 +19,41 @@
 
 #define SHSTK_ENTRY_SIZE sizeof(void *)
 
+bool is_shstk_enabled(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.ubcfi_en;
+}
+
+void set_shstk_base(struct task_struct *task, unsigned long shstk_addr, unsigned long size)
+{
+	task->thread_info.user_cfi_state.shdw_stk_base = shstk_addr;
+	task->thread_info.user_cfi_state.shdw_stk_size = size;
+}
+
+unsigned long get_shstk_base(struct task_struct *task, unsigned long *size)
+{
+	if (size)
+		*size = task->thread_info.user_cfi_state.shdw_stk_size;
+	return task->thread_info.user_cfi_state.shdw_stk_base;
+}
+
+void set_active_shstk(struct task_struct *task, unsigned long shstk_addr)
+{
+	task->thread_info.user_cfi_state.user_shdw_stk = shstk_addr;
+}
+
+/*
+ * If size is 0, then to be compatible with regular stack we want it to be as big as
+ * regular stack. Else PAGE_ALIGN it and return back
+ */
+static unsigned long calc_shstk_size(unsigned long size)
+{
+	if (size)
+		return PAGE_ALIGN(size);
+
+	return PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G));
+}
+
 /*
  * Writes on shadow stack can either be `sspush` or `ssamoswap`. `sspush` can happen
  * implicitly on current shadow stack pointed to by CSR_SSP. `ssamoswap` takes pointer to
@@ -141,3 +176,88 @@ SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsi
 
 	return allocate_shadow_stack(addr, aligned_size, size, set_tok);
 }
+
+/*
+ * This gets called during clone/clone3/fork. And is needed to allocate a shadow stack for
+ * cases where CLONE_VM is specified and thus a different stack is specified by user. We
+ * thus need a separate shadow stack too. How does separate shadow stack is specified by
+ * user is still being debated. Once that's settled, remove this part of the comment.
+ * This function simply returns 0 if shadow stack are not supported or if separate shadow
+ * stack allocation is not needed (like in case of !CLONE_VM)
+ */
+unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
+				       const struct kernel_clone_args *args)
+{
+	unsigned long addr, size;
+
+	/* If shadow stack is not supported, return 0 */
+	if (!cpu_supports_shadow_stack())
+		return 0;
+
+	/*
+	 * If shadow stack is not enabled on the new thread, skip any
+	 * switch to a new shadow stack.
+	 */
+	if (!is_shstk_enabled(tsk))
+		return 0;
+
+	/*
+	 * For CLONE_VFORK the child will share the parents shadow stack.
+	 * Set base = 0 and size = 0, this is special means to track this state
+	 * so the freeing logic run for child knows to leave it alone.
+	 */
+	if (args->flags & CLONE_VFORK) {
+		set_shstk_base(tsk, 0, 0);
+		return 0;
+	}
+
+	/*
+	 * For !CLONE_VM the child will use a copy of the parents shadow
+	 * stack.
+	 */
+	if (!(args->flags & CLONE_VM))
+		return 0;
+
+	/*
+	 * reaching here means, CLONE_VM was specified and thus a separate shadow
+	 * stack is needed for new cloned thread. Note: below allocation is happening
+	 * using current mm.
+	 */
+	size = calc_shstk_size(args->stack_size);
+	addr = allocate_shadow_stack(0, size, 0, false);
+	if (IS_ERR_VALUE(addr))
+		return addr;
+
+	set_shstk_base(tsk, addr, size);
+
+	return addr + size;
+}
+
+void shstk_release(struct task_struct *tsk)
+{
+	unsigned long base = 0, size = 0;
+	/* If shadow stack is not supported or not enabled, nothing to release */
+	if (!cpu_supports_shadow_stack() || !is_shstk_enabled(tsk))
+		return;
+
+	/*
+	 * When fork() with CLONE_VM fails, the child (tsk) already has a
+	 * shadow stack allocated, and exit_thread() calls this function to
+	 * free it.  In this case the parent (current) and the child share
+	 * the same mm struct. Move forward only when they're same.
+	 */
+	if (!tsk->mm || tsk->mm != current->mm)
+		return;
+
+	/*
+	 * We know shadow stack is enabled but if base is NULL, then
+	 * this task is not managing its own shadow stack (CLONE_VFORK). So
+	 * skip freeing it.
+	 */
+	base = get_shstk_base(tsk, &size);
+	if (!base)
+		return;
+
+	vm_munmap(base, size);
+	set_shstk_base(tsk, 0, 0);
+}

-- 
2.43.0


