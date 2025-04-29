Return-Path: <linux-fsdevel+bounces-47566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C902AA059E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 10:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DD1844D98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 08:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E076627CB06;
	Tue, 29 Apr 2025 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAK5QZgM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB5427A939
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745914883; cv=none; b=uzJR6o3yyoZmD2wVtjBbCB4vPFrQW8Wq3rpAEDaR/xbIXn7en2VTV0NI3PsdyW1Zi8muLMQDx7ZgvZERQ1GJzeg0hkCDl3c8p2Ryvk/oaTDVcnEyCYwHYQAs90LN6P/tacjpSvPwp9msTBoLDjyDmL7dw2PT64tK7hZvyoqsudo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745914883; c=relaxed/simple;
	bh=FRih5VNH03RD5xis6I1b+MqVRIWzWhLJipDapjGDWrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfNNvjPaBIUlmYxI2oAX8vEEmW+jQMiMKoXIdpa08+AyOnCMxctR/U8B+iUNrt8JzXak4EzKbQVyGLHTTzR26oxsaGsPB7GgLJXslKF0CZ69o5S9Zqxr8khj1I9Rfrety9G9x5qXPhC0XPfwdSwvmGirH09WOWQf/1tgT054l00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAK5QZgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB693C4CEE3;
	Tue, 29 Apr 2025 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745914882;
	bh=FRih5VNH03RD5xis6I1b+MqVRIWzWhLJipDapjGDWrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAK5QZgMKwEwK6QSdk6dpFfjTUfd0NzkO83fhRcHFjtal8pvSZaBAL3PTk2FZ96/d
	 1w0Y10rQLn9W1n6x4CUdQXki4WKURSwOLNlHLOtU727h57223ZhwrhrOcAx0L634xY
	 sFMlKdc4mE46TtBG92m6/cbvTpTukoRCKbgKwqXuKylPuFg89YTdhVyMNH1AMPPuQB
	 A43c/hLokM9Pkh2NHwPgnbuh6MqsU/1dmHQWe/VBH3gUKgAaaa86nzITkVGIyq/s6E
	 39ZxFxUG9QJKTdB/jE5AUp3CTuAq1jsptziLGjl3bU6PjeeLxyOSZWFWR2uOSrxat4
	 Mr3AXrW2WvEcA==
Date: Tue, 29 Apr 2025 10:21:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] move_mount(2): still breakage around new mount detection
Message-ID: <20250429-bauzeit-klargemacht-b3a0ff8b39c0@brauner>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250429040358.GO2023217@ZenIV>
 <20250429051054.GP2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250429051054.GP2023217@ZenIV>

On Tue, Apr 29, 2025 at 06:10:54AM +0100, Al Viro wrote:
> On Tue, Apr 29, 2025 at 05:03:58AM +0100, Al Viro wrote:
> > On Mon, Apr 28, 2025 at 07:53:18PM +0100, Al Viro wrote:
> > 
> > > FWIW, I've a series of cleanups falling out of audit of struct mount
> > > handling; it's still growing, but I'll post the stable parts for review
> > > tonight or tomorrow...
> > 
> > _Another_ fun one, this time around do_umount().
> 
> ... and more, from 620c266f3949 "fhandle: relax open_by_handle_at()
> permission checks" - just what is protecting has_locked_children()
> use there?  We are, after all, iterating through ->mnt_mounts -
> with no locks whatsoever.  Not to mention the fun question regarding

Mea culpa. That was clearly an obvious accident.
It's a not very subtle oversight.

> the result (including the bits sensitive to is_mounted()) remaining
> valid by the time you get through exportfs_decode_fh_raw() (and no,
> you can't hold any namespace_sem over it - no IO allowed under

I know.

> that, so we'll need to recheck after that point)...

Why bother rechecking? It's literally just to prove that the caller
could theoretically get an unobstructed view by shedding mounts if they
wanted to. This is an approximation _at best_.

The caller obviously cannot switch mount namespace so there's no risk of
suddenly a bunch of locked mounts popping up. The only way we could
suddenly have a locked mount appear is if someone propagated a mount
tree into the callers user+mount namespace from a different user+mount
namespace and some mounts were about to expire. And it even has to be an
actual tree and not just a single mount.

So honestly, the one check is just fine. It's imperfect as it is and
it's for the special users that really need this. It's blocked in nearly
all container runtimes by default anyway because it can be abused to
open any crap on the system. This is literally fringe but needed
functionality.

