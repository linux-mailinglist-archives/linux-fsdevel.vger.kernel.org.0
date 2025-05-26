Return-Path: <linux-fsdevel+bounces-49834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBDCAC38CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 06:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869CF7A90A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 04:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C6B1A8401;
	Mon, 26 May 2025 04:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K12ZesCA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176642A87
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748234849; cv=none; b=J/h6QyAeH4Lhe+RFS4gPYXfWdki5oTHnK1TTHeSgxVUfxOfgioIr8mxFrHcvPAQ4bxpFcl+f0Pb1IHxQDMcOeGty9hYODDWgF+lgp+uWlFBujpMvfwRbeHFisZI//1qXSqbAt/GwIgPj0fe17Tg7JfjYgGGQYjhlf5LEX3wdNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748234849; c=relaxed/simple;
	bh=dmcd7gSmAy5p9Ox7myFnG4imeDc/5lWWQke69PxKIwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVODmgayfgFBP/KkHFzWeACau4jJlP/Tvww9xw1W4kSc/L4V+nqEguM1gzYyp061nqz0DveOdohUhkeqbkDv28q997o3lkYtUAiL0zbR9s2AC2EpZsxcEWmByStD0bQ4CA1Zm+3in75640lpLNIaH7mAUkLI5saWOVsYCy2sKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K12ZesCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B77C4CEE7;
	Mon, 26 May 2025 04:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748234849;
	bh=dmcd7gSmAy5p9Ox7myFnG4imeDc/5lWWQke69PxKIwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K12ZesCA4q7zaJQeXY0eec+s+ah8NxOmMAGCQWk/ApBw/1RqDyZra7CfFOqd+tfoN
	 xx8oL1QsKcSc/J1xu/F4woVm2DNDwKAYeUBckALyG+cB5oPR+3WSr8iRGKgHUm6hAX
	 J4KS5Dkg8RvQT7FikXqyolKYRf+PjDmEqadUWhBt/uwanYomDou7DgI2hViJ+KhGyO
	 gAV2dIll0Fr7Tlhxd1NVn/9KdNFboy/DWjdALj5rjJeICrbkIwuCOFKxNQN6lrOt+j
	 z95+MNGEcr8rQ086lJO8YN9BW/oVGvVa8ZSTGJVsg5dZCbpojdk26A0HoGNG5MlJEj
	 IRgL+07HXdC3Q==
Date: Mon, 26 May 2025 06:47:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Allison Karlitskaya <lis@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: Apparent mount behaviour change in 6.15
Message-ID: <20250526-kondition-genehm-84f02ccedf54@brauner>
References: <CAOYeF9WQhFDe+BGW=Dp5fK8oRy5AgZ6zokVyTj1Wp4EUiYgt4w@mail.gmail.com>
 <20250515-abhauen-geflecht-c7eb5df70b78@brauner>
 <20250523063238.GI2023217@ZenIV>
 <20250523-aufweichen-dreizehn-c69ee4529b8b@brauner>
 <20250523212958.GJ2023217@ZenIV>
 <20250523213735.GK2023217@ZenIV>
 <20250523232213.GL2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250523232213.GL2023217@ZenIV>

On Sat, May 24, 2025 at 12:22:13AM +0100, Al Viro wrote:
> On Fri, May 23, 2025 at 10:37:35PM +0100, Al Viro wrote:
> > On Fri, May 23, 2025 at 10:29:58PM +0100, Al Viro wrote:
> > 
> > > This is bogus, IMO.  I'm perfectly fine with propagate_one() returning 0
> > > on anon_ns(m->mnt); that would refuse to propagate into *any* anon ns,
> > > but won't screw the propagation between the mounts that are in normal, non-anon
> > > namespaces.
> > 
> > IOW, I mean this variant - the only difference from what you've posted is
> > the location of is_anon_ns() test; you do it in IS_MNT_NEW(), this variant
> > has it in propagate_one().  Does the variant below fix regression?
> 
> AFAICS, it does suffice to revert the behaviour change on the reproducer
> upthread.
> 
> I've replaced the top of viro/vfs.git#fixes with that; commit message there
> is tentative - if nothing else, that's a patch from Christian with slight
> modifications from me.  It also needs reported-by, etc.
> 
> Said that, could somebody (original reporter) confirm that the variant
> in git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git #fixes (head at
> 63e90fcc1807) is OK with them?
> 
> And yes, it will need a proper commit message.  Christian?

Yes, that looks good to me, thank you!

> 
> commit 63e90fcc18072638a62196caae93de66fc6cbc37
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Fri May 23 19:20:36 2025 -0400
> 
>     Don't propagate mounts into detached trees
>     
>     That reverts to behaviour of 6.14 and earlier, with
>     fix from "fix IS_MNT_PROPAGATING uses" preserved.
>     
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 7aecf2a60472..ad7173037924 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -7,10 +7,6 @@
>  
>  extern struct list_head notify_list;
>  
> -typedef __u32 __bitwise mntns_flags_t;
> -
> -#define MNTNS_PROPAGATING	((__force mntns_flags_t)(1 << 0))
> -
>  struct mnt_namespace {
>  	struct ns_common	ns;
>  	struct mount *	root;
> @@ -37,7 +33,6 @@ struct mnt_namespace {
>  	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
>  	struct list_head	mnt_ns_list; /* entry in the sequential list of mounts namespace */
>  	refcount_t		passive; /* number references not pinning @mounts */
> -	mntns_flags_t		mntns_flags;
>  } __randomize_layout;
>  
>  struct mnt_pcp {
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 1b466c54a357..623cd110076d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3648,7 +3648,7 @@ static int do_move_mount(struct path *old_path,
>  	if (!(attached ? check_mnt(old) : is_anon_ns(ns)))
>  		goto out;
>  
> -	if (is_anon_ns(ns)) {
> +	if (is_anon_ns(ns) && ns == p->mnt_ns) {
>  		/*
>  		 * Ending up with two files referring to the root of the
>  		 * same anonymous mount namespace would cause an error
> @@ -3656,16 +3656,7 @@ static int do_move_mount(struct path *old_path,
>  		 * twice into the mount tree which would be rejected
>  		 * later. But be explicit about it right here.
>  		 */
> -		if ((is_anon_ns(p->mnt_ns) && ns == p->mnt_ns))
> -			goto out;
> -
> -		/*
> -		 * If this is an anonymous mount tree ensure that mount
> -		 * propagation can detect mounts that were just
> -		 * propagated to the target mount tree so we don't
> -		 * propagate onto them.
> -		 */
> -		ns->mntns_flags |= MNTNS_PROPAGATING;
> +		goto out;
>  	} else if (is_anon_ns(p->mnt_ns)) {
>  		/*
>  		 * Don't allow moving an attached mount tree to an
> @@ -3722,8 +3713,6 @@ static int do_move_mount(struct path *old_path,
>  	if (attached)
>  		put_mountpoint(old_mp);
>  out:
> -	if (is_anon_ns(ns))
> -		ns->mntns_flags &= ~MNTNS_PROPAGATING;
>  	unlock_mount(mp);
>  	if (!err) {
>  		if (attached) {
> diff --git a/fs/pnode.c b/fs/pnode.c
> index fb77427df39e..ffd429b760d5 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -231,8 +231,8 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
>  	/* skip if mountpoint isn't visible in m */
>  	if (!is_subdir(dest_mp->m_dentry, m->mnt.mnt_root))
>  		return 0;
> -	/* skip if m is in the anon_ns we are emptying */
> -	if (m->mnt_ns->mntns_flags & MNTNS_PROPAGATING)
> +	/* skip if m is in the anon_ns */
> +	if (is_anon_ns(m->mnt_ns))
>  		return 0;
>  
>  	if (peers(m, last_dest)) {

