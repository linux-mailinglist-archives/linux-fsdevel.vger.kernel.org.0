Return-Path: <linux-fsdevel+bounces-34308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C2B9C47CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49500B32F22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 20:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009A91CB33A;
	Mon, 11 Nov 2024 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zZkJAkNj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05051CB31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358466; cv=none; b=K+1zZbG27hNrsl45gUoviwOs5N2faCqgIx2p6fk6ikaDu+W5av9+vhRmDxT2N6On5d6yBj7yhzIEqw/0QaDCVyave3YquZJ54egdSdKDx3bh+zl4FAnliq3UWRv2C0OwoX5IdOyoCkXJUtUTFgPEPrrDdGG6DiaS4N30Tt6jmSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358466; c=relaxed/simple;
	bh=M8UDD/dqlEd/X3kkmt5qQtXayEoz402O/i2ISfsAGQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mAG/VKtLnnrR7w5Vv2ulyofRZAL/3tGKaaFOBG+0jqC9VZHGx/cDTlD8H5fLj37hkwljNeC7AdqTNbeE7DA0HixwQaNleODGiXAXREB14DWX1AH1tOeAOWSRLyknHshmAefsAjGYwzcTDqq8W1UnFq1/vutfb6SxbwxFJ0MluYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zZkJAkNj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ce5e3b116so43978065ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358464; x=1731963264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJnRmE7nzvvUdOgcQw+N8m7/qUjw6OBKlSgXkJR7mUo=;
        b=zZkJAkNj4qE4oqlF7xg8UkjXcjbHTf3p/brf4TMsS25U4VyaOTcou7or7YJbB2rpc0
         R0XES/0uep1AwZWgZQIWdSf7FEFmQMS4W8DBNbC7XqBMmaY35fk+kzIn9FHXvf46oFGb
         jnqfhpZA4wCWHFMUKd5x6PwTrD6sHAQlpNgx1JgXxF3X5S+tmL5ea3uIpeiV5yiUHQ9t
         ayC3EHLGiF3foYP3weVULjwVofV6rCv70nHc/59qvC4k87dHhp969ptMBJ65nooxvFVZ
         1Ne7g7f17rCVWzbJVLfSijF39EODQUl96R1Mzd3FXYlNEAf+0FowvscEp2KtHLyZkpet
         RYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358464; x=1731963264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJnRmE7nzvvUdOgcQw+N8m7/qUjw6OBKlSgXkJR7mUo=;
        b=kJGxHVV/0Q/X+6JMwbyMJ+O57FQn4OEqUGrAiOvXb2s50wHhjhg6jrrtrIUTV+rEiq
         IxT2ATup8h8kh0in/fcuxIJuMqEDhH6emgmJJZEytPYOpeOf0LFhIBbxb8dLRx0joIlH
         sjHdOcp6MGsgJ1B/MicdGypkeb4E7zOlDVFChePqtNa4IwKoSKJ8jV9oFj4y4UxSubr9
         C1PgR09lCgHh8gSvrvHZok61CGiYYeh7YyxGkbIT+pRMRmlXI+TbewqqXQl4HC/9TYWG
         cnFOUaZwYCnChSl1WzYdkwhc5tutavJFODtSt3/DghD4/kKt+3CmpO9R9wmx8Du8jzwf
         H4wA==
X-Forwarded-Encrypted: i=1; AJvYcCXi9AY7sYif0K4TDUGoV2xJaqhnd/8/KNUnp9chQgkJERKLRq5aomls4mn2nZru3KCyP01ww6qmukjhzmal@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ925l/GI69EJh+uJc6K6MN6XTFFAU44f7k/Pw5CCOHnapZKdh
	CX6F24OfFwA2K3Tw9jwhf5HxtB4jnASbuwgddEXWKHiXirboq/co2U6SNiHGxdw=
X-Google-Smtp-Source: AGHT+IGBjJ2qmkhI/9KkSAaUQ4/thfZExOudz5gsftSVr6ezuggghKNqKZsYYiLOvkR07Zl8T47kbA==
X-Received: by 2002:a17:903:2cd:b0:20b:a10c:9be3 with SMTP id d9443c01a7336-21183d4e6d4mr180460215ad.21.1731358464144;
        Mon, 11 Nov 2024 12:54:24 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:54:23 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:53:56 -0800
Subject: [PATCH v8 11/29] riscv/mm: Implement map_shadow_stack() syscall
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-11-dce14aa30207@rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/Makefile      |   2 +
 arch/riscv/kernel/usercfi.c     | 145 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/asm-generic/mman.h |   4 ++
 3 files changed, 151 insertions(+)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 30db92672ada..3f5a8eafe578 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -118,3 +118,5 @@ obj-$(CONFIG_COMPAT)		+= compat_vdso/
 obj-$(CONFIG_64BIT)		+= pi/
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_ACPI_NUMA)	+= acpi_numa.o
+
+obj-$(CONFIG_RISCV_USER_CFI) += usercfi.o
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
new file mode 100644
index 000000000000..96bb324abafb
--- /dev/null
+++ b/arch/riscv/kernel/usercfi.c
@@ -0,0 +1,145 @@
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
+		RISCV_ACQUIRE_BARRIER
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
+	if (amo_user_shstk((unsigned long __user *)addr, (unsigned long) ssp) == -1)
+		return -EFAULT;
+
+	if (token_addr)
+		*token_addr = addr;
+
+	return 0;
+}
+
+static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long size,
+				unsigned long token_offset,
+				bool set_tok)
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
+				VM_SHADOW_STACK | VM_WRITE, 0, &populate, NULL);
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
diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
index 57e8195d0b53..9cfb3c1e337d 100644
--- a/include/uapi/asm-generic/mman.h
+++ b/include/uapi/asm-generic/mman.h
@@ -19,4 +19,8 @@
 #define MCL_FUTURE	2		/* lock all future mappings */
 #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
 
+/* Set up a restore token in the shadow stack */
+#define SHADOW_STACK_SET_TOKEN (1ULL << 0)
+/* Set up a top of stack marker in the shadow stack */
+#define SHADOW_STACK_SET_MARKER (1ULL << 1)
 #endif /* __ASM_GENERIC_MMAN_H */

-- 
2.45.0


