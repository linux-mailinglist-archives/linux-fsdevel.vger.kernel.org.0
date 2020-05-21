Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5301DD9D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 00:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgEUWBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 18:01:48 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:52852 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729308AbgEUWBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 18:01:48 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2A8CF82075E;
        Fri, 22 May 2020 08:01:45 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jbtFz-0000Vf-A3; Fri, 22 May 2020 08:01:39 +1000
Date:   Fri, 22 May 2020 08:01:39 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/36] fs: Make page_mkwrite_check_truncate thp-aware
Message-ID: <20200521220139.GS2005@dread.disaster.area>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515131656.12890-11-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=sTwFKg_x9MkA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=KGgwbdxBNGb1bfa4TRwA:9 a=axUvvhqyyT9HjbU9:21 a=46PWhYHqkOUzt59A:21
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 06:16:30AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> If the page is compound, check the last index in the page and return
> the appropriate size.  Change the return type to ssize_t in case we ever
> support pages larger than 2GB.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 1a0bb387948c..c75d7fb7ccbc 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -827,22 +827,22 @@ static inline unsigned long dir_pages(struct inode *inode)
>   * @page: the page to check
>   * @inode: the inode to check the page against
>   *
> - * Returns the number of bytes in the page up to EOF,
> + * Return: The number of bytes in the page up to EOF,
>   * or -EFAULT if the page was truncated.
>   */
> -static inline int page_mkwrite_check_truncate(struct page *page,
> +static inline ssize_t page_mkwrite_check_truncate(struct page *page,
>  					      struct inode *inode)
>  {
>  	loff_t size = i_size_read(inode);
>  	pgoff_t index = size >> PAGE_SHIFT;
> -	int offset = offset_in_page(size);
> +	unsigned long offset = offset_in_thp(page, size);
>  
>  	if (page->mapping != inode->i_mapping)
>  		return -EFAULT;
>  
>  	/* page is wholly inside EOF */
> -	if (page->index < index)
> -		return PAGE_SIZE;
> +	if (page->index + hpage_nr_pages(page) - 1 < index)
> +		return thp_size(page);

Can we make these interfaces all use the same namespace prefix?
Here we have a mix of thp and hpage and I have no clue how hpages
are different to thps. If they refer to the same thing (i.e. huge
pages) then can we please make the API consistent before splattering
it all over the filesystem code?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
