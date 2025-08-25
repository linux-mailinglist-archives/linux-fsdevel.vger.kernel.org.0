Return-Path: <linux-fsdevel+bounces-59056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84CAB3405D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8906517B7A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10395202C43;
	Mon, 25 Aug 2025 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJRbb47h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3A155322
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127311; cv=none; b=d/lWkLt/cIwszrWdOIu9o19ZEsBWjgQ1pO78uYZEOQuNKMdgkVO8SSm9pMNUNAtlh3aYzUzgoEZAYzRCsMEhtiB1pPwsfbGv0aME6qFsoeBtWmlfwBV8HNOCMjiilGcTG0r1b9bXmPtapqNfiqGua+pdn1p/F1DvjoccDXS0rUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127311; c=relaxed/simple;
	bh=qWZyqewf5jZ2vHX1k6ueAtJjOOLybh1sK4HqZo0mNpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqxGk4tKOekmjBauHLMQWnoNsPU5Pmgs8LpqMGBwIamijZTVyM2bGKaYv7lJnISlrzwsTBw62zro7F1QQCFjPQ2JdNjs9rKjiigPOLDmzpKWlJ6QfUasSHha6A4jbSi/9vPr/obzOk4LaJUeHeWA92Rg3UNaAc/ZWhA8uqQeLIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJRbb47h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89A7C4CEED;
	Mon, 25 Aug 2025 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756127311;
	bh=qWZyqewf5jZ2vHX1k6ueAtJjOOLybh1sK4HqZo0mNpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJRbb47hqPKNZ6iE2YTwFdgOM0l8dHadju5TBbcD5WdgVbxK+3x67Jfhtbb5QgS4l
	 fcu35L6Q0OEgRfvWWmq/p9AKKgVGWLkToi+a+hU8RovzTFd4WKv5MfCAB25VFuSV97
	 O4w2UUaLfdyQW1/1P14eztp3qYMSMYE4FaobhKA4wa6Lr/I89C1mTKtGtlqJjDvy8K
	 Ri12bpAfuppQVADYoEDqKrxW0f+WkMVz3kIxB33wcMZsgcFlK40tOhLAj+8oB6bQcN
	 qw/o/daoEaALmrqX8URLiqeishtyVvO5Y9eVDH7Tj8w+FHKOw+o6ZNoiZwaFUnTPJq
	 dx/77mlncOE/A==
Date: Mon, 25 Aug 2025 15:08:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 24/52] finish_automount(): take the lock_mount() analogue
 into a helper
Message-ID: <20250825-kredit-gastprofessor-6eaf5f80d179@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-24-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-24-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:27AM +0100, Al Viro wrote:
> finish_automount() can't use lock_mount() - it treats finding something
> already mounted as "quitely drop our mount and return 0", not as
> "mount on top of whatever mounted there".  It's been open-coded;
> let's take it into a helper similar to lock_mount().  "something's
> already mounted" => -EBUSY, finish_automount() needs to distinguish
> it from the normal case and it can't happen in other failure cases.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/namespace.c | 42 +++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 892251663419..99757040a39a 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3786,9 +3786,29 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
>  	return err;
>  }
>  
> -int finish_automount(struct vfsmount *m, const struct path *path)
> +static int lock_mount_exact(const struct path *path,
> +			    struct pinned_mountpoint *mp)
>  {
>  	struct dentry *dentry = path->dentry;
> +	int err;
> +
> +	inode_lock(dentry->d_inode);
> +	namespace_lock();
> +	if (unlikely(cant_mount(dentry)))
> +		err = -ENOENT;
> +	else if (path_overmounted(path))
> +		err = -EBUSY;
> +	else
> +		err = get_mountpoint(dentry, mp);
> +	if (unlikely(err)) {
> +		namespace_unlock();
> +		inode_unlock(dentry->d_inode);
> +	}
> +	return err;
> +}
> +
> +int finish_automount(struct vfsmount *m, const struct path *path)
> +{
>  	struct pinned_mountpoint mp = {};
>  	struct mount *mnt;
>  	int err;
> @@ -3810,20 +3830,11 @@ int finish_automount(struct vfsmount *m, const struct path *path)
>  	 * that overmounts our mountpoint to be means "quitely drop what we've
>  	 * got", not "try to mount it on top".
>  	 */
> -	inode_lock(dentry->d_inode);
> -	namespace_lock();
> -	if (unlikely(cant_mount(dentry))) {
> -		err = -ENOENT;
> -		goto discard_locked;
> -	}
> -	if (path_overmounted(path)) {
> -		err = 0;
> -		goto discard_locked;
> +	err = lock_mount_exact(path, &mp);
> +	if (unlikely(err)) {
> +		mntput(m);
> +		return err == -EBUSY ? 0 : err;
>  	}
> -	err = get_mountpoint(dentry, &mp);
> -	if (err)
> -		goto discard_locked;
> -
>  	err = do_add_mount(mnt, mp.mp, path,
>  			   path->mnt->mnt_flags | MNT_SHRINKABLE);
>  	unlock_mount(&mp);
> @@ -3831,9 +3842,6 @@ int finish_automount(struct vfsmount *m, const struct path *path)
>  		goto discard;
>  	return 0;
>  
> -discard_locked:
> -	namespace_unlock();
> -	inode_unlock(dentry->d_inode);
>  discard:
>  	mntput(m);

Can use direct returns if you do:

        struct mount *mnt __free(mntput) = NULL;

and then in the success condition:

        retain_and_null_ptr(mnt);

