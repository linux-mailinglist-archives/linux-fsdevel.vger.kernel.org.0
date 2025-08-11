Return-Path: <linux-fsdevel+bounces-57404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AF5B213B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 19:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA532A856E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16482DE6FB;
	Mon, 11 Aug 2025 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGtvsy5x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F942DE6F7
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934678; cv=none; b=O6nLOspdUDgkWnulpVzJstYb+N4o2T8HsHeoSO7gnKooEE507Wc2KRfqxduImuyuVWt/C+2RpCQBL56JI813bP9k+utAGUii7moOOd3cQNSvL9bZpt+5NKduucBZMuJpZUBIg0jlllN7YRqlaRU31B1cuM/5kje1bbxfDrCzOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934678; c=relaxed/simple;
	bh=mxwpF/ZwfXnqofUfYke4BnsBBoVoJ7UB9pcyIHvjePk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/AkfsTOpHGu+btJY9zLDlvBjKzRDK9R1mPwMzgw4HJ1hqrFZk7UuksLmq+qV5kMQ+nwRTw6NhX+LHDXU6jNt05XbFHw2+eNhF6FZ03EkxIUvFOkVYunWy0DClmuJS/7/e0sKaGYKENO4xfD7YGHYWThTmQ7EW+TAysgFKZGpfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGtvsy5x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754934675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q7+rZH6WnIGqbNTKb5oY0f2u0sqgS7mW8iFDFrpObwE=;
	b=NGtvsy5xRitwVcTv371FePbCyPcRgtxCS6irT2hv2hMVknvgY2XbaAq3PvoPW3bLf/S/7Q
	9JFrODhsJwZDUeJBr+taOeRm+TXRWHZYqqnF2YX6+Tv6ScBuXFWZNHUJYSQdNr/LZSZsBa
	f8flr4si5MbjJRfIyw6JZlD4HGuaoKw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-hcXfjYhsM-OhNGmVSiiUzQ-1; Mon, 11 Aug 2025 13:51:13 -0400
X-MC-Unique: hcXfjYhsM-OhNGmVSiiUzQ-1
X-Mimecast-MFC-AGG-ID: hcXfjYhsM-OhNGmVSiiUzQ_1754934672
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76be0be9ee1so4704561b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 10:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754934672; x=1755539472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7+rZH6WnIGqbNTKb5oY0f2u0sqgS7mW8iFDFrpObwE=;
        b=dzho3OvV02S2sD9fhh4l4MhQC2oOjV7PKUJz+TVZPRoLWwMl77OIgnRLix+KdAwvh8
         c851aeRcEqHvN1MEQSBXx6BgUBDFPF61gna1aSduSD2njaXNNDHy+iqsKmcU0gaITBhM
         zT3xDhUotUxF9Aekpq/vteXs4yJmUjNRcZTThywjJ7WkAiegTPlhRJMSoqpSrMXYDjuK
         01PM1JPz02co7wfSesDy3fcIA8sLbCUc6Q3i+4qjJrqo4skC8l890BTix0lFYl2Y+OCt
         +d4mNMoPNGlFT1vHZWslHuVADQbUQqTkiD6xD75kdnxRKfMLm4AreUSnHoZzNbzVkGw8
         /LMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUInZn7c6jIeEvGuEMwNlN75GN8QQ+E6fhiXwe9k8u0Z5XZtETiiTxj3eY3stSdrjkG0G/p6Az8UVFCMG3R@vger.kernel.org
X-Gm-Message-State: AOJu0YxVxMnIcSNO6FBgsk0tsopLew2HBXhixyHXJMdQbDWTrnU1r6mO
	x1kHKmtnj0S1KfBzEZ3k7QuQxbwmbM/fUlv42bjoNy4fAuCtJkoYa3jpM3DBJZhKKIts0dz2nSX
	LiSh6vfy6/Uv3wO0uttSbro1YPDnh/TMqXtakGAJ2I5yUkVs+noU4toduZLqg4MlueIU=
X-Gm-Gg: ASbGncvRbQ0zieR7lRqhC1rQI5Qqqu0D+3gzK/79q5AVbujoaixTb3imKMfz2yMTKH/
	aI/ILuRQ4GVGlpAQN73lbej9OdyT1WhGisdNQ7j9viMIqhUMta6oS8vnBGonn+xNjolCwNOB+ZL
	5XiTyu4y0PbqX50jFxggN2tJT+WFiYGHC7pasInqS6Ut6vIictk14Q35lWcH8xWhsM+yqzhAL3/
	AoTtxk20tS9SiIlWrfibTykTInV7ng3jHM5JOlRxTwkoCVq65wSHNKygEUW52ehJdvvp1oueKnu
	g7jTg0iBc7keok8U6QRlazh6kg2LgvgoaU5eHLjUK4OUfAou2IBLbTfbW0ZMa7LFVF3aXr7Vx5w
	drSzb
X-Received: by 2002:a05:6a00:10c9:b0:76b:dcc6:8138 with SMTP id d2e1a72fcca58-76e0df57951mr579610b3a.22.1754934672212;
        Mon, 11 Aug 2025 10:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJCgj2WDCu5xtksWjQYWSNJZnPdYLfvWjRhSIG3miAQD+nXjD9kfioCFV078aIweT1m3FYIw==
X-Received: by 2002:a05:6a00:10c9:b0:76b:dcc6:8138 with SMTP id d2e1a72fcca58-76e0df57951mr579577b3a.22.1754934671746;
        Mon, 11 Aug 2025 10:51:11 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd9b3b3d4sm25614672b3a.10.2025.08.11.10.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:51:11 -0700 (PDT)
Date: Tue, 12 Aug 2025 01:51:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 1/3] file_attr: introduce program to set/get fsxattr
Message-ID: <20250811175107.gxarqqcsftz5b6m4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
 <20250808-xattrat-syscall-v1-1-6a09c4f37f10@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-xattrat-syscall-v1-1-6a09c4f37f10@kernel.org>

On Fri, Aug 08, 2025 at 09:31:56PM +0200, Andrey Albershteyn wrote:
> This programs uses newly introduced file_getattr and file_setattr
> syscalls. This program is partially a test of invalid options. This will
> be used further in the test.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  .gitignore            |   1 +
>  configure.ac          |   1 +
>  include/builddefs.in  |   1 +
>  m4/package_libcdev.m4 |  16 +++
>  src/Makefile          |   5 +
>  src/file_attr.c       | 277 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 301 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 4fd817243dca..1a578eab1ea0 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -210,6 +210,7 @@ tags
>  /src/fiemap-fault
>  /src/min_dio_alignment
>  /src/dio-writeback-race
> +/src/file_attr

I'm wondering if xfsprogs/xfs_io would like to have this command :)

Thanks,
Zorro

>  
>  # Symlinked files
>  /tests/generic/035.out
> diff --git a/configure.ac b/configure.ac
> index f3c8c643f0eb..6fe54e8e1d54 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -73,6 +73,7 @@ AC_HAVE_RLIMIT_NOFILE
>  AC_NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
>  AC_HAVE_FICLONE
>  AC_HAVE_TRIVIAL_AUTO_VAR_INIT
> +AC_HAVE_FILE_ATTR
>  
>  AC_CHECK_FUNCS([renameat2])
>  AC_CHECK_FUNCS([reallocarray])
> diff --git a/include/builddefs.in b/include/builddefs.in
> index 96d5ed25b3e2..821237339cc7 100644
> --- a/include/builddefs.in
> +++ b/include/builddefs.in
> @@ -74,6 +74,7 @@ HAVE_BMV_OF_SHARED = @have_bmv_of_shared@
>  HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
>  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
>  HAVE_FICLONE = @have_ficlone@
> +HAVE_FILE_ATTR = @have_file_attr@
>  
>  GCCFLAGS = -std=gnu11 -funsigned-char -fno-strict-aliasing -Wall
>  SANITIZER_CFLAGS += @autovar_init_cflags@
> diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
> index ed8fe6e32ae0..e68a70f7d87e 100644
> --- a/m4/package_libcdev.m4
> +++ b/m4/package_libcdev.m4
> @@ -86,3 +86,19 @@ AC_DEFUN([AC_HAVE_TRIVIAL_AUTO_VAR_INIT],
>      CFLAGS="${OLD_CFLAGS}"
>      AC_SUBST(autovar_init_cflags)
>    ])
> +
> +#
> +# Check if we have a file_getattr/file_setattr system call (Linux)
> +#
> +AC_DEFUN([AC_HAVE_FILE_ATTR],
> +  [ AC_MSG_CHECKING([for file_getattr/file_setattr syscalls])
> +    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
> +#define _GNU_SOURCE
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +    ]], [[
> +         syscall(__NR_file_getattr, 0, 0, 0, 0, 0, 0);
> +    ]])],[have_file_attr=yes
> +       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
> +    AC_SUBST(have_file_attr)
> +  ])
> diff --git a/src/Makefile b/src/Makefile
> index 6ac72b366257..f3137acf687f 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -61,6 +61,11 @@ ifeq ($(HAVE_FALLOCATE), true)
>  LCFLAGS += -DHAVE_FALLOCATE
>  endif
>  
> +ifeq ($(HAVE_FILE_ATTR), yes)
> +LINUX_TARGETS += file_attr
> +LCFLAGS += -DHAVE_FILE_ATTR
> +endif
> +
>  ifeq ($(PKG_PLATFORM),linux)
>  TARGETS += $(LINUX_TARGETS)
>  endif
> diff --git a/src/file_attr.c b/src/file_attr.c
> new file mode 100644
> index 000000000000..9756ab265a57
> --- /dev/null
> +++ b/src/file_attr.c
> @@ -0,0 +1,277 @@
> +#include "global.h"
> +#include <sys/syscall.h>
> +#include <getopt.h>
> +#include <errno.h>
> +#include <linux/fs.h>
> +#include <sys/stat.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#ifndef HAVE_FILE_ATTR
> +#define __NR_file_getattr 468
> +#define __NR_file_setattr 469
> +
> +struct file_attr {
> +       __u32           fa_xflags;     /* xflags field value (get/set) */
> +       __u32           fa_extsize;    /* extsize field value (get/set)*/
> +       __u32           fa_nextents;   /* nextents field value (get)   */
> +       __u32           fa_projid;     /* project identifier (get/set) */
> +       __u32           fa_cowextsize; /* CoW extsize field value (get/set) */
> +};
> +
> +#endif
> +
> +#define SPECIAL_FILE(x) \
> +	   (S_ISCHR((x)) \
> +	|| S_ISBLK((x)) \
> +	|| S_ISFIFO((x)) \
> +	|| S_ISLNK((x)) \
> +	|| S_ISSOCK((x)))
> +
> +static struct option long_options[] = {
> +	{"set",			no_argument,	0,	's' },
> +	{"get",			no_argument,	0,	'g' },
> +	{"no-follow",		no_argument,	0,	'n' },
> +	{"at-cwd",		no_argument,	0,	'a' },
> +	{"set-nodump",		no_argument,	0,	'd' },
> +	{"invalid-at",		no_argument,	0,	'i' },
> +	{"too-big-arg",		no_argument,	0,	'b' },
> +	{"too-small-arg",	no_argument,	0,	'm' },
> +	{"new-fsx-flag",	no_argument,	0,	'x' },
> +	{0,			0,		0,	0 }
> +};
> +
> +static struct xflags {
> +	uint	flag;
> +	char	*shortname;
> +	char	*longname;
> +} xflags[] = {
> +	{ FS_XFLAG_REALTIME,		"r", "realtime"		},
> +	{ FS_XFLAG_PREALLOC,		"p", "prealloc"		},
> +	{ FS_XFLAG_IMMUTABLE,		"i", "immutable"	},
> +	{ FS_XFLAG_APPEND,		"a", "append-only"	},
> +	{ FS_XFLAG_SYNC,		"s", "sync"		},
> +	{ FS_XFLAG_NOATIME,		"A", "no-atime"		},
> +	{ FS_XFLAG_NODUMP,		"d", "no-dump"		},
> +	{ FS_XFLAG_RTINHERIT,		"t", "rt-inherit"	},
> +	{ FS_XFLAG_PROJINHERIT,		"P", "proj-inherit"	},
> +	{ FS_XFLAG_NOSYMLINKS,		"n", "nosymlinks"	},
> +	{ FS_XFLAG_EXTSIZE,		"e", "extsize"		},
> +	{ FS_XFLAG_EXTSZINHERIT,	"E", "extsz-inherit"	},
> +	{ FS_XFLAG_NODEFRAG,		"f", "no-defrag"	},
> +	{ FS_XFLAG_FILESTREAM,		"S", "filestream"	},
> +	{ FS_XFLAG_DAX,			"x", "dax"		},
> +	{ FS_XFLAG_COWEXTSIZE,		"C", "cowextsize"	},
> +	{ FS_XFLAG_HASATTR,		"X", "has-xattr"	},
> +	{ 0, NULL, NULL }
> +};
> +
> +static int
> +file_getattr(
> +		int			dfd,
> +		const char		*filename,
> +		struct file_attr	*fsx,
> +		size_t			usize,
> +		unsigned int		at_flags)
> +{
> +	return syscall(__NR_file_getattr, dfd, filename, fsx, usize, at_flags);
> +}
> +
> +static int
> +file_setattr(
> +		int			dfd,
> +		const char		*filename,
> +		struct file_attr	*fsx,
> +		size_t			usize,
> +		unsigned int		at_flags)
> +{
> +	return syscall(__NR_file_setattr, dfd, filename, fsx, usize, at_flags);
> +}
> +
> +void
> +printxattr(
> +	uint		flags,
> +	int		verbose,
> +	int		dofname,
> +	const char	*fname,
> +	int		dobraces,
> +	int		doeol)
> +{
> +	struct xflags	*p;
> +	int		first = 1;
> +
> +	if (dobraces)
> +		fputs("[", stdout);
> +	for (p = xflags; p->flag; p++) {
> +		if (flags & p->flag) {
> +			if (verbose) {
> +				if (first)
> +					first = 0;
> +				else
> +					fputs(", ", stdout);
> +				fputs(p->longname, stdout);
> +			} else {
> +				fputs(p->shortname, stdout);
> +			}
> +		} else if (!verbose) {
> +			fputs("-", stdout);
> +		}
> +	}
> +	if (dobraces)
> +		fputs("]", stdout);
> +	if (dofname)
> +		printf(" %s ", fname);
> +	if (doeol)
> +		fputs("\n", stdout);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int error;
> +	int c;
> +	const char *path = NULL;
> +	const char *path1 = NULL;
> +	const char *path2 = NULL;
> +	unsigned int at_flags = 0;
> +	unsigned int fa_xflags = 0;
> +	int action = 0; /* 0 get; 1 set */
> +	struct file_attr fsx = { };
> +	int fa_size = sizeof(struct file_attr);
> +	struct stat status;
> +	int fd;
> +	int at_fdcwd = 0;
> +	int unknwon_fa_flag = 0;
> +
> +        while (1) {
> +            int option_index = 0;
> +
> +            c = getopt_long_only(argc, argv, "", long_options, &option_index);
> +            if (c == -1)
> +                break;
> +
> +            switch (c) {
> +	    case 's':
> +		action = 1;
> +		break;
> +	    case 'g':
> +		action = 0;
> +		break;
> +	    case 'n':
> +		at_flags |= AT_SYMLINK_NOFOLLOW;
> +		break;
> +	    case 'a':
> +		at_fdcwd = 1;
> +		break;
> +	    case 'd':
> +		fa_xflags |= FS_XFLAG_NODUMP;
> +		break;
> +	    case 'i':
> +		at_flags |= (1 << 25);
> +		break;
> +	    case 'b':
> +		fa_size = getpagesize() + 1; /* max size if page size */
> +		break;
> +	    case 'm':
> +		fa_size = 19; /* VER0 size of fsxattr is 20 */
> +		break;
> +	    case 'x':
> +		unknwon_fa_flag = (1 << 27);
> +		break;
> +	    default:
> +		goto usage;
> +            }
> +        }
> +
> +	if (!path1 && optind < argc)
> +		path1 = argv[optind++];
> +	if (!path2 && optind < argc)
> +		path2 = argv[optind++];
> +
> +	if (at_fdcwd) {
> +		fd = AT_FDCWD;
> +		path = path1;
> +	} else if (!path2) {
> +		error = stat(path1, &status);
> +		if (error) {
> +			fprintf(stderr,
> +"Can not get file status of %s: %s\n", path1, strerror(errno));
> +			return error;
> +		}
> +
> +		if (SPECIAL_FILE(status.st_mode)) {
> +			fprintf(stderr,
> +"Can not open special file %s without parent dir: %s\n", path1, strerror(errno));
> +			return errno;
> +		}
> +
> +		fd = open(path1, O_RDONLY);
> +		if (fd == -1) {
> +			fprintf(stderr, "Can not open %s: %s\n", path1,
> +					strerror(errno));
> +			return errno;
> +		}
> +	} else {
> +		fd = open(path1, O_RDONLY);
> +		if (fd == -1) {
> +			fprintf(stderr, "Can not open %s: %s\n", path1,
> +					strerror(errno));
> +			return errno;
> +		}
> +		path = path2;
> +	}
> +
> +	if (!path)
> +		at_flags |= AT_EMPTY_PATH;
> +
> +	if (action) {
> +		error = file_getattr(fd, path, &fsx, fa_size,
> +				at_flags);
> +		if (error) {
> +			fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
> +					strerror(errno));
> +			return error;
> +		}
> +
> +		fsx.fa_xflags |= (fa_xflags | unknwon_fa_flag);
> +
> +		error = file_setattr(fd, path, &fsx, fa_size,
> +				at_flags);
> +		if (error) {
> +			fprintf(stderr, "Can not set fsxattr on %s: %s\n", path,
> +					strerror(errno));
> +			return error;
> +		}
> +	} else {
> +		error = file_getattr(fd, path, &fsx, fa_size,
> +				at_flags);
> +		if (error) {
> +			fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
> +					strerror(errno));
> +			return error;
> +		}
> +
> +		if (path2)
> +			printxattr(fsx.fa_xflags, 0, 1, path, 0, 1);
> +		else
> +			printxattr(fsx.fa_xflags, 0, 1, path1, 0, 1);
> +	}
> +
> +	return error;
> +
> +usage:
> +	printf("Usage: %s [options]\n", argv[0]);
> +	printf("Options:\n");
> +	printf("\t--get\t\tget filesystem inode attributes\n");
> +	printf("\t--set\t\tset filesystem inode attributes\n");
> +	printf("\t--at-cwd\t\topen file at current working directory\n");
> +	printf("\t--no-follow\t\tdon't follow symlinks\n");
> +	printf("\t--set-nodump\t\tset FS_XFLAG_NODUMP on an inode\n");
> +	printf("\t--invalid-at\t\tUse invalida AT_* flag\n");
> +	printf("\t--too-big-arg\t\tSet fsxattr size bigger than PAGE_SIZE\n");
> +	printf("\t--too-small-arg\t\tSet fsxattr size to 27 bytes\n");
> +	printf("\t--new-fsx-flag\t\tUse unknown fa_flags flag\n");
> +
> +	return 1;
> +}
> 
> -- 
> 2.49.0
> 


