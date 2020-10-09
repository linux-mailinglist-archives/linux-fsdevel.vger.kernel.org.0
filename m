Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01CD2891FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 21:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403772AbgJITnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 15:43:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:56990 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390782AbgJITnS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 15:43:18 -0400
IronPort-SDR: hDzTMMCSvXMgBKJhmaix94FbtpcdrGNN9iqzfH3/aBeTq0aH4eAP1UPGOu4LEl0CZXULH0FAnI
 6BiidN9/qVrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="152450171"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="152450171"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:43:16 -0700
IronPort-SDR: QGagKaHaEz6C8vSTvWE34GsKgKGu64SrXDfmG1DDvczkuQvQD4Hdp2SxOffaG9Mj5FBKYAuyH8
 iqAmnV/wWgUg==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="312650714"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:43:16 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH RFC V3 4/9] x86/pks: Preserve the PKRS MSR on context switch
Date:   Fri,  9 Oct 2020 12:42:53 -0700
Message-Id: <20201009194258.3207172-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201009194258.3207172-1-ira.weiny@intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The PKRS MSR is defined as a per-logical-processor register.  This
isolates memory access by logical CPU.  Unfortunately, the MSR is not
managed by XSAVE.  Therefore, tasks must save/restore the MSR value on
context switch.

Define a saved PKRS value in the task struct, as well as a cached
per-logical-processor MSR value which mirrors the MSR value of the
current CPU.  Initialize all tasks with the default MSR value.  Then, on
schedule in, check the saved task MSR vs the per-cpu value.  If
different proceed to write the MSR.  If not avoid the overhead of the
MSR write and continue.

Follow on patches will update the saved PKRS as well as the MSR if
needed.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/include/asm/msr-index.h    |  1 +
 arch/x86/include/asm/pkeys_common.h | 20 ++++++++++++++++++++
 arch/x86/include/asm/processor.h    | 13 +++++++++++++
 arch/x86/kernel/cpu/common.c        |  2 ++
 arch/x86/kernel/process.c           | 21 +++++++++++++++++++++
 arch/x86/mm/pkeys.c                 | 28 ++++++++++++++++++++++++++++
 6 files changed, 85 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 2859ee4f39a8..e467e087f1b3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -747,6 +747,7 @@
 
 #define MSR_IA32_TSC_DEADLINE		0x000006E0
 
+#define MSR_IA32_PKRS			0x000006E1
 
 #define MSR_TSX_FORCE_ABORT		0x0000010F
 
diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
index a9f086f1e4b4..05781be33c14 100644
--- a/arch/x86/include/asm/pkeys_common.h
+++ b/arch/x86/include/asm/pkeys_common.h
@@ -8,4 +8,24 @@
 
 #define PKR_AD_KEY(pkey)	(PKR_AD_BIT << ((pkey) * PKR_BITS_PER_PKEY))
 
+/*
+ * Define a default PKRS value for each task.
+ *
+ * Key 0 has no restriction.  All other keys are set to the most restrictive
+ * value which is access disabled (AD=1).
+ *
+ * NOTE: This needs to be a macro to be used as part of the INIT_THREAD macro.
+ */
+#define INIT_PKRS_VALUE (PKR_AD_KEY(1) | PKR_AD_KEY(2) | PKR_AD_KEY(3) | \
+			 PKR_AD_KEY(4) | PKR_AD_KEY(5) | PKR_AD_KEY(6) | \
+			 PKR_AD_KEY(7) | PKR_AD_KEY(8) | PKR_AD_KEY(9) | \
+			 PKR_AD_KEY(10) | PKR_AD_KEY(11) | PKR_AD_KEY(12) | \
+			 PKR_AD_KEY(13) | PKR_AD_KEY(14) | PKR_AD_KEY(15))
+
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+void write_pkrs(u32 new_pkrs);
+#else
+static inline void write_pkrs(u32 new_pkrs) { }
+#endif
+
 #endif /*_ASM_X86_PKEYS_INTERNAL_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 97143d87994c..da2381136b2d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -18,6 +18,7 @@ struct vm86;
 #include <asm/cpufeatures.h>
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
+#include <asm/pkeys_common.h>
 #include <asm/percpu.h>
 #include <asm/msr.h>
 #include <asm/desc_defs.h>
@@ -542,6 +543,11 @@ struct thread_struct {
 
 	unsigned int		sig_on_uaccess_err:1;
 
+#ifdef	CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+	/* Saved Protection key register for supervisor mappings */
+	u32			saved_pkrs;
+#endif
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
@@ -840,8 +846,15 @@ static inline void spin_lock_prefetch(const void *x)
 #define STACK_TOP		TASK_SIZE_LOW
 #define STACK_TOP_MAX		TASK_SIZE_MAX
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+#define INIT_THREAD_PKRS	.saved_pkrs = INIT_PKRS_VALUE
+#else
+#define INIT_THREAD_PKRS	0
+#endif
+
 #define INIT_THREAD  {						\
 	.addr_limit		= KERNEL_DS,			\
+	INIT_THREAD_PKRS,					\
 }
 
 extern unsigned long KSTK_ESP(struct task_struct *task);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a129d5e4afab..968863d59b6c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -57,6 +57,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
+#include <linux/pkeys.h>
 
 #include "cpu.h"
 
@@ -1458,6 +1459,7 @@ static void setup_pks(void)
 	if (!cpu_feature_enabled(X86_FEATURE_PKS))
 		return;
 
+	write_pkrs(INIT_PKRS_VALUE);
 	cr4_set_bits(X86_CR4_PKS);
 }
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ba4593a913fa..eb3a95a69392 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -43,6 +43,7 @@
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
 #include <asm/frame.h>
+#include <asm/pkeys_common.h>
 
 #include "process.h"
 
@@ -187,6 +188,22 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	return ret;
 }
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+DECLARE_PER_CPU(u32, pkrs_cache);
+static inline void pks_init_task(struct task_struct *tsk)
+{
+	/* New tasks get the most restrictive PKRS value */
+	tsk->thread.saved_pkrs = INIT_PKRS_VALUE;
+}
+static inline void pks_sched_in(void)
+{
+	write_pkrs(current->thread.saved_pkrs);
+}
+#else
+static inline void pks_init_task(struct task_struct *tsk) { }
+static inline void pks_sched_in(void) { }
+#endif
+
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
@@ -195,6 +212,8 @@ void flush_thread(void)
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
 	fpu__clear_all(&tsk->thread.fpu);
+
+	pks_init_task(tsk);
 }
 
 void disable_TSC(void)
@@ -644,6 +663,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 
 	if ((tifp ^ tifn) & _TIF_SLD)
 		switch_to_sld(tifn);
+
+	pks_sched_in();
 }
 
 /*
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 3cf8f775f36d..30f65dd3d0c5 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -229,3 +229,31 @@ u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
 
 	return pk_reg;
 }
+
+DEFINE_PER_CPU(u32, pkrs_cache);
+
+/**
+ * It should also be noted that the underlying WRMSR(MSR_IA32_PKRS) is not
+ * serializing but still maintains ordering properties similar to WRPKRU.
+ * The current SDM section on PKRS needs updating but should be the same as
+ * that of WRPKRU.  So to quote from the WRPKRU text:
+ *
+ * 	WRPKRU will never execute transiently. Memory accesses
+ * 	affected by PKRU register will not execute (even transiently)
+ * 	until all prior executions of WRPKRU have completed execution
+ * 	and updated the PKRU register.
+ */
+void write_pkrs(u32 new_pkrs)
+{
+	u32 *pkrs;
+
+	if (!static_cpu_has(X86_FEATURE_PKS))
+		return;
+
+	pkrs = get_cpu_ptr(&pkrs_cache);
+	if (*pkrs != new_pkrs) {
+		*pkrs = new_pkrs;
+		wrmsrl(MSR_IA32_PKRS, new_pkrs);
+	}
+	put_cpu_ptr(pkrs);
+}
-- 
2.28.0.rc0.12.gb6a658bd00c9

