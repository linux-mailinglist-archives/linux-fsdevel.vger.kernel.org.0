Return-Path: <linux-fsdevel+bounces-8366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD13D835729
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 18:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5ED281F88
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 17:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF61381D4;
	Sun, 21 Jan 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZItkOn+b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1124381B2;
	Sun, 21 Jan 2024 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705859462; cv=none; b=cjHeNsb4fQ14cg1pjVbJ4CR33DiBfEnktF5NiMlRHzdgvw0FYUhwkEyjoCe8iWe6UK9BvdhF1lNVVPoald7CMAGdtN1osQVmMvVoCfhjkgfNAL0GPTHOb+YCZ4fG2MFKwlmF8C+W3WsO4T+CrYoEPR7aNjzXqiAeo7KzJObE/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705859462; c=relaxed/simple;
	bh=S2b2p/D2DNsbjy01O3hEZtYO4Xn+sshl3AvTraPHDG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4Q1ZK7Lbs7wKGjGP3MRPZ5LZgnyrHKYUSA+/GK86iWxP7CyPk/QJOVC3GG5mk0MGaA8Y2J90ZN8WAPRgdnudW5VTRp/QegjA1Ex43g+0TBOocWLCe0hvrxssbA2slDrA1a2K5KYRXzIe4pW/cZp5p8T7XWlm8j5tUcwHAdvXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZItkOn+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F017AC433C7;
	Sun, 21 Jan 2024 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705859462;
	bh=S2b2p/D2DNsbjy01O3hEZtYO4Xn+sshl3AvTraPHDG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZItkOn+b56ZHJYmcWMaPMMn+yRtStVFTj8GE5pxMCokoOm+Q24SwIJidnN7IEftlq
	 7wUBwo/LP5Od8SixrDZKqFo+TRMGixpPL5afTrga1E1aTrp50VHsX6EZZaXmUsubh6
	 UmJA8e9EKikw8PUr7YfuBhQmH8yerCLtX42u5W+CiVdyTcp4ksmdJSIar2GgtYg3VM
	 ScZh0MxE3QA9pI9c0t3s+twqsYCjlxx3hyMmyA0x+yneN1aoCgRfhcdD5gLZi+iZqT
	 OuCSpZlPYqzXJ37pE4a1bGmwpSaxuUky55iJGdCYhKvWKjnu/gawMXrXRpwccYSpeT
	 C1wUVRnDDoJvQ==
Date: Sun, 21 Jan 2024 18:50:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/9] fuse: basic support for idmapped mounts
Message-ID: <20240121-pfeffer-erkranken-f32c63956aac@brauner>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>

On Mon, Jan 08, 2024 at 01:08:15PM +0100, Alexander Mikhalitsyn wrote:
> Dear friends,
> 
> This patch series aimed to provide support for idmapped mounts
> for fuse. We already have idmapped mounts support for almost all
> widely-used filesystems:
> * local (ext4, btrfs, xfs, fat, vfat, ntfs3, squashfs, f2fs, erofs, ZFS (out-of-tree))
> * network (ceph)
> 
> Git tree (based on https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?h=for-next):
> v1: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v1
> current: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts

Great work!

> Things to discuss:
> - we enable idmapped mounts support only if "default_permissions" mode is enabled,
> because otherwise, we would need to deal with UID/GID mappings on the userspace side OR
> provide the userspace with idmapped req->in.h.uid/req->in.h.gid values which is not
> something that we probably want to do. Idmapped mounts philosophy is not about faking
> caller uid/gid.

Having VFS idmaps but then outsourcing permission checking to userspace
is conceptually strange so requiring default_permissions is the correct
thing to do. 

> - We have a small offlist discussion with Christian about adding fs_type->allow_idmap
> hook. Christian pointed out that it would be nice to have a superblock flag instead like
> SB_I_NOIDMAP and we can set this flag during mount time if we see that the filesystem does not
> support idmappings. But, unfortunately, I didn't succeed here because the kernel will
> know if the filesystem supports idmapping or not after FUSE_INIT request, but FUSE_INIT request
> is being sent at the end of the mounting process, so the mount and superblock will exist and
> visible by the userspace in that time. It seems like setting SB_I_NOIDMAP flag, in this
> case, is too late as a user may do the trick by creating an idmapped mount while it wasn't
> restricted by SB_I_NOIDMAP. Alternatively, we can introduce a "positive" version SB_I_ALLOWIDMAP

I see.

> and a "weak" version of FS_ALLOW_IDMAP like FS_MAY_ALLOW_IDMAP. So if FS_MAY_ALLOW_IDMAP is set,
> then SB_I_ALLOWIDMAP has to be set on the superblock to allow the creation of an idmapped mount.
> But that's a matter of our discussion.

I dislike making adding a struct super_block method. Because it means that we
call into the filesystem from generic mount code and specifically with the
namespace semaphore held. If there's ever any network filesystem that e.g.,
calls to a hung server it will lockup the whole system. So I'm opposed to
calling into the filesystem here at all. It's also ugly because this is really
a vfs level change. The only involvement should be whether the filesystem type
can actually support this ideally.

I think we should handle this within FUSE. So we allow the creation of idmapped
mounts just based on FS_ALLOW_IDMAP. And if the server doesn't support the
FUSE_OWNER_UID_GID_EXT then we simply refuse all creation requests originating
from an idmapped mount. Either we return EOPNOSUPP or we return EOVERFLOW to
indicate that we can't represent the owner correctly because the server is
missing the required extension.

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 3f37ba6a7a10..0726da21150a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -606,8 +606,16 @@ static int get_create_ext(struct mnt_idmap *idmap,
                err = get_security_context(dentry, mode, &ext);
        if (!err && fc->create_supp_group)
                err = get_create_supp_group(dir, &ext);
-       if (!err && fc->owner_uid_gid_ext)
-               err = get_owner_uid_gid(idmap, fc, &ext);
+       if (!err) {
+               /*
+                * If the server doesn't support FUSE_OWNER_UID_GID_EXT and
+                * this is a creation request from an idmapped mount refuse it.
+                */
+               if (fc->owner_uid_gid_ext)
+                       err = get_owner_uid_gid(idmap, fc, &ext);
+               else if (idmap != &nop_mnt_idmap)
+                       err = -EOPNOTSUPP;
+       }

        if (!err && ext.size) {
                WARN_ON(args->in_numargs >= ARRAY_SIZE(args->in_args));

