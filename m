Return-Path: <linux-fsdevel+bounces-35827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2B99D87B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FD11688CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0342F1B0F22;
	Mon, 25 Nov 2024 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwATmg9C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9FC1AC453;
	Mon, 25 Nov 2024 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544032; cv=none; b=a1Vg87yDGgFslM7qvUjc4jw08SWIO9opbuI1Z6es0jsohPcEk5k1PU28g9wABa+kfJiRCZ0jVbsM5YABDD06x/cUEk6yWct/uCpY92O1adQiF+YjnuU0LjkdtwXZH6lcJkZxEqN0XAOc4OueiAgebPkR39P/GG6rRrUMUX08EP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544032; c=relaxed/simple;
	bh=L2/gOwMqTj/oSS0AL0zr6ZP9mNGEOtaDBMwHyxVBqbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CePgrsH+zLuaiQXKw5gLPZwNFlITeIDwzVpf4M3MhTihWholi88pm4RuCdLJbPMbUkcIGlRqZClXIrQVdIYvI1mmK0EDG+QORs4qlwbaM+e5tk7xRO555hv/18KR6C9vjQF2aXIRrkNQnwtHE1EAE+gYD9YCzreSpVXO/kQAdMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwATmg9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65831C4CECE;
	Mon, 25 Nov 2024 14:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732544031;
	bh=L2/gOwMqTj/oSS0AL0zr6ZP9mNGEOtaDBMwHyxVBqbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwATmg9C6fJfkeLjCOTVfQP/rAI6J3LlDu2AYZ3bHs9XRcF/EtEbpVzDafQQgOZ/d
	 Tzkt1WSkZn35DDxK0I2QTH3ObXWsNIQ1NW+6JCbHfhAvKPkm5wC1SivwvWysHqcFAZ
	 w18nOToawtVx9pk0cMoUGlaYedCG7qEZZua/y8WeyHzOb/ftxRW74sA+0A6xsTg865
	 VH16fC+jbdEigUlq+STLGjhsLAK+Oi2J17w+GtjIvTVQhfViRH6IDHSnOdSfVOmhZm
	 5NsswPUpB6jUJmvF22j420MuUu6k99z6HqdBRNYfaj3q5Yr8ZxVdJrBkzEeS5WqwwV
	 xdnpSqJpvYSwQ==
Date: Mon, 25 Nov 2024 15:13:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/26] cred: rework {override,revert}_creds()
Message-ID: <20241125-golfplatz-benommen-46e80ad2b601@brauner>
References: <CAHk-=whoEWma-c-ZTj=fpXtD+1EyYimW4TwqDV9FeUVVfzwang@mail.gmail.com>
 <20241124-work-cred-v1-0-f352241c3970@kernel.org>
 <CAHk-=wi5ZxjGBKsseL2eNHpDVDF=W_EDZcXVfmJ2Dk2Vh7o+nQ@mail.gmail.com>
 <CAOQ4uxgYf2kEkYSz=AC++B6cb643Aq82En5QjwDwsSpPRf+A6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgYf2kEkYSz=AC++B6cb643Aq82En5QjwDwsSpPRf+A6w@mail.gmail.com>

On Mon, Nov 25, 2024 at 01:55:25PM +0100, Amir Goldstein wrote:
> On Sun, Nov 24, 2024 at 7:00 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, 24 Nov 2024 at 05:44, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > This series does all that. Afaict, most callers can be directly
> > > converted over and can avoid the extra reference count completely.
> > >
> > > Lightly tested.
> >
> > Thanks, this looks good to me. I only had two reactions:
> >
> >  (a) I was surprised that using get_new_cred() apparently "just worked".
> >
> > I was expecting us to have cases where the cred was marked 'const',
> > because I had this memory of us actively marking things const to make
> > sure people didn't play games with modifying the creds in-place (and
> > then casting away the const just for ref updates).
> >
> > But apparently that's never the case for override_creds() users, so
> > your patch actually ended up even simpler than I expected in that you
> > didn't end up needing any new helper for just incrementing the
> > refcount on a const cred.
> >
> >  (b) a (slight) reaction was to wish for a short "why" on the
> > pointless reference bumps
> >
> > partly to show that it was thought about, but also partly to
> > discourage people from doing it entirely mindlessly in other cases.
> >
> > I mean, sometimes the reference bumps were just obviously pointless
> > because they ended up being right next to each other after being
> > exposed, like the get/put pattern in access_override_creds().
> >
> > But in some other cases, like the aio_write case, I think it would
> > have been good to just say
> >
> >  "The refcount is held by iocb->fsync.creds that cannot change over
> > the operation"
> >
> > or similar. Or - very similarly - the binfmt_misc uses "file->f_cred",
> > and again, file->f_cred is set at open time and never changed, so we
> > can rely on it staying around for the file lifetime.
> >
> > I actually don't know if there were any exceptions to this (ie cases
> > where the source of the override cred could actually go away from
> > under us during the operation) where you didn't end up removing the
> > refcount games as a result.
> 
> I was asking myself the same question.
> 
> I see that cachefiles_{begin,end}_secure() bump the refcount, but they
> mostly follow a very similar pattern to the cases that do not bump the refcount,
> so I wonder if you left this out because they were hidden in those
> inline helpers
> or because of the non-trivial case of  cachefiles_determine_cache_security()
> which replaces the 'master' cache_creds?
> 
> Other that that, I stared at the creds code in nfsd_file_acquire_local() and
> nfsd_setuser() more than I would like to admit, with lines like:
> 
>         /* discard any old override before preparing the new set */
>         put_cred(revert_creds(get_cred(current_real_cred())));
> 
> And my only conclusion was this code is complicated enough,
> so it'd better not use borrowed creds..

I actually ported cachefilesd and and nfsd in v2. I simply missed them.

