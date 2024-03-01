Return-Path: <linux-fsdevel+bounces-13231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DAB86D81C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 01:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC9A1F22D1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 00:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4369A63C;
	Fri,  1 Mar 2024 00:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us1rVkPG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE717E;
	Fri,  1 Mar 2024 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251410; cv=none; b=rAE+Ir+cNmBgELYUOARQG8e9JEDua54JE8uCh6zh8gzXd/QJWInmxQ/boFQMRJ1MhMZLLEwPMhz1rXipgIKy3nahXd4tgJWuYR5iEE2LQbaH/lrb8lvgGy0uE70BGQEVI3Z80VW7z07m8y+VRVlPCZCPVhjzKZWmomgHyzlylcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251410; c=relaxed/simple;
	bh=QHvk9C3U20n8u+vI2eeOPtcTBK0DSoLTgny0C/YbSBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOqvpuG5CWs4GeHEJxJBhm1m3IAPmY/3tcuxdjOKjM8DRLMdEuaUqzjQFymK+VDRT30i55v8gjmR6tRxl9CDlaTUTqYZ9LNJeKKUYWp2+b2bl4f6GkRGFkGI3QuZWv0JiZTeto9VTPbH0i6ATBlkU2HGwKLlNgq2h0JvxXo7GsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us1rVkPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27474C433F1;
	Fri,  1 Mar 2024 00:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709251410;
	bh=QHvk9C3U20n8u+vI2eeOPtcTBK0DSoLTgny0C/YbSBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Us1rVkPG5lB1uXCGaXOEK1G6T7lhXsQ9LwCiT5DFoTjU8wJwlsbR2jEYhfnmTLjJt
	 1Q6KaWeDHb2SmXqc9d9BrGGx1sS+aUtOMxwTYN6uLLjI0tzbT2jPt41lkj6ASpBrAK
	 yRcP+Qom7WLON4YDD4MxzzSc92G0IYoIzteakZuf5OktA+JJpN/jYHwAFI1oU41XP9
	 skf9PcGABG29+B/9FbxoZYxp1h5WvTfGPBaBmQDxJJRnKPVF97v6VG05xmolYjTV9A
	 6oIrq6w0tfOWLfSbIjq6lhch+C9rvtSNz2fNsIFH0BMId2TrG45QThjFeS1vUahO49
	 JS9KRPripv5jw==
Date: Thu, 29 Feb 2024 16:03:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Colin Walters <walters@verbum.org>
Cc: linux-fsdevel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHSET v29.4 03/13] xfs: atomic file content exchanges
Message-ID: <20240301000329.GF1927156@frogsfrogsfrogs>
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
 <87961163-a4b9-4032-aa06-f5126c9c8ca2@app.fastmail.com>
 <20240229201840.GC1927156@frogsfrogsfrogs>
 <7282e2c3-f44a-4425-b0f7-24d1182e5499@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7282e2c3-f44a-4425-b0f7-24d1182e5499@app.fastmail.com>

On Thu, Feb 29, 2024 at 05:43:21PM -0500, Colin Walters wrote:
> 
> 
> On Thu, Feb 29, 2024, at 3:18 PM, Darrick J. Wong wrote:
> >
> > Correct, there's no built-in dedupe.  For small files you'll probably
> > end up with a single allocation anyway, which is ideal in terms of
> > ondisk metadata overhead.
> 
> Makes sense.
> 
> > though I would bet that extending linkat (or rename, or
> > whatever) is going to be the only workable solution for old / simple
> > filesystems (e.g. fat32).
> 
> Ah, right; that too.
> 
> > How /does/ dconf handle those changes?  Does it rename the file and
> > signal all the other dconf threads to reopen the file?  And then those
> > threads get the new file contents?
> 
> I briefly skimmed the code and couldn't find it, but yes I believe
> it's basically that clients have an inotify watch that gets handled
> from the mainloop and clients close and reopen and re-mmap - it's
> probably nonexistent to have non-mainloop threads reading things from
> the mmap, so there's no races with any other threads.

Hrmm.  IIRC inotify and fanotify both use the same fsnotify backend.
fsnotify events are emitted after i_rwsem drops, which (if I read
read_write.c correctly) means this is technically racy.

That said if they're mostly waiting around in the inotify loop then it
probably doesn't matter.

> > Huurrrh hurrrh.  That's right, I don't see how exchange can mesh well
> > with mmap without actual flock()ing. :(
> >
> > fsnotify will send a message out to userspace after the exchange
> > finishes, which means that userspace could watch for the notifications
> > via fanotify.  However, that's still a bit racy... :/
> 
> Right.  However...it's not just about mmap.  Sorry this is a minor
> rant but...near my top ten list of changes to make with a time machine
> for Unix would be the concept of a contents-immutable file, like all
> the seals that work on memfd with F_ADD_SEALS (and outside of
> fsverity, which is good but can be a bit of a heavier hammer).

You and me both. :)

Also I want a persistent file contents write counter; and a
file-anything write counter.

Oh, and a conditional read where you pass in the file contents write
counter and returns an error if the file has been changed since sampling
time.  The changecookie thing mentioned elsewhere gets us towards that,
if onlty the issues w/ XFS get resolved.

> A few times I've been working on shell script in my editor on my
> desktop, and these shell scripts are tests because shell script is so
> tempting.  I'm sure this familiar, given (x)fstests.
> 
> And if you just run the tests (directly from source in git), and then
> notice a bug, and start typing in your editor, save the changes, and
> then and your editor happens to do a generic "open(O_TRUNC), save"
> instead of an atomic rename.  This happens to be what `nano` and
> VSCode do, although at least the `vi` I have here does an atomic
> rename.  (One could say all editors that don't are broken...but...)

I think they do O_TRUNC because it saves them from having to copy the
file attrs and xattrs.  Too bad it severely screws up a program running
in another terminal that just happens to hit the zero-byte file.

> And now because the way bash works (and I assume other historical Unix
> shells) is that they interpret the file *as they're reading it* in
> this scenario you can get completely undefined behavior.  It could do
> *anything*.
> 
> At least one of those times, I got an error from an `rm -rf`
> invocation that happened to live in one of those test scripts...that
> could have in theory just gone off and removed anything.
> 
> Basically the contents-immutable is really what you *always* want for
> executables and really anything that can be parsed without locking
> (like, almost all config files in /etc too).  With ELF files there's

Yes.

> EXTBUSY if it *happens* to be in use, but that's just a hack.  Also in

A hack that doesn't work for scripts.  Either interpreters have to read
the entire script into memory before execution, or I guess they can do
the insane thing that the DOS batch interpreter did, where before each
statement it would save the file pos, close it, execute the command,
reopen the batch file, and seek back to that line.

> that other thread about racing writes to suid executables...well,
> there'd be no possibility for races if we just denied writing because
> again - it makes no sense to just make random writes in-place to an
> executable.  (OK I did see the zig folks are trying an incremental
> linker, but still I would just assume reflinks are available for that)
> 
> Now this is relevant here because, I don't think anything like
> dpkg/rpm and all those things could ever use this ioctl for this
> reason.

Right.  dpkg executable file replacement really doesn't make much sense
for exchange range.  That's also wasn't the usecase I was targetting
though admittedly I'm only using this ioctl to test functionality that
online fsck requires.

> So, it seems to me like it should really be more explicitly targeted at
> - Things that are using open()+write() today and it's safe for that use case
> - The database cases
> 
> And not talk about replacing the general open(O_TMPFILE) + rename() path.

I think I'll change the cover letter to talk about what it does, what
problems it solves, and what problems it introduces.  Figuring out how
to take advantage of it is an exercise for application writers.

--D

