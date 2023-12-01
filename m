Return-Path: <linux-fsdevel+bounces-4599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B41801301
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 19:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5BFBB20B2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E85102C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgiYJarF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7062D634;
	Fri,  1 Dec 2023 17:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0D3C433C7;
	Fri,  1 Dec 2023 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701450567;
	bh=QPXBVj4TJXcwgh5JQIm8/8CeXHqLYOmq91L3eBH7lKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgiYJarF6GT2hfQJOsq2zcMv/cDXYXR7VqdCVW/LOYEVHSRy1ciy3Q1ZaPXa2K6ty
	 NQ88FLXRt2/G5sh5suPfanyPaSBmFgNd3UOxa3EL4PyLgbfC2DXqfiXQvY3RnCaUH8
	 5YkVE8LxfXd69BorkbZ8JckNHPU3PpfhE44ch4Jfo1Kdkd9GscM3Qa3qynTzJ9JlBa
	 +2WHfFLIjbEvTfaEjMa+e3OkE4stvlEP2N0COFBtdNJX0bCtKHu+tN6q+XnTWxNimC
	 xVxPnqeexVmDX0KgtyLh7sdw3J1K1x05dpn3lSzl2QUvIeIfEIY1bpYJn0669n87F0
	 d9EIGgu4buptQ==
Date: Fri, 1 Dec 2023 11:09:26 -0600
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To: Christian Brauner <brauner@kernel.org>
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
Message-ID: <ZWoTRsbZLSRkXbrd@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-5-da5a26058a5b@kernel.org>
 <20231201-gefahndet-biogas-ee3669edc96c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-gefahndet-biogas-ee3669edc96c@brauner>

On Fri, Dec 01, 2023 at 05:41:19PM +0100, Christian Brauner wrote:
> >  /**
> > - * get_vfs_caps_from_disk - retrieve vfs caps from disk
> > + * vfs_caps_from_xattr - convert raw caps xattr data to vfs_caps
> >   *
> > - * @idmap:	idmap of the mount the inode was found from
> > - * @dentry:	dentry from which @inode is retrieved
> > - * @cpu_caps:	vfs capabilities
> > + * @idmap:      idmap of the mount the inode was found from
> > + * @src_userns: user namespace for ids in xattr data
> > + * @vfs_caps:   destination buffer for vfs_caps data
> > + * @data:       rax xattr caps data
> > + * @size:       size of xattr data
> >   *
> > - * Extract the on-exec-apply capability sets for an executable file.
> > + * Converts a raw security.capability xattr into the kernel-internal
> > + * capabilities format.
> >   *
> > - * If the inode has been found through an idmapped mount the idmap of
> > - * the vfsmount must be passed through @idmap. This function will then
> > - * take care to map the inode according to @idmap before checking
> > - * permissions. On non-idmapped mounts or if permission checking is to be
> > - * performed on the raw inode simply pass @nop_mnt_idmap.
> > + * If the xattr is being read or written through an idmapped mount the
> > + * idmap of the vfsmount must be passed through @idmap. This function
> > + * will then take care to map the rootid according to @idmap.
> > + *
> > + * Return: On success, return 0; on error, return < 0.
> >   */
> > -int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
> > -			   const struct dentry *dentry,
> > -			   struct vfs_caps *cpu_caps)
> > +int vfs_caps_from_xattr(struct mnt_idmap *idmap,
> > +			struct user_namespace *src_userns,
> > +			struct vfs_caps *vfs_caps,
> > +			const void *data, int size)
> >  {
> > -	struct inode *inode = d_backing_inode(dentry);
> >  	__u32 magic_etc;
> > -	int size;
> > -	struct vfs_ns_cap_data data, *nscaps = &data;
> > -	struct vfs_cap_data *caps = (struct vfs_cap_data *) &data;
> > +	const struct vfs_ns_cap_data *ns_caps = data;
> 
> The casting here is predicated on the compatibility of these two structs
> and I'm kinda surprised to see no static assertions about their layout.
> So I would recommend to add some to the header:
> 
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 5bb906098697..0fd75aab9754 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -16,6 +16,10 @@
> 
>  #include <linux/types.h>
> 
> +#ifdef __KERNEL__
> +#include <linux/build_bug.h>
> +#endif
> +
>  /* User-level do most of the mapping between kernel and user
>     capabilities based on the version tag given by the kernel. The
>     kernel might be somewhat backwards compatible, but don't bet on
> @@ -100,6 +104,15 @@ struct vfs_ns_cap_data {
>  #define _LINUX_CAPABILITY_VERSION  _LINUX_CAPABILITY_VERSION_1
>  #define _LINUX_CAPABILITY_U32S     _LINUX_CAPABILITY_U32S_1
> 
> +#else
> +
> +static_assert(offsetof(struct vfs_cap_data, magic_etc) ==
> +             offsetof(struct vfs_ns_cap_data, magic_etc));
> +static_assert(offsetof(struct vfs_cap_data, data) ==
> +             offsetof(struct vfs_ns_cap_data, data));
> +static_assert(sizeof(struct vfs_cap_data) ==
> +             offsetof(struct vfs_ns_cap_data, rootid));
> +
>  #endif

It's a little orthogonal to the changes, but I can certainly add a patch
for this.

> > +/**
> > + * vfs_caps_to_xattr - convert vfs_caps to raw caps xattr data
> > + *
> > + * @idmap:       idmap of the mount the inode was found from
> > + * @dest_userns: user namespace for ids in xattr data
> > + * @vfs_caps:    source vfs_caps data
> > + * @data:        destination buffer for rax xattr caps data
> > + * @size:        size of the @data buffer
> > + *
> > + * Converts a kernel-interrnal capability into the raw security.capability
> 
> s/interrnal/internal/
> 
> > + * xattr format.
> > + *
> > + * If the xattr is being read or written through an idmapped mount the
> > + * idmap of the vfsmount must be passed through @idmap. This function
> > + * will then take care to map the rootid according to @idmap.
> > + *
> > + * Return: On success, return 0; on error, return < 0.
> > + */
> > +int vfs_caps_to_xattr(struct mnt_idmap *idmap,
> > +		      struct user_namespace *dest_userns,
> > +		      const struct vfs_caps *vfs_caps,
> > +		      void *data, int size)
> > +{
> > +	struct vfs_ns_cap_data *caps = data;
> > +	int ret;
> > +
> > +	ret = __vfs_caps_to_xattr(idmap, dest_userns, vfs_caps, data, size);
> > +	if (ret > 0 &&
> > +	    (vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) == VFS_CAP_REVISION_3 &&
> > +	     le32_to_cpu(caps->rootid) == (uid_t)-1)
> > +		return -EOVERFLOW;
> 
> I think the return value situation of these two helper is a bit
> confusing. So if they return the size or a negative error pointer the
> return value of both functions should likely be ssize_t.
> 
> But unless you actually later use the size in the callers of these
> helpers it would be easier to just stick with 0 on success, negative
> errno on failure. Note that that's what vfs_caps_from_xattr() is doing.
> 
> I'll see whether that becomes relevant later in the series though.

Size is relevant since the different versions have different xattr
sizes, and callers need to know how much data to write to disk or copy
to userspace. ssize_t probably is better though, so I'll change it.


