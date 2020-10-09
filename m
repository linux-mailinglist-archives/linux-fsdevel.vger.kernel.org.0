Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64586289200
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 21:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390766AbgJITnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 15:43:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:39856 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390754AbgJITnP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 15:43:15 -0400
IronPort-SDR: AIsl6nEidCker+zzDuN//w3pYCDJ75nlExpbTzYBQZPDGCip29a1CKBTiT9UwsR/F+7I9pHg4/
 YCt8Ur8r5xIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="162067170"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="162067170"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:43:14 -0700
IronPort-SDR: Bmxu3eOmFc0uMWdOYbGyxDst27ek460QQaA0jACDAJb/72j7sCwXxdbb3Cq/ClpAgeJlqRV77v
 yAfycEpcJEhg==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="317145592"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:43:13 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH RFC V3 3/9] x86/pks: Enable Protection Keys Supervisor (PKS)
Date:   Fri,  9 Oct 2020 12:42:52 -0700
Message-Id: <20201009194258.3207172-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201009194258.3207172-1-ira.weiny@intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Protection Keys for Supervisor pages (PKS) enables fast, hardware thread
specific, manipulation of permission restrictions on supervisor page
mappings.  It uses the same mechanism of Protection Keys as those on
User mappings but applies that mechanism to supervisor mappings using a
supervisor specific MSR.

Kernel users can thus defines 'domains' of page mappings which have an
extra level of protection beyond those specified in the supervisor page
table entries.

Define ARCH_HAS_SUPERVISOR_PKEYS to distinguish this functionality from
the existing ARCH_HAS_PKEYS and then enable PKS when configured and
indicated by the CPU instance.  While not strictly necessary in this
patch, ARCH_HAS_SUPERVISOR_PKEYS separates this functionality through
the patch series so it is introduced here.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/Kconfig                            |  1 +
 arch/x86/include/asm/cpufeatures.h          |  1 +
 arch/x86/include/uapi/asm/processor-flags.h |  2 ++
 arch/x86/kernel/cpu/common.c                | 15 +++++++++++++++
 mm/Kconfig                                  |  2 ++
 5 files changed, 21 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac64bb20..1bfb912342a3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1873,6 +1873,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
+	select ARCH_HAS_SUPERVISOR_PKEYS
 	help
 	  Memory Protection Keys provides a mechanism for enforcing
 	  page-based protections, but without requiring modification of the
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 2901d5df4366..7646b03fc3f4 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -353,6 +353,7 @@
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
+#define X86_FEATURE_PKS			(16*32+31) /* Protection Keys for Supervisor pages */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index bcba3c643e63..191c574b2390 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -130,6 +130,8 @@
 #define X86_CR4_SMAP		_BITUL(X86_CR4_SMAP_BIT)
 #define X86_CR4_PKE_BIT		22 /* enable Protection Keys support */
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
+#define X86_CR4_PKS_BIT		24 /* enable Protection Keys for Supervisor */
+#define X86_CR4_PKS		_BITUL(X86_CR4_PKS_BIT)
 
 /*
  * x86-64 Task Priority Register, CR8
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c5d6f17d9b9d..a129d5e4afab 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1447,6 +1447,20 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 #endif
 }
 
+/*
+ * PKS is independent of PKU and either or both may be supported on a CPU.
+ * Configure PKS if the cpu supports the feature.
+ */
+static void setup_pks(void)
+{
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_SUPERVISOR_PKEYS))
+		return;
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	cr4_set_bits(X86_CR4_PKS);
+}
+
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
@@ -1544,6 +1558,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	x86_init_rdrand(c);
 	setup_pku(c);
+	setup_pks();
 
 	/*
 	 * Clear/Set all flags overridden by options, need do it
diff --git a/mm/Kconfig b/mm/Kconfig
index 6c974888f86f..1b9bc004d9bc 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -822,6 +822,8 @@ config ARCH_USES_HIGH_VMA_FLAGS
 	bool
 config ARCH_HAS_PKEYS
 	bool
+config ARCH_HAS_SUPERVISOR_PKEYS
+	bool
 
 config PERCPU_STATS
 	bool "Collect percpu memory statistics"
-- 
2.28.0.rc0.12.gb6a658bd00c9

