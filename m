Return-Path: <linux-fsdevel+bounces-57376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D232FB20D1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AB3168D33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DC12DECBC;
	Mon, 11 Aug 2025 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw3d87zu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624B418EB0;
	Mon, 11 Aug 2025 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924868; cv=none; b=hXmsapH21v3cP7rFnPr8TVbNbc842Gm1jttvJnKN62/dP2/SqOBIymd3vc4Gf5HlvSEUSYo8kgrMyC1jSEOfSuXJighZkXRLLVwcWGk9fJ5Z6IphUrGZrURAApywApJWgq9RLB/7IrWUjJ3l0xmAp2uOHyXh6d/L66a1CoQqYdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924868; c=relaxed/simple;
	bh=DMZxfkZQ/KEYNXJ1rWpPkTdH+TcVBH0OC1iNUOxqhcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBEcHpDJNmWjHx+e9BSZtw419Vm4VIFeAha/gZsMR1InjuzURLjPxy22KKpFYjDU7gnpPZMCL+sQV8vTs1XRtoTPhW2BNeOyq7wHhgKvXQmZs5/oOacArAXU+UGV3j1+ffpS6pcZGDffyJvBg5D+S+t8iW2wF/MpDpshs+lm68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw3d87zu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37C1C4CEED;
	Mon, 11 Aug 2025 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754924867;
	bh=DMZxfkZQ/KEYNXJ1rWpPkTdH+TcVBH0OC1iNUOxqhcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iw3d87zuoq2QjgiqpL/lVO7XiZyyexveFajj9DVgtSezNG/fImiPC79vUppnbPoJ6
	 QbtrBIyLdeR4FY9gm7+39vls1EjpQu5wNQyNxNN7VbR87kILZWAQJGMFuuxsuN24OG
	 jT5Dq7eteUpwwYZVGRpm/k2quTWTK+jGw62A0HVXVArlKJ/ZMLJbiuAVDiaKbRQIZT
	 23WqfNJwAe0upBAh+dcxabV2lrBBqI+p4CvDVd5Vw4VwYcyQ7skVzlQcpX+k9aZqfE
	 My4qrdOIpr9UfxKWdxMz44zt+WjXj+2VI4W3YLI2x3RpY06mLsXP0SX89tTHW/2xBT
	 kloylr2j1UtQw==
Date: Mon, 11 Aug 2025 08:07:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/4] xfs_quota: utilize file_setattr to set prjid on
 special files
Message-ID: <20250811150747.GB7965@frogsfrogsfrogs>
References: <20250808-xattrat-syscall-v1-0-48567c29e45c@kernel.org>
 <20250808-xattrat-syscall-v1-2-48567c29e45c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-xattrat-syscall-v1-2-48567c29e45c@kernel.org>

On Fri, Aug 08, 2025 at 09:30:17PM +0200, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Utilize new file_getattr/file_setattr syscalls to set project ID on
> special files. Previously, special files were skipped due to lack of the
> way to call FS_IOC_SETFSXATTR ioctl on them. The quota accounting was
> therefore missing these inodes (special files created before project
> setup). The ones created after porject initialization did inherit the
> projid flag from the parent.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  quota/project.c | 144 +++++++++++++++++++++++++++++---------------------------
>  1 file changed, 74 insertions(+), 70 deletions(-)
> 
> diff --git a/quota/project.c b/quota/project.c
> index adb26945fa57..93d7ace0e11b 100644
> --- a/quota/project.c
> +++ b/quota/project.c
> @@ -4,14 +4,17 @@
>   * All Rights Reserved.
>   */
>  
> +#include <unistd.h>
>  #include "command.h"
>  #include "input.h"
>  #include "init.h"
> +#include "libfrog/file_attr.h"
>  #include "quota.h"
>  
>  static cmdinfo_t project_cmd;
>  static prid_t prid;
>  static int recurse_depth = -1;
> +static int dfd;

Ew, global scope variables, can we pass that through to check_project?

>  enum {
>  	CHECK_PROJECT	= 0x1,
> @@ -19,13 +22,6 @@ enum {
>  	CLEAR_PROJECT	= 0x4,
>  };
>  
> -#define EXCLUDED_FILE_TYPES(x) \
> -	   (S_ISCHR((x)) \
> -	|| S_ISBLK((x)) \
> -	|| S_ISFIFO((x)) \
> -	|| S_ISLNK((x)) \
> -	|| S_ISSOCK((x)))
> -
>  static void
>  project_help(void)
>  {
> @@ -85,8 +81,8 @@ check_project(
>  	int			flag,
>  	struct FTW		*data)
>  {
> -	struct fsxattr		fsx;
> -	int			fd;
> +	int			error;
> +	struct file_attr	fa = { 0 };
>  
>  	if (recurse_depth >= 0 && data->level > recurse_depth)
>  		return 0;
> @@ -96,30 +92,30 @@ check_project(
>  		fprintf(stderr, _("%s: cannot stat file %s\n"), progname, path);
>  		return 0;
>  	}
> -	if (EXCLUDED_FILE_TYPES(stat->st_mode)) {
> -		fprintf(stderr, _("%s: skipping special file %s\n"), progname, path);
> -		return 0;
> -	}
>  
> -	if ((fd = open(path, O_RDONLY|O_NOCTTY)) == -1) {
> -		exitcode = 1;
> -		fprintf(stderr, _("%s: cannot open %s: %s\n"),
> -			progname, path, strerror(errno));
> -	} else if ((xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> -		exitcode = 1;
> +	error = file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> +	if (error) {
> +#ifndef HAVE_FILE_ATTR
> +		if (SPECIAL_FILE(stat->st_mode)) {
> +			fprintf(stderr, _("%s: skipping special file %s\n"),
> +					progname, path);
> +			return 0;
> +		}
> +#endif

Yeah, file_getattr really ought to return some error code for "not
supported" and then this becomes:

	error = file_getattr(...);
	if (error && errno == EOPNOTSUPP) {
		fprintf(stderr, _("%s: skipping special file %s\n"),
					progname, path);
		return 0;
	}
	if (error) {
		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
			progname, path, strerror(errno));
		exitcode = 1;
		return 0;
	}

>  		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
> -			progname, path, strerror(errno));
> -	} else {
> -		if (fsx.fsx_projid != prid)
> -			printf(_("%s - project identifier is not set"
> -				 " (inode=%u, tree=%u)\n"),
> -				path, fsx.fsx_projid, (unsigned int)prid);
> -		if (!(fsx.fsx_xflags & FS_XFLAG_PROJINHERIT) && S_ISDIR(stat->st_mode))
> -			printf(_("%s - project inheritance flag is not set\n"),
> -				path);
> +				progname, path, strerror(errno));
> +		exitcode = 1;
> +		return 0;
>  	}
> -	if (fd != -1)
> -		close(fd);
> +
> +	if (fa.fa_projid != prid)
> +		printf(_("%s - project identifier is not set"
> +				" (inode=%u, tree=%u)\n"),
> +			path, fa.fa_projid, (unsigned int)prid);
> +	if (!(fa.fa_xflags & FS_XFLAG_PROJINHERIT) && S_ISDIR(stat->st_mode))
> +		printf(_("%s - project inheritance flag is not set\n"),
> +			path);
> +
>  	return 0;
>  }
>  
> @@ -130,8 +126,8 @@ clear_project(
>  	int			flag,
>  	struct FTW		*data)
>  {
> -	struct fsxattr		fsx;
> -	int			fd;
> +	int			error;
> +	struct file_attr	fa;
>  
>  	if (recurse_depth >= 0 && data->level > recurse_depth)
>  		return 0;
> @@ -141,32 +137,31 @@ clear_project(
>  		fprintf(stderr, _("%s: cannot stat file %s\n"), progname, path);
>  		return 0;
>  	}
> -	if (EXCLUDED_FILE_TYPES(stat->st_mode)) {
> -		fprintf(stderr, _("%s: skipping special file %s\n"), progname, path);
> -		return 0;
> -	}
>  
> -	if ((fd = open(path, O_RDONLY|O_NOCTTY)) == -1) {
> -		exitcode = 1;
> -		fprintf(stderr, _("%s: cannot open %s: %s\n"),
> -			progname, path, strerror(errno));
> -		return 0;
> -	} else if (xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx) < 0) {
> -		exitcode = 1;
> +	error = file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> +	if (error) {
> +#ifndef HAVE_FILE_ATTR
> +		if (SPECIAL_FILE(stat->st_mode)) {
> +			fprintf(stderr, _("%s: skipping special file %s\n"),
> +					progname, path);
> +			return 0;
> +		}
> +#endif
>  		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
> -			progname, path, strerror(errno));
> -		close(fd);
> +				progname, path, strerror(errno));
> +		exitcode = 1;
>  		return 0;
>  	}
>  
> -	fsx.fsx_projid = 0;
> -	fsx.fsx_xflags &= ~FS_XFLAG_PROJINHERIT;
> -	if (xfsctl(path, fd, FS_IOC_FSSETXATTR, &fsx) < 0) {
> -		exitcode = 1;
> +	fa.fa_projid = 0;
> +	fa.fa_xflags &= ~FS_XFLAG_PROJINHERIT;
> +
> +	error = file_setattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> +	if (error) {
>  		fprintf(stderr, _("%s: cannot clear project on %s: %s\n"),
>  			progname, path, strerror(errno));
> +		exitcode = 1;
>  	}
> -	close(fd);
>  	return 0;
>  }
>  
> @@ -177,8 +172,8 @@ setup_project(
>  	int			flag,
>  	struct FTW		*data)
>  {
> -	struct fsxattr		fsx;
> -	int			fd;
> +	struct file_attr	fa;
> +	int			error;
>  
>  	if (recurse_depth >= 0 && data->level > recurse_depth)
>  		return 0;
> @@ -188,32 +183,32 @@ setup_project(
>  		fprintf(stderr, _("%s: cannot stat file %s\n"), progname, path);
>  		return 0;
>  	}
> -	if (EXCLUDED_FILE_TYPES(stat->st_mode)) {
> -		fprintf(stderr, _("%s: skipping special file %s\n"), progname, path);
> -		return 0;
> -	}
>  
> -	if ((fd = open(path, O_RDONLY|O_NOCTTY)) == -1) {
> -		exitcode = 1;
> -		fprintf(stderr, _("%s: cannot open %s: %s\n"),
> -			progname, path, strerror(errno));
> -		return 0;
> -	} else if (xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx) < 0) {
> -		exitcode = 1;
> +	error = file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> +	if (error) {
> +#ifndef HAVE_FILE_ATTR
> +		if (SPECIAL_FILE(stat->st_mode)) {
> +			fprintf(stderr, _("%s: skipping special file %s\n"),
> +					progname, path);
> +			return 0;
> +		}
> +#endif
>  		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
> -			progname, path, strerror(errno));
> -		close(fd);
> +				progname, path, strerror(errno));
> +		exitcode = 1;
>  		return 0;
>  	}
>  
> -	fsx.fsx_projid = prid;
> -	fsx.fsx_xflags |= FS_XFLAG_PROJINHERIT;
> -	if (xfsctl(path, fd, FS_IOC_FSSETXATTR, &fsx) < 0) {
> -		exitcode = 1;
> +	fa.fa_projid = prid;
> +	if (S_ISDIR(stat->st_mode))
> +		fa.fa_xflags |= FS_XFLAG_PROJINHERIT;
> +
> +	error = file_setattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> +	if (error) {
>  		fprintf(stderr, _("%s: cannot set project on %s: %s\n"),
>  			progname, path, strerror(errno));
> +		exitcode = 1;
>  	}
> -	close(fd);
>  	return 0;
>  }
>  
> @@ -223,6 +218,13 @@ project_operations(
>  	char		*dir,
>  	int		type)
>  {
> +	dfd = open(dir, O_RDONLY|O_NOCTTY);
> +	if (dfd < -1) {
> +		printf(_("Error opening dir %s for project %s...\n"), dir,
> +				project);
> +		return;
> +	}
> +
>  	switch (type) {
>  	case CHECK_PROJECT:
>  		printf(_("Checking project %s (path %s)...\n"), project, dir);
> @@ -237,6 +239,8 @@ project_operations(
>  		nftw(dir, clear_project, 100, FTW_PHYS|FTW_MOUNT);
>  		break;
>  	}
> +
> +	close(dfd);
>  }
>  
>  static void
> 
> -- 
> 2.49.0
> 
> 

