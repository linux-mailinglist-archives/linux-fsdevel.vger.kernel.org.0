Return-Path: <linux-fsdevel+bounces-42647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D71A4582D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8375F7A5F68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF81E1E07;
	Wed, 26 Feb 2025 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3YdqG8l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0D27702
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558560; cv=none; b=YFnLaWuXdPMYJz+0uMQ59fa+vtRdNshB2cH5zy/RPnDZFA2ghw9X/E2PsuwdILdKaTQHPT9B469VxYUTXea1ZXJGvGEwym1v7fZWyLMbJcm1jq5VHFWb2WfLIdBOX+8yF9TLzKGVh30pCbRC/gjb8GOzNmfH+UTCj7f6l5ol4TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558560; c=relaxed/simple;
	bh=hc3pqr+wKgaZUzQqJge3cSl60Wr06iYnsEybU3sBeKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFVSCZG75wbQwPbT7axF8vZWWq84Jr5PDZTN5pS3eJ4JfpC1bCiDsQcwxxb5JDbrDM0ZPTjMYhfmATCMoHB4Crr85Nt5ged0M4rrbTZ5DoL+eU2G/TBNU2I+zoJn65G+AxkRLzlWaoQBB1kn6zBbpcuVl2hdI19tAZqYS2fjoeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3YdqG8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D9FC4CED6;
	Wed, 26 Feb 2025 08:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740558559;
	bh=hc3pqr+wKgaZUzQqJge3cSl60Wr06iYnsEybU3sBeKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N3YdqG8ltmYPOZzOAp7HmmlPlp0f5c52Z19aqKqeOSQQhLOM00rLrxJvp0tca23Yn
	 /8SJo2HGVC/37SIGbTi6wFzk+un3KriaAW37IDEGlIiYqyYDpHKVYNswySjHsrhuwP
	 N5wKyD65/S8qTXtkHdj65eVfZh5Jn3gpwC68hwo/wF9karjpcPR/qvwGqw+Qa2xeaB
	 xp+YlkmCGyHZelbKJAZz+uErUFjRdkiEwe5aBQcmZUm0yduAKf1UetsBsLn+b1OczL
	 h4komqAawRkdq44WxBNYkDMdnwT50GkGBnaCTrVeElka1rLnnKGEkzY6T8e+2hm+nr
	 riUh/ZKA/h7ag==
Date: Wed, 26 Feb 2025 09:29:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 03/21] switch procfs from d_set_d_op() to
 d_splice_alias_ops()
Message-ID: <20250226-umzog-nachrangig-c23e2b75dde4@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-3-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:33PM +0000, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/proc/base.c        | 9 +++------
>  fs/proc/generic.c     | 8 ++++----
>  fs/proc/internal.h    | 3 +--
>  fs/proc/namespaces.c  | 3 +--
>  fs/proc/proc_sysctl.c | 7 +++----
>  5 files changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index cd89e956c322..397a9f6f463e 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2709,8 +2709,7 @@ static struct dentry *proc_pident_instantiate(struct dentry *dentry,
>  		inode->i_fop = p->fop;
>  	ei->op = p->op;
>  	pid_update_inode(task, inode);
> -	d_set_d_op(dentry, &pid_dentry_operations);
> -	return d_splice_alias(inode, dentry);
> +	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
>  }
>  
>  static struct dentry *proc_pident_lookup(struct inode *dir, 
> @@ -3508,8 +3507,7 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
>  	set_nlink(inode, nlink_tgid);
>  	pid_update_inode(task, inode);
>  
> -	d_set_d_op(dentry, &pid_dentry_operations);
> -	return d_splice_alias(inode, dentry);
> +	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
>  }
>  
>  struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
> @@ -3813,8 +3811,7 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
>  	set_nlink(inode, nlink_tid);
>  	pid_update_inode(task, inode);
>  
> -	d_set_d_op(dentry, &pid_dentry_operations);
> -	return d_splice_alias(inode, dentry);
> +	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
>  }
>  
>  static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry, unsigned int flags)
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 499c2bf67488..774e18372914 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -255,10 +255,10 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
>  		if (!inode)
>  			return ERR_PTR(-ENOMEM);
>  		if (de->flags & PROC_ENTRY_FORCE_LOOKUP)
> -			d_set_d_op(dentry, &proc_net_dentry_ops);
> -		else
> -			d_set_d_op(dentry, &proc_misc_dentry_ops);
> -		return d_splice_alias(inode, dentry);
> +			return d_splice_alias_ops(inode, dentry,
> +						  &proc_net_dentry_ops);
> +		return d_splice_alias_ops(inode, dentry,
> +					  &proc_misc_dentry_ops);
>  	}
>  	read_unlock(&proc_subdir_lock);
>  	return ERR_PTR(-ENOENT);
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 07f75c959173..48410381036b 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -358,7 +358,6 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
>  static inline struct dentry *proc_splice_unmountable(struct inode *inode,
>  		struct dentry *dentry, const struct dentry_operations *d_ops)
>  {
> -	d_set_d_op(dentry, d_ops);
>  	dont_mount(dentry);
> -	return d_splice_alias(inode, dentry);
> +	return d_splice_alias_ops(inode, dentry, d_ops);
>  }
> diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
> index c610224faf10..4403a2e20c16 100644
> --- a/fs/proc/namespaces.c
> +++ b/fs/proc/namespaces.c
> @@ -111,8 +111,7 @@ static struct dentry *proc_ns_instantiate(struct dentry *dentry,
>  	ei->ns_ops = ns_ops;
>  	pid_update_inode(task, inode);
>  
> -	d_set_d_op(dentry, &pid_dentry_operations);
> -	return d_splice_alias(inode, dentry);
> +	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
>  }
>  
>  static int proc_ns_dir_readdir(struct file *file, struct dir_context *ctx)
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index cc9d74a06ff0..7a8bffc03dc8 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -540,9 +540,8 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
>  			goto out;
>  	}
>  
> -	d_set_d_op(dentry, &proc_sys_dentry_operations);
>  	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
> -	err = d_splice_alias(inode, dentry);
> +	err = d_splice_alias_ops(inode, dentry, &proc_sys_dentry_operations);
>  
>  out:
>  	if (h)
> @@ -699,9 +698,9 @@ static bool proc_sys_fill_cache(struct file *file,
>  			return false;
>  		if (d_in_lookup(child)) {
>  			struct dentry *res;
> -			d_set_d_op(child, &proc_sys_dentry_operations);
>  			inode = proc_sys_make_inode(dir->d_sb, head, table);
> -			res = d_splice_alias(inode, child);
> +			res = d_splice_alias_ops(inode, child,
> +						 &proc_sys_dentry_operations);
>  			d_lookup_done(child);
>  			if (unlikely(res)) {
>  				dput(child);
> -- 
> 2.39.5
> 

