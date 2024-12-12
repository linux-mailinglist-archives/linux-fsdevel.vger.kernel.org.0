Return-Path: <linux-fsdevel+bounces-37231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390DC9EFD8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 21:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D000188E70A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 20:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901461AD41F;
	Thu, 12 Dec 2024 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+tfm9Hw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FB41422D4;
	Thu, 12 Dec 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734036010; cv=none; b=rfNLE/kWA7xyu0xyYQQEW/1cA5hWuyQ/7M37ppbzsNzWEbWNI86jWjYRMMrKJ4+z4nJm+uliO4mIyI5Vq2KgYvhzxXbtbYhI52P/zhFAAWZ8NiHzuXtRyoBnjuJo2rsAz5nfzK2Dwi0DIMw4xNWamGN35XVe2y9v0RUlhJygYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734036010; c=relaxed/simple;
	bh=3JXAd2s9J/3wCUOsK66MJBoOzwvpB3DcCJAiBMH3CJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4U1rtJrcR02zzzWho2AEn522hSp83FhUFI1bGdxAh6dCwXvmwhyDaP8oSmiZxgx06sEPMvUhXlPICtFbwHkRaue1BCprc+vOZRviemwF3gaTcGMXhYTVo5T9mqZaD11f3luyf9veSr3oOLkHeqL78fuWAPwkOiXKGoGDoagimo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+tfm9Hw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D1FC4CED0;
	Thu, 12 Dec 2024 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734036008;
	bh=3JXAd2s9J/3wCUOsK66MJBoOzwvpB3DcCJAiBMH3CJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+tfm9HwbRWaOK+2GWvAqvFXLDq/nmlnhjcfzJcYgkyTgY2MNgD4Dlk4kSScaO6fi
	 6IhJ+1ICiDmp2eBDjbFtnR6IxuxWztOdRVU8A8BNLzW82Gt66WbwiEARWXNaULIN41
	 uIDDkWuhzipmo04OFyKlp4qHw4o4FWvUrg6zObQHGKEAYIUzr60C7qiIP5Z6g1qk9/
	 apGLkpi+XlzaivrT+iedAxaikKSR8pSDG74SIPrb/gmQNZ5QdoFNEQgYLwzDAXdi7r
	 26HNv3krClaXyRdJuz+5ZzyDF0qoZFotaTWg1Qb6i15Du6Tare8d2Fk00x56cpTlAu
	 VuGfzxcISL4AA==
Date: Thu, 12 Dec 2024 12:40:07 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH v2 2/7] iomap: Add zero unwritten mappings dio support
Message-ID: <20241212204007.GL6678@frogsfrogsfrogs>
References: <20241210125737.786928-1-john.g.garry@oracle.com>
 <20241210125737.786928-3-john.g.garry@oracle.com>
 <20241211234748.GB6678@frogsfrogsfrogs>
 <4d34e14f-6596-483b-86e8-d4b7e44acd9a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d34e14f-6596-483b-86e8-d4b7e44acd9a@oracle.com>

On Thu, Dec 12, 2024 at 10:40:15AM +0000, John Garry wrote:
> On 11/12/2024 23:47, Darrick J. Wong wrote:
> > On Tue, Dec 10, 2024 at 12:57:32PM +0000, John Garry wrote:
> > > For atomic writes support, it is required to only ever submit a single bio
> > > (for an atomic write).
> > > 
> > > Furthermore, currently the atomic write unit min and max limit is fixed at
> > > the FS block size.
> > > 
> > > For lifting the atomic write unit max limit, it may occur that an atomic
> > > write spans mixed unwritten and mapped extents. For this case, due to the
> > > iterative nature of iomap, multiple bios would be produced, which is
> > > intolerable.
> > > 
> > > Add a function to zero unwritten extents in a certain range, which may be
> > > used to ensure that unwritten extents are zeroed prior to issuing of an
> > > atomic write.
> > 
> > I still dislike this.  IMO block untorn writes _is_ a niche feature for
> > programs that perform IO in large blocks.  Any program that wants a
> > general "apply all these updates or none of them" interface should use
> > XFS_IOC_EXCHANGE_RANGE since it has no awu_max restrictions, can handle
> > discontiguous update ranges, doesn't require block alignment, etc.
> 
> That is not a problem which I am trying to solve. Indeed atomic writes are
> for fixed blocks of data and not atomic file updates.

Agreed.

> However, I still think that we should be able to atomic write mixed extents,
> even though it is a pain to implement. To that end, I could be convinced
> again that we don't require it...

Well... if you /did/ add a few entries to include/uapi/linux/fs.h for
ways that an untorn write can fail, then we could define the programming
interface as so:

"If you receive -EBADMAP, then call fallocate(FALLOC_FL_MAKE_OVERWRITE)
to force all the mappings to pure overwrites."

...since there have been a few people who have asked about that ability
so that they can write+fdatasync without so much overhead from file
metadata updates.

> > 
> > Instead here we are adding a bunch of complexity, and not even all that
> > well:
> > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/iomap/direct-io.c  | 76 +++++++++++++++++++++++++++++++++++++++++++
> > >   include/linux/iomap.h |  3 ++
> > >   2 files changed, 79 insertions(+)
> > > 
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index 23fdad16e6a8..18c888f0c11f 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -805,6 +805,82 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > >   }
> > >   EXPORT_SYMBOL_GPL(iomap_dio_rw);
> > > +static loff_t
> > > +iomap_dio_zero_unwritten_iter(struct iomap_iter *iter, struct iomap_dio *dio)
> > > +{
> > > +	const struct iomap *iomap = &iter->iomap;
> > > +	loff_t length = iomap_length(iter);
> > > +	loff_t pos = iter->pos;
> > > +
> > > +	if (iomap->type == IOMAP_UNWRITTEN) {
> > > +		int ret;
> > > +
> > > +		dio->flags |= IOMAP_DIO_UNWRITTEN;
> > > +		ret = iomap_dio_zero(iter, dio, pos, length);
> > 
> > Shouldn't this be detecting the particular case that the mapping for the
> > kiocb is in mixed state and only zeroing in that case?  This just
> > targets every unwritten extent, even if the unwritten extent covered the
> > entire range that is being written.
> 
> Right, so I did touch on this in the final comment in patch 4/7 commit log.
> 
> Why I did it this way? I did not think that it made much difference, since
> this zeroing would be generally a one-off and did not merit even more
> complexity to implement.

The trouble is, if you fallocate the whole file and then write an
aligned 64k block, this will write zeroes to the block, update the
mapping, and only then issue the untorn write.  Sure that's a one time
performance hit, but probably not a welcome one.

> > It doesn't handle COW, it doesn't
> 
> Do we want to atomic write COW?

I don't see why not -- if there's a single COW mapping for the whole
untorn write, then the data gets written to the media in an untorn
fashion, and the remap is a single transaction.

> > handle holes, etc.
> 
> I did test hole, and it seemed to work. However I noticed that for a hole
> region we get IOMAP_UNWRITTEN type, like:

Oh right, that's ->iomap_begin allocating an unwritten extent into the
hole, because you're not allowed to specify a hole for the destination
of a write.  I withdraw that part of the comment.

> # xfs_bmap -vvp /root/mnt/file
> /root/mnt/file:
>  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>    0: [0..127]:        192..319          0 (192..319)         128 000000
>    1: [128..255]:      hole                                   128
>    2: [256..383]:      448..575          0 (448..575)         128 000000
>  FLAG Values:
>     0100000 Shared extent
>     0010000 Unwritten preallocated extent
>     0001000 Doesn't begin on stripe unit
>     0000100 Doesn't end   on stripe unit
>     0000010 Doesn't begin on stripe width
>     0000001 Doesn't end   on stripe width
> #
> #
> 
> For an atomic wrote of length 65536 @ offset 65536.
> 
> Any hint on how to create a iomap->type == IOMAP_HOLE?
> 
> > Also, can you make a version of blkdev_issue_zeroout that returns the
> > bio so the caller can issue them asynchronously instead of opencoding
> > the bio_alloc loop in iomap_dev_zero?
> 
> ok, fine
> 
> > 
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	dio->size += length;
> > > +
> > > +	return length;
> > > +}
> > > +
> > > +ssize_t
> > > +iomap_dio_zero_unwritten(struct kiocb *iocb, struct iov_iter *iter,
> > > +		const struct iomap_ops *ops, const struct iomap_dio_ops *dops)
> > > +{
> > > +	struct inode *inode = file_inode(iocb->ki_filp);
> > > +	struct iomap_dio *dio;
> > > +	ssize_t ret;
> > > +	struct iomap_iter iomi = {
> > > +		.inode		= inode,
> > > +		.pos		= iocb->ki_pos,
> > > +		.len		= iov_iter_count(iter),
> > > +		.flags		= IOMAP_WRITE,
> > 
> > IOMAP_WRITE | IOMAP_DIRECT, no?
> 
> yes, I'll fix that.
> 
> And I should also set IOMAP_DIO_WRITE for dio->flags.

<nod>

--D

> Thanks,
> John
> 

