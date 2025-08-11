Return-Path: <linux-fsdevel+bounces-57245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D97F3B1FD65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 02:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B037A15A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 00:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6890F19CD1B;
	Mon, 11 Aug 2025 00:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="jy0xTVGJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1856E158535;
	Mon, 11 Aug 2025 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754873902; cv=none; b=NqHcdnry/7QkGM7XBBzF1uqrl3FgvTSQ784jQGVCiUk5x5O7S+mBGzWqKt+6tg3KKp97M+oxymnKLaACLo2tjSTdsTx8cYw+AXIAM+t11AZxQyH5HpEtL5N3w2IHoXsC3zeVjI37Y9LWD8+6evWMzcV/5LjdSoGybsVR5WfWCAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754873902; c=relaxed/simple;
	bh=Ca6C5/G6JFtlESkeALp4nkpI7w6l08YrhdSky1a/1Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EE1frHuz+r4gpJBws8N0m/e5ecL40N1Jfd8uLcxARDqCOzZItrB4GtHrGsqt0B1yG6022r1Y7BDakUmBITWDkitPNnE+zOPyd9O7aGR1H65gPXcgzumX/6jh3Sx6oRUGiJrDS8uyoFvqlsZjiCOe5bnCVMWSPmxcMaaiuP7hhHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=jy0xTVGJ; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A234914C2D3;
	Mon, 11 Aug 2025 02:58:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1754873893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+WDmvL58Zkd9+bnuMxxM5Ne5Go/EKIWCRikWVY6hwo=;
	b=jy0xTVGJiNYAtFxShDClUvVeoh1ob4HiiAV9pGwcMjUI4CiojpOvQnTdtzliclCLXddcKB
	yZJ8JWBKAY2eltqmk4VR70SuAmXFUMF/1gj88IpFIJOFqbydf2JFcWl/M+ry6FqYD267qR
	j4O8h1+Jhm5tZiB1P9n8mxPwqwX0vZwdAJkP3oyR7lcLtInQdEJgyGFGjt+BPWd24bq5ub
	tTbLE915b226sd4IQj1X6y3XwLww+/kC9x8406mJFMB9kULd99YfRTuncz08L4C8Wi5OmT
	FPJCNahS3tNKXfxDnUKn76Vzue1AjhqAfTvBWR2T7DAUUZ1KW+EzMgnmxiJCKw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id a20b2092;
	Mon, 11 Aug 2025 00:58:06 +0000 (UTC)
Date: Mon, 11 Aug 2025 09:57:51 +0900
From: asmadeus@codewreck.org
To: Arnout Engelen <arnout@bzzt.net>
Cc: ryan@lahfa.xyz, antony.antony@secunet.com, antony@phenome.org,
	brauner@kernel.org, dhowells@redhat.com, ericvh@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net, maximilian@mbosch.me,
	netfs@lists.linux.dev, regressions@lists.linux.dev,
	sedat.dilek@gmail.com, v9fs@lists.linux.dev
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Message-ID: <aJlAD0nPcR2kvAtS@codewreck.org>
References: <w5ap2zcsatkx4dmakrkjmaexwh3mnmgc5vhavb2miaj6grrzat@7kzr5vlsrmh5>
 <20250810175712.3588005-1-arnout@bzzt.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250810175712.3588005-1-arnout@bzzt.net>

Arnout Engelen wrote on Sun, Aug 10, 2025 at 07:57:11PM +0200:
> I have a smallish nix-based reproducer at [3], and a more involved setup
> with a lot of logging enabled and a convenient way to attach gdb at [4].
> You start the VM and then 'cat /repro/default.json' manually, and see if
> it looks 'truncated'.

Thank you!!! I was able to reproduce with this!

(well, `nix -L build .#nixosConfigurations.default.config.system.build.vm`
to build the VM as this machine isn't running nixos and doesn't have
nixos-rebuild...)

> Interestingly, the file is read in two p9 read calls: one of 12288 bytes and
> one of 655 bytes. The first read is a zero-copy one, the second is not
> zero-copy (because it is smaller than 1024).

Yes, your msize is set to 16k but with the 9p overhead the largest,
4k-aligned read that can be done is 12k, so that's coherent.
(Changing the msize to 32k so it's read in a single zero-copy read,
obviously makes this particular error go away, but it's a huge hint)

Removing readahead also makes the problem go away, which is also
surprising because from looking at traces it's only calling into
p9_client_read() once (which forks the two p9_client_read_once, one with
zc and the other without), so readahead shouldn't matter at all but it
obviously does...

Also I haven't been able to reproduce it with a kernel I built myself/my
environment, but it reproduces reliably 99% of the times in the nixos
VM, so we're missing a last piece for a "simple" (non-nix) reproducer,
but I think it's good enough for me to dig into this;
I'll try to find time to check in details this afternoon...
Basically "just" have to follow where the data is written and why it
doesn't end up in the iov and fix that, but I'll need to reproduce on a
kernel I built first to be able to validate the fix.


Anyway this is a huge leap forward (hopeful it's the same problem and we
don't have two similar issues lurking here...), we can't thank you
enough.

I'll report back ASAP.
-- 
Dominique Martinet | Asmadeus

