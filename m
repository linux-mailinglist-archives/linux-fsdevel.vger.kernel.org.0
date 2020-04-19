Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76FB1AF969
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 12:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgDSKoZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 06:44:25 -0400
Received: from mout-p-101.mailbox.org ([80.241.56.151]:18118 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgDSKoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 06:44:24 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 494mfZ31SmzKmZX;
        Sun, 19 Apr 2020 12:44:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id 1tc6z-XEnpVC; Sun, 19 Apr 2020 12:44:18 +0200 (CEST)
Date:   Sun, 19 Apr 2020 20:44:04 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, linux-arch@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 2/3] fs: openat2: Extend open_how to allow
 userspace-selected fds
Message-ID: <20200419104404.j4e5gxdn2duvmu6s@yavin.dot.cyphar.com>
References: <cover.1586830316.git.josh@joshtriplett.org>
 <f969e7d45a8e83efc1ca13d675efd8775f13f376.1586830316.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sf7fp3oycsacoxul"
Content-Disposition: inline
In-Reply-To: <f969e7d45a8e83efc1ca13d675efd8775f13f376.1586830316.git.josh@joshtriplett.org>
X-Rspamd-Queue-Id: 0050E176D
X-Rspamd-Score: -7.79 / 15.00 / 15.00
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--sf7fp3oycsacoxul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-13, Josh Triplett <josh@joshtriplett.org> wrote:
> Inspired by the X protocol's handling of XIDs, allow userspace to select
> the file descriptor opened by openat2, so that it can use the resulting
> file descriptor in subsequent system calls without waiting for the
> response to openat2.
>=20
> In io_uring, this allows sequences like openat2/read/close without
> waiting for the openat2 to complete. Multiple such sequences can
> overlap, as long as each uses a distinct file descriptor.

I'm not sure I understand this explanation -- how can you trigger a
syscall with an fd that hasn't yet been registered (unless you're just
hoping the race goes in your favour)?

> Add a new O_SPECIFIC_FD open flag to enable this behavior, only accepted
> by openat2 for now (ignored by open/openat like all unknown flags). Add
> an fd field to struct open_how (along with appropriate padding, and
> verify that the padding is 0 to allow replacing the padding with a field
> in the future).
>=20
> The file table has a corresponding new function
> get_specific_unused_fd_flags, which gets the specified file descriptor
> if O_SPECIFIC_FD is set (and the fd isn't -1); otherwise it falls back
> to get_unused_fd_flags, to simplify callers.
>=20
> The specified file descriptor must not already be open; if it is,
> get_specific_unused_fd_flags will fail with -EBUSY. This helps catch
> userspace errors.
>=20
> When O_SPECIFIC_FD is set, and fd is not -1, openat2 will use the
> specified file descriptor rather than finding the lowest available one.

I still don't like that you can enable this feature with O_SPECIFIC_FD
but then disable it by specifying fd as -1. I understand why this is
needed for pipe2() and socketpair() and that's totally fine, but I don't
think it makes sense for openat2() or other interfaces where there's
only one fd being returned -- what does it mean to say "give me a
specific fd, but actually I don't care what it is"?

I know this is a trade-off between consistency of O_SPECIFIC_FD
interfaces and having wart-less interfaces for each syscall, but I don't
think it breaks consistency to say "syscalls that only give you one fd
don't have a second way of disabling the feature -- just don't pass
O_SPECIFIC_FD".

> Test program:
>=20
>     #include <err.h>
>     #include <fcntl.h>
>     #include <stdio.h>
>     #include <unistd.h>
>=20
>     int main(void)
>     {
>         struct open_how how =3D {
> 	    .flags =3D O_RDONLY | O_SPECIFIC_FD,
> 	    .fd =3D 42
> 	};
>         int fd =3D openat2(AT_FDCWD, "/dev/null", &how, sizeof(how));
>         if (fd < 0)
>             err(1, "openat2");
>         printf("fd=3D%d\n", fd); // prints fd=3D42
>         return 0;
>     }
>=20
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
>  fs/fcntl.c                                    |  2 +-
>  fs/file.c                                     | 39 +++++++++++++++++++
>  fs/io_uring.c                                 |  3 +-
>  fs/open.c                                     |  8 +++-
>  include/linux/fcntl.h                         |  5 ++-
>  include/linux/file.h                          |  3 ++
>  include/uapi/asm-generic/fcntl.h              |  4 ++
>  include/uapi/linux/openat2.h                  |  3 ++
>  tools/testing/selftests/openat2/helpers.c     |  2 +-
>  tools/testing/selftests/openat2/helpers.h     | 21 +++++++---
>  .../testing/selftests/openat2/openat2_test.c  | 29 +++++++++++++-
>  11 files changed, 105 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 2e4c0fa2074b..0357ad667563 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -1033,7 +1033,7 @@ static int __init fcntl_init(void)
>  	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
>  	 * is defined as O_NONBLOCK on some platforms and not on others.
>  	 */
> -	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> +	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=3D
>  		HWEIGHT32(
>  			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
>  			__FMODE_EXEC | __FMODE_NONOTIFY));
> diff --git a/fs/file.c b/fs/file.c
> index ba06140d89af..0674c3a2d3a5 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -567,6 +567,45 @@ void put_unused_fd(unsigned int fd)
> =20
>  EXPORT_SYMBOL(put_unused_fd);
> =20
> +int __get_specific_unused_fd_flags(unsigned int fd, unsigned int flags,
> +				   unsigned long nofile)
> +{
> +	int ret;
> +	struct fdtable *fdt;
> +	struct files_struct *files =3D current->files;
> +
> +	if (!(flags & O_SPECIFIC_FD) || fd =3D=3D UINT_MAX)
> +		return __get_unused_fd_flags(flags, nofile);
> +
> +	if (fd >=3D nofile)
> +		return -EBADF;
> +
> +	spin_lock(&files->file_lock);
> +	ret =3D expand_files(files, fd);
> +	if (unlikely(ret < 0))
> +		goto out_unlock;
> +	fdt =3D files_fdtable(files);
> +	if (fdt->fd[fd]) {
> +		ret =3D -EBUSY;
> +		goto out_unlock;
> +	}
> +	__set_open_fd(fd, fdt);
> +	if (flags & O_CLOEXEC)
> +		__set_close_on_exec(fd, fdt);
> +	else
> +		__clear_close_on_exec(fd, fdt);
> +	ret =3D fd;
> +
> +out_unlock:
> +	spin_unlock(&files->file_lock);
> +	return ret;
> +}
> +
> +int get_specific_unused_fd_flags(unsigned int fd, unsigned int flags)
> +{
> +	return __get_specific_unused_fd_flags(fd, flags, rlimit(RLIMIT_NOFILE));
> +}
> +
>  /*
>   * Install a file pointer in the fd array.
>   *
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 358f97be9c7b..4a69e1daf3fe 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2997,7 +2997,8 @@ static int io_openat2(struct io_kiocb *req, bool fo=
rce_nonblock)
>  	if (ret)
>  		goto err;
> =20
> -	ret =3D __get_unused_fd_flags(req->open.how.flags, req->open.nofile);
> +	ret =3D __get_specific_unused_fd_flags(req->open.how.fd,
> +			req->open.how.flags, req->open.nofile);
>  	if (ret < 0)
>  		goto err;
> =20
> diff --git a/fs/open.c b/fs/open.c
> index 719b320ede52..c1c2dd2d408d 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -962,6 +962,8 @@ inline struct open_how build_open_how(int flags, umod=
e_t mode)
>  		.mode =3D mode & S_IALLUGO,
>  	};
> =20
> +	/* O_SPECIFIC_FD doesn't work in open calls that use build_open_how. */
> +	how.flags &=3D ~O_SPECIFIC_FD;
>  	/* O_PATH beats everything else. */
>  	if (how.flags & O_PATH)
>  		how.flags &=3D O_PATH_FLAGS;
> @@ -989,6 +991,10 @@ inline int build_open_flags(const struct open_how *h=
ow, struct open_flags *op)
>  		return -EINVAL;
>  	if (how->resolve & ~VALID_RESOLVE_FLAGS)
>  		return -EINVAL;
> +	if (how->pad !=3D 0)
> +		return -EINVAL;
> +	if (!(flags & O_SPECIFIC_FD) && how->fd !=3D 0)
> +		return -EINVAL;
> =20
>  	/* Deal with the mode. */
>  	if (WILL_CREATE(flags)) {
> @@ -1143,7 +1149,7 @@ static long do_sys_openat2(int dfd, const char __us=
er *filename,
>  	if (IS_ERR(tmp))
>  		return PTR_ERR(tmp);
> =20
> -	fd =3D get_unused_fd_flags(how->flags);
> +	fd =3D get_specific_unused_fd_flags(how->fd, how->flags);
>  	if (fd >=3D 0) {
>  		struct file *f =3D do_filp_open(dfd, tmp, &op);
>  		if (IS_ERR(f)) {
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index 7bcdcf4f6ab2..728849bcd8fa 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -10,7 +10,7 @@
>  	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC |=
 \
>  	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
>  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> -	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> +	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_SPECIFIC_FD)
> =20
>  /* List of all valid flags for the how->upgrade_mask argument: */
>  #define VALID_UPGRADE_FLAGS \
> @@ -23,7 +23,8 @@
> =20
>  /* List of all open_how "versions". */
>  #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
> -#define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER0
> +#define OPEN_HOW_SIZE_VER1	32 /* added fd and pad */
> +#define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER1
> =20
>  #ifndef force_o_largefile
>  #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
> diff --git a/include/linux/file.h b/include/linux/file.h
> index b67986f818d2..a63301864a36 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -87,6 +87,9 @@ extern void set_close_on_exec(unsigned int fd, int flag=
);
>  extern bool get_close_on_exec(unsigned int fd);
>  extern int __get_unused_fd_flags(unsigned flags, unsigned long nofile);
>  extern int get_unused_fd_flags(unsigned flags);
> +extern int __get_specific_unused_fd_flags(unsigned int fd, unsigned int =
flags,
> +	unsigned long nofile);
> +extern int get_specific_unused_fd_flags(unsigned int fd, unsigned int fl=
ags);
>  extern void put_unused_fd(unsigned int fd);
>  extern unsigned int increase_min_fd(unsigned int num);
> =20
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/=
fcntl.h
> index 9dc0bf0c5a6e..d3de5b8b3955 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -89,6 +89,10 @@
>  #define __O_TMPFILE	020000000
>  #endif
> =20
> +#ifndef O_SPECIFIC_FD
> +#define O_SPECIFIC_FD	01000000000	/* open as specified fd */
> +#endif
> +
>  /* a horrid kludge trying to make sure that this will fail on old kernel=
s */
>  #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
>  #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)     =20
> diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
> index 58b1eb711360..63974a276fb2 100644
> --- a/include/uapi/linux/openat2.h
> +++ b/include/uapi/linux/openat2.h
> @@ -15,11 +15,14 @@
>   * @flags: O_* flags.
>   * @mode: O_CREAT/O_TMPFILE file mode.
>   * @resolve: RESOLVE_* flags.
> + * @fd: Specific file descriptor to use, for O_SPECIFIC_FD.
>   */
>  struct open_how {
>  	__u64 flags;
>  	__u64 mode;
>  	__u64 resolve;
> +	__u32 fd;
> +	__u32 pad; /* Must be 0 in the current version */
>  };
> =20
>  /* how->resolve flags for openat2(2). */
> diff --git a/tools/testing/selftests/openat2/helpers.c b/tools/testing/se=
lftests/openat2/helpers.c
> index 5074681ffdc9..b6533f0b1124 100644
> --- a/tools/testing/selftests/openat2/helpers.c
> +++ b/tools/testing/selftests/openat2/helpers.c
> @@ -98,7 +98,7 @@ void __attribute__((constructor)) init(void)
>  	struct open_how how =3D {};
>  	int fd;
> =20
> -	BUILD_BUG_ON(sizeof(struct open_how) !=3D OPEN_HOW_SIZE_VER0);
> +	BUILD_BUG_ON(sizeof(struct open_how) !=3D OPEN_HOW_SIZE_VER1);
> =20
>  	/* Check openat2(2) support. */
>  	fd =3D sys_openat2(AT_FDCWD, ".", &how);
> diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/se=
lftests/openat2/helpers.h
> index a6ea27344db2..b7dea87c17b9 100644
> --- a/tools/testing/selftests/openat2/helpers.h
> +++ b/tools/testing/selftests/openat2/helpers.h
> @@ -24,28 +24,37 @@
>  #endif /* SYS_openat2 */
> =20
>  /*
> - * Arguments for how openat2(2) should open the target path. If @resolve=
 is
> - * zero, then openat2(2) operates very similarly to openat(2).
> + * Arguments for how openat2(2) should open the target path. If only @fl=
ags and
> + * @mode are non-zero, then openat2(2) operates very similarly to openat=
(2).
>   *
> - * However, unlike openat(2), unknown bits in @flags result in -EINVAL r=
ather
> - * than being silently ignored. @mode must be zero unless one of {O_CREA=
T,
> - * O_TMPFILE} are set.
> + * However, unlike openat(2), unknown or invalid bits in @flags result in
> + * -EINVAL rather than being silently ignored. @mode must be zero unless=
 one of
> + * {O_CREAT, O_TMPFILE} are set.
>   *
>   * @flags: O_* flags.
>   * @mode: O_CREAT/O_TMPFILE file mode.
>   * @resolve: RESOLVE_* flags.
> + * @fd: Specific file descriptor to use, for O_SPECIFIC_FD.
>   */
>  struct open_how {
>  	__u64 flags;
>  	__u64 mode;
>  	__u64 resolve;
> +	__u32 fd;
> +	__u32 pad; /* Must be 0 in the current version */

Small nit: This field should be called __padding to make it more
explicit it's something internal and shouldn't be looked at by
userspace. And the comment should just be "must be zeroed".

>  };
> =20
> +/* List of all open_how "versions". */
>  #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
> -#define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER0
> +#define OPEN_HOW_SIZE_VER1	32 /* added fd and pad */
> +#define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER1
> =20
>  bool needs_openat2(const struct open_how *how);
> =20
> +#ifndef O_SPECIFIC_FD
> +#define O_SPECIFIC_FD  01000000000
> +#endif
> +
>  #ifndef RESOLVE_IN_ROOT
>  /* how->resolve flags for openat2(2). */
>  #define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
> diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testi=
ng/selftests/openat2/openat2_test.c
> index b386367c606b..cf21a83c70c9 100644
> --- a/tools/testing/selftests/openat2/openat2_test.c
> +++ b/tools/testing/selftests/openat2/openat2_test.c
> @@ -40,7 +40,7 @@ struct struct_test {
>  	int err;
>  };
> =20
> -#define NUM_OPENAT2_STRUCT_TESTS 7
> +#define NUM_OPENAT2_STRUCT_TESTS 8
>  #define NUM_OPENAT2_STRUCT_VARIATIONS 13
> =20
>  void test_openat2_struct(void)
> @@ -52,6 +52,9 @@ void test_openat2_struct(void)
>  		{ .name =3D "normal struct",
>  		  .arg.inner.flags =3D O_RDONLY,
>  		  .size =3D sizeof(struct open_how) },
> +		{ .name =3D "v0 struct",
> +		  .arg.inner.flags =3D O_RDONLY,
> +		  .size =3D OPEN_HOW_SIZE_VER0 },
>  		/* Bigger struct, with zeroed out end. */
>  		{ .name =3D "bigger struct (zeroed out)",
>  		  .arg.inner.flags =3D O_RDONLY,
> @@ -155,7 +158,7 @@ struct flag_test {
>  	int err;
>  };
> =20
> -#define NUM_OPENAT2_FLAG_TESTS 23
> +#define NUM_OPENAT2_FLAG_TESTS 29
> =20
>  void test_openat2_flags(void)
>  {
> @@ -223,6 +226,24 @@ void test_openat2_flags(void)
>  		{ .name =3D "invalid how.resolve and O_PATH",
>  		  .how.flags =3D O_PATH,
>  		  .how.resolve =3D 0x1337, .err =3D -EINVAL },
> +
> +		/* O_SPECIFIC_FD tests */
> +		{ .name =3D "O_SPECIFIC_FD",
> +		  .how.flags =3D O_RDONLY | O_SPECIFIC_FD, .how.fd =3D 42 },
> +		{ .name =3D "O_SPECIFIC_FD if fd exists",
> +		  .how.flags =3D O_RDONLY | O_SPECIFIC_FD, .how.fd =3D 2,
> +		  .err =3D -EBUSY },
> +		{ .name =3D "O_SPECIFIC_FD with fd -1",
> +		  .how.flags =3D O_RDONLY | O_SPECIFIC_FD, .how.fd =3D -1 },
> +		{ .name =3D "fd without O_SPECIFIC_FD",
> +		  .how.flags =3D O_RDONLY, .how.fd =3D 42,
> +		  .err =3D -EINVAL },
> +		{ .name =3D "fd -1 without O_SPECIFIC_FD",
> +		  .how.flags =3D O_RDONLY, .how.fd =3D -1,
> +		  .err =3D -EINVAL },
> +		{ .name =3D "existing fd without O_SPECIFIC_FD",
> +		  .how.flags =3D O_RDONLY, .how.fd =3D 2,
> +		  .err =3D -EINVAL },

It would be good to add a test to make sure that a non-zero value of
how->__padding also gives -EINVAL.

>  	};
> =20
>  	BUILD_BUG_ON(ARRAY_LEN(tests) !=3D NUM_OPENAT2_FLAG_TESTS);
> @@ -268,6 +289,10 @@ void test_openat2_flags(void)
>  			if (!(test->how.flags & O_LARGEFILE))
>  				fdflags &=3D ~O_LARGEFILE;
>  			failed |=3D (fdflags !=3D test->how.flags);
> +
> +			if (test->how.flags & O_SPECIFIC_FD
> +			    && test->how.fd !=3D -1)
> +				failed |=3D (fd !=3D test->how.fd);
>  		}
> =20
>  		if (failed) {
> --=20
> 2.26.0
>=20


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--sf7fp3oycsacoxul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXpwrcQAKCRCdlLljIbnQ
EgrqAQCyOyZICl1GRqDHXI7/LzLnAKSwaDlysVYeW+BA5CxlDwEA3aSfVFR/b8W0
SW48hvipk3aSeiyRoIxgh5lk9i3X8Ak=
=WjfK
-----END PGP SIGNATURE-----

--sf7fp3oycsacoxul--
