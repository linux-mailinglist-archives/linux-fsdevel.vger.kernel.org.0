Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4506442EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 13:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiLFMH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 07:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbiLFMHC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:07:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437D1E01A;
        Tue,  6 Dec 2022 04:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670328419; x=1701864419;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=/9rw4XJZnVf887NtG425skKbwwHseWVQy8ohNx+mMzU=;
  b=c9TY9mo6D9vYu8x8bbEhse+QFYFsISWdZ7OB+Gh5zr8fPqqb/vVX/Vxa
   9kHPS4Borq24C1tND8K3wQ19TjaReZLLKf4ijn9Kvq3J5yha44BGxojhD
   fgBXBI7ScF/fHvJSfy6eriXZXSaTr9sZpW5Q9/1jsG8KPgVOykdgW5nIk
   T/vd1YXBjAQXFn85BRLhJRtdkm1Eur7vD7ZOqXSWa/ynH7mc7+reBJso/
   LqQZzjrI4GXhR+COmZ2B9ytgWfhYmEDtp4tQiDswwyjDVftUEHG1jZNwB
   87bFsCBmeiGOMiE9ROZl9OAUqkGDRgG4Jr4YrEA14vayo8HMsSRSRveNf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="317748801"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="317748801"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 04:06:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="639853305"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="639853305"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 06 Dec 2022 04:06:44 -0800
Date:   Tue, 6 Dec 2022 20:02:24 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
Message-ID: <20221206120224.GC1216605@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-8-chao.p.peng@linux.intel.com>
 <20221205224959.GA3632095@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205224959.GA3632095@ls.amr.corp.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 05, 2022 at 02:49:59PM -0800, Isaku Yamahata wrote:
> On Fri, Dec 02, 2022 at 02:13:45PM +0800,
> Chao Peng <chao.p.peng@linux.intel.com> wrote:
> 
> > A large page with mixed private/shared subpages can't be mapped as large
> > page since its sub private/shared pages are from different memory
> > backends and may also treated by architecture differently. When
> > private/shared memory are mixed in a large page, the current lpage_info
> > is not sufficient to decide whether the page can be mapped as large page
> > or not and additional private/shared mixed information is needed.
> > 
> > Tracking this 'mixed' information with the current 'count' like
> > disallow_lpage is a bit challenge so reserve a bit in 'disallow_lpage'
> > to indicate a large page has mixed private/share subpages and update
> > this 'mixed' bit whenever the memory attribute is changed between
> > private and shared.
> > 
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |   8 ++
> >  arch/x86/kvm/mmu/mmu.c          | 134 +++++++++++++++++++++++++++++++-
> >  arch/x86/kvm/x86.c              |   2 +
> >  include/linux/kvm_host.h        |  19 +++++
> >  virt/kvm/kvm_main.c             |   9 ++-
> >  5 files changed, 169 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index 283cbb83d6ae..7772ab37ac89 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -38,6 +38,7 @@
> >  #include <asm/hyperv-tlfs.h>
> >  
> >  #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
> > +#define __KVM_HAVE_ARCH_SET_MEMORY_ATTRIBUTES
> >  
> >  #define KVM_MAX_VCPUS 1024
> >  
> > @@ -1011,6 +1012,13 @@ struct kvm_vcpu_arch {
> >  #endif
> >  };
> >  
> > +/*
> > + * Use a bit in disallow_lpage to indicate private/shared pages mixed at the
> > + * level. The remaining bits are used as a reference count.
> > + */
> > +#define KVM_LPAGE_PRIVATE_SHARED_MIXED		(1U << 31)
> > +#define KVM_LPAGE_COUNT_MAX			((1U << 31) - 1)
> > +
> >  struct kvm_lpage_info {
> >  	int disallow_lpage;
> >  };
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index e2c70b5afa3e..2190fd8c95c0 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -763,11 +763,16 @@ static void update_gfn_disallow_lpage_count(const struct kvm_memory_slot *slot,
> >  {
> >  	struct kvm_lpage_info *linfo;
> >  	int i;
> > +	int disallow_count;
> >  
> >  	for (i = PG_LEVEL_2M; i <= KVM_MAX_HUGEPAGE_LEVEL; ++i) {
> >  		linfo = lpage_info_slot(gfn, slot, i);
> > +
> > +		disallow_count = linfo->disallow_lpage & KVM_LPAGE_COUNT_MAX;
> > +		WARN_ON(disallow_count + count < 0 ||
> > +			disallow_count > KVM_LPAGE_COUNT_MAX - count);
> > +
> >  		linfo->disallow_lpage += count;
> > -		WARN_ON(linfo->disallow_lpage < 0);
> >  	}
> >  }
> >  
> > @@ -6986,3 +6991,130 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
> >  	if (kvm->arch.nx_huge_page_recovery_thread)
> >  		kthread_stop(kvm->arch.nx_huge_page_recovery_thread);
> >  }
> > +
> > +static bool linfo_is_mixed(struct kvm_lpage_info *linfo)
> > +{
> > +	return linfo->disallow_lpage & KVM_LPAGE_PRIVATE_SHARED_MIXED;
> > +}
> > +
> > +static void linfo_set_mixed(gfn_t gfn, struct kvm_memory_slot *slot,
> > +			    int level, bool mixed)
> > +{
> > +	struct kvm_lpage_info *linfo = lpage_info_slot(gfn, slot, level);
> > +
> > +	if (mixed)
> > +		linfo->disallow_lpage |= KVM_LPAGE_PRIVATE_SHARED_MIXED;
> > +	else
> > +		linfo->disallow_lpage &= ~KVM_LPAGE_PRIVATE_SHARED_MIXED;
> > +}
> > +
> > +static bool is_expected_attr_entry(void *entry, unsigned long expected_attrs)
> > +{
> > +	bool expect_private = expected_attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> > +
> > +	if (xa_to_value(entry) & KVM_MEMORY_ATTRIBUTE_PRIVATE) {
> > +		if (!expect_private)
> > +			return false;
> > +	} else if (expect_private)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +static bool mem_attrs_mixed_2m(struct kvm *kvm, unsigned long attrs,
> > +			       gfn_t start, gfn_t end)
> > +{
> > +	XA_STATE(xas, &kvm->mem_attr_array, start);
> > +	gfn_t gfn = start;
> > +	void *entry;
> > +	bool mixed = false;
> > +
> > +	rcu_read_lock();
> > +	entry = xas_load(&xas);
> > +	while (gfn < end) {
> > +		if (xas_retry(&xas, entry))
> > +			continue;
> > +
> > +		KVM_BUG_ON(gfn != xas.xa_index, kvm);
> > +
> > +		if (!is_expected_attr_entry(entry, attrs)) {
> > +			mixed = true;
> > +			break;
> > +		}
> > +
> > +		entry = xas_next(&xas);
> > +		gfn++;
> > +	}
> > +
> > +	rcu_read_unlock();
> > +	return mixed;
> > +}
> > +
> > +static bool mem_attrs_mixed(struct kvm *kvm, struct kvm_memory_slot *slot,
> > +			    int level, unsigned long attrs,
> > +			    gfn_t start, gfn_t end)
> > +{
> > +	unsigned long gfn;
> > +
> > +	if (level == PG_LEVEL_2M)
> > +		return mem_attrs_mixed_2m(kvm, attrs, start, end);
> > +
> > +	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1))
> > +		if (linfo_is_mixed(lpage_info_slot(gfn, slot, level - 1)) ||
> > +		    !is_expected_attr_entry(xa_load(&kvm->mem_attr_array, gfn),
> > +					    attrs))
> > +			return true;
> > +	return false;
> > +}
> > +
> > +static void kvm_update_lpage_private_shared_mixed(struct kvm *kvm,
> > +						  struct kvm_memory_slot *slot,
> > +						  unsigned long attrs,
> > +						  gfn_t start, gfn_t end)
> > +{
> > +	unsigned long pages, mask;
> > +	gfn_t gfn, gfn_end, first, last;
> > +	int level;
> > +	bool mixed;
> > +
> > +	/*
> > +	 * The sequence matters here: we set the higher level basing on the
> > +	 * lower level's scanning result.
> > +	 */
> > +	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
> > +		pages = KVM_PAGES_PER_HPAGE(level);
> > +		mask = ~(pages - 1);
> > +		first = start & mask;
> > +		last = (end - 1) & mask;
> > +
> > +		/*
> > +		 * We only need to scan the head and tail page, for middle pages
> > +		 * we know they will not be mixed.
> > +		 */
> > +		gfn = max(first, slot->base_gfn);
> > +		gfn_end = min(first + pages, slot->base_gfn + slot->npages);
> > +		mixed = mem_attrs_mixed(kvm, slot, level, attrs, gfn, gfn_end);
> > +		linfo_set_mixed(gfn, slot, level, mixed);
> > +
> > +		if (first == last)
> > +			return;
> 
> 
> continue.

Ya!

> 
> > +
> > +		for (gfn = first + pages; gfn < last; gfn += pages)
> > +			linfo_set_mixed(gfn, slot, level, false);
> > +
> > +		gfn = last;
> > +		gfn_end = min(last + pages, slot->base_gfn + slot->npages);
> 
> if (gfn == gfn_end) continue.

Do you see a case where gfn can equal to gfn_end? Though it does not
hurt to add a check.

> 
> 
> > +		mixed = mem_attrs_mixed(kvm, slot, level, attrs, gfn, gfn_end);
> > +		linfo_set_mixed(gfn, slot, level, mixed);
> > +	}
> > +}
> > +
> > +void kvm_arch_set_memory_attributes(struct kvm *kvm,
> > +				    struct kvm_memory_slot *slot,
> > +				    unsigned long attrs,
> > +				    gfn_t start, gfn_t end)
> > +{
> > +	if (kvm_slot_can_be_private(slot))
> > +		kvm_update_lpage_private_shared_mixed(kvm, slot, attrs,
> > +						      start, end);
> > +}
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
> 
> Is there any alignment restriction? If no, It should be +=.
> In practice, alignment will hold though.

All we need here is checking whether both userspace_addr and
restricted_offset are aligned to HPAGE_SIZE or not. '+=' actually can
yield wrong value in cases when userspace_addr + restricted_offset is
aligned to HPAGE_SIZE but individually they may not align to HPAGE_SIZE.

Thanks,
Chao
> 
> Thanks,
> 
> >  		/*
> >  		 * If the gfn and userspace address are not aligned wrt each
> >  		 * other, disable large page support for this slot.
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 3331c0c92838..25099c94e770 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -592,6 +592,11 @@ struct kvm_memory_slot {
> >  	struct restrictedmem_notifier notifier;
> >  };
> >  
> > +static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
> > +{
> > +	return slot && (slot->flags & KVM_MEM_PRIVATE);
> > +}
> > +
> >  static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)
> >  {
> >  	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
> > @@ -2316,4 +2321,18 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
> >  /* Max number of entries allowed for each kvm dirty ring */
> >  #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
> >  
> > +#ifdef __KVM_HAVE_ARCH_SET_MEMORY_ATTRIBUTES
> > +void kvm_arch_set_memory_attributes(struct kvm *kvm,
> > +				    struct kvm_memory_slot *slot,
> > +				    unsigned long attrs,
> > +				    gfn_t start, gfn_t end);
> > +#else
> > +static inline void kvm_arch_set_memory_attributes(struct kvm *kvm,
> > +						  struct kvm_memory_slot *slot,
> > +						  unsigned long attrs,
> > +						  gfn_t start, gfn_t end)
> > +{
> > +}
> > +#endif /* __KVM_HAVE_ARCH_SET_MEMORY_ATTRIBUTES */
> > +
> >  #endif
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 4e1e1e113bf0..e107afea32f0 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2354,7 +2354,8 @@ static u64 kvm_supported_mem_attributes(struct kvm *kvm)
> >  	return 0;
> >  }
> >  
> > -static void kvm_unmap_mem_range(struct kvm *kvm, gfn_t start, gfn_t end)
> > +static void kvm_unmap_mem_range(struct kvm *kvm, gfn_t start, gfn_t end,
> > +				unsigned long attrs)
> >  {
> >  	struct kvm_gfn_range gfn_range;
> >  	struct kvm_memory_slot *slot;
> > @@ -2378,6 +2379,10 @@ static void kvm_unmap_mem_range(struct kvm *kvm, gfn_t start, gfn_t end)
> >  			gfn_range.slot = slot;
> >  
> >  			r |= kvm_unmap_gfn_range(kvm, &gfn_range);
> > +
> > +			kvm_arch_set_memory_attributes(kvm, slot, attrs,
> > +						       gfn_range.start,
> > +						       gfn_range.end);
> >  		}
> >  	}
> >  
> > @@ -2427,7 +2432,7 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> >  		idx = srcu_read_lock(&kvm->srcu);
> >  		KVM_MMU_LOCK(kvm);
> >  		if (i > start)
> > -			kvm_unmap_mem_range(kvm, start, i);
> > +			kvm_unmap_mem_range(kvm, start, i, attrs->attributes);
> >  		kvm_mmu_invalidate_end(kvm);
> >  		KVM_MMU_UNLOCK(kvm);
> >  		srcu_read_unlock(&kvm->srcu, idx);
> > -- 
> > 2.25.1
> > 
> 
> -- 
> Isaku Yamahata <isaku.yamahata@gmail.com>
