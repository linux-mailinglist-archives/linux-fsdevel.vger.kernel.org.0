Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8454156816C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 10:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiGFIZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 04:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbiGFIZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:25:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E0D23173;
        Wed,  6 Jul 2022 01:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657095903; x=1688631903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OGH2abmwTaIHjo/AWx1ogoPQgnuP1dOfum5JiV1obCI=;
  b=ehGcjz/GgtvyFtGU+FlJzR/ZLNtHSs1Am4ZYMryWoZqvHY/WeZXpdqlF
   MTD7UVqb6j4Mfr54mjdYnfVZdFj+d5S44oRKLRAM++W/oJConkRfxka2i
   7rW4MjfchlF+QvFq1BxBZ00VvKj5NykZ5jPBCSnZ/XWJtYJVEdXePay58
   xOX1+He4A0uf7kObhxRDM0kBh4KWcR1gAmFp+LvfLSXvQClJexaU+v/9G
   kYEIDrjJXw6i+xQirNKGWeybtWSY6/0FXciFALvrEu3WbpOH0eeYg0VEU
   aJI5cEwIxQLn/RLe47nayvsGHrqJ/iXjA3wAWCrmAlWCG5212jGCPa2iN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284416444"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="284416444"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 01:25:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="567968030"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 01:24:52 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org
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
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 07/14] KVM: Use gfn instead of hva for mmu_notifier_retry
Date:   Wed,  6 Jul 2022 16:20:09 +0800
Message-Id: <20220706082016.2603916-8-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently in mmu_notifier validate path, hva range is recorded and then
checked in the mmu_notifier_retry_hva() from page fault path. However
for the to be introduced private memory, a page fault may not have a hva
associated, checking gfn(gpa) makes more sense. For existing non private
memory case, gfn is expected to continue to work.

The patch also fixes a potential bug in kvm_zap_gfn_range() which has
already been using gfn when calling kvm_inc/dec_notifier_count() in
current code.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/mmu/mmu.c   |  2 +-
 include/linux/kvm_host.h | 18 ++++++++----------
 virt/kvm/kvm_main.c      |  6 +++---
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f7fa4c31b7c5..0d882fad4bc1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4182,7 +4182,7 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
 		return true;
 
 	return fault->slot &&
-	       mmu_notifier_retry_hva(vcpu->kvm, mmu_seq, fault->hva);
+	       mmu_notifier_retry_gfn(vcpu->kvm, mmu_seq, fault->gfn);
 }
 
 static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0bdb6044e316..e9153b54e2a4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -767,8 +767,8 @@ struct kvm {
 	struct mmu_notifier mmu_notifier;
 	unsigned long mmu_notifier_seq;
 	long mmu_notifier_count;
-	unsigned long mmu_notifier_range_start;
-	unsigned long mmu_notifier_range_end;
+	gfn_t mmu_notifier_range_start;
+	gfn_t mmu_notifier_range_end;
 #endif
 	struct list_head devices;
 	u64 manual_dirty_log_protect;
@@ -1362,10 +1362,8 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
 void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 #endif
 
-void kvm_inc_notifier_count(struct kvm *kvm, unsigned long start,
-				   unsigned long end);
-void kvm_dec_notifier_count(struct kvm *kvm, unsigned long start,
-				   unsigned long end);
+void kvm_inc_notifier_count(struct kvm *kvm, gfn_t start, gfn_t end);
+void kvm_dec_notifier_count(struct kvm *kvm, gfn_t start, gfn_t end);
 
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg);
@@ -1923,9 +1921,9 @@ static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
 	return 0;
 }
 
-static inline int mmu_notifier_retry_hva(struct kvm *kvm,
+static inline int mmu_notifier_retry_gfn(struct kvm *kvm,
 					 unsigned long mmu_seq,
-					 unsigned long hva)
+					 gfn_t gfn)
 {
 	lockdep_assert_held(&kvm->mmu_lock);
 	/*
@@ -1935,8 +1933,8 @@ static inline int mmu_notifier_retry_hva(struct kvm *kvm,
 	 * positives, due to shortcuts when handing concurrent invalidations.
 	 */
 	if (unlikely(kvm->mmu_notifier_count) &&
-	    hva >= kvm->mmu_notifier_range_start &&
-	    hva < kvm->mmu_notifier_range_end)
+	    gfn >= kvm->mmu_notifier_range_start &&
+	    gfn < kvm->mmu_notifier_range_end)
 		return 1;
 	if (kvm->mmu_notifier_seq != mmu_seq)
 		return 1;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index da263c370d00..4d7f0e72366f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -536,8 +536,7 @@ static void kvm_mmu_notifier_invalidate_range(struct mmu_notifier *mn,
 
 typedef bool (*hva_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
 
-typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
-			     unsigned long end);
+typedef void (*on_lock_fn_t)(struct kvm *kvm, gfn_t start, gfn_t end);
 
 typedef void (*on_unlock_fn_t)(struct kvm *kvm);
 
@@ -624,7 +623,8 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 				locked = true;
 				KVM_MMU_LOCK(kvm);
 				if (!IS_KVM_NULL_FN(range->on_lock))
-					range->on_lock(kvm, range->start, range->end);
+					range->on_lock(kvm, gfn_range.start,
+							    gfn_range.end);
 				if (IS_KVM_NULL_FN(range->handler))
 					break;
 			}
-- 
2.25.1

