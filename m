Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC9515A2F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 09:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgBLILu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 03:11:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgBLILu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CFFumfzArLwyhPSt9zEmKyULA8GHCnRz4sG9emhEO3w=; b=YovItmSpQwaHYsOGEhsmnjhy2v
        tKidHjLiClOhzBczlh80j4+QUmlTbg2xU8NXXuj2nGbdr00TYZh4KbHhx8umfF1XBxOjv4nyh4qCO
        u8IF8bU/BWuTNuyotXaEhVlsNJboyRjyfKSorb2pXlVV3DUs1PkozB1rcYeMMv+YO6cokIdT62jEj
        mA47Vg6CSQhv2LOPMiRZBHA9e5rx2kE81aghjYvVcMf0FWyrh0N6Y2I/4wqXZT8D/sBUlpO59NoEq
        59XadIPx3mVgDfdvH1ejtQFcKyAw7NT94ttXERNOjBUY9w1u6E9/LqR+1IKL7B1T4/roPLlq/2uCX
        z5t0OxOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1n7d-00050d-DU; Wed, 12 Feb 2020 08:11:49 +0000
Date:   Wed, 12 Feb 2020 00:11:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/25] iomap: Support large pages in
 iomap_adjust_read_range
Message-ID: <20200212081149.GC24497@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-16-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  		struct page *page, struct iomap *srcmap)
>  {
> -	struct iomap_page *iop = iomap_page_create(inode, page);
>  	loff_t block_size = i_blocksize(inode);
>  	loff_t block_start = pos & ~(block_size - 1);
>  	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
> @@ -556,9 +557,10 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  
>  	if (PageUptodate(page))
>  		return 0;
> +	iomap_page_create(inode, page);

FYI, I have a similar change in a pending series that only creates
the iomap_page if a page isn't actually mapped by a contiguous extent.
Lets see which series goes in first, but the conflicts shouldn't be too
bad.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 52269e56c514..b4bf86590096 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1387,6 +1387,8 @@ static inline void clear_page_pfmemalloc(struct page *page)
>  extern void pagefault_out_of_memory(void);
>  
>  #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
> +#define offset_in_this_page(page, p)	\
> +	((unsigned long)(p) & (thp_size(page) - 1))

I think this should go int oa separate patch.
