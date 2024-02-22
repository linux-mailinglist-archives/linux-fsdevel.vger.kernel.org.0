Return-Path: <linux-fsdevel+bounces-12445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBBB85F69F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396631C22BD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1164D446D5;
	Thu, 22 Feb 2024 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xRwnfgWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1AD3E49E
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600770; cv=none; b=LDJBdIJDnHiFywyTWgpluhjpehiLDVImQ6r+ici98Sys5K5MGAaL3yh8mBK47FFc/rpxlC8kLz3bzSdbVKs/3+yS7D9Ho82OCYyMYvx8oVAv6gyl60cYHK4NxUCsonv9DCMd/MaI0HsHewd2hPmLu+xu3GS7ZUSeUjTAbh8W5Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600770; c=relaxed/simple;
	bh=/Ljrr6CJk+mIUZ+I8p47GxKWHfPQCKx+XO5pmkj2Zdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpEG0lHiONHGqMl0ndL1AOyGqHWMBG1MERqlu+7Rkt0cfxAWV5C+Om4DbJANpgrjDMB9pzQIApK4Da9rhJBZP72JHNKqKTxn2ZjNTjHBv4PNmV9fwZ8qPfJqyUpTCdfJcP4QFdKPSDAg10Z90KMlrsWDytnERE9O3VyAuW/Cn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xRwnfgWB; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Feb 2024 06:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708600766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SLtXP+zArhGcaGCh9YToDwJ5gVLqg/X2spMjxvpVolE=;
	b=xRwnfgWBwskIO9s8RehDD2wEevpdAGb31vUwSCo5owmykKEtrkxGUWhsToPDvKrJIMX6IE
	InRMHGnQcTltMb7RlsvY4dnPxWwExlCuk9of76Y8Fmnl7z7EowHUqukB4ToGLfrPzmfeuU
	ukkv9popOugyzjK0PAJ78Bi1TNRQhPg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF TOPIC] statx extensions for subvol/snapshot filesystems &
 more
Message-ID: <yaq7zpqe3x67igm6kvzbs4jczgd7pqhx733jha4fmzihr6e67c@pm5nfkpabtk7>
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting>
 <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
 <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx>
 <CAJfpegtxv3Omm3227c-1vprHYVTd1n3WoOxDKUSioNSP5pdeGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtxv3Omm3227c-1vprHYVTd1n3WoOxDKUSioNSP5pdeGw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 22, 2024 at 11:25:12AM +0100, Miklos Szeredi wrote:
> On Thu, 22 Feb 2024 at 10:42, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > Yeah no, you can't crap multiple 64 bit inode number spaces into 64
> > bits: pigeonhole principle.
> 
> Obviously not.  And I have no idea about the inode number allocation
> strategy of bcachefs and how many bits would be needed for subvolumes,
> etc..   I was just telling what overlayfs does and why.  It's a
> pragmatic solution that works.  I'd very much like to move to better
> interfaces, but creating good interfaces is never easy.

You say "creating good interfaces is never easy" - but we've got a
proposal, that's bounced around a fair bit, and you aren't saying
anything concrete.

> > We need something better than "hacks".
> 
> That's the end goal, obviously.   But we also need to take care of
> legacy.  Always have.

So what are you proposing?

> > This isn't a serious proposal.
> 
> If not, then what is?
> 
> BTW to expand on the st_dev_v2 idea, it can be done by adding a
> STATX_DEV_V2 query mask.

Didn't you see Josef just say they're trying to get away from st_dev?

> The other issue is adding subvolume ID.  You seem to think that it's
> okay to add that to statx and let userspace use (st_ino, st_subvoid)
> to identify the inode.  I'm saying this is wrong, because it doesn't
> work in the general case.

No, I explicitly said that when INO_NOT_UNIQUE is set the _filehandle_
would be the means to identify the file.

