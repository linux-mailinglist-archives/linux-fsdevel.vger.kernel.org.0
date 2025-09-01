Return-Path: <linux-fsdevel+bounces-59813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5FCB3E1E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD1017A078B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1237B31579D;
	Mon,  1 Sep 2025 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKLBGjU6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAE530EF7D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727010; cv=none; b=OOBYJWuezbP3B4HjJ9BJ2ebk7VR7aIlPtfy3I0jQShNifsycuCoA4ykuk3JylxCRWOatD5a/0F2FdBriwEjFUlm02ktJnY8E7JSrdt2CiUCcS1dZpO4C9IMBVMe9WxrOFzLS6l4yjT/XTSWUvNQCJsZ4gESABfaLOjMSgiVvpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727010; c=relaxed/simple;
	bh=penJ5ypL3XQIbM2WqIPCxxvwyDhLYL+rBpLwELnhnU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLpguTReQhKduz/wuT6rZyBKaIdNVkW36J1e8hI/EuKHVL18zvpv9nBjrGa2pmQjGpLmyn2VF+nXpkXq/9Mn3D8a5ZY0JmYPAhwM8I9OIEG8CHVuZ5/nujhoMurM2LXwerRbmVBJ7A99O4sdIo0MZ1m92bl5qJ8ao3NZZDpQF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKLBGjU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04FBC4CEF0;
	Mon,  1 Sep 2025 11:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756727010;
	bh=penJ5ypL3XQIbM2WqIPCxxvwyDhLYL+rBpLwELnhnU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKLBGjU6AK0ZudzeEiIKK7DVEWUPtLqflK9hD0ijfxNoBC/XnchJWQ4jq07SVnb2U
	 A3SvVTM9JC/ZfzuXVY1Kka3M1Lj1uy+rcBzavGjCHKLKsKfC26g2UR1zx6kLXi+OHC
	 xICxiGPLjYOKQt6AcSTjOzBvYcimf6m7PvcZcYRCWisSc0F7Eb4Xkafw3ElJJGt+eJ
	 ma89mdR4K5n0duKILIDF8245Vz2JiYqDbwLjLrecvXt63YeqBUvPQzbPlKCtx5Bo8g
	 vIcrZ6cYcOLJ2Ol+4zxtv8UGUl1+9Odm9yFr6dolQe7unTD0eoJ+t+v7l8TCoWIUP+
	 iOHI+BlGQflmw==
Date: Mon, 1 Sep 2025 13:43:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 58/63] copy_mnt_ns(): use guards
Message-ID: <20250901-muskel-vorhof-b45c8fd9a70f@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-58-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-58-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:08:01AM +0100, Al Viro wrote:
> * mntput() of rootmnt and pwdmnt done via __free(mntput)
> * mnt_ns_tree_add() can be done within namespace_excl scope.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namespace.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a418555586ef..9e16231d4561 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4164,7 +4164,8 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
>  		struct user_namespace *user_ns, struct fs_struct *new_fs)
>  {
>  	struct mnt_namespace *new_ns;
> -	struct vfsmount *rootmnt = NULL, *pwdmnt = NULL;
> +	struct vfsmount *rootmnt __free(mntput) = NULL;
> +	struct vfsmount *pwdmnt __free(mntput) = NULL;
>  	struct mount *p, *q;
>  	struct mount *old;
>  	struct mount *new;
> @@ -4183,7 +4184,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
>  	if (IS_ERR(new_ns))
>  		return new_ns;
>  
> -	namespace_lock();
> +	guard(namespace_excl)();
>  	/* First pass: copy the tree topology */
>  	copy_flags = CL_COPY_UNBINDABLE | CL_EXPIRE;
>  	if (user_ns != ns->user_ns)
> @@ -4191,13 +4192,11 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
>  	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
>  	if (IS_ERR(new)) {
>  		emptied_ns = new_ns;
> -		namespace_unlock();
>  		return ERR_CAST(new);
>  	}
>  	if (user_ns != ns->user_ns) {
> -		lock_mount_hash();
> +		guard(mount_writer)();
>  		lock_mnt_tree(new);
> -		unlock_mount_hash();
>  	}
>  	new_ns->root = new;
>  
> @@ -4229,14 +4228,6 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
>  		while (p->mnt.mnt_root != q->mnt.mnt_root)
>  			p = next_mnt(skip_mnt_tree(p), old);
>  	}
> -	namespace_unlock();
> -
> -	if (rootmnt)
> -		mntput(rootmnt);
> -	if (pwdmnt)
> -		mntput(pwdmnt);
> -
> -	mnt_ns_tree_add(new_ns);

The commit message states that "mnt_ns_tree_add() can be done within
namespace_excl scope" suggesting that all this does is to widen the
scope of the lock. But this change also removes the call to
mnt_ns_tree_add() completely? Intentional?

