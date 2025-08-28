Return-Path: <linux-fsdevel+bounces-59471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF69B397C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 11:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D28D1C80309
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D4D2DEA7B;
	Thu, 28 Aug 2025 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgwBDpgN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B3D1F4CAF;
	Thu, 28 Aug 2025 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371636; cv=none; b=tmKX3w8l8IbI8tfTqcHsqWuJLFG7/s/ntLHUxMPQl2v+H9eFcOt+gUyYc/4TCU+5Q9R3836oV5Ow5Zne0QG544XF4YwFYXvV2+ll1GAYQJkROXK4efbabXVj/bSePp6Q5YB9jtVj+oJjdFHMm3otesAewtNvgSdawo0XPCM4hWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371636; c=relaxed/simple;
	bh=aZU+O1QhNhNZNy5evwzSIDXT12+t3PtexQ5lHoMyOBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iv0MyAMIc1K0WdSwtuFBQ16v6WIdD6KOCpIkHfJTh2FDCctfaKui6EPpP30umnQeB47v34p1xfrd4CfvDidhcjqRg4zbEIoA3qBgSZhO24v12Av4vo+TgpJazArq1W71C+u2D50gPdwZ+tiL2I4c3jpKsEsWvJ8JGrdbvmJ9yiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgwBDpgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42FDC4CEEB;
	Thu, 28 Aug 2025 09:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756371635;
	bh=aZU+O1QhNhNZNy5evwzSIDXT12+t3PtexQ5lHoMyOBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgwBDpgN6xYqCx+/drcirAnhaQSj0q0MFROKBjy2C7xglkkL+CwxDTKl+VbKPX9p8
	 na0GzKaR+zARaNUjprGTILPJIvztsQ66ESeHWG63JjRBVT8HRthjoVQfsmouEbMwLm
	 EPeHdCpb3MozjNfvzfheb2Hsd0jlX+YFgo1+5ohUTpGp+Uq8g7GFzcq63FZljcmgnh
	 RUXhlLH+Uw7DPwLhas3rVZjq57OhfeoQj7ZDrZSvlJdUQwwA4uBZX2rmwqnxWwGrSV
	 x+TtUCxtKJpFOLbE5e9pJTLElxDiSfe4AazNqVYe/UtKvwLMYe0FrP/OvygsktYtbE
	 NKKVj7JzPX6rg==
Date: Thu, 28 Aug 2025 11:00:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 17/54] fs: remove the inode from the LRU list on
 unlink/rmdir
Message-ID: <20250828-perfekt-juckreiz-1f018973edf1@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <3552943716349efa4ff107bb590ac6b980183735.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3552943716349efa4ff107bb590ac6b980183735.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:17AM -0400, Josef Bacik wrote:
> We can end up with an inode on the LRU list or the cached list, then at
> some point in the future go to unlink that inode and then still have an
> elevated i_count reference for that inode because it is on one of these
> lists.
> 
> The more common case is the cached list. We open a file, write to it,
> truncate some of it which triggers the inode_add_lru code in the
> pagecache, adding it to the cached LRU.  Then we unlink this inode, and
> it exists until writeback or reclaim kicks in and removes the inode.
> 
> To handle this case, delete the inode from the LRU list when it is
> unlinked, so we have the best case scenario for immediately freeing the
> inode.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/namei.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 138a693c2346..e56dcb5747e4 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4438,6 +4438,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
>  int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
>  		     struct dentry *dentry)
>  {
> +	struct inode *inode = dentry->d_inode;
>  	int error = may_delete(idmap, dir, dentry, 1);
>  
>  	if (error)
> @@ -4447,11 +4448,11 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
>  		return -EPERM;
>  
>  	dget(dentry);
> -	inode_lock(dentry->d_inode);
> +	inode_lock(inode);
>  
>  	error = -EBUSY;
>  	if (is_local_mountpoint(dentry) ||
> -	    (dentry->d_inode->i_flags & S_KERNEL_FILE))
> +	    (inode->i_flags & S_KERNEL_FILE))
>  		goto out;
>  
>  	error = security_inode_rmdir(dir, dentry);
> @@ -4463,12 +4464,21 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
>  		goto out;
>  
>  	shrink_dcache_parent(dentry);
> -	dentry->d_inode->i_flags |= S_DEAD;
> +	inode->i_flags |= S_DEAD;
>  	dont_mount(dentry);
>  	detach_mounts(dentry);
>  
>  out:
> -	inode_unlock(dentry->d_inode);
> +	/*
> +	 * The inode may be on the LRU list, so delete it from the LRU at this
> +	 * point in order to make sure that the inode is freed as soon as
> +	 * possible.
> +	 */
> +	spin_lock(&inode->i_lock);
> +	inode_lru_list_del(inode);
> +	spin_unlock(&inode->i_lock);

I think it should be possible to optimize this with an appropriate
helper doing:

static inline bool inode_on_lru(const struct inode *inode)
{
	return !!(READ_ONCE(inode->i_state) & (I_LRU | I_CACHED_LRU));
}

then

if (inode_on_lru(inode)) {
	spin_lock(&inode->i_lock);
	inode_lru_list_del(inode);
	spin_unlock(&inode->i_lock);
}

so you don't needlessly acquire i_lock.

