Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B7647C25F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbhLUPMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:12:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:21302 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239050AbhLUPMs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640099568; x=1671635568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=snmatL1uK4KuRHcj/WK0h5dXbp4LPNz5mNTfAgPLTLI=;
  b=VWnZhcoKG4e+uAcd3QcYuKMRtT4aujNAUqLna4DzfarmWxABH/5L6ZK3
   U1xyejzgIvz/1Ov5IyTCJ3PVG1BTgOBFJgUe+S+oZhRTsFs2eFnS5agLx
   2TlP6CEm1AewoKe45LR4MFTsPv7IyGN4AqOtK/YfyTZEMP/hMZ0iHc8zp
   FDbIN09AcesyIE2XiikJPW0TQOZGJB7g5TZuR43R+53omHsAShABRxnkX
   14kPjIatXRMg6T2S5tkxpIEim/Le+6iKvPZ60UxURkXgC92zBg2egsgFo
   g0fBapIvm7+QbOpQuVPxB/th0n/XdvtyWuKeVxhDrLD9EfgaVrqAlsM+T
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="326709756"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="326709756"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 07:12:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684688401"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 07:12:40 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: [PATCH v3 05/15] KVM: Implement fd-based memory using MEMFD_OPS interfaces
Date:   Tue, 21 Dec 2021 23:11:15 +0800
Message-Id: <20211221151125.19446-6-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
References: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds the new memfd facility in KVM using MEMFD_OPS to provide
guest memory from a file descriptor created in user space with
memfd_create() instead of traditional userspace hva. It mainly provides
two kind of functions:
  - Pair/unpair a fd-based memslot to a memory backend that owns the
    file descriptor when such memslot gets created/deleted.
  - Get/put a pfn that to be used in KVM page fault handler from/to the
    paired memory backend.

At the pairing time, KVM and the memfd subsystem exchange calllbacks
that each can call into the other side. These callbacks are the major
places to implement fd-based guest memory provisioning.
KVM->memfd:
  - get_pfn: get and lock a page at specified offset in the fd.
  - put_pfn: put and unlock the pfn.
    Note: page needs to be locked between get_pfn/put_pfn to ensure pfn
    is valid when KVM uses it to establish the mapping in the secondary
    MMU page table.
memfd->KVM:
  - invalidate_page_range: called when userspace punch hole on the fd,
    KVM should unmap related pages in the second MMU.
  - fallocate: called when userspace fallocate space on the fd, KVM
    can map related pages in the second MMU.
  - get/put_owner: used to ensure guest is still alive using a reference
    mechanism when calling above invalidate/fallocate callbacks.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/Kconfig     |  1 +
 arch/x86/kvm/Makefile    |  3 +-
 include/linux/kvm_host.h |  8 ++++
 virt/kvm/memfd.c         | 95 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 virt/kvm/memfd.c

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 619186138176..b90ba95db5f3 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -44,6 +44,7 @@ config KVM
 	select KVM_VFIO
 	select SRCU
 	select HAVE_KVM_PM_NOTIFIER if PM
+	select MEMFD_OPS
 	help
 	  Support hosting fully virtualized guest machines using hardware
 	  virtualization extensions.  You will need a fairly recent
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 51b2d5fdaeed..87e49d1d9980 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -11,7 +11,8 @@ KVM := ../../../virt/kvm
 
 kvm-y			+= $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
 				$(KVM)/eventfd.o $(KVM)/irqchip.o $(KVM)/vfio.o \
-				$(KVM)/dirty_ring.o $(KVM)/binary_stats.o
+				$(KVM)/dirty_ring.o $(KVM)/binary_stats.o \
+				$(KVM)/memfd.o
 kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(KVM)/async_pf.o
 
 kvm-y			+= x86.o emulate.o i8259.o irq.o lapic.o \
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 96e46b288ecd..b0b63c9a160f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -773,6 +773,14 @@ static inline void kvm_irqfd_exit(void)
 {
 }
 #endif
+
+int kvm_memfd_register(struct kvm *kvm,
+		       const struct kvm_userspace_memory_region_ext *mem,
+		       struct kvm_memory_slot *slot);
+void kvm_memfd_unregister(struct kvm *kvm, struct kvm_memory_slot *slot);
+long kvm_memfd_get_pfn(struct kvm_memory_slot *slot, gfn_t gfn, int *order);
+void kvm_memfd_put_pfn(kvm_pfn_t pfn);
+
 int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 		  struct module *module);
 void kvm_exit(void);
diff --git a/virt/kvm/memfd.c b/virt/kvm/memfd.c
new file mode 100644
index 000000000000..96a1a5bee0f7
--- /dev/null
+++ b/virt/kvm/memfd.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * memfd.c: routines for fd based guest memory
+ * Copyright (c) 2021, Intel Corporation.
+ *
+ * Author:
+ *	Chao Peng <chao.p.peng@linux.intel.com>
+ */
+
+#include <linux/kvm_host.h>
+#include <linux/memfd.h>
+
+#ifdef CONFIG_MEMFD_OPS
+static const struct memfd_pfn_ops *memfd_ops;
+
+static void memfd_invalidate_page_range(struct inode *inode, void *owner,
+					pgoff_t start, pgoff_t end)
+{
+}
+
+static void memfd_fallocate(struct inode *inode, void *owner,
+			    pgoff_t start, pgoff_t end)
+{
+}
+
+static bool memfd_get_owner(void *owner)
+{
+	return kvm_get_kvm_safe(owner);
+}
+
+static void memfd_put_owner(void *owner)
+{
+	kvm_put_kvm(owner);
+}
+
+static const struct  memfd_falloc_notifier memfd_notifier = {
+	.invalidate_page_range = memfd_invalidate_page_range,
+	.fallocate = memfd_fallocate,
+	.get_owner = memfd_get_owner,
+	.put_owner = memfd_put_owner,
+};
+#endif
+
+long kvm_memfd_get_pfn(struct kvm_memory_slot *slot, gfn_t gfn, int *order)
+{
+#ifdef CONFIG_MEMFD_OPS
+	pgoff_t index = gfn - slot->base_gfn +
+			(slot->file_ofs >> PAGE_SHIFT);
+
+	return memfd_ops->get_lock_pfn(slot->file->f_inode, index, order);
+#else
+	return -1;
+#endif
+}
+
+void kvm_memfd_put_pfn(kvm_pfn_t pfn)
+{
+#ifdef CONFIG_MEMFD_OPS
+	memfd_ops->put_unlock_pfn(pfn);
+#endif
+}
+
+int kvm_memfd_register(struct kvm *kvm,
+		       const struct kvm_userspace_memory_region_ext *mem,
+		       struct kvm_memory_slot *slot)
+{
+#ifdef CONFIG_MEMFD_OPS
+	int ret;
+	struct fd fd = fdget(mem->fd);
+
+	if (!fd.file)
+		return -EINVAL;
+
+	ret = memfd_register_falloc_notifier(fd.file->f_inode, kvm,
+				   &memfd_notifier, &memfd_ops);
+	if (ret)
+		return ret;
+
+	slot->file = fd.file;
+	slot->file_ofs = mem->ofs;
+	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+void kvm_memfd_unregister(struct kvm *kvm, struct kvm_memory_slot *slot)
+{
+#ifdef CONFIG_MEMFD_OPS
+	if (slot->file) {
+		fput(slot->file);
+		slot->file = NULL;
+	}
+#endif
+}
-- 
2.17.1

