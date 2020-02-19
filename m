Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02031163A5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 03:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgBSClN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 21:41:13 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2966 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726799AbgBSClN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:41:13 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 245B626217D9D6DA7E4E;
        Wed, 19 Feb 2020 10:41:08 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 19 Feb 2020 10:41:07 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 19 Feb 2020 10:41:07 +0800
Date:   Wed, 19 Feb 2020 10:39:48 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v6 12/19] erofs: Convert uncompressed files from
 readpages to readahead
Message-ID: <20200219023948.GB83440@architecture4>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-21-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-21-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme720-chm.china.huawei.com (10.1.199.116) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:46:01AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new readahead operation in erofs
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

It looks good to me, and will test it later as well..

Acked-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

>  fs/erofs/data.c              | 39 +++++++++++++-----------------------
>  fs/erofs/zdata.c             |  2 +-
>  include/trace/events/erofs.h |  6 +++---
>  3 files changed, 18 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index fc3a8d8064f8..82ebcee9d178 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -280,47 +280,36 @@ static int erofs_raw_access_readpage(struct file *file, struct page *page)
>  	return 0;
>  }
>  
> -static int erofs_raw_access_readpages(struct file *filp,
> -				      struct address_space *mapping,
> -				      struct list_head *pages,
> -				      unsigned int nr_pages)
> +static void erofs_raw_access_readahead(struct readahead_control *rac)
>  {
>  	erofs_off_t last_block;
>  	struct bio *bio = NULL;
> -	gfp_t gfp = readahead_gfp_mask(mapping);
> -	struct page *page = list_last_entry(pages, struct page, lru);
> -
> -	trace_erofs_readpages(mapping->host, page, nr_pages, true);
> +	struct page *page;
>  
> -	for (; nr_pages; --nr_pages) {
> -		page = list_entry(pages->prev, struct page, lru);
> +	trace_erofs_readpages(rac->mapping->host, readahead_index(rac),
> +			readahead_count(rac), true);
>  
> +	readahead_for_each(rac, page) {
>  		prefetchw(&page->flags);
> -		list_del(&page->lru);
>  
> -		if (!add_to_page_cache_lru(page, mapping, page->index, gfp)) {
> -			bio = erofs_read_raw_page(bio, mapping, page,
> -						  &last_block, nr_pages, true);
> +		bio = erofs_read_raw_page(bio, rac->mapping, page, &last_block,
> +				readahead_count(rac), true);
>  
> -			/* all the page errors are ignored when readahead */
> -			if (IS_ERR(bio)) {
> -				pr_err("%s, readahead error at page %lu of nid %llu\n",
> -				       __func__, page->index,
> -				       EROFS_I(mapping->host)->nid);
> +		/* all the page errors are ignored when readahead */
> +		if (IS_ERR(bio)) {
> +			pr_err("%s, readahead error at page %lu of nid %llu\n",
> +			       __func__, page->index,
> +			       EROFS_I(rac->mapping->host)->nid);
>  
> -				bio = NULL;
> -			}
> +			bio = NULL;
>  		}
>  
> -		/* pages could still be locked */
>  		put_page(page);
>  	}
> -	DBG_BUGON(!list_empty(pages));
>  
>  	/* the rare case (end in gaps) */
>  	if (bio)
>  		submit_bio(bio);
> -	return 0;
>  }
>  
>  static int erofs_get_block(struct inode *inode, sector_t iblock,
> @@ -358,7 +347,7 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>  /* for uncompressed (aligned) files and raw access for other files */
>  const struct address_space_operations erofs_raw_access_aops = {
>  	.readpage = erofs_raw_access_readpage,
> -	.readpages = erofs_raw_access_readpages,
> +	.readahead = erofs_raw_access_readahead,
>  	.bmap = erofs_bmap,
>  };
>  
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 80e47f07d946..17f45fcb8c5c 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1315,7 +1315,7 @@ static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
>  	struct page *head = NULL;
>  	LIST_HEAD(pagepool);
>  
> -	trace_erofs_readpages(mapping->host, lru_to_page(pages),
> +	trace_erofs_readpages(mapping->host, lru_to_page(pages)->index,
>  			      nr_pages, false);
>  
>  	f.headoffset = (erofs_off_t)lru_to_page(pages)->index << PAGE_SHIFT;
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index 27f5caa6299a..bf9806fd1306 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -113,10 +113,10 @@ TRACE_EVENT(erofs_readpage,
>  
>  TRACE_EVENT(erofs_readpages,
>  
> -	TP_PROTO(struct inode *inode, struct page *page, unsigned int nrpage,
> +	TP_PROTO(struct inode *inode, pgoff_t start, unsigned int nrpage,
>  		bool raw),
>  
> -	TP_ARGS(inode, page, nrpage, raw),
> +	TP_ARGS(inode, start, nrpage, raw),
>  
>  	TP_STRUCT__entry(
>  		__field(dev_t,		dev	)
> @@ -129,7 +129,7 @@ TRACE_EVENT(erofs_readpages,
>  	TP_fast_assign(
>  		__entry->dev	= inode->i_sb->s_dev;
>  		__entry->nid	= EROFS_I(inode)->nid;
> -		__entry->start	= page->index;
> +		__entry->start	= start;
>  		__entry->nrpage	= nrpage;
>  		__entry->raw	= raw;
>  	),
> -- 
> 2.25.0
> 
> 
