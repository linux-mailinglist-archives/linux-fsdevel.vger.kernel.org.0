Return-Path: <linux-fsdevel+bounces-47203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B07A9A411
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FBB9221CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A711F4190;
	Thu, 24 Apr 2025 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="c5oHOKiO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842972153E1
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479541; cv=none; b=oaRLHd9O1i/KG6QuWV7QzgxmJvfaW4VFJNjPpRMYqrpVKKKzc/Lbvg0N8TqBJHOCorVNinFU98utIp2/zsSLN72NvRKP6R8CvaDdZrtFCzZMj+yvb89bV8qaikQec//mhoSAdXPk0AD5HWTLtGTXP823LcTnFOculV3n39f4SGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479541; c=relaxed/simple;
	bh=sdM7Lfbt0ugbQKamZrvJVP35QAMpRJf64N3YU80rJrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQJEQIJCcwHUJVmeaRTLB9Ut2yHN3cIgVK0cJYXLQa1vKsmoq//5FpxOttDW/qlkgRnOoh+r5XmVcm1/exStxKuB2ZJ9OROa9kBrPn5Hr6maPQhQbWgyN0I8pzC5s5OSxBGR2rAfNnrNVWVwI75+kou5wHs0pDQRMLTFq+Gg5cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=c5oHOKiO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22401f4d35aso7922675ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 00:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479539; x=1746084339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZraI9Ovv6gpYhi0G8W3Cw0oZRXxTTj3IaFkdasgPTa8=;
        b=c5oHOKiO2JcHXg01FrqxIOSkwypRDgq10RcjXPmL6sJW5SZtaRXVhcokdFdqPLgvWa
         CFnMlSemcRQmSFNbyouosHBBR+0I9QmkaP/TVMGiQKYOdouJaxKMUoLYeeLy5gCl9dmr
         yTpR6e9J7S63w34hdN9uhuoWxUFG7FV+pkKcJQQWANDCbldrG94GvnoFGTA56VpGHrwq
         CmK//jjXKoPCHRkdoHugMu9ls02etO3jkiVbrTN67/E7FyIGS7279M8MTLCs3LNBbCwP
         h8GSeQHhRPxvKeFdGpS/ccO2QaU8VCn3v+f+w3dTNKTlyPkmotruMpFlK6K83SVfrawf
         X8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479539; x=1746084339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZraI9Ovv6gpYhi0G8W3Cw0oZRXxTTj3IaFkdasgPTa8=;
        b=GklYtDMqIMBHsKAHpsb1PGNVa0noBXJZb9Q2w7vamNbVUpF/VbPLN6qvShylv7wAQY
         fP8wrS+FRvP0NCVxYFWtAkx9/d6Yq7toXNaOZ+DzjMCp5mjVqHJZO0sj3/6KiaehLvT9
         28NiPSDNLGZachrRCOxvz/hMp0uoGwoAGMWdXrq8mReRk7AuTvBNWvTJetoa5G9mZb5S
         NabIN+kyZUjpGuvHMTl0UEYF5tQun0gyZ6oDggtMovBTgyYstLJX1st8PsY2M998smTq
         OYhmEeE5pft05o9W0MFUti/qZRy5M7cC5WiIDh3T5oTqtnH3Mc013No16JUUYHNjUElL
         nK+g==
X-Forwarded-Encrypted: i=1; AJvYcCVpsLxHCmh5/Fo+d5Dc2308s+U/cjsGDoxfwnUxzzbHq1geQySzExiFZaf6ywMWtC1Z/6JhRCYwIf4+CTtX@vger.kernel.org
X-Gm-Message-State: AOJu0YxB3UeZdsQe7Wpx++dXTCksMF8ox7SCVRslX6EMuOSluehE89US
	ndGH80HGSSq4b+402Uz8qTKFhkHFmMrIPo5vhH8WllKva2ZslLrZvvs31DHdWkk=
X-Gm-Gg: ASbGnctnbFoJxsu5OcIOAqcMy5xasAoWqyPZW9fhilhySqsrHLh5wsHh0cKP7eyNOWn
	mgmkxkgbw0nhxOR1YAHcJzzZ5LUUw9Ik9oW0GeJ562qPr+DRETBdoHkObxmIB1TM3vKVYGnMCmO
	rFPQseYVRCAfY/fpftAe77ILzBJwkieMSVXBFcPZZo3SgdA3z44JmbmTBTGwJp6+GzwE++PSSwk
	Y5yCjEgktihdQ9+RlbzF+nizmBnNDxwkekNoWvgZdTncr8jlSVXLf5U6fmBKHQnpFB9lDJj1XU2
	ZN2yXFFtd157T3fQTMECa3RtgNqT4azsRedTfA1XaB5H9VrqoFe8MF2Kf1q7ew==
X-Google-Smtp-Source: AGHT+IH7Pn7YrwNkVIPl7Y7iC7lJ60MGgO6KIgekfFqy8hhbQAHwjVQ+88ZLIatTihzxRFG2BgkJcw==
X-Received: by 2002:a17:902:e5c8:b0:220:c813:dfd1 with SMTP id d9443c01a7336-22db3d777c4mr23449115ad.36.1745479538561;
        Thu, 24 Apr 2025 00:25:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50ea91fsm6333385ad.126.2025.04.24.00.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:25:38 -0700 (PDT)
Date: Thu, 24 Apr 2025 00:25:34 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v13 05/28] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
Message-ID: <aAnnbtABLTL81uEY@debug.ba.rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
 <20250424-v5_user_cfi_series-v13-5-971437de586a@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250424-v5_user_cfi_series-v13-5-971437de586a@rivosinc.com>

On Thu, Apr 24, 2025 at 12:20:20AM -0700, Deepak Gupta wrote:
>Carves out space in arch specific thread struct for cfi status and shadow
>stack in usermode on riscv.
>
>This patch does following
>- defines a new structure cfi_status with status bit for cfi feature
>- defines shadow stack pointer, base and size in cfi_status structure
>- defines offsets to new member fields in thread in asm-offsets.c
>- Saves and restore shadow stack pointer on trap entry (U --> S) and exit
>  (S --> U)
>
>Shadow stack save/restore is gated on feature availiblity and implemented
>using alternative. CSR can be context switched in `switch_to` as well but
>soon as kernel shadow stack support gets rolled in, shadow stack pointer
>will need to be switched at trap entry/exit point (much like `sp`). It can
>be argued that kernel using shadow stack deployment scenario may not be as
>prevalant as user mode using this feature. But even if there is some
>minimal deployment of kernel shadow stack, that means that it needs to be
>supported. And thus save/restore of shadow stack pointer in entry.S instead
>of in `switch_to.h`.
>
>Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
>Reviewed-by: Zong Li <zong.li@sifive.com>
>Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>---
> arch/riscv/include/asm/processor.h   |  1 +
> arch/riscv/include/asm/thread_info.h |  3 +++
> arch/riscv/include/asm/usercfi.h     | 24 ++++++++++++++++++++++++
> arch/riscv/kernel/asm-offsets.c      |  4 ++++
> arch/riscv/kernel/entry.S            | 23 +++++++++++++++++++++++
> 5 files changed, 55 insertions(+)
>
>diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
>index e3aba3336e63..d851bb5c6da0 100644
>--- a/arch/riscv/include/asm/processor.h
>+++ b/arch/riscv/include/asm/processor.h
>@@ -14,6 +14,7 @@
>
> #include <asm/ptrace.h>
> #include <asm/hwcap.h>
>+#include <asm/usercfi.h>
>
> #define arch_get_mmap_end(addr, len, flags)			\
> ({								\
>diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>index f5916a70879a..a0cfe00c2ca6 100644
>--- a/arch/riscv/include/asm/thread_info.h
>+++ b/arch/riscv/include/asm/thread_info.h
>@@ -62,6 +62,9 @@ struct thread_info {
> 	long			user_sp;	/* User stack pointer */
> 	int			cpu;
> 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>+#ifdef CONFIG_RISCV_USER_CFI
>+	struct cfi_status	user_cfi_state;
>+#endif
> #ifdef CONFIG_SHADOW_CALL_STACK
> 	void			*scs_base;
> 	void			*scs_sp;
>diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
>new file mode 100644
>index 000000000000..5f2027c51917
>--- /dev/null
>+++ b/arch/riscv/include/asm/usercfi.h
>@@ -0,0 +1,24 @@
>+/* SPDX-License-Identifier: GPL-2.0
>+ * Copyright (C) 2024 Rivos, Inc.
>+ * Deepak Gupta <debug@rivosinc.com>
>+ */
>+#ifndef _ASM_RISCV_USERCFI_H
>+#define _ASM_RISCV_USERCFI_H
>+
>+#ifndef __ASSEMBLY__
>+#include <linux/types.h>
>+
>+#ifdef CONFIG_RISCV_USER_CFI
>+struct cfi_status {
>+	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
>+	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 1);
>+	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
>+	unsigned long shdw_stk_base; /* Base address of shadow stack */
>+	unsigned long shdw_stk_size; /* size of shadow stack */
>+};

I didn't change this part yet. There are two comments from Radim here

1) Separate state of enabling/lock status from shadow stack pointer.
    Same goes for landing pad in later patches. I am arguing that since
    thread_info is already occupies two cachelines and there isn't any
    effort to manage it within single cacheline, I am not sure if it's worth
    the effort. Most likely comment is stale or doesn't have backed up data
    behind it. Furthermore whenever state of enabling is accessed, most likely
    shadow stack pointer, base pointer or size of shaodw stack will likely to
    be accessed as well. Thus having all that in colocated cacheline would
    actually be useful.

2) Convert enabling/lock status from bitfield to bool or accessed via bitmasks.
    I am agreeing to feedback here and will do that once we converge on point 1.


>+
>+#endif /* CONFIG_RISCV_USER_CFI */
>+
>+#endif /* __ASSEMBLY__ */
>+
>+#endif /* _ASM_RISCV_USERCFI_H */
>diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
>index e89455a6a0e5..0c188aaf3925 100644
>--- a/arch/riscv/kernel/asm-offsets.c
>+++ b/arch/riscv/kernel/asm-offsets.c
>@@ -50,6 +50,10 @@ void asm_offsets(void)
> #endif
>
> 	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
>+#ifdef CONFIG_RISCV_USER_CFI
>+	OFFSET(TASK_TI_CFI_STATUS, task_struct, thread_info.user_cfi_state);
>+	OFFSET(TASK_TI_USER_SSP, task_struct, thread_info.user_cfi_state.user_shdw_stk);
>+#endif
> 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
> 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
> 	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
>diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>index 33a5a9f2a0d4..f5531d82f7e7 100644
>--- a/arch/riscv/kernel/entry.S
>+++ b/arch/riscv/kernel/entry.S
>@@ -147,6 +147,20 @@ SYM_CODE_START(handle_exception)
>
> 	REG_L s0, TASK_TI_USER_SP(tp)
> 	csrrc s1, CSR_STATUS, t0
>+	/*
>+	 * If previous mode was U, capture shadow stack pointer and save it away
>+	 * Zero CSR_SSP at the same time for sanitization.
>+	 */
>+	ALTERNATIVE("nops(4)",
>+				__stringify(			\
>+				andi s2, s1, SR_SPP;		\
>+				bnez s2, skip_ssp_save;		\
>+				csrrw s2, CSR_SSP, x0;		\
>+				REG_S s2, TASK_TI_USER_SSP(tp); \
>+				skip_ssp_save:),
>+				0,
>+				RISCV_ISA_EXT_ZICFISS,
>+				CONFIG_RISCV_USER_CFI)
> 	csrr s2, CSR_EPC
> 	csrr s3, CSR_TVAL
> 	csrr s4, CSR_CAUSE
>@@ -236,6 +250,15 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
> 	 * structures again.
> 	 */
> 	csrw CSR_SCRATCH, tp
>+
>+	ALTERNATIVE("nops(2)",
>+				__stringify(			\
>+				REG_L s3, TASK_TI_USER_SSP(tp); \
>+				csrw CSR_SSP, s3),
>+				0,
>+				RISCV_ISA_EXT_ZICFISS,
>+				CONFIG_RISCV_USER_CFI)
>+
> 1:
> #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
> 	move a0, sp
>
>-- 
>2.43.0
>

