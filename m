Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9C925AB06
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 14:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgIBMUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 08:20:18 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:58222 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgIBMUO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:20:14 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 8B55B823241;
        Wed,  2 Sep 2020 22:20:10 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kDRkG-0000eL-Db; Wed, 02 Sep 2020 22:20:08 +1000
Date:   Wed, 2 Sep 2020 22:20:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Message-ID: <20200902122008.GK12096@dread.disaster.area>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
 <20200901214613.GH12096@dread.disaster.area>
 <551b2801-d626-9bd7-7cb2-9d20674c06bf@toxicpanda.com>
 <20200901235830.GI12096@dread.disaster.area>
 <20200902114414.GX14765@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902114414.GX14765@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=IuRgj43g c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
        a=7-415B0cAAAA:8 a=LkxeRzu4S8V8-VZuuRUA:9 a=CjuIK1q_8ugA:10
        a=WzC6qhA0u3u7Ye7llzcV:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 02, 2020 at 12:44:14PM +0100, Matthew Wilcox wrote:
> On Wed, Sep 02, 2020 at 09:58:30AM +1000, Dave Chinner wrote:
> > Put simply: converting a filesystem to use iomap is not a "change
> > the filesystem interfacing code and it will work" modification.  We
> > ask that filesystems are modified to conform to the iomap IO
> > exclusion model; adding special cases for every potential
> > locking and mapping quirk every different filesystem has is part of
> > what turned the old direct IO code into an unmaintainable nightmare.
> > 
> > > That's fine, but this is kind of a bad way to find
> > > out.  We really shouldn't have generic helper's that have different generic
> > > locking rules based on which file system uses them.
> > 
> > We certainly can change the rules for new infrastructure. Indeed, we
> > had to change the rules to support DAX.  The whole point of the
> > iomap infrastructure was that it enabled us to use code that already
> > worked for DAX (the XFS code) in multiple filesystems. And as people
> > have realised that the DIO via iomap is much faster than the old DIO
> > code and is a much more efficient way of doing large buffered IO,
> > other filesystems have started to use it.
> > 
> > However....
> > 
> > > Because then we end up
> > > with situations like this, where suddenly we're having to come up with some
> > > weird solution because the generic thing only works for a subset of file
> > > systems.  Thanks,
> > 
> > .... we've always said "you need to change the filesystem code to
> > use iomap". This is simply a reflection on the fact that iomap has
> > different rules and constraints to the old code and so it's not a
> > direct plug in replacement. There are no short cuts here...
> 
> Can you point me (and I suspect Josef!) towards the documentation of the
> locking model?  I was hoping to find Documentation/filesystems/iomap.rst
> but all the 'iomap' strings in Documentation/ refer to pci_iomap and
> similar, except for this in the DAX documentation:

There's no locking model documentation because there is no locking
in the iomap direct IO code. The filesystem defines and does all the
locking, so there's pretty much nothing to document for iomap.

IOWs, the only thing iomap_dio_rw requires is that the IO completion
paths do not take same locks that the IO submission path
requires. And that's because:

/*
 * iomap_dio_rw() always completes O_[D]SYNC writes regardless of whether the IO
 * is being issued as AIO or not. [...]

So you obviously can't sit waiting for dio completion in
iomap_dio_rw() while holding the submission lock if completion
requires the submission lock to make progress.

FWIW, iomap_dio_rw() originally required the inode_lock() to be held
and contained a lockdep assert to verify this, but....

commit 3ad99bec6e82e32fa9faf2f84e74b134586b46f7
Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
Date:   Sat Nov 30 09:59:25 2019 -0600

    iomap: remove lockdep_assert_held()
    
    Filesystems such as btrfs can perform direct I/O without holding the
    inode->i_rwsem in some of the cases like writing within i_size.  So,
    remove the check for lockdep_assert_held() in iomap_dio_rw().
    
    Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
    Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
    Signed-off-by: David Sterba <dsterba@suse.com>

... btrfs has special corner cases for direct IO locking and hence
we removed the lockdep assert....

IOWs, iomap_dio_rw() really does not care what strategy filesystems
use to serialise DIO against other operations.  Filesystems can use
whatever IO serialisation mechanism they want (mutex, rwsem, range
locks, etc) as long as they obey the one simple requirement: do not
take the DIO submission lock in the DIO completion path.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
