Return-Path: <linux-fsdevel+bounces-13569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B50D8711E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 01:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE60B23785
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 00:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C524A8BF0;
	Tue,  5 Mar 2024 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YOGuIUGc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD898F49
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599449; cv=none; b=XY3w0dGR97+PwC/Vb76p41iPWhv6/JsQZkbQSwZOOO9EYWuf/paZA+DSWjO7hf4fVpz07VTTMIPYBY12JSteAA1x4bce2YLJSy0GkMp6Bws26e1xAJXD/ZcGiXUSqCU29rjiw88/QD1EjQbRe/5NgOWUG34Oc/tYjDwvxsutH/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599449; c=relaxed/simple;
	bh=FCSN2F3wTvR59J3Tc2+6hcLQYXRq7Q3JPDsJPrqBGTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fD4hw+BOIvMle94DIB2iaooNhPO+90owF25/S1R3S9HQUDxkQBxtWa3CQM3TyZacYYLLol/B9ICbPiXyonLK+rjL4SkNqGnEkemFbu0ecakKD27Di1ipoXZL3l4Vxn/sXhTvuVTAun3xeeh3tO/DC36e19uV3O5D0YoUOs98IL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YOGuIUGc; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c1e992f060so1122632b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 16:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709599446; x=1710204246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPeZoO0bALzx/m/oW1n+JeFHK8ZJCb569gkaMGduVZI=;
        b=YOGuIUGcv56EbFSq1A5ahSwiITdCRhR1ddacMwqju3g1CyH8FPo864Mf/F5j94EyzC
         2UXaNL6LvMhklSaZsCLE/Jd9/+Y6+6FC3GB6UhkSiD8kJbGv8G4AtrlCrUNSWoMWNu/8
         uXpqLjDQsbqn8iyZi2M9Cdlgo2ropiiZ65mVnhFWwehRa4DEKL/1usjJSvPDbcoFEX01
         3kkS2qliVzHhSn6115o0tMD47DsB1n0tIkisbMhMnppabIxLfvEqhMHPquh8puLdpeo2
         bJgsiIY8Z4bGV6TXx/Ga8Tt0MPkmyD/rVtnPpA1/ZdlHhAyaHIoV0k6wsw5adzFsaGyF
         YPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599446; x=1710204246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPeZoO0bALzx/m/oW1n+JeFHK8ZJCb569gkaMGduVZI=;
        b=L3p6+qruRZcKGbCocf2MRFOh2QdZrdLsRkEdxwZEFax/1WduchjIPfnzEVXffMecFF
         Fu7SDl4+xb3XSb3+g4+Gg9+Qs+pWY/rwMcGUOo7O52pJpTZbLacQLXXM6dxs97qdbe7F
         yYVr3UEZuW+lOTK1h48AyV3EfYAwN+KH+/6L+eFVB/P9Mzvm3KI3FpeseS+qS6qAhi2p
         mEEB6SyodFahin4JwiUSJc3Gf64xOBifLlR/97cJBYru2Nfe/uMThr5oOW8r1qaxWNhr
         hSoAD6BSa0I0dso7JaCqey+t6Ptq4sO+U2C75xd0nwGvc4WQrt1+sK7D3RaWW6dqS70+
         6Fhg==
X-Forwarded-Encrypted: i=1; AJvYcCU+jlG8LHrSdMWDXPK2PUbfWelclRNgNN51Xhg5+JmnkYUdQtYAmzhXWuA1y98qbfK0HYf8S2hWHYLKfs6LJrBXgLHNqSB8/u+bOXLuCg==
X-Gm-Message-State: AOJu0YxDsayG+b0W2gLcoDxtns91rPvbisYwOqk025u4S9MJhR7jTKWQ
	+84jiwMabQmkMzTvHkkUYbJ7gpKfjy1pHLVJRmEZnZC4qyPzt8c1BLybjbnCb9Q=
X-Google-Smtp-Source: AGHT+IED5DlJm55+yeTSAP67lyXYzh7y9fJgoXg73PjeZWFq6cETXSAVBoBLcxVriWbUTUsN74HBvQ==
X-Received: by 2002:a05:6871:328b:b0:21e:7a61:5a5a with SMTP id mp11-20020a056871328b00b0021e7a615a5amr334149oac.48.1709599445892;
        Mon, 04 Mar 2024 16:44:05 -0800 (PST)
Received: from dread.disaster.area (pa49-181-192-230.pa.nsw.optusnet.com.au. [49.181.192.230])
        by smtp.gmail.com with ESMTPSA id f42-20020a056a000b2a00b006e623357178sm2358453pfu.176.2024.03.04.16.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:44:05 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rhIuY-00F8Gg-1h;
	Tue, 05 Mar 2024 11:44:02 +1100
Date: Tue, 5 Mar 2024 11:44:02 +1100
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
Message-ID: <ZeZq0hRLeEV0PNd6@dread.disaster.area>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304130428.13026-5-john.g.garry@oracle.com>

On Mon, Mar 04, 2024 at 01:04:18PM +0000, John Garry wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> The existing extsize hint code already did the work of expanding file
> range mapping requests so that the range is aligned to the hint value.
> Now add the code we need to guarantee that the space allocations are
> also always aligned.
> 
> XXX: still need to check all this with reflink
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Co-developed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 22 +++++++++++++++++-----
>  fs/xfs/xfs_iomap.c       |  4 +++-
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 60d100134280..8dee60795cf4 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3343,6 +3343,19 @@ xfs_bmap_compute_alignments(
>  		align = xfs_get_cowextsz_hint(ap->ip);
>  	else if (ap->datatype & XFS_ALLOC_USERDATA)
>  		align = xfs_get_extsz_hint(ap->ip);
> +
> +	/*
> +	 * xfs_get_cowextsz_hint() returns extsz_hint for when forcealign is
> +	 * set as forcealign and cowextsz_hint are mutually exclusive
> +	 */
> +	if (xfs_inode_forcealign(ap->ip) && align) {
> +		args->alignment = align;
> +		if (stripe_align % align)
> +			stripe_align = align;

This kinda does the right thing, but it strikes me as the wrong
thing to be doing - it seems to conflates two different physical
alignment properties in potentially bad ways, and we should never
get this far into the allocator to discover these issues.

Stripe alignment is alignment to physical disks in a RAID array.
Inode forced alignment is file offset alignment to specificly
defined LBA address ranges.  The stripe unit/width is set at mkfs
time, the inode extent size hint at runtime.

These can only work together in specific situations:

	1. max sized RWF_ATOMIC IO must be the same or smaller size
	   than the stripe unit. Alternatively: stripe unit must be
	   an integer (power of 2?) multiple of max atomic IO size.

	   IOWs, stripe unit vs atomic IO constraints must be
	   resolved in a compatible manner at mkfs time. If they
	   can't be resolved (e.g. non-power of 2 stripe unit) then
	   atomic IO cannot be done on the filesystem at all. Stripe
	   unit constraints always win over atomic IO.

	2. min sized RWF_ATOMIC IO must be an integer divider of
	   stripe unit so that small atomic IOs are always correctly
	   aligned to the stripe unit.

	3. Inode forced alignment constraints set at runtime (i.e.
	   extsize hints) must fit within the above stripe unit vs
	   min/max atomic IO requirements.

	   i.e. extent size hint will typically need to an integer
	   multiple of stripe unit size which will always be
	   compatible with stripe unit and atomic IO size and
	   alignments...

IOWs, these are static geometry constraints and so should be checked
and rejected at the point where alignments are specified (i.e.
mkfs, mount and ioctls). Then the allocator can simply assume that
forced inode alignments are always stripe alignment compatible and
we don't need separate handling of two possibly incompatible
alignments.

Regardless, I think the code as it stands won't work correctly when
a stripe unit is not set.

The correct functioning of this code appears to be dependent on
stripe_align being set >= the extent size hint. If stripe align is
not set, then what does (0 % align) return? If my checks are
correct, this will return 0, and so the above code will end up with
stripe_align = 0.

Now, consider that args->alignment is used to signal to the
allocator what the -start alignment- of the allocation is supposed
to be, whilst args->prod/args->mod are used to tell the allocator
what the tail adjustment is supposed to be.

Stripe alignment wants start alignment, extent size hints want tail
adjustment and force aligned allocation wants both start alignment
and tail adjustment.

However, the allocator overrides these depending on what it is
doing. e.g. exact block EOF allocation turns off start alignment but
has to ensure space is reserved for start alignment if it fails.
This reserves space for stripe_align in args->minalignslop, but if
force alignment has a start alignment requirement larger than stripe
unit alignment, this code fails to reserve the necessary alignment
slop for the force alignment code.

If we aren't doing exact block EOF allocation, then we do stripe
unit alignment. Again, if this fails and the forced alignment is
larger than stripe alignment, this code does not reserve space for
the larger alignment in args->minalignslop, so it will also do the
wrong when we fall back to an args->alignment > 1 allocation.

Failing to correctly account for minalignslop is known to cause
accounting problems when the AG is very near empty, and the usual
result of that is cancelling of a dirty allocation transaction and a
forced shutdown. So this is something we need to get right.

More below....

> +	} else {
> +		args->alignment = 1;
> +	}

Just initialise the allocation args structure with a value of 1 like
we already do?

> +
>  	if (align) {
>  		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
>  					ap->eof, 0, ap->conv, &ap->offset,
> @@ -3438,7 +3451,6 @@ xfs_bmap_exact_minlen_extent_alloc(
>  	args.minlen = args.maxlen = ap->minlen;
>  	args.total = ap->total;
>  
> -	args.alignment = 1;
>  	args.minalignslop = 0;

This likely breaks the debug code. This isn't intended for testing
atomic write capability, it's for exercising low space allocation
algorithms with worst case fragmentation patterns. This is only
called when error injection is turned on to trigger this path, so we
shouldn't need to support forced IO alignment here.

>  
>  	args.minleft = ap->minleft;
> @@ -3484,6 +3496,7 @@ xfs_bmap_btalloc_at_eof(
>  {
>  	struct xfs_mount	*mp = args->mp;
>  	struct xfs_perag	*caller_pag = args->pag;
> +	int			orig_alignment = args->alignment;
>  	int			error;
>  
>  	/*
> @@ -3558,10 +3571,10 @@ xfs_bmap_btalloc_at_eof(
>  
>  	/*
>  	 * Allocation failed, so turn return the allocation args to their
> -	 * original non-aligned state so the caller can proceed on allocation
> -	 * failure as if this function was never called.
> +	 * original state so the caller can proceed on allocation failure as
> +	 * if this function was never called.
>  	 */
> -	args->alignment = 1;
> +	args->alignment = orig_alignment;
>  	return 0;
>  }

As I said above, we can't set an alignment of > 1 here if we haven't
accounted for that alignment in args->minalignslop above. This leads
to unexpected ENOSPC conditions and filesystem shutdowns.

I suspect what we need to do is get rid of the separate stripe_align
variable altogether and always just set args->alignment to what we
need the extent start alignment to be, regardless of whether it is
from stripe alignment or forced alignment.

Then the code in xfs_bmap_btalloc_at_eof() doesn't need to know what
'stripe_align' is - the exact EOF block allocation can simply save
and restore the args->alignment value and use it for minalignslop
calculations for the initial exact block allocation.

Then, if xfs_bmap_btalloc_at_eof() fails and xfs_inode_forcealign()
is true, we can abort allocation immediately, and not bother to fall
back on further aligned/unaligned attempts that will also fail or do
the wrong them.

Similarly, if we aren't doing EOF allocation, having args->alignment
set means it will do the right thing for the first allocation
attempt. Again, if that fails, we can check if
xfs_inode_forcealign() is true and fail the aligned allocation
instead of running the low space algorithm. This now makes it clear
that we're failing the allocation because of the forced alignment
requirement, and now the low space allocation code can explicitly
turn off start alignment as it isn't required...


> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 18c8f168b153..70fe873951f3 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -181,7 +181,9 @@ xfs_eof_alignment(
>  		 * If mounted with the "-o swalloc" option the alignment is
>  		 * increased from the strip unit size to the stripe width.
>  		 */
> -		if (mp->m_swidth && xfs_has_swalloc(mp))
> +		if (xfs_inode_forcealign(ip))
> +			align = xfs_get_extsz_hint(ip);
> +		else if (mp->m_swidth && xfs_has_swalloc(mp))
>  			align = mp->m_swidth;
>  		else if (mp->m_dalign)
>  			align = mp->m_dalign;

This doesn't work for files with a current size of less than
"align". The next line of code does:

	if (align && XFS_ISIZE(ip) < XFS_FSB_TO_B(mp, align))
		align = 0;

IOWs, the first aligned write allocation will occur with a file size
of zero, and that will result in this function returning 0. i.e.
speculative post EOF delalloc doesn't turn on and align the EOF
until writes up to offset == align have already been completed.

Essentially, this code wants to be:

	if (xfs_inode_forcealign(ip))
		return xfs_get_extsz_hint(ip);

So that any write to the a force aligned inode will always trigger
extent size hint EOF alignment.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

