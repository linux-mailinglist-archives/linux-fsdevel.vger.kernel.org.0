Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A775724873
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 18:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjFFQDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 12:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237565AbjFFQDV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F85D10D7;
        Tue,  6 Jun 2023 09:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBDCD62C41;
        Tue,  6 Jun 2023 16:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F487C433D2;
        Tue,  6 Jun 2023 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686067398;
        bh=cB8jDm9vqYIMj4+pOZ8F9fFyH5836PTmYuLb6/JCtlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NCADavvJ4QD0JeSokjdw29eo/7KLj6+QCkfkle7KmHorLMU7LIdEtxaTXogvoxxoh
         0x8JxNCylLZqi7C3exlLxSxcDQdb+j5w+t0XefvkDGySV4W9Ba1XOpF+6s2WyJTq0i
         zw3ugW6/Z9sByWlwL5dudAvzo2kc5BNHlvx+aMhykth9JMqWOC6OMYwyCqlT0+aGUe
         WCSgFADSbP+As9rtGXB6lrY8gMdPOHIRhKdYYeQj1w5z7EDAjj+740n1WeZpXp+MFg
         m/Lc51ypY4Idof4LzUJ0koV6tAp4iWxFzVM2KbBxfM0L34XJhzofleUt7n+EeDqiXW
         okydQmeTw5uEg==
Date:   Tue, 6 Jun 2023 09:03:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv7 3/6] iomap: Refactor some iop related accessor functions
Message-ID: <20230606160317.GA72224@frogsfrogsfrogs>
References: <20230605225434.GF1325469@frogsfrogsfrogs>
 <87jzwhjwmz.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzwhjwmz.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 05:21:32AM +0530, Ritesh Harjani wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
> > On Mon, Jun 05, 2023 at 04:25:03PM +0530, Ritesh Harjani (IBM) wrote:
> >> We would eventually use iomap_iop_** function naming by the rest of the
> >> buffered-io iomap code. This patch update function arguments and naming
> >> from iomap_set_range_uptodate() -> iomap_iop_set_range_uptodate().
> >> iop_set_range_uptodate() then becomes an accessor function used by
> >> iomap_iop_** functions.
> >>
> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> ---
> >>  fs/iomap/buffered-io.c | 111 +++++++++++++++++++++++------------------
> >>  1 file changed, 63 insertions(+), 48 deletions(-)
> >>
> >> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> >> index 6fffda355c45..136f57ccd0be 100644
> >> --- a/fs/iomap/buffered-io.c
> >> +++ b/fs/iomap/buffered-io.c
> >> @@ -24,14 +24,14 @@
> >>  #define IOEND_BATCH_SIZE	4096
> >>
> >>  /*
> >> - * Structure allocated for each folio when block size < folio size
> >> - * to track sub-folio uptodate status and I/O completions.
> >> + * Structure allocated for each folio to track per-block uptodate state
> >> + * and I/O completions.
> >>   */
> >>  struct iomap_page {
> >>  	atomic_t		read_bytes_pending;
> >>  	atomic_t		write_bytes_pending;
> >> -	spinlock_t		uptodate_lock;
> >> -	unsigned long		uptodate[];
> >> +	spinlock_t		state_lock;
> >> +	unsigned long		state[];
> >>  };
> >>
> >>  static inline struct iomap_page *to_iomap_page(struct folio *folio)
> >> @@ -43,6 +43,48 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
> >>
> >>  static struct bio_set iomap_ioend_bioset;
> >>
> >> +static bool iop_test_full_uptodate(struct folio *folio)
> >
> > Same comment as Andreas, I think this works better with 'fully', e.g.
> >
> > iop_test_fully_uptodate()
> >
> > Why you don't pass the iomap_page directly into this function?  Doesn't
> > that eliminate the need for iomap_iop_free to keep folio->private set
> > until the very end?
> >
> > static inline bool
> > iomap_iop_is_fully_uptodate(const struct iomap_page *iop,
> > 			    const struct folio *folio)
> >
> > Same sort of thing for the second function -- we already extracted
> > folio->private and checked it wasn't null, so we don't need to do that
> > again.
> >
> > static inline bool
> > iomap_io_is_block_uptodate(const struct iomap_page *iop,
> > 			   const struct folio *folio,
> > 			   unsigned int block)
> >
> >> +{
> >> +	struct iomap_page *iop = to_iomap_page(folio);
> >> +	struct inode *inode = folio->mapping->host;
> >> +
> >> +	return bitmap_full(iop->state, i_blocks_per_folio(inode, folio));
> >> +}
> >> +
> >> +static bool iop_test_block_uptodate(struct folio *folio, unsigned int block)
> >> +{
> >> +	struct iomap_page *iop = to_iomap_page(folio);
> >> +
> >> +	return test_bit(block, iop->state);
> >> +}
> >> +
> >> +static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
> >> +				   size_t off, size_t len)
> >> +{
> >> +	struct iomap_page *iop = to_iomap_page(folio);
> >> +	unsigned int first_blk = off >> inode->i_blkbits;
> >> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
> >> +	unsigned int nr_blks = last_blk - first_blk + 1;
> >> +	unsigned long flags;
> >> +
> >> +	spin_lock_irqsave(&iop->state_lock, flags);
> >> +	bitmap_set(iop->state, first_blk, nr_blks);
> >> +	if (iop_test_full_uptodate(folio))
> >> +		folio_mark_uptodate(folio);
> >> +	spin_unlock_irqrestore(&iop->state_lock, flags);
> >> +}
> >> +
> >> +static void iomap_iop_set_range_uptodate(struct inode *inode,
> >
> > I don't understand why iomap_set_range_uptodate is now
> > iomap_iop_set_range_uptodate; it doesn't take an iomap_page object as an
> > argument...?
> >
> > I thought I understood that iomap_FOO operates on a folio and a range,
> > whereas iomap_iop_FOO operates on sub-blocks within a folio?  And that
> > you were renaming the iop_* functions to iomap_iop_*?
> >
> > I'm also not sure why iop_set_range_uptodate needs to be passed the
> > struct inode; can't it extract that from folio->mapping->host, like
> > current upstream does?
> >
> 
> So, I do have a confusion in __folio_mark_dirty() function...
> 
> i.e. __folio_mark_dirty checks whether folio->mapping is not NULL.
> That means for marking range of blocks dirty within iop from
> ->dirty_folio(), we can't use folio->mapping->host is it?
> We have to use inode from mapping->host (mapping is passed as a
> parameter in ->dirty_folio).

Ah, yeah.  folio->mapping can become NULL if truncate races with us in
removing the folio from the foliocache.

For regular reads and writes this is a nonissue because those paths all
take i_rwsem and will block truncate.  However, for page_mkwrite, xfs
doesn't take mmap_invalidate_lock until after the vm_fault has been
given a folio to play with.

I think that means we can't rely on folio->mapping to be non-null, and
hence can't dereference folio->mapping->host.  That said, if the folio's
locked and folio->mapping is null, the page has been truncated so we
could just return VM_FAULT_NOPAGE, perhaps?

(willy might know better than I do...)

> I tried looking into the history of this, but I couldn't find any.
> This is also the reason I thought we would need to pass an inode for the
> iop_set_range_dirty() function (because it is also called from
> ->dirty_folio -> iomap_dirty_folio()) and to keep it consistent, I kept
> inode argument for iop_**_uptodate functions as well.

That seems ok to me, now that you've brought that ^^ to my attention.

--D

> Thoughts please?
> 
> <some code snippet>
> ====================
> 
> iomap_dirty_folio -> filemap_dirty_folio-> __folio_mark_dirty()
> 
> void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
> 			     int warn)
> {
> 	unsigned long flags;
> 
> 	xa_lock_irqsave(&mapping->i_pages, flags);
> 	if (folio->mapping) {	/* Race with truncate? */
> 		WARN_ON_ONCE(warn && !folio_test_uptodate(folio));
> 		folio_account_dirtied(folio, mapping);
> 		__xa_set_mark(&mapping->i_pages, folio_index(folio),
> 				PAGECACHE_TAG_DIRTY);
> 	}
> 	xa_unlock_irqrestore(&mapping->i_pages, flags);
> }
> 
> -ritesh
> 
> 
> 
> > Generally I don't understand why this part of the patch is needed at
> > all.  Wasn't the point merely to rename uptodate_* to state_* and
> > introduce the iomap_iop_test_*_uptodate helpers?
> >
> > --D
> >
> >> +		struct folio *folio, size_t off, size_t len)
> >> +{
> >> +	struct iomap_page *iop = to_iomap_page(folio);
> >> +
> >> +	if (iop)
> >> +		iop_set_range_uptodate(inode, folio, off, len);
> >> +	else
> >> +		folio_mark_uptodate(folio);
> >> +}
> >> +
> >>  static struct iomap_page *iomap_iop_alloc(struct inode *inode,
> >>  				struct folio *folio, unsigned int flags)
> >>  {
> >> @@ -58,12 +100,12 @@ static struct iomap_page *iomap_iop_alloc(struct inode *inode,
> >>  	else
> >>  		gfp = GFP_NOFS | __GFP_NOFAIL;
> >>
> >> -	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
> >> +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
> >>  		      gfp);
> >>  	if (iop) {
> >> -		spin_lock_init(&iop->uptodate_lock);
> >> +		spin_lock_init(&iop->state_lock);
> >>  		if (folio_test_uptodate(folio))
> >> -			bitmap_fill(iop->uptodate, nr_blocks);
> >> +			bitmap_fill(iop->state, nr_blocks);
> >>  		folio_attach_private(folio, iop);
> >>  	}
> >>  	return iop;
> >> @@ -72,14 +114,12 @@ static struct iomap_page *iomap_iop_alloc(struct inode *inode,
> >>  static void iomap_iop_free(struct folio *folio)
> >>  {
> >>  	struct iomap_page *iop = to_iomap_page(folio);
> >> -	struct inode *inode = folio->mapping->host;
> >> -	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> >>
> >>  	if (!iop)
> >>  		return;
> >>  	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
> >>  	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
> >> -	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> >> +	WARN_ON_ONCE(iop_test_full_uptodate(folio) !=
> >>  			folio_test_uptodate(folio));
> >>  	folio_detach_private(folio);
> >>  	kfree(iop);
> >> @@ -111,7 +151,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
> >>
> >>  		/* move forward for each leading block marked uptodate */
> >>  		for (i = first; i <= last; i++) {
> >> -			if (!test_bit(i, iop->uptodate))
> >> +			if (!iop_test_block_uptodate(folio, i))
> >>  				break;
> >>  			*pos += block_size;
> >>  			poff += block_size;
> >> @@ -121,7 +161,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
> >>
> >>  		/* truncate len if we find any trailing uptodate block(s) */
> >>  		for ( ; i <= last; i++) {
> >> -			if (test_bit(i, iop->uptodate)) {
> >> +			if (iop_test_block_uptodate(folio, i)) {
> >>  				plen -= (last - i + 1) * block_size;
> >>  				last = i - 1;
> >>  				break;
> >> @@ -145,30 +185,6 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
> >>  	*lenp = plen;
> >>  }
> >>
> >> -static void iomap_iop_set_range_uptodate(struct folio *folio,
> >> -		struct iomap_page *iop, size_t off, size_t len)
> >> -{
> >> -	struct inode *inode = folio->mapping->host;
> >> -	unsigned first = off >> inode->i_blkbits;
> >> -	unsigned last = (off + len - 1) >> inode->i_blkbits;
> >> -	unsigned long flags;
> >> -
> >> -	spin_lock_irqsave(&iop->uptodate_lock, flags);
> >> -	bitmap_set(iop->uptodate, first, last - first + 1);
> >> -	if (bitmap_full(iop->uptodate, i_blocks_per_folio(inode, folio)))
> >> -		folio_mark_uptodate(folio);
> >> -	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
> >> -}
> >> -
> >> -static void iomap_set_range_uptodate(struct folio *folio,
> >> -		struct iomap_page *iop, size_t off, size_t len)
> >> -{
> >> -	if (iop)
> >> -		iomap_iop_set_range_uptodate(folio, iop, off, len);
> >> -	else
> >> -		folio_mark_uptodate(folio);
> >> -}
> >> -
> >>  static void iomap_finish_folio_read(struct folio *folio, size_t offset,
> >>  		size_t len, int error)
> >>  {
> >> @@ -178,7 +194,8 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
> >>  		folio_clear_uptodate(folio);
> >>  		folio_set_error(folio);
> >>  	} else {
> >> -		iomap_set_range_uptodate(folio, iop, offset, len);
> >> +		iomap_iop_set_range_uptodate(folio->mapping->host, folio,
> >> +					     offset, len);
> >>  	}
> >>
> >>  	if (!iop || atomic_sub_and_test(len, &iop->read_bytes_pending))
> >> @@ -214,7 +231,6 @@ struct iomap_readpage_ctx {
> >>  static int iomap_read_inline_data(const struct iomap_iter *iter,
> >>  		struct folio *folio)
> >>  {
> >> -	struct iomap_page *iop;
> >>  	const struct iomap *iomap = iomap_iter_srcmap(iter);
> >>  	size_t size = i_size_read(iter->inode) - iomap->offset;
> >>  	size_t poff = offset_in_page(iomap->offset);
> >> @@ -232,15 +248,14 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
> >>  	if (WARN_ON_ONCE(size > iomap->length))
> >>  		return -EIO;
> >>  	if (offset > 0)
> >> -		iop = iomap_iop_alloc(iter->inode, folio, iter->flags);
> >> -	else
> >> -		iop = to_iomap_page(folio);
> >> +		iomap_iop_alloc(iter->inode, folio, iter->flags);
> >>
> >>  	addr = kmap_local_folio(folio, offset);
> >>  	memcpy(addr, iomap->inline_data, size);
> >>  	memset(addr + size, 0, PAGE_SIZE - poff - size);
> >>  	kunmap_local(addr);
> >> -	iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
> >> +	iomap_iop_set_range_uptodate(iter->inode, folio, offset,
> >> +				     PAGE_SIZE - poff);
> >>  	return 0;
> >>  }
> >>
> >> @@ -277,7 +292,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
> >>
> >>  	if (iomap_block_needs_zeroing(iter, pos)) {
> >>  		folio_zero_range(folio, poff, plen);
> >> -		iomap_set_range_uptodate(folio, iop, poff, plen);
> >> +		iomap_iop_set_range_uptodate(iter->inode, folio, poff, plen);
> >>  		goto done;
> >>  	}
> >>
> >> @@ -452,7 +467,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
> >>  	last = (from + count - 1) >> inode->i_blkbits;
> >>
> >>  	for (i = first; i <= last; i++)
> >> -		if (!test_bit(i, iop->uptodate))
> >> +		if (!iop_test_block_uptodate(folio, i))
> >>  			return false;
> >>  	return true;
> >>  }
> >> @@ -591,7 +606,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
> >>  			if (status)
> >>  				return status;
> >>  		}
> >> -		iomap_set_range_uptodate(folio, iop, poff, plen);
> >> +		iomap_iop_set_range_uptodate(iter->inode, folio, poff, plen);
> >>  	} while ((block_start += plen) < block_end);
> >>
> >>  	return 0;
> >> @@ -698,7 +713,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> >>  static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> >>  		size_t copied, struct folio *folio)
> >>  {
> >> -	struct iomap_page *iop = to_iomap_page(folio);
> >>  	flush_dcache_folio(folio);
> >>
> >>  	/*
> >> @@ -714,7 +728,8 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> >>  	 */
> >>  	if (unlikely(copied < len && !folio_test_uptodate(folio)))
> >>  		return 0;
> >> -	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
> >> +	iomap_iop_set_range_uptodate(inode, folio, offset_in_folio(folio, pos),
> >> +				     len);
> >>  	filemap_dirty_folio(inode->i_mapping, folio);
> >>  	return copied;
> >>  }
> >> @@ -1630,7 +1645,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >>  	 * invalid, grab a new one.
> >>  	 */
> >>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> >> -		if (iop && !test_bit(i, iop->uptodate))
> >> +		if (iop && !iop_test_block_uptodate(folio, i))
> >>  			continue;
> >>
> >>  		error = wpc->ops->map_blocks(wpc, inode, pos);
> >> --
> >> 2.40.1
> >>
