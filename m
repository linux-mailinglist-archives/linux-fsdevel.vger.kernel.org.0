Return-Path: <linux-fsdevel+bounces-70727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE852CA5399
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 21:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D5623099886
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF73F34B438;
	Thu,  4 Dec 2025 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="YkcNXgUv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B7350D70
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878686; cv=none; b=XRy7bl0955n7g0sYB+hECsEsovzVgkY+R1RDrBJWIGRKYqvd01SFD8VI9pY9QgwMPXEEdYiHGY5MTNSd81eyffpNbscd5iKR2wrw40Vnvxo/aAn1OPUJNJRknfDwlSWhkc1R2RRq3fpcC1tMUOm5OPp8aajCQQbpu2mRbu1U4RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878686; c=relaxed/simple;
	bh=UW9zPS2E4TbdsfJtyu+1aU02XU1fbJS+cjnllb5pNMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svSaz77HKwRyjJT5VsJeRmOJC0/tUcGjF6/OmLNs7rsp/BKb2GRBSBA3YMJgRpcNC3zRodEDtjqW3s9Oj8luZ+1cc2ydO2UllMJbmuoUS2+E+Qf6k+rdetVrRQbFteYtI264IaFZNyAQWDcaX0hEYe0TgRkUw0Sx7DQsx5EJzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=YkcNXgUv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso1727493b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 12:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764878683; x=1765483483; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RnuI2UkBizC29w22/jrSl2sQbK2qqJuozv4nJOkh7A=;
        b=YkcNXgUvVWZ1gIR3SSVYpWlWvpyeX9jlUg+aC3mHNuLrEJ7jm2IV3zJS9jh6HDaB60
         zyTVTrTJD4x5txZ2qfxQTVbIbKzUn9VNuIRKOaiXaGAuOQrTkLsDag1adBILPnT8NExQ
         1LuomDV90rO92nRMB+P4DJfKDMKyqF4EITb9UJxMHUp8QoAS5SQLiBvYOgM7F4rWrUuy
         taK9iae2XHkTrVrWUrE4UoMwnD3EydQxcKYX9+PwrTKl6hVDfasL7fdjgmuxSLSuZ1zx
         vo8MElMaJr2EhnT+n70T9oNM3/1BUwHLDyZ/EIh68/r2YvDu+ygdop9Zj/dWjYb0GEPj
         0CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878683; x=1765483483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7RnuI2UkBizC29w22/jrSl2sQbK2qqJuozv4nJOkh7A=;
        b=kuG6FIbgF6sHDb5MCiKwWOyBK3Cj/7F6hMjDrYfeHWJod1ZE5npxjI/QOVjobK65KG
         UHuDwXnuWVVt2sW/aUWkfZw7+YSACn7VKeDD/EgJ7JtbNmMHIeDAtLN+nY5OJHW/z6Xu
         M7BnFuDPpfNjUERe63vqvvMzRU3zskHcOZPjTgtkH+dUtd8tpULqxUJRDtqEigyc3UDX
         SK3B1qtHlqpvG+qwsSjkWGK1CwZgAFy7YZqLpptsFG6fyDryAzJNyxgNVPcBq/bGG14T
         EWMNKJjpYnWFsQtkTDgz8kt2Dv/6fbBhNsE4n8vAxJKFhgpWqP0MytGFjTGNuQcwRCLt
         ZohA==
X-Forwarded-Encrypted: i=1; AJvYcCXMMv26sOrPXXFyzcrU3rasCWeLYYS0w8i/pBWlvnacI8Jyp4nA1DPxI14zfEQ9BBjjOO4StXiNOQK60fm+@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/yNSUZQ4ijBbgTgGD9zd7moLg13TDlqHbUHPicuc8P6xrqV5
	J+MkwQD4mZ0RabFpRozWuFjnzuChoTsW/EtLDdHSH/wT/MwEJ6lwn/RF1yZ3FpI03RI=
X-Gm-Gg: ASbGnctCh0T8Rs7Sb+6A6NgP11bJZjS3wB9mztgtp5uTneT32VsqpTxXebQWSFcdr+i
	9+OKnhEohE8HR1HzUT567yj0mR14lam6jtkA32z7RpHcZPMtDR/AzXOdxV5XpGZo4jGSTADpkU6
	blGb6zF9coHFfvQcYU9VOM8vQ5Askc45To+yuAZgRdS8PtS/yuofTrrfyHfUjZbYlawq0woqL2N
	TjuPMAEk2VGfFLjaa6vFBwOIKSDEz8Bliu/57AqB0AfcEMmOL5wc2DSzSi5/0/aFKiwQcAEoE8c
	sFB2afuR7/pWeyz9jJx2YZ/ZAiwlLQITyC+wrIri5qJkz97eRUd51myJfyRMz6iqsSZf03WBnBm
	9sucNtfflCMUwBy0LWhL1akEK9fCm8QJtw9mED+O4dCxlHGMSw5NwJAZJlzt76Goqp43Wrfr+u+
	Z5+eY8exKPEvbzu13kzWFR
X-Google-Smtp-Source: AGHT+IF16MKXc3hQ084pupi13Dl2urHAgrpT88m6eiVRkvjF23PTTOUeQTpFrtMGdK1aUuGo06V0dg==
X-Received: by 2002:a05:7022:90b:b0:11b:ceee:b78a with SMTP id a92af1059eb24-11df0be1472mr5168873c88.19.1764878682485;
        Thu, 04 Dec 2025 12:04:42 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm10417454c88.6.2025.12.04.12.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:04:41 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 04 Dec 2025 12:04:11 -0800
Subject: [PATCH v24 22/28] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-v5_user_cfi_series-v24-22-ada7a3ba14dc@rivosinc.com>
References: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
In-Reply-To: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, 
 Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764878636; l=2983;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=UW9zPS2E4TbdsfJtyu+1aU02XU1fbJS+cjnllb5pNMY=;
 b=WuDcgJ62IvLXPFgLcbkpSl0esymJQ5NG1MpKico0xKW3dN4w1YBch3Z3iJoZAFZASJeAR5ose
 QSMma6B9ys2A3GbTrz8rpZ2vK5fiaUGL2oKnDU3DgoW8pbHwXIyIDhd
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

Kernel will have to perform shadow stack operations on user shadow stack.
Like during signal delivery and sigreturn, shadow stack token must be
created and validated respectively. Thus shadow stack access for kernel
must be enabled.

In future when kernel shadow stacks are enabled for linux kernel, it must
be enabled as early as possible for better coverage and prevent imbalance
between regular stack and shadow stack. After `relocate_enable_mmu` has
been done, this is as early as possible it can enabled.

Reviewed-by: Zong Li <zong.li@sifive.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/asm-offsets.c |  6 ++++++
 arch/riscv/kernel/head.S        | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 8a2b2656cb2f..af827448a609 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -533,4 +533,10 @@ void asm_offsets(void)
 	DEFINE(FREGS_A6,	    offsetof(struct __arch_ftrace_regs, a6));
 	DEFINE(FREGS_A7,	    offsetof(struct __arch_ftrace_regs, a7));
 #endif
+#ifdef CONFIG_RISCV_SBI
+	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
+	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
+	DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
+	DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
+#endif
 }
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index bdf3352acf4c..9c99c5ad6fe8 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -15,6 +15,7 @@
 #include <asm/image.h>
 #include <asm/scs.h>
 #include <asm/xip_fixup.h>
+#include <asm/usercfi.h>
 #include "efi-header.S"
 
 __HEAD
@@ -170,6 +171,19 @@ secondary_start_sbi:
 	call relocate_enable_mmu
 #endif
 	call .Lsetup_trap_vector
+#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_USER_CFI)
+	li a7, SBI_EXT_FWFT
+	li a6, SBI_EXT_FWFT_SET
+	li a0, SBI_FWFT_SHADOW_STACK
+	li a1, 1 /* enable supervisor to access shadow stack access */
+	li a2, SBI_FWFT_SET_FLAG_LOCK
+	ecall
+	beqz a0, 1f
+	la a1, riscv_nousercfi
+	li a0, CMDLINE_DISABLE_RISCV_USERCFI_BCFI
+	REG_S a0, (a1)
+1:
+#endif
 	scs_load_current
 	call smp_callin
 #endif /* CONFIG_SMP */
@@ -330,6 +344,19 @@ SYM_CODE_START(_start_kernel)
 	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	addi sp, sp, -PT_SIZE_ON_STACK
+#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_USER_CFI)
+	li a7, SBI_EXT_FWFT
+	li a6, SBI_EXT_FWFT_SET
+	li a0, SBI_FWFT_SHADOW_STACK
+	li a1, 1 /* enable supervisor to access shadow stack access */
+	li a2, SBI_FWFT_SET_FLAG_LOCK
+	ecall
+	beqz a0, 1f
+	la a1, riscv_nousercfi
+	li a0, CMDLINE_DISABLE_RISCV_USERCFI_BCFI
+	REG_S a0, (a1)
+1:
+#endif
 	scs_load_current
 
 #ifdef CONFIG_KASAN

-- 
2.45.0


