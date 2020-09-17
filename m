Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBFF26D3A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 08:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIQG33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 02:29:29 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:44282 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbgIQG33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:29:29 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 8147182725F;
        Thu, 17 Sep 2020 16:29:24 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kInQ3-0001f2-DB; Thu, 17 Sep 2020 16:29:23 +1000
Date:   Thu, 17 Sep 2020 16:29:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Message-ID: <20200917062923.GV12096@dread.disaster.area>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
 <20200903163236.GA26043@lst.de>
 <20200907000432.GM12096@dread.disaster.area>
 <20200915214853.iurg43dt52h5z2gp@fiona>
 <20200917030942.GU12096@dread.disaster.area>
 <20200917055232.GA31646@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917055232.GA31646@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=XJ9OtjpE c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8
        a=rjxYxGGUp2qB-56pKk8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 07:52:32AM +0200, Christoph Hellwig wrote:
> On Thu, Sep 17, 2020 at 01:09:42PM +1000, Dave Chinner wrote:
> > > > iomap_dio_complete()
> > > >   generic_write_sync()
> > > >     btrfs_file_fsync()
> > > >       inode_lock()
> > > >       <deadlock>
> > > 
> > > Can inode_dio_end() be called before generic_write_sync(), as it is done
> > > in fs/direct-io.c:dio_complete()?
> > 
> > Don't think so.  inode_dio_wait() is supposed to indicate that all
> > DIO is complete, and having the "make it stable" parts of an O_DSYNC
> > DIO still running after inode_dio_wait() returns means that we still
> > have DIO running....
> > 
> > For some filesystems, ensuring the DIO data is stable may involve
> > flushing other data (perhaps we did EOF zeroing before the file
> > extending DIO) and/or metadata to the log, so we need to guarantee
> > these DIO related operations are complete and stable before we say
> > the DIO is done.
> 
> inode_dio_wait really just waits for active I/O that writes to or reads
> from the file.  It does not imply that the I/O is stable, just like
> i_rwsem itself doesn't.

No, but iomap_dio_rw() considers a O_DSYNC write to be incomplete
until it is stable so that it presents consistent behaviour to
anythign calling inode_dio_wait().

> Various file systems have historically called
> the syncing outside i_rwsem and inode_dio_wait (in fact that is what the
> fs/direct-io.c code does, so XFS did as well until a few years ago), and
> that isn't a problem at all - we just can't return to userspace (or call
> ki_complete for in-kernel users) before the data is stable on disk.

I'm really not caring about userspace here - we use inode_dio_wait()
as an IO completion notification for the purposes of synchronising
internal filesystem state before modifying user data via direct
metadata manipulation. Hence I want sane, consistent, predictable IO
completion notification behaviour regardless of the implementation
path it goes through.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
