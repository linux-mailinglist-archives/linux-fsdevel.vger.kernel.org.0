Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654E17D43F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 06:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfHAD74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 23:59:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfHAD7z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I8/9yqTIylyYT3ifD0KNSCMCuP/VEpy95OXwAJhhUzE=; b=fiHGVvDtNjwrMZ1w5x3i7cGa2
        rfi3qs+wzc+FhoeW6GraEzaAvZiCGq5fhWGer81vIGrUlBL/gLv928TfNDZA8hecNG2z3vzoIpAYy
        A4A7+f6nQ57kFGnjjWdc6hwg9GSLhGIq7C5SlT/iMMZmk1lOxmjWTAC5AlVd+oVB2XbGeRAhJ/Xoz
        jfhDH1ttVWoFSto6gcH9BSoGWrr1w4v8qjDHgJMEYIHWgBNCysTOFU7Y+FV5UHBYjQ4WqjtQpA5TK
        coKmH8NbBZxPevwyL0FKEEVV5XLEe/0r0Z5a72RyrmEAfR4FltCnFWI6pzQpmHQwpreFHfLwCaQ8T
        nCQ3avbNg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1ht2Fv-00057I-3K; Thu, 01 Aug 2019 03:59:55 +0000
Date:   Wed, 31 Jul 2019 20:59:55 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] iomap: Support large pages
Message-ID: <20190801035955.GI4700@bombadil.infradead.org>
References: <20190731171734.21601-1-willy@infradead.org>
 <20190731171734.21601-2-willy@infradead.org>
 <20190731230315.GJ7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731230315.GJ7777@dread.disaster.area>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 09:03:15AM +1000, Dave Chinner wrote:
> > -	if (iop || i_blocksize(inode) == PAGE_SIZE)
> > +	if (iop || i_blocksize(inode) == page_size(page))
> >  		return iop;
> >  
> > -	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
> > +	nbits = BITS_TO_LONGS(page_size(page) / SECTOR_SIZE);
> 
> nbits = BITS_TO_LONGS(page_size(page) / i_blocksize(inode));

Ah, yes, that's better.  When it's statically allocated, you have to assume
512-byte blocks, but when it's dynamically allocated, you can use the
actual inode blocksize.

> > +	iop = kmalloc(struct_size(iop, uptodate, nbits),
> > +			GFP_NOFS | __GFP_NOFAIL);
> >  	atomic_set(&iop->read_count, 0);
> >  	atomic_set(&iop->write_count, 0);
> > -	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
> > +	bitmap_zero(iop->uptodate, nbits);

Also, I confused myself by using nbits.  And, really, why do all this
initialisation by hand?

@@ -23,17 +23,14 @@ static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
        struct iomap_page *iop = to_iomap_page(page);
-       unsigned int nbits;
+       unsigned int n;
 
        if (iop || i_blocksize(inode) == page_size(page))
                return iop;
 
-       nbits = BITS_TO_LONGS(page_size(page) / SECTOR_SIZE);
-       iop = kmalloc(struct_size(iop, uptodate, nbits),
-                       GFP_NOFS | __GFP_NOFAIL);
-       atomic_set(&iop->read_count, 0);
-       atomic_set(&iop->write_count, 0);
-       bitmap_zero(iop->uptodate, nbits);
+       n = BITS_TO_LONGS(page_size(page) >> inode->i_blkbits);
+       iop = kmalloc(struct_size(iop, uptodate, n),
+                       GFP_NOFS | __GFP_NOFAIL | __GFP_ZERO);
 
        /*
         * migrate_page_move_mapping() assumes that pages with private data have

> > -	unsigned poff = offset_in_page(*pos);
> > -	unsigned plen = min_t(loff_t, PAGE_SIZE - poff, length);
> > +	unsigned poff = *pos & (page_size(page) - 1);
> > +	unsigned plen = min_t(loff_t, page_size(page) - poff, length);
> >  	unsigned first = poff >> block_bits;
> >  	unsigned last = (poff + plen - 1) >> block_bits;
> 
> This all kinda looks familar. In my block size > page size patch
> set, I was trying to wrap these sorts of things in helpers as they
> ge repeated over and over again. e.g:
> 
> /*
>  * Return the block size we should use for page cache based operations.
>  * This will return the inode block size for block size < PAGE_SIZE,
>  * otherwise it will return PAGE_SIZE.
>  */
> static inline unsigned
> iomap_chunk_size(struct inode *inode)
> {
> 	return min_t(unsigned, PAGE_SIZE, i_blocksize(inode));
> }
> 
> "chunk" being the name that Christoph suggested as the size of the
> region we need to operate over in this function.
> 
> IOws, if we have a normal page, it's as per the above, but if
> we have block size > PAGE_SIZE, it's the block size we need to work
> from, and if it's a huge page, is the huge page size we need to
> use....
> 
> So starting by wrapping a bunch of these common length/size/offset
> calculations will make this code much easier to understand, follow,
> maintain as we explode the number of combinations of page and block
> size it supports in the near future...
> 
> FYI, the blocksize > pagesize patchset was first posted here:
> 
> https://lore.kernel.org/linux-fsdevel/20181107063127.3902-1-david@fromorbit.com/
> 
> [ Bad memories, this patchset is what lead us to discover how 
> horribly broken copy_file_range and friends were. ]

Thanks.  I'll take a look at that and come back with a refreshed patch
tomorrow that wraps a bunch of these things.

> > -		unsigned end = offset_in_page(isize - 1) >> block_bits;
> > +		unsigned end = (isize - 1) & (page_size(page) - 1) >>
> > +				block_bits;
> 
> iomap_offset_in_page()....

It has applications outside iomap, so I've been thinking about
offset_in_this_page(page, thing).  I don't like it, but page_offset()
is taken and offset_in_page() doesn't take a page parameter.

> > @@ -194,11 +199,12 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
> >  		return;
> >  
> >  	BUG_ON(page->index);
> > -	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +	BUG_ON(size > page_size(page) - ((unsigned long)iomap->inline_data &
> > +						(page_size(page) - 1)));
> 
> Inline data should never use a huge page - it's a total waste of
> 2MB of memory because inline data is intended for very small data
> files that fit inside an inode. If anyone ever needs inline data
> larger than PAGE_SIZE then we can worry about how to support that
> at that time. Right now it should just refuse to use a huge page...

I kind of agree, but ...

This isn't just about supporting huge pages.  It's about supporting
large pages too (and by large pages, I mean arbitrary-order pages,
rather than ones which match a particular CPU's PMD/PGD hierarchy).
We might well decide that we want to switch to always at least trying
to allocate 16kB pages in the page cache, and so we might end up here
with a page larger than the base page size.

And yes, we could say it's the responsibility of that person to do this
work, but it's done now.

> > -		int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +		int nr_vecs = (length + page_size(page) - 1) >> page_shift(page);
> 
> iomap_nr_pages(page)?

Do you mean iomap_nr_pages(page, length)?

Actually, I'm not sure this is right.  It assumes the pages all have the same
length, so if we do a call to readpages() which has a 2MB page followed by
a raft of 4kB pages, it'll allocate a BIO with 2 vectors, when it should
really allocate many more.  I think I'll change this one back to operating
on PAGE_SIZE and if we fill in fewer vecs than we allocated, that's fine.

> > @@ -355,9 +361,14 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> >  {
> >  	struct iomap_readpage_ctx *ctx = data;
> >  	loff_t done, ret;
> > +	size_t pg_left = 0;
> > +
> > +	if (ctx->cur_page)
> > +		pg_left = page_size(ctx->cur_page) -
> > +					(pos & (page_size(ctx->cur_page) - 1));
> 
> What's this unreadable magic do?

Calculates the number of bytes left in this page.

> > @@ -1047,11 +1069,11 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
> >  		goto out_unlock;
> >  	}
> >  
> > -	/* page is wholly or partially inside EOF */
> > -	if (((page->index + 1) << PAGE_SHIFT) > size)
> > -		length = offset_in_page(size);
> > +	/* page is wholly or partially beyond EOF */
> > +	if (((page->index + compound_nr(page)) << PAGE_SHIFT) > size)
> > +		length = size & (page_size(page) - 1);
> >  	else
> > -		length = PAGE_SIZE;
> > +		length = page_size(page);
> 
> Yeah, that needs some help :)
> 
> Basically, I'd love to have all the things that end up being
> variable because of block size or page size or a combination of both
> moved into helpers. That way we end up the the code that does the
> work being clean and easy to maintain, and all the nastiness
> inherent to variable size objects is isolated to the helper
> functions...

I'm on board with the overall plan; just the details to quibble over.
