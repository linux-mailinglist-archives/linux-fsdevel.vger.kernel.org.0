Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC62E2B48E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgKPPOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 10:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgKPPOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:14:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91013C0613CF;
        Mon, 16 Nov 2020 07:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DPK8kltl3zjX8pqHlBtk1g1ne4D5St7jwKhxm4gTJu8=; b=pD234fuxwp9moQ14SJrs0DTB8C
        dfmEyPxIbX33wEVNG0/I85yb+JcIY206Y77Aipblvnf6Bvu3Gyz6ivCMj6IcXW48auThCxpnrNjkz
        IooTapSSZ5NPzrvyGQO93iM0ymePG+SitxcNefJYyvMRPq15mvMk0X+Au80/8pWK2F5qulB2l3DV1
        L0Sbtq0C7e+xEptFt46fWYINu89PaOPAmWMgVDNEbM2mICyfVT4bCGJefPCfB8SetLbmuGQ9f1yAK
        Ut8qZUb/vZid5oYxOnk0/iq1D5QxgnvkH4vvNjpTtXwLXtO/pMYR0Mxr5YF0R5/2+An7JxVWZWfbS
        Y8sf4bAg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kegDM-0006Uh-HT; Mon, 16 Nov 2020 15:14:44 +0000
Date:   Mon, 16 Nov 2020 15:14:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
Message-ID: <20201116151444.GB29991@casper.infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
 <alpine.LSU.2.11.2011160128001.1206@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2011160128001.1206@eggly.anvils>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 02:34:34AM -0800, Hugh Dickins wrote:
> On Thu, 12 Nov 2020, Matthew Wilcox (Oracle) wrote:
> 
> > This THP prep patchset changes several page cache iteration APIs to only
> > return head pages.
> > 
> >  - It's only possible to tag head pages in the page cache, so only
> >    return head pages, not all their subpages.
> >  - Factor a lot of common code out of the various batch lookup routines
> >  - Add mapping_seek_hole_data()
> >  - Unify find_get_entries() and pagevec_lookup_entries()
> >  - Make find_get_entries only return head pages, like find_get_entry().
> > 
> > These are only loosely connected, but they seem to make sense together
> > as a series.
> > 
> > v4:
> >  - Add FGP_ENTRY, remove find_get_entry and find_lock_entry
> >  - Rename xas_find_get_entry to find_get_entry
> >  - Add "Optimise get_shadow_from_swap_cache"
> >  - Move "iomap: Use mapping_seek_hole_data" to this patch series
> >  - Rebase against next-20201112
> 
> I hope next-20201112 had nothing vital for this series, I applied
> it to v5.10-rc3, and have been busy testing huge tmpfs on that.

Thank you.  It's plain I'm not able to hit these cases ... I do run
xfstests against shmem, but that's obviously not good enough.  Can
you suggest something I should be running to improve my coverage?

> Fix to [PATCH v4 06/16] mm/filemap: Add helper for finding pages.
> I hit that VM_BUG_ON_PAGE(!thp_contains) when swapping, it is not
> safe without page lock, during the interval when shmem is moving a
> page between page cache and swap cache.  It could be tightened by
> passing in a new FGP to distinguish whether searching page or swap
> cache, but I think never tight enough in the swap case - because there
> is no rule for persisting page->private as there is for page->index.
> The best I could do is:

I'll just move this out to the caller who actually locks the page:

+++ b/mm/filemap.c
@@ -1839,7 +1839,6 @@ static inline struct page *find_get_entry(struct xa_state *xas, pgoff_t max,
                put_page(page);
                goto reset;
        }
-       VM_BUG_ON_PAGE(!thp_contains(page, xas->xa_index), page);
 
        return page;
 reset:
@@ -1923,6 +1922,8 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
                                goto put;
                        if (page->mapping != mapping || PageWriteback(page))
                                goto unlock;
+                       VM_BUG_ON_PAGE(!thp_contains(page, xas->xa_index),
+                                       page);
                }
                indices[pvec->nr] = xas.xa_index;
                if (!pagevec_add(pvec, page))

> Fix to [PATCH v4 07/16] mm/filemap: Add mapping_seek_hole_data.
> Crashed on a swap entry 0x2ff09, fairly obvious...

Whoops.  Thanks.

> Fix to [PATCH v4 15/16] mm/truncate,shmem: Handle truncates that split THPs.
> One machine ran fine, swapping and building in ext4 on loop0 on huge tmpfs;
> one machine got occasional pages of zeros in its .os; one machine couldn't
> get started because of ext4_find_dest_de errors on the newly mkfs'ed fs.
> The partial_end case was decided by PAGE_SIZE, when there might be a THP
> there.  The below patch has run well (for not very long), but I could
> easily have got it slightly wrong, off-by-one or whatever; and I have
> not looked into the similar code in mm/truncate.c, maybe that will need
> a similar fix or maybe not.
> 
> --- 5103w/mm/shmem.c	2020-11-12 15:46:21.075254036 -0800
> +++ 5103wh/mm/shmem.c	2020-11-16 01:09:35.431677308 -0800
> @@ -874,7 +874,7 @@ static void shmem_undo_range(struct inod
>  	long nr_swaps_freed = 0;
>  	pgoff_t index;
>  	int i;
> -	bool partial_end;
> +	bool same_page;
>  
>  	if (lend == -1)
>  		end = -1;	/* unsigned, so actually very big */
> @@ -907,16 +907,12 @@ static void shmem_undo_range(struct inod
>  		index++;
>  	}
>  
> -	partial_end = ((lend + 1) % PAGE_SIZE) > 0;
> +	same_page = (lstart >> PAGE_SHIFT) == end;
>  	page = NULL;
>  	shmem_getpage(inode, lstart >> PAGE_SHIFT, &page, SGP_READ);
>  	if (page) {
> -		bool same_page;
> -
>  		page = thp_head(page);
>  		same_page = lend < page_offset(page) + thp_size(page);
> -		if (same_page)
> -			partial_end = false;

I don't object to this patch at all, at least partly because it's shorter
and simpler!  I don't understand what it's solving, though.  The case
where there's a THP which covers partial_end is supposed to be handled
by the three lines above.

> Fix to [PATCH v4 15/16] mm/truncate,shmem: Handle truncates that split THPs.
> xfstests generic/012 on huge tmpfs hit this every time (when checking
> xfs_io commands available: later decides "not run" because no "fiemap").
> I grabbed this line unthinkingly from one of your later series, it fixes
> the crash; but once I actually thought about it when trying to track down
> weirder behaviours, realize that the kmap_atomic() and flush_dcache_page()
> in zero_user_segments() are not prepared for a THP - so highmem and
> flush_dcache_page architectures will be disappointed. If I searched
> through your other series, I might find the complete fix; or perhaps
> it's already there in linux-next, I haven't looked.

zero_user_segments() is fixed by "mm: Support THPs in zero_user_segments".
I think most recently posted here:
https://lore.kernel.org/linux-mm/20201026183136.10404-2-willy@infradead.org/

My fault for not realising this patch depended on that patch.  I did
test these patches stand-alone, but it didn't trigger this problem.

flush_dcache_page() needs to be called once for each sub-page.  We
really need a flush_dcache_thp() so that architectures can optimise this.
Although maybe now that's going to be called flush_dcache_folio().

> I also had noise from the WARN_ON(page_to_index(page) != index)
> in invalidate_inode_pages2_range(): but that's my problem, since
> for testing I add a dummy shmem_direct_IO() (return 0): for that
> I've now added a shmem_mapping() check at the head of pages2_range().

Ah, I have a later fix for invalidate_inode_pages2_range():
https://lore.kernel.org/linux-mm/20201026183136.10404-6-willy@infradead.org/

I didn't post it earlier because there aren't any filesystems currently
which use THPs and directIO ;-)

> That's all for now: I'll fire off more overnight testing.

Thanks!
