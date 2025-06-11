Return-Path: <linux-fsdevel+bounces-51283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C61A2AD5238
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA4E1883AC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1B126A0C7;
	Wed, 11 Jun 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRFRpl1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7825C804
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638373; cv=none; b=cWgedspNHIX+dxPS2yZF+a47jY9R/Ur4sY3yVj3Vw0J6QNkPk+E/bfJRq3hLChE4gCYpj/8yCSVemC+g+MRtZJY2xhwExh1cNsrsWC9Z0S4VgIXtBvP/bGIAbbA1VwTDmT03tsXmxJlO9PEz+WW1Hwxkb14a+FGI6cOMQRQIsrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638373; c=relaxed/simple;
	bh=4a3+3KQQENRdpSAaWK5tslN/T3BI+GLq8G7XsfKAb3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgN5L+SCgOIADFXUp8Onx6l21H+7UTduFuoFJOJklVCeCAcBqtbemDEg/KLCuDqwkl8rDcXQTnTpuhVF0B+K4Gzo4huxrlgllRglXStleXwWx03Ivhv4h/CE7XXPP65Y7QpiXunU9/krvwhLh7RHbKG6t9jEV9tVcwsxCPMChfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRFRpl1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1231C4CEEE;
	Wed, 11 Jun 2025 10:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749638371;
	bh=4a3+3KQQENRdpSAaWK5tslN/T3BI+GLq8G7XsfKAb3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRFRpl1y8wPwp1CxCs79p5gpzHpN+j8nnjL1qwoUKs7FNvhoxDdbLDyynQAbnLgVV
	 bo5n+wKf0zovZlAtMhkxnIfnyedzeloMaPpH1tdu5kPZ5zhFyw2iEKNQpLByqZRvpQ
	 qo3L7lF8AQFdoX9QT+EJkQD6vvcNy8iNpJz033q+SIWQWWuREWnlN1n2qPwgMLZGQ7
	 EI1VfmfWfEBS2Whboc8kGsr+z9j+HluH/34XciaiZ0935VUSOCsuSPe6aJ/zMLj86f
	 AxY1fRiSn02rPfMZ3b3ww8eQGFz2G56TuS2d9BWsI69tzZf+DSKQKVyCZzrcGSvTL8
	 nX3AgfWKQ2e6w==
Date: Wed, 11 Jun 2025 12:39:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 06/26] new predicate: anon_ns_root(mount)
Message-ID: <20250611-fehlverhalten-offen-0113576bf502@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-6-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-6-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:28AM +0100, Al Viro wrote:
> checks if mount is the root of an anonymouns namespace.
> Switch open-coded equivalents to using it.
> 
> For mounts that belong to anon namespace !mnt_has_parent(mount)
> is the same as mount == ns->root, and intent is more obvious in
> the latter form.
> 
> NB: comment in do_mount_setattr() appears to be very confused...

The comment just mentions a single case where we did regress userspace
some time ago because we didn't allowing changing mount properties on
the real rootfs (And we have this discussion on another thread.).

But I'm not sure why this belongs in the commit message in the first
place. Just remove the comment.

> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/mount.h     |  7 +++++++
>  fs/namespace.c | 17 +++--------------
>  2 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 9fe06e901cc8..18fa88ad752a 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -160,6 +160,13 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
>  	return ns->seq == 0;
>  }
>  
> +static inline bool anon_ns_root(const struct mount *m)
> +{
> +	struct mnt_namespace *ns = READ_ONCE(m->mnt_ns);
> +
> +	return !IS_ERR_OR_NULL(ns) && is_anon_ns(ns) && m == ns->root;
> +}
> +
>  static inline bool mnt_ns_attached(const struct mount *mnt)
>  {
>  	return !RB_EMPTY_NODE(&mnt->mnt_node);
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 2fb5b9fcd2cd..b229f74762de 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2485,9 +2485,7 @@ struct vfsmount *clone_private_mount(const struct path *path)
>  	 * loops get created.
>  	 */
>  	if (!check_mnt(old_mnt)) {
> -		if (!is_mounted(&old_mnt->mnt) ||
> -			!is_anon_ns(old_mnt->mnt_ns) ||
> -			mnt_has_parent(old_mnt))
> +		if (!anon_ns_root(old_mnt))
>  			return ERR_PTR(-EINVAL);
>  
>  		if (!check_for_nsfs_mounts(old_mnt))
> @@ -3657,9 +3655,6 @@ static int do_move_mount(struct path *old_path,
>  	ns = old->mnt_ns;
>  
>  	err = -EINVAL;
> -	/* The thing moved must be mounted... */
> -	if (!is_mounted(&old->mnt))
> -		goto out;
>  
>  	if (check_mnt(old)) {
>  		/* if the source is in our namespace... */
> @@ -3672,10 +3667,8 @@ static int do_move_mount(struct path *old_path,
>  	} else {
>  		/*
>  		 * otherwise the source must be the root of some anon namespace.
> -		 * AV: check for mount being root of an anon namespace is worth
> -		 * an inlined predicate...
>  		 */
> -		if (!is_anon_ns(ns) || mnt_has_parent(old))
> +		if (!anon_ns_root(old))
>  			goto out;
>  		/*
>  		 * Bail out early if the target is within the same namespace -
> @@ -5036,10 +5029,6 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
>  	err = -EINVAL;
>  	lock_mount_hash();
>  
> -	/* Ensure that this isn't anything purely vfs internal. */
> -	if (!is_mounted(&mnt->mnt))
> -		goto out;
> -
>  	/*
>  	 * If this is an attached mount make sure it's located in the callers
>  	 * mount namespace. If it's not don't let the caller interact with it.
> @@ -5051,7 +5040,7 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
>  	 * neither has a parent nor is it a detached mount so we cannot
>  	 * unconditionally check for detached mounts.
>  	 */
> -	if ((mnt_has_parent(mnt) || !is_anon_ns(mnt->mnt_ns)) && !check_mnt(mnt))
> +	if (!anon_ns_root(mnt) && !check_mnt(mnt))
>  		goto out;
>  
>  	/*
> -- 
> 2.39.5
> 

