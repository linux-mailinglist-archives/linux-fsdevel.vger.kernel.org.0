Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D168328D43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 00:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388622AbfEWWgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 18:36:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:10352 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387735AbfEWWgI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 18:36:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 15:36:07 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 15:36:07 -0700
Date:   Thu, 23 May 2019 15:37:01 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/1] infiniband/mm: convert put_page() to put_user_page*()
Message-ID: <20190523223701.GA15048@iweiny-DESK2.sc.intel.com>
References: <20190523072537.31940-1-jhubbard@nvidia.com>
 <20190523072537.31940-2-jhubbard@nvidia.com>
 <20190523172852.GA27175@iweiny-DESK2.sc.intel.com>
 <20190523173222.GH12145@mellanox.com>
 <fa6d7d7c-13a3-0586-6384-768ebb7f0561@nvidia.com>
 <20190523190423.GA19578@iweiny-DESK2.sc.intel.com>
 <0bd9859f-8eb0-9148-6209-08ae42665626@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd9859f-8eb0-9148-6209-08ae42665626@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 12:13:59PM -0700, John Hubbard wrote:
> On 5/23/19 12:04 PM, Ira Weiny wrote:
> > On Thu, May 23, 2019 at 10:46:38AM -0700, John Hubbard wrote:
> > > On 5/23/19 10:32 AM, Jason Gunthorpe wrote:
> > > > On Thu, May 23, 2019 at 10:28:52AM -0700, Ira Weiny wrote:
> > > > > > @@ -686,8 +686,8 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
> > > > > >    			 * ib_umem_odp_map_dma_single_page().
> > > > > >    			 */
> > > > > >    			if (npages - (j + 1) > 0)
> > > > > > -				release_pages(&local_page_list[j+1],
> > > > > > -					      npages - (j + 1));
> > > > > > +				put_user_pages(&local_page_list[j+1],
> > > > > > +					       npages - (j + 1));
> > > > > 
> > > > > I don't know if we discussed this before but it looks like the use of
> > > > > release_pages() was not entirely correct (or at least not necessary) here.  So
> > > > > I think this is ok.
> > > > 
> > > > Oh? John switched it from a put_pages loop to release_pages() here:
> > > > 
> > > > commit 75a3e6a3c129cddcc683538d8702c6ef998ec589
> > > > Author: John Hubbard <jhubbard@nvidia.com>
> > > > Date:   Mon Mar 4 11:46:45 2019 -0800
> > > > 
> > > >       RDMA/umem: minor bug fix in error handling path
> > > >       1. Bug fix: fix an off by one error in the code that cleans up if it fails
> > > >          to dma-map a page, after having done a get_user_pages_remote() on a
> > > >          range of pages.
> > > >       2. Refinement: for that same cleanup code, release_pages() is better than
> > > >          put_page() in a loop.
> > > > 
> > > > And now we are going to back something called put_pages() that
> > > > implements the same for loop the above removed?
> > > > 
> > > > Seems like we are going in circles?? John?
> > > > 
> > > 
> > > put_user_pages() is meant to be a drop-in replacement for release_pages(),
> > > so I made the above change as an interim step in moving the callsite from
> > > a loop, to a single call.
> > > 
> > > And at some point, it may be possible to find a way to optimize put_user_pages()
> > > in a similar way to the batching that release_pages() does, that was part
> > > of the plan for this.
> > > 
> > > But I do see what you mean: in the interim, maybe put_user_pages() should
> > > just be calling release_pages(), how does that change sound?
> > 
> > I'm certainly not the expert here but FWICT release_pages() was originally
> > designed to work with the page cache.
> > 
> > aabfb57296e3  mm: memcontrol: do not kill uncharge batching in free_pages_and_swap_cache
> > 
> > But at some point it was changed to be more general?
> > 
> > ea1754a08476 mm, fs: remove remaining PAGE_CACHE_* and page_cache_{get,release} usage
> > 
> > ... and it is exported and used outside of the swapping code... and used at
> > lease 1 place to directly "put" pages gotten from get_user_pages_fast()
> > [arch/x86/kvm/svm.c]
> > 
> >  From that it seems like it is safe.
> > 
> > But I don't see where release_page() actually calls put_page() anywhere?  What
> > am I missing?
> > 
> 
> For that question, I recall having to look closely at this function, as well:
> 
> void release_pages(struct page **pages, int nr)
> {
> 	int i;
> 	LIST_HEAD(pages_to_free);
> 	struct pglist_data *locked_pgdat = NULL;
> 	struct lruvec *lruvec;
> 	unsigned long uninitialized_var(flags);
> 	unsigned int uninitialized_var(lock_batch);
> 
> 	for (i = 0; i < nr; i++) {
> 		struct page *page = pages[i];
> 
> 		/*
> 		 * Make sure the IRQ-safe lock-holding time does not get
> 		 * excessive with a continuous string of pages from the
> 		 * same pgdat. The lock is held only if pgdat != NULL.
> 		 */
> 		if (locked_pgdat && ++lock_batch == SWAP_CLUSTER_MAX) {
> 			spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
> 			locked_pgdat = NULL;
> 		}
> 
> 		if (is_huge_zero_page(page))
> 			continue;
> 
> 		/* Device public page can not be huge page */
> 		if (is_device_public_page(page)) {
> 			if (locked_pgdat) {
> 				spin_unlock_irqrestore(&locked_pgdat->lru_lock,
> 						       flags);
> 				locked_pgdat = NULL;
> 			}
> 			put_devmap_managed_page(page);
> 			continue;
> 		}
> 
> 		page = compound_head(page);
> 		if (!put_page_testzero(page))
> 
> 		     ^here is where it does the put_page() call, is that what
> 			you were looking for?

Yes I saw that...

I've dug in further and I see now that release_pages() implements (almost the
same thing, see below) as put_page().

However, I think we need to be careful here because put_page_testzero() calls

	page_ref_dec_and_test(page);

... and after your changes it will need to call ...

	page_ref_sub_return(page, GUP_PIN_COUNTING_BIAS);

... on a GUP page:

So how do you propose calling release_pages() from within put_user_pages()?  Or
were you thinking this would be temporary?

That said, there are 2 differences I see between release_pages() and put_page()

1) release_pages() will only work for a MEMORY_DEVICE_PUBLIC page and not all
   devmem pages...
   I think this is a bug, patch to follow shortly.

2) release_pages() calls __ClearPageActive() while put_page() does not

I have no idea if the second difference is a bug or not.  But it smells of
one...

It would be nice to know if the open coding of put_page is really a performance
benefit or not.  It seems like an attempt to optimize the taking of the page
data lock.

Does anyone have any information about the performance advantage here?

Given the changes above it seems like it would be a benefit to merge the 2 call
paths more closely to make sure we do the right thing.

Ira

