Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F4847C288
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbhLUPOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:14:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:56050 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239203AbhLUPOE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640099644; x=1671635644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=We7gK/h+jEknZOV42LJTALD74jcdTiL5CfglrMRHFxI=;
  b=agCPuVx8JsdpkpYpKJR3WvUNB+rjROd49vaYMAbyCuq3I2bQStc/S4cM
   mXuiAY3Uc034Mn5EZutFf4KZtOovUUHVwgI0wFDfwlTYvd1XXtRlRwD/2
   p2XIjGoe0RGqqJfPUtv3WD5tq7Ox4ZAXxlCk4zki/WLwW4lYB7YBuHXFT
   TmIpaEY6YJ8Wbrx2NZCP23nhR4az/henWGp43C9m+lhr5Zwm7OK3BGD6T
   ga+8xmLHOP12U9VwR1yOpyG5pbi5jLPjCaREqnDkpD6+oMDpYuAQZuyMd
   lzTFa2rw89j8fFo4kCAY/h+YJ2Fm+dAoArBP4Rlng/CTb0CA5MkJMwYXT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240216779"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="240216779"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 07:14:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684688711"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 07:13:56 -0800
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
Subject: [PATCH v3 15/15] KVM: Register/unregister private memory slot to memfd
Date:   Tue, 21 Dec 2021 23:11:25 +0800
Message-Id: <20211221151125.19446-16-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
References: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expose KVM_MEM_PRIVATE flag and register/unregister private memory
slot to memfd when userspace sets the flag.

KVM_MEM_PRIVATE is disallowed by default but architecture code can
turn it on by implementing kvm_arch_private_memory_supported().

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0c53df0a6b2e..0f0e24f19892 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1096,6 +1096,8 @@ int kvm_arch_post_init_vm(struct kvm *kvm);
 void kvm_arch_pre_destroy_vm(struct kvm *kvm);
 int kvm_arch_create_vm_debugfs(struct kvm *kvm);
 bool kvm_arch_dirty_log_supported(struct kvm *kvm);
+bool kvm_arch_private_memory_supported(struct kvm *kvm);
+
 
 #ifndef __KVM_HAVE_ARCH_VM_ALLOC
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 79313c549fb9..6eb0d86abdcf 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1509,6 +1509,11 @@ bool __weak kvm_arch_dirty_log_supported(struct kvm *kvm)
 	return true;
 }
 
+bool __weak kvm_arch_private_memory_supported(struct kvm *kvm)
+{
+	return false;
+}
+
 static int check_memory_region_flags(struct kvm *kvm,
 			     const struct kvm_userspace_memory_region_ext *mem)
 {
@@ -1517,6 +1522,9 @@ static int check_memory_region_flags(struct kvm *kvm,
 	if (kvm_arch_dirty_log_supported(kvm))
 		valid_flags |= KVM_MEM_LOG_DIRTY_PAGES;
 
+	if (kvm_arch_private_memory_supported(kvm))
+		valid_flags |= KVM_MEM_PRIVATE;
+
 #ifdef __KVM_HAVE_READONLY_MEM
 	valid_flags |= KVM_MEM_READONLY;
 #endif
@@ -1708,9 +1716,21 @@ static int kvm_set_memslot(struct kvm *kvm,
 	/* Copy the arch-specific data, again after (re)acquiring slots_arch_lock. */
 	memcpy(&new->arch, &old.arch, sizeof(old.arch));
 
+	if (mem->flags & KVM_MEM_PRIVATE && change == KVM_MR_CREATE) {
+		r = kvm_memfd_register(kvm, mem, new);
+		if (r)
+			goto out_slots;
+	}
+
 	r = kvm_arch_prepare_memory_region(kvm, new, mem, change);
-	if (r)
+	if (r) {
+		if (mem->flags & KVM_MEM_PRIVATE && change == KVM_MR_CREATE)
+			kvm_memfd_unregister(kvm, new);
 		goto out_slots;
+	}
+
+	if (mem->flags & KVM_MEM_PRIVATE && change == KVM_MR_DELETE)
+		kvm_memfd_unregister(kvm, new);
 
 	update_memslots(slots, new, change);
 	slots = install_new_memslots(kvm, as_id, slots);
@@ -1786,10 +1806,12 @@ int __kvm_set_memory_region(struct kvm *kvm,
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
@@ -1821,6 +1843,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	new.npages = mem->memory_size >> PAGE_SHIFT;
 	new.flags = mem->flags;
 	new.userspace_addr = mem->userspace_addr;
+	new.file = NULL;
+	new.file_ofs = 0;
 
 	if (new.npages > KVM_MEM_MAX_NR_PAGES)
 		return -EINVAL;
@@ -1829,6 +1853,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		change = KVM_MR_CREATE;
 		new.dirty_bitmap = NULL;
 	} else { /* Modify an existing slot. */
+		/* Private memslots are immutable, they can only be deleted. */
+		if (mem->flags & KVM_MEM_PRIVATE)
+			return -EINVAL;
 		if ((new.userspace_addr != old.userspace_addr) ||
 		    (new.npages != old.npages) ||
 		    ((new.flags ^ old.flags) & KVM_MEM_READONLY))
-- 
2.17.1

