Return-Path: <linux-fsdevel+bounces-4596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635978012FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 19:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863A61C20328
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D744EB46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOL5d121"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388074D109;
	Fri,  1 Dec 2023 16:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A331BC433C9;
	Fri,  1 Dec 2023 16:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701448885;
	bh=gl7H4i18Jm2yLgqXk3+J6Itv7zEPVQWiJ43VT4UGz7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOL5d121IoNSM2PRow/Xc5LPAKDrQevVVAptMbdR/rc3O8WAIrp3ShBlDzOZwfMMM
	 X6lCSjYjozM1ZElUNlsRic99bmVWf/gCnXQ7F5xJNcYOEJBlHbZ9cpMxqj1iP9h+YC
	 gtBScQVd+XKezaxzb4AbdtKP/yJp8zJ6tgXhPNGFe4F00hmldtA6Q2E/M2Y9HAk5ED
	 6w0NA2cjijtY22rh8H9VHOEc5gXS+3JE58Xi7ZwMiyDCVW6wipYu39Lly72FNUYSkw
	 HgQ/dmE0NpYkX3lezMbv8TiVj0WlG1S9bS1Ga7t0X7xsLXnujtVJ+sITi+Ojt104N4
	 2dLaXGuizfJDA==
Date: Fri, 1 Dec 2023 17:41:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 05/16] capability: provide helpers for converting between
 xattrs and vfs_caps
Message-ID: <20231201-gefahndet-biogas-ee3669edc96c@brauner>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-5-da5a26058a5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129-idmap-fscap-refactor-v1-5-da5a26058a5b@kernel.org>

On Wed, Nov 29, 2023 at 03:50:23PM -0600, Seth Forshee (DigitalOcean) wrote:
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
>  security/commoncap.c       | 227 +++++++++++++++++++++++++++++++++++----------
>  2 files changed, 186 insertions(+), 51 deletions(-)
> 
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index eb46d346bbbc..cdd7d2d8855e 100644
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
> +			const void *data, int size);
> +int vfs_caps_to_xattr(struct mnt_idmap *idmap,
> +		      struct user_namespace *dest_userns,
> +		      const struct vfs_caps *vfs_caps,
> +		      void *data, int size);
> +
>  /* audit system wants to get cap info from files as well */
>  int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
>  			   const struct dentry *dentry,
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 3d045d377e5e..ef37966f3522 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -618,54 +618,41 @@ static inline int bprm_caps_from_vfs_caps(struct vfs_caps *caps,
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
> +			const void *data, int size)
>  {
> -	struct inode *inode = d_backing_inode(dentry);
>  	__u32 magic_etc;
> -	int size;
> -	struct vfs_ns_cap_data data, *nscaps = &data;
> -	struct vfs_cap_data *caps = (struct vfs_cap_data *) &data;
> +	const struct vfs_ns_cap_data *ns_caps = data;

The casting here is predicated on the compatibility of these two structs
and I'm kinda surprised to see no static assertions about their layout.
So I would recommend to add some to the header:

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 5bb906098697..0fd75aab9754 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -16,6 +16,10 @@

 #include <linux/types.h>

+#ifdef __KERNEL__
+#include <linux/build_bug.h>
+#endif
+
 /* User-level do most of the mapping between kernel and user
    capabilities based on the version tag given by the kernel. The
    kernel might be somewhat backwards compatible, but don't bet on
@@ -100,6 +104,15 @@ struct vfs_ns_cap_data {
 #define _LINUX_CAPABILITY_VERSION  _LINUX_CAPABILITY_VERSION_1
 #define _LINUX_CAPABILITY_U32S     _LINUX_CAPABILITY_U32S_1

+#else
+
+static_assert(offsetof(struct vfs_cap_data, magic_etc) ==
+             offsetof(struct vfs_ns_cap_data, magic_etc));
+static_assert(offsetof(struct vfs_cap_data, data) ==
+             offsetof(struct vfs_ns_cap_data, data));
+static_assert(sizeof(struct vfs_cap_data) ==
+             offsetof(struct vfs_ns_cap_data, rootid));
+
 #endif


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
> @@ -678,39 +665,177 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
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
> +static int __vfs_caps_to_xattr(struct mnt_idmap *idmap,
> +			       struct user_namespace *dest_userns,
> +			       const struct vfs_caps *vfs_caps,
> +			       void *data, int size)
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
> + * Converts a kernel-interrnal capability into the raw security.capability

s/interrnal/internal/

> + * xattr format.
> + *
> + * If the xattr is being read or written through an idmapped mount the
> + * idmap of the vfsmount must be passed through @idmap. This function
> + * will then take care to map the rootid according to @idmap.
> + *
> + * Return: On success, return 0; on error, return < 0.
> + */
> +int vfs_caps_to_xattr(struct mnt_idmap *idmap,
> +		      struct user_namespace *dest_userns,
> +		      const struct vfs_caps *vfs_caps,
> +		      void *data, int size)
> +{
> +	struct vfs_ns_cap_data *caps = data;
> +	int ret;
> +
> +	ret = __vfs_caps_to_xattr(idmap, dest_userns, vfs_caps, data, size);
> +	if (ret > 0 &&
> +	    (vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) == VFS_CAP_REVISION_3 &&
> +	     le32_to_cpu(caps->rootid) == (uid_t)-1)
> +		return -EOVERFLOW;

I think the return value situation of these two helper is a bit
confusing. So if they return the size or a negative error pointer the
return value of both functions should likely be ssize_t.

But unless you actually later use the size in the callers of these
helpers it would be easier to just stick with 0 on success, negative
errno on failure. Note that that's what vfs_caps_from_xattr() is doing.

I'll see whether that becomes relevant later in the series though.

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

