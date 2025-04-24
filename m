Return-Path: <linux-fsdevel+bounces-47179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2899BA9A350
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F2B194734E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 07:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20979201004;
	Thu, 24 Apr 2025 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TMlstJMS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73CB1FECAB
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479240; cv=none; b=hE6p75gQT8MBWU8SXuftdWm0mb59jFacI55g3qveEIu6pTuM4YUL0iHksc7ZE60OCJH4kMJOX8GEEDhv3YLHxRBHN6jcIQ0j8vCl3FUYre1fCVs51877oSWbQnHArjMaWwsXmdNe4OmBPfHo4zBEYhY1e7/bgh+vNgE3cOPb8Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479240; c=relaxed/simple;
	bh=1WegDJ7s5oHREDhIPWT7kYe0riPrIRaYjud0Nx9m4Iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KbMJ3Kibokqh7Cx0mj08T9tB+wblwkXITSa8Csc1BmU8nupV92l6b3kIm6V7PnhC7fKYYZ7gst7Ckl3g1dQJRjJDBE+CtBNzrBRgZHTXGxRNAKxhlak7pTl4jIbgcdZeK6m0mSP7JQg3oAtDtyicf4L7bMeiZ1+DVP3WuQCGFCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TMlstJMS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224100e9a5cso8329965ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 00:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479238; x=1746084038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2iQwykcrMqX35SdzbQmxoYXyPhByf18rj1xks04xkI=;
        b=TMlstJMShVCgTHQXuFOoAA96RcFW6kFkhNRNt6478rt5SfIGxkI/lqwrs7fI0K/8p2
         NlzaXNjcpSn5cM9M1e+Asit0dbEA8Fry6NhEbp4vguzf1dG+ZDq4Y8I3VjuxS44astww
         ic4jZCheDLlekDtgaFQ/loCf66eX/btGd2+MOGZ5oxTjMc6YNhBVZQEv4l/bK6Af1mUg
         M1cjGnOtQsARKTW1dIw7rRTfdtdDtZwLlqtWu3+dSLh/CskMN8+jBfTAqmJq2aQlcZK+
         G8C5C9t4CFWiCj78jLAZqx2BM+wKcxVp+H0kQPu8IZVCBp7YgaV99hgAVDv3xKDjegOD
         xFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479238; x=1746084038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2iQwykcrMqX35SdzbQmxoYXyPhByf18rj1xks04xkI=;
        b=nzEoTSPoTcRPm+eZy3VVSd5G8saayNAsUGMr5UGTyV03zjrssyWzY+x+vrTEO4B4Ta
         a7WBlwRY0JUN+wyH3t0f6yOXftXOKESNnJ5QBvMnVD4oc297iGa7RBvT/6prbPr3u3qW
         8HrKMxQw7XQH0sHZVouitSaoNZ0XLSXB0RPhKTndyGlknOfwJWljY17NJXPJA3mwnQZP
         M/6kh6v6kmxs5Ias/1A1bB9UKWkKp5hPIcwNVbqOZdR/jB8ckRyqUBUWKJIHV6EZbM6v
         J0UF3KkkDhPOMkho1cgmMp4V+MIedv1opxBtrGWG1hyvQg/A50SvzDzvb1zloLk0H4zW
         Vi9w==
X-Forwarded-Encrypted: i=1; AJvYcCWdh7d2uz+/rXim/CsmYvdxtRgVY9A/ZwMb6i5ydrMpqGOkkDtuFTPZzLaSxF4klwpuFr3HiabG2LtiHp3f@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7GvpquiBeBtXypz77KOUgPVZqBmhndRH1OJD2Y1h1KgqCG7tU
	8SW5VzP1K9wMaUJ/PunzZfa1P/RvD17hco65pJtZL2Bfdm+L/qTxRmvQlQbcAG8=
X-Gm-Gg: ASbGncsIzSvIMozLwFfUdYMZz85hVwqXKw5enPtG3lUB2h5Q9I9tQ/ec34qN0KgBUwi
	Mx3MkF48bt2eVrSGSrm3IRcEUjUctIDa9eG5yNmEUpHfHE7+6F6bDkK1h3nQSjsjsjxstrHJcEG
	ayhTefbT0XMIsQsFOcTL0zSwWbP+xWxoyFza/SuczsLoXNGlVrAGCg9vDd2lTt6Yb8ubzTRIXGF
	Y8b16sMgCtkLwy0ytYkLUcdxGctzddM89w0kuFa8IfMuicaVC/Gq8OzWiAlKmd4y6AQ32/xYgCZ
	nfdT4lulju7yVck81Y2V5CHJei7iug6r4St7+RcBmyDWbHdXkoc=
X-Google-Smtp-Source: AGHT+IGTUNfhbadbAV/QV8/Z1nPIpw+IRD35ku3cOXRKsWZQ9FGvK/U4dKyN0R2NYVwk5yjzpaZp3g==
X-Received: by 2002:a17:903:41c5:b0:226:5dbf:373f with SMTP id d9443c01a7336-22db3bbbf6amr24730505ad.10.1745479237787;
        Thu, 24 Apr 2025 00:20:37 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:20:37 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:20 -0700
Subject: [PATCH v13 05/28] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-5-971437de586a@rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
In-Reply-To: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
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
 arch/riscv/include/asm/usercfi.h     | 24 ++++++++++++++++++++++++
 arch/riscv/kernel/asm-offsets.c      |  4 ++++
 arch/riscv/kernel/entry.S            | 23 +++++++++++++++++++++++
 5 files changed, 55 insertions(+)

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
index f5916a70879a..a0cfe00c2ca6 100644
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
index 000000000000..5f2027c51917
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
+	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 1);
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
index e89455a6a0e5..0c188aaf3925 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -50,6 +50,10 @@ void asm_offsets(void)
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
index 33a5a9f2a0d4..f5531d82f7e7 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -147,6 +147,20 @@ SYM_CODE_START(handle_exception)
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
+	/*
+	 * If previous mode was U, capture shadow stack pointer and save it away
+	 * Zero CSR_SSP at the same time for sanitization.
+	 */
+	ALTERNATIVE("nops(4)",
+				__stringify(			\
+				andi s2, s1, SR_SPP;		\
+				bnez s2, skip_ssp_save;		\
+				csrrw s2, CSR_SSP, x0;		\
+				REG_S s2, TASK_TI_USER_SSP(tp); \
+				skip_ssp_save:),
+				0,
+				RISCV_ISA_EXT_ZICFISS,
+				CONFIG_RISCV_USER_CFI)
 	csrr s2, CSR_EPC
 	csrr s3, CSR_TVAL
 	csrr s4, CSR_CAUSE
@@ -236,6 +250,15 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	 * structures again.
 	 */
 	csrw CSR_SCRATCH, tp
+
+	ALTERNATIVE("nops(2)",
+				__stringify(			\
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
2.43.0


