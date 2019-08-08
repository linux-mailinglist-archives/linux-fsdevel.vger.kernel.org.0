Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9584586DFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 01:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbfHHXlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 19:41:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:22779 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfHHXlj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 19:41:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 16:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; 
   d="scan'208";a="203754786"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2019 16:41:38 -0700
Date:   Thu, 8 Aug 2019 16:41:38 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Black <daniel@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 1/3] mm/mlock.c: convert put_page() to put_user_page*()
Message-ID: <20190808234138.GA15908@iweiny-DESK2.sc.intel.com>
References: <20190805222019.28592-1-jhubbard@nvidia.com>
 <20190805222019.28592-2-jhubbard@nvidia.com>
 <20190807110147.GT11812@dhcp22.suse.cz>
 <01b5ed91-a8f7-6b36-a068-31870c05aad6@nvidia.com>
 <20190808062155.GF11812@dhcp22.suse.cz>
 <875dca95-b037-d0c7-38bc-4b4c4deea2c7@suse.cz>
 <306128f9-8cc6-761b-9b05-578edf6cce56@nvidia.com>
 <d1ecb0d4-ea6a-637d-7029-687b950b783f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1ecb0d4-ea6a-637d-7029-687b950b783f@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 08, 2019 at 03:59:15PM -0700, John Hubbard wrote:
> On 8/8/19 12:20 PM, John Hubbard wrote:
> > On 8/8/19 4:09 AM, Vlastimil Babka wrote:
> >> On 8/8/19 8:21 AM, Michal Hocko wrote:
> >>> On Wed 07-08-19 16:32:08, John Hubbard wrote:
> >>>> On 8/7/19 4:01 AM, Michal Hocko wrote:
> >>>>> On Mon 05-08-19 15:20:17, john.hubbard@gmail.com wrote:
> >>>>>> From: John Hubbard <jhubbard@nvidia.com>
> >>>> Actually, I think follow_page_mask() gets all the pages, right? And the
> >>>> get_page() in __munlock_pagevec_fill() is there to allow a pagevec_release() 
> >>>> later.
> >>>
> >>> Maybe I am misreading the code (looking at Linus tree) but munlock_vma_pages_range
> >>> calls follow_page for the start address and then if not THP tries to
> >>> fill up the pagevec with few more pages (up to end), do the shortcut
> >>> via manual pte walk as an optimization and use generic get_page there.
> >>
> > 
> > Yes, I see it finally, thanks. :)  
> > 
> >> That's true. However, I'm not sure munlocking is where the
> >> put_user_page() machinery is intended to be used anyway? These are
> >> short-term pins for struct page manipulation, not e.g. dirtying of page
> >> contents. Reading commit fc1d8e7cca2d I don't think this case falls
> >> within the reasoning there. Perhaps not all GUP users should be
> >> converted to the planned separate GUP tracking, and instead we should
> >> have a GUP/follow_page_mask() variant that keeps using get_page/put_page?
> >>  
> > 
> > Interesting. So far, the approach has been to get all the gup callers to
> > release via put_user_page(), but if we add in Jan's and Ira's vaddr_pin_pages()
> > wrapper, then maybe we could leave some sites unconverted.
> > 
> > However, in order to do so, we would have to change things so that we have
> > one set of APIs (gup) that do *not* increment a pin count, and another set
> > (vaddr_pin_pages) that do. 
> > 
> > Is that where we want to go...?
> > 
> 
> Oh, and meanwhile, I'm leaning toward a cheap fix: just use gup_fast() instead
> of get_page(), and also fix the releasing code. So this incremental patch, on
> top of the existing one, should do it:
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index b980e6270e8a..2ea272c6fee3 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -318,18 +318,14 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
>                 /*
>                  * We won't be munlocking this page in the next phase
>                  * but we still need to release the follow_page_mask()
> -                * pin. We cannot do it under lru_lock however. If it's
> -                * the last pin, __page_cache_release() would deadlock.
> +                * pin.
>                  */
> -               pagevec_add(&pvec_putback, pvec->pages[i]);
> +               put_user_page(pages[i]);
>                 pvec->pages[i] = NULL;
>         }
>         __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
>         spin_unlock_irq(&zone->zone_pgdat->lru_lock);
>  
> -       /* Now we can release pins of pages that we are not munlocking */
> -       pagevec_release(&pvec_putback);
> -

I'm not an expert but this skips a call to lru_add_drain().  Is that ok?

>         /* Phase 2: page munlock */
>         for (i = 0; i < nr; i++) {
>                 struct page *page = pvec->pages[i];
> @@ -394,6 +390,8 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
>         start += PAGE_SIZE;
>         while (start < end) {
>                 struct page *page = NULL;
> +               int ret;
> +
>                 pte++;
>                 if (pte_present(*pte))
>                         page = vm_normal_page(vma, start, *pte);
> @@ -411,7 +409,13 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
>                 if (PageTransCompound(page))
>                         break;
>  
> -               get_page(page);
> +               /*
> +                * Use get_user_pages_fast(), instead of get_page() so that the
> +                * releasing code can unconditionally call put_user_page().
> +                */
> +               ret = get_user_pages_fast(start, 1, 0, &page);
> +               if (ret != 1)
> +                       break;

I like the idea of making this a get/put pair but I'm feeling uneasy about how
this is really supposed to work.

For sure the GUP/PUP was supposed to be separate from [get|put]_page.

Ira
>                 /*
>                  * Increase the address that will be returned *before* the
>                  * eventual break due to pvec becoming full by adding the page
> 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
