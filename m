Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2D01ED7CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 23:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgFCVHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 17:07:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:45438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgFCVHZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:07:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 24997AD4D;
        Wed,  3 Jun 2020 21:07:27 +0000 (UTC)
Date:   Wed, 3 Jun 2020 16:07:20 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Filipe Manana <fdmanana@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz
Subject: Re: [PATCH] iomap: Return zero in case of unsuccessful pagecache
 invalidation before DIO
Message-ID: <20200603210720.6d6jlaozyibnhdbl@fiona>
References: <20200528192103.xm45qoxqmkw7i5yl@fiona>
 <20200529002319.GQ252930@magnolia>
 <20200601151614.pxy7in4jrvuuy7nx@fiona>
 <CAL3q7H60xa0qW4XdneDdeQyNcJZx7DxtwDiYkuWB5NoUVPYdwQ@mail.gmail.com>
 <CAL3q7H4=N2pfnBSiJ+TApy9kwvcPE5sB92sxcVZN10bxZqQpaA@mail.gmail.com>
 <20200603190252.GG8204@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603190252.GG8204@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12:02 03/06, Darrick J. Wong wrote:
> On Wed, Jun 03, 2020 at 12:32:15PM +0100, Filipe Manana wrote:
> > On Wed, Jun 3, 2020 at 12:23 PM Filipe Manana <fdmanana@gmail.com> wrote:
> > >
> > > On Mon, Jun 1, 2020 at 4:16 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> > > >
> > > > On 17:23 28/05, Darrick J. Wong wrote:
> > > > > On Thu, May 28, 2020 at 02:21:03PM -0500, Goldwyn Rodrigues wrote:
> > > > > >
> > > > > > Filesystems such as btrfs are unable to guarantee page invalidation
> > > > > > because pages could be locked as a part of the extent. Return zero
> > > > >
> > > > > Locked for what?  filemap_write_and_wait_range should have just cleaned
> > > > > them off.
> > > > >
> > > > > > in case a page cache invalidation is unsuccessful so filesystems can
> > > > > > fallback to buffered I/O. This is similar to
> > > > > > generic_file_direct_write().
> > > > > >
> > > > > > This takes care of the following invalidation warning during btrfs
> > > > > > mixed buffered and direct I/O using iomap_dio_rw():
> > > > > >
> > > > > > Page cache invalidation failure on direct I/O.  Possible data
> > > > > > corruption due to collision with buffered I/O!
> > > > > >
> > > > > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > > > >
> > > > > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > > > > index e4addfc58107..215315be6233 100644
> > > > > > --- a/fs/iomap/direct-io.c
> > > > > > +++ b/fs/iomap/direct-io.c
> > > > > > @@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > > > > >      */
> > > > > >     ret = invalidate_inode_pages2_range(mapping,
> > > > > >                     pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > > > > > -   if (ret)
> > > > > > -           dio_warn_stale_pagecache(iocb->ki_filp);
> > > > > > -   ret = 0;
> > > > > > +   /*
> > > > > > +    * If a page can not be invalidated, return 0 to fall back
> > > > > > +    * to buffered write.
> > > > > > +    */
> > > > > > +   if (ret) {
> > > > > > +           if (ret == -EBUSY)
> > > > > > +                   ret = 0;
> > > > > > +           goto out_free_dio;
> > > > >
> > > > > XFS doesn't fall back to buffered io when directio fails, which means
> > > > > this will cause a regression there.
> > > > >
> > > > > Granted mixing write types is bogus...
> > > > >
> > > >
> > > > I have not seen page invalidation failure errors on XFS, but what should
> 
> What happens if you try to dirty an mmap page at the same time as
> issuing a directio?

I did not think of that scenario. But in this case, is mmap working on
stale data? and is it considered a writeback error?

> 
> > > > happen hypothetically if they do occur? Carry on with the direct I/O?
> > > > Would an error return like -ENOTBLK be better?
> 
> In the old days, we would only WARN when we encountered collisions like
> this.  How about only setting EIO in the mapping if we fail the
> pagecache invalidation in directio completion?  If a buffered write
> dirties the page after the direct write thread flushes the dirty pages
> but before invalidation, we can argue that we didn't lose anything; the
> direct write simply happened after the buffered write.

This error will finally be returned by iomap_dio_rw(), and EIO would
mean there is a device error, and not a transient error from which it
can recover. We could return -ENOTBLK, but that is used temporarily for
buffered write fallbacks such as in ext4. iomap still returns zero in
case of such transient errors.

> 
> XFS doesn't implement buffered write fallback, and it never has.  Either
> the entire directio succeeds, or it returns a negative error code.  Some
> of the iomap_dio_rw callers (ext4, jfs2) will notice a short direct
> write and try to finish the rest with buffered io, but xfs and zonefs do
> not.
> 
> The net effect of this (on xfs anyway) is that when buffered and direct
> writes collide, before we'd make the buffered writer lose, now we make
> the direct writer lose.
> 
> You also /could/ propose teaching xfs how to fall back to an
> invalidating synchronous buffered write like ext4 does, but that's not
> part of this patch set, and that's not a behavior I want to introduce
> suddenly during the merge window.

So does that mean XFS would be open to fallback to buffered write?
That would make things much simpler!

-- 
Goldwyn
