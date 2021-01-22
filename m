Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CD52FFD05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 08:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbhAVHAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 02:00:01 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11848 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbhAVHAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:00:00 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DMVTG3L3Hz7YPN;
        Fri, 22 Jan 2021 14:58:10 +0800 (CST)
Received: from [10.174.177.2] (10.174.177.2) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Fri, 22 Jan 2021
 14:59:15 +0800
Subject: Re: [PATCH v4 02/18] mm/filemap: Remove dynamically allocated array
 from filemap_read
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <hch@lst.de>, <kent.overstreet@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210121041616.3955703-1-willy@infradead.org>
 <20210121041616.3955703-3-willy@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ce489afa-1621-947b-8cd6-b5c45eb5e2cc@huawei.com>
Date:   Fri, 22 Jan 2021 14:59:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210121041616.3955703-3-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.2]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi:
On 2021/1/21 12:16, Matthew Wilcox (Oracle) wrote:
> Increasing the batch size runs into diminishing returns.  It's probably
> better to make, eg, three calls to filemap_get_pages() than it is to
> call into kmalloc().
> 

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/filemap.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 934e04f1760ef..5dec04c8e16b0 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2421,8 +2421,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  	struct file_ra_state *ra = &filp->f_ra;
>  	struct address_space *mapping = filp->f_mapping;
>  	struct inode *inode = mapping->host;
> -	struct page *pages_onstack[PAGEVEC_SIZE], **pages = NULL;
> -	unsigned int nr_pages = min_t(unsigned int, 512,
> +	struct page *pages[PAGEVEC_SIZE];
> +	unsigned int nr_pages = min_t(unsigned int, PAGEVEC_SIZE,
>  			((iocb->ki_pos + iter->count + PAGE_SIZE - 1) >> PAGE_SHIFT) -
>  			(iocb->ki_pos >> PAGE_SHIFT));
>  	int i, pg_nr, error = 0;
> @@ -2433,14 +2433,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		return 0;
>  	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
>  
> -	if (nr_pages > ARRAY_SIZE(pages_onstack))
> -		pages = kmalloc_array(nr_pages, sizeof(void *), GFP_KERNEL);
> -
> -	if (!pages) {
> -		pages = pages_onstack;
> -		nr_pages = min_t(unsigned int, nr_pages, ARRAY_SIZE(pages_onstack));
> -	}
> -
>  	do {
>  		cond_resched();
>  
> @@ -2525,9 +2517,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  
>  	file_accessed(filp);
>  
> -	if (pages != pages_onstack)
> -		kfree(pages);
> -
>  	return written ? written : error;
>  }
>  EXPORT_SYMBOL_GPL(generic_file_buffered_read);
> 

