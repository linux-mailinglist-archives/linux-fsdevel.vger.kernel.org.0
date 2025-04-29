Return-Path: <linux-fsdevel+bounces-47565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA69FAA050D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 09:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8F97ACB54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 07:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DC32741A7;
	Tue, 29 Apr 2025 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTSabfOX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D355A1F76A5
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913378; cv=none; b=u9ULlEE2jXGuj2ygQPMc9gTl9IYrMiPIwYL300MbCcwbI9Z5aqqBrlsdL4HI+sPg1M6c2j6S2ampHTJYMQdFy9fMktb0rWII0ZjyrI4MZ3vabICl7Gyx4Y5QMJYx0k5FDjzhN6+0d6u34GyPucrbOE6fD6/NLHFus+fIWDTlPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913378; c=relaxed/simple;
	bh=2V06loNAAzfYeqOT5xrGJlQLes41bGzSn7Dpn+3kdKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7uOEvQI8Q8jtZC+oeAGTeJEYcPMS8JQL/Gfo0XaNTWHHZbs04nNvHMTNTFNqfFq4MFxFMo5a/vJlI8NzgJs+v6tyW273IuQjZNGRDd/9H1rQahaPboxb5LK8RL1yU2Ma/7Y7kihVeZUxT722czYkeSYGIhsccAvjGO5k27zFWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTSabfOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F87C4CEE3;
	Tue, 29 Apr 2025 07:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745913378;
	bh=2V06loNAAzfYeqOT5xrGJlQLes41bGzSn7Dpn+3kdKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTSabfOXjDew5vmu/bEvDwBWu+9EOAffb2CuJ35uPj/EJbq/VgpZ1Wrjhvm/rW8rY
	 HnaqUiUMGv5DIgQ5Cj/ZDfG0Iv+CKvgK7dhj+rYjjZr7U8nFV+12pOIK1DPeQ+CanQ
	 4kPJdFuabPbV2DgUcbXiMRLX+TOJ+8WV3VazQUv+VGH51widuyS4+UrW8mIF7y7L5B
	 z5Tm5AuLRLWNgcXxs1jRupnMH3heBbcAA1k0LSId6w8jtwk4KE7FRQNZMGHYBp9jv3
	 Dgf8mkyeu/4NEjxMX8jDi2oxneU5ylhzvN7rRlTpBrjICB9SvhHJoc/f9NsWqLoxvJ
	 Y4hc4SQe+XFAA==
Date: Tue, 29 Apr 2025 09:56:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] move_mount(2): still breakage around new mount detection
Message-ID: <20250429-fakten-anfliegen-6cf13f1292d0@brauner>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250429040358.GO2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250429040358.GO2023217@ZenIV>

On Tue, Apr 29, 2025 at 05:03:58AM +0100, Al Viro wrote:
> On Mon, Apr 28, 2025 at 07:53:18PM +0100, Al Viro wrote:
> 
> > FWIW, I've a series of cleanups falling out of audit of struct mount
> > handling; it's still growing, but I'll post the stable parts for review
> > tonight or tomorrow...
> 
> _Another_ fun one, this time around do_umount().  Take a look
> at this chunk in mntput_no_expire():
>         lock_mount_hash();
> 	/*
> 	 * make sure that if __legitimize_mnt() has not seen us grab
> 	 * mount_lock, we'll see their refcount increment here.
> 	 */
> 	smp_mb();
> 	mnt_add_count(mnt, -1);
> 	count = mnt_get_count(mnt);
> 
> ... and note that we do *not* have such a barrier in do_umount(), between
>         lock_mount_hash();
> and
>                 shrink_submounts(mnt);
> 		retval = -EBUSY;
> 		if (!propagate_mount_busy(mnt, 2)) {
> making it possible to __legitimize_mnt() fail to see lock_mount_hash() in
> do_umount(), with do_umount() not noticing the increment of refcount done
> by __legitimize_mnt().  It is considerably harder to hit, but I wouldn't
> bet on it being impossible...

Most of these issues are almost impossible to hit in real workloads or
it's so rare that it doesn't matter. This one in particular seems like a
really uninteresting one. I mean, yes we should probably add that
barrier there but also nobody would care if we didn't.

> 
> The sky is not falling (the worst we'll get is a successful sync umount(2)
> ending up like a lazy one would; sucks if you see that umount(2) has succeeded
> and e.g. pull a USB stick out, of course, but...)
> 
> But AFAICS we need a barrier here, to make sure that either legitimize_mnt()
> fails seqcount check, grabs mount_lock, sees MNT_SYNC_UMOUNT and quitely
> decrements refcount and buggers off or umount(2) sees the increment in
> legitimize_mnt() and fails with -EBUSY.
> 
> It's really the same situation as with mntput_no_expire(), except that
> there the corresponding flag is MNT_DOOMED...
> 
> [PATCH] do_umount(): add missing barrier before refcount checks in sync case
>     
> do_umount() analogue of the race fixed in 119e1ef80ecf "fix
> __legitimize_mnt()/mntput() race".  Here we want to make sure that
> if __legitimize_mnt() doesn't notice our lock_mount_hash(), we will
> notice their refcount increment.  Harder to hit than mntput_no_expire()
> one, fortunately, and consequences are milder (sync umount acting
> like umount -l on a rare race with RCU pathwalk hitting at just the
> wrong time instead of use-after-free galore mntput_no_expire()
> counterpart used to be hit).  Still a bug...
>  
> Fixes: 48a066e72d97 ("RCU'd vsfmounts")

That's an ancient bug at that...

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

> diff --git a/fs/namespace.c b/fs/namespace.c
> index eba4748388b1..d8a344d0a80a 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -787,7 +787,7 @@ int __legitimize_mnt(struct vfsmount *bastard, unsigned seq)
>  		return 0;
>  	mnt = real_mount(bastard);
>  	mnt_add_count(mnt, 1);
> -	smp_mb();			// see mntput_no_expire()
> +	smp_mb();		// see mntput_no_expire() and do_umount()
>  	if (likely(!read_seqretry(&mount_lock, seq)))
>  		return 0;
>  	lock_mount_hash();
> @@ -2044,6 +2044,7 @@ static int do_umount(struct mount *mnt, int flags)
>  			umount_tree(mnt, UMOUNT_PROPAGATE);
>  		retval = 0;
>  	} else {
> +		smp_mb(); // paired with __legitimize_mnt()
>  		shrink_submounts(mnt);
>  		retval = -EBUSY;
>  		if (!propagate_mount_busy(mnt, 2)) {

