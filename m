Return-Path: <linux-fsdevel+bounces-59502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6B2B3A26B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 16:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4CE1C820FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE2531577E;
	Thu, 28 Aug 2025 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7CEVw0/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE12315793;
	Thu, 28 Aug 2025 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392053; cv=none; b=YgcRUJAULCzppxj0iT1LJS/WFp2PXGjE/aW4fJP1yzAxh8FJ7c7Z70NijWUK5IE+xhzB+4L/6FwpqEG1QvOSKEKa6Nfs6OL0d/AqmrgiNKUXot0LgDUO1bLsqDd12uaWh0fyBw+T55nSkqgO2P3XyKr237R7F5+uGWZvbvuN/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392053; c=relaxed/simple;
	bh=8K0QTh5go645RISA51CU8owAmDucI/lI6BL3OKHf5I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYRRTKHtDhJgjOuMfDrIntmFpesZfXISD8r3+Sp5k7X0bSqCIs8PQKuqJXVr3MugwRhLDC3JFqK3cMn61JlO2XhMKRJZ5FUsnYozPXvmxX95p8Z/sJlenjIounox3HOwGTZv/ITkO9+Q2YMPaJiyJcjRWOjyuxeTDTHkLbObRjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7CEVw0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A523C4CEEB;
	Thu, 28 Aug 2025 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756392053;
	bh=8K0QTh5go645RISA51CU8owAmDucI/lI6BL3OKHf5I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7CEVw0/GM+TaXy4oYeEGwXUyXMdbasd3z/blEmotB+EN2o3XaVkze9AJmesZ2iPQ
	 9+y58VqRAVPrRlCFGOLEal996MqJhqztbz+nRRqxYxq99Gf3+jmL7NNQZEVF3C/Zm3
	 7/0EMKjX6tEJCLUjlO9UTnTUVTuW0ufpgJJxUPbePxWXdUCR48nlSFbkxQe2u62PAa
	 MLoJ7VeCz4vxpYrjAnIWN8orJ7mpbE+DCAygY4PA98LO/DjhsdDqqEE+mwUSfmgCl7
	 FuvQ3pGo/uuc5ptIKEQUiWHZGJnzYngP6irImema3ay6OlewCcsZ6p2/OglV+SlpTN
	 Pm5eovlVjSm0g==
Date: Thu, 28 Aug 2025 07:40:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] xfs_io: make ls/chattr work with special files
Message-ID: <20250828144052.GC8096@frogsfrogsfrogs>
References: <20250827-xattrat-syscall-v2-0-82a2d2d5865b@kernel.org>
 <20250827-xattrat-syscall-v2-3-82a2d2d5865b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-xattrat-syscall-v2-3-82a2d2d5865b@kernel.org>

On Wed, Aug 27, 2025 at 05:15:55PM +0200, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> With new file_getattr/file_setattr syscalls we can now list/change file
> attributes on special files instead for ignoring them.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  io/attr.c | 138 +++++++++++++++++++++++++++++++++++++-------------------------
>  io/io.h   |   2 +-
>  io/stat.c |   2 +-
>  3 files changed, 84 insertions(+), 58 deletions(-)
> 
> diff --git a/io/attr.c b/io/attr.c
> index fd82a2e73801..1005450ac9f9 100644
> --- a/io/attr.c
> +++ b/io/attr.c
> @@ -8,6 +8,7 @@
>  #include "input.h"
>  #include "init.h"
>  #include "io.h"
> +#include "libfrog/file_attr.h"
>  
>  static cmdinfo_t chattr_cmd;
>  static cmdinfo_t lsattr_cmd;
> @@ -113,7 +114,7 @@ chattr_help(void)
>  }
>  
>  void
> -printxattr(
> +print_xflags(
>  	uint		flags,
>  	int		verbose,
>  	int		dofname,
> @@ -156,36 +157,36 @@ lsattr_callback(
>  	int			status,
>  	struct FTW		*data)
>  {
> -	struct fsxattr		fsx;
> -	int			fd;
> +	struct file_attr	fa;
> +	int			error;
>  
>  	if (recurse_dir && !S_ISDIR(stat->st_mode))
>  		return 0;
>  
> -	if ((fd = open(path, O_RDONLY)) == -1) {
> -		fprintf(stderr, _("%s: cannot open %s: %s\n"),
> -			progname, path, strerror(errno));
> -		exitcode = 1;
> -	} else if ((xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> +        error = xfrog_file_getattr(AT_FDCWD, path, stat, &fa,
> +				   AT_SYMLINK_NOFOLLOW);
> +        if (error) {


   ^^^^^^ spaces not tabs for indentation

With the indentation problems all fixed (there are a few more here),
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
>  			progname, path, strerror(errno));
>  		exitcode = 1;
> -	} else
> -		printxattr(fsx.fsx_xflags, 0, 1, path, 0, 1);
> +		return 0;
> +	}
> +
> +	print_xflags(fa.fa_xflags, 0, 1, path, 0, 1);
>  
> -	if (fd != -1)
> -		close(fd);
>  	return 0;
>  }
>  
>  static int
>  lsattr_f(
> -	int		argc,
> -	char		**argv)
> +	int			argc,
> +	char			**argv)
>  {
> -	struct fsxattr	fsx;
> -	char		*name = file->name;
> -	int		c, aflag = 0, vflag = 0;
> +	struct file_attr	fa;
> +	char			*name = file->name;
> +	int			c, aflag = 0, vflag = 0;
> +	struct stat		st;
> +	int			error;
>  
>  	recurse_all = recurse_dir = 0;
>  	while ((c = getopt(argc, argv, "DRav")) != EOF) {
> @@ -211,17 +212,28 @@ lsattr_f(
>  	if (recurse_all || recurse_dir) {
>  		nftw(name, lsattr_callback,
>  			100, FTW_PHYS | FTW_MOUNT | FTW_DEPTH);
> -	} else if ((xfsctl(name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> +		return 0;
> +	}
> +
> +	error = stat(name, &st);
> +	if (error)
> +		return error;
> +
> +	error = xfrog_file_getattr(AT_FDCWD, name, &st, &fa,
> +				   AT_SYMLINK_NOFOLLOW);
> +	if (error) {
>  		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
>  			progname, name, strerror(errno));
>  		exitcode = 1;
> -	} else {
> -		printxattr(fsx.fsx_xflags, vflag, !aflag, name, vflag, !aflag);
> -		if (aflag) {
> -			fputs("/", stdout);
> -			printxattr(-1, 0, 1, name, 0, 1);
> -		}
> +		return 0;
>  	}
> +
> +	print_xflags(fa.fa_xflags, vflag, !aflag, name, vflag, !aflag);
> +	if (aflag) {
> +		fputs("/", stdout);
> +		print_xflags(-1, 0, 1, name, 0, 1);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -232,44 +244,45 @@ chattr_callback(
>  	int			status,
>  	struct FTW		*data)
>  {
> -	struct fsxattr		attr;
> -	int			fd;
> +	struct file_attr	attr;
> +	int			error;
>  
>  	if (recurse_dir && !S_ISDIR(stat->st_mode))
>  		return 0;
>  
> -	if ((fd = open(path, O_RDONLY)) == -1) {
> -		fprintf(stderr, _("%s: cannot open %s: %s\n"),
> -			progname, path, strerror(errno));
> -		exitcode = 1;
> -	} else if (xfsctl(path, fd, FS_IOC_FSGETXATTR, &attr) < 0) {
> +        error = xfrog_file_getattr(AT_FDCWD, path, stat, &attr,
> +                                   AT_SYMLINK_NOFOLLOW);
> +        if (error) {
>  		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
>  			progname, path, strerror(errno));
>  		exitcode = 1;
> -	} else {
> -		attr.fsx_xflags |= orflags;
> -		attr.fsx_xflags &= ~andflags;
> -		if (xfsctl(path, fd, FS_IOC_FSSETXATTR, &attr) < 0) {
> -			fprintf(stderr, _("%s: cannot set flags on %s: %s\n"),
> -				progname, path, strerror(errno));
> -			exitcode = 1;
> -		}
> +		return 0;
> +	}
> +
> +	attr.fa_xflags |= orflags;
> +	attr.fa_xflags &= ~andflags;
> +	error = xfrog_file_setattr(AT_FDCWD, path, stat, &attr,
> +				   AT_SYMLINK_NOFOLLOW);
> +	if (error) {
> +		fprintf(stderr, _("%s: cannot set flags on %s: %s\n"),
> +			progname, path, strerror(errno));
> +		exitcode = 1;
>  	}
>  
> -	if (fd != -1)
> -		close(fd);
>  	return 0;
>  }
>  
>  static int
>  chattr_f(
> -	int		argc,
> -	char		**argv)
> +	int			argc,
> +	char			**argv)
>  {
> -	struct fsxattr	attr;
> -	struct xflags	*p;
> -	unsigned int	i = 0;
> -	char		*c, *name = file->name;
> +	struct file_attr	attr;
> +	struct xflags		*p;
> +	unsigned int		i = 0;
> +	char			*c, *name = file->name;
> +	struct stat		st;
> +	int			error;
>  
>  	orflags = andflags = 0;
>  	recurse_all = recurse_dir = 0;
> @@ -326,19 +339,32 @@ chattr_f(
>  	if (recurse_all || recurse_dir) {
>  		nftw(name, chattr_callback,
>  			100, FTW_PHYS | FTW_MOUNT | FTW_DEPTH);
> -	} else if (xfsctl(name, file->fd, FS_IOC_FSGETXATTR, &attr) < 0) {
> +		return 0;
> +	}
> +
> +	error = stat(name, &st);
> +	if (error)
> +		return error;
> +
> +	error = xfrog_file_getattr(AT_FDCWD, name, &st, &attr,
> +				   AT_SYMLINK_NOFOLLOW);
> +	if (error) {
>  		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
>  			progname, name, strerror(errno));
>  		exitcode = 1;
> -	} else {
> -		attr.fsx_xflags |= orflags;
> -		attr.fsx_xflags &= ~andflags;
> -		if (xfsctl(name, file->fd, FS_IOC_FSSETXATTR, &attr) < 0) {
> -			fprintf(stderr, _("%s: cannot set flags on %s: %s\n"),
> -				progname, name, strerror(errno));
> -			exitcode = 1;
> -		}
> +		return 0;
>  	}
> +
> +	attr.fa_xflags |= orflags;
> +	attr.fa_xflags &= ~andflags;
> +	error = xfrog_file_setattr(AT_FDCWD, name, &st, &attr,
> +				   AT_SYMLINK_NOFOLLOW);
> +	if (error) {
> +		fprintf(stderr, _("%s: cannot set flags on %s: %s\n"),
> +			progname, name, strerror(errno));
> +		exitcode = 1;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/io/io.h b/io/io.h
> index 259c034931b8..35fb8339eeb5 100644
> --- a/io/io.h
> +++ b/io/io.h
> @@ -78,7 +78,7 @@ extern int		openfile(char *, struct xfs_fsop_geom *, int, mode_t,
>  extern int		addfile(char *, int , struct xfs_fsop_geom *, int,
>  				struct fs_path *);
>  extern int		closefile(void);
> -extern void		printxattr(uint, int, int, const char *, int, int);
> +extern void		print_xflags(uint, int, int, const char *, int, int);
>  
>  extern unsigned int	recurse_all;
>  extern unsigned int	recurse_dir;
> diff --git a/io/stat.c b/io/stat.c
> index c257037aa8ee..c1085f14eade 100644
> --- a/io/stat.c
> +++ b/io/stat.c
> @@ -112,7 +112,7 @@ print_extended_info(int verbose)
>  	}
>  
>  	printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
> -	printxattr(fsx.fsx_xflags, verbose, 0, file->name, 1, 1);
> +	print_xflags(fsx.fsx_xflags, verbose, 0, file->name, 1, 1);
>  	printf(_("fsxattr.projid = %u\n"), fsx.fsx_projid);
>  	printf(_("fsxattr.extsize = %u\n"), fsx.fsx_extsize);
>  	printf(_("fsxattr.cowextsize = %u\n"), fsx.fsx_cowextsize);
> 
> -- 
> 2.49.0
> 
> 

