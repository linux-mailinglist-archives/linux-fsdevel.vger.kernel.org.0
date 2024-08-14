Return-Path: <linux-fsdevel+bounces-25918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57757951CDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 16:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B26B282CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB271B374C;
	Wed, 14 Aug 2024 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElDZefu4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C951B32B7;
	Wed, 14 Aug 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645158; cv=none; b=klLZ8I6zGXC/Udd0QCn9RdSwgiTSYPxkmfV3J72Hdmuk8Qi6wjNCl6tc+6+A/kxgtnvhW3mwYfdwJ8IL6aLURlAksLhlyubZ4SK101/COIKMRjpcvLT8ikk0cXPZe9fWQl+Jx72tL7u58jaibyvUtEazm8gCEJn/oFSHvLw+1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645158; c=relaxed/simple;
	bh=JhPntTP5E/lMm+yrUTNBTsDRXaK47bfXNjvD2Z8Ij9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3z1UAsyGBoW4rA/IRr1D/9Iv0DAnHGycJQWzPhGwM7ZBXJmDzE1nPEEwLKivZqZLJC0wFddOSaqM1Zg5lxxhxS9rzZDA7qVA5/WXlCXt4nN/wRXj8vYqs67I5cuX4pNv6W3gstTc210TN5y4dC+yhFILjWHIPqF+3+HMs64QQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElDZefu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBC2C32786;
	Wed, 14 Aug 2024 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723645157;
	bh=JhPntTP5E/lMm+yrUTNBTsDRXaK47bfXNjvD2Z8Ij9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElDZefu49+mXjySF/T/lcrR4mYRXXdGS3uFDJHchbGkyLuXMmZ9H7erabkX2OOYHn
	 4KLrqJ6I8FoT7pHEKgs+3xbd3DHn9uMPX08k6pO4W0tgA3nXetQsnqtxEjVV8SoP2g
	 jUump+joG+cE8nrNMcjL1zDnBUpcqgtDhd3AArnYm/RlCWJocZ0lClrmUhqseY2PgJ
	 Rvoy1lYkVqBY4iolFSWghUBOovl4mhpwrQlbaCT5dkuH5/YAUjFArKiFhBM+zusvH9
	 TLvP3kgzeGm5FvDwEoZrNk+HAgFHfdnUBQq/N4cKhkAaMzteeIpLIT9bV0LNmlJ4Sd
	 /NpUxS3D4trLQ==
Date: Wed, 14 Aug 2024 16:19:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] fs/fuse: allow idmapped mounts
Message-ID: <20240814-knochen-ersparen-9b3f366caac4@brauner>
References: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
 <20240814114034.113953-10-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240814114034.113953-10-aleksandr.mikhalitsyn@canonical.com>

On Wed, Aug 14, 2024 at 01:40:34PM GMT, Alexander Mikhalitsyn wrote:
> Now we have everything in place and we can allow idmapped mounts
> by setting the FS_ALLOW_IDMAP flag. Notice that real availability
> of idmapped mounts will depend on the fuse daemon. Fuse daemon
> have to set FUSE_ALLOW_IDMAP flag in the FUSE_INIT reply.
> 
> To discuss:
> - we enable idmapped mounts support only if "default_permissions" mode is enabled,
> because otherwise we would need to deal with UID/GID mappings in the userspace side OR
> provide the userspace with idmapped req->in.h.uid/req->in.h.gid values which is not
> something that we probably want to. Idmapped mounts phylosophy is not about faking
> caller uid/gid.
> 
> - We have a small offlist discussion with Christian around adding fs_type->allow_idmap
> hook. Christian pointed that it would be nice to have a superblock flag instead like
> SB_I_NOIDMAP and we can set this flag during mount time if we see that filesystem does not
> support idmappings. But, unfortunately I didn't succeed here because the kernel will
> know if the filesystem supports idmapping or not after FUSE_INIT request, but FUSE_INIT request
> is being sent at the end of mounting process, so mount and superblock will exist and
> visible by the userspace in that time. It seems like setting SB_I_NOIDMAP flag in this
> case is too late as user may do the trick with creating a idmapped mount while it wasn't
> restricted by SB_I_NOIDMAP. Alternatively, we can introduce a "positive" version SB_I_ALLOWIDMAP

Hm, I'm confused why won't the following (uncompiled) work?

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ed4c2688047f..8ead1cacdd2f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1346,10 +1346,12 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
                        if (flags & FUSE_OWNER_UID_GID_EXT)
                                fc->owner_uid_gid_ext = 1;
                        if (flags & FUSE_ALLOW_IDMAP) {
-                               if (fc->owner_uid_gid_ext && fc->default_permissions)
+                               if (fc->owner_uid_gid_ext && fc->default_permissions) {
                                        fc->allow_idmap = 1;
-                               else
+                                       fm->sb->s_iflags &= ~SB_I_NOIDMAP;
+                               } else {
                                        ok = false;
+                               }
                        }
                } else {
                        ra_pages = fc->max_read / PAGE_SIZE;
@@ -1576,6 +1578,7 @@ static void fuse_sb_defaults(struct super_block *sb)
        sb->s_time_gran = 1;
        sb->s_export_op = &fuse_export_operations;
        sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+       sb->s_iflags |= SB_I_NOIDMAP;
        if (sb->s_user_ns != &init_user_ns)
                sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
        sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
diff --git a/fs/namespace.c b/fs/namespace.c
index 328087a4df8a..d1702285c915 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4436,6 +4436,10 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
        if (!(m->mnt_sb->s_type->fs_flags & FS_ALLOW_IDMAP))
                return -EINVAL;

+       /* The filesystem has turned off idmapped mounts. */
+       if (m->mnt_sb->s_iflags & SB_I_NOIDMAP)
+               return -EINVAL;
+
        /* We're not controlling the superblock. */
        if (!ns_capable(fs_userns, CAP_SYS_ADMIN))
                return -EPERM;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..185004c41a5e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1189,6 +1189,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
 #define SB_I_RETIRED   0x00000800      /* superblock shouldn't be reused */
 #define SB_I_NOUMASK   0x00001000      /* VFS does not apply umask */
+#define SB_I_NOIDMAP   0x00002000      /* No idmapped mounts on this superblock */

 /* Possible states of 'frozen' field */
 enum {

