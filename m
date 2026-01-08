Return-Path: <linux-fsdevel+bounces-72815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E27D5D02B3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 13:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F058D305B1E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 12:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F6E48D64D;
	Thu,  8 Jan 2026 10:26:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAEF48DA5B;
	Thu,  8 Jan 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867971; cv=none; b=CSy5pWGO9SdTsm7JkekOt4D4aktFaGFMoidk2IWEEy8mQfpj2E2ctt+xZosu1Co1yYEqj5CNY3khc0xizZH67nVP4XHgattb20VHNE6LxCu2/BLYKUcdZr31dnfSOVXs3wW/l5BRQ0uEPMhIVu64vjyWFqJ0zpyFwQiyc0nxuOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867971; c=relaxed/simple;
	bh=ferKa+yhyaZf3e38F8hXpHzLzfFzNGff8gsEgv5YzvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0ozIkVPZ4TPSciIDlNVeQydizw45+DPyiPcsLLKUQC+XSjh7qm8wDxq5h/8hIMQQjZjzI6Zi0GdSBJ/uEFF/XlYpM4xQzxdVZFV3CFqrsVLsee3X1n35T8mn6LfjB7fyKuDr19LO9+s25stqnZYkfTCM4fBc4g91vvYqLT5V4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 83381227A87; Thu,  8 Jan 2026 11:25:59 +0100 (CET)
Date: Thu, 8 Jan 2026 11:25:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 11/11] xfs: add media error reporting ioctl
Message-ID: <20260108102559.GA25394@lst.de>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs> <176766637485.774337.16716764027357885673.stgit@frogsfrogsfrogs> <20260107093611.GC24264@lst.de> <20260107163035.GA15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107163035.GA15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 07, 2026 at 08:30:35AM -0800, Darrick J. Wong wrote:
> > FYI, I'd much prefer adding the kernel support than relying in userspace
> > doing it, which will be hard to move away from.
> 
> Hrm.  I wonder, does the block layer use iomap for directio?  Now that
> the fserror reporting has been hooked up to iomap, I wonder if it's
> possible for xfs_healer to listen for file IO errors on a block device?
> 
> Oh.  block/fops.c doesn't actually call iomap_dio_* so I guess that's
> not yet possible.  Would it be easier to convert blockdevs to use iomap,
> or should I bite the bullet and convert the legacy direct_IO code?

The block code basically has it's own simplified copy of the iomap
direct I/O code.

> Or I guess one of us should go figure out a reasonable verify command
> that would call fserror_* on media errors.

Hmm, I would expect the verify command to be issued by fs/xfs/scrub/
in the kernel, so that it can be directly tied into the in-kernel
logical to physical and rmap.  But you are more well versed there,
so maybe I'm missing something.


