Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5125157E62C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 20:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiGVSBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 14:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiGVSBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E4613F93;
        Fri, 22 Jul 2022 11:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7EBA622D7;
        Fri, 22 Jul 2022 18:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD37C341C6;
        Fri, 22 Jul 2022 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658512897;
        bh=eZLmaZ6G6g5lqte/Ys+R+WbUlvjke0UdT436JFR7AIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nb+MLDqg88rYpbxrrfNfRc3ai+Ysgc0CNPh7FHGrlUDATD+ocIqvXJ35tQf8Bmawh
         fE/cI36MPvhsPcQIEhiw3qEsB4d7Dp6H4DbdzLuTBavZPesmUF+6OFjJd9AFdAJqGO
         B/XHy9HhApKhY4eZZy36dUhtt1FI6m6yNjJRjYWQtdQZ/5tYk42FDjBb4DssM3uIul
         hQ0LWohGSZnoZuTya3nHC378UU7PqhPSOwIAFbotzkmPb6lPPW2Er35I/Sf2szA2Z7
         miaWI/J/IP25LAYqpG5O/gmsdoXc2D+QzitWgWXBRjCgDsKcNTpveYwNeye2N76blH
         qv3frkibWXyxw==
Date:   Fri, 22 Jul 2022 18:01:35 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <Ytrl/1YEg9M0fb+i@gmail.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
 <YtpTYSNUCwPelNgL@sol.localdomain>
 <Ytq3qwTBTRRxBfXv@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytq3qwTBTRRxBfXv@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 08:43:55AM -0600, Keith Busch wrote:
> On Fri, Jul 22, 2022 at 12:36:01AM -0700, Eric Biggers wrote:
> > [+f2fs list and maintainers]
> > 
> > On Fri, Jun 10, 2022 at 12:58:30PM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > Use the address alignment requirements from the block_device for direct
> > > io instead of requiring addresses be aligned to the block size.
> > > 
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/iomap/direct-io.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index 370c3241618a..5d098adba443 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -242,7 +242,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >  	struct inode *inode = iter->inode;
> > >  	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
> > >  	unsigned int fs_block_size = i_blocksize(inode), pad;
> > > -	unsigned int align = iov_iter_alignment(dio->submit.iter);
> > >  	loff_t length = iomap_length(iter);
> > >  	loff_t pos = iter->pos;
> > >  	unsigned int bio_opf;
> > > @@ -253,7 +252,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >  	size_t copied = 0;
> > >  	size_t orig_count;
> > >  
> > > -	if ((pos | length | align) & ((1 << blkbits) - 1))
> > > +	if ((pos | length) & ((1 << blkbits) - 1) ||
> > > +	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> > >  		return -EINVAL;
> > >  
> > >  	if (iomap->type == IOMAP_UNWRITTEN) {
> > 
> > I noticed that this patch is going to break the following logic in
> > f2fs_should_use_dio() in fs/f2fs/file.c:
> > 
> > 	/*
> > 	 * Direct I/O not aligned to the disk's logical_block_size will be
> > 	 * attempted, but will fail with -EINVAL.
> > 	 *
> > 	 * f2fs additionally requires that direct I/O be aligned to the
> > 	 * filesystem block size, which is often a stricter requirement.
> > 	 * However, f2fs traditionally falls back to buffered I/O on requests
> > 	 * that are logical_block_size-aligned but not fs-block aligned.
> > 	 *
> > 	 * The below logic implements this behavior.
> > 	 */
> > 	align = iocb->ki_pos | iov_iter_alignment(iter);
> > 	if (!IS_ALIGNED(align, i_blocksize(inode)) &&
> > 	    IS_ALIGNED(align, bdev_logical_block_size(inode->i_sb->s_bdev)))
> > 		return false;
> > 
> > 	return true;
> > 
> > So, f2fs assumes that __iomap_dio_rw() returns an error if the I/O isn't logical
> > block aligned.  This patch changes that.  The result is that DIO will sometimes
> > proceed in cases where the I/O doesn't have the fs block alignment required by
> > f2fs for all DIO.
> > 
> > Does anyone have any thoughts about what f2fs should be doing here?  I think
> > it's weird that f2fs has different behaviors for different degrees of
> > misalignment: fail with EINVAL if not logical block aligned, else fallback to
> > buffered I/O if not fs block aligned.  I think it should be one convention or
> > the other.  Any opinions about which one it should be?
> 
> It looks like f2fs just falls back to buffered IO for this condition without
> reaching the new code in iomap_dio_bio_iter().

No.  It's a bit subtle, so read the code and what I'm saying carefully.  f2fs
only supports 4K aligned DIO and normally falls back to buffered I/O; however,
for DIO that is *very* misaligned (not even LBS aligned) it returns EINVAL
instead.  And it relies on __iomap_dio_rw() returning that EINVAL.

Relying on __iomap_dio_rw() in that way is definitely a bad design on f2fs's
part (and I messed that up when switching f2fs from fs/direct-io.c to iomap).
The obvious fix is to just have f2fs do the LBS alignment check itself.

But I think that f2fs shouldn't have different behavior for different levels of
misalignment in the first place, so I was wondering if anyone had any thoughts
on which behavior (EINVAL or fallback to buffered I/O) should be standardized on
in all cases, at least for f2fs.  There was some discussion about this sort of
thing for ext4 several years ago on the thread
https://lore.kernel.org/linux-ext4/1461472078-20104-1-git-send-email-tytso@mit.edu/T/#u,
but it didn't really reach a conclusion.  I'm wondering if the f2fs maintainers
have any thoughts about why the f2fs behavior is as it is.  I.e. is it just
accidental, or are there specific reasons...

- Eric
