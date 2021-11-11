Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E5E44D7F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 15:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhKKOS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 09:18:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:49655 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233742AbhKKOSX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:18:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="232759684"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="232759684"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 06:15:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="492555679"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 06:15:22 -0800
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
Subject: [RFC PATCH 4/6] kvm: x86: implement private_ops for memfd backing store
Date:   Thu, 11 Nov 2021 22:13:43 +0800
Message-Id: <20211111141352.26311-5-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
References: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call memfd_register_guest() module API to setup private_ops for a given
private memslot.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/Makefile    |  2 +-
 arch/x86/kvm/memfd.c     | 63 ++++++++++++++++++++++++++++++++++++++++
 include/linux/kvm_host.h |  6 ++++
 virt/kvm/kvm_main.c      | 29 ++++++++++++++++--
 4 files changed, 96 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/kvm/memfd.c

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index e7ed25070206..72ad96c78bed 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -16,7 +16,7 @@ kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(KVM)/async_pf.o
 
 kvm-y			+= x86.o emulate.o i8259.o irq.o lapic.o \
 			   i8254.o ioapic.o irq_comm.o cpuid.o pmu.o mtrr.o \
-			   hyperv.o debugfs.o mmu/mmu.o mmu/page_track.o \
+			   hyperv.o debugfs.o memfd.o mmu/mmu.o mmu/page_track.o \
 			   mmu/spte.o
 kvm-$(CONFIG_X86_64) += mmu/tdp_iter.o mmu/tdp_mmu.o
 kvm-$(CONFIG_KVM_XEN)	+= xen.o
diff --git a/arch/x86/kvm/memfd.c b/arch/x86/kvm/memfd.c
new file mode 100644
index 000000000000..e08ab61d09f2
--- /dev/null
+++ b/arch/x86/kvm/memfd.c
@@ -0,0 +1,63 @@
+
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * memfd.c: routines for fd based memory backing store
+ * Copyright (c) 2021, Intel Corporation.
+ *
+ */
+
+#include <linux/kvm_host.h>
+#include <linux/memfd.h>
+const static struct guest_mem_ops *memfd_ops;
+
+static void test_guest_invalidate_page_range(struct inode *inode, void *owner,
+					     pgoff_t start, pgoff_t end)
+{
+	//!!!We can get here after the owner no longer exists
+}
+
+static const struct guest_ops guest_ops = {
+	.invalidate_page_range = test_guest_invalidate_page_range,
+};
+
+static unsigned long memfd_get_lock_pfn(const struct kvm_memory_slot *slot,
+					gfn_t gfn, int *page_level)
+{
+	pgoff_t index = gfn - slot->base_gfn +
+			(slot->userspace_addr >> PAGE_SHIFT);
+
+	return memfd_ops->get_lock_pfn(slot->file->f_inode, index, page_level);
+}
+
+static void memfd_put_unlock_pfn(unsigned long pfn)
+{
+	memfd_ops->put_unlock_pfn(pfn);
+}
+
+static struct kvm_private_memory_ops memfd_private_ops = {
+	.get_lock_pfn = memfd_get_lock_pfn,
+	.put_unlock_pfn = memfd_put_unlock_pfn,
+};
+
+int kvm_register_private_memslot(struct kvm *kvm,
+				 const struct kvm_userspace_memory_region *mem,
+				 struct kvm_memory_slot *slot)
+{
+	struct fd memfd = fdget(mem->fd);
+
+	if(!memfd.file)
+		return -EINVAL;
+
+	slot->file = memfd.file;
+	slot->private_ops = &memfd_private_ops;
+
+	memfd_register_guest(slot->file->f_inode, kvm, &guest_ops, &memfd_ops);
+	return 0;
+}
+
+void kvm_unregister_private_memslot(struct kvm *kvm,
+				 const struct kvm_userspace_memory_region *mem,
+				 struct kvm_memory_slot *slot)
+{
+	fput(slot->file);
+}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 83345460c5f5..17fabb4f53bf 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -777,6 +777,12 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *old,
 				const struct kvm_memory_slot *new,
 				enum kvm_mr_change change);
+int kvm_register_private_memslot(struct kvm *kvm,
+				 const struct kvm_userspace_memory_region *mem,
+				 struct kvm_memory_slot *slot);
+void kvm_unregister_private_memslot(struct kvm *kvm,
+				 const struct kvm_userspace_memory_region *mem,
+				 struct kvm_memory_slot *slot);
 /* flush all memory translations */
 void kvm_arch_flush_shadow_all(struct kvm *kvm);
 /* flush memory translations pointing to 'slot' */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fe62df334054..e8e2c5b28aa4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1250,7 +1250,19 @@ static int kvm_set_memslot(struct kvm *kvm,
 		kvm_arch_flush_shadow_memslot(kvm, slot);
 	}
 
+#ifdef KVM_PRIVATE_ADDRESS_SPACE
+	if (change == KVM_MR_CREATE && as_id == KVM_PRIVATE_ADDRESS_SPACE) {
+		r = kvm_register_private_memslot(kvm, mem, new);
+		if (r)
+			goto out_slots;
+	}
+#endif
+
 	r = kvm_arch_prepare_memory_region(kvm, new, mem, change);
+#ifdef KVM_PRIVATE_ADDRESS_SPACE
+	if ((r || change == KVM_MR_DELETE) && as_id == KVM_PRIVATE_ADDRESS_SPACE)
+		kvm_unregister_private_memslot(kvm, mem, new);
+#endif
 	if (r)
 		goto out_slots;
 
@@ -1324,10 +1336,15 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		return -EINVAL;
 	if (mem->guest_phys_addr & (PAGE_SIZE - 1))
 		return -EINVAL;
-	/* We can read the guest memory with __xxx_user() later on. */
 	if ((mem->userspace_addr & (PAGE_SIZE - 1)) ||
-	    (mem->userspace_addr != untagged_addr(mem->userspace_addr)) ||
-	     !access_ok((void __user *)(unsigned long)mem->userspace_addr,
+	    (mem->userspace_addr != untagged_addr(mem->userspace_addr)))
+		return -EINVAL;
+	/* We can read the guest memory with __xxx_user() later on. */
+	if (
+#ifdef KVM_PRIVATE_ADDRESS_SPACE
+	    as_id != KVM_PRIVATE_ADDRESS_SPACE &&
+#endif
+	    !access_ok((void __user *)(unsigned long)mem->userspace_addr,
 			mem->memory_size))
 		return -EINVAL;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
@@ -1368,6 +1385,12 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		new.dirty_bitmap = NULL;
 		memset(&new.arch, 0, sizeof(new.arch));
 	} else { /* Modify an existing slot. */
+#ifdef KVM_PRIVATE_ADDRESS_SPACE
+		/* Private memslots are immutable, they can only be deleted. */
+		if (as_id == KVM_PRIVATE_ADDRESS_SPACE)
+			return -EINVAL;
+#endif
+
 		if ((new.userspace_addr != old.userspace_addr) ||
 		    (new.npages != old.npages) ||
 		    ((new.flags ^ old.flags) & KVM_MEM_READONLY))
-- 
2.17.1

