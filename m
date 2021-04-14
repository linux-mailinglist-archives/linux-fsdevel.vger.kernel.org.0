Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4749235F305
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 13:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhDNL4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 07:56:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:44752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233708AbhDNL4g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:56:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 605D1AF5A;
        Wed, 14 Apr 2021 11:56:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 271051F2B5F; Wed, 14 Apr 2021 13:56:14 +0200 (CEST)
Date:   Wed, 14 Apr 2021 13:56:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 2/3] ext4: Fix occasional generic/418 failure
Message-ID: <20210414115614.GB31323@quack2.suse.cz>
References: <20210412102333.2676-1-jack@suse.cz>
 <20210412102333.2676-3-jack@suse.cz>
 <20210412215024.GP1990290@dread.disaster.area>
 <20210413091122.GA15752@quack2.suse.cz>
 <20210413224531.GE63242@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413224531.GE63242@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-04-21 08:45:31, Dave Chinner wrote:
> On Tue, Apr 13, 2021 at 11:11:22AM +0200, Jan Kara wrote:
> > On Tue 13-04-21 07:50:24, Dave Chinner wrote:
> > > On Mon, Apr 12, 2021 at 12:23:32PM +0200, Jan Kara wrote:
> > > > Eric has noticed that after pagecache read rework, generic/418 is
> > > > occasionally failing for ext4 when blocksize < pagesize. In fact, the
> > > > pagecache rework just made hard to hit race in ext4 more likely. The
> > > > problem is that since ext4 conversion of direct IO writes to iomap
> > > > framework (commit 378f32bab371), we update inode size after direct IO
> > > > write only after invalidating page cache. Thus if buffered read sneaks
> > > > at unfortunate moment like:
> > > > 
> > > > CPU1 - write at offset 1k                       CPU2 - read from offset 0
> > > > iomap_dio_rw(..., IOMAP_DIO_FORCE_WAIT);
> > > >                                                 ext4_readpage();
> > > > ext4_handle_inode_extension()
> > > > 
> > > > the read will zero out tail of the page as it still sees smaller inode
> > > > size and thus page cache becomes inconsistent with on-disk contents with
> > > > all the consequences.
> > > > 
> > > > Fix the problem by moving inode size update into end_io handler which
> > > > gets called before the page cache is invalidated.
> > > 
> > > Confused.
> > > 
> > > This moves all the inode extension stuff into the completion
> > > handler, when all that really needs to be done is extending
> > > inode->i_size to tell the world there is data up to where the
> > > IO completed. Actually removing the inode from the orphan list
> > > does not need to be done in the IO completion callback, because...
> > > 
> > > >  	if (ilock_shared)
> > > >  		iomap_ops = &ext4_iomap_overwrite_ops;
> > > > -	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
> > > > -			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0);
> > > > -	if (ret == -ENOTBLK)
> > > > -		ret = 0;
> > > > -
> > > >  	if (extend)
> > > > -		ret = ext4_handle_inode_extension(inode, offset, ret, count);
> > > > +		dio_ops = &ext4_dio_extending_write_ops;
> > > >  
> > > > +	ret = iomap_dio_rw(iocb, from, iomap_ops, dio_ops,
> > > > +			   (extend || unaligned_io) ? IOMAP_DIO_FORCE_WAIT : 0);
> > >                             ^^^^^^                    ^^^^^^^^^^^^^^^^^^^ 
> > > 
> > > .... if we are doing an extending write, we force DIO to complete
> > > before returning. Hence even AIO will block here on an extending
> > > write, and hence we can -always- do the correct post-IO completion
> > > orphan list cleanup here because we know a) the original IO size and
> > > b) the amount of data that was actually written.
> > > 
> > > Hence all that remains is closing the buffered read vs invalidation
> > > race. All this requires is for the dio write completion to behave
> > > like XFS where it just does the inode->i_size update for extending
> > > writes. THis means the size is updated before the invalidation, and
> > > hence any read that occurs after the invalidation but before the
> > > post-eof blocks have been removed will see the correct size and read
> > > the tail page(s) correctly. This closes the race window, and the
> > > caller can still handle the post-eof block cleanup as it does now.
> > > 
> > > Hence I don't see any need for changing the iomap infrastructure to
> > > solve this problem. This seems like the obvious solution to me, so
> > > what am I missing?
> > 
> > All that you write above is correct. The missing piece is: If everything
> > succeeded and all the cleanup we need is removing inode from the orphan
> > list (common case), we want to piggyback that orphan list removal into the
> > same transaction handle as the update of the inode size. This is just a
> > performance thing, you are absolutely right we could also do the orphan
> > cleanup unconditionally in ext4_dio_write_iter() and thus avoid any changes
> > to the iomap framework.
> 
> Doesn't ext4, like XFS, keep two copies of the inode size? One for
> the on-disk size and one for the in-memory size?
> 
> /me looks...
> 
> Yeah, there's ei->i_disksize that reflects the on-disk size.
> 
> And I note that the first thing that ext4_handle_inode_extension()
> is already checking that the write is extending past the current
> on-disk inode size before running the extension transaction.

Yes.

> The page cache only cares about the inode->i_size value, not the
> ei->i_disksize value, so you can update them independently and still
> have things work correctly. That's what XFS does in
> xfs_dio_write_end_io - it updates the in-memory inode->i_size, then
> runs a transaction to atomically update the inode on-disk inode
> size. Updating the VFS inode size first protects against buffered
> read races while updating the on-disk size...
> 
> So for ext4, the two separate size updates don't need to be done at
> the same time - you have all the state you need in the ext4 dio
> write path to extend the on-disk file size on successful extending
> write, and it is not dependent in any way on the current in-memory
> VFS inode size that you'd update in the ->end_io callback....

Right, that's a nice trick that will allow us to keep the original
performance (I've verified that indeed splitting inode size and orphan
updates into separate transactions costs us ~10% of performance when
appending 512-byte chunks) without touching generic dio code. Thanks for
the idea!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
