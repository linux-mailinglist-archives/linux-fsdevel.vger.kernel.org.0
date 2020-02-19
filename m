Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9CD1637EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 01:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgBSABp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 19:01:45 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17107 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgBSABp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:01:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4c7ac80000>; Tue, 18 Feb 2020 16:01:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Feb 2020 16:01:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Feb 2020 16:01:44 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Feb
 2020 00:01:43 +0000
Subject: Re: [PATCH v6 07/19] mm: Put readahead pages in cache earlier
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-12-willy@infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e3671faa-dfb3-ceba-3120-a445b2982a95@nvidia.com>
Date:   Tue, 18 Feb 2020 16:01:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217184613.19668-12-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582070472; bh=z3Bzj/5bgrV9fPnuzsXFxX0FOV0H+b7fZfF2f3wUJhE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CDXm5ZINDvSMkAMnjJBonRkzIb7iakoxvVztr5ii0adNdeG78Anh8llJWS1Oc3ute
         ciu9+xmTJ9a50yl/a+pixD46BgV6xF+09QnP10UJd4Zpp0lWUdTmM7aBiLhSZDw6Hf
         wCP/rAeJW8P45k+lakQ0Jakmz74bgXZE1S//J77o6oOO3+7Jggx7PzOpoJM5AKYTOZ
         KfIQU7OmVVxsb6VxM6AEe7fCrs6vPu0hc+FYSwUN2mgoONMaQPVhKQI/fdMA+wED9M
         GVdeSW/kF97kpNzr8blN78Wpo/oC7ggjF0inN752QvrA2QkM3LFiAvFbOOfAivj44D
         cOxpPLMH8VOBg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/20 10:45 AM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> At allocation time, put the pages in the cache unless we're using
> ->readpages.  Add the readahead_for_each() iterator for the benefit of
> the ->readpage fallback.  This iterator supports huge pages, even though
> none of the filesystems to be converted do yet.
> 


"Also, remove the gfp argument from read_pages(), now that read_pages()
no longer does allocation."

Generally looks accurate, just a few notes below:


> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 24 ++++++++++++++++++++++++
>  mm/readahead.c          | 34 +++++++++++++++++-----------------
>  2 files changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 982ecda2d4a2..3613154e79e4 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -639,8 +639,32 @@ struct readahead_control {
>  /* private: use the readahead_* accessors instead */
>  	pgoff_t _start;
>  	unsigned int _nr_pages;
> +	unsigned int _batch_count;
>  };
>  
> +static inline struct page *readahead_page(struct readahead_control *rac)
> +{
> +	struct page *page;
> +
> +	if (!rac->_nr_pages)
> +		return NULL;
> +
> +	page = xa_load(&rac->mapping->i_pages, rac->_start);
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	rac->_batch_count = hpage_nr_pages(page);
> +
> +	return page;
> +}
> +
> +static inline void readahead_next(struct readahead_control *rac)
> +{
> +	rac->_nr_pages -= rac->_batch_count;
> +	rac->_start += rac->_batch_count;
> +}
> +
> +#define readahead_for_each(rac, page)					\
> +	for (; (page = readahead_page(rac)); readahead_next(rac))
> +


How about this instead? It uses the "for" loop fully and more naturally,
and is easier to read. And it does the same thing:

static inline struct page *readahead_page(struct readahead_control *rac)
{
	struct page *page;

	if (!rac->_nr_pages)
		return NULL;

	page = xa_load(&rac->mapping->i_pages, rac->_start);
	VM_BUG_ON_PAGE(!PageLocked(page), page);
	rac->_batch_count = hpage_nr_pages(page);

	return page;
}

static inline struct page *readahead_next(struct readahead_control *rac)
{
	rac->_nr_pages -= rac->_batch_count;
	rac->_start += rac->_batch_count;

	return readahead_page(rac);
}

#define readahead_for_each(rac, page)			\
	for (page = readahead_page(rac); page != NULL;	\
	     page = readahead_page(rac))




>  /* The number of pages in this readahead block */
>  static inline unsigned int readahead_count(struct readahead_control *rac)
>  {
> diff --git a/mm/readahead.c b/mm/readahead.c
> index bdc5759000d3..9e430daae42f 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -113,12 +113,11 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
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
>  	blk_start_plug(&plug);
>  
> @@ -127,19 +126,13 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
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
> +	} else {
> +		readahead_for_each(rac, page) {
>  			aops->readpage(rac->file, page);
> -		put_page(page);
> +			put_page(page);
> +		}
>  	}
>  
> -out:
>  	blk_finish_plug(&plug);
>  }
>  
> @@ -159,6 +152,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	unsigned long i;
>  	loff_t isize = i_size_read(inode);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
> +	bool use_list = mapping->a_ops->readpages;


fwiw, "bool have_readpages" seems like a better name (after all, that's how read_pages() 
effectively is written: "if you have .readpages, then..."), but I can see both sides 
of that bikeshed. :)


>  	struct readahead_control rac = {
>  		.mapping = mapping,
>  		.file = filp,
> @@ -196,8 +190,14 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		page = __page_cache_alloc(gfp_mask);
>  		if (!page)
>  			break;
> -		page->index = offset;
> -		list_add(&page->lru, &page_pool);
> +		if (use_list) {
> +			page->index = offset;
> +			list_add(&page->lru, &page_pool);
> +		} else if (add_to_page_cache_lru(page, mapping, offset,
> +					gfp_mask) < 0) {


It would be a little safer from a maintenance point of view, to check for !=0, rather
than checking for < 0.  Most (all?) existing callers check that way, and it's good
to stay with the pack there.


> +			put_page(page);
> +			goto read;
> +		}
>  		if (i == nr_to_read - lookahead_size)
>  			SetPageReadahead(page);
>  		rac._nr_pages++;
> @@ -205,7 +205,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		continue;
>  read:
>  		if (readahead_count(&rac))
> -			read_pages(&rac, &page_pool, gfp_mask);
> +			read_pages(&rac, &page_pool);
>  		rac._nr_pages = 0;
>  		rac._start = ++offset;
>  	}
> @@ -216,7 +216,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	 * will then handle the error.
>  	 */
>  	if (readahead_count(&rac))
> -		read_pages(&rac, &page_pool, gfp_mask);
> +		read_pages(&rac, &page_pool);
>  	BUG_ON(!list_empty(&page_pool));
>  }
>  
> 


thanks,
-- 
John Hubbard
NVIDIA
