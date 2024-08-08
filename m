Return-Path: <linux-fsdevel+bounces-25418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6759B94BE72
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 15:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966831C24DCB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 13:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1D818CC08;
	Thu,  8 Aug 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6Yu9PeM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B52148832
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123210; cv=none; b=JuIdZxgDtQo0Y5hMCkmB0Xq7YGrsD495801w8C7DOTqRCXJsfsc7fKRubtXZFOXuYjxkJR6Zd2TXd4xR7b35w5ToUHSoKv1bFGoyZ/2k2JROqAvyMYUuVVK+ka5Q2qCJ6Tdo4Uu9Ywx4OheXCR1HZEhwMUmhCSllyCLT1bKaPgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123210; c=relaxed/simple;
	bh=6FeaBPbiL76OWLUNN/6MflsMNeiKZ7tugvmzeSVPqtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeUpPwS5Oj9Gm0kKdGnXAyV2OPsKbza2gEHXIvoyRTTuIwuOJ2yQr5yb056S3HvMQJE0Si7Du4YJ6vUgWtgWh9AOgb3UqlGHfFS8y4e3hUvgfditFvOtID0spNyGIWLAfU954BV5xosEKGKVG8/UW752YrBOL0QmGbjwQH/3kTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6Yu9PeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B168C32782;
	Thu,  8 Aug 2024 13:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723123209;
	bh=6FeaBPbiL76OWLUNN/6MflsMNeiKZ7tugvmzeSVPqtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6Yu9PeMyGrBkJcE/jM3Wur9FLmeLQWdnBTlIlyAXavLmkxNmvvn9oo3OQAmjan9A
	 30PHGIxgNa/MB1qOVNtSM2nuoicibs84ZkR/OXLswkCF5A8KmlqOzfOErMAX21WXAf
	 XlOskBFpH96Udcps0LXCkIKT5bDPkioBDHDX8mK9QDpjUQQWBvAFWp6DOcIbC88un1
	 EBmATLsQ3eUgDtrg10DtLBmmIYnneqpo7nBXWbxDLZkWmV3CbPhB0kIj45/boXfORQ
	 hXtpRf8XjgRcj7WinT78zArV6NKOwAfBHob2Ub3ul/0dDeDII7zA8PMgplqGd4ykwC
	 2lcfS01QZALWg==
Date: Thu, 8 Aug 2024 15:20:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Mateusz Guzik <mjguzik@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [RFC] why do we need smp_rmb/smp_wmb pair in
 fd_install()/expand_fdtable()?
Message-ID: <20240808-dates-pechschwarz-0cccfed2c605@brauner>
References: <20240808025029.GB5334@ZenIV>
 <CAHk-=wgse0ui5sJgNGSvqvYw_BDTcObqdqcwN1BxgCqKBiiGzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgse0ui5sJgNGSvqvYw_BDTcObqdqcwN1BxgCqKBiiGzQ@mail.gmail.com>

On Wed, Aug 07, 2024 at 08:06:31PM GMT, Linus Torvalds wrote:
> On Wed, 7 Aug 2024 at 19:50, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > What's the problem with droping both barriers and turning that
> > into
> >         expanded = expand_fdtable(files, nr);
> >         smp_store_release(&files->resize_in_progress, false);
> > and
> >         if (unlikely(smp_load_acquire(&files->resize_in_progress))) {
> >                 ....
> >                 return;
> >         }
> 
> That should be fine. smp_store_release()->smp_load_acquire() is the
> more modern model, and the better one. But I think we simply have a
> long history of using the old smp_wmb()->smp_rmb() model, so we have a
> lot of code that does that.
> 
> On x86, there's basically no difference - in all cases it ends up
> being just an instruction scheduling barrier.
> 
> On arm64, store_release->load_acquire is likely better, but obviously
> micro-architectural implementation issues might make it a wash.
> 
> On other architectures, there probably isn't a huge difference, but
> acquire/release can be more expensive if the architecture is
> explicitly designed for the old-style rmb/wmb model.
> 
> So on alpha, for example, store_release->load_acquire ends up being a
> full memory barrier in both cases (rmb is always a full memory barrier
> on alpha), which is hugely more expensive than wmb (well, again, in
> theory this is all obviously dependent on microarchitectures, but wmb
> in particular is very cheap unless the uarch really screwed the pooch
> and just messed up its barriers entirely).
> 
> End result: wmb/rmb is usually never _horrific_, while release/acquire
> can be rather expensive on bad machines.
> 
> But release/acquire is the RightThing(tm), and the fact that alpha
> based its ordering on the bad old model is not really our problem.
> 
> So I'm ok with just saying "screw bad memory orderings, go with the
> modern model"

So that's what confused me in your earlier mail in the other thread
where the question around smp_{r,w}mb() and smp_store_release() and
smp_load_acquire() already came up.

Basically, I had always used smp_load_acquire() and smp_store_release()
based on the assumption that they're equivalent to smp_{r,w}mb().

But then multiple times people brought up that supposedly smp_rmb() and
smp_wmb() are cheaper because they only do load or store ordering
whereas smp_{load,store}_{acquire,release}() do load and store ordering.

And it doesn't help that we seemingly don't have a practical guideline
of the form "Generally prefer smp_load_acquire() and smp_store_release()
over smp_rmb() and smp_wmb()." written down anywhere. That really would
shortcut decisions such as this.

