Return-Path: <linux-fsdevel+bounces-59501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C28B3A23F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 16:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588D57AC2CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069813148C9;
	Thu, 28 Aug 2025 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHBgVMk5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4293148B7;
	Thu, 28 Aug 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391957; cv=none; b=e2xMI16N1Up8sxGRWArJPMm827+xVlkfGPc0E5lyDwu9AE/b3lcfaCSeoDywFmF7zk0FCTtk+LCi2vcCW60nj8XFQQTpqjcndOUmRqP7ZpluoUnU73zWrZBBks+rT2Dkwbaq9qQaPs2PTcu252vWcT8qtuJN6kXSlSsQ9aVm2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391957; c=relaxed/simple;
	bh=JSOAVVfSEizIEKjgb4EaQanM5xdSUrRhedbTGCvoamc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taMdLiNa2p47vNofmNh0Gl7userFmFmwEMRaIu51fZ5Hozg+PyDpvi92q5g2KosBN/TDJ7USwAKxpcABwd0SafqekltTgfv+10KmR18GljFMqnomWLmqLi9nIW8rxTugBfVHrJZb4SmZzR7HbUVAPZX1WWh2i7SdqWAwinAQhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHBgVMk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FA8C4CEEB;
	Thu, 28 Aug 2025 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756391957;
	bh=JSOAVVfSEizIEKjgb4EaQanM5xdSUrRhedbTGCvoamc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHBgVMk5AVsfCtCNkqtqaOYki+hWPePciKZb1AqSdsBMmlBsWJL7GYCCrBVd6b4RD
	 xgQbsDa6aKILBDfZMyAbruE4LI8Sig3JaHiRIzJJECKESCEywdz0f206fB3b09mzuY
	 GExbinmU5K0cOsDOYMzeni8XVHLzJQZkcfXpArCVcTziSPIc10fXIhfGIDoPd61pbJ
	 4Q5IQE5CUyNpY6FZu3F4NWqWmsYmNX+tl9wDDdhZXZ+R5uLNP+jelS0Afm2K4BtbyT
	 THzI/70GYOuVmIl4Vl4UxgOcifmpj1ikudfQfeXDJ9zRk6BuB56yOBT1A86GogAzyv
	 aayrCp8IbZ1zg==
Date: Thu, 28 Aug 2025 07:39:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/4] xfs_quota: utilize file_setattr to set prjid on
 special files
Message-ID: <20250828143916.GB8096@frogsfrogsfrogs>
References: <20250827-xattrat-syscall-v2-0-82a2d2d5865b@kernel.org>
 <20250827-xattrat-syscall-v2-2-82a2d2d5865b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-xattrat-syscall-v2-2-82a2d2d5865b@kernel.org>

On Wed, Aug 27, 2025 at 05:15:54PM +0200, Andrey Albershteyn wrote:
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
> ---
>  quota/project.c | 142 +++++++++++++++++++++++++++++---------------------------
>  1 file changed, 74 insertions(+), 68 deletions(-)
> 
> diff --git a/quota/project.c b/quota/project.c
> index adb26945fa57..857b1abe71c7 100644
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

Hrm, interesting change in projinherit logic -- is this because the new
setattr code rejects projinherit on non-directories?

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
> +	dfd = open(dir, O_RDONLY|O_NOCTTY);

Nit: spaces around the pipe char^acter, please.

--D

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
> 2.49.0
> 
> 

