Return-Path: <linux-fsdevel+bounces-31105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A3F991C6E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 05:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B191F21FD2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 03:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7158216A940;
	Sun,  6 Oct 2024 03:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W/ihGSdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AEC155C97
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728186184; cv=none; b=d3tr1iag8WIy5jhcgAcOe5PZ3dWowsH3t+aDn+wV1BWyvkWtH29Pkv7uzFxeKp1Y8/P2tDd7MCDdhq63vCN169zghGcmbaWUEewXjA3dQ4RSyGb2d3k4UWUzTwuJHFKrW2ocStz9dLI6898mo1cFvaQjuObYScm7eF8KNZM6OEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728186184; c=relaxed/simple;
	bh=N2hmapaVYcoCs611h4gdMKWRM4aDYfZ1XusjU4/qjp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdeO9gTgB1xH42ESH3+HiOgCX04lNhMXuwMTgNdsI5UvbFv3MDkaRDXfmW4bDFmc6WiK/S5zWpHqaG6SFDYoFbvKQlJee4BWfsRtxSYtQyyGJw/VhXOOoZwySxbbaIe/fDhXFxeUJZj314AN8Cb8n/wze+s2KhoIMVpTi2CR/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W/ihGSdW; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 5 Oct 2024 23:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728186180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXGBLqKQO+xeAR5ecgv73dMkpFHtDaW1iRkrgZlVimI=;
	b=W/ihGSdWgiKIzZHWWHkxTmp8hNN2PLgTL690k61dJqO74aOIO2SmYd/AQUPA6WflIfNtGQ
	BqAdq9+H0xOSeVNTr8QM4ihyOm/7mTi/Un67bUItwILa9R7B2xxfxIgwvnoTiNWQ0apK4B
	M/rk9fgjuMY2LBOIpQJTm8ykhqugX7s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Carl E. Thompson" <list-bcachefs@carlthompson.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <yrhcxgitslbfm473daku7m5baox4qgagr2nbsa6brjsiqkj4pv@rtaqdzmjrqug>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <345264611.558.1728177653590@mail.carlthompson.net>
 <coczqmiqvuy4h74j462mjyro3skeybyt2y3kcqdcuwy4bwibjy@pquinazt4h22>
 <941798317.650.1728183991400@mail.carlthompson.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <941798317.650.1728183991400@mail.carlthompson.net>
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 05, 2024 at 08:06:31PM GMT, Carl E. Thompson wrote:
> Yeah, of course there were the disk accounting issues and before that
> was the kernel upgrade-downgrade bug going from 6.8 back to 6.7.
> Currently over on Reddit at least one user is mention read errors and
> / or performance regressions on the current RC version that I'd rather
> avoid.

So, disk accounting rewrite: that code was basically complete, just
baking, for a full six months before merging - so, not exactly rushed,
and it saw user testing before merging. Given the size, and how invasive
it was, some regressions were inevitable and they were pretty small and
localized.

The upgrade/downgrade bug was really nasty, yeah.

> There were a number of other issues that cropped up in some earlier
> versions but not others such as deadlocks when using compression
> (particularly zstd), weirdness when using compression with 4k blocks
> and suspend / resume failures when using bcachefs. 

I don't believe any of those were bcachefs regressions, although some
are bcachefs bugs - suspend/resume for example there's still an open
bug.

I've seen multiple compression bugs that were mostly not bcachefs bugs
(i.e. there was a zstd bug that affected bcachefs that took forever to
fix, and there's a recently reported LZ4HC bug that may or may not be
bcachefs).

> None of those things were a big deal to me as I mostly only use
> bcachefs on root filesystems which are of course easy to recreate. But
> I do currently use bcachefs for all the filesystems on my main laptop
> so issues there can be more of a pain.

Are you talking about issues you've hit, or issues that you've seen
reported? Because the main subject of discussion is regressions.

> 
> As an example of potential issues I'd like to avoid I often upgrade my
> laptop and swap the old SSD in and am currently considering pulling
> the trigger on a Ryzen AI laptop such as the ProArt P16. However, this
> new processor has some cutting edge features only fully supported in
> 6.12 so I'd prefer to use that kernel if I can. But... because
> according to Reddit there are apparently issues with bcachefs in the
> 6.12RC kernels that means I am hesitant to buy the laptop and use the
> RC kernel the carefree manor I normally would. Yeah, first world
> problems!

The main 6.12-rc1 issue was actually caused by Christain's change to
inode state wakeups - it was a VFS change where bcachefs wasn't updated.

That should've been caught by automated testing on fs-next - so that
one's on me; fs-next is still fairly new and I still need to get that
going.

> Speaking of Reddit, I don't know if you saw it but a user there quotes
> you as saying users who use release candidates should expect them to
> be "dangerous as crap." I could not find a post where you said that in
> the thread that user pointed to but if you **did** say something like
> that then I guess I have a different concept of what "release
> candidate" means.

I don't recall saying that, but I did say something about Canonical
shipping rc kernels to the general population - that's a bit crazy.
Rc kernels should generally be run by users who know what they're
getting into and have some ability to help test and debug.

> So for me it would be a lot easier if bcachefs versions were decoupled
> from kernel versions. 

Well, this sounds more like generalized concern than anything concrete I
can act on, to be honest - but if you've got regressions that you've
been hit by, please tell me about those.

The feedback I've generally been getting has been that each release has
been getting steadily better, and more stable and usable - and lately
pretty much all I've been doing has been fixing user reported bugs, so
those I naturally want to get out quickly if the bugs are serious enough
and I'm confident that they'll be low risk - and there has been a lot of
that.

The shrinker fixes for fsck OOMing that didn't land in 6.11 were
particularly painful for a lot of users.

The key cache/rcu pending work that didn't land in 6.11, that was a
major usability issue for several users that I talked to.

The past couple weeks I've been working on filesystem repair and
snapshots issues for several users that were inadvertently torture
testing snapshots - the fixes are turning out to be fairly involved, but
I'm also weighing there "how likely are other users to be affected by
this, and do we want to wait another 3 months", and I've got multiple
reports of affected users.

