Return-Path: <linux-fsdevel+bounces-73495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B987AD1AE5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6C643052200
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC1B34FF48;
	Tue, 13 Jan 2026 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8UNWd/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416612EC090;
	Tue, 13 Jan 2026 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330093; cv=none; b=ojhLRAGOU8iOmsE+JbRxKUwcHDrfMYmtsAWsoCbJ19wIfRCh8vEm+teApXmF+FJb5JVtWZbdIR/y+k1l8lv+WGBb7xParNA/LCyuPzB/Ywkcgq71Nm+iE1tBirezG1+PMw9qkGM/fHlJgp89grNKFF7QUE0oCBaTfanko/ajvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330093; c=relaxed/simple;
	bh=HXFlgzO2W/NQ7+AHeOl7Rbk8HFGbjUHjTrPaWiqTEag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ny08i3NS1EjjESxBSUQJrI5Z7X3NqlDCe2Yk4Gkt8aABWMlZmJyMyvbWzzrf4Fx/hUxUhQtcsCaj0nDXFl6gxGrcNs1CZxhDCkP1OsUFXMsdeds8qfNsWCOZ+J1QjK+lHIMhqjl0PqDNRaxOEwwztH2qIAhuZ/eCTm1UNzuKLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8UNWd/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E50C19423;
	Tue, 13 Jan 2026 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768330092;
	bh=HXFlgzO2W/NQ7+AHeOl7Rbk8HFGbjUHjTrPaWiqTEag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8UNWd/FPrdkuGDzjd92Kq72AuXGap5gi6uUaAaLbYM5nNGGQpfatQFyxZrVtPyDC
	 cjsx3J8Gb4uReJQQDuPI9GQtnAvF8ySGRpRk1fzeAw4JDRpY6T4DfqyJeS5ixMk+JT
	 WYFlMcFo2yzltQQPoqjTrUl23FkPEAQcyrHHxD7sYJvt1eUCHEiCw5WOlls8gVZC25
	 VDHn8e3eVDZS0hfJiKdIYZpl17A4/qp4CW6AhUtbI0wipA6kYuraZbJjF0ohaB4QNp
	 i9x423ppJTAtu948tYL0TVQQQP9DZ0T5NarRmUGwQ6QljcfWuJD/+9lugG+kK+DYiX
	 7mlqyktNdAKlw==
Date: Tue, 13 Jan 2026 10:48:12 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 04/11] xfs: convey filesystem unmount events to the
 health monitor
Message-ID: <20260113184812.GB15551@frogsfrogsfrogs>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
 <176826412793.3493441.11061369088553154286.stgit@frogsfrogsfrogs>
 <20260113161105.GC4208@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113161105.GC4208@lst.de>

On Tue, Jan 13, 2026 at 05:11:05PM +0100, Christoph Hellwig wrote:
> > +	event = kzalloc(sizeof(struct xfs_healthmon_event), GFP_NOFS);
> > +	mutex_lock(&hm->lock);
> > +
> > +	trace_xfs_healthmon_report_unmount(hm);
> > +
> > +	if (event) {
> > +		/*
> > +		 * Insert the unmount notification at the start of the event
> > +		 * queue so that userspace knows the filesystem went away as
> > +		 * soon as possible.  There's nothing actionable for userspace
> > +		 * after an unmount.
> > +		 */
> > +		event->type = XFS_HEALTHMON_UNMOUNT;
> > +		event->domain = XFS_HEALTHMON_MOUNT;
> > +
> > +		__xfs_healthmon_insert(hm, event);
> 
> The allocation (and locking) could move into __xfs_healthmon_insert
> sharing this code with xfs_ioc_health_monitor().  That means the wake_up
> would not be covered by the lock, but I can't see how that would need
> it.
> 
> > +	} else {
> > +		/*
> > +		 * Wake up the reader directly in case we didn't have enough
> > +		 * memory to queue the unmount event.  The filesystem is about
> > +		 * to go away so we don't care about reporting previously lost
> > +		 * events.
> > +		 */
> > +		wake_up(&hm->wait);
> > +	}
> 
> And then even after reading this many times I'm still not understanding
> it.  Yes, this wakes up the reader direct, but why is waking it up
> without an even ok?

I think that was an artifact from an earlier stage in development where
it was necessary to wake up the reader to get it to drain the event
queue no matter what.  At this point I'd much rather preallocate the
unmount event because...

> And if it is ok, why do we even bother with the
> unmount even?  If OTOH the unmount event is actually important, should
> we preallocate the event?  (and render my above suggestion impractical).

...the unmount is important, because the userspace daemon uses that as
the signal to quit immediately.  If userspace misses the event then
it'll just keep running forever with a dead healthmon fd.

xfs_healer_start will restart the whole service if someone mounts
another xfs filesystem at the same mountpoint, but if nobody does that
then we'll be stuck with a defunct daemon forever.

Let's preallocate the unmount event, and then this whole thing becomes:

	/*
	 * Insert the unmount notification at the start of the event
	 * queue so that userspace knows the filesystem went away as
	 * soon as possible.  There's nothing actionable for userspace
	 * after an unmount.  Once we've inserted unmount_event, hm no
	 * longer owns that event.
	 */
	mutex_lock(&hm->lock);
	__xfs_healthmon_insert(hm, hm->unmount_event);
	hm->unmount_event = NULL;
	mutex_unlock(&hm->lock);

--D

