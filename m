Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA91A5B9D60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 16:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiIOOge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 10:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiIOOfl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:35:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28A2FD;
        Thu, 15 Sep 2022 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663252504; x=1694788504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OdNh9Zw3Oa88e2pjFDCMImTzlT1i+7tGALsj6VLXH/Q=;
  b=DO7BxfVrEzyJz5VqeXSYFv+WJV9FTLOIxwWAZ1GkG3ijlOUOA4S3hO9C
   ixbtuZ+QOQ8YUFFf7fMqFUeEezGsweEdbG8M6oWuoY0Gg74cfjKQQslM+
   kDwWxZQSodZS7Tz6Am9zi5aJXVe/fdKmjQcok7lOq7+N8SixSRLAXjGa2
   BTm0N+JekjizEIxM5lspwzgiKEXc1Nb5P4nJ+2JDOsx3pzwJql+nR77hL
   ftpJ7M9IRwtFCOjHo3ShZRuBB8uRxHnwHcvQ7TLIglS5egpDasiJYe21w
   rAH/GBiiMNwrQ4Zqh1EbJIAMAVxEjmML/6Q/wUfuDLXZFzNp8WJYgFJU8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="285769945"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="285769945"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 07:35:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="945977198"
Received: from chaop.bj.intel.com ([10.240.193.75])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2022 07:34:52 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: [PATCH v8 6/8] KVM: Update lpage info when private/shared memory are mixed
Date:   Thu, 15 Sep 2022 22:29:11 +0800
Message-Id: <20220915142913.2213336-7-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When private/shared memory are mixed in a large page, the lpage_info may
not be accurate and should be updated with this mixed info. A large page
has mixed pages can't be really mapped as large page since its
private/shared pages are from different physical memory.

This patch updates lpage_info when private/shared memory attribute is
changed.  If both private and shared pages are within a large page
region, it can't be mapped as large page. It's a bit challenge to track
the mixed info in a 'count' like variable, this patch instead reserves a
bit in disallow_lpage to indicate a large page include mixed
private/share pages.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h |   8 +++
 arch/x86/kvm/mmu/mmu.c          | 119 +++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c              |   2 +
 include/linux/kvm_host.h        |  17 +++++
 virt/kvm/kvm_main.c             |  11 ++-
 5 files changed, 154 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cfad6ba1a70a..85119ed9527a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -38,6 +38,7 @@
 
 #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
 #define __KVM_HAVE_ZAP_GFN_RANGE
+#define __KVM_HAVE_ARCH_UPDATE_MEM_ATTR
 
 #define KVM_MAX_VCPUS 1024
 
@@ -945,6 +946,13 @@ struct kvm_vcpu_arch {
 #endif
 };
 
+/*
+ * Use a bit in disallow_lpage to indicate private/shared pages mixed at the
+ * level. The remaining bits will be used as a reference count for other users.
+ */
+#define KVM_LPAGE_PRIVATE_SHARED_MIXED		(1U << 31)
+#define KVM_LPAGE_COUNT_MAX			((1U << 31) - 1)
+
 struct kvm_lpage_info {
 	int disallow_lpage;
 };
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 08abad4f3e6f..a0f198cede3d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -762,11 +762,16 @@ static void update_gfn_disallow_lpage_count(const struct kvm_memory_slot *slot,
 {
 	struct kvm_lpage_info *linfo;
 	int i;
+	int disallow_count;
 
 	for (i = PG_LEVEL_2M; i <= KVM_MAX_HUGEPAGE_LEVEL; ++i) {
 		linfo = lpage_info_slot(gfn, slot, i);
+
+		disallow_count = linfo->disallow_lpage & KVM_LPAGE_COUNT_MAX;
+		WARN_ON(disallow_count + count < 0 ||
+			disallow_count > KVM_LPAGE_COUNT_MAX - count);
+
 		linfo->disallow_lpage += count;
-		WARN_ON(linfo->disallow_lpage < 0);
 	}
 }
 
@@ -6894,3 +6899,115 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
 	if (kvm->arch.nx_lpage_recovery_thread)
 		kthread_stop(kvm->arch.nx_lpage_recovery_thread);
 }
+
+static bool mem_attr_is_mixed(struct kvm *kvm, unsigned int attr,
+			      gfn_t start, gfn_t end)
+{
+	XA_STATE(xas, &kvm->mem_attr_array, start);
+	gfn_t gfn = start;
+	void *entry;
+	bool shared, private;
+	bool mixed = false;
+
+	if (attr == KVM_MEM_ATTR_SHARED) {
+		shared = true;
+		private = false;
+	} else {
+		shared = false;
+		private = true;
+	}
+
+	rcu_read_lock();
+	entry = xas_load(&xas);
+	while (gfn < end) {
+		if (xas_retry(&xas, entry))
+			continue;
+
+		KVM_BUG_ON(gfn != xas.xa_index, kvm);
+
+		if (entry)
+			private = true;
+		else
+			shared = true;
+
+		if (private && shared) {
+			mixed = true;
+			goto out;
+		}
+
+		entry = xas_next(&xas);
+		gfn++;
+	}
+out:
+	rcu_read_unlock();
+	return mixed;
+}
+
+static inline void update_mixed(struct kvm_lpage_info *linfo, bool mixed)
+{
+	if (mixed)
+		linfo->disallow_lpage |= KVM_LPAGE_PRIVATE_SHARED_MIXED;
+	else
+		linfo->disallow_lpage &= ~KVM_LPAGE_PRIVATE_SHARED_MIXED;
+}
+
+static void update_mem_lpage_info(struct kvm *kvm,
+				  struct kvm_memory_slot *slot,
+				  unsigned int attr,
+				  gfn_t start, gfn_t end)
+{
+	unsigned long lpage_start, lpage_end;
+	unsigned long gfn, pages, mask;
+	int level;
+
+	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
+		pages = KVM_PAGES_PER_HPAGE(level);
+		mask = ~(pages - 1);
+		lpage_start = start & mask;
+		lpage_end = (end - 1) & mask;
+
+		/*
+		 * We only need to scan the head and tail page, for middle pages
+		 * we know they are not mixed.
+		 */
+		update_mixed(lpage_info_slot(lpage_start, slot, level),
+			     mem_attr_is_mixed(kvm, attr, lpage_start,
+							  lpage_start + pages));
+
+		if (lpage_start == lpage_end)
+			return;
+
+		for (gfn = lpage_start + pages; gfn < lpage_end; gfn += pages)
+			update_mixed(lpage_info_slot(gfn, slot, level), false);
+
+		update_mixed(lpage_info_slot(lpage_end, slot, level),
+			     mem_attr_is_mixed(kvm, attr, lpage_end,
+							  lpage_end + pages));
+	}
+}
+
+void kvm_arch_update_mem_attr(struct kvm *kvm, unsigned int attr,
+			      gfn_t start, gfn_t end)
+{
+	struct kvm_memory_slot *slot;
+	struct kvm_memslots *slots;
+	struct kvm_memslot_iter iter;
+	int i;
+
+	WARN_ONCE(!(attr & (KVM_MEM_ATTR_PRIVATE | KVM_MEM_ATTR_SHARED)),
+			"Unsupported mem attribute.\n");
+
+	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+		slots = __kvm_memslots(kvm, i);
+
+		kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
+			slot = iter.slot;
+			start = max(start, slot->base_gfn);
+			end = min(end, slot->base_gfn + slot->npages);
+			if (WARN_ON_ONCE(start >= end))
+				continue;
+
+			update_mem_lpage_info(kvm, slot, attr, start, end);
+		}
+	}
+}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 081f62ccc9a1..ef11cda6f13f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12321,6 +12321,8 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 		if ((slot->base_gfn + npages) & (KVM_PAGES_PER_HPAGE(level) - 1))
 			linfo[lpages - 1].disallow_lpage = 1;
 		ugfn = slot->userspace_addr >> PAGE_SHIFT;
+		if (kvm_slot_can_be_private(slot))
+			ugfn |= slot->private_offset >> PAGE_SHIFT;
 		/*
 		 * If the gfn and userspace address are not aligned wrt each
 		 * other, disable large page support for this slot.
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d65690cae80b..fd36ce6597ad 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2277,4 +2277,21 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
 /* Max number of entries allowed for each kvm dirty ring */
 #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
 
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
+
+#define KVM_MEM_ATTR_SHARED	0x0001
+#define KVM_MEM_ATTR_PRIVATE	0x0002
+
+#ifdef __KVM_HAVE_ARCH_UPDATE_MEM_ATTR
+void kvm_arch_update_mem_attr(struct kvm *kvm, unsigned int attr,
+			      gfn_t start, gfn_t end);
+#else
+static inline void kvm_arch_update_mem_attr(struct kvm *kvm, unsigned int attr,
+					    gfn_t start, gfn_t end)
+{
+}
+#endif
+
+#endif /* CONFIG_HAVE_KVM_PRIVATE_MEM */
+
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index de5cce8c82c7..97d893f7482c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -938,13 +938,13 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
 
 #ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
-#define KVM_MEM_ATTR_SHARED	0x0001
 static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
 				     bool is_private)
 {
 	gfn_t start, end;
 	unsigned long index;
 	void *entry;
+	int attr;
 	int r;
 
 	if (size == 0 || gpa + size < gpa)
@@ -959,7 +959,13 @@ static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
 	 * Guest memory defaults to private, kvm->mem_attr_array only stores
 	 * shared memory.
 	 */
-	entry = is_private ? NULL : xa_mk_value(KVM_MEM_ATTR_SHARED);
+	if (is_private) {
+		attr = KVM_MEM_ATTR_PRIVATE;
+		entry = NULL;
+	} else {
+		attr = KVM_MEM_ATTR_SHARED;
+		entry = xa_mk_value(KVM_MEM_ATTR_SHARED);
+	}
 
 	for (index = start; index < end; index++) {
 		r = xa_err(xa_store(&kvm->mem_attr_array, index, entry,
@@ -969,6 +975,7 @@ static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
 	}
 
 	kvm_zap_gfn_range(kvm, start, end);
+	kvm_arch_update_mem_attr(kvm, attr, start, end);
 
 	return r;
 err:
-- 
2.25.1

