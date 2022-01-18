Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888F2492734
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243476AbiARNXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:23:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:23096 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239194AbiARNXh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642512217; x=1674048217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WMNkcnSDaEvDrlJP1KgKm0jYnNbblXf6Dmx4W+l5lNg=;
  b=WI9lcyXo8WncTmLnkUnHTCisu7JSQHnqeuG6Ffr+LZDs1lWVwrZgwxgb
   ee0IYfE2QazcVb2LdkCLCrt3mktDX9W5I3VI51XpEaC9I+/0MGeVak7/B
   2JH2oCOOcfV5vD1HINH49rG2eKLxzfpFwUFfKV8j2EPylMOGuLDSSdIrD
   wr4ipODnjsJ5uQMPn5d3uRc578Z6OULTE029kx0KiZTxGGbeMFiztkH1q
   jQCQdSAfb1p4bE+g+goINKSjCAJewGco7eTwm2O6tFuPSvRKodkS1tBbe
   Pq8OBeLy9Wa96OofRq/MZ2xrmR4tyjtN5nNRsIMgul4e82Bp7Dw0f/eJE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="269193767"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="269193767"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 05:23:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="531791967"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2022 05:23:19 -0800
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
Subject: [PATCH v4 12/12] KVM: Expose KVM_MEM_PRIVATE
Date:   Tue, 18 Jan 2022 21:21:21 +0800
Message-Id: <20220118132121.31388-13-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KVM_MEM_PRIVATE is not exposed by default but architecture code can turn
on it by implementing kvm_arch_private_memory_supported().

Also private memslot cannot be movable and the same file+offset can not
be mapped into different GFNs.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 49 ++++++++++++++++++++++++++++++++++------
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 117cf0da9c5e..444b390261c0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1328,6 +1328,7 @@ bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
 int kvm_arch_post_init_vm(struct kvm *kvm);
 void kvm_arch_pre_destroy_vm(struct kvm *kvm);
 int kvm_arch_create_vm_debugfs(struct kvm *kvm);
+bool kvm_arch_private_memory_supported(struct kvm *kvm);
 
 #ifndef __KVM_HAVE_ARCH_VM_ALLOC
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 10e553215618..51d0f08a8601 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1491,10 +1491,19 @@ static void kvm_replace_memslot(struct kvm *kvm,
 	}
 }
 
-static int check_memory_region_flags(const struct kvm_userspace_memory_region *mem)
+bool __weak kvm_arch_private_memory_supported(struct kvm *kvm)
+{
+	return false;
+}
+
+static int check_memory_region_flags(struct kvm *kvm,
+				const struct kvm_userspace_memory_region *mem)
 {
 	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
 
+	if (kvm_arch_private_memory_supported(kvm))
+		valid_flags |= KVM_MEM_PRIVATE;
+
 #ifdef __KVM_HAVE_READONLY_MEM
 	valid_flags |= KVM_MEM_READONLY;
 #endif
@@ -1873,15 +1882,32 @@ static int kvm_set_memslot(struct kvm *kvm,
 }
 
 static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
-				      gfn_t start, gfn_t end)
+				      struct file *file,
+				      gfn_t start, gfn_t end,
+				      loff_t start_off, loff_t end_off)
 {
 	struct kvm_memslot_iter iter;
+	struct kvm_memory_slot *slot;
+	struct inode *inode;
+	int bkt;
 
 	kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
 		if (iter.slot->id != id)
 			return true;
 	}
 
+	/* Disallow mapping the same file+offset into multiple gfns. */
+	if (file) {
+		inode = file_inode(file);
+		kvm_for_each_memslot(slot, bkt, slots) {
+			if (slot->private_file &&
+			     file_inode(slot->private_file) == inode &&
+			     !(end_off <= slot->private_offset ||
+			       start_off >= slot->private_offset
+					     + (slot->npages >> PAGE_SHIFT)))
+				return true;
+		}
+	}
 	return false;
 }
 
@@ -1906,7 +1932,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	int as_id, id;
 	int r;
 
-	r = check_memory_region_flags(mem);
+	r = check_memory_region_flags(kvm, mem);
 	if (r)
 		return r;
 
@@ -1919,10 +1945,12 @@ int __kvm_set_memory_region(struct kvm *kvm,
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
+	if (!(mem->flags & KVM_MEM_PRIVATE) &&
+	    !access_ok((void __user *)(unsigned long)mem->userspace_addr,
 			mem->memory_size))
 		return -EINVAL;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
@@ -1963,6 +1991,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		if ((kvm->nr_memslot_pages + npages) < kvm->nr_memslot_pages)
 			return -EINVAL;
 	} else { /* Modify an existing slot. */
+		/* Private memslots are immutable, they can only be deleted. */
+		if (mem->flags & KVM_MEM_PRIVATE)
+			return -EINVAL;
 		if ((mem->userspace_addr != old->userspace_addr) ||
 		    (npages != old->npages) ||
 		    ((mem->flags ^ old->flags) & KVM_MEM_READONLY))
@@ -1983,7 +2014,11 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	}
 
 	if ((change == KVM_MR_CREATE || change == KVM_MR_MOVE) &&
-	    kvm_check_memslot_overlap(slots, id, base_gfn, base_gfn + npages)) {
+	    kvm_check_memslot_overlap(slots, id, file,
+				      base_gfn, base_gfn + npages,
+				      region_ext->private_offset,
+				      region_ext->private_offset +
+						mem->memory_size)) {
 		r = -EEXIST;
 		goto out;
 	}
-- 
2.17.1

