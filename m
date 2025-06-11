Return-Path: <linux-fsdevel+bounces-51284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D19AD523C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F238F3A48B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56BB26772E;
	Wed, 11 Jun 2025 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6ATRibp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246AB256C93
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638504; cv=none; b=X8G2/wcMwU4jeus2iF2+fJKfeAReqa2mfoZxicuogqaYteHtj0YaiCiqyvYzODLINUPyB9xNrUmx4p83ZuEj5uEozViOAdmNvy2ClQzC+BTChYM2ZeOPy9/UvyzaBKY03hZSTiyVKSUxGt325sDgipD3XYnF0oODtukTItkmyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638504; c=relaxed/simple;
	bh=lbTA5UMU9wHIDVpeH6ICjnZ6c2/3SjvFISF72eCr3wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMWqBOBH4pAbBEbTwa4rAwiN66nJkr4nYlyVycchgMp7TC5y3ubZrrpuzCm01K1XmyM5GBhoH7xwwV5loUlf8mU3ykwwYzmdUhGqiLawNVeSmLHu2HvhI3QWL9fTs0+7wXK+bL6LmOU9/ObteEq5U4JHU/ZguoH5FfAI00cIvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6ATRibp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC5BC4CEEE;
	Wed, 11 Jun 2025 10:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749638503;
	bh=lbTA5UMU9wHIDVpeH6ICjnZ6c2/3SjvFISF72eCr3wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6ATRibp85HHecSOFvY+tzlI/nHwwpyJ9oQYHoz9fzOp0OHObCpuQX2qmjldh/H5T
	 GVz0GyjW5xmHeM6u157GJrqk7ZxsyHCcMJA9de26WCaJs4KFyhlqw4VGmjKbTLVTNZ
	 N5F1LWKmWUzz0X/nz5MTQI1wemvUQjPL6/qESm1/AWt2rq/WSLOdnoStPmIhhJo+5j
	 yVqInvcvTV6msgLHxrr1mDP91mzAcHFHWZHVhImQu7sGblmrcjgv5Zb7bel0xa27jm
	 /Hi9Dfu6mN+oZSFMgwAPr8yUqnX4Npxp9Bq8o0x8yux2SrOwAeALbeD1Zck/z9rWwA
	 Yix3RmQQGAopA==
Date: Wed, 11 Jun 2025 12:41:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 07/26] dissolve_on_fput(): use anon_ns_root()
Message-ID: <20250611-regte-jaguar-609086ada538@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-7-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-7-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:29AM +0100, Al Viro wrote:
> that's the condition we are actually trying to check there...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/namespace.c | 62 +++++++++++---------------------------------------
>  1 file changed, 13 insertions(+), 49 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index b229f74762de..e783eb801060 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2329,67 +2329,31 @@ struct vfsmount *collect_mounts(const struct path *path)
>  static void free_mnt_ns(struct mnt_namespace *);
>  static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *, bool);
>  
> -static inline bool must_dissolve(struct mnt_namespace *mnt_ns)
> -{
> -	/*
> -        * This mount belonged to an anonymous mount namespace
> -        * but was moved to a non-anonymous mount namespace and
> -        * then unmounted.
> -        */
> -	if (unlikely(!mnt_ns))
> -		return false;
> -
> -	/*
> -        * This mount belongs to a non-anonymous mount namespace
> -        * and we know that such a mount can never transition to
> -        * an anonymous mount namespace again.
> -        */
> -	if (!is_anon_ns(mnt_ns)) {
> -		/*
> -		 * A detached mount either belongs to an anonymous mount
> -		 * namespace or a non-anonymous mount namespace. It
> -		 * should never belong to something purely internal.
> -		 */
> -		VFS_WARN_ON_ONCE(mnt_ns == MNT_NS_INTERNAL);
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
>  void dissolve_on_fput(struct vfsmount *mnt)
>  {
>  	struct mnt_namespace *ns;
>  	struct mount *m = real_mount(mnt);
>  
> +	/*
> +	 * m used to be the root of anon namespace; if it still is one,
> +	 * we need to dissolve the mount tree and free that namespace.
> +	 * Let's try to avoid taking namespace_sem if we can determine
> +	 * that there's nothing to do without it - rcu_read_lock() is
> +	 * enough to make anon_ns_root() memory-safe and once m has
> +	 * left its namespace, it's no longer our concern, since it will
> +	 * never become a root of anon ns again.
> +	 */
> +
>  	scoped_guard(rcu) {
> -		if (!must_dissolve(READ_ONCE(m->mnt_ns)))
> +		if (!anon_ns_root(m))
>  			return;
>  	}
>  
>  	scoped_guard(namespace_lock, &namespace_sem) {
> -		ns = m->mnt_ns;
> -		if (!must_dissolve(ns))
> -			return;
> -
> -		/*
> -		 * After must_dissolve() we know that this is a detached
> -		 * mount in an anonymous mount namespace.
> -		 *
> -		 * Now when mnt_has_parent() reports that this mount
> -		 * tree has a parent, we know that this anonymous mount
> -		 * tree has been moved to another anonymous mount
> -		 * namespace.
> -		 *
> -		 * So when closing this file we cannot unmount the mount
> -		 * tree. This will be done when the file referring to
> -		 * the root of the anonymous mount namespace will be
> -		 * closed (It could already be closed but it would sync
> -		 * on @namespace_sem and wait for us to finish.).
> -		 */
> -		if (mnt_has_parent(m))
> +		if (!anon_ns_root(m))
>  			return;
>  
> +		ns = m->mnt_ns;
>  		lock_mount_hash();
>  		umount_tree(m, UMOUNT_CONNECTED);
>  		unlock_mount_hash();
> -- 
> 2.39.5
> 

