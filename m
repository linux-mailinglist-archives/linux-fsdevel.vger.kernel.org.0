Return-Path: <linux-fsdevel+bounces-33181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E8B9B5748
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC9A1F23D95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 23:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A49C20E00C;
	Tue, 29 Oct 2024 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gA56lXzy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB92220CCE9
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245470; cv=none; b=RfuYp2CT/XZjeyh6T5fxV7tU9zp7utYqWGhOEE+galPBEWn3yoRDodH3u+eBVUJFwC4dJbdaw9fdhUNnMZeNOpBYC9IICxX8f7jMi0CFRJaGg5DYApi0iiRB4Wf0iVTHTcpdCv092NvYUQz+f7yw4OB20pGcPNXHmkHvPlijwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245470; c=relaxed/simple;
	bh=8irZdyfpIFMqPeGtNroHPDaMK0kMqN29j/A6L9BAyRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=muftu1pVtIodYY3MOGJZc4bk6GpridLYXFihjVhQCzHoZd4FMA89LPA8DysBLnIPU9iSwTIFC4f0nYyWcEoX4sZU/ZQTIVbvXpNyfhMP708V6tvJPExMlGTfcEPtCDhvZyasq/TJGhb0skRKVNppjbVuNaThrooZmq0O4jKL2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gA56lXzy; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso268659a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 16:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730245466; x=1730850266; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CCKzg74NjcYHO/B30bowh1owAHwLHbAhOOOeEQpeDk4=;
        b=gA56lXzy0tBx7RM1tw7QA1kp/ORko6+v4TwwLa45Yn0ZPYkxiEjUSorr+1zurtvQMU
         wiXIU9zgdaIvJe7GLO3y9xHKZBlJArWLiLEo/5OpN22QnyOb5E/PDaKX/x8nDbHMB1DF
         F27tbk0WWm4k4VL64lJroP5V/uwbBVLxsspRpRSYkKEDgxkNidTTNtl0icD7BJCGeFGr
         dgHdq4ElX5ac4sO+dBrCDTKgmV81LIgh4b8nP4hMxcoTg4FnhnCXHI/MG/1Kwlsw+vn/
         A2b+pbtYJsVlVk3rfKtsfFCFgfQ4SmXCtsi3Bwp3j876Sbm9wV1OCNpf31lTxqr/uHkS
         69RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245466; x=1730850266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCKzg74NjcYHO/B30bowh1owAHwLHbAhOOOeEQpeDk4=;
        b=mav0luIX/itzVxAARfDHaqFhjHePGtaYkXlW3r36lpUjThrQJL9AwxPj5y9MUEclEA
         YdZaPrrBVL0XWP3e36RGMt/Fee+AYy6K+XnVqHKsbdS+XZcTkUDwshMTof0Ym1PJCZei
         oRLqT7yULjCfBjZNykRcpckER9nSGlffedhzbYC1ACRLxKeYxWt9fjjKSccApepZVvGo
         /C+B0vzkKTmPbNKXaws5ZmE/Y/iU7fOI3u8EqL0mvWQkUI4EjaolxIBK4TEs87z1Le/Q
         0lDG7fC+Z/ExFs6xNxNVS6hmmzyjFkMH8xPgQmCb/jRAwHLFIxO3IXphZgzsXuCyUtro
         BY/g==
X-Forwarded-Encrypted: i=1; AJvYcCXzVMrGSMK2mp9Q0qESYJjvodRsMuM3lai6q3Kou0ktQejYXqthudHY8lGGA8EP2jRHuWsIuSaJfqv0uUSv@vger.kernel.org
X-Gm-Message-State: AOJu0YxmepTSet9ezW5T+1S6BThz0V/EAtBJaMz802V//aYJ2gfhwRI/
	2Czpc0lCtXwrm/E/btYWlYgA2JEVxk2nlWtxk0NeUaq5SQxKepPlnkujwjwsWGc=
X-Google-Smtp-Source: AGHT+IHJh+1ZXsYwxslZQeQFaVaIosIBJ9byAeINs1Cby21LH+tx3YEEJESgsOz7GEIKZ2P3AAXg4A==
X-Received: by 2002:a05:6a21:99a0:b0:1d4:f7b7:f20 with SMTP id adf61e73a8af0-1db7ff5e5e7mr749841637.21.1730245465983;
        Tue, 29 Oct 2024 16:44:25 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm8157643b3a.33.2024.10.29.16.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:44:25 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Oct 2024 16:44:04 -0700
Subject: [PATCH v7 04/32] riscv: Add support for per-thread envcfg CSR
 values
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-v5_user_cfi_series-v7-4-2727ce9936cb@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Samuel Holland <samuel.holland@sifive.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Deepak Gupta <debug@rivosinc.com>
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
2.34.1


