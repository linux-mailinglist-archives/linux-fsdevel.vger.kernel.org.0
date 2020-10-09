Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89847289212
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 21:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403802AbgJITn2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 15:43:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:42712 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403771AbgJITnU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 15:43:20 -0400
IronPort-SDR: xCN4lmGxohXITFGjHslj2U58MIRBIHhgYZ5cKZn64N7lDpYz6ow0NJZFRyTL4K6aaZRnqR/F3I
 AM3o14tl7rYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="162892651"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="162892651"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:43:19 -0700
IronPort-SDR: ioOUcujqdf9W3f9A6sGS1TlnTSiA9NRqPzQ0YBRPZvGczCu2a0fYpeabI4AK0/JIc1oFhf9b/o
 v0j54S4+A2ow==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="518798290"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:43:18 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH RFC V3 5/9] x86/pks: Add PKS kernel API
Date:   Fri,  9 Oct 2020 12:42:54 -0700
Message-Id: <20201009194258.3207172-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201009194258.3207172-1-ira.weiny@intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

PKS allows kernel users to define domains of page mappings which have
additional protections beyond the paging protections.

Add an API to allocate, use, and free a protection key which identifies
such a domain.  Export 5 new symbols pks_key_alloc(), pks_mknoaccess(),
pks_mkread(), pks_mkrdwr(), and pks_key_free().  Add 2 new macros;
PAGE_KERNEL_PKEY(key) and _PAGE_PKEY(pkey).

Update the protection key documentation to cover pkeys on supervisor
pages.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 Documentation/core-api/protection-keys.rst | 101 ++++++++++++++---
 arch/x86/include/asm/pgtable_types.h       |  12 ++
 arch/x86/include/asm/pkeys.h               |  11 ++
 arch/x86/include/asm/pkeys_common.h        |   4 +
 arch/x86/mm/pkeys.c                        | 125 +++++++++++++++++++++
 include/linux/pgtable.h                    |   4 +
 include/linux/pkeys.h                      |  22 ++++
 7 files changed, 261 insertions(+), 18 deletions(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index ec575e72d0b2..00a046a913e4 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -4,25 +4,33 @@
 Memory Protection Keys
 ======================
 
-Memory Protection Keys for Userspace (PKU aka PKEYs) is a feature
-which is found on Intel's Skylake (and later) "Scalable Processor"
-Server CPUs. It will be available in future non-server Intel parts
-and future AMD processors.
-
-For anyone wishing to test or use this feature, it is available in
-Amazon's EC2 C5 instances and is known to work there using an Ubuntu
-17.04 image.
-
 Memory Protection Keys provides a mechanism for enforcing page-based
 protections, but without requiring modification of the page tables
-when an application changes protection domains.  It works by
-dedicating 4 previously ignored bits in each page table entry to a
-"protection key", giving 16 possible keys.
+when an application changes protection domains.
+
+PKeys Userspace (PKU) is a feature which is found on Intel's Skylake "Scalable
+Processor" Server CPUs and later.  And It will be available in future
+non-server Intel parts and future AMD processors.
+
+Future Intel processors will support Protection Keys for Supervisor pages
+(PKS).
+
+For anyone wishing to test or use user space pkeys, it is available in Amazon's
+EC2 C5 instances and is known to work there using an Ubuntu 17.04 image.
+
+pkeys work by dedicating 4 previously Reserved bits in each page table entry to
+a "protection key", giving 16 possible keys.  User and Supervisor pages are
+treated separately.
+
+Protections for each page are controlled with per CPU registers for each type
+of page User and Supervisor.  Each of these 32 bit register stores two separate
+bits (Access Disable and Write Disable) for each key.
 
-There is also a new user-accessible register (PKRU) with two separate
-bits (Access Disable and Write Disable) for each key.  Being a CPU
-register, PKRU is inherently thread-local, potentially giving each
-thread a different set of protections from every other thread.
+For Userspace the register is user-accessible (rdpkru/wrpkru).  For
+Supervisor, the register (MSR_IA32_PKRS) is accessible only to the kernel.
+
+Being a CPU register, pkeys are inherently thread-local, potentially giving
+each thread an independent set of protections from every other thread.
 
 There are two new instructions (RDPKRU/WRPKRU) for reading and writing
 to the new register.  The feature is only available in 64-bit mode,
@@ -30,8 +38,11 @@ even though there is theoretically space in the PAE PTEs.  These
 permissions are enforced on data access only and have no effect on
 instruction fetches.
 
-Syscalls
-========
+For kernel space rdmsr/wrmsr are used to access the kernel MSRs.
+
+
+Syscalls for user space keys
+============================
 
 There are 3 system calls which directly interact with pkeys::
 
@@ -98,3 +109,57 @@ with a read()::
 The kernel will send a SIGSEGV in both cases, but si_code will be set
 to SEGV_PKERR when violating protection keys versus SEGV_ACCERR when
 the plain mprotect() permissions are violated.
+
+
+Kernel API for PKS support
+==========================
+
+The following interface is used to allocate, use, and free a pkey which defines
+a 'protection domain' within the kernel.  Setting a pkey value in a supervisor
+mapping adds that mapping to the protection domain.
+
+        int pks_key_alloc(const char * const pkey_user);
+        #define PAGE_KERNEL_PKEY(pkey)
+        #define _PAGE_KEY(pkey)
+        void pks_mknoaccess(int pkey);
+        void pks_mkread(int pkey);
+        void pks_mkrdwr(int pkey);
+        void pks_key_free(int pkey);
+
+pks_key_alloc() allocates keys dynamically to allow better use of the limited
+key space.
+
+Callers of pks_key_alloc() _must_ be prepared for it to fail and take
+appropriate action.  This is due mainly to the fact that PKS may not be
+available on all arch's.  Failure to check the return of pks_key_alloc() and
+using any of the rest of the API is undefined.
+
+Kernel users must set the PTE permissions in the page table entries for the
+mappings they want to protect.  This can be done with PAGE_KERNEL_PKEY() or
+_PAGE_KEY().
+
+The pks_mk*() family of calls allows kernel users the ability to change the
+protections for the domain identified by the pkey specified.  3 states are
+available pks_mknoaccess(), pks_mkread(), and pks_mkrdwr() which set the access
+to none, read, and read/write respectively.
+
+Finally, pks_key_free() allows a user to return the key to the allocator for
+use by others.
+
+The interface maintains pks_mknoaccess() (Access Disabled (AD=1)) for all keys
+not currently allocated.  Therefore, the user can depend on access being
+disabled when pks_key_alloc() returns a key and the user should remove mappings
+from the domain (remove the pkey from the PTE) prior to calling pks_key_free().
+
+It should be noted that the underlying WRMSR(MSR_IA32_PKRS) is not serializing
+but still maintains ordering properties similar to WRPKRU.  Thus it is safe to
+immediately use a mapping when the pks_mk*() functions returns.
+
+The current SDM section on PKRS needs updating but should be the same as that
+of WRPKRU.  So to quote from the WRPKRU text:
+
+	WRPKRU will never execute transiently. Memory accesses
+	affected by PKRU register will not execute (even transiently)
+	until all prior executions of WRPKRU have completed execution
+	and updated the PKRU register.
+
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 816b31c68550..c9fdfbdcbbfb 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -73,6 +73,12 @@
 			 _PAGE_PKEY_BIT2 | \
 			 _PAGE_PKEY_BIT3)
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+#define _PAGE_PKEY(pkey)	(_AT(pteval_t, pkey) << _PAGE_BIT_PKEY_BIT0)
+#else
+#define _PAGE_PKEY(pkey)	(_AT(pteval_t, 0))
+#endif
+
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 #define _PAGE_KNL_ERRATUM_MASK (_PAGE_DIRTY | _PAGE_ACCESSED)
 #else
@@ -229,6 +235,12 @@ enum page_cache_mode {
 #define PAGE_KERNEL_IO		__pgprot_mask(__PAGE_KERNEL_IO)
 #define PAGE_KERNEL_IO_NOCACHE	__pgprot_mask(__PAGE_KERNEL_IO_NOCACHE)
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+#define PAGE_KERNEL_PKEY(pkey)	__pgprot_mask(__PAGE_KERNEL | _PAGE_PKEY(pkey))
+#else
+#define PAGE_KERNEL_PKEY(pkey) PAGE_KERNEL
+#endif
+
 #endif	/* __ASSEMBLY__ */
 
 /*         xwr */
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 4526245b03e5..79952216474e 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_PKEYS_H
 
 #include <asm/pkeys_common.h>
+#include <asm-generic/mman-common.h>
 
 #define ARCH_DEFAULT_PKEY	0
 
@@ -138,4 +139,14 @@ static inline int vma_pkey(struct vm_area_struct *vma)
 
 u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags);
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+int pks_key_alloc(const char *const pkey_user);
+void pks_key_free(int pkey);
+
+void pks_mknoaccess(int pkey);
+void pks_mkread(int pkey);
+void pks_mkrdwr(int pkey);
+
+#endif /* CONFIG_ARCH_HAS_SUPERVISOR_PKEYS */
+
 #endif /*_ASM_X86_PKEYS_H */
diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
index 05781be33c14..40464c170522 100644
--- a/arch/x86/include/asm/pkeys_common.h
+++ b/arch/x86/include/asm/pkeys_common.h
@@ -22,6 +22,10 @@
 			 PKR_AD_KEY(10) | PKR_AD_KEY(11) | PKR_AD_KEY(12) | \
 			 PKR_AD_KEY(13) | PKR_AD_KEY(14) | PKR_AD_KEY(15))
 
+/*  PKS supports 16 keys. Key 0 is reserved for the kernel. */
+#define        PKS_KERN_DEFAULT_KEY    0
+#define        PKS_NUM_KEYS            16
+
 #ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
 void write_pkrs(u32 new_pkrs);
 #else
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 30f65dd3d0c5..1d9f451b4b78 100644
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
@@ -229,6 +232,7 @@ u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
 
 	return pk_reg;
 }
+EXPORT_SYMBOL_GPL(update_pkey_val);
 
 DEFINE_PER_CPU(u32, pkrs_cache);
 
@@ -257,3 +261,124 @@ void write_pkrs(u32 new_pkrs)
 	}
 	put_cpu_ptr(pkrs);
 }
+EXPORT_SYMBOL_GPL(write_pkrs);
+
+/**
+ * Do not call this directly, see pks_mk*() below.
+ *
+ * @pkey: Key for the domain to change
+ * @protection: protection bits to be used
+ *
+ * Protection utilizes the same protection bits specified for User pkeys
+ *     PKEY_DISABLE_ACCESS
+ *     PKEY_DISABLE_WRITE
+ *
+ */
+static inline void pks_update_protection(int pkey, unsigned long protection)
+{
+	current->thread.saved_pkrs = update_pkey_val(current->thread.saved_pkrs,
+						     pkey, protection);
+	preempt_disable();
+	write_pkrs(current->thread.saved_pkrs);
+	preempt_enable();
+}
+
+/**
+ * PKS access control functions
+ *
+ * Change the access of the domain specified by the pkey.  These are global
+ * updates.  They only affects the current running thread.  It is undefined and
+ * a bug for users to call this without having allocated a pkey and using it as
+ * pkey here.
+ *
+ * pks_mknoaccess()
+ *     Disable all access to the domain
+ * pks_mkread()
+ *     Make the domain Read only
+ * pks_mkrdwr()
+ *     Make the domain Read/Write
+ *
+ * @pkey the pkey for which the access should change.
+ *
+ */
+void pks_mknoaccess(int pkey)
+{
+	pks_update_protection(pkey, PKEY_DISABLE_ACCESS);
+}
+EXPORT_SYMBOL_GPL(pks_mknoaccess);
+
+void pks_mkread(int pkey)
+{
+	pks_update_protection(pkey, PKEY_DISABLE_WRITE);
+}
+EXPORT_SYMBOL_GPL(pks_mkread);
+
+void pks_mkrdwr(int pkey)
+{
+	pks_update_protection(pkey, 0);
+}
+EXPORT_SYMBOL_GPL(pks_mkrdwr);
+
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
+	int nr;
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return -EINVAL;
+
+	while (1) {
+		nr = find_first_zero_bit(&pks_key_allocation_map, PKS_NUM_KEYS);
+		if (nr >= PKS_NUM_KEYS) {
+			pr_info("Cannot allocate supervisor key for %s.\n",
+				pkey_user);
+			return -ENOSPC;
+		}
+		if (!test_and_set_bit_lock(nr, &pks_key_allocation_map))
+			break;
+	}
+
+	/* for debugging key exhaustion */
+	pks_key_users[nr] = pkey_user;
+
+	return nr;
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
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	if (pkey >= PKS_NUM_KEYS || pkey <= PKS_KERN_DEFAULT_KEY)
+		return;
+
+	/* Restore to default of no access */
+	pks_mknoaccess(pkey);
+	pks_key_users[pkey] = NULL;
+	__clear_bit(pkey, &pks_key_allocation_map);
+}
+EXPORT_SYMBOL_GPL(pks_key_free);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 90654cb63e9e..6900182d53ee 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1374,6 +1374,10 @@ static inline bool arch_has_pfn_modify_check(void)
 # define PAGE_KERNEL_EXEC PAGE_KERNEL
 #endif
 
+#ifndef PAGE_KERNEL_PKEY
+#define PAGE_KERNEL_PKEY(pkey) PAGE_KERNEL
+#endif
+
 /*
  * Page Table Modification bits for pgtbl_mod_mask.
  *
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 2955ba976048..cc3510cde64e 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -50,4 +50,26 @@ static inline void copy_init_pkru_to_fpregs(void)
 
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
+#ifndef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+static inline int pks_key_alloc(const char * const pkey_user)
+{
+	return -EINVAL;
+}
+static inline void pks_key_free(int pkey)
+{
+}
+static inline void pks_mknoaccess(int pkey)
+{
+	WARN_ON_ONCE(1);
+}
+static inline void pks_mkread(int pkey)
+{
+	WARN_ON_ONCE(1);
+}
+static inline void pks_mkrdwr(int pkey)
+{
+	WARN_ON_ONCE(1);
+}
+#endif /* ! CONFIG_ARCH_HAS_SUPERVISOR_PKEYS */
+
 #endif /* _LINUX_PKEYS_H */
-- 
2.28.0.rc0.12.gb6a658bd00c9

