Return-Path: <linux-fsdevel+bounces-73606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C26D1CA04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A85930388B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E6D36657B;
	Wed, 14 Jan 2026 06:02:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE8934D3B6;
	Wed, 14 Jan 2026 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768370547; cv=none; b=OPd7PLcTh/cFp7kxjA4HxW2J9Py/o6tYgbgR5CPyxHPJDDJLydUuY4tHmnyFTdncm0CE+Pvjl4x84Kaaltk3g4vu3W4TldSGAuohej74nDM6/TwIxwvMYOIt7ukZge9SVy7PRB/8KOBaTJOSLLgD0TvpqvSTzIpNNAtp7q1eOvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768370547; c=relaxed/simple;
	bh=mhOChSG+AU7XbWnntZlRA9SUUTijr6y6Q+4tfIQ3ugQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZPAtxpUmMc/2ClYEBmDxo6w2FbkyGuyhZxD8TrCgbnXNiQ8/w8NpBk27CNbgMJq6JtF8KsUsgm+/Je3enyOn6dsbxePWfAS7Jlqe2tGC+IFLjFUqgSqn9mnLIWAm7x3hAGEXzm/n7VWxXbhQva1cmG/qppnIt8pZy0R7QAIKS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 61DB7227A8E; Wed, 14 Jan 2026 07:02:14 +0100 (CET)
Date: Wed, 14 Jan 2026 07:02:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/11] xfs: add media verification ioctl
Message-ID: <20260114060214.GA10372@lst.de>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs> <176826412941.3493441.8359506127711497025.stgit@frogsfrogsfrogs> <20260113155701.GA3489@lst.de> <20260113232113.GD15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113232113.GD15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 13, 2026 at 03:21:13PM -0800, Darrick J. Wong wrote:
> > > +#define XFS_VERIFY_TO_EOD	(~0ULL)	/* end of disk */
> > 
> > Is there much of a point in this flag?  scrub/healer really should
> > know the device size, shouldn't they?
> 
> Yes, scrub and healer both know the size they want to verify.  I put
> that in for the sake of xfs_io so that it wouldn't have to figure out
> the device size, but as the ioctl always decreases @end_daddr to the
> actual EOD, I think it'd be ok if xfs_io blindly wrote in ~0ULL.

That's the best of both worlds.

> > > +	const unsigned int	iosize = BIO_MAX_VECS << PAGE_SHIFT;
> > > +	unsigned int		bufsize = iosize;
> > 
> > That's a pretty gigantic buffer size.  In general a low number of
> > MB should max out most current devices, and for a background scrub
> > you generally do not want to actually max out the device..
> 
> 256 * 4k (= 1MB) is too large a buffer?

No, my reading comprehension just sucks :)  And of course the way
it's written isn't very helpful either.

> I guess that /is/ 16M on a 64k-page system.

Yeah, just stick to SZ_1M.

> > > +				min(nr_sects, bufsize >> SECTOR_SHIFT);
> > > +
> > > +			bio_add_folio_nofail(bio, folio,
> > > +					vec_sects << SECTOR_SHIFT, 0);
> > > +
> > > +			bio_daddr += vec_sects;
> > > +			bio_bbcount -= vec_sects;
> > > +			bio_submitted += vec_sects;
> > > +		}
> > 
> > A single folio is always just a single vetor in the bio.  No need
> > for any of the looping here.
> 
> If we have to fall back to a single base page, shouldn't we still try to
> create a larger bio?

How do you create a larger bio if you only have a single bio available?

> A subtle assumption here is that it's ok to have
> all the bvecs pointing to the same memory, and that the device won't
> screw up if someone asks it to DMA to the same page simultaneously.

Ooooh.  Yes, that will screw up badly when using PI.

> > > +		/* Don't let too many IOs accumulate */
> > > +		if (bio_submitted > SZ_256M >> SECTOR_SHIFT) {
> > > +			blk_finish_plug(&plug);
> > > +			error = submit_bio_wait(bio);
> > 
> > Also the building up and chaining here seems harmful.  If you're
> > on SSDs you want to fire things off ASAP if you have large I/O.
> > On a HDD we'll take care of it below, but the bios will usually
> > actually be split, not merged anyway as they are beyond the
> > supported I/O size of the HBAs.
> 
> Hrm, maybe I should query the block device for max_sectors_kb then?

No.  max_sectors_kb is kida stupid.  I think a sensible default and
a tunable is a better choice here at least for now.

> However, in the case where memory is fragmented and we can only get
> (say) a single base page, it'll still try to load up the bio with as
> many vecs as it can to try to keep the io size large, because issuing
> 256x 4k IOs is a lot slower than issuing 1x 1M IO with the same page
> added 256 times.

Yeah.  But seriously, if the MM is pretty good and is getting better
at finding large allocations.  We need to start relying on that.

> I wonder if nr_vecs ought to be capped by queue_max_segments?

No, leave all that splitting to the block layer.  max_segments is
an implementation detail.


