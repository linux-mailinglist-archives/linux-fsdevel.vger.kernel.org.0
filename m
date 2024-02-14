Return-Path: <linux-fsdevel+bounces-11517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2849685439B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 08:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC791C247DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 07:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60B5134A9;
	Wed, 14 Feb 2024 07:46:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B212E54;
	Wed, 14 Feb 2024 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896767; cv=none; b=MmSP3+oSD31ZSBLZu2CkUcQqeVHb6tCqNfoD5nRWa3sAig62qfkH/vKYz3CLAoGhrDx6GeveO25jJerHo16ff6Abm9j8NIb0jxVnv1rBEgmuzm6V0qdoUirBubtR5lgb304z0I2M9ZWH4lYISFWvIQDvj3D/1PufhElUcpMHLl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896767; c=relaxed/simple;
	bh=j2L0dsxXcUALJ2xrMWdCxrXsQ3lueIEYhmFrnKTCdFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clCgajX+tGpMsftY9BxBuPFKcpOL7HtMVtBG7JVojpRLuY+TYE6G4FfA6cibwn3xnsod/b321CMlvBeMmHJ30HO+p7XllWYBBsov36JwlkSLmiGTSVPaj7m6Z35Ojo8sXH7QFNaIRx/0lNYTsCmcadapTJfNJptV6NU24FfpI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A9CE227AAA; Wed, 14 Feb 2024 08:46:00 +0100 (CET)
Date: Wed, 14 Feb 2024 08:45:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, chandan.babu@oracle.com, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH 0/6] block atomic writes for XFS
Message-ID: <20240214074559.GB10006@lst.de>
References: <20240124142645.9334-1-john.g.garry@oracle.com> <20240213072237.GA24218@lst.de> <20240213175549.GU616564@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213175549.GU616564@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 13, 2024 at 09:55:49AM -0800, Darrick J. Wong wrote:
> On Tue, Feb 13, 2024 at 08:22:37AM +0100, Christoph Hellwig wrote:
> > From reading the series and the discussions with Darrick and Dave
> > I'm coming more and more back to my initial position that tying this
> > user visible feature to hardware limits is wrong and will just keep
> > on creating ever more painpoints in the future.
> > 
> > Based on that I suspect that doing proper software only atomic writes
> > using the swapext log item and selective always COW mode
> 
> Er, what are you thinking w.r.t. swapext and sometimescow?

What do you mean with sometimescow?  Just normal reflinked inodes?

> swapext
> doesn't currently handle COW forks at all, and it can only exchange
> between two of the same type of fork (e.g. both data forks or both attr
> forks, no mixing).
> 
> Or will that be your next suggestion whenever I get back to fiddling
> with the online fsck patches? ;)

Let's take a step back.  If we want atomic write semantics without
hardware offload, what we need is to allocate new blocks and atomically
swap them into the data fork.  Basicall an atomic version of
xfs_reflink_end_cow.  But yes, the details of the current swapext
item might not be an exact fit, maybe it's just shared infrastructure
and concepts.

I'm not planning to make you do it, because such a log item would
generally be pretty useful for always COW mode.

> > and making that
> > work should be the first step.  We can then avoid that overhead for
> > properly aligned writs if the hardware supports it.  For your Oracle
> > DB loads you'll set the alignment hints and maybe even check with
> > fiemap that everything is fine and will get the offload, but we also
> > provide a nice and useful API for less performance critical applications
> > that don't have to care about all these details.
> 
> I suspect they might want to fail-fast (back to standard WAL mode or
> whatever) if the hardware support isn't available.

Maybe for your particular DB use case.  But there's plenty of
applications that just want atomic writes without building their
own infrastruture, including some that want pretty large chunks.

Also if a file system supports logging data (which I have an
XFS early prototype for that I plan to finish), we can even do
the small double writes more efficiently than the application,
all through the same interface.

