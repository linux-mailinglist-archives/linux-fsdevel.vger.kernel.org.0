Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9FF284EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 19:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfEWR2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 13:28:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:15627 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbfEWR2A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 13:28:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 10:27:59 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2019 10:27:59 -0700
Date:   Thu, 23 May 2019 10:28:52 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     john.hubbard@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 1/1] infiniband/mm: convert put_page() to put_user_page*()
Message-ID: <20190523172852.GA27175@iweiny-DESK2.sc.intel.com>
References: <20190523072537.31940-1-jhubbard@nvidia.com>
 <20190523072537.31940-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523072537.31940-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 12:25:37AM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For infiniband code that retains pages via get_user_pages*(),
> release those pages via the new put_user_page(), or
> put_user_pages*(), instead of put_page()
> 
> This is a tiny part of the second step of fixing the problem described
> in [1]. The steps are:
> 
> 1) Provide put_user_page*() routines, intended to be used
>    for releasing pages that were pinned via get_user_pages*().
> 
> 2) Convert all of the call sites for get_user_pages*(), to
>    invoke put_user_page*(), instead of put_page(). This involves dozens of
>    call sites, and will take some time.
> 
> 3) After (2) is complete, use get_user_pages*() and put_user_page*() to
>    implement tracking of these pages. This tracking will be separate from
>    the existing struct page refcounting.
> 
> 4) Use the tracking and identification of these pages, to implement
>    special handling (especially in writeback paths) when the pages are
>    backed by a filesystem. Again, [1] provides details as to why that is
>    desirable.
> 
> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
> 
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Cc: Christian Benvenuti <benve@cisco.com>
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Acked-by: Jason Gunthorpe <jgg@mellanox.com>
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c              |  7 ++++---
>  drivers/infiniband/core/umem_odp.c          | 10 +++++-----
>  drivers/infiniband/hw/hfi1/user_pages.c     | 11 ++++-------
>  drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +++---
>  drivers/infiniband/hw/qib/qib_user_pages.c  | 11 ++++-------
>  drivers/infiniband/hw/qib/qib_user_sdma.c   |  6 +++---
>  drivers/infiniband/hw/usnic/usnic_uiom.c    |  7 ++++---
>  7 files changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index e7ea819fcb11..673f0d240b3e 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -54,9 +54,10 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
>  
>  	for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->sg_nents, 0) {
>  		page = sg_page_iter_page(&sg_iter);
> -		if (!PageDirty(page) && umem->writable && dirty)
> -			set_page_dirty_lock(page);
> -		put_page(page);
> +		if (umem->writable && dirty)
> +			put_user_pages_dirty_lock(&page, 1);
> +		else
> +			put_user_page(page);
>  	}
>  
>  	sg_free_table(&umem->sg_head);
> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> index f962b5bbfa40..17e46df3990a 100644
> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -487,7 +487,7 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
>   * The function returns -EFAULT if the DMA mapping operation fails. It returns
>   * -EAGAIN if a concurrent invalidation prevents us from updating the page.
>   *
> - * The page is released via put_page even if the operation failed. For
> + * The page is released via put_user_page even if the operation failed. For
>   * on-demand pinning, the page is released whenever it isn't stored in the
>   * umem.
>   */
> @@ -536,7 +536,7 @@ static int ib_umem_odp_map_dma_single_page(
>  	}
>  
>  out:
> -	put_page(page);
> +	put_user_page(page);
>  
>  	if (remove_existing_mapping) {
>  		ib_umem_notifier_start_account(umem_odp);
> @@ -659,7 +659,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
>  					ret = -EFAULT;
>  					break;
>  				}
> -				put_page(local_page_list[j]);
> +				put_user_page(local_page_list[j]);
>  				continue;
>  			}
>  
> @@ -686,8 +686,8 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
>  			 * ib_umem_odp_map_dma_single_page().
>  			 */
>  			if (npages - (j + 1) > 0)
> -				release_pages(&local_page_list[j+1],
> -					      npages - (j + 1));
> +				put_user_pages(&local_page_list[j+1],
> +					       npages - (j + 1));

I don't know if we discussed this before but it looks like the use of
release_pages() was not entirely correct (or at least not necessary) here.  So
I think this is ok.

As for testing, I have been running with this patch for a while but I don't
have ODP hardware so that testing would not cover this code path.  So you can
add my:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

>  			break;
>  		}
>  	}
> diff --git a/drivers/infiniband/hw/hfi1/user_pages.c b/drivers/infiniband/hw/hfi1/user_pages.c
> index 02eee8eff1db..b89a9b9aef7a 100644
> --- a/drivers/infiniband/hw/hfi1/user_pages.c
> +++ b/drivers/infiniband/hw/hfi1/user_pages.c
> @@ -118,13 +118,10 @@ int hfi1_acquire_user_pages(struct mm_struct *mm, unsigned long vaddr, size_t np
>  void hfi1_release_user_pages(struct mm_struct *mm, struct page **p,
>  			     size_t npages, bool dirty)
>  {
> -	size_t i;
> -
> -	for (i = 0; i < npages; i++) {
> -		if (dirty)
> -			set_page_dirty_lock(p[i]);
> -		put_page(p[i]);
> -	}
> +	if (dirty)
> +		put_user_pages_dirty_lock(p, npages);
> +	else
> +		put_user_pages(p, npages);
>  
>  	if (mm) { /* during close after signal, mm can be NULL */
>  		atomic64_sub(npages, &mm->pinned_vm);
> diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.c b/drivers/infiniband/hw/mthca/mthca_memfree.c
> index 8ff0e90d7564..edccfd6e178f 100644
> --- a/drivers/infiniband/hw/mthca/mthca_memfree.c
> +++ b/drivers/infiniband/hw/mthca/mthca_memfree.c
> @@ -482,7 +482,7 @@ int mthca_map_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
>  
>  	ret = pci_map_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
>  	if (ret < 0) {
> -		put_page(pages[0]);
> +		put_user_page(pages[0]);
>  		goto out;
>  	}
>  
> @@ -490,7 +490,7 @@ int mthca_map_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
>  				 mthca_uarc_virt(dev, uar, i));
>  	if (ret) {
>  		pci_unmap_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
> -		put_page(sg_page(&db_tab->page[i].mem));
> +		put_user_page(sg_page(&db_tab->page[i].mem));
>  		goto out;
>  	}
>  
> @@ -556,7 +556,7 @@ void mthca_cleanup_user_db_tab(struct mthca_dev *dev, struct mthca_uar *uar,
>  		if (db_tab->page[i].uvirt) {
>  			mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, uar, i), 1);
>  			pci_unmap_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
> -			put_page(sg_page(&db_tab->page[i].mem));
> +			put_user_page(sg_page(&db_tab->page[i].mem));
>  		}
>  	}
>  
> diff --git a/drivers/infiniband/hw/qib/qib_user_pages.c b/drivers/infiniband/hw/qib/qib_user_pages.c
> index f712fb7fa82f..bfbfbb7e0ff4 100644
> --- a/drivers/infiniband/hw/qib/qib_user_pages.c
> +++ b/drivers/infiniband/hw/qib/qib_user_pages.c
> @@ -40,13 +40,10 @@
>  static void __qib_release_user_pages(struct page **p, size_t num_pages,
>  				     int dirty)
>  {
> -	size_t i;
> -
> -	for (i = 0; i < num_pages; i++) {
> -		if (dirty)
> -			set_page_dirty_lock(p[i]);
> -		put_page(p[i]);
> -	}
> +	if (dirty)
> +		put_user_pages_dirty_lock(p, num_pages);
> +	else
> +		put_user_pages(p, num_pages);
>  }
>  
>  /**
> diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
> index 0c204776263f..ac5bdb02144f 100644
> --- a/drivers/infiniband/hw/qib/qib_user_sdma.c
> +++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
> @@ -317,7 +317,7 @@ static int qib_user_sdma_page_to_frags(const struct qib_devdata *dd,
>  		 * the caller can ignore this page.
>  		 */
>  		if (put) {
> -			put_page(page);
> +			put_user_page(page);
>  		} else {
>  			/* coalesce case */
>  			kunmap(page);
> @@ -631,7 +631,7 @@ static void qib_user_sdma_free_pkt_frag(struct device *dev,
>  			kunmap(pkt->addr[i].page);
>  
>  		if (pkt->addr[i].put_page)
> -			put_page(pkt->addr[i].page);
> +			put_user_page(pkt->addr[i].page);
>  		else
>  			__free_page(pkt->addr[i].page);
>  	} else if (pkt->addr[i].kvaddr) {
> @@ -706,7 +706,7 @@ static int qib_user_sdma_pin_pages(const struct qib_devdata *dd,
>  	/* if error, return all pages not managed by pkt */
>  free_pages:
>  	while (i < j)
> -		put_page(pages[i++]);
> +		put_user_page(pages[i++]);
>  
>  done:
>  	return ret;
> diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
> index e312f522a66d..0b0237d41613 100644
> --- a/drivers/infiniband/hw/usnic/usnic_uiom.c
> +++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
> @@ -75,9 +75,10 @@ static void usnic_uiom_put_pages(struct list_head *chunk_list, int dirty)
>  		for_each_sg(chunk->page_list, sg, chunk->nents, i) {
>  			page = sg_page(sg);
>  			pa = sg_phys(sg);
> -			if (!PageDirty(page) && dirty)
> -				set_page_dirty_lock(page);
> -			put_page(page);
> +			if (dirty)
> +				put_user_pages_dirty_lock(&page, 1);
> +			else
> +				put_user_page(page);
>  			usnic_dbg("pa: %pa\n", &pa);
>  		}
>  		kfree(chunk);
> -- 
> 2.21.0
> 
