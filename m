Return-Path: <linux-fsdevel+bounces-47978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A816AA7D38
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 May 2025 01:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CE51899EB0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 23:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C94C2701D0;
	Fri,  2 May 2025 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pRF6+N4w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1126FA47
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228710; cv=none; b=MJHqsQaJgaJH8Rf8lib/bfmqE5sTpf4Ze2XIDDKQhR4dkFbD1HtrzuYPMMHZ0PlS+DjvvCfY4O7Qj8N6OxJFrAl5Q+euQrY4yPcw2KhiMgFVn5hE6jhjg2bCLBynYPQP0G56tIS0uN+OvfZgpsyWq4JxkqObJcRmup3HI5L+4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228710; c=relaxed/simple;
	bh=2OxRjeNitwA7Tao/73SE6WLGWnhdaTAAhh7qudypmD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZH3ls1POGNC0ysYYezyMR6U1q+HcsF/D2naCalJji2RCc461yoImLasOW7P2Mzv9GqrdH5Fb4Anh6fgrWgaxeOjYJRNwNWfOny2i6/RfQZ8Js7XP1bLvLSdeb8aZV4D/UOD167499rxJYyKDDx/IZnUzAkH3uJ0Mk05ybeUybBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pRF6+N4w; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22435603572so32487625ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746228707; x=1746833507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBvEpeAE/7wGyExLODAiLDg6krF79sL+1H1FZhekT8M=;
        b=pRF6+N4wRe9tVsnkloUxzuwfCvtFh73Pn1anMgw6oDcTwTSfmiHnC7DUdiuItdEl0V
         FknLCLksmaYe66Sp0XcLP6x98pwdNgE6+4aYEs1DKCYJFO6Uyxsco4oiAUp/mQqQj25S
         Vak1ANSLVdpc5dvY29yYmS36T4NmdjLndQXYNmMDsX6HnkyApn+okkG2MQmaxudLI+OW
         /vYsl7EO5mcmxfDSFArAsEHBHnao1qgJ71jtGHp2ybuH4NviuCkd/DuhP4LHvhxtRfcI
         A5Uol2gM+qT9N8AQnwnH40GpIWN1Slg5bVNu3ZXjCKQ5F0yK3LR0/chEvtSK+4+70mUS
         DEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228707; x=1746833507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBvEpeAE/7wGyExLODAiLDg6krF79sL+1H1FZhekT8M=;
        b=dL+Mt4XonY8cIyED4mkqyZqXwOcEKaCS764kPEh6Xg6SEWwqAtd1hOnAb4B5WaYLPf
         1QyRnCJe51kOMg+ScB1nGIZ9iIxjuyf3F0VliPe5tObiLuMGu9gJ+XL2QhXHAkUU44sp
         FiIzN5RG8fwRkzjt0KjVFojulU62vz3w+QncEKalIBa2jGFIQC97b5awj/u/zgkhY8Vz
         AVI1zW7eqx2b3RqHFOGdKdjG1UaVmwWSpaYef69xKW50z+uvAh4xzPNZP4j5Kt2EberX
         XNXFNV0IwllHZZrq/iVK7Oc3zOzbheuFn5+mptPnnnuXfyL8VNsnsRBuYlO698OQ7nHO
         QM+g==
X-Forwarded-Encrypted: i=1; AJvYcCV06tcoWwqSA++N1aWvMU3TOBCZmPkDD6bdOQTC+LkVPf3kIITzV79xUXujVYZQOtEagyNBXNxwt7UeA1Ri@vger.kernel.org
X-Gm-Message-State: AOJu0YyarYkXAnrlc4o8GgKe55wzqNdzSbnNpBoS4u86hQL11qxHV/o4
	aUA7ewjw0qtko2l0wGftzFy98CbhMjncdvRz47FucInV9IeOmHn6ntTMJVYxTXM=
X-Gm-Gg: ASbGncuQKosB+GKdpakBBewz2iQH35D0LO4ipMfMvXlwoDHy6S4uj7yrmFmr/OAs0KX
	JlrD5dw1zgu6RwX8mxxhrTWsr/mkataJpEc4IG6VkmV5MyYstZLYqW4aTnIs8IFoLFXaipguLPh
	SbbmmTseaKuK9GbLKM2Poe/16cfMXfH+BRYEAWOmcwczj5ErjoihYrhJPCrXIiERSNi7Zv2oB80
	4Wg5gaqI4Sqz5XerpVer4B78klFbk2ohis7bMkUtZepZWY6UkVKqj4XNB1E8A9LuAXfD5Mf1Kh1
	+bvDarxQ/5jIfKloaqbPBOdqMcWujXVIiP4YW9jG8kxcvPCR3QI=
X-Google-Smtp-Source: AGHT+IF65UbwtR43GArG69lb3A8mSpF2tYUKJ/IXOS3rV9/TBWmbC/mO0B88SVzG1mjx0nqZklftGQ==
X-Received: by 2002:a17:902:cf01:b0:211:e812:3948 with SMTP id d9443c01a7336-22e1023416cmr78113425ad.0.1746228706918;
        Fri, 02 May 2025 16:31:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ff2sm13367055ad.180.2025.05.02.16.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:31:46 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 02 May 2025 16:30:53 -0700
Subject: [PATCH v15 22/27] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-v5_user_cfi_series-v15-22-914966471885@rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
In-Reply-To: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
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

Kernel will have to perform shadow stack operations on user shadow stack.
Like during signal delivery and sigreturn, shadow stack token must be
created and validated respectively. Thus shadow stack access for kernel
must be enabled.

In future when kernel shadow stacks are enabled for linux kernel, it must
be enabled as early as possible for better coverage and prevent imbalance
between regular stack and shadow stack. After `relocate_enable_mmu` has
been done, this is as early as possible it can enabled.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/asm-offsets.c |  4 ++++
 arch/riscv/kernel/head.S        | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index f33945432f8f..7ab41f01aa17 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -514,4 +514,8 @@ void asm_offsets(void)
 	DEFINE(FREGS_A6,	    offsetof(struct __arch_ftrace_regs, a6));
 	DEFINE(FREGS_A7,	    offsetof(struct __arch_ftrace_regs, a7));
 #endif
+	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
+	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
+	DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
+	DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
 }
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 356d5397b2a2..7eae9a172351 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -15,6 +15,7 @@
 #include <asm/image.h>
 #include <asm/scs.h>
 #include <asm/xip_fixup.h>
+#include <asm/usercfi.h>
 #include "efi-header.S"
 
 __HEAD
@@ -164,6 +165,19 @@ secondary_start_sbi:
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
@@ -320,6 +334,19 @@ SYM_CODE_START(_start_kernel)
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
2.43.0


