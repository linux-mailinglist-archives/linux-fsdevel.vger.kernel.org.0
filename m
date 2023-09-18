Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B8C7A3F1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 03:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjIRBON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 21:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbjIRBOG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 21:14:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55456126;
        Sun, 17 Sep 2023 18:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XK0rNY3L3g5m3pHwfAdXwzlHodkwWeulG1oKxkLyNLc=; b=VvG7rsG5IWMH9lVEbAl69McmDN
        wuJ3FQe07L6e06w5sQJtZqNf6Zs6t+mPxkHO8HflIPk6eMCSN37YYmfbGDFx7LCGHXWEqQ37kYk2Y
        FJ00uqcQLsL6lPtKMKnwfh/8HuiJ9z1Czj6NR/4mEu4kERyrUXljMerapyfEYr/Xj05Di7SxX422t
        wMu/sOFt/POlDP2L0lzwEJFLLLz1gb5EQ38IWCpkt4jIIEEAXZdElhapn3x6VpYRupz7wpKbx/m7G
        snlAh/LWByKF0G4Dbf/PEKh/5Euy/+XheB0RDP7QLJxSO3O2dfGpI2atgIIr85MAMfBG3IGroq2hd
        +T4f480g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qi2pY-00EBos-3D;
        Mon, 18 Sep 2023 01:13:41 +0000
Date:   Sun, 17 Sep 2023 18:13:40 -0700
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
Message-ID: <ZQekRLRXpoGu7VQ+@bombadil.infradead.org>
References: <20230915213254.2724586-1-mcgrof@kernel.org>
 <ZQd/7RYfDZgvR0n2@dread.disaster.area>
 <ZQeIaN2WC+whc/OP@casper.infradead.org>
 <ZQeg2+0X6yzGL1Mx@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQeg2+0X6yzGL1Mx@dread.disaster.area>
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

On Mon, Sep 18, 2023 at 10:59:07AM +1000, Dave Chinner wrote:
> On Mon, Sep 18, 2023 at 12:14:48AM +0100, Matthew Wilcox wrote:
> > On Mon, Sep 18, 2023 at 08:38:37AM +1000, Dave Chinner wrote:
> > > On Fri, Sep 15, 2023 at 02:32:44PM -0700, Luis Chamberlain wrote:
> > > > LBS devices. This in turn allows filesystems which support bs > 4k to be
> > > > enabled on a 4k PAGE_SIZE world on LBS block devices. This alows LBS
> > > > device then to take advantage of the recenlty posted work today to enable
> > > > LBS support for filesystems [0].
> > > 
> > > Why do we need LBS devices to support bs > ps in XFS?
> > 
> > It's the other way round -- we need the support in the page cache to
> > reject sub-block-size folios (which is in the other patches) before we
> > can sensibly talk about enabling any filesystems on top of LBS devices.
> >
> > Even XFS, or for that matter ext2 which support 16k block sizes on
> > CONFIG_PAGE_SIZE_16K (or 64K) kernels need that support first.
> 
> Well, yes, I know that. But the statement above implies that we
> can't use bs > ps filesytems without LBS support on 4kB PAGE_SIZE
> systems. If it's meant to mean the exact opposite, then it is
> extremely poorly worded....

Let's ignore the above statement of a second just to clarify the goal here.
The patches posted by Pankaj enable bs > ps even on 4k sector drives.

This patch series by definition is suggesting that an LBS device is one
where the minimum sector size is > ps, in practice I'm talking about
devices where the logical block size is > 4k, or where the physical
block size can be > 4k. There are two situations in the NVMe world where
this can happen. One is where the LBA format used is > 4k, the other is
where the npwg & awupf | nawupf is > 4k. The first makes the logical
block size > 4k, the later allows the physical block size to be > 4k.
The first *needs* an aops which groks > ps on the block device cache.
The second let's you remain backward compatible with 4k sector size, but
if you want to use a larger sector size you can too, but that also
requires a block device cache which groks > ps. When using > ps for
logical block size of physical block size is what I am suggesting we
should call LBS devices.

I'm happy for us to use other names but it just seemed like a natural
preogression to me.

> > > > There might be a better way to do this than do deal with the switching
> > > > of the aops dynamically, ideas welcomed!
> > > 
> > > Is it even safe to switch aops dynamically? We know there are
> > > inherent race conditions in doing this w.r.t. mmap and page faults,
> > > as the write fault part of the processing is directly dependent
> > > on the page being correctly initialised during the initial
> > > population of the page data (the "read fault" side of the write
> > > fault).
> > > 
> > > Hence it's not generally considered safe to change aops from one
> > > mechanism to another dynamically. Block devices can be mmap()d, but
> > > I don't see anything in this patch set that ensures there are no
> > > other users of the block device when the swaps are done. What am I
> > > missing?
> > 
> > We need to evict all pages from the page cache before switching aops to
> > prevent misinterpretation of folio->private. 
> 
> Yes, but if the device is mapped, even after an invalidation, we can
> still race with a new fault instantiating a page whilst the aops are
> being swapped, right? That was the problem that sunk dynamic
> swapping of the aops when turning DAX on and off on an inode, right?

I was not aware of that, thanks!

> > If switching aops is even
> > the right thing to do.  I don't see the problem with allowing buffer heads
> > on block devices, but I haven't been involved with the discussion here.
> 
> iomap supports bufferheads as a transitional thing (e.g. for gfs2).

But not for the block device cache.

> Hence I suspect that a better solution is to always use iomap and
> the same aops, but just switch from iomap page state to buffer heads
> in the bdev mapping 

Not sure this means, any chance I can trouble you to clarify a bit more?

> interface via a synchronised invalidation +
> setting/clearing IOMAP_F_BUFFER_HEAD in all new mapping requests...

I'm happy we use whatever makes more sense and is safer, just keep in
mind that we can't default to the iomap aops otherwise buffer-head
based filesystems won't work. I tried that. The first aops which the
block device cache needs if we want co-existence is buffer-heads.

If buffer-heads get large folio support then this is a non-issue as
far as I can tell but only because XFS does not use buffer-heads for
meta data. Once and when we do have a filesystem which does use
buffer-heads for metadata to support LBS it could be a problem I think.

  Luis
