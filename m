Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5554D4925
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243038AbiCJOOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243043AbiCJONj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:13:39 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BB9158781;
        Thu, 10 Mar 2022 06:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646921494; x=1678457494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/0lWU+5EyoSjlOB1k9o55wX3sxsJiR5VJJRuHs8r7qY=;
  b=kiYvPnW9Gj7SQrP24WbI06ECFPfV2PqyoFFes50+7S86EZlVoYo7g0Jx
   jYL0+D2UIylthTW7Aw3zTuAs5o660VG2VDDGcDryyAfhXmhIgvJdPAl8A
   aJojElt2ht3053BNck435zMaBVB5t/QxOWfBb0sZdduj+iEuH0TMcdlRo
   dVbqlVuSo/9IqGNcc3okXn3h5UMvLItMzfvWTn2Scq/5Nr52PKDo1uC9W
   P6etffT2Y22yZqN30E3aWg1ihKLdCQ/qKLfi8FDaxZ1vWTc164ge7T8NK
   qcBa8KAk/DXSfNwUsgYLGdAYpV2XN25Ht9BQivzLaDSplSTk2a1R8hdO+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="242702683"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="242702683"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:10:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554655084"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 06:10:32 -0800
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
Subject: [PATCH v5 08/13] KVM: Use memfile_pfn_ops to obtain pfn for private pages
Date:   Thu, 10 Mar 2022 22:09:06 +0800
Message-Id: <20220310140911.50924-9-chao.p.peng@linux.intel.com>
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
index e3cbd7706136..ca7b2a6a452a 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -48,6 +48,7 @@ config KVM
 	select SRCU
 	select INTERVAL_TREE
 	select HAVE_KVM_PM_NOTIFIER if PM
+	select MEMFILE_NOTIFIER
 	help
 	  Support hosting fully virtualized guest machines using hardware
 	  virtualization extensions.  You will need a fairly recent
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c92c70174248..6e1d770d6bf8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -44,6 +44,7 @@
 
 #include <asm/kvm_host.h>
 #include <linux/kvm_dirty_ring.h>
+#include <linux/memfile_notifier.h>
 
 #ifndef KVM_MAX_VCPU_IDS
 #define KVM_MAX_VCPU_IDS KVM_MAX_VCPUS
@@ -565,6 +566,7 @@ struct kvm_memory_slot {
 	u16 as_id;
 	struct file *private_file;
 	loff_t private_offset;
+	struct memfile_pfn_ops *pfn_ops;
 };
 
 static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
@@ -915,6 +917,7 @@ static inline void kvm_irqfd_exit(void)
 {
 }
 #endif
+
 int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 		  struct module *module);
 void kvm_exit(void);
@@ -2217,4 +2220,34 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
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

