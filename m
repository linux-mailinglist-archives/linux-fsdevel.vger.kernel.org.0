Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F322B1B3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 13:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKMMim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 07:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMMil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:38:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC66C0613D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 04:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RYLmEpvBz+t57yvqN9GmWpxhfukhqfsT/7cprwXn3vM=; b=hvlA99gUbacmKAw5wr3w/hPyYa
        gXC2WwVnunDrt+cySAhx/QTYSIGZoMEXgfxxgDQB3gHCqG7hy3Z9Nkn8ucJEBJ7VOm8rrW+nEdFY6
        /b4piYt2+3uvK1/tWp0BjUenTa5Kh9v1MJZ9G+wsP+tUr3PrF/BQ4BA7D82zL29ujAn4XaJ8bH1sL
        LnwLHb7YejNUJ3W8TmcBETBzx1tkPbSj183yrd+7UoDAaZYHBHir+ubCYfrVIXHxDr5G9zv4V3tuO
        FgG2kQvOPuItySyH/4OP70Q4XMqUhBHIsw7lyQrjQzwX+D8lA+e0Leru9OQltb9SY8ciZW+0p9sFQ
        lGiUTz/w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdYLc-0005bn-B7; Fri, 13 Nov 2020 12:38:36 +0000
Date:   Fri, 13 Nov 2020 12:38:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: Are THPs the right model for the pagecache?
Message-ID: <20201113123836.GE17076@casper.infradead.org>
References: <20201113044652.GD17076@casper.infradead.org>
 <1c1fa264-41d8-49a4-e5ff-2a5bf03e711e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1fa264-41d8-49a4-e5ff-2a5bf03e711e@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 10:39:10PM -0800, John Hubbard wrote:
> > IOWs, something like this:
> > 
> > struct lpage {
> > 	struct page subpages[4];
> > };
> > 
> > static inline struct lpage *page_lpage(struct page *page)
> > {
> > 	unsigned long head = READ_ONCE(page->compound_head);
> > 
> > 	if (unlikely(head & 1))
> > 		return (struct lpage *)(head - 1);
> > 	return (struct lpage *)page;
> > }
> 
> This is really a "get_head_page()" function, not a "get_large_page()"
> function. But even renaming it doesn't seem quite right, because
> wouldn't it be better to avoid discarding that tail bit information? In
> other words, you might be looking at 3 cases, one of which is *not*
> involving large pages at all:
> 
>     The page is a single, non-compound page.
>     The page is a head page of a compound page
>     The page is a tail page of a compound page
> 
> ...but this function returns a type of "large page", even for the first
> case. That's misleading, isn't it?

Argh.  Yes, that's part of the problem, so this is still confusing.
An lpage might actually be an order-0 page.  Maybe it needs to be called
something that's not 'page' at all.  There are really four cases:

 - An order-0 page
 - A subpage that happens to be a tail page
 - A subpage that happens to be a head page
 - An order-N page

We have code today that treats tail pages as order-0 pages, but if
the subpage you happen to pass in is a head page, it'll work on the
entire page.  That must, surely, be a bug.

So what if we had:

/* Cache memory */
struct cmem {
	struct page pages[1];
};

Now there's a clear hierarchy.  The page cache stores pointers to cmem.

struct page *cmem_page(struct cmem *cmem, pgoff_t index)
{
	return cmem->pages[index - cmem->pages[0].index];
}

struct cmem *page_cmem(struct page *page)
{
	unsigned long head = READ_ONCE(page->compound_head);

	if (unlikely(head & 1))
		return (struct cmem *)(head - 1);
	return (struct cmem *)page;
}

and we'll need the usualy panoply of functions to get the order/size/...
of a cmem.  We'll also need functions like CMemDirty(), CMemLocked(),
CMemWriteback(), etc.

