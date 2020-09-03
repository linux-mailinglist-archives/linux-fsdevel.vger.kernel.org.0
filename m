Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5E425B8C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 04:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgICC2d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 22:28:33 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:36405 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbgICC2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:28:33 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 3CC143A72D4;
        Thu,  3 Sep 2020 12:28:23 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kDez8-0002kI-BU; Thu, 03 Sep 2020 12:28:22 +1000
Date:   Thu, 3 Sep 2020 12:28:22 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Message-ID: <20200903022822.GL12096@dread.disaster.area>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
 <20200901214613.GH12096@dread.disaster.area>
 <551b2801-d626-9bd7-7cb2-9d20674c06bf@toxicpanda.com>
 <20200901235830.GI12096@dread.disaster.area>
 <20200902114414.GX14765@casper.infradead.org>
 <20200902122008.GK12096@dread.disaster.area>
 <424119cd-08ca-8621-5e50-d52e0349a1f5@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424119cd-08ca-8621-5e50-d52e0349a1f5@toxicpanda.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=IuRgj43g c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
        a=7-415B0cAAAA:8 a=yIghhBYreof9tE_Kfs8A:9 a=CjuIK1q_8ugA:10
        a=WzC6qhA0u3u7Ye7llzcV:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 02, 2020 at 08:42:25AM -0400, Josef Bacik wrote:
> On 9/2/20 8:20 AM, Dave Chinner wrote:
> > On Wed, Sep 02, 2020 at 12:44:14PM +0100, Matthew Wilcox wrote:
> > > On Wed, Sep 02, 2020 at 09:58:30AM +1000, Dave Chinner wrote:
> > > > Put simply: converting a filesystem to use iomap is not a "change
> > > > the filesystem interfacing code and it will work" modification.  We
> > > > ask that filesystems are modified to conform to the iomap IO
> > > > exclusion model; adding special cases for every potential
> > > > locking and mapping quirk every different filesystem has is part of
> > > > what turned the old direct IO code into an unmaintainable nightmare.
> > > > 
> > > > > That's fine, but this is kind of a bad way to find
> > > > > out.  We really shouldn't have generic helper's that have different generic
> > > > > locking rules based on which file system uses them.
> > > > 
> > > > We certainly can change the rules for new infrastructure. Indeed, we
> > > > had to change the rules to support DAX.  The whole point of the
> > > > iomap infrastructure was that it enabled us to use code that already
> > > > worked for DAX (the XFS code) in multiple filesystems. And as people
> > > > have realised that the DIO via iomap is much faster than the old DIO
> > > > code and is a much more efficient way of doing large buffered IO,
> > > > other filesystems have started to use it.
> > > > 
> > > > However....
> > > > 
> > > > > Because then we end up
> > > > > with situations like this, where suddenly we're having to come up with some
> > > > > weird solution because the generic thing only works for a subset of file
> > > > > systems.  Thanks,
> > > > 
> > > > .... we've always said "you need to change the filesystem code to
> > > > use iomap". This is simply a reflection on the fact that iomap has
> > > > different rules and constraints to the old code and so it's not a
> > > > direct plug in replacement. There are no short cuts here...
> > > 
> > > Can you point me (and I suspect Josef!) towards the documentation of the
> > > locking model?  I was hoping to find Documentation/filesystems/iomap.rst
> > > but all the 'iomap' strings in Documentation/ refer to pci_iomap and
> > > similar, except for this in the DAX documentation:
> > 
> > There's no locking model documentation because there is no locking
> > in the iomap direct IO code. The filesystem defines and does all the
> > locking, so there's pretty much nothing to document for iomap.
> > 
> > IOWs, the only thing iomap_dio_rw requires is that the IO completion
> > paths do not take same locks that the IO submission path
> > requires. And that's because:
> > 
> > /*
> >   * iomap_dio_rw() always completes O_[D]SYNC writes regardless of whether the IO
> >   * is being issued as AIO or not. [...]
> > 
> > So you obviously can't sit waiting for dio completion in
> > iomap_dio_rw() while holding the submission lock if completion
> > requires the submission lock to make progress.
> > 
> > FWIW, iomap_dio_rw() originally required the inode_lock() to be held
> > and contained a lockdep assert to verify this, but....
> > 
> > commit 3ad99bec6e82e32fa9faf2f84e74b134586b46f7
> > Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Date:   Sat Nov 30 09:59:25 2019 -0600
> > 
> >      iomap: remove lockdep_assert_held()
> >      Filesystems such as btrfs can perform direct I/O without holding the
> >      inode->i_rwsem in some of the cases like writing within i_size.  So,
> >      remove the check for lockdep_assert_held() in iomap_dio_rw().
> >      Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> >      Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >      Signed-off-by: David Sterba <dsterba@suse.com>
> > 
> > ... btrfs has special corner cases for direct IO locking and hence
> > we removed the lockdep assert....
> > 
> > IOWs, iomap_dio_rw() really does not care what strategy filesystems
> > use to serialise DIO against other operations.  Filesystems can use
> > whatever IO serialisation mechanism they want (mutex, rwsem, range
> > locks, etc) as long as they obey the one simple requirement: do not
> > take the DIO submission lock in the DIO completion path.
> > 
> 
> Goldwyn has been working on these patches for a long time, and is actually
> familiar with this code, and he missed that these two interfaces are being
> mixed.  This is a problem that I want to solve.  He didn't notice it in any
> of his testing, which IIRC was like 6 months to get this stuff actually into
> the btrfs tree.

And that "been working on it for 6 months" is what really worries me
the most. Hence I've done some post-mortem analysis of the
"inode_lock" deadlock situation. I decided to do this after I
realised this same patch set was merged last cycle and reverted late in
the cycle because of problems it was found to have with page
invalidation when mixed IO types were used.

I did a bit of looking around yesterday afternoon, both in the btrfs
code to understand the iomap_dio_rw changes and at our test
coverage for DIO functionality.

The more I dug, the more I'm finding that the most important
question we need to answer is not "why wasn't this iomap locking
requirement documented", the question we should be trying to answer
is this:

	Why wasn't this *obvious* deadlock detected months ago?

First of all, the inode-lock() complaints are largely a red herring
as the typical btrfs DIO write path through the patchset does not
take the inode lock and hence it is actually "safe" to take the
inode lock in the completion path in the common case. i.e. for DIO
writes wholly inside EOF, submission drops the inode_lock() before
calling iomap_dio_rw() and so there is no inode_lock() deadlock
present. From that view point, it looks like there's only a specific
corner case where this deadlock might occur and that would explain
why it hasn't been discovered until now.

However.

The new btrfs dio write path always does
down_read(BTRFS_I()->dio_sem), even when the inode lock has not been
taken.  That's important because btrfs_sync_file() always does a
down_write(&BTRFS_I(inode)->dio_sem) call and will deadlock iin IO
completion if the IO submission code is holding the dio_sem.

So regardless of the inode_lock(), non-AIO O_DSYNC DIO writes
through iomap_dio_rw() should deadlock immediately on the first IO
with this locking arrangement. It will deadlock on either the
inode_lock or the dio_sem, depending on whether the ODSYNC DIO write
is wholly within EOF or not, but the deadlock is guaranteed to
occur. Hence we can completely ignore the "inode_lock vs fsync" side
show, because other btrfs internal locks will trigger the same
issue.

If this is correct, then how did this "should happen instantly"
bug go undiscovered for months?

Well....  It appears that fstests has no coverage of non-AIO
O_DSYNC DIO writes.  Tools like fsx and fstress don't have O_SYNC,
O_DSYNC or RWF_DSYNC modes and O_SYNC and O_DSYNC is not used by any
of the common DIO test programs. xfs_io can open files O_SYNC and
there's a test that uses xfs_io's RWF_DSYNC capability, but they all
use buffered IO and so none of tests that open or write data
synchronously use direct IO.

The only conclusion I can make from thsi is that the case that
should deadlock instantly isn't actually covered by fstests at all.
This conclusion only stands up this O_DSYNC code path was only
"tested" for feature coverage with fstests. However, it does imply
that no pre-implementation audit was done to determine if fstests
actually covered all the functionality that needed to be tested
here....

I tend to use xfs_io and fio for DIO feature correctness testing
long before I run fstests on new code.  That's how I developed and
tested the FUA optimisations - xfs_io and fio w/ RWF_DSYNC on XFS on
iscsi - so I've never noticed that fstests doesn't actually exercise
this syscall path directly.

Granted, the problem was eventually discovered by fstests, but this
also raised questions. The failing test was an AIO+DIO O_DSYNC test,
but the trigger has been described as a "unusual event on a rarely
tested configuration".

That "unusual event" was an DIO completion being run from submission
context because the IO completed before the submission had been
finish. This is not actually unusual - it's how all AIO on
synchronous IO devices complete. i.e. if you have a ram device or a
(fake) pmem device, every single AIO will complete in this way as
the "IO reference" held by submit_bio() is completed inside
submit_bio() before it returns to the submission context. Hence the
submission context always drops the last IO reference and completes
the IO.

Therefore running fstests on a ramdisk or (fake) pmem would have
triggered this deadlock *instantly* on the first O_DSYNC AIO+DIO
write that fstests issued. This implies that btrfs is rarely tested
on fast synchronous storage devices despite ramdisks being available
on every test machine that can run fstests. To provide a contrast,
the iomap infrastructure is regularly tested on such devices - both
Darrick and I have both have (fake) pmem test setups and exercise
synchronous completion code paths like this on a daily basis.

Hence it looks to me like the answer to the "why wasn't this found
earlier" question is a combination of multiple factors:

1. fstests has no specific non-AIO O_DSYNC DIO write unit tests, nor
do the stress tests allow use O_DSYNC or RWF_DSYNC.

2. No test coverage audit was performed prior to making a critical
change to the btrfs IO path so this specific lack of coverage was
not noticed until now.

3. after the first revert of this functionality, post-mortem
analysis either wasn't performed or didn't identify process and/or
test coverage issues that allowed serious issues in the patch set to
go undiscovered.

4. tools and benchmarks that could have easily discovered the
problem either weren't run or they weren't configured to test
and exercise all the IO path features the change affected.

5. btrfs is not regularly tested on a variety of storage that have
distinctly different IO path behaviours.

> If we're going to mix interfaces then it should be
> blatantly obvious to developers that's what's happening so the find out
> during development, not after the patches have landed, and certainly not
> after they've made it out to users.  Thanks,

As the above indicates, this issue _should_ have been blatantly
obvious months ago and documentation would not change this fact.
IOWs, even if the iomap requirement was documented and followed, a
locking bug in the btrfs implementation would still not have been
discovered until now because that's how long it took to actually
exercise the buggy code path and expose it.

So, yeah, the lack of documentation contributed to the bug being
present. But taking 6 months to actually exercise the new code
containing the bug is most definitely not an interface documentation
problem, nor a problem that can be fixed by correcting the interface
documentation....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
