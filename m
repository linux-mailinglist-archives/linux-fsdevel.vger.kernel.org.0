Return-Path: <linux-fsdevel+bounces-10003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE5D846F60
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B383FB2AF86
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A834113EFFC;
	Fri,  2 Feb 2024 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHxyiR9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC613E223;
	Fri,  2 Feb 2024 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874400; cv=none; b=PTKCASTur65MFv56JdGt0SWM7IZryARpmO3RKIL6HykdrrFPWYeKTNbg68IxhOhg6ie+1moOUFRIgHEzfVaNTTPvA5wH/ea1WsYeTh6jASzQc03vUUhlmiCNPg3fE2mrDjdk6YvyTjvKG4q22UOV57rLFJKR1QqptzQGI1KIi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874400; c=relaxed/simple;
	bh=bH9maqpLPXu6Jsy4OzAqPtinJeJMFDIvCvmOKpjy/XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiEppeMz3DOi/g2iWb/chnnM45R9RC4vT9MtwSiiYXXBLjiQiXB6oj0ROXOIyJMVHj+ifRpHwvEl7I4y6cxp+Il6cizFLUZrJAauzmsK3b2hVU+B/hWBNZ8d8rfY2yPQJvLr65txngRK3HUw+6dJP2lldIYEN5eEmwifTJuE+nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHxyiR9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820AEC433C7;
	Fri,  2 Feb 2024 11:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874399;
	bh=bH9maqpLPXu6Jsy4OzAqPtinJeJMFDIvCvmOKpjy/XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHxyiR9xT9QXfcAmEHBfFgwKSQhC2AqYkgplgSE7TzUh1/laCiP4HIo1864DUXlMj
	 nObLdLl9cd7akcbsVTn4049OFCCpfEAAJHtU/afDqjw3ePN+n8tpipk/G9F0a91SSI
	 EcOaKnB1MM+GGI6jBYfCofJlmREYFksA12S6ioJ9PQiHpRZptNHxnfeM7BQ8X8Az2p
	 ovDB6ASd3PIA5oS1ZUXrkh6Whtm+ygyI1thbtPwMT0cst/c+NoLK9vimuGz+8rjUPP
	 uDG89EfUMyZ1m6LvFQIurZTaksQFDQqCjG2zyT3YZ3j5de6snyJAwZctdVD/Yn6Kz2
	 y4VY+5NmwPMxg==
Date: Fri, 2 Feb 2024 12:46:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 01/34] bdev: open block device as files
Message-ID: <20240202-umkehren-winter-3ec7321e230c@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-1-adbd023e19cc@kernel.org>
 <20240129160241.GA2793@lst.de>
 <20240201-rational-wurfgeschosse-73ca66259263@brauner>
 <20240202064324.GA4350@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202064324.GA4350@lst.de>

On Fri, Feb 02, 2024 at 07:43:24AM +0100, Christoph Hellwig wrote:
> On Thu, Feb 01, 2024 at 06:08:29PM +0100, Christian Brauner wrote:
> > > > +	/*
> > > > +	 * O_EXCL is one of those flags that the VFS clears once it's done with
> > > > +	 * the operation. So don't raise it here either.
> > > > +	 */
> > > > +	if (mode & BLK_OPEN_NDELAY)
> > > > +		flags |= O_NDELAY;
> > > 
> > > O_EXCL isn't dealt with in this helper at all.
> > 
> > Yeah, on purpose was my point bc we can just rely on @holder and passing
> > _EXCL without holder is invalid. But I could add it.
> 
> Ok.  I found it weird to have the comment next to BLK_OPEN_NDELAY
> as it looked like it sneaked through.  Especially as BLK_OPEN_EXCL
> has literally nothing to do with O_EXCL at all as the latter is a
> namespace operation flag.  So even if the comment was intentional
> I think we're probably better off without it.
> 
> > Yes, I had considered that and it would work but there's the issue that
> > we need to figure out how to handle BLK_OPEN_RESTRICT_WRITES. It has no
> > corresponding O_* flag that would let us indicate this.
> 
> Oh, indeed.
> 
> >
> > So I had
> > considered:
> > 
> > 1/ Expose bdev_file_open_excl() so callers don't need to pass any
> >    specific flags. Nearly all filesystems would effectively use this
> >    helper as sb_open_mode() adds it implicitly. That would have the
> >    side-effect of introducing another open helper ofc; possibly two if
> >    we take _by_dev() and _by_path() into account.
> > 
> > 2/ Abuse an O_* flag to mean BLK_OPEN_RESTRICT_WRITES. For example,
> >    O_TRUNC or O_NOCTTY which is pretty yucky.
> > 
> > 3/ Introduce an internal O_* flag which is also ugly. Vomitorious and my
> >    co-maintainers would likely chop off my hands so I can't go near a
> >    computer again.
> > 
> > 3/ Make O_EXCL when passed together with bdev_file_open_by_*() always
> >    imply BLK_OPEN_RESTRICT_WRITES.
> > 
> > The 3/ option would probably be the cleanest one and I think that all
> > filesystems now pass at least a holder and holder ops so this _should_
> > work.
> 
> 2 and 3 sound pretty horrible.  3 would work and look clean for the
> block side, but O_ flags are mess so I wouldn't go there.

My numbering is obviously wrong btw. That last point should obviously be 4/

> 
> Maybe  variant of 1 that allows for a non-exclusive open and clearly
> marks that?
> 
> Or just leave it as-is for now and look into that later.

Ok.

