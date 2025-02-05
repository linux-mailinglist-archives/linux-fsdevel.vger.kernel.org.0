Return-Path: <linux-fsdevel+bounces-40872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9640A280CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 02:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8AF37A28F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 01:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83C422A7E6;
	Wed,  5 Feb 2025 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dtzwY2m+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DBC22A4DC
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 01:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718529; cv=none; b=ScySVwkmxWR9BVKOebCV4h/6u21h0Cg7WR+n3i+bkkQgfE7yWkh2s9zC2Yg8u9pfdp+BEZgDFq9OVoHa+g2d5Jbdsv+WMQF7mpMmLncegSRF3lbnPBujhZG8u9DWG3MuX1v6NzR+jPiQ+Aq1h9ofu86pynjimkJdtFbAG1Azea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718529; c=relaxed/simple;
	bh=toOY3g5UWbhyzFvpokgMbtCDrGwGLK+0MjdImo2Zc6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Elk8GtVqhUMPEhv9wgAtTRQ1Kg9CXrPkZbPzA/FhfhsA4uQmTr+p5Odx6ctSQ+mzR4tWvOKuq5LAMq6n1tYuRy1rp2a/mlEn37eBU4VsaxFSneAAXrfnrvrIlhlhRDvG6rgPlCn/1YktxtBHlYWz8c7Ukrj9SiLKRHgJZxjKj1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dtzwY2m+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2161eb95317so110997395ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 17:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718525; x=1739323325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1e5RgGuqZS+AKw5oTSgp47pWFJ0GDjWFc7jT6Xd5TJc=;
        b=dtzwY2m+FXezOKTSyjlDXgShTfRgwP5V1LTUmMIN22MWLRnKo+naWRMD/JvGnNSHaS
         UUbpg9X5n8TvdK3S2HsoBDqGpz2mlBktoSn+gyQqgdSrHiDc8RqR5hMWTmcfD2fJsG2x
         zPgR2oOKyXDsGyuLr3eyF2tEyHP06A1swN5pB0LMzNGwAjSCWxtikh7jIZEOgoFPZTyi
         xCIugqe79snPlKcgI9jwb8ubPbhhD6wmZ5r3wCLybUyw/JoZL/E92BpqrXzKo5SOUSBv
         g1EheIWV7IxZqZEquxGRTg3DYkkTEdBBvrH64yF6x6/5MvX9CG1IEWzsRCgSGygg5s/T
         eXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718525; x=1739323325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1e5RgGuqZS+AKw5oTSgp47pWFJ0GDjWFc7jT6Xd5TJc=;
        b=vF+cVQX3nv3nS8Xk//aQQn/5U/1MtH8/5UWm0Va8qF5mLCKhvs/kCH/KIfXvAzwS9R
         B7pMuL9jIbvdla3JaF2BsMTYIZ+Ij81vcPk+3xSVLsLxQLyMpKEGtDaOU14MAVWqjTNI
         vpbRm4c1yfIHxNTNzrTgL5LTTXdyp0poinJMvDwMiCn6p5q4YB2qrr4oTMftjlBOsRiY
         qsUhJPCC11qj4eLmaSaH6R3gDMrYL2AJ0mtpOZCyFYWegcM6yzaKfx+f6JenMBxQrHJn
         H/1o/XtkHm4JCa7Tza0LFZ8Ts0fBAILVLJgzekwydYoF9pfU4/Ie1+dj/IjrwtCpBbPP
         ZeGg==
X-Forwarded-Encrypted: i=1; AJvYcCXeku+Ki/mGEJwN6Lf9BkN6QUVBDKl79NuW/LGXviaC2OYv1jxBC0HmlfeDmkdEK4/z+5/Z0NI7enDbh3NK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6GZpmPbFwcBDHx30STXRi2mmgYjuJv3BMlFp3YKr7wsdDZYiq
	RsKiMC5aRzE7I/XCEa2u0WRwaXOChYbnjlOiikI1u083HdJAvtQL1F8IMHaRZaA=
X-Gm-Gg: ASbGncssKtV27/Kd6ix9mjHMvPen8ca46IA2Ninh/DZTZoO5Ww0BCOmNAR3E175yYSw
	o1guLl5mAFiiybECDpbJrvYGIHqtgtaZNQgitHCuUTFoOfjxGdornt+8W6i/6hjojaCSgLPanDR
	IIu3KswA4DI0ApKO//ksamQMoxn4jKjJ/f4P6QeXWIdfG1ggQDRqs5BrQgjf3ZcapY0PjpoHW6e
	8F6WqFiaNsLsO2K6pfiFdUkVk2ldcdrj0NxFH1LpfFJWU/FbdT9oPJPzVYqMJt1FjkQIOmzbZaA
	OpZAzZKaxZR+2V6Es1UYvH3hGg==
X-Google-Smtp-Source: AGHT+IGmwZmqjzvPRO4j1QnW6c26qtiThBAMPujeU03hhi/wAPDw8k7cHzAb2QmKpofb/oE3lFc7aw==
X-Received: by 2002:a05:6a00:e13:b0:725:e37d:cd36 with SMTP id d2e1a72fcca58-730350e4f2amr1787173b3a.2.1738718525565;
        Tue, 04 Feb 2025 17:22:05 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:22:05 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:21:53 -0800
Subject: [PATCH v9 06/26] riscv/mm : ensure PROT_WRITE leads to VM_READ |
 VM_WRITE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-v5_user_cfi_series-v9-6-b37a49c5205c@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

`arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
This is to make sure that any existing apps using PROT_WRITE still work.

Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
encodings for shadow stack. Above changes ensure that existing apps
continue to work because underneath kernel will be picking
`protection_map[VM_WRITE|VM_READ]` PTE encodings.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/mman.h    | 25 +++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/sys_riscv.c    | 10 ++++++++++
 arch/riscv/mm/init.c             |  2 +-
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
new file mode 100644
index 000000000000..392c9c2d2e78
--- /dev/null
+++ b/arch/riscv/include/asm/mman.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <uapi/asm/mman.h>
+
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+						   unsigned long pkey __always_unused)
+{
+	unsigned long ret = 0;
+
+	/*
+	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
+	 * Only VM_WRITE means shadow stack.
+	 */
+	if (prot & PROT_WRITE)
+		ret = (VM_READ | VM_WRITE);
+	return ret;
+}
+
+#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
+
+#endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 050fdc49b5ad..8c528cd7347a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -178,6 +178,7 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
 #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
 #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
 					 _PAGE_EXEC | _PAGE_WRITE)
+#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
 
 #define PAGE_COPY		PAGE_READ
 #define PAGE_COPY_EXEC		PAGE_READ_EXEC
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index d77afe05578f..43a448bf254b 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -7,6 +7,7 @@
 
 #include <linux/syscalls.h>
 #include <asm/cacheflush.h>
+#include <asm-generic/mman-common.h>
 
 static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 			   unsigned long prot, unsigned long flags,
@@ -16,6 +17,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
 
+	/*
+	 * If PROT_WRITE is specified then extend that to PROT_READ
+	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
+	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
+	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
+	 */
+	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
+		prot |= PROT_READ;
+
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 15b2eda4c364..9d6661638d0b 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -342,7 +342,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READ,
-	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE]					= PAGE_SHADOWSTACK,
 	[VM_WRITE | VM_READ]				= PAGE_COPY,
 	[VM_EXEC]					= PAGE_EXEC,
 	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,

-- 
2.34.1


