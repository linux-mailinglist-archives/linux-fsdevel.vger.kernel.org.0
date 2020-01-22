Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7C3145EFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 00:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgAVXLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 18:11:46 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:49147 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbgAVXLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 18:11:46 -0500
Received: from dread.disaster.area (pa49-181-218-253.pa.nsw.optusnet.com.au [49.181.218.253])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7C8D43A1955;
        Thu, 23 Jan 2020 10:11:38 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iuP9u-000876-3J; Thu, 23 Jan 2020 10:11:38 +1100
Date:   Thu, 23 Jan 2020 10:11:38 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hare@suse.de" <hare@suse.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "jth@kernel.org" <jth@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] fs: New zonefs file system
Message-ID: <20200122231138.GH9407@dread.disaster.area>
References: <20200121065846.216538-1-damien.lemoal@wdc.com>
 <20200121065846.216538-2-damien.lemoal@wdc.com>
 <20200122015757.GG9407@dread.disaster.area>
 <63dbc880d4748c5f7f9dc91f80525ec01933370f.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63dbc880d4748c5f7f9dc91f80525ec01933370f.camel@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=TU0PeEMO9XNyODJ+pEfdLw==:117 a=TU0PeEMO9XNyODJ+pEfdLw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=C8PisHbqREvtqrBXf9oA:9 a=-iGcd2G-_d87knI5:21
        a=i2gGs6wJv-NuZrnf:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 10:07:07AM +0000, Damien Le Moal wrote:
> Dave,
> 
> On Wed, 2020-01-22 at 12:57 +1100, Dave Chinner wrote:
> > [...]
> > > +static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > > +			      unsigned int flags, struct iomap *iomap,
> > > +			      struct iomap *srcmap)
> > > +{
> > > +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
> > > +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> > > +	loff_t max_isize = zi->i_max_size;
> > > +	loff_t isize;
> > > +
> > > +	/*
> > > +	 * For sequential zones, enforce direct IO writes. This is already
> > > +	 * checked when writes are issued, so warn about this here if we
> > > +	 * get buffered write to a sequential file inode.
> > > +	 */
> > > +	if (WARN_ON_ONCE(zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
> > > +			 (flags & IOMAP_WRITE) && !(flags & IOMAP_DIRECT)))
> > > +		return -EIO;
> > > +
> > > +	/*
> > > +	 * For all zones, all blocks are always mapped. For sequential zones,
> > > +	 * all blocks after the write pointer (inode size) are always unwritten.
> > > +	 */
> > > +	mutex_lock(&zi->i_truncate_mutex);
> > > +	isize = i_size_read(inode);
> > > +	if (offset >= isize) {
> > > +		length = min(length, max_isize - offset);
> > > +		if (zi->i_ztype == ZONEFS_ZTYPE_CNV)
> > > +			iomap->type = IOMAP_MAPPED;
> > > +		else
> > > +			iomap->type = IOMAP_UNWRITTEN;
> > > +	} else {
> > > +		length = min(length, isize - offset);
> > > +		iomap->type = IOMAP_MAPPED;
> > > +	}
> > 
> > Something was bugging me about this, and reading the rest of the
> > patch it finally triggered. For conventional zones, inode->i_size =
> > zi->i_max_size, and so if offset >= isize for a conventional
> > zone then this:
> > 
> > 	length = min(length, max_isize - offset);
> > 
> > is going to result in length <= 0 and we return a negative length
> > iomap.
> > 
> > IOWs, this case should only trigger for IO into sequential zones,
> > as it appears to be prevented at higher layers for conventional
> > zones by explicit checks against i_max_size and/or
> > iov_iter_truncate() calls to ensure user IOs are limited to within
> > i_max_size.
> > 
> > Hence it looks to me that triggering the (offset >= isize) case here
> > for conventional zones is a WARN_ON_ONCE() and return -EIO
> > situation...
> > 
> > SO, perhaps:
> > 
> > 	isize = i_size_read(inode);
> > 	if (offset >= isize) {
> > 		if (WARN_ON_ONCE(i->i_ztype == ZONEFS_ZTYPE_CNV)) {
> > 			/* drop locks */
> > 			return -EIO;
> > 		}
> > 		length = min(length, max_isize - offset);
> > 		iomap->type = IOMAP_UNWRITTEN;
> > 	} else {
> > 		length = min(length, isize - offset);
> > 		iomap->type = IOMAP_MAPPED;
> > 	}
> 
> Yes, that is much better indeed. I will change this.
> 
> > This also seems tailored around the call from zonefs_map_blocks()
> > which tries to map the entire zone (length = zi->i_max_size) for
> > writeback mappings. Hence the length in this case always requires
> > clamping to zi->i_max_size - offset. Again, there's an issue here:
> > 
> > > +static int zonefs_map_blocks(struct iomap_writepage_ctx *wpc,
> > > +			     struct inode *inode, loff_t offset)
> > > +{
> > > +	if (offset >= wpc->iomap.offset &&
> > > +	    offset < wpc->iomap.offset + wpc->iomap.length)
> > > +		return 0;
> > > +
> > > +	memset(&wpc->iomap, 0, sizeof(wpc->iomap));
> > > +	return zonefs_iomap_begin(inode, offset, ZONEFS_I(inode)->i_max_size,
> > > +				  0, &wpc->iomap, NULL);
> > 
> > Where we pass flags = 0 into zonefs_iomap_begin(), and so there is
> > no checking that this writeback code path is only executing against
> > a conventional zone. I.e. the comments and checks in
> > zonefs_iomap_begin() relate only to user IO call paths, but don't
> > validate or comment on the writeback path callers, and there's no
> > comments or checks here that the inode points at a conventional
> > zone, either....
> 
> I do not understand your point here. Since all blocks are always
> allocated for both conventional and sequential files, I think that
> using i_max_size for calling zonefs_iomap_begin is OK:

Yes, it is, but that wasn't really the point I was trying to make.
My comments around passing in the max size here means that
zonefs_iomap_begin() has to do clamping (i.e. the length = min(length,
max_isize - offset) calls) just for this caller, as all the other
callers from the user IO path already have their offset/lengths
clamped to isize/max_isize. Hence if zonefs_map_blocks() clamped
the length it passed to (i_max_size - offset) like all other callers
do, then code in zonefs_iomap_begin() would be simpler.


> for conventional
> zone files, any of these blocks can be written, both user direct or
> through the page cache. No distinction is I think necessary. For
> sequential zone files, only the blocks at "offset" can be written, and
> that value must be equal to zi->i_wpoffset (which account for in-
> flights writes). In both cases, exceeding the max file size is not
> allowed so this check is common in zonefs_iomap_begin() to cover all
> users and not just zonefs_map_blocks(). Did I get something wrong with
> iomap workings ?

No, the point I was trying to make (unsucessfully!) is that
zonefs_map_blocks() is only called from buffered writeback, and
so it only called on conventional zone writes. Neither
zonefs_map_blocks() or zonefs_iomap_begin() check this, and
zonefs_iomap_begin() can't because it doesn't have any flags passed
into it to tell it that a mapping for a write is being done.

i.e. somewhere in this zonefs_map_blocks() codepath there needs to
be a check like:

	WARN_ON_ONCE(zi->zi_type != ZONEFS_ZTYPE_CNV);

because we should never get here for sequential zones.

And that then raises the question - if we can only get here for
conventional zones, then wouldn't the code read better using
the inode->i_size rather that the zi->i_max_size as all IO to
conventional zones must be within the inode size?

> > > +	pos = (zone->wp - zone->start) << SECTOR_SHIFT;
> > > +	zi->i_wpoffset = pos;
> > > +	if (i_size_read(inode) != pos) {
> > > +		zonefs_update_stats(inode, pos);
> > > +		i_size_write(inode, pos);
> > > +	}
> > 
> > What happens if this decreases the size of the zone? don't we need
> > to invalidate the page cache beyond the new EOF in this case (i.e.
> > it's a truncate operation)?
> 
> This is called only for direct write errors into sequential zones.
> Since for that case we only deal with append direct writes, there is no
> possibility of having any of the written data cached already. So even
> if we get a short write or complete failure, no invalidation is needed.

Ah, there's a undocumented assumption that a write error never
resets the zone write pointer completely, but only remains unchanged
from where it was prior to the write that failed. My concern is what
happens if the device decides that the error has caused the zone to
be completely lost and so resets the write pointer back to zero?

And the other concern here is what if the hardware write pointer
still moves forward and exposes stale data because the write failed?

> Compared to errors for read operations in any zone, or conventional
> zone files read/write errors, this error handling adds processing of
> zone condition changes (error due to a zone going offline or read-
> only). I could add the same treatment for all IO errors. I did not
> since if we start seeing these zone conditions, it is likely that the
> drive is about to die.

Ok, so it's not expected, but it sounds like in extreme
circumstances it can still occur, and hence we still should try to
handle such errors in a sane manner.

> So conventional zone writes and all read errors
> are treated like on any other FS: only return the error to the user
> without any drive-specific forensic done.

Sure, but they don't go through this new error path :)

> > > +	/*
> > > +	 * blkdev_report_zones() uses GFP_KERNEL by default. Force execution as
> > > +	 * if GFP_NOFS was specified so that it will not end up recursing into
> > > +	 * the FS on memory allocation.
> > > +	 */
> > > +	nofs_flag = memalloc_nofs_save();
> > > +	ret = blkdev_report_zones(sb->s_bdev, sector, 1,
> > > +				  zonefs_report_zones_err_cb, inode);
> > > +	memalloc_nofs_restore(nofs_flag);
> > 
> > The comment is kinda redundant - it's explaining exactly what the
> > code does rather than why it needs this protection. i.e. the comment
> > should explain the recursion vector/deadlock that we are avoiding
> > here...
> 
> Yes. Changed it to:
> 
> /*
>  * Report zones memory allocation could trigger a recursion into zonefs
>  * due to memory reclaim. Since this is always called with the inode
>  * truncate mutex lock being held, avoid the potential recursion
>  * deadlock using a GFP_NOFS allocation.
>  */
> 
> > 
> > > +static int zonefs_file_dio_write_end(struct kiocb *iocb, ssize_t size, int ret,
> > > +				     unsigned int flags)
> > > +{
> > > +	struct inode *inode = file_inode(iocb->ki_filp);
> > > +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> > > +
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/*
> > > +	 * Conventional zone file size is fixed to the zone size so there
> > > +	 * is no need to do anything.
> > > +	 */
> > > +	if (zi->i_ztype == ZONEFS_ZTYPE_CNV)
> > > +		return 0;
> > > +
> > > +	mutex_lock(&zi->i_truncate_mutex);
> > > +
> > > +	if (size < 0) {
> > > +		ret = zonefs_seq_file_write_failed(inode, size);
> > 
> > Ok, so I see it is being called from IO completion context, whcih
> > means we'd want memalloc_noio_save() because the underlying bio
> > doesn't get freed until this whole completion runs, right?
> 
> Yes, the failed BIO is freed only after the report zone is done. But
> more than GFP_NOIO, we want GFP_NOFS for the reason stated above.

Yes, I can see that GFP_NOFS is needed to avoid truncate lock
recursion. However, we are in an IO completion routine here holding
a bio, so what I'm asking is whether reclaim recursion back into the
block layer and allocating more bios (e.g.  for swap to a
conventional zone within the same zoned block device) is safe to do
while we hold a bio from the same bioset that swap bios will be
allocated from...

i.e. doesn't this violate the forwards progress guarantee we need
for bioset mempools? i.e. we now can't free a bio if nested
allocation of a bio blocks waiting for a bio to be freed...

> > > +static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
> > > +{
> > > +	struct inode *inode = file_inode(iocb->ki_filp);
> > > +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
> > > +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> > > +	size_t count;
> > > +	ssize_t ret;
> > > +
> > > +	if (iocb->ki_flags & IOCB_NOWAIT) {
> > > +		if (!inode_trylock(inode))
> > > +			return -EAGAIN;
> > > +	} else {
> > > +		inode_lock(inode);
> > > +	}
> > > +
> > > +	ret = generic_write_checks(iocb, from);
> > > +	if (ret <= 0)
> > > +		goto out;
> > > +
> > > +	iov_iter_truncate(from, zi->i_max_size - iocb->ki_pos);
> > > +	count = iov_iter_count(from);
> > 
> > So count is initialised to the entire IO length....
> 
> Well, yes, count reflects the truncated iov_iter size. This is
> necessary for the AIO case when iomap_dio_rw() returns -EIOCBQUEUED so
> that we can account for the inflight AIOs for an eventual subsequent
> AIO submission by the user (see next comment below). For sync writes
> (or AIOs that completed very quickly), the final value for count is
> updated using iomap_dio_rw() return value.

Sure.

> > > +	/*
> > > +	 * Direct writes must be aligned to the block size, that is, the device
> > > +	 * physical sector size, to avoid errors when writing sequential zones
> > > +	 * on 512e devices (512B logical sector, 4KB physical sectors).
> > > +	 */
> > > +	if ((iocb->ki_pos | count) & sbi->s_blocksize_mask) {
> > > +		ret = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Enforce sequential writes (append only) in sequential zones.
> > > +	 */
> > > +	mutex_lock(&zi->i_truncate_mutex);
> > > +	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
> > > +	    iocb->ki_pos != zi->i_wpoffset) {
> > > +		zonefs_err(inode->i_sb,
> > > +			   "Unaligned write at %llu + %zu (wp %llu)\n",
> > > +			   iocb->ki_pos, count,
> > > +			   zi->i_wpoffset);
> > > +		mutex_unlock(&zi->i_truncate_mutex);
> > > +		ret = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +	mutex_unlock(&zi->i_truncate_mutex);
> > > +
> > > +	ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops, &zonefs_dio_ops,
> > > +			   is_sync_kiocb(iocb));
> > > +	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
> > > +	    (ret > 0 || ret == -EIOCBQUEUED)) {
> > > +		if (ret > 0)
> > > +			count = ret;
> > > +		mutex_lock(&zi->i_truncate_mutex);
> > > +		zi->i_wpoffset += count;
> > > +		mutex_unlock(&zi->i_truncate_mutex);
> > 
> > Hmmmm. This looks problematic w.r.t. AIO. If we get -EIOCBQUEUED it
> > means the IO has been queued but not necessarily submitted, but
> > we update zi->i_wpoffset as though the entire AIO has laready
> > completed. ANd then we drop the inode_lock() and return, allowing
> > another AIO+DIO to be started.
> > 
> > Hence another concurrent sequential AIO+DIO write could now be
> > submitted and pass the above iocb->ki_pos != zi->i_wpoffset check.
> > Now we have two independent IOs in flight - one that is at the
> > current hardware write pointer offset, and one that is beyond it.
> > 
> > What happens if the block layer now re-orders these two IOs?
> 
> If the correct block scheduler is used, that is mq-deadline, there is
> no possibility of write reordering.

Oh, my.

That needs a great big warning in the code. This assumes the block
layer functions in a specific manner, and there is no way to
guarantee that it does at the filesystem layer. Hence if the block
layer is subtly broken (which has happened far too many times in the
past couple of years for me to just trust it anymore) then this code
can result in spurious write failures for applications that use
AIO+DIO...

> mq-deadline is now the default IO
> scheduler for zoned block devices and the only one that is allowed
> (beside "none"). mq-deadline uses a zone write locking mechanism to
> ensure that there is no reordering of write requests, either by the
> block layer itself or by bad hardware (SATA AHCI adapters are
> notoriously bad and silently reorder requests all the time, even for
> SMR disks).
>
> With this mechanism, the user can safely use io_submit() beyond a
> single IO and zonefs check that the set of AIOs being submitted are all
> sequential starting from the zi->i_wpoffset "soft" write pointer that
> reflects the already in-flight AIOs. Multiple io_submit() of multiple
> AIOs can be executed in sequence without needing to limit to a single
> AIO at a time.

I can see lots of potential problems with AIO on a filesystem that
assumes sequential, ordered AIO submission. e.g. RWF_NOWAIT and
submitting multiple sequential IOs at a time. First IO gets EAGAIN
because a lock is held by something else, second IO gets the lock
and now returns -EINVAL because it's offset no longer matches the
write pointer because the first IO got -EAGAIN and punted back to
userspace.

Or worse, it's io_uring, and it punts that IO to a worker thread to
resubmit. Now that IO will be issued out of order to all the others,
and so userspace will see that it succeeds, but all the other IOs in
the sequential batch get -EINVAL because of IO reordering long
before the IO even gets to the block layer....

> If a disk error occurs along the way, the seq file size and zi-
> >i_wpoffset are updated using the report zone result. All in-flight or
> submitted AIOs after the failed one will be failed by the disk itself
> due to the their now unaligned position. These failures will not change
> again the file size or zi->i_wpoffset since the zone information will
> be the same after all failures. The user only has to look at the file
> size again to know were to restart writing from without even needing to
> wait for all in-flight AIO to complete with an error (but that would of
> course be the recommended practice).

So I'm guessing that the same failure condition will return
different errors based on where the failure is detected. e.g. EINVAL
if it's at the write submission layer and EIO if it is reported by
the hardware?

> In other word, we assume here that all write succeed and allow high-
> queue depth submission using zi->i_wpoffset as a "soft" write pointer.

I'm starting to wonder whether it is a good idea to even support AIO
on sequential zones because there are some really messy spurious
failure cases that userspace will not be able to distinguish from
real write errors. That's not a very nice API for applications to
have to deal with...

At minimum, this needs extensive documentation both for users and
for kernel filesystem people that need to maintain this code forever
more...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
