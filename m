Return-Path: <linux-fsdevel+bounces-70873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A2ECA8FD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 20:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6E3230F1E8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8C83559D1;
	Fri,  5 Dec 2025 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Eti7NAMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D6352947
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959864; cv=none; b=NRo6M+R62afu3KTxE1evte0EAj2ByJZxhyJoHTTb3mylq3AqRuNeVN10p23Fxdf3q8EMKvVTXYe/w3DdJ5UXOjNndptVxdO+RSVs8gRbwXr0Ugp5Y4/mmSXK5OmZTAZAzvIsliNEFa3LWMx0DgnVfjcu2sQeSMw2G1EoBnnQ8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959864; c=relaxed/simple;
	bh=UW9zPS2E4TbdsfJtyu+1aU02XU1fbJS+cjnllb5pNMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HJmDrwdnrYbHToDcW7c1zr+hHJtrTlfZyVEJ8U2IiercPVLZ/pMq8rC3KE142qhy9x/vhtOKgpRySKsGJ/B1wN/57D2zGVKgsY08KVA2Vi19/TM1dptSMuW+lQYDZ1e1RUC8zrMmx+ee1pcfwnHnh4SgjkXEPCEs7vYZK/Q1qHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Eti7NAMz; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b553412a19bso2097610a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 10:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959852; x=1765564652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RnuI2UkBizC29w22/jrSl2sQbK2qqJuozv4nJOkh7A=;
        b=Eti7NAMzlBvkKb6WAYOU/DO+PWtVDnlK+f42aTLd1VbFwYn50ahDvXPFmnwEl66rI7
         ZQt0U5j79/QuPOT7lUQFd9N7wSM/JdmUj9GM8HiI6RCPYIYzZWdbjZxaLZyyqV/l879R
         O4Tr50OaJi8Dr0v2ik0XpwWQEwFO2mxKJo/ZlFj06HBXr62CpryH95qj1rgzAQcCAo0w
         FeeVbWtuK1BWa1A+KV6J+i0iyyfspy8CyjLIb87DneabUsG/ibckBzViafa1TeFB6zYn
         IeORzFVtYr4N1goBgXd0CI61nOJBq1Ith78X1WutIdqd1argMkMTUUgQX3Bggswvefu8
         bzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959852; x=1765564652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7RnuI2UkBizC29w22/jrSl2sQbK2qqJuozv4nJOkh7A=;
        b=rEAbh14TGMSnZfWF0At5yBTu88itJqdeSFBzZNykdxMHhtzRye69Icj2Nslu6U3PDo
         pwf3qqI+oGnJUHDw6A70EX3SIcTNX3RU2bCD+qVKriyQTFY3gawZvWjVzwj68PXmRBXQ
         NAoOAkfa9D4hMtf4AqxWitwGrGM9qXDwmi8iP5OxPl0iPtrwaGVfaBVB1bmlxRI3baw4
         HDD31W24PbMP76xIIfsSQX5LSP/lJ/g2PgdH2spWxu0ScQWOenH15fxZqqW5IAr+Vo+s
         nBXdgwv9RIR4E7P65H3Pg8ml/Z0TDOvEK2QEf34DW4CAyZMAWIe8/FfIRN9jUD7p1hIx
         0CuA==
X-Forwarded-Encrypted: i=1; AJvYcCVlISvI29U/kT4quqtCxY4lFBPEwKZFgtA9jSeL7VKxgf1c//lFWM2EElndb3B4OxNTdLyfns4sq7j/E++t@vger.kernel.org
X-Gm-Message-State: AOJu0Yxurv65d7GHoyMRotfwsPYWRYFidWHOMEIeZ3rPDbxA7Lw2KcBY
	V3QFlnLWxWKvZIZ0mJeejq9CD8jTXXMUL9+OrVIVSSQvKvMrzq5OLNKX67g0XXtde5w=
X-Gm-Gg: ASbGnctXFvoCn6SSRsDWUKkqhHfX/OSl4SJjq0oZTYRuKfVcETkI/bEiXnn/yEvnAQe
	TxFSvQdmUsORQPakguu/wUUAU2yfDsPth2yH5ppfsb2XEG6zjG6l3QGUzmbYUpkrQWnWBQWGbVE
	4szmz9I0+A4dpMTvAHw8ul6h1KrLFiTvkAcVnSR0LOirdz8bR+5Z/SITsnXGMb685E2sXnpwfCB
	CUup6d1i34p+bnLBwYwzI2gK4bo2N1nfHX/w4OymTXYJqXndmGH1ii5dBpZXtbwv4aQyeVfDLBa
	umsRoxkHXR6K44obQpjYoU8MIMzcDUo0PV9MehznzkElWofRvVy84BfOYIdtevH8CwmkcNB2Rf1
	5+IusQK4AI/WefvZrAyz64VhPEaSZ37zTMH5v+uNOAzwW0H6XZE3ib5PQmz8tNkncSYBlamTEKZ
	I4waM/+slCR9JB5RXKkXYi
X-Google-Smtp-Source: AGHT+IFwWQQuMqwR1+ed74jDMY/CSXapqooDG8iNUOlxCqzdKYEOKwnXkGf4vaTbspDREQ1pfREY3Q==
X-Received: by 2002:a05:7300:ce8d:b0:2a4:3593:6450 with SMTP id 5a478bee46e88-2abc6f4d29dmr119392eec.0.1764959852461;
        Fri, 05 Dec 2025 10:37:32 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm23933342eec.1.2025.12.05.10.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:37:31 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 05 Dec 2025 10:37:08 -0800
Subject: [PATCH v25 22/28] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v5_user_cfi_series-v25-22-8a3570c3e145@rivosinc.com>
References: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
In-Reply-To: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764959808; l=2983;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=UW9zPS2E4TbdsfJtyu+1aU02XU1fbJS+cjnllb5pNMY=;
 b=f2KU+fCOkVj7mMjxZQYYSKXqi4DC7zhXlZZWWremH2iJ9TKnGVTmf9UQKwNWQYisAJhI9NDY8
 wDPYzH1n8XfDJHQBz0URPXJgVJBe8mEcqmkwauMK0YTBxPK3RkLVc7B
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


