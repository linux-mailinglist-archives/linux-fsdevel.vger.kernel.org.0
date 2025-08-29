Return-Path: <linux-fsdevel+bounces-59647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D6DB3BB4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 14:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 026FE4E33FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 12:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F6C317704;
	Fri, 29 Aug 2025 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MGBGf4dY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41433176F6
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470658; cv=none; b=JUOkg0Jbz8eHS/QXNksOVndgoI1FXav/ffhaI5RgwvaFC8yXV3Q1huusDzj9w0uLtDivICN3KH4R27rxGGtz4K1om8CXLSR+tK5uoCW4jHRJJtAQhmHxr0TEBhkjYnrQmdcaxb7qyyQzpAd+6/1N6JH0FE/k3PKhjH4qnLnjnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470658; c=relaxed/simple;
	bh=J5HYb3I3SBC7ma9GELXhsIqKSeing5U3Qdi3yzPLvhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdt4TF4rpaH/oF9EmeBPycOL0+JoTxCyGLSy6aE7BEUQ+c+0CU/v92gmaVH9P7AVFhU1gGvIVo8nB/bfimNJfcSD6aNtoMHVIW7eaug2w2VqntBgRWxcbNSakNJVIfRqq1WuvRAh2evce5lkH6whe2fWyKYFEMdj0QHWXBLp088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MGBGf4dY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-108.bstnma.fios.verizon.net [173.48.114.108])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57TCUYGt012868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 08:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1756470636; bh=75mBFSto0jZO6pTucPPXEhd3w6CFE61xDhiMG6QfiJ0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=MGBGf4dYj7PmAhQIYERC5DSrHUULIXYIz5NsGuJlZWhcHbFwKAx2uF0BgO3pu27mL
	 ui4sKZcb4dwslCHAaDO+ooAHTgSBbLAZjIqxjQjZQ2HWFfwJbCH3Z00E6Gph5O9WuR
	 f5TYg0HWbxRurMKxSFefGHsZJk9y6ONOhObOvJwgwIJ1vjHqUmXE8MnmgGpJTtGATe
	 TcCTCHHkFcXCZ4MvAo5i8jxjcG6MNux9hj2iuUpaYBrUE+Odlds50H4e6XxKBsZXN3
	 ft/yQlJIvXQrEToR2FqljleWCh2pfiBs8tsoJSj3FLZ9+3ZuYWEyl5SI0Dwg2BcD0d
	 0FkkoDKzabrNQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C971D2E00D6; Fri, 29 Aug 2025 08:30:33 -0400 (EDT)
Date: Fri, 29 Aug 2025 08:30:33 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
Message-ID: <20250829123033.GA2470272@mit.edu>
References: <20250825-glanz-qualm-bcbae4e2c683@brauner>
 <20250825161114.GM39973@ZenIV>
 <20250825174312.GQ39973@ZenIV>
 <20250826-umbenannt-bersten-c42dd9c4dc6a@brauner>
 <CAHk-=whBm4Y=962=HuYNpbmYBEq-7X8O_aOAPQpqFKv5h5UbSA@mail.gmail.com>
 <CAHk-=wgWD9Kyzyy53iL=r4Qp68jhySp+8pHxfqfcxT3amoj5Bw@mail.gmail.com>
 <20250827-military-grinning-orca-edb838@lemur>
 <CAHk-=wiwiuG93ZeGdTt0n79hzE5HGwSU=ZWW61cc_6Sp9qkG=w@mail.gmail.com>
 <20250827-sandy-dog-of-perspective-54c2ce@lemur>
 <CAHk-=wjcTwA5E7YT8KT6=87nQaJ78A0hqUAVGo9bYRWt9dTe3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjcTwA5E7YT8KT6=87nQaJ78A0hqUAVGo9bYRWt9dTe3Q@mail.gmail.com>

On Wed, Aug 27, 2025 at 06:29:50PM -0700, Linus Torvalds wrote:
> On Wed, 27 Aug 2025 at 17:41, Konstantin Ryabitsev
> <konstantin@linuxfoundation.org> wrote:
> >
> > I'm not sure what you mean. The Link: trailer is added when the maintainer
> > pulls in the series into their tree.
> 
> That's my point. Adding it to the commit at that point is entirely
> useless, because
> 
>  (a) that email doesn't have the *reason* for the patch (or rather, if
> it does, then the link to the email is pointless, since the *real*
> reason was mentioned already)

From a maintainer's perspective, the reason why I keep the link in is
because I'm dumb-ass lazy.  My workflow involves looking at patchwork,
cutting-and-pasting the Message-Id, and then passing it to b4.
Looking through a 20 patch series to figure out which one rates a
Link: trailer, and which one doesn't is a pain in the *ss, and in the
off-chance that there *is* a meaningful and deep discussion, it would
be nice to be able to capture it.  But it might be in patch #4; or
patch #12; or patches #14 and #15.  Also, there might be an extended
conversation thread in the patch series description (patch #0) and it
would be useful to be able to get a link to it.

So here's a set of feature requests for b4.

(a) It would be cool(tm), if there was a way for b4 to automatically
    detect whether or not there was a reply to a patch at the time that
    "b4 am" is run; if there is, to include the patch series.  If there
    isn't an e-mail reply, skip the the Link: trailer.

(b) In the case of a patch series, it would be useful to include some
    kind of trailer indicating that a group of patches are logically
    grouped together (maybe a patch-series: that has the message id to
    the the series header, or the first patch if there is no patch #0)
    --- because one of the other ways that I figure out that a series
    of commits are part of a patch series is by looking at the Link:
    field since if the messages are generated using "git send-email"
    it's usually obvious from the message id.  This has also come up
    from some of the folks who want this for their web-based review
    systems.  I don't care about that, but if it solves multiple use
    cases at once, that's great.

(c) Include a link tag to the patch series description e-mail message
    (if present) in the first commit of the patch series so it's
    possible to read the patch #0 description of the patch series,
    since otherwise this can get be hard to find in the git history.

(d) For bonus points, if there is a way to determine a link to the
    previous versions of the patch series, it would be useful for to
    incude link: tags to previous versions of the patch if and only if
    there were e-mail comments to say, the v5, v12, and v27 versions
    of the patch.

(e) If there is some way we can easily capture lore.kernel.org URL for
    the vN-1 version of the patch series in the vN commit description
    header, in "b4 prep" that would be *excellent*.  I don't think it
    can do this today, but if it can, can we make sure it's defaulted
    to on, and then we should **really** market the heck out of b4
    prep?

The bottom line is I'd love to make Linus less cranky; but I'd also love
it if I didn't have to do the extra work by hand.  :-)   Because if I do
have to do it by hand, I will probably screw up, and my preference has
been to err on the side of having the link, so it's there when I'm
having to code code archeology --- even if most of the time it's not
strictly speaking necessary.

Cheers,

      	       	       	      	    	 - Ted

