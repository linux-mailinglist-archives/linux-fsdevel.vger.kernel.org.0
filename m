Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47C82FE4E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 09:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbhAUIZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 03:25:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11121 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbhAUIZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:25:02 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DLwPJ6Hcvz15sPm;
        Thu, 21 Jan 2021 16:22:44 +0800 (CST)
Received: from [10.174.177.2] (10.174.177.2) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Jan 2021
 16:23:47 +0800
Subject: Re: [PATCH v4 01/18] mm/filemap: Rename generic_file_buffered_read
 subfunctions
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <hch@lst.de>, <kent.overstreet@gmail.com>
References: <20210121041616.3955703-1-willy@infradead.org>
 <20210121041616.3955703-2-willy@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <293e33c4-c112-8fa9-0935-34cd826428f7@huawei.com>
Date:   Thu, 21 Jan 2021 16:23:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210121041616.3955703-2-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.2]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi:
On 2021/1/21 12:15, Matthew Wilcox (Oracle) wrote:
> The recent split of generic_file_buffered_read() created some very
> long function names which are hard to distinguish from each other.
> Rename as follows:
> 
> generic_file_buffered_read_readpage -> filemap_read_page
> generic_file_buffered_read_pagenotuptodate -> filemap_update_page
> generic_file_buffered_read_no_cached_page -> filemap_create_page
> generic_file_buffered_read_get_pages -> filemap_get_pages
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  mm/filemap.c | 44 +++++++++++++++-----------------------------
>  1 file changed, 15 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d90614f501daa..934e04f1760ef 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2168,11 +2168,8 @@ static int lock_page_for_iocb(struct kiocb *iocb, struct page *page)
>  		return lock_page_killable(page);
>  }
>  
> -static struct page *
> -generic_file_buffered_read_readpage(struct kiocb *iocb,
> -				    struct file *filp,
> -				    struct address_space *mapping,
> -				    struct page *page)
> +static struct page *filemap_read_page(struct kiocb *iocb, struct file *filp,
> +		struct address_space *mapping, struct page *page)
>  {
>  	struct file_ra_state *ra = &filp->f_ra;
>  	int error;
> @@ -2223,12 +2220,9 @@ generic_file_buffered_read_readpage(struct kiocb *iocb,
>  	return page;
>  }
>  
> -static struct page *
> -generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
> -					   struct file *filp,
> -					   struct iov_iter *iter,
> -					   struct page *page,
> -					   loff_t pos, loff_t count)
> +static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
> +		struct iov_iter *iter, struct page *page, loff_t pos,
> +		loff_t count)
>  {
>  	struct address_space *mapping = filp->f_mapping;
>  	struct inode *inode = mapping->host;
> @@ -2291,12 +2285,11 @@ generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
>  		return page;
>  	}
>  
> -	return generic_file_buffered_read_readpage(iocb, filp, mapping, page);
> +	return filemap_read_page(iocb, filp, mapping, page);
>  }
>  
> -static struct page *
> -generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
> -					  struct iov_iter *iter)
> +static struct page *filemap_create_page(struct kiocb *iocb,
> +		struct iov_iter *iter)
>  {
>  	struct file *filp = iocb->ki_filp;
>  	struct address_space *mapping = filp->f_mapping;
> @@ -2307,10 +2300,6 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
>  	if (iocb->ki_flags & IOCB_NOIO)
>  		return ERR_PTR(-EAGAIN);
>  
> -	/*
> -	 * Ok, it wasn't cached, so we need to create a new
> -	 * page..
> -	 */
>  	page = page_cache_alloc(mapping);
>  	if (!page)
>  		return ERR_PTR(-ENOMEM);
> @@ -2322,13 +2311,11 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
>  		return error != -EEXIST ? ERR_PTR(error) : NULL;
>  	}
>  
> -	return generic_file_buffered_read_readpage(iocb, filp, mapping, page);
> +	return filemap_read_page(iocb, filp, mapping, page);
>  }
>  
> -static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
> -						struct iov_iter *iter,
> -						struct page **pages,
> -						unsigned int nr)
> +static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
> +		struct page **pages, unsigned int nr)
>  {
>  	struct file *filp = iocb->ki_filp;
>  	struct address_space *mapping = filp->f_mapping;
> @@ -2355,7 +2342,7 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
>  	if (nr_got)
>  		goto got_pages;
>  
> -	pages[0] = generic_file_buffered_read_no_cached_page(iocb, iter);
> +	pages[0] = filemap_create_page(iocb, iter);
>  	err = PTR_ERR_OR_ZERO(pages[0]);
>  	if (!IS_ERR_OR_NULL(pages[0]))
>  		nr_got = 1;
> @@ -2389,8 +2376,8 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
>  				break;
>  			}
>  
> -			page = generic_file_buffered_read_pagenotuptodate(iocb,
> -					filp, iter, page, pg_pos, pg_count);
> +			page = filemap_update_page(iocb, filp, iter, page,
> +					pg_pos, pg_count);
>  			if (IS_ERR_OR_NULL(page)) {
>  				for (j = i + 1; j < nr_got; j++)
>  					put_page(pages[j]);
> @@ -2466,8 +2453,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  			iocb->ki_flags |= IOCB_NOWAIT;
>  
>  		i = 0;
> -		pg_nr = generic_file_buffered_read_get_pages(iocb, iter,
> -							     pages, nr_pages);
> +		pg_nr = filemap_get_pages(iocb, iter, pages, nr_pages);
>  		if (pg_nr < 0) {
>  			error = pg_nr;
>  			break;
> 

Looks good to me. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

