Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7025C45700A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 14:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhKSNxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 08:53:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:30727 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235800AbhKSNxP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:53:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="221632487"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="221632487"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 05:50:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="507905238"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2021 05:50:05 -0800
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
Subject: [RFC v2 PATCH 12/13] KVM: Introduce kvm_memfd_fallocate_range
Date:   Fri, 19 Nov 2021 21:47:38 +0800
Message-Id: <20211119134739.20218-13-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It reuses the same code for kvm_memfd_invalidate_range, except using
kvm_map_gfn_range as its handler.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 28 +++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d841ed877b4b..f1d7856be05b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1887,5 +1887,7 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
 
 int kvm_memfd_invalidate_range(struct kvm *kvm, struct inode *inode,
 			       unsigned long start, unsigned long end);
+int kvm_memfd_fallocate_range(struct kvm *kvm, struct inode *inode,
+			      unsigned long start, unsigned long end);
 
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 492c1a99ec63..7eaafc0ae6ab 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -828,8 +828,10 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 	return mmu_notifier_register(&kvm->mmu_notifier, current->mm);
 }
 
-int kvm_memfd_invalidate_range(struct kvm *kvm, struct inode *inode,
-			       unsigned long start, unsigned long end)
+int kvm_memfd_handle_range(struct kvm *kvm, struct inode *inode,
+			   unsigned long start, unsigned long end,
+			   gfn_handler_t handler)
+
 {
 	int ret;
 	const struct kvm_useraddr_range useraddr_range = {
@@ -837,7 +839,7 @@ int kvm_memfd_invalidate_range(struct kvm *kvm, struct inode *inode,
 		.end		= end,
 		.inode		= inode,
 		.pte		= __pte(0),
-		.handler	= kvm_unmap_gfn_range,
+		.handler	= handler,
 		.on_lock	= (void *)kvm_null_fn,
 		.flush_on_ret	= true,
 		.may_block	= false,
@@ -858,6 +860,20 @@ int kvm_memfd_invalidate_range(struct kvm *kvm, struct inode *inode,
 	return ret;
 }
 
+int kvm_memfd_invalidate_range(struct kvm *kvm, struct inode *inode,
+			       unsigned long start, unsigned long end)
+{
+	return kvm_memfd_handle_range(kvm, inode, start, end,
+				      kvm_unmap_gfn_range);
+}
+
+int kvm_memfd_fallocate_range(struct kvm *kvm, struct inode *inode,
+			      unsigned long start, unsigned long end)
+{
+	return kvm_memfd_handle_range(kvm, inode, start, end,
+				      kvm_map_gfn_range);
+}
+
 #else  /* !(CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER) */
 
 static int kvm_init_mmu_notifier(struct kvm *kvm)
@@ -871,6 +887,12 @@ int kvm_memfd_invalidate_range(struct kvm *kvm, struct inode *inode,
 	return 0;
 }
 
+int kvm_memfd_fallocate_range(struct kvm *kvm, struct inode *inode,
+			      unsigned long start, unsigned long end)
+{
+	return 0;
+}
+
 #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
 
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
-- 
2.17.1

