Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D2C26BC17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 08:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgIPGCF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 02:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgIPGCE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:02:04 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08E0C06174A;
        Tue, 15 Sep 2020 23:02:03 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4BrqHQ4VvqzQlKM;
        Wed, 16 Sep 2020 08:01:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id rBau5b8-cG3X; Wed, 16 Sep 2020 08:01:48 +0200 (CEST)
Date:   Wed, 16 Sep 2020 16:01:40 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vfs: add fchmodat2 syscall
Message-ID: <20200916060140.q3mueczygm6ulqii@yavin.dot.cyphar.com>
References: <20200916002157.GO3265@brightrain.aerifal.cx>
 <20200916002335.GQ3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uvgfaqz7hfk7e3hp"
Content-Disposition: inline
In-Reply-To: <20200916002335.GQ3265@brightrain.aerifal.cx>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -7.48 / 15.00 / 15.00
X-Rspamd-Queue-Id: 11F474F6
X-Rspamd-UID: 875351
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--uvgfaqz7hfk7e3hp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-15, Rich Felker <dalias@libc.org> wrote:
> POSIX defines fchmodat as having a 4th argument, flags, that can be
> AT_SYMLINK_NOFOLLOW. Support for changing the access mode of symbolic
> links is optional (EOPNOTSUPP allowed if not supported), but this flag
> is important even on systems where symlinks do not have access modes,
> since it's the only way to safely change the mode of a file which
> might be asynchronously replaced with a symbolic link, without a race
> condition whereby the link target is changed.

Could we also add AT_EMPTY_PATH support, so that you can fchmod an open
file in a race-free way without needing to go through procfs?

> It's possible to emulate AT_SYMLINK_NOFOLLOW in userspace, and both
> musl libc and glibc do this, by opening an O_PATH file descriptor and
> performing chmod on the corresponding magic symlink in /proc/self/fd.
> However, this requires procfs to be mounted and accessible.
>=20
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
>  arch/arm/tools/syscall.tbl                  |  1 +
>  arch/arm64/include/asm/unistd.h             |  2 +-
>  arch/arm64/include/asm/unistd32.h           |  2 ++
>  arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
>  arch/s390/kernel/syscalls/syscall.tbl       |  1 +
>  arch/sh/kernel/syscalls/syscall.tbl         |  1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
>  fs/open.c                                   | 17 ++++++++++++++---
>  include/linux/syscalls.h                    |  2 ++
>  include/uapi/asm-generic/unistd.h           |  4 +++-
>  21 files changed, 38 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index ec8bed9e7b75..5648fa8be7a1 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -479,3 +479,4 @@
>  547	common	openat2				sys_openat2
>  548	common	pidfd_getfd			sys_pidfd_getfd
>  549	common	faccessat2			sys_faccessat2
> +550	common	fchmodat2			sys_fchmodat2
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 171077cbf419..b6b715bb3315 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -453,3 +453,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	fchmodat2			sys_fchmodat2
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/uni=
std.h
> index 3b859596840d..b3b2019f8d16 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -38,7 +38,7 @@
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
> =20
> -#define __NR_compat_syscalls		440
> +#define __NR_compat_syscalls		441
>  #endif
> =20
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/u=
nistd32.h
> index 734860ac7cf9..cd0845f3c19f 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -887,6 +887,8 @@ __SYSCALL(__NR_openat2, sys_openat2)
>  __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
>  #define __NR_faccessat2 439
>  __SYSCALL(__NR_faccessat2, sys_faccessat2)
> +#define __NR_fchmodat2 440
> +__SYSCALL(__NR_fchmodat2, sys_fchmodat2)
> =20
>  /*
>   * Please add new compat syscalls above this comment and update
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/sys=
calls/syscall.tbl
> index f52a41f4c340..7c3f8564d0f3 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -360,3 +360,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	fchmodat2			sys_fchmodat2
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/sys=
calls/syscall.tbl
> index 81fc799d8392..063d875377bf 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -439,3 +439,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	fchmodat2			sys_fchmodat2
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaz=
e/kernel/syscalls/syscall.tbl
> index b4e263916f41..6aea8a435fd0 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -445,3 +445,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	fchmodat2			sys_fchmodat2
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel=
/syscalls/syscall_n32.tbl
> index f9df9edb67a4..a9205843251d 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -378,3 +378,4 @@
>  437	n32	openat2				sys_openat2
>  438	n32	pidfd_getfd			sys_pidfd_getfd
>  439	n32	faccessat2			sys_faccessat2
> +440	n32	fchmodat2			sys_fchmodat2
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel=
/syscalls/syscall_n64.tbl
> index 557f9954a2b9..31da28e2d6f3 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -354,3 +354,4 @@
>  437	n64	openat2				sys_openat2
>  438	n64	pidfd_getfd			sys_pidfd_getfd
>  439	n64	faccessat2			sys_faccessat2
> +440	n64	fchmodat2			sys_fchmodat2
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel=
/syscalls/syscall_o32.tbl
> index 195b43cf27c8..af0e38302ed8 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -427,3 +427,4 @@
>  437	o32	openat2				sys_openat2
>  438	o32	pidfd_getfd			sys_pidfd_getfd
>  439	o32	faccessat2			sys_faccessat2
> +440	o32	fchmodat2			sys_fchmodat2
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel=
/syscalls/syscall.tbl
> index def64d221cd4..379cdb44ca0b 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -437,3 +437,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	fchmodat2			sys_fchmodat2
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kern=
el/syscalls/syscall.tbl
> index c2d737ff2e7b..ada11db506e6 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -529,3 +529,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	fchmodat2			sys_fchmodat2
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/sys=
calls/syscall.tbl
> index 10456bc936fb..a4dae0abb353 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -442,3 +442,4 @@
>  437  common	openat2			sys_openat2			sys_openat2
>  438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
>  439  common	faccessat2		sys_faccessat2			sys_faccessat2
> +440  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscall=
s/syscall.tbl
> index ae0a00beea5f..b59b4408b85f 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -442,3 +442,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	fchmodat2			sys_fchmodat2
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/s=
yscalls/syscall.tbl
> index 4af114e84f20..e817416f81df 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -485,3 +485,4 @@
>  437	common	openat2			sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	fchmodat2			sys_fchmodat2
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/sysc=
alls/syscall_32.tbl
> index 9d1102873666..208b06650cef 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -444,3 +444,4 @@
>  437	i386	openat2			sys_openat2
>  438	i386	pidfd_getfd		sys_pidfd_getfd
>  439	i386	faccessat2		sys_faccessat2
> +440	i386	fchmodat2		sys_fchmodat2
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysc=
alls/syscall_64.tbl
> index f30d6ae9a688..d9a591db72fb 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -361,6 +361,7 @@
>  437	common	openat2			sys_openat2
>  438	common	pidfd_getfd		sys_pidfd_getfd
>  439	common	faccessat2		sys_faccessat2
> +440	common	fchmodat2		sys_fchmodat2
> =20
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel=
/syscalls/syscall.tbl
> index 6276e3c2d3fc..ff756cb2f5d7 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -410,3 +410,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	fchmodat2			sys_fchmodat2
> diff --git a/fs/open.c b/fs/open.c
> index cdb7964aaa6e..f492c782c0ed 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -616,11 +616,16 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, =
mode)
>  	return err;
>  }
> =20
> -static int do_fchmodat(int dfd, const char __user *filename, umode_t mod=
e)
> +static int do_fchmodat(int dfd, const char __user *filename, umode_t mod=
e, int flags)
>  {
>  	struct path path;
>  	int error;
>  	unsigned int lookup_flags =3D LOOKUP_FOLLOW;
> +
> +	if (flags & ~AT_SYMLINK_NOFOLLOW)
> +		return -EINVAL;
> +	if (flags & AT_SYMLINK_NOFOLLOW)
> +		lookup_flags &=3D ~LOOKUP_FOLLOW;
>  retry:
>  	error =3D user_path_at(dfd, filename, lookup_flags, &path);
>  	if (!error) {
> @@ -634,15 +639,21 @@ static int do_fchmodat(int dfd, const char __user *=
filename, umode_t mode)
>  	return error;
>  }
> =20
> +SYSCALL_DEFINE4(fchmodat2, int, dfd, const char __user *, filename,
> +		umode_t, mode, int, flags)
> +{
> +	return do_fchmodat(dfd, filename, mode, flags);
> +}
> +
>  SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename,
>  		umode_t, mode)
>  {
> -	return do_fchmodat(dfd, filename, mode);
> +	return do_fchmodat(dfd, filename, mode, 0);
>  }
> =20
>  SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
>  {
> -	return do_fchmodat(AT_FDCWD, filename, mode);
> +	return do_fchmodat(AT_FDCWD, filename, mode, 0);
>  }
> =20
>  int chown_common(const struct path *path, uid_t user, gid_t group)
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 75ac7f8ae93c..ced00c56eba7 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -435,6 +435,8 @@ asmlinkage long sys_chroot(const char __user *filenam=
e);
>  asmlinkage long sys_fchmod(unsigned int fd, umode_t mode);
>  asmlinkage long sys_fchmodat(int dfd, const char __user * filename,
>  			     umode_t mode);
> +asmlinkage long sys_fchmodat2(int dfd, const char __user * filename,
> +			      umode_t mode, int flags);
>  asmlinkage long sys_fchownat(int dfd, const char __user *filename, uid_t=
 user,
>  			     gid_t group, int flag);
>  asmlinkage long sys_fchown(unsigned int fd, uid_t user, gid_t group);
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic=
/unistd.h
> index 995b36c2ea7d..ebf5cdb3f444 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -859,9 +859,11 @@ __SYSCALL(__NR_openat2, sys_openat2)
>  __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
>  #define __NR_faccessat2 439
>  __SYSCALL(__NR_faccessat2, sys_faccessat2)
> +#define __NR_fchmodat2 440
> +__SYSCALL(__NR_fchmodat2, sys_fchmodat2)
> =20
>  #undef __NR_syscalls
> -#define __NR_syscalls 440
> +#define __NR_syscalls 441
> =20
>  /*
>   * 32 bit systems traditionally used different
> --=20
> 2.21.0
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--uvgfaqz7hfk7e3hp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCX2GqQgAKCRCdlLljIbnQ
EuWNAP0VB0wK1l68KKVdMdNPluHuL5Jf+/W0UKu1sCTjekvvuAD9GMl08MQTAMEW
0wojItuDyO0BNhtUTQ2ovHzPT5VTAQw=
=qT55
-----END PGP SIGNATURE-----

--uvgfaqz7hfk7e3hp--
