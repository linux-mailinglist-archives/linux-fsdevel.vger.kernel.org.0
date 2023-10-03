Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2CF7B6EE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 18:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbjJCQr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjJCQry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:47:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FAF9E;
        Tue,  3 Oct 2023 09:47:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD87C433C8;
        Tue,  3 Oct 2023 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696351670;
        bh=4p9963VFVlutEBBCundjDdJv/u3ZUzQXNKGcu4as1rQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxT9yXCzB/O2Cm9iOB6swPV1v26/gtOSQAs12gb9/3ZdPSDiMpRf7kBzpM/9UBSWF
         yKJXv079BAQitOBxGFPJg3HQgeLzONrHrSTyDUdc84UKGdV0JX4HI8N/VCEv6p8mYM
         H0GuvfItEHgHY1DrRvOKmrqhaI8Qb2hMDA8QBk2pgTo4I91HEJLCAJBX3KNPG8EWQw
         noFDy51x9bnX3x8QW4pesjlcp/aH3MYU/zU3TNsnGCS5Z/fuLqlzja+hn2tKNR2PJh
         uuTkQp/crBt9fpFWbuyiN1lJJYowlWs+mfJqEm8War2mb2PYY/iY90pIIfBn7D7m3Y
         nxmO9S4Vmam3Q==
Date:   Tue, 3 Oct 2023 09:47:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 16/21] fs: iomap: Atomic write support
Message-ID: <20231003164749.GH21298@frogsfrogsfrogs>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-17-john.g.garry@oracle.com>
 <ZRuXd/iG1kyeFQDh@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRuXd/iG1kyeFQDh@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023 at 03:24:23PM +1100, Dave Chinner wrote:
> On Fri, Sep 29, 2023 at 10:27:21AM +0000, John Garry wrote:
> > Add flag IOMAP_ATOMIC_WRITE to indicate to the FS that an atomic write
> > bio is being created and all the rules there need to be followed.
> > 
> > It is the task of the FS iomap iter callbacks to ensure that the mapping
> > created adheres to those rules, like size is power-of-2, is at a
> > naturally-aligned offset, etc.
> 
> The mapping being returned by the filesystem can span a much greater
> range than the actual IO needs - the iomap itself is not guaranteed
> to be aligned to anything in particular, but the IO location within
> that map can still conform to atomic IO constraints. See how
> iomap_sector() calculates the actual LBA address of the IO from
> the iomap and the current file position the IO is being done at.
> 
> hence I think saying "the filesysetm should make sure all IO
> alignment adheres to atomic IO rules is probably wrong. The iomap
> layer doesn't care what the filesystem does, all it cares about is
> whether the IO can be done given the extent map that was returned to
> it.
> 
> Indeed, iomap_dio_bio_iter() is doing all these alignment checks for
> normal DIO reads and writes which must be logical block sized
> aligned. i.e. this check:
> 
>         if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
>             !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>                 return -EINVAL;
> 
> Hence I think that atomic IO units, which are similarly defined by
> the bdev, should be checked at the iomap layer, too. e.g, by
> following up with:
> 
> 	if ((dio->iocb->ki_flags & IOCB_ATOMIC) &&
> 	    ((pos | length) & (bdev_atomic_unit_min(iomap->bdev) - 1) ||
> 	     !bdev_iter_is_atomic_aligned(iomap->bdev, dio->submit.iter))
> 		return -EINVAL;
> 
> At this point, filesystems don't really need to know anything about
> atomic IO - if they've allocated a large contiguous extent (e.g. via
> fallocate()), then RWF_ATOMIC will just work for the cases where the
> block device supports it...
> 
> This then means that stuff like XFS extent size hints only need to
> check when the hint is set that it is aligned to the underlying
> device atomic IO constraints. Then when it sees the IOMAP_ATOMIC
> modifier, it can fail allocation if it can't get extent size hint
> aligned allocation.
> 
> IOWs, I'm starting to think this doesn't need any change to the
> on-disk format for XFS - it can be driven entirely through two
> dynamic mechanisms:
> 
> 1. (IOMAP_WRITE | IOMAP_ATOMIC) requests from the direct IO layer
> which causes mapping/allocation to fail if it can't allocate (or
> map) atomic IO compatible extents for the IO.
> 
> 2. FALLOC_FL_ATOMIC preallocation flag modifier to tell fallocate()
> to force alignment of all preallocated extents to atomic IO
> constraints.

Ugh, let's not relitigate problems that you (Dave) and I have already
solved.

Back in 2018, our internal proto-users of pmem asked for aligned
allocations so they could use PMD mappings to reduce TLB pressure.  At
the time, you and I talked on IRC about whether that should be done via
fallocate flag or setting extszinherit+sunit at mkfs time.  We decided
against adding fallocate flags because linux-api bikeshed hell.

Ever since, we've been shipping UEK with a mkfs.xmem scripts that
automates computing the mkfs.xfs geometry CLI options.  It works,
mostly, except for the unaligned allocations that one gets when the free
space gets fragmented.  The xfsprogs side of the forcealign patchset
moves most of the mkfs.xmem cli option setting logic into mkfs itself,
and the kernel side shuts off the lowspace allocator to fix the
fragmentation problem.

I'd rather fix the remaining quirks and not reinvent solved solutions,
as popular as that is in programming circles.

Why is mandatory allocation alignment for atomic writes different?
Forcealign solves the problem for NVME/SCSI AWU and pmem PMD in the same
way with the same control knobs for sysadmins.  I don't want to have
totally separate playbooks for accomplishing nearly the same things.

I don't like encoding hardware details in the fallocate uapi either.
That implies adding FALLOC_FL_HUGEPAGE for pmem, and possibly
FALLOC_FL_{SUNIT,SWIDTH} for users with RAIDs.

> This doesn't require extent size hints at all. The filesystem can
> query the bdev at mount time, store the min/max atomic write sizes,
> and then use them for all requests that have _ATOMIC modifiers set
> on them.
> 
> With iomap doing the same "get the atomic constraints from the bdev"
> style lookups for per-IO file offset and size checking, I don't
> think we actually need extent size hints or an on-disk flag to force
> extent size hint alignment.
> 
> That doesn't mean extent size hints can't be used - it just means
> that extent size hints have to be constrained to being aligned to
> atomic IOs (e.g. extent size hint must be an integer multiple of the
> max atomic IO size). This then acts as a modifier for _ATOMIC
> context allocations, much like it is a modifier for normal
> allocations now.

(One behavior change that comes with FORCEALIGN is that without it,
extent size hints affect only the alignment of the file range mappings.
With FORCEALIGN, the space allocation itself *and* the mapping are
aligned.)

The one big downside of FORCEALIGN is that the extent size hint can
become misaligned with the AWU (or pagetable) geometry if the fs is
moved to a different computing environment.  I prefer not to couple the
interface to the hardware because that leaves open the possibility for
users to discover more use cases.

> 
> > In iomap_dio_bio_iter(), ensure that for a non-dsync iocb that the mapping
> > is not dirty nor unmapped.
> >
> > A write should only produce a single bio, so error when it doesn't.
> 
> I comment on both these things below.
> 
> > 
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  fs/iomap/direct-io.c  | 26 ++++++++++++++++++++++++--
> >  fs/iomap/trace.h      |  3 ++-
> >  include/linux/iomap.h |  1 +
> >  3 files changed, 27 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index bcd3f8cf5ea4..6ef25e26f1a1 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -275,10 +275,11 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> >  static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> >  		struct iomap_dio *dio)
> >  {
> > +	bool atomic_write = iter->flags & IOMAP_ATOMIC_WRITE;
> >  	const struct iomap *iomap = &iter->iomap;
> >  	struct inode *inode = iter->inode;
> >  	unsigned int fs_block_size = i_blocksize(inode), pad;
> > -	loff_t length = iomap_length(iter);
> > +	const loff_t length = iomap_length(iter);
> >  	loff_t pos = iter->pos;
> >  	blk_opf_t bio_opf;
> >  	struct bio *bio;
> > @@ -292,6 +293,13 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> >  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> >  		return -EINVAL;
> >  
> > +	if (atomic_write && !iocb_is_dsync(dio->iocb)) {
> > +		if (iomap->flags & IOMAP_F_DIRTY)
> > +			return -EIO;
> > +		if (iomap->type != IOMAP_MAPPED)
> > +			return -EIO;
> > +	}
> 
> How do we get here without space having been allocated for the
> write?
> 
> Perhaps what this is trying to do is make RWF_ATOMIC only be valid
> into written space? I mean, this will fail with preallocated space
> (IOMAP_UNWRITTEN) even though we still have exactly the RWF_ATOMIC
> all-or-nothing behaviour guaranteed after a crash because of journal
> recovery behaviour. i.e. if the unwritten conversion gets written to
> the journal, the data will be there. If it isn't written to the
> journal, then the space remains unwritten and there's no data across
> that entire range....
> 
> So I'm not really sure that either of these checks are valid or why
> they are actually needed....

This requires O_DSYNC (or RWF_DSYNC) for atomic writes to unwritten or
COW space.  We want failures in forcing the log transactions for the
endio processing to be reported to the pwrite caller as EIO, right?

--D

> > +
> >  	if (iomap->type == IOMAP_UNWRITTEN) {
> >  		dio->flags |= IOMAP_DIO_UNWRITTEN;
> >  		need_zeroout = true;
> > @@ -381,6 +389,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> >  					  GFP_KERNEL);
> >  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
> >  		bio->bi_ioprio = dio->iocb->ki_ioprio;
> > +		if (atomic_write)
> > +			bio->bi_opf |= REQ_ATOMIC;
> > +
> >  		bio->bi_private = dio;
> >  		bio->bi_end_io = iomap_dio_bio_end_io;
> >  
> > @@ -397,6 +408,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> >  		}
> >  
> >  		n = bio->bi_iter.bi_size;
> > +		if (atomic_write && n != length) {
> > +			/* This bio should have covered the complete length */
> > +			ret = -EINVAL;
> > +			bio_put(bio);
> > +			goto out;
> 
> Why? The actual bio can be any length that meets the aligned
> criteria between min and max, yes? So it's valid to split a
> RWF_ATOMIC write request up into multiple min unit sized bios, is it
> not? I mean, that's the whole point of the min/max unit setup, isn't
> it? That the max sized write only guarantees that it will tear at
> min unit boundaries, not within those min unit boundaries? If
> I've understood this correctly, then why does this "single bio for
> large atomic write" constraint need to exist?
> 
> 
> > +		}
> >  		if (dio->flags & IOMAP_DIO_WRITE) {
> >  			task_io_account_write(n);
> >  		} else {
> > @@ -554,6 +571,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  	struct blk_plug plug;
> >  	struct iomap_dio *dio;
> >  	loff_t ret = 0;
> > +	bool is_read = iov_iter_rw(iter) == READ;
> > +	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
> 
> This does not need to be done here, because....
> 
> >  
> >  	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
> >  
> > @@ -579,7 +598,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  	if (iocb->ki_flags & IOCB_NOWAIT)
> >  		iomi.flags |= IOMAP_NOWAIT;
> >  
> > -	if (iov_iter_rw(iter) == READ) {
> > +	if (is_read) {
> >  		/* reads can always complete inline */
> >  		dio->flags |= IOMAP_DIO_INLINE_COMP;
> >  
> > @@ -605,6 +624,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  		if (iocb->ki_flags & IOCB_DIO_CALLER_COMP)
> >  			dio->flags |= IOMAP_DIO_CALLER_COMP;
> >  
> > +		if (atomic_write)
> > +			iomi.flags |= IOMAP_ATOMIC_WRITE;
> 
> .... it is only checked once in the write path, so
> 
> 		if (iocb->ki_flags & IOCB_ATOMIC)
> 			iomi.flags |= IOMAP_ATOMIC;
> 
> > +
> >  		if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
> >  			ret = -EAGAIN;
> >  			if (iomi.pos >= dio->i_size ||
> > diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> > index c16fd55f5595..f9932733c180 100644
> > --- a/fs/iomap/trace.h
> > +++ b/fs/iomap/trace.h
> > @@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
> >  	{ IOMAP_REPORT,		"REPORT" }, \
> >  	{ IOMAP_FAULT,		"FAULT" }, \
> >  	{ IOMAP_DIRECT,		"DIRECT" }, \
> > -	{ IOMAP_NOWAIT,		"NOWAIT" }
> > +	{ IOMAP_NOWAIT,		"NOWAIT" }, \
> > +	{ IOMAP_ATOMIC_WRITE,	"ATOMIC" }
> 
> We already have an IOMAP_WRITE flag, so IOMAP_ATOMIC is the modifier
> for the write IO behaviour (like NOWAIT), not a replacement write
> flag.
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
