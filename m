Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204A25B9D52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 16:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiIOOfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiIOOev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:34:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3AE65F7;
        Thu, 15 Sep 2022 07:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663252485; x=1694788485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Raca1wOUdVWzIsRmNLgx+j7A1SHMFBohtFeko5o9+Ds=;
  b=KR/OPsTRhPRkRZs/lZ3mmJREwcTXV6bZbRJK9h/AMO8oIrQwcIPl2ivr
   FfAERNBMwAmKn9o+lvwT+Nhkr5QzWB/g0QJsQZBjwftEjhasHaIdLIZZ7
   L8wVuGXMFCTP4oIM/sOiKNYUxx3rJzKuSfxjruGmjc40dhFsUX6GHriQ6
   5m1fQMWxWc6BrSo6oXK1udTg93dtQLSN0U/7Nup27DDMrsGtT84BgZ6Z7
   IwKX8XYe7gv3TuOa+Z70kIrf508hZUALCL4VNCHMZyv9HK2OM3HFfMepG
   uimQqy9ZxXCmpt510fOCmw3EAdKxs0+7vIYk5jW2DuggKrNIPS1E13OH8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="299541006"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="299541006"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 07:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="945977075"
Received: from chaop.bj.intel.com ([10.240.193.75])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2022 07:34:32 -0700
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
Subject: [PATCH v8 4/8] KVM: Use gfn instead of hva for mmu_notifier_retry
Date:   Thu, 15 Sep 2022 22:29:09 +0800
Message-Id: <20220915142913.2213336-5-chao.p.peng@linux.intel.com>
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

Currently in mmu_notifier validate path, hva range is recorded and then
checked against in the mmu_notifier_retry_hva() of the page fault path.
However, for the to be introduced private memory, a page fault may not
have a hva associated, checking gfn(gpa) makes more sense.

For existing non private memory case, gfn is expected to continue to
work. The only downside is when aliasing multiple gfns to a single hva,
the current algorithm of checking multiple ranges could result in a much
larger range being rejected. Such aliasing should be uncommon, so the
impact is expected small.

The patch also fixes a bug in kvm_zap_gfn_range() which has already
been using gfn when calling kvm_mmu_invalidate_begin/end() while these
functions accept hva in current code.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/mmu/mmu.c   |  2 +-
 include/linux/kvm_host.h | 18 +++++++---------
 virt/kvm/kvm_main.c      | 45 ++++++++++++++++++++++++++--------------
 3 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e418ef3ecfcb..08abad4f3e6f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4203,7 +4203,7 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
 		return true;
 
 	return fault->slot &&
-	       mmu_invalidate_retry_hva(vcpu->kvm, mmu_seq, fault->hva);
+	       mmu_invalidate_retry_gfn(vcpu->kvm, mmu_seq, fault->gfn);
 }
 
 static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index eac1787b899b..2125b50f6345 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -776,8 +776,8 @@ struct kvm {
 	struct mmu_notifier mmu_notifier;
 	unsigned long mmu_invalidate_seq;
 	long mmu_invalidate_in_progress;
-	unsigned long mmu_invalidate_range_start;
-	unsigned long mmu_invalidate_range_end;
+	gfn_t mmu_invalidate_range_start;
+	gfn_t mmu_invalidate_range_end;
 #endif
 	struct list_head devices;
 	u64 manual_dirty_log_protect;
@@ -1366,10 +1366,8 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
 void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 #endif
 
-void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
-			      unsigned long end);
-void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
-			    unsigned long end);
+void kvm_mmu_invalidate_begin(struct kvm *kvm, gfn_t start, gfn_t end);
+void kvm_mmu_invalidate_end(struct kvm *kvm, gfn_t start, gfn_t end);
 
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg);
@@ -1938,9 +1936,9 @@ static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
 	return 0;
 }
 
-static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
+static inline int mmu_invalidate_retry_gfn(struct kvm *kvm,
 					   unsigned long mmu_seq,
-					   unsigned long hva)
+					   gfn_t gfn)
 {
 	lockdep_assert_held(&kvm->mmu_lock);
 	/*
@@ -1950,8 +1948,8 @@ static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
 	 * positives, due to shortcuts when handing concurrent invalidations.
 	 */
 	if (unlikely(kvm->mmu_invalidate_in_progress) &&
-	    hva >= kvm->mmu_invalidate_range_start &&
-	    hva < kvm->mmu_invalidate_range_end)
+	    gfn >= kvm->mmu_invalidate_range_start &&
+	    gfn < kvm->mmu_invalidate_range_end)
 		return 1;
 	if (kvm->mmu_invalidate_seq != mmu_seq)
 		return 1;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 12dc0dc57b06..fa9dd2d2c001 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -540,8 +540,7 @@ static void kvm_mmu_notifier_invalidate_range(struct mmu_notifier *mn,
 
 typedef bool (*hva_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
 
-typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
-			     unsigned long end);
+typedef void (*on_lock_fn_t)(struct kvm *kvm, gfn_t start, gfn_t end);
 
 typedef void (*on_unlock_fn_t)(struct kvm *kvm);
 
@@ -628,7 +627,8 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 				locked = true;
 				KVM_MMU_LOCK(kvm);
 				if (!IS_KVM_NULL_FN(range->on_lock))
-					range->on_lock(kvm, range->start, range->end);
+					range->on_lock(kvm, gfn_range.start,
+							    gfn_range.end);
 				if (IS_KVM_NULL_FN(range->handler))
 					break;
 			}
@@ -715,15 +715,9 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 	kvm_handle_hva_range(mn, address, address + 1, pte, kvm_set_spte_gfn);
 }
 
-void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
-			      unsigned long end)
+static inline void update_invalidate_range(struct kvm *kvm, gfn_t start,
+							    gfn_t end)
 {
-	/*
-	 * The count increase must become visible at unlock time as no
-	 * spte can be established without taking the mmu_lock and
-	 * count is also read inside the mmu_lock critical section.
-	 */
-	kvm->mmu_invalidate_in_progress++;
 	if (likely(kvm->mmu_invalidate_in_progress == 1)) {
 		kvm->mmu_invalidate_range_start = start;
 		kvm->mmu_invalidate_range_end = end;
@@ -744,6 +738,28 @@ void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
 	}
 }
 
+static void mark_invalidate_in_progress(struct kvm *kvm, gfn_t start, gfn_t end)
+{
+	/*
+	 * The count increase must become visible at unlock time as no
+	 * spte can be established without taking the mmu_lock and
+	 * count is also read inside the mmu_lock critical section.
+	 */
+	kvm->mmu_invalidate_in_progress++;
+}
+
+static bool kvm_mmu_handle_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	update_invalidate_range(kvm, range->start, range->end);
+	return kvm_unmap_gfn_range(kvm, range);
+}
+
+void kvm_mmu_invalidate_begin(struct kvm *kvm, gfn_t start, gfn_t end)
+{
+	mark_invalidate_in_progress(kvm, start, end);
+	update_invalidate_range(kvm, start, end);
+}
+
 static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 					const struct mmu_notifier_range *range)
 {
@@ -752,8 +768,8 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 		.start		= range->start,
 		.end		= range->end,
 		.pte		= __pte(0),
-		.handler	= kvm_unmap_gfn_range,
-		.on_lock	= kvm_mmu_invalidate_begin,
+		.handler	= kvm_mmu_handle_gfn_range,
+		.on_lock	= mark_invalidate_in_progress,
 		.on_unlock	= kvm_arch_guest_memory_reclaimed,
 		.flush_on_ret	= true,
 		.may_block	= mmu_notifier_range_blockable(range),
@@ -791,8 +807,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	return 0;
 }
 
-void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
-			    unsigned long end)
+void kvm_mmu_invalidate_end(struct kvm *kvm, gfn_t start, gfn_t end)
 {
 	/*
 	 * This sequence increase will notify the kvm page fault that
-- 
2.25.1

