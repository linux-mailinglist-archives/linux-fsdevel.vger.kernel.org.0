Return-Path: <linux-fsdevel+bounces-4601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6B8801303
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 19:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98EAEB208C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D62951C30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9vMIDYP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310754D10B;
	Fri,  1 Dec 2023 17:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE8CC433C9;
	Fri,  1 Dec 2023 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701451438;
	bh=QOHfQ98nqwi1J2PTqSI0/MkweaWsRSnMcDSb7BkvBOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9vMIDYPf6fGlDBdjzQi9PZS9gxcBpq412PHC7r/ZK/odc6HD/kSB/HwMMMkZF8/v
	 2foMpBAradhjkVCJJWjA4OXh8d43H7RtalIEB5rdglfZrQ0PXMmfYp3ntnTwa+uzp4
	 lpH4Bsz0GCXyy5ytXIzm48N4Di7EciK62at7X0LzmQEw+e8Zn4RS6FPNeV2++4rsjP
	 x/kzpzhPcBmJrznimNCHRRWqNThDtan5ekp6BrrjFWiUTixRBC7uO0FlfuNlOz05hQ
	 c0SygCn6AuUc4Mlp12HZxzYSb8ZafJ8z2NYnpHY+nIk5ooeeAA7CUQdWx8qlI+fOMJ
	 LM+sAouKgsgBg==
Date: Fri, 1 Dec 2023 11:23:57 -0600
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
Subject: Re: [PATCH 06/16] capability: provide a helper for converting
 vfs_caps to xattr for userspace
Message-ID: <ZWoWrRgNDVRv6BTB@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-6-da5a26058a5b@kernel.org>
 <20231201-seide-famos-74e8c23ee2cc@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-seide-famos-74e8c23ee2cc@brauner>

On Fri, Dec 01, 2023 at 05:57:35PM +0100, Christian Brauner wrote:
> On Wed, Nov 29, 2023 at 03:50:24PM -0600, Seth Forshee (DigitalOcean) wrote:
> > cap_inode_getsecurity() implements a handful of policies for capability
> > xattrs read by userspace:
> > 
> >  - It returns EINVAL if the on-disk capability is in v1 format.
> > 
> >  - It masks off all bits in magic_etc except for the version and
> >    VFS_CAP_FLAGS_EFFECTIVE.
> > 
> >  - v3 capabilities are converted to v2 format if the rootid returned to
> >    userspace would be 0 or if the rootid corresponds to root in an
> >    ancestor user namespace.
> > 
> >  - It returns EOVERFLOW for a v3 capability whose rootid does not map to
> >    a valid id in current_user_ns() or to root in an ancestor namespace.
> 
> Nice. Precise and clear, please just drop these bullet points into the
> kernel-doc of that function.

Will do.

> > +/**
> > + * vfs_caps_to_user_xattr - convert vfs_caps to caps xattr for userspace
> > + *
> > + * @idmap:       idmap of the mount the inode was found from
> > + * @dest_userns: user namespace for ids in xattr data
> > + * @vfs_caps:    source vfs_caps data
> > + * @data:        destination buffer for rax xattr caps data
> > + * @size:        size of the @data buffer
> > + *
> > + * Converts a kernel-interrnal capability into the raw security.capability
> > + * xattr format. Includes permission checking and v2->v3 conversion as
> > + * appropriate.
> > + *
> > + * If the xattr is being read or written through an idmapped mount the
> > + * idmap of the vfsmount must be passed through @idmap. This function
> > + * will then take care to map the rootid according to @idmap.
> > + *
> > + * Return: On success, return 0; on error, return < 0.
> > + */
> > +int vfs_caps_to_user_xattr(struct mnt_idmap *idmap,
> > +			   struct user_namespace *dest_userns,
> > +			   const struct vfs_caps *vfs_caps,
> > +			   void *data, int size)
> > +{
> > +	struct vfs_ns_cap_data *ns_caps = data;
> > +	bool is_v3;
> > +	u32 magic;
> > +
> > +	/* Preserve previous behavior of returning EINVAL for v1 caps */
> > +	if ((vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) == VFS_CAP_REVISION_1)
> > +		return -EINVAL;
> > +
> > +	size = __vfs_caps_to_xattr(idmap, dest_userns, vfs_caps, data, size);
> > +	if (size < 0)
> > +		return size;
> > +
> > +	magic = vfs_caps->magic_etc &
> > +		(VFS_CAP_REVISION_MASK | VFS_CAP_FLAGS_EFFECTIVE);
> > +	ns_caps->magic_etc = cpu_to_le32(magic);
> > +
> > +	/*
> > +	 * If this is a v3 capability with a valid, non-zero rootid, return
> > +	 * the v3 capability to userspace. A v3 capability with a rootid of
> > +	 * 0 will be converted to a v2 capability below for compatibility
> > +	 * with old userspace.
> > +	 */
> > +	is_v3 = (vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) == VFS_CAP_REVISION_3;
> > +	if (is_v3) {
> > +		uid_t rootid = le32_to_cpu(ns_caps->rootid);
> > +		if (rootid != (uid_t)-1 && rootid != (uid_t)0)
> > +			return size;
> > +	}
> > +
> > +	if (!rootid_owns_currentns(vfs_caps->rootid))
> > +		return -EOVERFLOW;
> 
> For a v2 cap that we read vfs_caps->rootid will be vfsuid 0, right?
> So that means we're guaranteed to resolve that in the initial user
> namespace. IOW, rootid_owns_currentns() will indeed work with a pure v2
> cap. Ok. Just making sure that I understand that this won't cause
> EOVERFLOW for v2. But you would've likely seen that in tests right away.

Yes, that's all correct.

