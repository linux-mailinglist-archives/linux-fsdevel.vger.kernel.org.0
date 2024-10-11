Return-Path: <linux-fsdevel+bounces-31651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4A19997F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 02:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6111C25C7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 00:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0075464E;
	Fri, 11 Oct 2024 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="G0spaA2i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8543112B63
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606747; cv=none; b=VEM9E5iaolnBav4zvbWKaUNmFsBszoTlLQhkzcvyXVWcT1Z13X0jGHUBiqqU2EztrwtjGenNmAHky6PIK+Hw+4f9DQcdmiwxY5lzMXNga92368egsuMAxYXDaPjheLPENQv5jE5ICRXyd19e5HJkF9806jLt+b5zrMUZf8nX9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606747; c=relaxed/simple;
	bh=6vXMNEXgKS6x6arhnFZmYZ8DfGHVLedY/y0T1pAEr1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mx19s+vULtRyw7V9sW/erMIpdV5+SrC2VcUIyRH3hiGiP/1mb2Ei3n3oUFV9KgmJb1jtzQ/JByRL68LwaVy/HCZheeXZMKryRcyBrLFHTvbDQ8S8yTiokPvQNBlpAISQyfcxP2lY9lTVoQMVXE3pJ0eg2MaWrwnCeWaA5V/tYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=G0spaA2i; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71dfccba177so2130373b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 17:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728606745; x=1729211545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LsajkhEjibBVidc/N9UXu/T/kPuUFNE9m11+ozaBUc=;
        b=G0spaA2iZq0wzXZrR1sHjRh4XE66iY+ItUoANWdfGZ4eBwgV9UIRg3w1RB+S21VYYb
         d9Qcgill7Kru6Y9VY9E+M8Ro4/z0VHDNc1MO9euAEvVHeY5kL/TO6ak9N9GASu1J54TE
         R59w1i5yI04pXj9qhJ86FkCSTisXHSEeGeRnCRWUHldjNt2GmWFU1TOxVkoRo9Z+vojg
         R8ufMf/TQpKRTe5O7tgXBjUbMj7Se+UQvM2WM9ett27sNYQZZYFNLIIlL0hFSSsD6QU0
         ApeTOAXsjPQb9UvBqzjv2YqWImg995tVGtTjAxkDnzin6yxpVfULYqBmWMGndMLCwX8F
         Z9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728606745; x=1729211545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LsajkhEjibBVidc/N9UXu/T/kPuUFNE9m11+ozaBUc=;
        b=m62FprWdZV81bLpdGvrwcaTqQ0Q0oLckfPiAro5z7BQDZ2SZ4DA4jaJmXoQAYDMYtS
         aL4uvU5TuCMy5ZyXvBOfnjXMWOORn+h0ZczKfduJpeVTn6x2Y29lsDgPNGydv6pbXlx9
         GjtE1/uzLyQRrXU/CyUKeJ9pXHwjsAr8NqU8DGHwRlwAjxEpfikU0hXvkT3Pi24vLlct
         snzS499McaD9x9gMw4DQMHMtx8wpaPZiSmMHU/e5X8cvfP1ySHvS6bpZD2IOoEWL3Qyg
         t3L0lhD6JeSY4lgeOPWbEvDCH9JwQS3ypGV/VJCRrhBCmImYpVApo0h33fh/Ezvtg+mN
         E9RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWquE+RdxX0ILepZF5MULd0DgCEEfYe87sKGrGvnvd74KRKOekK5ijGL3Qniu/RjFzxK5IcndOyexAaxDmJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWCZ0zrkIluO+CnCjkWpQ3ChOq6EbV40pWVksRtEkE+4LV8Rm
	7wFJqp2NqN71gR3gYFPT7xFMTWUjneKW7d8S6nETPItmHAvNAjP+Bs0kx2k9NUY=
X-Google-Smtp-Source: AGHT+IFOFivpf2dfihVtShzwf9FEEOMn7Ved5zOgRCjh+YWjJ0yTlvWa3kaJvmwenVIm58jaUJ+ALA==
X-Received: by 2002:a05:6a00:17a8:b0:71d:fc8c:348a with SMTP id d2e1a72fcca58-71e26eecc42mr9331967b3a.9.1728606744583;
        Thu, 10 Oct 2024 17:32:24 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4496b1afsm1545600a12.94.2024.10.10.17.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 17:32:24 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 10 Oct 2024 17:32:05 -0700
Subject: [PATCH RFC/RFT 3/3] kernel: converge common shadow stack flow
 agnostic to arch
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-shstk_converge-v1-3-631beca676e7@rivosinc.com>
References: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
In-Reply-To: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
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
 arch/x86/include/asm/shstk.h           |   9 +
 arch/x86/include/uapi/asm/mman.h       |   3 -
 arch/x86/kernel/shstk.c                | 270 ++++++------------------------
 include/linux/usershstk.h              |  25 +++
 include/uapi/asm-generic/mman-common.h |   3 +
 kernel/Makefile                        |   2 +
 kernel/usershstk.c                     | 289 +++++++++++++++++++++++++++++++++
 7 files changed, 375 insertions(+), 226 deletions(-)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 4cb77e004615..4bb20af6cf7b 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -37,6 +37,15 @@ static inline int shstk_update_last_frame(unsigned long val) { return 0; }
 static inline bool shstk_is_enabled(void) { return false; }
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
+int arch_create_rstor_token(unsigned long ssp, unsigned long *token_addr);
+bool arch_cpu_supports_shadow_stack(void);
+bool arch_is_shstk_enabled(struct task_struct *task);
+void arch_set_shstk_base_size(struct task_struct *task, unsigned long base,
+			unsigned long size);
+void arch_get_shstk_base_size(struct task_struct *task, unsigned long *base,
+			unsigned long *size);
+void arch_set_shstk_ptr_and_enable(unsigned long ssp);
+void arch_set_thread_shstk_status(bool enable);
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
index 059685612362..512339b271e1 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -25,6 +25,7 @@
 #include <asm/special_insns.h>
 #include <asm/fpu/api.h>
 #include <asm/prctl.h>
+#include <linux/usershstk.h>
 
 #define SS_FRAME_SIZE 8
 
@@ -43,11 +44,56 @@ static void features_clr(unsigned long features)
 	current->thread.features &= ~features;
 }
 
+bool arch_cpu_supports_shadow_stack(void)
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
+
+void arch_set_shstk_ptr_and_enable(unsigned long ssp)
+{
+	fpregs_lock_and_load();
+	wrmsrl(MSR_IA32_PL3_SSP, ssp);
+	wrmsrl(MSR_IA32_U_CET, CET_SHSTK_EN);
+	fpregs_unlock();
+}
+
+void arch_set_thread_shstk_status(bool enable)
+{
+	if (enable)
+		features_set(ARCH_SHSTK_SHSTK);
+	else
+		features_clr(ARCH_SHSTK_SHSTK);
+}
+
 /*
  * Create a restore token on the shadow stack.  A token is always 8-byte
  * and aligned to 8.
  */
-static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
+int arch_create_rstor_token(unsigned long ssp, unsigned long *token_addr)
 {
 	unsigned long addr;
 
@@ -72,118 +118,6 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
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
-static int shstk_setup(void)
-{
-	struct thread_shstk *shstk = &current->thread.shstk;
-	unsigned long addr, size;
-
-	/* Already enabled */
-	if (features_enabled(ARCH_SHSTK_SHSTK))
-		return 0;
-
-	/* Also not supported for 32 bit */
-	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) || in_ia32_syscall())
-		return -EOPNOTSUPP;
-
-	size = adjust_shstk_size(0);
-	addr = alloc_shstk(0, size, 0, false);
-	if (IS_ERR_VALUE(addr))
-		return PTR_ERR((void *)addr);
-
-	fpregs_lock_and_load();
-	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
-	wrmsrl(MSR_IA32_U_CET, CET_SHSTK_EN);
-	fpregs_unlock();
-
-	shstk->base = addr;
-	shstk->size = size;
-	features_set(ARCH_SHSTK_SHSTK);
-
-	return 0;
-}
-
 void reset_thread_features(void)
 {
 	memset(&current->thread.shstk, 0, sizeof(struct thread_shstk));
@@ -191,48 +125,6 @@ void reset_thread_features(void)
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
@@ -402,44 +294,6 @@ int restore_signal_shadow_stack(void)
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
@@ -502,36 +356,6 @@ static int shstk_disable(void)
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
index 000000000000..68d751948e35
--- /dev/null
+++ b/include/linux/usershstk.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SHSTK_H
+#define _SHSTK_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+unsigned long alloc_shstk(unsigned long addr, unsigned long size,
+				 unsigned long token_offset, bool set_res_tok);
+int shstk_setup(void);
+int create_rstor_token(unsigned long ssp, unsigned long *token_addr);
+bool cpu_supports_shadow_stack(void);
+bool is_shstk_enabled(struct task_struct *task);
+void set_shstk_base_size(struct task_struct *task, unsigned long base,
+			unsigned long size);
+void get_shstk_base_size(struct task_struct *task, unsigned long *base,
+			unsigned long *size);
+void set_shstk_ptr_and_enable(unsigned long ssp);
+void set_thread_shstk_status(bool enable);
+unsigned long adjust_shstk_size(unsigned long size);
+void unmap_shadow_stack(u64 base, u64 size);
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _SHSTK_H */
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..2c36e4c7b6ec 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -87,4 +87,7 @@
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
 				 PKEY_DISABLE_WRITE)
 
+/* Flags for map_shadow_stack(2) */
+#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
+
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
index 000000000000..055d70b99893
--- /dev/null
+++ b/kernel/usershstk.c
@@ -0,0 +1,289 @@
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
+bool cpu_supports_shadow_stack(void)
+{
+	return arch_cpu_supports_shadow_stack();
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
+void set_shstk_ptr_and_enable(unsigned long ssp)
+{
+	arch_set_shstk_ptr_and_enable(ssp);
+}
+
+void set_thread_shstk_status(bool enable)
+{
+	arch_set_thread_shstk_status(enable);
+}
+
+int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
+{
+	return arch_create_rstor_token(ssp, token_addr);
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
+ * VM_SHADOW_STACK will have a guard page. This helps userspace protect
+ * itself from attacks. The reasoning is as follows:
+ *
+ * The shadow stack pointer(SSP) is moved by CALL, RET, and INCSSPQ. The
+ * INCSSP instruction can increment the shadow stack pointer. It is the
+ * shadow stack analog of an instruction like:
+ *
+ *   addq $0x80, %rsp
+ *
+ * However, there is one important difference between an ADD on %rsp
+ * and INCSSP. In addition to modifying SSP, INCSSP also reads from the
+ * memory of the first and last elements that were "popped". It can be
+ * thought of as acting like this:
+ *
+ * READ_ONCE(ssp);       // read+discard top element on stack
+ * ssp += nr_to_pop * 8; // move the shadow stack
+ * READ_ONCE(ssp-8);     // read+discard last popped stack element
+ *
+ * The maximum distance INCSSP can move the SSP is 2040 bytes, before
+ * it would read the memory. Therefore a single page gap will be enough
+ * to prevent any operation from shifting the SSP to an adjacent stack,
+ * since it would have to land in the gap at least once, causing a
+ * fault.
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
+	if (create_rstor_token(mapped_addr + token_offset, NULL)) {
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
+	if (!cpu_supports_shadow_stack() ||
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
+	if (!cpu_supports_shadow_stack())
+		return -EOPNOTSUPP;
+
+	if (flags & ~SHADOW_STACK_SET_TOKEN)
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
+int shstk_setup(void)
+{
+	struct thread_shstk *shstk = &current->thread.shstk;
+	unsigned long addr, size;
+
+	/* Already enabled */
+	if (is_shstk_enabled(current))
+		return 0;
+
+	/* Also not supported for 32 bit */
+	if (!cpu_supports_shadow_stack() ||
+		(IS_ENABLED(CONFIG_X86_64) && in_ia32_syscall()))
+		return -EOPNOTSUPP;
+
+	size = adjust_shstk_size(0);
+	addr = alloc_shstk(0, size, 0, false);
+	if (IS_ERR_VALUE(addr))
+		return PTR_ERR((void *)addr);
+
+	set_shstk_ptr_and_enable(addr + size);
+	set_shstk_base_size(current, addr, size);
+
+	set_thread_shstk_status(true);
+
+	return 0;
+}
+
+unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
+				       unsigned long stack_size)
+{
+	struct thread_shstk *shstk = &tsk->thread.shstk;
+	unsigned long addr, size;
+
+	if (!cpu_supports_shadow_stack())
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
2.45.0


