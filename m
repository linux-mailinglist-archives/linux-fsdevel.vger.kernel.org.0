Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63816A0D9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 00:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfH1WcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 18:32:24 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54966 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726658AbfH1WcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:32:24 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 98ED4361338;
        Thu, 29 Aug 2019 08:32:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i36UE-00057N-WE; Thu, 29 Aug 2019 08:32:19 +1000
Date:   Thu, 29 Aug 2019 08:32:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 4/5] ext4: introduce direct IO write code path using
 iomap infrastructure
Message-ID: <20190828223218.GZ7777@dread.disaster.area>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
 <20190828202619.GG22343@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828202619.GG22343@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=4ERQYXhnAAAA:8 a=7-415B0cAAAA:8 a=YRs46oH6ve-dZsFn3eoA:9
        a=CjuIK1q_8ugA:10 a=HrUHXJcpxbsINVJ6ux1W:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:26:19PM +0200, Jan Kara wrote:
> On Mon 12-08-19 22:53:26, Matthew Bobrowski wrote:
> > This patch introduces a new direct IO write code path implementation
> > that makes use of the iomap infrastructure.
> > 
> > All direct IO write operations are now passed from the ->write_iter() callback
> > to the new function ext4_dio_write_iter(). This function is responsible for
> > calling into iomap infrastructure via iomap_dio_rw(). Snippets of the direct
> > IO code from within ext4_file_write_iter(), such as checking whether the IO
> > request is unaligned asynchronous IO, or whether it will ber overwriting
> > allocated and initialized blocks has been moved out and into
> > ext4_dio_write_iter().
> > 
> > The block mapping flags that are passed to ext4_map_blocks() from within
> > ext4_dio_get_block() and friends have effectively been taken out and
> > introduced within the ext4_iomap_begin(). If ext4_map_blocks() happens to have
> > instantiated blocks beyond the i_size, then we attempt to place the inode onto
> > the orphan list. Despite being able to perform i_size extension checking
> > earlier on in the direct IO code path, it makes most sense to perform this bit
> > post successful block allocation.
> > 
> > The ->end_io() callback ext4_dio_write_end_io() is responsible for removing
> > the inode from the orphan list and determining if we should truncate a failed
> > write in the case of an error. We also convert a range of unwritten extents to
> > written if IOMAP_DIO_UNWRITTEN is set and perform the necessary
> > i_size/i_disksize extension if the iocb->ki_pos + dio->size > i_size_read(inode).
> > 
> > In the instance of a short write, we fallback to buffered IO and complete
> > whatever is left the 'iter'. Any blocks that may have been allocated in
> > preparation for direct IO will be reused by buffered IO, so there's no issue
> > with leaving allocated blocks beyond EOF.
> > 
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> > ---
> >  fs/ext4/file.c  | 227 ++++++++++++++++++++++++++++++++++++++++----------------
> >  fs/ext4/inode.c |  42 +++++++++--
> >  2 files changed, 199 insertions(+), 70 deletions(-)
> 
> Overall this is very nice. Some smaller comments below.
> 
> > @@ -235,6 +244,34 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
> >  	return iov_iter_count(from);
> >  }
> >  
> > +static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
> > +					struct iov_iter *from)
> > +{
> > +	ssize_t ret;
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +
> > +	if (!inode_trylock(inode)) {
> > +		if (iocb->ki_flags & IOCB_NOWAIT)
> > +			return -EOPNOTSUPP;
> > +		inode_lock(inode);
> > +	}
> 
> Currently there's no support for IOCB_NOWAIT for buffered IO so you can
> replace this with "inode_lock(inode)".

IOCB_NOWAIT is supported for buffered reads. It is not supported on
buffered writes (as yet), so this should return EOPNOTSUPP if
IOCB_NOWAIT is set, regardless of whether the lock can be grabbed or
not.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
