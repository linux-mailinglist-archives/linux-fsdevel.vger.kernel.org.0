Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E942235A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 09:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgGQHWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 03:22:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:48157 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgGQHVF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:21:05 -0400
IronPort-SDR: euGBuBzK4eGB63eW/2jMZlalPhL7JtIT/9aB72lXmqcgG4zvZRNnbulICoxnrpytsAz1ZP09zc
 AGoXh651vtqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129111928"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="129111928"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:03 -0700
IronPort-SDR: 8i/TZE8qfmw3EhMgZhG/RVSFnd+u3sPC5jkD2v98KRJWRdSZ/qmdi+GKnE2LirhYp+nvpHB/Ax
 DUj5ubNB3hxw==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="300484565"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:01 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH RFC V2 02/17] x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
Date:   Fri, 17 Jul 2020 00:20:41 -0700
Message-Id: <20200717072056.73134-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20200717072056.73134-1-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Define a helper, get_new_pkr(), which will be used to support both
Protection Key User (PKU) and the new Protection Key for Supervisor
(PKS) in subsequent patches.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/pkeys.h |  2 ++
 arch/x86/kernel/fpu/xstate.c | 17 +++--------------
 arch/x86/mm/pkeys.c          | 28 ++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index be8b3e448f76..34cef29fed20 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -136,4 +136,6 @@ static inline int vma_pkey(struct vm_area_struct *vma)
 	return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
 }
 
+u32 get_new_pkr(u32 old_pkr, int pkey, unsigned long init_val);
+
 #endif /*_ASM_X86_PKEYS_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index fc1ec2986e03..1def71dc8105 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -954,9 +954,7 @@ const void *get_xsave_field_ptr(int xfeature_nr)
 int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val)
 {
-	u32 old_pkru;
-	int pkey_shift = (pkey * PKR_BITS_PER_PKEY);
-	u32 new_pkru_bits = 0;
+	u32 old_pkru, new_pkru;
 
 	/*
 	 * This check implies XSAVE support.  OSPKE only gets
@@ -972,21 +970,12 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	 */
 	WARN_ON_ONCE(pkey >= arch_max_pkey());
 
-	/* Set the bits we need in PKRU:  */
-	if (init_val & PKEY_DISABLE_ACCESS)
-		new_pkru_bits |= PKR_AD_BIT;
-	if (init_val & PKEY_DISABLE_WRITE)
-		new_pkru_bits |= PKR_WD_BIT;
-
-	/* Shift the bits in to the correct place in PKRU for pkey: */
-	new_pkru_bits <<= pkey_shift;
-
 	/* Get old PKRU and mask off any old bits in place: */
 	old_pkru = read_pkru();
-	old_pkru &= ~((PKR_AD_BIT|PKR_WD_BIT) << pkey_shift);
+	new_pkru = get_new_pkr(old_pkru, pkey, init_val);
 
 	/* Write old part along with new part: */
-	write_pkru(old_pkru | new_pkru_bits);
+	write_pkru(new_pkru);
 
 	return 0;
 }
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index f5efb4007e74..a5c680d32930 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -208,3 +208,31 @@ static __init int setup_init_pkru(char *opt)
 	return 1;
 }
 __setup("init_pkru=", setup_init_pkru);
+
+/*
+ * Get a new pkey register value from the user values specified.
+ *
+ * Kernel users use the same flags as user space:
+ *     PKEY_DISABLE_ACCESS
+ *     PKEY_DISABLE_WRITE
+ */
+u32 get_new_pkr(u32 old_pkr, int pkey, unsigned long init_val)
+{
+	int pkey_shift = (pkey * PKR_BITS_PER_PKEY);
+	u32 new_pkr_bits = 0;
+
+	/* Set the bits we need in the register:  */
+	if (init_val & PKEY_DISABLE_ACCESS)
+		new_pkr_bits |= PKR_AD_BIT;
+	if (init_val & PKEY_DISABLE_WRITE)
+		new_pkr_bits |= PKR_WD_BIT;
+
+	/* Shift the bits in to the correct place: */
+	new_pkr_bits <<= pkey_shift;
+
+	/* Mask off any old bits in place: */
+	old_pkr &= ~((PKR_AD_BIT | PKR_WD_BIT) << pkey_shift);
+
+	/* Return the old part along with the new part: */
+	return old_pkr | new_pkr_bits;
+}
-- 
2.28.0.rc0.12.gb6a658bd00c9

