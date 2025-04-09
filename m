Return-Path: <linux-fsdevel+bounces-46141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 241C0A834CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 01:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97719189BA06
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 23:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4256921D5AA;
	Wed,  9 Apr 2025 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S88rhuDS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6AC1A5BA4;
	Wed,  9 Apr 2025 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242377; cv=none; b=P+svKBYDkAEuA+NxZOSLtJrizvMtfXfbpCftaCXul/IDTsMvHc2HOV/GKlHo0i5cDJhK7nepyJqTlwH+92zUYFrh0nCthlSaLoBC08FYWscWfn4R48XO0B39WWHK0FbQyDsGX5oFa/uRAkepS8hFzqBljIx9NXgJwZViurFlQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242377; c=relaxed/simple;
	bh=D2j6lsQNFmlZkkBdK0jIAElxCCOytoXhhNlTCM+/o8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoTS/dRTjg6NOEGKODRcUYsnunaaXjwdnhLvy53Vt8RPCrbUftr3O2wpqKZKbz/TpEFmBRmpuqN0prfH27NveY0yMnifl2Y46B/ia/sXoMgCrCo3jBKOfwdyc8IPTvFMnMraxWsK4vWcNQ8DMFHPJGY9sK/KnqTxhp3/cRjYTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S88rhuDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE838C4CEE2;
	Wed,  9 Apr 2025 23:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744242376;
	bh=D2j6lsQNFmlZkkBdK0jIAElxCCOytoXhhNlTCM+/o8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S88rhuDSAHF/McWjpYFRPivJaW5VSiRP4cv9eQS1CD+sBV0wFMfTmKDxiWZSKmXi0
	 a7mJPn/AQTaMC9kDP4mCkbAmFgdK8quoZBiBg1IcFs1qBtyzGSXl7cz7lRAiJIOBQ6
	 mzI9sTz8NdeiryYD7GJ/KKL77UPNHuwVEapOu880cmi6AMjF7SAU2lbXZeg3KnE0O4
	 8xZIyLC5/0G7AWhsDZamLFCf5OsyPIvWweWNHnnyhzKcTV4pU8jf3PmKJvJtUN/+HY
	 YxOAoYKDUQGhuGxdVQN18mYtIxrB7HlCd5zfuhu+9Jw+GUK5bPcFQFsdFlds5Cr2n0
	 inWszXvhCXv4A==
Date: Wed, 9 Apr 2025 16:46:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v6 11/12] xfs: add xfs_compute_atomic_write_unit_max()
Message-ID: <20250409234615.GV6283@frogsfrogsfrogs>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
 <20250408104209.1852036-12-john.g.garry@oracle.com>
 <Z_WnbfRhKR6RQsSA@dread.disaster.area>
 <20250409004156.GL6307@frogsfrogsfrogs>
 <Z_YF9HpdbkJDLeuR@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_YF9HpdbkJDLeuR@dread.disaster.area>

On Wed, Apr 09, 2025 at 03:30:28PM +1000, Dave Chinner wrote:
> On Tue, Apr 08, 2025 at 05:41:56PM -0700, Darrick J. Wong wrote:
> > On Wed, Apr 09, 2025 at 08:47:09AM +1000, Dave Chinner wrote:
> > > On Tue, Apr 08, 2025 at 10:42:08AM +0000, John Garry wrote:
> > > > Now that CoW-based atomic writes are supported, update the max size of an
> > > > atomic write for the data device.
> > > > 
> > > > The limit of a CoW-based atomic write will be the limit of the number of
> > > > logitems which can fit into a single transaction.
> > > 
> > > I still think this is the wrong way to define the maximum
> > > size of a COW-based atomic write because it is going to change from
> > > filesystem to filesystem and that variability in supported maximum
> > > length will be exposed to userspace...
> > > 
> > > i.e. Maximum supported atomic write size really should be defined as
> > > a well documented fixed size (e.g. 16MB). Then the transaction
> > > reservations sizes needed to perform that conversion can be
> > > calculated directly from that maximum size and optimised directly
> > > for the conversion operation that atomic writes need to perform.
> > 
> > I'll get to this below...
> 
> I'll paste it here so it's all in one context.
> 
> > This is why I don't agree with adding a static 16MB limit -- we clearly
> > don't need it to emulate current hardware, which can commit up to 64k
> > atomically.  Future hardware can increase that by 64x and we'll still be
> > ok with using the existing tr_write transaction type.
> > 
> > By contrast, adding a 16MB limit would result in a much larger minimum
> > log size.  If we add that to struct xfs_trans_resv for all filesystems
> > then we run the risk of some ancient filesystem with a 12M log failing
> > suddenly failing to mount on a new kernel.
> > 
> > I don't see the point.
> 
> You've got stuck on ithe example size of 16MB I gave, not
> the actual reason I gave that example.

Well you kept saying 16MB, so that's why I ran the numbers on it.

> That is: we should not be exposing some unpredictable, filesystem
> geometry depending maximum atomic size to a userspace API.  We need
> to define a maximum size that we support, that we can clearly
> document and guarantee will work on all filesystem geometries.
> 
> What size that is needs to be discussed - all you've done is
> demonstrate that 16MB would require a larger minimum log size for a
> small set of historic/legacy filesystem configs.

No, I've done more than that.  I've shown that it's possible to
determine the maximum permissible size of a software untorn writes
completions given a log reservation, which means that we can:

1) Determine if we can backstop hardware untorn writes with software
untorn writes.

2) Determine the largest untorn write we can complete in software for
an existing filesystems with no other changes required.

in addition to 3) Determine if we can land an untorn write of a
specific size.

We care about (1).  (2) is basically done (albeit with calculation
errors) by this patchset.  (3) is not something we're interested in.
If you believe that having a fixed upper size bound that isn't tied to
existing log reservations is worth pursuing, then please send patches
building off this series.

I think it wouldn't be much work to have a larger fixed limit that
doesn't depend on any of the existing static transaction reservations.
Use the computation I provided to decide if that limit won't push the
filesystem too close to the maximum transaction size, then dynamically
compute the reservation at ioend time for the specific IO being
completed.

But again, our users don't want that, they're fine with 64k.  They
really don't want the software fallback at all.  If you have users who
prefer a well known static limit, then please work with them.

> I'm actually quite fine with adding new reservations that change
> minimum required log sizes - this isn't a show-stopper in any way.

I'm not convinced.  The minimum log size footgun still exists; it's just
that the new(ish) 64M floor makes it much less likely to happen.  The
image factories have been upgraded with newer xfsprogs so the number of
complaints will (at long last) slowly go down, but 12M logs are still
causing problems.

> Atomic writes are optional functionality, so if the log size is too
> small for the atomic write transaction requirements, then we don't
> enable the atomic write functionality on that filesystem. Hence the
> minimum required log size for the filesystem -does not change- and
> the filesystem mounts as normal..
> 
> i.e. the user hasn't lost anything on these tiny log filesystems
> when the kernel is upgraded to support software atomic writes.
> All that happens is that the legacy filesystem will never support
> atomic writes....
> 
> Such a mount time check allows us to design the atomic write
> functionality around a fixed upper size bound that we can guarantee
> will work correctly. i.e. the size of the transaction reservation
> needed for it is irrelevant because we guarantee to only run that
> transaction on filesytsems with logs large enough to support it.

Yes, that's what I've been trying to say all along.

> Having a consistent maximum atomic write size makes it easier for
> userspace to create logic and algorithms around, and it makes it
> much easier for us to do boundary condition testing as we don't have
> to reverse engineer the expected boundaries from filesysetm geometry
> in test code. Fixed sizes make API verification and testing a whole
> lot simpler.

John added a statx field so that the kernel can advertise the hardware
and software untorn write capabilities.  Are you saying that's not good
enough even for (1) and (2) from above?

If it turns out that users want a higher limit, they can come talk to us
about adding a mkfs option or whatever to declare that they want more,
and then we can enforce that.

> And, finally, if everything is sized from an single API constant, it
> makes it easy to modify the supported size in future. The 64MB
> minimum log size gives us lots of headroom to increase supported
> atomic write sizes, so if userspace finds that it really needs
> larger sizes than what we initially support, it's trivial to change
> both the kernel and the test code to support a larger size...
> 
> > > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > > index b2dd0c0bf509..42b2b7540507 100644
> > > > --- a/fs/xfs/xfs_super.c
> > > > +++ b/fs/xfs/xfs_super.c
> > > > @@ -615,6 +615,28 @@ xfs_init_mount_workqueues(
> > > >  	return -ENOMEM;
> > > >  }
> > > >  
> > > > +unsigned int
> > > > +xfs_atomic_write_logitems(
> > > > +	struct xfs_mount	*mp)
> > > > +{
> > > > +	unsigned int		efi = xfs_efi_item_overhead(1);
> > > > +	unsigned int		rui = xfs_rui_item_overhead(1);
> > > > +	unsigned int		cui = xfs_cui_item_overhead(1);
> > > > +	unsigned int		bui = xfs_bui_item_overhead(1);
> > > > +	unsigned int		logres = M_RES(mp)->tr_write.tr_logres;
> > > > +
> > > > +	/*
> > > > +	 * Maximum overhead to complete an atomic write ioend in software:
> > > > +	 * remove data fork extent + remove cow fork extent +
> > > > +	 * map extent into data fork
> > > > +	 */
> > > > +	unsigned int		atomic_logitems =
> > > > +		(bui + cui + rui + efi) + (cui + rui) + (bui + rui);
> > > 
> > > This seems wrong. Unmap from the data fork only logs a (bui + cui)
> > > pair, we don't log a RUI or an EFI until the transaction that
> > > processes the BUI or CUI actually frees an extent from the the BMBT
> > > or removes a block from the refcount btree.
> > 
> > This is tricky -- the first transaction in the chain creates a BUI and a
> > CUI and that's all it needs.
> > 
> > Then we roll to finish the BUI.  The second transaction needs space for
> > the BUD, an RUI, and enough space to relog the CUI (== CUI + CUD).
> > 
> > Then we roll again to finish the RUI.  This third transaction needs
> > space for the RUD and space to relog the CUI.
> > 
> > Roll again, fourth transaction needs space for the CUD and possibly a
> > new EFI.
> > 
> > Roll again, fifth transaction needs space for an EFD.
> 
> Yes, that is exactly the point I was making.

It's also slightly wrong -- if an extent referenced by the chain isn't
actively being worked on, its BUI/CUI can get relogged.  So the actual
computation is:

	relog = bui + bud + cui + cud;
	per_intent = max(tx0..tx4, relog);

That doesn't seem to change the output though.

> > > > +
> > > > +	/* atomic write limits are always a power-of-2 */
> > > > +	return rounddown_pow_of_two(logres / (2 * atomic_logitems));
> > > 
> > > What is the magic 2 in that division?
> > 
> > That's handwaving the lack of a computation involving
> > xfs_allocfree_block_count.  A better version would be to figure out the
> > log space needed:
> > 
> > 	/* Overhead to finish one step of each intent item type */
> > 	const unsigned int	f1 = libxfs_calc_finish_efi_reservation(mp, 1);
> > 	const unsigned int	f2 = libxfs_calc_finish_rui_reservation(mp, 1);
> 
> Yup, those should be a single call to xfs_calc_buf_res(xfs_allocfree_block_count())
> 
> > 	const unsigned int	f3 = libxfs_calc_finish_cui_reservation(mp, 1);
> 
> Similarly, xfs_calc_refcountbt_reservation().
> 
> > 	const unsigned int	f4 = libxfs_calc_finish_bui_reservation(mp, 1);
> 
> xfs_calc_write_reservation() but for a single extent instead of 2.
> Also, I think the bui finish needs to take into account dquots, too.
> 
> > 	/* We only finish one item per transaction in a chain */
> > 	const unsigned int	step_size = max(f4, max3(f1, f2, f3));
> 
> And that is xfs_calc_itruncate_reservation(), except it reserves
> space for 1 extent to be processed instead of 4.
> 
> FWIW, I'd suggest that these helpers make for a better way of
> calculating high level reservations such as
> xfs_calc_write_reservation() and xfs_calc_itruncate_reservation()
> because those functions currently don't take into account how
> intents are relogged during those operations.
> 
> > and then you have what you need to figure out the logres needed to
> > support a given awu_max, or vice versa:
> > 
> > 	if (desired_max) {
> > 		dbprintf(
> >  "desired_max: %u\nstep_size: %u\nper_intent: %u\nlogres: %u\n",
> > 				desired_max, step_size, per_intent,
> > 				(desired_max * per_intent) + step_size);
> > 	} else if (logres) {
> > 		dbprintf(
> >  "logres: %u\nstep_size: %u\nper_intent: %u\nmax_awu: %u\n",
> > 				logres, step_size, per_intent,
> > 				logres >= step_size ? (logres - step_size) / per_intent : 0);
> > 	}
> > 
> > I hacked this into xfs_db so that I could compute a variety of
> > scenarios.  Let's pretend I have a 10T filesystem with 4k fsblocks and
> > the default configuration.
> > 
> > # xfs_db /dev/mapper/moo -c logres -c "untorn_max -b $(( (16 * 1048576) / 4096 ))" -c "untorn_max -l 244216"
> > type 0 logres 244216 logcount 5 flags 0x4
> > type 1 logres 428928 logcount 5 flags 0x4
> > <snip>
> > minlogsize logres 648576 logcount 8
> > 
> > To emulate a 16MB untorn write, you'd need a logres of:
> > 
> > desired_max: 4096
> > step_size: 107520
> > per_intent: 208
> > logres: 959488
> >
> > 959488 > 648576, which would alter the minlogsize calculation.  I know
> > we banned tiny filesystems a few years ago, but there's still a risk in
> > increasing it.
> 
> Yeah, it's a bit under a megabyte of reservation space. That's no
> big deal, as log reservations get much larger than this as block
> size and log stripe units are increased.
> 
> <snip the rest, they all show roughly the same thing>
> 
> Ok, these numbers pretty much prove my point - that a fixed max
> atomic write size somewhere around 16MB isn't going to be a problem
> for any filesystem that uses the historic small fs default log size
> (10MB) or larger.
> 
> Let's avoid the internal XFS minlogsize problems by disabling the
> atomic write functionality on the increasingly rare legacy
> filesystems where the log is too small. That allows us to design and
> implement sane userspace API bounds and guarantees for atomic writes
> and not expose internal filesystem constraints and inconsistencies
> to applications...

Ok then.

--D

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

