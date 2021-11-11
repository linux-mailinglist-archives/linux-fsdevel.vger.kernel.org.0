Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF91C44D7FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 15:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhKKOSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 09:18:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:10961 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233835AbhKKOSn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:18:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="219806832"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="219806832"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 06:15:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="492555822"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 06:15:43 -0800
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
Subject: [RFC PATCH 6/6] KVM: add KVM_SPLIT_MEMORY_REGION
Date:   Thu, 11 Nov 2021 22:13:45 +0800
Message-Id: <20211111141352.26311-7-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
References: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This new ioctl let user to split an exising memory region into two
parts. The first part reuses the existing memory region but have a
shrinked size. The second part is a newly created one.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/x86.c       |   3 +-
 include/linux/kvm_host.h |   4 ++
 include/uapi/linux/kvm.h |  16 +++++
 virt/kvm/kvm_main.c      | 147 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 98dbe602f47b..1d490c3d7766 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11020,7 +11020,8 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				const struct kvm_userspace_memory_region *mem,
 				enum kvm_mr_change change)
 {
-	if (change == KVM_MR_CREATE || change == KVM_MR_MOVE)
+	if (change == KVM_MR_CREATE || change == KVM_MR_MOVE ||
+	    change == KVM_MR_SHRINK)
 		return kvm_alloc_memslot_metadata(memslot,
 						  mem->memory_size >> PAGE_SHIFT);
 	return 0;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 17fabb4f53bf..8b5a9217231b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -752,6 +752,9 @@ static inline bool memslot_is_private(const struct kvm_memory_slot *slot)
  *   -- move it in the guest physical memory space
  *   -- just change its flags
  *
+ * KVM_SPLIT_MEMORY_REGION ioctl allows the following operation:
+ * - shrink an existing memory slot
+ *
  * Since flags can be changed by some of these operations, the following
  * differentiation is the best we can do for __kvm_set_memory_region():
  */
@@ -760,6 +763,7 @@ enum kvm_mr_change {
 	KVM_MR_DELETE,
 	KVM_MR_MOVE,
 	KVM_MR_FLAGS_ONLY,
+	KVM_MR_SHRINK,
 };
 
 int kvm_set_memory_region(struct kvm *kvm,
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 470c472a9451..e61c0eac91e7 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1108,6 +1108,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_DIRTY_LOG_RING 192
 #define KVM_CAP_X86_BUS_LOCK_EXIT 193
 #define KVM_CAP_PPC_DAWR1 194
+#define KVM_CAP_MEMORY_REGION_SPLIT 195
 
 #define KVM_CAP_VM_TYPES 1000
 
@@ -1885,4 +1886,19 @@ struct kvm_dirty_gfn {
 #define KVM_BUS_LOCK_DETECTION_OFF             (1 << 0)
 #define KVM_BUS_LOCK_DETECTION_EXIT            (1 << 1)
 
+/**
+ * struct kvm_split_memory_region_info - Infomation for memory region split.
+ * @slot1: The slot to be split.
+ * @slot2: The slot for the newly split part.
+ * @offset: The offset(bytes) in @slot1 to split.
+ */
+struct kvm_split_memory_region_info {
+	__u32 slot1;
+	__u32 slot2;
+	__u64 offset;
+};
+
+#define KVM_SPLIT_MEMORY_REGION _IOW(KVMIO, 0xcf, \
+					struct kvm_split_memory_region_info)
+
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e8e2c5b28aa4..11b0f3d8b9ee 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1467,6 +1467,140 @@ static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
 	return kvm_set_memory_region(kvm, mem);
 }
 
+static void memslot_to_memory_region(struct kvm_userspace_memory_region *mem,
+				struct kvm_memory_slot *slot)
+{
+	mem->slot = (u32)slot->as_id << 16 | slot->id;
+	mem->flags = slot->flags;
+	mem->guest_phys_addr = slot->base_gfn >> PAGE_SHIFT;
+	mem->memory_size = slot->npages << PAGE_SHIFT;
+	mem->userspace_addr = slot->userspace_addr;
+}
+
+static int kvm_split_memory_region(struct kvm *kvm, int as_id, int id1, int id2,
+					gfn_t offset)
+{
+	struct kvm_memory_slot *slot1;
+	struct kvm_memory_slot slot2, old;
+	struct kvm_userspace_memory_region mem;
+	unsigned long *dirty_bitmap_slot1;
+	struct kvm_memslots *slots;
+	int r;
+
+	/* Make a full copy of the old memslot. */
+	slot1 = id_to_memslot(__kvm_memslots(kvm, as_id), id1);
+	if (!slot1)
+		return -EINVAL;
+	else
+		old = *slot1;
+
+	if( offset <= old.base_gfn ||
+	    offset >= old.base_gfn + old.npages )
+		return -EINVAL;
+
+	/* Prepare the second half. */
+	slot2.as_id = as_id;
+	slot2.id = id2;
+	slot2.base_gfn = old.npages + offset;
+	slot2.npages = old.npages - offset;
+	slot2.flags = old.flags;
+	slot2.userspace_addr = old.userspace_addr + (offset >> PAGE_SHIFT);
+	slot2.file = old.file;
+	slot2.private_ops = old.private_ops;
+
+	if (!(old.flags & KVM_MEM_LOG_DIRTY_PAGES))
+		slot2.dirty_bitmap = NULL;
+	else if (!kvm->dirty_ring_size) {
+		slot1->npages = offset;
+		r = kvm_alloc_dirty_bitmap(slot1);
+		if (r)
+			return r;
+		else
+			dirty_bitmap_slot1 = slot1->dirty_bitmap;
+
+		r = kvm_alloc_dirty_bitmap(&slot2);
+		if (r)
+			goto out_bitmap;
+
+		//TODO: copy dirty_bitmap or return -EINVAL if logging is running
+	}
+
+//	mutex_lock(&kvm->slots_arch_lock);
+
+	slots = kvm_dup_memslots(__kvm_memslots(kvm, as_id), KVM_MR_CREATE);
+	if (!slots) {
+//		mutex_unlock(&kvm->slots_arch_lock);
+		r = -ENOMEM;
+		goto out_bitmap;
+	}
+
+	slot1 = id_to_memslot(slots, id1);
+	slot1->npages = offset;
+	slot1->dirty_bitmap = dirty_bitmap_slot1;
+
+	memslot_to_memory_region(&mem, slot1);
+	r = kvm_arch_prepare_memory_region(kvm, slot1, &mem, KVM_MR_SHRINK);
+	if (r)
+		goto out_slots;
+
+	memslot_to_memory_region(&mem, &slot2);
+	r = kvm_arch_prepare_memory_region(kvm, &slot2, &mem, KVM_MR_CREATE);
+	if (r)
+		goto out_slots;
+
+	update_memslots(slots, slot1, KVM_MR_SHRINK);
+	update_memslots(slots, &slot2, KVM_MR_CREATE);
+
+	slots = install_new_memslots(kvm, as_id, slots);
+
+	kvm_free_memslot(kvm, &old);
+
+	kvfree(slots);
+	return 0;
+
+out_slots:
+//	mutex_unlock(&kvm->slots_arch_lock);
+	kvfree(slots);
+out_bitmap:
+	if (dirty_bitmap_slot1)
+		kvm_destroy_dirty_bitmap(slot1);
+	if (slot2.dirty_bitmap)
+		kvm_destroy_dirty_bitmap(&slot2);
+
+	return r;
+}
+
+static int kvm_vm_ioctl_split_memory_region(struct kvm *kvm,
+				struct kvm_split_memory_region_info *info)
+{
+	int as_id1, as_id2, id1, id2;
+	int r;
+
+	if ((u16)info->slot1 >= KVM_USER_MEM_SLOTS ||
+	    (u16)info->slot2 >= KVM_USER_MEM_SLOTS)
+		return -EINVAL;
+	if (info->offset & (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	as_id1 = info->slot1 >> 16;
+	as_id2 = info->slot2 >> 16;
+
+	if (as_id1 != as_id2 || as_id1 >= KVM_ADDRESS_SPACE_NUM)
+		return -EINVAL;
+
+	id1 = (u16)info->slot1;
+	id2 = (u16)info->slot2;
+	if (id1 == id2 || id1 >= KVM_MEM_SLOTS_NUM || id2 >= KVM_MEM_SLOTS_NUM)
+		return -EINVAL;
+
+	mutex_lock(&kvm->slots_lock);
+	r = kvm_split_memory_region(kvm, as_id1, id1, id2,
+					info->offset >> PAGE_SHIFT);
+	mutex_unlock(&kvm->slots_lock);
+
+	return r;
+}
+
 #ifndef CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT
 /**
  * kvm_get_dirty_log - get a snapshot of dirty pages
@@ -3765,6 +3899,8 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 #else
 		return 0;
 #endif
+	case KVM_CAP_MEMORY_REGION_SPLIT:
+		return 1;
 	default:
 		break;
 	}
@@ -3901,6 +4037,17 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
 		break;
 	}
+	case KVM_SPLIT_MEMORY_REGION: {
+		struct kvm_split_memory_region_info info;
+
+		r = -EFAULT;
+		if (copy_from_user(&info, argp, sizeof(info)))
+			goto out;
+
+		r = kvm_vm_ioctl_split_memory_region(kvm, &info);
+		break;
+	}
+
 	case KVM_GET_DIRTY_LOG: {
 		struct kvm_dirty_log log;
 
-- 
2.17.1

