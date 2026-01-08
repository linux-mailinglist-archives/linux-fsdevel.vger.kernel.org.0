Return-Path: <linux-fsdevel+bounces-72883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1576D04B4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AFFF30AD549
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27F12F9D83;
	Thu,  8 Jan 2026 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As0Ibtdj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269972F39D1;
	Thu,  8 Jan 2026 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891228; cv=none; b=ewBGeiEiysx3E3Y+sz+wlZwbrKqqyeLbuTF7G4CnyjSv8LqZ8xPWSOH5coPJ7XnjvwENyZW1q1kL+BoHZlsI7IZyf4yfWWLF4u9hW2gzi0c8XLd74beP/oR5Y5O9ScPxB773I7q/Uz3AIabbFRhDLtbc4wlPoR3BVF7qGsfV100=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891228; c=relaxed/simple;
	bh=Hh/i3FXj5iEXhAsSNl7uiWglOYwU71tHpmyFD2ISOQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL1eRcppGs0hAWqGq60zbeGcPlIDGDl465o4agjbYbs1TujYbVMnUYHKt791+m7kOjAjXAbnYVc7wnNBtMOdikaQPpOGEbb4YX9aSf8akAsWU7J3+j4/jbT5rxsiHYvxYN9ccwRWdMRRdTokJnBG40cbZCy7YCC6z5YEEfpB7dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As0Ibtdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8247FC2BCAF;
	Thu,  8 Jan 2026 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767891227;
	bh=Hh/i3FXj5iEXhAsSNl7uiWglOYwU71tHpmyFD2ISOQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=As0Ibtdj66kEpyncqrw7thlom7rJHXjiTMhNvhJ0UWv2Arft8hQM7ayXs0ltOCH5G
	 stsw+AqigFGhotdb/WLeee0kEHIA4u7bBA6N0Xgyw7JwmtAZiGIYgk4U3EakURstJr
	 SouPnfBDtaH6lecjVaQEoacw3e/igYusiXp2hl93ZUy2HuSszFBjf386GNmij1umju
	 xE+FgSCJB7wFaFD5ZodnYD5nrN8Hu1DsUAlYZrmY1V7yEPC+dut+nODPOMZvSRo8ww
	 rDZy01nBXrpJbWA4oub5v2PxqA+TycJII+WdQeovRfT9P+4unx21v8z02SqAClXaCJ
	 u97eb691nFQ2w==
Date: Thu, 8 Jan 2026 08:53:47 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 11/11] xfs: add media error reporting ioctl
Message-ID: <20260108165347.GE15583@frogsfrogsfrogs>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
 <176766637485.774337.16716764027357885673.stgit@frogsfrogsfrogs>
 <20260107093611.GC24264@lst.de>
 <20260107163035.GA15551@frogsfrogsfrogs>
 <20260108102559.GA25394@lst.de>
 <20260108160929.GH15551@frogsfrogsfrogs>
 <20260108161404.GA10766@lst.de>
 <20260108161817.GI15551@frogsfrogsfrogs>
 <20260108162032.GA11429@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108162032.GA11429@lst.de>

On Thu, Jan 08, 2026 at 05:20:32PM +0100, Christoph Hellwig wrote:
> On Thu, Jan 08, 2026 at 08:18:17AM -0800, Darrick J. Wong wrote:
> > > All the partition mapping can be trivially undone.  I still think
> > > issuing the commands on the block device instead of from the file
> > > system feels wrong.
> > 
> > "From the filesystem"?  That gives me an idea: what if xfs_scrub instead
> > opens the root dir, calls an ioctl that does the verify work, and that
> > ioctl then reports the result to userspace and xfs_healthmon?
> > 
> > As opposed to this kind of stupid reporting ioctl?
> 
> Yes, that's what I've been trying to push for.  I guess I didn't really
> express that clearly enough.

Aha, ok.  I'm glad I finally caught up; I'll take a look at this today.

> > > > simply does direct reads to a throwaway page, to work around willy's
> > > > objection that the existing scsi verify command doesn't require proof
> > > > that the device actually did anything (and some of them clearly don't).
> > > 
> > > We could do that, although I'd make it conditional.  For the kind of
> > > storage you want to store your data on it does work, as the customer
> > > would get very unhappy otherwise.
> > 
> > Heheh.  It's really too bad that I have a bunch of Very Expensive RAID
> > controllers that lie... and it's the crappy Samsung QVO SSDs that
> > actually do the work.
> 
> Well, we can have versions of the ioctls that do verify vs a real read..

<nod> seeing as there's no block layer function for verify anyway, I'll
have to start with submit_bio to a dummy page anyway.

--D

