Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2176188758
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 02:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfHJAaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 20:30:03 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11301 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfHJAaD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 20:30:03 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4e100b0000>; Fri, 09 Aug 2019 17:30:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 09 Aug 2019 17:30:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 09 Aug 2019 17:30:01 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 10 Aug
 2019 00:30:00 +0000
Subject: Re: [RFC PATCH v2 12/19] mm/gup: Prep put_user_pages() to take an
 vaddr_pin struct
To:     <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        <linux-xfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-ext4@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-13-ira.weiny@intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <12b6a576-7a64-102c-f4d7-7a4ad34df710@nvidia.com>
Date:   Fri, 9 Aug 2019 17:30:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809225833.6657-13-ira.weiny@intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565397003; bh=b6l0EcXIqF+/G734s3cwMmTuz8hr26aRZITM0rTS7i0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YuSjKP4AhoHBLbcLLk3pP6lpPKp3lDROEPEvTqE9UI51WZMnw7gDxHjDxCNYgrKFG
         eJSblzJ11XR+iPKHqtIBfdezKsvu3QyJNyAtWH8orgG5n3CXjFYzGPRkTarpeyNBWM
         Ld3eQEAg5q/fhZpMxjwhjHlvzkvWoxrjGf8mteQe/9zOwX+/hKrNHzUUZDIkFyAvE4
         TUmARG5/QH4nieV6kDH49Ow4NjXJWhjIX2dJU7VZ8T9crzyuhKuNKD4B0ovUrTCKYM
         z6Jov3Bvzd7/f65uk7zLQUZ9QVk+5mVU49Voiwk1vsJL5LuA4oqdZMOTf5a8XkXl6c
         7USB/u58j90KA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/9/19 3:58 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Once callers start to use vaddr_pin the put_user_pages calls will need
> to have access to this data coming in.  Prep put_user_pages() for this
> data.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  include/linux/mm.h |  20 +-------
>  mm/gup.c           | 122 ++++++++++++++++++++++++++++++++-------------
>  2 files changed, 88 insertions(+), 54 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index befe150d17be..9d37cafbef9a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1064,25 +1064,7 @@ static inline void put_page(struct page *page)
>  		__put_page(page);
>  }
>  
> -/**
> - * put_user_page() - release a gup-pinned page
> - * @page:            pointer to page to be released
> - *
> - * Pages that were pinned via get_user_pages*() must be released via
> - * either put_user_page(), or one of the put_user_pages*() routines
> - * below. This is so that eventually, pages that are pinned via
> - * get_user_pages*() can be separately tracked and uniquely handled. In
> - * particular, interactions with RDMA and filesystems need special
> - * handling.
> - *
> - * put_user_page() and put_page() are not interchangeable, despite this early
> - * implementation that makes them look the same. put_user_page() calls must
> - * be perfectly matched up with get_user_page() calls.
> - */
> -static inline void put_user_page(struct page *page)
> -{
> -	put_page(page);
> -}
> +void put_user_page(struct page *page);
>  
>  void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>  			       bool make_dirty);
> diff --git a/mm/gup.c b/mm/gup.c
> index a7a9d2f5278c..10cfd30ff668 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -24,30 +24,41 @@
>  
>  #include "internal.h"
>  
> -/**
> - * put_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
> - * @pages:  array of pages to be maybe marked dirty, and definitely released.

A couple comments from our circular review chain: some fellow with the same
last name as you, recommended wording it like this:

      @pages:  array of pages to be put

> - * @npages: number of pages in the @pages array.
> - * @make_dirty: whether to mark the pages dirty
> - *
> - * "gup-pinned page" refers to a page that has had one of the get_user_pages()
> - * variants called on that page.
> - *
> - * For each page in the @pages array, make that page (or its head page, if a
> - * compound page) dirty, if @make_dirty is true, and if the page was previously
> - * listed as clean. In any case, releases all pages using put_user_page(),
> - * possibly via put_user_pages(), for the non-dirty case.
> - *
> - * Please see the put_user_page() documentation for details.
> - *
> - * set_page_dirty_lock() is used internally. If instead, set_page_dirty() is
> - * required, then the caller should a) verify that this is really correct,
> - * because _lock() is usually required, and b) hand code it:
> - * set_page_dirty_lock(), put_user_page().
> - *
> - */
> -void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
> -			       bool make_dirty)
> +static void __put_user_page(struct vaddr_pin *vaddr_pin, struct page *page)
> +{
> +	page = compound_head(page);
> +
> +	/*
> +	 * For devmap managed pages we need to catch refcount transition from
> +	 * GUP_PIN_COUNTING_BIAS to 1, when refcount reach one it means the
> +	 * page is free and we need to inform the device driver through
> +	 * callback. See include/linux/memremap.h and HMM for details.
> +	 */
> +	if (put_devmap_managed_page(page))
> +		return;
> +
> +	if (put_page_testzero(page))
> +		__put_page(page);
> +}
> +
> +static void __put_user_pages(struct vaddr_pin *vaddr_pin, struct page **pages,
> +			     unsigned long npages)
> +{
> +	unsigned long index;
> +
> +	/*
> +	 * TODO: this can be optimized for huge pages: if a series of pages is
> +	 * physically contiguous and part of the same compound page, then a
> +	 * single operation to the head page should suffice.
> +	 */

As discussed in the other review thread (""), let's just delete that comment,
as long as you're moving things around.


> +	for (index = 0; index < npages; index++)
> +		__put_user_page(vaddr_pin, pages[index]);
> +}
> +
> +static void __put_user_pages_dirty_lock(struct vaddr_pin *vaddr_pin,
> +					struct page **pages,
> +					unsigned long npages,
> +					bool make_dirty)

Elsewhere in this series, we pass vaddr_pin at the end of the arg list.
Here we pass it at the beginning, and it caused a minor jar when reading it.
Obviously just bike shedding at this point, though. Either way. :)

>  {
>  	unsigned long index;
>  
> @@ -58,7 +69,7 @@ void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>  	 */
>  
>  	if (!make_dirty) {
> -		put_user_pages(pages, npages);
> +		__put_user_pages(vaddr_pin, pages, npages);
>  		return;
>  	}
>  
> @@ -86,9 +97,58 @@ void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>  		 */
>  		if (!PageDirty(page))
>  			set_page_dirty_lock(page);
> -		put_user_page(page);
> +		__put_user_page(vaddr_pin, page);
>  	}
>  }
> +
> +/**
> + * put_user_page() - release a gup-pinned page
> + * @page:            pointer to page to be released
> + *
> + * Pages that were pinned via get_user_pages*() must be released via
> + * either put_user_page(), or one of the put_user_pages*() routines
> + * below. This is so that eventually, pages that are pinned via
> + * get_user_pages*() can be separately tracked and uniquely handled. In
> + * particular, interactions with RDMA and filesystems need special
> + * handling.
> + *
> + * put_user_page() and put_page() are not interchangeable, despite this early
> + * implementation that makes them look the same. put_user_page() calls must
> + * be perfectly matched up with get_user_page() calls.
> + */
> +void put_user_page(struct page *page)
> +{
> +	__put_user_page(NULL, page);
> +}
> +EXPORT_SYMBOL(put_user_page);
> +
> +/**
> + * put_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
> + * @pages:  array of pages to be maybe marked dirty, and definitely released.

Same here:

      @pages:  array of pages to be put

> + * @npages: number of pages in the @pages array.
> + * @make_dirty: whether to mark the pages dirty
> + *
> + * "gup-pinned page" refers to a page that has had one of the get_user_pages()
> + * variants called on that page.
> + *
> + * For each page in the @pages array, make that page (or its head page, if a
> + * compound page) dirty, if @make_dirty is true, and if the page was previously
> + * listed as clean. In any case, releases all pages using put_user_page(),
> + * possibly via put_user_pages(), for the non-dirty case.
> + *
> + * Please see the put_user_page() documentation for details.
> + *
> + * set_page_dirty_lock() is used internally. If instead, set_page_dirty() is
> + * required, then the caller should a) verify that this is really correct,
> + * because _lock() is usually required, and b) hand code it:
> + * set_page_dirty_lock(), put_user_page().
> + *
> + */
> +void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
> +			       bool make_dirty)
> +{
> +	__put_user_pages_dirty_lock(NULL, pages, npages, make_dirty);
> +}
>  EXPORT_SYMBOL(put_user_pages_dirty_lock);
>  
>  /**
> @@ -102,15 +162,7 @@ EXPORT_SYMBOL(put_user_pages_dirty_lock);
>   */
>  void put_user_pages(struct page **pages, unsigned long npages)
>  {
> -	unsigned long index;
> -
> -	/*
> -	 * TODO: this can be optimized for huge pages: if a series of pages is
> -	 * physically contiguous and part of the same compound page, then a
> -	 * single operation to the head page should suffice.
> -	 */
> -	for (index = 0; index < npages; index++)
> -		put_user_page(pages[index]);
> +	__put_user_pages(NULL, pages, npages);
>  }
>  EXPORT_SYMBOL(put_user_pages);
>  
> 

This all looks pretty good, so regardless of the outcome of the minor
points above,
   
    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA
