Return-Path: <linux-fsdevel+bounces-64762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8E7BF3895
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B132F4F0EBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 20:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C8A33374E;
	Mon, 20 Oct 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="BdVUmgiN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5D33291F
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993629; cv=none; b=mWqwpnp9L6cWFp2dgdsKHmCTGnX4+1LCq1totc3kyGzjDIdPj8I9RiyxsL2j7LIW1Z2EotbAqEcOGqlqO1uwhG49vmkblm2zab2aOXIieL7lqMazxif1JRx6ijfs6yVHVLvXbgFinBb2UgzCMlEWQPGFKUgqBLjWRN47qIlz3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993629; c=relaxed/simple;
	bh=R6UcK7O0yzGwyniKw/erlt2J+KJFzK3qt2jdwKTD2UE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N99/pum+VcFdBnX2zusna8PzJFZb+x3lV5F3+SkcU0LN0G1xoMdcrb1MObDTJ2PSNUlEf1awPszbJuo0MRP1QtP+wPTOyxYq/OmqHS7EeSY8imce38V0iFtmdycENr7G8GfOodjkjKDPU3Z15e6VRUCG4o8wGz1esiRbKkqHXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=BdVUmgiN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-789fb76b466so4010717b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760993625; x=1761598425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MT7G2FWEtOvbLIeJ4rFRIEDlr9+XyxGZrLE08/iHBzA=;
        b=BdVUmgiNbP3ZNiF+hZXU/oN1iVuLe1gyRa5SNi+uPgUMKBHtgzAJnfknaChY6QWfSG
         Suc12OUb8U9aniAFtKCQ4v8fi+YyFXNiDzwBNqpjYeX1IrIUSIRsRRa1REPxLzfYjmnz
         A2/kYIEtKi2dbGIEksVbxXtvS+9sLqGYzXgQHQU5EdRARt6FKmdgn5JzV5mg6AeJQ2xW
         nWhP5vc/riwnX0cn633PAoMvkSTjwJYhSF3q7bdlU6XCf+DnHDod6GHo+AIWV0V49XDW
         zjoekJOgq++FrJCy1IZ4FsSAYzHaKgG4gPDoXNlHXS2ulnOQWRgjR1+ZQL1XlylqDsgF
         CsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993625; x=1761598425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MT7G2FWEtOvbLIeJ4rFRIEDlr9+XyxGZrLE08/iHBzA=;
        b=TgSdipUx2CvlsJkj7eGt8OZcejdxUi+TE0J4N7v4NgNwqz/wcRo4RZDxcYYsJYx6Hz
         at04wT+s9B6zyCmy0VrA+UjEiahhgISsr/+Iv01bVZ8C5SIcoIc9vbHf6bau28bkXUzY
         1vRQbn9M6hYC3wlCLVlUnpPx0Osrt3msOmIifTAL1hrVV2ffWZRRkC7KHx/KUusxdGp1
         sa2112yrHj4o4GggXnvIGrPGeEswD/X7ox8nUUYBOCCZMeLDB7m3Khw7dUzD7LSHs9fQ
         SlLZFZtdfok8GHHAYL3gbLatW4G+IH/Tq8PepRnmB0g4rIketF7QnSRuHGS0/eRHB9VG
         Ctdg==
X-Forwarded-Encrypted: i=1; AJvYcCW/YVRhz7HX67k8u9/oaTMFSKtSwb2rrH2akYF5v7G9qa7Xmb7G3noxl7JaNOmz0ROfuB0T5FzNxZ3HwKMO@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWJ+tHVcXk797J8Yki1QhLck+9/cKxh8J+yi8mtzdR8X6HgEJ
	gnINS7pDqiwujTz80I/2KNiyRpvHzy5s97EKxotGSPsH+KlMVOtXo1KucZuZWat+RDw=
X-Gm-Gg: ASbGncsGmsrdIqYwL3PqxrJue3aitvyCAdV9NCb/7dda1xXVUoxBa48sTbwBoaWoNiX
	Ra2R6DccvsjNqUfEi/uIUQzOA+8Jepwra8qqTKoiquvyJzEm2JEM94MJRCzoPxXmO4uNA2/lqHw
	mbjhRq3suNHUe8JrhHMoMeZtMIt6rWhjazye01tUIsntBaMzmNmaqqjqT80RJFp1A5J3P91APwA
	K21CanSzMC4VeVOFCdhAP+OpTuWYv2T6FRqWHqphfBwY6ZbAPxH9TrGF1KvQ5XPx4Jf6LIRzTyz
	4czchiioDJUG6Zr0AGIcuoqsBtm/bUSvHxd9k0bKrtg0yE6MssUp6rZPummgYFVSNgoEb5Ubc44
	OIg41rr/d6xnwG955ix/eeWmlZv6ExtROYvML/R/eGH+DI9l6fQxVieAbRMGfJAbBCzTWKSZ08x
	aqm+VqEbNmy7s7P9ydfYER
X-Google-Smtp-Source: AGHT+IGXwMYaDVdcIc8A66BKgGJixjgYHD56Xsel19AXjGE4Pyw+x/8QgXo63NUTPmJUti9dv8B+CQ==
X-Received: by 2002:a05:6a20:4309:b0:2da:f4be:c8d9 with SMTP id adf61e73a8af0-334a8606e88mr19355739637.37.1760993625361;
        Mon, 20 Oct 2025 13:53:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1591dsm9453867b3a.7.2025.10.20.13.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:53:44 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 13:53:34 -0700
Subject: [PATCH v22 05/28] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-v5_user_cfi_series-v22-5-9ae5510d1c6f@rivosinc.com>
References: <20251020-v5_user_cfi_series-v22-0-9ae5510d1c6f@rivosinc.com>
In-Reply-To: <20251020-v5_user_cfi_series-v22-0-9ae5510d1c6f@rivosinc.com>
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

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/processor.h   |  1 +
 arch/riscv/include/asm/thread_info.h |  3 +++
 arch/riscv/include/asm/usercfi.h     | 23 +++++++++++++++++++++++
 arch/riscv/kernel/asm-offsets.c      |  4 ++++
 arch/riscv/kernel/entry.S            | 31 +++++++++++++++++++++++++++++++
 5 files changed, 62 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index da5426122d28..4c3dd94d0f63 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -16,6 +16,7 @@
 #include <asm/insn-def.h>
 #include <asm/alternative-macros.h>
 #include <asm/hwcap.h>
+#include <asm/usercfi.h>
 
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 836d80dd2921..36918c9200c9 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -73,6 +73,9 @@ struct thread_info {
 	 */
 	unsigned long		a0, a1, a2;
 #endif
+#ifdef CONFIG_RISCV_USER_CFI
+	struct cfi_state	user_cfi_state;
+#endif
 };
 
 #ifdef CONFIG_SHADOW_CALL_STACK
diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
new file mode 100644
index 000000000000..4c5233e8f3f9
--- /dev/null
+++ b/arch/riscv/include/asm/usercfi.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2024 Rivos, Inc.
+ * Deepak Gupta <debug@rivosinc.com>
+ */
+#ifndef _ASM_RISCV_USERCFI_H
+#define _ASM_RISCV_USERCFI_H
+
+#ifndef __ASSEMBLER__
+#include <linux/types.h>
+
+#ifdef CONFIG_RISCV_USER_CFI
+struct cfi_state {
+	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
+	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
+	unsigned long shdw_stk_base; /* Base address of shadow stack */
+	unsigned long shdw_stk_size; /* size of shadow stack */
+};
+
+#endif /* CONFIG_RISCV_USER_CFI */
+
+#endif /* __ASSEMBLER__ */
+
+#endif /* _ASM_RISCV_USERCFI_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 7d42d3b8a32a..8a2b2656cb2f 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -51,6 +51,10 @@ void asm_offsets(void)
 #endif
 
 	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
+#ifdef CONFIG_RISCV_USER_CFI
+	OFFSET(TASK_TI_CFI_STATE, task_struct, thread_info.user_cfi_state);
+	OFFSET(TASK_TI_USER_SSP, task_struct, thread_info.user_cfi_state.user_shdw_stk);
+#endif
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
 	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index d3d92a4becc7..8410850953d6 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -92,6 +92,35 @@
 	REG_L	a0, TASK_TI_A0(tp)
 .endm
 
+/*
+ * If previous mode was U, capture shadow stack pointer and save it away
+ * Zero CSR_SSP at the same time for sanitization.
+ */
+.macro save_userssp tmp, status
+	ALTERNATIVE("nops(4)",
+		__stringify(				\
+		andi \tmp, \status, SR_SPP;		\
+		bnez \tmp, skip_ssp_save;		\
+		csrrw \tmp, CSR_SSP, x0;		\
+		REG_S \tmp, TASK_TI_USER_SSP(tp);	\
+		skip_ssp_save:),
+		0,
+		RISCV_ISA_EXT_ZICFISS,
+		CONFIG_RISCV_USER_CFI)
+.endm
+
+.macro restore_userssp tmp, status
+	ALTERNATIVE("nops(4)",
+		__stringify(				\
+		andi \tmp, \status, SR_SPP;		\
+		bnez \tmp, skip_ssp_restore;		\
+		REG_L \tmp, TASK_TI_USER_SSP(tp);	\
+		csrw CSR_SSP, \tmp;			\
+		skip_ssp_restore:),
+		0,
+		RISCV_ISA_EXT_ZICFISS,
+		CONFIG_RISCV_USER_CFI)
+.endm
 
 SYM_CODE_START(handle_exception)
 	/*
@@ -148,6 +177,7 @@ SYM_CODE_START(handle_exception)
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
+	save_userssp s2, s1
 	csrr s2, CSR_EPC
 	csrr s3, CSR_TVAL
 	csrr s4, CSR_CAUSE
@@ -243,6 +273,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	call riscv_v_context_nesting_end
 #endif
 	REG_L a0, PT_STATUS(sp)
+	restore_userssp s3, a0
 	/*
 	 * The current load reservation is effectively part of the processor's
 	 * state, in the sense that load reservations cannot be shared between

-- 
2.43.0


