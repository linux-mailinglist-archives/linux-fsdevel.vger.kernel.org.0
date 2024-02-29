Return-Path: <linux-fsdevel+bounces-13201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E9E86CF82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 17:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBD5283830
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1DA381B0;
	Thu, 29 Feb 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jtn1bVX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4508E16063B
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225014; cv=none; b=PYmQdDNW26aKz5dci9eclUKuosfNcJWzcS7lAHyQQ6IWCCNiB6Ul5bM4UgK+0dPGnJ6GozS/eOdbh2v4DZIBHPyuKSk69QMKXaI+LzSCLdvZpnVsjM1ca1Be5pVSrXhWyVf2B0bGLn71LCnkUyPfC8h/tDuFbIPC50Q08DlOops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225014; c=relaxed/simple;
	bh=1+21ldCzpprljlvUJ2Lr3Gx5oQp3S9XRiF1iVZ+duVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfOM774qi2Ca8PIbP3eGOeE1FTTiBkg4zUmRe6LHU6ERU8Kr2hq513Gkb/nW/8K57tBGs49CkgLrV9mpdCtHy00mpc6tVfAVQ2i58FSPhEdblhXUgFYkNPer0U8ewVGnXtVnSLRHp1ticMM2PGKZkVw0HgW1nEB5tOHPjo1CwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jtn1bVX3; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 11:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709225010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LAE1asfDpdVLwQya95aH6pklaTkHLNchRUYul7b04dM=;
	b=Jtn1bVX3crLm8FbDb9+w75RuQGRxHwKraJfcORafYigU5vQOyeUFxyUv3iswk9DIjelA9j
	Lyw8LgWaKP2XB580LjhnHgVhOGxlvbMbu5Lh3fMvhGoVWGeqAMvlE4H63rQfb/jmZV8NCd
	+/poXf/E4GAL6b4nI/8MitOezx80WOE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, david@fromorbit.com, 
	mcgrof@kernel.org, hch@lst.de, willy@infradead.org
Subject: Re: [PATCH 2/2] bcachefs: Buffered write path now can avoid the
 inode lock
Message-ID: <y6hurdequpds6fgpsm3vlapzzfj6e5pgs2ukfjm4qbziv5kdwr@lrjkcnzkjh75>
References: <20240229063010.68754-1-kent.overstreet@linux.dev>
 <20240229063010.68754-3-kent.overstreet@linux.dev>
 <CAHk-=whf9HsM6BP3L4EYONCjGawAV=X0aBDoUHXkND4fpqB2Ww@mail.gmail.com>
 <CAHk-=wg96Rt-SuUeRb-xev1KdwqX0GLFjf2=qnRsyLimx6-xzw@mail.gmail.com>
 <20240229-gestrafft-waage-157c1c4ee225@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-gestrafft-waage-157c1c4ee225@brauner>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 29, 2024 at 10:46:48AM +0100, Christian Brauner wrote:
> On Wed, Feb 28, 2024 at 11:27:05PM -0800, Linus Torvalds wrote:
> > On Wed, 28 Feb 2024 at 23:20, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > >
> > >  - take the lock exclusively if O_APPEND or if it *looks* like you
> > > might extend the file size.
> > >
> > >  - otherwise, take the shared lock, and THEN RE-CHECK. The file size
> > > might have changed, so now you need to double-check that you're really
> > > not going to extend the size of the file, and if you are, you need to
> > > go back and take the inode lock exclusively after all.
> > 
> > Same goes for the suid/sgid checks. You need to take the inode lock
> > shared to even have the i_mode be stable, and at that point you might
> > decide "oh, I need to clear suid/sgid after all" and have to go drop
> > the lock and retake it for exclusive access after all.
> 
> I agree. And this is how we've done it in xfs as well. The inode lock is
> taken shared, then check for IS_NOSEC(inode) and if that's true keep the
> shared lock, otherwise upgrade to an exclusive lock. Note that this
> whole check also checks filesystem capability xattrs.
> 
> I think you'd also get potential security issues or at least very subtle
> behavior. Someone could make a binary setuid and a concurrent write
> happens. chmod is taking the exclusive lock and there's a concurrent
> write going on changing the contents to something unsafe without being
> forced to remove the set*id bits.
> 
> Similar for {g,u}id changes. Someone starts a chown() taking inode lock
> while someone issues a concurrent write. The chown changes the group
> ownership so that a writer would be forced to drop the sgid bit. But the
> writer proceeds keeping that bit.

That's the kind of race that's not actually a race - if the syscalls
being invoked at the same time, it's fine if the result is as if the
write happened first, then the chown.

For there to be an actual race one of two things would have to be the
case:
 - the chown/chmod path would have to be dependent on the on the data
   the write path is changing, or
 - there'd have to be a problem wnith the write path seeing inconsistent
   state mid modification

But I can't claim 100% the second case isn't a factor, I don't know the
security side of things as well, and the XFS way sounds nice and clean.

