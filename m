Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA1CA1335
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 10:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfH2IDL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 04:03:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:52818 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbfH2IDL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:03:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4BED4AC8E;
        Thu, 29 Aug 2019 08:03:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B65901E4362; Thu, 29 Aug 2019 10:03:08 +0200 (CEST)
Date:   Thu, 29 Aug 2019 10:03:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 4/5] ext4: introduce direct IO write code path using
 iomap infrastructure
Message-ID: <20190829080308.GA19156@quack2.suse.cz>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
 <20190828202619.GG22343@quack2.suse.cz>
 <20190828223218.GZ7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828223218.GZ7777@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-08-19 08:32:18, Dave Chinner wrote:
> On Wed, Aug 28, 2019 at 10:26:19PM +0200, Jan Kara wrote:
> > On Mon 12-08-19 22:53:26, Matthew Bobrowski wrote:
> > > This patch introduces a new direct IO write code path implementation
> > > that makes use of the iomap infrastructure.
> > > 
> > > All direct IO write operations are now passed from the ->write_iter() callback
> > > to the new function ext4_dio_write_iter(). This function is responsible for
> > > calling into iomap infrastructure via iomap_dio_rw(). Snippets of the direct
> > > IO code from within ext4_file_write_iter(), such as checking whether the IO
> > > request is unaligned asynchronous IO, or whether it will ber overwriting
> > > allocated and initialized blocks has been moved out and into
> > > ext4_dio_write_iter().
> > > 
> > > The block mapping flags that are passed to ext4_map_blocks() from within
> > > ext4_dio_get_block() and friends have effectively been taken out and
> > > introduced within the ext4_iomap_begin(). If ext4_map_blocks() happens to have
> > > instantiated blocks beyond the i_size, then we attempt to place the inode onto
> > > the orphan list. Despite being able to perform i_size extension checking
> > > earlier on in the direct IO code path, it makes most sense to perform this bit
> > > post successful block allocation.
> > > 
> > > The ->end_io() callback ext4_dio_write_end_io() is responsible for removing
> > > the inode from the orphan list and determining if we should truncate a failed
> > > write in the case of an error. We also convert a range of unwritten extents to
> > > written if IOMAP_DIO_UNWRITTEN is set and perform the necessary
> > > i_size/i_disksize extension if the iocb->ki_pos + dio->size > i_size_read(inode).
> > > 
> > > In the instance of a short write, we fallback to buffered IO and complete
> > > whatever is left the 'iter'. Any blocks that may have been allocated in
> > > preparation for direct IO will be reused by buffered IO, so there's no issue
> > > with leaving allocated blocks beyond EOF.
> > > 
> > > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> > > ---
> > >  fs/ext4/file.c  | 227 ++++++++++++++++++++++++++++++++++++++++----------------
> > >  fs/ext4/inode.c |  42 +++++++++--
> > >  2 files changed, 199 insertions(+), 70 deletions(-)
> > 
> > Overall this is very nice. Some smaller comments below.
> > 
> > > @@ -235,6 +244,34 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
> > >  	return iov_iter_count(from);
> > >  }
> > >  
> > > +static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
> > > +					struct iov_iter *from)
> > > +{
> > > +	ssize_t ret;
> > > +	struct inode *inode = file_inode(iocb->ki_filp);
> > > +
> > > +	if (!inode_trylock(inode)) {
> > > +		if (iocb->ki_flags & IOCB_NOWAIT)
> > > +			return -EOPNOTSUPP;
> > > +		inode_lock(inode);
> > > +	}
> > 
> > Currently there's no support for IOCB_NOWAIT for buffered IO so you can
> > replace this with "inode_lock(inode)".
> 
> IOCB_NOWAIT is supported for buffered reads. It is not supported on
> buffered writes (as yet), so this should return EOPNOTSUPP if
> IOCB_NOWAIT is set, regardless of whether the lock can be grabbed or
> not.

Yeah, right. Thanks for correcting me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
