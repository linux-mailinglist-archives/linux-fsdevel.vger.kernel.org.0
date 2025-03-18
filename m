Return-Path: <linux-fsdevel+bounces-44234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FE8A664C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 02:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12D4189C003
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 01:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308DE8468;
	Tue, 18 Mar 2025 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fN2GcF9H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B515A87C
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260513; cv=none; b=kpZ5GPdmUJwTBoY+87iUPsUGPBHmZMNMQ5IXouEppIzuIdYYisHnxGOW0ayPbuiAm2A/kf/TvZ4rqsdUupSAkxwFoF/Ggm1h39ZgVoYN2EPoMikW0/Rsus8x+618w+U73OSyTeNFgmmjIzkSv+ulqDrPrkdd1xrAnYo3Pl7asJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260513; c=relaxed/simple;
	bh=Bli4yDmu5+3qrchprxkFeZDERB5C2XJ6haYQD7Z5688=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoEwRrwWyNRWo2ywez7jtOh/MU8pKFhU+WtQVf6D4H+TQ/r7FdsQDYvI+LJF2a7Mwgd0+kijs8RfHTf+F6U9Deqc9hsui0Di6XTn2YHx8qBO4mJO2bOHkO4WmA4fh+92MAUeC05KAFyGT0PpX1jujlQWEvA6XgYCEOCIUzCU1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fN2GcF9H; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 17 Mar 2025 21:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742260509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Q7/l4Ub370JHe+SyOW8etUedb9vG4uU2/MyRZY5mf4=;
	b=fN2GcF9HJn9s+ei475W6p/NCBLxB68JGBzF8tCZhF8//dsXWCY1aGXCI1CATTqVqYE91XD
	sw2ArNagu5VKQZwg2tOFtMoh1HPl269S+YkNpoPMTUS0sU1nrjPfgr5Cxek++T/WG+i15I
	WozqnAJ3P7w/ZPn886CfBNVKx4YGyls=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: John Stoffel <john@stoffel.org>
Cc: linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org, 
	Roland Vet <vet.roland@protonmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/14] better handling of checksum errors/bitrot
Message-ID: <avmzp2nswsowb3hg2tcrb6fv2djgkiw7yl3bgdn4dnccuk4yti@ephd5sxy5b7w>
References: <20250311201518.3573009-1-kent.overstreet@linux.dev>
 <26584.35900.850011.320586@quad.stoffel.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26584.35900.850011.320586@quad.stoffel.home>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 17, 2025 at 04:55:24PM -0400, John Stoffel wrote:
> >>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:
> 
> > Roland Vet spotted a good one: currently, rebalance/copygc get stuck if
> > we've got an extent that can't be read, due to checksum error/bitrot.
> 
> > This took some doing to fix properly, because
> 
> > - We don't want to just delete such data (replace it with
> >   KEY_TYPE_error); we never want to delete anything except when
> >   explicitly told to by the user, and while we don't yet have an API for
> >   "read this file even though there's errors, just give me what you
> >   have" we definitely will in the future.
> 
> So will open() just return an error?  How will this look from
> userspace?  

Not the open, the read - the typical case is only a single extent goes
bad; it's like any other IO error.

> > - Not being able to move data is a non-option: that would block copygc,
> >   device removal, etc.
> 
> > - And, moving said extent requires giving it a new checksum - strictly
> >   required if the move has to fragment it, teaching the write/move path
> >   about extents with bad checksums is unpalateable, and anyways we'd
> >   like to be able to guard against more bitrot, if we can.
> 
> Why does it need a new checksum if there are read errors?  What
> happens if there are more read errors?   If I have a file on a
> filesystem which is based in spinning rust and I get a single bit
> flip, I'm super happy you catch it.  

The data move paths very strictly verify checksums as they move data
around so they don't introduce bitrot.

I'm not going to add
	if (!bitrotted_extent) checksum(); else no_checksum()
Eww...


Besides being gross, we also would like to guard against introducing
more bitrot.

> But now you re-checksum the file, with the read error, and return it?
> I'm stupid and just a user/IT guy.  I want notifications, but I don't
> want my application to block so I can't kill it, or unmount the
> filesystem.  Or continue to use it if I like.  

The aforementioned poison bit ensures that you still get the error from
the original checksum error when you read that data - unless you use an
appropriate "give it to me anyways" API.

> > So that means:
> 
> > - Extents need a poison bit: "reads return errors, even though it now
> >   has a good checksum" - this was added in a separate patch queued up
> >   for 6.15.
> 
> Sorry for being dense, but does a file have one or more extents?  Or
> is this at a level below that?  

Files have multiple extents.

An extent is one contiguous range of data, and in bcachefs checksums are
at the extent level, not block, so checksummed (and compressed) extents
are limited to, by default, 128k.

> >   It's an incompat feature because it's a new extent field, and old
> >   versions can't parse extents with unknown field types, since they
> >   won't know their sizes - meaning users will have to explicitly do an
> >   incompat upgrade to make use of this stuff.
> 
> > - The read path needs to do additional retries after checksum errors
> >   before giving up and marking it poisoned, so that we don't
> >   accidentally convert a transient error to permanent corruption.
> 
> When doing these retries, is the filesystem locked up or will the
> process doing the read() be blocked from being killed?  

The process doing the read() can't be killed during this, no. If
requested this could be changed, but keep in mind retries are limited in
number.

Nothing else is "locked up", everything else proceeds as normal.

> > - The read path gets a whole bunch of work to plumb precise modern error
> >   codes around, so that e.g. the retry path, the data move path, and the
> >   "mark extent poisoned" path all know exactly what's going on.
> 
> > - Read path is responsible for marking extents poisoned after sufficient
> >   retry attempts (controlled by a new filesystem option)
> 
> > - Data move path is allowed to move extents after a read error, if it's
> >   a checksum error (giving it a new checksum) if it's been poisoned
> >   (i.e. the extent flags feature is enabled).
> 
> So if just a single bit flips, the extent gets moved onto better
> storage, and the file gets re-checksummed.  But what about if more
> bits go bad afterwards?  

The new checksum means they're detected, and if you have replication
enabled they'll be corrected automatically, like any other IO error.

