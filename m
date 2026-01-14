Return-Path: <linux-fsdevel+bounces-73681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AE6D1EA3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27D8A303EBA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD73939527B;
	Wed, 14 Jan 2026 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHd56cTA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDA439341C
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392329; cv=none; b=WxE/TH29KAZQmO3gBlzL9ayqgZpNTR52wUVPkkFHl/0VKndlnlB9eNEL3TluASx915tzJtXEeYLcs3HfCbLQq88vN7A3gBmHdf9/eDAcATCxW4A4/RlWbdZIeUadGpBCErHI6nm446imqaevIgkiHQhkmIntu2GiXNcMbUhPsaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392329; c=relaxed/simple;
	bh=gV7woxEs+0wXMp6l0WwKDc4T7x+yRLaAFmqguzjaFWQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sWrkSV+edtvpwoRG7aj1QNd+Pb1TIQZ0QK7GO4oV2O+QyhumUZAM6NsvYp9QVt5DCbmwbpwESipkc2M7+pPWTkcmF74Xxz7PRB+IXR9Dtu+o6aL8YuzzEx2y9cJPs3BFWOXRgRh6Z4OH0NefpSUwNg3BfYe99uyfKEj7G/IHyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHd56cTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4045FC4CEF7;
	Wed, 14 Jan 2026 12:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768392329;
	bh=gV7woxEs+0wXMp6l0WwKDc4T7x+yRLaAFmqguzjaFWQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dHd56cTAplYkuCBzdrzYgmGzJozpomyTckALaqU6ILsdgytAvD/LMYQ7npF860gon
	 PltwvDxWbbCGmL/fBJ3vu80b5x6iFjs4cwfSxgax+VgLbKbHmdr6gnWO4Vy7PkLL02
	 xjlQ/9VwN9J8gYSJ4GvzbG+TH0iIl4T13USJNBu2bT7FpjWvUtt7V+pKJvkOdqWdWA
	 yFkzwZyoQv8RUGZolPIDJMW8UdHJyqJ6LT4wqBug1fbNyYZX+FB8MFLp8rud4BSwW5
	 lgX3eo0Td8QCyk37eTtE5bvMfcdnNaaZWQRzblioPYfF8XXnVTi04k6Qk+igRv7gPW
	 lXY5ejHwhZ7VQ==
Message-ID: <e26aace854f9aa6a7aab35a2705aaa5a95732775.camel@kernel.org>
Subject: Re: [RFC PATCH 5/4] fs: use nullfs unconditionally as the real
 rootfs
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
  Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Lennart
 Poettering	 <lennart@poettering.net>, Zbigniew
 =?UTF-8?Q?J=C4=99drzejewski-Szmek?=	 <zbyszek@in.waw.pl>, Josef Bacik
 <josef@toxicpanda.com>
Date: Wed, 14 Jan 2026 07:05:27 -0500
In-Reply-To: <20260114-nennwert-pixeln-da3a611f7c40@brauner>
References: <20260114-zarte-zerrbild-0e20b46eb1a6@brauner>
	 <20260114-nennwert-pixeln-da3a611f7c40@brauner>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-14 at 11:32 +0100, Christian Brauner wrote:
> Remove the "nullfs_rootfs" boot parameter and try to simply always use
> nullfs. The mutable rootfs will be mounted on top of it. Systems that
> don't use pivot_root() to pivot away from the real rootfs will have an
> additional mount stick around but that shouldn't be a problem at all. If
> it is we'll rever this commit.
>=20
> This also simplifies the boot process and removes the need for the
> traditional switch_root workarounds.
>=20
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  .../filesystems/ramfs-rootfs-initramfs.rst    | 24 ++-----
>  fs/namespace.c                                | 64 ++++++-------------
>  init/do_mounts.c                              | 20 ++----
>  init/do_mounts.h                              |  1 -
>  4 files changed, 32 insertions(+), 77 deletions(-)
>=20
> diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Docum=
entation/filesystems/ramfs-rootfs-initramfs.rst
> index a8899f849e90..165117a721ce 100644
> --- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
> +++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
> @@ -76,13 +76,8 @@ What is rootfs?
>  ---------------
> =20
>  Rootfs is a special instance of ramfs (or tmpfs, if that's enabled), whi=
ch is
> -always present in 2.6 systems.  Traditionally, you can't unmount rootfs =
for
> -approximately the same reason you can't kill the init process; rather th=
an
> -having special code to check for and handle an empty list, it's smaller =
and
> -simpler for the kernel to just make sure certain lists can't become empt=
y.
> -
> -However, if the kernel is booted with "nullfs_rootfs", an immutable empt=
y
> -filesystem called nullfs is used as the true root, with the mutable root=
fs
> +always present in Linux systems.  The kernel uses an immutable empty fil=
esystem
> +called nullfs as the true root of the VFS hierarchy, with the mutable ro=
otfs
>  (tmpfs/ramfs) mounted on top of it.  This allows pivot_root() and unmoun=
ting
>  of the initramfs to work normally.
> =20
> @@ -126,25 +121,14 @@ All this differs from the old initrd in several way=
s:
>      program.  See the switch_root utility, below.)
> =20
>    - When switching another root device, initrd would pivot_root and then
> -    umount the ramdisk.  Traditionally, initramfs is rootfs: you can nei=
ther
> -    pivot_root rootfs, nor unmount it.  Instead delete everything out of
> -    rootfs to free up the space (find -xdev / -exec rm '{}' ';'), overmo=
unt
> -    rootfs with the new root (cd /newmount; mount --move . /; chroot .),
> -    attach stdin/stdout/stderr to the new /dev/console, and exec the new=
 init.
> -
> -    Since this is a remarkably persnickety process (and involves deletin=
g
> -    commands before you can run them), the klibc package introduced a he=
lper
> -    program (utils/run_init.c) to do all this for you.  Most other packa=
ges
> -    (such as busybox) have named this command "switch_root".
> -
> -    However, if the kernel is booted with "nullfs_rootfs", pivot_root() =
works
> +    umount the ramdisk.  With nullfs as the true root, pivot_root() work=
s
>      normally from the initramfs.  Userspace can simply do::
> =20
>        chdir(new_root);
>        pivot_root(".", ".");
>        umount2(".", MNT_DETACH);
> =20
> -    This is the preferred method when nullfs_rootfs is enabled.
> +    This is the preferred method for switching root filesystems.
> =20
>  Populating initramfs:
>  ---------------------
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a44ebb2f1161..53d1055c1825 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -75,17 +75,6 @@ static int __init initramfs_options_setup(char *str)
> =20
>  __setup("initramfs_options=3D", initramfs_options_setup);
> =20
> -bool nullfs_rootfs =3D false;
> -
> -static int __init nullfs_rootfs_setup(char *str)
> -{
> -	if (*str)
> -		return 0;
> -	nullfs_rootfs =3D true;
> -	return 1;
> -}
> -__setup("nullfs_rootfs", nullfs_rootfs_setup);
> -
>  static u64 event;
>  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
>  static DEFINE_IDA(mnt_group_ida);
> @@ -4593,10 +4582,9 @@ int path_pivot_root(struct path *new, struct path =
*old)
>   * pointed to by put_old must yield the same directory as new_root. No o=
ther
>   * file system may be mounted on put_old. After all, new_root is a mount=
point.
>   *
> - * Also, the current root cannot be on the 'rootfs' (initial ramfs) file=
system
> - * unless the kernel was booted with "nullfs_rootfs". See
> - * Documentation/filesystems/ramfs-rootfs-initramfs.rst for alternatives
> - * in this situation.
> + * The immutable nullfs filesystem is mounted as the true root of the VF=
S
> + * hierarchy. The mutable rootfs (tmpfs/ramfs) is layered on top of this=
,
> + * allowing pivot_root() to work normally from initramfs.
>   *
>   * Notes:
>   *  - we don't move root/cwd if they are not at the root (reason: if som=
ething
> @@ -5993,49 +5981,39 @@ static void __init init_mount_tree(void)
>  	struct path root;
> =20
>  	/*
> -	 * When nullfs is used, we create two mounts:
> +	 * We create two mounts:
>  	 *
>  	 * (1) nullfs with mount id 1
>  	 * (2) mutable rootfs with mount id 2
>  	 *
>  	 * with (2) mounted on top of (1).
>  	 */
> -	if (nullfs_rootfs) {
> -		nullfs_mnt =3D vfs_kern_mount(&nullfs_fs_type, 0, "nullfs", NULL);
> -		if (IS_ERR(nullfs_mnt))
> -			panic("VFS: Failed to create nullfs");
> -	}
> +	nullfs_mnt =3D vfs_kern_mount(&nullfs_fs_type, 0, "nullfs", NULL);
> +	if (IS_ERR(nullfs_mnt))
> +		panic("VFS: Failed to create nullfs");
> =20
>  	mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", initramfs_options)=
;
>  	if (IS_ERR(mnt))
>  		panic("Can't create rootfs");
> =20
> -	if (nullfs_rootfs) {
> -		VFS_WARN_ON_ONCE(real_mount(nullfs_mnt)->mnt_id !=3D 1);
> -		VFS_WARN_ON_ONCE(real_mount(mnt)->mnt_id !=3D 2);
> +	VFS_WARN_ON_ONCE(real_mount(nullfs_mnt)->mnt_id !=3D 1);
> +	VFS_WARN_ON_ONCE(real_mount(mnt)->mnt_id !=3D 2);
> =20
> -		/* The namespace root is the nullfs mnt. */
> -		mnt_root		=3D real_mount(nullfs_mnt);
> -		init_mnt_ns.root	=3D mnt_root;
> +	/* The namespace root is the nullfs mnt. */
> +	mnt_root		=3D real_mount(nullfs_mnt);
> +	init_mnt_ns.root	=3D mnt_root;
> =20
> -		/* Mount mutable rootfs on top of nullfs. */
> -		root.mnt		=3D nullfs_mnt;
> -		root.dentry		=3D nullfs_mnt->mnt_root;
> +	/* Mount mutable rootfs on top of nullfs. */
> +	root.mnt		=3D nullfs_mnt;
> +	root.dentry		=3D nullfs_mnt->mnt_root;
> =20
> -		LOCK_MOUNT_EXACT(mp, &root);
> -		if (unlikely(IS_ERR(mp.parent)))
> -			panic("VFS: Failed to mount rootfs on nullfs");
> -		scoped_guard(mount_writer)
> -			attach_mnt(real_mount(mnt), mp.parent, mp.mp);
> +	LOCK_MOUNT_EXACT(mp, &root);
> +	if (unlikely(IS_ERR(mp.parent)))
> +		panic("VFS: Failed to mount rootfs on nullfs");
> +	scoped_guard(mount_writer)
> +		attach_mnt(real_mount(mnt), mp.parent, mp.mp);
> =20
> -		pr_info("VFS: Finished mounting rootfs on nullfs\n");
> -	} else {
> -		VFS_WARN_ON_ONCE(real_mount(mnt)->mnt_id !=3D 1);
> -
> -		/* The namespace root is the mutable rootfs. */
> -		mnt_root		=3D real_mount(mnt);
> -		init_mnt_ns.root	=3D mnt_root;
> -	}
> +	pr_info("VFS: Finished mounting rootfs on nullfs\n");
> =20
>  	/*
>  	 * We've dropped all locks here but that's fine. Not just are we
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 675397c8a7a4..df6847bcf1f2 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -493,21 +493,15 @@ void __init prepare_namespace(void)
>  out:
>  	devtmpfs_mount();
> =20
> -	if (nullfs_rootfs) {
> -		if (init_pivot_root(".", ".")) {
> -			pr_err("VFS: Failed to pivot into new rootfs\n");
> -			return;
> -		}
> -		if (init_umount(".", MNT_DETACH)) {
> -			pr_err("VFS: Failed to unmount old rootfs\n");
> -			return;
> -		}
> -		pr_info("VFS: Pivoted into new rootfs\n");
> +	if (init_pivot_root(".", ".")) {
> +		pr_err("VFS: Failed to pivot into new rootfs\n");
>  		return;
>  	}
> -
> -	init_mount(".", "/", NULL, MS_MOVE, NULL);
> -	init_chroot(".");
> +	if (init_umount(".", MNT_DETACH)) {
> +		pr_err("VFS: Failed to unmount old rootfs\n");
> +		return;
> +	}
> +	pr_info("VFS: Pivoted into new rootfs\n");
>  }
> =20
>  static bool is_tmpfs;
> diff --git a/init/do_mounts.h b/init/do_mounts.h
> index fbfee810aa89..6069ea3eb80d 100644
> --- a/init/do_mounts.h
> +++ b/init/do_mounts.h
> @@ -15,7 +15,6 @@
>  void  mount_root_generic(char *name, char *pretty_name, int flags);
>  void  mount_root(char *root_device_name);
>  extern int root_mountflags;
> -extern bool nullfs_rootfs;
> =20
>  static inline __init int create_dev(char *name, dev_t dev)
>  {

I like the idea of getting rid of the command-line option. Anything we
can do to make this more automatic seems like a good idea.

If you're worried about it, you could flip the command-line option
around: do the new method by default, but allow a command-line option=20
that makes it set up the rootfs the old way.
--=20
Jeff Layton <jlayton@kernel.org>

