Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509CF492721
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243123AbiARNW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:22:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:18818 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242933AbiARNW5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642512177; x=1674048177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Sxmzc3HCYf+A9G7nAq2yyNQIgWHQdtSxzJnS7/C1WdQ=;
  b=hL2+HxVZricn2zr/dzQ8GZAwbTkDqoyCW53TXzoIePdEQiKN4PtiJpGR
   /p80VcPvt2HkDJdtsqIZ0JQvWqPRY3Au6VIabRQx+n4yM1UFiFBLBFhbq
   8OPryc9+ozWA5IfPDuwWaanPfLjJFWc/mYSDzZo4Z5LubpKyEU9hwmuPd
   I5o+tlR/qdzTb7wvBzYhZJCbi/ZWD+FG8tI8P83g+97jMo0cxfubjofcy
   quVx2DtH8YnTMwFoD50ebNg6uIQ6nHU+AkD0V6Y6yLfWBZTYlDs70TMyd
   WX6sernqwBeUuI6ep4If7+BxoNZxDPSAG/paKH54OjyqWcIa3cCz2M7vo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="243636356"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="243636356"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 05:22:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="531791861"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2022 05:22:49 -0800
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
Subject: [PATCH v4 08/12] KVM: Use memfile_pfn_ops to obtain pfn for private pages
Date:   Tue, 18 Jan 2022 21:21:17 +0800
Message-Id: <20220118132121.31388-9-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Private pages are not mmap-ed into userspace so can not reply on
get_user_pages() to obtain the pfn. Instead we add a memfile_pfn_ops
pointer pfn_ops in each private memslot and use it to obtain the pfn
for a gfn. To do that, KVM should convert the gfn to the offset into
the fd and then call get_lock_pfn callback. Once KVM completes its job
it should call put_unlock_pfn to unlock the pfn. Note the pfn(page) is
locked between get_lock_pfn/put_unlock_pfn to ensure pfn is valid when
KVM uses it to establish the mapping in the secondary MMU page table.

The pfn_ops is initialized via memfile_register_notifier from the memory
backing store that provided the private_fd.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/Kconfig     |  1 +
 include/linux/kvm_host.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index ebc8ce9ec917..5d5bebaad9e7 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -47,6 +47,7 @@ config KVM
 	select SRCU
 	select INTERVAL_TREE
 	select HAVE_KVM_PM_NOTIFIER if PM
+	select MEMFILE_NOTIFIER
 	help
 	  Support hosting fully virtualized guest machines using hardware
 	  virtualization extensions.  You will need a fairly recent
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 26118a45f0bb..927e7f44a02a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -42,6 +42,7 @@
 
 #include <asm/kvm_host.h>
 #include <linux/kvm_dirty_ring.h>
+#include <linux/memfile_notifier.h>
 
 #ifndef KVM_MAX_VCPU_IDS
 #define KVM_MAX_VCPU_IDS KVM_MAX_VCPUS
@@ -460,6 +461,7 @@ struct kvm_memory_slot {
 	u16 as_id;
 	struct file *private_file;
 	loff_t private_offset;
+	struct memfile_pfn_ops *pfn_ops;
 };
 
 static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
@@ -810,6 +812,7 @@ static inline void kvm_irqfd_exit(void)
 {
 }
 #endif
+
 int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 		  struct module *module);
 void kvm_exit(void);
@@ -2103,4 +2106,34 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
 /* Max number of entries allowed for each kvm dirty ring */
 #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
 
+#ifdef CONFIG_MEMFILE_NOTIFIER
+static inline long kvm_memfile_get_pfn(struct kvm_memory_slot *slot, gfn_t gfn,
+				       int *order)
+{
+	pgoff_t index = gfn - slot->base_gfn +
+			(slot->private_offset >> PAGE_SHIFT);
+
+	return slot->pfn_ops->get_lock_pfn(file_inode(slot->private_file),
+					   index, order);
+}
+
+static inline void kvm_memfile_put_pfn(struct kvm_memory_slot *slot,
+				       kvm_pfn_t pfn)
+{
+	slot->pfn_ops->put_unlock_pfn(pfn);
+}
+
+#else
+static inline long kvm_memfile_get_pfn(struct kvm_memory_slot *slot, gfn_t gfn,
+				       int *order)
+{
+	return -1;
+}
+
+static inline void kvm_memfile_put_pfn(struct kvm_memory_slot *slot,
+				       kvm_pfn_t pfn)
+{
+}
+#endif /* CONFIG_MEMFILE_NOTIFIER */
+
 #endif
-- 
2.17.1

