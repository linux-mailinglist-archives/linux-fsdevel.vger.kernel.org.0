Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F31F166D60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 04:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgBUDUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 22:20:05 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19121 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbgBUDUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 22:20:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4f4c170000>; Thu, 20 Feb 2020 19:18:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 19:20:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 19:20:00 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Feb
 2020 03:19:58 +0000
Subject: Re: [PATCH v7 09/24] mm: Put readahead pages in cache earlier
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-10-willy@infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <5691442b-56c7-7b0d-d91b-275be52abb42@nvidia.com>
Date:   Thu, 20 Feb 2020 19:19:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219210103.32400-10-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582255127; bh=d9GO24BnJ9chVyb7bjDvehilb1nYQfQG1WbFa23HlCQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=j8lnjXCIkqwMrXJaVVDslJxTWLAnUGO/CaWyqjQLudoTMm3i9Zx3OqJhlyB9Yyhq+
         utkP6BZFbavm1AmbhdA+XFIXY5d3Kj33MMh1p8Uk0onLlle+ytW3uHn9sEhzomIheI
         Se+a2E+KXmhwvFtDc9hHRwsk8PVOBI1/XGSQWpesFfsXpMZEAeJylOzpozmk9xhzFj
         MZfu8A1bf4E5H4WCdDcjNC/yj/pHtBcxhV2Pb4lZVU17ufmzgkLLLQQ309cKct9ZkV
         TVR///Pi86EMvWedrYrq49dcDa3rkvkyTy76J1dRBqQ1zbotcoI7AyAadLWkOyAg8u
         OWp28i0wa/20A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/19/20 1:00 PM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> When populating the page cache for readahead, mappings that use
> ->readpages must populate the page cache themselves as the pages are
> passed on a linked list which would normally be used for the page cache's
> LRU.  For mappings that use ->readpage or the upcoming ->readahead method,
> we can put the pages into the page cache as soon as they're allocated,
> which solves a race between readahead and direct IO.  It also lets us
> remove the gfp argument from read_pages().
> 
> Use the new readahead_page() API to implement the repeated calls to
> ->readpage(), just like most filesystems will.  This iterator also
> supports huge pages, even though none of the filesystems have been
> converted to use them yet.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 20 +++++++++++++++++
>  mm/readahead.c          | 48 +++++++++++++++++++++++++----------------
>  2 files changed, 49 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 55fcea0249e6..4989d330fada 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -647,8 +647,28 @@ struct readahead_control {
>  /* private: use the readahead_* accessors instead */
>  	pgoff_t _index;
>  	unsigned int _nr_pages;
> +	unsigned int _batch_count;
>  };
>  
> +static inline struct page *readahead_page(struct readahead_control *rac)
> +{
> +	struct page *page;
> +
> +	BUG_ON(rac->_batch_count > rac->_nr_pages);
> +	rac->_nr_pages -= rac->_batch_count;
> +	rac->_index += rac->_batch_count;
> +	rac->_batch_count = 0;


Is it intentional, to set rac->_batch_count twice (here, and below)? The
only reason I can see is if a caller needs to use ->_batch_count in the
"return NULL" case, which doesn't seem to come up...


> +
> +	if (!rac->_nr_pages)
> +		return NULL;
> +
> +	page = xa_load(&rac->mapping->i_pages, rac->_index);
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	rac->_batch_count = hpage_nr_pages(page);
> +
> +	return page;
> +}
> +
>  /* The number of pages in this readahead block */
>  static inline unsigned int readahead_count(struct readahead_control *rac)
>  {
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 83df5c061d33..aaa209559ba2 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -113,15 +113,14 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
>  
>  EXPORT_SYMBOL(read_cache_pages);
>  
> -static void read_pages(struct readahead_control *rac, struct list_head *pages,
> -		gfp_t gfp)
> +static void read_pages(struct readahead_control *rac, struct list_head *pages)
>  {
>  	const struct address_space_operations *aops = rac->mapping->a_ops;
> +	struct page *page;
>  	struct blk_plug plug;
> -	unsigned page_idx;
>  
>  	if (!readahead_count(rac))
> -		return;
> +		goto out;
>  
>  	blk_start_plug(&plug);
>  
> @@ -130,23 +129,23 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
>  				readahead_count(rac));
>  		/* Clean up the remaining pages */
>  		put_pages_list(pages);
> -		goto out;
> -	}
> -
> -	for (page_idx = 0; page_idx < readahead_count(rac); page_idx++) {
> -		struct page *page = lru_to_page(pages);
> -		list_del(&page->lru);
> -		if (!add_to_page_cache_lru(page, rac->mapping, page->index,
> -				gfp))
> +		rac->_index += rac->_nr_pages;
> +		rac->_nr_pages = 0;
> +	} else {
> +		while ((page = readahead_page(rac))) {
>  			aops->readpage(rac->file, page);
> -		put_page(page);
> +			put_page(page);
> +		}
>  	}
>  
> -out:
>  	blk_finish_plug(&plug);
>  
>  	BUG_ON(!list_empty(pages));
> -	rac->_nr_pages = 0;
> +	BUG_ON(readahead_count(rac));
> +
> +out:
> +	/* If we were called due to a conflicting page, skip over it */


Tiny documentation nit: What if we were *not* called due to a conflicting page? 
(And what is a "conflicting page", in this context, btw?) The next line unconditionally 
moves the index ahead, so the "if" part of the comment really confuses me.


> +	rac->_index++;
>  }
>  
>  /*
> @@ -165,9 +164,11 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	LIST_HEAD(page_pool);
>  	loff_t isize = i_size_read(inode);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
> +	bool use_list = mapping->a_ops->readpages;
>  	struct readahead_control rac = {
>  		.mapping = mapping,
>  		.file = filp,
> +		._index = index,
>  		._nr_pages = 0,
>  	};
>  	unsigned long i;
> @@ -184,6 +185,8 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		if (index + i > end_index)
>  			break;
>  
> +		BUG_ON(index + i != rac._index + rac._nr_pages);
> +
>  		page = xa_load(&mapping->i_pages, index + i);
>  		if (page && !xa_is_value(page)) {
>  			/*
> @@ -191,15 +194,22 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  			 * contiguous pages before continuing with the next
>  			 * batch.
>  			 */
> -			read_pages(&rac, &page_pool, gfp_mask);
> +			read_pages(&rac, &page_pool);
>  			continue;
>  		}
>  
>  		page = __page_cache_alloc(gfp_mask);
>  		if (!page)
>  			break;
> -		page->index = index + i;
> -		list_add(&page->lru, &page_pool);
> +		if (use_list) {
> +			page->index = index + i;
> +			list_add(&page->lru, &page_pool);
> +		} else if (add_to_page_cache_lru(page, mapping, index + i,
> +					gfp_mask) < 0) {


I still think you'll want to compare against !=0, rather than < 0, here.


> +			put_page(page);
> +			read_pages(&rac, &page_pool);


Doing a read_pages() in the error case is because...actually, I'm not sure yet.
Why do we do this? Effectively it's a retry?


> +			continue;
> +		}
>  		if (i == nr_to_read - lookahead_size)
>  			SetPageReadahead(page);
>  		rac._nr_pages++;
> @@ -210,7 +220,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	 * uptodate then the caller will launch readpage again, and
>  	 * will then handle the error.
>  	 */
> -	read_pages(&rac, &page_pool, gfp_mask);
> +	read_pages(&rac, &page_pool);
>  }
>  
>  /*
> 

Didn't spot any actual errors, just mainly my own questions here. :)


thanks,
-- 
John Hubbard
NVIDIA
