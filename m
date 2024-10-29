Return-Path: <linux-fsdevel+bounces-33204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2589B57DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16BCB22E58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 23:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57487215F71;
	Tue, 29 Oct 2024 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HTMNY+qJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72292144CC
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245529; cv=none; b=AvLCIOlVWGLxK4R0wg3BGvHMDq/T5fJMzDWLWPVGT1IylRSrPqFNgJs0WvgfhXHV3367cPpkF155ZJ7rOSUQupI+tfJYRQ47htxH50z8Db4LsJIJjBVjUR2WExcNmEpjVFTWNzFh1I3poqDlhOGFbs41Gh/3mhEzwd6fLRwnpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245529; c=relaxed/simple;
	bh=G1aLy3IelhuEgU9JBrVeI1DyWWDfsjmjGHH+A4pzYCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lu6lz1ulZhjORkWjnYRRzgF7woO//tZawqDE7o/bZDPqxpRZLzudfKb2X30nKVifpFuwfuEIBj1vwDGpzhtKtIYTb3rTZOoiDSitYNSBjgkFyLbjcuO84aXZNuBjLsJLMlgd02I6CVW1z3zuwZzGyjxmdFlr1wNPJwpzdDrDrIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HTMNY+qJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72070d341e5so2665776b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 16:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730245527; x=1730850327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xlMf/FGu+cOf/Hv7qUX6Wk1q9xFnQqCr1v5Bv8qZmQ=;
        b=HTMNY+qJCB2vrebUcEPoAHMUUlAYzT/zo2CEtkLYq3b/1FcRKsgBYefX8KT0GaBbO2
         XxE8SPFV16FkeqIlW0+Iy0Ma+/D1sW3ikBToyZbcKGsnTttTDE7zD7Wcb7qXEnJRI/re
         r52WdT3H+hSjoP/5vfuc5ebALl4jAC6Sm0Xjj3SZMz8khtce7jpO+JqfScR/FY7hQ34O
         nrxcyiBzHnMcOW+DBJkzW37bW9l6wJ+Rd0Sxwqnss6vOHNo1Ssx18KzzGuG1+KSyKg3T
         Di+YpOBkL0kglMrnMrUVY3vVggfPhGjKUi5BGwIrH34VvHlBuc07UPDsvy+JGiT7cMg1
         3WEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245527; x=1730850327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xlMf/FGu+cOf/Hv7qUX6Wk1q9xFnQqCr1v5Bv8qZmQ=;
        b=uKH5HDCkz+SWa0oMJgC0qi3R2Y3Bje0MKA2ao28MllPPhrogfWq1L4FxHGag/mLMzm
         jZn9K3Q7RsajokJB2ixDP2Mt8orF/zql877RyO+F28wvNbRKprip/DKvYSTr8YjMPCfI
         yOQGH6JKy1+QWn5z5MkNBSjYq69BbJumWAvc1r3CMXj1+mQa28NxRbupfCixmosnKLqd
         x3kMa0KGGmb6Qj36Eodq/eA297beuDrvJr9TlpwGTgcVJTx6SSs7XxJd3jTVZas51akO
         6lbNGziccbgCuWfYoSBJ6HLlp1ALzn1lTHOn+HjZYwdCLni7crh7bWzPyvBVPYj7kD5L
         bNTg==
X-Forwarded-Encrypted: i=1; AJvYcCX+axd2y8NOHeyqyVgceiR/U7P4BsWt5XcYTXWByQT5LvDIvy1iJ9ixx43TqvxtyPGpzyoc+0m+jv75uotC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Azttn37mv8/SiFwXySxzrCrsD5xFLbxa08S6YeaIITXzTOlJ
	97fTIfZJ/1KA4cvC8RU+crlobN1dEjUOSRRBpPRI/qKMKblLb0s5k574Efa7ye0=
X-Google-Smtp-Source: AGHT+IELr6IagcEBTdUxKgRdLblmitKpEm/GHFYUpbKbGEH4mdOch+QEksQsRpJQnLoaEfYjLi/gYQ==
X-Received: by 2002:a05:6a00:2d17:b0:71e:5fa1:d3e4 with SMTP id d2e1a72fcca58-72062f86747mr18633884b3a.2.1730245527282;
        Tue, 29 Oct 2024 16:45:27 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm8157643b3a.33.2024.10.29.16.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:45:26 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Oct 2024 16:44:27 -0700
Subject: [PATCH v7 27/32] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-v5_user_cfi_series-v7-27-2727ce9936cb@rivosinc.com>
References: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
In-Reply-To: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
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

Kernel will have to perform shadow stack operations on user shadow stack.
Like during signal delivery and sigreturn, shadow stack token must be
created and validated respectively. Thus shadow stack access for kernel
must be enabled.

In future when kernel shadow stacks are enabled for linux kernel, it must
be enabled as early as possible for better coverage and prevent imbalance
between regular stack and shadow stack. After `relocate_enable_mmu` has
been done, this is as early as possible it can enabled.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/asm-offsets.c |  4 ++++
 arch/riscv/kernel/head.S        | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 766bd33f10cb..a22ab8a41672 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -517,4 +517,8 @@ void asm_offsets(void)
 	DEFINE(FREGS_A6,	    offsetof(struct ftrace_regs, a6));
 	DEFINE(FREGS_A7,	    offsetof(struct ftrace_regs, a7));
 #endif
+	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
+	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
+	DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
+	DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
 }
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 356d5397b2a2..6244408ca917 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -164,6 +164,12 @@ secondary_start_sbi:
 	call relocate_enable_mmu
 #endif
 	call .Lsetup_trap_vector
+	li a7, SBI_EXT_FWFT
+	li a6, SBI_EXT_FWFT_SET
+	li a0, SBI_FWFT_SHADOW_STACK
+	li a1, 1 /* enable supervisor to access shadow stack access */
+	li a2, SBI_FWFT_SET_FLAG_LOCK
+	ecall
 	scs_load_current
 	call smp_callin
 #endif /* CONFIG_SMP */
@@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
 	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	addi sp, sp, -PT_SIZE_ON_STACK
+	li a7, SBI_EXT_FWFT
+	li a6, SBI_EXT_FWFT_SET
+	li a0, SBI_FWFT_SHADOW_STACK
+	li a1, 1 /* enable supervisor to access shadow stack access */
+	li a2, SBI_FWFT_SET_FLAG_LOCK
+	ecall
 	scs_load_current
 
 #ifdef CONFIG_KASAN

-- 
2.34.1


