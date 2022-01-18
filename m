Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B089949272E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbiARNXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:23:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:23105 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234488AbiARNXg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642512216; x=1674048216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Doiq2R3hAItBU5LQnTBxQCkUWyVHPsvtgI1nQR7ap4A=;
  b=VTH0UeXkWQffOiJ85URJghn7A7SpieAcgukEl1XFuVfQkjVbxiErW/Dg
   9q9rVCE/MDD2fwQqPPmnbaD+iHy7zBYJz/HnKK9S5uQA0ATOXBYMLZoVw
   qWfJNqZo2U9cP9XLm4GHReZ23HErQpM+KQDNDfsXU6TeUjD7a8P47rlr/
   CYuaR9N/ejA2Gp7wXnU3auM9bph6KLg/gG7S94qUN8Wnncp+tFsM/nWlK
   2tnZ/h5EQIqit0W1PVM2sMFc4tOYGpAkqQRwCxgDx27rvPEygOLN66UbK
   AYQEoJWFKSCYRYL7uHyWtyoxhGB59m2Y9GarvIQLULau6MU65YnA3SJCu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="269193757"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="269193757"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 05:23:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="531791936"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2022 05:23:11 -0800
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
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v4 11/12] KVM: Zap existing KVM mappings when pages changed in the private fd
Date:   Tue, 18 Jan 2022 21:21:20 +0800
Message-Id: <20220118132121.31388-12-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
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
index 667efe839767..117cf0da9c5e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -235,7 +235,7 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #endif
 
-#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
+#if defined(KVM_ARCH_WANT_MMU_NOTIFIER) || defined(CONFIG_MEMFILE_NOTIFIER)
 struct kvm_gfn_range {
 	struct kvm_memory_slot *slot;
 	gfn_t start;
@@ -463,6 +463,7 @@ struct kvm_memory_slot {
 	loff_t private_offset;
 	struct memfile_pfn_ops *pfn_ops;
 	struct memfile_notifier notifier;
+	struct kvm *kvm;
 };
 
 static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6b78ddef7880..10e553215618 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -847,8 +847,43 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
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
@@ -1969,6 +2004,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	new->private_file = file;
 	new->private_offset = mem->flags & KVM_MEM_PRIVATE ?
 			      region_ext->private_offset : 0;
+	new->kvm = kvm;
 
 	r = kvm_set_memslot(kvm, old, new, change);
 	if (!r)
-- 
2.17.1

