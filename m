Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1334D4928
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbiCJONl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbiCJONC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:13:02 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AF015694C;
        Thu, 10 Mar 2022 06:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646921480; x=1678457480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dJciXpEHLFj6Z+EAfDFvGxoZXvWRu/tGM+jdlgCTKlE=;
  b=Js2cUaBkpKSpZ2f+bQu0e7Lq8W9rIAI3MQoOOEaEh5WQaOMkMXTMoKdJ
   HRkqWCOWgyt7zDICbp3zC2lArsOpGhv75JsDbR80rFTaY9Pa057PQjVob
   vYy0CtKv5iJmts/UIK96OKSkEqEqPObvvJ1Xkt6t6ezjnNhxTHCPJA0qC
   U09Wngd7+C5MTe+bdJwCOngIf77CQrNBRsPUnGgsk8LXtpSmV9PJesf8i
   q51wtmEurz3TifUvoG6dO8/xTLoj8tlPLF9NqV0BwoyhMjDYJAOXe4vny
   loSSqhC8NDLAr4t85Ap37dilJ7AfKfu8yQHH4qkChqpFMJCNWQLjomSTc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="252823625"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="252823625"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:10:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554655136"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 06:10:49 -0800
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
Subject: [PATCH v5 10/13] KVM: Register private memslot to memory backing store
Date:   Thu, 10 Mar 2022 22:09:08 +0800
Message-Id: <20220310140911.50924-11-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add 'notifier' to memslot to make it a memfile_notifier node and then
register it to memory backing store via memfile_register_notifier() when
memslot gets created. When memslot is deleted, do the reverse with
memfile_unregister_notifier(). Note each KVM memslot can be registered
to different memory backing stores (or the same backing store but at
different offset) independently.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 75 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6e1d770d6bf8..9b175aeca63f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -567,6 +567,7 @@ struct kvm_memory_slot {
 	struct file *private_file;
 	loff_t private_offset;
 	struct memfile_pfn_ops *pfn_ops;
+	struct memfile_notifier notifier;
 };
 
 static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d11a2628b548..67349421eae3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -840,6 +840,37 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 
 #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
 
+#ifdef CONFIG_MEMFILE_NOTIFIER
+static inline int kvm_memfile_register(struct kvm_memory_slot *slot)
+{
+	return memfile_register_notifier(file_inode(slot->private_file),
+					 &slot->notifier,
+					 &slot->pfn_ops);
+}
+
+static inline void kvm_memfile_unregister(struct kvm_memory_slot *slot)
+{
+	if (slot->private_file) {
+		memfile_unregister_notifier(file_inode(slot->private_file),
+					    &slot->notifier);
+		fput(slot->private_file);
+		slot->private_file = NULL;
+	}
+}
+
+#else /* !CONFIG_MEMFILE_NOTIFIER */
+
+static inline int kvm_memfile_register(struct kvm_memory_slot *slot)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void kvm_memfile_unregister(struct kvm_memory_slot *slot)
+{
+}
+
+#endif /* CONFIG_MEMFILE_NOTIFIER */
+
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 static int kvm_pm_notifier_call(struct notifier_block *bl,
 				unsigned long state,
@@ -884,6 +915,9 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
 /* This does not remove the slot from struct kvm_memslots data structures */
 static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 {
+	if (slot->flags & KVM_MEM_PRIVATE)
+		kvm_memfile_unregister(slot);
+
 	kvm_destroy_dirty_bitmap(slot);
 
 	kvm_arch_free_memslot(kvm, slot);
@@ -1738,6 +1772,12 @@ static int kvm_set_memslot(struct kvm *kvm,
 		kvm_invalidate_memslot(kvm, old, invalid_slot);
 	}
 
+	if (new->flags & KVM_MEM_PRIVATE && change == KVM_MR_CREATE) {
+		r = kvm_memfile_register(new);
+		if (r)
+			return r;
+	}
+
 	r = kvm_prepare_memory_region(kvm, old, new, change);
 	if (r) {
 		/*
@@ -1752,6 +1792,10 @@ static int kvm_set_memslot(struct kvm *kvm,
 		} else {
 			mutex_unlock(&kvm->slots_arch_lock);
 		}
+
+		if (new->flags & KVM_MEM_PRIVATE && change == KVM_MR_CREATE)
+			kvm_memfile_unregister(new);
+
 		return r;
 	}
 
@@ -1817,6 +1861,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	enum kvm_mr_change change;
 	unsigned long npages;
 	gfn_t base_gfn;
+	struct file *file = NULL;
 	int as_id, id;
 	int r;
 
@@ -1890,14 +1935,24 @@ int __kvm_set_memory_region(struct kvm *kvm,
 			return 0;
 	}
 
+	if (mem->flags & KVM_MEM_PRIVATE) {
+		file = fdget(region_ext->private_fd).file;
+		if (!file)
+			return -EINVAL;
+	}
+
 	if ((change == KVM_MR_CREATE || change == KVM_MR_MOVE) &&
-	    kvm_check_memslot_overlap(slots, id, base_gfn, base_gfn + npages))
-		return -EEXIST;
+	    kvm_check_memslot_overlap(slots, id, base_gfn, base_gfn + npages)) {
+		r = -EEXIST;
+		goto out;
+	}
 
 	/* Allocate a slot that will persist in the memslot. */
 	new = kzalloc(sizeof(*new), GFP_KERNEL_ACCOUNT);
-	if (!new)
-		return -ENOMEM;
+	if (!new) {
+		r = -ENOMEM;
+		goto out;
+	}
 
 	new->as_id = as_id;
 	new->id = id;
@@ -1905,10 +1960,18 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	new->npages = npages;
 	new->flags = mem->flags;
 	new->userspace_addr = mem->userspace_addr;
+	new->private_file = file;
+	new->private_offset = mem->flags & KVM_MEM_PRIVATE ?
+			      region_ext->private_offset : 0;
 
 	r = kvm_set_memslot(kvm, old, new, change);
-	if (r)
-		kfree(new);
+	if (!r)
+		return r;
+
+	kfree(new);
+out:
+	if (file)
+		fput(file);
 	return r;
 }
 EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
-- 
2.17.1

