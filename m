Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8C741B61B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 20:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbhI1S0A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 14:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242184AbhI1SZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632853449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YxVxDaMF8Dvr5dJnhnKtXBDkasxDLaxdtEfkC3HanCE=;
        b=fMzU62lrwd+Yy9xtxXsot4PJFkC5SzASmXH8wLg35TY8j9GvgYOC/v/IhuwUsVIKi/1t95
        oY54T9sno+VXRkBACZcnW0+wFM4GeQ4Z9yqlxMZGRYRQjP4Fd1bH4l1Z+zUSQNzljDYHnW
        U7za+EJ2Qve+lppsIFlqoDCR0W/ANNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-rpm4hXWDPGGhvyyl4qPVLg-1; Tue, 28 Sep 2021 14:24:08 -0400
X-MC-Unique: rpm4hXWDPGGhvyyl4qPVLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F05E41B2C980;
        Tue, 28 Sep 2021 18:24:05 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6147C60854;
        Tue, 28 Sep 2021 18:23:50 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 4/8] proc/vmcore: convert oldmem_pfn_is_ram callback to more generic vmcore callbacks
Date:   Tue, 28 Sep 2021 20:22:54 +0200
Message-Id: <20210928182258.12451-5-david@redhat.com>
In-Reply-To: <20210928182258.12451-1-david@redhat.com>
References: <20210928182258.12451-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's support multiple registered callbacks, making sure that
registering vmcore callbacks cannot fail. Make the callback return a
bool instead of an int, handling how to deal with errors internally.
Drop unused HAVE_OLDMEM_PFN_IS_RAM.

We soon want to make use of this infrastructure from other drivers:
virtio-mem, registering one callback for each virtio-mem device, to
prevent reading unplugged virtio-mem memory.

Handle it via a generic vmcore_cb structure, prepared for future
extensions: for example, once we support virtio-mem on s390x where the
vmcore is completely constructed in the second kernel, we want to detect
and add plugged virtio-mem memory ranges to the vmcore in order for them
to get dumped properly.

Handle corner cases that are unexpected and shouldn't happen in sane
setups: registering a callback after the vmcore has already been opened
(warn only) and unregistering a callback after the vmcore has already been
opened (warn and essentially read only zeroes from that point on).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/kernel/aperture_64.c | 13 ++++-
 arch/x86/xen/mmu_hvm.c        | 15 +++---
 fs/proc/vmcore.c              | 99 ++++++++++++++++++++++++-----------
 include/linux/crash_dump.h    | 26 +++++++--
 4 files changed, 113 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index 10562885f5fc..af3ba08b684b 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -73,12 +73,23 @@ static int gart_mem_pfn_is_ram(unsigned long pfn)
 		      (pfn >= aperture_pfn_start + aperture_page_count));
 }
 
+#ifdef CONFIG_PROC_VMCORE
+static bool gart_oldmem_pfn_is_ram(struct vmcore_cb *cb, unsigned long pfn)
+{
+	return !!gart_mem_pfn_is_ram(pfn);
+}
+
+static struct vmcore_cb gart_vmcore_cb = {
+	.pfn_is_ram = gart_oldmem_pfn_is_ram,
+};
+#endif
+
 static void __init exclude_from_core(u64 aper_base, u32 aper_order)
 {
 	aperture_pfn_start = aper_base >> PAGE_SHIFT;
 	aperture_page_count = (32 * 1024 * 1024) << aper_order >> PAGE_SHIFT;
 #ifdef CONFIG_PROC_VMCORE
-	WARN_ON(register_oldmem_pfn_is_ram(&gart_mem_pfn_is_ram));
+	register_vmcore_cb(&gart_vmcore_cb);
 #endif
 #ifdef CONFIG_PROC_KCORE
 	WARN_ON(register_mem_pfn_is_ram(&gart_mem_pfn_is_ram));
diff --git a/arch/x86/xen/mmu_hvm.c b/arch/x86/xen/mmu_hvm.c
index eb61622df75b..49bd4a6a5858 100644
--- a/arch/x86/xen/mmu_hvm.c
+++ b/arch/x86/xen/mmu_hvm.c
@@ -12,10 +12,10 @@
  * The kdump kernel has to check whether a pfn of the crashed kernel
  * was a ballooned page. vmcore is using this function to decide
  * whether to access a pfn of the crashed kernel.
- * Returns 0 if the pfn is not backed by a RAM page, the caller may
+ * Returns "false" if the pfn is not backed by a RAM page, the caller may
  * handle the pfn special in this case.
  */
-static int xen_oldmem_pfn_is_ram(unsigned long pfn)
+static bool xen_vmcore_pfn_is_ram(struct vmcore_cb *cb, unsigned long pfn)
 {
 	struct xen_hvm_get_mem_type a = {
 		.domid = DOMID_SELF,
@@ -23,15 +23,18 @@ static int xen_oldmem_pfn_is_ram(unsigned long pfn)
 	};
 
 	if (HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a))
-		return -ENXIO;
+		return true;
 
 	switch (a.mem_type) {
 	case HVMMEM_mmio_dm:
-		return 0;
+		return false;
 	default:
-		return 1;
+		return true;
 	}
 }
+static struct vmcore_cb xen_vmcore_cb = {
+	.pfn_is_ram = xen_vmcore_pfn_is_ram,
+};
 #endif
 
 static void xen_hvm_exit_mmap(struct mm_struct *mm)
@@ -65,6 +68,6 @@ void __init xen_hvm_init_mmu_ops(void)
 	if (is_pagetable_dying_supported())
 		pv_ops.mmu.exit_mmap = xen_hvm_exit_mmap;
 #ifdef CONFIG_PROC_VMCORE
-	WARN_ON(register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram));
+	register_vmcore_cb(&xen_vmcore_cb);
 #endif
 }
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index a9bd80ab670e..7a04b2eca287 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -62,46 +62,75 @@ core_param(novmcoredd, vmcoredd_disabled, bool, 0);
 /* Device Dump Size */
 static size_t vmcoredd_orig_sz;
 
-/*
- * Returns > 0 for RAM pages, 0 for non-RAM pages, < 0 on error
- * The called function has to take care of module refcounting.
- */
-static int (*oldmem_pfn_is_ram)(unsigned long pfn);
-
-int register_oldmem_pfn_is_ram(int (*fn)(unsigned long pfn))
+static DECLARE_RWSEM(vmcore_cb_rwsem);
+/* List of registered vmcore callbacks. */
+static LIST_HEAD(vmcore_cb_list);
+/* Whether we had a surprise unregistration of a callback. */
+static bool vmcore_cb_unstable;
+/* Whether the vmcore has been opened once. */
+static bool vmcore_opened;
+
+void register_vmcore_cb(struct vmcore_cb *cb)
 {
-	if (oldmem_pfn_is_ram)
-		return -EBUSY;
-	oldmem_pfn_is_ram = fn;
-	return 0;
+	down_write(&vmcore_cb_rwsem);
+	INIT_LIST_HEAD(&cb->next);
+	list_add_tail(&cb->next, &vmcore_cb_list);
+	/*
+	 * Registering a vmcore callback after the vmcore was opened is
+	 * very unusual (e.g., manual driver loading).
+	 */
+	if (vmcore_opened)
+		pr_warn_once("Unexpected vmcore callback registration\n");
+	up_write(&vmcore_cb_rwsem);
 }
-EXPORT_SYMBOL_GPL(register_oldmem_pfn_is_ram);
+EXPORT_SYMBOL_GPL(register_vmcore_cb);
 
-void unregister_oldmem_pfn_is_ram(void)
+void unregister_vmcore_cb(struct vmcore_cb *cb)
 {
-	oldmem_pfn_is_ram = NULL;
-	wmb();
+	down_write(&vmcore_cb_rwsem);
+	list_del(&cb->next);
+	/*
+	 * Unregistering a vmcore callback after the vmcore was opened is
+	 * very unusual (e.g., forced driver removal), but we cannot stop
+	 * unregistering.
+	 */
+	if (vmcore_opened) {
+		pr_warn_once("Unexpected vmcore callback unregistration\n");
+		vmcore_cb_unstable = true;
+	}
+	up_write(&vmcore_cb_rwsem);
 }
-EXPORT_SYMBOL_GPL(unregister_oldmem_pfn_is_ram);
+EXPORT_SYMBOL_GPL(unregister_vmcore_cb);
 
 static bool pfn_is_ram(unsigned long pfn)
 {
-	int (*fn)(unsigned long pfn);
-	/* pfn is ram unless fn() checks pagetype */
+	struct vmcore_cb *cb;
 	bool ret = true;
 
-	/*
-	 * Ask hypervisor if the pfn is really ram.
-	 * A ballooned page contains no data and reading from such a page
-	 * will cause high load in the hypervisor.
-	 */
-	fn = oldmem_pfn_is_ram;
-	if (fn)
-		ret = !!fn(pfn);
+	lockdep_assert_held_read(&vmcore_cb_rwsem);
+	if (unlikely(vmcore_cb_unstable))
+		return false;
+
+	list_for_each_entry(cb, &vmcore_cb_list, next) {
+		if (unlikely(!cb->pfn_is_ram))
+			continue;
+		ret = cb->pfn_is_ram(cb, pfn);
+		if (!ret)
+			break;
+	}
 
 	return ret;
 }
 
+static int open_vmcore(struct inode *inode, struct file *file)
+{
+	down_read(&vmcore_cb_rwsem);
+	vmcore_opened = true;
+	up_read(&vmcore_cb_rwsem);
+
+	return 0;
+}
+
 /* Reads a page from the oldmem device from given offset. */
 ssize_t read_from_oldmem(char *buf, size_t count,
 			 u64 *ppos, int userbuf,
@@ -117,6 +146,7 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 	offset = (unsigned long)(*ppos % PAGE_SIZE);
 	pfn = (unsigned long)(*ppos / PAGE_SIZE);
 
+	down_read(&vmcore_cb_rwsem);
 	do {
 		if (count > (PAGE_SIZE - offset))
 			nr_bytes = PAGE_SIZE - offset;
@@ -136,8 +166,10 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 				tmp = copy_oldmem_page(pfn, buf, nr_bytes,
 						       offset, userbuf);
 
-			if (tmp < 0)
+			if (tmp < 0) {
+				up_read(&vmcore_cb_rwsem);
 				return tmp;
+			}
 		}
 		*ppos += nr_bytes;
 		count -= nr_bytes;
@@ -147,6 +179,7 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 		offset = 0;
 	} while (count);
 
+	up_read(&vmcore_cb_rwsem);
 	return read;
 }
 
@@ -537,14 +570,19 @@ static int vmcore_remap_oldmem_pfn(struct vm_area_struct *vma,
 			    unsigned long from, unsigned long pfn,
 			    unsigned long size, pgprot_t prot)
 {
+	int ret;
+
 	/*
 	 * Check if oldmem_pfn_is_ram was registered to avoid
 	 * looping over all pages without a reason.
 	 */
-	if (oldmem_pfn_is_ram)
-		return remap_oldmem_pfn_checked(vma, from, pfn, size, prot);
+	down_read(&vmcore_cb_rwsem);
+	if (!list_empty(&vmcore_cb_list) || vmcore_cb_unstable)
+		ret = remap_oldmem_pfn_checked(vma, from, pfn, size, prot);
 	else
-		return remap_oldmem_pfn_range(vma, from, pfn, size, prot);
+		ret = remap_oldmem_pfn_range(vma, from, pfn, size, prot);
+	up_read(&vmcore_cb_rwsem);
+	return ret;
 }
 
 static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
@@ -668,6 +706,7 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 #endif
 
 static const struct proc_ops vmcore_proc_ops = {
+	.proc_open	= open_vmcore,
 	.proc_read	= read_vmcore,
 	.proc_lseek	= default_llseek,
 	.proc_mmap	= mmap_vmcore,
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 2618577a4d6d..0c547d866f1e 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -91,9 +91,29 @@ static inline void vmcore_unusable(void)
 		elfcorehdr_addr = ELFCORE_ADDR_ERR;
 }
 
-#define HAVE_OLDMEM_PFN_IS_RAM 1
-extern int register_oldmem_pfn_is_ram(int (*fn)(unsigned long pfn));
-extern void unregister_oldmem_pfn_is_ram(void);
+/**
+ * struct vmcore_cb - driver callbacks for /proc/vmcore handling
+ * @pfn_is_ram: check whether a PFN really is RAM and should be accessed when
+ *              reading the vmcore. Will return "true" if it is RAM or if the
+ *              callback cannot tell. If any callback returns "false", it's not
+ *              RAM and the page must not be accessed; zeroes should be
+ *              indicated in the vmcore instead. For example, a ballooned page
+ *              contains no data and reading from such a page will cause high
+ *              load in the hypervisor.
+ * @next: List head to manage registered callbacks internally; initialized by
+ *        register_vmcore_cb().
+ *
+ * vmcore callbacks allow drivers managing physical memory ranges to
+ * coordinate with vmcore handling code, for example, to prevent accessing
+ * physical memory ranges that should not be accessed when reading the vmcore,
+ * although included in the vmcore header as memory ranges to dump.
+ */
+struct vmcore_cb {
+	bool (*pfn_is_ram)(struct vmcore_cb *cb, unsigned long pfn);
+	struct list_head next;
+};
+extern void register_vmcore_cb(struct vmcore_cb *cb);
+extern void unregister_vmcore_cb(struct vmcore_cb *cb);
 
 #else /* !CONFIG_CRASH_DUMP */
 static inline bool is_kdump_kernel(void) { return 0; }
-- 
2.31.1

