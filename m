Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6767F85B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jan 2023 15:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjA1ODA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Jan 2023 09:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjA1OC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Jan 2023 09:02:58 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C461043C;
        Sat, 28 Jan 2023 06:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674914572; x=1706450572;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Kc8vJ3FvU/EJ0EkuHD1xOBQzKplcG7pKfCLj/xSsBkU=;
  b=mU20VRy12R8p2Lt0ta8VNz+LnWUNK2FkIyxLprxPBA3d4vo8URlkdFZ+
   gUhbk2/CXe59rcoya2dmV/buQZXq5aWiY87KoNDRyVD2DLrSuRzfRmgJD
   zoP/PFkKup/HYA4Ro27UMS/kQG/t1cSvfFkeQGN9FE/4NAzGnadpc4bAJ
   XzbViP9oOB6fZgfYB3wDpv7RMgI0jVLLAR/S6iQuwFkgKrDzTDiGh5gFB
   yr5NHivuhuc0UhPx/3AG7B43BLaFJ8H9zXvdYodOB7SuAPffcD70kTJdQ
   cqRt2V8F+iYhqcdQlnsHT9B4YhHgj6SBhPZKZeTe4nOT7lW2f9pTrDIYa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="391846258"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="391846258"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 06:02:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="908979126"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="908979126"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.105])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jan 2023 06:02:39 -0800
Date:   Sat, 28 Jan 2023 21:54:54 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 7/9] KVM: Update lpage info when private/shared
 memory are mixed
Message-ID: <20230128135454.GA700688@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-8-chao.p.peng@linux.intel.com>
 <Y8HmS2iE4u0Gfkrn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8HmS2iE4u0Gfkrn@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:16:27PM +0000, Sean Christopherson wrote:
> On Fri, Dec 02, 2022, Chao Peng wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 9a07380f8d3c..5aefcff614d2 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -12362,6 +12362,8 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
> >  		if ((slot->base_gfn + npages) & (KVM_PAGES_PER_HPAGE(level) - 1))
> >  			linfo[lpages - 1].disallow_lpage = 1;
> >  		ugfn = slot->userspace_addr >> PAGE_SHIFT;
> > +		if (kvm_slot_can_be_private(slot))
> > +			ugfn |= slot->restricted_offset >> PAGE_SHIFT;
> >  		/*
> >  		 * If the gfn and userspace address are not aligned wrt each
> >  		 * other, disable large page support for this slot.
> 
> Forgot to talk about the bug.  This code needs to handle the scenario where a
> memslot is created with existing, non-uniform attributes.  It might be a bit ugly
> (I didn't even try to write the code), but it's definitely possible, and since
> memslot updates are already slow I think it's best to handle things here.
> 
> In the meantime, I added this so we don't forget to fix it before merging.
> 
> #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> 	pr_crit_once("FIXME: Walk the memory attributes of the slot and set the mixed status appropriately");
> #endif

Here is the code to fix (based on your latest github repo).

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e552374f2357..609ff1cba9c5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2195,4 +2195,9 @@ int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
 	 KVM_X86_QUIRK_FIX_HYPERCALL_INSN |	\
 	 KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS)
 
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+void kvm_memory_attributes_create_memslot(struct kvm *kvm,
+					  struct kvm_memory_slot *slot);
+#endif
+
 #endif /* _ASM_X86_KVM_HOST_H */
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index eda615f3951c..8833d7201e41 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7201,10 +7201,11 @@ static bool has_mixed_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return false;
 }
 
-void kvm_arch_set_memory_attributes(struct kvm *kvm,
-				    struct kvm_memory_slot *slot,
-				    unsigned long attrs,
-				    gfn_t start, gfn_t end)
+static void kvm_update_lpage_mixed_flag(struct kvm *kvm,
+					struct kvm_memory_slot *slot,
+					bool set_attrs,
+					unsigned long attrs,
+					gfn_t start, gfn_t end)
 {
 	unsigned long pages, mask;
 	gfn_t gfn, gfn_end, first, last;
@@ -7231,25 +7232,53 @@ void kvm_arch_set_memory_attributes(struct kvm *kvm,
 		first = start & mask;
 		last = (end - 1) & mask;
 
-		/*
-		 * We only need to scan the head and tail page, for middle pages
-		 * we know they will not be mixed.
-		 */
+		/* head page */
 		gfn = max(first, slot->base_gfn);
 		gfn_end = min(first + pages, slot->base_gfn + slot->npages);
+		if(!set_attrs)
+			attrs = kvm_get_memory_attributes(kvm, gfn);
 		mixed = has_mixed_attrs(kvm, slot, level, attrs, gfn, gfn_end);
 		linfo_update_mixed(gfn, slot, level, mixed);
 
 		if (first == last)
 			return;
 
-		for (gfn = first + pages; gfn < last; gfn += pages)
-			linfo_update_mixed(gfn, slot, level, false);
+		/* middle pages */
+		for (gfn = first + pages; gfn < last; gfn += pages) {
+			if (set_attrs) {
+				mixed = false;
+			} else {
+				gfn_end = gfn + pages;
+				attrs = kvm_get_memory_attributes(kvm, gfn);
+				mixed = has_mixed_attrs(kvm, slot, level, attrs,
+							gfn, gfn_end);
+			}
+			linfo_update_mixed(gfn, slot, level, mixed);
+		}
 
+		/* tail page */
 		gfn = last;
 		gfn_end = min(last + pages, slot->base_gfn + slot->npages);
+		if(!set_attrs)
+			attrs = kvm_get_memory_attributes(kvm, gfn);
 		mixed = has_mixed_attrs(kvm, slot, level, attrs, gfn, gfn_end);
 		linfo_update_mixed(gfn, slot, level, mixed);
 	}
 }
+
+void kvm_arch_set_memory_attributes(struct kvm *kvm,
+				    struct kvm_memory_slot *slot,
+				    unsigned long attrs,
+				    gfn_t start, gfn_t end)
+{
+	kvm_update_lpage_mixed_flag(kvm, slot, true, attrs, start, end);
+}
+
+void kvm_memory_attributes_create_memslot(struct kvm *kvm,
+					  struct kvm_memory_slot *slot)
+{
+
+	kvm_update_lpage_mixed_flag(kvm, slot, false, 0, slot->base_gfn,
+				    slot->base_gfn + slot->npages);
+}
 #endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 268c3d16894d..c1074aecf2d0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12443,7 +12443,7 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 	}
 
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-	pr_crit_once("FIXME: Walk the memory attributes of the slot and set the mixed status appropriately");
+	kvm_memory_attributes_create_memslot(kvm, slot);
 #endif
 
 	if (kvm_page_track_create_memslot(kvm, slot, npages))
