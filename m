Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E93357E604
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 19:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiGVRxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 13:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiGVRxo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:53:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368AAE4;
        Fri, 22 Jul 2022 10:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC35D622CA;
        Fri, 22 Jul 2022 17:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D11C341C6;
        Fri, 22 Jul 2022 17:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658512423;
        bh=aH7ipXW19B/cULTLHxU4tydKYD6QhKFE7T4q2uxNrD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ReHgVOJpZKkP8HvxXgI8IsZJv0mIyKP0Mjwfjkhr5FHHBqffXTErE4bbmZgLLCYP6
         T+AE/FUOtdZbf4fdoggWfrm1qgbi1RlTjVyOjI9Z8n6fzYkt1v0RMuPcTKmY5UGldb
         0w0gyYORBFfJbzFD1SC7Q8HepbsRIsZP48nbunzpuz14/9fQ8xa/ToiWWAl03lPRjl
         boz3BJp2x6s0EwT4/FOr/qSpDj6+P/DUYCgt0uRcxuQAd97BvrRkcjYj27IASzCiVo
         8OmtMEd1bmqXw17QzW/EfL5y20ycJKL4DAc6ySKI5JQatsDZDy13YoHtxWrLLV3RVI
         CIAGt0syvJzcw==
Date:   Fri, 22 Jul 2022 10:53:42 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <YtrkJgwOmCGqPO3E@magnolia>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
 <YtpTYSNUCwPelNgL@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtpTYSNUCwPelNgL@sol.localdomain>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 12:36:01AM -0700, Eric Biggers wrote:
> [+f2fs list and maintainers]
> 
> On Fri, Jun 10, 2022 at 12:58:30PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Use the address alignment requirements from the block_device for direct
> > io instead of requiring addresses be aligned to the block size.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/iomap/direct-io.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 370c3241618a..5d098adba443 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -242,7 +242,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> >  	struct inode *inode = iter->inode;
> >  	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
> >  	unsigned int fs_block_size = i_blocksize(inode), pad;
> > -	unsigned int align = iov_iter_alignment(dio->submit.iter);
> >  	loff_t length = iomap_length(iter);
> >  	loff_t pos = iter->pos;
> >  	unsigned int bio_opf;
> > @@ -253,7 +252,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> >  	size_t copied = 0;
> >  	size_t orig_count;
> >  
> > -	if ((pos | length | align) & ((1 << blkbits) - 1))
> > +	if ((pos | length) & ((1 << blkbits) - 1) ||
> > +	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))

How does this change intersect with "make statx() return DIO alignment
information" ?  Will the new STATX_DIOALIGN implementations have to be
adjusted to set stx_dio_mem_align = bdev_dma_alignment(...)?

I'm guessing the answer is yes, but I haven't seen any patches on the
list to do that, but more and more these days email behaves like a flood
of UDP traffic... :(

--D

> >  		return -EINVAL;
> >  
> >  	if (iomap->type == IOMAP_UNWRITTEN) {
> 
> I noticed that this patch is going to break the following logic in
> f2fs_should_use_dio() in fs/f2fs/file.c:
> 
> 	/*
> 	 * Direct I/O not aligned to the disk's logical_block_size will be
> 	 * attempted, but will fail with -EINVAL.
> 	 *
> 	 * f2fs additionally requires that direct I/O be aligned to the
> 	 * filesystem block size, which is often a stricter requirement.
> 	 * However, f2fs traditionally falls back to buffered I/O on requests
> 	 * that are logical_block_size-aligned but not fs-block aligned.
> 	 *
> 	 * The below logic implements this behavior.
> 	 */
> 	align = iocb->ki_pos | iov_iter_alignment(iter);
> 	if (!IS_ALIGNED(align, i_blocksize(inode)) &&
> 	    IS_ALIGNED(align, bdev_logical_block_size(inode->i_sb->s_bdev)))
> 		return false;
> 
> 	return true;
> 
> So, f2fs assumes that __iomap_dio_rw() returns an error if the I/O isn't logical
> block aligned.  This patch changes that.  The result is that DIO will sometimes
> proceed in cases where the I/O doesn't have the fs block alignment required by
> f2fs for all DIO.
> 
> Does anyone have any thoughts about what f2fs should be doing here?  I think
> it's weird that f2fs has different behaviors for different degrees of
> misalignment: fail with EINVAL if not logical block aligned, else fallback to
> buffered I/O if not fs block aligned.  I think it should be one convention or
> the other.  Any opinions about which one it should be?
> 
> (Note: if you blame the above code, it was written by me.  But I was just
> preserving the existing behavior; I don't know the original motivation.)
> 
> - Eric
