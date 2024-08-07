Return-Path: <linux-fsdevel+bounces-25206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2307D949CC1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 02:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FCB01C21FFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 00:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617792BB09;
	Wed,  7 Aug 2024 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOHWgz87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67229CEC;
	Wed,  7 Aug 2024 00:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722990264; cv=none; b=QDm7lQ2pmcnS/fnnhHs/3emzcceTtz6GneDq0uSmMpnHMO+TuKDwnjP/j3aFwSoKKbssHxQp3vVkRhqoUMF7Fr24y23f9BnwVdXXdcbqrqoQ1++C/rxaKb0Nejia+xEZGKzsptJqIg82yMHFGDfBat2rzX+HijOw0vwUyAVwq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722990264; c=relaxed/simple;
	bh=GOW6U9XNqsaU2CM+rYJPgJwJYza0BM/q9oivw9cdNdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E66fyUkot81EbDiwpbfu1ENXl5oHIQu9NgUmE32Sc5Kx7JbdHtjdBZ4xYQLMSjx4Jw4CerbfjjfhEjmPEiGDuCeURb/boz5JxC3ka/LkrDgUNUOH4mkX25fxA8GijhcKiVErpZuae4V60X/IlyxdyxmB8YLPdDT2nUqt65Zyrlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOHWgz87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB04C32786;
	Wed,  7 Aug 2024 00:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722990264;
	bh=GOW6U9XNqsaU2CM+rYJPgJwJYza0BM/q9oivw9cdNdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOHWgz87GyOyZ5R5JpfpBLFPgBUStE5Hh+HQjmSGqOtcowNQSDW4SOLVOFw94B+l5
	 8G+ocelXm5DBIk8r15kRp79tLr3bn0IG4FaDAQaIjvtwngtkzTgX0KghcdDeZM7s9Z
	 M6yi7mMkSyQVP1XY9SftMI0JRY135F9E21IuoJRT5oc5JTPhgupVA52cWlfHQKwpHx
	 cOIHt+nrI8SrxZmcPrTGLnyGirhrcSKIVTi0u9o6EJGT0Y7pTEFnNVtQLZd6hOpOnL
	 +EduCh9AdkRlGCeB6PrHBlpGUUX8Lw0y+ld91gFx7+INqqNGMHRAQsHgmRmWiGLXYv
	 ddGfTKQrDQdeg==
Date: Tue, 6 Aug 2024 17:24:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com,
	dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v3 04/14] xfs: make EOF allocation simpler
Message-ID: <20240807002423.GR623936@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-5-john.g.garry@oracle.com>
 <20240806185853.GI623936@frogsfrogsfrogs>
 <ZrK5Lu1+oqqyG3ke@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrK5Lu1+oqqyG3ke@dread.disaster.area>

On Wed, Aug 07, 2024 at 10:00:46AM +1000, Dave Chinner wrote:
> On Tue, Aug 06, 2024 at 11:58:53AM -0700, Darrick J. Wong wrote:
> > On Thu, Aug 01, 2024 at 04:30:47PM +0000, John Garry wrote:
> > > @@ -3688,12 +3649,19 @@ xfs_bmap_btalloc_filestreams(
> > >  	}
> > >  
> > >  	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
> > > -	if (ap->aeof)
> > > -		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
> > > +	if (ap->aeof && ap->offset)
> > > +		error = xfs_bmap_btalloc_at_eof(ap, args);
> > >  
> > > +	/* This may be an aligned allocation attempt. */
> > >  	if (!error && args->fsbno == NULLFSBLOCK)
> > >  		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
> > >  
> > > +	/* Attempt non-aligned allocation if we haven't already. */
> > > +	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
> > > +		args->alignment = 1;
> > > +		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
> > 
> > Oops, I just replied to the v2 thread instead of this.
> > 
> > From
> > https://lore.kernel.org/linux-xfs/20240621203556.GU3058325@frogsfrogsfrogs/
> > 
> > Do we have to zero args->alignslop here?
> 
> No. It should always be zero here to begin with. It is the
> responsibility of the allocation attempt that modifies
> args->alignment and args->alignslop to reset them to original values
> on allocation failure.
> 
> The only places we use alignslop are xfs_bmap_btalloc_at_eof() and
> xfs_ialloc_ag_alloc(). They both zero it and reset args->alignment
> on allocation failure before falling through to the next allocation
> attempt.

Aha, that's even in this patch.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

