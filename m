Return-Path: <linux-fsdevel+bounces-72878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3499BD04570
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EF4F301C37B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0F3274FF5;
	Thu,  8 Jan 2026 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXzCQkJp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F4265CA6;
	Thu,  8 Jan 2026 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889099; cv=none; b=GGnW1KUKueHqwDkq1Ic4EzFnFMxQCRH38V98ZDOSlT7J0/YKMBYPlSHzkSAO5uwrMhCIRm4+VFblM8RCPZfUUPUdm1CiBUdT2SUPdA94mG+SvwQnbVBQvtP93E3+wL7eW8lsntcm5wW7HhT20DZiwihDvknm7BHd3m4pkHPfMDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889099; c=relaxed/simple;
	bh=g6irQRbkQGHUjF+9KvAGadNtp3IaY4MvtAq4blC9vTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1jhdmEwB66CfUTFSJiBeGryBPslB+W4OzK7zySCB/ZbB2whxLCqhJOcdc24gDDXoxxfcNC/nmQQYOi2PXPVXGxDOrV1g+DNiQNiqxTtXGVJftK1565i2HEYCscZE4oR1sivRdzC4iesaDK0LlPLRkyEohMUXdDDr75zkOxvC0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXzCQkJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490C4C116C6;
	Thu,  8 Jan 2026 16:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767889098;
	bh=g6irQRbkQGHUjF+9KvAGadNtp3IaY4MvtAq4blC9vTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXzCQkJpf47FDg8867sB4WuricZ1Rd9BUVpHhmYOanpFv40uWVHYinmkrwno+05GJ
	 Y0MrYaXVH/7n7+rzgKdN2Yn+MV+89ulf3PFllrYMPYr5FfhWqjPNH6X8ueN9UzIOqD
	 qMYnFhL/O6XayzDNwSRUfI04bdMFLO6OOD/slonj2cpzCsKxeeHy962NdaLEceH2fF
	 NTfHd0t13KgIdmtNQWaun29rDhuo0BmWXEx3vdW63Itxv+IdoXRGHCqIbdH31T+VRG
	 OkWKf4sH4H5KyUiTYgeMk9+uN10yT1HS8vlwusyAhQTyuGBnfgsRZnBBLqEAjQkuGV
	 4TI7ypApPJzvg==
Date: Thu, 8 Jan 2026 08:18:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 11/11] xfs: add media error reporting ioctl
Message-ID: <20260108161817.GI15551@frogsfrogsfrogs>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
 <176766637485.774337.16716764027357885673.stgit@frogsfrogsfrogs>
 <20260107093611.GC24264@lst.de>
 <20260107163035.GA15551@frogsfrogsfrogs>
 <20260108102559.GA25394@lst.de>
 <20260108160929.GH15551@frogsfrogsfrogs>
 <20260108161404.GA10766@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108161404.GA10766@lst.de>

On Thu, Jan 08, 2026 at 05:14:04PM +0100, Christoph Hellwig wrote:
> On Thu, Jan 08, 2026 at 08:09:29AM -0800, Darrick J. Wong wrote:
> > But maybe the blockdev fs can implement the new fserror hook, see if
> > there's a super_block associated with the bdev, and throw the fserror
> > up to the mounted filesystem.
> > 
> > (Hard part: partitions)
> 
> All the partition mapping can be trivially undone.  I still think
> issuing the commands on the block device instead of from the file
> system feels wrong.

"From the filesystem"?  That gives me an idea: what if xfs_scrub instead
opens the root dir, calls an ioctl that does the verify work, and that
ioctl then reports the result to userspace and xfs_healthmon?

As opposed to this kind of stupid reporting ioctl?

> > > > Or I guess one of us should go figure out a reasonable verify command
> > > > that would call fserror_* on media errors.
> > > 
> > > Hmm, I would expect the verify command to be issued by fs/xfs/scrub/
> > > in the kernel, so that it can be directly tied into the in-kernel
> > > logical to physical and rmap.  But you are more well versed there,
> > > so maybe I'm missing something.
> > 
> > Did Chaitanya actually push for the verify command to get merged?
> 
> Not yet.
> 
> > I guess it wouldn't be terribly hard to make a stupid version that
> > simply does direct reads to a throwaway page, to work around willy's
> > objection that the existing scsi verify command doesn't require proof
> > that the device actually did anything (and some of them clearly don't).
> 
> We could do that, although I'd make it conditional.  For the kind of
> storage you want to store your data on it does work, as the customer
> would get very unhappy otherwise.

Heheh.  It's really too bad that I have a bunch of Very Expensive RAID
controllers that lie... and it's the crappy Samsung QVO SSDs that
actually do the work.

--D

