Return-Path: <linux-fsdevel+bounces-12447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4CE85F6C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 609D2B2332F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0F14654E;
	Thu, 22 Feb 2024 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o3+s7mVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08F942078
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601242; cv=none; b=bdVYs3BGI91qv9egcU8FCoKsn4kYy4DiWWwPHGWDE1b65aJfrzxNoHrSWIea7qNio+8lF85SP6lWG50n2P8hBAVcakrtFUzxm27/s+iISFsJpcQ2inUa2i3XrgDlS1D8UOguHxbIdPIe+qvVjzqebEq6QPGGQ5ZhkC7EU8aVO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601242; c=relaxed/simple;
	bh=yV+yc5NcFdyAmErUOkBLyA/OIsvMtbygsWXFfZyKmeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/FyGbjzH+fzowpZF0r33s4PVk5X+DPnWOXHYqwTY6iuXUxcQquQ5zRO9gBwslPIJvaAq8pFBy+KHYIkZ0z2OyJBIiKVfh3bc4hP4NIvhrCOaRPpNpdGPN/yVGBbEdN5hwugrF9Z4CS5rQBZT/URn+CCge5tA5CeSxuuLa6/PnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o3+s7mVP; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Feb 2024 06:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708601238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1us2I0AdDLWfvobj5hAHlolfZfpgMQjKsf9/EDXX+6c=;
	b=o3+s7mVPd1I6RClV135IlABuJDdKFIdd82TRZc0Y8G4YGE/c1EolVJEXBb+38xyxMvHp7G
	2cADKkE0jOV0K1QUFbgKaM8eHxMg4NaSq024dFEJ336jxRaCwa8kXf4q7LZLP3vPl8Fmtg
	6WVBObBAP4k2ZK6lM+0es8C6nON7AR8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, linux-btrfs@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF TOPIC] statx extensions for subvol/snapshot
 filesystems & more
Message-ID: <u4btyvpsohnf77r5rm43tz426u3advjc4goea4obt2wtv6xyog@7bukhgoyumed>
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting>
 <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
 <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx>
 <20240222110138.ckai4sxiin3a74ku@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222110138.ckai4sxiin3a74ku@quack3>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 22, 2024 at 12:01:38PM +0100, Jan Kara wrote:
> On Thu 22-02-24 04:42:07, Kent Overstreet wrote:
> > On Thu, Feb 22, 2024 at 10:14:20AM +0100, Miklos Szeredi wrote:
> > > On Wed, 21 Feb 2024 at 22:08, Josef Bacik <josef@toxicpanda.com> wrote:
> > > >
> > > > On Wed, Feb 21, 2024 at 04:06:34PM +0100, Miklos Szeredi wrote:
> > > > > On Wed, 21 Feb 2024 at 01:51, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > > > >
> > > > > > Recently we had a pretty long discussion on statx extensions, which
> > > > > > eventually got a bit offtopic but nevertheless hashed out all the major
> > > > > > issues.
> > > > > >
> > > > > > To summarize:
> > > > > >  - guaranteeing inode number uniqueness is becoming increasingly
> > > > > >    infeasible, we need a bit to tell userspace "inode number is not
> > > > > >    unique, use filehandle instead"
> > > > >
> > > > > This is a tough one.   POSIX says "The st_ino and st_dev fields taken
> > > > > together uniquely identify the file within the system."
> > > > >
> > > >
> > > > Which is what btrfs has done forever, and we've gotten yelled at forever for
> > > > doing it.  We have a compromise and a way forward, but it's not a widely held
> > > > view that changing st_dev to give uniqueness is an acceptable solution.  It may
> > > > have been for overlayfs because you guys are already doing something special,
> > > > but it's not an option that is afforded the rest of us.
> > > 
> > > Overlayfs tries hard not to use st_dev to give uniqueness and instead
> > > partitions the 64bit st_ino space within the same st_dev.  There are
> > > various fallback cases, some involve switching st_dev and some using
> > > non-persistent st_ino.
> > 
> > Yeah no, you can't crap multiple 64 bit inode number spaces into 64
> > bits: pigeonhole principle.
> > 
> > We need something better than "hacks".
> 
> I agree we should have a better long-term plan than finding ways how to
> cram things into 64-bits inos. However I don't see a realistic short-term
> solution other than that.
> 
> To explicit: Currently, tar and patch and very likely other less well-known
> tools are broken on bcachefs due to non-unique inode numbers. If you want
> ot fix them, either you find ways how bcachefs can cram things into 64-bit
> ino_t or you go and modify these tools (or prod maintainers or whatever) to
> not depend on ino_t for uniqueness. The application side of things isn't
> going to magically fix itself by us telling "bad luck, ino_t isn't unique
> anymore".

My intent is to make a real effort towards getting better interfaces
going, prod those maintainers, _then_ look at adding those hacks (that
will necessarily be short term solutions since 64 bits is already
looking cramped).

Kind of seems to me like you guys think kicking the can down the road
is supposed to to be the first priority, and that's not what I'm doing
here.

> > > What overlayfs does may or may not be applicable to btrfs/bcachefs,
> > > but that's not my point.  My point is that adding a flag to statx does
> > > not solve anything.   You can't just say that from now on btrfs
> > > doesn't have use unique st_ino/st_dev because we've just indicated
> > > that in statx and everything is fine.   That will trigger the
> > > no-regressions rule and then it's game over.  At least I would expect
> > > that to happen.
> > > 
> > > What we can do instead is introduce a new API that is better,
> > 
> > This isn't a serious proposal.
> 
> I think for "unique inode identifier" we don't even have to come up with
> new APIs. The file handle + fsid pair is an established way to do this,
> fanotify successfully uses this as object identifier and Amir did quite
> some work for this to be usable for vast majority of filesystems (including
> virtual ones). The problem is with rewriting all these applications to use
> it. If statx flag telling whether inode numbers are unique helps with that,
> sure we can add it, but that seems like a trivial part of the problem.

Basically, it turns it into a checklist item for userspace. "Are we
still doing things the old way (and we've got a documented list of where
that will break", or "are we handling the INO_NOT_UNIQUE case
correctly".

In general when semantics change, APIs ought to change.

