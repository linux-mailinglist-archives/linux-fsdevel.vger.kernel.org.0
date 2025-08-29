Return-Path: <linux-fsdevel+bounces-59660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C45B3C262
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 20:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1219B2079F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74119341ACA;
	Fri, 29 Aug 2025 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iO3q4BWt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6EE1F4631
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491905; cv=none; b=k0vf1r0Khq6rpXnS4dgGejwEdFBWvleTNk0LkVbyaq8d1BCxe3eSvPYOeWUgi3z3OvBkq+TK7C3P5kPRP8X4DMwn7yYVLMLsv/E0EYXHZ231/4WE8Iw4yXAzbOK3PlBKvgrXvOdnGFixwPX3cbrFHeCOJQC/40GmZWzR5/wsG6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491905; c=relaxed/simple;
	bh=vDlEp0EHKOQtCnSXvlLe3yB3p1Pk/GJdggy7QE1OE9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRthQYtpyH1mmp6N6hKt9QP7Q/nae4w0A39kRdlmdGYWsNK5/KR16rG9b+rLVjctOXjod0YfGase6PU4W1GccpZTCyBXGy1Xmkg+bRUtIXjEb4qgo+m6f6bGt1VrMuBrQLVQwaZunkjf5tDLuaW88T71S9bn/ztbLPoetIMbcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iO3q4BWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82F2C4CEF0;
	Fri, 29 Aug 2025 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756491905;
	bh=vDlEp0EHKOQtCnSXvlLe3yB3p1Pk/GJdggy7QE1OE9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iO3q4BWtorj5m+8/0tvYonj0JIlCPJEQFsLQioInoxMNqNXQbi7GQcjt60HztLY/L
	 nGkCSxCwm8+JtuCgasFmocyoFfBNPdcBaaM5f8O5J/DetLbuj8djO8PByxkMU4wsFr
	 rRfwvQiV3C6GMJpfWxyRi1okndcX2pLgQ/4MF3Yw=
Date: Fri, 29 Aug 2025 14:25:01 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
Message-ID: <20250829-translucent-free-chinchilla-bdfcac@lemur>
References: <20250825161114.GM39973@ZenIV>
 <20250825174312.GQ39973@ZenIV>
 <20250826-umbenannt-bersten-c42dd9c4dc6a@brauner>
 <CAHk-=whBm4Y=962=HuYNpbmYBEq-7X8O_aOAPQpqFKv5h5UbSA@mail.gmail.com>
 <CAHk-=wgWD9Kyzyy53iL=r4Qp68jhySp+8pHxfqfcxT3amoj5Bw@mail.gmail.com>
 <20250827-military-grinning-orca-edb838@lemur>
 <CAHk-=wiwiuG93ZeGdTt0n79hzE5HGwSU=ZWW61cc_6Sp9qkG=w@mail.gmail.com>
 <20250827-sandy-dog-of-perspective-54c2ce@lemur>
 <CAHk-=wjcTwA5E7YT8KT6=87nQaJ78A0hqUAVGo9bYRWt9dTe3Q@mail.gmail.com>
 <20250829123033.GA2470272@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829123033.GA2470272@mit.edu>

On Fri, Aug 29, 2025 at 08:30:33AM -0400, Theodore Ts'o wrote:
> So here's a set of feature requests for b4.
> 
> (a) It would be cool(tm), if there was a way for b4 to automatically
>     detect whether or not there was a reply to a patch at the time that
>     "b4 am" is run; if there is, to include the patch series.  If there
>     isn't an e-mail reply, skip the the Link: trailer.

I'm afraid this would mostly breed confusion.

> (b) In the case of a patch series, it would be useful to include some
>     kind of trailer indicating that a group of patches are logically
>     grouped together (maybe a patch-series: that has the message id to
>     the the series header, or the first patch if there is no patch #0)
>     --- because one of the other ways that I figure out that a series
>     of commits are part of a patch series is by looking at the Link:
>     field since if the messages are generated using "git send-email"
>     it's usually obvious from the message id.  This has also come up
>     from some of the folks who want this for their web-based review
>     systems.  I don't care about that, but if it solves multiple use
>     cases at once, that's great.

This is already in place with the change-id trailer (and the corresponding
X-Change-ID email header).

However, only b4 puts those in. Series prepared and sent with git-send-email
don't have any identifier like that.

> (c) Include a link tag to the patch series description e-mail message
>     (if present) in the first commit of the patch series so it's
>     possible to read the patch #0 description of the patch series,
>     since otherwise this can get be hard to find in the git history.

We're talking about the lore.kernel.org web interface?

> (d) For bonus points, if there is a way to determine a link to the
>     previous versions of the patch series, it would be useful for to
>     incude link: tags to previous versions of the patch if and only if
>     there were e-mail comments to say, the v5, v12, and v27 versions
>     of the patch.

Again, are we talking in the context of the lore.kernel.org web interface? The
initial discussion about Link: tags was about them being present in git
commits.

> (e) If there is some way we can easily capture lore.kernel.org URL for
>     the vN-1 version of the patch series in the vN commit description
>     header, in "b4 prep" that would be *excellent*.  I don't think it
>     can do this today, but if it can, can we make sure it's defaulted
>     to on, and then we should **really** market the heck out of b4
>     prep?

You can do this for any b4-prep sent series by just searching for the
change-id string. E.g.:

https://lore.kernel.org/lkml/?q=20241018-pmu_event_info-986e21ce6bd3

`b4 prep` is used quite extensively these days, but it's far from being
predominant.

> The bottom line is I'd love to make Linus less cranky; but I'd also love
> it if I didn't have to do the extra work by hand.  :-)   Because if I do
> have to do it by hand, I will probably screw up, and my preference has
> been to err on the side of having the link, so it's there when I'm
> having to code code archeology --- even if most of the time it's not
> strictly speaking necessary.

This doesn't ultimately solve the problem that we're butting heads about --
that it's impossible to reliably match a commit to its provenance. Using Link:
trailers indicating where the patch came from is the only reliable mechanism
we have thus far, because it establishes this relationship unequivocally.
However, these links annoy Linus, who would like this to be automated in some
other way behind the scenes. I'd love to be able to do so, but short of
running some kind of "provenance transparency log" of curated commit ->
message-id mappings, I don't see how it's possible.

-K

