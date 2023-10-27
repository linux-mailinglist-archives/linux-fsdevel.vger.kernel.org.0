Return-Path: <linux-fsdevel+bounces-1400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6257D9F84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691042826BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725F23C68B;
	Fri, 27 Oct 2023 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE93C075
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:09:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFE30AC;
	Fri, 27 Oct 2023 11:09:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 173A4143D;
	Fri, 27 Oct 2023 11:10:15 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48ED73F64C;
	Fri, 27 Oct 2023 11:09:31 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	will@kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 12/24] arm64: handle PKEY/POE faults
Date: Fri, 27 Oct 2023 19:08:38 +0100
Message-Id: <20231027180850.1068089-13-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027180850.1068089-1-joey.gouly@arm.com>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a memory fault occurs that is due to an overlay/pkey fault, report that to
userspace with a SEGV_PKUERR.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/traps.h |  1 +
 arch/arm64/kernel/traps.c      | 12 ++++++++--
 arch/arm64/mm/fault.c          | 44 +++++++++++++++++++++++++++++++---
 3 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index d66dfb3a72dd..dae51eccfc19 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -26,6 +26,7 @@ try_emulate_armv8_deprecated(struct pt_regs *regs, u32 insn)
 void force_signal_inject(int signal, int code, unsigned long address, unsigned long err);
 void arm64_notify_segfault(unsigned long addr);
 void arm64_force_sig_fault(int signo, int code, unsigned long far, const char *str);
+void arm64_force_sig_fault_pkey(int signo, int code, unsigned long far, const char *str, int pkey);
 void arm64_force_sig_mceerr(int code, unsigned long far, short lsb, const char *str);
 void arm64_force_sig_ptrace_errno_trap(int errno, unsigned long far, const char *str);
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 8b70759cdbb9..b68682c284a2 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -263,16 +263,24 @@ static void arm64_show_signal(int signo, const char *str)
 	__show_regs(regs);
 }
 
-void arm64_force_sig_fault(int signo, int code, unsigned long far,
-			   const char *str)
+void arm64_force_sig_fault_pkey(int signo, int code, unsigned long far,
+			   const char *str, int pkey)
 {
 	arm64_show_signal(signo, str);
 	if (signo == SIGKILL)
 		force_sig(SIGKILL);
+	else if (code == SEGV_PKUERR)
+		force_sig_pkuerr((void __user *)far, pkey);
 	else
 		force_sig_fault(signo, code, (void __user *)far);
 }
 
+void arm64_force_sig_fault(int signo, int code, unsigned long far,
+			   const char *str)
+{
+	arm64_force_sig_fault_pkey(signo, code, far, str, 0);
+}
+
 void arm64_force_sig_mceerr(int code, unsigned long far, short lsb,
 			    const char *str)
 {
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2e5d1e238af9..655dd80f0ec0 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -23,6 +23,7 @@
 #include <linux/sched/debug.h>
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
+#include <linux/pkeys.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
 
@@ -497,6 +498,23 @@ static void do_bad_area(unsigned long far, unsigned long esr,
 #define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
 #define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
 
+static bool fault_from_pkey(unsigned long esr, struct vm_area_struct *vma,
+			unsigned int mm_flags)
+{
+	unsigned long iss2 = ESR_ELx_ISS2(esr);
+
+	if (!arch_pkeys_enabled())
+		return false;
+
+	if (iss2 & ESR_ELx_Overlay)
+		return true;
+
+	return !arch_vma_access_permitted(vma,
+			mm_flags & FAULT_FLAG_WRITE,
+			mm_flags & FAULT_FLAG_INSTRUCTION,
+			mm_flags & FAULT_FLAG_REMOTE);
+}
+
 static vm_fault_t __do_page_fault(struct mm_struct *mm,
 				  struct vm_area_struct *vma, unsigned long addr,
 				  unsigned int mm_flags, unsigned long vm_flags,
@@ -688,9 +706,29 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		 * Something tried to access memory that isn't in our memory
 		 * map.
 		 */
-		arm64_force_sig_fault(SIGSEGV,
-				      fault == VM_FAULT_BADACCESS ? SEGV_ACCERR : SEGV_MAPERR,
-				      far, inf->name);
+		int fault_kind;
+		/*
+		 * The pkey value that we return to userspace can be different
+		 * from the pkey that caused the fault.
+		 *
+		 * 1. T1   : mprotect_key(foo, PAGE_SIZE, pkey=4);
+		 * 2. T1   : set AMR to deny access to pkey=4, touches, page
+		 * 3. T1   : faults...
+		 * 4.    T2: mprotect_key(foo, PAGE_SIZE, pkey=5);
+		 * 5. T1   : enters fault handler, takes mmap_lock, etc...
+		 * 6. T1   : reaches here, sees vma_pkey(vma)=5, when we really
+		 *	     faulted on a pte with its pkey=4.
+		 */
+		int pkey = vma_pkey(vma);
+
+		if (fault_from_pkey(esr, vma, mm_flags))
+			fault_kind = SEGV_PKUERR;
+		else
+			fault_kind = fault == VM_FAULT_BADACCESS ? SEGV_ACCERR : SEGV_MAPERR;
+
+		arm64_force_sig_fault_pkey(SIGSEGV,
+				      fault_kind,
+				      far, inf->name, pkey);
 	}
 
 	return 0;
-- 
2.25.1


