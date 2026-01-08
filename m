Return-Path: <linux-fsdevel+bounces-72875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECB3D04D85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB725349540B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 16:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B4223EA8A;
	Thu,  8 Jan 2026 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zbiyw3p0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177124A076;
	Thu,  8 Jan 2026 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888570; cv=none; b=E+ZTo+0lszBcNbnZC3qwt7K6djeR0tjJS1PX13mloH4cx7dPSnkiu3XKlAje+g/4l/LAPNIpFDPA9RxfrTZwWsMX8jAwlsP5lJSSKWLkioQS1GCFua12F19b/RG2l7AJW47Tk184GQdNeDyGISduKRLqmibgR+jb0pwYslHpYyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888570; c=relaxed/simple;
	bh=FzECb9E+84GAB26u6yRohLUd1ZVWZ1UzGGigL2BwDBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSK4Fql/9tGMxQx2LfJuN3VN30UaGDieMYiB7Dl2hKnX2YjQJzuMSHGsaIni+Wn7KA5IlWMhCjnK2hFpBMnWN7AMMYmM5gtyk6lhVQz/PyAsTs0HLOGCd51UJ4oB4kCu/zjugM6rjBhfBwPCP0OLldnX2XHRivnFWtDeu6j9ypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zbiyw3p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272E6C16AAE;
	Thu,  8 Jan 2026 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767888570;
	bh=FzECb9E+84GAB26u6yRohLUd1ZVWZ1UzGGigL2BwDBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zbiyw3p0N5h8SreovHhw6b3qJ7SQ7TA+gITg3bH+gQLQ9CQLWSMfCBT8vHJWEozJC
	 lSQgxPURm0PbkptnxqMjIiDyPLmyD5ZKkUy33/6mrDcLKLRqJyV53Km75H2UHRQwH5
	 ilHEe8TIera4bo6CHNJ5TXg+O5XHWLTifUQbHwlIT7RkkaquVeFFwV27XPdJ64HW4k
	 ZBuL7e4AdXALy63TpEIeItgVpE+FdOFNtcyMikUujmUZg0P6UmuPdkMW1l0eCpGWrH
	 fp3sTNzYyj9CrmePOHZLhZdeONXhr5+krl5FcZnC7eeghLLnATwvhT5B+l5yi52MfA
	 9PZq3t4Qh4tYA==
Date: Thu, 8 Jan 2026 08:09:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 11/11] xfs: add media error reporting ioctl
Message-ID: <20260108160929.GH15551@frogsfrogsfrogs>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
 <176766637485.774337.16716764027357885673.stgit@frogsfrogsfrogs>
 <20260107093611.GC24264@lst.de>
 <20260107163035.GA15551@frogsfrogsfrogs>
 <20260108102559.GA25394@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108102559.GA25394@lst.de>

On Thu, Jan 08, 2026 at 11:25:59AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 07, 2026 at 08:30:35AM -0800, Darrick J. Wong wrote:
> > > FYI, I'd much prefer adding the kernel support than relying in userspace
> > > doing it, which will be hard to move away from.
> > 
> > Hrm.  I wonder, does the block layer use iomap for directio?  Now that
> > the fserror reporting has been hooked up to iomap, I wonder if it's
> > possible for xfs_healer to listen for file IO errors on a block device?
> > 
> > Oh.  block/fops.c doesn't actually call iomap_dio_* so I guess that's
> > not yet possible.  Would it be easier to convert blockdevs to use iomap,
> > or should I bite the bullet and convert the legacy direct_IO code?
> 
> The block code basically has it's own simplified copy of the iomap
> direct I/O code.

Hrmm, yes, I see where I might stuff a few fserror_report_io calls,
though the bigger problem is that fanotify's error reporting doesn't
allow for a file range, so we can tell you that there was a media error
but not where.

But maybe the blockdev fs can implement the new fserror hook, see if
there's a super_block associated with the bdev, and throw the fserror
up to the mounted filesystem.

(Hard part: partitions)

> > Or I guess one of us should go figure out a reasonable verify command
> > that would call fserror_* on media errors.
> 
> Hmm, I would expect the verify command to be issued by fs/xfs/scrub/
> in the kernel, so that it can be directly tied into the in-kernel
> logical to physical and rmap.  But you are more well versed there,
> so maybe I'm missing something.

Did Chaitanya actually push for the verify command to get merged?
I guess it wouldn't be terribly hard to make a stupid version that
simply does direct reads to a throwaway page, to work around willy's
objection that the existing scsi verify command doesn't require proof
that the device actually did anything (and some of them clearly don't).

--D

