Return-Path: <linux-fsdevel+bounces-73377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A136D173A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E789B3069D51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76963793BD;
	Tue, 13 Jan 2026 08:12:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1876F3793AC;
	Tue, 13 Jan 2026 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291946; cv=none; b=Peg+mVsRqwG8oi0wbpMfM0EqX9Cvfph4DnsYzWKJP/j7c1bj397815Iw/5RHSxZ0i+40diU6zEB/0JJLmyhzd0xcaNxeWONCpQSnPfTFlohJ/czE1BO1wAhKoq064ZrU4LkC4dCzq9ZKlNZWlqkoYbKk0tsM/529WB3vt/PZ3QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291946; c=relaxed/simple;
	bh=DNFd102j054r5FnEeMtTIJcmuAO3bOs1G9f9PQgkbH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVw7ryAZWVskllJm1Z94q/D/yFswhqe+ujQ/NmHvxQlID6k82lTi0fO54qCFnDZwFTA6ebgCJfAPUxW2bQCW9DccXqtm+dXpn00zW4BZSigbdzoWa5NwxJqO6rVHmufEywYmcxy7PmoD05PO36yyzqtqw+izbhovAHbwVFDX770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8DC11227AA8; Tue, 13 Jan 2026 09:12:20 +0100 (CET)
Date: Tue, 13 Jan 2026 09:12:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 3/22] iomap: introduce IOMAP_F_BEYOND_EOF
Message-ID: <20260113081220.GB30809@lst.de>
References: <cover.1768229271.patch-series@thinky> <d5fc72ldfwyzbgiypzlhn5diiqyijxaicpa3w6obx4iismuko3@kttpcgqjy6i5> <20260112221853.GI15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112221853.GI15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 12, 2026 at 02:18:53PM -0800, Darrick J. Wong wrote:
> On Mon, Jan 12, 2026 at 03:50:05PM +0100, Andrey Albershteyn wrote:
> > Flag to indicate to iomap that read/write is happening beyond EOF and no
> > isize checks/update is needed.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/iomap/buffered-io.c | 13 ++++++++-----
> >  fs/iomap/trace.h       |  3 ++-
> >  include/linux/iomap.h  |  5 +++++
> >  3 files changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index e5c1ca440d..cc1cbf2a4c 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -533,7 +533,8 @@
> 
> (Does your diff program not set --show-c-function?  That makes reviewing
> harder because I have to search on the comment text to figure out which
> function this is)

Or use git-send-email which sidesteps all these issues :)

> Hrm.  The last test in iomap_block_needs_zeroing is if pos is at or
> beyond EOF, and iomap_adjust_read_range takes great pains to reduce plen
> so that poff/plen never cross EOF.  I think the intent of that code is
> to ensure that we always zero the post-EOF part of a folio when reading
> it in from disk.
> 
> For verity I can see why you don't want to zero the merkle tree blocks
> beyond EOF, but I think this code can expose unwritten junk in the
> post-EOF part of the EOF block on disk.
> 
> Would it be more correct to do:

Or replace the generic past EOF flag with a FSVERITY flag making
the use case clear?

> > @@ -1815,8 +1817,9 @@
> >  
> >  	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
> >  
> > -	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
> > -		return 0;
> > +	if (!(wpc->iomap.flags & IOMAP_F_BEYOND_EOF) &&
> > +	    !iomap_writeback_handle_eof(folio, inode, &end_pos))
> 
> Hrm.  I /think/ this might break post-eof zeroing on writeback if
> BEYOND_EOF is set.  For verity this isn't a problem because there's no
> writeback, but it's a bit of a logic bomb if someone ever tries to set
> BEYOND_EOF on a non-verity file.

Maybe we should not even support the flag for writeback?


