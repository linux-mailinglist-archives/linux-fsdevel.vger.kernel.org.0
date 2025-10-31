Return-Path: <linux-fsdevel+bounces-66587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77673C2524C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 14:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39463BC404
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 13:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B779E34AAF4;
	Fri, 31 Oct 2025 13:01:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD913271E9;
	Fri, 31 Oct 2025 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915661; cv=none; b=ixe060j1cZvEV3tCnEzQ7XMEU4nBtdHP7pPQrFNEgcnx/GjV79ediZ4YejnkNvjrB0wv0KRkZ5kiN06Zi/Orw0MhKO/dsFhDmGjMxmLawdRwCQN9kk/97gMORtnZjS5mJZM0ZIkAU1Cagyp3QYrS48vANtHDdgS5YTqN42l3V4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915661; c=relaxed/simple;
	bh=ZEn/aGQHjkZVe82YckT2+K8RU6xxfrWAYS8r175AALM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/S2IWEIxQ+O3iZ4tvPor45Lpp0HranXvT+dq/DUX1hLfZ0g7DDisphrtA5SrlMj4FVlnh/CrYpg3GGzDEnzN3EZA4zY1dzF7u4wfVw2Nn45ye0ifIE7y1HN4ngzsekYFa+b8SsSmN3s0KdANma/34TgzGoP69t0sobLgpev1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E8C55227A88; Fri, 31 Oct 2025 14:00:50 +0100 (CET)
Date: Fri, 31 Oct 2025 14:00:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <20251031130050.GA15719@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <aQNJ4iQ8vOiBQEW2@dread.disaster.area> <20251030143324.GA31550@lst.de> <aQPyVtkvTg4W1nyz@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQPyVtkvTg4W1nyz@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 31, 2025 at 10:18:46AM +1100, Dave Chinner wrote:
> I'm not asking about btrfs - I'm asking about actual, real world
> problems reported in production XFS environments.

The same things applies once we have checksums with PI.  But it seems
like you don't want to listen anyway.

> > For RAID you probably won't see too many reports, as with RAID the
> > problem will only show up as silent corruption long after a rebuild
> > rebuild happened that made use of the racy data.
> 
> Yet we are not hearing about this, either. Nobody is reporting that
> their data is being found to be corrupt days/weeks/months/years down
> the track.
> 
> This is important, because software RAID5 is pretty much the -only-
> common usage of BLK_FEAT_STABLE_WRITES that users are exposed to.

RAID5 bounce buffers by default.  It has a tunable to disable that:

https://sbsfaq.com/qnap-fails-to-reveal-data-corruption-bug-that-affects-all-4-bay-and-higher-nas-devices/

and once that was turned on it pretty much immediately caused data
corruption:

https://sbsfaq.com/qnap-fails-to-reveal-data-corruption-bug-that-affects-all-4-bay-and-higher-nas-devices/
https://sbsfaq.com/synology-nas-confirmed-to-have-same-data-corruption-bug-as-qnap/

> This patch set is effectively disallowing direct IO for anyone
> using software RAID5. That is simply not an acceptible outcome here.

Quite contrary, fixing this properly allows STABLE_WRITES to actually
work without bouncing in lower layers and at least get efficient
buffered I/O.

> 
> > With checksums
> > it is much easier to reproduce and trivially shown by various xfstests.
> 
> Such as? 

Basically anything using fsstress long enough plus a few others.

> 
> > With increasing storage capacities checksums are becoming more and
> > more important, and I'm trying to get Linux in general and XFS
> > specifically to use them well.
> 
> So when XFS implements checksums and that implementation is
> incompatible with Direct IO, then we can talk about disabling Direct
> IO on XFS when that feature is enabled. But right now, that feature
> does not exist, and ....

Every Linux file system supports checksums with PI capable device.
I'm trying to make it actually work for all case and perform well for a
while.

> 
> > Right now I don't think anyone is
> > using PI with XFS or any Linux file system given the amount of work
> > I had to put in to make it work well, and how often I see regressions
> > with it.
> 
> .... as you say, "nobody is using PI with XFS".
> 
> So patchset is a "fix" for a problem that no-one is actually having
> right now.

I'm making it work.

> Modifying an IO buffer whilst a DIO is in flight on that buffer has
> -always- been an application bug.

Says who?

> It is a vector for torn writes
> that don't get detected until the next read. It is a vector for
> in-memory data corruption of read buffers.

That assumes that particular use case cares about torn writes.  We've
never ever documented any such requirement.  We can't just make that
up 20+ years later.

> Indeed, it does not matter if the underlying storage asserts
> BLK_FEAT_STABLE_WRITES or not, modifying DIO buffers that are under
> IO will (eventually) result in data corruption.

It doesn't if that's not your assumption.  But more importantly with
RAID5 if you modify them you do not primarily corrupt your own data,
but other data in the stripe.  It is a way how a malicious user can
corrupt other users data.

> Hence, by your
> logic, we should disable Direct IO for everyone.

That's your weird logic, not mine.


