Return-Path: <linux-fsdevel+bounces-12451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AD885F791
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D43B1C24207
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A904655D;
	Thu, 22 Feb 2024 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lRDl0nHn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F9545BF9
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602933; cv=none; b=tbd/B6GxGAJeQ5fEZMuxLrgqeLvWO3yTHLxgVeyLAsb5mFH8NOhGTFNXoOO/2n9d8q4amNUdiIeYLSdG7AmMf+6sAAvu4JElTK3vXtlZlbW1I/GPHFlNoKzmtDfLMNRu/CncejeG9vG/lXv+q5bcOv29oB1BIffcqX75fisuJUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602933; c=relaxed/simple;
	bh=0CJpr26zan7TdkdLzjJcZGBNSSb45N51xiEhwd3+uaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiqHIpb0ae666MZBeT3PfheoNXqCEOgaV4yCvkGpHhC4Cg9xiVxeo8Dce8fOyVE2Bh38M+SchV86px6z4I8P0wTLTfycFBBBqjICfBczk+dXqcBn7D13g6GSQ1xslEdqtFBoeiUFTT9aIJoAgMW5OZhpGuOmY7HICZKnLC06FCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lRDl0nHn; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Feb 2024 06:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708602930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOSNF//i8qwwUlDAqBjDcUQ68DsRV1xIVPVD8Mb3zPM=;
	b=lRDl0nHnJJsSXURYD+j4aDEP5upGN1kgw5NWTCfYi+JVsZEyXn78qm2NmO8/+ePcYaOOIB
	XlFrD8tQcHtTeRssf1+3QzUcCWLKu1/iNUq03e3Ehdu/wB04e1Htiua1y9wVPWYvuE1znI
	gkxm21v3AaWlXjatwcNzTsKJaHhyumk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, linux-btrfs@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF TOPIC] statx extensions for subvol/snapshot
 filesystems & more
Message-ID: <2tsfxaf2blhcxlkfcagfavz3mnuga3qsjgpytbstvykmcq2prj@icc7vub55i3p>
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting>
 <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
 <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx>
 <20240222110138.ckai4sxiin3a74ku@quack3>
 <u4btyvpsohnf77r5rm43tz426u3advjc4goea4obt2wtv6xyog@7bukhgoyumed>
 <20240222114417.wpcdkgsed7wklv3h@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222114417.wpcdkgsed7wklv3h@quack3>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 22, 2024 at 12:44:17PM +0100, Jan Kara wrote:
> On Thu 22-02-24 06:27:14, Kent Overstreet wrote:
> > On Thu, Feb 22, 2024 at 12:01:38PM +0100, Jan Kara wrote:
> > > On Thu 22-02-24 04:42:07, Kent Overstreet wrote:
> > > > On Thu, Feb 22, 2024 at 10:14:20AM +0100, Miklos Szeredi wrote:
> > > > > On Wed, 21 Feb 2024 at 22:08, Josef Bacik <josef@toxicpanda.com> wrote:
> > > > > >
> > > > > > On Wed, Feb 21, 2024 at 04:06:34PM +0100, Miklos Szeredi wrote:
> > > > > > > On Wed, 21 Feb 2024 at 01:51, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > > > > > >
> > > > > > > > Recently we had a pretty long discussion on statx extensions, which
> > > > > > > > eventually got a bit offtopic but nevertheless hashed out all the major
> > > > > > > > issues.
> > > > > > > >
> > > > > > > > To summarize:
> > > > > > > >  - guaranteeing inode number uniqueness is becoming increasingly
> > > > > > > >    infeasible, we need a bit to tell userspace "inode number is not
> > > > > > > >    unique, use filehandle instead"
> > > > > > >
> > > > > > > This is a tough one.   POSIX says "The st_ino and st_dev fields taken
> > > > > > > together uniquely identify the file within the system."
> > > > > > >
> > > > > >
> > > > > > Which is what btrfs has done forever, and we've gotten yelled at forever for
> > > > > > doing it.  We have a compromise and a way forward, but it's not a widely held
> > > > > > view that changing st_dev to give uniqueness is an acceptable solution.  It may
> > > > > > have been for overlayfs because you guys are already doing something special,
> > > > > > but it's not an option that is afforded the rest of us.
> > > > > 
> > > > > Overlayfs tries hard not to use st_dev to give uniqueness and instead
> > > > > partitions the 64bit st_ino space within the same st_dev.  There are
> > > > > various fallback cases, some involve switching st_dev and some using
> > > > > non-persistent st_ino.
> > > > 
> > > > Yeah no, you can't crap multiple 64 bit inode number spaces into 64
> > > > bits: pigeonhole principle.
> > > > 
> > > > We need something better than "hacks".
> > > 
> > > I agree we should have a better long-term plan than finding ways how to
> > > cram things into 64-bits inos. However I don't see a realistic short-term
> > > solution other than that.
> > > 
> > > To explicit: Currently, tar and patch and very likely other less well-known
> > > tools are broken on bcachefs due to non-unique inode numbers. If you want
> > > ot fix them, either you find ways how bcachefs can cram things into 64-bit
> > > ino_t or you go and modify these tools (or prod maintainers or whatever) to
> > > not depend on ino_t for uniqueness. The application side of things isn't
> > > going to magically fix itself by us telling "bad luck, ino_t isn't unique
> > > anymore".
> > 
> > My intent is to make a real effort towards getting better interfaces
> > going, prod those maintainers, _then_ look at adding those hacks (that
> > will necessarily be short term solutions since 64 bits is already
> > looking cramped).
> 
> OK, fine by me :) So one thing is still not quite clear to me - how do you
> expect the INO_NOT_UNIQUE flag to be used by these apps? Do you expect them
> to use st_dev + st_ino by default and fall back to fsid + fhandle only when
> INO_NOT_UNIQUE is set?

Shouldn't matter. If they care about performance and they're in some
strange situation where the syscal overhead matters, they can use
fhandle only when the bit is set, but I'd personally prefer to see
everyone on the same codepath and just always using fh.

