Return-Path: <linux-fsdevel+bounces-27009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B87195DAAC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 04:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7531C20D9C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 02:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFF925762;
	Sat, 24 Aug 2024 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ngJKiQrL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE4118641
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724466806; cv=none; b=cMQx618CqnOtBm5hZNDH0ZlpOiwkRtnGJJWiUstzHu38xQpTHYIkBp7FNa5nuKRoRfjrSg+Fr9jwwKDsUn7XJoX6ZkwRthmGv6T8GUsskHVtKv7IzevO0SVaui5iGKkDce8BON/MC4fY747iACTysAlZhCf3atLjHUCCSuvMOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724466806; c=relaxed/simple;
	bh=+Rv+ki5E94G3a8rFm/xzNadQieXqf59b4HON3+8muCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWnjnZ072Ok+wnnaZkN0dZ8ErmtD7e30/micTUArVBfUeyTn2+Kpe0nsqT03MB343/KTboruzXD9z9FqQ1Sc8FiQniR7ln2cytKXGv/YZv9+JFIWS5aW9S1hsQ5VEVEgBRF0Sp+pk8SmcQAKyP/t6F/xhdCQv7HFCVvgnJGRErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ngJKiQrL; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 Aug 2024 22:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724466802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M47ROraySwb9cntg/4YOKpNxKjrfEeCjyDjuacBGW2g=;
	b=ngJKiQrLfaDqq/lmNEg3RyJLfyRG1c3uNGBS5xYCtFAf5ahIBiHNFKq3kVh098Y0LBpjbX
	e1TA8hStapR+OEu/WTF+YlIQaVuA/Bbp7uhKyTJq6Pi6694I8m3oW/B3hBSxhAvo3eHVvQ
	cPgBPeVXyKcz8+HfOumdQH8lyZ490Dk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
Message-ID: <nxyp62x2ruommzyebdwincu26kmi7opqq53hbdv53hgqa7zsvp@dcveluxhuxsd>
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
 <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
 <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
 <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Aug 24, 2024 at 10:25:02AM GMT, Linus Torvalds wrote:
> On Sat, 24 Aug 2024 at 10:14, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > On Sat, Aug 24, 2024 at 09:23:00AM GMT, Linus Torvalds wrote:
> > > On Sat, 24 Aug 2024 at 02:54, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > >
> > > > Hi Linus, big one this time...
> > >
> > > Yeah, no, enough is enough. The last pull was already big.
> > >
> > > This is too big, it touches non-bcachefs stuff, and it's not even
> > > remotely some kind of regression.
> > >
> > > At some point "fix something" just turns into development, and this is
> > > that point.
> > >
> > > Nobody sane uses bcachefs and expects it to be stable, so every single
> > > user is an experimental site.
> >
> > Eh?
> >
> > Universal consensus has been that bcachefs is _definitely_ more
> > trustworthy than brtfs,
> 
> I'll believe that when there are major distros that use it and you
> have lots of varied use.

Oh, I'm waiting for that hammer to drop too.

But: all the data we've got so far is that it really is shaping up to be
that solid, there's clearly been big upticks in users as it went
upstream, as distros have been rolling it out, and the uptick in bug
reports hasn't been there.

> But it doesn't even change the issue: you aren't fixing a regression,
> you are doing new development to fix some old probl;em, and now you
> are literally editing non-bcachefs files too.

What is to be gained by holding back fixes, if we've got every reason to
believe that the fixes are solid?

And yes, these _are_ solid, the rhashtable stuff was done months ago
(minus the deadlock fix, that's more recent), and the rcu_pending stuff
was mostly done months ago as well, and _heavily_ tested (including
using it as replacement backend for kvfree_rcu, which is the eventual
goal there).

And the genradix code is code that I also wrote and maintain, and those
are simple patches.

