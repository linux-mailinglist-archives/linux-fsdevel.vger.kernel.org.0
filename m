Return-Path: <linux-fsdevel+bounces-50304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 756F8ACAB65
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D0B3BBFE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372E41E1A3D;
	Mon,  2 Jun 2025 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at/9AmMH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88229AD5E;
	Mon,  2 Jun 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748856621; cv=none; b=eZHybftZ0XfG0U8wDrviazBgTZlI9S4gHbcxO4Lac5p5YPmAhXPEk261dGi0oqNCPNar+yyaLH9ZnHaCFW2R4MIhiQ+egRjiWQwHlW8/EhiVm7orLEWbWqECzWhk9zm+9jpiU/yW8/mYiFjKTI9+rr9uOIkpPmkzI1Dpxyf8eBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748856621; c=relaxed/simple;
	bh=aDUBGlfptgInexGGrVjaZTgI+VShdoXmTL1ZuJC/YuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T90TgoTcFFr5VNa/E/qQGNw6Q3xrEzFvfv+eT6E6GSDO99hf0DAIdnss+eZiq6x5JP3gv4zn5k0dwVM/3P1mYbgkEdWiwBrPruag5l6RvhXIN5cCH6sYkNTAsCe+Z1o5w9TlF+YCf7vHtK8Xy6BCILemgDxXMvq8VVfJhNqCPt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=at/9AmMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9BDC4CEEB;
	Mon,  2 Jun 2025 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748856620;
	bh=aDUBGlfptgInexGGrVjaZTgI+VShdoXmTL1ZuJC/YuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=at/9AmMHELZvvziiPPxxxOXpzL3Zn5SvDzSDStMyjGRKzzbZPkSug1b/UQ8tKl+Z3
	 pAw4ywTTICdD+dOGryL+neBI6174Tz8FbZxhtJgeRdyeSocOxQmCmwXnsFcZKBYnxR
	 QRANmU71lit7Tj1KoGY2I95lnwZar2pWmzrhQSjlw/NKSgGVWZOUNSm4Zn69+aVHon
	 kwxl5ocM3UvSiD53aDwvEZbr/mJJ4pdNsCppNguo2NfZJiCrAYZ/Jl//T1uRYm1u10
	 lJfPEEGfOHahv6rkYiPjfyKuZhTX27wIKGBaexqauqRMBRKXyafJuNQ2Ap29c+qzX9
	 a982/K6ne/dww==
Date: Mon, 2 Jun 2025 11:30:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Song Liu <song@kernel.org>, Jan Kara <jack@suse.cz>, 
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, 
	josef@toxicpanda.com, mic@digikod.net, gnoack@google.com
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250602-beunruhigen-sichtweise-9effb0388fdb@brauner>
References: <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <20250529173810.GJ2023217@ZenIV>
 <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250529183536.GL2023217@ZenIV>
 <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV>
 <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
 <20250529214544.GO2023217@ZenIV>
 <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
 <20250529231018.GP2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250529231018.GP2023217@ZenIV>

On Fri, May 30, 2025 at 12:10:18AM +0100, Al Viro wrote:
> On Thu, May 29, 2025 at 03:13:10PM -0700, Song Liu wrote:
> 
> > Is it an issue if we only hold a reference to a MNT_LOCKED mount for
> > short period of time? "Short period" means it may get interrupted, page
> > faults, or wait for an IO (read xattr), but it won't hold a reference to the
> > mount and sleep indefinitely.
> 
> MNT_LOCKED mount itself is not a problem.  What shouldn't be done is
> looking around in the mountpoint it covers.  It depends upon the things
> you are going to do with that, but it's very easy to get an infoleak
> that way.
> 
> > > OTOH, there's a good cause for moving some of the flags, MNT_LOCKED
> > > included, out of ->mnt_flags and into a separate field in struct mount.
> > > However, that would conflict with any code using that to deal with
> > > your iterator safely.
> > >
> > > What's more, AFAICS in case of a stack of mounts each covering the root
> > > of parent mount, you stop in each of those.  The trouble is, umount(2)
> > > propagation logics assumes that intermediate mounts can be pulled out of
> > > such stack without causing trouble.  For pathname resolution that is
> > > true; it goes through the entire stack atomically wrt that stuff.
> > > For your API that's not the case; somebody who has no idea about an
> > > intermediate mount being there might get caught on it while it's getting
> > > pulled from the stack.
> > >
> > > What exactly do you need around the mountpoint crossing?
> > 
> > I thought about skipping intermediate mounts (that are hidden by
> > other mounts). AFAICT, not skipping them will not cause any issue.
> 
> It can.  Suppose e.g. that /mnt gets propagation from another namespace,
> but not the other way round and you mount something on /mnt.
> 
> Later, in that another namespace, somebody mounts something on wherever
> your /mnt gets propagation to.  A copy will be propagated _between_
> your /mnt and whatever you've mounted on top of it; it will be entirely
> invisible until you umount your /mnt.  At that point the propagated
> copy will show up there, same as if it had appeared just after your
> umount.  Prior to that it's entirely invisible.  If its original
> counterpart in another namespace gets unmounted first, the copy will
> be quietly pulled out.

Fwiw, I have explained these and similar issues at length multiple times.

> 
> Note that choose_mountpoint_rcu() callers (including choose_mountpoint())
> will have mount_lock seqcount sampled before the traversal _and_ recheck
> it after having reached the bottom of stack.  IOW, if you traverse ..
> on the way to root, you won't get caught on the sucker being pulled out.
> 
> Your iterator, OTOH, would stop in that intermediate mount - and get
> an unpleasant surprise when it comes back to do the next step (towards
> /mnt on root filesystem, that is) and finds that path->mnt points
> to something that is detached from everything - no way to get from
> it any further.  That - despite the fact that location you've started
> from is still mounted, still has the same pathname, etc. and nothing
> had been disrupted for it.

Same...

