Return-Path: <linux-fsdevel+bounces-28095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363FA966D09
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 01:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71E81F243D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 23:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991EF18FDD7;
	Fri, 30 Aug 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNxqSu4R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92114AD38;
	Fri, 30 Aug 2024 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725062183; cv=none; b=mMJFeTT7H9djF2nqUDWeLRYQFf8a25Re7X2trenC2ENYs+QYv6uhXIpXjrB/V5i50NeZnMFJjVgpbTGMZ3qfrmKrSvTXGstHznJcMk4rcxdsXsVTannW5Yl6moJ9Si6vyhjytPrAxOPJe0Qa7ZKaMJnC3tJ8HVQ02+9FFcagL6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725062183; c=relaxed/simple;
	bh=pbFRQTG3rbv8AkxuMR0tvTGJyrk4wg2skLcT7z9reuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxaGzNCZKC2j8U/q4gd4goTuxrNCVF+TwOx0JsxZIVsVkhSVzfjmJSqoux1PWCKU6PqP9KP83QUtSByQgK5bOzyoU72/G90eZ4nyp9tWmdvcPcRWMJFVf/TB0H0Dh8mUZLlGo1Fp/UtvKxpGurOXRbuWXgB010kXL4srhmfMJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNxqSu4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649E4C4CEC2;
	Fri, 30 Aug 2024 23:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725062182;
	bh=pbFRQTG3rbv8AkxuMR0tvTGJyrk4wg2skLcT7z9reuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNxqSu4R2RXwfm3i1v+v0kcHeNf2XDM39kZJuuYNTOFXW5TNbH1tlB56L288jy9e/
	 4J323pD8XvKLSsepz7ImyShHz08EM6SOzXu3avEMeV/vaFDgJ5akE2UZErUrG+TzZN
	 DTgt7XFgixSvvf9coIcf/sZujl6WZI7nUy/P+hw0tOP3fRob/aDXqyA/d4cE4MPb4i
	 F2MI5hVzFNAYCeG4G1r/3y9+LHWTVTfLJT0gP0qqUGM7ecc8lo+W9rrvpB42vLMHRB
	 g2sLQ80L0/+aUD7iF4RrhMhJax8r4faYX2e5oTPTpu1CA6u+VJjOLCyPVMZAQTMPwE
	 WZCGWWRZpChiw==
Date: Fri, 30 Aug 2024 16:56:21 -0700
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
Message-ID: <20240830235621.GS6216@frogsfrogsfrogs>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-4-john.g.garry@oracle.com>
 <20240821165803.GI865349@frogsfrogsfrogs>
 <a91557d2-95d4-4e73-9936-72fc1fbe100f@oracle.com>
 <20240822203058.GR865349@frogsfrogsfrogs>
 <112ec3a6-48b3-4596-9c20-e23288581ffd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112ec3a6-48b3-4596-9c20-e23288581ffd@oracle.com>

On Fri, Aug 30, 2024 at 04:48:36PM +0100, John Garry wrote:
> On 22/08/2024 21:30, Darrick J. Wong wrote:
> > > Then, the iomap->type/flag is either IOMAP_UNWRITTEN/IOMAP_F_DIRTY or
> > > IOMAP_MAPPED/IOMAP_F_DIRTY per iter. So the type is not consistent. However
> > > we will set IOMAP_DIO_UNWRITTEN in dio->flags, so call xfs_dio_write_endio()
> > > -> xfs_iomap_write_unwritten() for the complete FSB range.
> > > 
> > > Do you see a problem with this?
> 
> Sorry again for the slow response.
> 
> > > 
> > > Please see this also for some more background:
> > > https://urldefense.com/v3/__https://lore.kernel.org/linux-
> > > xfs/20240726171358.GA27612@lst.de/__;!!ACWV5N9M2RV99hQ! P5jeP96F8wAtRAblbm8NvRo8nlpil03vA26UMMX8qrYa4IzKecAAk7x1l1M45bBshC3Czxn1CkDXypNSAg$
> > Yes -- if you have a mix of written and unwritten blocks for the same
> > chunk of physical space:
> > 
> > 0      7
> > WUWUWUWU
> > 
> > the directio ioend function will start four separate transactions to
> > convert blocks 1, 3, 5, and 7 to written status.  If the system crashes
> > midway through, they will see this afterwards:
> > 
> > WWWWW0W0
> > 
> > IOWs, although the*disk write* was completed successfully, the mapping
> > updates were torn, and the user program sees a torn write.
> > > The most performant/painful way to fix this would be to make the whole
> > ioend completion a logged operation so that we could commit to updating
> > all the unwritten mappings and restart it after a crash.
> 
> could we make it logged for those special cases which we are interested in
> only?

Yes, though this is the long route -- you get to define a new ondisk log
item, build all the incore structures to process them, and then define a
new high level operation that uses the state encoded in that new log
item to run all the ioend completion transactions within that framework.
Also you get to add a new log incompat feature bit for this.

Perhaps we should analyze the cost of writing and QA'ing all that vs.
the amount of time saved in the handling of this corner case using one
of the less exciting options.

> > The least performant of course is to write zeroes at allocation time,
> > like we do for fsdax.
> 
> That idea was already proposed:
> https://lore.kernel.org/linux-xfs/ZcGIPlNCkL6EDx3Z@dread.disaster.area/

Yes, I'm aware.

> > A possible middle ground would be to detect IOMAP_ATOMIC in the
> > ->iomap_begin method, notice that there are mixed mappings under the
> > proposed untorn IO, and pre-convert the unwritten blocks by writing
> > zeroes to disk and updating the mappings
> 
> Won't that have the same issue as using XFS_BMAPI_ZERO, above i.e. zeroing
> during allocation?

Only if you set the forcealign size to > 1fsb and fail to write new
file data in forcealign units, even for non-untorn writes.  If all
writes to the file are aligned to the forcealign size then there's only
one extent conversion to be done, and that cannot be torn.

> > before handing the one single
> > mapping back to iomap_dio_rw to stage the untorn writes bio.  At least
> > you'd only be suffering that penalty for the (probable) corner case of
> > someone creating mixed mappings.
> 
> BTW, one issue I have with the sub-extent(or -alloc unit) zeroing from v4
> series is how the unwritten conversion has changed, like:
> 
> xfs_iomap_write_unwritten()
> {
> 	unsigned int rounding;
> 
> 	/* when converting anything unwritten, we must be spanning an alloc unit,
> so round up/down */
> 	if (rounding > 1) {
> 		offset_fsb = rounddown(rounding);
> 		count_fsb = roundup(rounding);
> 	}
> 
> 	...
> 	do {
> 		xfs_bmapi_write();
> 		...
> 		xfs_trans_commit();
> 	} while ();
> }
> 
> I'm not too happy with it and it seems a bit of a bodge, as I would rather
> we report the complete size written (user data and zeroes); then
> xfs_iomap_write_unwritten() would do proper individual block conversion.
> However, we do something similar for zeroing for sub-FSB writes. I am not
> sure if that is the same thing really, as we only round up to FSB size.
> Opinion?

xfs_iomap_write_unwritten is in the ioend path; that's not what I was
talking about.

I'm talking about a separate change to the xfs_direct_write_iomap_begin
function that would detect the case where the bmapi_read returns an
@imap that doesn't span the whole forcealign region, then repeatedly
calls bmapi_write(BMAPI_ZERO | BMAPI_CONVERT) on any unwritten mappings
within that file range until the original bmapi_read would return a
single written mapping.

--D

> 
> Thanks,
> John
> 
> 
> 

