Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9369F26D177
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 05:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgIQDJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 23:09:49 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:32918 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbgIQDJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 23:09:49 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E2FAB3AA31D;
        Thu, 17 Sep 2020 13:09:43 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kIkIo-00015p-TR; Thu, 17 Sep 2020 13:09:42 +1000
Date:   Thu, 17 Sep 2020 13:09:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Message-ID: <20200917030942.GU12096@dread.disaster.area>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
 <20200903163236.GA26043@lst.de>
 <20200907000432.GM12096@dread.disaster.area>
 <20200915214853.iurg43dt52h5z2gp@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915214853.iurg43dt52h5z2gp@fiona>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=XJ9OtjpE c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8
        a=n9nB9iI-1VlEs8jUNu4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 04:48:53PM -0500, Goldwyn Rodrigues wrote:
> On 10:04 07/09, Dave Chinner wrote:
> > On Thu, Sep 03, 2020 at 06:32:36PM +0200, Christoph Hellwig wrote:
> > > We could trivially do something like this to allow the file system
> > > to call iomap_dio_complete without i_rwsem:
> > 
> > That just exposes another deadlock vector:
> > 
> > P0			P1
> > inode_lock()		fallocate(FALLOC_FL_ZERO_RANGE)
> > __iomap_dio_rw()	inode_lock()
> > 			<block>
> > <submits IO>
> > <completes IO>
> > inode_unlock()
> > 			<gets inode_lock()>
> > 			inode_dio_wait()
> > iomap_dio_complete()
> >   generic_write_sync()
> >     btrfs_file_fsync()
> >       inode_lock()
> >       <deadlock>
> 
> Can inode_dio_end() be called before generic_write_sync(), as it is done
> in fs/direct-io.c:dio_complete()?

Don't think so.  inode_dio_wait() is supposed to indicate that all
DIO is complete, and having the "make it stable" parts of an O_DSYNC
DIO still running after inode_dio_wait() returns means that we still
have DIO running....

For some filesystems, ensuring the DIO data is stable may involve
flushing other data (perhaps we did EOF zeroing before the file
extending DIO) and/or metadata to the log, so we need to guarantee
these DIO related operations are complete and stable before we say
the DIO is done.

> Christoph's solution is a clean approach and would prefer to use it as
> the final solution.

/me shrugs

Christoph's solution simply means you can't use inode_dio_wait() in
the filesystem. btrfs would need its own DIO barrier....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
