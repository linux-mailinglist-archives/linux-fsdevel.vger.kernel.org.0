Return-Path: <linux-fsdevel+bounces-32150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DBB9A1559
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 23:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325ED28150A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 21:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91131D5CE7;
	Wed, 16 Oct 2024 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cpTqYUkJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5B1D45F2
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115863; cv=none; b=hvtHpnaYvMZBllSBuhYTm54FhYoGDMBC7/nTUusm0ko4dG7cMos3jtvaK3KRGYgXZ70Gu4NPX1VC75E8PBuwnFHznFInco8xLCoVU42n2ubqBHd+8ABhqwSmXEqC/azsEfFCVwv0sVWgZBTd68U9iV2bgAGiQlfvO3zsBDYCfEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115863; c=relaxed/simple;
	bh=UA9RUHleVzTBj1jXq+b5Ql4QpQ5VcH8Odm5vrkVycXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KGo43wYr0WDVtPr1HXhap7+HCXM/r+mE+2o0PB6YHFXo/yxJciErMFoV6DxHXqpsg4wmQuo4f2y5yeMjgc4jbA7Hz8aSSOkrrJEMA6UJ1zSKedpb1BLaNNCoRRbKnkTaAGxze/SU2Gb9Dm+jq0q9wM9mZ4Dopv0PMW3uU5UOFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cpTqYUkJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c70abba48so2668015ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729115860; x=1729720660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Cz5vF6A8ORZeY1cEQGXtdF7pJ+XZREd9sGOCjruplk=;
        b=cpTqYUkJZNrX+kdaxO1/nh/z7l1+JmIx2RBQfiHl/hdXP2AwKEU+Iy3suv/J3NWtti
         Rlv6g4TaV9UEwYwERBuJGfjk5bm29ID5pD/PNsOxPVhGP3//55lvGvhwZw3hR+nB9gzD
         tMBEDz7orneDWOgQUBfq0LEreMxO/6WxsXW2854w0xi70ecJflTsCZS9GFoHIaIEe8Zj
         2QWGHMas6MrrVQiArf3tBvOmAMlGmvZmmsS9ZjF5R0EqeZ/XLeKyFzbSP9ZDvKRtFHQD
         vVKyPtdf2mlWCYxiSHH5uCvd198yJs1u6IZjZRfaprjz5zRKuR3CVQK2413zaZFDsIU2
         ev2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115860; x=1729720660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Cz5vF6A8ORZeY1cEQGXtdF7pJ+XZREd9sGOCjruplk=;
        b=CNQ3p6BSYPK15KiJZwvY2UJc+G2+JqiIQqcbi9ag77Cn8CPMidNPKM/UgcuCk1J58y
         RMwNEnTSGOPsMP1I9JkruBtjGXEB/zb1wHoUhykWRDtOSKL+HIgh/0rmA9dsAj/mTZX9
         4Y9fQ9MoHFfnIpW2f4hCO/VfAnKEMumsOeWdXCmfn/+abmxFzxdtF9SlFonr1jQUP0Ed
         Ht4o9kf1BtOq7Uy02z7gvcUWYuACCedYJDkskivYYn06oEabYlqpuVdWJaOC/lhofX6k
         85ivI0hXixV4F/9A0LUYLGEaV252mBjik+C1VMwwhMyFscliLDfXJR26E3NlVXEr+RWT
         oChA==
X-Forwarded-Encrypted: i=1; AJvYcCWVdOkgxRyrnLaowdeF/tb06ls9iG2yiJQ79a0cbHVkkMsSB7O2/jHRWAWggeRP1c4+h2kfbaNzCbMVdxWD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo9zjejl2akwcJbXpGbqT75oGkMS8kDCxUZtaZxXlxuoHq+KQ1
	6ILXp3WNqbMz/LYNh3Z67zjuKvIKh6TpxFl2Azw8YbauTQYyYSiQmSsrczR6OEw=
X-Google-Smtp-Source: AGHT+IGZ01+86e/vK/iXrBpqVEYHxeNuio5G/NuosXloiX7aqgv/9qs580q/7Mz0aTsAfHOZaGn29g==
X-Received: by 2002:a17:903:41c2:b0:20b:920e:8fd3 with SMTP id d9443c01a7336-20cbb1c407emr250356465ad.35.1729115860394;
        Wed, 16 Oct 2024 14:57:40 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f87ccasm32973295ad.62.2024.10.16.14.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:57:39 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 16 Oct 2024 14:57:34 -0700
Subject: [PATCH RFC/RFT v2 2/2] kernel: converge common shadow stack flow
 agnostic to arch
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-shstk_converge-v2-2-c41536eb5c3b@rivosinc.com>
References: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
In-Reply-To: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-arch@vger.kernel.org, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Mark Brown <broonie@kernel.org>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

CPU assisted shadow stack are supported by x86, arm64 and risc-v. In
terms of enabling shadow stack feature for usermode code in kernel,
they have following commonalities

- Expose a user ABI (via a prctl) to allow user mode to explicitly
  ask for enabling shadow stack instead of by default enabling it.
  x86 series pre-dates arm64 or risc-v announcment of support, so it
  ended up doing a arch specific prctl instead of generic one. arm64
  and risc-v have converged on using generic prctl and each of them
  can handle it appropriatley.

- On fork or clone, shadow stack has to be COWed or not COWed depending
  on CLONE_VM was passed or not. Additionally if CLONE_VFORK was passed
  then same (parent one) shadow stack should be used.

- To create shadow stack mappings, implement `map_shadow_stack` system
  call.

This patch picks up Mark Brown's `ARCH_HAS_USER_SHADOW_STACK` config
introduction and incorproate most of the common flows between different
architectures.

On a high level, shadow stack allocation and shadow stack de-allocation
are base operations on virtual memory and common between architectures.
Similarly shadow stack setup on prctl (arch specific or otherwise) is a
common flow. Treatment of shadow stack virtual memory on `clone/fork` and
implementaiton of `map_shadow_stack` is also converged into common flow.

To implement these common flows, each architecture have arch-specific
enabling mechanism as well as arch-specific data structures in task/
thread struct. So additionally this patch tries to abstract certain
operation/helpers and allowing each architecture to have their arch_*
implementation to implement the abstractions.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/x86/include/asm/shstk.h           |   7 +
 arch/x86/include/uapi/asm/mman.h       |   3 -
 arch/x86/kernel/shstk.c                | 223 +++++---------------------------
 include/linux/usershstk.h              |  22 ++++
 include/uapi/asm-generic/mman-common.h |   5 +
 kernel/Makefile                        |   2 +
 kernel/usershstk.c                     | 230 +++++++++++++++++++++++++++++++++
 7 files changed, 296 insertions(+), 196 deletions(-)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 4cb77e004615..b40c3d91538b 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -37,6 +37,13 @@ static inline int shstk_update_last_frame(unsigned long val) { return 0; }
 static inline bool shstk_is_enabled(void) { return false; }
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
+int arch_create_shstk_token(unsigned long ssp, unsigned long *token_addr);
+bool arch_user_shstk_supported(void);
+bool arch_is_shstk_enabled(struct task_struct *task);
+void arch_set_shstk_base_size(struct task_struct *task, unsigned long base,
+			unsigned long size);
+void arch_get_shstk_base_size(struct task_struct *task, unsigned long *base,
+			unsigned long *size);
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_SHSTK_H */
diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index 46cdc941f958..ac1e6277212b 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -5,9 +5,6 @@
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 #define MAP_ABOVE4G	0x80		/* only map above 4GB */
 
-/* Flags for map_shadow_stack(2) */
-#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
-
 #include <asm-generic/mman.h>
 
 #endif /* _ASM_X86_MMAN_H */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 059685612362..d53a7efd70b5 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -25,6 +25,7 @@
 #include <asm/special_insns.h>
 #include <asm/fpu/api.h>
 #include <asm/prctl.h>
+#include <linux/usershstk.h>
 
 #define SS_FRAME_SIZE 8
 
@@ -43,11 +44,39 @@ static void features_clr(unsigned long features)
 	current->thread.features &= ~features;
 }
 
+bool arch_user_shstk_supported(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_USER_SHSTK);
+}
+
+bool arch_is_shstk_enabled(struct task_struct *task)
+{
+	return features_enabled(ARCH_SHSTK_SHSTK);
+}
+
+void arch_set_shstk_base_size(struct task_struct *task, unsigned long base,
+			unsigned long size)
+{
+	struct thread_shstk *shstk = &task->thread.shstk;
+
+	shstk->base = base;
+	shstk->size = size;
+}
+
+void arch_get_shstk_base_size(struct task_struct *task, unsigned long *base,
+			unsigned long *size)
+{
+	struct thread_shstk *shstk = &task->thread.shstk;
+
+	*base = shstk->base;
+	*size = shstk->size;
+}
+
 /*
  * Create a restore token on the shadow stack.  A token is always 8-byte
  * and aligned to 8.
  */
-static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
+int arch_create_shstk_token(unsigned long ssp, unsigned long *token_addr)
 {
 	unsigned long addr;
 
@@ -72,88 +101,6 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
 	return 0;
 }
 
-/*
- * VM_SHADOW_STACK will have a guard page. This helps userspace protect
- * itself from attacks. The reasoning is as follows:
- *
- * The shadow stack pointer(SSP) is moved by CALL, RET, and INCSSPQ. The
- * INCSSP instruction can increment the shadow stack pointer. It is the
- * shadow stack analog of an instruction like:
- *
- *   addq $0x80, %rsp
- *
- * However, there is one important difference between an ADD on %rsp
- * and INCSSP. In addition to modifying SSP, INCSSP also reads from the
- * memory of the first and last elements that were "popped". It can be
- * thought of as acting like this:
- *
- * READ_ONCE(ssp);       // read+discard top element on stack
- * ssp += nr_to_pop * 8; // move the shadow stack
- * READ_ONCE(ssp-8);     // read+discard last popped stack element
- *
- * The maximum distance INCSSP can move the SSP is 2040 bytes, before
- * it would read the memory. Therefore a single page gap will be enough
- * to prevent any operation from shifting the SSP to an adjacent stack,
- * since it would have to land in the gap at least once, causing a
- * fault.
- */
-static unsigned long alloc_shstk(unsigned long addr, unsigned long size,
-				 unsigned long token_offset, bool set_res_tok)
-{
-	int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_ABOVE4G;
-	struct mm_struct *mm = current->mm;
-	unsigned long mapped_addr, unused;
-
-	if (addr)
-		flags |= MAP_FIXED_NOREPLACE;
-
-	mmap_write_lock(mm);
-	mapped_addr = do_mmap(NULL, addr, size, PROT_READ, flags,
-			      VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
-	mmap_write_unlock(mm);
-
-	if (!set_res_tok || IS_ERR_VALUE(mapped_addr))
-		goto out;
-
-	if (create_rstor_token(mapped_addr + token_offset, NULL)) {
-		vm_munmap(mapped_addr, size);
-		return -EINVAL;
-	}
-
-out:
-	return mapped_addr;
-}
-
-static unsigned long adjust_shstk_size(unsigned long size)
-{
-	if (size)
-		return PAGE_ALIGN(size);
-
-	return PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G));
-}
-
-static void unmap_shadow_stack(u64 base, u64 size)
-{
-	int r;
-
-	r = vm_munmap(base, size);
-
-	/*
-	 * mmap_write_lock_killable() failed with -EINTR. This means
-	 * the process is about to die and have it's MM cleaned up.
-	 * This task shouldn't ever make it back to userspace. In this
-	 * case it is ok to leak a shadow stack, so just exit out.
-	 */
-	if (r == -EINTR)
-		return;
-
-	/*
-	 * For all other types of vm_munmap() failure, either the
-	 * system is out of memory or there is bug.
-	 */
-	WARN_ON_ONCE(r);
-}
-
 static int shstk_setup(void)
 {
 	struct thread_shstk *shstk = &current->thread.shstk;
@@ -191,48 +138,6 @@ void reset_thread_features(void)
 	current->thread.features_locked = 0;
 }
 
-unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
-				       unsigned long stack_size)
-{
-	struct thread_shstk *shstk = &tsk->thread.shstk;
-	unsigned long addr, size;
-
-	/*
-	 * If shadow stack is not enabled on the new thread, skip any
-	 * switch to a new shadow stack.
-	 */
-	if (!features_enabled(ARCH_SHSTK_SHSTK))
-		return 0;
-
-	/*
-	 * For CLONE_VFORK the child will share the parents shadow stack.
-	 * Make sure to clear the internal tracking of the thread shadow
-	 * stack so the freeing logic run for child knows to leave it alone.
-	 */
-	if (clone_flags & CLONE_VFORK) {
-		shstk->base = 0;
-		shstk->size = 0;
-		return 0;
-	}
-
-	/*
-	 * For !CLONE_VM the child will use a copy of the parents shadow
-	 * stack.
-	 */
-	if (!(clone_flags & CLONE_VM))
-		return 0;
-
-	size = adjust_shstk_size(stack_size);
-	addr = alloc_shstk(0, size, 0, false);
-	if (IS_ERR_VALUE(addr))
-		return addr;
-
-	shstk->base = addr;
-	shstk->size = size;
-
-	return addr + size;
-}
-
 static unsigned long get_user_shstk_addr(void)
 {
 	unsigned long long ssp;
@@ -402,44 +307,6 @@ int restore_signal_shadow_stack(void)
 	return 0;
 }
 
-void shstk_free(struct task_struct *tsk)
-{
-	struct thread_shstk *shstk = &tsk->thread.shstk;
-
-	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
-	    !features_enabled(ARCH_SHSTK_SHSTK))
-		return;
-
-	/*
-	 * When fork() with CLONE_VM fails, the child (tsk) already has a
-	 * shadow stack allocated, and exit_thread() calls this function to
-	 * free it.  In this case the parent (current) and the child share
-	 * the same mm struct.
-	 */
-	if (!tsk->mm || tsk->mm != current->mm)
-		return;
-
-	/*
-	 * If shstk->base is NULL, then this task is not managing its
-	 * own shadow stack (CLONE_VFORK). So skip freeing it.
-	 */
-	if (!shstk->base)
-		return;
-
-	/*
-	 * shstk->base is NULL for CLONE_VFORK child tasks, and so is
-	 * normal. But size = 0 on a shstk->base is not normal and
-	 * indicated an attempt to free the thread shadow stack twice.
-	 * Warn about it.
-	 */
-	if (WARN_ON(!shstk->size))
-		return;
-
-	unmap_shadow_stack(shstk->base, shstk->size);
-
-	shstk->size = 0;
-}
-
 static int wrss_control(bool enable)
 {
 	u64 msrval;
@@ -502,36 +369,6 @@ static int shstk_disable(void)
 	return 0;
 }
 
-SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
-{
-	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
-	unsigned long aligned_size;
-
-	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
-		return -EOPNOTSUPP;
-
-	if (flags & ~SHADOW_STACK_SET_TOKEN)
-		return -EINVAL;
-
-	/* If there isn't space for a token */
-	if (set_tok && size < 8)
-		return -ENOSPC;
-
-	if (addr && addr < SZ_4G)
-		return -ERANGE;
-
-	/*
-	 * An overflow would result in attempting to write the restore token
-	 * to the wrong location. Not catastrophic, but just return the right
-	 * error code and block it.
-	 */
-	aligned_size = PAGE_ALIGN(size);
-	if (aligned_size < size)
-		return -EOVERFLOW;
-
-	return alloc_shstk(addr, aligned_size, size, set_tok);
-}
-
 long shstk_prctl(struct task_struct *task, int option, unsigned long arg2)
 {
 	unsigned long features = arg2;
diff --git a/include/linux/usershstk.h b/include/linux/usershstk.h
new file mode 100644
index 000000000000..4ab27a1ab3f8
--- /dev/null
+++ b/include/linux/usershstk.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SHSTK_H
+#define _SHSTK_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+unsigned long alloc_shstk(unsigned long addr, unsigned long size,
+				 unsigned long token_offset, bool set_res_tok);
+int create_shstk_token(unsigned long ssp, unsigned long *token_addr);
+bool user_shstk_supported(void);
+bool is_shstk_enabled(struct task_struct *task);
+void set_shstk_base_size(struct task_struct *task, unsigned long base,
+			unsigned long size);
+void get_shstk_base_size(struct task_struct *task, unsigned long *base,
+			unsigned long *size);
+unsigned long adjust_shstk_size(unsigned long size);
+void unmap_shadow_stack(u64 base, u64 size);
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _SHSTK_H */
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..5d6fb32fda95 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -87,4 +87,9 @@
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
 				 PKEY_DISABLE_WRITE)
 
+/* Flags for map_shadow_stack(2) */
+#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
+#define SHADOW_STACK_SET_MARKER (1ULL << 1) /* Set up a top of stack marker in the shadow stack */
+
+#define SHADOW_STACK_SET_MASK	(SHADOW_STACK_SET_TOKEN | SHADOW_STACK_SET_MARKER)
 #endif /* __ASM_GENERIC_MMAN_COMMON_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 87866b037fbe..1922c456b954 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -140,6 +140,8 @@ KCOV_INSTRUMENT_stackleak.o := n
 
 obj-$(CONFIG_SCF_TORTURE_TEST) += scftorture.o
 
+obj-$(CONFIG_ARCH_HAS_USER_SHADOW_STACK) += usershstk.o
+
 $(obj)/configs.o: $(obj)/config_data.gz
 
 targets += config_data config_data.gz
diff --git a/kernel/usershstk.c b/kernel/usershstk.c
new file mode 100644
index 000000000000..1ebce6b768aa
--- /dev/null
+++ b/kernel/usershstk.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * shstk.c - Intel shadow stack support
+ *
+ * Copyright (c) 2021, Intel Corporation.
+ * Yu-cheng Yu <yu-cheng.yu@intel.com>
+ */
+
+#include <linux/sched.h>
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/sched/signal.h>
+#include <linux/compat.h>
+#include <linux/sizes.h>
+#include <linux/user.h>
+#include <linux/syscalls.h>
+#include <asm/shstk.h>
+#include <linux/usershstk.h>
+
+#define SHSTK_ENTRY_SIZE sizeof(void *)
+
+bool user_shstk_supported(void)
+{
+	return arch_user_shstk_supported();
+}
+
+bool is_shstk_enabled(struct task_struct *task)
+{
+	return arch_is_shstk_enabled(task);
+}
+
+void set_shstk_base_size(struct task_struct *task, unsigned long base,
+			unsigned long size)
+{
+	arch_set_shstk_base_size(task, base, size);
+}
+
+void get_shstk_base_size(struct task_struct *task, unsigned long *base,
+			unsigned long *size)
+{
+	arch_get_shstk_base_size(task, base, size);
+}
+
+int create_shstk_token(unsigned long ssp, unsigned long *token_addr)
+{
+	return arch_create_shstk_token(ssp, token_addr);
+}
+
+unsigned long adjust_shstk_size(unsigned long size)
+{
+	if (size)
+		return PAGE_ALIGN(size);
+
+	return PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G));
+}
+
+void unmap_shadow_stack(u64 base, u64 size)
+{
+	int r;
+
+	r = vm_munmap(base, size);
+
+	/*
+	 * mmap_write_lock_killable() failed with -EINTR. This means
+	 * the process is about to die and have it's MM cleaned up.
+	 * This task shouldn't ever make it back to userspace. In this
+	 * case it is ok to leak a shadow stack, so just exit out.
+	 */
+	if (r == -EINTR)
+		return;
+
+	/*
+	 * For all other types of vm_munmap() failure, either the
+	 * system is out of memory or there is bug.
+	 */
+	WARN_ON_ONCE(r);
+}
+
+/*
+ * allocates a fresh shadow stack mapping and if required place a shadow
+ * stack token at base
+ */
+unsigned long alloc_shstk(unsigned long addr, unsigned long size,
+				 unsigned long token_offset, bool set_res_tok)
+{
+	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
+
+	flags |= IS_ENABLED(CONFIG_X86_64) ? MAP_ABOVE4G : 0;
+
+	struct mm_struct *mm = current->mm;
+	unsigned long mapped_addr, unused;
+
+	if (addr)
+		flags |= MAP_FIXED_NOREPLACE;
+
+	mmap_write_lock(mm);
+	mapped_addr = do_mmap(NULL, addr, size, PROT_READ, flags,
+			      VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
+	mmap_write_unlock(mm);
+
+	if (!set_res_tok || IS_ERR_VALUE(mapped_addr))
+		goto out;
+
+	if (create_shstk_token(mapped_addr + token_offset, NULL)) {
+		vm_munmap(mapped_addr, size);
+		return -EINVAL;
+	}
+
+out:
+	return mapped_addr;
+}
+
+void shstk_free(struct task_struct *tsk)
+{
+	unsigned long base, size;
+
+	if (!user_shstk_supported() ||
+	    !is_shstk_enabled(current))
+		return;
+
+	/*
+	 * When fork() with CLONE_VM fails, the child (tsk) already has a
+	 * shadow stack allocated, and exit_thread() calls this function to
+	 * free it.  In this case the parent (current) and the child share
+	 * the same mm struct.
+	 */
+	if (!tsk->mm || tsk->mm != current->mm)
+		return;
+
+	get_shstk_base_size(tsk, &base, &size);
+	/*
+	 * If shstk->base is NULL, then this task is not managing its
+	 * own shadow stack (CLONE_VFORK). So skip freeing it.
+	 */
+	if (!base)
+		return;
+
+	/*
+	 * shstk->base is NULL for CLONE_VFORK child tasks, and so is
+	 * normal. But size = 0 on a shstk->base is not normal and
+	 * indicated an attempt to free the thread shadow stack twice.
+	 * Warn about it.
+	 */
+	if (WARN_ON(!size))
+		return;
+
+	unmap_shadow_stack(base, size);
+
+	set_shstk_base_size(tsk, 0, 0);
+}
+
+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
+{
+	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
+	unsigned long aligned_size;
+
+	if (!user_shstk_supported())
+		return -EOPNOTSUPP;
+
+	if (flags & ~SHADOW_STACK_SET_MASK)
+		return -EINVAL;
+
+	/* If there isn't space for a token */
+	if (set_tok && size < SHSTK_ENTRY_SIZE)
+		return -ENOSPC;
+
+	if (addr && (addr & (PAGE_SIZE - 1)))
+		return -EINVAL;
+
+	if (IS_ENABLED(CONFIG_X86_64) &&
+		addr && addr < SZ_4G)
+		return -ERANGE;
+
+	/*
+	 * An overflow would result in attempting to write the restore token
+	 * to the wrong location. Not catastrophic, but just return the right
+	 * error code and block it.
+	 */
+	aligned_size = PAGE_ALIGN(size);
+	if (aligned_size < size)
+		return -EOVERFLOW;
+
+	return alloc_shstk(addr, aligned_size, size, set_tok);
+}
+
+unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
+				       unsigned long stack_size)
+{
+	unsigned long addr, size;
+
+	if (!user_shstk_supported())
+		return -EOPNOTSUPP;
+
+	/*
+	 * If shadow stack is not enabled on the new thread, skip any
+	 * switch to a new shadow stack.
+	 */
+	if (!is_shstk_enabled(tsk))
+		return 0;
+
+	/*
+	 * For CLONE_VFORK the child will share the parents shadow stack.
+	 * Make sure to clear the internal tracking of the thread shadow
+	 * stack so the freeing logic run for child knows to leave it alone.
+	 */
+	if (clone_flags & CLONE_VFORK) {
+		set_shstk_base_size(tsk, 0, 0);
+		return 0;
+	}
+
+	/*
+	 * For !CLONE_VM the child will use a copy of the parents shadow
+	 * stack.
+	 */
+	if (!(clone_flags & CLONE_VM))
+		return 0;
+
+	size = adjust_shstk_size(stack_size);
+	addr = alloc_shstk(0, size, 0, false);
+	if (IS_ERR_VALUE(addr))
+		return addr;
+
+	set_shstk_base_size(tsk, addr, size);
+
+	return addr + size;
+}

-- 
2.34.1


