Return-Path: <linux-fsdevel+bounces-50833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E117AD009C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 12:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7697E189C815
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 10:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6163286D66;
	Fri,  6 Jun 2025 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2lQfPKA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93D2868A2;
	Fri,  6 Jun 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206605; cv=none; b=S6AkuX2bVFYqmj/0riu5hyJkM3CFb8XQrIQOxLONXSlzV1J/F3vZVE1RyOGB6Gx95fJM3sGUXriNPaerrLAqM/nnmSLYXnTr9co8xi5kbBQxTpZRLiLx0IjGlUjeymfbHkdhJSXp4oimv0tDZXS4TDcf2UGEDs5U8hcp1QLulJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206605; c=relaxed/simple;
	bh=d3M2yJtpoAEDHmcTRFJLeuPtxCzJh5eZlvKgfhER6sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFJhCuI24j/VasHr91wl8jHN8xRWYiuzU46tq3haA0p35c+6hbcl3NFH3ufUOcWH2/9N/KXA7RF1wgwKB935IKA4Ep3as+DGOr537mS9i2ElOYgn/CJ2+KcqCJOfBMkw4XF7TcjCCMBpVFd3w8r056zIsZNH15OTtb8mwbipozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2lQfPKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A69C4CEEB;
	Fri,  6 Jun 2025 10:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749206604;
	bh=d3M2yJtpoAEDHmcTRFJLeuPtxCzJh5eZlvKgfhER6sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2lQfPKA0L7XaPuZ61cSrM3FByq6PeZHd0eNDlO0k0LiGQwsAHvIlQ8khpbVLdWYO
	 wkg0ytrwKzteT5w21yhTAlJWr/Q7iHH3/rcW6ZAosmY5E/EePXCIgFtDgnD78JbVw9
	 yqsc4+bvNANvOv7GMPyulkzEmfLnVXNlMDQYbE1r/cg9uD7PKDeuNRp8E5pnI/6ckL
	 KYQZ5yyKRqmnqPtvNx01r9V/CLJfNexHdV3lIvpJWFG6Uypn8NrBLtGPO5ZiKfOqkg
	 3+N8TLCTTonS7Lo7PguzLvfzeoYHYGP8dYzzYp6Jl6Z1dPsZdEUijNm2+jng8JlPLK
	 ElWJQ06/heL1g==
Date: Fri, 6 Jun 2025 12:43:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, Yafang Shao <laoar.shao@gmail.com>, 
	cem@kernel.org, linux-xfs@vger.kernel.org, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <20250606-zickig-wirft-6c61ba630e2c@brauner>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <20250529042550.GB8328@frogsfrogsfrogs>
 <20250530-ahnen-relaxen-917e3bba8e2d@brauner>
 <20250530153847.GC8328@frogsfrogsfrogs>
 <aDuKgfi-CCykPuhD@dread.disaster.area>
 <20250603000327.GM8328@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603000327.GM8328@frogsfrogsfrogs>

On Mon, Jun 02, 2025 at 05:03:27PM -0700, Darrick J. Wong wrote:
> On Sun, Jun 01, 2025 at 09:02:25AM +1000, Dave Chinner wrote:
> > On Fri, May 30, 2025 at 08:38:47AM -0700, Darrick J. Wong wrote:
> > > On Fri, May 30, 2025 at 07:17:00AM +0200, Christian Brauner wrote:
> > > > On Wed, May 28, 2025 at 09:25:50PM -0700, Darrick J. Wong wrote:
> > > > > On Thu, May 29, 2025 at 10:50:01AM +0800, Yafang Shao wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > Recently, we encountered data loss when using XFS on an HDD with bad
> > > > > > blocks. After investigation, we determined that the issue was related
> > > > > > to writeback errors. The details are as follows:
> > > > > > 
> > > > > > 1. Process-A writes data to a file using buffered I/O and completes
> > > > > > without errors.
> > > > > > 2. However, during the writeback of the dirtied pagecache pages, an
> > > > > > I/O error occurs, causing the data to fail to reach the disk.
> > > > > > 3. Later, the pagecache pages may be reclaimed due to memory pressure,
> > > > > > since they are already clean pages.
> > > > > > 4. When Process-B reads the same file, it retrieves zeroed data from
> > > > > > the bad blocks, as the original data was never successfully written
> > > > > > (IOMAP_UNWRITTEN).
> > > > > > 
> > > > > > We reviewed the related discussion [0] and confirmed that this is a
> > > > > > known writeback error issue. While using fsync() after buffered
> > > > > > write() could mitigate the problem, this approach is impractical for
> > > > > > our services.
> > > > > > 
> > > > > > Instead, we propose introducing configurable options to notify users
> > > > > > of writeback errors immediately and prevent further operations on
> > > > > > affected files or disks. Possible solutions include:
> > > > > > 
> > > > > > - Option A: Immediately shut down the filesystem upon writeback errors.
> > > > > > - Option B: Mark the affected file as inaccessible if a writeback error occurs.
> > > > > > 
> > > > > > These options could be controlled via mount options or sysfs
> > > > > > configurations. Both solutions would be preferable to silently
> > > > > > returning corrupted data, as they ensure users are aware of disk
> > > > > > issues and can take corrective action.
> > > > > > 
> > > > > > Any suggestions ?
> > > > > 
> > > > > Option C: report all those write errors (direct and buffered) to a
> > > > > daemon and let it figure out what it wants to do:
> > > > > 
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=health-monitoring_2025-05-21
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=health-monitoring-rust_2025-05-21
> > > > > 
> > > > > Yes this is a long term option since it involves adding upcalls from the
> > > > 
> > > > I hope you don't mean actual usermodehelper upcalls here because we
> > > > should not add any new ones. If you just mean a way to call up from a
> > > > lower layer than that's obviously fine.
> > > 
> > > Correct.  The VFS upcalls to XFS on some event, then XFS queues the
> > > event data (or drops it) and waits for userspace to read the queued
> > > events.  We're not directly invoking a helper program from deep in the
> > > guts, that's too wild even for me. ;)
> > > 
> > > > Fwiw, have you considered building this on top of a fanotify extension
> > > > instead of inventing your own mechanism for this?
> > > 
> > > I have, at various stages of this experiment.
> > > 
> > > Originally, I was only going to export xfs-specific metadata events
> > > (e.g. this AG's inode btree index is bad) so that the userspace program
> > > (xfs_healer) could initiate a repair against the broken pieces.
> > > 
> > > At the time I thought it would be fun to experiment with an anonfd file
> > > that emitted jsonp objects so that I could avoid the usual C struct ABI
> > > mess because json is easily parsed into key-value mapping objects in a
> > > lot of languages (that aren't C).  It later turned out that formatting
> > > the json is rather more costly than I thought even with seq_bufs, so I
> > > added an alternate format that emits boring C structures.
> > > 
> > > Having gone back to C structs, it would be possibly (and possibly quite
> > > nice) to migrate to fanotify so that I don't have to maintain a bunch of
> > > queuing code.  But that can have its own drawbacks, as Ted and I
> > > discovered when we discussed his patches that pushed ext4 error events
> > > through fanotify:
> > > 
> > > For filesystem metadata events, the fine details of representing that
> > > metadata in a generic interface gets really messy because each
> > > filesystem has a different design.
> > 
> > Perhaps that is the wrong approach. The event just needs to tell
> > userspace that there is a metadata error, and the fs specific agent
> > that receives the event can then pull the failure information from
> > the filesystem through a fs specific ioctl interface.
> > 
> > i.e. the fanotify event could simply be a unique error, and that
> > gets passed back into the ioctl to retreive the fs specific details
> > of the failure. We might not even need fanotify for this - I suspect
> > that we could use udev events to punch error ID notifications out to
> > userspace to trigger a fs specific helper to go find out what went
> > wrong.
> 
> I'm not sure if you're addressing me or brauner, but I think it would be
> even simpler to retain the current design where events are queued to our
> special xfs anonfd and read out by userspace.  Using fanotify as a "door
> bell" to go look at another fd is ... basically poll() but far more
> complicated than it ought to be.  Pounding udev with events can result
> in userspace burning a lot of energy walking the entire rule chain.

I don't think we need to rush any of this. My main concern is that if we
come up with something then I want it to be able to be used by other
filesystems as this seems something that is generally very useful. By
using fanotify we implicitly enable this which is why I'm asking.

I don't want the outcome to be that there's a filesystem with a very
elaborate and detailed scheme that cannot be used by another one and
then we end up with slightly different implementations of the same
underlying concept. And so it will be impossible for userspace to
consume correctly even if abstracted in multiple libraries.

I think udev is the wrong medium for this and I'm pretty sure that the
udev maintainers agree with me on this.

I think this specific type of API would really benefit from gathering
feedback from userspace. There's All Systems Go in Berlin in September
and that might not be the worst time to present what you did and give a
little demo. I'm not sure how fond you are of traveling though rn:
https://all-systems-go.io/

> 
> > Keeping unprocessed failures in an internal fs queue isn't a big
> > deal; it's not a lot of memory, and it can be discarded on unmount.
> > At that point we know that userspace did not care about the
> > failure and is not going to be able to query about the failure in
> > future, so we can just throw it away.
> > 
> > This also allows filesystems to develop such functionality in
> > parallel, allowing us to find commonality and potential areas for
> > abstraction as the functionality is developed, rahter than trying to
> > come up with some generic interface that needs to support all
> > possible things we can think of right now....
> 
> Agreed.  I don't think Ted or Jan were enthusiastic about trying to make
> a generic fs metadata event descriptor either.

