Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F324156813C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 10:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiGFI1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 04:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiGFI1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:27:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEF824951;
        Wed,  6 Jul 2022 01:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657095984; x=1688631984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=btM1la5Pz1GNel76VNHG7FnCfSGO0SToWA3Mb7+FUy8=;
  b=P92jnDz/bjiOVm6yuG7oMQDt9dFMPPKcvBAYcZ5kdrI60FrZaC8b1zMQ
   uA+vcr8jJI6Evl1MJtyWyOsrGs5jNSSQC8qPHU6gu+XHx/rvfgikxJt+I
   Svu4XXTa4U2cL87KqAeNS1veF4+oueg1eL7lSR7AEm3ofx00Z3L8hQSEZ
   mUyJRb4kKX1KTkm46/gNW0u/QYxymg+KSQ8ezNbkwjgd8QJD0L8ZZFgTE
   FHDOAzjK3RMQ9TnJSby/IlfVV5HM+MxUEcFSAdaP0E4Vf7ZKdZF0ktoBW
   6w4g28hM2WxdVwk2jEzDbikdMhQgr+nCVWaaebDQl+CdBBkKK+Pvnh244
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="281232196"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="281232196"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 01:26:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="567968337"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 01:26:03 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 13/14] KVM: Enable and expose KVM_MEM_PRIVATE
Date:   Wed,  6 Jul 2022 16:20:15 +0800
Message-Id: <20220706082016.2603916-14-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Register private memslot to fd-based memory backing store and handle the
memfile notifiers to zap the existing mappings.

Currently the register is happened at memslot creating time and the
initial support does not include page migration/swap.

KVM_MEM_PRIVATE is not exposed by default, architecture code can turn
on it by implementing kvm_arch_private_mem_supported().

A 'kvm' reference is added in memslot structure since in
memfile_notifier callbacks we can only obtain a memslot reference while
kvm is need to do the zapping.

Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |   1 +
 virt/kvm/kvm_main.c      | 117 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 109 insertions(+), 9 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 8f56426aa1e3..4e5a0db68799 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -584,6 +584,7 @@ struct kvm_memory_slot {
 	struct file *private_file;
 	loff_t private_offset;
 	struct memfile_notifier notifier;
+	struct kvm *kvm;
 };
 
 static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index bb714c2a4b06..d6f7e074cab2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -941,6 +941,63 @@ static int kvm_vm_ioctl_set_encrypted_region(struct kvm *kvm, unsigned int ioctl
 
 	return r;
 }
+
+static void kvm_memfile_notifier_invalidate(struct memfile_notifier *notifier,
+					    pgoff_t start, pgoff_t end)
+{
+	struct kvm_memory_slot *slot = container_of(notifier,
+						    struct kvm_memory_slot,
+						    notifier);
+	unsigned long base_pgoff = slot->private_offset >> PAGE_SHIFT;
+	gfn_t start_gfn = slot->base_gfn;
+	gfn_t end_gfn = slot->base_gfn + slot->npages;
+
+
+	if (start > base_pgoff)
+		start_gfn = slot->base_gfn + start - base_pgoff;
+
+	if (end < base_pgoff + slot->npages)
+		end_gfn = slot->base_gfn + end - base_pgoff;
+
+	if (start_gfn >= end_gfn)
+		return;
+
+	kvm_zap_gfn_range(slot->kvm, start_gfn, end_gfn);
+}
+
+static struct memfile_notifier_ops kvm_memfile_notifier_ops = {
+	.invalidate = kvm_memfile_notifier_invalidate,
+};
+
+#define KVM_MEMFILE_FLAGS (MEMFILE_F_USER_INACCESSIBLE | \
+			   MEMFILE_F_UNMOVABLE | \
+			   MEMFILE_F_UNRECLAIMABLE)
+
+static inline int kvm_private_mem_register(struct kvm_memory_slot *slot)
+{
+	slot->notifier.ops = &kvm_memfile_notifier_ops;
+	return memfile_register_notifier(slot->private_file, KVM_MEMFILE_FLAGS,
+					 &slot->notifier);
+}
+
+static inline void kvm_private_mem_unregister(struct kvm_memory_slot *slot)
+{
+	memfile_unregister_notifier(&slot->notifier);
+}
+
+#else /* !CONFIG_HAVE_KVM_PRIVATE_MEM */
+
+static inline int kvm_private_mem_register(struct kvm_memory_slot *slot)
+{
+	WARN_ON_ONCE(1);
+	return -EOPNOTSUPP;
+}
+
+static inline void kvm_private_mem_unregister(struct kvm_memory_slot *slot)
+{
+	WARN_ON_ONCE(1);
+}
+
 #endif /* CONFIG_HAVE_KVM_PRIVATE_MEM */
 
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
@@ -987,6 +1044,11 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
 /* This does not remove the slot from struct kvm_memslots data structures */
 static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 {
+	if (slot->flags & KVM_MEM_PRIVATE) {
+		kvm_private_mem_unregister(slot);
+		fput(slot->private_file);
+	}
+
 	kvm_destroy_dirty_bitmap(slot);
 
 	kvm_arch_free_memslot(kvm, slot);
@@ -1548,10 +1610,16 @@ bool __weak kvm_arch_private_mem_supported(struct kvm *kvm)
 	return false;
 }
 
-static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
+static int check_memory_region_flags(struct kvm *kvm,
+				     const struct kvm_user_mem_region *mem)
 {
 	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
 
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
+	if (kvm_arch_private_mem_supported(kvm))
+		valid_flags |= KVM_MEM_PRIVATE;
+#endif
+
 #ifdef __KVM_HAVE_READONLY_MEM
 	valid_flags |= KVM_MEM_READONLY;
 #endif
@@ -1627,6 +1695,12 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
 {
 	int r;
 
+	if (change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE) {
+		r = kvm_private_mem_register(new);
+		if (r)
+			return r;
+	}
+
 	/*
 	 * If dirty logging is disabled, nullify the bitmap; the old bitmap
 	 * will be freed on "commit".  If logging is enabled in both old and
@@ -1655,6 +1729,9 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
 	if (r && new && new->dirty_bitmap && (!old || !old->dirty_bitmap))
 		kvm_destroy_dirty_bitmap(new);
 
+	if (r && change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE)
+		kvm_private_mem_unregister(new);
+
 	return r;
 }
 
@@ -1952,7 +2029,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	int as_id, id;
 	int r;
 
-	r = check_memory_region_flags(mem);
+	r = check_memory_region_flags(kvm, mem);
 	if (r)
 		return r;
 
@@ -1971,6 +2048,10 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	     !access_ok((void __user *)(unsigned long)mem->userspace_addr,
 			mem->memory_size))
 		return -EINVAL;
+	if (mem->flags & KVM_MEM_PRIVATE &&
+		(mem->private_offset & (PAGE_SIZE - 1) ||
+		 mem->private_offset > U64_MAX - mem->memory_size))
+		return -EINVAL;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
 		return -EINVAL;
 	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
@@ -2009,6 +2090,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		if ((kvm->nr_memslot_pages + npages) < kvm->nr_memslot_pages)
 			return -EINVAL;
 	} else { /* Modify an existing slot. */
+		/* Private memslots are immutable, they can only be deleted. */
+		if (mem->flags & KVM_MEM_PRIVATE)
+			return -EINVAL;
 		if ((mem->userspace_addr != old->userspace_addr) ||
 		    (npages != old->npages) ||
 		    ((mem->flags ^ old->flags) & KVM_MEM_READONLY))
@@ -2037,10 +2121,27 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	new->npages = npages;
 	new->flags = mem->flags;
 	new->userspace_addr = mem->userspace_addr;
+	if (mem->flags & KVM_MEM_PRIVATE) {
+		new->private_file = fget(mem->private_fd);
+		if (!new->private_file) {
+			r = -EINVAL;
+			goto out;
+		}
+		new->private_offset = mem->private_offset;
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
+	if (new->private_file)
+		fput(new->private_file);
+	kfree(new);
 	return r;
 }
 EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
@@ -4712,12 +4813,10 @@ static long kvm_vm_ioctl(struct file *filp,
 			(u32 __user *)(argp + offsetof(typeof(mem), flags))))
 			goto out;
 
-		if (flags & KVM_MEM_PRIVATE) {
-			r = -EINVAL;
-			goto out;
-		}
-
-		size = sizeof(struct kvm_userspace_memory_region);
+		if (flags & KVM_MEM_PRIVATE)
+			size = sizeof(struct kvm_userspace_memory_region_ext);
+		else
+			size = sizeof(struct kvm_userspace_memory_region);
 
 		if (copy_from_user(&mem, argp, size))
 			goto out;
-- 
2.25.1

