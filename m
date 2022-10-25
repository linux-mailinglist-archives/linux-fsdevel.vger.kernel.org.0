Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6BD60D064
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 17:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiJYPWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 11:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiJYPVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:21:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1F4233B9;
        Tue, 25 Oct 2022 08:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666711198; x=1698247198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gSDGYt1SO9GcrVjFFDdyGRTv5gtWiyJtwnCYk8FJbTc=;
  b=lgez4p6MWIjuq9XDnGl5vrkhF+5Xy/J1q4ZLwWAH5b1eCsp9lnYLX1TG
   +l7xfN1wFlOfywqYLWwkDDPxg29FA4EY2VUMya+qndBU5XlQWsWnQxkP7
   /DssHSr1u4fQIpu0wB51TkrFFOUBtAjC7fPRotkCOtTxFbS9mfO4ZPHAB
   8PZL8O9hoMPidByXOnFJrLv3A3S0trMWR+jGWoR6aTXkLflNsWq2CzG6r
   K6Kp1dOFxH1ZWM40jG5or44Pchrg6Dqk0x0kz+6a5XRFTONcGuAIVhsRI
   DrppYJOt9JKCL2SIVD8+Q/dO9CHd3r4eO0THS0W71voP87dcLwdeo88mY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="394019202"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="394019202"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 08:19:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="736865843"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="736865843"
Received: from chaop.bj.intel.com ([10.240.193.75])
  by fmsmga002.fm.intel.com with ESMTP; 25 Oct 2022 08:19:46 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: [PATCH v9 8/8] KVM: Enable and expose KVM_MEM_PRIVATE
Date:   Tue, 25 Oct 2022 23:13:44 +0800
Message-Id: <20221025151344.3784230-9-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expose KVM_MEM_PRIVATE and memslot fields restricted_fd/offset to
userspace. KVM register/unregister private memslot to fd-based
memory backing store and responses to invalidation event from
restrictedmem_notifier to zap the existing memory mappings in the
secondary page table.

Whether KVM_MEM_PRIVATE is actually exposed to userspace is determined
by architecture code which can turn on it by overriding the default
kvm_arch_has_private_mem().

A 'kvm' reference is added in memslot structure since in
restrictedmem_notifier callback we can only obtain a memslot reference
but 'kvm' is needed to do the zapping.

Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |   3 +-
 virt/kvm/kvm_main.c      | 174 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 171 insertions(+), 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 69300fc6d572..e27d62c30484 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -246,7 +246,7 @@ int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #endif
 
 
-#if defined(KVM_ARCH_WANT_MMU_NOTIFIER) || defined(CONFIG_KVM_GENERIC_PRIVATE_MEM)
+#if defined(KVM_ARCH_WANT_MMU_NOTIFIER) || defined(CONFIG_HAVE_KVM_RESTRICTED_MEM)
 struct kvm_gfn_range {
 	struct kvm_memory_slot *slot;
 	gfn_t start;
@@ -583,6 +583,7 @@ struct kvm_memory_slot {
 	struct file *restricted_file;
 	loff_t restricted_offset;
 	struct restrictedmem_notifier notifier;
+	struct kvm *kvm;
 };
 
 static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 13a37b4d9e97..dae6a2c196ad 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1028,6 +1028,111 @@ static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
 }
 #endif /* CONFIG_KVM_GENERIC_PRIVATE_MEM */
 
+#ifdef CONFIG_HAVE_KVM_RESTRICTED_MEM
+static bool restrictedmem_range_is_valid(struct kvm_memory_slot *slot,
+					 pgoff_t start, pgoff_t end,
+					 gfn_t *gfn_start, gfn_t *gfn_end)
+{
+	unsigned long base_pgoff = slot->restricted_offset >> PAGE_SHIFT;
+
+	if (start > base_pgoff)
+		*gfn_start = slot->base_gfn + start - base_pgoff;
+	else
+		*gfn_start = slot->base_gfn;
+
+	if (end < base_pgoff + slot->npages)
+		*gfn_end = slot->base_gfn + end - base_pgoff;
+	else
+		*gfn_end = slot->base_gfn + slot->npages;
+
+	if (*gfn_start >= *gfn_end)
+		return false;
+
+	return true;
+}
+
+static void kvm_restrictedmem_invalidate_begin(struct restrictedmem_notifier *notifier,
+					       pgoff_t start, pgoff_t end)
+{
+	struct kvm_memory_slot *slot = container_of(notifier,
+						    struct kvm_memory_slot,
+						    notifier);
+	struct kvm *kvm = slot->kvm;
+	gfn_t gfn_start, gfn_end;
+	struct kvm_gfn_range gfn_range;
+	int idx;
+
+	if (!restrictedmem_range_is_valid(slot, start, end,
+						&gfn_start, &gfn_end))
+		return;
+
+	idx = srcu_read_lock(&kvm->srcu);
+	KVM_MMU_LOCK(kvm);
+
+	kvm_mmu_invalidate_begin(kvm, gfn_start, gfn_end);
+
+	gfn_range.start = gfn_start;
+	gfn_range.end = gfn_end;
+	gfn_range.slot = slot;
+	gfn_range.pte = __pte(0);
+	gfn_range.may_block = true;
+
+	if (kvm_unmap_gfn_range(kvm, &gfn_range))
+		kvm_flush_remote_tlbs(kvm);
+
+	KVM_MMU_UNLOCK(kvm);
+	srcu_read_unlock(&kvm->srcu, idx);
+}
+
+static void kvm_restrictedmem_invalidate_end(struct restrictedmem_notifier *notifier,
+					     pgoff_t start, pgoff_t end)
+{
+	struct kvm_memory_slot *slot = container_of(notifier,
+						    struct kvm_memory_slot,
+						    notifier);
+	struct kvm *kvm = slot->kvm;
+	gfn_t gfn_start, gfn_end;
+
+	if (!restrictedmem_range_is_valid(slot, start, end,
+						&gfn_start, &gfn_end))
+		return;
+
+	KVM_MMU_LOCK(kvm);
+	kvm_mmu_invalidate_end(kvm, gfn_start, gfn_end);
+	KVM_MMU_UNLOCK(kvm);
+}
+
+static struct restrictedmem_notifier_ops kvm_restrictedmem_notifier_ops = {
+	.invalidate_start = kvm_restrictedmem_invalidate_begin,
+	.invalidate_end = kvm_restrictedmem_invalidate_end,
+};
+
+static inline void kvm_restrictedmem_register(struct kvm_memory_slot *slot)
+{
+	slot->notifier.ops = &kvm_restrictedmem_notifier_ops;
+	restrictedmem_register_notifier(slot->restricted_file, &slot->notifier);
+}
+
+static inline void kvm_restrictedmem_unregister(struct kvm_memory_slot *slot)
+{
+	restrictedmem_unregister_notifier(slot->restricted_file,
+					  &slot->notifier);
+}
+
+#else /* !CONFIG_HAVE_KVM_RESTRICTED_MEM */
+
+static inline void kvm_restrictedmem_register(struct kvm_memory_slot *slot)
+{
+	WARN_ON_ONCE(1);
+}
+
+static inline void kvm_restrictedmem_unregister(struct kvm_memory_slot *slot)
+{
+	WARN_ON_ONCE(1);
+}
+
+#endif /* CONFIG_HAVE_KVM_RESTRICTED_MEM */
+
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 static int kvm_pm_notifier_call(struct notifier_block *bl,
 				unsigned long state,
@@ -1072,6 +1177,11 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
 /* This does not remove the slot from struct kvm_memslots data structures */
 static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 {
+	if (slot->flags & KVM_MEM_PRIVATE) {
+		kvm_restrictedmem_unregister(slot);
+		fput(slot->restricted_file);
+	}
+
 	kvm_destroy_dirty_bitmap(slot);
 
 	kvm_arch_free_memslot(kvm, slot);
@@ -1643,10 +1753,16 @@ bool __weak kvm_arch_has_private_mem(struct kvm *kvm)
 	return false;
 }
 
-static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
+static int check_memory_region_flags(struct kvm *kvm,
+				     const struct kvm_user_mem_region *mem)
 {
 	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
 
+#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
+	if (kvm_arch_has_private_mem(kvm))
+		valid_flags |= KVM_MEM_PRIVATE;
+#endif
+
 #ifdef __KVM_HAVE_READONLY_MEM
 	valid_flags |= KVM_MEM_READONLY;
 #endif
@@ -1722,6 +1838,9 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
 {
 	int r;
 
+	if (change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE)
+		kvm_restrictedmem_register(new);
+
 	/*
 	 * If dirty logging is disabled, nullify the bitmap; the old bitmap
 	 * will be freed on "commit".  If logging is enabled in both old and
@@ -1750,6 +1869,9 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
 	if (r && new && new->dirty_bitmap && (!old || !old->dirty_bitmap))
 		kvm_destroy_dirty_bitmap(new);
 
+	if (r && change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE)
+		kvm_restrictedmem_unregister(new);
+
 	return r;
 }
 
@@ -2047,7 +2169,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	int as_id, id;
 	int r;
 
-	r = check_memory_region_flags(mem);
+	r = check_memory_region_flags(kvm, mem);
 	if (r)
 		return r;
 
@@ -2066,6 +2188,10 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	     !access_ok((void __user *)(unsigned long)mem->userspace_addr,
 			mem->memory_size))
 		return -EINVAL;
+	if (mem->flags & KVM_MEM_PRIVATE &&
+		(mem->restricted_offset & (PAGE_SIZE - 1) ||
+		 mem->restricted_offset > U64_MAX - mem->memory_size))
+		return -EINVAL;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
 		return -EINVAL;
 	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
@@ -2104,6 +2230,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		if ((kvm->nr_memslot_pages + npages) < kvm->nr_memslot_pages)
 			return -EINVAL;
 	} else { /* Modify an existing slot. */
+		/* Private memslots are immutable, they can only be deleted. */
+		if (mem->flags & KVM_MEM_PRIVATE)
+			return -EINVAL;
 		if ((mem->userspace_addr != old->userspace_addr) ||
 		    (npages != old->npages) ||
 		    ((mem->flags ^ old->flags) & KVM_MEM_READONLY))
@@ -2132,10 +2261,28 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	new->npages = npages;
 	new->flags = mem->flags;
 	new->userspace_addr = mem->userspace_addr;
+	if (mem->flags & KVM_MEM_PRIVATE) {
+		new->restricted_file = fget(mem->restricted_fd);
+		if (!new->restricted_file ||
+		    !file_is_restrictedmem(new->restricted_file)) {
+			r = -EINVAL;
+			goto out;
+		}
+		new->restricted_offset = mem->restricted_offset;
+	}
+
+	new->kvm = kvm;
 
 	r = kvm_set_memslot(kvm, old, new, change);
 	if (r)
-		kfree(new);
+		goto out;
+
+	return 0;
+
+out:
+	if (new->restricted_file)
+		fput(new->restricted_file);
+	kfree(new);
 	return r;
 }
 EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
@@ -4604,6 +4751,11 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_BINARY_STATS_FD:
 	case KVM_CAP_SYSTEM_EVENT_DATA:
 		return 1;
+#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
+	case KVM_CAP_PRIVATE_MEM:
+		return 1;
+#endif
+
 	default:
 		break;
 	}
@@ -4795,16 +4947,28 @@ static long kvm_vm_ioctl(struct file *filp,
 	}
 	case KVM_SET_USER_MEMORY_REGION: {
 		struct kvm_user_mem_region mem;
-		unsigned long size = sizeof(struct kvm_userspace_memory_region);
+		unsigned int flags_offset = offsetof(typeof(mem), flags);
+		unsigned long size;
+		u32 flags;
 
 		kvm_sanity_check_user_mem_region_alias();
 
+		memset(&mem, 0, sizeof(mem));
+
 		r = -EFAULT;
+		if (get_user(flags, (u32 __user *)(argp + flags_offset)))
+			goto out;
+
+		if (flags & KVM_MEM_PRIVATE)
+			size = sizeof(struct kvm_userspace_memory_region_ext);
+		else
+			size = sizeof(struct kvm_userspace_memory_region);
+
 		if (copy_from_user(&mem, argp, size))
 			goto out;
 
 		r = -EINVAL;
-		if (mem.flags & KVM_MEM_PRIVATE)
+		if ((flags ^ mem.flags) & KVM_MEM_PRIVATE)
 			goto out;
 
 		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
-- 
2.25.1

