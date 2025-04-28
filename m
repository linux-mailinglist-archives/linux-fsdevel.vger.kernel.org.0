Return-Path: <linux-fsdevel+bounces-47495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9A5A9EB29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 10:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3353D179EB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BBC25EF81;
	Mon, 28 Apr 2025 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kX72plmB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB725D1EC
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830258; cv=none; b=R2qMTIjxrKmBQbMlIqH8xXogb+ksmwiax/mo0tVw4n5EfDL5L75OKr4Pbuav2kfhxgySndf44acjJS9f02M74e/2CmEZ/68XXBQYMUdADiLQFFNtApua4IAh67W6Lyrz9l0I8KZ4YWGuNv7qg/iu7R3M/VuNSuoB0yf7S6BrSZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830258; c=relaxed/simple;
	bh=u+1wl6Y6TpTLzpTOlpKG/OikQ5WDwsp4LynOQldqE3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVi5yNdcrBfM3UlY35EYiAehjBBSvfgyYY+0WCzK1wfuKdwZ28NNp65MMBq06n3P67H37awv8xzClSf5ze9gITsaLGeXPwRWouSzQNWiwpePNSKeCzqI2G8BIxL+V1StMyfoLh7iWzc11mLfPqEpmE2qhXHCilr43/IMKENdhYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kX72plmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52EFC4CEE4;
	Mon, 28 Apr 2025 08:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745830257;
	bh=u+1wl6Y6TpTLzpTOlpKG/OikQ5WDwsp4LynOQldqE3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kX72plmB28qTWCr5SJjPpbNq0XJrhUjfD1T3/2z9HVMBQE6AgR3h+TvJtl8lqrNE4
	 /2E0DFFmv8OVJmXLyMMMAJazzlxkOL7LiJYZv8MUdtBRVS+NVR2J/kweelvU2EXKWs
	 ZlHXHlSuqEAYkMjuBu8HaG7gBTxJlxf73r7pHlz0sUKUqQ6ynSbho1YZ5f9NOEGJ5W
	 ak8l1zqJZBCHDnqAuMMGynLRM7cybLfk/HO8BdkIPkHWwp55MbECk22h9XtOh3t7aI
	 /B5FRvxliF/By8HCLH/gZbVkiUBWFU9r2I5EITRgVx5OG3zk48xDoMc+Eo1VwTdvS4
	 0EE9ygzUeXz4w==
Date: Mon, 28 Apr 2025 10:50:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] move_mount(2): still breakage around new mount detection
Message-ID: <20250428-wortkarg-krabben-8692c5782475@brauner>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428070353.GM2023217@ZenIV>

On Mon, Apr 28, 2025 at 08:03:53AM +0100, Al Viro wrote:
> On Mon, Apr 28, 2025 at 07:30:56AM +0100, Al Viro wrote:
> > have at most one ns so marked, right?  And we only care about it in
> > propagate_mnt(), where we are serialized under namespace_lock.
> > So why not simply remember the anon_ns we would've marked and compare
> > ->mnt_ns with it instead of dereferencing and checking for flag?
> > 
> > IOW, what's wrong with the following?
> 
> Hmm... You also have propagation_would_overmount() (from
> can_move_mount_beneath()) checking it...  IDGI.
> 
> For that predicate to trigger in there you need source
> anon ns - you won't see NULL ->mnt_ns there.  So...
> mnt_from is the absolute root of anon ns, target is
> *not* in that anon ns (either it's in our current namespace,
> or in a different anon ns).  IOW, in
>         if (propagation_would_overmount(parent_mnt_to, mnt_to, mp))
> 		return -EINVAL;
> IS_MNT_PROPAGATED() will be false (mnt_to has unmarked namespace)
> and in
>         if (propagation_would_overmount(parent_mnt_to, mnt_from, mp))
> 		return -EINVAL;
> IS_MNT_PROPAGATED() is true.  So basically, we can drop that
> check inf propagation_would_overmount() and take it to
> can_move_mount_beneath(), turning the second check into
>         if (check_mnt(mnt_from) &&
> 	    propagation_would_overmount(parent_mnt_to, mnt_from, mp))
> 		    return -EINVAL;
> since mnt_from is either ours or root of anon and the check removed
> from propagation_would_overmount() had it return false in "mnt_from
> is root of anon" case.
> 
> And we obviously need it cleared at the end of propagate_mnt(),
> yielding the patch below.  Do you see any other problems?
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
> index eba4748388b1..3061f1b04d4c 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3556,7 +3556,8 @@ static int can_move_mount_beneath(const struct path *from,
>  	 * @mnt_from itself. This defeats the whole purpose of mounting
>  	 * @mnt_from beneath @mnt_to.
>  	 */
> -	if (propagation_would_overmount(parent_mnt_to, mnt_from, mp))
> +	if (check_mnt(mnt_from) &&
> +	    propagation_would_overmount(parent_mnt_to, mnt_from, mp))
>  		return -EINVAL;
>  
>  	return 0;
> @@ -3656,14 +3657,6 @@ static int do_move_mount(struct path *old_path,
>  		 */
>  		if ((is_anon_ns(p->mnt_ns) && ns == p->mnt_ns))
>  			goto out;
> -
> -		/*
> -		 * If this is an anonymous mount tree ensure that mount
> -		 * propagation can detect mounts that were just
> -		 * propagated to the target mount tree so we don't
> -		 * propagate onto them.
> -		 */
> -		ns->mntns_flags |= MNTNS_PROPAGATING;
>  	} else if (is_anon_ns(p->mnt_ns)) {
>  		/*
>  		 * Don't allow moving an attached mount tree to an
> @@ -3714,9 +3707,6 @@ static int do_move_mount(struct path *old_path,
>  	if (err)
>  		goto out;
>  
> -	if (is_anon_ns(ns))
> -		ns->mntns_flags &= ~MNTNS_PROPAGATING;
> -
>  	/* if the mount is moved, it should no longer be expire
>  	 * automatically */
>  	list_del_init(&old->mnt_expire);
> diff --git a/fs/pnode.c b/fs/pnode.c
> index 7a062a5de10e..26d0482fe017 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -13,6 +13,18 @@
>  #include "internal.h"
>  #include "pnode.h"
>  
> +static struct mnt_namespace *source_anon;
> +static inline bool IS_MNT_PROPAGATED(const struct mount *m)
> +{
> +	/*
> +	 * If this is an anonymous mount tree ensure that mount
> +	 * propagation can detect mounts that were just
> +	 * propagated to the target mount tree so we don't
> +	 * propagate onto them.
> +	 */
> +	return !m->mnt_ns || m->mnt_ns == source_anon;
> +}
> +
>  /* return the next shared peer mount of @p */
>  static inline struct mount *next_peer(struct mount *p)
>  {
> @@ -300,6 +312,9 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
>  	last_source = source_mnt;
>  	list = tree_list;
>  	dest_master = dest_mnt->mnt_master;
> +	source_anon = source_mnt->mnt_ns;
> +	if (source_anon && !is_anon_ns(source_anon))
> +		source_anon = NULL;
>  
>  	/* all peers of dest_mnt, except dest_mnt itself */
>  	for (n = next_peer(dest_mnt); n != dest_mnt; n = next_peer(n)) {
> @@ -328,6 +343,7 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
>  			CLEAR_MNT_MARK(m->mnt_master);
>  	}
>  	read_sequnlock_excl(&mount_lock);
> +	source_anon = NULL;

I'm not fond of the global variable. I would generally agree with you if
that were really performance sensitive but this really isn't.

I'll have more uses for the flags member very soon as I will make it
possible to list mounts in anonymous mount namespaces because it
confuses userspace to no end that they can't list detached mount trees.

So anonymous mount namespaces will simply get a mount namespace id just
like any other mount namespace and simply be discerned by a flag.

Thanks for going through this. I appreciate it.

The check_mnt() simplification is good though.

