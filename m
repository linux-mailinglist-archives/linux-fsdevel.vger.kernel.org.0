Return-Path: <linux-fsdevel+bounces-66384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B002C1DA64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 00:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9F454E06D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE15C2E0B59;
	Wed, 29 Oct 2025 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiY+ByUP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF842F619F;
	Wed, 29 Oct 2025 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779596; cv=none; b=Gs0xbpkmuEBK6QTyEI/uJoAG6IwXF+4LsHCAr85MyyrIxIHsSXAJaZudfZmHWR4fWld12DLfoBbZFwvRiMzUKq83b5RAs/7gPSYcNfvBZpmI83YzxfretoSNgkbhAAid/yzfmLcqTqsRfYPWEcYUyVvbY3Uo1qInV34tNmTGffM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779596; c=relaxed/simple;
	bh=i8sPeculRlHzZXFfvtQA6o9c6EpAjxIY7l+PSiETcnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EODTUL9gULOy6Uuq06icJIOtNvkbDXrTSuycA4SrP9y2OYB6kIxr0+krLUuBLuFg97pZkQFvE1sqJs+mYet65BejAwHCLSdb32ssvuPd+KLzjICDFlUBI19HtGehiKVBLBn903n1a+3x6IqUIfeCnuETsyhjUFzCJ1ZsAYfMD1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiY+ByUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BA9C4CEF7;
	Wed, 29 Oct 2025 23:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761779595;
	bh=i8sPeculRlHzZXFfvtQA6o9c6EpAjxIY7l+PSiETcnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uiY+ByUPi5Gw0keXarfyDh0x4sGc21DhKNN2G4NYxpm+bNksuOWVltQHkHN86LIYi
	 RaAMLOubXG2tgMevlImlz98kcfhpJV0pnjabg/Pgz8r1jpBkgiz/zVws4+d9VU7Qrp
	 0ArzjJA+vp+nPmkFJ9Pqxw4MOOsXyZRHupam3MreHjkf2esJdnfmadADPulvdABl2C
	 A75p2KahDnpfHJfHIxnQKEZLYmb24wcfl22k8H5WYz8fsApXRHydO2j+4VKynOZwnr
	 mznk1cw/WoVPi1vl9C69VJsPeFSu01EMvYCVd1HygiSgPSNBQEiXarilWN91Dawgnn
	 FJTJTg/CUVdFw==
Date: Thu, 30 Oct 2025 00:13:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] fs/pipe: stop duplicating union pipe_index declaration
Message-ID: <20251030-zuruf-linken-d20795719609@brauner>
References: <20251023082142.2104456-1-linux@rasmusvillemoes.dk>
 <20251029-redezeit-reitz-1fa3f3b4e171@brauner>
 <20251029173828.GA1669504@ax162>
 <20251029-wobei-rezept-bd53e76bb05b@brauner>
 <CAHk-=wjGcos7LACF0J40x-Dwf4beOYj+mhptD+xcLte1RG91Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjGcos7LACF0J40x-Dwf4beOYj+mhptD+xcLte1RG91Ug@mail.gmail.com>

On Wed, Oct 29, 2025 at 03:53:37PM -0700, Linus Torvalds wrote:
> On Wed, 29 Oct 2025 at 15:25, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Meh, I thought it was already enabled.
> > Are you pushing this as a new feature for v6.19 or is Linus ok with
> > enabling this still during v6.18?
> 
> I wasn't planning on doing any conversions for 6.18, but if it makes
> things easier for people to start doing this, I could certainly take
> just the "add new compiler flags" at any time.

Oh nice!

> 
> Alternatively, maybe Rasmus/Nathan could just expose that commit
> 778740ee2d00 ("Kbuild: enable -fms-extensions") as a shared stable
> branch.
> 
> That commit seems to be directly on top of 6.18-rc2, so people who
> want it could just pull that commit instead.

I'm fine either way. @Nathan, if you just want to give Linus the patch
if it's small enough or just want to give me a stable branch I can pull
I'll be content. Thanks!

