Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3650161656B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 15:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKBO6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKBO6F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:58:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8FA2A700;
        Wed,  2 Nov 2022 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667401083; x=1698937083;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=uie0uv8Iy7FMg7x2ZTUU5aJpcMzyu1e6Q6enp9LSoyY=;
  b=ZiV4Qqs0Tt+CbXwtP/lHN/yu9lfS50Vv2S0cQq5gcuYJF66onjt18zGP
   GfvBclorFR939PfYtZw8lA+rW3DwdpAW6BkiGfX+2eHLq1+O/oDxmyDWT
   XfbTRvWSAl6O/CZu7F9zPxpYY9zlIXawPWpT1QU0/f6PbNzpptLfqtOsr
   vPD58yWdqmGUGJ5aTXamr3u0t0Ii5h3crkal5pCJn9zveoFVW/kKKb2Fb
   b3nu/QzL83xh8AbHlX/jn5Hf1AJ82pr5+DwpNHD9njXFwsovA5hrk2zx7
   wOE9a1Jjs8Rxk8Hto0ovK14RHR9xSP0TJGNVGOwjgEXp2G5O3sm5wfna2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="296875186"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="296875186"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 07:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="665588091"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="665588091"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 02 Nov 2022 07:57:52 -0700
Date:   Wed, 2 Nov 2022 22:53:25 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Michael Roth <michael.roth@amd.com>
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
        mhocko@suse.com, Muchun Song <songmuchun@bytedance.com>,
        wei.w.wang@intel.com
Subject: Re: [PATCH v9 1/8] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20221102145325.GA4068513@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221031174738.fklhlia5fmaiinpe@amd.com>
 <20221101113729.GA4015495@chaop.bj.intel.com>
 <20221101151944.rhpav47pdulsew7l@amd.com>
 <20221101193058.tpzkap3kbrbgasqi@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101193058.tpzkap3kbrbgasqi@amd.com>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 02:30:58PM -0500, Michael Roth wrote:
> On Tue, Nov 01, 2022 at 10:19:44AM -0500, Michael Roth wrote:
> > On Tue, Nov 01, 2022 at 07:37:29PM +0800, Chao Peng wrote:
> > > On Mon, Oct 31, 2022 at 12:47:38PM -0500, Michael Roth wrote:
> > > > On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
> > > 
> > > > 
> > > >   3) Potentially useful for hugetlbfs support:
> > > > 
> > > >      One issue with hugetlbfs is that we don't support splitting the
> > > >      hugepage in such cases, which was a big obstacle prior to UPM. Now
> > > >      however, we may have the option of doing "lazy" invalidations where
> > > >      fallocate(PUNCH_HOLE, ...) won't free a shmem-allocate page unless
> > > >      all the subpages within the 2M range are either hole-punched, or the
> > > >      guest is shut down, so in that way we never have to split it. Sean
> > > >      was pondering something similar in another thread:
> > > > 
> > > >        https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-mm%2FYyGLXXkFCmxBfu5U%40google.com%2F&amp;data=05%7C01%7CMichael.Roth%40amd.com%7C28ba5dbb51844f910dec08dabc1c99e6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638029128345507924%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=bxcRfuJIgo1Z1G8HQ800HscE6y7RXRQwvWSkfc5M8Bs%3D&amp;reserved=0
> > > > 
> > > >      Issuing invalidations with folio-granularity ties in fairly well
> > > >      with this sort of approach if we end up going that route.
> > > 
> > > There is semantics difference between the current one and the proposed
> > > one: The invalidation range is exactly what userspace passed down to the
> > > kernel (being fallocated) while the proposed one will be subset of that
> > > (if userspace-provided addr/size is not aligned to power of two), I'm
> > > not quite confident this difference has no side effect.
> > 
> > In theory userspace should not be allocating/hole-punching restricted
> > pages for GPA ranges that are already mapped as private in the xarray,
> > and KVM could potentially fail such requests (though it does currently).
> > 
> > But if we somehow enforced that, then we could rely on
> > KVM_MEMORY_ENCRYPT_REG_REGION to handle all the MMU invalidation stuff,
> > which would free up the restricted fd invalidation callbacks to be used
> > purely to handle doing things like RMP/directmap fixups prior to returning
> > restricted pages back to the host. So that was sort of my thinking why the
> > new semantics would still cover all the necessary cases.
> 
> Sorry, this explanation is if we rely on userspace to fallocate() on 2MB
> boundaries, and ignore any non-aligned requests in the kernel. But
> that's not how I actually ended up implementing things, so I'm not sure
> why answered that way...
> 
> In my implementation we actually do issue invalidations for fallocate()
> even for non-2M-aligned GPA/offset ranges. For instance (assuming
> restricted FD offset 0 corresponds to GPA 0), an fallocate() on GPA
> range 0x1000-0x402000 would result in the following invalidations being
> issued if everything was backed by a 2MB page:
> 
>   invalidate GPA: 0x001000-0x200000, Page: pfn_to_page(I), order:9
>   invalidate GPA: 0x200000-0x400000, Page: pfn_to_page(J), order:9
>   invalidate GPA: 0x400000-0x402000, Page: pfn_to_page(K), order:9

Only see this I understand what you are actually going to propose;)

So the memory range(start/end) will be still there and covers exactly
what it should be from usrspace point of view, the page+order(or just
folio) is really just a _hint_ for the invalidation callbacks. Looks
ugly though.

In v9 we use a invalidate_start/ invalidate_end pair to solve a race
contention issue(https://lore.kernel.org/kvm/Y1LOe4JvnTbFNs4u@google.com/).
To work with this, I believe we only need pass this hint info for
invalidate_start() since at the invalidate_end() time, the page has
already been discarded.

Another worth-mentioning-thing is invalidate_start/end is not just
invoked for hole punching, but also for allocation(e.g. default
fallocate). While for allocation we can get the page only at the
invalidate_end() time. But AFAICS, the invalidate() is called for
fallocate(allocation) is because previously we rely on the existence in
memory backing store to tell a page is private and we need notify KVM
that the page is being converted from shared to private, but that is not
true for current code and fallocate() is also not mandatory since KVM
can call restrictedmem_get_page() to allocate dynamically, so I think we
can remove the invalidation path for fallocate(allocation).

> 
> So you still cover the same range, but the arch/platform callbacks can
> then, as a best effort, do things like restore 2M directmap if they see
> that the backing page is 2MB+ and the GPA range covers the entire range.
> If the GPA doesn't covers the whole range, or the backing page is
> order:0, then in that case we are still forced to leave the directmap
> split.
> 
> But with that in place we can then improve on that by allowing for the
> use of hugetlbfs.
> 
> We'd still be somewhat reliant on userspace to issue fallocate()'s on
> 2M-aligned boundaries to some degree (guest teardown invalidations
> could be issued as 2M-aligned, which would be the bulk of the pages
> in most cases, but for discarding pages after private->shared
> conversion we could still get fragmentation). This could maybe be
> addressed by keeping track of those partial/non-2M-aligned fallocate()
> requests and then issuing them as a batched 2M invalidation once all
> the subpages have been fallocate(HOLE_PUNCH)'d. We'd need to enforce
> that fallocate(PUNCH_HOLE) is preceeded by
> KVM_MEMORY_ENCRYPT_UNREG_REGION to make sure MMU invalidations happen
> though.

Don't understand why the sequence matters here, we should do MMU
invalidation for both fallocate(PUNCH_HOLE) and
KVM_MEMORY_ENCRYPT_UNREG_REGION, right?

Thanks,
Chao
> 
> Not sure on these potential follow-ups, but they all at least seem
> compatible with the proposed invalidation scheme.
> 
> -Mike
> 
> > 
> > -Mike
> > 
> > > 
> > > > 
> > > > I need to rework things for v9, and we'll probably want to use struct
> > > > folio instead of struct page now, but as a proof-of-concept of sorts this
> > > > is what I'd added on top of v8 of your patchset to implement 1) and 2):
> > > > 
> > > >   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommit%2F127e5ea477c7bd5e4107fd44a04b9dc9e9b1af8b&amp;data=05%7C01%7CMichael.Roth%40amd.com%7C28ba5dbb51844f910dec08dabc1c99e6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638029128345507924%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=iv%2BOMPe5AZuUtIW6bCH%2BRhJPljS14JrTXbQXptLG9fM%3D&amp;reserved=0
> > > > 
> > > > Does an approach like this seem reasonable? Should be work this into the
> > > > base restricted memslot support?
> > > 
> > > If the above mentioned semantics difference is not a problem, I don't
> > > have strong objection on this.
> > > 
> > > Sean, since you have much better understanding on this, what is your
> > > take on this?
> > > 
> > > Chao
> > > > 
> > > > Thanks,
> > > > 
> > > > Mike
