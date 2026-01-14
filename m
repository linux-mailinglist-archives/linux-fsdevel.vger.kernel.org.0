Return-Path: <linux-fsdevel+bounces-73607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD28D1CA1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AB1030BB860
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE1923741;
	Wed, 14 Jan 2026 06:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dn7/THjn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2E2C3259;
	Wed, 14 Jan 2026 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768370826; cv=none; b=XNPULUJ8pXR78AFaw6p/738gy0UqFq0qS12LNFIx32hPFGGuGKLe1mri4+bG7GiUsabK6svzUPWc2vXv42WcpZZ3Iox6SAyT8h1WggY10W+jQ6Qguajx8qgc6uO2Ut8DtRRrp5JqxpAXUG5ReJqoa5gcHfu5o4RIqudTNnhnxtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768370826; c=relaxed/simple;
	bh=Xf9uksS3zoq5XqYQ35F9CpTGc5iGqiKWSA0eGEmeyc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqB41TyRukH89OsnZKbj9b5W7KK8TNJ97UOWIc7BK8nYeKzJ7LJK7cXMKH9e0J5IWiK6cYAnusW5HsQnVoIX/9peA0CuH16YCt8OI9A/cIUHBd9N+qxLlTsnQo9nXVu6q6+PXLGvbtJElIrODO5vq/nRcoYnArncNYQ7xn3zZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dn7/THjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86352C4CEF7;
	Wed, 14 Jan 2026 06:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768370826;
	bh=Xf9uksS3zoq5XqYQ35F9CpTGc5iGqiKWSA0eGEmeyc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dn7/THjnQwU/SscEjLyb0EDNaalOH6hGbJjobdPWRP1Fn9jr15lU39fB84ncST1/E
	 d0vmsApcInoPWpifJgNZcNd1rF+/gX3R6srWb2YH9GqCkscq+DODLLDxl1N+KDgvPB
	 OU1A5WeHgl4mwPEVkjGUJj8QbnHVLYdSo0QIIhGjqKdaqNF8te95qTUZjPBIjO/lNV
	 WFZ3LtlbXGvmCTV6pe3XU2434QDC8wxQ0OSRzPD0KA3/QISr/hcYeWR59+kXRmnWXC
	 DlakT0HR45eQ+l5hmN88aGGZrLqwhplL6LcKYOiEbJ3if0OcSM5/P81+n1gwCG575G
	 pmG5MTNPmzd0g==
Date: Tue, 13 Jan 2026 22:07:05 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/11] xfs: add media verification ioctl
Message-ID: <20260114060705.GK15583@frogsfrogsfrogs>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
 <176826412941.3493441.8359506127711497025.stgit@frogsfrogsfrogs>
 <20260113155701.GA3489@lst.de>
 <20260113232113.GD15551@frogsfrogsfrogs>
 <20260114060214.GA10372@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114060214.GA10372@lst.de>

On Wed, Jan 14, 2026 at 07:02:14AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 13, 2026 at 03:21:13PM -0800, Darrick J. Wong wrote:
> > > > +#define XFS_VERIFY_TO_EOD	(~0ULL)	/* end of disk */
> > > 
> > > Is there much of a point in this flag?  scrub/healer really should
> > > know the device size, shouldn't they?
> > 
> > Yes, scrub and healer both know the size they want to verify.  I put
> > that in for the sake of xfs_io so that it wouldn't have to figure out
> > the device size, but as the ioctl always decreases @end_daddr to the
> > actual EOD, I think it'd be ok if xfs_io blindly wrote in ~0ULL.
> 
> That's the best of both worlds.
> 
> > > > +	const unsigned int	iosize = BIO_MAX_VECS << PAGE_SHIFT;
> > > > +	unsigned int		bufsize = iosize;
> > > 
> > > That's a pretty gigantic buffer size.  In general a low number of
> > > MB should max out most current devices, and for a background scrub
> > > you generally do not want to actually max out the device..
> > 
> > 256 * 4k (= 1MB) is too large a buffer?
> 
> No, my reading comprehension just sucks :)  And of course the way
> it's written isn't very helpful either.
> 
> > I guess that /is/ 16M on a 64k-page system.
> 
> Yeah, just stick to SZ_1M.

Ok, will do.

> > > > +				min(nr_sects, bufsize >> SECTOR_SHIFT);
> > > > +
> > > > +			bio_add_folio_nofail(bio, folio,
> > > > +					vec_sects << SECTOR_SHIFT, 0);
> > > > +
> > > > +			bio_daddr += vec_sects;
> > > > +			bio_bbcount -= vec_sects;
> > > > +			bio_submitted += vec_sects;
> > > > +		}
> > > 
> > > A single folio is always just a single vetor in the bio.  No need
> > > for any of the looping here.
> > 
> > If we have to fall back to a single base page, shouldn't we still try to
> > create a larger bio?
> 
> How do you create a larger bio if you only have a single bio available?
> 
> > A subtle assumption here is that it's ok to have
> > all the bvecs pointing to the same memory, and that the device won't
> > screw up if someone asks it to DMA to the same page simultaneously.
> 
> Ooooh.  Yes, that will screw up badly when using PI.

DOH!  I forgot about that.

Yep, that's correct.  I'll change the code to one folio, one bio. 

> > > > +		/* Don't let too many IOs accumulate */
> > > > +		if (bio_submitted > SZ_256M >> SECTOR_SHIFT) {
> > > > +			blk_finish_plug(&plug);
> > > > +			error = submit_bio_wait(bio);
> > > 
> > > Also the building up and chaining here seems harmful.  If you're
> > > on SSDs you want to fire things off ASAP if you have large I/O.
> > > On a HDD we'll take care of it below, but the bios will usually
> > > actually be split, not merged anyway as they are beyond the
> > > supported I/O size of the HBAs.
> > 
> > Hrm, maybe I should query the block device for max_sectors_kb then?
> 
> No.  max_sectors_kb is kida stupid.  I think a sensible default and
> a tunable is a better choice here at least for now.

<nod> I'll set iosize to 1MB by default and userspace can decrease it if
it so desires.

Also it occurs to me that max_hw_sectors_kb seems to be 128K for all of
my consumer nvme devices, and the fancy Intel ones too.  Funny that the
sata ssds set it to 4MB, but I guess capping at 128k is one way to
reduce the command latency...?  (Or the kernel's broken?  I can't figure
out how to get mpsmin with nvme-cli...)

> > However, in the case where memory is fragmented and we can only get
> > (say) a single base page, it'll still try to load up the bio with as
> > many vecs as it can to try to keep the io size large, because issuing
> > 256x 4k IOs is a lot slower than issuing 1x 1M IO with the same page
> > added 256 times.
> 
> Yeah.  But seriously, if the MM is pretty good and is getting better
> at finding large allocations.  We need to start relying on that.
> 
> > I wonder if nr_vecs ought to be capped by queue_max_segments?
> 
> No, leave all that splitting to the block layer.  max_segments is
> an implementation detail.

Will do.  Only using the folio once per bio will make the control loop
easier to understand too.

--D

