Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADEF274B85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 23:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIVVtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 17:49:43 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:37404 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgIVVtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:49:42 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 17ECE3A8668;
        Wed, 23 Sep 2020 07:49:35 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kKqAJ-0003rH-01; Wed, 23 Sep 2020 07:49:35 +1000
Date:   Wed, 23 Sep 2020 07:49:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, johannes.thumshirn@wdc.com, dsterba@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/15] iomap: Call inode_dio_end() before
 generic_write_sync()
Message-ID: <20200922214934.GC12096@dread.disaster.area>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-5-rgoldwyn@suse.de>
 <20bf949a-7237-8409-4230-cddb430026a9@toxicpanda.com>
 <20200922163156.GD7949@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922163156.GD7949@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=iox4zFpeAAAA:8 a=7-415B0cAAAA:8
        a=qVYXC0LHI1IRUiICw7YA:9 a=IORDTW5l82JP8UU_:21 a=SW7t0_conF5gZlKb:21
        a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:31:56AM -0700, Darrick J. Wong wrote:
> On Tue, Sep 22, 2020 at 10:20:11AM -0400, Josef Bacik wrote:
> > On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> > > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > 
> > > iomap complete routine can deadlock with btrfs_fallocate because of the
> > > call to generic_write_sync().
> > > 
> > > P0                      P1
> > > inode_lock()            fallocate(FALLOC_FL_ZERO_RANGE)
> > > __iomap_dio_rw()        inode_lock()
> > >                          <block>
> > > <submits IO>
> > > <completes IO>
> > > inode_unlock()
> > >                          <gets inode_lock()>
> > >                          inode_dio_wait()
> > > iomap_dio_complete()
> > >    generic_write_sync()
> > >      btrfs_file_fsync()
> > >        inode_lock()
> > >        <deadlock>
> > > 
> > > inode_dio_end() is used to notify the end of DIO data in order
> > > to synchronize with truncate. Call inode_dio_end() before calling
> > > generic_write_sync(), so filesystems can lock i_rwsem during a sync.
> > > 
> > > ---
> > >   fs/iomap/direct-io.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index d970c6bbbe11..e01f81e7b76f 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -118,6 +118,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
> > >   			dio_warn_stale_pagecache(iocb->ki_filp);
> > >   	}
> > > +	inode_dio_end(file_inode(iocb->ki_filp));
> > >   	/*
> > >   	 * If this is a DSYNC write, make sure we push it to stable storage now
> > >   	 * that we've written data.
> > > @@ -125,7 +126,6 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
> > >   	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
> > >   		ret = generic_write_sync(iocb, ret);
> > > -	inode_dio_end(file_inode(iocb->ki_filp));
> > >   	kfree(dio);
> > >   	return ret;
> > > 
> > 
> > Did you verify that xfs or ext4 don't rely on the inode_dio_end() happening
> > before the generic_write_sync()?  I wouldn't expect that they would, but
> > we've already run into problems making those kind of assumptions.  If it's
> > fine you can add
> 
> I was gonna ask the same question, but as there's no SoB on this patch I
> hadn't really looked at it yet. ;)
> 
> Operations that rely on inode_dio_wait to have blocked until all the
> directios are complete could get tripped up by iomap not having done the
> generic_write_sync to stabilise the metadata, but I /think/ most
> operations that do that also themselves flush the file.  But I don't
> really know if there's a subtlety there if the inode_dio_wait thread
> manages to grab the ILOCK before the generic_write_sync thread does.

I did point out in the previous thread that this actually means that
inode_dio_wait() now has inconsistent wait semantics for O_DSYNC
writes. If it's a pure overwrite and we hit the FUA path, the
O_DSYNC write will be complete and guaranteed to be on stable storage
before the IO completes. If the inode is metadata dirty, then the IO
will now be signalled complete *before* the data and metadata are
flushed to stable storage.

Hence, from the perspective of writes to *stable* storage, this
makes the ordering of O_DSYNC DIO against anything waiting for it to
complete to be potentially inconsistent at the stable storage level.

That's an extremely subtle change of behaviour, and something that
would be largely impossible to test or reproduce. And, really, I
don't like having this sort of "oh, it should be fine" handwavy
justification when we are talking about data integrity operations...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
