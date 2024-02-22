Return-Path: <linux-fsdevel+bounces-12483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D0E85FC2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 16:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81461F2466F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A5014D43C;
	Thu, 22 Feb 2024 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqftgMjW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFCE14C586;
	Thu, 22 Feb 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615217; cv=none; b=pEh8HaDtR2+20lqKM9CdlGsnUKvai9G0dsr7EPhhNXtdSewyCoOvmFMg2MAEr1DZP7kxJAePik1fr6q+y1U7ZAQxShTSFQL08Iz1fsFftJ00l/l67dE6wthAw46lwxZ4ybGHPvZTtO+QW2uqpwtFz6xxI0/CTEl3A6itWkXGp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615217; c=relaxed/simple;
	bh=bml6ArFFJiK9FnYAWmn7RGCZrjEyDDwWD5hm+jZMO0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nnimt7SFlpu2SKl+TofhDE6clODJ1ZJYh4lss+FHPi2xnKGUL/1Ey543rcMoe+wyYnGikLRIgf+oKMQ8yI3Yb3H4YlWehfE89TtP2djAOZilmlaWzWS+ANRx/BBX5mgs6+9cUg7WXA/YuX0kkexv5s9RwNdKCKI7mp0Cu0+meMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqftgMjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3351DC433C7;
	Thu, 22 Feb 2024 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708615216;
	bh=bml6ArFFJiK9FnYAWmn7RGCZrjEyDDwWD5hm+jZMO0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gqftgMjWYOF9UPiyM8r9+2nv8zPGgJDKe7h4qZcmhX8n6WCVe/NIJDb7JIxYL5WeQ
	 h9Pf+CJ8nHdi3DuCu34SgjvFDP7e1lP3LXl8N3riHnp5XoOM+N0XOKUbjl1a71PmSk
	 +IvV0WxzzNHQJRsAr5OHPsbwPlppuJHq0+VGF0in9geLIlTrLRB9/TZDaiT5C/4kiS
	 VKf7+ttF2Ovqs7aHvwMd9iS0g9PwfoW6r1nKbBYm+eYw4wBy3ET7GyFrP5bzi8Gt0w
	 9eTr97ZAUn/ngpuRKDfU9HT3AJlBlyihrNFE0KIFjA9Pnt9LyfoWxEHEfNP71+Z8fS
	 4q3RZvbTlzBeg==
Date: Thu, 22 Feb 2024 16:20:08 +0100
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
Subject: Re: [PATCH v2 06/25] capability: provide helpers for converting
 between xattrs and vfs_caps
Message-ID: <20240222-wieweit-eiskunstlauf-0dbab2007754@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-6-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-6-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:37PM -0600, Seth Forshee (DigitalOcean) wrote:
> To pass around vfs_caps instead of raw xattr data we will need to
> convert between the two representations near userspace and disk
> boundaries. We already convert xattrs from disks to vfs_caps, so move
> that code into a helper, and change get_vfs_caps_from_disk() to use the
> helper.
> 
> When converting vfs_caps to xattrs we have different considerations
> depending on the destination of the xattr data. For xattrs which will be
> written to disk we need to reject the xattr if the rootid does not map
> into the filesystem's user namespace, whereas xattrs read by userspace
> may need to undergo a conversion from v3 to v2 format when the rootid
> does not map. So this helper is split into an internal and an external
> interface. The internal interface does not return an error if the rootid
> has no mapping in the target user namespace and will be used for
> conversions targeting userspace. The external interface returns
> EOVERFLOW if the rootid has no mapping and will be used for all other
> conversions.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  include/linux/capability.h |  10 ++
>  security/commoncap.c       | 228 +++++++++++++++++++++++++++++++++++----------
>  2 files changed, 187 insertions(+), 51 deletions(-)
> 
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index eb46d346bbbc..a0893ac4664b 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -209,6 +209,16 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
>  		ns_capable(ns, CAP_SYS_ADMIN);
>  }
>  
> +/* helpers to convert between xattr and in-kernel representations */
> +int vfs_caps_from_xattr(struct mnt_idmap *idmap,
> +			struct user_namespace *src_userns,
> +			struct vfs_caps *vfs_caps,
> +			const void *data, size_t size);
> +ssize_t vfs_caps_to_xattr(struct mnt_idmap *idmap,
> +			  struct user_namespace *dest_userns,
> +			  const struct vfs_caps *vfs_caps,
> +			  void *data, size_t size);
> +
>  /* audit system wants to get cap info from files as well */
>  int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
>  			   const struct dentry *dentry,
> diff --git a/security/commoncap.c b/security/commoncap.c
> index a0b5c9740759..7531c9634997 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -619,54 +619,41 @@ static inline int bprm_caps_from_vfs_caps(struct vfs_caps *caps,
>  }
>  
>  /**
> - * get_vfs_caps_from_disk - retrieve vfs caps from disk
> + * vfs_caps_from_xattr - convert raw caps xattr data to vfs_caps
>   *
> - * @idmap:	idmap of the mount the inode was found from
> - * @dentry:	dentry from which @inode is retrieved
> - * @cpu_caps:	vfs capabilities
> + * @idmap:      idmap of the mount the inode was found from
> + * @src_userns: user namespace for ids in xattr data
> + * @vfs_caps:   destination buffer for vfs_caps data
> + * @data:       rax xattr caps data
> + * @size:       size of xattr data
>   *
> - * Extract the on-exec-apply capability sets for an executable file.
> + * Converts a raw security.capability xattr into the kernel-internal
> + * capabilities format.
>   *
> - * If the inode has been found through an idmapped mount the idmap of
> - * the vfsmount must be passed through @idmap. This function will then
> - * take care to map the inode according to @idmap before checking
> - * permissions. On non-idmapped mounts or if permission checking is to be
> - * performed on the raw inode simply pass @nop_mnt_idmap.
> + * If the xattr is being read or written through an idmapped mount the
> + * idmap of the vfsmount must be passed through @idmap. This function
> + * will then take care to map the rootid according to @idmap.
> + *
> + * Return: On success, return 0; on error, return < 0.
>   */
> -int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
> -			   const struct dentry *dentry,
> -			   struct vfs_caps *cpu_caps)
> +int vfs_caps_from_xattr(struct mnt_idmap *idmap,
> +			struct user_namespace *src_userns,
> +			struct vfs_caps *vfs_caps,
> +			const void *data, size_t size)
>  {
> -	struct inode *inode = d_backing_inode(dentry);
>  	__u32 magic_etc;
> -	int size;
> -	struct vfs_ns_cap_data data, *nscaps = &data;
> -	struct vfs_cap_data *caps = (struct vfs_cap_data *) &data;
> +	const struct vfs_ns_cap_data *ns_caps = data;
> +	struct vfs_cap_data *caps = (struct vfs_cap_data *)ns_caps;
>  	kuid_t rootkuid;
> -	vfsuid_t rootvfsuid;
> -	struct user_namespace *fs_ns;
> -
> -	memset(cpu_caps, 0, sizeof(struct vfs_caps));
> -
> -	if (!inode)
> -		return -ENODATA;
>  
> -	fs_ns = inode->i_sb->s_user_ns;
> -	size = __vfs_getxattr((struct dentry *)dentry, inode,
> -			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
> -	if (size == -ENODATA || size == -EOPNOTSUPP)
> -		/* no data, that's ok */
> -		return -ENODATA;
> -
> -	if (size < 0)
> -		return size;
> +	memset(vfs_caps, 0, sizeof(*vfs_caps));
>  
>  	if (size < sizeof(magic_etc))
>  		return -EINVAL;
>  
> -	cpu_caps->magic_etc = magic_etc = le32_to_cpu(caps->magic_etc);
> +	vfs_caps->magic_etc = magic_etc = le32_to_cpu(caps->magic_etc);
>  
> -	rootkuid = make_kuid(fs_ns, 0);
> +	rootkuid = make_kuid(src_userns, 0);
>  	switch (magic_etc & VFS_CAP_REVISION_MASK) {
>  	case VFS_CAP_REVISION_1:
>  		if (size != XATTR_CAPS_SZ_1)
> @@ -679,39 +666,178 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
>  	case VFS_CAP_REVISION_3:
>  		if (size != XATTR_CAPS_SZ_3)
>  			return -EINVAL;
> -		rootkuid = make_kuid(fs_ns, le32_to_cpu(nscaps->rootid));
> +		rootkuid = make_kuid(src_userns, le32_to_cpu(ns_caps->rootid));
>  		break;
>  
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	rootvfsuid = make_vfsuid(idmap, fs_ns, rootkuid);
> -	if (!vfsuid_valid(rootvfsuid))
> -		return -ENODATA;
> +	vfs_caps->rootid = make_vfsuid(idmap, src_userns, rootkuid);
> +	if (!vfsuid_valid(vfs_caps->rootid))
> +		return -EOVERFLOW;
>  
> -	/* Limit the caps to the mounter of the filesystem
> -	 * or the more limited uid specified in the xattr.
> +	vfs_caps->permitted.val = le32_to_cpu(caps->data[0].permitted);
> +	vfs_caps->inheritable.val = le32_to_cpu(caps->data[0].inheritable);
> +
> +	/*
> +	 * Rev1 had just a single 32-bit word, later expanded
> +	 * to a second one for the high bits
>  	 */
> -	if (!rootid_owns_currentns(rootvfsuid))
> -		return -ENODATA;
> +	if ((magic_etc & VFS_CAP_REVISION_MASK) != VFS_CAP_REVISION_1) {
> +		vfs_caps->permitted.val += (u64)le32_to_cpu(caps->data[1].permitted) << 32;
> +		vfs_caps->inheritable.val += (u64)le32_to_cpu(caps->data[1].inheritable) << 32;

That + makes this even more difficult to read. This should be rewritten.

> +	}
> +
> +	vfs_caps->permitted.val &= CAP_VALID_MASK;
> +	vfs_caps->inheritable.val &= CAP_VALID_MASK;
> +
> +	return 0;
> +}
> +
> +/*
> + * Inner implementation of vfs_caps_to_xattr() which does not return an
> + * error if the rootid does not map into @dest_userns.
> + */
> +static ssize_t __vfs_caps_to_xattr(struct mnt_idmap *idmap,
> +				   struct user_namespace *dest_userns,
> +				   const struct vfs_caps *vfs_caps,
> +				   void *data, size_t size)
> +{
> +	struct vfs_ns_cap_data *ns_caps = data;
> +	struct vfs_cap_data *caps = (struct vfs_cap_data *)ns_caps;
> +	kuid_t rootkuid;
> +	uid_t rootid;
> +
> +	memset(ns_caps, 0, size);
> +
> +	rootid = 0;
> +	switch (vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) {
> +	case VFS_CAP_REVISION_1:
> +		if (size < XATTR_CAPS_SZ_1)
> +			return -EINVAL;
> +		size = XATTR_CAPS_SZ_1;
> +		break;
> +	case VFS_CAP_REVISION_2:
> +		if (size < XATTR_CAPS_SZ_2)
> +			return -EINVAL;
> +		size = XATTR_CAPS_SZ_2;
> +		break;
> +	case VFS_CAP_REVISION_3:
> +		if (size < XATTR_CAPS_SZ_3)
> +			return -EINVAL;
> +		size = XATTR_CAPS_SZ_3;
> +		rootkuid = from_vfsuid(idmap, dest_userns, vfs_caps->rootid);
> +		rootid = from_kuid(dest_userns, rootkuid);
> +		ns_caps->rootid = cpu_to_le32(rootid);
> +		break;
>  
> -	cpu_caps->permitted.val = le32_to_cpu(caps->data[0].permitted);
> -	cpu_caps->inheritable.val = le32_to_cpu(caps->data[0].inheritable);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	caps->magic_etc = cpu_to_le32(vfs_caps->magic_etc);
> +
> +	caps->data[0].permitted = cpu_to_le32(lower_32_bits(vfs_caps->permitted.val));
> +	caps->data[0].inheritable = cpu_to_le32(lower_32_bits(vfs_caps->inheritable.val));
>  
>  	/*
>  	 * Rev1 had just a single 32-bit word, later expanded
>  	 * to a second one for the high bits
>  	 */
> -	if ((magic_etc & VFS_CAP_REVISION_MASK) != VFS_CAP_REVISION_1) {
> -		cpu_caps->permitted.val += (u64)le32_to_cpu(caps->data[1].permitted) << 32;
> -		cpu_caps->inheritable.val += (u64)le32_to_cpu(caps->data[1].inheritable) << 32;
> +	if ((vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) != VFS_CAP_REVISION_1) {
> +		caps->data[1].permitted =
> +			cpu_to_le32(upper_32_bits(vfs_caps->permitted.val));
> +		caps->data[1].inheritable =
> +			cpu_to_le32(upper_32_bits(vfs_caps->inheritable.val));
>  	}
>  
> -	cpu_caps->permitted.val &= CAP_VALID_MASK;
> -	cpu_caps->inheritable.val &= CAP_VALID_MASK;
> +	return size;
> +}
> +
> +
> +/**
> + * vfs_caps_to_xattr - convert vfs_caps to raw caps xattr data
> + *
> + * @idmap:       idmap of the mount the inode was found from
> + * @dest_userns: user namespace for ids in xattr data
> + * @vfs_caps:    source vfs_caps data
> + * @data:        destination buffer for rax xattr caps data
> + * @size:        size of the @data buffer
> + *
> + * Converts a kernel-internal capability into the raw security.capability
> + * xattr format.
> + *
> + * If the xattr is being read or written through an idmapped mount the
> + * idmap of the vfsmount must be passed through @idmap. This function
> + * will then take care to map the rootid according to @idmap.
> + *
> + * Return: On success, return the size of the xattr data. On error,
> + * return < 0.
> + */
> +ssize_t vfs_caps_to_xattr(struct mnt_idmap *idmap,
> +			  struct user_namespace *dest_userns,
> +			  const struct vfs_caps *vfs_caps,
> +			  void *data, size_t size)
> +{
> +	struct vfs_ns_cap_data *caps = data;
> +	int ret;

This should very likely be ssize_t ret.

> +
> +	ret = __vfs_caps_to_xattr(idmap, dest_userns, vfs_caps, data, size);
> +	if (ret > 0 &&
> +	    (vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) == VFS_CAP_REVISION_3 &&
> +	     le32_to_cpu(caps->rootid) == (uid_t)-1)
> +		return -EOVERFLOW;
> +	return ret;
> +}
> +
> +/**
> + * get_vfs_caps_from_disk - retrieve vfs caps from disk
> + *
> + * @idmap:	idmap of the mount the inode was found from
> + * @dentry:	dentry from which @inode is retrieved
> + * @cpu_caps:	vfs capabilities
> + *
> + * Extract the on-exec-apply capability sets for an executable file.
> + *
> + * If the inode has been found through an idmapped mount the idmap of
> + * the vfsmount must be passed through @idmap. This function will then
> + * take care to map the inode according to @idmap before checking
> + * permissions. On non-idmapped mounts or if permission checking is to be
> + * performed on the raw inode simply pass @nop_mnt_idmap.
> + */
> +int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
> +			   const struct dentry *dentry,
> +			   struct vfs_caps *cpu_caps)
> +{
> +	struct inode *inode = d_backing_inode(dentry);
> +	int size, ret;
> +	struct vfs_ns_cap_data data, *nscaps = &data;
> +
> +	if (!inode)
> +		return -ENODATA;
>  
> -	cpu_caps->rootid = rootvfsuid;
> +	size = __vfs_getxattr((struct dentry *)dentry, inode,
> +			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
> +	if (size == -ENODATA || size == -EOPNOTSUPP)
> +		/* no data, that's ok */
> +		return -ENODATA;
> +
> +	if (size < 0)
> +		return size;
> +
> +	ret = vfs_caps_from_xattr(idmap, inode->i_sb->s_user_ns,
> +				  cpu_caps, nscaps, size);
> +	if (ret == -EOVERFLOW)
> +		return -ENODATA;
> +	if (ret)
> +		return ret;
> +
> +	/* Limit the caps to the mounter of the filesystem
> +	 * or the more limited uid specified in the xattr.
> +	 */
> +	if (!rootid_owns_currentns(cpu_caps->rootid))
> +		return -ENODATA;
>  
>  	return 0;
>  }
> 
> -- 
> 2.43.0
> 

