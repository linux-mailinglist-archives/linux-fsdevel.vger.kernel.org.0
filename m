Return-Path: <linux-fsdevel+bounces-57512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE258B22B35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 16:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9CE188A6AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F03C2F5314;
	Tue, 12 Aug 2025 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP9qk7IW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF02F4A17;
	Tue, 12 Aug 2025 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010400; cv=none; b=pyoJezRLkiUFip9fpRcngCZijF2N1PbZBxAI3NsTKvAJtGSjW8EkHFMOgpBMtaNZJRAIj0NsmbztZI18dJ1HCP9AT/1PJsEHi34sh6ofybobgnZYkIJ0hTNNrsXZMpLenIps+aPfKoS3I6a9lzY/AErF1xmFW7WQXXZF5Q6ZeaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010400; c=relaxed/simple;
	bh=TdI2PtZZONHdUGv3XhKihqPXdKx4/sZpkMEtm+pyKHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXg9RDrAc0rfmfqgfmUeUsK7tn7phrBHrHh08Nki6DfdWGSpH/Fz9on0p9l4EQ8thhkvgnYadYWKcw9jvnACLsG0lbJjElGI7dNdZsuBdKdigM2fyMdCeuStCe+5xA/t/cwI7e/RZ5RKf2HDdUr4/ZhRXMxAD5LvinSXx5C9P8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP9qk7IW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79172C4CEF1;
	Tue, 12 Aug 2025 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755010399;
	bh=TdI2PtZZONHdUGv3XhKihqPXdKx4/sZpkMEtm+pyKHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EP9qk7IW/2sgFPXCyswx1I03xePonkIvOmbw85n9wuRgHIWCxN+1Rqg4fzXAxurQ3
	 i3osVTpaGLu4l6Mdhc41h26dGPfc0VF21SH3t7kaxsHrGGUxjwkS//ZjMnNqXPHZtF
	 Qjf4YNIuQIuc7fKPkvoARuwLc3tE1ILoj7HcQ1QNvzKUezqWtfFiUYsYlorEZTX4hK
	 nEmARRiDq97NoHPw9yfm7IpWGds4kJXnKcXsERalfKY9NZU5jf7WTFEUNUYkl4mMFd
	 pJBNWxH2go3oYC6r6bNIiwqr0Vv7welggZ0GKSqjuK0F3vfAKLZZuL02O0W6mEq4gT
	 zGuLp95cVqBmQ==
Date: Tue, 12 Aug 2025 07:53:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/4] libfrog: add wrappers for file_getattr/file_setattr
 syscalls
Message-ID: <20250812145318.GE7942@frogsfrogsfrogs>
References: <20250808-xattrat-syscall-v1-0-48567c29e45c@kernel.org>
 <20250808-xattrat-syscall-v1-1-48567c29e45c@kernel.org>
 <20250811150242.GA7965@frogsfrogsfrogs>
 <echftqsxxxecifnok2j3tbel377ds7cud2cm5kjc5qbtwszn2m@retzo6pcntfv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <echftqsxxxecifnok2j3tbel377ds7cud2cm5kjc5qbtwszn2m@retzo6pcntfv>

On Mon, Aug 11, 2025 at 07:44:14PM +0200, Andrey Albershteyn wrote:
> On 2025-08-11 08:02:42, Darrick J. Wong wrote:
> > On Fri, Aug 08, 2025 at 09:30:16PM +0200, Andrey Albershteyn wrote:
> > > Add wrappers for new file_getattr/file_setattr inode syscalls which will
> > > be used by xfs_quota and xfs_io.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ---
> > >  configure.ac          |   1 +
> > >  include/builddefs.in  |   5 +++
> > >  include/linux.h       |  20 ++++++++++
> > >  libfrog/Makefile      |   2 +
> > >  libfrog/file_attr.c   | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  libfrog/file_attr.h   |  35 +++++++++++++++++
> > >  m4/package_libcdev.m4 |  19 +++++++++
> > >  7 files changed, 187 insertions(+)
> > > 
> > > diff --git a/configure.ac b/configure.ac
> > > index 9a3309bcdfd1..40a44c571e7b 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -156,6 +156,7 @@ AC_PACKAGE_NEED_RCU_INIT
> > >  AC_HAVE_PWRITEV2
> > >  AC_HAVE_COPY_FILE_RANGE
> > >  AC_HAVE_CACHESTAT
> > > +AC_HAVE_FILE_ATTR
> > >  AC_NEED_INTERNAL_FSXATTR
> > >  AC_NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG
> > >  AC_NEED_INTERNAL_FSCRYPT_POLICY_V2
> > > diff --git a/include/builddefs.in b/include/builddefs.in
> > > index 04b4e0880a84..d727b55b854f 100644
> > > --- a/include/builddefs.in
> > > +++ b/include/builddefs.in
> > > @@ -97,6 +97,7 @@ HAVE_ZIPPED_MANPAGES = @have_zipped_manpages@
> > >  HAVE_PWRITEV2 = @have_pwritev2@
> > >  HAVE_COPY_FILE_RANGE = @have_copy_file_range@
> > >  HAVE_CACHESTAT = @have_cachestat@
> > > +HAVE_FILE_ATTR = @have_file_attr@
> > >  NEED_INTERNAL_FSXATTR = @need_internal_fsxattr@
> > >  NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG = @need_internal_fscrypt_add_key_arg@
> > >  NEED_INTERNAL_FSCRYPT_POLICY_V2 = @need_internal_fscrypt_policy_v2@
> > > @@ -169,6 +170,10 @@ ifeq ($(ENABLE_GETTEXT),yes)
> > >  GCFLAGS += -DENABLE_GETTEXT
> > >  endif
> > >  
> > > +ifeq ($(HAVE_FILE_ATTR),yes)
> > > +LCFLAGS += -DHAVE_FILE_ATTR
> > > +endif
> > > +
> > >  # Override these if C++ needs other options
> > >  SANITIZER_CXXFLAGS = $(SANITIZER_CFLAGS)
> > >  GCXXFLAGS = $(GCFLAGS)
> > > diff --git a/include/linux.h b/include/linux.h
> > > index 6e83e073aa2e..018cc78960e3 100644
> > > --- a/include/linux.h
> > > +++ b/include/linux.h
> > > @@ -16,6 +16,7 @@
> > >  #include <sys/param.h>
> > >  #include <sys/sysmacros.h>
> > >  #include <sys/stat.h>
> > > +#include <sys/syscall.h>
> > >  #include <inttypes.h>
> > >  #include <malloc.h>
> > >  #include <getopt.h>
> > > @@ -202,6 +203,25 @@ struct fsxattr {
> > >  };
> > >  #endif
> > >  
> > > +/*
> > > + * Use __NR_file_getattr instead of build system HAVE_FILE_ATTR as this header
> > > + * could be included in other places where HAVE_FILE_ATTR is not defined (e.g.
> > > + * xfstests's conftest.c in ./configure)
> > > + */
> > > +#ifndef __NR_file_getattr
> > 
> > Seeing as uapi fs.h now has:
> > 
> > #define FILE_ATTR_SIZE_VER0 24
> > #define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
> > 
> > I wonder if you'd be better off gating on one of those defines rather
> > than the presence of the syscall number?
> 
> Hmm, yeah, should work
> 
> > 
> > > +/*
> > > + * We need to define file_attr if it's missing to know how to convert it to
> > > + * fsxattr
> > > + */
> > > +struct file_attr {
> > > +	__u32		fa_xflags;
> > > +	__u32		fa_extsize;
> > > +	__u32		fa_nextents;
> > > +	__u32		fa_projid;
> > > +	__u32		fa_cowextsize;
> > > +};
> > > +#endif
> > > +
> > >  #ifndef FS_IOC_FSGETXATTR
> > >  /*
> > >   * Flags for the fsx_xflags field
> > > diff --git a/libfrog/Makefile b/libfrog/Makefile
> > > index b64ca4597f4e..7d49fd0fe6cc 100644
> > > --- a/libfrog/Makefile
> > > +++ b/libfrog/Makefile
> > > @@ -24,6 +24,7 @@ fsproperties.c \
> > >  fsprops.c \
> > >  getparents.c \
> > >  histogram.c \
> > > +file_attr.c \
> > >  list_sort.c \
> > >  linux.c \
> > >  logging.c \
> > > @@ -55,6 +56,7 @@ fsprops.h \
> > >  getparents.h \
> > >  handle_priv.h \
> > >  histogram.h \
> > > +file_attr.h \
> > >  logging.h \
> > >  paths.h \
> > >  projects.h \
> > > diff --git a/libfrog/file_attr.c b/libfrog/file_attr.c
> > > new file mode 100644
> > > index 000000000000..8592d775f554
> > > --- /dev/null
> > > +++ b/libfrog/file_attr.c
> > > @@ -0,0 +1,105 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2024 Red Hat, Inc.
> > > + * All Rights Reserved.
> > > + */
> > > +
> > > +#include "file_attr.h"
> > > +#include <stdio.h>
> > > +#include <errno.h>
> > > +#include <string.h>
> > > +#include <sys/syscall.h>
> > > +#include <asm/types.h>
> > > +#include <fcntl.h>
> > > +
> > > +static void
> > > +file_attr_to_fsxattr(
> > > +	const struct file_attr	*fa,
> > > +	struct fsxattr		*fsxa)
> > > +{
> > > +     memset(fsxa, 0, sizeof(struct fsxattr));
> > > +
> > > +     fsxa->fsx_xflags = fa->fa_xflags;
> > > +     fsxa->fsx_extsize = fa->fa_extsize;
> > > +     fsxa->fsx_nextents = fa->fa_nextents;
> > > +     fsxa->fsx_projid = fa->fa_projid;
> > > +     fsxa->fsx_cowextsize = fa->fa_cowextsize;
> > > +
> > > +}
> > > +
> > > +static void
> > > +fsxattr_to_file_attr(
> > > +	const struct fsxattr	*fsxa,
> > > +	struct file_attr	*fa)
> > > +{
> > > +     memset(fa, 0, sizeof(struct file_attr));
> > > +
> > > +     fa->fa_xflags = fsxa->fsx_xflags;
> > > +     fa->fa_extsize = fsxa->fsx_extsize;
> > > +     fa->fa_nextents = fsxa->fsx_nextents;
> > > +     fa->fa_projid = fsxa->fsx_projid;
> > > +     fa->fa_cowextsize = fsxa->fsx_cowextsize;
> > > +}
> > > +
> > > +int
> > > +file_getattr(
> > > +	const int		dfd,
> > > +	const char		*path,
> > > +	const struct stat	*stat,
> > > +	struct file_attr	*fa,
> > > +	const unsigned int	at_flags)
> > > +{
> > 
> > Will this cause a naming conflict when libc wraps the new syscall?
> 
> xfrog_file_getattr?
> 
> > 
> > > +	int			error;
> > > +	int			fd;
> > > +	struct fsxattr		fsxa;
> > > +
> > > +#ifdef HAVE_FILE_ATTR
> > > +	return syscall(__NR_file_getattr, dfd, path, fa,
> > > +			sizeof(struct file_attr), at_flags);
> > 
> > What happens if we build xfsprogs on new userspace but it then gets run
> > on an old kernel that doesn't support file_getattr(2)?  Shouldn't we
> > fall back to the old ioctl on ENOSYS?
> 
> oh right, missed that. I can add this check.
> 
> Is it something common in general? I suppose booting into older
> kernel when xfsprogs was compiled with the "current" one is one case
> but it's expected that kernel can miss some features

I don't think it's common among packaged distributions, but developers
(or at least myself) regularly do things like that.

> > 
> > > +#else
> > > +	if (SPECIAL_FILE(stat->st_mode))
> > > +		return 0;
> > 
> > Why does it return 0 without filling out @fa?  Shouldn't this be
> > EOPNOTSUPP or something?
> > 
> > > +#endif
> > > +
> > > +	fd = open(path, O_RDONLY|O_NOCTTY);
> > > +	if (fd == -1)
> > > +		return errno;
> > > +
> > > +	error = ioctl(fd, FS_IOC_FSGETXATTR, &fsxa);
> > > +	close(fd);
> > > +
> > > +	fsxattr_to_file_attr(&fsxa, fa);
> > 
> > Er... if the ioctl errors out, fsxa will still be uninitialized stack
> > garbage, which is (pointlessly) copied to the caller's fa structure.
> > 
> > > +
> > > +	return error;
> > 
> > I'm confused about the return value of this function.  If the syscall
> > or the ioctl fail we'll pass the -1 to the caller and let them access
> > errno, but if the open fails we return errno directly?
> 
> I was trying to just wrap the old code without changing the output,
> I haven't thought too hard about design of this function. I will
> apply your suggestion including EOPNOSUPP mentioned in other mail.

<nod>

--D

> > 
> > > +}
> > > +
> > > +int
> > > +file_setattr(
> > > +	const int		dfd,
> > > +	const char		*path,
> > > +	const struct stat	*stat,
> > > +	struct file_attr	*fa,
> > > +	const unsigned int	at_flags)
> > > +{
> > > +	int			error;
> > > +	int			fd;
> > > +	struct fsxattr		fsxa;
> > > +
> > > +#ifdef HAVE_FILE_ATTR
> > > +	return syscall(__NR_file_setattr, dfd, path, fa,
> > > +			sizeof(struct file_attr), at_flags);
> > > +#else
> > > +	if (SPECIAL_FILE(stat->st_mode))
> > > +		return 0;
> > > +#endif
> > > +
> > > +	fd = open(path, O_RDONLY|O_NOCTTY);
> > > +	if (fd == -1)
> > > +		return errno;
> > 
> > Same comments that I had about file_getattr.
> > 
> > > +
> > > +	file_attr_to_fsxattr(fa, &fsxa);
> > > +	error = ioctl(fd, FS_IOC_FSSETXATTR, fa);
> > > +	close(fd);
> > > +
> > > +	return error;
> > > +}
> > > diff --git a/libfrog/file_attr.h b/libfrog/file_attr.h
> > > new file mode 100644
> > > index 000000000000..3e56e80a6f95
> > > --- /dev/null
> > > +++ b/libfrog/file_attr.h
> > > @@ -0,0 +1,35 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2024 Red Hat, Inc.
> > > + * All Rights Reserved.
> > > + */
> > > +#ifndef __LIBFROG_IXATTR_H__
> > > +#define __LIBFROG_IXATTR_H__
> > 
> > __LIBFROG_FILE_ATTR_H__ ?
> 
> ops, right
> 
> > 
> > --D
> > 
> > > +
> > > +#include "linux.h"
> > > +#include <sys/stat.h>
> > > +
> > > +#define SPECIAL_FILE(x) \
> > > +	   (S_ISCHR((x)) \
> > > +	|| S_ISBLK((x)) \
> > > +	|| S_ISFIFO((x)) \
> > > +	|| S_ISLNK((x)) \
> > > +	|| S_ISSOCK((x)))
> > > +
> > > +int
> > > +file_getattr(
> > > +	const int		dfd,
> > > +	const char		*path,
> > > +	const struct stat	*stat,
> > > +	struct file_attr	*fa,
> > > +	const unsigned int	at_flags);
> > > +
> > > +int
> > > +file_setattr(
> > > +	const int		dfd,
> > > +	const char		*path,
> > > +	const struct stat	*stat,
> > > +	struct file_attr	*fa,
> > > +	const unsigned int	at_flags);
> > > +
> > > +#endif /* __LIBFROG_IXATTR_H__ */
> > > diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
> > > index 61353d0aa9d5..cb8ff1576d01 100644
> > > --- a/m4/package_libcdev.m4
> > > +++ b/m4/package_libcdev.m4
> > > @@ -274,3 +274,22 @@ AC_DEFUN([AC_PACKAGE_CHECK_LTO],
> > >      AC_SUBST(lto_cflags)
> > >      AC_SUBST(lto_ldflags)
> > >    ])
> > > +
> > > +#
> > > +# Check if we have a file_getattr/file_setattr system call (Linux)
> > > +#
> > > +AC_DEFUN([AC_HAVE_FILE_ATTR],
> > > +  [ AC_MSG_CHECKING([for file_getattr/file_setattr syscalls])
> > > +    AC_LINK_IFELSE(
> > > +    [	AC_LANG_PROGRAM([[
> > > +#define _GNU_SOURCE
> > > +#include <sys/syscall.h>
> > > +#include <unistd.h>
> > > +	]], [[
> > > +syscall(__NR_file_getattr, 0, 0, 0, 0, 0);
> > > +	]])
> > > +    ], have_file_attr=yes
> > > +       AC_MSG_RESULT(yes),
> > > +       AC_MSG_RESULT(no))
> > > +    AC_SUBST(have_file_attr)
> > > +  ])
> > > 
> > > -- 
> > > 2.49.0
> > > 
> > > 
> > 
> 
> -- 
> - Andrey
> 
> 

