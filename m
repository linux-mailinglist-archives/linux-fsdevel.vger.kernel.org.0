Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5440223580
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 09:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgGQHVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 03:21:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:43785 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbgGQHVK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:21:10 -0400
IronPort-SDR: mpCI5GwvWZvuhxZTBf/E+PskpFzSiIYegx8jPnlZ0jWozbzhGsY3wgYPWcUGW8NAAXtldnpw8/
 /fOAI44uECkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="214268945"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="214268945"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:08 -0700
IronPort-SDR: L5N41W1IZMYqtEO0G+MmXEdL7gPoNKH9/M9p+sSFdda5Nsq8X33DPhrp/daPHnsytrbgemyQNn
 zPgSpidsfJCg==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="308927483"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:07 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH RFC V2 12/17] memremap: Add zone device access protection
Date:   Fri, 17 Jul 2020 00:20:51 -0700
Message-Id: <20200717072056.73134-13-ira.weiny@intel.com>
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

Device managed memory exposes itself to the kernel direct map which
allows stray pointers to access these device memories.

Stray pointers to normal memory may result in a crash or other
undesirable behavior which, while unfortunate, are usually recoverable
with a reboot.  Stray writes to areas such as non-volatile memory are
permanent in nature and thus are more likely to result in permanent user
data loss vs a stray write to other memory areas

Set up an infrastructure for extra device access protection. Then
implement the new protection using the new Protection Keys Supervisor
(PKS) on architectures which support it.

To enable this extra protection devices specify a flag in the pgmap to
indicate that these areas wish to use additional protection.

Kernel code which intends to access this memory can do so automatically
through the use of the kmap infrastructure calling into
dev_access_[enable|disable]() described here.  The kmap infrastructure
is implemented in a follow on patch.

In addition, users can directly enable/disable the access through
dev_access_[enable|disable]() if they have a priori knowledge of the
type of pages they are accessing.

All calls to enable/disable protection flow through
dev_access_[enable|disable]() and are nestable by the use of a per task
reference count.  This reference count does 2 things.

1) Allows a thread to nest calls to disable protection such that the
   first call to re-enable protection does not 'break' the last access of
   the pmem device memory.

2) Provides faster performance by avoiding lots of MSR writes.  For
   example, looping over a sequence of pmem pages.

IRQ context borrows the reference count of the interrupted task.  This
is a trade off vs saving/restoring on interrupt entry/exit.  The
following example shows how this works:

...
	// ref == 0
        dev_access_enable()  // ref += 1 ==> disable protection
                irq()
                        dev_access_enable()   // ref += 1 ==> 2
                        dev_access_disable()  // ref -= 1 ==> 1
        do_pmem_thing()  // all good here
        dev_access_disable() // ref -= 1 ==> 0 ==> enable protection
...

While this does leave some openings for stray writes during irq's the
over all protection is much stronger after this patch and implementing
save/restore during irq's would have been a much more complicated
implementation.  So we compromise.

The pkey value is never free'ed as this too optimizes the implementation
to be either on or off using the static branch conditional in the fast
paths.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/memremap.h |  1 +
 include/linux/mm.h       | 33 ++++++++++++++
 include/linux/sched.h    |  3 ++
 init/init_task.c         |  3 ++
 kernel/fork.c            |  3 ++
 mm/Kconfig               | 13 ++++++
 mm/memremap.c            | 98 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 154 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 5f5b2df06e61..87a9772b1aa7 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -90,6 +90,7 @@ struct dev_pagemap_ops {
 };
 
 #define PGMAP_ALTMAP_VALID	(1 << 0)
+#define PGMAP_PROT_ENABLED	(1 << 1)
 
 /**
  * struct dev_pagemap - metadata for ZONE_DEVICE mappings
diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc7b87310c10..99d0914e26f9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1123,6 +1123,39 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
 }
 
+#ifdef CONFIG_ZONE_DEVICE_ACCESS_PROTECTION
+DECLARE_STATIC_KEY_FALSE(dev_protection_static_key);
+
+/*
+ * We make page_is_access_protected() as quick as possible.
+ *    1) If no mappings have been enabled with extra protection we skip this
+ *       entirely
+ *    2) Skip pages which are not ZONE_DEVICE
+ *    3) Only then check if this particular page was mapped with extra
+ *       protections.
+ */
+static inline bool page_is_access_protected(struct page *page)
+{
+	if (!static_branch_unlikely(&dev_protection_static_key))
+		return false;
+	if (!is_zone_device_page(page))
+		return false;
+	if (page->pgmap->flags & PGMAP_PROT_ENABLED)
+		return true;
+	return false;
+}
+
+void dev_access_enable(void);
+void dev_access_disable(void);
+#else
+static inline bool page_is_access_protected(struct page *page)
+{
+	return false;
+}
+static inline void dev_access_enable(void) { }
+static inline void dev_access_disable(void) { }
+#endif /* CONFIG_ZONE_DEVICE_ACCESS_PROTECTION */
+
 /* 127: arbitrary random number, small enough to assemble well */
 #define page_ref_zero_or_close_to_overflow(page) \
 	((unsigned int) page_ref_count(page) + 127u <= 127u)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 692e327d7455..2a8dbbb371ee 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1313,6 +1313,9 @@ struct task_struct {
 	struct callback_head		mce_kill_me;
 #endif
 
+#ifdef CONFIG_ZONE_DEVICE_ACCESS_PROTECTION
+	unsigned int			dev_page_access_ref;
+#endif
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/init/init_task.c b/init/init_task.c
index 15089d15010a..17766b059606 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -204,6 +204,9 @@ struct task_struct init_task
 #ifdef CONFIG_SECURITY
 	.security	= NULL,
 #endif
+#ifdef CONFIG_ZONE_DEVICE_ACCESS_PROTECTION
+	.dev_page_access_ref = 0,
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index efc5493203ae..a6c14b962a27 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -957,6 +957,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
+#endif
+#ifdef CONFIG_ZONE_DEVICE_ACCESS_PROTECTION
+	tsk->dev_page_access_ref = 0;
 #endif
 	return tsk;
 
diff --git a/mm/Kconfig b/mm/Kconfig
index e541d2c0dcac..f6029f3c2c89 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -798,6 +798,19 @@ config ZONE_DEVICE
 
 	  If FS_DAX is enabled, then say Y.
 
+config ZONE_DEVICE_ACCESS_PROTECTION
+	bool "Device memory access protection"
+	depends on ZONE_DEVICE
+	depends on ARCH_HAS_SUPERVISOR_PKEYS
+
+	help
+	  Enable the option of having access protections on device memory
+	  areas.  This protects against access to device memory which is not
+	  intended such as stray writes.  This feature is particularly useful
+	  to protect against corruption of persistent memory.
+
+	  If in doubt, say 'Y'.
+
 config DEV_PAGEMAP_OPS
 	bool
 
diff --git a/mm/memremap.c b/mm/memremap.c
index 9fb9ad500e78..513d9c3a48de 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -6,12 +6,16 @@
 #include <linux/memory_hotplug.h>
 #include <linux/mm.h>
 #include <linux/pfn_t.h>
+#include <linux/pkeys.h>
 #include <linux/swap.h>
 #include <linux/mmzone.h>
 #include <linux/swapops.h>
 #include <linux/types.h>
 #include <linux/wait_bit.h>
 #include <linux/xarray.h>
+#include <uapi/asm-generic/mman-common.h>
+
+#define PKEY_INVALID (INT_MIN)
 
 static DEFINE_XARRAY(pgmap_array);
 
@@ -67,6 +71,97 @@ static void devmap_managed_enable_put(void)
 }
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
 
+#ifdef CONFIG_ZONE_DEVICE_ACCESS_PROTECTION
+/*
+ * Note all devices which have asked for protections share the same key.  The
+ * key may, or may not, have been provided by the core.  If not, protection
+ * will remain disabled.  The key acquisition is attempted at init time and
+ * never again.  So we don't have to worry about dev_page_pkey changing.
+ */
+static int dev_page_pkey = PKEY_INVALID;
+DEFINE_STATIC_KEY_FALSE(dev_protection_static_key);
+EXPORT_SYMBOL(dev_protection_static_key);
+
+static pgprot_t dev_protection_enable_get(struct dev_pagemap *pgmap, pgprot_t prot)
+{
+	if (pgmap->flags & PGMAP_PROT_ENABLED && dev_page_pkey != PKEY_INVALID) {
+		pgprotval_t val = pgprot_val(prot);
+
+		static_branch_inc(&dev_protection_static_key);
+		prot = __pgprot(val | _PAGE_PKEY(dev_page_pkey));
+	}
+	return prot;
+}
+
+static void dev_protection_enable_put(struct dev_pagemap *pgmap)
+{
+	if (pgmap->flags & PGMAP_PROT_ENABLED && dev_page_pkey != PKEY_INVALID)
+		static_branch_dec(&dev_protection_static_key);
+}
+
+void dev_access_disable(void)
+{
+	unsigned long flags;
+
+	if (!static_branch_unlikely(&dev_protection_static_key))
+		return;
+
+	local_irq_save(flags);
+	current->dev_page_access_ref--;
+	if (current->dev_page_access_ref == 0)
+		pks_update_protection(dev_page_pkey, PKEY_DISABLE_ACCESS);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(dev_access_disable);
+
+void dev_access_enable(void)
+{
+	unsigned long flags;
+
+	if (!static_branch_unlikely(&dev_protection_static_key))
+		return;
+
+	local_irq_save(flags);
+	/* 0 clears the PKEY_DISABLE_ACCESS bit, allowing access */
+	if (current->dev_page_access_ref == 0)
+		pks_update_protection(dev_page_pkey, 0);
+	current->dev_page_access_ref++;
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(dev_access_enable);
+
+/**
+ * dev_access_protection_init: Configure a PKS key domain for device pages
+ *
+ * The domain defaults to the protected state.  Device page mappings should set
+ * the PGMAP_PROT_ENABLED flag when mapping pages.
+ *
+ * Note the pkey is never free'ed.  This is run at init time and we either get
+ * the key or we do not.  We need to do this to maintian a constant key (or
+ * not) as device memory is added or removed.
+ */
+static int __init __dev_access_protection_init(void)
+{
+	int pkey = pks_key_alloc("Device Memory");
+
+	if (pkey < 0)
+		return 0;
+
+	dev_page_pkey = pkey;
+
+	return 0;
+}
+subsys_initcall(__dev_access_protection_init);
+#else
+static pgprot_t dev_protection_enable_get(struct dev_pagemap *pgmap, pgprot_t prot)
+{
+	return prot;
+}
+static void dev_protection_enable_put(struct dev_pagemap *pgmap)
+{
+}
+#endif /* CONFIG_ZONE_DEVICE_ACCESS_PROTECTION */
+
 static void pgmap_array_delete(struct resource *res)
 {
 	xa_store_range(&pgmap_array, PHYS_PFN(res->start), PHYS_PFN(res->end),
@@ -156,6 +251,7 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 	pgmap_array_delete(res);
 	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
 	devmap_managed_enable_put();
+	dev_protection_enable_put(pgmap);
 }
 EXPORT_SYMBOL_GPL(memunmap_pages);
 
@@ -191,6 +287,8 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 	int error, is_ram;
 	bool need_devmap_managed = true;
 
+	params.pgprot = dev_protection_enable_get(pgmap, params.pgprot);
+
 	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 		if (!IS_ENABLED(CONFIG_DEVICE_PRIVATE)) {
-- 
2.28.0.rc0.12.gb6a658bd00c9

