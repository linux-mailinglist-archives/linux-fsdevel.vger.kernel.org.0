Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1701D3E1A8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 19:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbhHERjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 13:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233039AbhHERjR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:39:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72FBD60F42;
        Thu,  5 Aug 2021 17:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628185143;
        bh=mpOGezB+SXuAsFVVC6lA3bwptRrmzQF001+TM4vmdWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4QaeFt7YNA89dhbokWqs7ATP7Bj82GlnLNx+wA6LzxkM82xHT+Gaz8dFXwAGiNc2
         hFoeWzLsIX7QCVOuY2bfl+FzVv0Nw7pZhBmebhbRxAW4cbCw5kD1wPflm2BVQ3RIv7
         gLz5yq/Nq3mZlZZn0xTDrvTrIvMFQ2YMzZbXq8qchCnNpR4B2xI0ZSdJwhP63P9a9b
         1+K2C2qALwsm1SUwWvD2OBwEgeE6iTeKAV5hu6zqpTafqN0a3w+eEb5EKxuOcSp09B
         RUkjjWo0avlBGuKVhJ3jwP6gFRmPQ8LsP6e33F4dDJUU3rMZgQUET9pioKaChkYjIC
         mO5wNW5NB0Q7w==
Date:   Thu, 5 Aug 2021 10:39:03 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: Use kmap_local_page instead of kmap_atomic
Message-ID: <20210805173903.GH3601405@magnolia>
References: <20210803193134.1198733-1-willy@infradead.org>
 <20210805173104.GF3601405@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805173104.GF3601405@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05, 2021 at 10:31:04AM -0700, Darrick J. Wong wrote:
> On Tue, Aug 03, 2021 at 08:31:33PM +0100, Matthew Wilcox (Oracle) wrote:
> > kmap_atomic() has the side-effect of disabling pagefaults and
> > preemption.  kmap_local_page() does not do this and is preferred.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Pretty straightforward.
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> > ---
> >  fs/iomap/buffered-io.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index c1c8cd41ea81..8ee0211bea86 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -223,10 +223,10 @@ static int iomap_read_inline_data(struct inode *inode, struct page *page,
> >  	if (poff > 0)
> >  		iomap_page_create(inode, page);
> >  
> > -	addr = kmap_atomic(page) + poff;
> > +	addr = kmap_local_page(page) + poff;

Though now that I think about it: Why does iomap_write_actor still use
copy_page_from_iter_atomic?  Can that be converted to use regular
copy_page_from_iter, which at least sometimes uses kmap_local_page?

--D

> >  	memcpy(addr, iomap->inline_data, size);
> >  	memset(addr + size, 0, PAGE_SIZE - poff - size);
> > -	kunmap_atomic(addr);
> > +	kunmap_local(addr);
> >  	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
> >  	return PAGE_SIZE - poff;
> >  }
> > @@ -682,9 +682,9 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> >  	BUG_ON(!iomap_inline_data_valid(iomap));
> >  
> >  	flush_dcache_page(page);
> > -	addr = kmap_atomic(page);
> > -	memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
> > -	kunmap_atomic(addr);
> > +	addr = kmap_local_page(page) + pos;
> > +	memcpy(iomap_inline_data(iomap, pos), addr, copied);
> > +	kunmap_local(addr);
> >  
> >  	mark_inode_dirty(inode);
> >  	return copied;
> > -- 
> > 2.30.2
> > 
