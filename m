Return-Path: <linux-fsdevel+bounces-26833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8974495BF8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 22:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BDB28541C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 20:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247DC1D0DFA;
	Thu, 22 Aug 2024 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp29njgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189E14A4CC;
	Thu, 22 Aug 2024 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358659; cv=none; b=ihGD/iKOxKSP7FfCIj6xc1AIsi883Q+q+ad2IJDRSP8GtSiM157WFSJ0PT2M0MiTaA0glBKCkArXBYVnASyV1C4vpOfQ+Gyj6CJitXFzhEmjTaBiuBKANxlN5es5So5LHhcz/njwsEEaWvAyYx5TABV0IDPWX97xHoCDmt5puHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358659; c=relaxed/simple;
	bh=DSY6th/sRSXoB1K5edub5QsT/OYwGJY3+8ohmpVQeeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6NvW89UnBpycQ/vj6qDtIxQ5VvXbQQ8IHYbtyImSEz6l9FwSkHeXEOpu76z/0HizOZmiOJUDeR80Lu4DpduJsyNGrhf1fvvXm61zNGyKP5Z/zCmS1e4uNnfujDfA29GNoJ/K3WkLZdece3bA0OQA+egvM0ED8Pm4uhJPjtikag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp29njgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5B7C32782;
	Thu, 22 Aug 2024 20:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724358659;
	bh=DSY6th/sRSXoB1K5edub5QsT/OYwGJY3+8ohmpVQeeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gp29njgOe0oi5Z9LvL24nqgbJTkzB8FUNhHzZGFdob4VHu7REIWVpMXDmxuCoYPpJ
	 n55mdUbjUY9+3AGKodNfffocG9x+lUePyKL1GOU5MqRY7ID151iB3gBI0PGlggeOrC
	 CrmWf1uzofJqYw3LKqeFF++S/dJAg4iQ0QXXlqH0N1ltzGFwFQ+O8j0zfRcxNIPghU
	 pSbkhfG8HUSFfDC0apa9Q+k3ZTtqvOADRVu7wlFM4+VOGGJnVArSO06aSzfVNo3yGm
	 br2SgfY6VD40rNbdFD6iyFnrDHdC7uPQDEBmTArvXfRGTiSwR5mZeF1eVE0szmQex1
	 QuqoQD2w0UFyg==
Date: Thu, 22 Aug 2024 13:30:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, chandan.babu@oracle.com, dchinner@redhat.com,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	kbusch@kernel.org
Subject: Re: [PATCH v5 3/7] fs: iomap: Atomic write support
Message-ID: <20240822203058.GR865349@frogsfrogsfrogs>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-4-john.g.garry@oracle.com>
 <20240821165803.GI865349@frogsfrogsfrogs>
 <a91557d2-95d4-4e73-9936-72fc1fbe100f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a91557d2-95d4-4e73-9936-72fc1fbe100f@oracle.com>

On Thu, Aug 22, 2024 at 04:29:34PM +0100, John Garry wrote:
> 
> > > +
> > >   static void iomap_dio_submit_bio(const struct iomap_iter *iter,
> > >   		struct iomap_dio *dio, struct bio *bio, loff_t pos)
> > >   {
> > > @@ -256,7 +275,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
> > >    * clearing the WRITE_THROUGH flag in the dio request.
> > >    */
> > >   static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> > > -		const struct iomap *iomap, bool use_fua)
> > > +		const struct iomap *iomap, bool use_fua, bool atomic)
> > >   {
> > >   	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
> > > @@ -268,6 +287,8 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> > >   		opflags |= REQ_FUA;
> > >   	else
> > >   		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
> > > +	if (atomic)
> > > +		opflags |= REQ_ATOMIC;
> > >   	return opflags;
> > >   }
> > > @@ -275,21 +296,23 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> > >   static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >   		struct iomap_dio *dio)
> > >   {
> > > +	bool atomic = dio->iocb->ki_flags & IOCB_ATOMIC;
> > >   	const struct iomap *iomap = &iter->iomap;
> > >   	struct inode *inode = iter->inode;
> > >   	unsigned int fs_block_size = i_blocksize(inode), pad;
> > > +	struct iov_iter *i = dio->submit.iter;
> > 
> > If you're going to pull this out into a convenience variable, please do
> > that as a separate patch so that the actual untorn write additions don't
> > get mixed in.
> 
> Yeah, I was thinking of doing that, so ok.
> 
> > 
> > >   	loff_t length = iomap_length(iter);
> > >   	loff_t pos = iter->pos;
> > >   	blk_opf_t bio_opf;
> > >   	struct bio *bio;
> > >   	bool need_zeroout = false;
> > >   	bool use_fua = false;
> > > -	int nr_pages, ret = 0;
> > > +	int nr_pages, orig_nr_pages, ret = 0;
> > >   	size_t copied = 0;
> > >   	size_t orig_count;
> > >   	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> > > -	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> > > +	    !bdev_iter_is_aligned(iomap->bdev, i))
> > >   		return -EINVAL;
> > >   	if (iomap->type == IOMAP_UNWRITTEN) {
> > > @@ -322,15 +345,35 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >   			dio->flags &= ~IOMAP_DIO_CALLER_COMP;
> > >   	}
> > > +	if (dio->atomic_bio) {
> > > +		/*
> > > +		 * These should not fail, but check just in case.
> > > +		 * Caller takes care of freeing the bio.
> > > +		 */
> > > +		if (iter->iomap.bdev != dio->atomic_bio->bi_bdev) {
> > > +			ret = -EINVAL;
> > > +			goto out;
> > > +		}
> > > +
> > > +		if (dio->atomic_bio->bi_iter.bi_sector +
> > > +		    (dio->atomic_bio->bi_iter.bi_size >> SECTOR_SHIFT) !=
> > 
> > Hmm, so I guess you stash an untorn write bio in the iomap_dio so that
> > multiple iomap_dio_bio_iter can try to combine a mixed mapping into a
> > single contiguous untorn write that can be completed all at once?
> 
> Right, we are writing to a contiguous LBA address range with a single bio
> that happens to cover many different extents.
> 
> > I suppose that works as long as the iomap->type is the same across all
> > the _iter calls, but I think that needs explicit checking here.
> 
> As an sample, if we try to atomically write over the data in the following
> file:
> 
> # xfs_bmap -vvp mnt/file
> mnt/file:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>   0: [0..127]:        hole                                   128
>   1: [128..135]:      256..263          0 (256..263)           8 010000
>   2: [136..143]:      264..271          0 (264..271)           8 000000
>   3: [144..255]:      272..383          0 (272..383)         112 010000
> FLAG Values:
>    0100000 Shared extent
>    0010000 Unwritten preallocated extent
>    0001000 Doesn't begin on stripe unit
>    0000100 Doesn't end   on stripe unit
>    0000010 Doesn't begin on stripe width
>    0000001 Doesn't end   on stripe width
> #
> 
> 
> Then, the iomap->type/flag is either IOMAP_UNWRITTEN/IOMAP_F_DIRTY or
> IOMAP_MAPPED/IOMAP_F_DIRTY per iter. So the type is not consistent. However
> we will set IOMAP_DIO_UNWRITTEN in dio->flags, so call xfs_dio_write_endio()
> -> xfs_iomap_write_unwritten() for the complete FSB range.
> 
> Do you see a problem with this?
> 
> Please see this also for some more background:
> https://lore.kernel.org/linux-xfs/20240726171358.GA27612@lst.de/

Yes -- if you have a mix of written and unwritten blocks for the same
chunk of physical space:

0      7
WUWUWUWU

the directio ioend function will start four separate transactions to
convert blocks 1, 3, 5, and 7 to written status.  If the system crashes
midway through, they will see this afterwards:

WWWWW0W0

IOWs, although the *disk write* was completed successfully, the mapping
updates were torn, and the user program sees a torn write.

The most performant/painful way to fix this would be to make the whole
ioend completion a logged operation so that we could commit to updating
all the unwritten mappings and restart it after a crash.

The least performant of course is to write zeroes at allocation time,
like we do for fsdax.

A possible middle ground would be to detect IOMAP_ATOMIC in the
->iomap_begin method, notice that there are mixed mappings under the
proposed untorn IO, and pre-convert the unwritten blocks by writing
zeroes to disk and updating the mappings before handing the one single
mapping back to iomap_dio_rw to stage the untorn writes bio.  At least
you'd only be suffering that penalty for the (probable) corner case of
someone creating mixed mappings.

> 
> > 
> > > +			iomap_sector(iomap, pos)) {
> > > +			ret = -EINVAL;
> > > +			goto out;
> > > +		}
> > > +	} else if (atomic) {
> > > +		orig_nr_pages = bio_iov_vecs_to_alloc(i, BIO_MAX_VECS);
> > > +	}
> > > +
> > >   	/*
> > >   	 * Save the original count and trim the iter to just the extent we
> > >   	 * are operating on right now.  The iter will be re-expanded once
> > >   	 * we are done.
> > >   	 */
> > > -	orig_count = iov_iter_count(dio->submit.iter);
> > > -	iov_iter_truncate(dio->submit.iter, length);
> > > +	orig_count = iov_iter_count(i);
> > > +	iov_iter_truncate(i, length);
> > > -	if (!iov_iter_count(dio->submit.iter))
> > > +	if (!iov_iter_count(i))
> > >   		goto out;
> > >   	/*
> > > @@ -365,27 +408,46 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >   	 * can set up the page vector appropriately for a ZONE_APPEND
> > >   	 * operation.
> > >   	 */
> > > -	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
> > > +	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
> > > +
> > > +	if (atomic) {
> > > +		size_t orig_atomic_size;
> > > +
> > > +		if (!dio->atomic_bio) {
> > > +			dio->atomic_bio = iomap_dio_alloc_bio_data(iter,
> > > +					dio, orig_nr_pages, bio_opf, pos);
> > > +		}
> > > +		orig_atomic_size = dio->atomic_bio->bi_iter.bi_size;
> > > +
> > > +		/*
> > > +		 * In case of error, caller takes care of freeing the bio. The
> > > +		 * smallest size of atomic write is i_node size, so no need for
> > 
> > What is "i_node size"?  Are you referring to i_blocksize?
> 
> Yes, I meant i_blocksize()
> 
> > 
> > > +		 * tail zeroing out.
> > > +		 */
> > > +		ret = bio_iov_iter_get_pages(dio->atomic_bio, i);
> > > +		if (!ret) {
> > > +			copied = dio->atomic_bio->bi_iter.bi_size -
> > > +				orig_atomic_size;
> > > +		}
> > > -	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
> > > +		dio->size += copied;
> > > +		goto out;
> > > +	}
> > > +
> > > +	nr_pages = bio_iov_vecs_to_alloc(i, BIO_MAX_VECS);
> > >   	do {
> > >   		size_t n;
> > >   		if (dio->error) {
> > > -			iov_iter_revert(dio->submit.iter, copied);
> > > +			iov_iter_revert(i, copied);
> > >   			copied = ret = 0;
> > >   			goto out;
> > >   		}
> > > -		bio = iomap_dio_alloc_bio(iter, dio, nr_pages, bio_opf);
> > > +		bio = iomap_dio_alloc_bio_data(iter, dio, nr_pages, bio_opf, pos);
> > >   		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> > >   					  GFP_KERNEL);
> > > -		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
> > > -		bio->bi_write_hint = inode->i_write_hint;
> > > -		bio->bi_ioprio = dio->iocb->ki_ioprio;
> > > -		bio->bi_private = dio;
> > > -		bio->bi_end_io = iomap_dio_bio_end_io;
> > 
> > I see two places (here and iomap_dio_zero) that allocate a bio and
> > perform some initialization of it.  Can you move the common pieces to
> > iomap_dio_alloc_bio instead of adding a iomap_dio_alloc_bio_data
> > variant, and move all that to a separate cleanup patch?
> 
> Sure
> 
> So can it cause harm if we set bio->bi_write_hint and ->bi_ioprio with the
> same values as iomap_dio_alloc_bio() for iomap_dio_zero()? If no, this would
> help make all the bio alloc code common

I'd leave the bi_write_hint and bi_ioprio initialization out of the
common function.

--D

> > 
> > > -		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
> > > +		ret = bio_iov_iter_get_pages(bio, i);
> > >   		if (unlikely(ret)) {
> > >   			/*
> > >   			 * We have to stop part way through an IO. We must fall
> > > @@ -408,8 +470,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >   		dio->size += n;
> > >   		copied += n;
> > > -		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
> > > -						 BIO_MAX_VECS);
> > > +		nr_pages = bio_iov_vecs_to_alloc(i, BIO_MAX_VECS);
> > >   		/*
> > >   		 * We can only poll for single bio I/Os.
> > >   		 */
> > > @@ -435,7 +496,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >   	}
> > >   out:
> > >   	/* Undo iter limitation to current extent */
> > > -	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
> > > +	iov_iter_reexpand(i, orig_count - copied);
> > >   	if (copied)
> > >   		return copied;
> > >   	return ret;
> > > @@ -555,6 +616,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > >   	struct blk_plug plug;
> > >   	struct iomap_dio *dio;
> > >   	loff_t ret = 0;
> > > +	size_t orig_count = iov_iter_count(iter);
> > >   	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
> > > @@ -580,6 +642,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > >   	if (iocb->ki_flags & IOCB_NOWAIT)
> > >   		iomi.flags |= IOMAP_NOWAIT;
> > > +	if (iocb->ki_flags & IOCB_ATOMIC) {
> > > +		if (bio_iov_vecs_to_alloc(iter, INT_MAX) > BIO_MAX_VECS)
> > > +			return ERR_PTR(-EINVAL);
> > > +		iomi.flags |= IOMAP_ATOMIC;
> > > +	}
> > > +	dio->atomic_bio = NULL;
> > > +
> > >   	if (iov_iter_rw(iter) == READ) {
> > >   		/* reads can always complete inline */
> > >   		dio->flags |= IOMAP_DIO_INLINE_COMP;
> > > @@ -665,6 +734,21 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > >   		iocb->ki_flags &= ~IOCB_HIPRI;
> > >   	}
> > > +	if (iocb->ki_flags & IOCB_ATOMIC) {
> > > +		if (ret >= 0) {
> > > +			if (dio->size == orig_count) {
> > > +				iomap_dio_submit_bio(&iomi, dio,
> > > +					dio->atomic_bio, iocb->ki_pos);
> > 
> > Does this need to do task_io_account_write like regular direct writes
> > do?
> 
> yes, I missed that, will fix
> 
> > 
> > > +			} else {
> > > +				if (dio->atomic_bio)
> > > +					bio_put(dio->atomic_bio);
> > > +				ret = -EINVAL;
> > > +			}
> > > +		} else if (dio->atomic_bio) {
> > > +			bio_put(dio->atomic_bio);
> > 
> > This ought to null out dio->atomic_bio to prevent accidental UAF.
> 
> ok, fine
> 
> Thanks,
> John
> 

