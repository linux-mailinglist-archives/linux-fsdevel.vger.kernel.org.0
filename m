Return-Path: <linux-fsdevel+bounces-16864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F89F8A3D2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 17:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D6B1F2182C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 15:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95DB45C04;
	Sat, 13 Apr 2024 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4z+86AH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EDF42A96;
	Sat, 13 Apr 2024 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021390; cv=none; b=QK9lCPRVrekkQeKID9z7VVOiG23VrQ/3CvM1Qy7/VETdZoUmvfNggoCPX/PZ/pru06U0RF2yOktu9nD5ijIN/ow19SMi6uT23cM0bNf+UB9usqPZO5q76BiWL/0JMhRAlL8Ee9FiPe8rFW5nY/QtHpYmKFRlNmU3q0VcrYXCe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021390; c=relaxed/simple;
	bh=29YarKc0WYNTWP1PNRSnD3A3fcc5Wb6BU/OaAvyB/hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/9HK+zxGxkkYnx4einnpfV9TSb+Pq5zgeqfapZXTNWbnXp3GeM16q2r+jHV6LWessZqMQOnI0AI8MIwgpftrrAQEnYVQML7LEu/qAH0gy1pu9L69fOVgGBI8A+p9DRfg2mi3snWcz+Cz5JxDaGqUh3VxLjtYRRSHyOykhUyuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4z+86AH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A026C113CD;
	Sat, 13 Apr 2024 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713021389;
	bh=29YarKc0WYNTWP1PNRSnD3A3fcc5Wb6BU/OaAvyB/hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4z+86AH0nG+BT1F1V4YYCbQR4fb/rU0cC4UJPobP/ZgaWUvZtMILOxRC5lE2ijJ3
	 2ZdA2ADpZ/XDl2Z3VafgsCqzB2EqwSo9DZkg9kfHnnz60Qnv/81xem4W3j+eZj3ioU
	 tLEfkV99gj9E/SM8KqenvLn0RUEt/UVtG+ECerTuLyBLTqBBP+C7qkAIFlMKVxUUvq
	 14Fz4iCKIuIOaHOe7ixIgYpcByeAAON5VpMUs/glzbgp5X+rLThZ4Y952cU6S5v6tr
	 YG3tqkBrKGMTt45/tQeYWOH4x5tTj4RBguxgIXEbn51A+HyzB1YjkuhT/nb2RBeTYP
	 eXuC86M6sFU+g==
Date: Sat, 13 Apr 2024 17:16:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() -
 requirements
Message-ID: <20240413-armbrust-specht-394d58f53f0f@brauner>
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <20240412-vegetarisch-installieren-1152433bd1a7@brauner>
 <CAHk-=wiYnnv7Kw7v+Cp2xU6_Fd-qxQMZuuxZ61LgA2=Gtftw-A@mail.gmail.com>
 <20240413-aufgaben-feigen-e61a1ec3668f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240413-aufgaben-feigen-e61a1ec3668f@brauner>

On Sat, Apr 13, 2024 at 11:41:57AM +0200, Christian Brauner wrote:
> On Fri, Apr 12, 2024 at 10:43:06AM -0700, Linus Torvalds wrote:
> > Side note: I'd really like to relax another unrelated AT_EMPTY_PATH
> > issue: we should just allow a NULL path for that case.
> > 
> > The requirement that you pass an actual empty string is insane. It's
> > wrong. And it adds a noticeable amount of expense to this path,
> > because just getting the single byte and looking it up is fairly
> > expensive.
> > 
> > This was more noticeable because glibc at one point (still?) did
> > 
> >         newfstatat(6, "", buf, AT_EMPTY_PATH)
> > 
> > when it should have just done a simple "fstat()".
> > 
> > So there were (are?) a *LOT* of AT_EMPTY_PATH users, and they all do a
> > pointless "let's copy a string from user space".
> > 
> > And yes, I know exactly why AT_EMPTY_PATH exists: because POSIX
> > traditionally says that a path of "" has to return -ENOENT, not the
> > current working directory. So AT_EMPTY_PATH basically says "allow the
> > empty path for lookup".
> > 
> > But while it *allows* the empty path, it does't *force* it, so it
> > doesn't mean "avoid the lookup", and we really end up doing a lot of
> > extra work just for this case. Just the user string copy is a big deal
> > because of the whole overhead of accessing user space, but it's also
> > the whole "allocate memory for the path etc".
> > 
> > If we either said "a NULL path with AT_EMPTY_PATH means empty", or
> > even just added a new AT_NULL_PATH thing that means "path has to be
> > NULL, and it means the same as AT_EMPTY_PATH with an empty path", we'd
> > be able to avoid quite a bit of pointless work.
> 
> It also causes issues for sandboxed enviroments (most recently for the
> Chrome sandbox) because AT_EMPTY_PATH doesn't actually mean
> AT_EMPTY_PATH unless the string is actually empty. Otherwise
> AT_EMPTY_PATH is ignored. So I'm all on board for this. I need to think
> a bit whether AT_NULL_PATH or just allowing NULL would be nicer. Mostly
> because I want to ensure that userspace can easily detect this new
> feature.

I think it should be ok to allow AT_EMPTY_PATH with NULL because
userspace can detect whether the kernel allows that by passing
AT_EMPTY_PATH with a NULL path argument and they would get an error back
that would tell them that this kernel doesn't support NULL paths.

I'd like to try a patch for this next week. It's a good opportunity to
get into some of the more gritty details of this area.

From a rough first glance most AT_EMPTY_PATH users should be covered by
adapting getname_flags() accordingly.

Imho, this could likely be done by introducing a single struct filename
null_filename. That also takes care of audit that reuses the pathname.
That thing would basically never go away and the refcnt remain fixed at
one. Kind of similar to what we did for struct mnt_idmap nop_mnt_idmap.
That's at least what I naively hope for but I haven't yet starting
looking into all the dark corners.

