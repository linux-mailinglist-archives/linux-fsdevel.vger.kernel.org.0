Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD283D1AA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 02:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhGUXig (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 19:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhGUXig (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 19:38:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3F6060D07;
        Thu, 22 Jul 2021 00:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626913151;
        bh=02WBJv43Ul3/E4zefrr5BSI7WykAgFvJVxBqMsob8jw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=BeQmcfxx5mLOyMZ/2WBBPYKtwdyuU0jmC846ANp/fc77cIG4kZVbHmw1w3hDpnVRW
         m+BKTS0l/HJQIRBgq9lQD6Z+fgMG7cxlbafV8srq5BhXgkPmz9y93aTkb3YkJhROrh
         ykRB1KjCY9F4mU8MPl2qG1eRlZ8y9bJpYwEkUdTgAB6zPgz/Kr4WMJiOKbAkzHKmwO
         gvYr0cows/yJeHw55ggnbU5IqtrQitAQurnrl084qAGbiZn026K8hInC/Yy7M2zATq
         534fj6pTzMCLfvC3xpM1XjNH9SXL6SVxeoFVWMWDeBVSOV/1qNb79fvMSkQ3p16u/7
         mVge+jWK0QTmg==
Date:   Wed, 21 Jul 2021 17:19:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v5] iomap: support tail packing inline read
Message-ID: <20210722001911.GD8572@magnolia>
References: <20210721082323.41933-1-hsiangkao@linux.alibaba.com>
 <20210721222404.GA8639@magnolia>
 <YPi3/okpVH7Q1O2X@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPi3/okpVH7Q1O2X@B-P7TQMD6M-0146.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 08:12:46AM +0800, Gao Xiang wrote:
> Hi Darrick,
> 
> On Wed, Jul 21, 2021 at 03:24:04PM -0700, Darrick J. Wong wrote:
> > On Wed, Jul 21, 2021 at 04:23:23PM +0800, Gao Xiang wrote:
> > > This tries to add tail packing inline read to iomap, which can support
> > > several inline tail blocks. Similar to the previous approach, it cleans
> > > post-EOF in one iteration.
> > > 
> > > The write path remains untouched since EROFS cannot be used for testing.
> > > It'd be better to be implemented if upcoming real users care rather than
> > > leave untested dead code around.
> > 
> > I had a conversation with Gao on IRC this morning, and I think I've
> > finally gotten up to speed on where he's trying to go with this
> > patchset.  Maybe that will make review of this patch easier, or at least
> > not muddy the waters further.
> 
> Many thanks for your time on this and the detailed long reply.
> 
> > 
> > Right now, inline data in iomap serves exactly two users -- gfs2 and
> > ext4.  ext4 doesn't use iomap for buffered IO and doesn't support
> > directio for inline data files, so we can ignore them for now.  gfs2
> > uses iomap for buffered IO, and it stores the inline data after the
> > gfs2_dinode.
> > 
> > iomap's inline data functions exist to serve the gfs2 use case, which is
> > why the code has baked-in assumptions that iomap->offset is always zero,
> > and the length is never more than a page.
> > 
> 
> Yeah, that is why I need to update the iomap inline code before
> convering all buffer I/O stuffs to iomap.
> 
> > It used to be the case that we'd always attach an iomap_page to a page
> > for blocksize < pagesize files, but as of 5.14-rc2 we're starting to
> > move towards creating and dropping them on demand.  IOWs, reads from
> > inline data files always read the entire file contents into the page so
> > we mark the whole page uptodate and do not attach an iomap_page (unlike
> > regular reads).  Writes don't attach an iomap_page to inline data files.
> > Writeback attaches an iomap_page.
> 
> Yeah.
> 
> > 
> > Did I get that much right?  Onto the erofs part, now that I've also
> > taken the time to figure out what it's doing by reading the ondisk
> > format in Documentation/.  (Thanks for that, erofs developers!)
> > 
> > erofs can perform tail packing to reduce internal block fragmentation.
> > Tails of files are written immediately after the ondisk inode, which is
> > why Gao wants to use IOMAP_INLINE for this.  Note that erofs tailpacking
> > is /not/ same as what reiserfs does, and the inlinedata model is /not/
> > the same as what gfs2 does.
> > 
> > A tail-packed erofs file mapping looks like this:
> > 
> > x = round_down(i_size, blocksize);
> > [0..(x - 1)]:		mapped to a range of external blocks
> > [x..(i_size - 1)]:	inline data immediately after the inode
> >
> 
> Correct.
> 
> > The previous discussions have gone a bit afield -- there's only one
> > inline data region per file, it won't cross a page boundary because
> > erofs requires blocksize == pagesize, and it's always at the end of the
> > file.  I don't know how we got onto the topic of multiple inline data
> > regions or encoded regions in the middle of a file, but that's not on
> > anybody's requirement list today, AFAICT.
> 
> Sorry, I just tried to give an example. And I saw it misled the topic,
> very sorry about that.
> 
> > 
> > I suspect that adapting the inlinedata code to support regions that
> > don't start at offset zero but are otherwise page-aligned can be done
> > with fairly minor changes to the accounting, since I think that largely
> > can be done by removing the asserts about offset==0.
> 
> I think I could try to figure out a page-size aligned only patch like
> this, as long as each one is happy about that.
> 
> > 
> > Did I get that right?
> > 
> > The next thing the erofs developers want to do is add support for
> > blocksize < pagesize, presumably so that they can mount a 4k blocksize
> > erofs volume on a machine with 64k pages.  For that, I think erofs needs
> > to be able to read the tail bytes into the middle of an existing page.
> > Hence the need to update the per-block uptodate bits in the iomap_page
> > from the read function, and all the math changes where we increase the
> > starting address of a copy by (iomap->offset - pos).  The end result
> > should be that we can handle inline data regions anywhere, though we
> > won't really have a way to test that until erofs starts supporting
> > blocksize < pagesize.
> 
> Correct.
> 
> > 
> > Assuming that my assumptions are correct, I think this patch decomposes
> > into three more targeted changes, one of which applies now, and the rest
> > which will go with the later effort.
> > 
> > 1) Update the code to handle inline data mappings where iomap->offset is
> > not zero but the start of the mapping is always page-aligned.
> 
> I could write a patch just for page-aligned cases for now.
> 
> > 
> > 2) Adapt the inline data code to create and update the iop as
> > appropriate.  This could be a little tricky since I've seen elsewhere in
> > the v4 discussion thread that people like the idea of not paying the iop
> > overhead for pages that are backed by a single extent even when bs < ps.
> > I suspect we have enough to decide this from the *iomap/*srcmap length
> > in iomap_readpage_actor or iomap_write_begin, though I've not written
> > any code that tries that.
> > 
> > 3) Update the code to handle inline data mappings where iomap->offset
> > can point to the middle of a page.
> 
> Ok, so I think I will unprioritize 2) and 3) for now. and just address
> the page-aligned approach since it's currently what EROFS needs.
> 
> > 
> > My apologies if everyone else already figured all of this out; for all I
> > know I'm merely scrawling this here as notes to refer back to for future
> > discussions.
> > 
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Darrick J. Wong <djwong@kernel.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > ---
> > > v4: https://lore.kernel.org/r/20210720133554.44058-1-hsiangkao@linux.alibaba.com
> > > changes since v4:
> > >  - turn to WARN_ON_ONCE() suggested by Darrick;
> > >  - fix size to "min(iomap->length + iomap->offset - pos,
> > >                     PAGE_SIZE - poff)"
> > > 
> > >  fs/iomap/buffered-io.c | 58 +++++++++++++++++++++++++++---------------
> > >  fs/iomap/direct-io.c   | 13 +++++++---
> > >  2 files changed, 47 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 87ccb3438bec..d8436d34a159 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -205,25 +205,27 @@ struct iomap_readpage_ctx {
> > >  	struct readahead_control *rac;
> > >  };
> > >  
> > > -static void
> > > +static int
> > >  iomap_read_inline_data(struct inode *inode, struct page *page,
> > > -		struct iomap *iomap)
> > > +		struct iomap *iomap, loff_t pos)
> > >  {
> > > -	size_t size = i_size_read(inode);
> > > +	unsigned int size, poff = offset_in_page(pos);
> > >  	void *addr;
> > >  
> > > -	if (PageUptodate(page))
> > > -		return;
> > > -
> > > -	BUG_ON(page_has_private(page));
> > > -	BUG_ON(page->index);
> > > -	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > > +	/* inline source data must be inside a single page */
> > > +	if (WARN_ON_ONCE(iomap->length > PAGE_SIZE -
> > > +			 offset_in_page(iomap->inline_data)))
> > > +		return -EIO;
> > > +	/* handle tail-packing blocks cross the current page into the next */
> > > +	size = min_t(unsigned int, iomap->length + iomap->offset - pos,
> > > +		     PAGE_SIZE - poff);
> > 
> > Part of my confusion has resulted from this comment -- now that I think
> > I understand the problem domain better, I realize that the clamping code
> > here is not because erofs will hand us a tail-packing iomap that crosses
> > page boundaries; this clamp simply protects us from memory corruption.
> > 
> > 	/*
> > 	 * iomap->inline_data is a kernel-mapped memory page, so we must
> > 	 * terminate the read at the end of that page.
> > 	 */
> > 	if (WARN_ON_ONCE(...))
> > 		return -EIO;
> > 	size = min_t(...);
> 
> That sounds much better. I will update like this.
> 
> > 
> > TBH I wonder if we merely need a rule that ->iomap_begin must not hand
> > back an inline data mapping that crosses a page, since I think the
> > check in the previous line is sufficient.
> > 
> > >  	addr = kmap_atomic(page);
> > > -	memcpy(addr, iomap->inline_data, size);
> > > -	memset(addr + size, 0, PAGE_SIZE - size);
> > > +	memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> > 
> > I keep seeing this (iomap->inline_data + pos - iomap->offset)
> > construction in this patch, maybe it should be a helper?
> 
> I'm fine with this, (but I'm not good at naming), may I ask for
> some suggested naming? e.g.
> 
> static inline void *iomap_adjusted_inline_data(iomap, pos)
> 
> does that look good?

static inline void *
iomap_inline_buf(const struct iomap *iomap, loff_t pos)
{
	return iomap->inline_data + pos - iomap->offset;
}

(gcc complaints about pointer arithmetic on void pointers notwithstanding)

> 
> > 
> > > +	memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
> > >  	kunmap_atomic(addr);
> > > -	SetPageUptodate(page);
> > > +	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
> > > +	return PAGE_SIZE - poff;
> > >  }
> > >  
> > >  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> > > @@ -245,19 +247,23 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > >  	loff_t orig_pos = pos;
> > >  	unsigned poff, plen;
> > >  	sector_t sector;
> > > +	int ret;
> > >  
> > > -	if (iomap->type == IOMAP_INLINE) {
> > > -		WARN_ON_ONCE(pos);
> > > -		iomap_read_inline_data(inode, page, iomap);
> > > -		return PAGE_SIZE;
> > > -	}
> > > -
> > > -	/* zero post-eof blocks as the page may be mapped */
> > >  	iop = iomap_page_create(inode, page);
> > > +	/* needs to skip some leading uptodate blocks */
> > >  	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
> > >  	if (plen == 0)
> > >  		goto done;
> > >  
> > > +	if (iomap->type == IOMAP_INLINE) {
> > > +		ret = iomap_read_inline_data(inode, page, iomap, pos);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +		plen = ret;
> > > +		goto done;
> > > +	}
> > > +
> > > +	/* zero post-eof blocks as the page may be mapped */
> > >  	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
> > >  		zero_user(page, poff, plen);
> > >  		iomap_set_range_uptodate(page, poff, plen);
> > > @@ -589,6 +595,18 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
> > >  	return 0;
> > >  }
> > >  
> > > +static int iomap_write_begin_inline(struct inode *inode, loff_t pos,
> > > +		struct page *page, struct iomap *srcmap)
> > > +{
> > > +	/* needs more work for the tailpacking case, disable for now */
> > > +	if (WARN_ON_ONCE(srcmap->offset != 0))
> > > +		return -EIO;
> > > +	if (PageUptodate(page))
> > > +		return 0;
> > > +	iomap_read_inline_data(inode, page, srcmap, 0);
> > > +	return 0;
> > > +}
> > > +
> > >  static int
> > >  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> > >  		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> > > @@ -618,7 +636,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> > >  	}
> > >  
> > >  	if (srcmap->type == IOMAP_INLINE)
> > > -		iomap_read_inline_data(inode, page, srcmap);
> > > +		status = iomap_write_begin_inline(inode, pos, page, srcmap);
> > >  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
> > >  		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
> > >  	else
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index 9398b8c31323..cbadb99fb88c 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -379,22 +379,27 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
> > >  {
> > >  	struct iov_iter *iter = dio->submit.iter;
> > >  	size_t copied;
> > > +	void *dst = iomap->inline_data + pos - iomap->offset;
> > >  
> > > -	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > > +	/* inline data must be inside a single page */
> > > +	if (WARN_ON_ONCE(length > PAGE_SIZE -
> > > +			 offset_in_page(iomap->inline_data)))
> > > +		return -EIO;
> > 
> > 	/*
> > 	 * iomap->inline_data is a kernel-mapped memory page, so we must
> > 	 * terminate the write at the end of that page.
> > 	 */
> > 	if (WARN_ON_ONCE(...))
> > 		return -EIO;
> 
> Ok.
> 
> > 
> > >  	if (dio->flags & IOMAP_DIO_WRITE) {
> > 
> > I thought we weren't allowing writes to an inline mapping unless
> > iomap->offset == 0?  Why is it necessary to change the directio write
> > path?  Shouldn't this be:
> > 
> > 		/* needs more work for the tailpacking case, disable for now */
> > 		if (WARN_ON_ONCE(pos > 0))
> > 			return -EIO;
> 
> That is because Andreas once pointed out a case in:
> https://lore.kernel.org/r/CAHpGcMJ4T6byxqmO6zZF78wuw01twaEvSW5N6s90qWm0q_jCXQ@mail.gmail.com/
> 
> "This should be a WARN_ON_ONCE(srcmap->offset != 0). Otherwise, something like:
> 
>   xfs_io -ft -c 'pwrite 1 2'
> 
> will fail because pos will be 1."
> 
> I think that is reasonable to gfs2. So I changed like this.

Ah, right.  I forgot that reads are always done for an entire page at a
time, whereas writes are of course byte-aligned.  I still wonder why any
changes are needed for directio write?

--D

> Thanks,
> Gao Xiang
> 
> > 
> > --D
> > 
> > >  		loff_t size = inode->i_size;
> > >  
> > >  		if (pos > size)
> > > -			memset(iomap->inline_data + size, 0, pos - size);
> > > -		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
> > > +			memset(iomap->inline_data + size - iomap->offset,
> > > +			       0, pos - size);
> > > +		copied = copy_from_iter(dst, length, iter);
> > >  		if (copied) {
> > >  			if (pos + copied > size)
> > >  				i_size_write(inode, pos + copied);
> > >  			mark_inode_dirty(inode);
> > >  		}
> > >  	} else {
> > > -		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
> > > +		copied = copy_to_iter(dst, length, iter);
> > >  	}
> > >  	dio->size += copied;
> > >  	return copied;
> > > -- 
> > > 2.24.4
> > > 
