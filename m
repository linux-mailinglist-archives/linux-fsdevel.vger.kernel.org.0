Return-Path: <linux-fsdevel+bounces-31801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3521799B315
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 12:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE59B21500
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CC115443C;
	Sat, 12 Oct 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqcf/DUv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4418136330;
	Sat, 12 Oct 2024 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728729440; cv=none; b=bYnUq3REPFFH10PpXsjdNg2qW5kreMmfcKJabE38ABs0VlF6oJrNg8IKhtS4o1C4VJJtIacx1xJG5M5FK0mgGR94Imh21XZpPUpoGVKa8pEDPBC3ZjUbgPrP05z7dWQ18PeRuXbfJCd1pmplekOGX8vqFNTNkGDCOQHJGfZd2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728729440; c=relaxed/simple;
	bh=9fmZEr9oLMAK2u7YxH5ipKdKgoLnFz66NSTlF+KsnME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1zqe+aPCtJn+H5xtgq6QOUk2ZxAofVhw05t1L8rMCMXhqnIj9VKhcj+kE7j5xu8e/5gS5U0oFK3cdCIjkM2G8msB25CNhyqInnaqK1lLToTh6Uzq3Cxj4njP1yEmxOibg4VuqpU7U4VTlJdniQQ4aEgcV51T5leKSiXNW5ZrB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqcf/DUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEDCC4CEC6;
	Sat, 12 Oct 2024 10:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728729440;
	bh=9fmZEr9oLMAK2u7YxH5ipKdKgoLnFz66NSTlF+KsnME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lqcf/DUvulIUpIMq4QGzAQEMghWHDFniW8Ik4Mw2LFv+/f8phXRDHscuR5HNN3JQM
	 oWj/j0mXNZJZDBAseEvUKB5J/hJBy2uwNey4es7yhSKKogT2vWPXxsMsibR5T6+12p
	 1y8vxG+4P/1CQjK9Uu1hF4HqWtaZD5mK4QVMyHLzFeCIeFBxQ4IH8bMto36JDJrEel
	 aRdXbj8QsNrCn+167fMKS6/ahF+51ecJSugGrzUV5cm/PcxWsJnrtH2JkJkfaZexeO
	 hQzeMkXs4mdJ2lo3RnSwyJGTqPq3BuuRAkDF1eovgvek4fnhDtQN+JRY/JOIYJRZz4
	 qpG5eSOItfSGQ==
Date: Sat, 12 Oct 2024 12:37:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/4] ovl: specify layers via file descriptors
Message-ID: <20241012-geklagt-busfahren-49fc6d75088b@brauner>
References: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org>
 <20241011-work-overlayfs-v2-2-1b43328c5a31@kernel.org>
 <CAOQ4uxhhReggva_knvfTfCW4VzgiBo7w3wLMEsp7eLy36cPcfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhhReggva_knvfTfCW4VzgiBo7w3wLMEsp7eLy36cPcfQ@mail.gmail.com>

On Sat, Oct 12, 2024 at 10:25:38AM +0200, Amir Goldstein wrote:
> On Fri, Oct 11, 2024 at 11:46 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> 
> nit: if you can avoid using the exact same title for the cover letter and
> a patch that would be nice (gmail client collapses them together).

Fine, but fwiw, the solution to this problem is to use a proper email
client. ;)

> 
> > Currently overlayfs only allows specifying layers through path names.
> > This is inconvenient for users such as systemd that want to assemble an
> > overlayfs mount purely based on file descriptors.
> >
> > This enables user to specify both:
> >
> >     fsconfig(fd_overlay, FSCONFIG_SET_FD, "upperdir+", NULL, fd_upper);
> >     fsconfig(fd_overlay, FSCONFIG_SET_FD, "workdir+",  NULL, fd_work);
> >     fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower1);
> >     fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower2);
> >
> > in addition to:
> >
> >     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "upperdir+", "/upper",  0);
> >     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "workdir+",  "/work",   0);
> >     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower1", 0);
> >     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower2", 0);
> >
> 
> Please add a minimal example with FSCONFIG_SET_FD to overlayfs.rst.
> I am not looking for a user manual, just one example to complement the
> FSCONFIG_SET_STRING examples.
> 
> I don't mind adding config types on a per need basis, but out of curiosity
> do you think the need will arise to support FSCONFIG_SET_PATH{,_EMPTY}
> in the future? It is going to be any more challenging than just adding
> support for
> just FSCONFIG_SET_FD?

This could also be made to work rather easily but I wouldn't know why we
would want to add it. The current overlayfs FSCONFIG_SET_STRING variant
is mostly equivalent. Imho, it's a lot saner to let userspace do the
required open via regular openat{2}() and then use FSCONFIG_SET_FD, then
force *at() based semantics down into the filesystem via fsconfig().
U_PATH{_EMPTY} is unused and we could probably also get rid of it.

> 
> Again, not asking you to do extra work for a feature that no user asked for.
> 
> Other than that, it looks very nice and useful.

Thanks!

