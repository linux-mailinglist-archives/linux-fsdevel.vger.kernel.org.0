Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3EF2235AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 09:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgGQHWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 03:22:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:38280 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgGQHVE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:21:04 -0400
IronPort-SDR: 20fR+/Gn2SecUpqdL5CxY/xhbemrORuDHPSRZ6oCkJntn0crl78QqZxteh0SQogEzxLL+YqB/n
 vZo/Reg5Khmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="137666002"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="137666002"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:02 -0700
IronPort-SDR: T0X54Up0hzXrelQKBCFriABUplplx0wn+etZAwWtZeijUUT+2ZTs7WpOxrsRmfFkw7Z2Mqtz0B
 LN5/HIH0BGQg==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="318690690"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:02 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH RFC V2 04/17] x86/pks: Preserve the PKRS MSR on context switch
Date:   Fri, 17 Jul 2020 00:20:43 -0700
Message-Id: <20200717072056.73134-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20200717072056.73134-1-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The PKRS MSR is defined as a per-logical-processor register.  This
isolates memory access by CPU.  Unfortunately, the MSR is not managed
by XSAVE.  Therefore, We must preserve the protections for individual
tasks even if they are context switched out and placed on another cpu
later.

Define a saved PKRS value in the task struct, as well as a cached
per-logical-processor MSR value which mirrors the MSR value of the
current CPU.  Initialize, all tasks with the default MSR value.  Then,
on schedule in, check the saved task MSR vs the per-cpu value.  If
different proceed to write the MSR.  If not we avoid the overhead of the
MSR write and continue.

Follow on patches will update the saved PKRS as well as the MSR if
needed.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/include/asm/msr-index.h      |  1 +
 arch/x86/include/asm/pkeys_internal.h | 20 +++++++++++++++
 arch/x86/include/asm/processor.h      | 12 +++++++++
 arch/x86/kernel/cpu/common.c          |  2 ++
 arch/x86/kernel/process.c             | 35 +++++++++++++++++++++++++++
 arch/x86/mm/pkeys.c                   | 13 ++++++++++
 6 files changed, 83 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e8370e64a155..b6ffdfc3f388 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -727,6 +727,7 @@
 
 #define MSR_IA32_TSC_DEADLINE		0x000006E0
 
+#define MSR_IA32_PKRS			0x000006E1
 
 #define MSR_TSX_FORCE_ABORT		0x0000010F
 
diff --git a/arch/x86/include/asm/pkeys_internal.h b/arch/x86/include/asm/pkeys_internal.h
index a9f086f1e4b4..05257cdc7200 100644
--- a/arch/x86/include/asm/pkeys_internal.h
+++ b/arch/x86/include/asm/pkeys_internal.h
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
+void write_pkrs(u32 pkrs_val);
+#else
+static inline void write_pkrs(u32 pkrs_val) { }
+#endif
+
 #endif /*_ASM_X86_PKEYS_INTERNAL_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 7da9855b5068..704d9f28fd4e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -545,6 +545,11 @@ struct thread_struct {
 
 	unsigned int		sig_on_uaccess_err:1;
 
+#ifdef	CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+	/* Saved Protection key register for supervisor mappings */
+	u32			saved_pkrs;
+#endif
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
@@ -907,8 +912,15 @@ static inline void spin_lock_prefetch(const void *x)
 #define STACK_TOP		TASK_SIZE_LOW
 #define STACK_TOP_MAX		TASK_SIZE_MAX
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+#define INIT_THREAD_PKRS	.saved_pkrs = INIT_PKRS_VALUE,
+#else
+#define INIT_THREAD_PKRS
+#endif
+
 #define INIT_THREAD  {						\
 	.addr_limit		= KERNEL_DS,			\
+	INIT_THREAD_PKRS					\
 }
 
 extern unsigned long KSTK_ESP(struct task_struct *task);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f34bcefeda42..b8241936cbbf 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -56,6 +56,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
+#include <asm/pkeys_internal.h>
 
 #include "cpu.h"
 
@@ -1442,6 +1443,7 @@ static void setup_pks(void)
 		return;
 
 	cr4_set_bits(X86_CR4_PKS);
+	write_pkrs(INIT_PKRS_VALUE);
 }
 
 /*
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f362ce0d5ac0..d69250a7c1bf 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -42,6 +42,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
+#include <asm/pkeys_internal.h>
 
 #include "process.h"
 
@@ -184,6 +185,36 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	return ret;
 }
 
+/*
+ * NOTE: We wrap pks_init_task() and pks_sched_in() with
+ * CONFIG_ARCH_HAS_SUPERVISOR_PKEYS because using IS_ENABLED() fails
+ * due to the lack of task_struct->saved_pkrs in this configuration.
+ * Furthermore, we place them here because of the complexity introduced by
+ * header conflicts introduced to get the task_struct definition in the pkeys
+ * headers.
+ */
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+DECLARE_PER_CPU(u32, pkrs_cache);
+static inline void pks_init_task(struct task_struct *tsk)
+{
+	/* New tasks get the most restrictive PKRS value */
+	tsk->thread.saved_pkrs = INIT_PKRS_VALUE;
+}
+static inline void pks_sched_in(void)
+{
+	u64 current_pkrs = current->thread.saved_pkrs;
+
+	/* Only update the MSR when current's pkrs is different from the MSR. */
+	if (this_cpu_read(pkrs_cache) == current_pkrs)
+		return;
+
+	write_pkrs(current_pkrs);
+}
+#else
+static inline void pks_init_task(struct task_struct *tsk) { }
+static inline void pks_sched_in(void) { }
+#endif
+
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
@@ -192,6 +223,8 @@ void flush_thread(void)
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
 	fpu__clear_all(&tsk->thread.fpu);
+
+	pks_init_task(tsk);
 }
 
 void disable_TSC(void)
@@ -655,6 +688,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 
 	if ((tifp ^ tifn) & _TIF_SLD)
 		switch_to_sld(tifn);
+
+	pks_sched_in();
 }
 
 /*
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index a5c680d32930..0f86f2374bd7 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -236,3 +236,16 @@ u32 get_new_pkr(u32 old_pkr, int pkey, unsigned long init_val)
 	/* Return the old part along with the new part: */
 	return old_pkr | new_pkr_bits;
 }
+
+DEFINE_PER_CPU(u32, pkrs_cache);
+
+/*
+ * Write the PKey Register Supervisor.  This must be run with preemption
+ * disabled as it does not guarantee the atomicity of updating the pkrs_cache
+ * and MSR on its own.
+ */
+void write_pkrs(u32 pkrs_val)
+{
+	this_cpu_write(pkrs_cache, pkrs_val);
+	wrmsrl(MSR_IA32_PKRS, pkrs_val);
+}
-- 
2.28.0.rc0.12.gb6a658bd00c9

