Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A118610AB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 08:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJ1Grd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 02:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJ1Gq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:46:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5C715B31E;
        Thu, 27 Oct 2022 23:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666939405; x=1698475405;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=8NnFR5a6Ov4GS57k7NcQ6r9rc2t1vYt8WPecZyaK0cQ=;
  b=M+doX1X/NFa5YSyRRXs1GZCSJZgsZ7wRChFO2Wylvx1ZDECW8psDEKLo
   O80rwYAz2VcqybEVJLerEvRl8uP0BGQmSwDLXjBv+fVtrhMyDt8aO//t3
   g8WkHSSMdFqpKeaLXsZAN8BfBqcM54CYNIoUMOTAVfvkCh9o8wBTnC3jm
   erdq6vBr4NK4XMhU+vF2ysjKYuqv2QN5eDUCG9m7Y4vOkZTWlulKqkmAp
   2/285QTJaeePNQgXoiOzqmGbzcilgCaV3VYcyRJ8lw4nwykwS9LXqN1kh
   YwK/0BqgaibJFKRzkFmYbzjZO0PfzM0eKuofnOIHj0chH2XwLWjtt0OXQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="288139755"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="288139755"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 23:43:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="696111933"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="696111933"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 27 Oct 2022 23:42:55 -0700
Date:   Fri, 28 Oct 2022 14:38:26 +0800
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 6/8] KVM: Update lpage info when private/shared memory
 are mixed
Message-ID: <20221028063826.GC3885130@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-7-chao.p.peng@linux.intel.com>
 <20221026204620.GB3819453@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026204620.GB3819453@ls.amr.corp.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 26, 2022 at 01:46:20PM -0700, Isaku Yamahata wrote:
> On Tue, Oct 25, 2022 at 11:13:42PM +0800,
> Chao Peng <chao.p.peng@linux.intel.com> wrote:
> 
> > When private/shared memory are mixed in a large page, the lpage_info may
> > not be accurate and should be updated with this mixed info. A large page
> > has mixed pages can't be really mapped as large page since its
> > private/shared pages are from different physical memory.
> > 
> > Update lpage_info when private/shared memory attribute is changed. If
> > both private and shared pages are within a large page region, it can't
> > be mapped as large page. It's a bit challenge to track the mixed
> > info in a 'count' like variable, this patch instead reserves a bit in
> > 'disallow_lpage' to indicate a large page has mixed private/share pages.
> > 
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |   8 +++
> >  arch/x86/kvm/mmu/mmu.c          | 112 +++++++++++++++++++++++++++++++-
> >  arch/x86/kvm/x86.c              |   2 +
> >  include/linux/kvm_host.h        |  19 ++++++
> >  virt/kvm/kvm_main.c             |  16 +++--
> >  5 files changed, 152 insertions(+), 5 deletions(-)
> > 
> ...
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 33b1aec44fb8..67a9823a8c35 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> ...
> > @@ -6910,3 +6915,108 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
> >  	if (kvm->arch.nx_lpage_recovery_thread)
> >  		kthread_stop(kvm->arch.nx_lpage_recovery_thread);
> >  }
> > +
> > +static inline bool linfo_is_mixed(struct kvm_lpage_info *linfo)
> > +{
> > +	return linfo->disallow_lpage & KVM_LPAGE_PRIVATE_SHARED_MIXED;
> > +}
> > +
> > +static inline void linfo_update_mixed(struct kvm_lpage_info *linfo, bool mixed)
> > +{
> > +	if (mixed)
> > +		linfo->disallow_lpage |= KVM_LPAGE_PRIVATE_SHARED_MIXED;
> > +	else
> > +		linfo->disallow_lpage &= ~KVM_LPAGE_PRIVATE_SHARED_MIXED;
> > +}
> > +
> > +static bool mem_attr_is_mixed_2m(struct kvm *kvm, unsigned int attr,
> > +				 gfn_t start, gfn_t end)
> > +{
> > +	XA_STATE(xas, &kvm->mem_attr_array, start);
> > +	gfn_t gfn = start;
> > +	void *entry;
> > +	bool shared = attr == KVM_MEM_ATTR_SHARED;
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
> > +		if ((entry && !shared) || (!entry && shared)) {
> > +			mixed = true;
> > +			goto out;
> 
> nitpick: goto isn't needed. break should work.

Thanks.

> 
> > +		}
> > +
> > +		entry = xas_next(&xas);
> > +		gfn++;
> > +	}
> > +out:
> > +	rcu_read_unlock();
> > +	return mixed;
> > +}
> > +
> > +static bool mem_attr_is_mixed(struct kvm *kvm, struct kvm_memory_slot *slot,
> > +			      int level, unsigned int attr,
> > +			      gfn_t start, gfn_t end)
> > +{
> > +	unsigned long gfn;
> > +	void *entry;
> > +
> > +	if (level == PG_LEVEL_2M)
> > +		return mem_attr_is_mixed_2m(kvm, attr, start, end);
> > +
> > +	entry = xa_load(&kvm->mem_attr_array, start);
> > +	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
> > +		if (linfo_is_mixed(lpage_info_slot(gfn, slot, level - 1)))
> > +			return true;
> > +		if (xa_load(&kvm->mem_attr_array, gfn) != entry)
> > +			return true;
> > +	}
> > +	return false;
> > +}
> > +
> > +void kvm_arch_update_mem_attr(struct kvm *kvm, struct kvm_memory_slot *slot,
> > +			      unsigned int attr, gfn_t start, gfn_t end)
> > +{
> > +
> > +	unsigned long lpage_start, lpage_end;
> > +	unsigned long gfn, pages, mask;
> > +	int level;
> > +
> > +	WARN_ONCE(!(attr & (KVM_MEM_ATTR_PRIVATE | KVM_MEM_ATTR_SHARED)),
> > +			"Unsupported mem attribute.\n");
> > +
> > +	/*
> > +	 * The sequence matters here: we update the higher level basing on the
> > +	 * lower level's scanning result.
> > +	 */
> > +	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
> > +		pages = KVM_PAGES_PER_HPAGE(level);
> > +		mask = ~(pages - 1);
> 
> nitpick: KVM_HPAGE_MASK(level).  Maybe matter of preference.

Yes, haven't noticed there is a KVM_HPAGE_MASK defined. Have no
strong preference here, since I already have KVM_PAGES_PER_HPAGE(level),
getting mask is straightforward.

A single KVM_HPAGE_MASK(level) will not give me what I need since here
is gfn, KVM_HPAGE_MASK(level)>> PAGE_SHIFT should be the right
equivalent.

Chao
> 
> 
> > +		lpage_start = max(start & mask, slot->base_gfn);
> > +		lpage_end = (end - 1) & mask;
> > +
> > +		/*
> > +		 * We only need to scan the head and tail page, for middle pages
> > +		 * we know they are not mixed.
> > +		 */
> > +		linfo_update_mixed(lpage_info_slot(lpage_start, slot, level),
> > +				   mem_attr_is_mixed(kvm, slot, level, attr,
> > +						     lpage_start, start));
> > +
> > +		if (lpage_start == lpage_end)
> > +			return;
> > +
> > +		for (gfn = lpage_start + pages; gfn < lpage_end; gfn += pages)
> > +			linfo_update_mixed(lpage_info_slot(gfn, slot, level),
> > +					   false);
> > +
> > +		linfo_update_mixed(lpage_info_slot(lpage_end, slot, level),
> > +				   mem_attr_is_mixed(kvm, slot, level, attr,
> > +						     end, lpage_end + pages));
> > +	}
> > +}
> 
> -- 
> Isaku Yamahata <isaku.yamahata@gmail.com>
