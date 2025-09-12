Return-Path: <linux-fsdevel+bounces-61152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ED6B55A6C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 01:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FC0176009
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 23:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4277A284663;
	Fri, 12 Sep 2025 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhP45T8z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8F6220F24;
	Fri, 12 Sep 2025 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720333; cv=none; b=bZ8MHghO5zyJ93PI2L3Ee9WGmguBDkWH5mTVJj7Y2Xio0cQP2nIW6M8vJeKkIoRgsQd0j1m+Dw25ChP8AUaObf4Ovan1qvIIHQ6oPqujlV68xjD2n2X0pOA1BF/ST5pGNtmRhissCOTMIB4KoSmHBXTY/8fUITS6qaMDJCT4oCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720333; c=relaxed/simple;
	bh=BnxFWUf62tGeu0b7meFoDaFPBozR09hC06Xrwsp2ew8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj3P4R1AVZ5huEiynrl1uyHIH0QdpbzkXDixtkbqdE8ySOzPrOVC8lehqRxqlXTxjrXfZZUJkWtyxuDpVcLZFN3wn6slYAJMka115IQe6DLPgWnyZ3t5FFOUWkzAtAYUgbkbZKarnyB7V0sSfKAt8X9Ng86YdsG+Wdlfkf1umTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhP45T8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3B9C4CEF1;
	Fri, 12 Sep 2025 23:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757720333;
	bh=BnxFWUf62tGeu0b7meFoDaFPBozR09hC06Xrwsp2ew8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhP45T8zv4+TZv5dLYzSxwjbiCSTLZChCzhuK6+Jxo0QjDnzLboxFcQe5NVXW0pyD
	 a9xX3Q7mhKVkSCQ08si4jd5m8eGC9f4Xhj6gfRRNANb6YE9+4jFEfE4qBvLv7VuXI2
	 0lKcAGJ9/qgdrPuh6M9whEn1wLjBwWxsJ7qXRRN3DoyutuxHWm9V0BgtBi1cKDyh0o
	 I7erd9rVfoKXt6C5BcC7/VqptCCcTGwAIVEjcrcp47eVrwYSYsECuXO9EsdCtk+RHZ
	 fT65VgrLTkZU6Ug94wwC58PR1RG17DmM0eTHIgPXId+8E0ZbgEOzdBwjeE8mSN2KMt
	 Of3VcK6BGRh4A==
Date: Fri, 12 Sep 2025 16:38:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 v3 2/4] xfs_quota: utilize file_setattr to set prjid
 on special files
Message-ID: <20250912233852.GK1587915@frogsfrogsfrogs>
References: <20250909-xattrat-syscall-v3-0-4407a714817e@kernel.org>
 <20250909-xattrat-syscall-v3-2-4407a714817e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-xattrat-syscall-v3-2-4407a714817e@kernel.org>

On Tue, Sep 09, 2025 at 05:24:37PM +0200, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Utilize new file_getattr/file_setattr syscalls to set project ID on
> special files. Previously, special files were skipped due to lack of the
> way to call FS_IOC_SETFSXATTR ioctl on them. The quota accounting was
> therefore missing these inodes (special files created before project
> setup). The ones created after project initialization did inherit the
> projid flag from the parent.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>

Looks good now, thanks for the nitpick cleanups!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  quota/project.c | 142 +++++++++++++++++++++++++++++---------------------------
>  1 file changed, 74 insertions(+), 68 deletions(-)
> 
> diff --git a/quota/project.c b/quota/project.c
> index adb26945fa57..5832e1474e25 100644
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
>  
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
> +	struct file_attr	fa;
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
> +	error = xfrog_file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> +	if (error && errno == EOPNOTSUPP) {
> +		if (SPECIAL_FILE(stat->st_mode)) {
> +			fprintf(stderr, _("%s: skipping special file %s: %s\n"),
> +					progname, path, strerror(errno));
> +			return 0;
> +		}
> +	}
> +	if (error) {
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
> @@ -141,32 +137,32 @@ clear_project(
>  		fprintf(stderr, _("%s: cannot stat file %s\n"), progname, path);
>  		return 0;
>  	}
> -	if (EXCLUDED_FILE_TYPES(stat->st_mode)) {
> -		fprintf(stderr, _("%s: skipping special file %s\n"), progname, path);
> -		return 0;
> +
> +	error = xfrog_file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> +	if (error && errno == EOPNOTSUPP) {
> +		if (SPECIAL_FILE(stat->st_mode)) {
> +			fprintf(stderr, _("%s: skipping special file %s: %s\n"),
> +					progname, path, strerror(errno));
> +			return 0;
> +		}
>  	}
>  
> -	if ((fd = open(path, O_RDONLY|O_NOCTTY)) == -1) {
> -		exitcode = 1;
> -		fprintf(stderr, _("%s: cannot open %s: %s\n"),
> -			progname, path, strerror(errno));
> -		return 0;
> -	} else if (xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx) < 0) {
> -		exitcode = 1;
> +	if (error) {
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
> +	error = xfrog_file_setattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> +	if (error) {
>  		fprintf(stderr, _("%s: cannot clear project on %s: %s\n"),
>  			progname, path, strerror(errno));
> +		exitcode = 1;
>  	}
> -	close(fd);
>  	return 0;
>  }
>  
> @@ -177,8 +173,8 @@ setup_project(
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
> @@ -188,32 +184,33 @@ setup_project(
>  		fprintf(stderr, _("%s: cannot stat file %s\n"), progname, path);
>  		return 0;
>  	}
> -	if (EXCLUDED_FILE_TYPES(stat->st_mode)) {
> -		fprintf(stderr, _("%s: skipping special file %s\n"), progname, path);
> -		return 0;
> +
> +	error = xfrog_file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> +	if (error && errno == EOPNOTSUPP) {
> +		if (SPECIAL_FILE(stat->st_mode)) {
> +			fprintf(stderr, _("%s: skipping special file %s\n"),
> +					progname, path);
> +			return 0;
> +		}
>  	}
>  
> -	if ((fd = open(path, O_RDONLY|O_NOCTTY)) == -1) {
> -		exitcode = 1;
> -		fprintf(stderr, _("%s: cannot open %s: %s\n"),
> -			progname, path, strerror(errno));
> -		return 0;
> -	} else if (xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx) < 0) {
> -		exitcode = 1;
> +	if (error) {
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
> +	error = xfrog_file_setattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
> +	if (error) {
>  		fprintf(stderr, _("%s: cannot set project on %s: %s\n"),
>  			progname, path, strerror(errno));
> +		exitcode = 1;
>  	}
> -	close(fd);
>  	return 0;
>  }
>  
> @@ -223,6 +220,13 @@ project_operations(
>  	char		*dir,
>  	int		type)
>  {
> +	dfd = open(dir, O_RDONLY | O_NOCTTY);
> +	if (dfd < -1) {
> +		printf(_("Error opening dir %s for project %s...\n"), dir,
> +				project);
> +		return;
> +	}
> +
>  	switch (type) {
>  	case CHECK_PROJECT:
>  		printf(_("Checking project %s (path %s)...\n"), project, dir);
> @@ -237,6 +241,8 @@ project_operations(
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
> 2.50.1
> 
> 

