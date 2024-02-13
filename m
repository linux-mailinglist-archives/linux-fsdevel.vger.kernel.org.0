Return-Path: <linux-fsdevel+bounces-11411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B359853980
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 19:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4881C21346
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 18:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BDE60865;
	Tue, 13 Feb 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvrI4gk5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69542605A3;
	Tue, 13 Feb 2024 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847710; cv=none; b=c/n5/zloO5El/2P6m0MFx3W7upexRkBoo25d7TQWWvDZArXdxNUBb5X87h7pbjVrAOEgZga31YY3suotyB9kFl9C/N/vrbWEf9wxv+6qg38T2Z+Ujz8JFtaK8SS4wEvcdpXDwqg7cEM+LoYrTSEHdFKjhvBzlDvUgGM8QTntHjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847710; c=relaxed/simple;
	bh=rgKIeqWZt/N5yMxignTV2UYSxYoX+Ts53cD2sMPC6S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNofCyjwgH7hhKtP+NefMjUkrWgym25LND3FTe+uGq/Z5mnGE4XK1fgPxyJwVvFEGMhJEnGCGMpmox/krNpBeK+ihUlFg5pZeQPepbG8aCSAuO+LP/QulMfGxMCjMJ0Y5CvKRLX3WhW5Wim8RT3M/HuwmVGWQAHF1ZwKxE192Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvrI4gk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5082C433F1;
	Tue, 13 Feb 2024 18:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707847710;
	bh=rgKIeqWZt/N5yMxignTV2UYSxYoX+Ts53cD2sMPC6S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NvrI4gk589ZOgkDJQ0t9KhA8P09BHR8yiwioNPXRKcAHTUs9ObNJLKLQRhu3/mAR3
	 pwUbfTBi9E2ajp27qCoNI3O8gKtwHBDVn9WAuiO89LWL1pjoYVgkT2Bpt1UX4B5mvy
	 q2CB0UhCNsQ6OIIj38gwKAh+pYonIpY9uEaUk2yOvP8mWSt0iGFBXGonRz2YleB8sK
	 rm3zbtGEnpXYHOVdK1b9c3GaCpghYZkaXzEeQEL94SqdBJtC1Q5g+05knTmBVP1hI+
	 P30hVNniC/laBNBrTg2WAvmfNHb5qglrHICH4xGEW1YSMsx5+u4f3L2Aqfl0/0xcFl
	 dLpY4iHTPFBEQ==
Date: Tue, 13 Feb 2024 10:08:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH 1/6] fs: iomap: Atomic write support
Message-ID: <20240213180829.GD6184@frogsfrogsfrogs>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-2-john.g.garry@oracle.com>
 <20240202172513.GZ6226@frogsfrogsfrogs>
 <2f91a71e-413b-47b6-8bc9-a60c86ed6f6b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f91a71e-413b-47b6-8bc9-a60c86ed6f6b@oracle.com>

On Mon, Feb 05, 2024 at 11:29:57AM +0000, John Garry wrote:
> On 02/02/2024 17:25, Darrick J. Wong wrote:
> > On Wed, Jan 24, 2024 at 02:26:40PM +0000, John Garry wrote:
> > > Add flag IOMAP_ATOMIC_WRITE to indicate to the FS that an atomic write
> > > bio is being created and all the rules there need to be followed.
> > > 
> > > It is the task of the FS iomap iter callbacks to ensure that the mapping
> > > created adheres to those rules, like size is power-of-2, is at a
> > > naturally-aligned offset, etc. However, checking for a single iovec, i.e.
> > > iter type is ubuf, is done in __iomap_dio_rw().
> > > 
> > > A write should only produce a single bio, so error when it doesn't.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/iomap/direct-io.c  | 21 ++++++++++++++++++++-
> > >   fs/iomap/trace.h      |  3 ++-
> > >   include/linux/iomap.h |  1 +
> > >   3 files changed, 23 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index bcd3f8cf5ea4..25736d01b857 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -275,10 +275,12 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> > >   static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >   		struct iomap_dio *dio)
> > >   {
> > > +	bool atomic_write = iter->flags & IOMAP_ATOMIC;
> > >   	const struct iomap *iomap = &iter->iomap;
> > >   	struct inode *inode = iter->inode;
> > >   	unsigned int fs_block_size = i_blocksize(inode), pad;
> > >   	loff_t length = iomap_length(iter);
> > > +	const size_t iter_len = iter->len;
> > >   	loff_t pos = iter->pos;
> > >   	blk_opf_t bio_opf;
> > >   	struct bio *bio;
> > > @@ -381,6 +383,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >   					  GFP_KERNEL);
> > >   		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
> > >   		bio->bi_ioprio = dio->iocb->ki_ioprio;
> > > +		if (atomic_write)
> > > +			bio->bi_opf |= REQ_ATOMIC;
> > 
> > This really ought to be in iomap_dio_bio_opflags.  Unless you can't pass
> > REQ_ATOMIC to bio_alloc*, in which case there ought to be a comment
> > about why.
> 
> I think that should be ok
> 
> > 
> > Also, what's the meaning of REQ_OP_READ | REQ_ATOMIC?
> 
> REQ_ATOMIC will be ignored for REQ_OP_READ. I'm following the same policy as
> something like RWF_SYNC for a read.
> 
> However, if FMODE_CAN_ATOMIC_WRITE is unset, then REQ_ATOMIC will be
> rejected for both REQ_OP_READ and REQ_OP_WRITE.
> 
> > Does that
> > actually work?  I don't know what that means, and "block: Add REQ_ATOMIC
> > flag" says that's not a valid combination.  I'll complain about this
> > more below.
> 
> Please note that I do mention that this flag is only meaningful for
> pwritev2(), like RWF_SYNC, here:
> https://lore.kernel.org/linux-api/20240124112731.28579-3-john.g.garry@oracle.com/
> 
> > 
> > > +
> > >   		bio->bi_private = dio;
> > >   		bio->bi_end_io = iomap_dio_bio_end_io;
> > > @@ -397,6 +402,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >   		}
> > >   		n = bio->bi_iter.bi_size;
> > > +		if (atomic_write && n != iter_len) {
> > 
> > s/iter_len/orig_len/ ?
> 
> ok, I can change the name if you prefer
> 
> > 
> > > +			/* This bio should have covered the complete length */
> > > +			ret = -EINVAL;
> > > +			bio_put(bio);
> > > +			goto out;
> > > +		}
> > >   		if (dio->flags & IOMAP_DIO_WRITE) {
> > >   			task_io_account_write(n);
> > >   		} else {
> > > @@ -554,12 +565,17 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > >   	struct blk_plug plug;
> > >   	struct iomap_dio *dio;
> > >   	loff_t ret = 0;
> > > +	bool is_read = iov_iter_rw(iter) == READ;
> > > +	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
> > 
> > Hrmm.  So if the caller passes in an IOCB_ATOMIC iocb with a READ iter,
> > we'll silently drop IOCB_ATOMIC and do the read anyway?  That seems like
> > a nonsense combination, but is that ok for some reason?
> 
> Please see above
> 
> > 
> > >   	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
> > >   	if (!iomi.len)
> > >   		return NULL;
> > > +	if (atomic_write && !iter_is_ubuf(iter))
> > > +		return ERR_PTR(-EINVAL);
> > 
> > Does !iter_is_ubuf actually happen?
> 
> Sure, if someone uses iovcnt > 1 for pwritev2
> 
> Please see __import_iovec(), where only if iovcnt == 1 we create iter_type
> == ITER_UBUF, if > 1 then we have iter_type == ITER_IOVEC

Ok.  The iter stuff (especially the macros) confuse the hell out of me
every time I go reading through that.

> > Why don't we support any of the
> > other ITER_ types?  Is it because hardware doesn't want vectored
> > buffers?
> It's related how we can determine atomic_write_unit_max for the bdev.
> 
> We want to give a definitive max write value which we can guarantee to
> always fit in a BIO, but not mandate any extra special iovec
> length/alignment rules.
> 
> Without any iovec length or alignment rules (apart from direct IO rules that
> an iovec needs to be bdev logical block size and length aligned) , if a user
> provides many iovecs, then we may only be able to only fit bdev LBS of data
> (typically 512B) in each BIO vector, and thus we need to give a
> pessimistically low atomic_write_unit_max value.
> 
> If we say that iovcnt max == 1, then we know that we can fit PAGE size of
> data in each BIO vector (ignoring first/last vectors), and this will give a
> reasonably large atomic_write_unit_max value.
> 
> Note that we do now provide this iovcnt max value via statx, but always
> return 1 for now. This was agreed with Christoph, please see:
> https://lore.kernel.org/linux-nvme/20240117150200.GA30112@lst.de/

Got it.  We can always add ITER_IOVEC support later if we figure out a
sane way to restrain userspace. :)

> > 
> > I really wish there was more commenting on /why/ we do things here:
> > 
> > 	if (iocb->ki_flags & IOCB_ATOMIC) {
> > 		/* atomic reads do not make sense */
> > 		if (iov_iter_rw(iter) == READ)
> > 			return ERR_PTR(-EINVAL);
> > 
> > 		/*
> > 		 * block layer doesn't want to handle handle vectors of
> > 		 * buffers when performing an atomic write i guess?
> > 		 */
> > 		if (!iter_is_ubuf(iter))
> > 			return ERR_PTR(-EINVAL);
> > 
> > 		iomi.flags |= IOMAP_ATOMIC;
> > 	}
> 
> ok, I can make this more clear.
> 
> Note: It would be nice if we could check this in xfs_iomap_write_direct() or
> a common VFS helper (which xfs_iomap_write_direct() calls), but iter is not
> available there.

No, do not put generic stuff like that in XFS, leave it here in iomap.

> I could just check iter_is_ubuf() on its own in the vfs rw path, but I would
> like to keep the checks as close together as possible.

Yeah, and I want you to put as many of the checks in the VFS as
possible so that we (or really Ojaswin) don't end up copy-pasting all
that validation into ext4 and every other filesystem that wants to
expose untorn writes.

AFAICT the only things XFS really needs to do on its own is check that
the xfs_inode_alloc_unit() is a power of two if untorn writes are
present; and adjusting the awu min/max for statx reporting.

--D

> Thanks,
> John
> 

