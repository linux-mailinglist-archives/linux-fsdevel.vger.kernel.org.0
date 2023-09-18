Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB367A5145
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 19:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjIRRvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 13:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIRRvk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:51:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A17FFB;
        Mon, 18 Sep 2023 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AtWXTK9sBM3qyLBsA+qIGYXo3vkpfD3c/us98GiG588=; b=depldozsVNKZnEGYPeAz7DGFRW
        +kdoZkj/bKBt9WiQm4mVFQs5PxJYfgJXW2d993KWSTLtLZAxpb76dZiun83S2JjREqwpTaYQF0s8w
        5fEzbMruEmv6NeA8T+Q1h0a23k88aCF9kaR7S+e6e1EMqRXVGxnI2tnLV/KbZ1WXs5Sz2j9I+CtbK
        7E7kDIXVXWtgO37vRfLGWXIlhQI/NQ8ndoRSnvnxouzqkxCYnsdCRNHGT2Azie3J1Gx6KSJ4iJerT
        dEZLZQ/bBpGXucdQdNirB2I4e9OOnpn/FlEd+UTc0XLZVTRbkq4VpUn/oWlSZ6AFzZvZLmdcQx48k
        txFJ9yIg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qiIP2-00G0xi-0m;
        Mon, 18 Sep 2023 17:51:20 +0000
Date:   Mon, 18 Sep 2023 10:51:20 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>, hch@infradead.org,
        djwong@kernel.org, dchinner@redhat.com, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com, brauner@kernel.org, hare@suse.de,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        ziy@nvidia.com, ryan.roberts@arm.com, patches@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, dan.helmick@samsung.com
Subject: Re: [RFC v2 00/10] bdev: LBS devices support to coexist with
 buffer-heads
Message-ID: <ZQiOGA18+fpFd6ly@bombadil.infradead.org>
References: <20230915213254.2724586-1-mcgrof@kernel.org>
 <ZQd/7RYfDZgvR0n2@dread.disaster.area>
 <ZQeIaN2WC+whc/OP@casper.infradead.org>
 <ZQeg2+0X6yzGL1Mx@dread.disaster.area>
 <ZQekRLRXpoGu7VQ+@bombadil.infradead.org>
 <ZQe6wBxRFE7yY3eQ@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQe6wBxRFE7yY3eQ@dread.disaster.area>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 12:49:36PM +1000, Dave Chinner wrote:
> On Sun, Sep 17, 2023 at 06:13:40PM -0700, Luis Chamberlain wrote:
> > On Mon, Sep 18, 2023 at 10:59:07AM +1000, Dave Chinner wrote:
> > > On Mon, Sep 18, 2023 at 12:14:48AM +0100, Matthew Wilcox wrote:
> > > > On Mon, Sep 18, 2023 at 08:38:37AM +1000, Dave Chinner wrote:
> > > > > On Fri, Sep 15, 2023 at 02:32:44PM -0700, Luis Chamberlain wrote:
> > > > > > LBS devices. This in turn allows filesystems which support bs > 4k to be
> > > > > > enabled on a 4k PAGE_SIZE world on LBS block devices. This alows LBS
> > > > > > device then to take advantage of the recenlty posted work today to enable
> > > > > > LBS support for filesystems [0].
> > > > > 
> > > > > Why do we need LBS devices to support bs > ps in XFS?
> > > > 
> > > > It's the other way round -- we need the support in the page cache to
> > > > reject sub-block-size folios (which is in the other patches) before we
> > > > can sensibly talk about enabling any filesystems on top of LBS devices.
> > > >
> > > > Even XFS, or for that matter ext2 which support 16k block sizes on
> > > > CONFIG_PAGE_SIZE_16K (or 64K) kernels need that support first.
> > > 
> > > Well, yes, I know that. But the statement above implies that we
> > > can't use bs > ps filesytems without LBS support on 4kB PAGE_SIZE
> > > systems. If it's meant to mean the exact opposite, then it is
> > > extremely poorly worded....
> > 
> > Let's ignore the above statement of a second just to clarify the goal here.
> > The patches posted by Pankaj enable bs > ps even on 4k sector drives.
> 
> Yes. They also enable XFS to support bs > ps on devices up to 32kB
> sector sizes, too. All the sector size does is define the minimum
> filesystem block size that can be supported by the filesystem on
> that device and apart from that we just don't care what the sector
> size on the underlying device is.

Ah yes, but on a system with 4k page size, my point is that you still
can't use a 32k sector size drive.

> > This patch series by definition is suggesting that an LBS device is one
> > where the minimum sector size is > ps, in practice I'm talking about
> > devices where the logical block size is > 4k, or where the physical
> > block size can be > 4k.
> 
> Which XFS with bs > ps just doesn't care about. As long as the
> logical sector size is a power of 2 between 512 bytes and 32kB, it
> will just work.
> 
> > There are two situations in the NVMe world where
> > this can happen. One is where the LBA format used is > 4k, the other is
> > where the npwg & awupf | nawupf is > 4k. The first makes the logical
> 
> FWIW, I have no idea what these acronyms actually mean....

Sorry, I've described them them, here now:

https://kernelnewbies.org/KernelProjects/large-block-size#LBS_NVMe_support

What matters though is in practice it is a combination of two values
which today also allows the nvme driver to have a higher than 4k
physical block size.

> > block size > 4k, the later allows the physical block size to be > 4k.
> > The first *needs* an aops which groks > ps on the block device cache.
> > The second let's you remain backward compatible with 4k sector size, but
> > if you want to use a larger sector size you can too, but that also
> > requires a block device cache which groks > ps. When using > ps for
> > logical block size of physical block size is what I am suggesting we
> > should call LBS devices.
> 
> Sure. LBS means sector size > page size for the block device. That
> much has always been clear.
> 
> But telling me that again doesn't explain what LBS support has to do
> with the filesystem implementation. mkfs.xfs doesn't require LBS
> support to make a new XFS filesystem with a 32kB sector size and
> 64kB filessytem block size.  For the mounted filesystem that
> supports bs > ps, it also doesn't care about the device sector size
> is smaller than what mkfs told it to us. e.g. this is how run 4kB
> sector size filesystem testing on 512 byte sector devices today....
> 
> What I'm asking is why LBS support even mentions filesystems?

It's just that without this patchset you can mkfs an filesystem with
larger bs > ps, but will only be able to mount them if the sector size
matches the page size. This patchset allows them to be mounted and used
where sector size > ps. The main issue there is just the block device
cache aops and the current size limitaiton on set_blocksize().

> It's
> not necessary for filesystems to support bs > ps for LBS to be
> implemented, and it's not necessary for LBS to be supported for
> filesytsems to implement bs > ps. Conflating them seems a recipe
> for confusion....

I see, so we should just limit the scope to enabling LBS devices on
the block device cache?

> > > iomap supports bufferheads as a transitional thing (e.g. for gfs2).
> > 
> > But not for the block device cache.
> 
> That's why I'm suggesting that you implement support for bufferheads
> through the existing iomap infrastructure instead of trying to
> dynamically switch aops structures....
> 
> > > Hence I suspect that a better solution is to always use iomap and
> > > the same aops, but just switch from iomap page state to buffer heads
> > > in the bdev mapping 
> > 
> > Not sure this means, any chance I can trouble you to clarify a bit more?
> 
> bdev_use_buggerheads()
> {
> 	/*
> 	 * set the bufferhead bit atomically with invalidation emptying the
> 	 * page cache to prevent repopulation races. 
> 	 */
> 	filemap_invalidate_lock()
> 	invalidate_bdev()
> 	if (turn_on_bufferheads)
> 		set_bit(bdev->state, BDEV_USE_BUFFERHEADS);
> 	else
> 		clear_bit(bdev->state, BDEV_USE_BUFFERHEADS);
> 	filemap_invalidate_unlock()
> }
> 
> bdev_iomap_begin()
> {
> 	.....
> 	if (test_bit(bdev->state, BDEV_USE_BUFFERHEADS))
> 		iomap->flags |= IOMAP_F_BUFFER_HEAD;
> }
> 
> /*
>  * If an indexing switch happened while processing the iomap, make
>  * sure to get the iomap marked stale to force a new mapping to be
>  * looked up.
>  */
> bdev_iomap_valid()
> {
> 	bool need_bhs = iomap->flags & IOMAP_F_BUFFER_HEAD;
> 	bool use_bhs = test_bit(bdev->state, BDEV_USE_BUGGERHEADS);
> 
> 	return need_bhs == use_bhs;
> }

Will give this a shot, thanks!

  Luis
