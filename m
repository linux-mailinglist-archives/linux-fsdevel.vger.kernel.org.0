Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A754A223585
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 09:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgGQHVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 03:21:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:43785 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbgGQHVI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:21:08 -0400
IronPort-SDR: zHh1j819bUVCIU5cBFagKdnAsDC+WdOsx1FHaPHhBCA/ErujY2+EuU6KJubelVYdRYB51XhNfO
 Py5Av/wZd2KQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="214268929"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="214268929"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:03 -0700
IronPort-SDR: YuI06+zcQTmtYh2FhfRWS0zFPlu++X6tf+pbLZ6KHWdJSf9+QDz6KRcknyroF05uy/NVCkDi73
 CtVQWNKmYc0Q==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="317271922"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:02 -0700
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
Subject: [PATCH RFC V2 05/17] x86/pks: Add PKS kernel API
Date:   Fri, 17 Jul 2020 00:20:44 -0700
Message-Id: <20200717072056.73134-6-ira.weiny@intel.com>
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

PKS allows kernel users to define domains of page mappings which have
additional protections beyond the paging protections.

Add an API to allocate, use, and free a protection key which identifies
such a domain.

We export 2 new symbols pks_key_alloc() and pks_key_free() while
pks_update_protection() is exposed as an inline function via header
file.

pks_key_alloc() reserves pkey 0 for default kernel pages.  The other 15
keys are dynamically allocated to allow better use of the limited key
space.

This, and the fact that PKS may not be available on all arch's, means
callers of the allocator _must_ be prepared for it to fail and take
appropriate action to run without their allocated domain.  This is not
anticipated to be a problem as these protections only serve to harden
memory and users should be no worse off than before the introduction of
PKS.

PAGE_KERNEL_PKEY(key) and _PAGE_PKEY(pkey) aid in setting page table
entry bits by kernel users.  Note these defines will be used in follow
on patches but are included here for a complete interface.

pks_update_protection() is inlined for performance and allows kernel
users the ability to change the protections for the domain identified by
the pkey specified.  It is undefined behavior to call this on a pkey not
allocated by the allocator.  And will WARN_ON if called on architectures
which do not support PKS.  (Again callers are expected to check the
return of pks_key_alloc() before using this API further.)

It should also be noted that the underlying WRMSR(MSR_IA32_PKRS) is not
serializing but still maintains ordering properties similar to WRPKRU.
The current SDM section on PKRS needs updating but should be the same as
that of WRPKRU.  So to quote from the WRPKRU text:

	WRPKRU will never execute speculatively. Memory accesses
	affected by PKRU register will not execute (even speculatively)
	until all prior executions of WRPKRU have completed execution
	and updated the PKRU register.

Finally, pks_key_free() allows a user to return the key to the
allocator for use by others.

The interface maintains Access Disabled (AD=1) for all keys not
currently allocated.  Therefore, the user can depend on access being
disabled when pks_key_alloc() returns a key.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/pgtable_types.h  |  4 ++
 arch/x86/include/asm/pkeys.h          | 30 ++++++++++
 arch/x86/include/asm/pkeys_internal.h |  4 ++
 arch/x86/mm/pkeys.c                   | 79 +++++++++++++++++++++++++++
 include/linux/pkeys.h                 | 14 +++++
 5 files changed, 131 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 816b31c68550..2ab45ef89c7d 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -73,6 +73,8 @@
 			 _PAGE_PKEY_BIT2 | \
 			 _PAGE_PKEY_BIT3)
 
+#define _PAGE_PKEY(pkey)	(_AT(pteval_t, pkey) << _PAGE_BIT_PKEY_BIT0)
+
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 #define _PAGE_KNL_ERRATUM_MASK (_PAGE_DIRTY | _PAGE_ACCESSED)
 #else
@@ -229,6 +231,8 @@ enum page_cache_mode {
 #define PAGE_KERNEL_IO		__pgprot_mask(__PAGE_KERNEL_IO)
 #define PAGE_KERNEL_IO_NOCACHE	__pgprot_mask(__PAGE_KERNEL_IO_NOCACHE)
 
+#define PAGE_KERNEL_PKEY(pkey)	__pgprot_mask(__PAGE_KERNEL | _PAGE_PKEY(pkey))
+
 #endif	/* __ASSEMBLY__ */
 
 /*         xwr */
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 34cef29fed20..e30ea907abb6 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -138,4 +138,34 @@ static inline int vma_pkey(struct vm_area_struct *vma)
 
 u32 get_new_pkr(u32 old_pkr, int pkey, unsigned long init_val);
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+int pks_key_alloc(const char *const pkey_user);
+void pks_key_free(int pkey);
+u32 get_new_pkr(u32 old_pkr, int pkey, unsigned long init_val);
+
+/*
+ * pks_update_protection - Update the protection of the specified key
+ *
+ * @pkey: Key for the domain to change
+ * @protection: protection bits to be used
+ *
+ * Protection utilizes the same protection bits specified for User pkeys
+ *     PKEY_DISABLE_ACCESS
+ *     PKEY_DISABLE_WRITE
+ *
+ * This is not a global update.  It only affects the current running thread.
+ *
+ * It is undefined and a bug for users to call this without having allocated a
+ * pkey and using it as pkey here.
+ */
+static inline void pks_update_protection(int pkey, unsigned long protection)
+{
+	current->thread.saved_pkrs = get_new_pkr(current->thread.saved_pkrs,
+						 pkey, protection);
+	preempt_disable();
+	write_pkrs(current->thread.saved_pkrs);
+	preempt_enable();
+}
+#endif /* CONFIG_ARCH_HAS_SUPERVISOR_PKEYS */
+
 #endif /*_ASM_X86_PKEYS_H */
diff --git a/arch/x86/include/asm/pkeys_internal.h b/arch/x86/include/asm/pkeys_internal.h
index 05257cdc7200..e34f380c66d1 100644
--- a/arch/x86/include/asm/pkeys_internal.h
+++ b/arch/x86/include/asm/pkeys_internal.h
@@ -22,6 +22,10 @@
 			 PKR_AD_KEY(10) | PKR_AD_KEY(11) | PKR_AD_KEY(12) | \
 			 PKR_AD_KEY(13) | PKR_AD_KEY(14) | PKR_AD_KEY(15))
 
+/*  PKS supports 16 keys. Key 0 is reserved for the kernel. */
+#define        PKS_KERN_DEFAULT_KEY    0
+#define        PKS_NUM_KEYS            16
+
 #ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
 void write_pkrs(u32 pkrs_val);
 #else
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 0f86f2374bd7..16f735c12fcd 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -3,6 +3,9 @@
  * Intel Memory Protection Keys management
  * Copyright (c) 2015, Intel Corporation.
  */
+#undef pr_fmt
+#define pr_fmt(fmt) "x86/pkeys: " fmt
+
 #include <linux/debugfs.h>		/* debugfs_create_u32()		*/
 #include <linux/mm_types.h>             /* mm_struct, vma, etc...       */
 #include <linux/pkeys.h>                /* PKEY_*                       */
@@ -249,3 +252,79 @@ void write_pkrs(u32 pkrs_val)
 	this_cpu_write(pkrs_cache, pkrs_val);
 	wrmsrl(MSR_IA32_PKRS, pkrs_val);
 }
+
+DEFINE_MUTEX(pks_lock);
+static const char pks_key_user0[] = "kernel";
+
+/* Store names of allocated keys for debug.  Key 0 is reserved for the kernel.  */
+static const char *pks_key_users[PKS_NUM_KEYS] = {
+	pks_key_user0
+};
+
+/*
+ * Each key is represented by a bit.  Bit 0 is set for key 0 and reserved for
+ * its use.  We use ulong for the bit operations but only 16 bits are used.
+ */
+static unsigned long pks_key_allocation_map = 1 << PKS_KERN_DEFAULT_KEY;
+
+/*
+ * pks_key_alloc - Allocate a PKS key
+ *
+ * @pkey_user: String stored for debugging of key exhaustion.  The caller is
+ * responsible to maintain this memory until pks_key_free().
+ */
+int pks_key_alloc(const char * const pkey_user)
+{
+	int nr, old_bit, pkey;
+
+	might_sleep();
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return -EINVAL;
+
+	mutex_lock(&pks_lock);
+	/* Find a free bit (0) in the bit map. */
+	old_bit = 1;
+	while (old_bit) {
+		nr = ffz(pks_key_allocation_map);
+		old_bit = __test_and_set_bit(nr, &pks_key_allocation_map);
+	}
+
+	if (nr < PKS_NUM_KEYS) {
+		pkey = nr;
+		/* for debugging key exhaustion */
+		pks_key_users[pkey] = pkey_user;
+	} else {
+		pkey = -ENOSPC;
+		pr_info("Cannot allocate supervisor key for %s.\n",
+			pkey_user);
+	}
+
+	mutex_unlock(&pks_lock);
+	return pkey;
+}
+EXPORT_SYMBOL_GPL(pks_key_alloc);
+
+/*
+ * pks_key_free - Free a previously allocate PKS key
+ *
+ * @pkey: Key to be free'ed
+ */
+void pks_key_free(int pkey)
+{
+	might_sleep();
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	if (pkey >= PKS_NUM_KEYS || pkey <= PKS_KERN_DEFAULT_KEY)
+		return;
+
+	mutex_lock(&pks_lock);
+	__clear_bit(pkey, &pks_key_allocation_map);
+	pks_key_users[pkey] = NULL;
+	/* Restore to default AD=1 and WD=0. */
+	pks_update_protection(pkey, PKEY_DISABLE_ACCESS);
+	mutex_unlock(&pks_lock);
+}
+EXPORT_SYMBOL_GPL(pks_key_free);
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 2955ba976048..e4bff77d7b49 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -50,4 +50,18 @@ static inline void copy_init_pkru_to_fpregs(void)
 
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
+#ifndef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+static inline int pks_key_alloc(const char * const pkey_user)
+{
+	return -EINVAL;
+}
+static inline void pks_key_free(int pkey)
+{
+}
+static inline void pks_update_protection(int pkey, unsigned long protection)
+{
+	WARN_ON_ONCE(1);
+}
+#endif /* ! CONFIG_ARCH_HAS_SUPERVISOR_PKEYS */
+
 #endif /* _LINUX_PKEYS_H */
-- 
2.28.0.rc0.12.gb6a658bd00c9

