Return-Path: <linux-fsdevel+bounces-8678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A783A191
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 06:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EBE1F21D01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 05:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49360F501;
	Wed, 24 Jan 2024 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fRZW24rB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307C0E55E
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075565; cv=none; b=ajm5p2U3xVk/YMMehg9jOW6oNqILdav3mmJ4EsjGy7U4kjXZmKWZ5ekXejyP2gXkFA7tuHyu7ru+4Wy61jvqPrqQPesxxqO4LvmEyrXSOsDa7+bKN+4fRRV1czCsH+wUKVTnjUwuH+YGsJJ2lg6knv/cUCYgP3uO9rj7Tcp4vwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075565; c=relaxed/simple;
	bh=yZt0zg3iBUVwGQBEldSRY9zt6NOsTAKk72w6fdMhYKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=by+LoaBzuF2da60lggXMc4c+u9BgEq6d7Pdt1ftjSsT3BfvFkuDhJXmOKibDPHeRPY0GKnf1sS+ji5Z3Clr9c8Fm/npR0y2n6F+B5WoFu2EF0C13dBJ8vvk/lxiIDrenME8Dp63gTj0lWyrK6JVWf96xRC0sheFQlTG2/Pnyrzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fRZW24rB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-122-36.bstnma.fios.verizon.net [173.48.122.36])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40O5q14u027448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 00:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706075525; bh=E/PUYLVV836aOWBrB38K06wEMiKIYR/pOEJXNqfgSKM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=fRZW24rBnce67VYuFMD5QYTSjuCtt55kikicVmlYUY8j8QCeFQFzwzs4A5K9cnO0Z
	 A7T9VFsI9RLmCiwfWB8+T6gzixGYaqD3S5QPaj5is/jjCi0uoPw65kHZ8Eth5LkMPB
	 gVPzDbCrkjXH4Q2wRMxTpm9/j9nlHZVrBLu0/JPRSZGCSSr2IshM4PZguoG1wfL8Qr
	 NNdhPZd4kbK5rTzwA6t7wNsy6v1XxR0T1u0bGamTruZl+1wr6iIdC6OOXMg5MvSkVM
	 L1YdSTaiR4VsJSyVN6sfpPsMoK9lJqwvTDNlDCimW3kTVW5B5Z+SxKLF01ZIsDOeI2
	 qsCHDZlP/g/zw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 6F9DF15C04DD; Wed, 24 Jan 2024 00:52:01 -0500 (EST)
Date: Wed, 24 Jan 2024 00:52:01 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg KH <greg@kroah.com>, Mark Brown <broonie@kernel.org>,
        Neal Gompa <neal@gompa.dev>, Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nikolai Kondrashov <spbnick@gmail.com>,
        Philip Li <philip.li@intel.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <20240124055201.GA2125008@mit.edu>
References: <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
 <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
 <2024011532-mortician-region-8302@gregkh>
 <lr2wz4hos4pcavyrmswpvokiht5mmcww2e7eqyc2m7x5k6nbgf@6zwehwujgez3>
 <20240117055457.GL911245@mit.edu>
 <5b7154f86913a0957e0518b54365a1b0fce5fbea.camel@HansenPartnership.com>
 <20240118024922.GB1353741@mit.edu>
 <32cn5wzlryvq7z64uwo3ztooh7rthlp2ihmbgfyayvehtdbeyt@pnvumkjz4eve>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32cn5wzlryvq7z64uwo3ztooh7rthlp2ihmbgfyayvehtdbeyt@pnvumkjz4eve>

On Sun, Jan 21, 2024 at 07:20:32AM -0500, Kent Overstreet wrote:
> 
> Well, I've tried talking to you about improving our testing tooling - in
> particular, what we could do if we had better, more self contained
> tools, not just targeted at xfstests, in particular a VM testrunner that
> could run kselftests too - and as I recall, your reaction was pretty
> much "why would I be interested in that? What does that do for me?"

My reaction was to your proposal that I throw away my framework which
works super well for me, in favor of your favorite framework.  My
framework already supports blktests and the Phoronix Test Suite, and
it would be a lot less work for me to add support for kselftests to
{gce,kvm,android}-xfstests.

The reality is that we all have test suites that are optimized for our
workflow.  Trying to get everyone to standardize on a single test
framework is going to be hard, since they have optimized for different
use cases.  Mine can be used for both local testing as well as
sharding across multiple Google Cloud VM's, and with auto-bisection
features, and it already supports blktests and PTS, and it handles
both x86 and arm64 with both native and cross-compiling support.  I'm
certainly willing to work with others to improve my xfstests-bld.

> So yeah, I would call that a fail in leadership. Us filesystem people
> have the highest testing requirements and ought to know how to do this
> best, and if the poeple with the most experience aren't trying share
> that knowledge and experience in the form of collaborating on tooling,
> what the fuck are we even doing here?

I'm certainly willing to work with others, and I've accepted patches
from other users of {kvm,gce,android}-xfstests.  If you have something
which is a strict superset of all of the features of xfstests-bld, I'm
certainly willing to talk.

I'm sure you have a system which works well for *you*.  However, I'm
much less interested in throwing away of my invested effort for
something that works well for me --- as well as other users of
xfstests-bld.  (This includes other ext4 developers, Google's internal
prodkernel for our data centers, and testing ext4 and xfs for Google's
Cloud-Opmized OS distribution.)

This is not a leadership failure; this is more like telling a Debian
user to throw away their working system because you think Fedora
better, and "wouldn't it be better if we all used the same
distribution"?

> ktest has been a tiny side project for me. If I can turn that into a
> full blown CI that runs arbitrary self contained VM tests with quick
> turnaround and a nice git log UI, in my spare time, why can't we pitch
> in together instead of each running in different directions and
> collaborate and communicate a bit better instead of bitching so much?

xfstests-bld started as a side project to me as well, and has
accumulated other users and contributors.  Why can't you use my system
instead?  By your definition of "failure of leadership", you have
clearly failed as well in not seeing the light and using *my* system.  :-)

						- Ted

