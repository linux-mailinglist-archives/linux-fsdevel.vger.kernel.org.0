Return-Path: <linux-fsdevel+bounces-31373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2D6995A43
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 00:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593C01F2473C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 22:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34043219483;
	Tue,  8 Oct 2024 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sQ2MbGjc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051C218D7B
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427080; cv=none; b=uCvQ+NNh8zo2qqTwXmrB2SwOGlR+lPU/w/3f4nyx8kyiiBSt3yNZ5cXkOVvTu/jnaFpQbH3YVntnTbKXT6Y9OFSfEQ6WcRBI2vi2GYaCDLHrigijvpjZAPRqotS798K7MO9khtKCUEgDgq5/8pVKgXbMKEhf3WNyHzQtXI3Hk+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427080; c=relaxed/simple;
	bh=Vg9qUps9hydvc7ePr7ag3TUqLbaNhAZx4r8+i18vT8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MFsTGOopkphQLXyDKVmBfd0EVDHIcBxaoE90xCuaTlTeJD3BGNEX8xwfPbE/W7eu+5hkMkql01PFY6LtZs8lREAqIAunu6g52ix+VPh+hCA9qTS273ywGpRlhbOC9kYsF1c/DxHlu3xfYtLU213FP0YU7pH6MlfiWM6QOMi8Krk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sQ2MbGjc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e0c3e85c5so1751399b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427078; x=1729031878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmcYgz7XnLLJto60RpG9fxf/3nbG0BDRV+8az326H18=;
        b=sQ2MbGjcuDdqzwmYUtRxCjKWMg3oAs1cB/0LTKhdvlMCHhIDR4MryIeHpeCfnaHGdu
         ROPQcUteUZo8sF9qdfjfaW+KEn6qwocwU6dZI2uDgZQxZ2AITmhWYmyJwQDMGwYzqFJL
         a6VqzgUTfbxnP/zcYcHwIUt9pHTN26JIBERIqnojgNiXG0vHIFQhvYLyVT5+1ui6tEBr
         103WsMJ3WFNy/twSdRx16QOmps/3UCYNyx+SWjT9zZuC5/257998u1ByPUkVWpORsls5
         emSZ+nEmiRB885ncvavt3G7NybUMAx5luiOYNQ2hqFfVDytePC13ttEnBf/XBW8IUxG1
         weow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728427078; x=1729031878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmcYgz7XnLLJto60RpG9fxf/3nbG0BDRV+8az326H18=;
        b=U5V4SqmDJuoCjMoqDC55zKHv3Kw2P0nmiMsUb6wEoyc3w2F7KA+HXXyiboBYnSPrwK
         4wOUmWgAdscxu9fd1qXmQoPhYH+KHgMpnRffriSGhz/MDT8dkGHwQBYxbMhJd1ykemIs
         Wt18hWVjifehOZN4xuVovi1x/XSQfKV42xDpQVNFthK05iO/dcqhtaeov8byPXFtM32X
         ZktB8I9RpVQ0ni2ENsMdlA4/c/gvabbG2igKYJvx++vIFn3wTrvt1s1nkmnFlHGc3keS
         mMI/rB0qLQ6BMMkH1n+6LUyBd4XFun9iFCe3qtkZ7GHed/yOcFmHghiPFPKnPQHb+uHs
         7CIA==
X-Forwarded-Encrypted: i=1; AJvYcCVIsAPsu3kxxdEH/+Wouv1yM5wW0gvlAn0PWkp1invvDGOm0J15fVoF0Q8AEJI7Qw7GL91VkUdGPNibcwap@vger.kernel.org
X-Gm-Message-State: AOJu0YxhFCMxTmWdiW3RPDK7r3IthRPdP7RyjCLjaKED1dBK7wX15MXX
	hZloUBqBTqIQdUSx3hKW4VDW6r38DnyeJ/PEzdiFy24MTKrz4/9nW9o7OqNbhoY=
X-Google-Smtp-Source: AGHT+IErKskUpIBiFKlwdYnNS9we5iBG5psWxaDz48JOAw5L1P7wN1gzBxCeW201xTOm4LwBlfF9lQ==
X-Received: by 2002:a05:6a00:816:b0:71e:19d0:2988 with SMTP id d2e1a72fcca58-71e1db85912mr671554b3a.14.1728427078379;
        Tue, 08 Oct 2024 15:37:58 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccc4b2sm6591270b3a.45.2024.10.08.15.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:37:58 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 08 Oct 2024 15:36:46 -0700
Subject: [PATCH v6 04/33] riscv: Add support for per-thread envcfg CSR
 values
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-v5_user_cfi_series-v6-4-60d9fe073f37@rivosinc.com>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
In-Reply-To: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Andrew Jones <ajones@ventanamicro.com>
X-Mailer: b4 0.14.0

From: Samuel Holland <samuel.holland@sifive.com>

Some bits in the [ms]envcfg CSR, such as the CFI state and pointer
masking mode, need to be controlled on a per-thread basis. Support this
by keeping a copy of the CSR value in struct thread_struct and writing
it during context switches. It is safe to discard the old CSR value
during the context switch because the CSR is modified only by software,
so the CSR will remain in sync with the copy in thread_struct.

Use ALTERNATIVE directly instead of riscv_has_extension_unlikely() to
minimize branchiness in the context switching code.

Since thread_struct is copied during fork(), setting the value for the
init task sets the default value for all other threads.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---
 arch/riscv/include/asm/processor.h | 1 +
 arch/riscv/include/asm/switch_to.h | 8 ++++++++
 arch/riscv/kernel/cpufeature.c     | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index efa1b3519b23..c1a492508835 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -102,6 +102,7 @@ struct thread_struct {
 	unsigned long s[12];	/* s[0]: frame pointer */
 	struct __riscv_d_ext_state fstate;
 	unsigned long bad_cause;
+	unsigned long envcfg;
 	u32 riscv_v_flags;
 	u32 vstate_ctrl;
 	struct __riscv_v_ext_state vstate;
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 7594df37cc9f..9685cd85e57c 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -70,6 +70,13 @@ static __always_inline bool has_fpu(void) { return false; }
 #define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
+static inline void __switch_to_envcfg(struct task_struct *next)
+{
+	asm volatile (ALTERNATIVE("nop", "csrw " __stringify(CSR_ENVCFG) ", %0",
+				  0, RISCV_ISA_EXT_XLINUXENVCFG, 1)
+			:: "r" (next->thread.envcfg) : "memory");
+}
+
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
@@ -103,6 +110,7 @@ do {							\
 		__switch_to_vector(__prev, __next);	\
 	if (switch_to_should_flush_icache(__next))	\
 		local_flush_icache_all();		\
+	__switch_to_envcfg(__next);			\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index e560a253e99b..27bafc5dd62d 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -923,7 +923,7 @@ unsigned long riscv_get_elf_hwcap(void)
 void riscv_user_isa_enable(void)
 {
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
-		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
+		current->thread.envcfg |= ENVCFG_CBZE;
 	else if (any_cpu_has_zicboz)
 		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
 }

-- 
2.45.0


