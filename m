Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF67D57EC2C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jul 2022 07:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiGWFDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Jul 2022 01:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiGWFDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Jul 2022 01:03:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F13BE9D4;
        Fri, 22 Jul 2022 22:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDEE160AFB;
        Sat, 23 Jul 2022 05:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A452C341C0;
        Sat, 23 Jul 2022 05:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658552596;
        bh=AaXFZrwKTUU6UrRXrK94Z+zja72i1JjD3maZa+2WSDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NiPTZKSntRLpsWC2wnEE/9s5Ls/ZV/qrKlqVIc1zO4K13INz/0pAB23jjh+OIe7Tb
         aVLUcjYx/E1f93YFKBHh6aF95V6SekpqSSQIbeSA/e+2vU4E6KJs/geUKC57+cZBXQ
         Xp0Aim38hl+Kp2FRQpOR+J/blPWy9OQ6nTQM+X0KCptWqjbOA8fba8Qmo+qSyHIcCB
         WkqPesCM9h8o31anSVs3tyFkotxcc5XlUjsHc23KYfW73nxG8qicIVJsNUGp+yChFd
         As/bA1MVnE3ZuwU4WizlJnw19tLqcMIZTcW6iJ1zOTW3+sWC/V3DbMrhHxjq6rTm5t
         C0YYwut8nyrIw==
Date:   Fri, 22 Jul 2022 22:03:15 -0700
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
Message-ID: <YtuBE8EZbATU495P@magnolia>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
 <YtpTYSNUCwPelNgL@sol.localdomain>
 <YtrkJgwOmCGqPO3E@magnolia>
 <YtromC4cR5a0mog8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtromC4cR5a0mog8@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 06:12:40PM +0000, Eric Biggers wrote:
> On Fri, Jul 22, 2022 at 10:53:42AM -0700, Darrick J. Wong wrote:
> > On Fri, Jul 22, 2022 at 12:36:01AM -0700, Eric Biggers wrote:
> > > [+f2fs list and maintainers]
> > > 
> > > On Fri, Jun 10, 2022 at 12:58:30PM -0700, Keith Busch wrote:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > > 
> > > > Use the address alignment requirements from the block_device for direct
> > > > io instead of requiring addresses be aligned to the block size.
> > > > 
> > > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > ---
> > > >  fs/iomap/direct-io.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > > index 370c3241618a..5d098adba443 100644
> > > > --- a/fs/iomap/direct-io.c
> > > > +++ b/fs/iomap/direct-io.c
> > > > @@ -242,7 +242,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > > >  	struct inode *inode = iter->inode;
> > > >  	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
> > > >  	unsigned int fs_block_size = i_blocksize(inode), pad;
> > > > -	unsigned int align = iov_iter_alignment(dio->submit.iter);
> > > >  	loff_t length = iomap_length(iter);
> > > >  	loff_t pos = iter->pos;
> > > >  	unsigned int bio_opf;
> > > > @@ -253,7 +252,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > > >  	size_t copied = 0;
> > > >  	size_t orig_count;
> > > >  
> > > > -	if ((pos | length | align) & ((1 << blkbits) - 1))
> > > > +	if ((pos | length) & ((1 << blkbits) - 1) ||
> > > > +	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> > 
> > How does this change intersect with "make statx() return DIO alignment
> > information" ?  Will the new STATX_DIOALIGN implementations have to be
> > adjusted to set stx_dio_mem_align = bdev_dma_alignment(...)?
> > 
> > I'm guessing the answer is yes, but I haven't seen any patches on the
> > list to do that, but more and more these days email behaves like a flood
> > of UDP traffic... :(
> > 
> 
> Yes.  I haven't done that in the STATX_DIOALIGN patchset yet because I've been
> basing it on upstream, which doesn't yet have this iomap patch.  I haven't been
> expecting STATX_DIOALIGN to make 5.20, given that it's a new UAPI that needs
> time to be properly reviewed, plus I've just been busy with other things.  So
> I've been planning to make the above change after this patch lands upstream.

<nod> Ok, I'm looking forward to it.  Thank you for your work on statx! :)

--D

> - Eric
