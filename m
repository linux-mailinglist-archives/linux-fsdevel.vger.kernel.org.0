Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2B14D48ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiCJONB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242937AbiCJOMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:12:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA6414A6D8;
        Thu, 10 Mar 2022 06:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646921449; x=1678457449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=uGzkzAL8Dy+iBgRDUMsNImudpdJ03OH3v6JTl1qmo+Y=;
  b=edGhZH26HZ23srmHhGqL9ZTiw9+LcvTQlWQDYLS0sYqi4kK/fczuekCy
   VtzOhzbvcMglkLZLnH69Xz0tb/6SmZmWXjxi2MKs/B78RsML1KhKOA6Pf
   Tz5U70ZWNb07Cbuec56y2WdTTMq9ncB5yqRzMgadqrlnNHX/V+o3hrtos
   y0L266Vo1jD+u/xhLADMRklV+Qqo0kYJl35lmkaW1aaHoGBoMR6gTZKSQ
   Ik2CJxwGB2ELVKWpNbGHAsvVkhgqo8lf1nqmTC24G+x2NzdRac/jI68jd
   1OXa7aW/Jwou7HhyWB1W7NgAzFr+chiv6E80TK85IJIAHUTwwzxHUzml0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="254085038"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="254085038"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554655113"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 06:10:41 -0800
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
Subject: [PATCH v5 09/13] KVM: Handle page fault for private memory
Date:   Thu, 10 Mar 2022 22:09:07 +0800
Message-Id: <20220310140911.50924-10-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When page fault happens for a memslot with KVM_MEM_PRIVATE, we use
kvm_memfile_get_pfn() which further calls into memfile_pfn_ops callbacks
defined for each memslot to request the pfn from the memory backing store.

One assumption is that private pages are persistent and pre-allocated in
the private memory fd (backing store) so KVM uses this information as an
indicator for a page is private or shared (i.e. the private fd is the
final source of truth as to whether or not a GPA is private).

Depending on the access is private or shared, we go different paths:
  - For private access, KVM checks if the page is already allocated in
    the memory backing store, if yes KVM establishes the mapping,
    otherwise exits to userspace to convert a shared page to private one.

  - For shared access, KVM also checks if the page is already allocated
    in the memory backing store, if yes then exit to userspace to
    convert a private page to shared one, otherwise it's treated as a
    traditional hva-based shared memory, KVM lets existing code to obtain
    a pfn with get_user_pages() and establish the mapping.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/mmu/mmu.c         | 73 ++++++++++++++++++++++++++++++++--
 arch/x86/kvm/mmu/paging_tmpl.h | 11 +++--
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3b8da8b0745e..f04c823ea09a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2844,6 +2844,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
 	if (max_level == PG_LEVEL_4K)
 		return PG_LEVEL_4K;
 
+	if (kvm_slot_is_private(slot))
+		return max_level;
+
 	host_level = host_pfn_mapping_level(kvm, gfn, pfn, slot);
 	return min(host_level, max_level);
 }
@@ -3890,7 +3893,59 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				  kvm_vcpu_gfn_to_hva(vcpu, gfn), &arch);
 }
 
-static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault, int *r)
+static bool kvm_vcpu_is_private_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
+{
+	/*
+	 * At this time private gfn has not been supported yet. Other patch
+	 * that enables it should change this.
+	 */
+	return false;
+}
+
+static bool kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
+				    struct kvm_page_fault *fault,
+				    bool *is_private_pfn, int *r)
+{
+	int order;
+	unsigned int flags = 0;
+	struct kvm_memory_slot *slot = fault->slot;
+	long pfn = kvm_memfile_get_pfn(slot, fault->gfn, &order);
+
+	if (kvm_vcpu_is_private_gfn(vcpu, fault->addr >> PAGE_SHIFT)) {
+		if (pfn < 0)
+			flags |= KVM_MEMORY_EXIT_FLAG_PRIVATE;
+		else {
+			fault->pfn = pfn;
+			if (slot->flags & KVM_MEM_READONLY)
+				fault->map_writable = false;
+			else
+				fault->map_writable = true;
+
+			if (order == 0)
+				fault->max_level = PG_LEVEL_4K;
+			*is_private_pfn = true;
+			*r = RET_PF_FIXED;
+			return true;
+		}
+	} else {
+		if (pfn < 0)
+			return false;
+
+		kvm_memfile_put_pfn(slot, pfn);
+	}
+
+	vcpu->run->exit_reason = KVM_EXIT_MEMORY_ERROR;
+	vcpu->run->memory.flags = flags;
+	vcpu->run->memory.padding = 0;
+	vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
+	vcpu->run->memory.size = PAGE_SIZE;
+	fault->pfn = -1;
+	*r = -1;
+	return true;
+}
+
+static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
+			    bool *is_private_pfn, int *r)
 {
 	struct kvm_memory_slot *slot = fault->slot;
 	bool async;
@@ -3924,6 +3979,10 @@ static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 		}
 	}
 
+	if (kvm_slot_is_private(slot) &&
+	    kvm_faultin_pfn_private(vcpu, fault, is_private_pfn, r))
+		return *r == RET_PF_FIXED ? false : true;
+
 	async = false;
 	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, &async,
 					  fault->write, &fault->map_writable,
@@ -3984,6 +4043,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	bool is_tdp_mmu_fault = is_tdp_mmu(vcpu->arch.mmu);
 
 	unsigned long mmu_seq;
+	bool is_private_pfn = false;
 	int r;
 
 	fault->gfn = fault->addr >> PAGE_SHIFT;
@@ -4003,7 +4063,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	smp_rmb();
 
-	if (kvm_faultin_pfn(vcpu, fault, &r))
+	if (kvm_faultin_pfn(vcpu, fault, &is_private_pfn, &r))
 		return r;
 
 	if (handle_abnormal_pfn(vcpu, fault, ACC_ALL, &r))
@@ -4016,7 +4076,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	else
 		write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault, mmu_seq))
+	if (!is_private_pfn && is_page_fault_stale(vcpu, fault, mmu_seq))
 		goto out_unlock;
 
 	r = make_mmu_pages_available(vcpu);
@@ -4033,7 +4093,12 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 		read_unlock(&vcpu->kvm->mmu_lock);
 	else
 		write_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(fault->pfn);
+
+	if (is_private_pfn)
+		kvm_memfile_put_pfn(fault->slot, fault->pfn);
+	else
+		kvm_release_pfn_clean(fault->pfn);
+
 	return r;
 }
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 252c77805eb9..6a5736699c0a 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -825,6 +825,8 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	int r;
 	unsigned long mmu_seq;
 	bool is_self_change_mapping;
+	bool is_private_pfn = false;
+
 
 	pgprintk("%s: addr %lx err %x\n", __func__, fault->addr, fault->error_code);
 	WARN_ON_ONCE(fault->is_tdp);
@@ -873,7 +875,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	smp_rmb();
 
-	if (kvm_faultin_pfn(vcpu, fault, &r))
+	if (kvm_faultin_pfn(vcpu, fault, &is_private_pfn, &r))
 		return r;
 
 	if (handle_abnormal_pfn(vcpu, fault, walker.pte_access, &r))
@@ -901,7 +903,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault, mmu_seq))
+	if (!is_private_pfn && is_page_fault_stale(vcpu, fault, mmu_seq))
 		goto out_unlock;
 
 	r = make_mmu_pages_available(vcpu);
@@ -911,7 +913,10 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 out_unlock:
 	write_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(fault->pfn);
+	if (is_private_pfn)
+		kvm_memfile_put_pfn(fault->slot, fault->pfn);
+	else
+		kvm_release_pfn_clean(fault->pfn);
 	return r;
 }
 
-- 
2.17.1

