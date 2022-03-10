Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34984D48F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243092AbiCJOOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243055AbiCJONj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:13:39 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9869A9B5;
        Thu, 10 Mar 2022 06:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646921497; x=1678457497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UDNf/tndP7AKz2Uk9JPtbsxmn9QkdDXr+UJSlA/azbE=;
  b=O+YpcDiy1oXurDZKsyZVFJGI1pPv7DnewXMpBYDVw6YIyq1s4VN9+Ncc
   wLm5S4V1j2GC0AG8q8eP9PaWBn+4LP5wzVddndRBxK7h66QOH/txLZYZH
   4i+DB0Jr5DEQjEhdE5xoR681vqcHUFE4UXS9i/axp+bLcPo2kQ6X032dK
   GONoT3dk4umm9NRp53s+Wrm46e32mqEKPyiTosJCI/N7dvOge5C9gmnZR
   I+8FraorLY6y5PKl6V8F1aoT5MgdKpxunySqL3sPEkvY80DJJ1ZQwDwgb
   tQqxsp1ui5yJB3K7Kz1AGxZoujLjAwWqKqGfZQ34aad4tDkYw/7SD4FiR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="242702811"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="242702811"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:11:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554655204"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 06:10:56 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v5 11/13] KVM: Zap existing KVM mappings when pages changed in the private fd
Date:   Thu, 10 Mar 2022 22:09:09 +0800
Message-Id: <20220310140911.50924-12-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KVM gets notified when memory pages changed in the memory backing store.
When userspace allocates the memory with fallocate() or frees memory
with fallocate(FALLOC_FL_PUNCH_HOLE), memory backing store calls into
KVM fallocate/invalidate callbacks respectively. To ensure KVM never
maps both the private and shared variants of a GPA into the guest, in
the fallocate callback, we should zap the existing shared mapping and
in the invalidate callback we should zap the existing private mapping.

In the callbacks, KVM firstly converts the offset range into the
gfn_range and then calls existing kvm_unmap_gfn_range() which will zap
the shared or private mapping. Both callbacks pass in a memslot
reference but we need 'kvm' so add a reference in memslot structure.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |  3 ++-
 virt/kvm/kvm_main.c      | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9b175aeca63f..186b9b981a65 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -236,7 +236,7 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #endif
 
-#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
+#if defined(KVM_ARCH_WANT_MMU_NOTIFIER) || defined(CONFIG_MEMFILE_NOTIFIER)
 struct kvm_gfn_range {
 	struct kvm_memory_slot *slot;
 	gfn_t start;
@@ -568,6 +568,7 @@ struct kvm_memory_slot {
 	loff_t private_offset;
 	struct memfile_pfn_ops *pfn_ops;
 	struct memfile_notifier notifier;
+	struct kvm *kvm;
 };
 
 static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 67349421eae3..52319f49d58a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -841,8 +841,43 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
 
 #ifdef CONFIG_MEMFILE_NOTIFIER
+static void kvm_memfile_notifier_handler(struct memfile_notifier *notifier,
+					 pgoff_t start, pgoff_t end)
+{
+	int idx;
+	struct kvm_memory_slot *slot = container_of(notifier,
+						    struct kvm_memory_slot,
+						    notifier);
+	struct kvm_gfn_range gfn_range = {
+		.slot		= slot,
+		.start		= start - (slot->private_offset >> PAGE_SHIFT),
+		.end		= end - (slot->private_offset >> PAGE_SHIFT),
+		.may_block 	= true,
+	};
+	struct kvm *kvm = slot->kvm;
+
+	gfn_range.start = max(gfn_range.start, slot->base_gfn);
+	gfn_range.end = min(gfn_range.end, slot->base_gfn + slot->npages);
+
+	if (gfn_range.start >= gfn_range.end)
+		return;
+
+	idx = srcu_read_lock(&kvm->srcu);
+	KVM_MMU_LOCK(kvm);
+	kvm_unmap_gfn_range(kvm, &gfn_range);
+	kvm_flush_remote_tlbs(kvm);
+	KVM_MMU_UNLOCK(kvm);
+	srcu_read_unlock(&kvm->srcu, idx);
+}
+
+static struct memfile_notifier_ops kvm_memfile_notifier_ops = {
+	.invalidate = kvm_memfile_notifier_handler,
+	.fallocate = kvm_memfile_notifier_handler,
+};
+
 static inline int kvm_memfile_register(struct kvm_memory_slot *slot)
 {
+	slot->notifier.ops = &kvm_memfile_notifier_ops;
 	return memfile_register_notifier(file_inode(slot->private_file),
 					 &slot->notifier,
 					 &slot->pfn_ops);
@@ -1963,6 +1998,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	new->private_file = file;
 	new->private_offset = mem->flags & KVM_MEM_PRIVATE ?
 			      region_ext->private_offset : 0;
+	new->kvm = kvm;
 
 	r = kvm_set_memslot(kvm, old, new, change);
 	if (!r)
-- 
2.17.1

