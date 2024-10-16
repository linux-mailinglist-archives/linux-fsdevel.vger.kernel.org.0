Return-Path: <linux-fsdevel+bounces-32118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCCE9A0C89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 16:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6121C212D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D6C20C011;
	Wed, 16 Oct 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSZUiYyT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8803D502BE;
	Wed, 16 Oct 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088587; cv=none; b=D3Jc98cSqFuqLI44TiW0uLczwHPvwA/1Cc0nzxezf7P8OO3qOo7BrMvMinBNbYoYVgOc04t+yBpM1PWgF6aSocVi3Sjs5N3YfRxM1kmKnFYLBPzmMONEKMyw/EWRRilEo1JIwbak34BC6wjeEBjMf5C7vCiHXns7d7slpXM9nGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088587; c=relaxed/simple;
	bh=jD6ZYgj249WXE3YgGo+kGl7esi6CCSX0C5qgagYAYIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hV8x5xkPXHfxbr1mLs/gJ0DM+V66GgVPCjy0AOE1ZAI/fiykx8MbPr89SRugMUECVEJCYjr/ouj0VvWWFrJJdhONOt+Au7aTRhoiYGC7Y9gHTWnQD3WDAptHtN3OIb6SssdTXGxPraF7idjN0M5yq69J9tiHHReLWnrD13yYnCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSZUiYyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EE4C4CEC7;
	Wed, 16 Oct 2024 14:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729088587;
	bh=jD6ZYgj249WXE3YgGo+kGl7esi6CCSX0C5qgagYAYIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gSZUiYyTGbnxwEtnXpQe7swluYTRtTMbhW0Zo9YwBJuSp/DaIhpNLAdDnxcDAltWI
	 Ighd5wfWR+JZAu5k+bSd+q9HiFRNIhJbbLjt5QqEfM4e3i3S29WpLUL3pf6TmzojCd
	 zaeDtDtcuKzewuvWJ1cJvDK9Id0M0JbsHlTwZ21cF9wEFvwAj0nebZR6CtCDxbTH57
	 9v4/gu1I8tWE71TcxHwad0OuFHrD3oCti7JZ928lDsIy3rPmCfHsWHnym3Jx3QrUVl
	 obej86Qtl1vQ97Qd55tqiWmpjwDQqJe6JFx/uwE18Jy7blZSq5htHsulKc9IPoHDTd
	 KIg2+5Ycqyzqw==
Date: Wed, 16 Oct 2024 16:23:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241016-mitdenken-bankdaten-afb403982468@brauner>
References: <20241010152649.849254-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010152649.849254-1-mic@digikod.net>

On Thu, Oct 10, 2024 at 05:26:41PM +0200, Mickaël Salaün wrote:
> When a filesystem manages its own inode numbers, like NFS's fileid shown
> to user space with getattr(), other part of the kernel may still expose
> the private inode->ino through kernel logs and audit.
> 
> Another issue is on 32-bit architectures, on which ino_t is 32 bits,
> whereas the user space's view of an inode number can still be 64 bits.
> 
> Add a new inode_get_ino() helper calling the new struct
> inode_operations' get_ino() when set, to get the user space's view of an
> inode number.  inode_get_ino() is called by generic_fillattr().
> 
> Implement get_ino() for NFS.
> 
> Cc: Trond Myklebust <trondmy@kernel.org>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> I'm not sure about nfs_namespace_getattr(), please review carefully.
> 
> I guess there are other filesystems exposing inode numbers different
> than inode->i_ino, and they should be patched too.

What are the other filesystems that are presumably affected by this that
would need an inode accessor?

If this is just about NFS then just add a helper function that audit and
whatever can call if they need to know the real inode number without
forcing a new get_inode() method onto struct inode_operations.

I'm against adding a new inode_operations method unless we really have
to because it means that we grow a nasty interface that filesystem can
start using and we absolutely don't want them to.

And I don't buy that is suddenly rush hour for this. Seemingly no one
noticed this in the past idk how many years.

> ---
>  fs/nfs/inode.c     | 6 ++++--
>  fs/nfs/internal.h  | 1 +
>  fs/nfs/namespace.c | 2 ++
>  fs/stat.c          | 2 +-
>  include/linux/fs.h | 9 +++++++++
>  5 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 542c7d97b235..5dfc176b6d92 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -83,18 +83,19 @@ EXPORT_SYMBOL_GPL(nfs_wait_bit_killable);
>  
>  /**
>   * nfs_compat_user_ino64 - returns the user-visible inode number
> - * @fileid: 64-bit fileid
> + * @inode: inode pointer
>   *
>   * This function returns a 32-bit inode number if the boot parameter
>   * nfs.enable_ino64 is zero.
>   */
> -u64 nfs_compat_user_ino64(u64 fileid)
> +u64 nfs_compat_user_ino64(const struct *inode)
>  {
>  #ifdef CONFIG_COMPAT
>  	compat_ulong_t ino;
>  #else	
>  	unsigned long ino;
>  #endif
> +	u64 fileid = NFS_FILEID(inode);
>  
>  	if (enable_ino64)
>  		return fileid;
> @@ -103,6 +104,7 @@ u64 nfs_compat_user_ino64(u64 fileid)
>  		ino ^= fileid >> (sizeof(fileid)-sizeof(ino)) * 8;
>  	return ino;
>  }
> +EXPORT_SYMBOL_GPL(nfs_compat_user_ino64);
>  
>  int nfs_drop_inode(struct inode *inode)
>  {
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 430733e3eff2..f5555a71a733 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -451,6 +451,7 @@ extern void nfs_zap_acl_cache(struct inode *inode);
>  extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
>  extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
>  extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
> +extern u64 nfs_compat_user_ino64(const struct *inode);
>  
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  /* localio.c */
> diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> index e7494cdd957e..d9b1e0606833 100644
> --- a/fs/nfs/namespace.c
> +++ b/fs/nfs/namespace.c
> @@ -232,11 +232,13 @@ nfs_namespace_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  const struct inode_operations nfs_mountpoint_inode_operations = {
>  	.getattr	= nfs_getattr,
>  	.setattr	= nfs_setattr,
> +	.get_ino	= nfs_compat_user_ino64,
>  };
>  
>  const struct inode_operations nfs_referral_inode_operations = {
>  	.getattr	= nfs_namespace_getattr,
>  	.setattr	= nfs_namespace_setattr,
> +	.get_ino	= nfs_compat_user_ino64,
>  };
>  
>  static void nfs_expire_automounts(struct work_struct *work)
> diff --git a/fs/stat.c b/fs/stat.c
> index 41e598376d7e..05636919f94b 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -50,7 +50,7 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
>  	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
>  
>  	stat->dev = inode->i_sb->s_dev;
> -	stat->ino = inode->i_ino;
> +	stat->ino = inode_get_ino(inode);
>  	stat->mode = inode->i_mode;
>  	stat->nlink = inode->i_nlink;
>  	stat->uid = vfsuid_into_kuid(vfsuid);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e3c603d01337..0eba09a21cf7 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2165,6 +2165,7 @@ struct inode_operations {
>  			    struct dentry *dentry, struct fileattr *fa);
>  	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
>  	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
> +	u64 (*get_ino)(const struct inode *inode);
>  } ____cacheline_aligned;
>  
>  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> @@ -2172,6 +2173,14 @@ static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
>  	return file->f_op->mmap(file, vma);
>  }
>  
> +static inline u64 inode_get_ino(struct inode *inode)
> +{
> +	if (unlikely(inode->i_op->get_ino))
> +		return inode->i_op->get_ino(inode);
> +
> +	return inode->i_ino;
> +}
> +
>  extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
>  extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
>  extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
> -- 
> 2.46.1
> 

