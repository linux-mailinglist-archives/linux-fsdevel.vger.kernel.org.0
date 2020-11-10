Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83422AE018
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 20:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgKJTu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 14:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJTu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:50:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1867C0613D1;
        Tue, 10 Nov 2020 11:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SqhC/cvrpcIdhfC4C7TE3FfX7urzbmqhGyrHEJ3KSz8=; b=B+0xZ4I+0CWqwbY5/9QtASiyMb
        dI/Qz/zeclSvhBV+TRepHHxfSYX/SI/LWizB4lmJjqsmifSWofyfms/AIb0dabiBe2/yDl1qvKuwv
        6ojv+z5Z5I/CQPVpzGb181ShkkroDqLJW95u8cBWOnuG0KN9n/er87OgMhRt5Wo3BMjszk1NiO7fB
        TPFkQKoIPrOyslRlfJVA3u0iIQ9pacD+CUdlXq2EhAzMLWiH00ryVbCeMdPTv96w9zvuTwZBKgTHi
        oGYR5I+TpaLwcQ9MfmveoutWhtlxsCemrX2nSry6j3FL0lxfIdAHJiH9/Z8JsqJhlM62RJEX/m/z1
        xmuVTS7g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcZer-0007MT-SQ; Tue, 10 Nov 2020 19:50:25 +0000
Date:   Tue, 10 Nov 2020 19:50:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        mhocko@suse.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 03/21] mm/hugetlb: Introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
Message-ID: <20201110195025.GN17076@casper.infradead.org>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-4-songmuchun@bytedance.com>
 <20201109135215.GA4778@localhost.localdomain>
 <ef564084-ea73-d579-9251-ec0440df2b48@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef564084-ea73-d579-9251-ec0440df2b48@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:31:31AM -0800, Mike Kravetz wrote:
> On 11/9/20 5:52 AM, Oscar Salvador wrote:
> > On Sun, Nov 08, 2020 at 10:10:55PM +0800, Muchun Song wrote:
> >> The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> >> whether to enable the feature of freeing unused vmemmap associated
> >> with HugeTLB pages. Now only support x86.
> >>
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> ---
> >>  arch/x86/mm/init_64.c |  2 +-
> >>  fs/Kconfig            | 16 ++++++++++++++++
> >>  mm/bootmem_info.c     |  3 +--
> >>  3 files changed, 18 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> >> index 0a45f062826e..0435bee2e172 100644
> >> --- a/arch/x86/mm/init_64.c
> >> +++ b/arch/x86/mm/init_64.c
> >> @@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
> >>  
> >>  static void __init register_page_bootmem_info(void)
> >>  {
> >> -#ifdef CONFIG_NUMA
> >> +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
> >>  	int i;
> >>  
> >>  	for_each_online_node(i)
> >> diff --git a/fs/Kconfig b/fs/Kconfig
> >> index 976e8b9033c4..21b8d39a9715 100644
> >> --- a/fs/Kconfig
> >> +++ b/fs/Kconfig
> >> @@ -245,6 +245,22 @@ config HUGETLBFS
> >>  config HUGETLB_PAGE
> >>  	def_bool HUGETLBFS
> >>  
> >> +config HUGETLB_PAGE_FREE_VMEMMAP
> >> +	bool "Free unused vmemmap associated with HugeTLB pages"
> >> +	default y
> >> +	depends on X86
> >> +	depends on HUGETLB_PAGE
> >> +	depends on SPARSEMEM_VMEMMAP
> >> +	depends on HAVE_BOOTMEM_INFO_NODE
> >> +	help
> >> +	  There are many struct page structures associated with each HugeTLB
> >> +	  page. But we only use a few struct page structures. In this case,
> >> +	  it wastes some memory. It is better to free the unused struct page
> >> +	  structures to buddy system which can save some memory. For
> >> +	  architectures that support it, say Y here.
> >> +
> >> +	  If unsure, say N.
> > 
> > I am not sure the above is useful for someone who needs to decide
> > whether he needs/wants to enable this or not.
> > I think the above fits better in a Documentation part.
> > 
> > I suck at this, but what about the following, or something along those
> > lines? 
> > 
> > "
> > When using SPARSEMEM_VMEMMAP, the system can save up some memory
> > from pre-allocated HugeTLB pages when they are not used.
> > 6 pages per 2MB HugeTLB page and 4095 per 1GB HugeTLB page.
> > When the pages are going to be used or freed up, the vmemmap
> > array representing that range needs to be remapped again and
> > the pages we discarded earlier need to be rellocated again.
> > Therefore, this is a trade-off between saving memory and
> > increasing time in allocation/free path.
> > "
> > 
> > It would be also great to point out that this might be a
> > trade-off between saving up memory and increasing the cost
> > of certain operations on allocation/free path.
> > That is why I mentioned it there.
> 
> Yes, this is somewhat a trade-off.
> 
> As a config option, this is something that would likely be decided by
> distros.  I almost hate to suggest this, but is it something that an
> end user would want to decide?  Is this something that perhaps should
> be a boot/kernel command line option?

I don't like config options.  I like boot options even less.  I don't
know how to describe to an end-user whether they should select this
or not.  Is there a way to make this not a tradeoff?  Or make the
tradeoff so minimal as to be not worth describing?  (do we have numbers
for the worst possible situation when enabling this option?)

I haven't read through these patches in detail, so maybe we do this
already, but when we free the pages to the buddy allocator, do we retain
the third page to use for the PTEs (and free pages 3-7), or do we allocate
a separate page for the PTES and free pages 2-7?
