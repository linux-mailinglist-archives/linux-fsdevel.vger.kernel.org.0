Return-Path: <linux-fsdevel+bounces-12554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C85BB860D7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 10:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CBE1F26F89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 09:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D077D24219;
	Fri, 23 Feb 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvCH4LoJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3661864C;
	Fri, 23 Feb 2024 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679085; cv=none; b=H5jJSWWwxC2jvbIcT//XP2HioOEV0VSPznUeV9bxlozmw1LyR3bs7PBqCbRZhLtTDvoy/Zs9l3dShuS9rL2a24bKdPYmeewbScx/j4JYSM1fLJZXMYyHMJoq9QbClzPDYHRhm2nvLA4Bf4ANaozh5GcduFW/XL+IIsrPnZS/vXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679085; c=relaxed/simple;
	bh=7kFRhHwFlVphxZTXGnqN85XzeoEezZvAaghzbI2ztG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gn1YgCUIUesV+TSQYHWRRzFJACfYcBKyFRA4L8B8CydByPFb90Udm0MNXtYEo75vJLd+hh86VK3KFn+3RTVzJA/sL0cIS+Avqra7VadtQQ8V/ecxVKxi/S/TYZWrV9/I1uvZg7pRJHf5GSym6ZY2/JsPdJ2KCGJjArjC36uThus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvCH4LoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C152C433F1;
	Fri, 23 Feb 2024 09:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708679084;
	bh=7kFRhHwFlVphxZTXGnqN85XzeoEezZvAaghzbI2ztG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GvCH4LoJMMNaIT0igFhCk4k0LdsCvF1yK9NRBHwdsShWV4oHubDamxW9SXY8qzUad
	 NeFnqfJCvolHAKGf3LvVgOdBLFmDx2lA3/gzvxQYThNEge7HWhRW5AotDuEvmoDE/p
	 cgiKuublpFC+Tr4h7MBN8WdkLZBdyjJJgkeM+sXoBtf0jxIgaMeSYjJOFVgyVfz6c7
	 V6bb/pIXGRES7bb2d4FADw9XsFf+NBL5ykf8euOtnDkn2A+unTIcyqTJ7+26szPImH
	 1L/efaXcq/x/624shWTxOeVy44Rz4//9uzkzgt9m4/ROVeNU0J6FVvXRQ70GlCxYCi
	 Bm81xRtbHq9NA==
Date: Fri, 23 Feb 2024 10:04:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, selinux@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 20/25] ovl: add fscaps handlers
Message-ID: <20240223-geldhahn-anklicken-e118fa7ad4c0@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-20-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-20-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:51PM -0600, Seth Forshee (DigitalOcean) wrote:
> Add handlers which read fs caps from the lower or upper filesystem and
> write/remove fs caps to the upper filesystem, performing copy-up as
> necessary.
> 
> While fscaps only really make sense on regular files, the general policy
> is to allow most xattr namespaces on all different inode types, so
> fscaps handlers are installed in the inode operations for all types of
> inodes.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  fs/overlayfs/dir.c       |  2 ++
>  fs/overlayfs/inode.c     | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/overlayfs/overlayfs.h |  5 ++++
>  3 files changed, 79 insertions(+)
> 
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 0f8b4a719237..4ff360fe10c9 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1307,6 +1307,8 @@ const struct inode_operations ovl_dir_inode_operations = {
>  	.get_inode_acl	= ovl_get_inode_acl,
>  	.get_acl	= ovl_get_acl,
>  	.set_acl	= ovl_set_acl,
> +	.get_fscaps	= ovl_get_fscaps,
> +	.set_fscaps	= ovl_set_fscaps,
>  	.update_time	= ovl_update_time,
>  	.fileattr_get	= ovl_fileattr_get,
>  	.fileattr_set	= ovl_fileattr_set,
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index c63b31a460be..7a8978ea6fe1 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -568,6 +568,72 @@ int ovl_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  }
>  #endif
>  
> +int ovl_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +		   struct vfs_caps *caps)
> +{
> +	int err;
> +	const struct cred *old_cred;
> +	struct path realpath;
> +
> +	ovl_path_real(dentry, &realpath);
> +	old_cred = ovl_override_creds(dentry->d_sb);
> +	err = vfs_get_fscaps(mnt_idmap(realpath.mnt), realpath.dentry, caps);

Right, vfs_get_fscaps() returns a struct vfs_caps which contains a
vfs{g,u}id and has the lower/upper layer's idmap taken into account.

That confused me at first because vfs_get_acl() returns a struct
posix_acl which contains k{g,u}id.

Reading through this made me realize that we need a few more words about
the translations. The reason is that we do distinct things for POSIX
ACLs and for fscaps. For POSIX ACLs when we call vfs_get_acl() what we
get is a struct posix_acl which contains k{g,u}id_t types. Because
struct posix_acl is cached filesytems wide and thus shared among
concurrent retrievers from different mounts with different idmappings.
Which means that we can't put vfs{g,u}id_t types in there. Instead we
perform translations on the fly. We do that in the VFS during path
lookup and we do that for overlayfs when it retrieves POSIX ACLs.

However, for fscaps we seem to do it differently because they're not
cached which is ok because they don't matter during path lookup as POSIX
ACLs do. So performance here doesn't matter too much. But that means
overall that the translations are quite distinct. And that gets
confusing when we have a stacking filesystem in the mix where we have to
take into account the privileges of the mounter of the overlayfs
instance and the idmap of the lower/upper layer.

I only skimmed my old commit but I think that commit 0c5fd887d2bb ("acl: move
idmapped mount fixup into vfs_{g,s}etxattr()") contains a detailed explanation
of this as I see:

    > For POSIX ACLs we need to do something similar. However, in contrast to fscaps
    > we cannot apply the fix directly to the kernel internal posix acl data
    > structure as this would alter the cached values and would also require a rework
    > of how we currently deal with POSIX ACLs in general which almost never take the
    > filesystem idmapping into account (the noteable exception being FUSE but even
    > there the implementation is special) and instead retrieve the raw values based
    > on the initial idmapping.

Could you please add a diagram/explanation illustrating the translations for
fscaps in the general case and for stacking filesystems? It doesn't really
matter too much where you put it. Either add a section to
Documentation/filesystems/porting.rst or add a section to
Documentation/filesystems/idmapping.rst.

> +	revert_creds(old_cred);
> +	return err;
> +}
> +
> +int ovl_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +		   const struct vfs_caps *caps, int setxattr_flags)
> +{
> +	int err;
> +	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
> +	struct dentry *upperdentry = ovl_dentry_upper(dentry);
> +	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
> +	const struct cred *old_cred;
> +
> +	/*
> +	 * If the fscaps are to be remove from a lower file, check that they
> +	 * exist before copying up.
> +	 */
> +	if (!caps && !upperdentry) {
> +		struct path realpath;
> +		struct vfs_caps lower_caps;
> +
> +		ovl_path_lower(dentry, &realpath);
> +		old_cred = ovl_override_creds(dentry->d_sb);
> +		err = vfs_get_fscaps(mnt_idmap(realpath.mnt), realdentry,
> +				     &lower_caps);
> +		revert_creds(old_cred);
> +		if (err)
> +			goto out;
> +	}
> +
> +	err = ovl_want_write(dentry);
> +	if (err)
> +		goto out;
> +
> +	err = ovl_copy_up(dentry);
> +	if (err)
> +		goto out_drop_write;
> +	upperdentry = ovl_dentry_upper(dentry);
> +
> +	old_cred = ovl_override_creds(dentry->d_sb);
> +	if (!caps)
> +		err = vfs_remove_fscaps(ovl_upper_mnt_idmap(ofs), upperdentry);
> +	else
> +		err = vfs_set_fscaps(ovl_upper_mnt_idmap(ofs), upperdentry,
> +				     caps, setxattr_flags);
> +	revert_creds(old_cred);
> +
> +	/* copy c/mtime */
> +	ovl_copyattr(d_inode(dentry));
> +
> +out_drop_write:
> +	ovl_drop_write(dentry);
> +out:
> +	return err;
> +}
> +
>  int ovl_update_time(struct inode *inode, int flags)
>  {
>  	if (flags & S_ATIME) {
> @@ -747,6 +813,8 @@ static const struct inode_operations ovl_file_inode_operations = {
>  	.get_inode_acl	= ovl_get_inode_acl,
>  	.get_acl	= ovl_get_acl,
>  	.set_acl	= ovl_set_acl,
> +	.get_fscaps	= ovl_get_fscaps,
> +	.set_fscaps	= ovl_set_fscaps,
>  	.update_time	= ovl_update_time,
>  	.fiemap		= ovl_fiemap,
>  	.fileattr_get	= ovl_fileattr_get,
> @@ -758,6 +826,8 @@ static const struct inode_operations ovl_symlink_inode_operations = {
>  	.get_link	= ovl_get_link,
>  	.getattr	= ovl_getattr,
>  	.listxattr	= ovl_listxattr,
> +	.get_fscaps	= ovl_get_fscaps,
> +	.set_fscaps	= ovl_set_fscaps,
>  	.update_time	= ovl_update_time,
>  };
>  
> @@ -769,6 +839,8 @@ static const struct inode_operations ovl_special_inode_operations = {
>  	.get_inode_acl	= ovl_get_inode_acl,
>  	.get_acl	= ovl_get_acl,
>  	.set_acl	= ovl_set_acl,
> +	.get_fscaps	= ovl_get_fscaps,
> +	.set_fscaps	= ovl_set_fscaps,
>  	.update_time	= ovl_update_time,
>  };
>  
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index ee949f3e7c77..4f948749ee02 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -781,6 +781,11 @@ static inline struct posix_acl *ovl_get_acl_path(const struct path *path,
>  }
>  #endif
>  
> +int ovl_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +		   struct vfs_caps *caps);
> +int ovl_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +		   const struct vfs_caps *caps, int setxattr_flags);
> +
>  int ovl_update_time(struct inode *inode, int flags);
>  bool ovl_is_private_xattr(struct super_block *sb, const char *name);
>  
> 
> -- 
> 2.43.0
> 

