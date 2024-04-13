Return-Path: <linux-fsdevel+bounces-16856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 042B68A3C00
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 11:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8129EB2154A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A78376E2;
	Sat, 13 Apr 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBspg1Lx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B39D1E515;
	Sat, 13 Apr 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713001324; cv=none; b=bVHleeXDWYUCY9K8vrSnrAsulkVIHXgMFt9pG6SksdUGBdUnhMsXQzZSzIUWwUrbzCkVSUauyza79NIb6Hs2E1OcJXX3ICrpALl8QWLhmcbKjQjaPlVxKDg4eas33cB0UhGeTOxYQ6+jYXAAiq1XqhGCjrMs+jUTFJL9Qweze+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713001324; c=relaxed/simple;
	bh=rIdyIzeWyytQNTt2PuS6xZHsPm01Tq24RBxQ59IuLm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpALFyMt2Zqz5ZNvcIcnB6bUmg6A64ic4v3iNZ4ltE7ZpbkpmUkn4u66+RA07OzqXc+3SYQEDtAC+O5VfPlrgv4mY5A83kvLqkyJEqx+zq30iclz/VRn51wgbwcCR9tmUvm1lqAVz9VAIY/IuDb8JZqfYWWFneOWKgqhMso6Fqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBspg1Lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF39C3277B;
	Sat, 13 Apr 2024 09:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713001323;
	bh=rIdyIzeWyytQNTt2PuS6xZHsPm01Tq24RBxQ59IuLm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBspg1Lx9XU/EoMFCU9hXzhO2MUatTIBx+YbZxVcb+hCq99a7b4pA1zBYOXPfy4HL
	 DL3+rkKK4ovi5OHs+uSFBIvG4UBc88+Wl8n4YtF21LvTb3agOJ64Iy4TrJzPOLXarl
	 rG/xwyB1aX6gJFhW4odPJWNyqa1jjZYrZWlK8pab4tiP6INTc8GvtJsiJT202ctH/b
	 KKOTZXqBJ231P6warRbuWr+5FBX1cHxmNFq3Wy9uK9xP7zi3RMIkxmTcMWaCXMb8jq
	 Q6tBhgv4yGVyhrZ9YaZYyTzPNnF+lT5SfsYqEk+MGDAh0OT+n9l2S2wy8vtqUWWxrg
	 QWLNgfhdwaZdw==
Date: Sat, 13 Apr 2024 11:41:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() -
 requirements
Message-ID: <20240413-aufgaben-feigen-e61a1ec3668f@brauner>
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <20240412-vegetarisch-installieren-1152433bd1a7@brauner>
 <CAHk-=wiYnnv7Kw7v+Cp2xU6_Fd-qxQMZuuxZ61LgA2=Gtftw-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiYnnv7Kw7v+Cp2xU6_Fd-qxQMZuuxZ61LgA2=Gtftw-A@mail.gmail.com>

On Fri, Apr 12, 2024 at 10:43:06AM -0700, Linus Torvalds wrote:
> Side note: I'd really like to relax another unrelated AT_EMPTY_PATH
> issue: we should just allow a NULL path for that case.
> 
> The requirement that you pass an actual empty string is insane. It's
> wrong. And it adds a noticeable amount of expense to this path,
> because just getting the single byte and looking it up is fairly
> expensive.
> 
> This was more noticeable because glibc at one point (still?) did
> 
>         newfstatat(6, "", buf, AT_EMPTY_PATH)
> 
> when it should have just done a simple "fstat()".
> 
> So there were (are?) a *LOT* of AT_EMPTY_PATH users, and they all do a
> pointless "let's copy a string from user space".
> 
> And yes, I know exactly why AT_EMPTY_PATH exists: because POSIX
> traditionally says that a path of "" has to return -ENOENT, not the
> current working directory. So AT_EMPTY_PATH basically says "allow the
> empty path for lookup".
> 
> But while it *allows* the empty path, it does't *force* it, so it
> doesn't mean "avoid the lookup", and we really end up doing a lot of
> extra work just for this case. Just the user string copy is a big deal
> because of the whole overhead of accessing user space, but it's also
> the whole "allocate memory for the path etc".
> 
> If we either said "a NULL path with AT_EMPTY_PATH means empty", or
> even just added a new AT_NULL_PATH thing that means "path has to be
> NULL, and it means the same as AT_EMPTY_PATH with an empty path", we'd
> be able to avoid quite a bit of pointless work.

It also causes issues for sandboxed enviroments (most recently for the
Chrome sandbox) because AT_EMPTY_PATH doesn't actually mean
AT_EMPTY_PATH unless the string is actually empty. Otherwise
AT_EMPTY_PATH is ignored. So I'm all on board for this. I need to think
a bit whether AT_NULL_PATH or just allowing NULL would be nicer. Mostly
because I want to ensure that userspace can easily detect this new
feature.

