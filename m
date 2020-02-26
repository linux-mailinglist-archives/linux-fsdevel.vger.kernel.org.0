Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B730516F59D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 03:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgBZC3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 21:29:36 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:60240 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgBZC3f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:29:35 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 48S0B207v7zQlBN;
        Wed, 26 Feb 2020 03:29:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id bKZRoxL52J_Y; Wed, 26 Feb 2020 03:29:24 +0100 (CET)
Date:   Wed, 26 Feb 2020 13:29:13 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/17] fsinfo: Add fsinfo() syscall to query filesystem
 information [ver #17]
Message-ID: <20200226022913.i2b3rnb3ua4dlym3@yavin.dot.cyphar.com>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <158230816405.2185128.14624101691579582829.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xmvp4mevtdwkh2f4"
Content-Disposition: inline
In-Reply-To: <158230816405.2185128.14624101691579582829.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--xmvp4mevtdwkh2f4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-21, David Howells <dhowells@redhat.com> wrote:
> Add a system call to allow filesystem information to be queried.  A reque=
st
> value can be given to indicate the desired attribute.  Support is provided
> for enumerating multi-value attributes.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> NEW SYSTEM CALL
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The new system call looks like:
>=20
> 	int ret =3D fsinfo(int dfd,
> 			 const char *filename,
> 			 const struct fsinfo_params *params,
> 			 void *buffer,
> 			 size_t buf_size);
>=20
> The params parameter optionally points to a block of parameters:
>=20
> 	struct fsinfo_params {
> 		__u32	at_flags;
> 		__u32	flags;
> 		__u32	request;
> 		__u32	Nth;
> 		__u32	Mth;
> 		__u64	__reserved[3];
> 	};
>=20
> If params is NULL, it is assumed params->request should be
> FSINFO_ATTR_STATFS, params->Nth should be 0, params->Mth should be 0,
> params->at_flags should be 0 and params->flags should be 0.
>=20
> If params is given, all of params->__reserved[] must be 0.

I would suggest that rather than having a reserved field for future
extensions, you make use of copy_struct_from_user() and have extensible
structs:

	int ret =3D fsinfo(int dfd,
			 const char *filename,
			 struct fsinfo_params *params,
			 size_t params_usize,
			 void *buffer,
			 size_t buf_usize);

 	struct fsinfo_params {
 		__u64	flags;
 		__u32	at_flags;
 		__u32	request;
 		__u32	Nth;
 		__u32	Mth;
 	};

I dropped the "const" on fsinfo_params because the planned CHECK_FiELDS
feature for extensible-struct syscalls requires writing to the struct. I
also switched the flags field to u64 because CHECK_FiELDS is intended to
use (1<<63) for all syscalls (this has the nice benefit of removing the
need of a padding field entirely).

> dfd, filename and params->at_flags indicate the file to query.  There is =
no
> equivalent of lstat() as that can be emulated with fsinfo() by setting
> AT_SYMLINK_NOFOLLOW in params->at_flags.

Minor gripe -- can we make the default be AT_SYMLINK_NOFOLLOW and you
need to explicitly pass AT_SYMLINK_FOLLOW? Accidentally following
symlinks is a constant source of security bugs.

> There is also no equivalent of fstat() as that can be emulated by
> passing a NULL filename to fsinfo() with the fd of interest in dfd.

Presumably you also need to pass AT_EMPTY_PATH?

> params->request indicates the attribute/attributes to be queried.  This c=
an
> be one of:
>=20
> 	FSINFO_ATTR_STATFS		- statfs-style info
> 	FSINFO_ATTR_IDS			- Filesystem IDs
> 	FSINFO_ATTR_LIMITS		- Filesystem limits
> 	FSINFO_ATTR_SUPPORTS		- What's supported in statx(), IOC flags
> 	FSINFO_ATTR_TIMESTAMP_INFO	- Inode timestamp info
> 	FSINFO_ATTR_VOLUME_ID		- Volume ID (string)
> 	FSINFO_ATTR_VOLUME_UUID		- Volume UUID
> 	FSINFO_ATTR_VOLUME_NAME		- Volume name (string)
> 	FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO - Information about attr Nth
> 	FSINFO_ATTR_FSINFO_ATTRIBUTES	- List of supported attrs
>=20
> Some attributes (such as the servers backing a network filesystem) can ha=
ve
> multiple values.  These can be enumerated by setting params->Nth and
> params->Mth to 0, 1, ... until ENODATA is returned.
>=20
> buffer and buf_size point to the reply buffer.  The buffer is filled up to
> the specified size, even if this means truncating the reply.  The full si=
ze
> of the reply is returned.  In future versions, this will allow extra fiel=
ds
> to be tacked on to the end of the reply, but anyone not expecting them wi=
ll
> only get the subset they're expecting.  If either buffer of buf_size are =
0,
> no copy will take place and the data size will be returned.

Sounds good, though I think we should zero-fill the tail end of the
buffer (if the buffer is larger than the in-kernel one). This is
basically what a theoretical copy_struct_to_user() would do. It will
also ensure that CHECK_FiELDS will act consistently on a syscall that
has two extensible struct arguments.

> At the moment, this will only work on x86_64 and i386 as it requires the
> system call to be wired up.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-api@vger.kernel.org
> ---
>=20
>  arch/alpha/kernel/syscalls/syscall.tbl      |    1=20
>  arch/arm/tools/syscall.tbl                  |    1=20
>  arch/arm64/include/asm/unistd.h             |    2=20
>  arch/ia64/kernel/syscalls/syscall.tbl       |    1=20
>  arch/m68k/kernel/syscalls/syscall.tbl       |    1=20
>  arch/microblaze/kernel/syscalls/syscall.tbl |    1=20
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |    1=20
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |    1=20
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |    1=20
>  arch/parisc/kernel/syscalls/syscall.tbl     |    1=20
>  arch/powerpc/kernel/syscalls/syscall.tbl    |    1=20
>  arch/s390/kernel/syscalls/syscall.tbl       |    1=20
>  arch/sh/kernel/syscalls/syscall.tbl         |    1=20
>  arch/sparc/kernel/syscalls/syscall.tbl      |    1=20
>  arch/x86/entry/syscalls/syscall_32.tbl      |    1=20
>  arch/x86/entry/syscalls/syscall_64.tbl      |    1=20
>  arch/xtensa/kernel/syscalls/syscall.tbl     |    1=20
>  fs/Kconfig                                  |    7=20
>  fs/Makefile                                 |    1=20
>  fs/fsinfo.c                                 |  566 +++++++++++++++++++++=
++++
>  include/linux/fs.h                          |    4=20
>  include/linux/fsinfo.h                      |   72 +++
>  include/linux/syscalls.h                    |    4=20
>  include/uapi/asm-generic/unistd.h           |    4=20
>  include/uapi/linux/fsinfo.h                 |  187 ++++++++
>  kernel/sys_ni.c                             |    1=20
>  samples/vfs/Makefile                        |    5=20
>  samples/vfs/test-fsinfo.c                   |  607 +++++++++++++++++++++=
++++++
>  28 files changed, 1474 insertions(+), 2 deletions(-)
>  create mode 100644 fs/fsinfo.c
>  create mode 100644 include/linux/fsinfo.h
>  create mode 100644 include/uapi/linux/fsinfo.h
>  create mode 100644 samples/vfs/test-fsinfo.c
>=20
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index 7c0115af9010..4d0b07dde12d 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -479,3 +479,4 @@
>  548	common	pidfd_getfd			sys_pidfd_getfd
>  549	common	watch_mount			sys_watch_mount
>  550	common	watch_sb			sys_watch_sb
> +551	common	fsinfo				sys_fsinfo
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index f256f009a89f..fdda8382b420 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -453,3 +453,4 @@
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	watch_mount			sys_watch_mount
>  440	common	watch_sb			sys_watch_sb
> +441	common	fsinfo				sys_fsinfo
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/uni=
std.h
> index bc0f923e0e04..388eeb71cff0 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -38,7 +38,7 @@
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
> =20
> -#define __NR_compat_syscalls		441
> +#define __NR_compat_syscalls		442
>  #endif
> =20
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/sys=
calls/syscall.tbl
> index a4dafc659647..2316e60e031a 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -360,3 +360,4 @@
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	watch_mount			sys_watch_mount
>  440	common	watch_sb			sys_watch_sb
> +441	common	fsinfo				sys_fsinfo
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/sys=
calls/syscall.tbl
> index 893fb4151547..efc2723ca91f 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -439,3 +439,4 @@
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	watch_mount			sys_watch_mount
>  440	common	watch_sb			sys_watch_sb
> +441	common	fsinfo				sys_fsinfo
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaz=
e/kernel/syscalls/syscall.tbl
> index 54aaf0d40c64..745c0f462fce 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -445,3 +445,4 @@
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	watch_mount			sys_watch_mount
>  440	common	watch_sb			sys_watch_sb
> +441	common	fsinfo				sys_fsinfo
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel=
/syscalls/syscall_n32.tbl
> index fd34dd0efed0..499f83562a8c 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -378,3 +378,4 @@
>  438	n32	pidfd_getfd			sys_pidfd_getfd
>  439	n32	watch_mount			sys_watch_mount
>  440	n32	watch_sb			sys_watch_sb
> +441	n32	fsinfo				sys_fsinfo
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel=
/syscalls/syscall_n64.tbl
> index db0f4c0a0a0b..b3188bc3ab3c 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -354,3 +354,4 @@
>  438	n64	pidfd_getfd			sys_pidfd_getfd
>  439	n64	watch_mount			sys_watch_mount
>  440	n64	watch_sb			sys_watch_sb
> +441	n64	fsinfo				sys_fsinfo
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel=
/syscalls/syscall_o32.tbl
> index ce2e1326de8f..1a3e8ed5e538 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -427,3 +427,4 @@
>  438	o32	pidfd_getfd			sys_pidfd_getfd
>  439	o32	watch_mount			sys_watch_mount
>  440	o32	watch_sb			sys_watch_sb
> +441	o32	fsinfo				sys_fsinfo
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel=
/syscalls/syscall.tbl
> index 6e4a7c08b64b..2572c215d861 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -437,3 +437,4 @@
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	watch_mount			sys_watch_mount
>  440	common	watch_sb			sys_watch_sb
> +441	common	fsinfo				sys_fsinfo
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kern=
el/syscalls/syscall.tbl
> index 08943f3b8206..39d7ac7e918c 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -521,3 +521,4 @@
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	watch_mount			sys_watch_mount
>  440	common	watch_sb			sys_watch_sb
> +441	common	fsinfo				sys_fsinfo
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/sys=
calls/syscall.tbl
> index b3b8529d2b74..ae4cefd3dd1b 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -442,3 +442,4 @@
>  438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
>  439	common	watch_mount		sys_watch_mount			sys_watch_mount
>  440	common	watch_sb		sys_watch_sb			sys_watch_sb
> +441  common	fsinfo			sys_fsinfo			sys_fsinfo
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscall=
s/syscall.tbl
> index 89307a20657c..05945b9aee4b 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -442,3 +442,4 @@
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	watch_mount			sys_watch_mount
>  440	common	watch_sb			sys_watch_sb
> +441	common	fsinfo				sys_fsinfo
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/s=
yscalls/syscall.tbl
> index 4ff841a00450..b71b34d4b45c 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -485,3 +485,4 @@
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	watch_mount			sys_watch_mount
>  440	common	watch_sb			sys_watch_sb
> +441	common	fsinfo				sys_fsinfo
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/sysc=
alls/syscall_32.tbl
> index e2731d295f88..e118ba9aca4c 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -444,3 +444,4 @@
>  438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
>  439	i386	watch_mount		sys_watch_mount			__ia32_sys_watch_mount
>  440	i386	watch_sb		sys_watch_sb			__ia32_sys_watch_sb
> +441	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysc=
alls/syscall_64.tbl
> index f4391176102c..067f247471d0 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -361,6 +361,7 @@
>  438	common	pidfd_getfd		__x64_sys_pidfd_getfd
>  439	common	watch_mount		__x64_sys_watch_mount
>  440	common	watch_sb		__x64_sys_watch_sb
> +441	common	fsinfo			__x64_sys_fsinfo
> =20
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel=
/syscalls/syscall.tbl
> index 8e7d731ed6cf..e1ec25099d10 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -410,3 +410,4 @@
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	watch_mount			sys_watch_mount
>  440	common	watch_sb			sys_watch_sb
> +441	common	fsinfo				sys_fsinfo
> diff --git a/fs/Kconfig b/fs/Kconfig
> index fef1365c23a5..01d0d436b3cd 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -15,6 +15,13 @@ config VALIDATE_FS_PARSER
>  	  Enable this to perform validation of the parameter description for a
>  	  filesystem when it is registered.
> =20
> +config FSINFO
> +	bool "Enable the fsinfo() system call"
> +	help
> +	  Enable the file system information querying system call to allow
> +	  comprehensive information to be retrieved about a filesystem,
> +	  superblock or mount object.
> +
>  if BLOCK
> =20
>  config FS_IOMAP
> diff --git a/fs/Makefile b/fs/Makefile
> index 4477757780d0..b6bf2424c7f7 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_COREDUMP)		+=3D coredump.o
>  obj-$(CONFIG_SYSCTL)		+=3D drop_caches.o
> =20
>  obj-$(CONFIG_FHANDLE)		+=3D fhandle.o
> +obj-$(CONFIG_FSINFO)		+=3D fsinfo.o
>  obj-y				+=3D iomap/
> =20
>  obj-y				+=3D quota/
> diff --git a/fs/fsinfo.c b/fs/fsinfo.c
> new file mode 100644
> index 000000000000..5d3ba3c3a7ad
> --- /dev/null
> +++ b/fs/fsinfo.c
> @@ -0,0 +1,566 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Filesystem information query.
> + *
> + * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +#include <linux/syscalls.h>
> +#include <linux/fs.h>
> +#include <linux/file.h>
> +#include <linux/mount.h>
> +#include <linux/namei.h>
> +#include <linux/statfs.h>
> +#include <linux/security.h>
> +#include <linux/uaccess.h>
> +#include <linux/fsinfo.h>
> +#include <uapi/linux/mount.h>
> +#include "internal.h"
> +
> +/**
> + * fsinfo_string - Store a NUL-terminated string as an fsinfo attribute =
value.
> + * @s: The string to store (may be NULL)
> + * @ctx: The parameter context
> + */
> +int fsinfo_string(const char *s, struct fsinfo_context *ctx)
> +{
> +	unsigned int len;
> +	char *p =3D ctx->buffer;
> +	int ret =3D 0;
> +
> +	if (s) {
> +		len =3D min_t(size_t, strlen(s), ctx->buf_size - 1);
> +		if (!ctx->want_size_only) {
> +			memcpy(p, s, len);
> +			p[len] =3D 0;
> +		}
> +		ret =3D len;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(fsinfo_string);
> +
> +/*
> + * Get basic filesystem stats from statfs.
> + */
> +static int fsinfo_generic_statfs(struct path *path, struct fsinfo_contex=
t *ctx)
> +{
> +	struct fsinfo_statfs *p =3D ctx->buffer;
> +	struct kstatfs buf;
> +	int ret;
> +
> +	ret =3D vfs_statfs(path, &buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	p->f_blocks.lo	=3D buf.f_blocks;
> +	p->f_bfree.lo	=3D buf.f_bfree;
> +	p->f_bavail.lo	=3D buf.f_bavail;
> +	p->f_files.lo	=3D buf.f_files;
> +	p->f_ffree.lo	=3D buf.f_ffree;
> +	p->f_favail.lo	=3D buf.f_ffree;
> +	p->f_bsize	=3D buf.f_bsize;
> +	p->f_frsize	=3D buf.f_frsize;
> +	return sizeof(*p);
> +}
> +
> +static int fsinfo_generic_ids(struct path *path, struct fsinfo_context *=
ctx)
> +{
> +	struct fsinfo_ids *p =3D ctx->buffer;
> +	struct super_block *sb;
> +	struct kstatfs buf;
> +	int ret;
> +
> +	ret =3D vfs_statfs(path, &buf);
> +	if (ret < 0 && ret !=3D -ENOSYS)
> +		return ret;
> +	if (ret =3D=3D 0)
> +		memcpy(&p->f_fsid, &buf.f_fsid, sizeof(p->f_fsid));
> +
> +	sb =3D path->dentry->d_sb;
> +	p->f_fstype	=3D sb->s_magic;
> +	p->f_dev_major	=3D MAJOR(sb->s_dev);
> +	p->f_dev_minor	=3D MINOR(sb->s_dev);
> +	p->f_sb_id	=3D sb->s_unique_id;
> +	strlcpy(p->f_fs_name, sb->s_type->name, sizeof(p->f_fs_name));
> +	return sizeof(*p);
> +}
> +
> +int fsinfo_generic_limits(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct fsinfo_limits *p =3D ctx->buffer;
> +	struct super_block *sb =3D path->dentry->d_sb;
> +
> +	p->max_file_size.hi	=3D 0;
> +	p->max_file_size.lo	=3D sb->s_maxbytes;
> +	p->max_ino.hi		=3D 0;
> +	p->max_ino.lo		=3D UINT_MAX;
> +	p->max_hard_links	=3D sb->s_max_links;
> +	p->max_uid		=3D UINT_MAX;
> +	p->max_gid		=3D UINT_MAX;
> +	p->max_projid		=3D UINT_MAX;
> +	p->max_filename_len	=3D NAME_MAX;
> +	p->max_symlink_len	=3D PATH_MAX;
> +	p->max_xattr_name_len	=3D XATTR_NAME_MAX;
> +	p->max_xattr_body_len	=3D XATTR_SIZE_MAX;
> +	p->max_dev_major	=3D 0xffffff;
> +	p->max_dev_minor	=3D 0xff;
> +	return sizeof(*p);
> +}
> +EXPORT_SYMBOL(fsinfo_generic_limits);
> +
> +int fsinfo_generic_supports(struct path *path, struct fsinfo_context *ct=
x)
> +{
> +	struct fsinfo_supports *p =3D ctx->buffer;
> +	struct super_block *sb =3D path->dentry->d_sb;
> +
> +	p->stx_mask =3D STATX_BASIC_STATS;
> +	if (sb->s_d_op && sb->s_d_op->d_automount)
> +		p->stx_attributes |=3D STATX_ATTR_AUTOMOUNT;
> +	return sizeof(*p);
> +}
> +EXPORT_SYMBOL(fsinfo_generic_supports);
> +
> +static const struct fsinfo_timestamp_info fsinfo_default_timestamp_info =
=3D {
> +	.atime =3D {
> +		.minimum	=3D S64_MIN,
> +		.maximum	=3D S64_MAX,
> +		.gran_mantissa	=3D 1,
> +		.gran_exponent	=3D 0,
> +	},
> +	.mtime =3D {
> +		.minimum	=3D S64_MIN,
> +		.maximum	=3D S64_MAX,
> +		.gran_mantissa	=3D 1,
> +		.gran_exponent	=3D 0,
> +	},
> +	.ctime =3D {
> +		.minimum	=3D S64_MIN,
> +		.maximum	=3D S64_MAX,
> +		.gran_mantissa	=3D 1,
> +		.gran_exponent	=3D 0,
> +	},
> +	.btime =3D {
> +		.minimum	=3D S64_MIN,
> +		.maximum	=3D S64_MAX,
> +		.gran_mantissa	=3D 1,
> +		.gran_exponent	=3D 0,
> +	},
> +};
> +
> +int fsinfo_generic_timestamp_info(struct path *path, struct fsinfo_conte=
xt *ctx)
> +{
> +	struct fsinfo_timestamp_info *p =3D ctx->buffer;
> +	struct super_block *sb =3D path->dentry->d_sb;
> +	s8 exponent;
> +
> +	*p =3D fsinfo_default_timestamp_info;
> +
> +	if (sb->s_time_gran < 1000000000) {
> +		if (sb->s_time_gran < 1000)
> +			exponent =3D -9;
> +		else if (sb->s_time_gran < 1000000)
> +			exponent =3D -6;
> +		else
> +			exponent =3D -3;
> +
> +		p->atime.gran_exponent =3D exponent;
> +		p->mtime.gran_exponent =3D exponent;
> +		p->ctime.gran_exponent =3D exponent;
> +		p->btime.gran_exponent =3D exponent;
> +	}
> +
> +	return sizeof(*p);
> +}
> +EXPORT_SYMBOL(fsinfo_generic_timestamp_info);
> +
> +static int fsinfo_generic_volume_uuid(struct path *path, struct fsinfo_c=
ontext *ctx)
> +{
> +	struct fsinfo_volume_uuid *p =3D ctx->buffer;
> +	struct super_block *sb =3D path->dentry->d_sb;
> +
> +	memcpy(p, &sb->s_uuid, sizeof(*p));
> +	return sizeof(*p);
> +}
> +
> +static int fsinfo_generic_volume_id(struct path *path, struct fsinfo_con=
text *ctx)
> +{
> +	return fsinfo_string(path->dentry->d_sb->s_id, ctx);
> +}
> +
> +static const struct fsinfo_attribute fsinfo_common_attributes[] =3D {
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_STATFS,		fsinfo_generic_statfs),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_IDS,		fsinfo_generic_ids),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_LIMITS,		fsinfo_generic_limits),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_SUPPORTS,		fsinfo_generic_supports),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_TIMESTAMP_INFO,	fsinfo_generic_timestamp_in=
fo),
> +	FSINFO_STRING	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
> +
> +	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	(void *)123UL),
> +	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, (void *)123UL),
> +	{}
> +};
> +
> +/*
> + * Determine an attribute's minimum buffer size and, if the buffer is la=
rge
> + * enough, get the attribute value.
> + */
> +static int fsinfo_get_this_attribute(struct path *path,
> +				     struct fsinfo_context *ctx,
> +				     const struct fsinfo_attribute *attr)
> +{
> +	int buf_size;
> +
> +	if (ctx->Nth !=3D 0 && !(attr->flags & (FSINFO_FLAGS_N | FSINFO_FLAGS_N=
M)))
> +		return -ENODATA;
> +	if (ctx->Mth !=3D 0 && !(attr->flags & FSINFO_FLAGS_NM))
> +		return -ENODATA;
> +
> +	switch (attr->type) {
> +	case FSINFO_TYPE_VSTRUCT:
> +		ctx->clear_tail =3D true;
> +		buf_size =3D attr->size;
> +		break;
> +	case FSINFO_TYPE_STRING:
> +	case FSINFO_TYPE_OPAQUE:
> +	case FSINFO_TYPE_LIST:
> +		buf_size =3D 4096;
> +		break;
> +	default:
> +		return -ENOPKG;
> +	}
> +
> +	if (ctx->buf_size < buf_size)
> +		return buf_size;
> +
> +	return attr->get(path, ctx);
> +}
> +
> +static void fsinfo_attributes_insert(struct fsinfo_context *ctx,
> +				     const struct fsinfo_attribute *attr)
> +{
> +	__u32 *p =3D ctx->buffer;
> +	unsigned int i;
> +
> +	if (ctx->usage >=3D ctx->buf_size ||
> +	    ctx->buf_size - ctx->usage < sizeof(__u32)) {
> +		ctx->usage +=3D sizeof(__u32);
> +		return;
> +	}
> +
> +	for (i =3D 0; i < ctx->usage / sizeof(__u32); i++)
> +		if (p[i] =3D=3D attr->attr_id)
> +			return;
> +
> +	p[i] =3D attr->attr_id;
> +	ctx->usage +=3D sizeof(__u32);
> +}
> +
> +static int fsinfo_list_attributes(struct path *path,
> +				  struct fsinfo_context *ctx,
> +				  const struct fsinfo_attribute *attributes)
> +{
> +	const struct fsinfo_attribute *a;
> +
> +	for (a =3D attributes; a->get; a++)
> +		fsinfo_attributes_insert(ctx, a);
> +	return -EOPNOTSUPP; /* We want to go through all the lists */
> +}
> +
> +static int fsinfo_get_attribute_info(struct path *path,
> +				     struct fsinfo_context *ctx,
> +				     const struct fsinfo_attribute *attributes)
> +{
> +	const struct fsinfo_attribute *a;
> +	struct fsinfo_attribute_info *p =3D ctx->buffer;
> +
> +	if (!ctx->buf_size)
> +		return sizeof(*p);
> +
> +	for (a =3D attributes; a->get; a++) {
> +		if (a->attr_id =3D=3D ctx->Nth) {
> +			p->attr_id	=3D a->attr_id;
> +			p->type		=3D a->type;
> +			p->flags	=3D a->flags;
> +			p->size		=3D a->size;
> +			p->size		=3D a->size;
> +			return sizeof(*p);
> +		}
> +	}
> +	return -EOPNOTSUPP; /* We want to go through all the lists */
> +}
> +
> +/**
> + * fsinfo_get_attribute - Look up and handle an attribute
> + * @path: The object to query
> + * @params: Parameters to define a request and place to store result
> + * @attributes: List of attributes to search.
> + *
> + * Look through a list of attributes for one that matches the requested
> + * attribute then call the handler for it.
> + */
> +int fsinfo_get_attribute(struct path *path, struct fsinfo_context *ctx,
> +			 const struct fsinfo_attribute *attributes)
> +{
> +	const struct fsinfo_attribute *a;
> +
> +	switch (ctx->requested_attr) {
> +	case FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO:
> +		return fsinfo_get_attribute_info(path, ctx, attributes);
> +	case FSINFO_ATTR_FSINFO_ATTRIBUTES:
> +		return fsinfo_list_attributes(path, ctx, attributes);
> +	default:
> +		for (a =3D attributes; a->get; a++)
> +			if (a->attr_id =3D=3D ctx->requested_attr)
> +				return fsinfo_get_this_attribute(path, ctx, a);
> +		return -EOPNOTSUPP;
> +	}
> +}
> +EXPORT_SYMBOL(fsinfo_get_attribute);
> +
> +/**
> + * generic_fsinfo - Handle an fsinfo attribute generically
> + * @path: The object to query
> + * @params: Parameters to define a request and place to store result
> + */
> +static int fsinfo_call(struct path *path, struct fsinfo_context *ctx)
> +{
> +	int ret;
> +
> +	if (path->dentry->d_sb->s_op->fsinfo) {
> +		ret =3D path->dentry->d_sb->s_op->fsinfo(path, ctx);
> +		if (ret !=3D -EOPNOTSUPP)
> +			return ret;
> +	}
> +	ret =3D fsinfo_get_attribute(path, ctx, fsinfo_common_attributes);
> +	if (ret !=3D -EOPNOTSUPP)
> +		return ret;
> +
> +	switch (ctx->requested_attr) {
> +	case FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO:
> +		return -ENODATA;
> +	case FSINFO_ATTR_FSINFO_ATTRIBUTES:
> +		return ctx->usage;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +/**
> + * vfs_fsinfo - Retrieve filesystem information
> + * @path: The object to query
> + * @params: Parameters to define a request and place to store result
> + *
> + * Get an attribute on a filesystem or an object within a filesystem.  T=
he
> + * filesystem attribute to be queried is indicated by @ctx->requested_at=
tr, and
> + * if it's a multi-valued attribute, the particular value is selected by
> + * @ctx->Nth and then @ctx->Mth.
> + *
> + * For common attributes, a value may be fabricated if it is not support=
ed by
> + * the filesystem.
> + *
> + * On success, the size of the attribute's value is returned (0 is a val=
id
> + * size).  A buffer will have been allocated and will be pointed to by
> + * @ctx->buffer.  The caller must free this with kvfree().
> + *
> + * Errors can also be returned: -ENOMEM if a buffer cannot be allocated,=
 -EPERM
> + * or -EACCES if permission is denied by the LSM, -EOPNOTSUPP if an attr=
ibute
> + * doesn't exist for the specified object or -ENODATA if the attribute e=
xists,
> + * but the Nth,Mth value does not exist.  -EMSGSIZE indicates that the v=
alue is
> + * unmanageable internally and -ENOPKG indicates other internal failure.
> + *
> + * Errors such as -EIO may also come from attempts to access media or se=
rvers
> + * to obtain the requested information if it's not immediately to hand.
> + *
> + * [*] Note that the caller may set @ctx->want_size_only if it only want=
s the
> + *     size of the value and not the data.  If this is set, a buffer may=
 not be
> + *     allocated under some circumstances.  This is intended for size qu=
ery by
> + *     userspace.
> + *
> + * [*] Note that @ctx->clear_tail will be returned set if the data shoul=
d be
> + *     padded out with zeros when writing it to userspace.
> + */
> +static int vfs_fsinfo(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct dentry *dentry =3D path->dentry;
> +	int ret;
> +
> +	ret =3D security_sb_statfs(dentry);
> +	if (ret)
> +		return ret;
> +
> +	/* Call the handler to find out the buffer size required. */
> +	ctx->buf_size =3D 0;
> +	ret =3D fsinfo_call(path, ctx);
> +	if (ret < 0 || ctx->want_size_only)
> +		return ret;
> +	ctx->buf_size =3D ret;
> +
> +	do {
> +		/* Allocate a buffer of the requested size. */
> +		if (ctx->buf_size > INT_MAX)
> +			return -EMSGSIZE;
> +		ctx->buffer =3D kvzalloc(ctx->buf_size, GFP_KERNEL);
> +		if (!ctx->buffer)
> +			return -ENOMEM;
> +
> +		ctx->usage =3D 0;
> +		ret =3D fsinfo_call(path, ctx);
> +		if (IS_ERR_VALUE((long)ret))
> +			return ret;
> +		if ((unsigned int)ret <=3D ctx->buf_size)
> +			return ret; /* It fitted */
> +
> +		/* We need to resize the buffer */
> +		ctx->buf_size =3D roundup(ret, PAGE_SIZE);
> +		kvfree(ctx->buffer);
> +		ctx->buffer =3D NULL;
> +	} while (!signal_pending(current));
> +
> +	return -ERESTARTSYS;
> +}
> +
> +static int vfs_fsinfo_path(int dfd, const char __user *pathname,
> +			   unsigned int at_flags, struct fsinfo_context *ctx)
> +{
> +	struct path path;
> +	unsigned lookup_flags =3D LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
> +	int ret =3D -EINVAL;
> +
> +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
> +			  AT_EMPTY_PATH)) !=3D 0)
> +		return -EINVAL;
> +
> +	if (at_flags & AT_SYMLINK_NOFOLLOW)
> +		lookup_flags &=3D ~LOOKUP_FOLLOW;
> +	if (at_flags & AT_NO_AUTOMOUNT)
> +		lookup_flags &=3D ~LOOKUP_AUTOMOUNT;
> +	if (at_flags & AT_EMPTY_PATH)
> +		lookup_flags |=3D LOOKUP_EMPTY;
> +
> +retry:
> +	ret =3D user_path_at(dfd, pathname, lookup_flags, &path);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D vfs_fsinfo(&path, ctx);
> +	path_put(&path);
> +	if (retry_estale(ret, lookup_flags)) {
> +		lookup_flags |=3D LOOKUP_REVAL;
> +		goto retry;
> +	}
> +out:
> +	return ret;
> +}
> +
> +static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_context *ctx)
> +{
> +	struct fd f =3D fdget_raw(fd);
> +	int ret =3D -EBADF;
> +
> +	if (f.file) {
> +		ret =3D vfs_fsinfo(&f.file->f_path, ctx);
> +		fdput(f);
> +	}
> +	return ret;
> +}
> +
> +/**
> + * sys_fsinfo - System call to get filesystem information
> + * @dfd: Base directory to pathwalk from or fd referring to filesystem.
> + * @pathname: Filesystem to query or NULL.
> + * @_params: Parameters to define request (or NULL for enhanced statfs).
> + * @user_buffer: Result buffer.
> + * @user_buf_size: Size of result buffer.
> + *
> + * Get information on a filesystem.  The filesystem attribute to be quer=
ied is
> + * indicated by @_params->request, and some of the attributes can have m=
ultiple
> + * values, indexed by @_params->Nth and @_params->Mth.  If @_params is N=
ULL,
> + * then the 0th fsinfo_attr_statfs attribute is queried.  If an attribut=
e does
> + * not exist, EOPNOTSUPP is returned; if the Nth,Mth value does not exis=
t,
> + * ENODATA is returned.
> + *
> + * On success, the size of the attribute's value is returned.  If
> + * @user_buf_size is 0 or @user_buffer is NULL, only the size is returne=
d.  If
> + * the size of the value is larger than @user_buf_size, it will be trunc=
ated by
> + * the copy.  If the size of the value is smaller than @user_buf_size th=
en the
> + * excess buffer space will be cleared.  The full size of the value will=
 be
> + * returned, irrespective of how much data is actually placed in the buf=
fer.
> + */
> +SYSCALL_DEFINE5(fsinfo,
> +		int, dfd, const char __user *, pathname,
> +		struct fsinfo_params __user *, params,
> +		void __user *, user_buffer, size_t, user_buf_size)
> +{
> +	struct fsinfo_context ctx;
> +	struct fsinfo_params user_params;
> +	unsigned int at_flags =3D 0, result_size;
> +	int ret;
> +
> +	if (!user_buffer && user_buf_size)
> +		return -EINVAL;
> +	if (user_buffer && !user_buf_size)
> +		return -EINVAL;
> +	if (user_buf_size > UINT_MAX)
> +		return -EOVERFLOW;
> +
> +	memset(&ctx, 0, sizeof(ctx));
> +	ctx.requested_attr =3D FSINFO_ATTR_STATFS;
> +	if (user_buf_size =3D=3D 0)
> +		ctx.want_size_only =3D true;
> +
> +	if (params) {
> +		if (copy_from_user(&user_params, params, sizeof(user_params)))
> +			return -EFAULT;
> +		if (user_params.__reserved32[0] ||
> +		    user_params.__reserved[0] ||
> +		    user_params.__reserved[1] ||
> +		    user_params.__reserved[2] ||
> +		    user_params.flags & ~FSINFO_FLAGS_QUERY_MASK)
> +			return -EINVAL;
> +		at_flags =3D user_params.at_flags;
> +		ctx.flags =3D user_params.flags;
> +		ctx.requested_attr =3D user_params.request;
> +		ctx.Nth =3D user_params.Nth;
> +		ctx.Mth =3D user_params.Mth;
> +	}
> +
> +	switch (ctx.flags & FSINFO_FLAGS_QUERY_MASK) {
> +	case FSINFO_FLAGS_QUERY_PATH:
> +		ret =3D vfs_fsinfo_path(dfd, pathname, at_flags, &ctx);
> +		break;
> +	case FSINFO_FLAGS_QUERY_FD:
> +		if (pathname)
> +			return -EINVAL;
> +		ret =3D vfs_fsinfo_fd(dfd, &ctx);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret < 0)
> +		goto error;
> +
> +	result_size =3D min_t(size_t, ret, user_buf_size);
> +	if (result_size > 0 &&
> +	    copy_to_user(user_buffer, ctx.buffer, result_size) !=3D 0) {
> +		ret =3D -EFAULT;
> +		goto error;
> +	}
> +
> +	/* Clear any part of the buffer that we won't fill if we're putting a
> +	 * struct in there.  Strings, opaque objects and arrays are expected to
> +	 * be variable length.
> +	 */
> +	if (ctx.clear_tail &&
> +	    user_buf_size > result_size &&
> +	    clear_user(user_buffer + result_size, user_buf_size - result_size) =
!=3D 0) {
> +		ret =3D -EFAULT;
> +		goto error;
> +	}
> +
> +error:
> +	kvfree(ctx.buffer);
> +	return ret;
> +}
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d5128d112384..d2476c0fc978 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -69,6 +69,7 @@ struct fsverity_info;
>  struct fsverity_operations;
>  struct fs_context;
>  struct fs_parameter_spec;
> +struct fsinfo_context;
> =20
>  extern void __init inode_init(void);
>  extern void __init inode_init_early(void);
> @@ -1963,6 +1964,9 @@ struct super_operations {
>  	int (*thaw_super) (struct super_block *);
>  	int (*unfreeze_fs) (struct super_block *);
>  	int (*statfs) (struct dentry *, struct kstatfs *);
> +#ifdef CONFIG_FSINFO
> +	int (*fsinfo)(struct path *, struct fsinfo_context *);
> +#endif
>  	int (*remount_fs) (struct super_block *, int *, char *);
>  	void (*umount_begin) (struct super_block *);
> =20
> diff --git a/include/linux/fsinfo.h b/include/linux/fsinfo.h
> new file mode 100644
> index 000000000000..943fbd6640f9
> --- /dev/null
> +++ b/include/linux/fsinfo.h
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Filesystem information query
> + *
> + * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#ifndef _LINUX_FSINFO_H
> +#define _LINUX_FSINFO_H
> +
> +#ifdef CONFIG_FSINFO
> +
> +#include <uapi/linux/fsinfo.h>
> +
> +struct path;
> +
> +#define FSINFO_NORMAL_ATTR_MAX_SIZE 4096
> +
> +struct fsinfo_context {
> +	__u32		flags;		/* [in] FSINFO_FLAGS_* */
> +	__u32		requested_attr;	/* [in] What is being asking for */
> +	__u32		Nth;		/* [in] Instance of it (some may have multiple) */
> +	__u32		Mth;		/* [in] Subinstance */
> +	bool		want_size_only;	/* [in] Just want to know the size, not the data =
*/
> +	bool		clear_tail;	/* [out] T if tail of buffer should be cleared */
> +	unsigned int	usage;		/* [tmp] Amount of buffer used (if large) */
> +	unsigned int	buf_size;	/* [tmp] Size of ->buffer[] */
> +	void		*buffer;	/* [out] The reply buffer */
> +};
> +
> +/*
> + * A filesystem information attribute definition.
> + */
> +struct fsinfo_attribute {
> +	unsigned int		attr_id;	/* The ID of the attribute */
> +	enum fsinfo_value_type	type:8;		/* The type of the attribute's value(s)=
 */
> +	unsigned int		flags:8;
> +	unsigned int		size:16;	/* - Value size (FSINFO_STRUCT/LIST) */
> +	int (*get)(struct path *path, struct fsinfo_context *params);
> +};
> +
> +#define __FSINFO(A, T, S, G, F) \
> +	{ .attr_id =3D A, .type =3D T, .flags =3D F, .size =3D S, .get =3D G }
> +
> +#define _FSINFO(A, T, S, G)	__FSINFO(A, T, S, G, 0)
> +#define _FSINFO_N(A, T, S, G)	__FSINFO(A, T, S, G, FSINFO_FLAGS_N)
> +#define _FSINFO_NM(A, T, S, G)	__FSINFO(A, T, S, G, FSINFO_FLAGS_NM)
> +
> +#define _FSINFO_VSTRUCT(A,S,G)	  _FSINFO   (A, FSINFO_TYPE_VSTRUCT, size=
of(S), G)
> +#define _FSINFO_VSTRUCT_N(A,S,G)  _FSINFO_N (A, FSINFO_TYPE_VSTRUCT, siz=
eof(S), G)
> +#define _FSINFO_VSTRUCT_NM(A,S,G) _FSINFO_NM(A, FSINFO_TYPE_VSTRUCT, siz=
eof(S), G)
> +
> +#define FSINFO_VSTRUCT(A,G)	_FSINFO_VSTRUCT   (A, A##__STRUCT, G)
> +#define FSINFO_VSTRUCT_N(A,G)	_FSINFO_VSTRUCT_N (A, A##__STRUCT, G)
> +#define FSINFO_VSTRUCT_NM(A,G)	_FSINFO_VSTRUCT_NM(A, A##__STRUCT, G)
> +#define FSINFO_STRING(A,G)	_FSINFO   (A, FSINFO_TYPE_STRING, 0, G)
> +#define FSINFO_STRING_N(A,G)	_FSINFO_N (A, FSINFO_TYPE_STRING, 0, G)
> +#define FSINFO_STRING_NM(A,G)	_FSINFO_NM(A, FSINFO_TYPE_STRING, 0, G)
> +#define FSINFO_OPAQUE(A,G)	_FSINFO   (A, FSINFO_TYPE_OPAQUE, 0, G)
> +#define FSINFO_LIST(A,G)	_FSINFO   (A, FSINFO_TYPE_LIST, sizeof(A##__STR=
UCT), G)
> +#define FSINFO_LIST_N(A,G)	_FSINFO_N (A, FSINFO_TYPE_LIST, sizeof(A##__S=
TRUCT), G)
> +
> +extern int fsinfo_string(const char *, struct fsinfo_context *);
> +extern int fsinfo_generic_timestamp_info(struct path *, struct fsinfo_co=
ntext *);
> +extern int fsinfo_generic_supports(struct path *, struct fsinfo_context =
*);
> +extern int fsinfo_generic_limits(struct path *, struct fsinfo_context *);
> +extern int fsinfo_get_attribute(struct path *, struct fsinfo_context *,
> +				const struct fsinfo_attribute *);
> +
> +#endif /* CONFIG_FSINFO */
> +
> +#endif /* _LINUX_FSINFO_H */
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index c84440d57f52..936e2eb76c8f 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -47,6 +47,7 @@ struct stat64;
>  struct statfs;
>  struct statfs64;
>  struct statx;
> +struct fsinfo_params;
>  struct __sysctl_args;
>  struct sysinfo;
>  struct timespec;
> @@ -1007,6 +1008,9 @@ asmlinkage long sys_watch_mount(int dfd, const char=
 __user *path,
>  				unsigned int at_flags, int watch_fd, int watch_id);
>  asmlinkage long sys_watch_sb(int dfd, const char __user *path,
>  			     unsigned int at_flags, int watch_fd, int watch_id);
> +asmlinkage long sys_fsinfo(int dfd, const char __user *pathname,
> +			   struct fsinfo_params __user *params,
> +			   void __user *buffer, size_t buf_size);
> =20
>  /*
>   * Architecture-specific system calls
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic=
/unistd.h
> index 5bff318b7ffa..7d764f86d3f5 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -859,9 +859,11 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
>  __SYSCALL(__NR_watch_mount, sys_watch_mount)
>  #define __NR_watch_sb 440
>  __SYSCALL(__NR_watch_sb, sys_watch_sb)
> +#define __NR_fsinfo 441
> +__SYSCALL(__NR_fsinfo, sys_fsinfo)
> =20
>  #undef __NR_syscalls
> -#define __NR_syscalls 441
> +#define __NR_syscalls 442
> =20
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
> new file mode 100644
> index 000000000000..6eb02de8a631
> --- /dev/null
> +++ b/include/uapi/linux/fsinfo.h
> @@ -0,0 +1,187 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* fsinfo() definitions.
> + *
> + * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +#ifndef _UAPI_LINUX_FSINFO_H
> +#define _UAPI_LINUX_FSINFO_H
> +
> +#include <linux/types.h>
> +#include <linux/socket.h>
> +
> +/*
> + * The filesystem attributes that can be requested.  Note that some attr=
ibutes
> + * may have multiple instances which can be switched in the parameter bl=
ock.
> + */
> +#define FSINFO_ATTR_STATFS		0x00	/* statfs()-style state */
> +#define FSINFO_ATTR_IDS			0x01	/* Filesystem IDs */
> +#define FSINFO_ATTR_LIMITS		0x02	/* Filesystem limits */
> +#define FSINFO_ATTR_SUPPORTS		0x03	/* What's supported in statx, iocflag=
s, ... */
> +#define FSINFO_ATTR_TIMESTAMP_INFO	0x04	/* Inode timestamp info */
> +#define FSINFO_ATTR_VOLUME_ID		0x05	/* Volume ID (string) */
> +#define FSINFO_ATTR_VOLUME_UUID		0x06	/* Volume UUID (LE uuid) */
> +#define FSINFO_ATTR_VOLUME_NAME		0x07	/* Volume name (string) */
> +
> +#define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about att=
r N (for path) */
> +#define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attrs (=
for path) */
> +
> +/*
> + * Optional fsinfo() parameter structure.
> + *
> + * If this is not given, it is assumed that fsinfo_attr_statfs instance =
0,0 is
> + * desired.
> + */
> +struct fsinfo_params {
> +	__u32	at_flags;	/* AT_SYMLINK_NOFOLLOW and similar flags */
> +	__u32	flags;		/* Flags controlling fsinfo() specifically */
> +#define FSINFO_FLAGS_QUERY_MASK	0x0007 /* What object should fsinfo() qu=
ery? */
> +#define FSINFO_FLAGS_QUERY_PATH	0x0000 /* - path, specified by dirfd,pat=
hname,AT_EMPTY_PATH */
> +#define FSINFO_FLAGS_QUERY_FD	0x0001 /* - fd specified by dirfd */
> +	__u32	request;	/* ID of requested attribute */
> +	__u32	Nth;		/* Instance of it (some may have multiple) */
> +	__u32	Mth;		/* Subinstance of Nth instance */
> +	__u32	__reserved32[1]; /* Reserved params; all must be 0 */
> +	__u64	__reserved[3];
> +};
> +
> +enum fsinfo_value_type {
> +	FSINFO_TYPE_VSTRUCT	=3D 0,	/* Version-lengthed struct (up to 4096 bytes=
) */
> +	FSINFO_TYPE_STRING	=3D 1,	/* NUL-term var-length string (up to 4095 cha=
rs) */
> +	FSINFO_TYPE_OPAQUE	=3D 2,	/* Opaque blob (unlimited size) */
> +	FSINFO_TYPE_LIST	=3D 3,	/* List of ints/structs (unlimited size) */
> +};
> +
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO).
> + *
> + * This gives information about the attributes supported by fsinfo for t=
he
> + * given path.
> + */
> +struct fsinfo_attribute_info {
> +	unsigned int		attr_id;	/* The ID of the attribute */
> +	enum fsinfo_value_type	type;		/* The type of the attribute's value(s) */
> +	unsigned int		flags;
> +#define FSINFO_FLAGS_N		0x01		/* - Attr has a set of values */
> +#define FSINFO_FLAGS_NM		0x02		/* - Attr has a set of sets of values */
> +	unsigned int		size;		/* - Value size (FSINFO_STRUCT/FSINFO_LIST) */
> +};
> +
> +#define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO__STRUCT struct fsinfo_attribut=
e_info
> +#define FSINFO_ATTR_FSINFO_ATTRIBUTES__STRUCT __u32
> +
> +struct fsinfo_u128 {
> +#if defined(__BYTE_ORDER) ? __BYTE_ORDER =3D=3D __BIG_ENDIAN : defined(_=
_BIG_ENDIAN)
> +	__u64	hi;
> +	__u64	lo;
> +#elif defined(__BYTE_ORDER) ? __BYTE_ORDER =3D=3D __LITTLE_ENDIAN : defi=
ned(__LITTLE_ENDIAN)
> +	__u64	lo;
> +	__u64	hi;
> +#endif
> +};
> +
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_STATFS).
> + * - This gives extended filesystem information.
> + */
> +struct fsinfo_statfs {
> +	struct fsinfo_u128 f_blocks;	/* Total number of blocks in fs */
> +	struct fsinfo_u128 f_bfree;	/* Total number of free blocks */
> +	struct fsinfo_u128 f_bavail;	/* Number of free blocks available to ordi=
nary user */
> +	struct fsinfo_u128 f_files;	/* Total number of file nodes in fs */
> +	struct fsinfo_u128 f_ffree;	/* Number of free file nodes */
> +	struct fsinfo_u128 f_favail;	/* Number of file nodes available to ordin=
ary user */
> +	__u64	f_bsize;		/* Optimal block size */
> +	__u64	f_frsize;		/* Fragment size */
> +};
> +
> +#define FSINFO_ATTR_STATFS__STRUCT struct fsinfo_statfs
> +
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_IDS).
> + *
> + * List of basic identifiers as is normally found in statfs().
> + */
> +struct fsinfo_ids {
> +	char	f_fs_name[15 + 1];	/* Filesystem name */
> +	__u64	f_fsid;			/* Short 64-bit Filesystem ID (as statfs) */
> +	__u64	f_sb_id;		/* Internal superblock ID for sbnotify()/mntnotify() */
> +	__u32	f_fstype;		/* Filesystem type from linux/magic.h [uncond] */
> +	__u32	f_dev_major;		/* As st_dev_* from struct statx [uncond] */
> +	__u32	f_dev_minor;
> +	__u32	__padding[1];
> +};
> +
> +#define FSINFO_ATTR_IDS__STRUCT struct fsinfo_ids
> +
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_LIMITS).
> + *
> + * List of supported filesystem limits.
> + */
> +struct fsinfo_limits {
> +	struct fsinfo_u128 max_file_size;	/* Maximum file size */
> +	struct fsinfo_u128 max_ino;		/* Maximum inode number */
> +	__u64	max_uid;			/* Maximum UID supported */
> +	__u64	max_gid;			/* Maximum GID supported */
> +	__u64	max_projid;			/* Maximum project ID supported */
> +	__u64	max_hard_links;			/* Maximum number of hard links on a file */
> +	__u64	max_xattr_body_len;		/* Maximum xattr content length */
> +	__u32	max_xattr_name_len;		/* Maximum xattr name length */
> +	__u32	max_filename_len;		/* Maximum filename length */
> +	__u32	max_symlink_len;		/* Maximum symlink content length */
> +	__u32	max_dev_major;			/* Maximum device major representable */
> +	__u32	max_dev_minor;			/* Maximum device minor representable */
> +	__u32	__padding[1];
> +};
> +
> +#define FSINFO_ATTR_LIMITS__STRUCT struct fsinfo_limits
> +
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_SUPPORTS).
> + *
> + * What's supported in various masks, such as statx() attribute and mask=
 bits
> + * and IOC flags.
> + */
> +struct fsinfo_supports {
> +	__u64	stx_attributes;		/* What statx::stx_attributes are supported */
> +	__u32	stx_mask;		/* What statx::stx_mask bits are supported */
> +	__u32	fs_ioc_getflags;	/* What FS_IOC_GETFLAGS may return */
> +	__u32	fs_ioc_setflags_set;	/* What FS_IOC_SETFLAGS may set */
> +	__u32	fs_ioc_setflags_clear;	/* What FS_IOC_SETFLAGS may clear */
> +	__u32	win_file_attrs;		/* What DOS/Windows FILE_* attributes are suppor=
ted */
> +	__u32	__padding[1];
> +};
> +
> +#define FSINFO_ATTR_SUPPORTS__STRUCT struct fsinfo_supports
> +
> +struct fsinfo_timestamp_one {
> +	__s64	minimum;	/* Minimum timestamp value in seconds */
> +	__s64	maximum;	/* Maximum timestamp value in seconds */
> +	__u16	gran_mantissa;	/* Granularity(secs) =3D mant * 10^exp */
> +	__s8	gran_exponent;
> +	__u8	__padding[5];
> +};
> +
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_TIMESTAMP_INFO).
> + */
> +struct fsinfo_timestamp_info {
> +	struct fsinfo_timestamp_one	atime;	/* Access time */
> +	struct fsinfo_timestamp_one	mtime;	/* Modification time */
> +	struct fsinfo_timestamp_one	ctime;	/* Change time */
> +	struct fsinfo_timestamp_one	btime;	/* Birth/creation time */
> +};
> +
> +#define FSINFO_ATTR_TIMESTAMP_INFO__STRUCT struct fsinfo_timestamp_info
> +
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_VOLUME_UUID).
> + */
> +struct fsinfo_volume_uuid {
> +	__u8	uuid[16];
> +};
> +
> +#define FSINFO_ATTR_VOLUME_UUID__STRUCT struct fsinfo_volume_uuid
> +
> +#endif /* _UAPI_LINUX_FSINFO_H */
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 0ce01f86e5db..519317f3904c 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -51,6 +51,7 @@ COND_SYSCALL_COMPAT(io_pgetevents);
>  COND_SYSCALL(io_uring_setup);
>  COND_SYSCALL(io_uring_enter);
>  COND_SYSCALL(io_uring_register);
> +COND_SYSCALL(fsinfo);
> =20
>  /* fs/xattr.c */
> =20
> diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
> index 65acdde5c117..9159ad1d7fc5 100644
> --- a/samples/vfs/Makefile
> +++ b/samples/vfs/Makefile
> @@ -1,10 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  # List of programs to build
> +
>  hostprogs :=3D \
> +	test-fsinfo \
>  	test-fsmount \
>  	test-statx
> =20
>  always-y :=3D $(hostprogs)
> =20
> +HOSTCFLAGS_test-fsinfo.o +=3D -I$(objtree)/usr/include
> +HOSTLDLIBS_test-fsinfo +=3D -static -lm
> +
>  HOSTCFLAGS_test-fsmount.o +=3D -I$(objtree)/usr/include
>  HOSTCFLAGS_test-statx.o +=3D -I$(objtree)/usr/include
> diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
> new file mode 100644
> index 000000000000..22fe3c47ff42
> --- /dev/null
> +++ b/samples/vfs/test-fsinfo.c
> @@ -0,0 +1,607 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Test the fsinfo() system call
> + *
> + * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#define _GNU_SOURCE
> +#define _ATFILE_SOURCE
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <ctype.h>
> +#include <errno.h>
> +#include <time.h>
> +#include <math.h>
> +#include <fcntl.h>
> +#include <sys/syscall.h>
> +#include <linux/fsinfo.h>
> +#include <linux/socket.h>
> +#include <sys/stat.h>
> +#include <arpa/inet.h>
> +
> +#ifndef __NR_fsinfo
> +#define __NR_fsinfo -1
> +#endif
> +
> +static bool debug =3D 0;
> +
> +static __attribute__((unused))
> +ssize_t fsinfo(int dfd, const char *filename, struct fsinfo_params *para=
ms,
> +	       void *buffer, size_t buf_size)
> +{
> +	return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
> +}
> +
> +struct fsinfo_attribute {
> +	unsigned int		attr_id;
> +	enum fsinfo_value_type	type;
> +	unsigned int		size;
> +	const char		*name;
> +	void (*dump)(void *reply, unsigned int size);
> +};
> +
> +static const struct fsinfo_attribute fsinfo_attributes[];
> +
> +static void dump_hex(unsigned int *data, int from, int to)
> +{
> +	unsigned offset, print_offset =3D 1, col =3D 0;
> +
> +	from /=3D 4;
> +	to =3D (to + 3) / 4;
> +
> +	for (offset =3D from; offset < to; offset++) {
> +		if (print_offset) {
> +			printf("%04x: ", offset * 8);
> +			print_offset =3D 0;
> +		}
> +		printf("%08x", data[offset]);
> +		col++;
> +		if ((col & 3) =3D=3D 0) {
> +			printf("\n");
> +			print_offset =3D 1;
> +		} else {
> +			printf(" ");
> +		}
> +	}
> +
> +	if (!print_offset)
> +		printf("\n");
> +}
> +
> +static void dump_attribute_info(void *reply, unsigned int size)
> +{
> +	struct fsinfo_attribute_info *attr_info =3D reply;
> +	const struct fsinfo_attribute *attr;
> +	char type[32], val_size[32];
> +
> +	switch (attr_info->type) {
> +	case FSINFO_TYPE_VSTRUCT:	strcpy(type, "V-STRUCT");	break;
> +	case FSINFO_TYPE_STRING:	strcpy(type, "STRING");		break;
> +	case FSINFO_TYPE_OPAQUE:	strcpy(type, "OPAQUE");		break;
> +	case FSINFO_TYPE_LIST:		strcpy(type, "LIST");		break;
> +	default:
> +		sprintf(type, "type-%x", attr_info->type);
> +		break;
> +	}
> +
> +	if (attr_info->flags & FSINFO_FLAGS_N)
> +		strcat(type, " x N");
> +	else if (attr_info->flags & FSINFO_FLAGS_NM)
> +		strcat(type, " x NM");
> +
> +	for (attr =3D fsinfo_attributes; attr->name; attr++)
> +		if (attr->attr_id =3D=3D attr_info->attr_id)
> +			break;
> +
> +	if (attr_info->size)
> +		sprintf(val_size, "%u", attr_info->size);
> +	else
> +		strcpy(val_size, "-");
> +
> +	printf("%8x %-12s %08x %5s %s\n",
> +	       attr_info->attr_id,
> +	       type,
> +	       attr_info->flags,
> +	       val_size,
> +	       attr->name ? attr->name : "");
> +}
> +
> +static void dump_fsinfo_generic_statfs(void *reply, unsigned int size)
> +{
> +	struct fsinfo_statfs *f =3D reply;
> +
> +	printf("\n");
> +	printf("\tblocks       : n=3D%llu fr=3D%llu av=3D%llu\n",
> +	       (unsigned long long)f->f_blocks.lo,
> +	       (unsigned long long)f->f_bfree.lo,
> +	       (unsigned long long)f->f_bavail.lo);
> +
> +	printf("\tfiles        : n=3D%llu fr=3D%llu av=3D%llu\n",
> +	       (unsigned long long)f->f_files.lo,
> +	       (unsigned long long)f->f_ffree.lo,
> +	       (unsigned long long)f->f_favail.lo);
> +	printf("\tbsize        : %llu\n", f->f_bsize);
> +	printf("\tfrsize       : %llu\n", f->f_frsize);
> +}
> +
> +static void dump_fsinfo_generic_ids(void *reply, unsigned int size)
> +{
> +	struct fsinfo_ids *f =3D reply;
> +
> +	printf("\n");
> +	printf("\tdev          : %02x:%02x\n", f->f_dev_major, f->f_dev_minor);
> +	printf("\tfs           : type=3D%x name=3D%s\n", f->f_fstype, f->f_fs_n=
ame);
> +	printf("\tfsid         : %llx\n", (unsigned long long)f->f_fsid);
> +	printf("\tsbid         : %llx\n", (unsigned long long)f->f_sb_id);
> +}
> +
> +static void dump_fsinfo_generic_limits(void *reply, unsigned int size)
> +{
> +	struct fsinfo_limits *f =3D reply;
> +
> +	printf("\n");
> +	printf("\tmax file size: %llx%016llx\n",
> +	       (unsigned long long)f->max_file_size.hi,
> +	       (unsigned long long)f->max_file_size.lo);
> +	printf("\tmax ino      : %llx%016llx\n",
> +	       (unsigned long long)f->max_ino.hi,
> +	       (unsigned long long)f->max_ino.lo);
> +	printf("\tmax ids      : u=3D%llx g=3D%llx p=3D%llx\n",
> +	       (unsigned long long)f->max_uid,
> +	       (unsigned long long)f->max_gid,
> +	       (unsigned long long)f->max_projid);
> +	printf("\tmax dev      : maj=3D%x min=3D%x\n",
> +	       f->max_dev_major, f->max_dev_minor);
> +	printf("\tmax links    : %llx\n",
> +	       (unsigned long long)f->max_hard_links);
> +	printf("\tmax xattr    : n=3D%x b=3D%llx\n",
> +	       f->max_xattr_name_len,
> +	       (unsigned long long)f->max_xattr_body_len);
> +	printf("\tmax len      : file=3D%x sym=3D%x\n",
> +	       f->max_filename_len, f->max_symlink_len);
> +}
> +
> +static void dump_fsinfo_generic_supports(void *reply, unsigned int size)
> +{
> +	struct fsinfo_supports *f =3D reply;
> +
> +	printf("\n");
> +	printf("\tstx_attr     : %llx\n", (unsigned long long)f->stx_attributes=
);
> +	printf("\tstx_mask     : %x\n", f->stx_mask);
> +	printf("\tfs_ioc_*flags: get=3D%x set=3D%x clr=3D%x\n",
> +	       f->fs_ioc_getflags, f->fs_ioc_setflags_set, f->fs_ioc_setflags_c=
lear);
> +	printf("\twin_fattrs   : %x\n", f->win_file_attrs);
> +}
> +
> +static void print_time(struct fsinfo_timestamp_one *t, char stamp)
> +{
> +	printf("\t%ctime       : gran=3D%gs range=3D%llx-%llx\n",
> +	       stamp,
> +	       t->gran_mantissa * pow(10., t->gran_exponent),
> +	       (long long)t->minimum,
> +	       (long long)t->maximum);
> +}
> +
> +static void dump_fsinfo_generic_timestamp_info(void *reply, unsigned int=
 size)
> +{
> +	struct fsinfo_timestamp_info *f =3D reply;
> +
> +	printf("\n");
> +	print_time(&f->atime, 'a');
> +	print_time(&f->mtime, 'm');
> +	print_time(&f->ctime, 'c');
> +	print_time(&f->btime, 'b');
> +}
> +
> +static void dump_fsinfo_generic_volume_uuid(void *reply, unsigned int si=
ze)
> +{
> +	struct fsinfo_volume_uuid *f =3D reply;
> +
> +	printf("%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x"
> +	       "-%02x%02x%02x%02x%02x%02x\n",
> +	       f->uuid[ 0], f->uuid[ 1],
> +	       f->uuid[ 2], f->uuid[ 3],
> +	       f->uuid[ 4], f->uuid[ 5],
> +	       f->uuid[ 6], f->uuid[ 7],
> +	       f->uuid[ 8], f->uuid[ 9],
> +	       f->uuid[10], f->uuid[11],
> +	       f->uuid[12], f->uuid[13],
> +	       f->uuid[14], f->uuid[15]);
> +}
> +
> +static void dump_string(void *reply, unsigned int size)
> +{
> +	char *s =3D reply, *p;
> +
> +	p =3D s;
> +	if (size >=3D 4096) {
> +		size =3D 4096;
> +		p[4092] =3D '.';
> +		p[4093] =3D '.';
> +		p[4094] =3D '.';
> +		p[4095] =3D 0;
> +	} else {
> +		p[size] =3D 0;
> +	}
> +
> +	for (p =3D s; *p; p++) {
> +		if (!isprint(*p)) {
> +			printf("<non-printable>\n");
> +			continue;
> +		}
> +	}
> +
> +	printf("%s\n", s);
> +}
> +
> +#define dump_fsinfo_generic_volume_id		dump_string
> +#define dump_fsinfo_generic_volume_name		dump_string
> +
> +/*
> + *
> + */
> +#define __FSINFO(A, T, S, U, G, F) \
> +	{ .attr_id =3D A, .type =3D T, .size =3D S, .name =3D #G, .dump =3D dum=
p_##G }
> +
> +#define _FSINFO(A, T, S, U, G)	  __FSINFO(A, T, S, U, G, 0)
> +#define _FSINFO_N(A, T, S, U, G)  __FSINFO(A, T, S, U, G, FSINFO_FLAGS_N)
> +#define _FSINFO_NM(A, T, S, U, G) __FSINFO(A, T, S, U, G, FSINFO_FLAGS_N=
M)
> +
> +#define _FSINFO_VSTRUCT(A,S,G)	 _FSINFO    (A, FSINFO_TYPE_VSTRUCT, size=
of(S), 0, G)
> +#define _FSINFO_VSTRUCT_N(A,S,G) _FSINFO_N  (A, FSINFO_TYPE_VSTRUCT, siz=
eof(S), 0, G)
> +#define _FSINFO_VSTRUCT_NM(A,S,G) _FSINFO_NM(A, FSINFO_TYPE_VSTRUCT, siz=
eof(S), 0, G)
> +
> +#define FSINFO_VSTRUCT(A,G)	_FSINFO_VSTRUCT   (A, A##__STRUCT, G)
> +#define FSINFO_VSTRUCT_N(A,G)	_FSINFO_VSTRUCT_N (A, A##__STRUCT, G)
> +#define FSINFO_VSTRUCT_NM(A,G)	_FSINFO_VSTRUCT_NM(A, A##__STRUCT, G)
> +#define FSINFO_STRING(A,G)	_FSINFO   (A, FSINFO_TYPE_STRING, 0, 0, G)
> +#define FSINFO_STRING_N(A,G)	_FSINFO_N (A, FSINFO_TYPE_STRING, 0, 0, G)
> +#define FSINFO_STRING_NM(A,G)	_FSINFO_NM(A, FSINFO_TYPE_STRING, 0, 0, G)
> +#define FSINFO_OPAQUE(A,G)	_FSINFO   (A, FSINFO_TYPE_OPAQUE, 0, 0, G)
> +#define FSINFO_LIST(A,G)	_FSINFO   (A, FSINFO_TYPE_LIST, 0, sizeof(A##__=
STRUCT), G)
> +#define FSINFO_LIST_N(A,G)	_FSINFO_N (A, FSINFO_TYPE_LIST, 0, sizeof(A##=
__STRUCT), G)
> +
> +static const struct fsinfo_attribute fsinfo_attributes[] =3D {
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_STATFS,		fsinfo_generic_statfs),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_IDS,		fsinfo_generic_ids),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_LIMITS,		fsinfo_generic_limits),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_SUPPORTS,		fsinfo_generic_supports),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_TIMESTAMP_INFO,	fsinfo_generic_timestamp_in=
fo),
> +	FSINFO_STRING	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
> +	FSINFO_STRING	(FSINFO_ATTR_VOLUME_NAME,	fsinfo_generic_volume_name),
> +	{}
> +};
> +
> +static void dump_value(unsigned int attr_id,
> +		       const struct fsinfo_attribute *attr,
> +		       const struct fsinfo_attribute_info *attr_info,
> +		       void *reply, unsigned int size)
> +{
> +	if (!attr || !attr->dump) {
> +		printf("<no dumper>\n");
> +		return;
> +	}
> +
> +	if (attr->type =3D=3D FSINFO_TYPE_VSTRUCT && size < attr->size) {
> +		printf("<short data %u/%u>\n", size, attr->size);
> +		return;
> +	}
> +
> +	attr->dump(reply, size);
> +}
> +
> +static void dump_list(unsigned int attr_id,
> +		      const struct fsinfo_attribute *attr,
> +		      const struct fsinfo_attribute_info *attr_info,
> +		      void *reply, unsigned int size)
> +{
> +	size_t elem_size =3D attr_info->size;
> +	unsigned int ix =3D 0;
> +
> +	printf("\n");
> +	if (!attr || !attr->dump) {
> +		printf("<no dumper>\n");
> +		return;
> +	}
> +
> +	if (attr->type =3D=3D FSINFO_TYPE_VSTRUCT && size < attr->size) {
> +		printf("<short data %u/%u>\n", size, attr->size);
> +		return;
> +	}
> +
> +	while (size >=3D elem_size) {
> +		printf("\t[%02x] ", ix);
> +		attr->dump(reply, size);
> +		reply +=3D elem_size;
> +		size -=3D elem_size;
> +		ix++;
> +	}
> +}
> +
> +/*
> + * Call fsinfo, expanding the buffer as necessary.
> + */
> +static ssize_t get_fsinfo(const char *file, const char *name,
> +			  struct fsinfo_params *params, void **_r)
> +{
> +	ssize_t ret;
> +	size_t buf_size =3D 4096;
> +	void *r;
> +
> +	for (;;) {
> +		r =3D malloc(buf_size);
> +		if (!r) {
> +			perror("malloc");
> +			exit(1);
> +		}
> +		memset(r, 0xbd, buf_size);
> +
> +		errno =3D 0;
> +		ret =3D fsinfo(AT_FDCWD, file, params, r, buf_size);
> +		if (ret =3D=3D -1) {
> +			free(r);
> +			*_r =3D NULL;
> +			return ret;
> +		}
> +
> +		if (ret <=3D buf_size)
> +			break;
> +		buf_size =3D (ret + 4096 - 1) & ~(4096 - 1);
> +	}
> +
> +	if (debug) {
> +		if (ret =3D=3D -1)
> +			printf("fsinfo(%s,%s,%u,%u) =3D %m\n",
> +			       file, name, params->Nth, params->Mth);
> +		else
> +			printf("fsinfo(%s,%s,%u,%u) =3D %zd\n",
> +			       file, name, params->Nth, params->Mth, ret);
> +	}
> +
> +	*_r =3D r;
> +	return ret;
> +}
> +
> +/*
> + * Try one subinstance of an attribute.
> + */
> +static int try_one(const char *file, struct fsinfo_params *params,
> +		   const struct fsinfo_attribute_info *attr_info, bool raw)
> +{
> +	const struct fsinfo_attribute *attr;
> +	const char *name;
> +	size_t size =3D 4096;
> +	char namebuf[32];
> +	void *r;
> +
> +	for (attr =3D fsinfo_attributes; attr->name; attr++) {
> +		if (attr->attr_id =3D=3D params->request) {
> +			name =3D attr->name;
> +			if (strncmp(name, "fsinfo_generic_", 15) =3D=3D 0)
> +				name +=3D 15;
> +			goto found;
> +		}
> +	}
> +
> +	sprintf(namebuf, "<unknown-%x>", params->request);
> +	name =3D namebuf;
> +	attr =3D NULL;
> +
> +found:
> +	size =3D get_fsinfo(file, name, params, &r);
> +
> +	if (size =3D=3D -1) {
> +		if (errno =3D=3D ENODATA) {
> +			if (!(attr_info->flags & (FSINFO_FLAGS_N | FSINFO_FLAGS_NM)) &&
> +			    params->Nth =3D=3D 0 && params->Mth =3D=3D 0) {
> +				fprintf(stderr,
> +					"Unexpected ENODATA (0x%x{%u}{%u})\n",
> +					params->request, params->Nth, params->Mth);
> +				exit(1);
> +			}
> +			free(r);
> +			return (params->Mth =3D=3D 0) ? 2 : 1;
> +		}
> +		if (errno =3D=3D EOPNOTSUPP) {
> +			if (params->Nth > 0 || params->Mth > 0) {
> +				fprintf(stderr,
> +					"Should return -ENODATA (0x%x{%u}{%u})\n",
> +					params->request, params->Nth, params->Mth);
> +				exit(1);
> +			}
> +			//printf("\e[33m%s\e[m: <not supported>\n",
> +			//       fsinfo_attr_names[attr]);
> +			free(r);
> +			return 2;
> +		}
> +		perror(file);
> +		exit(1);
> +	}
> +
> +	if (raw) {
> +		if (size > 4096)
> +			size =3D 4096;
> +		dump_hex(r, 0, size);
> +		free(r);
> +		return 0;
> +	}
> +
> +	switch (attr_info->flags & (FSINFO_FLAGS_N | FSINFO_FLAGS_NM)) {
> +	case 0:
> +		printf("\e[33m%s\e[m: ", name);
> +		break;
> +	case FSINFO_FLAGS_N:
> +		printf("\e[33m%s{%u}\e[m: ", name, params->Nth);
> +		break;
> +	case FSINFO_FLAGS_NM:
> +		printf("\e[33m%s{%u,%u}\e[m: ", name, params->Nth, params->Mth);
> +		break;
> +	}
> +
> +	switch (attr_info->type) {
> +	case FSINFO_TYPE_VSTRUCT:
> +	case FSINFO_TYPE_STRING:
> +		dump_value(params->request, attr, attr_info, r, size);
> +		free(r);
> +		return 0;
> +
> +	case FSINFO_TYPE_LIST:
> +		dump_list(params->request, attr, attr_info, r, size);
> +		free(r);
> +		return 0;
> +
> +	case FSINFO_TYPE_OPAQUE:
> +		free(r);
> +		return 0;
> +
> +	default:
> +		fprintf(stderr, "Fishy about %u 0x%x,%x,%x\n",
> +			params->request, attr_info->type, attr_info->flags, attr_info->size);
> +		exit(1);
> +	}
> +}
> +
> +static int cmp_u32(const void *a, const void *b)
> +{
> +	return *(const int *)a - *(const int *)b;
> +}
> +
> +/*
> + *
> + */
> +int main(int argc, char **argv)
> +{
> +	struct fsinfo_attribute_info attr_info;
> +	struct fsinfo_params params =3D {
> +		.at_flags	=3D AT_SYMLINK_NOFOLLOW,
> +		.flags		=3D FSINFO_FLAGS_QUERY_PATH,
> +	};
> +	unsigned int *attrs, ret, nr, i;
> +	bool meta =3D false;
> +	int raw =3D 0, opt, Nth, Mth;
> +
> +	while ((opt =3D getopt(argc, argv, "adlmr"))) {
> +		switch (opt) {
> +		case 'a':
> +			params.at_flags |=3D AT_NO_AUTOMOUNT;
> +			continue;
> +		case 'd':
> +			debug =3D true;
> +			continue;
> +		case 'l':
> +			params.at_flags &=3D ~AT_SYMLINK_NOFOLLOW;
> +			continue;
> +		case 'm':
> +			meta =3D true;
> +			continue;
> +		case 'r':
> +			raw =3D 1;
> +			continue;
> +		}
> +		break;
> +	}
> +
> +	argc -=3D optind;
> +	argv +=3D optind;
> +
> +	if (argc !=3D 1) {
> +		printf("Format: test-fsinfo [-alr] <file>\n");
> +		exit(2);
> +	}
> +
> +	/* Retrieve a list of supported attribute IDs */
> +	params.request =3D FSINFO_ATTR_FSINFO_ATTRIBUTES;
> +	params.Nth =3D 0;
> +	params.Mth =3D 0;
> +	ret =3D get_fsinfo(argv[0], "attributes", &params, (void **)&attrs);
> +	if (ret =3D=3D -1) {
> +		fprintf(stderr, "Unable to get attribute list: %m\n");
> +		exit(1);
> +	}
> +
> +	if (ret % sizeof(attrs[0])) {
> +		fprintf(stderr, "Bad length of attribute list (0x%x)\n", ret);
> +		exit(2);
> +	}
> +
> +	nr =3D ret / sizeof(attrs[0]);
> +	qsort(attrs, nr, sizeof(attrs[0]), cmp_u32);
> +
> +	if (meta) {
> +		printf("ATTR ID  TYPE         FLAGS    SIZE  NAME\n");
> +		printf("=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> +		for (i =3D 0; i < nr; i++) {
> +			params.request =3D FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO;
> +			params.Nth =3D attrs[i];
> +			params.Mth =3D 0;
> +			ret =3D fsinfo(AT_FDCWD, argv[0], &params, &attr_info, sizeof(attr_in=
fo));
> +			if (ret =3D=3D -1) {
> +				fprintf(stderr, "Can't get info for attribute %x: %m\n", attrs[i]);
> +				exit(1);
> +			}
> +
> +			dump_attribute_info(&attr_info, ret);
> +		}
> +		exit(0);
> +	}
> +
> +	for (i =3D 0; i < nr; i++) {
> +		params.request =3D FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO;
> +		params.Nth =3D attrs[i];
> +		params.Mth =3D 0;
> +		ret =3D fsinfo(AT_FDCWD, argv[0], &params, &attr_info, sizeof(attr_inf=
o));
> +		if (ret =3D=3D -1) {
> +			fprintf(stderr, "Can't get info for attribute %x: %m\n", attrs[i]);
> +			exit(1);
> +		}
> +
> +		if (attrs[i] =3D=3D FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO ||
> +		    attrs[i] =3D=3D FSINFO_ATTR_FSINFO_ATTRIBUTES)
> +			continue;
> +
> +		if (attrs[i] !=3D attr_info.attr_id) {
> +			fprintf(stderr, "ID for %03x returned %03x\n",
> +				attrs[i], attr_info.attr_id);
> +			break;
> +		}
> +		Nth =3D 0;
> +		do {
> +			Mth =3D 0;
> +			do {
> +				params.request =3D attrs[i];
> +				params.Nth =3D Nth;
> +				params.Mth =3D Mth;
> +
> +				switch (try_one(argv[0], &params, &attr_info, raw)) {
> +				case 0:
> +					continue;
> +				case 1:
> +					goto done_M;
> +				case 2:
> +					goto done_N;
> +				}
> +			} while (++Mth < 100);
> +
> +		done_M:
> +			if (Mth >=3D 100) {
> +				fprintf(stderr, "Fishy: Mth %x[%u][%u]\n", attrs[i], Nth, Mth);
> +				break;
> +			}
> +
> +		} while (++Nth < 100);
> +
> +	done_N:
> +		if (Nth >=3D 100) {
> +			fprintf(stderr, "Fishy: Nth %x[%u]\n", attrs[i], Nth);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
>=20
>=20


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--xmvp4mevtdwkh2f4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXlXX8wAKCRCdlLljIbnQ
EsofAQCNgqpSfaA4tHEvCpMtyMSyg5vS/Ua0qoeGjWrskW9ADgEA2LMVDIabgyru
seSGSkZ6iDkBaFDD8jRAyKc3DaMqnQ4=
=gz3a
-----END PGP SIGNATURE-----

--xmvp4mevtdwkh2f4--
