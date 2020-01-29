Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 232D914D28D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 22:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgA2VdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 16:33:24 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41878 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgA2VdY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:33:24 -0500
Received: from dread.disaster.area (pa49-195-111-217.pa.nsw.optusnet.com.au [49.195.111.217])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 70BDA7EAB58;
        Thu, 30 Jan 2020 08:33:19 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iwuxa-0004p3-9N; Thu, 30 Jan 2020 08:33:18 +1100
Date:   Thu, 30 Jan 2020 08:33:18 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jth@kernel.org" <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH v9 1/2] fs: New zonefs file system
Message-ID: <20200129213318.GM18610@dread.disaster.area>
References: <20200127100521.53899-1-damien.lemoal@wdc.com>
 <20200127100521.53899-2-damien.lemoal@wdc.com>
 <20200128174608.GR3447196@magnolia>
 <b404c1cd7a0c8ccbabcbd3c8aed440542750706e.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b404c1cd7a0c8ccbabcbd3c8aed440542750706e.camel@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=0OveGI8p3fsTA6FL6ss4ZQ==:117 a=0OveGI8p3fsTA6FL6ss4ZQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=3J5UeX1WDUf5wypQ6G8A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 01:06:29PM +0000, Damien Le Moal wrote:
> On Tue, 2020-01-28 at 09:46 -0800, Darrick J. Wong wrote:
> > > +static int zonefs_io_err_cb(struct blk_zone *zone, unsigned int idx, void *data)
> > > +{
> > > +	struct zonefs_ioerr_data *ioerr = data;
> > > +	struct inode *inode = ioerr->inode;
> > > +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> > > +	struct super_block *sb = inode->i_sb;
> > > +	loff_t isize, wp_ofst;
> > > +
> > > +	/*
> > > +	 * The condition of the zone may have change. Fix the file access
> > > +	 * permissions if necessary.
> > > +	 */
> > > +	zonefs_update_file_perm(inode, zone);
> > > +
> > > +	/*
> > > +	 * There is no write pointer on conventional zones and read operations
> > > +	 * do not change a zone write pointer. So there is nothing more to do
> > > +	 * for these two cases.
> > > +	 */
> > > +	if (zi->i_ztype == ZONEFS_ZTYPE_CNV || !ioerr->write)
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * For sequential zones write, make sure that the zone write pointer
> > > +	 * position is as expected, that is, in sync with the inode size.
> > > +	 */
> > > +	wp_ofst = (zone->wp - zone->start) << SECTOR_SHIFT;
> > > +	zi->i_wpoffset = wp_ofst;
> > > +	isize = i_size_read(inode);
> > > +
> > > +	if (isize == wp_ofst)
> > /> +		return 0;
> > > +
> > > +	/*
> > > +	 * The inode size and the zone write pointer are not in sync.
> > > +	 * If the inode size is below the zone write pointer, then data was
> > 
> > I'm a little confused about what events these states reflect.
> > 
> > "inode size is below the zone wp" -- let's say we have a partially
> > written sequential zone:
> > 
> >     isize
> > ----v---------------
> > DDDDD
> > ----^---------------
> >     WP
> > 
> > Then we tried to write to the end of the sequential zone:
> > 
> >     isize
> > ----v---------------
> > DDDDDWWWW
> > ----^---------------
> >     WP
> > 
> > Then an error happens so we didn't update the isize, and now we see that
> > the write pointer is beyond isize (pretend the write failed to the '?'
> > area):
> > 
> >     isize
> > ----v---------------
> > DDDDDD?DD
> > --------^-----------
> >         WP
> 
> If the write failed at the "?" location, then the zone write pointer
> points to that location since nothing after that location can be
> written unless that location itself is first written.
> 
> So with your example, the drive will give back:
> 
>     isize
> ----v---------------
> DDDDDD?XX
> ------^-------------
>       WP
> 
> With XX denoting the unwritten part of the issued write.
> 
> > So if we increase isize to match the WP, what happens when userspace
> > tries to read the question-mark area?  Do they get read errors?  Stale
> > contents?
> 
> Nope, see above: the write pointer always point to the sector following
> the last sector correctly written. So increasing isize to the write
> pointer location only exposes the data that actually was written and is
> readable. No stale data.
> > Or am I misunderstanding SMR firmware, and the drive only advances the
> > write pointer once it has written a block?  i.e. if a write fails in
> > the middle, the drive ends up in this state, not the one I drew above:
> > 
> >     isize
> > ----v---------------
> > DDDDDD?
> > -----^--------------
> >      WP
> > 
> > In which case it would be fine to push isize up to the write pointer?
> 
> Exactly. This is how the ZBC & ZAC (and upcoming ZNS) specifications
> define the write pointer behavior. That makes error recovery a lot
> easier and does not result in stale data accesses. Just notice the one-
> off difference for the WP position from your example as WP will be
> pointing at the error location, not the last written location. Indexing
> from 0, we get (wp - zone start) always being isize with all written
> and readable data in the sector range between zone start and zone write
> pointer.

Ok, I'm going throw a curve ball here: volatile device caches.

How does the write pointer updates interact with device write
caches? i.e.  the first write could be sitting in the device write
cache, and the OS write pointer has been advanced. Then another write
occurs, the device decides to write both to physical media, and it
gets a write error in the area of the first write that only hit the
volatile cache.

So does this mean that, from the POV of the OS, the device zone
write pointer has gone backwards?

Unless there's some other magic that ensures device cached writes
that have been signalled as successfully completed to the OS
can never fail or that sequential zone writes are never cached in
volatile memory in drives, I can't see how the above guarantees
can be provided.

> It is hard to decide on the best action to take here considering the
> simple nature of zonefs (i.e. another better interface to do raw block
> device file accesses). Including your comments on mount options, I cam
> up with these actions that the user can choose with mount options:
> * repair: Truncate the inode size only, nothing else
> * remount-ro (default): Truncate the inode size and remount read-only
> * zone-ro: Truncate the inode size and set the inode read-only
> * zone-offline: Truncate the inode size to 0 and assume that its zone 
> is offline (no reads nor writes possible).
> 
> This gives I think a good range of possible behaviors that the user may
> want, from almost nothing (repair) to extreme to avoid accessing bad
> data (zone-offline).

I would suggest that this is something that can be added later as it
is not critical to supporting the underlying functionality.  Right
now I'd just pick the safest option: shutdown to protect what data
is on the storage right now and then let the user take action to
recover/fix the issue.

> > > +	 * BIO allocations for the same device. The former case may end up in
> > > +	 * a deadlock on the inode truncate mutex, while the latter may prevent
> > > +	 * forward progress with BIO allocations as we are potentially still
> > > +	 * holding the failed BIO. Executing the report zones under GFP_NOIO
> > > +	 * avoids both problems.
> > > +	 */
> > > +	noio_flag = memalloc_noio_save();
> > 
> > Don't you still need memalloc_nofs_ here too?
> 
> noio implies nofs, doesn't it ? Or rather, noio is more restrictive
> than nofs here. Which is safer since we need a struct request to be
> able to execute blkdev_report_zones().

Correct, noio implies nofs.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
