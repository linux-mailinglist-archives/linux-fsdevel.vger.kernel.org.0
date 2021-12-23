Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC2847E377
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 13:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348442AbhLWMcc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 07:32:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:24553 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348438AbhLWMcc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640262752; x=1671798752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=YEqJBACRcYF6r6P724iXUNeYRL5G8D47PprkAJHUqo4=;
  b=EBCSZr5mJqgM/pr2FPQCwa9mqHEYE+ermtDCZ9Ndmk3exKnZjrKtZTKy
   qSNQjs0FpHtC8nyGDY9ZEzQjQosc6Mm2CQpzagf4lehLfY8nBrN34oSNd
   kiFCrEJskmfeYnbQ69VmUTyzw108Pj53EZo4UN38mnZzEL7Sur4N692d2
   QOoWiBxW4KWdGy+1ITYMxDaUlrQ/dg6EcS1Hz2tnaJ5kRQyjY+6rt7Wv8
   MCty1LEABiI0s19QfHKA5XFzCN8iK9yiGctPV9gfilbkqCqi/LNwvkZ0Z
   rz3/E0SriILHhEQoJFKtaYS2DCH/JbN1/Uoum4Cbh7snO1K4IgWWZJiO9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="227661127"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="227661127"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 04:32:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="522078999"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2021 04:32:24 -0800
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
Subject: [PATCH v3 kvm/queue 12/16] KVM: Implement fd-based memory fallocation
Date:   Thu, 23 Dec 2021 20:30:07 +0800
Message-Id: <20211223123011.41044-13-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KVM gets notified through memfd_notifier when userspace allocatea space
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
index 8c2359175509..ad89a0e8bf6b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2017,6 +2017,8 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
 #ifdef CONFIG_MEMFD_OPS
 int kvm_memfd_invalidate_range(struct kvm *kvm, struct inode *inode,
 			       unsigned long start, unsigned long end);
+int kvm_memfd_fallocate_range(struct kvm *kvm, struct inode *inode,
+			      unsigned long start, unsigned long end);
 #endif /* CONFIG_MEMFD_OPS */
 
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 660ce15973ad..36dd2adcd7fc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -891,15 +891,17 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
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
@@ -914,6 +916,20 @@ int kvm_memfd_invalidate_range(struct kvm *kvm, struct inode *inode,
 
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
index 547f65f5a187..91a17c9fbc49 100644
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

