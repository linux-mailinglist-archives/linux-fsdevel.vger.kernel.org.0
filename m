Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1B3121E20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 23:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfLPWeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 17:34:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:60992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfLPWeX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:34:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 55D07AD14;
        Mon, 16 Dec 2019 22:34:21 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     quentin.bouget@cea.fr, linux-fsdevel@vger.kernel.org
Date:   Tue, 17 Dec 2019 09:34:14 +1100
Cc:     MARTINET Dominique 606316 <dominique.martinet@cea.fr>,
        Andreas Dilger <adilger@whamcloud.com>,
        NeilBrown <neilb@suse.com>
Subject: Re: open_by_handle_at: mount_fd opened with O_PATH
In-Reply-To: <2759fc54-9576-aaa0-926a-cad9d09d388c@cea.fr>
References: <2759fc54-9576-aaa0-926a-cad9d09d388c@cea.fr>
Message-ID: <87d0cnhpcp.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16 2019, quentin.bouget@cea.fr wrote:

> Hello,
>
> I recently noticed that the syscall open_by_handle_at() automatically=20
> fails if
> its first argument is a file descriptor opened with O_PATH. I looked at=20
> the code
> and saw no reason this could not be allowed. Attached to this mail are a
> a reproducer and the patch I came up with.
>
> I am not quite familiar with the kernel's way of processing patches. Any=
=20
> pointer
> or advice on this matter is very welcome.

It is probably worth reading through Documentation/process/,
particularly
   5.Posting.rst
We generally like the email to be the commit.  If you have comments to
make that really don't need to get included in the git commit, they can
go after the "---" after the Signed-off-by.

Also including a reproducer is great, but inline is generally preferred
to attachments as long as it isn't too big.

When making API changes (which this fix does), it is best to Cc
linux-api@vger.kernel.org.

You might also like to submit a separate patch to linux man-pages
to update the open(2) man page to include open_by_handle_at
in the list of "operations [that] can be performed on the resulting file de=
scriptor"
in the section about O_PATH, but just cc:ing linux-api might be enough,
depending on how busy Michael is.

Thanks,
NeilBrown

>
> Cheers,
> Quentin Bouget
>
> #define _GNU_SOURCE
> #include <errno.h>
> #include <error.h>
> #include <fcntl.h>
> #include <stdlib.h>
> #include <unistd.h>
>
> int
> main()
> {
>     struct file_handle *fhandle;
>     const char *pathname =3D "/";
>     int mount_fd;
>     int mountid;
>     int fd;
>
>     fhandle =3D malloc(sizeof(*fhandle) + 128);
>     if (fhandle =3D=3D NULL)
>         error(EXIT_FAILURE, errno, "malloc");
>     fhandle->handle_bytes =3D 128;
>
>     fd =3D open(pathname, O_RDONLY | O_PATH | O_NOFOLLOW);
>     if (fd < 0)
>         error(EXIT_FAILURE, errno, "open");
>
>     if (name_to_handle_at(fd, "", fhandle, &mountid, AT_EMPTY_PATH))
>         error(EXIT_FAILURE, errno, "name_to_handle_at");
>
>     mount_fd =3D fd;
>     fd =3D open_by_handle_at(mount_fd, fhandle, O_RDONLY | O_PATH | O_NOF=
OLLOW);
>     if (fd < 0)
>         error(EXIT_FAILURE, errno, "open_by_handle_at");
>
>     if (close(fd))
>         error(EXIT_FAILURE, errno, "close");
>
>     if (close(mount_fd))
>         error(EXIT_FAILURE, errno, "close");
>
>     free(fhandle);
>
>     return EXIT_SUCCESS;
> }
> From e3717e276444c5711335d398c29beedaf61bac82 Mon Sep 17 00:00:00 2001
> From: Quentin Bouget <quentin.bouget@cea.fr>
> Date: Thu, 24 Oct 2019 16:54:54 +0200
> Subject: [PATCH] vfs: let open_by_handle_at() use mount_fd opened with O_=
PATH
>
> The first argument of open_by_handle_at() is `mount_fd':
>
>> a file descriptor for any object (file, directory, etc.) in the
>> mounted filesystem with respect to which `handle' should be
>> interpreted.
>
> This patch allows for this file descriptor to be opened with O_PATH.
>
> Signed-off-by: Quentin Bouget <quentin.bouget@cea.fr>
> ---
>  fs/fhandle.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 01263ffbc..8b67f1b9e 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -112,22 +112,33 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const =
char __user *, name,
>  	return err;
>  }
>=20=20
> +static struct vfsmount *get_vfsmount_from_cwd(void)
> +{
> +	struct fs_struct *fs =3D current->fs;
> +	struct vfsmount *mnt;
> +
> +	spin_lock(&fs->lock);
> +	mnt =3D mntget(fs->pwd.mnt);
> +	spin_unlock(&fs->lock);
> +
> +	return mnt;
> +}
> +
>  static struct vfsmount *get_vfsmount_from_fd(int fd)
>  {
>  	struct vfsmount *mnt;
> +	struct path path;
> +	int err;
>=20=20
> -	if (fd =3D=3D AT_FDCWD) {
> -		struct fs_struct *fs =3D current->fs;
> -		spin_lock(&fs->lock);
> -		mnt =3D mntget(fs->pwd.mnt);
> -		spin_unlock(&fs->lock);
> -	} else {
> -		struct fd f =3D fdget(fd);
> -		if (!f.file)
> -			return ERR_PTR(-EBADF);
> -		mnt =3D mntget(f.file->f_path.mnt);
> -		fdput(f);
> -	}
> +	if (fd =3D=3D AT_FDCWD)
> +		return get_vfsmount_from_cwd();
> +
> +	err =3D filename_lookup(fd, getname_kernel(""), LOOKUP_EMPTY, &path, NU=
LL);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	mnt =3D mntget(path.mnt);
> +	path_put(&path);
>  	return mnt;
>  }
>=20=20
> --=20
> 2.18.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl34BmYACgkQOeye3VZi
gblYUg/9HebtisUvv845mD3YohDE2XHyZnMLUH65RvexQwDGVipt3R71JksJMvsF
rNN2IDeEw6ratiHUbnIPitwJvvVa5rOKrZZioCz09vaPe0L42aJVi/TQvGrI827z
Z1iipgTHVkd7T8kGqjlT+cy0HVAtO+YlMwwJuIlGl1X5dxdCvwGoTUJjpIB67ooq
YV1RNlfvWJ5S0lNPnQbVlkuAGeo+ZRWQkmZG5eJmrA6oP2UQhRG3/e9ZtduCnoXp
UEm03MPTNVVIfQdmf2aKZyx5Lgtjhidy1EBzhyzvVdiHnxX7RymYMfB5tuSjD3Nv
XuRgrIuwHe4gBF50VKE2XcG6IeFWzewb9kHuir74lB4CxAvKnJ0vokmfwQc7VxfI
1dH3mn/48aS48qb2qaYyYpS71ikKBQxMhdrhyMMbjLQNUwGy5VRqE9yGmPD/WczY
d33w7QjCFmp8YDdr1Npzvpgj1tRSt98hYDCHHCITktR1NoO71T3tj9O59nOAH9T4
j7vi2OIX0HMur4qg9gvW4IMtfFXKpiqN6xUEIa7k1p4b8zOaW9EeNsMgT2qNJzVK
n7yckcjfBU3T30D6vUDCvfzNYkLZBp7wBZn/cu/1xavb/d3Ja9arTPck30DSrHyh
5nBV97HSKXfakmWrowQsy51PgfrlQC64Nkh/uzn9hXlPj+Wsqyo=
=vcRk
-----END PGP SIGNATURE-----
--=-=-=--
