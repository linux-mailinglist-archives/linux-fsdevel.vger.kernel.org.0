Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1915C49272C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiARNXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:23:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:57296 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234907AbiARNX1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642512207; x=1674048207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=EeAqQ9F4s9hLs6erZUPGg6L9PNHtGyg9c724TwmrBc4=;
  b=mdinzFsq+W20Dg0jbxVVwfpOX8filBTzKM6zox39NcWKLGdbW1bfPAu3
   SqGxfVEyWHsxtZ/NEIxuHG/hUO3SSnED2/51f843XEywSNfWp1FsX6I+8
   HU0mFwnNBmrc/U4qcchX84LIdP7GLcHMXvz1ozLSPb3dxCPOp33UEsQY6
   Z4v6ejA0Fv/0uMwQnTWGCCiv6SbYhzqflXj5AmKPNms0LkJRwu/Y1Bycu
   /3RJcQTsNa4CI1LL/MXSwef3Imm9+ytrYyMtkgd9qupWVy4rAJAeoCevI
   wUQ691jwTv1a0Nu5QsMequjLgcDdjsOLS7QKKI1Ig/hRTq5+Zw3oHzkzt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="232172020"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="232172020"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 05:23:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="531791917"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2022 05:23:04 -0800
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
Subject: [PATCH v4 10/12] KVM: Register private memslot to memory backing store
Date:   Tue, 18 Jan 2022 21:21:19 +0800
Message-Id: <20220118132121.31388-11-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
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
index 927e7f44a02a..667efe839767 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -462,6 +462,7 @@ struct kvm_memory_slot {
 	struct file *private_file;
 	loff_t private_offset;
 	struct memfile_pfn_ops *pfn_ops;
+	struct memfile_notifier notifier;
 };
 
 static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ecf94e2548f7..6b78ddef7880 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -846,6 +846,37 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 
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
@@ -890,6 +921,9 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
 /* This does not remove the slot from struct kvm_memslots data structures */
 static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 {
+	if (slot->flags & KVM_MEM_PRIVATE)
+		kvm_memfile_unregister(slot);
+
 	kvm_destroy_dirty_bitmap(slot);
 
 	kvm_arch_free_memslot(kvm, slot);
@@ -1744,6 +1778,12 @@ static int kvm_set_memslot(struct kvm *kvm,
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
@@ -1758,6 +1798,10 @@ static int kvm_set_memslot(struct kvm *kvm,
 		} else {
 			mutex_unlock(&kvm->slots_arch_lock);
 		}
+
+		if (new->flags & KVM_MEM_PRIVATE && change == KVM_MR_CREATE)
+			kvm_memfile_unregister(new);
+
 		return r;
 	}
 
@@ -1823,6 +1867,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	enum kvm_mr_change change;
 	unsigned long npages;
 	gfn_t base_gfn;
+	struct file *file = NULL;
 	int as_id, id;
 	int r;
 
@@ -1896,14 +1941,24 @@ int __kvm_set_memory_region(struct kvm *kvm,
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
@@ -1911,10 +1966,18 @@ int __kvm_set_memory_region(struct kvm *kvm,
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

