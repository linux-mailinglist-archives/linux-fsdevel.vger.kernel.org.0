Return-Path: <linux-fsdevel+bounces-59470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DC1B396D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 10:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164CA465032
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 08:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA9C2DE1FA;
	Thu, 28 Aug 2025 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FJrxmzhQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D471F7580;
	Thu, 28 Aug 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369541; cv=none; b=K8wQlDkQCg9bZGwPLXaBFQGNwB9rHqLbQopn0Ajxw0WgK0EYj2ylg/SRU8COre2I0ztEJLLypRTWBT8Vzq3+nTjLIJdB83b6zJf2/j/W1biFHJJjatE2b19f8M+YlK2rrqMyhah2lbHnRdFxA+yQ2zvjiRs1KT3OQ0fqhfIPztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369541; c=relaxed/simple;
	bh=ekUuC13a3iYi+p4plrnGu1grusArsr/19IrJLJSWtKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=l1teHOAXwdx/syFjH8yy2+RewacXtMH/iF4/Mwc0P5jN/dVKaNNafNOxY+Jeu0Lws8a2UbD8wntS56gIjb3T/3zw/wxYY/f02vC80VUltkRFD3k/YddcUGGwBFIua9GQgP+tWnGqd6eovtoz/hguLzegEc5R5VeIWkluL1fcDuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FJrxmzhQ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=a+CEnKd1erN9PyCMQFaZ8UZiWrsbFUKdsbVOOvJeFY4=;
	b=FJrxmzhQX1atQK1z5ligWEmgKaOiRA6In6aL3ytcjttFYrSO5o2NDSAHVcM+oQ
	Yz2Aix6WZWSK3tyD2mR3OsI7EteH7EvAwYv1JhXC1zy4ayIxoHOyhcVHRCIlzxcg
	BcjSlyxZ7ChufIB/w8i7L+ktZ50hfhSNg/B2pPsAjlKhs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBXFbk1ErBozAtLAw--.1992S2;
	Thu, 28 Aug 2025 16:24:23 +0800 (CST)
From: mysteryli <m13940358460@163.com>
To: m13940358460@163.com
Cc: Namhyung Kim <namhyung@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-api@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	Ian Rogers <irogers@google.com>
Subject: [PATCH 01/14] perf test: Fix a build error in x86 topdown test
Date: Thu, 28 Aug 2025 16:24:16 +0800
Message-Id: <20250828082416.1701419-1-m13940358460@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBXFbk1ErBozAtLAw--.1992S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4iU3vUDUUUU
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbBNRO3OmiwDcuIVgAAsr

From: Namhyung Kim <namhyung@kernel.org>

There's an environment that caused the following build error.  Include
"debug.h" (under util directory) to fix it.

  arch/x86/tests/topdown.c: In function 'event_cb':
  arch/x86/tests/topdown.c:53:25: error: implicit declaration of function 'pr_debug'
                                         [-Werror=implicit-function-declaration]
     53 |                         pr_debug("Broken topdown information for '%s'\n", evsel__name(evsel));
        |                         ^~~~~~~~
  cc1: all warnings being treated as errors

Link: https://lore.kernel.org/r/20250815164122.289651-1-namhyung@kernel.org
Fixes: 5b546de9cc177936 ("perf topdown: Use attribute to see an event is a topdown metic or slots")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/tests/topdown.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
index 8d0ea7a4bbc1..1eba3b4594ef 100644
--- a/tools/perf/arch/x86/tests/topdown.c
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "arch-tests.h"
 #include "../util/topdown.h"
+#include "debug.h"
 #include "evlist.h"
 #include "parse-events.h"
 #include "pmu.h"
-- 
2.25.1


From bd842ff41543af424c2473dc16c678ac8ba2b43f Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Aug 2025 10:32:18 -0700
Subject: [PATCH 02/14] tools headers: Sync KVM headers with the kernel source

To pick up the changes in this cset:

  f55ce5a6cd33211c KVM: arm64: Expose new KVM cap for cacheable PFNMAP
  28224ef02b56fcee KVM: TDX: Report supported optional TDVMCALLs in TDX capabilities
  4580dbef5ce0f95a KVM: TDX: Exit to userspace for SetupEventNotifyInterrupt
  25e8b1dd4883e6c2 KVM: TDX: Exit to userspace for GetTdVmCallInfo
  cf207eac06f661fb KVM: TDX: Handle TDG.VP.VMCALL<GetQuote>

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
    diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h

Please see tools/include/uapi/README for further details.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/x86/include/uapi/asm/kvm.h |  8 +++++++-
 tools/include/uapi/linux/kvm.h        | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 6f3499507c5e..0f15d683817d 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -965,7 +965,13 @@ struct kvm_tdx_cmd {
 struct kvm_tdx_capabilities {
 	__u64 supported_attrs;
 	__u64 supported_xfam;
-	__u64 reserved[254];
+
+	__u64 kernel_tdvmcallinfo_1_r11;
+	__u64 user_tdvmcallinfo_1_r11;
+	__u64 kernel_tdvmcallinfo_1_r12;
+	__u64 user_tdvmcallinfo_1_r12;
+
+	__u64 reserved[250];
 
 	/* Configurable CPUID bits for userspace */
 	struct kvm_cpuid2 cpuid;
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 7415a3863891..f0f0d49d2544 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -178,6 +178,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_NOTIFY           37
 #define KVM_EXIT_LOONGARCH_IOCSR  38
 #define KVM_EXIT_MEMORY_FAULT     39
+#define KVM_EXIT_TDX              40
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -447,6 +448,31 @@ struct kvm_run {
 			__u64 gpa;
 			__u64 size;
 		} memory_fault;
+		/* KVM_EXIT_TDX */
+		struct {
+			__u64 flags;
+			__u64 nr;
+			union {
+				struct {
+					__u64 ret;
+					__u64 data[5];
+				} unknown;
+				struct {
+					__u64 ret;
+					__u64 gpa;
+					__u64 size;
+				} get_quote;
+				struct {
+					__u64 ret;
+					__u64 leaf;
+					__u64 r11, r12, r13, r14;
+				} get_tdvmcall_info;
+				struct {
+					__u64 ret;
+					__u64 vector;
+				} setup_event_notify;
+			};
+		} tdx;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -935,6 +961,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_EL2 240
 #define KVM_CAP_ARM_EL2_E2H0 241
 #define KVM_CAP_RISCV_MP_STATE_RESET 242
+#define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.25.1


From 6cb8607934d937f4ad24ec9ad26aeb669e266937 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Aug 2025 10:32:18 -0700
Subject: [PATCH 03/14] tools headers: Sync linux/bits.h with the kernel source

To pick up the changes in this cset:

  104ea1c84b91c9f4 bits: unify the non-asm GENMASK*()
  6d4471252ccc1722 bits: split the definition of the asm and non-asm GENMASK*()

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/linux/bits.h include/linux/bits.h

Please see tools/include/uapi/README for further details.

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/linux/bits.h | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index 7ad056219115..a40cc861b3a7 100644
--- a/tools/include/linux/bits.h
+++ b/tools/include/linux/bits.h
@@ -2,10 +2,8 @@
 #ifndef __LINUX_BITS_H
 #define __LINUX_BITS_H
 
-#include <linux/const.h>
 #include <vdso/bits.h>
 #include <uapi/linux/bits.h>
-#include <asm/bitsperlong.h>
 
 #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
@@ -50,10 +48,14 @@
 	     (type_max(t) << (l) &				\
 	      type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
 
+#define GENMASK(h, l)		GENMASK_TYPE(unsigned long, h, l)
+#define GENMASK_ULL(h, l)	GENMASK_TYPE(unsigned long long, h, l)
+
 #define GENMASK_U8(h, l)	GENMASK_TYPE(u8, h, l)
 #define GENMASK_U16(h, l)	GENMASK_TYPE(u16, h, l)
 #define GENMASK_U32(h, l)	GENMASK_TYPE(u32, h, l)
 #define GENMASK_U64(h, l)	GENMASK_TYPE(u64, h, l)
+#define GENMASK_U128(h, l)	GENMASK_TYPE(u128, h, l)
 
 /*
  * Fixed-type variants of BIT(), with additional checks like GENMASK_TYPE(). The
@@ -79,28 +81,9 @@
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
  * disable the input check if that is the case.
  */
-#define GENMASK_INPUT_CHECK(h, l) 0
+#define GENMASK(h, l)		__GENMASK(h, l)
+#define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)
 
 #endif /* !defined(__ASSEMBLY__) */
 
-#define GENMASK(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
-#define GENMASK_ULL(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
-
-#if !defined(__ASSEMBLY__)
-/*
- * Missing asm support
- *
- * __GENMASK_U128() depends on _BIT128() which would not work
- * in the asm code, as it shifts an 'unsigned __int128' data
- * type instead of direct representation of 128 bit constants
- * such as long and unsigned long. The fundamental problem is
- * that a 128 bit constant will get silently truncated by the
- * gcc compiler.
- */
-#define GENMASK_U128(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
-#endif
-
 #endif	/* __LINUX_BITS_H */
-- 
2.25.1


From aa34642f6fc36a436de5ae5b30d414578b3622f5 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Aug 2025 10:32:18 -0700
Subject: [PATCH 04/14] tools headers: Sync linux/cfi_types.h with the kernel
 source

To pick up the changes in this cset:

  5ccaeedb489b41ce cfi: add C CFI type macro

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/linux/cfi_types.h include/linux/cfi_types.h

Please see tools/include/uapi/README for further details.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/linux/cfi_types.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/linux/cfi_types.h b/tools/include/linux/cfi_types.h
index 6b8713675765..685f7181780f 100644
--- a/tools/include/linux/cfi_types.h
+++ b/tools/include/linux/cfi_types.h
@@ -41,5 +41,28 @@
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
 #endif
 
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_CFI_CLANG
+#define DEFINE_CFI_TYPE(name, func)						\
+	/*									\
+	 * Force a reference to the function so the compiler generates		\
+	 * __kcfi_typeid_<func>.						\
+	 */									\
+	__ADDRESSABLE(func);							\
+	/* u32 name __ro_after_init = __kcfi_typeid_<func> */			\
+	extern u32 name;							\
+	asm (									\
+	"	.pushsection	.data..ro_after_init,\"aw\",\%progbits	\n"	\
+	"	.type	" #name ",\%object				\n"	\
+	"	.globl	" #name "					\n"	\
+	"	.p2align	2, 0x0					\n"	\
+	#name ":							\n"	\
+	"	.4byte	__kcfi_typeid_" #func "				\n"	\
+	"	.size	" #name ", 4					\n"	\
+	"	.popsection						\n"	\
+	);
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* _LINUX_CFI_TYPES_H */
-- 
2.25.1


From 619f55c859014e2235f83ba6cde8c59edc492f39 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Aug 2025 10:32:18 -0700
Subject: [PATCH 05/14] tools headers: Sync x86 headers with the kernel source

To pick up the changes in this cset:

  7b306dfa326f7011 x86/sev: Evict cache lines during SNP memory validation
  65f55a30176662ee x86/CPU/AMD: Add CPUID faulting support
  d8010d4ba43e9f79 x86/bugs: Add a Transient Scheduler Attacks mitigation
  a3c4f3396b82849a x86/msr-index: Add AMD workload classification MSRs
  17ec2f965344ee3f KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Please see tools/include/uapi/README for further details.

Cc: x86@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/x86/include/asm/cpufeatures.h | 10 +++++++++-
 tools/arch/x86/include/asm/msr-index.h   |  7 +++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index ee176236c2be..06fc0479a23f 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -218,6 +218,7 @@
 #define X86_FEATURE_FLEXPRIORITY	( 8*32+ 1) /* "flexpriority" Intel FlexPriority */
 #define X86_FEATURE_EPT			( 8*32+ 2) /* "ept" Intel Extended Page Table */
 #define X86_FEATURE_VPID		( 8*32+ 3) /* "vpid" Intel Virtual Processor ID */
+#define X86_FEATURE_COHERENCY_SFW_NO	( 8*32+ 4) /* SNP cache coherency software work around not needed */
 
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* "vmmcall" Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* Xen paravirtual guest */
@@ -456,10 +457,14 @@
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Breakpoints */
 #define X86_FEATURE_WRMSR_XX_BASE_NS	(20*32+ 1) /* WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing */
 #define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* LFENCE always serializing / synchronizes RDTSC */
+#define X86_FEATURE_VERW_CLEAR		(20*32+ 5) /* The memory form of VERW mitigates TSA */
 #define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* Null Selector Clears Base */
+
 #define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* Automatic IBRS */
 #define X86_FEATURE_NO_SMM_CTL_MSR	(20*32+ 9) /* SMM_CTL MSR is not present */
 
+#define X86_FEATURE_GP_ON_USER_CPUID	(20*32+17) /* User CPUID faulting */
+
 #define X86_FEATURE_PREFETCHI		(20*32+20) /* Prefetch Data/Instruction to Cache Level */
 #define X86_FEATURE_SBPB		(20*32+27) /* Selective Branch Prediction Barrier */
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* MSR_PRED_CMD[IBPB] flushes all branch type predictions */
@@ -487,6 +492,9 @@
 #define X86_FEATURE_PREFER_YMM		(21*32+ 8) /* Avoid ZMM registers due to downclocking */
 #define X86_FEATURE_APX			(21*32+ 9) /* Advanced Performance Extensions */
 #define X86_FEATURE_INDIRECT_THUNK_ITS	(21*32+10) /* Use thunk for indirect branches in lower half of cacheline */
+#define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
+#define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
+#define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
 
 /*
  * BUG word(s)
@@ -542,5 +550,5 @@
 #define X86_BUG_OLD_MICROCODE		X86_BUG( 1*32+ 6) /* "old_microcode" CPU has old microcode, it is surely vulnerable to something */
 #define X86_BUG_ITS			X86_BUG( 1*32+ 7) /* "its" CPU is affected by Indirect Target Selection */
 #define X86_BUG_ITS_NATIVE_ONLY		X86_BUG( 1*32+ 8) /* "its_native_only" CPU is affected by ITS, VMX is not affected */
-
+#define X86_BUG_TSA			X86_BUG( 1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 5cfb5d74dd5f..b65c3ba5fa14 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -419,6 +419,7 @@
 #define DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI	(1UL << 12)
 #define DEBUGCTLMSR_FREEZE_IN_SMM_BIT	14
 #define DEBUGCTLMSR_FREEZE_IN_SMM	(1UL << DEBUGCTLMSR_FREEZE_IN_SMM_BIT)
+#define DEBUGCTLMSR_RTM_DEBUG		BIT(15)
 
 #define MSR_PEBS_FRONTEND		0x000003f7
 
@@ -733,6 +734,11 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Hardware Feedback Support MSRs */
+#define MSR_AMD_WORKLOAD_CLASS_CONFIG		0xc0000500
+#define MSR_AMD_WORKLOAD_CLASS_ID		0xc0000501
+#define MSR_AMD_WORKLOAD_HRST			0xc0000502
+
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
@@ -831,6 +837,7 @@
 #define MSR_K7_HWCR_SMMLOCK		BIT_ULL(MSR_K7_HWCR_SMMLOCK_BIT)
 #define MSR_K7_HWCR_IRPERF_EN_BIT	30
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
+#define MSR_K7_HWCR_CPUID_USER_DIS_BIT	35
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
 #define MSR_K7_HWCR_CPB_DIS_BIT		25
-- 
2.25.1


From 14ec8ce45611c767656e4fa575f17b05344aa80a Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Aug 2025 10:32:18 -0700
Subject: [PATCH 06/14] tools headers: Sync arm64 headers with the kernel
 source
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  efe676a1a7554219 arm64: proton-pack: Add new CPUs 'k' values for branch mitigation
  e18c09b204e81702 arm64: Add support for HIP09 Spectre-BHB mitigation
  a9b5bd81b294d30a arm64: cputype: Add MIDR_CORTEX_A76AE
  53a52a0ec7680287 arm64: cputype: Add comments about Qualcomm Kryo 5XX and 6XX cores
  401c3333bb2396aa arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
  86edf6bdcf0571c0 smccc/kvm_guest: Enable errata based on implementation CPUs
  0bc9a9e85fcf4ffb KVM: arm64: Work around x1e's CNTVOFF_EL2 bogosity

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

But the following two changes cannot be applied since they introduced
new build errors in util/arm-spe.c.  So it still has the warning after
this change.

  c8c2647e69bedf80 arm64: Make  _midr_in_range_list() an exported function
  e3121298c7fcaf48 arm64: Modify _midr_range() functions to read MIDR/REVIDR internally

Please see tools/include/uapi/README for further details.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>

perf build: [WIP] Fix arm-spe build errors

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/arm64/include/asm/cputype.h | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 9a5d85cfd1fb..139d5e87dc95 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -75,11 +75,13 @@
 #define ARM_CPU_PART_CORTEX_A76		0xD0B
 #define ARM_CPU_PART_NEOVERSE_N1	0xD0C
 #define ARM_CPU_PART_CORTEX_A77		0xD0D
+#define ARM_CPU_PART_CORTEX_A76AE	0xD0E
 #define ARM_CPU_PART_NEOVERSE_V1	0xD40
 #define ARM_CPU_PART_CORTEX_A78		0xD41
 #define ARM_CPU_PART_CORTEX_A78AE	0xD42
 #define ARM_CPU_PART_CORTEX_X1		0xD44
 #define ARM_CPU_PART_CORTEX_A510	0xD46
+#define ARM_CPU_PART_CORTEX_X1C		0xD4C
 #define ARM_CPU_PART_CORTEX_A520	0xD80
 #define ARM_CPU_PART_CORTEX_A710	0xD47
 #define ARM_CPU_PART_CORTEX_A715	0xD4D
@@ -119,9 +121,11 @@
 #define QCOM_CPU_PART_KRYO		0x200
 #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
 #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
+#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
 #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
 #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
 #define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
+#define QCOM_CPU_PART_ORYON_X1		0x001
 
 #define NVIDIA_CPU_PART_DENVER		0x003
 #define NVIDIA_CPU_PART_CARMEL		0x004
@@ -129,6 +133,7 @@
 #define FUJITSU_CPU_PART_A64FX		0x001
 
 #define HISI_CPU_PART_TSV110		0xD01
+#define HISI_CPU_PART_HIP09			0xD02
 #define HISI_CPU_PART_HIP12		0xD06
 
 #define APPLE_CPU_PART_M1_ICESTORM	0x022
@@ -159,11 +164,13 @@
 #define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
 #define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
 #define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
+#define MIDR_CORTEX_A76AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76AE)
 #define MIDR_NEOVERSE_V1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V1)
 #define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
 #define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
 #define MIDR_CORTEX_X1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1)
 #define MIDR_CORTEX_A510 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A510)
+#define MIDR_CORTEX_X1C MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1C)
 #define MIDR_CORTEX_A520 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A520)
 #define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A710)
 #define MIDR_CORTEX_A715 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A715)
@@ -196,13 +203,26 @@
 #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 #define MIDR_QCOM_KRYO_2XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_GOLD)
 #define MIDR_QCOM_KRYO_2XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_SILVER)
+#define MIDR_QCOM_KRYO_3XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_GOLD)
 #define MIDR_QCOM_KRYO_3XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_SILVER)
 #define MIDR_QCOM_KRYO_4XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_GOLD)
 #define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
+#define MIDR_QCOM_ORYON_X1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_ORYON_X1)
+
+/*
+ * NOTES:
+ * - Qualcomm Kryo 5XX Prime / Gold ID themselves as MIDR_CORTEX_A77
+ * - Qualcomm Kryo 5XX Silver IDs itself as MIDR_QCOM_KRYO_4XX_SILVER
+ * - Qualcomm Kryo 6XX Prime IDs itself as MIDR_CORTEX_X1
+ * - Qualcomm Kryo 6XX Gold IDs itself as ARM_CPU_PART_CORTEX_A78
+ * - Qualcomm Kryo 6XX Silver IDs itself as MIDR_CORTEX_A55
+ */
+
 #define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
+#define MIDR_HISI_HIP09 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP09)
 #define MIDR_HISI_HIP12 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP12)
 #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
 #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
@@ -291,6 +311,14 @@ static inline u32 __attribute_const__ read_cpuid_id(void)
 	return read_cpuid(MIDR_EL1);
 }
 
+struct target_impl_cpu {
+	u64 midr;
+	u64 revidr;
+	u64 aidr;
+};
+
+bool cpu_errata_set_target_impl(u64 num, void *impl_cpus);
+
 static inline u64 __attribute_const__ read_cpuid_mpidr(void)
 {
 	return read_cpuid(MPIDR_EL1);
-- 
2.25.1


From c85538c4e3c7111958057d15ea8ee444116891c3 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Aug 2025 10:32:18 -0700
Subject: [PATCH 07/14] tools headers: Sync powerpc headers with the kernel
 source

To pick up the changes in this cset:

  69bf2053608423cb powerpc: Drop GPL boilerplate text with obsolete FSF address

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/uapi/asm/kvm.h

Please see tools/include/uapi/README for further details.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/powerpc/include/uapi/asm/kvm.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index eaeda001784e..077c5437f521 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -1,18 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
- *
  * Copyright IBM Corp. 2007
  *
  * Authors: Hollis Blanchard <hollisb@us.ibm.com>
-- 
2.25.1


From 52174e0eb13876654f56701c26a672890aa5e7e3 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Aug 2025 10:32:18 -0700
Subject: [PATCH 08/14] tools headers: Sync syscall tables with the kernel
 source

To pick up the changes in this cset:

  be7efb2d20d67f33 fs: introduce file_getattr and file_setattr syscalls

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
    diff -u tools/scripts/syscall.tbl scripts/syscall.tbl
    diff -u tools/perf/arch/x86/entry/syscalls/syscall_32.tbl arch/x86/entry/syscalls/syscall_32.tbl
    diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
    diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl
    diff -u tools/perf/arch/arm/entry/syscalls/syscall.tbl arch/arm/tools/syscall.tbl
    diff -u tools/perf/arch/sh/entry/syscalls/syscall.tbl arch/sh/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/sparc/entry/syscalls/syscall.tbl arch/sparc/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/xtensa/entry/syscalls/syscall.tbl arch/xtensa/kernel/syscalls/syscall.tbl

Please see tools/include/uapi/README for further details.

Cc: Arnd Bergmann <arnd@arndb.de>
CC: linux-api@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/asm-generic/unistd.h             | 8 +++++++-
 tools/perf/arch/arm/entry/syscalls/syscall.tbl      | 2 ++
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 2 ++
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 2 ++
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 2 ++
 tools/perf/arch/sh/entry/syscalls/syscall.tbl       | 2 ++
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl    | 2 ++
 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl   | 2 ++
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 2 ++
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl   | 2 ++
 tools/scripts/syscall.tbl                           | 2 ++
 11 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 2892a45023af..04e0077fb4c9 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -852,8 +852,14 @@ __SYSCALL(__NR_removexattrat, sys_removexattrat)
 #define __NR_open_tree_attr 467
 __SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
 
+/* fs/inode.c */
+#define __NR_file_getattr 468
+__SYSCALL(__NR_file_getattr, sys_file_getattr)
+#define __NR_file_setattr 469
+__SYSCALL(__NR_file_setattr, sys_file_setattr)
+
 #undef __NR_syscalls
-#define __NR_syscalls 468
+#define __NR_syscalls 470
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/arm/entry/syscalls/syscall.tbl b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
index 27c1d5ebcd91..b07e699aaa3c 100644
--- a/tools/perf/arch/arm/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
@@ -482,3 +482,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 1e8c44c7b614..7a7049c2c307 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -382,3 +382,5 @@
 465	n64	listxattrat			sys_listxattrat
 466	n64	removexattrat			sys_removexattrat
 467	n64	open_tree_attr			sys_open_tree_attr
+468	n64	file_getattr			sys_file_getattr
+469	n64	file_setattr			sys_file_setattr
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 9a084bdb8926..b453e80dfc00 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -558,3 +558,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index a4569b96ef06..8a6744d658db 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -470,3 +470,5 @@
 465  common	listxattrat		sys_listxattrat			sys_listxattrat
 466  common	removexattrat		sys_removexattrat		sys_removexattrat
 467  common	open_tree_attr		sys_open_tree_attr		sys_open_tree_attr
+468  common	file_getattr		sys_file_getattr		sys_file_getattr
+469  common	file_setattr		sys_file_setattr		sys_file_setattr
diff --git a/tools/perf/arch/sh/entry/syscalls/syscall.tbl b/tools/perf/arch/sh/entry/syscalls/syscall.tbl
index 52a7652fcff6..5e9c9eff5539 100644
--- a/tools/perf/arch/sh/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/sh/entry/syscalls/syscall.tbl
@@ -471,3 +471,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
index 83e45eb6c095..ebb7d06d1044 100644
--- a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
@@ -513,3 +513,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
index ac007ea00979..4877e16da69a 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
@@ -473,3 +473,5 @@
 465	i386	listxattrat		sys_listxattrat
 466	i386	removexattrat		sys_removexattrat
 467	i386	open_tree_attr		sys_open_tree_attr
+468	i386	file_getattr		sys_file_getattr
+469	i386	file_setattr		sys_file_setattr
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index cfb5ca41e30d..92cf0fe2291e 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -391,6 +391,8 @@
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
 467	common	open_tree_attr		sys_open_tree_attr
+468	common	file_getattr		sys_file_getattr
+469	common	file_setattr		sys_file_setattr
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl b/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
index f657a77314f8..374e4cb788d8 100644
--- a/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
@@ -438,3 +438,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/tools/scripts/syscall.tbl b/tools/scripts/syscall.tbl
index 580b4e246aec..d1ae5e92c615 100644
--- a/tools/scripts/syscall.tbl
+++ b/tools/scripts/syscall.tbl
@@ -408,3 +408,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
-- 
2.25.1


From b18aabe283a10774977d698c075d2296a2336aef Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Aug 2025 10:32:18 -0700
Subject: [PATCH 09/14] tools headers: Sync uapi/linux/fcntl.h with the kernel
 source

To pick up the changes in this cset:

  3941e37f62fe2c3c uapi/fcntl: add FD_PIDFS_ROOT
  cd5d2006327b6d84 uapi/fcntl: add FD_INVALID
  67fcec2919e4ed31 fcntl/pidfd: redefine PIDFD_SELF_THREAD_GROUP
  a4c746f06853f91d uapi/fcntl: mark range as reserved

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h

Please see tools/include/uapi/README for further details.

Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../trace/beauty/include/uapi/linux/fcntl.h    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
index a15ac2fa4b20..f291ab4f94eb 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
@@ -90,10 +90,28 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+/* Reserved kernel ranges [-100], [-10000, -40000]. */
 #define AT_FDCWD		-100    /* Special value for dirfd used to
 					   indicate openat should use the
 					   current working directory. */
 
+/*
+ * The concept of process and threads in userland and the kernel is a confusing
+ * one - within the kernel every thread is a 'task' with its own individual PID,
+ * however from userland's point of view threads are grouped by a single PID,
+ * which is that of the 'thread group leader', typically the first thread
+ * spawned.
+ *
+ * To cut the Gideon knot, for internal kernel usage, we refer to
+ * PIDFD_SELF_THREAD to refer to the current thread (or task from a kernel
+ * perspective), and PIDFD_SELF_THREAD_GROUP to refer to the current thread
+ * group leader...
+ */
+#define PIDFD_SELF_THREAD		-10000 /* Current thread. */
+#define PIDFD_SELF_THREAD_GROUP		-10001 /* Current thread group leader. */
+
+#define FD_PIDFS_ROOT			-10002 /* Root of the pidfs filesystem */
+#define FD_INVALID			-10009 /* Invalid file descriptor: -10000 - EBADF = -10009 */
 
 /* Generic flags for the *at(2) family of syscalls. */
 
-- 
2.25.1


From 4a4083af03a7a75a86c392fd60cb37ce23ed87b6 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Aug 2025 10:32:18 -0700
Subject: [PATCH 10/14] tools headers: Sync uapi/linux/fs.h with the kernel
 source

To pick up the changes in this cset:

  76fdb7eb4e1c9108 uapi: export PROCFS_ROOT_INO
  ca115d7e754691c0 tree-wide: s/struct fileattr/struct file_kattr/g
  be7efb2d20d67f33 fs: introduce file_getattr and file_setattr syscalls
  9eb22f7fedfc9eb1 fs: add ioctl to query metadata and protection info capabilities

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/linux/fs.h

Please see tools/include/uapi/README for further details.

Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../perf/trace/beauty/include/uapi/linux/fs.h | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fs.h b/tools/perf/trace/beauty/include/uapi/linux/fs.h
index 0098b0ce8ccb..0bd678a4a10e 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fs.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fs.h
@@ -60,6 +60,17 @@
 #define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
 #define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
 
+/*
+ * The root inode of procfs is guaranteed to always have the same inode number.
+ * For programs that make heavy use of procfs, verifying that the root is a
+ * real procfs root and using openat2(RESOLVE_{NO_{XDEV,MAGICLINKS},BENEATH})
+ * will allow you to make sure you are never tricked into operating on the
+ * wrong procfs file.
+ */
+enum procfs_ino {
+	PROCFS_ROOT_INO = 1,
+};
+
 struct file_clone_range {
 	__s64 src_fd;
 	__u64 src_offset;
@@ -91,6 +102,63 @@ struct fs_sysfs_path {
 	__u8			name[128];
 };
 
+/* Protection info capability flags */
+#define	LBMD_PI_CAP_INTEGRITY		(1 << 0)
+#define	LBMD_PI_CAP_REFTAG		(1 << 1)
+
+/* Checksum types for Protection Information */
+#define LBMD_PI_CSUM_NONE		0
+#define LBMD_PI_CSUM_IP			1
+#define LBMD_PI_CSUM_CRC16_T10DIF	2
+#define LBMD_PI_CSUM_CRC64_NVME		4
+
+/* sizeof first published struct */
+#define LBMD_SIZE_VER0			16
+
+/*
+ * Logical block metadata capability descriptor
+ * If the device does not support metadata, all the fields will be zero.
+ * Applications must check lbmd_flags to determine whether metadata is
+ * supported or not.
+ */
+struct logical_block_metadata_cap {
+	/* Bitmask of logical block metadata capability flags */
+	__u32	lbmd_flags;
+	/*
+	 * The amount of data described by each unit of logical block
+	 * metadata
+	 */
+	__u16	lbmd_interval;
+	/*
+	 * Size in bytes of the logical block metadata associated with each
+	 * interval
+	 */
+	__u8	lbmd_size;
+	/*
+	 * Size in bytes of the opaque block tag associated with each
+	 * interval
+	 */
+	__u8	lbmd_opaque_size;
+	/*
+	 * Offset in bytes of the opaque block tag within the logical block
+	 * metadata
+	 */
+	__u8	lbmd_opaque_offset;
+	/* Size in bytes of the T10 PI tuple associated with each interval */
+	__u8	lbmd_pi_size;
+	/* Offset in bytes of T10 PI tuple within the logical block metadata */
+	__u8	lbmd_pi_offset;
+	/* T10 PI guard tag type */
+	__u8	lbmd_guard_tag_type;
+	/* Size in bytes of the T10 PI application tag */
+	__u8	lbmd_app_tag_size;
+	/* Size in bytes of the T10 PI reference tag */
+	__u8	lbmd_ref_tag_size;
+	/* Size in bytes of the T10 PI storage tag */
+	__u8	lbmd_storage_tag_size;
+	__u8	pad;
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -148,6 +216,24 @@ struct fsxattr {
 	unsigned char	fsx_pad[8];
 };
 
+/*
+ * Variable size structure for file_[sg]et_attr().
+ *
+ * Note. This is alternative to the structure 'struct file_kattr'/'struct fsxattr'.
+ * As this structure is passed to/from userspace with its size, this can
+ * be versioned based on the size.
+ */
+struct file_attr {
+	__u64 fa_xflags;	/* xflags field value (get/set) */
+	__u32 fa_extsize;	/* extsize field value (get/set)*/
+	__u32 fa_nextents;	/* nextents field value (get)   */
+	__u32 fa_projid;	/* project identifier (get/set) */
+	__u32 fa_cowextsize;	/* CoW extsize field value (get/set) */
+};
+
+#define FILE_ATTR_SIZE_VER0 24
+#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
+
 /*
  * Flags for the fsx_xflags field
  */
@@ -247,6 +333,8 @@ struct fsxattr {
  * also /sys/kernel/debug/ for filesystems with debugfs exports
  */
 #define FS_IOC_GETFSSYSFSPATH		_IOR(0x15, 1, struct fs_sysfs_path)
+/* Get logical block metadata capability details */
+#define FS_IOC_GETLBMD_CAP		_IOWR(0x15, 2, struct logical_block_metadata_cap)
 
 /*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
-- 
2.25.1


From e7e79e99726190a5a83d158576cd448896d68102 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Aug 2025 10:32:18 -0700
Subject: [PATCH 11/14] tools headers: Sync uapi/linux/prctl.h with the kernel
 source

To pick up the changes in this cset:

  b1fabef37bd504f3 prctl: Introduce PR_MTE_STORE_ONLY
  a2fc422ed75748ee syscall_user_dispatch: Add PR_SYS_DISPATCH_INCLUSIVE_ON

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/prctl.h include/uapi/linux/prctl.h

Please see tools/include/uapi/README for further details.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/uapi/linux/prctl.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/prctl.h b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
index 3b93fb906e3c..ed3aed264aeb 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/prctl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
@@ -244,6 +244,8 @@ struct prctl_mm_map {
 # define PR_MTE_TAG_MASK		(0xffffUL << PR_MTE_TAG_SHIFT)
 /* Unused; kept only for source compatibility */
 # define PR_MTE_TCF_SHIFT		1
+/* MTE tag check store only */
+# define PR_MTE_STORE_ONLY		(1UL << 19)
 /* RISC-V pointer masking tag length */
 # define PR_PMLEN_SHIFT			24
 # define PR_PMLEN_MASK			(0x7fUL << PR_PMLEN_SHIFT)
@@ -255,7 +257,12 @@ struct prctl_mm_map {
 /* Dispatch syscalls to a userspace handler */
 #define PR_SET_SYSCALL_USER_DISPATCH	59
 # define PR_SYS_DISPATCH_OFF		0
-# define PR_SYS_DISPATCH_ON		1
+/* Enable dispatch except for the specified range */
+# define PR_SYS_DISPATCH_EXCLUSIVE_ON	1
+/* Enable dispatch for the specified range */
+# define PR_SYS_DISPATCH_INCLUSIVE_ON	2
+/* Legacy name for backwards compatibility */
+# define PR_SYS_DISPATCH_ON		PR_SYS_DISPATCH_EXCLUSIVE_ON
 /* The control values for the user space selector when dispatch is enabled */
 # define SYSCALL_DISPATCH_FILTER_ALLOW	0
 # define SYSCALL_DISPATCH_FILTER_BLOCK	1
-- 
2.25.1


From f79a62f4b3c750759e60a402e8fe5180fc5771f0 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Aug 2025 10:32:18 -0700
Subject: [PATCH 12/14] tools headers: Sync uapi/linux/vhost.h with the kernel
 source

To pick up the changes in this cset:

  7d9896e9f6d02d8a vhost: Reintroduce kthread API and add mode selection
  333c515d189657c9 vhost-net: allow configuring extended features

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h include/uapi/linux/vhost.h

Please see tools/include/uapi/README for further details.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux.dev
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../trace/beauty/include/uapi/linux/vhost.h   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/vhost.h b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
index d4b3e2ae1314..c57674a6aa0d 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/vhost.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
@@ -235,4 +235,39 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+/* Extended features manipulation */
+#define VHOST_GET_FEATURES_ARRAY _IOR(VHOST_VIRTIO, 0x83, \
+				       struct vhost_features_array)
+#define VHOST_SET_FEATURES_ARRAY _IOW(VHOST_VIRTIO, 0x83, \
+				       struct vhost_features_array)
+
+/* fork_owner values for vhost */
+#define VHOST_FORK_OWNER_KTHREAD 0
+#define VHOST_FORK_OWNER_TASK 1
+
+/**
+ * VHOST_SET_FORK_FROM_OWNER - Set the fork_owner flag for the vhost device,
+ * This ioctl must called before VHOST_SET_OWNER.
+ * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=y
+ *
+ * @param fork_owner: An 8-bit value that determines the vhost thread mode
+ *
+ * When fork_owner is set to VHOST_FORK_OWNER_TASK(default value):
+ *   - Vhost will create vhost worker as tasks forked from the owner,
+ *     inheriting all of the owner's attributes.
+ *
+ * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
+ *   - Vhost will create vhost workers as kernel threads.
+ */
+#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x84, __u8)
+
+/**
+ * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost device.
+ * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=y
+ *
+ * @return: An 8-bit value indicating the current thread mode.
+ */
+#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x85, __u8)
+
 #endif
-- 
2.25.1


From ba0b7081f7a521d7c28b527a4f18666a148471e7 Mon Sep 17 00:00:00 2001
From: Ian Rogers <irogers@google.com>
Date: Fri, 22 Aug 2025 17:00:23 -0700
Subject: [PATCH 13/14] perf symbol-minimal: Fix ehdr reading in
 filename__read_build_id

The e_ident is part of the ehdr and so reading it a second time would
mean the read ehdr was displaced by 16-bytes. Switch from stdio to
open/read/lseek syscalls for similarity with the symbol-elf version of
the function and so that later changes can alter then open flags.

Fixes: fef8f648bb47 ("perf symbol: Fix use-after-free in filename__read_build_id")
Signed-off-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20250823000024.724394-2-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol-minimal.c | 55 ++++++++++++++++----------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 7201494c5c20..8d41bd7842df 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -4,7 +4,6 @@
 
 #include <errno.h>
 #include <unistd.h>
-#include <stdio.h>
 #include <fcntl.h>
 #include <string.h>
 #include <stdlib.h>
@@ -88,11 +87,8 @@ int filename__read_debuglink(const char *filename __maybe_unused,
  */
 int filename__read_build_id(const char *filename, struct build_id *bid)
 {
-	FILE *fp;
-	int ret = -1;
+	int fd, ret = -1;
 	bool need_swap = false, elf32;
-	u8 e_ident[EI_NIDENT];
-	int i;
 	union {
 		struct {
 			Elf32_Ehdr ehdr32;
@@ -103,28 +99,27 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			Elf64_Phdr *phdr64;
 		};
 	} hdrs;
-	void *phdr;
-	size_t phdr_size;
-	void *buf = NULL;
-	size_t buf_size = 0;
+	void *phdr, *buf = NULL;
+	ssize_t phdr_size, ehdr_size, buf_size = 0;
 
-	fp = fopen(filename, "r");
-	if (fp == NULL)
+	fd = open(filename, O_RDONLY);
+	if (fd < 0)
 		return -1;
 
-	if (fread(e_ident, sizeof(e_ident), 1, fp) != 1)
+	if (read(fd, hdrs.ehdr32.e_ident, EI_NIDENT) != EI_NIDENT)
 		goto out;
 
-	if (memcmp(e_ident, ELFMAG, SELFMAG) ||
-	    e_ident[EI_VERSION] != EV_CURRENT)
+	if (memcmp(hdrs.ehdr32.e_ident, ELFMAG, SELFMAG) ||
+	    hdrs.ehdr32.e_ident[EI_VERSION] != EV_CURRENT)
 		goto out;
 
-	need_swap = check_need_swap(e_ident[EI_DATA]);
-	elf32 = e_ident[EI_CLASS] == ELFCLASS32;
+	need_swap = check_need_swap(hdrs.ehdr32.e_ident[EI_DATA]);
+	elf32 = hdrs.ehdr32.e_ident[EI_CLASS] == ELFCLASS32;
+	ehdr_size = (elf32 ? sizeof(hdrs.ehdr32) : sizeof(hdrs.ehdr64)) - EI_NIDENT;
 
-	if (fread(elf32 ? (void *)&hdrs.ehdr32 : (void *)&hdrs.ehdr64,
-		  elf32 ? sizeof(hdrs.ehdr32) : sizeof(hdrs.ehdr64),
-		  1, fp) != 1)
+	if (read(fd,
+		 (elf32 ? (void *)&hdrs.ehdr32 : (void *)&hdrs.ehdr64) + EI_NIDENT,
+		 ehdr_size) != ehdr_size)
 		goto out;
 
 	if (need_swap) {
@@ -138,14 +133,18 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			hdrs.ehdr64.e_phnum = bswap_16(hdrs.ehdr64.e_phnum);
 		}
 	}
-	phdr_size = elf32 ? hdrs.ehdr32.e_phentsize * hdrs.ehdr32.e_phnum
-			  : hdrs.ehdr64.e_phentsize * hdrs.ehdr64.e_phnum;
+	if ((elf32 && hdrs.ehdr32.e_phentsize != sizeof(Elf32_Phdr)) ||
+	    (!elf32 && hdrs.ehdr64.e_phentsize != sizeof(Elf64_Phdr)))
+		goto out;
+
+	phdr_size = elf32 ? sizeof(Elf32_Phdr) * hdrs.ehdr32.e_phnum
+			  : sizeof(Elf64_Phdr) * hdrs.ehdr64.e_phnum;
 	phdr = malloc(phdr_size);
 	if (phdr == NULL)
 		goto out;
 
-	fseek(fp, elf32 ? hdrs.ehdr32.e_phoff : hdrs.ehdr64.e_phoff, SEEK_SET);
-	if (fread(phdr, phdr_size, 1, fp) != 1)
+	lseek(fd, elf32 ? hdrs.ehdr32.e_phoff : hdrs.ehdr64.e_phoff, SEEK_SET);
+	if (read(fd, phdr, phdr_size) != phdr_size)
 		goto out_free;
 
 	if (elf32)
@@ -153,8 +152,8 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 	else
 		hdrs.phdr64 = phdr;
 
-	for (i = 0; i < elf32 ? hdrs.ehdr32.e_phnum : hdrs.ehdr64.e_phnum; i++) {
-		size_t p_filesz;
+	for (int i = 0; i < (elf32 ? hdrs.ehdr32.e_phnum : hdrs.ehdr64.e_phnum); i++) {
+		ssize_t p_filesz;
 
 		if (need_swap) {
 			if (elf32) {
@@ -180,8 +179,8 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 				goto out_free;
 			buf = tmp;
 		}
-		fseek(fp, elf32 ? hdrs.phdr32[i].p_offset : hdrs.phdr64[i].p_offset, SEEK_SET);
-		if (fread(buf, p_filesz, 1, fp) != 1)
+		lseek(fd, elf32 ? hdrs.phdr32[i].p_offset : hdrs.phdr64[i].p_offset, SEEK_SET);
+		if (read(fd, buf, p_filesz) != p_filesz)
 			goto out_free;
 
 		ret = read_build_id(buf, p_filesz, bid, need_swap);
@@ -194,7 +193,7 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 	free(buf);
 	free(phdr);
 out:
-	fclose(fp);
+	close(fd);
 	return ret;
 }
 
-- 
2.25.1


From 2c369d91d0933aaff96b6b807b22363e6a38a625 Mon Sep 17 00:00:00 2001
From: Ian Rogers <irogers@google.com>
Date: Fri, 22 Aug 2025 17:00:24 -0700
Subject: [PATCH 14/14] perf symbol: Add blocking argument to
 filename__read_build_id

When synthesizing build-ids, for build ID mmap2 events, they will be
added for data mmaps if -d/--data is specified. The files opened for
their build IDs may block on the open causing perf to hang during
synthesis. There is some robustness in existing calls to
filename__read_build_id by checking the file path is to a regular
file, which unfortunately fails for symlinks. Rather than adding more
is_regular_file calls, switch filename__read_build_id to take a
"block" argument and specify O_NONBLOCK when this is false. The
existing is_regular_file checking callers and the event synthesis
callers are made to pass false and thereby avoiding the hang.

Fixes: 53b00ff358dc ("perf record: Make --buildid-mmap the default")
Signed-off-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20250823000024.724394-3-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/bench/inject-buildid.c  | 2 +-
 tools/perf/builtin-buildid-cache.c | 8 ++++----
 tools/perf/builtin-inject.c        | 4 ++--
 tools/perf/tests/sdt.c             | 2 +-
 tools/perf/util/build-id.c         | 4 ++--
 tools/perf/util/debuginfo.c        | 8 ++++++--
 tools/perf/util/dsos.c             | 4 ++--
 tools/perf/util/symbol-elf.c       | 9 +++++----
 tools/perf/util/symbol-minimal.c   | 6 +++---
 tools/perf/util/symbol.c           | 8 ++++----
 tools/perf/util/symbol.h           | 2 +-
 tools/perf/util/synthetic-events.c | 2 +-
 12 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index aad572a78d7f..12387ea88b9a 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -85,7 +85,7 @@ static int add_dso(const char *fpath, const struct stat *sb __maybe_unused,
 	if (typeflag == FTW_D || typeflag == FTW_SL)
 		return 0;
 
-	if (filename__read_build_id(fpath, &bid) < 0)
+	if (filename__read_build_id(fpath, &bid, /*block=*/true) < 0)
 		return 0;
 
 	dso->name = realpath(fpath, NULL);
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index c98104481c8a..2e0f2004696a 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -180,7 +180,7 @@ static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
 	struct nscookie nsc;
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	err = filename__read_build_id(filename, &bid);
+	err = filename__read_build_id(filename, &bid, /*block=*/true);
 	nsinfo__mountns_exit(&nsc);
 	if (err < 0) {
 		pr_debug("Couldn't read a build-id in %s\n", filename);
@@ -204,7 +204,7 @@ static int build_id_cache__remove_file(const char *filename, struct nsinfo *nsi)
 	int err;
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	err = filename__read_build_id(filename, &bid);
+	err = filename__read_build_id(filename, &bid, /*block=*/true);
 	nsinfo__mountns_exit(&nsc);
 	if (err < 0) {
 		pr_debug("Couldn't read a build-id in %s\n", filename);
@@ -280,7 +280,7 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 	if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
 		return true;
 
-	if (filename__read_build_id(filename, &bid) == -1) {
+	if (filename__read_build_id(filename, &bid, /*block=*/true) == -1) {
 		if (errno == ENOENT)
 			return false;
 
@@ -309,7 +309,7 @@ static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
 	int err;
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	err = filename__read_build_id(filename, &bid);
+	err = filename__read_build_id(filename, &bid, /*block=*/true);
 	nsinfo__mountns_exit(&nsc);
 	if (err < 0) {
 		pr_debug("Couldn't read a build-id in %s\n", filename);
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 40ba6a94f719..a114b3fa1bea 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -680,12 +680,12 @@ static int dso__read_build_id(struct dso *dso)
 
 	mutex_lock(dso__lock(dso));
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	if (filename__read_build_id(dso__long_name(dso), &bid) > 0)
+	if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/true) > 0)
 		dso__set_build_id(dso, &bid);
 	else if (dso__nsinfo(dso)) {
 		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
 
-		if (new_name && filename__read_build_id(new_name, &bid) > 0)
+		if (new_name && filename__read_build_id(new_name, &bid, /*block=*/true) > 0)
 			dso__set_build_id(dso, &bid);
 		free(new_name);
 	}
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 93baee2eae42..6132f1af3e22 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -31,7 +31,7 @@ static int build_id_cache__add_file(const char *filename)
 	struct build_id bid = { .size = 0, };
 	int err;
 
-	err = filename__read_build_id(filename, &bid);
+	err = filename__read_build_id(filename, &bid, /*block=*/true);
 	if (err < 0) {
 		pr_debug("Failed to read build id of %s\n", filename);
 		return err;
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index a7018a3b0437..bf7f3268b9a2 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -115,7 +115,7 @@ int filename__snprintf_build_id(const char *pathname, char *sbuild_id, size_t sb
 	struct build_id bid = { .size = 0, };
 	int ret;
 
-	ret = filename__read_build_id(pathname, &bid);
+	ret = filename__read_build_id(pathname, &bid, /*block=*/true);
 	if (ret < 0)
 		return ret;
 
@@ -841,7 +841,7 @@ static int filename__read_build_id_ns(const char *filename,
 	int ret;
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	ret = filename__read_build_id(filename, bid);
+	ret = filename__read_build_id(filename, bid, /*block=*/true);
 	nsinfo__mountns_exit(&nsc);
 
 	return ret;
diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index a44c70f93156..bb9ebd84ec2d 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -110,8 +110,12 @@ struct debuginfo *debuginfo__new(const char *path)
 	if (!dso)
 		goto out;
 
-	/* Set the build id for DSO_BINARY_TYPE__BUILDID_DEBUGINFO */
-	if (is_regular_file(path) && filename__read_build_id(path, &bid) > 0)
+	/*
+	 * Set the build id for DSO_BINARY_TYPE__BUILDID_DEBUGINFO. Don't block
+	 * incase the path isn't for a regular file.
+	 */
+	assert(!dso__has_build_id(dso));
+	if (filename__read_build_id(path, &bid, /*block=*/false) > 0)
 		dso__set_build_id(dso, &bid);
 
 	for (type = distro_dwarf_types;
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 0a7645c7fae7..64c1d65b0149 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -81,13 +81,13 @@ static int dsos__read_build_ids_cb(struct dso *dso, void *data)
 		return 0;
 	}
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	if (filename__read_build_id(dso__long_name(dso), &bid) > 0) {
+	if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/true) > 0) {
 		dso__set_build_id(dso, &bid);
 		args->have_build_id = true;
 	} else if (errno == ENOENT && dso__nsinfo(dso)) {
 		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
 
-		if (new_name && filename__read_build_id(new_name, &bid) > 0) {
+		if (new_name && filename__read_build_id(new_name, &bid, /*block=*/true) > 0) {
 			dso__set_build_id(dso, &bid);
 			args->have_build_id = true;
 		}
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6d2c280a1730..033c79231a54 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -902,7 +902,7 @@ static int read_build_id(const char *filename, struct build_id *bid)
 
 #else // HAVE_LIBBFD_BUILDID_SUPPORT
 
-static int read_build_id(const char *filename, struct build_id *bid)
+static int read_build_id(const char *filename, struct build_id *bid, bool block)
 {
 	size_t size = sizeof(bid->data);
 	int fd, err = -1;
@@ -911,7 +911,7 @@ static int read_build_id(const char *filename, struct build_id *bid)
 	if (size < BUILD_ID_SIZE)
 		goto out;
 
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
 	if (fd < 0)
 		goto out;
 
@@ -934,7 +934,7 @@ static int read_build_id(const char *filename, struct build_id *bid)
 
 #endif // HAVE_LIBBFD_BUILDID_SUPPORT
 
-int filename__read_build_id(const char *filename, struct build_id *bid)
+int filename__read_build_id(const char *filename, struct build_id *bid, bool block)
 {
 	struct kmod_path m = { .name = NULL, };
 	char path[PATH_MAX];
@@ -958,9 +958,10 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 		}
 		close(fd);
 		filename = path;
+		block = true;
 	}
 
-	err = read_build_id(filename, bid);
+	err = read_build_id(filename, bid, block);
 
 	if (m.comp)
 		unlink(filename);
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 8d41bd7842df..41e4ebe5eac5 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -85,7 +85,7 @@ int filename__read_debuglink(const char *filename __maybe_unused,
 /*
  * Just try PT_NOTE header otherwise fails
  */
-int filename__read_build_id(const char *filename, struct build_id *bid)
+int filename__read_build_id(const char *filename, struct build_id *bid, bool block)
 {
 	int fd, ret = -1;
 	bool need_swap = false, elf32;
@@ -102,7 +102,7 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 	void *phdr, *buf = NULL;
 	ssize_t phdr_size, ehdr_size, buf_size = 0;
 
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
 	if (fd < 0)
 		return -1;
 
@@ -323,7 +323,7 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
 	if (ret >= 0)
 		RC_CHK_ACCESS(dso)->is_64_bit = ret;
 
-	if (filename__read_build_id(ss->name, &bid) > 0)
+	if (filename__read_build_id(ss->name, &bid, /*block=*/true) > 0)
 		dso__set_build_id(dso, &bid);
 	return 0;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index e816e4220d33..3fed54de5401 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1869,14 +1869,14 @@ int dso__load(struct dso *dso, struct map *map)
 
 	/*
 	 * Read the build id if possible. This is required for
-	 * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work
+	 * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work. Don't block in case path
+	 * isn't for a regular file.
 	 */
-	if (!dso__has_build_id(dso) &&
-	    is_regular_file(dso__long_name(dso))) {
+	if (!dso__has_build_id(dso)) {
 		struct build_id bid = { .size = 0, };
 
 		__symbol__join_symfs(name, PATH_MAX, dso__long_name(dso));
-		if (filename__read_build_id(name, &bid) > 0)
+		if (filename__read_build_id(name, &bid, /*block=*/false) > 0)
 			dso__set_build_id(dso, &bid);
 	}
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 3fb5d146d9b1..347106218799 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -140,7 +140,7 @@ struct symbol *dso__next_symbol(struct symbol *sym);
 
 enum dso_type dso__type_fd(int fd);
 
-int filename__read_build_id(const char *filename, struct build_id *id);
+int filename__read_build_id(const char *filename, struct build_id *id, bool block);
 int sysfs__read_build_id(const char *filename, struct build_id *bid);
 int modules__parse(const char *filename, void *arg,
 		   int (*process_module)(void *arg, const char *name,
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index cb2c1ace304a..fcd1fd13c30e 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -401,7 +401,7 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 	nsi = nsinfo__new(event->pid);
 	nsinfo__mountns_enter(nsi, &nc);
 
-	rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
+	rc = filename__read_build_id(event->filename, &bid, /*block=*/false) > 0 ? 0 : -1;
 
 	nsinfo__mountns_exit(&nc);
 	nsinfo__put(nsi);
-- 
2.25.1


