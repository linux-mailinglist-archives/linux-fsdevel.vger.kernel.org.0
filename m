Return-Path: <linux-fsdevel+bounces-72880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B49D04DCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A8153123BB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D0B26E70E;
	Thu,  8 Jan 2026 16:20:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894C0263C8A;
	Thu,  8 Jan 2026 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889237; cv=none; b=Mso+LtJ0douoQUJDIM3qTe3Yane/0xAn+2oYGRWBvq19TRbphkiV7X7otCO1CzP3dqvp7YYKQUjtR4eIf2jePkguLEDt4b7UULxM0SYvPHxyUImsYzt2J0hoU6nO6Kz7xw75w2CvcerRNcA33Sd6T9UFbUAqvu7NjWa8C8a5f/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889237; c=relaxed/simple;
	bh=nZ8O1kxNUuPBl++wduO7GtJcTD+BiEMXF5HFOztNR9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fk4dNPkeoMqJgqKltlmvUY8wPGCZE7vMKwbDCjECLpdIXBaP95lhOWBjyOJL6mmpO2n4yuG3H9sLYGqubhK/l9CxHbMHoQa7JMNQp/0ghwsMg6mu+PBys9svCt7lqrsGw18Fi/sD+8QVB+R04CeEjonqJ8fLjh86QyLbwmEx3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0D27667373; Thu,  8 Jan 2026 17:20:33 +0100 (CET)
Date: Thu, 8 Jan 2026 17:20:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 11/11] xfs: add media error reporting ioctl
Message-ID: <20260108162032.GA11429@lst.de>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs> <176766637485.774337.16716764027357885673.stgit@frogsfrogsfrogs> <20260107093611.GC24264@lst.de> <20260107163035.GA15551@frogsfrogsfrogs> <20260108102559.GA25394@lst.de> <20260108160929.GH15551@frogsfrogsfrogs> <20260108161404.GA10766@lst.de> <20260108161817.GI15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108161817.GI15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 08, 2026 at 08:18:17AM -0800, Darrick J. Wong wrote:
> > All the partition mapping can be trivially undone.  I still think
> > issuing the commands on the block device instead of from the file
> > system feels wrong.
> 
> "From the filesystem"?  That gives me an idea: what if xfs_scrub instead
> opens the root dir, calls an ioctl that does the verify work, and that
> ioctl then reports the result to userspace and xfs_healthmon?
> 
> As opposed to this kind of stupid reporting ioctl?

Yes, that's what I've been trying to push for.  I guess I didn't really
express that clearly enough.

> > > simply does direct reads to a throwaway page, to work around willy's
> > > objection that the existing scsi verify command doesn't require proof
> > > that the device actually did anything (and some of them clearly don't).
> > 
> > We could do that, although I'd make it conditional.  For the kind of
> > storage you want to store your data on it does work, as the customer
> > would get very unhappy otherwise.
> 
> Heheh.  It's really too bad that I have a bunch of Very Expensive RAID
> controllers that lie... and it's the crappy Samsung QVO SSDs that
> actually do the work.

Well, we can have versions of the ioctls that do verify vs a real read..

