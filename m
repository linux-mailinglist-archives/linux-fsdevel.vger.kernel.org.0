Return-Path: <linux-fsdevel+bounces-50224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CB7AC8DC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 14:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4963B9EC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 12:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6172222ACDA;
	Fri, 30 May 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Iixtc6xD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332AB224AFE
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608639; cv=none; b=uQBRXxMbakCu6wuQ//GXDKnoqpEfStKuEngJsmwFn4JVCd63PiRr91aFJKIoKaOfyn0AsEfXhXRMa0J3ZPRBiHEQhxKppD2bn7UzAtw3f24+i8VzRBeCtO1yY2N/Yd1KABMHJy0wW2+rNW1OVTZ94lsAKG/iJ+cqxQ+W/AIeJFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608639; c=relaxed/simple;
	bh=usNAqfNU05yWDD1nnvMBPsO4jB44WecabSLtQa+JE+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRQIVOIz02CdEzzBMJeNc1qZJNT+n+5J4wTEtDZONzbHCiHGKZSeXr41kg4fuQ5dCIgc9bPW+GK1TJcRIcG8S3t6by2miNG63KSiNqPbnvH2V2m4nSPRwOythISZVKzLFoVRvuLrTCuKgclc1SOCGjeSvGvnxCHjXjbz4fusExY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Iixtc6xD; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b82Q12q1xz8g8;
	Fri, 30 May 2025 14:20:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748607641;
	bh=XnOAINnFb0Z0ZcHabmc3qHltopvQ1m/OtdV1pvd9//U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iixtc6xDq8SMxPtPVz3eEfOFPJq6OSNq9mg0j6DPkcvi1r3iE8Ae4vp8qmodYpgAd
	 HXk+DJ0PXp2s2uT0p/i1fexLNBhuGQ3aVgdkzut+dav0tI6ZVZNtYRVNlUE0Z/wEnU
	 JtxL5Y7j3xXmCtz0YpVzCWEiXLWncOjsEQ2BghOM=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b82Q01gBszjtL;
	Fri, 30 May 2025 14:20:40 +0200 (CEST)
Date: Fri, 30 May 2025 14:20:39 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <song@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com, 
	Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250530.euz5beesaSha@digikod.net>
References: <20250529173810.GJ2023217@ZenIV>
 <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250529183536.GL2023217@ZenIV>
 <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV>
 <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
 <20250529214544.GO2023217@ZenIV>
 <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
 <20250529231018.GP2023217@ZenIV>
 <CAPhsuW6-J+NUe=jX51wGVP=nMFjETu+1LUTsWZiBa1ckwq7b+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6-J+NUe=jX51wGVP=nMFjETu+1LUTsWZiBa1ckwq7b+w@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, May 29, 2025 at 05:42:16PM -0700, Song Liu wrote:
> On Thu, May 29, 2025 at 4:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, May 29, 2025 at 03:13:10PM -0700, Song Liu wrote:
> >
> > > Is it an issue if we only hold a reference to a MNT_LOCKED mount for
> > > short period of time? "Short period" means it may get interrupted, page
> > > faults, or wait for an IO (read xattr), but it won't hold a reference to the
> > > mount and sleep indefinitely.
> >
> > MNT_LOCKED mount itself is not a problem.  What shouldn't be done is
> > looking around in the mountpoint it covers.  It depends upon the things
> > you are going to do with that, but it's very easy to get an infoleak
> > that way.
> >
> > > > OTOH, there's a good cause for moving some of the flags, MNT_LOCKED
> > > > included, out of ->mnt_flags and into a separate field in struct mount.
> > > > However, that would conflict with any code using that to deal with
> > > > your iterator safely.
> > > >
> > > > What's more, AFAICS in case of a stack of mounts each covering the root
> > > > of parent mount, you stop in each of those.  The trouble is, umount(2)
> > > > propagation logics assumes that intermediate mounts can be pulled out of
> > > > such stack without causing trouble.  For pathname resolution that is
> > > > true; it goes through the entire stack atomically wrt that stuff.
> > > > For your API that's not the case; somebody who has no idea about an
> > > > intermediate mount being there might get caught on it while it's getting
> > > > pulled from the stack.
> > > >
> > > > What exactly do you need around the mountpoint crossing?
> > >
> > > I thought about skipping intermediate mounts (that are hidden by
> > > other mounts). AFAICT, not skipping them will not cause any issue.
> >
> > It can.  Suppose e.g. that /mnt gets propagation from another namespace,
> > but not the other way round and you mount something on /mnt.
> >
> > Later, in that another namespace, somebody mounts something on wherever
> > your /mnt gets propagation to.  A copy will be propagated _between_
> > your /mnt and whatever you've mounted on top of it; it will be entirely
> > invisible until you umount your /mnt.  At that point the propagated
> > copy will show up there, same as if it had appeared just after your
> > umount.  Prior to that it's entirely invisible.  If its original
> > counterpart in another namespace gets unmounted first, the copy will
> > be quietly pulled out.
> 
> Thanks for sharing this information!
> 
> > Note that choose_mountpoint_rcu() callers (including choose_mountpoint())
> > will have mount_lock seqcount sampled before the traversal _and_ recheck
> > it after having reached the bottom of stack.  IOW, if you traverse ..
> > on the way to root, you won't get caught on the sucker being pulled out.
> 
> In some of our internal discussions, we talked about using
> choose_mountpoint() instead of follow_up(). I didn't go that direction in this
> version because it requires holding "root". But if it makes more sense
> to use, choose_mountpoint(), we sure can hold "root".
> 
> Alternatively, I think it is also OK to pass a zero'ed root to
> choose_mountpoint().
> 
> > Your iterator, OTOH, would stop in that intermediate mount - and get
> > an unpleasant surprise when it comes back to do the next step (towards
> > /mnt on root filesystem, that is) and finds that path->mnt points
> > to something that is detached from everything - no way to get from
> > it any further.  That - despite the fact that location you've started
> > from is still mounted, still has the same pathname, etc. and nothing
> > had been disrupted for it.
> >
> > And yes, landlock has a narrow race in the matching place.  Needs to
> > be fixed.  At least it does ignore those as far as any decisions are
> > concerned...

Thanks for pointing this out.  In the case of Landlock, walking to a
disconnected mount point (because of this umount race condition) would
deny the requested access whereas it may be allowed otherwise.  This is
not a security issue but still an issue because an event unrelated to
the request (umount) can abort a path resolution, which should not be
the case.

Without access to mount_lock, what would be the best way to fix this
Landlock issue while making it backportable?

> 
> If we update path_parent in this patchset with choose_mountpoint(),
> and use it in Landlock, we will close this race condition, right?

choose_mountpoint() is currently private, but if we add a new filesystem
helper, I think the right approach would be to expose follow_dotdot(),
updating its arguments with public types.  This way the intermediates
mount points will not be exposed, RCU optimization will be leveraged,
and usage of this new helper will be simplified.

> 
> >
> > Note, BTW, that it might be better off by doing that similar to
> > d_path.c - without arseloads of dget_parent/dput et.al.; not sure
> > how feasible it is, but if everything in it can be done under
> > rcu_read_lock(), that's something to look into.
> 
> I don't think we can do everything here inside rcu_read_lock().
> But d_path.c does have some code we can probably reuse or
> learn from. Also, we probably need two variations of iterators,
> one walk until absolute root, while the other walk until root of
> current->fs, just like d_path() vs. d_absolute_path(). Does this
> sound reasonable?

Passing the root to a public follow_dotdot() helper should do the job.

> 
> Thanks,
> Song
> 

