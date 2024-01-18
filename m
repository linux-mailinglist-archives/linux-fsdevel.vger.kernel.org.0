Return-Path: <linux-fsdevel+bounces-8222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96071831183
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 03:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A7FB232C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 02:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A866A6106;
	Thu, 18 Jan 2024 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="nEZ0rDNJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586A553B4
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705546206; cv=none; b=QVjw4B1mxerCss5/0xf54fdmrZ+vrg5c+soz4tFTAw5RSlLEhjpMtj//DAw0G1A5lPrjE8kGFXjQtG5RHPcwgQauCgokk1dYDVwvXE5rflfdU7sOuQHKiRwkmcQ2uNF+o16toQofVt+wAxgND1YV1m4z61xfYvXac6vdtOMsFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705546206; c=relaxed/simple;
	bh=BJg75ZFdFsMHx0IzN/znZuL4kHgdbCZHjvh8m/sP/Ic=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=txGpQ2U9eSpaaPBGOGckwdVgPRIHcyab1OPH++THORDQhL2F6b0W09Eb1XdjWCZSv/j3PARb0nsDh3aoDRqpzpvdxGOOkR1vixBMXJXUMKDrtkf7g9z7ZWMfhwQG1OpoYkwZuHpXK/CRMkugnmhpdOe+vlGuTmAgLJziMxhkLJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=nEZ0rDNJ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-211.bstnma.fios.verizon.net [173.48.112.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40I2nMf0019056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 21:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1705546166; bh=QY2jieE117yh9NkMq2fzek7v348fUElM78MBn1O7k+c=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=nEZ0rDNJWDL7d1gCdVYmfFfutRKEw2G+rNE4+GDGhxboywGSJtNjBqEe+MTnpiBik
	 yVjrGhFN+FUGGE4TXKk0mgfcA19fnasGKYpVsNbMuLqEREcvVI9545CVNmF82H4mmG
	 dC0kCfezHq6SMV7AalXUahxeaDxPKUt0X4z/PU8tJT666bmVDF9tjAFTzvUVv2hf/F
	 ATwbGobBtp4bFlkdlL+wqjIV+plKAZz5ntdTgt1jGs8ao5G/6smZS0yMGsaBPbIsX/
	 9wNI4Rlqf9vk1QiE3F2yluvG4UhQrXxXoyYBffTJ86mh3Z6JdQf/GkE0v6fj8aeJtx
	 y1GEMArcvRm8w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 82EC215C0278; Wed, 17 Jan 2024 21:49:22 -0500 (EST)
Date: Wed, 17 Jan 2024 21:49:22 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Greg KH <greg@kroah.com>,
        Mark Brown <broonie@kernel.org>, Neal Gompa <neal@gompa.dev>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nikolai Kondrashov <spbnick@gmail.com>,
        Philip Li <philip.li@intel.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <20240118024922.GB1353741@mit.edu>
References: <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
 <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
 <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
 <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
 <2024011532-mortician-region-8302@gregkh>
 <lr2wz4hos4pcavyrmswpvokiht5mmcww2e7eqyc2m7x5k6nbgf@6zwehwujgez3>
 <20240117055457.GL911245@mit.edu>
 <5b7154f86913a0957e0518b54365a1b0fce5fbea.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7154f86913a0957e0518b54365a1b0fce5fbea.camel@HansenPartnership.com>

On Wed, Jan 17, 2024 at 08:03:35AM -0500, James Bottomley wrote:
> Actually, this is partly our fault.  Companies behave exactly like a
> selfish contributor does:
> 
> https://archive.fosdem.org/2020/schedule/event/selfish_contributor/
> 
> The question they ask is "if I'm putting money into it, what am I
> getting out of it".  If the answer to that is that it benefits
> everybody, it's basically charity  to the entity being asked (and not
> even properly tax deductible at that), which goes way back behind even
> real charitable donations (which at least have a publicity benefit) and
> you don't even get to speak to anyone about it when you go calling with
> the collecting tin.  If you can say it benefits these 5 tasks your
> current employees are doing, you might have a possible case for the
> engineering budget (you might get in the door but you'll still be
> queuing behind every in-plan budget item).  The best case is if you can
> demonstrate some useful for profit contribution it makes to the actual
> line of business (or better yet could be used to spawn a new line of
> business), so when you're asking for a tool, it has to be usable
> outside the narrow confines of the kernel and you need to be able to
> articulate why it's generally useful (git is a great example, it was
> designed to solve a kernel specific problem, but not it's in use pretty
> much everywhere source control is a thing).

I have on occasion tried to make the "it benefits the whole ecosystem"
argument, and that will work on the margins.  But it's a lot harder
when it's more than a full SWE-year's worth of investment, at least
more recently.  I *have* tried to get more test investment. with an
eye towards benefitting not just one company, but in a much more
general fasion ---- but multi-engineer projects are a very hard sell,
especially recently.  If Kent wants to impugn my leadership skills,
that's fine; I invite him to try and see if he can get SVP's cough up
the dough.  :-)

I've certainly had a lot more success with the "Business quid pro quo"
argument; fscrypt and fsverity was developed for Android and Chrome;
casefolding support benefited Android and Steam; ext4 fast commits was
targetted at cloud-based NFS and Samba serving, etc.

My conception of a successful open source maintainer includes a strong
aspect of a product manager whose job is to find product/market fit.
That is, I try to be a matchmaker between some feature that I've
wnated for my subsystem, and would benefit users, and a business case
that is sufficientlty compelling that a company is willing to fund the
engineering effort to make taht feature happen.  That companmy might
be one that signs my patcheck, or might be some other company.  For
special bonus points, if I can convince some other company to find a
good chunk of the engineering effort, and it *also* benefits the
company that pays my salary, that's a win-win that I can crow about at
performance review time.  :-)

> Somewhere between 2000 and now we seem to have lost our ability to
> frame the argument in the above terms, because the business quid pro
> quo argument was what got us money for stuff we needed and the Linux
> Foundation and the TAB formed, but we're not managing nearly as well
> now.  The environment has hardened against us (we're no longer the new
> shiny) but that's not the whole explanation.

There are a couple of dynamics going on here, I think.  When a company
is just starting to invest in open source, and it is the "new shiny"
it's a lot easier to make the pitch for big projects that are good for
everyone.  In the early days of the IBM Linux Technolgy Center, the
Linux SMP scalability effort, ltp, etc., were significantly funded by
the IBM LTC.  And in some cases, efforts which didn't make it
upstream, but which inspired the features to enter Linux (even if it
wasn't IBM code), such as in the case of the IBM's linux thread or
volume management, it was still considered a win by IBM management.

Unfortunately, this effect fades over time.  It's a lot easier to fund
multi-engineer projects which run for more than a year, when a company
is just starting out, and when it's still trying to attract upstream
developers, and it has a sizeable "investment" budget.  ("IBM will
invest a billion dollars in Linux").  But then in later years, the
VP's have to justify their budget, and so companies tend to become
more and more "selfish".  After all, that's how capitalism works ---
"think of the children^H^H^H^H^H^H^H shareholders!"

I suspect we can all think of companies beyond just IBM where this
dynamic is at play; I certainly can!

The economic cycle can also make a huge difference.  Things got harder
after the dot com imposiion; then things lossened up.  Howver,
post-COVID, we've seen multiple companies really become much more
focused on "how is this good for our company".  It has different names
at different companies, such as "year of efficiency" or "sharpening
our focus", but it often is accompanied with layoffs, and a general
tightening of budgets.  I don't think it's an accident that
maintainwer grumpiness has been higher than normal in the last year or
so.

	    	       	  	      	     	- Ted

