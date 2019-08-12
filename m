Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC15D8AA1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 00:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfHLWDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 18:03:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:16865 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfHLWDp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:03:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 15:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,379,1559545200"; 
   d="scan'208";a="176019166"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 12 Aug 2019 15:03:44 -0700
Date:   Mon, 12 Aug 2019 15:03:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     john.hubbard@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
Message-ID: <20190812220340.GA26305@iweiny-DESK2.sc.intel.com>
References: <20190812015044.26176-1-jhubbard@nvidia.com>
 <20190812015044.26176-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812015044.26176-3-jhubbard@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 11, 2019 at 06:50:44PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> This is the "vaddr_pin_pages" corresponding variant to
> get_user_pages_remote(), but with FOLL_PIN semantics: the implementation
> sets FOLL_PIN. That, in turn, means that the pages must ultimately be
> released by put_user_page*()--typically, via vaddr_unpin_pages*().
> 
> Note that the put_user_page*() requirement won't be truly
> required until all of the call sites have been converted, and
> the tracking of pages is actually activated.
> 
> Also introduce vaddr_unpin_pages(), in order to have a simpler
> call for the error handling cases.
> 
> Use both of these new calls in the Infiniband drive, replacing
> get_user_pages_remote() and put_user_pages().
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 15 +++++----
>  include/linux/mm.h                 |  7 +++++
>  mm/gup.c                           | 50 ++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> index 53085896d718..fdff034a8a30 100644
> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -534,7 +534,7 @@ static int ib_umem_odp_map_dma_single_page(
>  	}
>  
>  out:
> -	put_user_page(page);
> +	vaddr_unpin_pages(&page, 1, &umem_odp->umem.vaddr_pin);
>  
>  	if (remove_existing_mapping) {
>  		ib_umem_notifier_start_account(umem_odp);
> @@ -635,9 +635,10 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
>  		 * complex (and doesn't gain us much performance in most use
>  		 * cases).
>  		 */
> -		npages = get_user_pages_remote(owning_process, owning_mm,
> +		npages = vaddr_pin_pages_remote(owning_process, owning_mm,
>  				user_virt, gup_num_pages,
> -				flags, local_page_list, NULL, NULL);
> +				flags, local_page_list, NULL, NULL,
> +				&umem_odp->umem.vaddr_pin);
>  		up_read(&owning_mm->mmap_sem);
>  
>  		if (npages < 0) {
> @@ -657,7 +658,8 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
>  					ret = -EFAULT;
>  					break;
>  				}
> -				put_user_page(local_page_list[j]);
> +				vaddr_unpin_pages(&local_page_list[j], 1,
> +						  &umem_odp->umem.vaddr_pin);
>  				continue;
>  			}
>  
> @@ -684,8 +686,9 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
>  			 * ib_umem_odp_map_dma_single_page().
>  			 */
>  			if (npages - (j + 1) > 0)
> -				put_user_pages(&local_page_list[j+1],
> -					       npages - (j + 1));
> +				vaddr_unpin_pages(&local_page_list[j+1],
> +						  npages - (j + 1),
> +						  &umem_odp->umem.vaddr_pin);
>  			break;
>  		}
>  	}
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 61b616cd9243..2bd76ad8787e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1606,6 +1606,13 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
>  long vaddr_pin_pages(unsigned long addr, unsigned long nr_pages,
>  		     unsigned int gup_flags, struct page **pages,
>  		     struct vaddr_pin *vaddr_pin);
> +long vaddr_pin_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
> +			    unsigned long start, unsigned long nr_pages,
> +			    unsigned int gup_flags, struct page **pages,
> +			    struct vm_area_struct **vmas, int *locked,
> +			    struct vaddr_pin *vaddr_pin);
> +void vaddr_unpin_pages(struct page **pages, unsigned long nr_pages,
> +		       struct vaddr_pin *vaddr_pin);
>  void vaddr_unpin_pages_dirty_lock(struct page **pages, unsigned long nr_pages,
>  				  struct vaddr_pin *vaddr_pin, bool make_dirty);
>  bool mapping_inode_has_layout(struct vaddr_pin *vaddr_pin, struct page *page);
> diff --git a/mm/gup.c b/mm/gup.c
> index 85f09958fbdc..bb95adfaf9b6 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2518,6 +2518,38 @@ long vaddr_pin_pages(unsigned long addr, unsigned long nr_pages,
>  }
>  EXPORT_SYMBOL(vaddr_pin_pages);
>  
> +/**
> + * vaddr_pin_pages pin pages by virtual address and return the pages to the

vaddr_pin_pages_remote

Fixed in my tree.

> + * user.
> + *
> + * @tsk:	the task_struct to use for page fault accounting, or
> + *		NULL if faults are not to be recorded.
> + * @mm:		mm_struct of target mm
> + * @addr:	start address
> + * @nr_pages:	number of pages to pin
> + * @gup_flags:	flags to use for the pin
> + * @pages:	array of pages returned
> + * @vaddr_pin:	initialized meta information this pin is to be associated
> + * with.
> + *
> + * This is the "vaddr_pin_pages" corresponding variant to
> + * get_user_pages_remote(), but with FOLL_PIN semantics: the implementation sets
> + * FOLL_PIN. That, in turn, means that the pages must ultimately be released
> + * by put_user_page().
> + */
> +long vaddr_pin_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
> +			    unsigned long start, unsigned long nr_pages,
> +			    unsigned int gup_flags, struct page **pages,
> +			    struct vm_area_struct **vmas, int *locked,
> +			    struct vaddr_pin *vaddr_pin)
> +{
> +	gup_flags |= FOLL_TOUCH | FOLL_REMOTE | FOLL_PIN;
> +
> +	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
> +				       locked, gup_flags, vaddr_pin);
> +}
> +EXPORT_SYMBOL(vaddr_pin_pages_remote);
> +
>  /**
>   * vaddr_unpin_pages_dirty_lock - counterpart to vaddr_pin_pages
>   *
> @@ -2536,3 +2568,21 @@ void vaddr_unpin_pages_dirty_lock(struct page **pages, unsigned long nr_pages,
>  	__put_user_pages_dirty_lock(vaddr_pin, pages, nr_pages, make_dirty);
>  }
>  EXPORT_SYMBOL(vaddr_unpin_pages_dirty_lock);
> +
> +/**
> + * vaddr_unpin_pages - simple, non-dirtying counterpart to vaddr_pin_pages
> + *
> + * @pages: array of pages returned
> + * @nr_pages: number of pages in pages
> + * @vaddr_pin: same information passed to vaddr_pin_pages
> + *
> + * Like vaddr_unpin_pages_dirty_lock, but for non-dirty pages. Useful in putting
> + * back pages in an error case: they were never made dirty.
> + */
> +void vaddr_unpin_pages(struct page **pages, unsigned long nr_pages,
> +		       struct vaddr_pin *vaddr_pin)
> +{
> +	__put_user_pages_dirty_lock(vaddr_pin, pages, nr_pages, false);
> +}
> +EXPORT_SYMBOL(vaddr_unpin_pages);

Rather than have another wrapping call why don't we just do this?  Would it be
so bad to just have to specify false for make_dirty?


diff --git a/mm/gup.c b/mm/gup.c
index e77b250c1307..ca660a5e8206 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2540,7 +2540,7 @@ long vaddr_pin_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
 EXPORT_SYMBOL(vaddr_pin_pages_remote);
 
 /**
- * vaddr_unpin_pages_dirty_lock - counterpart to vaddr_pin_pages
+ * vaddr_unpin_pages - counterpart to vaddr_pin_pages
  *
  * @pages: array of pages returned
  * @nr_pages: number of pages in pages
@@ -2551,26 +2551,9 @@ EXPORT_SYMBOL(vaddr_pin_pages_remote);
  * in vaddr_pin_pages should be passed back into this call for proper
  * tracking.
  */
-void vaddr_unpin_pages_dirty_lock(struct page **pages, unsigned long nr_pages,
-                                 struct vaddr_pin *vaddr_pin, bool make_dirty)
+void vaddr_unpin_pages(struct page **pages, unsigned long nr_pages,
+                      struct vaddr_pin *vaddr_pin, bool make_dirty)
 {
        __put_user_pages_dirty_lock(vaddr_pin, pages, nr_pages, make_dirty);
 }
 EXPORT_SYMBOL(vaddr_unpin_pages_dirty_lock);
-
-/**
- * vaddr_unpin_pages - simple, non-dirtying counterpart to vaddr_pin_pages
- *
- * @pages: array of pages returned
- * @nr_pages: number of pages in pages
- * @vaddr_pin: same information passed to vaddr_pin_pages
- *
- * Like vaddr_unpin_pages_dirty_lock, but for non-dirty pages. Useful in putting
- * back pages in an error case: they were never made dirty.
- */
-void vaddr_unpin_pages(struct page **pages, unsigned long nr_pages,
-                      struct vaddr_pin *vaddr_pin)
-{
-       __put_user_pages_dirty_lock(vaddr_pin, pages, nr_pages, false);
-}
-EXPORT_SYMBOL(vaddr_unpin_pages);
