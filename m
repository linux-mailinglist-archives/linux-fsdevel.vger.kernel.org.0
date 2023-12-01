Return-Path: <linux-fsdevel+bounces-4597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF18012FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 19:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F69280D04
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36305102E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cit9ZhmM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D84CB42;
	Fri,  1 Dec 2023 16:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2184BC433C7;
	Fri,  1 Dec 2023 16:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701449861;
	bh=6vMNAOKP66LLVDFXHE2xulBRP5+kbafGsKVcFcSK8FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cit9ZhmMSyoCkjy+grl3uTlHprsinUNvt+W4WTt7jmY5etF5kFiDFNW86HNCv/F4T
	 qNk4uU08eCKjfvXAD83amYZuHBdgachnDcJgtWLUXppplDKrWJhEi/ZBZcG27DI6p3
	 K+muHICLhXuSKDbuXwDQjlVKNooPfYRozMd1gFIgSVf3IuY9GImMa0FrHx/cyaXDif
	 U9hYz9pxe52m0hI3U481ER/Ga9db26BE48Aabe5d7N6XDgPvA0LWNenDKJmI9tv9Na
	 ZmNrlMhQ2ooFi8414P1dFkjKFgHHE4feh16izh9YD5bw16PUH/DoRkLYINUry4wyTh
	 T9/pJzWAi5cAQ==
Date: Fri, 1 Dec 2023 17:57:35 +0100
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
Subject: Re: [PATCH 06/16] capability: provide a helper for converting
 vfs_caps to xattr for userspace
Message-ID: <20231201-seide-famos-74e8c23ee2cc@brauner>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-6-da5a26058a5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129-idmap-fscap-refactor-v1-6-da5a26058a5b@kernel.org>

On Wed, Nov 29, 2023 at 03:50:24PM -0600, Seth Forshee (DigitalOcean) wrote:
> cap_inode_getsecurity() implements a handful of policies for capability
> xattrs read by userspace:
> 
>  - It returns EINVAL if the on-disk capability is in v1 format.
> 
>  - It masks off all bits in magic_etc except for the version and
>    VFS_CAP_FLAGS_EFFECTIVE.
> 
>  - v3 capabilities are converted to v2 format if the rootid returned to
>    userspace would be 0 or if the rootid corresponds to root in an
>    ancestor user namespace.
> 
>  - It returns EOVERFLOW for a v3 capability whose rootid does not map to
>    a valid id in current_user_ns() or to root in an ancestor namespace.

Nice. Precise and clear, please just drop these bullet points into the
kernel-doc of that function.

> 
> These policies must be maintained when converting vfs_caps to an xattr
> for userspace. Provide a vfs_caps_to_user_xattr() helper which will
> enforce these policies.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  include/linux/capability.h |  4 +++
>  security/commoncap.c       | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index cdd7d2d8855e..c0bd9447685b 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -218,6 +218,10 @@ int vfs_caps_to_xattr(struct mnt_idmap *idmap,
>  		      struct user_namespace *dest_userns,
>  		      const struct vfs_caps *vfs_caps,
>  		      void *data, int size);
> +int vfs_caps_to_user_xattr(struct mnt_idmap *idmap,
> +			   struct user_namespace *dest_userns,
> +			   const struct vfs_caps *vfs_caps,
> +			   void *data, int size);
>  
>  /* audit system wants to get cap info from files as well */
>  int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
> diff --git a/security/commoncap.c b/security/commoncap.c
> index ef37966f3522..c645330f83a0 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -789,6 +789,74 @@ int vfs_caps_to_xattr(struct mnt_idmap *idmap,
>  	return ret;
>  }
>  
> +/**
> + * vfs_caps_to_user_xattr - convert vfs_caps to caps xattr for userspace
> + *
> + * @idmap:       idmap of the mount the inode was found from
> + * @dest_userns: user namespace for ids in xattr data
> + * @vfs_caps:    source vfs_caps data
> + * @data:        destination buffer for rax xattr caps data
> + * @size:        size of the @data buffer
> + *
> + * Converts a kernel-interrnal capability into the raw security.capability
> + * xattr format. Includes permission checking and v2->v3 conversion as
> + * appropriate.
> + *
> + * If the xattr is being read or written through an idmapped mount the
> + * idmap of the vfsmount must be passed through @idmap. This function
> + * will then take care to map the rootid according to @idmap.
> + *
> + * Return: On success, return 0; on error, return < 0.
> + */
> +int vfs_caps_to_user_xattr(struct mnt_idmap *idmap,
> +			   struct user_namespace *dest_userns,
> +			   const struct vfs_caps *vfs_caps,
> +			   void *data, int size)
> +{
> +	struct vfs_ns_cap_data *ns_caps = data;
> +	bool is_v3;
> +	u32 magic;
> +
> +	/* Preserve previous behavior of returning EINVAL for v1 caps */
> +	if ((vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) == VFS_CAP_REVISION_1)
> +		return -EINVAL;
> +
> +	size = __vfs_caps_to_xattr(idmap, dest_userns, vfs_caps, data, size);
> +	if (size < 0)
> +		return size;
> +
> +	magic = vfs_caps->magic_etc &
> +		(VFS_CAP_REVISION_MASK | VFS_CAP_FLAGS_EFFECTIVE);
> +	ns_caps->magic_etc = cpu_to_le32(magic);
> +
> +	/*
> +	 * If this is a v3 capability with a valid, non-zero rootid, return
> +	 * the v3 capability to userspace. A v3 capability with a rootid of
> +	 * 0 will be converted to a v2 capability below for compatibility
> +	 * with old userspace.
> +	 */
> +	is_v3 = (vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) == VFS_CAP_REVISION_3;
> +	if (is_v3) {
> +		uid_t rootid = le32_to_cpu(ns_caps->rootid);
> +		if (rootid != (uid_t)-1 && rootid != (uid_t)0)
> +			return size;
> +	}
> +
> +	if (!rootid_owns_currentns(vfs_caps->rootid))
> +		return -EOVERFLOW;

For a v2 cap that we read vfs_caps->rootid will be vfsuid 0, right?
So that means we're guaranteed to resolve that in the initial user
namespace. IOW, rootid_owns_currentns() will indeed work with a pure v2
cap. Ok. Just making sure that I understand that this won't cause
EOVERFLOW for v2. But you would've likely seen that in tests right away.

> +
> +	/* This comes from a parent namespace. Return as a v2 capability. */
> +	if (is_v3) {
> +		magic = VFS_CAP_REVISION_2 |
> +			(vfs_caps->magic_etc & VFS_CAP_FLAGS_EFFECTIVE);
> +		ns_caps->magic_etc = cpu_to_le32(magic);
> +		ns_caps->rootid = cpu_to_le32(0);
> +		size = XATTR_CAPS_SZ_2;
> +	}
> +
> +	return size;
> +}
> +
>  /**
>   * get_vfs_caps_from_disk - retrieve vfs caps from disk
>   *
> 
> -- 
> 2.43.0
> 

