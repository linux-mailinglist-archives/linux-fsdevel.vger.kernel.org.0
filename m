Return-Path: <linux-fsdevel+bounces-56470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C461B179BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 01:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DF33B0AAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 23:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A0727FD62;
	Thu, 31 Jul 2025 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xwl4NK0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBC4288C81
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754004006; cv=none; b=LLjuuufXXmvcoZC6ud94q2hQNGdbtKhIs/O0Kdd4wX6u6usy4bEY8/CBngVRPlETyw7dzpWpzBv3NzBZrT7ECx5dHK0KcQ6v1kRE5zkC4CG30bz0Rd2kYUMZR/E4gU2cHzJL+S4H6P9e42mt5Su9nlDo6Ipa3zlcR3uYsP+4KPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754004006; c=relaxed/simple;
	bh=9FILi955Wveqh4hd8I3dWtGVSB0h58Jyz6Fpva9/ZqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9p9WUU4QEhx6Fnyh8oSfwFe9mfzn4r5Z5p8uF5ocQHucdmE/5A+Cm517QpR5lVRP65Sx+4cv0u2M8U3eYrP+Xpy/0DWmZzpIUFqn0zxU2UiIrM2/vfv7F2ctt4RAiBEMoKpiU0lT9ZYz5LUPYtn/MScK8bHaLr5nmCwYQSftcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xwl4NK0y; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31f017262d9so1162501a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 16:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1754004004; x=1754608804; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KN7qsbRJwSpz1U0f3zKk0nPzS36Kgnagxj2tSzWZKOM=;
        b=xwl4NK0yrI2M4BbXXKZ+Cze5MyRWfqvVomJIdzVFu7mbN7CltOKmxOvU1xztxTgEnZ
         sLNYHYiCYrDxy3leFHopLbYG1de4W4oVWKrEufFF/aWJe9c55vDSNama288X9DOSGWiH
         T21bqzgcFy3tnPS8KZz6LHumY4GTc+RIBkbGU4ZBPzPe1gLuMz/vYsYdxWPBsnjHyqI1
         MIfllHmc30Pq+lQhtDly9tRHFP4n/rrDJ1YxiEevOw6kA35jdTC2kRuvJ8jjhqJx8/F8
         9KRBiLNQsNRZP1jlPeY8qsiEk++zosUaGIPTswz2Co9Y1vmDgfstBSQ1lPJWN4sR8gHH
         4hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754004004; x=1754608804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KN7qsbRJwSpz1U0f3zKk0nPzS36Kgnagxj2tSzWZKOM=;
        b=gAH7KN4V2/1dS8tjjtsJd/W+vvnjQOl1kTeTkAEtVKR6VoAxNbBC3Ze+coAgvK3WEX
         zk4taFwTL6GNGxG9RMPNfgIdc2XvKbUkv1E5HkjlvxjRZcpX/poFCqoGV0JklLQkppGT
         s4fi2aYQ+rVxmvRZmgO4Nf4IzcBLyU2P2y5Kl8JloixpsdWbtX1rM8sN5boiKmkPdvc1
         LWZI/iEeoFGSgoxnrqINfmzcz8st1Pix76iSy3ZLOAxpJiYt3OTfZUk08CR3jczFjK3D
         WiifZ1lG1mWPnR4ClnqtjvQVv0TXctpQPGvPhBYs9gWAyfo1cDfKoUK1P2Wh/MMa4xwT
         qHMg==
X-Forwarded-Encrypted: i=1; AJvYcCVqOSVKqVajFqZLsqalIMcgWKRRpnZfCIucE5AEipOLB8jNRSRYjWvQgr9AqpKVXu+yN9+HTGSrNVy9NXTo@vger.kernel.org
X-Gm-Message-State: AOJu0YxbqMeqJ4crozZ70i3sDwjoDjfia3ZjateiMajFkgwY8MYIutSf
	K2vcMwX19rlP0uhhjtBsI1f7/4tCe694Ai0MSluJ92T6i24K06SqoDTI8WZa0ltxZ6o=
X-Gm-Gg: ASbGncsrs0n6XMduYu6So1EUqCoPPwVLlTTJdh1mfU130JJnqS5CzLh2W1PVV+0KBbs
	EUOxlS672k2GKS+aypf+hL7jBnHhdncJ+5U74VatAnp0sEMK4Wf6saYFtJDhkYsLAUuJR0OfLQ8
	A2AqKVUUgInASE3xuq8rw+eJ3t4WgWvuNdKEuYoMLFVxC/ne/wAheTPLUep0LTXoL1hffHPiwSR
	lwQkJ548d2qHPH57PjNby/Nnr/XiX1/fMtCKrOG/FshhmPR3ZKllhJcb0UwINUGO5BbUpqG/7+4
	LfeVSI/U/c7imLKPGQdPmYBEBaItTCoZgtEKS+SVrc5+U/t+UY53U52vGppKCLfnx3UeuKxg05l
	kw6utAFTNN4vTnJQSgriInQD1EiLIF+u//3jtfJV0Qg4=
X-Google-Smtp-Source: AGHT+IHxrpjZfo/l2y5A/sxDDgOjavtB+BTRcJEcuhmKIdHQ5XFEf+Qh+iYbm7p4G9u0Pc3Qv/HPIw==
X-Received: by 2002:a17:90b:3ecb:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-31f5dd7f473mr11237625a91.5.1754004004235;
        Thu, 31 Jul 2025 16:20:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5773085a91.7.2025.07.31.16.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:20:03 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 31 Jul 2025 16:19:25 -0700
Subject: [PATCH v19 15/27] riscv/traps: Introduce software check exception
 and uprobe handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-v5_user_cfi_series-v19-15-09b468d7beab@rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
In-Reply-To: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
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
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
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

zicfiss / zicfilp introduces a new exception to priv isa `software check
exception` with cause code = 18. This patch implements software check
exception.

Additionally it implements a cfi violation handler which checks for code
in xtval. If xtval=2, it means that sw check exception happened because of
an indirect branch not landing on 4 byte aligned PC or not landing on
`lpad` instruction or label value embedded in `lpad` not matching label
value setup in `x7`. If xtval=3, it means that sw check exception happened
because of mismatch between link register (x1 or x5) and top of shadow
stack (on execution of `sspopchk`).

In case of cfi violation, SIGSEGV is raised with code=SEGV_CPERR.
SEGV_CPERR was introduced by x86 shadow stack patches.

To keep uprobes working, handle the uprobe event first before reporting
the CFI violation in software-check exception handler. Because when the
landing pad is activated, if the uprobe point is set at the lpad
instruction at the beginning of a function, the system triggers a software
-check exception instead of an ebreak exception due to the exception
priority, then uprobe can't work successfully.

Co-developed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/asm-prototypes.h |  1 +
 arch/riscv/include/asm/entry-common.h   |  2 ++
 arch/riscv/kernel/entry.S               |  3 ++
 arch/riscv/kernel/traps.c               | 54 +++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index a9988bf21ec8..41ec5cdec367 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -51,6 +51,7 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_u);
 DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
 DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
 DECLARE_DO_ERROR_INFO(do_trap_break);
+DECLARE_DO_ERROR_INFO(do_trap_software_check);
 
 asmlinkage void ret_from_fork_kernel(void *fn_arg, int (*fn)(void *), struct pt_regs *regs);
 asmlinkage void ret_from_fork_user(struct pt_regs *regs);
diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index b28ccc6cdeea..34ed149af5d1 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -40,4 +40,6 @@ static inline int handle_misaligned_store(struct pt_regs *regs)
 }
 #endif
 
+bool handle_user_cfi_violation(struct pt_regs *regs);
+
 #endif /* _ASM_RISCV_ENTRY_COMMON_H */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 633d66b5ae71..09954c6835ef 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -494,6 +494,9 @@ SYM_DATA_START_LOCAL(excp_vect_table)
 	RISCV_PTR do_page_fault   /* load page fault */
 	RISCV_PTR do_trap_unknown
 	RISCV_PTR do_page_fault   /* store page fault */
+	RISCV_PTR do_trap_unknown /* cause=16 */
+	RISCV_PTR do_trap_unknown /* cause=17 */
+	RISCV_PTR do_trap_software_check /* cause=18 is sw check exception */
 SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
 
 #ifndef CONFIG_MMU
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 9c83848797a7..2489abbbdb5d 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -364,6 +364,60 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 }
 
+#define CFI_TVAL_FCFI_CODE	2
+#define CFI_TVAL_BCFI_CODE	3
+/* handle cfi violations */
+bool handle_user_cfi_violation(struct pt_regs *regs)
+{
+	unsigned long tval = csr_read(CSR_TVAL);
+	bool is_fcfi = (tval == CFI_TVAL_FCFI_CODE && cpu_supports_indirect_br_lp_instr());
+	bool is_bcfi = (tval == CFI_TVAL_BCFI_CODE && cpu_supports_shadow_stack());
+
+	/*
+	 * Handle uprobe event first. The probe point can be a valid target
+	 * of indirect jumps or calls, in this case, forward cfi violation
+	 * will be triggered instead of breakpoint exception. Clear ELP flag
+	 * on sstatus image as well to avoid recurring fault.
+	 */
+	if (is_fcfi && probe_breakpoint_handler(regs)) {
+		regs->status &= ~SR_ELP;
+		return true;
+	}
+
+	if (is_fcfi || is_bcfi) {
+		do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,
+			      "Oops - control flow violation");
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * software check exception is defined with risc-v cfi spec. Software check
+ * exception is raised when:-
+ * a) An indirect branch doesn't land on 4 byte aligned PC or `lpad`
+ *    instruction or `label` value programmed in `lpad` instr doesn't
+ *    match with value setup in `x7`. reported code in `xtval` is 2.
+ * b) `sspopchk` instruction finds a mismatch between top of shadow stack (ssp)
+ *    and x1/x5. reported code in `xtval` is 3.
+ */
+asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		irqentry_enter_from_user_mode(regs);
+
+		/* not a cfi violation, then merge into flow of unknown trap handler */
+		if (!handle_user_cfi_violation(regs))
+			do_trap_unknown(regs);
+
+		irqentry_exit_to_user_mode(regs);
+	} else {
+		/* sw check exception coming from kernel is a bug in kernel */
+		die(regs, "Kernel BUG");
+	}
+}
+
 #ifdef CONFIG_MMU
 asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 {

-- 
2.43.0


