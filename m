Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30062721CC1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 06:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjFEEDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 00:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFEEDl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:03:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E419BC;
        Sun,  4 Jun 2023 21:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U4HI1ekIHHcIIOIBiStobq1kk+Nbt33a7tClgownB0s=; b=nJAkyAWxCuxG1DVp4MayHaMofv
        s5vduXIgeaFDpx3gR5Kkkbcssd9cNOBD9HFkbPp03U+PteoG+Qz1L90a0faIdzIo3sXRH7Y120zQ5
        vf8OZcgZ/lOAgw3q76NkLl3jQCoO7/MaO1M+h2i0mOv5Z+6uqy1fuU3BW2HZJnY7g3hEfawmKaujP
        jJ8nHqe8X2aKHa7OcYQDxO5BTOf9opMxsvb1Nf72dwV7RWoi7DOGc+h/Z8fjjMQWhfB+tXuEX560y
        2xpWc7KgE0nvFYtd+Gv0/kxZhjIV5HGsEwcaIOZdFmx9AKo3j5Hp2a2xwsXEpRHblT8xiOrwijez9
        JO9tTvfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q61RP-00BdVd-QG; Mon, 05 Jun 2023 04:03:35 +0000
Date:   Mon, 5 Jun 2023 05:03:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv6 5/5] iomap: Add per-block dirty state tracking to
 improve performance
Message-ID: <ZH1elxw5ddP+bjEa@casper.infradead.org>
References: <cover.1685900733.git.ritesh.list@gmail.com>
 <c38a4081e762e38b8fc4c0a54d848741d28d7455.1685900733.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c38a4081e762e38b8fc4c0a54d848741d28d7455.1685900733.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 07:01:52AM +0530, Ritesh Harjani (IBM) wrote:
> +static void iop_set_range_dirty(struct inode *inode, struct folio *folio,
> +				size_t off, size_t len)
> +{
> +	struct iomap_page *iop = to_iomap_page(folio);
> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +	unsigned int first_blk = off >> inode->i_blkbits;
> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
> +	unsigned int nr_blks = last_blk - first_blk + 1;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	bitmap_set(iop->state, first_blk + blks_per_folio, nr_blks);
> +	spin_unlock_irqrestore(&iop->state_lock, flags);
> +}
> +
> +static void iomap_iop_set_range_dirty(struct inode *inode, struct folio *folio,
> +				size_t off, size_t len)
> +{
> +	struct iomap_page *iop = to_iomap_page(folio);
> +
> +	if (iop)
> +		iop_set_range_dirty(inode, folio, off, len);
> +}

Why are these separate functions?  It'd be much better written as:

static void iomap_iop_set_range_dirty(struct inode *inode, struct folio *folio,
		size_t off, size_t len)
{
	struct iomap_page *iop = to_iomap_page(folio);
	unsigned int start, first, last;
	unsigned long flags;

	if (!iop)
		return;

	start = i_blocks_per_folio(inode, folio);
	first = off >> inode->i_blkbits;
	last = (off + len - 1) >> inode->i_blkbits;

	spin_lock_irqsave(&iop->state_lock, flags);
	bitmap_set(iop->state, start + first, last - first + 1);
	spin_unlock_irqrestore(&iop->state_lock, flags);
}

> +static void iop_clear_range_dirty(struct inode *inode, struct folio *folio,
> +				  size_t off, size_t len)
> +{
> +	struct iomap_page *iop = to_iomap_page(folio);
> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +	unsigned int first_blk = off >> inode->i_blkbits;
> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
> +	unsigned int nr_blks = last_blk - first_blk + 1;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	bitmap_clear(iop->state, first_blk + blks_per_folio, nr_blks);
> +	spin_unlock_irqrestore(&iop->state_lock, flags);
> +}
> +
> +static void iomap_iop_clear_range_dirty(struct inode *inode,
> +				struct folio *folio, size_t off, size_t len)
> +{
> +	struct iomap_page *iop = to_iomap_page(folio);
> +
> +	if (iop)
> +		iop_clear_range_dirty(inode, folio, off, len);
> +}

Similarly

> +bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
> +{
> +	struct iomap_page __maybe_unused *iop;
> +	struct inode *inode = mapping->host;
> +	size_t len = folio_size(folio);
> +
> +	iop = iomap_iop_alloc(inode, folio, 0);

Why do you keep doing this?  Just throw away the return value from
iomap_iop_alloc().  Don't clutter the source with the unnecessary
variable declaration and annotation that it's not used!

> +static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
> +		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
> +		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
> +{
> +	struct iomap_page *iop;
> +	unsigned int first_blk, last_blk, i;
> +	loff_t last_byte;
> +	u8 blkbits = inode->i_blkbits;
> +	int ret = 0;
> +
> +	if (start_byte > *punch_start_byte) {
> +		ret = punch(inode, *punch_start_byte,
> +				start_byte - *punch_start_byte);
> +		if (ret)
> +			goto out_err;
> +	}
> +	/*
> +	 * When we have per-block dirty tracking, there can be
> +	 * blocks within a folio which are marked uptodate
> +	 * but not dirty. In that case it is necessary to punch
> +	 * out such blocks to avoid leaking any delalloc blocks.
> +	 */
> +	iop = to_iomap_page(folio);
> +	if (!iop)
> +		goto skip_iop_punch;
> +
> +	last_byte = min_t(loff_t, end_byte - 1,
> +		(folio_next_index(folio) << PAGE_SHIFT) - 1);
> +	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
> +	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
> +	for (i = first_blk; i <= last_blk; i++) {
> +		if (!iop_test_block_dirty(folio, i)) {
> +			ret = punch(inode, i << blkbits, 1 << blkbits);
> +			if (ret)
> +				goto out_err;
> +		}
> +	}
> +
> +skip_iop_punch:
> +	/*
> +	 * Make sure the next punch start is correctly bound to
> +	 * the end of this data range, not the end of the folio.
> +	 */
> +	*punch_start_byte = min_t(loff_t, end_byte,
> +			folio_next_index(folio) << PAGE_SHIFT);
> +
> +	return ret;
> +
> +out_err:
> +	folio_unlock(folio);
> +	folio_put(folio);
> +	return ret;
> +
> +}
> +
>  /*
>   * Scan the data range passed to us for dirty page cache folios. If we find a
>   * dirty folio, punch out the preceeding range and update the offset from which
> @@ -940,26 +1074,9 @@ static int iomap_write_delalloc_scan(struct inode *inode,
>  		}
>  
>  		/* if dirty, punch up to offset */
> -		if (folio_test_dirty(folio)) {
> -			if (start_byte > *punch_start_byte) {
> -				int	error;
> -
> -				error = punch(inode, *punch_start_byte,
> -						start_byte - *punch_start_byte);
> -				if (error) {
> -					folio_unlock(folio);
> -					folio_put(folio);
> -					return error;
> -				}
> -			}
> -
> -			/*
> -			 * Make sure the next punch start is correctly bound to
> -			 * the end of this data range, not the end of the folio.
> -			 */
> -			*punch_start_byte = min_t(loff_t, end_byte,
> -					folio_next_index(folio) << PAGE_SHIFT);
> -		}
> +		if (folio_test_dirty(folio))
> +			iomap_write_delalloc_punch(inode, folio, punch_start_byte,
> +					   start_byte, end_byte, punch);
>  
>  		/* move offset to start of next folio in range */
>  		start_byte = folio_next_index(folio) << PAGE_SHIFT;

I'm having trouble following this refactoring + modification.  Perhaps
I'm just tired.

