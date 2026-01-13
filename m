Return-Path: <linux-fsdevel+bounces-73517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C546DD1BAF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 00:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 766053006E1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 23:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA7F35EDD2;
	Tue, 13 Jan 2026 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PioHGiMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B3B241690;
	Tue, 13 Jan 2026 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346474; cv=none; b=lBPJEZzvEBAe74IzQFXyP+ls+593xtVzJZYUNqTyyTV0z5lw2XSeHOH2kZChIcTQjDLuVib7Kd9UN6oTW7Y9nYJNA70lY+pHmvQdt647Wq1vHyV6aBil9hB7XlcUTLynVjTf7N2Vp5NokdCdxCZP8cRas8vWH+kz/UwaE6xOBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346474; c=relaxed/simple;
	bh=UsNDol6n9tcvpC/ws30F5OOraDnyBN5fhodZEr2rS6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxDMXnSApKzsJf/aSsup6BaGmRuIAaECJpJqpaYqTgQwD1Ue27a9CnF3umh+mQmVNnTsXW2tECCJxCWjMvWphCmfonkHZoU7yYbUL9YC3hk2yxiByOU2qSsxfSoWpuNLWMQXy3ezInuzYQTMRlZ1QK1HAP19xDcIv+jZ0y/clAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PioHGiMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C8BC116C6;
	Tue, 13 Jan 2026 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768346474;
	bh=UsNDol6n9tcvpC/ws30F5OOraDnyBN5fhodZEr2rS6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PioHGiMVf1SW4n3Uz5896+9PHlkJAQhRpvTN7831D46CifFGng2/J7ckCbuSfsETF
	 Mw+zoB+3lQE/0ES5cj//pNAGRCUx/TVFf2kmyTzcapVjACyLNX+yo0RREwmlC9a1Eh
	 vvN8kQ5lYwGq8T4BdNg/geuJUbgl1ygXD9zmNBo+D7Np9azXBFiiYpbOlchquOcoJX
	 giR043uAn2FX3qTsEawWXnbjvcwoT+BwxE3QuFFhzWSHOyX4GDSowSxTnw5FCARA7E
	 O7/EIDLGNVNXUjg+TaXntSdNUfcsvd0gXMYBY+9zWpY94m54qBkV7yMy2gOTcU87HX
	 KogRwAm+YwNOQ==
Date: Tue, 13 Jan 2026 15:21:13 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/11] xfs: add media verification ioctl
Message-ID: <20260113232113.GD15551@frogsfrogsfrogs>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
 <176826412941.3493441.8359506127711497025.stgit@frogsfrogsfrogs>
 <20260113155701.GA3489@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113155701.GA3489@lst.de>

On Tue, Jan 13, 2026 at 04:57:01PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 12, 2026 at 04:35:25PM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Add a new privileged ioctl so that xfs_scrub can ask the kernel to
> > verify the media of the devices backing an xfs filesystem, and have any
> > resulting media errors reported to fsnotify and xfs_healer.
> 
> Hmm, the description is a bit sparse?
> 
> > +/* Verify the media of the underlying devices */
> > +struct xfs_verify_media {
> > +	__u32	dev;		/* I: XFS_VERIFY_*DEV */
> 
> This should probably use the enum xfs_device values?

Yes, that's a good point.

> > +#define XFS_VERIFY_TO_EOD	(~0ULL)	/* end of disk */
> 
> Is there much of a point in this flag?  scrub/healer really should
> know the device size, shouldn't they?

Yes, scrub and healer both know the size they want to verify.  I put
that in for the sake of xfs_io so that it wouldn't have to figure out
the device size, but as the ioctl always decreases @end_daddr to the
actual EOD, I think it'd be ok if xfs_io blindly wrote in ~0ULL.

> > diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> > index 1edc4ddd10cdb2..5ef4109cc062d2 100644
> > --- a/fs/xfs/xfs_notify_failure.c
> > +++ b/fs/xfs/xfs_notify_failure.c
> 
> There's basically no overlap with the existing code in this file,
> why not add a new one?

Good idea!  I didn't even realize that it shares nothing now.

> > +	const unsigned int	iosize = BIO_MAX_VECS << PAGE_SHIFT;
> > +	unsigned int		bufsize = iosize;
> 
> That's a pretty gigantic buffer size.  In general a low number of
> MB should max out most current devices, and for a background scrub
> you generally do not want to actually max out the device..

256 * 4k (= 1MB) is too large a buffer?

I guess that /is/ 16M on a 64k-page system.

Maybe I need to reset my expectations. :)

> The in the background is also a good point here - we probably want
> a way to tune the size as it might put too much of a load onto the
> system pretty easily, and we need a way to dial it back.

I guess I could add a u32 max_io_size to constrain iosize; and a u16
rest_us that would enforce a sleep in between each submit_bio.

For xfs_scrub@.service I rely on systemd to set the io and cpu priority
and the kernel not to schedule xfs_scrub for resource usage control.

> > +	folio = folio_alloc(GFP_KERNEL, get_order(bufsize));
> > +	if (!folio)
> 
> That first folio_alloc will cause nasty stack traces when it fails.
> 
> > +		folio = folio_alloc(GFP_KERNEL, 0);
> 
> .. and then we fall back to just a single page.  This is what I ended
> up writing for an about to submitted series elsewhere:
> 
> static struct folio *folio_alloc_greedy(gfp_t gfp, size_t *size)
> {
>         struct folio *folio;
>                 
>         while (*size > PAGE_SIZE) {
>                 folio = folio_alloc(gfp | __GFP_NORETRY, get_order(*size));
>                 if (folio)
>                         return folio;
>                 *size = rounddown_pow_of_two(*size - 1);
>         }
> 
>         return folio_alloc(gfp, get_order(*size));
> }               

<nod>

> although that is a bit more complicated as we never want to round
> up the actual size.

I made a simpler version that does

for (order = get_order(); order > 0; order--)
	folio = folio_alloc(...);


> > +		for (i = 0; i < nr_vecs; i++) {
> > +			unsigned int	vec_sects =
> > +				min(nr_sects, bufsize >> SECTOR_SHIFT);
> > +
> > +			bio_add_folio_nofail(bio, folio,
> > +					vec_sects << SECTOR_SHIFT, 0);
> > +
> > +			bio_daddr += vec_sects;
> > +			bio_bbcount -= vec_sects;
> > +			bio_submitted += vec_sects;
> > +		}
> 
> A single folio is always just a single vetor in the bio.  No need
> for any of the looping here.

If we have to fall back to a single base page, shouldn't we still try to
create a larger bio?  A subtle assumption here is that it's ok to have
all the bvecs pointing to the same memory, and that the device won't
screw up if someone asks it to DMA to the same page simultaneously.

Obviously that all goes away with REQ_OP_VERIFY.

> > +		/* Don't let too many IOs accumulate */
> > +		if (bio_submitted > SZ_256M >> SECTOR_SHIFT) {
> > +			blk_finish_plug(&plug);
> > +			error = submit_bio_wait(bio);
> 
> Also the building up and chaining here seems harmful.  If you're
> on SSDs you want to fire things off ASAP if you have large I/O.
> On a HDD we'll take care of it below, but the bios will usually
> actually be split, not merged anyway as they are beyond the
> supported I/O size of the HBAs.

Hrm, maybe I should query the block device for max_sectors_kb then?

Though curiously the nvme devices all report 128K for that, and the
spinning rust reports 1M.

Anyway I've changed the loop body to allocate a bio, add up to iosize
worth of meory to it, submit it, and wait.  This avoids building up huge
chains of bios, and now I ask the device what's the biggest IO that it
supports:

iosize = min(queue_max_bytes(bdev_get_queue(btp->bt_bdev)), SZ_1M);
if (me->me_maxio && iosize > me->me_maxio)
	iosize = me->me_maxio;
if (iosize < SECTOR_SIZE)
	iosize = SECTOR_SIZE;

...

while (bio_bbcount > 0) {
	struct bio		*bio;
	unsigned int		nr_sects =
		min_t(sector_t, bio_bbcount, iosize >> SECTOR_SHIFT);
	const unsigned int	nr_vecs =
		howmany(nr_sects << SECTOR_SHIFT, bufsize);
	unsigned int		bio_submitted = 0;
	unsigned int		i;

	bio = bio_alloc(btp->bt_bdev, nr_vecs, REQ_OP_READ, GFP_KERNEL);
	if (!bio) {
		error = -ENOMEM;
		break;
	}
	bio->bi_iter.bi_sector = bio_daddr;

	for (i = 0; i < nr_vecs; i++) {
		unsigned int	vec_sects =
			min(nr_sects, bufsize >> SECTOR_SHIFT);

		bio_add_folio_nofail(bio, folio,
				vec_sects << SECTOR_SHIFT, 0);

		bio_daddr += vec_sects;
		bio_bbcount -= vec_sects;
		bio_submitted += vec_sects;
	}

	error = submit_bio_wait(bio);
	bio_put(bio);
	bio = NULL;
	if (error) {
		xfs_verify_media_error(mp, me, btp, fdev,
				new_start_daddr, bio_submitted, error);
		error = 0;
		break;
	}

	cond_resched();
	new_start_daddr += bio_submitted;
}

The only downside of this simple loop is that we can't pipeline read
requests, but maybe we don't want to flood the device with IO requests
anyway.

However, in the case where memory is fragmented and we can only get
(say) a single base page, it'll still try to load up the bio with as
many vecs as it can to try to keep the io size large, because issuing
256x 4k IOs is a lot slower than issuing 1x 1M IO with the same page
added 256 times.

I wonder if nr_vecs ought to be capped by queue_max_segments?

--D

