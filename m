Return-Path: <linux-fsdevel+bounces-9963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CBB846863
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 07:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473F11C25350
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 06:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060702943F;
	Fri,  2 Feb 2024 06:43:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414119479;
	Fri,  2 Feb 2024 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856217; cv=none; b=KNXVRPjrbeZ//9J3psLy62BsM4BsLhSjXRef69oX0a/de8Etupvl61b2IfFTjN+cwWjsyd7VTIASqos+jxSnOnnf47qr5A86PjFhsexbQq557+IeKOhL32oLuNzGvfH3/tAvpuDd68tWPDNefAvWLuLE0qexNbTnXNYoshVGXfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856217; c=relaxed/simple;
	bh=gmq4QpCe0BDa3b1XQk4Jqzcnz1BCJ95fhWBkHtT/Vc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ar2e6/4Rig/HCjIs3NYVibfb11TzJYLg7x78yoTBIc7ZJDHmRObHyBp8jnFQp4S0sPyUyUP9fWWgeiWZXzNM+Xbm/3HzZbloF3Yy34sOzxNKNniAKZfL2zDxc93gpnAd2bGkIdW5GCS2WG13oM47GIlL0NbUEfq45yrhsuMhxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ED426227A88; Fri,  2 Feb 2024 07:43:24 +0100 (CET)
Date: Fri, 2 Feb 2024 07:43:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 01/34] bdev: open block device as files
Message-ID: <20240202064324.GA4350@lst.de>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org> <20240123-vfs-bdev-file-v2-1-adbd023e19cc@kernel.org> <20240129160241.GA2793@lst.de> <20240201-rational-wurfgeschosse-73ca66259263@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-rational-wurfgeschosse-73ca66259263@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 01, 2024 at 06:08:29PM +0100, Christian Brauner wrote:
> > > +	/*
> > > +	 * O_EXCL is one of those flags that the VFS clears once it's done with
> > > +	 * the operation. So don't raise it here either.
> > > +	 */
> > > +	if (mode & BLK_OPEN_NDELAY)
> > > +		flags |= O_NDELAY;
> > 
> > O_EXCL isn't dealt with in this helper at all.
> 
> Yeah, on purpose was my point bc we can just rely on @holder and passing
> _EXCL without holder is invalid. But I could add it.

Ok.  I found it weird to have the comment next to BLK_OPEN_NDELAY
as it looked like it sneaked through.  Especially as BLK_OPEN_EXCL
has literally nothing to do with O_EXCL at all as the latter is a
namespace operation flag.  So even if the comment was intentional
I think we're probably better off without it.

> Yes, I had considered that and it would work but there's the issue that
> we need to figure out how to handle BLK_OPEN_RESTRICT_WRITES. It has no
> corresponding O_* flag that would let us indicate this.

Oh, indeed.

>
> So I had
> considered:
> 
> 1/ Expose bdev_file_open_excl() so callers don't need to pass any
>    specific flags. Nearly all filesystems would effectively use this
>    helper as sb_open_mode() adds it implicitly. That would have the
>    side-effect of introducing another open helper ofc; possibly two if
>    we take _by_dev() and _by_path() into account.
> 
> 2/ Abuse an O_* flag to mean BLK_OPEN_RESTRICT_WRITES. For example,
>    O_TRUNC or O_NOCTTY which is pretty yucky.
> 
> 3/ Introduce an internal O_* flag which is also ugly. Vomitorious and my
>    co-maintainers would likely chop off my hands so I can't go near a
>    computer again.
> 
> 3/ Make O_EXCL when passed together with bdev_file_open_by_*() always
>    imply BLK_OPEN_RESTRICT_WRITES.
> 
> The 3/ option would probably be the cleanest one and I think that all
> filesystems now pass at least a holder and holder ops so this _should_
> work.

2 and 3 sound pretty horrible.  3 would work and look clean for the
block side, but O_ flags are mess so I wouldn't go there.

Maybe  variant of 1 that allows for a non-exclusive open and clearly
marks that?

Or just leave it as-is for now and look into that later.

