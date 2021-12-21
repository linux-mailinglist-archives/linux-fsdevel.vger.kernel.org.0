Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FD247C280
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbhLUPNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:13:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:56009 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232682AbhLUPNo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640099624; x=1671635624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lwc3ZTobl3LT/VFyxod/1mSSsZKwyN5jd9bV9BUSQp0=;
  b=c5kUBbntEVG2G41z2dZrWzIvKoaYPYFrq2nvo4urtbTj8dojlNOs1s9y
   fQVUnB+oAUSuXRwEbI+FD8XPgagldCVG2ySkjnk9Pgf1uBvpWI6h+ZY3v
   PuikC/s1QCkXarP+vP/Hs6pwPM5uM+h7kh9TrKjYmWALeRUwpuj8uFWeT
   PXoMx40akGRri7YSrWiVZR/q3wq7AAlB++1vY57UO5m/1KXtVd4I4YZDL
   zGev8s0P031w2jczOV/Z6qZzdI7PejFqkMcj8i9uYl+hpvxKOTt2hofsC
   urKw1Stu3KBcrBNmMLf1t9jzRjfE1IvmQlFB2lpoENo7H8E9wxEsn6Okr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240216715"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="240216715"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 07:13:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684688572"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 07:13:26 -0800
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
Subject: [PATCH v3 11/15] KVM: Implement fd-based memory fallocation
Date:   Tue, 21 Dec 2021 23:11:21 +0800
Message-Id: <20211221151125.19446-12-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
References: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KVM gets notified through memfd_notifier when user space allocate space
via fallocate() on the fd which is used for guest memory. KVM can set up
the mapping in the secondary MMU page tables at this time. This patch
adds function in KVM to map pfn to gfn when the page is allocated in the
memory backend.

While it's possible to postpone the mapping of the secondary MMU to KVM
page fault handler but we can reduce some VMExits by also mapping the
secondary page tables when a page is mapped in the primary MMU.

It reuses the same code for kvm_memfd_invalidate_range, except using
kvm_map_gfn_range as its handler.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 22 +++++++++++++++++++---
 virt/kvm/memfd.c         |  2 ++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9c02fb53b8ab..1f69d76983a2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1879,6 +1879,8 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
 #ifdef CONFIG_MEMFD_OPS
 int kvm_memfd_invalidate_range(struct kvm *kvm, struct inode *inode,
 			       unsigned long start, unsigned long end);
+int kvm_memfd_fallocate_range(struct kvm *kvm, struct inode *inode,
+			      unsigned long start, unsigned long end);
 #endif /* CONFIG_MEMFD_OPS */
 
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b9855b2fdaae..1b7cf05759c7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -860,15 +860,17 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
 
 #ifdef CONFIG_MEMFD_OPS
-int kvm_memfd_invalidate_range(struct kvm *kvm, struct inode *inode,
-			       unsigned long start, unsigned long end)
+int kvm_memfd_handle_range(struct kvm *kvm, struct inode *inode,
+			   unsigned long start, unsigned long end,
+			   gfn_handler_t handler)
+
 {
 	int ret;
 	const struct kvm_useraddr_range useraddr_range = {
 		.start		= start,
 		.end		= end,
 		.pte		= __pte(0),
-		.handler	= kvm_unmap_gfn_range,
+		.handler	= handler,
 		.on_lock	= (void *)kvm_null_fn,
 		.flush_on_ret	= true,
 		.may_block	= false,
@@ -883,6 +885,20 @@ int kvm_memfd_invalidate_range(struct kvm *kvm, struct inode *inode,
 
 	return ret;
 }
+
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
 #endif /* CONFIG_MEMFD_OPS */
 
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
diff --git a/virt/kvm/memfd.c b/virt/kvm/memfd.c
index d092a9b6f496..e7a2ab790cc6 100644
--- a/virt/kvm/memfd.c
+++ b/virt/kvm/memfd.c
@@ -23,6 +23,8 @@ static void memfd_invalidate_page_range(struct inode *inode, void *owner,
 static void memfd_fallocate(struct inode *inode, void *owner,
 			    pgoff_t start, pgoff_t end)
 {
+	kvm_memfd_fallocate_range(owner, inode, start >> PAGE_SHIFT,
+						end >> PAGE_SHIFT);
 }
 
 static bool memfd_get_owner(void *owner)
-- 
2.17.1

