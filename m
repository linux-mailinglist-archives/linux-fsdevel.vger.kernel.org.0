Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BAF6294DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 10:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbiKOJx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 04:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKOJxZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:53:25 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08AB201AB;
        Tue, 15 Nov 2022 01:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668506002; x=1700042002;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=4aNJ2YOK3rk2Xxfz14Mm6Z9Et6IN8H9Ru4xzr7aFyfQ=;
  b=iEHP5yrylc3dN9Ft4O9vX6CY9FcWopVW6KOkWSPVuv0oX1dd7oyzUBDq
   OWSp+OfxYERu57A0erLFuuAIS5Ga69Wx6/JYzpKfzXfxGs3dprdJB99lY
   4M4KMjVkXI9VJNPg/gA+gtIK5CrYxGHClFkAywLl0J1SrzonF9U07a1jW
   vMOPMWnDdWLk93DeS8377PwC6/v+Nmu9e2VaP1/VDkyzPCCqTifnQAsoA
   UFLsbaLVdJYtw9NRS/skND0r4+aAzXXSRqIftHPZfjZjTf3ebffnpI0FN
   3taijOhfsTw80pkPoEQ+tS45J3MGxl4bW2O0s5QmKYEXhuAuXPNpnMOYi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="314021391"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="314021391"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 01:53:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="702376949"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="702376949"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2022 01:53:11 -0800
Date:   Tue, 15 Nov 2022 17:48:46 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
Message-ID: <20221115094846.GB338422@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221031174738.fklhlia5fmaiinpe@amd.com>
 <20221101113729.GA4015495@chaop.bj.intel.com>
 <20221101151944.rhpav47pdulsew7l@amd.com>
 <20a11042-2cfb-8f42-9d80-6672e155ca2c@suse.cz>
 <20221114152843.ylxe4dis254vrj5u@box.shutemov.name>
 <20221114221632.5xaz24adkghfjr2q@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114221632.5xaz24adkghfjr2q@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:16:32PM -0600, Michael Roth wrote:
> On Mon, Nov 14, 2022 at 06:28:43PM +0300, Kirill A. Shutemov wrote:
> > On Mon, Nov 14, 2022 at 03:02:37PM +0100, Vlastimil Babka wrote:
> > > On 11/1/22 16:19, Michael Roth wrote:
> > > > On Tue, Nov 01, 2022 at 07:37:29PM +0800, Chao Peng wrote:
> > > >> > 
> > > >> >   1) restoring kernel directmap:
> > > >> > 
> > > >> >      Currently SNP (and I believe TDX) need to either split or remove kernel
> > > >> >      direct mappings for restricted PFNs, since there is no guarantee that
> > > >> >      other PFNs within a 2MB range won't be used for non-restricted
> > > >> >      (which will cause an RMP #PF in the case of SNP since the 2MB
> > > >> >      mapping overlaps with guest-owned pages)
> > > >> 
> > > >> Has the splitting and restoring been a well-discussed direction? I'm
> > > >> just curious whether there is other options to solve this issue.
> > > > 
> > > > For SNP it's been discussed for quite some time, and either splitting or
> > > > removing private entries from directmap are the well-discussed way I'm
> > > > aware of to avoid RMP violations due to some other kernel process using
> > > > a 2MB mapping to access shared memory if there are private pages that
> > > > happen to be within that range.
> > > > 
> > > > In both cases the issue of how to restore directmap as 2M becomes a
> > > > problem.
> > > > 
> > > > I was also under the impression TDX had similar requirements. If so,
> > > > do you know what the plan is for handling this for TDX?
> > > > 
> > > > There are also 2 potential alternatives I'm aware of, but these haven't
> > > > been discussed in much detail AFAIK:
> > > > 
> > > > a) Ensure confidential guests are backed by 2MB pages. shmem has a way to
> > > >    request 2MB THP pages, but I'm not sure how reliably we can guarantee
> > > >    that enough THPs are available, so if we went that route we'd probably
> > > >    be better off requiring the use of hugetlbfs as the backing store. But
> > > >    obviously that's a bit limiting and it would be nice to have the option
> > > >    of using normal pages as well. One nice thing with invalidation
> > > >    scheme proposed here is that this would "Just Work" if implement
> > > >    hugetlbfs support, so an admin that doesn't want any directmap
> > > >    splitting has this option available, otherwise it's done as a
> > > >    best-effort.
> > > > 
> > > > b) Implement general support for restoring directmap as 2M even when
> > > >    subpages might be in use by other kernel threads. This would be the
> > > >    most flexible approach since it requires no special handling during
> > > >    invalidations, but I think it's only possible if all the CPA
> > > >    attributes for the 2M range are the same at the time the mapping is
> > > >    restored/unsplit, so some potential locking issues there and still
> > > >    chance for splitting directmap over time.
> > > 
> > > I've been hoping that
> > > 
> > > c) using a mechanism such as [1] [2] where the goal is to group together
> > > these small allocations that need to increase directmap granularity so
> > > maximum number of large mappings are preserved.
> > 
> > As I mentioned in the other thread the restricted memfd can be backed by
> > secretmem instead of plain memfd. It already handles directmap with care.
> 
> It looks like it would handle direct unmapping/cleanup nicely, but it
> seems to lack fallocate(PUNCH_HOLE) support which we'd probably want to
> avoid additional memory requirements. I think once we added that we'd
> still end up needing some sort of handling for the invalidations.
> 
> Also, I know Chao has been considering hugetlbfs support, I assume by
> leveraging the support that already exists in shmem. Ideally SNP would
> be able to make use of that support as well, but relying on a separate
> backend seems likely to result in more complications getting there
> later.
> 
> > 
> > But I don't think it has to be part of initial restricted memfd
> > implementation. It is SEV-specific requirement and AMD folks can extend
> > implementation as needed later.
> 
> Admittedly the suggested changes to the invalidation mechanism made a
> lot more sense to me when I was under the impression that TDX would have
> similar requirements and we might end up with a common hook. Since that
> doesn't actually seem to be the case, it makes sense to try to do it as
> a platform-specific hook for SNP.
> 
> I think, given a memslot, a GFN range, and kvm_restricted_mem_get_pfn(),
> we should be able to get the same information needed to figure out whether
> the range is backed by huge pages or not. I'll see how that works out
> instead.

Sounds a viable solution, just that kvm_restricted_mem_get_pfn() will
only give you the ability to check a page, not a range. But you can
still call it many times I think.

The invalidation callback will be still needed, it gives you the chance
to do the restoring.

Chao
> 
> Thanks,
> 
> Mike
> 
> > 
> > -- 
> >   Kiryl Shutsemau / Kirill A. Shutemov
