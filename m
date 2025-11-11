Return-Path: <linux-fsdevel+bounces-67877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEF7C4CBEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3561421216
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D2B2F25E8;
	Tue, 11 Nov 2025 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZeVhdar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899D221FBF;
	Tue, 11 Nov 2025 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854109; cv=none; b=s1AlsWTpMqURJGusW0lpbAM2NUj2WDh4Ngm5l82CBmo7Q1k66T7XY0iyUslBXqiObOuRbwrhV3h0qjV/YdcPASjt0gKaQIowamocO7ZJGbHoeiqBBKljnsMQWoWqthnuHs/zjzt2l3NVUA9UAT/oP+x8ys5YYieb3tGKEm42ygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854109; c=relaxed/simple;
	bh=7DpE6qKW9E6c42R3IuWwahjcCFXSEvnxEjECGK/4fd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEjnSQxe1R4FOUrfA7Wmu6jEK3u8/DJltP2EZTHcWzIs7LLXgGdzzUk0tYlcMkzpBsVNdo8aOdANtq1RTz9L5bWryEiK4fQLvDbvhGmHOjBPr4SvcwnVM/lYXRVomvJkdY4PBhfo7h6iL5o+GFsF/WYrumHs7RFd+MEAPoIyrks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZeVhdar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E17C4CEF7;
	Tue, 11 Nov 2025 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762854108;
	bh=7DpE6qKW9E6c42R3IuWwahjcCFXSEvnxEjECGK/4fd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZeVhdarN9bqSwL1AQKA2SxtMNT3RbOaJNz0UdZJkBs38HIj77DkVg1avscRInai0
	 qSsAsXFUYLTd+YYgJHnkyggMllirq9slpWdsNuo+BQ7yMcV+nEPKGvh1VunYN9GjQL
	 zR+DfFB/8wNBn6zRp56NJ7i+l3PR/4eJBiPBPLo7tO5lY9uAIk20E6ZsMRxzUyFoal
	 FMDuvtd6/ZIx7NVZNWRWhUnmD2mAqYsbeFnV+IfRWxMYqQPdJlWkRFPh0Nk48HqdT+
	 LHhxoDsqlrXnndliY5ZIiV51xB0sMnnAgZYW5qfAIU+hfOVN12nFGGr2GwMkMU/Yez
	 BW2v8Zk6NuHKg==
Date: Tue, 11 Nov 2025 10:41:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	torvalds@linux-foundation.org, josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] fs: speed up path lookup with cheaper handling of
 MAY_EXEC
Message-ID: <20251111-zeitablauf-plagen-8b0406abbdc6@brauner>
References: <20251107142149.989998-1-mjguzik@gmail.com>
 <20251107142149.989998-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251107142149.989998-2-mjguzik@gmail.com>

On Fri, Nov 07, 2025 at 03:21:47PM +0100, Mateusz Guzik wrote:
> The generic inode_permission() routine does work which is known to be of
> no significance for lookup. There are checks for MAY_WRITE, while the
> requested permission is MAY_EXEC. Additionally devcgroup_inode_permission()
> is called to check for devices, but it is an invariant the inode is a
> directory.
> 
> Absent a ->permission func, execution lands in generic_permission()
> which checks upfront if the requested permission is granted for
> everyone.
> 
> We can elide the branches which are guaranteed to be false and cut
> straight to the check if everyone happens to be allowed MAY_EXEC on the
> inode (which holds true most of the time).
> 
> Moreover, filesystems which provide their own ->permission routine can
> take advantage of the optimization by setting the IOP_FASTPERM_MAY_EXEC
> flag on their inodes, which they can legitimately do if their MAY_EXEC
> handling matches generic_permission().
> 
> As a simple benchmark, as part of compilation gcc issues access(2) on
> numerous long paths, for example /usr/lib/gcc/x86_64-linux-gnu/12/crtendS.o
> 
> Issuing access(2) on it in a loop on ext4 on Sapphire Rapids (ops/s):
> before: 3797556
> after:  3987789 (+5%)
> 
> Note: this depends on the not-yet-landed ext4 patch to mark inodes with
> cache_no_acl()
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/namei.c         | 43 +++++++++++++++++++++++++++++++++++++++++--
>  include/linux/fs.h | 13 +++++++------
>  2 files changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index a9f9d0453425..6b2a5a5478e7 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -540,6 +540,9 @@ static inline int do_inode_permission(struct mnt_idmap *idmap,
>   * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
>   *
>   * Separate out file-system wide checks from inode-specific permission checks.
> + *
> + * Note: lookup_inode_permission_may_exec() does not call here. If you add
> + * MAY_EXEC checks, adjust it.
>   */
>  static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
>  {
> @@ -602,6 +605,42 @@ int inode_permission(struct mnt_idmap *idmap,
>  }
>  EXPORT_SYMBOL(inode_permission);
>  
> +/**
> + * lookup_inode_permission_may_exec - Check traversal right for given inode
> + *
> + * This is a special case routine for may_lookup() making assumptions specific
> + * to path traversal. Use inode_permission() if you are doing something else.
> + *
> + * Work is shaved off compared to inode_permission() as follows:
> + * - we know for a fact there is no MAY_WRITE to worry about
> + * - it is an invariant the inode is a directory
> + *
> + * Since majority of real-world traversal happens on inodes which grant it for
> + * everyone, we check it upfront and only resort to more expensive work if it
> + * fails.
> + *
> + * Filesystems which have their own ->permission hook and consequently miss out
> + * on IOP_FASTPERM can still get the optimization if they set IOP_FASTPERM_MAY_EXEC
> + * on their directory inodes.
> + */
> +static __always_inline int lookup_inode_permission_may_exec(struct mnt_idmap *idmap,
> +	struct inode *inode, int mask)
> +{
> +	/* Lookup already checked this to return -ENOTDIR */
> +	VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode), inode);
> +	VFS_BUG_ON((mask & ~MAY_NOT_BLOCK) != 0);
> +
> +	mask |= MAY_EXEC;
> +
> +	if (unlikely(!(inode->i_opflags & (IOP_FASTPERM | IOP_FASTPERM_MAY_EXEC))))
> +		return inode_permission(idmap, inode, mask);
> +
> +	if (unlikely(((inode->i_mode & 0111) != 0111) || !no_acl_inode(inode)))

Can you send a follow-up where 0111 is a constant with some descriptive
name, please? Can be local to the file. I hate these raw-coded
permission masks with a passion.

> +		return inode_permission(idmap, inode, mask);
> +
> +	return security_inode_permission(inode, mask);
> +}
> +
>  /**
>   * path_get - get a reference to a path
>   * @path: path to get the reference to
> @@ -1855,7 +1894,7 @@ static inline int may_lookup(struct mnt_idmap *idmap,
>  	int err, mask;
>  
>  	mask = nd->flags & LOOKUP_RCU ? MAY_NOT_BLOCK : 0;
> -	err = inode_permission(idmap, nd->inode, mask | MAY_EXEC);
> +	err = lookup_inode_permission_may_exec(idmap, nd->inode, mask);
>  	if (likely(!err))
>  		return 0;
>  
> @@ -1870,7 +1909,7 @@ static inline int may_lookup(struct mnt_idmap *idmap,
>  	if (err != -ECHILD)	// hard error
>  		return err;
>  
> -	return inode_permission(idmap, nd->inode, MAY_EXEC);
> +	return lookup_inode_permission_may_exec(idmap, nd->inode, 0);
>  }
>  
>  static int reserve_stack(struct nameidata *nd, struct path *link)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 03e450dd5211..7d5de647ac7b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -647,13 +647,14 @@ is_uncached_acl(struct posix_acl *acl)
>  	return (long)acl & 1;
>  }
>  
> -#define IOP_FASTPERM	0x0001
> -#define IOP_LOOKUP	0x0002
> -#define IOP_NOFOLLOW	0x0004
> -#define IOP_XATTR	0x0008
> +#define IOP_FASTPERM		0x0001
> +#define IOP_LOOKUP		0x0002
> +#define IOP_NOFOLLOW		0x0004
> +#define IOP_XATTR		0x0008
>  #define IOP_DEFAULT_READLINK	0x0010
> -#define IOP_MGTIME	0x0020
> -#define IOP_CACHED_LINK	0x0040
> +#define IOP_MGTIME		0x0020
> +#define IOP_CACHED_LINK		0x0040
> +#define IOP_FASTPERM_MAY_EXEC	0x0080
>  
>  /*
>   * Inode state bits.  Protected by inode->i_lock
> -- 
> 2.48.1
> 

