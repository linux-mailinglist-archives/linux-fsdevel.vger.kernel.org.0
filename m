Return-Path: <linux-fsdevel+bounces-47581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A773AA0957
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC9716EA3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CB62C17B3;
	Tue, 29 Apr 2025 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roJuHU4s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544A29DB7C;
	Tue, 29 Apr 2025 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745925153; cv=none; b=bPpMMXnnolC6yDLeSDH6/Ch6GW6xSgnRC9WJTKrWGHQV52hyIkaKF6rlLYRDfOK+CX911yfYshO67bF/bF+NNN2xsHOnOLQcjfHzie96N0dYkZjbd2NCoK0mHF+T8rhuWl5tU3yk1k14tNh207b904cstmdOPV2pvOGUs7mOlZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745925153; c=relaxed/simple;
	bh=uaULU5kgeaUIvua+1n0mtSupRh+meJGEjwM6E8o+dHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPee0Z2wTb7P5B6R9If8wZJrHGGYrXNNBeidA/PKMlg+KpEAW4zzPcpilK4b56q7TfCcOYcgFvEPQSmYINrAwXu+RHHZKHwxSbj5Vkfx3fwoCwVEx/L2I/SXOeDu7b2HDmvzIoZl27kO9tRvbq1KXA62a17EhdgbFylzYHps9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roJuHU4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522A7C4CEE3;
	Tue, 29 Apr 2025 11:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745925152;
	bh=uaULU5kgeaUIvua+1n0mtSupRh+meJGEjwM6E8o+dHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roJuHU4s0E23I1Ige3FfhYUpiA6RRl5nZu7teFQDvJIcMyrzh2jyzuQ8I3x7o1dcJ
	 mLPN+jY35FXOvssu6FZi1XOyE1L8erS+CrZpxGowUy6EOPwQIUM7WYyvz3w5+GdHyM
	 +eCgVEHEV53X1s6CLLyFJRBjY3SmOSMk4L33obTEapW9GFhpewLdgshrTGBB8JdnZZ
	 RApWtCUwa1CfOdZkykBG3FY29pghDpfozK0kBawH9XDQuIgdCenMdlwR6qvn7d4m4n
	 hn5wVt73E/dIyuO4bHaE8Ijh0T1ZUtCxPLswYHP2P6cJiOKVV8wZF4fJseNeLybSbx
	 s7iiAK7DBUX+Q==
Date: Tue, 29 Apr 2025 13:12:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: make several inode lock operations killable
Message-ID: <20250429-anpassen-exkremente-98686d53a021@brauner>
References: <20250429094644.3501450-1-max.kellermann@ionos.com>
 <20250429094644.3501450-2-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250429094644.3501450-2-max.kellermann@ionos.com>

On Tue, Apr 29, 2025 at 11:46:44AM +0200, Max Kellermann wrote:
> Allows killing processes that are waiting for the inode lock.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---

Oha, that's interesting.

>  fs/open.c       | 14 +++++++++++---
>  fs/read_write.c |  4 +++-
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index a9063cca9911..7828234a7caa 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -60,7 +60,10 @@ int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (ret)
>  		newattrs.ia_valid |= ret | ATTR_FORCE;
>  
> -	inode_lock(dentry->d_inode);
> +	ret = inode_lock_killable(dentry->d_inode);
> +	if (ret)
> +		return ret;
> +
>  	/* Note any delegations or leases have already been broken: */
>  	ret = notify_change(idmap, dentry, &newattrs, NULL);
>  	inode_unlock(dentry->d_inode);
> @@ -635,7 +638,9 @@ int chmod_common(const struct path *path, umode_t mode)
>  	if (error)
>  		return error;
>  retry_deleg:
> -	inode_lock(inode);
> +	error = inode_lock_killable(inode);

That's probably fine.

> +	if (error)
> +		goto out_mnt_unlock;
>  	error = security_path_chmod(path, mode);
>  	if (error)
>  		goto out_unlock;
> @@ -650,6 +655,7 @@ int chmod_common(const struct path *path, umode_t mode)
>  		if (!error)
>  			goto retry_deleg;
>  	}
> +out_mnt_unlock:
>  	mnt_drop_write(path->mnt);
>  	return error;
>  }
> @@ -769,7 +775,9 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
>  		return -EINVAL;
>  	if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
>  		return -EINVAL;
> -	inode_lock(inode);
> +	error = inode_lock_killable(inode);
> +	if (error)
> +		return error;

That too.

>  	if (!S_ISDIR(inode->i_mode))
>  		newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
>  				     setattr_should_drop_sgid(idmap, inode);
> diff --git a/fs/read_write.c b/fs/read_write.c
> index bb0ed26a0b3a..0ef70e128c4a 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -332,7 +332,9 @@ loff_t default_llseek(struct file *file, loff_t offset, int whence)
>  	struct inode *inode = file_inode(file);
>  	loff_t retval;
>  
> -	inode_lock(inode);
> +	retval = inode_lock_killable(inode);

That change doesn't seem so obviously fine to me.
Either way I'd like to see this split in three patches and some
reasoning why it's safe and some justification why it's wanted...

