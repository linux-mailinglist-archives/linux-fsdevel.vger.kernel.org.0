Return-Path: <linux-fsdevel+bounces-50179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EB6AC8AF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968401884D48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73572236E9;
	Fri, 30 May 2025 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HYsOtTwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED82222A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597524; cv=none; b=kmCA7YRsDOS8BrgQVCXbNLDkfA4iYfJ1cRDbrESTxhgPquhwz28qgxfMDtsexwh20Aa1j5Ry/neC/AA6+6ysoQyFUv4sbXpQkHIM6a/wTEjEjYJ/fLncjYiWhz5p5uOccBK59vvl1zIUXlL++0Qibg4JB1gylvpAD8ekA98Jh0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597524; c=relaxed/simple;
	bh=v0y8BsMdpB12xLvFn5vAwwkHzR1Wq6pNBECHF1ePs8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=du2HrmQiXo78CciFPwMZ8IGpbhGcvdtMpMfYkLjIxq0sM1Ctdw8m1jcAVjpOqqYlPGTBeyQD/b/dexYq1TSzWIBxymyEW7T07MZ3wVXZQOr2kVcQY9xKPueFlQ/I7I212BEocFHa9QBDkGgHkTl/K8jPAZ5JKM4/iq+fEoXvtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HYsOtTwq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3114c943367so2031211a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597522; x=1749202322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO6otkog24Nl4MqGG9SKHBZpR3sFE7cRfJye6EEtKwU=;
        b=HYsOtTwqn7S/y04wP3C85vE2nFJV+K9wtaqiRJohu+f+XYSjGnOuUrbY8pmTlg/+p3
         yBxR1fgOc7FXWQpwH+g+Kozu3uCpxusa5vgbfp6fpGeQR0J6TmAaAgkRdmIkSVr0sRyQ
         p1fJ5rGcazqjI/Bz2d6Mu20bsCyE810r9VouqmECRrFC4z+MqeuO5SYb3IVFtVVhZHfb
         Dib8PeqnNuJ5IY5b0MRXNz7iIGUxeRBO5vIetq1Ka7SpM905TsScuVZaOUWHOPmiarfj
         JgO/C7mkZIaj1Tdo5Q+2vmca/JQYdh+6Gd+PLWIlIrFCRE3Ro2pBWSMM0E2B+O/PHF0w
         zWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597522; x=1749202322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dO6otkog24Nl4MqGG9SKHBZpR3sFE7cRfJye6EEtKwU=;
        b=QZ+pe72rNvEwVumn8EADreYyhi9xAGkNtGa2eQrCxa4qEdDupNaKx4CN18B/k+gFsx
         GHPzfw0wH4nrnF06cthNzkL4EvrJKzvrsiWI2PiWUdUZ3lb9uThL+qdQn+9O0+d63e+0
         gKpELqllY8bA2RW8LnZwXDySngTWfbXUk10nRDbaksDFptSaCjmgR5c3YmL4BI36wZqR
         JOy78ir+P1g5NYw+YwrpMQtWgLIW97sdZ7iaBVLlckwstzQtB3OyCvb2NfV252iQdasl
         Yj07H8K1Np4Hd4EBkm6aBGqjWnDgLfrH9LTgEQLDXrHwXtKQGR+phittuUBbcTyUVGTk
         ebTA==
X-Forwarded-Encrypted: i=1; AJvYcCWrplNnyJ+VYLFrWpF3CmJ1l5F8RWrifw+TDAMjUqhm0RFAguzSwQUCF3TQM0/akyYXn7h/Whx5otK4x3Jp@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBB5Xy5rE/zZY1vAl1Sc9xLmUn4NrKHnqxPwxV23soYg0+dbv
	D2tvrvR/54ff10wJH+KWwoD66Ybx9YXqOIl+WcQ7wijlcN1Fqi+UJ+ADk1alqycaZHQ=
X-Gm-Gg: ASbGncujBn3uEGpFnCI4kFp9jUjOfMevOk2Gkxc58/h68KlsgKP5CqI4UKKPFiilzL+
	MJHkG1ROLowGQlJYNJ+lSWw1Kw4o1gq4pee28BxXZ3YaB/ZCqA/MLB76AcED0Oi/tGI4ZFmL/4S
	dURXkowQ0V16Oq5ZZRuYKVZmicFADddXZjL65IuvruOpdjC3OJ5DNvc47jwu9S6Kj9SP0zoTV7c
	XEfc825Hec9ndBtr1HG6iJmSXCFwq8m3ZZZinl0ZYYr3U3kIxYb4bLVkLHx2TRVRXQlDuHWmcqQ
	fRkDyZD7lgvFvdDsTY2N7E92YyT6jDPIDUC5Juc6TA8UdEQdYvqUZnZiG3XuO6C062s6/2Mm0Uc
	HhbiA8ARhGBmbb9yJQlSK
X-Google-Smtp-Source: AGHT+IHUkj4Y6AZ8cB5OAPZaSl8VUuiU504h/MLG14sBKE++U+CpU83URutH7UTuLZZMbY0g/ZO+FA==
X-Received: by 2002:a17:90b:1d50:b0:311:fde5:c4b6 with SMTP id 98e67ed59e1d1-31250344995mr2213817a91.6.1748597521434;
        Fri, 30 May 2025 02:32:01 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.31.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:32:01 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 14/35] RPAL: enable page fault handling
Date: Fri, 30 May 2025 17:27:42 +0800
Message-Id: <a7c183833cca723238d4173a6df771dd7e340762.1748594840.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RPAL's address space sharing allows one process to access the memory of
another process, which may trigger page faults. To ensure programs can run
normally, RPAL needs to handle page faults occurring in the address space
of other processes. Additionally, to prevent processes from generating
coredumps due to invalid memory in other processes, RPAL must also restore
the current thread state to a pre-saved state under specific circumstances.

For handling page faults, by passing the correct vm_area_struct to
handle_page_fault(), RPAL locates the process corresponding to the address
where the page fault occurred and uses its mm_struct to handle the page
fault. Regarding thread state restoration, RPAL restores the thread's
state to a predefined state in userspace when it cannot locate the
mm_struct of the corresponding process (i.e., when the process has already
exited).

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/mm/fault.c     | 271 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/rpal/mm.c      |  34 +++++
 arch/x86/rpal/service.c |  24 ++++
 arch/x86/rpal/thread.c  |  23 ++++
 include/linux/rpal.h    |  81 ++++++++----
 5 files changed, 412 insertions(+), 21 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 998bd807fc7b..35f7c60a5e4f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -19,6 +19,7 @@
 #include <linux/mm_types.h>
 #include <linux/mm.h>			/* find_and_lock_vma() */
 #include <linux/vmalloc.h>
+#include <linux/rpal.h>
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1460,6 +1461,268 @@ trace_page_fault_entries(struct pt_regs *regs, unsigned long error_code,
 		trace_page_fault_kernel(address, regs, error_code);
 }
 
+#if IS_ENABLED(CONFIG_RPAL)
+static void rpal_do_user_addr_fault(struct pt_regs *regs, unsigned long error_code,
+			     unsigned long address, struct mm_struct *real_mm)
+{
+	struct vm_area_struct *vma;
+	vm_fault_t fault;
+	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+
+	if (unlikely(error_code & X86_PF_RSVD))
+		pgtable_bad(regs, error_code, address);
+
+	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
+		     !(error_code & X86_PF_USER) &&
+		     !(regs->flags & X86_EFLAGS_AC))) {
+		page_fault_oops(regs, error_code, address);
+		return;
+	}
+
+	if (unlikely(faulthandler_disabled())) {
+		bad_area_nosemaphore(regs, error_code, address);
+		return;
+	}
+
+	if (WARN_ON_ONCE(!(regs->flags & X86_EFLAGS_IF))) {
+		bad_area_nosemaphore(regs, error_code, address);
+		return;
+	}
+
+	local_irq_enable();
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
+	if (error_code & X86_PF_SHSTK)
+		flags |= FAULT_FLAG_WRITE;
+	if (error_code & X86_PF_WRITE)
+		flags |= FAULT_FLAG_WRITE;
+	if (error_code & X86_PF_INSTR)
+		flags |= FAULT_FLAG_INSTRUCTION;
+
+	if (user_mode(regs))
+		flags |= FAULT_FLAG_USER;
+
+#ifdef CONFIG_X86_64
+	if (is_vsyscall_vaddr(address)) {
+		if (emulate_vsyscall(error_code, regs, address))
+			return;
+	}
+#endif
+
+	if (!(flags & FAULT_FLAG_USER))
+		goto lock_mmap;
+
+	vma = lock_vma_under_rcu(real_mm, address);
+	if (!vma)
+		goto lock_mmap;
+
+	if (unlikely(access_error(error_code, vma))) {
+		bad_area_access_error(regs, error_code, address, NULL, vma);
+		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		return;
+	}
+
+	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
+
+	if (!(fault & VM_FAULT_RETRY)) {
+		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		goto done;
+	}
+	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+	if (fault & VM_FAULT_MAJOR)
+		flags |= FAULT_FLAG_TRIED;
+
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			kernelmode_fixup_or_oops(regs, error_code, address,
+						 SIGBUS, BUS_ADRERR,
+						 ARCH_DEFAULT_PKEY);
+		return;
+	}
+lock_mmap:
+
+retry:
+	/*
+	 * Here we don't need to lock current->mm since no vma in
+	 * current->mm is used to handle this page fault. However,
+	 * we do need to lock real_mm, as the address belongs to
+	 * real_mm's vma.
+	 */
+	vma = lock_mm_and_find_vma(real_mm, address, regs);
+	if (unlikely(!vma)) {
+		bad_area_nosemaphore(regs, error_code, address);
+		return;
+	}
+
+	if (unlikely(access_error(error_code, vma))) {
+		bad_area_access_error(regs, error_code, address, real_mm, vma);
+		return;
+	}
+
+	fault = handle_mm_fault(vma, address, flags, regs);
+
+	if (fault_signal_pending(fault, regs)) {
+		/*
+		 * Quick path to respond to signals.  The core mm code
+		 * has unlocked the mm for us if we get here.
+		 */
+		if (!user_mode(regs))
+			kernelmode_fixup_or_oops(regs, error_code, address,
+						 SIGBUS, BUS_ADRERR,
+						 ARCH_DEFAULT_PKEY);
+		return;
+	}
+
+	/* The fault is fully completed (including releasing mmap lock) */
+	if (fault & VM_FAULT_COMPLETED)
+		return;
+
+	if (unlikely(fault & VM_FAULT_RETRY)) {
+		flags |= FAULT_FLAG_TRIED;
+		goto retry;
+	}
+
+	mmap_read_unlock(real_mm);
+done:
+	if (likely(!(fault & VM_FAULT_ERROR)))
+		return;
+
+	if (fatal_signal_pending(current) && !user_mode(regs)) {
+		kernelmode_fixup_or_oops(regs, error_code, address, 0, 0,
+					 ARCH_DEFAULT_PKEY);
+		return;
+	}
+
+	if (fault & VM_FAULT_OOM) {
+		/* Kernel mode? Handle exceptions or die: */
+		if (!user_mode(regs)) {
+			kernelmode_fixup_or_oops(regs, error_code, address,
+						 SIGSEGV, SEGV_MAPERR,
+						 ARCH_DEFAULT_PKEY);
+			return;
+		}
+
+		pagefault_out_of_memory();
+	} else {
+		if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
+			     VM_FAULT_HWPOISON_LARGE))
+			do_sigbus(regs, error_code, address, fault);
+		else if (fault & VM_FAULT_SIGSEGV)
+			bad_area_nosemaphore(regs, error_code, address);
+		else
+			BUG();
+	}
+}
+NOKPROBE_SYMBOL(rpal_do_user_addr_fault);
+
+static inline void rpal_try_to_rebuild_context(struct pt_regs *regs,
+					       unsigned long address,
+					       int error_code)
+{
+	int handle_more = 0;
+
+	/*
+	 * We only rebuild sender's context, as other threads are not supposed
+	 * to access other process's memory, thus they will not trigger a page
+	 * fault.
+	 */
+	handle_more = rpal_rebuild_sender_context_on_fault(regs, address, -1);
+	/*
+	 * If we are not able to rebuild sender's context, just
+	 * send a signal to let it coredump.
+	 */
+	if (handle_more)
+		force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)address);
+}
+
+/*
+ * Most logic of this function is copied from do_user_addr_fault().
+ * RPAL logic is added to handle special cases, such as find another
+ * process's mm and rebuild sender's context if such page table is
+ * not able to be handled.
+ */
+static bool rpal_try_user_addr_fault(struct pt_regs *regs, unsigned long error_code,
+			      unsigned long address)
+{
+	struct mm_struct *real_mm;
+	int rebuild = 0;
+
+	/* fast path: avoid mmget and mmput */
+	if (unlikely((error_code & (X86_PF_USER | X86_PF_INSTR)) ==
+		     X86_PF_INSTR)) {
+		/*
+		 * Whoops, this is kernel mode code trying to execute from
+		 * user memory.  Unless this is AMD erratum #93, which
+		 * corrupts RIP such that it looks like a user address,
+		 * this is unrecoverable.  Don't even try to look up the
+		 * VMA or look for extable entries.
+		 */
+		if (is_errata93(regs, address))
+			return true;
+
+		page_fault_oops(regs, error_code, address);
+		return true;
+	}
+
+	/* kprobes don't want to hook the spurious faults: */
+	if (WARN_ON_ONCE(kprobe_page_fault(regs, X86_TRAP_PF)))
+		return true;
+
+	real_mm = rpal_pf_get_real_mm(address, &rebuild);
+
+	if (real_mm) {
+#ifdef CONFIG_MEMCG
+		struct mem_cgroup *memcg = NULL;
+
+		prefetchw(&real_mm->mmap_lock);
+		/* try to charge page alloc to real_mm's memcg */
+		if (!current->active_memcg) {
+			memcg = get_mem_cgroup_from_mm(real_mm);
+			if (memcg)
+				set_active_memcg(memcg);
+		}
+		rpal_do_user_addr_fault(regs, error_code, address, real_mm);
+		if (memcg) {
+			set_active_memcg(NULL);
+			mem_cgroup_put(memcg);
+		}
+#else
+		prefetchw(&real_mm->mmap_lock);
+		rpal_do_user_addr_fault(regs, error_code, address, real_mm);
+#endif
+		mmput_async(real_mm);
+		return true;
+	} else if (user_mode(regs) && rebuild) {
+		rpal_try_to_rebuild_context(regs, address, -1);
+		return true;
+	}
+
+	return false;
+}
+
+static bool rpal_handle_page_fault(struct pt_regs *regs, unsigned long error_code,
+			   unsigned long address)
+{
+	struct rpal_service *cur = rpal_current_service();
+
+	/*
+	 * For RPAL process, it may access another process's memory and
+	 * there may be page fault. We handle this case with our own routine.
+	 * If we cannot handle this page fault, just let it go and handle
+	 * it as a normal page fault.
+	 */
+	if (cur && !rpal_is_correct_address(cur, address)) {
+		if (rpal_try_user_addr_fault(regs, error_code, address))
+			return true;
+	}
+	return false;
+}
+#endif
+
 static __always_inline void
 handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 			      unsigned long address)
@@ -1473,7 +1736,15 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 	if (unlikely(fault_in_kernel_space(address))) {
 		do_kern_addr_fault(regs, error_code, address);
 	} else {
+#ifdef CONFIG_RPAL
+		if (rpal_handle_page_fault(regs, error_code, address)) {
+			local_irq_disable();
+			return;
+		}
+		do_user_addr_fault(regs, error_code, address);
+#else /* !CONFIG_RPAL */
 		do_user_addr_fault(regs, error_code, address);
+#endif
 		/*
 		 * User address page fault handling might have reenabled
 		 * interrupts. Fixing up all potential exit points of
diff --git a/arch/x86/rpal/mm.c b/arch/x86/rpal/mm.c
index f1003baae001..be7714ede2bf 100644
--- a/arch/x86/rpal/mm.c
+++ b/arch/x86/rpal/mm.c
@@ -390,3 +390,37 @@ void rpal_unmap_service(struct rpal_service *tgt)
 	}
 	mm_unlink_p4d(cur_mm, tgt->base);
 }
+
+static inline bool check_service_mapped(struct rpal_service *cur, int tgt_id)
+{
+	struct rpal_mapped_service *node;
+	bool is_mapped = true;
+	unsigned long type = (1 << RPAL_REVERSE_MAP) | (1 << RPAL_REQUEST_MAP);
+
+	node = rpal_get_mapped_node(cur, tgt_id);
+	if (unlikely((node->type & type) != type))
+		is_mapped = false;
+
+	return is_mapped;
+}
+
+struct mm_struct *rpal_pf_get_real_mm(unsigned long address, int *rebuild)
+{
+	struct rpal_service *cur, *tgt;
+	struct mm_struct *mm = NULL;
+
+	cur = rpal_current_service();
+
+	tgt = rpal_get_mapped_service_by_addr(cur, address);
+	if (tgt == NULL)
+		goto out;
+
+	mm = tgt->mm;
+	if (unlikely(!check_service_mapped(cur, tgt->id) ||
+		     !mmget_not_zero(mm)))
+		mm = NULL;
+	*rebuild = 1;
+	rpal_put_service(tgt);
+out:
+	return mm;
+}
diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
index f490ab07301d..49458321e7dc 100644
--- a/arch/x86/rpal/service.c
+++ b/arch/x86/rpal/service.c
@@ -148,6 +148,30 @@ static inline unsigned long calculate_base_address(int id)
 	return RPAL_ADDRESS_SPACE_LOW + RPAL_ADDR_SPACE_SIZE * id;
 }
 
+struct rpal_service *rpal_get_mapped_service_by_id(struct rpal_service *rs,
+						   int id)
+{
+	struct rpal_service *ret;
+
+	if (!is_valid_id(id))
+		return NULL;
+
+	ret = rpal_get_service(rs->service_map[id].rs);
+
+	return ret;
+}
+
+/* This function must be called after rpal_is_correct_address () */
+struct rpal_service *rpal_get_mapped_service_by_addr(struct rpal_service *rs,
+						     unsigned long addr)
+{
+	int id;
+
+	id = (addr - RPAL_ADDRESS_SPACE_LOW) / RPAL_ADDR_SPACE_SIZE;
+
+	return rpal_get_mapped_service_by_id(rs, id);
+}
+
 struct rpal_service *rpal_register_service(void)
 {
 	struct rpal_service *rs;
diff --git a/arch/x86/rpal/thread.c b/arch/x86/rpal/thread.c
index 7550ad94b63f..e50a4c865ff8 100644
--- a/arch/x86/rpal/thread.c
+++ b/arch/x86/rpal/thread.c
@@ -155,6 +155,29 @@ int rpal_unregister_receiver(void)
 	return ret;
 }
 
+int rpal_rebuild_sender_context_on_fault(struct pt_regs *regs,
+					 unsigned long addr, int error_code)
+{
+	if (rpal_test_current_thread_flag(RPAL_SENDER_BIT)) {
+		struct rpal_sender_call_context *scc = current->rpal_sd->scc;
+		unsigned long erip, ersp;
+		int magic;
+
+		erip = scc->ec.erip;
+		ersp = scc->ec.ersp;
+		magic = scc->ec.magic;
+		if (magic == RPAL_ERROR_MAGIC) {
+			regs->ax = error_code;
+			regs->ip = erip;
+			regs->sp = ersp;
+			/* avoid rebuild again */
+			scc->ec.magic = 0;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
 void exit_rpal_thread(void)
 {
 	if (rpal_test_current_thread_flag(RPAL_SENDER_BIT))
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 36be1ab6a9f3..3310d222739e 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -85,6 +85,8 @@ enum {
 	RPAL_REVERSE_MAP,
 };
 
+#define RPAL_ERROR_MAGIC 0x98CC98CC
+
 extern unsigned long rpal_cap;
 
 enum rpal_task_flag_bits {
@@ -198,23 +200,6 @@ struct rpal_version_info {
 	unsigned long cap;
 };
 
-/* End */
-
-struct rpal_shared_page {
-	unsigned long user_start;
-	unsigned long kernel_start;
-	int npage;
-	atomic_t refcnt;
-	struct list_head list;
-};
-
-struct rpal_common_data {
-	/* back pointer to task_struct */
-	struct task_struct *bp_task;
-	/* service id of rpal_service */
-	int service_id;
-};
-
 /* User registers state */
 struct rpal_task_context {
 	u64 r15;
@@ -232,17 +217,44 @@ struct rpal_receiver_call_context {
 	int receiver_id;
 };
 
-struct rpal_receiver_data {
-	struct rpal_common_data rcd;
-	struct rpal_shared_page *rsp;
-	struct rpal_receiver_call_context *rcc;
+/* recovery point for sender */
+struct rpal_error_context {
+	unsigned long fsbase;
+	u64 erip;
+	u64 ersp;
+	int state;
+	int magic;
 };
 
 struct rpal_sender_call_context {
 	struct rpal_task_context rtc;
+	struct rpal_error_context ec;
 	int sender_id;
 };
 
+/* End */
+
+struct rpal_shared_page {
+	unsigned long user_start;
+	unsigned long kernel_start;
+	int npage;
+	atomic_t refcnt;
+	struct list_head list;
+};
+
+struct rpal_common_data {
+	/* back pointer to task_struct */
+	struct task_struct *bp_task;
+	/* service id of rpal_service */
+	int service_id;
+};
+
+struct rpal_receiver_data {
+	struct rpal_common_data rcd;
+	struct rpal_shared_page *rsp;
+	struct rpal_receiver_call_context *rcc;
+};
+
 struct rpal_sender_data {
 	struct rpal_common_data rcd;
 	struct rpal_shared_page *rsp;
@@ -338,6 +350,26 @@ static inline bool rpal_service_mapped(struct rpal_mapped_service *node)
 	return (node->type & type) == type;
 }
 
+static inline bool rpal_is_correct_address(struct rpal_service *rs, unsigned long address)
+{
+	if (likely(rs->base <= address &&
+		   address < rs->base + RPAL_ADDR_SPACE_SIZE))
+		return true;
+
+	/*
+	 * [rs->base, rs->base + RPAL_ADDR_SPACE_SIZE) is always a
+	 * sub range of [RPAL_ADDRESS_SPACE_LOW, RPAL_ADDRESS_SPACE_HIGH).
+	 * Therefore, we can only check whether the address is in
+	 * [RPAL_ADDRESS_SPACE_LOW, RPAL_ADDRESS_SPACE_HIGH) to determine
+	 * whether the address may belong to another RPAL service.
+	 */
+	if (address >= RPAL_ADDRESS_SPACE_LOW &&
+	    address < RPAL_ADDRESS_SPACE_HIGH)
+		return false;
+
+	return true;
+}
+
 #ifdef CONFIG_RPAL
 static inline struct rpal_service *rpal_current_service(void)
 {
@@ -372,6 +404,13 @@ void copy_rpal(struct task_struct *p);
 void exit_rpal(bool group_dead);
 int rpal_balloon_init(unsigned long base);
 void rpal_exit_mmap(struct mm_struct *mm);
+struct rpal_service *rpal_get_mapped_service_by_addr(struct rpal_service *rs,
+						     unsigned long addr);
+struct rpal_service *rpal_get_mapped_service_by_id(struct rpal_service *rs,
+						   int id);
+int rpal_rebuild_sender_context_on_fault(struct pt_regs *regs,
+					 unsigned long addr, int error_code);
+struct mm_struct *rpal_pf_get_real_mm(unsigned long address, int *rebuild);
 
 extern void rpal_pick_mmap_base(struct mm_struct *mm,
 	struct rlimit *rlim_stack);
-- 
2.20.1


