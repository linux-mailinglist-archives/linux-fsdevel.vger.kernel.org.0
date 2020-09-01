Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD225A0F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 23:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgIAVqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 17:46:22 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:52904 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728802AbgIAVqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 17:46:21 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5F95F3A799A;
        Wed,  2 Sep 2020 07:46:14 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kDE6X-000764-Di; Wed, 02 Sep 2020 07:46:13 +1000
Date:   Wed, 2 Sep 2020 07:46:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Message-ID: <20200901214613.GH12096@dread.disaster.area>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=KcmsTjQD c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=dfLDlhdaAAAA:20 a=JF9118EUAAAA:8
        a=7-415B0cAAAA:8 a=NuZTmmcrA1hiN3Fiid0A:9 a=9yNkSyI0EFhAQx5I:21
        a=ZhL9NWcy351N7sOO:21 a=CjuIK1q_8ugA:10 a=xVlTc564ipvMDusKsbsT:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 01, 2020 at 11:11:58AM -0400, Josef Bacik wrote:
> On 9/1/20 9:06 AM, Johannes Thumshirn wrote:
> > This happens because iomap_dio_complete() calls into generic_write_sync()
> > if we have the data-sync flag set. But as we're still under the
> > inode_lock() from btrfs_file_write_iter() we will deadlock once
> > btrfs_sync_file() tries to acquire the inode_lock().
> > 
> > Calling into generic_write_sync() is not needed as __btrfs_direct_write()
> > already takes care of persisting the data on disk. We can temporarily drop
> > the IOCB_DSYNC flag before calling into __btrfs_direct_write() so the
> > iomap code won't try to call into the sync routines as well.
> > 
> > References: https://github.com/btrfs/fstests/issues/12
> > Fixes: da4d7c1b4c45 ("btrfs: switch to iomap for direct IO")
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >   fs/btrfs/file.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index b62679382799..c75c0f2a5f72 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -2023,6 +2023,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
> >   		atomic_inc(&BTRFS_I(inode)->sync_writers);
> >   	if (iocb->ki_flags & IOCB_DIRECT) {
> > +		iocb->ki_flags &= ~IOCB_DSYNC;
> >   		num_written = __btrfs_direct_write(iocb, from);
> >   	} else {
> >   		num_written = btrfs_buffered_write(iocb, from);
> > @@ -2046,8 +2047,10 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
> >   	if (num_written > 0)
> >   		num_written = generic_write_sync(iocb, num_written);
> > -	if (sync)
> > +	if (sync) {
> > +		iocb->ki_flags |= IOCB_DSYNC;
> >   		atomic_dec(&BTRFS_I(inode)->sync_writers);
> > +	}
> >   out:
> >   	current->backing_dev_info = NULL;
> >   	return num_written ? num_written : err;
> > 
> 
> Christoph, I feel like this is broken.

No, it isn't broken, it's just a -different design- to the old
direct IO path. It was done this way done by design because the old
way of requiring separate paths for calling generic_write_sync() for
sync and AIO is ....  nasty, and doesn't allow for optimisation of
IO completion functionality that may be wholly dependent on
submission time inode state.

e.g. moving the O_DSYNC completion out of the context of the
IOMAP_F_DIRTY submission context means we can't reliably do FUA
writes to avoid calls to generic_write_sync() completely.
Compromising that functionality is going to cause major performance
regressions for high performance enterprise databases using O_DSYNC
AIO+DIO...

> Xfs and ext4 get away with this for
> different reasons,

No, they "don't get away with it", this is how it was designed to
work.

> ext4 doesn't take the inode_lock() at all in fsync, and
> xfs takes the ILOCK instead of the IOLOCK, so it's fine.  However btrfs uses
> inode_lock() in ->fsync (not for the IO, just for the logging part).  A long
> time ago I specifically pushed the inode locking down into ->fsync()
> handlers to give us this sort of control.
> 
> I'm not 100% on the iomap stuff, but the fix seems like we need to move the
> generic_write_sync() out of iomap_dio_complete() completely, and the callers
> do their own thing, much like the normal generic_file_write_iter() does.

That effectively breaks O_DSYNC AIO and requires us to reintroduce
all the nasty code that the old direct IO path required both the
infrastructure and the filesystems to handle it. That's really not
acceptible solution to an internal btrfs locking issue...

> And then I'd like to add a WARN_ON(lockdep_is_held()) in vfs_fsync_range()
> so we can avoid this sort of thing in the future.  What do you think?

That's not going to work, either. There are filesystems that call
vfs_fsync_range() directly from under the inode_lock(). For example,
the fallocate() path in gfs2. And it's called under the ext4 and XFS
MMAPLOCK from the dax page fault path, which is the page fault
equivalent of the inode_lock(). IOWs, if you know that you aren't
going to take inode locks in your ->fsync() method, there's nothing
that says you cannot call vfs_fsync_range() while holding those
inode locks.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
