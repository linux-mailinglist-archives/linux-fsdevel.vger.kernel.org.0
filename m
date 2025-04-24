Return-Path: <linux-fsdevel+bounces-47184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE6CA9A36E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FAD3BF0B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF021215160;
	Thu, 24 Apr 2025 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FGBTc1ea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B62147F2
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479257; cv=none; b=OAYJuOQp/GaXewzn7tuiIjwbF14ib34hbyDdQLC1dkBcxChFAKoTO3ld6N3Jf6SuzQPSpKgvjxoSruEm/8X0Yp/e/3kb0B4ibm3gCaw9i0at0E7atvvWQvKXZmOqG8hQXDWMC8k0Qme8YErCPG31hhsqC8ssnFd9VNv91XmS8p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479257; c=relaxed/simple;
	bh=blEoqggQsQhRB0qQ2LOUYe1TBy9Har2a+Y7ff8LDB+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBkJeMjG7hUkSNpAypI+uuvTr/7mMjbv+Hw+834EVrHJhOl7l4esdmWq+H2bwYLB1PguFaxj6zNhFUhNm+cXsIXMsrKC0q8Sl7ei7wHAGR2icGS7QFu2BWBQzvLGMA+EodlQgndT2I/64B9ngCXcqEYvvFZS0Def9XHol8pFf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FGBTc1ea; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30828fc17adso702152a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 00:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479254; x=1746084054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YoM38xw3FRuDhuA6RoI5dV9L/poXJy4s4CZPvznw1r4=;
        b=FGBTc1ea3TUcDravWN+SrvudvHYhVb8uuspde6DJ45nXoafVHgwBEhXaZwl6OpNfpN
         CMIgCg+WUHmOEnE/ijqqnJiNcYVNOsMk9Ma0ojEqcDQcPnHHngu9JWy8Auk1OaIPAwcb
         QervnvF4DG0UnFkUaNnPyXNIroh1I25q3Udlmkq2awtbLjqRKCU61Kdjo/RcF2FKUgW2
         MMrTjzSkcx6CIrNTe1Fz0xr9vHntmq/im1EYbTI28GW5X+dNgpmgnB0027cRx4cWZkyZ
         bFWCuWsXnY0802dMJw3f6wEL7dJzdx9GZel+3DQlNFIk2ZrbZUT5jBi7FVJR003ULyWN
         KDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479254; x=1746084054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoM38xw3FRuDhuA6RoI5dV9L/poXJy4s4CZPvznw1r4=;
        b=CuljoybG/qE3p1IYuFhGr7pBXQhj/jjvOnMuMBqd2TB4oCEcKUnJF6ZSXpsjU9LSxG
         9GprLlonRzJ0EVy4yFlAFEBOv5D97uK/uuvj7P5K1o7tu+pj+I/4Ax2pQmuvRrNWT+xj
         9Jnv2dWAY2jS2b12hS2ON8GU58EoUJhVvpHbOhTrOvJcrb4usUwO0qQC5i1DahRNDlbD
         yNaME2eSYkZN3BWlA61WbNB574TelfCWTWo6F/86DCuVwF2cmEWNAiuGiK2zUzQV9j8W
         KrLq9NRQZK8LEMrvKRzDM953NU3JV2+SetN2cHcQE+U3wK1KEnnF5eiVGKCqHluYXEq/
         Kiog==
X-Forwarded-Encrypted: i=1; AJvYcCWlOqQksxjnTEVJbWZYeQq0zg02kMp+Koqn0Ho82qggAudruoKssuSoa2Mu/fK4rJFKb+PqDsSl32PQitw5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5D2U7kyNZ87N9lLmS5Af8a78UFu7nubne947SZ2Vn+MoDqkqE
	YPvIFEE0t9/f0DVh1Hodzoxj5mxDt3JBfJ7cRIFFRIzvVcmf3ul5ds5nNdYkWS8=
X-Gm-Gg: ASbGncsonDnqk2/RZpxQUs9+8YhHFgA+t0Ym1p1uJbhpCSixt/v3nfx+CQ1cawsT7P+
	dwhsEfw+T0mcuNfIRxRQ3/7NgrO2Dic+reW0//C558W5NYfld76q2fn+duprvNEZVai1FuS4cfM
	U4UG1lz9Cafq7hsurlIs5VxIskKNrzN6mqTk8yWjfOSd+BrHaRIosj9dZE8nO2QztLBaWtOwmnx
	DHSUqeCPr/+y9vgRxxPhgJQwO+A9tEMx2f9SsxD9QVLboNoFOWzXGnqeIcI/rCT0nntChdE6Vom
	P1nJ/eB1sdE0svTTLw5+FQIyfO6LXOgIaqhHlCBX44WXk+Y2mRo=
X-Google-Smtp-Source: AGHT+IGfVwsUikq0bQIV14EUCQ0IOp+dkJwCi1COEFMYUDX0iiVF9XxD9BG766WedmzzylDvD3Duyw==
X-Received: by 2002:a17:90b:274e:b0:2ff:7b28:a51a with SMTP id 98e67ed59e1d1-309ed298e18mr2663446a91.17.1745479254515;
        Thu, 24 Apr 2025 00:20:54 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:20:54 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:25 -0700
Subject: [PATCH v13 10/28] riscv/mm: Implement map_shadow_stack() syscall
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-10-971437de586a@rivosinc.com>
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

As discussed extensively in the changelog for the addition of this
syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
existing mmap() and madvise() syscalls do not map entirely well onto the
security requirements for shadow stack memory since they lead to windows
where memory is allocated but not yet protected or stacks which are not
properly and safely initialised. Instead a new syscall map_shadow_stack()
has been defined which allocates and initialises a shadow stack page.

This patch implements this syscall for riscv. riscv doesn't require token
to be setup by kernel because user mode can do that by itself. However to
provide compatibility and portability with other architectues, user mode
can specify token set flag.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/Makefile  |   1 +
 arch/riscv/kernel/usercfi.c | 143 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 8d186bfced45..3a861d320654 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -125,3 +125,4 @@ obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_ACPI_NUMA)	+= acpi_numa.o
 
 obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) += bugs.o
+obj-$(CONFIG_RISCV_USER_CFI) += usercfi.o
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
new file mode 100644
index 000000000000..0b3bbb41490a
--- /dev/null
+++ b/arch/riscv/kernel/usercfi.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Rivos, Inc.
+ * Deepak Gupta <debug@rivosinc.com>
+ */
+
+#include <linux/sched.h>
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/uaccess.h>
+#include <linux/sizes.h>
+#include <linux/user.h>
+#include <linux/syscalls.h>
+#include <linux/prctl.h>
+#include <asm/csr.h>
+#include <asm/usercfi.h>
+
+#define SHSTK_ENTRY_SIZE sizeof(void *)
+
+/*
+ * Writes on shadow stack can either be `sspush` or `ssamoswap`. `sspush` can happen
+ * implicitly on current shadow stack pointed to by CSR_SSP. `ssamoswap` takes pointer to
+ * shadow stack. To keep it simple, we plan to use `ssamoswap` to perform writes on shadow
+ * stack.
+ */
+static noinline unsigned long amo_user_shstk(unsigned long *addr, unsigned long val)
+{
+	/*
+	 * Never expect -1 on shadow stack. Expect return addresses and zero
+	 */
+	unsigned long swap = -1;
+
+	__enable_user_access();
+	asm goto(
+		".option push\n"
+		".option arch, +zicfiss\n"
+		"1: ssamoswap.d %[swap], %[val], %[addr]\n"
+		_ASM_EXTABLE(1b, %l[fault])
+		".option pop\n"
+		: [swap] "=r" (swap), [addr] "+A" (*addr)
+		: [val] "r" (val)
+		: "memory"
+		: fault
+		);
+	__disable_user_access();
+	return swap;
+fault:
+	__disable_user_access();
+	return -1;
+}
+
+/*
+ * Create a restore token on the shadow stack.  A token is always XLEN wide
+ * and aligned to XLEN.
+ */
+static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
+{
+	unsigned long addr;
+
+	/* Token must be aligned */
+	if (!IS_ALIGNED(ssp, SHSTK_ENTRY_SIZE))
+		return -EINVAL;
+
+	/* On RISC-V we're constructing token to be function of address itself */
+	addr = ssp - SHSTK_ENTRY_SIZE;
+
+	if (amo_user_shstk((unsigned long __user *)addr, (unsigned long)ssp) == -1)
+		return -EFAULT;
+
+	if (token_addr)
+		*token_addr = addr;
+
+	return 0;
+}
+
+static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long size,
+					   unsigned long token_offset, bool set_tok)
+{
+	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
+	struct mm_struct *mm = current->mm;
+	unsigned long populate, tok_loc = 0;
+
+	if (addr)
+		flags |= MAP_FIXED_NOREPLACE;
+
+	mmap_write_lock(mm);
+	addr = do_mmap(NULL, addr, size, PROT_READ, flags,
+		       VM_SHADOW_STACK | VM_WRITE, 0, &populate, NULL);
+	mmap_write_unlock(mm);
+
+	if (!set_tok || IS_ERR_VALUE(addr))
+		goto out;
+
+	if (create_rstor_token(addr + token_offset, &tok_loc)) {
+		vm_munmap(addr, size);
+		return -EINVAL;
+	}
+
+	addr = tok_loc;
+
+out:
+	return addr;
+}
+
+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
+{
+	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
+	unsigned long aligned_size = 0;
+
+	if (!cpu_supports_shadow_stack())
+		return -EOPNOTSUPP;
+
+	/* Anything other than set token should result in invalid param */
+	if (flags & ~SHADOW_STACK_SET_TOKEN)
+		return -EINVAL;
+
+	/*
+	 * Unlike other architectures, on RISC-V, SSP pointer is held in CSR_SSP and is available
+	 * CSR in all modes. CSR accesses are performed using 12bit index programmed in instruction
+	 * itself. This provides static property on register programming and writes to CSR can't
+	 * be unintentional from programmer's perspective. As long as programmer has guarded areas
+	 * which perform writes to CSR_SSP properly, shadow stack pivoting is not possible. Since
+	 * CSR_SSP is writeable by user mode, it itself can setup a shadow stack token subsequent
+	 * to allocation. Although in order to provide portablity with other architecture (because
+	 * `map_shadow_stack` is arch agnostic syscall), RISC-V will follow expectation of a token
+	 * flag in flags and if provided in flags, setup a token at the base.
+	 */
+
+	/* If there isn't space for a token */
+	if (set_tok && size < SHSTK_ENTRY_SIZE)
+		return -ENOSPC;
+
+	if (addr && (addr & (PAGE_SIZE - 1)))
+		return -EINVAL;
+
+	aligned_size = PAGE_ALIGN(size);
+	if (aligned_size < size)
+		return -EOVERFLOW;
+
+	return allocate_shadow_stack(addr, aligned_size, size, set_tok);
+}

-- 
2.43.0


