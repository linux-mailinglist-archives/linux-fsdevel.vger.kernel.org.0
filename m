Return-Path: <linux-fsdevel+bounces-40882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDF6A2810B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 02:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EDF161FFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 01:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3B622DFA8;
	Wed,  5 Feb 2025 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rv0QE8mO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C822D4DE
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718547; cv=none; b=KOIzAFEOJwpU32sb7l1tBe65uOpLZmzwbnRyRUZbHF4eg322kmDGZQCuaUrnPLPXbDvzmk+RmJGWDTpf4iBpxUphdI45Q3SBJkrSL+klErXJXFT8NDBQaXo65YLmy/3hIvr4Lqlv8g/XEMyAGrJABegqHHTDcQBT+Xj/SUUSHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718547; c=relaxed/simple;
	bh=wI9o+6ZNrC0pPpw2dP6AWMAMeO7BYuPrKSYAS17pkaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0MHCDevJSj2mm8FDt56uGZKiS7hzeLNUVRObzUyZwPIvZHXRSMDv9AaDoJIFK1mzDrJkE1DMR0uXPDWYTZSFO28hsQ0XNbjv/UqkAmUp4O4XS0SmMpHK1QkPMEXN4OOB+9NlPhhx5mNHKBRiqq8GX63fKwEXIFWbd42iX5Vvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rv0QE8mO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21ddab8800bso88859485ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 17:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718544; x=1739323344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZizf8oZeAex4CEwHeMnGWZudkjFQvNzoIsL7CfIy1g=;
        b=rv0QE8mOy7iJu7hyF6Kc1qlOP3mt+hBmHrsf8NcPmvq4Gmp2Zy8yI21EHRKVA3xTM0
         50317HkjwW21o6RqAAKGYR5PyAMzYNOMAOiI0b+yUcuxQjbUZl0+8Pgokyw/4PZ2q1Vk
         zeX5H0ty5cfokKItH6XD0//w8Y5DW6IOLPH1t1/XlDCmOFg81ssyDwIKsWHMchGcwGYH
         oFPiC7X4xflkio5ujKhSqxZJ8FqAkflCdElQZUB1oAv0rFy5MRqz+e/KoSx2Y2Hjozk/
         cpYsvdo++7vRofw9VLzNcENQs7DndIxw5p/xincqJvoACYmhVqDYS+t+zcEIwKCNvhBH
         d7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718544; x=1739323344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZizf8oZeAex4CEwHeMnGWZudkjFQvNzoIsL7CfIy1g=;
        b=mbzA0aPpEO2jXiFD7/O6PxZ9cpZ98Ipw5A2AsUYkb5/MjSOJ0S2NOZxwOTSpbbBHZk
         VTb2vkP3CaTotO7hzx9YW9NIIWx8vLKcXSahviiVISRTGn2+R4Ne4oYksviFqk9r3M1c
         Knji3AmmMDw5A/nJbc26u1ayKKt9yvmLOUrHwihMoC75QgNzirEN8iaaQpAWe+Vq8+mk
         5HwXuJo77ZJfuAY7MeF22hGpAz7KnH16NncN90nVdvCkQftN7ZjoQVVypYUfmnqdJAeK
         LCWz9tNbAqoH0dJDO9TnzKoBAu1zHdtSAvU38WZIlQslM99oi2JNZQWGxB3soVPOtOCW
         tSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHeAHzIZFNbdnYIivXzD6mMpMR16GUrGnpS6SXD039OjACCqtoru2JNhLVl3kQE3gUgVoUmFFIl05zKC3y@vger.kernel.org
X-Gm-Message-State: AOJu0YwAr8MUWDV34YIGwTcWwBIoeiPrfZKCOdsAt9LxAqXyqFi8JsN7
	hRbL9PmEUknD4zNLZPJ1RiGBFNe/BUpL9yNVj01GHK/G3MpqQwa0fGHtqIbUcdc=
X-Gm-Gg: ASbGncvlOeIKRDVgnDpDuG4ChJ/BUOk46OEF5HNKsAt4cVp60fAzrIwj4obgF5k7IpE
	MmXS9lOJnyneT8UxVC9X0k5YmKV1zrk8F+xK7oTowGjvxDSBTe9w44JpqRFS6zatEMxdACFUmVd
	CmsPvtGYfuA9N+qGqWnFkcwSuFXOriQ8/NdnkMUIsNVue5MPr0nR7OHnI1ePdQR2VmV1yEfp3Zj
	U+IDuWbrxO9r7wAdrUOMdBwGksyGAm13fsicLTp3klVJwrZ7g9xkmbkDv46tEPhiH/lHjPo6CeS
	cOc7m5Uvq/PkNHIuG9dEwY8/fw==
X-Google-Smtp-Source: AGHT+IEqJS41+LJt7inAR5iPhE1y82el2DHhoGjAbkJX4IwMn8QFNmHGfzX0UCg4AcbCiAYuTtk5yw==
X-Received: by 2002:a05:6a21:350d:b0:1ed:8cd8:77fb with SMTP id adf61e73a8af0-1ede8836074mr1402463637.16.1738718544490;
        Tue, 04 Feb 2025 17:22:24 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:22:24 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:22:03 -0800
Subject: [PATCH v9 16/26] riscv/signal: save and restore of shadow stack
 for signal
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-v5_user_cfi_series-v9-16-b37a49c5205c@rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
In-Reply-To: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>, 
 Andy Chiu <andybnac@gmail.com>
X-Mailer: b4 0.14.0

Save shadow stack pointer in sigcontext structure while delivering signal.
Restore shadow stack pointer from sigcontext on sigreturn.

As part of save operation, kernel uses `ssamoswap` to save snapshot of
current shadow stack on shadow stack itself (can be called as a save
token). During restore on sigreturn, kernel retrieves token from top of
shadow stack and validates it. This allows that user mode can't arbitrary
pivot to any shadow stack address without having a token and thus provide
strong security assurance between signaly delivery and sigreturn window.

Use ABI compatible way of saving/restoring shadow stack pointer into
signal stack. This follows what Vector extension, where extra registers
are placed in a form of extension header + extension body in the stack.
The extension header indicates the size of the extra architectural
states plus the size of header itself, and a magic identifier of the
extension. Then, the extensions body contains the new architectural
states in the form defined by uapi.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/usercfi.h         | 10 ++++
 arch/riscv/include/uapi/asm/ptrace.h     |  4 ++
 arch/riscv/include/uapi/asm/sigcontext.h |  1 +
 arch/riscv/kernel/signal.c               | 80 ++++++++++++++++++++++++++++++++
 arch/riscv/kernel/usercfi.c              | 56 ++++++++++++++++++++++
 5 files changed, 151 insertions(+)

diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index a8cec7c14d1d..361f59edbdef 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -8,6 +8,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 #include <linux/prctl.h>
+#include <linux/errno.h>
 
 struct task_struct;
 struct kernel_clone_args;
@@ -35,6 +36,9 @@ bool is_shstk_locked(struct task_struct *task);
 bool is_shstk_allocated(struct task_struct *task);
 void set_shstk_lock(struct task_struct *task);
 void set_shstk_status(struct task_struct *task, bool enable);
+unsigned long get_active_shstk(struct task_struct *task);
+int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr);
+int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_ptr);
 bool is_indir_lp_enabled(struct task_struct *task);
 bool is_indir_lp_locked(struct task_struct *task);
 void set_indir_lp_status(struct task_struct *task, bool enable);
@@ -72,6 +76,12 @@ void set_indir_lp_lock(struct task_struct *task);
 
 #define set_indir_lp_lock(task)
 
+#define restore_user_shstk(tsk, shstk_ptr) -EINVAL
+
+#define save_user_shstk(tsk, saved_shstk_ptr) -EINVAL
+
+#define get_active_shstk(task) 0UL
+
 #endif /* CONFIG_RISCV_USER_CFI */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index a38268b19c3d..659ea3af5680 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -127,6 +127,10 @@ struct __riscv_v_regset_state {
  */
 #define RISCV_MAX_VLENB (8192)
 
+struct __sc_riscv_cfi_state {
+	unsigned long ss_ptr;   /* shadow stack pointer */
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI_ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/include/uapi/asm/sigcontext.h
index cd4f175dc837..f37e4beffe03 100644
--- a/arch/riscv/include/uapi/asm/sigcontext.h
+++ b/arch/riscv/include/uapi/asm/sigcontext.h
@@ -10,6 +10,7 @@
 
 /* The Magic number for signal context frame header. */
 #define RISCV_V_MAGIC	0x53465457
+#define RISCV_ZICFISS_MAGIC		0x9487
 #define END_MAGIC	0x0
 
 /* The size of END signal context header. */
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 80c70dccf09f..a7472a6fcdca 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -22,11 +22,13 @@
 #include <asm/vector.h>
 #include <asm/csr.h>
 #include <asm/cacheflush.h>
+#include <asm/usercfi.h>
 
 unsigned long signal_minsigstksz __ro_after_init;
 
 extern u32 __user_rt_sigreturn[2];
 static size_t riscv_v_sc_size __ro_after_init;
+static size_t riscv_zicfiss_sc_size __ro_after_init;
 
 #define DEBUG_SIG 0
 
@@ -140,6 +142,62 @@ static long __restore_v_state(struct pt_regs *regs, void __user *sc_vec)
 	return copy_from_user(current->thread.vstate.datap, datap, riscv_v_vsize);
 }
 
+static long save_cfiss_state(struct pt_regs *regs, void __user *sc_cfi)
+{
+	struct __sc_riscv_cfi_state __user *state = sc_cfi;
+	unsigned long ss_ptr = 0;
+	long err = 0;
+
+	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI) || !is_shstk_enabled(current))
+		return 0;
+
+	/*
+	 * Save a pointer to shadow stack itself on shadow stack as a form of token.
+	 * A token on shadow gives following properties
+	 * - Safe save and restore for shadow stack switching. Any save of shadow stack
+	 *   must have had saved a token on shadow stack. Similarly any restore of shadow
+	 *   stack must check the token before restore. Since writing to shadow stack with
+	 *   address of shadow stack itself is not easily allowed. A restore without a save
+	 *   is quite difficult for an attacker to perform.
+	 * - A natural break. A token in shadow stack provides a natural break in shadow stack
+	 *   So a single linear range can be bucketed into different shadow stack segments. Any
+	 *   sspopchk will detect the condition and fault to kernel as sw check exception.
+	 */
+	err |= save_user_shstk(current, &ss_ptr);
+	err |= __put_user(ss_ptr, &state->ss_ptr);
+	if (unlikely(err))
+		return -EFAULT;
+
+	return riscv_zicfiss_sc_size;
+}
+
+static long __restore_cfiss_state(struct pt_regs *regs, void __user *sc_cfi)
+{
+	struct __sc_riscv_cfi_state __user *state = sc_cfi;
+	unsigned long ss_ptr = 0;
+	long err;
+
+	/*
+	 * Restore shadow stack as a form of token stored on shadow stack itself as a safe
+	 * way to restore.
+	 * A token on shadow gives following properties
+	 * - Safe save and restore for shadow stack switching. Any save of shadow stack
+	 *   must have had saved a token on shadow stack. Similarly any restore of shadow
+	 *   stack must check the token before restore. Since writing to shadow stack with
+	 *   address of shadow stack itself is not easily allowed. A restore without a save
+	 *   is quite difficult for an attacker to perform.
+	 * - A natural break. A token in shadow stack provides a natural break in shadow stack
+	 *   So a single linear range can be bucketed into different shadow stack segments.
+	 *   sspopchk will detect the condition and fault to kernel as sw check exception.
+	 */
+	err = __copy_from_user(&ss_ptr, &state->ss_ptr, sizeof(unsigned long));
+
+	if (unlikely(err))
+		return err;
+
+	return restore_user_shstk(current, ss_ptr);
+}
+
 struct arch_ext_priv {
 	__u32 magic;
 	long (*save)(struct pt_regs *regs, void __user *sc_vec);
@@ -150,6 +208,10 @@ struct arch_ext_priv arch_ext_list[] = {
 		.magic = RISCV_V_MAGIC,
 		.save = &save_v_state,
 	},
+	{
+		.magic = RISCV_ZICFISS_MAGIC,
+		.save = &save_cfiss_state,
+	},
 };
 
 const size_t nr_arch_exts = ARRAY_SIZE(arch_ext_list);
@@ -202,6 +264,12 @@ static long restore_sigcontext(struct pt_regs *regs,
 
 			err = __restore_v_state(regs, sc_ext_ptr);
 			break;
+		case RISCV_ZICFISS_MAGIC:
+			if (!is_shstk_enabled(current) || size != riscv_zicfiss_sc_size)
+				return -EINVAL;
+
+			err = __restore_cfiss_state(regs, sc_ext_ptr);
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -222,6 +290,10 @@ static size_t get_rt_frame_size(bool cal_all)
 		if (cal_all || riscv_v_vstate_query(task_pt_regs(current)))
 			total_context_size += riscv_v_sc_size;
 	}
+
+	if (is_shstk_enabled(current))
+		total_context_size += riscv_zicfiss_sc_size;
+
 	/*
 	 * Preserved a __riscv_ctx_hdr for END signal context header if an
 	 * extension uses __riscv_extra_ext_header
@@ -365,6 +437,11 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 #ifdef CONFIG_MMU
 	regs->ra = (unsigned long)VDSO_SYMBOL(
 		current->mm->context.vdso, rt_sigreturn);
+
+	/* if bcfi is enabled x1 (ra) and x5 (t0) must match. not sure if we need this? */
+	if (is_shstk_enabled(current))
+		regs->t0 = regs->ra;
+
 #else
 	/*
 	 * For the nommu case we don't have a VDSO.  Instead we push two
@@ -493,6 +570,9 @@ void __init init_rt_signal_env(void)
 {
 	riscv_v_sc_size = sizeof(struct __riscv_ctx_hdr) +
 			  sizeof(struct __sc_riscv_v_state) + riscv_v_vsize;
+
+	riscv_zicfiss_sc_size = sizeof(struct __riscv_ctx_hdr) +
+			  sizeof(struct __sc_riscv_cfi_state);
 	/*
 	 * Determine the stack space required for guaranteed signal delivery.
 	 * The signal_minsigstksz will be populated into the AT_MINSIGSTKSZ entry
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 3a66f149a4ef..6e561256bfaf 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -52,6 +52,11 @@ void set_active_shstk(struct task_struct *task, unsigned long shstk_addr)
 	task->thread_info.user_cfi_state.user_shdw_stk = shstk_addr;
 }
 
+unsigned long get_active_shstk(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.user_shdw_stk;
+}
+
 void set_shstk_status(struct task_struct *task, bool enable)
 {
 	task->thread_info.user_cfi_state.ubcfi_en = enable ? 1 : 0;
@@ -164,6 +169,57 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
 	return 0;
 }
 
+/*
+ * Save user shadow stack pointer on shadow stack itself and return pointer to saved location
+ * returns -EFAULT if operation was unsuccessful
+ */
+int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_ptr)
+{
+	unsigned long ss_ptr = 0;
+	unsigned long token_loc = 0;
+	int ret = 0;
+
+	if (saved_shstk_ptr == NULL)
+		return -EINVAL;
+
+	ss_ptr = get_active_shstk(tsk);
+	ret = create_rstor_token(ss_ptr, &token_loc);
+
+	if (!ret) {
+		*saved_shstk_ptr = token_loc;
+		set_active_shstk(tsk, token_loc);
+	}
+
+	return ret;
+}
+
+/*
+ * Restores user shadow stack pointer from token on shadow stack for task `tsk`
+ * returns -EFAULT if operation was unsuccessful
+ */
+int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr)
+{
+	unsigned long token = 0;
+
+	token = amo_user_shstk((unsigned long __user *)shstk_ptr, 0);
+
+	if (token == -1)
+		return -EFAULT;
+
+	/* invalid token, return EINVAL */
+	if ((token - shstk_ptr) != SHSTK_ENTRY_SIZE) {
+		pr_info_ratelimited(
+			"%s[%d]: bad restore token in %s: pc=%p sp=%p, token=%p, shstk_ptr=%p\n",
+			tsk->comm, task_pid_nr(tsk), __func__, (void *)(task_pt_regs(tsk)->epc),
+			(void *)(task_pt_regs(tsk)->sp), (void *)token, (void *)shstk_ptr);
+		return -EINVAL;
+	}
+
+	/* all checks passed, set active shstk and return success */
+	set_active_shstk(tsk, token);
+	return 0;
+}
+
 static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long size,
 					   unsigned long token_offset, bool set_tok)
 {

-- 
2.34.1


