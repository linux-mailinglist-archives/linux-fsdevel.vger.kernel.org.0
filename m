Return-Path: <linux-fsdevel+bounces-72876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB200D046F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D27E83105F93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21286264A86;
	Thu,  8 Jan 2026 16:14:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A1D262FC0;
	Thu,  8 Jan 2026 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888852; cv=none; b=qDuItGWshVacCqtNQl9BdA7wS1ZWOT80p2t+CfP8VO8TC1ySDYaEfOLUKqtNLSknYTQ7ZpyASW6wf67JMRbKSDz/d6MM3EOBQZi89rP9Emlz2QPhUScIyMd8v4WTRtUG7a5QetKX80CbD6FJoTI4vw1wjhX0cJA9scTZXvv1ZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888852; c=relaxed/simple;
	bh=G4ogkq1zHxsFqRjw7MGHnvgljSZLmywNKiytyqKTe4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYPLljpo+5PINe4V5aeWq0APDpU6ARJjkGTfUg8b5r67wkzKcFAxTcR1aK649xbSdkCqqQlsLm+2U+PH6oETlFBvbYiwu3NUeYbnEFNgW7PhhVvbEu95Cm2ldRNV3zc7032ciR4ftElMsVFmeGPFqRkWkepNXzwqnlNQCk2WvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B8FE9227AAA; Thu,  8 Jan 2026 17:14:05 +0100 (CET)
Date: Thu, 8 Jan 2026 17:14:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 11/11] xfs: add media error reporting ioctl
Message-ID: <20260108161404.GA10766@lst.de>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs> <176766637485.774337.16716764027357885673.stgit@frogsfrogsfrogs> <20260107093611.GC24264@lst.de> <20260107163035.GA15551@frogsfrogsfrogs> <20260108102559.GA25394@lst.de> <20260108160929.GH15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108160929.GH15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 08, 2026 at 08:09:29AM -0800, Darrick J. Wong wrote:
> But maybe the blockdev fs can implement the new fserror hook, see if
> there's a super_block associated with the bdev, and throw the fserror
> up to the mounted filesystem.
> 
> (Hard part: partitions)

All the partition mapping can be trivially undone.  I still think
issuing the commands on the block device instead of from the file
system feels wrong.

> > > Or I guess one of us should go figure out a reasonable verify command
> > > that would call fserror_* on media errors.
> > 
> > Hmm, I would expect the verify command to be issued by fs/xfs/scrub/
> > in the kernel, so that it can be directly tied into the in-kernel
> > logical to physical and rmap.  But you are more well versed there,
> > so maybe I'm missing something.
> 
> Did Chaitanya actually push for the verify command to get merged?

Not yet.

> I guess it wouldn't be terribly hard to make a stupid version that
> simply does direct reads to a throwaway page, to work around willy's
> objection that the existing scsi verify command doesn't require proof
> that the device actually did anything (and some of them clearly don't).

We could do that, although I'd make it conditional.  For the kind of
storage you want to store your data on it does work, as the customer
would get very unhappy otherwise.


