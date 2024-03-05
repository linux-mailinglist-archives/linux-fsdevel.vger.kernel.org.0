Return-Path: <linux-fsdevel+bounces-13665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DA2872A07
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 23:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8174A1F24F2B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 22:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9D212D1FE;
	Tue,  5 Mar 2024 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="BFS4jd69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88B12D1F4
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677104; cv=none; b=s/AGSKsrF5snnxDxSaLW//4rckDyyBDWKiAXvhwQ59m5HpOH4NmPLsXbEKvkFhbrRQfmVQc/GI35Dwq8dOCG/fZciKMO3nDtL0iUBdnHWipSRCzl/8tDNq0bbQkPh6OUGt1hrPsoNXl4lEEDQ11bElihPDOC/QNd240REi2c9mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677104; c=relaxed/simple;
	bh=9LNA1jHQRqYIJJpk0uYCr8Kb8Les4QGDI28QnUsM6eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Or+k2gLvq3eEW2oLi2OsDtQE7Zugv4oSEpQRukGzxVMPcoS/NbxYdfHF8Hw93hsqCmQ677DhXHNZKw0/bq1f911P78GDWaE27f/hbaz3Mzqu5VLAO4Gbva+HUp3LCH9XVNkBj9p37i+SUPAnM4X5E9xWqlsXcBQCITIMog7Yov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=BFS4jd69; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6092a84f4so2467850b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 14:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709677102; x=1710281902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT0E+xfE6Is1penOGXY7BgtiBNf+i2fC3qJWRmlk8Ss=;
        b=BFS4jd69etiy8e+I6URSYA682Vny1Eddas5uxxFrFsP8LcbOMt1pFtmBH9uzxIuTHx
         7x+PvE4SR1iRwFONHSkrPHAXScC75P0VuKGdvpZcmQPimXzDdoJp9WRhvx1lF3udrImb
         OJpuAwIuIIGU1VNlA7FT2AXLg2s/1AgOwbB1824T0Y6ZMvCzCCoUMNAZpVCSY6IQCXmv
         PGEStm1wYoz7gQOCV5dk7nIqvgObyAHsbOrgvKn8TSCJpvobil+Wl6eSaV4pwo/oJopJ
         jcjp460CW/wgTx4KheUjWdtgtAcfPRCR6AJ09bHL1mjuPOQfdWB9g5Joz9aGflNErJnY
         Dtkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709677102; x=1710281902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT0E+xfE6Is1penOGXY7BgtiBNf+i2fC3qJWRmlk8Ss=;
        b=AGF/crRcGEXABYW0zDKgaeZHz3rZBlVVocVnwy+CQGw4pRDMgpSrqja6f6suyxZzdf
         MU0GYWvqS2mwRq17gF/5H43y3wrWIPk/feSZVOlil+5MJxWONfzDFLmvKzq95Dihs6Pj
         t9/3m3QP8pdpt6NRXhFahabNcYvb8a/DJa/1N+wAba5maf/Kfjh17hIbwSvsm/rpE9fC
         ksxdIOG4wgVFSM1uDhvg0U4+iZunM4b4MfUSgRz4qozOTyHe6P/1p4ItAzo/mo9/6V0Q
         riQuJ977GCzB9H7s6XUEtbjEJfigKQcainfaL2x4oG5qGtOO9AGR86zo9oLTYWgmREfW
         sswA==
X-Forwarded-Encrypted: i=1; AJvYcCWa/qA6vZUfYi3CNFfAqG1KXxQ0f7bQs7+FkNrqbbfF9DyqdtsA+XEpIlZi3SZK8fk7XTYes/rEMV6j3f8mSjNF70y6FWtvudFPV139gA==
X-Gm-Message-State: AOJu0YwMtEnysvaKYpOo7+PlHYTY8sfYXSoPft3UALNeDAJlV98994ce
	SasL4JTirKIe5eHFBQN6UPl4UtTj77sDnoMhQrIsBJ/gyUfqFhoX8oJ5Ke8uqMk=
X-Google-Smtp-Source: AGHT+IHR0bYfjZNZ+IVZC/CMhYRQ0wwfWcjs6kg5rLZEnSmP6gWN+dGMC1lld5Hoz8sE/FQ74qoRFw==
X-Received: by 2002:aa7:88c1:0:b0:6e5:5425:d914 with SMTP id k1-20020aa788c1000000b006e55425d914mr14317350pff.2.1709677101467;
        Tue, 05 Mar 2024 14:18:21 -0800 (PST)
Received: from dread.disaster.area (pa49-181-192-230.pa.nsw.optusnet.com.au. [49.181.192.230])
        by smtp.gmail.com with ESMTPSA id fb26-20020a056a002d9a00b006e647059cccsm621041pfb.33.2024.03.05.14.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 14:18:21 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rhd74-00FXJ3-0b;
	Wed, 06 Mar 2024 09:18:18 +1100
Date: Wed, 6 Mar 2024 09:18:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 04/14] fs: xfs: Make file data allocations observe the
 'forcealign' flag
Message-ID: <ZeeaKrmVEkcXYjbK@dread.disaster.area>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-5-john.g.garry@oracle.com>
 <ZeZq0hRLeEV0PNd6@dread.disaster.area>
 <f569d971-222a-4824-b5fe-2e0d8dc400cc@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f569d971-222a-4824-b5fe-2e0d8dc400cc@oracle.com>

On Tue, Mar 05, 2024 at 03:22:52PM +0000, John Garry wrote:
> On 05/03/2024 00:44, Dave Chinner wrote:
> > On Mon, Mar 04, 2024 at 01:04:18PM +0000, John Garry wrote:
....
> > IOWs, these are static geometry constraints and so should be checked
> > and rejected at the point where alignments are specified (i.e.
> > mkfs, mount and ioctls). Then the allocator can simply assume that
> > forced inode alignments are always stripe alignment compatible and
> > we don't need separate handling of two possibly incompatible
> > alignments.
> 
> ok, makes sense.
> 
> Please note in case missed, I am mandating extsize hint for forcealign needs
> to be a power-of-2. It just makes life easier for all the sub-extent
> zero'ing later on.

That's fine - that will need to be documented in the xfsctl man
page...

> Also we need to enforce that the AG count to be compliant with the extsize
                                      ^^^^^ size?

> hint for forcealign; but since the extsize hint for forcealign needs to be
> compliant with stripe unit, above, and stripe unit would be compliant wth AG
> count (right?), then this would be a given.

We already align AG size to stripe unit when a stripe unit is set,
and ensure that we don't place all the AG headers on the same stripe
unit.

However, if there is no stripe unit we don't align the AG to
anything. So, yes, AG sizing by mkfs will need to ensure that all
AGs are correctly aligned to the underlying storage (integer
multiple of the max atomic write size, right?)...

> > More below....
> > 
> > > +	} else {
> > > +		args->alignment = 1;
> > > +	}
> > 
> > Just initialise the allocation args structure with a value of 1 like
> > we already do?
> 
> It was being done in this way to have just a single place where the value is
> initialised. It can easily be kept as is.

I'd prefer it as is, because then the value is always initialised
correctly and we only override in the special cases....

> > >   	args.minleft = ap->minleft;
> > > @@ -3484,6 +3496,7 @@ xfs_bmap_btalloc_at_eof(
> > >   {
> > >   	struct xfs_mount	*mp = args->mp;
> > >   	struct xfs_perag	*caller_pag = args->pag;
> > > +	int			orig_alignment = args->alignment;
> > >   	int			error;
> > >   	/*
> > > @@ -3558,10 +3571,10 @@ xfs_bmap_btalloc_at_eof(
> > >   	/*
> > >   	 * Allocation failed, so turn return the allocation args to their
> > > -	 * original non-aligned state so the caller can proceed on allocation
> > > -	 * failure as if this function was never called.
> > > +	 * original state so the caller can proceed on allocation failure as
> > > +	 * if this function was never called.
> > >   	 */
> > > -	args->alignment = 1;
> > > +	args->alignment = orig_alignment;
> > >   	return 0;
> > >   }
> > 
> > As I said above, we can't set an alignment of > 1 here if we haven't
> > accounted for that alignment in args->minalignslop above. This leads
> > to unexpected ENOSPC conditions and filesystem shutdowns.
> > 
> > I suspect what we need to do is get rid of the separate stripe_align
> > variable altogether and always just set args->alignment to what we
> > need the extent start alignment to be, regardless of whether it is
> > from stripe alignment or forced alignment.
> 
> ok, it sounds a bit simpler at least
> 
> > 
> > Then the code in xfs_bmap_btalloc_at_eof() doesn't need to know what
> > 'stripe_align' is - the exact EOF block allocation can simply save
> > and restore the args->alignment value and use it for minalignslop
> > calculations for the initial exact block allocation.
> > 
> > Then, if xfs_bmap_btalloc_at_eof() fails and xfs_inode_forcealign()
> > is true, we can abort allocation immediately, and not bother to fall
> > back on further aligned/unaligned attempts that will also fail or do
> > the wrong them.
> 
> ok
> 
> > 
> > Similarly, if we aren't doing EOF allocation, having args->alignment
> > set means it will do the right thing for the first allocation
> > attempt. Again, if that fails, we can check if
> > xfs_inode_forcealign() is true and fail the aligned allocation
> > instead of running the low space algorithm. This now makes it clear
> > that we're failing the allocation because of the forced alignment
> > requirement, and now the low space allocation code can explicitly
> > turn off start alignment as it isn't required...
> 
> are you saying that low-space allocator can set args->alignment = 1 to be
> explicit?

Yes.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

