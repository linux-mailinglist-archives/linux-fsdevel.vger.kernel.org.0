Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955E36118A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiJ1RDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJ1RCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCA67961E;
        Fri, 28 Oct 2022 10:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5B8F629B0;
        Fri, 28 Oct 2022 17:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28567C4347C;
        Fri, 28 Oct 2022 17:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666976480;
        bh=jEZoaqF+Fi7IueTWAFeFlWwwWlAqRrSyOpN7BcmcELQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpR+9FQrh+iOgwRNtQLAgeCVOia/kibwu48610ebBZehvOw0NniQk7TnNB+QO2j1Z
         BMT7WI+miTHZ7jFU7EQfduywJaRO/j687dy7ZnnMA+EqwIuElf9+FY3QMik/FUk7Bh
         14GA+RxtIqkof8I0uJiWQLAVy6osqgE0dGteIR3p8guA0DjtIXFFkQg/0qaiz3u+hE
         ecpyP8Vain0rhCU/WFu4aiAgGhL51PtTXMrYzBpYHowa5rlnFTGKQO0jsiuWKwwn+w
         IRoyxq1J91GtWp266tgiEpLes1/X4rwsk8wkDe6CtJgO0hu8pN2a2p2iHdr0CIOLQ/
         m9yxOteN32Cyg==
Date:   Fri, 28 Oct 2022 10:01:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <Y1wK3x7IketHl+DQ@magnolia>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:00:33AM +0530, Ritesh Harjani (IBM) wrote:
> On a 64k pagesize platforms (specially Power and/or aarch64) with 4k
> filesystem blocksize, this patch should improve the performance by doing
> only the subpage dirty data write.
> 
> This should also reduce the write amplification since we can now track
> subpage dirty status within state bitmaps. Earlier we had to
> write the entire 64k page even if only a part of it (e.g. 4k) was
> updated.
> 
> Performance testing of below fio workload reveals ~16x performance
> improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
> FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
> 
> <test_randwrite.fio>
> [global]
> 	ioengine=psync
> 	rw=randwrite
> 	overwrite=1
> 	pre_read=1
> 	direct=0
> 	bs=4k
> 	size=1G
> 	dir=./
> 	numjobs=8
> 	fdatasync=1
> 	runtime=60
> 	iodepth=64
> 	group_reporting=1
> 
> [fio-run]
> 
> Reported-by: Aravinda Herle <araherle@in.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 53 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 255f9f92668c..31ee80a996b2 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -58,7 +58,7 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
>  	else
>  		gfp = GFP_NOFS | __GFP_NOFAIL;
>  
> -	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
> +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
>  		      gfp);
>  	if (iop) {
>  		spin_lock_init(&iop->state_lock);
> @@ -168,6 +168,48 @@ static void iomap_set_range_uptodate(struct folio *folio,
>  		folio_mark_uptodate(folio);
>  }
>  
> +static void iomap_iop_set_range_dirty(struct folio *folio,
> +		struct iomap_page *iop, size_t off, size_t len)
> +{
> +	struct inode *inode = folio->mapping->host;
> +	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> +	unsigned first = (off >> inode->i_blkbits) + nr_blocks;
> +	unsigned last = ((off + len - 1) >> inode->i_blkbits) + nr_blocks;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	bitmap_set(iop->state, first, last - first + 1);
> +	spin_unlock_irqrestore(&iop->state_lock, flags);
> +}
> +
> +static void iomap_set_range_dirty(struct folio *folio,
> +		struct iomap_page *iop, size_t off, size_t len)
> +{
> +	if (iop)
> +		iomap_iop_set_range_dirty(folio, iop, off, len);
> +}
> +
> +static void iomap_iop_clear_range_dirty(struct folio *folio,
> +		struct iomap_page *iop, size_t off, size_t len)
> +{
> +	struct inode *inode = folio->mapping->host;
> +	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> +	unsigned first = (off >> inode->i_blkbits) + nr_blocks;
> +	unsigned last = ((off + len - 1) >> inode->i_blkbits) + nr_blocks;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	bitmap_clear(iop->state, first, last - first + 1);
> +	spin_unlock_irqrestore(&iop->state_lock, flags);
> +}
> +
> +static void iomap_clear_range_dirty(struct folio *folio,
> +		struct iomap_page *iop, size_t off, size_t len)
> +{
> +	if (iop)
> +		iomap_iop_clear_range_dirty(folio, iop, off, len);
> +}
> +
>  static void iomap_finish_folio_read(struct folio *folio, size_t offset,
>  		size_t len, int error)
>  {
> @@ -665,6 +707,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	if (unlikely(copied < len && !folio_test_uptodate(folio)))
>  		return 0;
>  	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
> +	iomap_set_range_dirty(folio, iop, offset_in_folio(folio, pos), len);
>  	filemap_dirty_folio(inode->i_mapping, folio);
>  	return copied;
>  }
> @@ -979,6 +1022,8 @@ static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
>  		block_commit_write(&folio->page, 0, length);
>  	} else {
>  		WARN_ON_ONCE(!folio_test_uptodate(folio));
> +		iomap_set_range_dirty(folio, to_iomap_page(folio),
> +				offset_in_folio(folio, iter->pos), length);
>  		folio_mark_dirty(folio);
>  	}
>  
> @@ -1354,7 +1399,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * invalid, grab a new one.
>  	 */
>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> -		if (iop && !test_bit(i, iop->state))
> +		if (iop && (!test_bit(i, iop->state) ||
> +			    !test_bit(i + nblocks, iop->state)))

Hmm.  So I /think/ these two test_bit()s mean that we skip any folio
sub-block if it's either notuptodate or not dirty?

I /think/ we only need to check the dirty status, right?  Like willy
said? :)

That said... somewhere we probably ought to check the consistency of the
two bits to ensure that they're not (dirty && !uptodate), given our
horrible history of getting things wrong with page and bufferhead state
bits.

Admittedly I'm not thrilled at the reintroduction of page and iop dirty
state that are updated in separate places, but OTOH the write
amplification here is demonstrably horrifying as you point out so it's
clearly necessary.

Maybe we need a debugging function that will check the page and iop
state, and call it every time we go in and out of critical iomap
functions (write, writeback, dropping pages, etc)

--D

>  			continue;
>  
>  		error = wpc->ops->map_blocks(wpc, inode, pos);
> @@ -1397,6 +1443,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		}
>  	}
>  
> +	iomap_clear_range_dirty(folio, iop,
> +				offset_in_folio(folio, folio_pos(folio)),
> +				end_pos - folio_pos(folio));
>  	folio_start_writeback(folio);
>  	folio_unlock(folio);
>  
> -- 
> 2.37.3
> 
