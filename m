Return-Path: <linux-fsdevel+bounces-43646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BEFA59D89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD943A52CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 17:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D68D231A24;
	Mon, 10 Mar 2025 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1un/QC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D722154C;
	Mon, 10 Mar 2025 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627304; cv=none; b=tQMUqJ5e6J6DtiC0O1a8nqnryCh+BCmeHPBcPIt/5pI+mXmSZO2/jkFs1Y1YBv/Ca7iOJq4f7MFx8o9E74XRQtlSxFhAomCa5u8/8HAh/qJ4Qvh9DrbFXy2nP2ltzw4r6c7ztkTiLIL+osH2To+6YSgb32KDmP2Ahh9I7JVauHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627304; c=relaxed/simple;
	bh=d24mA4bIr/mbuprlRhmoK24eMxUVfGcLpBqc+ZF7X20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heMPprt3Io2e+zPJccHhqqvHHKL+VHF9rMxvSeSzwVETTxmse8RLa62wqGDL+Syn5ggO+M+caN1nHa+CL6dlmtUexlvKSivyGTkYpOUBbiaiw76116W01uQVVtOb1+0PniBYja17+REo1MxRm2hlXXiubHExXIv7TTUkQYDR4nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1un/QC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B594C4CEEC;
	Mon, 10 Mar 2025 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627304;
	bh=d24mA4bIr/mbuprlRhmoK24eMxUVfGcLpBqc+ZF7X20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1un/QC/FPndigQhN+r3/3vRVawm+YGV0ejyRIsLADtKMAQfs5s/MzkaraNqogswQ
	 qZzTiA4FwhhMaHnjJZUJz0+JS6Mqp92BTnzVDT/pki2HHnlQdPxOud0K14tmagLQKe
	 NeZVkraSRXRKOCmyEG14s44hjRFlFaNA5/Q9gMIoxNmK60mK0ZPKHBvxzSGoNCIS5x
	 PvnsHcyITHyUpkP7GytMTQ1LLIt3t4U+oZ3Oz4aWQg5OdS/8Vse07IejfmF0kwdOGZ
	 deJS6fdp8aQ6U1U71GLDNpWFjFDYywMtMN9OXBesj3/Vq+dgk31P8kSngNQFz1wQwe
	 xRu0Kyctj/vMw==
Date: Mon, 10 Mar 2025 10:21:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>, brauner@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 05/12] iomap: Support SW-based atomic writes
Message-ID: <20250310172143.GT2803749@frogsfrogsfrogs>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <20250303171120.2837067-6-john.g.garry@oracle.com>
 <Z84NTP5tyHEVLNbA@dread.disaster.area>
 <4da6ae74-e431-4bc7-82f8-a621bb8905c1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4da6ae74-e431-4bc7-82f8-a621bb8905c1@oracle.com>

On Mon, Mar 10, 2025 at 10:44:47AM +0000, John Garry wrote:
> On 09/03/2025 21:51, Dave Chinner wrote:
> > Mon, Mar 03, 2025 at 05:11:13PM +0000, John Garry wrote:
> > > Currently atomic write support requires dedicated HW support. This imposes
> > > a restriction on the filesystem that disk blocks need to be aligned and
> > > contiguously mapped to FS blocks to issue atomic writes.
> > > 
> > > XFS has no method to guarantee FS block alignment for regular,
> > > non-RT files. As such, atomic writes are currently limited to 1x FS block
> > > there.
> > > 
> > > To deal with the scenario that we are issuing an atomic write over
> > > misaligned or discontiguous data blocks - and raise the atomic write size
> > > limit - support a SW-based software emulated atomic write mode. For XFS,
> > > this SW-based atomic writes would use CoW support to issue emulated untorn
> > > writes.
> > > 
> > > It is the responsibility of the FS to detect discontiguous atomic writes
> > > and switch to IOMAP_DIO_ATOMIC_SW mode and retry the write. Indeed,
> > > SW-based atomic writes could be used always when the mounted bdev does
> > > not support HW offload, but this strategy is not initially expected to be
> > > used.
> > So now seeing how these are are to be used, these aren't "hardware"
> > and "software" atomic IOs. They are block layer vs filesystem atomic
> > IOs.
> > 
> > We can do atomic IOs in software in the block layer drivers (think
> > loop or dm-thinp) rather than off-loading to storage hardware.
> > 
> > Hence I think these really need to be named after the layer that
> > will provide the atomic IO guarantees, because "hw" and "sw" as they
> > are currently used are not correct. e.g something like
> > IOMAP_FS_ATOMIC and IOMAP_BDEV_ATOMIC which indicates which layer
> > should be providing the atomic IO constraints and guarantees.
> 
> I'd prefer IOMAP_REQ_ATOMIC instead (of IOMAP_BDEV_ATOMIC), as we are using
> REQ_ATOMIC for those BIOs only. Anything which the block layer and below
> does with REQ_ATOMIC is its business, as long as it guarantees atomic
> submission. But I am not overly keen on that name, as it clashes with block
> layer names (naturally).

I don't like encoding "REQ_ATOMIC" in iomap flags.  If we're changing
the names, they ought to reflect who's making the guarantees:

IOMAP_DIO_BDEV_ATOMIC vs. IOMAP_DIO_FS_ATOMIC.

Not sure why the flags lost the "_DIO" part.

--D

> And IOMAP_FS_ATOMIC seems a bit vague, but I can't think of anything else.
> 
> Darrick, any opinion on this?
> 
> Cheers,
> John
> 

