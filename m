Return-Path: <linux-fsdevel+bounces-47105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E24A99069
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 17:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8397A7310
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9327F292914;
	Wed, 23 Apr 2025 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3v3rKRv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA72820C2;
	Wed, 23 Apr 2025 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421144; cv=none; b=vEomUWouwVIk/3MdalCW2Wh+9E3IdeHuOsy62pNpfljyPjzk62EqblelzrqeDJQWYS0+Bb2RW73PHoywzals0Qt4h4dmOGroaQW/IBdCX7KwLmEymEvrZzAXjR+E9ylgdUfuvn8ubHU0s40wYl1d0TrEW2ZC1m3z4rbv2Z9Z0EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421144; c=relaxed/simple;
	bh=zx/Oy6A5lqsXTBmfLcAGRgtyQAq3DSyvj2acgQbiHZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oi9KfaOGP179tWMfo++NdENPtR8S8wcH3tLPFpVP5EfjwhTnQXJBIT2ysa9IFqQLpSdgAV9s0Tfl7bRC1+Iqj+yBJ9iL7rWM4KnQMzRvDJHbkvgt4WyW5xtKPkZShxI70tGhtT3MHJw/Wc6XHcejzChGzdSwHSrye7A53xcvdbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3v3rKRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D01C4CEE3;
	Wed, 23 Apr 2025 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421144;
	bh=zx/Oy6A5lqsXTBmfLcAGRgtyQAq3DSyvj2acgQbiHZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3v3rKRvbDCRGJfaIyHi/pkzwLyfKW/Q5OmN7Tp2CSSl1mLmtDyMsoZnGKDaSw3Hr
	 c1VyMsbQmPXCpl7HMrKUTzloMBAUTV2L2Okf7JGSQEtXGLRJxjb3e3QiV8N5l7KLx4
	 SgRA3OB2TohvCyZipNabA1AZ78fwyeAgYuSdHEHrfYs/zQmLs5vPwG9U/l4Xh6o5ch
	 awi4NHeUstrRkanpy+V6T93PuMi4D+Kkp1oIDWruIo+eVuM1npdUySmBy7HlbezUuA
	 +LgNDaZbXRJY4JSJMIzkBnxPaNzIm2ZWZeCJBWrUgB5eAADoaQaAU8aAzEQncxtUI3
	 WQ5Z82Av1ehtQ==
Date: Wed, 23 Apr 2025 08:12:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v8 05/15] xfs: ignore HW which cannot atomic write a
 single block
Message-ID: <20250423151224.GC25675@frogsfrogsfrogs>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
 <20250422122739.2230121-6-john.g.garry@oracle.com>
 <20250423003823.GW25675@frogsfrogsfrogs>
 <f467a921-e7dd-4f5b-ac9f-c6e8c043143c@oracle.com>
 <20250423081055.GA28307@lst.de>
 <f27ea8f7-700a-4fb1-b9cd-a0cba04c9e47@oracle.com>
 <20250423083317.GB30432@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423083317.GB30432@lst.de>

On Wed, Apr 23, 2025 at 10:33:17AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 23, 2025 at 09:28:14AM +0100, John Garry wrote:
> >> But maybe we should just delay setting the atomic values until later so
> >> that it can be done in a single pass?  E.g. into xfs_setsize_buftarg
> >> which then should probably be rename to something like
> >> xfs_buftarg_setup.
> >>
> >
> > How about just do away with btp->bt_bdev_awu_{min, max} struct members, and 
> > call bdev_atomic_write_unit_max(mp->m_ddev_targp->bt_bdev) [and same for 
> > RT] to later to set the mp awu max values at mountfs time? I think that 
> > would work..
> 
> Sounds reasonable.

I disagree, leaving the hardware awu_min/max in the buftarg makes more
sense to me because the buftarg is our abstraction for a block device,
and these fields describe the atomic write units that we can use with
that block device.

IOWs, I don't like dumping even more into struct xfs_mount.  xfs_group
has an awu_max for the software fallback, xfs_buftarg has an awu_min/max
for hardware, and even this V8 has yet a third pair of awu_min/max in
xfs_mount which I think is just the buftarg version but possibly
truncated.  I find those last two pairs confusing.

--D

