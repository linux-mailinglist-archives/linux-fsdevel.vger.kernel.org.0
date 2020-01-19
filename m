Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46233141C95
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 07:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgASGOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 01:14:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgASGOK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 01:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qKmKMGK/YXS63xsMLO/1KuO0xP34f24PMa9GNUZcPo4=; b=eUzdE3xzal115Gd+86KdMYcBE
        s8zknNErq6vvGDwjV8MgPr0LcX8gHAH3b0T9iY2oFUdk2TX98CneAXDiQQ96+XL8GT5394b7MN3Y/
        XpZV5Pq6lMURWyQq/O5XWslGAveBqLWuhdLT8kQvFqXw469hHmeocVwpW5E+StQcmMt0ASorySEZ8
        GHs8+VInH+5jxh2MKRjPJEetimAJNf9zMvow9ID6scYwuL3uqCZ3j9thnOs9VLFuFx2W6eE4fd9DG
        Rk+a1F0Ug/BrCrX2rbphet/jCvHBLMtgMYl7brM82Q+n3VDlO6m1L+hyPGo9Dc4Njkt8sqw250lW2
        hLT8XnTdQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it3qU-0004TF-QP; Sun, 19 Jan 2020 06:14:02 +0000
Date:   Sat, 18 Jan 2020 22:14:02 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, houtao1@huawei.com,
        zhengbin13@huawei.com, yi.zhang@huawei.com
Subject: Re: [RFC] iomap: fix race between readahead and direct write
Message-ID: <20200119061402.GA7301@bombadil.infradead.org>
References: <20200116063601.39201-1-yukuai3@huawei.com>
 <20200118230826.GA5583@bombadil.infradead.org>
 <f5328338-1a2d-38b4-283f-3fb97ad37133@huawei.com>
 <20200119014213.GA16943@bombadil.infradead.org>
 <64d617cc-e7fe-6848-03bb-aab3498c9a07@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64d617cc-e7fe-6848-03bb-aab3498c9a07@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 19, 2020 at 10:51:37AM +0800, yukuai (C) wrote:
> At first, if you try to add all pages to pagecache and lock them before
> iomap_begin. I thought aboult it before, but I throw away the idea
> becacuse all other operation that will lock the page will need to wait
> for readahead to finish. And it might cause problem for performance
> overhead. And if you try to add each page to page cache and call iomap
> before adding the next page. Then, we are facing the same CPU overhead
> issure.

I don't understand your reasoning here.  If another process wants to
access a page of the file which isn't currently in cache, it would have
to first read the page in from storage.  If it's under readahead, it
has to wait for the read to finish.  Why is the second case worse than
the second?  It seems better to me.

The implementation doesn't call iomap for each page.  It allocates all
the pages and then calls iomap for the range.

> Then, there might be a problem in your implementation.
> if 'use_list' is set to true here:
> +	bool use_list = mapping->a_ops->readpages;
> 
> Your code do not call add_to_page_cache_lru for the page.

It can't.  The readpages implementation has to call add_to_page_cache_lru.
But for filesystems which use readpage or readahead, we can put the pages
in the page cache before calling readahead.

> And later, you replace 'iomap_next_page' with 'readahead_page'
> +static inline
> +struct page *readahead_page(struct address_space *mapping, loff_t pos)
> +{
> +	struct page *page = xa_load(&mapping->i_pages, pos / PAGE_SIZE);
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +
> +	return page;
> +}
> +
> 
> It seems that the page will never add to page cache.

At the same time, the iomap code is switched from ->readpages to
->readahead, so yes, the pages are added to the page cache.
