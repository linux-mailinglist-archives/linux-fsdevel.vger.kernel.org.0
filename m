Return-Path: <linux-fsdevel+bounces-73184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F911D109F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 06:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B5813032112
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 05:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF4C30F536;
	Mon, 12 Jan 2026 05:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7O/EH/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59C129AAF7;
	Mon, 12 Jan 2026 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768195469; cv=none; b=hzRlCQ3lqQq/taOv63ve9R4wJPn83Qu5G3L6d4ob2nDVIaWrSXDb/BA0ZwNBl42nrNDWew0JBcntskdWQheZ+O6W6MLBXLviiNVdfndyehy4EofB/om58Ol6cqJkSIZIsf95dHq5H0cr2Z38QEjNT+KRJDFWje4sRsKx1+zW73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768195469; c=relaxed/simple;
	bh=BFXpRR9U0MJ1H8dJiXVZcQ8bHI0ASUrqPtXn4C8lJu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wrh3lmkwcqtBKdsukM1HMhZhhbo9+8lUVbFqFbQK0+gStHqdV/S5DBELFwliF1vvPi9Rewn9JUQiQ418RupzA8wIGKv14h1dM7vPBAVxbyshaMSC/fqBYyrNS8J2qUJEcb0C0SdcyBpBhrena6/bcQ6YBTwuS3pOu+WA+UHk07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7O/EH/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3217BC116D0;
	Mon, 12 Jan 2026 05:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768195469;
	bh=BFXpRR9U0MJ1H8dJiXVZcQ8bHI0ASUrqPtXn4C8lJu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7O/EH/kK3r8x31QovuilYoGLn1p6m7eDYTuIRsc9snE2g+nEFQZDaLpZUO2shesN
	 9f5ZbIKWXykRjz0iQHLJ/vyiaI1M4o+eEEVHXxCsuKinuCA6yKMPPx4o/Q40bQof5u
	 aXJ1niwoo5Rtm7PBairp9elk5LCQC1tTcRdesBNO7JEAESnBupIDC6+TSFr5k+bUBE
	 lFYwP+dei9ZybrVnqHZOrfrRF7MRJwzE/Mn2YwKFJau2afbENmCw4WE6iZooFl6nqB
	 jQz8AZqFIasBOTD2e/il8ZjAsmcXQEX1f5h8Yip5+FNeoKriJCJhoopopPCeRrQisY
	 8PoXfpkgd3KRQ==
Date: Sun, 11 Jan 2026 21:24:28 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 11/11] xfs: add media error reporting ioctl
Message-ID: <20260112052428.GB15551@frogsfrogsfrogs>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
 <176766637485.774337.16716764027357885673.stgit@frogsfrogsfrogs>
 <20260107093611.GC24264@lst.de>
 <20260107163035.GA15551@frogsfrogsfrogs>
 <20260108102559.GA25394@lst.de>
 <20260108160929.GH15551@frogsfrogsfrogs>
 <20260108161404.GA10766@lst.de>
 <20260108161817.GI15551@frogsfrogsfrogs>
 <20260108162032.GA11429@lst.de>
 <20260108165347.GE15583@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108165347.GE15583@frogsfrogsfrogs>

On Thu, Jan 08, 2026 at 08:53:47AM -0800, Darrick J. Wong wrote:
> On Thu, Jan 08, 2026 at 05:20:32PM +0100, Christoph Hellwig wrote:
> > On Thu, Jan 08, 2026 at 08:18:17AM -0800, Darrick J. Wong wrote:
> > > > All the partition mapping can be trivially undone.  I still think
> > > > issuing the commands on the block device instead of from the file
> > > > system feels wrong.
> > > 
> > > "From the filesystem"?  That gives me an idea: what if xfs_scrub instead
> > > opens the root dir, calls an ioctl that does the verify work, and that
> > > ioctl then reports the result to userspace and xfs_healthmon?
> > > 
> > > As opposed to this kind of stupid reporting ioctl?
> > 
> > Yes, that's what I've been trying to push for.  I guess I didn't really
> > express that clearly enough.
> 
> Aha, ok.  I'm glad I finally caught up; I'll take a look at this today.

Here's my first attempt to create a media verify ioctl, based on the
stupid strategy of reading into a page and letting the storage device
tell us if it thinks it succeeded:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=health-monitoring_2026-01-11&id=b3c128fae37102fca55eae50fa9f610d04b39973

and some changes to xfs_scrub to use it:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/commit/?h=health-monitoring_2026-01-11&id=5cd7b8549bd766080c3e7048ed3ad237934e0c53

(This is exactly the same as what xfs_scrub phase6 currently does, but
with even more context switching and memory allocation overhead.)

--D

> > > > > simply does direct reads to a throwaway page, to work around willy's
> > > > > objection that the existing scsi verify command doesn't require proof
> > > > > that the device actually did anything (and some of them clearly don't).
> > > > 
> > > > We could do that, although I'd make it conditional.  For the kind of
> > > > storage you want to store your data on it does work, as the customer
> > > > would get very unhappy otherwise.
> > > 
> > > Heheh.  It's really too bad that I have a bunch of Very Expensive RAID
> > > controllers that lie... and it's the crappy Samsung QVO SSDs that
> > > actually do the work.
> > 
> > Well, we can have versions of the ioctls that do verify vs a real read..
> 
> <nod> seeing as there's no block layer function for verify anyway, I'll
> have to start with submit_bio to a dummy page anyway.
> 
> --D
> 

