Return-Path: <linux-fsdevel+bounces-39210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D6DA115B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174EB1888FDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 23:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5800321C9E4;
	Tue, 14 Jan 2025 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2zWRssJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBBE20F97C;
	Tue, 14 Jan 2025 23:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899048; cv=none; b=cdRsfP6lO8jV+z7YlfJVJFzPQdj//2/OGEH3+TIbI5l/NKiDbZlhvQ7Jw6NDqiD8IBhppVOxqJM/Wee0VWE9XzU3Jez0qmU71Y/m1UIMELNmx8tGUBh5S9Czf50YutZkyPrZjjKkVON8mBhX2AeeFj8ELM9VThS6uLQ+hazU/dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899048; c=relaxed/simple;
	bh=3vUP1EaUHYnR7E43+5MGJne5mxuhlaMPxsiO9F2tOME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE4nneQSkza/U+A+fMHqWryWr1I3i8fAcMxbFCF3Zpf5vS0AKxxAnbEWjzdXWIIAiTYR1bKRZQ3/77fMYOIfEjdD1IyrbaVG0O3ewusndtIvVOIXOvRql22/TDwPYKlDUUNbnMEbVfq02qNATLpq0EQlyyxi7aO92vEMjD746XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2zWRssJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C9CC4CEDD;
	Tue, 14 Jan 2025 23:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736899047;
	bh=3vUP1EaUHYnR7E43+5MGJne5mxuhlaMPxsiO9F2tOME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2zWRssJIJfKezUUjNhNJzVAYrJITsmCsxgwROg2cPvlKiSJb6F3u6VDtDnu+o5G4
	 2GZ0ZyAVVU6Axl9YXMG8WpniIWGNeVtCFCZ208T+hG7gbH48j4QtJiwx40P7x96mLp
	 83bhZ15anZmq9gD92SBk7/8kIvEdI8N9FtW0Lw98w1bON/srp7wnDjJiWzyCcj054S
	 sXTg30lp2sUex7W/R1FdI67lk/lRRfxf3XuGsowkwHV4sQYRPEcjiGiKmkHEe0qu7j
	 2a/jJWKkQxAZY19DA5qXEvBNzXhMhDbsHdn7VOkWZweOs2hUxANrwxmez2waPrHE3X
	 7XE3zSWnYk+zA==
Date: Tue, 14 Jan 2025 15:57:26 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
Message-ID: <20250114235726.GA3566461@frogsfrogsfrogs>
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
 <Z1IX2dFida3coOxe@dread.disaster.area>
 <20241212013433.GC6678@frogsfrogsfrogs>
 <Z4Xq6WuQpVOU7BmS@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Xq6WuQpVOU7BmS@dread.disaster.area>

On Tue, Jan 14, 2025 at 03:41:13PM +1100, Dave Chinner wrote:
> On Wed, Dec 11, 2024 at 05:34:33PM -0800, Darrick J. Wong wrote:
> > On Fri, Dec 06, 2024 at 08:15:05AM +1100, Dave Chinner wrote:
> > > On Thu, Dec 05, 2024 at 10:52:50AM +0000, John Garry wrote:
> > > e.g. look at MySQL's use of fallocate(hole punch) for transparent
> > > data compression - nobody had forseen that hole punching would be
> > > used like this, but it's a massive win for the applications which
> > > store bulk compressible data in the database even though it does bad
> > > things to the filesystem.
> > > 
> > > Spend some time looking outside the proprietary database application
> > > box and think a little harder about the implications of atomic write
> > > functionality.  i.e. what happens when we have ubiquitous support
> > > for guaranteeing only the old or the new data will be seen after
> > > a crash *without the need for using fsync*.
> > 
> > IOWs, the program either wants an old version or a new version of the
> > files that it wrote, and the commit boundary is syncfs() after updating
> > all the files?
> 
> Yes, though there isn't a need for syncfs() to guarantee old-or-new.
> That's the sort of thing an application can choose to do at the end
> of it's update set...

Well yes, there has to be a caches flush somewhere -- last I checked,
RWF_ATOMIC doesn't require that the written data be persisted after the
call completes.

> > > Think about the implications of that for a minute - for any full
> > > file overwrite up to the hardware atomic limits, we won't need fsync
> > > to guarantee the integrity of overwritten data anymore. We only need
> > > a mechanism to flush the journal and device caches once all the data
> > > has been written (e.g. syncfs)...
> > 
> > "up to the hardware atomic limits" -- that's a big limitation.  What if
> > I need to write 256K but the device only supports up to 64k?  RWF_ATOMIC
> > won't work.  Or what if the file range I want to dirty isn't aligned
> > with the atomic write alignment?  What if the awu geometry changes
> > online due to a device change, how do programs detect that?
> 
> If awu geometry changes dynamically in an incompatible way, then
> filesystem RWF_ATOMIC alignment guarantees are fundamentally broken.
> This is not a problem the filesystem can solve.
> 
> IMO, RAID device hotplug should reject new device replacement that
> has incompatible atomic write support with the existing device set.
> With that constraint, the whole mess of "awu can randomly change"
> problems go away.

Assuming device mapper is subject to that too, I agree.

> > Programs that aren't 100% block-based should use exchange-range.  There
> > are no alignment restrictions, no limits on the size you can exchange,
> > no file mapping state requiments to trip over, and you can update
> > arbitrary sparse ranges.  As long as you don't tell exchange-range to
> > flush the log itself, programs can use syncfs to amortize the log and
> > cache flush across a bunch of file content exchanges.
> 
> Right - that's kinda my point - I was assuming that we'd be using
> something like xchg-range as the "unaligned slow path" for
> RWF_ATOMIC.
> 
> i.e. RWF_ATOMIC as implemented by a COW capable filesystem should
> always be able to succeed regardless of IO alignment. In these
> situations, the REQ_ATOMIC block layer offload to the hardware is a
> fast path that is enabled when the user IO and filesystem extent
> alignment matches the constraints needed to do a hardware atomic
> write.
> 
> In all other cases, we implement RWF_ATOMIC something like
> always-cow or prealloc-beyond-eof-then-xchg-range-on-io-completion
> for anything that doesn't correctly align to hardware REQ_ATOMIC.
> 
> That said, there is nothing that prevents us from first implementing
> RWF_ATOMIC constraints as "must match hardware requirements exactly"
> and then relaxing them to be less stringent as filesystems
> implementations improve. We've relaxed the direct IO hardware
> alignment constraints multiple times over the years, so there's
> nothing that really prevents us from doing so with RWF_ATOMIC,
> either. Especially as we have statx to tell the application exactly
> what alignment will get fast hardware offloads...

Ok, let's do that then.  Just to be clear -- for any RWF_ATOMIC direct
write that's correctly aligned and targets a single mapping in the
correct state, we can build the untorn bio and submit it.  For
everything else, prealloc some post EOF blocks, write them there, and
exchange-range them.

Tricky questions: How do we avoid collisions between overlapping writes?
I guess we find a free file range at the top of the file that is long
enough to stage the write, and put it there?  And purge it later?

Also, does this imply that the maximum file size is less than the usual
8EB?

(There's also the question about how to do this with buffered writes,
but I guess we could skip that for now.)

> > Even better, if you still wanted to use untorn block writes to persist
> > the temporary file's dirty data to disk, you don't even need forcealign
> > because the exchange-range will take care of restarting the operation
> > during log recovery.  I don't know that there's much point in doing that
> > but the idea is there.
> 
> *nod*
> 
> > > Want to overwrite a bunch of small files safely?  Atomic write the
> > > new data, then syncfs(). There's no need to run fdatasync after each
> > > write to ensure individual files are not corrupted if we crash in
> > > the middle of the operation. Indeed, atomic writes actually provide
> > > better overwrite integrity semantics that fdatasync as it will be
> > > all or nothing. fdatasync does not provide that guarantee if we
> > > crash during the fdatasync operation.
> > > 
> > > Further, with COW data filesystems like XFS, btrfs and bcachefs, we
> > > can emulate atomic writes for any size larger than what the hardware
> > > supports.
> > > 
> > > At this point we actually provide app developers with what they've
> > > been repeatedly asking kernel filesystem engineers to provide them
> > > for the past 20 years: a way of overwriting arbitrary file data
> > > safely without needing an expensive fdatasync operation on every
> > > file that gets modified.
> > > 
> > > Put simply: atomic writes have a huge potential to fundamentally
> > > change the way applications interact with Linux filesystems and to
> > > make it *much* simpler for applications to safely overwrite user
> > > data.  Hence there is an imperitive here to make the foundational
> > > support for this technology solid and robust because atomic writes
> > > are going to be with us for the next few decades...
> > 
> > I agree that we need to make the interface solid and robust, but I don't
> > agree that the current RWF_ATOMIC, with its block-oriented storage
> > device quirks is the way to go here.
> 
> > Maybe a byte-oriented RWF_ATOMIC
> > would work, but the only way I can think of to do that is (say) someone
> > implements Christoph's suggestion to change the COW code to allow
> > multiple writes to a staging extent, and only commit the remapping
> > operations at sync time... and you'd still have problems if you have to
> > do multiple remappings if there's not also a way to restart the ioend
> > chains.
> > 
> > Exchange-range already solved all of that, and it's already merged.
> 
> Yes, I agree that the block-device quirks need to go away from
> RWF_ATOMIC, but I think it's the right interface for applications
> that want to use atomic overwrite semantics.

Ok.

> Hiding exchange-range under the XFS covers for unaligned atomic IO
> would mean applications won't need to target XFS specific ioctls to
> do reliable atomic overwrites. i.e. the API really needs to be
> simple and filesystem independent, and RWF_ATOMIC gives us that...

<nod>

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

