Return-Path: <linux-fsdevel+bounces-21730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7809094B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 01:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3BF1C20E52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 23:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F39187567;
	Fri, 14 Jun 2024 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/vC4fnw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E761482E8
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2024 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718406950; cv=none; b=sb7KpsEGJ2lJlZv4fDILWJPORL7jQ11PLuqhj22VdYQy4gA+YRsH3swHyd4fBGWsB7Hp+5AyGbzKTht5lL11W6jCtmA7UAdLA3u9f1t8UDfMx8LmbejNQPXctNEQrgy6FN6EIIORs2IaSUuqqAzygNti9LZ2x51I0g+Erm640Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718406950; c=relaxed/simple;
	bh=3Sbc8mvsScJp68/i3vylaWnU+haauLfJ4Ci5DnAfWCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FD/0b6JpclB66tp5eH+n8utJ3r8AJH6ss2dgMlknKQul8MxB+DC3fHwxE41dkFR1IpCg8oq35po3Lv1cNQGjr71FB+IdUTOkx6l0ppi5StQv00ivO38KHB1ZhUABF+sk4P7ZQaT1rlAG1pt+h7Af5hhlSxIchI09wNezAYV5AyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/vC4fnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB35C4AF63;
	Fri, 14 Jun 2024 23:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718406949;
	bh=3Sbc8mvsScJp68/i3vylaWnU+haauLfJ4Ci5DnAfWCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/vC4fnw/gMf82RBgyeMtLw1FCMcruX3S4wR7t6RS7GpZf+b8Nd6do6M4KCvDqDaq
	 if2ED4JAz/FSOcBFPTfaGn0K7Kwwx6qm9Y8t+y1u1A0uBfwH4FTYDQBKrhnocaiapo
	 mcPs5DkW/vd1ffDyI8t1y9oB42UBC/PTkoxmkhPBuSm+uuW3cjVEMTXZ6KT922DMNV
	 6KXwpNvSK3/1qOzJ9JGu3F4NTsJl27zqqh0mVSeSqJiyRqHpn3Dvn6vIW2gha9PqUK
	 Sg1Gdkj4yGpJDgZPBRctvpspWEAmJ3SNS/aSMyiQj3t5bTJfqZXZGm6WPeVHl/WrXi
	 qpFzQDsOFFd6A==
Date: Fri, 14 Jun 2024 16:15:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	"Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 23/25] fs: port fs{g,u}id helpers to mnt_idmap
Message-ID: <20240614231547.GA6102@frogsfrogsfrogs>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
 <20230113-fs-idmapped-mnt_idmap-conversion-v1-23-fc84fa7eba67@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-23-fc84fa7eba67@kernel.org>

On Fri, Jan 13, 2023 at 12:49:31PM +0100, Christian Brauner wrote:
> Convert to struct mnt_idmap.
> 
> Last cycle we merged the necessary infrastructure in
> 256c8aed2b42 ("fs: introduce dedicated idmap type for mounts").
> This is just the conversion to struct mnt_idmap.
> 
> Currently we still pass around the plain namespace that was attached to a
> mount. This is in general pretty convenient but it makes it easy to
> conflate namespaces that are relevant on the filesystem with namespaces
> that are relevent on the mount level. Especially for non-vfs developers
> without detailed knowledge in this area this can be a potential source for
> bugs.
> 
> Once the conversion to struct mnt_idmap is done all helpers down to the
> really low-level helpers will take a struct mnt_idmap argument instead of
> two namespace arguments. This way it becomes impossible to conflate the two
> eliminating the possibility of any bugs. All of the vfs and all filesystems
> only operate on struct mnt_idmap.
> 
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>  fs/ext4/ialloc.c              |  3 +--
>  fs/inode.c                    |  6 ++----
>  fs/xfs/xfs_inode.c            | 13 +++++--------
>  fs/xfs/xfs_symlink.c          |  5 ++---
>  include/linux/fs.h            | 21 ++++++++++-----------
>  include/linux/mnt_idmapping.h | 18 ++++++++++--------
>  6 files changed, 30 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 1024b0c02431..157663031f8c 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -943,7 +943,6 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  	ext4_group_t flex_group;
>  	struct ext4_group_info *grp = NULL;
>  	bool encrypt = false;
> -	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
>  
>  	/* Cannot create files in a deleted directory */
>  	if (!dir || !dir->i_nlink)
> @@ -973,7 +972,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		i_gid_write(inode, owner[1]);
>  	} else if (test_opt(sb, GRPID)) {
>  		inode->i_mode = mode;
> -		inode_fsuid_set(inode, mnt_userns);
> +		inode_fsuid_set(inode, idmap);
>  		inode->i_gid = dir->i_gid;
>  	} else
>  		inode_init_owner(idmap, inode, dir, mode);
> diff --git a/fs/inode.c b/fs/inode.c
> index 1aec92141fab..1b05e0e4b5c8 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2293,9 +2293,7 @@ EXPORT_SYMBOL(init_special_inode);
>  void inode_init_owner(struct mnt_idmap *idmap, struct inode *inode,
>  		      const struct inode *dir, umode_t mode)
>  {
> -	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
> -
> -	inode_fsuid_set(inode, mnt_userns);
> +	inode_fsuid_set(inode, idmap);
>  	if (dir && dir->i_mode & S_ISGID) {
>  		inode->i_gid = dir->i_gid;
>  
> @@ -2303,7 +2301,7 @@ void inode_init_owner(struct mnt_idmap *idmap, struct inode *inode,
>  		if (S_ISDIR(mode))
>  			mode |= S_ISGID;
>  	} else
> -		inode_fsgid_set(inode, mnt_userns);
> +		inode_fsgid_set(inode, idmap);
>  	inode->i_mode = mode;
>  }
>  EXPORT_SYMBOL(inode_init_owner);
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 59fb064e2df3..7f1d715faab5 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -788,7 +788,6 @@ xfs_init_new_inode(
>  	bool			init_xattrs,
>  	struct xfs_inode	**ipp)
>  {
> -	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
>  	struct inode		*dir = pip ? VFS_I(pip) : NULL;
>  	struct xfs_mount	*mp = tp->t_mountp;
>  	struct xfs_inode	*ip;
> @@ -824,7 +823,7 @@ xfs_init_new_inode(
>  	ip->i_projid = prid;
>  
>  	if (dir && !(dir->i_mode & S_ISGID) && xfs_has_grpid(mp)) {
> -		inode_fsuid_set(inode, mnt_userns);
> +		inode_fsuid_set(inode, idmap);
>  		inode->i_gid = dir->i_gid;
>  		inode->i_mode = mode;
>  	} else {
> @@ -955,7 +954,6 @@ xfs_create(
>  	bool			init_xattrs,
>  	xfs_inode_t		**ipp)
>  {
> -	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
>  	int			is_dir = S_ISDIR(mode);
>  	struct xfs_mount	*mp = dp->i_mount;
>  	struct xfs_inode	*ip = NULL;
> @@ -980,8 +978,8 @@ xfs_create(
>  	/*
>  	 * Make sure that we have allocated dquot(s) on disk.
>  	 */
> -	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
> -			mapped_fsgid(mnt_userns, &init_user_ns), prid,
> +	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(idmap, &init_user_ns),
> +			mapped_fsgid(idmap, &init_user_ns), prid,
>  			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
>  			&udqp, &gdqp, &pdqp);
>  	if (error)
> @@ -1109,7 +1107,6 @@ xfs_create_tmpfile(
>  	umode_t			mode,
>  	struct xfs_inode	**ipp)
>  {
> -	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
>  	struct xfs_mount	*mp = dp->i_mount;
>  	struct xfs_inode	*ip = NULL;
>  	struct xfs_trans	*tp = NULL;
> @@ -1130,8 +1127,8 @@ xfs_create_tmpfile(
>  	/*
>  	 * Make sure that we have allocated dquot(s) on disk.
>  	 */
> -	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
> -			mapped_fsgid(mnt_userns, &init_user_ns), prid,
> +	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(idmap, &init_user_ns),
> +			mapped_fsgid(idmap, &init_user_ns), prid,
>  			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
>  			&udqp, &gdqp, &pdqp);
>  	if (error)
> diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
> index 24cf0a16bf35..85e433df6a3f 100644
> --- a/fs/xfs/xfs_symlink.c
> +++ b/fs/xfs/xfs_symlink.c
> @@ -151,7 +151,6 @@ xfs_symlink(
>  	umode_t			mode,
>  	struct xfs_inode	**ipp)
>  {
> -	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
>  	struct xfs_mount	*mp = dp->i_mount;
>  	struct xfs_trans	*tp = NULL;
>  	struct xfs_inode	*ip = NULL;
> @@ -194,8 +193,8 @@ xfs_symlink(
>  	/*
>  	 * Make sure that we have allocated dquot(s) on disk.
>  	 */
> -	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
> -			mapped_fsgid(mnt_userns, &init_user_ns), prid,
> +	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(idmap, &init_user_ns),
> +			mapped_fsgid(idmap, &init_user_ns), prid,

I know this is pretty late to be asking questions about this patch, but
after reviewing this code, I am curious about something --

Here we try to allocate dquots prior to creating a file.  The uid used
here is:

	mapped_fsuid(mnt_userns, &init_user_ns)

But later in inode_fsuid_set, we set the new inode's actual uid to:

	mapped_fsuid(mnt_userns, i_user_ns(inode));

What happens if i_user_ns(inode) != &init_user_ns?  Can that change the
return value of mapped_fsuid with the result that quota accounting
charges the wrong uid if the user namespaces are different?
Unfortunately I'm not familiar enough with how these things work to know
if that's even a sensible question.

In my development tree I have a few assertions sprinked to see if we
ever detect a discrepancy in the uid that is set.  fstests doesn't
trigger it, nor does my usual workflow, so I really don't know.

--D

>  			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
>  			&udqp, &gdqp, &pdqp);
>  	if (error)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 173c5274a63a..54a95ed68322 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1744,29 +1744,29 @@ static inline void i_gid_update(struct mnt_idmap *idmap,
>  /**
>   * inode_fsuid_set - initialize inode's i_uid field with callers fsuid
>   * @inode: inode to initialize
> - * @mnt_userns: user namespace of the mount the inode was found from
> + * @idmap: idmap of the mount the inode was found from
>   *
>   * Initialize the i_uid field of @inode. If the inode was found/created via
> - * an idmapped mount map the caller's fsuid according to @mnt_users.
> + * an idmapped mount map the caller's fsuid according to @idmap.
>   */
>  static inline void inode_fsuid_set(struct inode *inode,
> -				   struct user_namespace *mnt_userns)
> +				   struct mnt_idmap *idmap)
>  {
> -	inode->i_uid = mapped_fsuid(mnt_userns, i_user_ns(inode));
> +	inode->i_uid = mapped_fsuid(idmap, i_user_ns(inode));
>  }
>  
>  /**
>   * inode_fsgid_set - initialize inode's i_gid field with callers fsgid
>   * @inode: inode to initialize
> - * @mnt_userns: user namespace of the mount the inode was found from
> + * @idmap: idmap of the mount the inode was found from
>   *
>   * Initialize the i_gid field of @inode. If the inode was found/created via
> - * an idmapped mount map the caller's fsgid according to @mnt_users.
> + * an idmapped mount map the caller's fsgid according to @idmap.
>   */
>  static inline void inode_fsgid_set(struct inode *inode,
> -				   struct user_namespace *mnt_userns)
> +				   struct mnt_idmap *idmap)
>  {
> -	inode->i_gid = mapped_fsgid(mnt_userns, i_user_ns(inode));
> +	inode->i_gid = mapped_fsgid(idmap, i_user_ns(inode));
>  }
>  
>  /**
> @@ -1784,14 +1784,13 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
>  					struct mnt_idmap *idmap)
>  {
>  	struct user_namespace *fs_userns = sb->s_user_ns;
> -	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
>  	kuid_t kuid;
>  	kgid_t kgid;
>  
> -	kuid = mapped_fsuid(mnt_userns, fs_userns);
> +	kuid = mapped_fsuid(idmap, fs_userns);
>  	if (!uid_valid(kuid))
>  		return false;
> -	kgid = mapped_fsgid(mnt_userns, fs_userns);
> +	kgid = mapped_fsgid(idmap, fs_userns);
>  	if (!gid_valid(kgid))
>  		return false;
>  	return kuid_has_mapping(fs_userns, kuid) &&
> diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
> index 0ccca33a7a6d..d63e7c84a389 100644
> --- a/include/linux/mnt_idmapping.h
> +++ b/include/linux/mnt_idmapping.h
> @@ -375,8 +375,8 @@ static inline kgid_t vfsgid_into_kgid(vfsgid_t vfsgid)
>  }
>  
>  /**
> - * mapped_fsuid - return caller's fsuid mapped up into a mnt_userns
> - * @mnt_userns: the mount's idmapping
> + * mapped_fsuid - return caller's fsuid mapped according to an idmapping
> + * @idmap: the mount's idmapping
>   * @fs_userns: the filesystem's idmapping
>   *
>   * Use this helper to initialize a new vfs or filesystem object based on
> @@ -385,18 +385,19 @@ static inline kgid_t vfsgid_into_kgid(vfsgid_t vfsgid)
>   * O_CREAT. Other examples include the allocation of quotas for a specific
>   * user.
>   *
> - * Return: the caller's current fsuid mapped up according to @mnt_userns.
> + * Return: the caller's current fsuid mapped up according to @idmap.
>   */
> -static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns,
> +static inline kuid_t mapped_fsuid(struct mnt_idmap *idmap,
>  				  struct user_namespace *fs_userns)
>  {
> +	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
>  	return from_vfsuid(mnt_userns, fs_userns,
>  			   VFSUIDT_INIT(current_fsuid()));
>  }
>  
>  /**
> - * mapped_fsgid - return caller's fsgid mapped up into a mnt_userns
> - * @mnt_userns: the mount's idmapping
> + * mapped_fsgid - return caller's fsgid mapped according to an idmapping
> + * @idmap: the mount's idmapping
>   * @fs_userns: the filesystem's idmapping
>   *
>   * Use this helper to initialize a new vfs or filesystem object based on
> @@ -405,11 +406,12 @@ static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns,
>   * O_CREAT. Other examples include the allocation of quotas for a specific
>   * user.
>   *
> - * Return: the caller's current fsgid mapped up according to @mnt_userns.
> + * Return: the caller's current fsgid mapped up according to @idmap.
>   */
> -static inline kgid_t mapped_fsgid(struct user_namespace *mnt_userns,
> +static inline kgid_t mapped_fsgid(struct mnt_idmap *idmap,
>  				  struct user_namespace *fs_userns)
>  {
> +	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
>  	return from_vfsgid(mnt_userns, fs_userns,
>  			   VFSGIDT_INIT(current_fsgid()));
>  }
> 
> -- 
> 2.34.1
> 

