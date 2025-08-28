Return-Path: <linux-fsdevel+bounces-59503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DDFB3A28E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 16:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA23986509
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E7B32039F;
	Thu, 28 Aug 2025 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNGiXlfF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56686313E25;
	Thu, 28 Aug 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392096; cv=none; b=SvKHcahzj8Mo3FSRTUfw4nhCZHeCAyH0uRjLK0w/ksSjtn/IoqJJZUY9xeNr7fXRZXzSq24d4B4lUVQm1cIUfnfhot2xReRnWx3mGLvks6XdCcs2jhs1XNGyVcxlIye2ABjCAOulUlGEVpsdMRMFDCFswyKTrgg86pCMwuFwFHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392096; c=relaxed/simple;
	bh=tQg7xfyAxcrmyjhSs4+FueA6nMvrdiK3yJQHbHBNTgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNMz+mNKSPOsU3Q5+Bm2w5a7bNQMUA+pY0lX6QIdwQDcup1EffqyZTsQKsHztOe++GaDhKs/A4ynd2U04GeQc9dIOR3HKTmuVAVdD05LWlO1E713mE+ooNQCmGebklO0zVTcah5ajT7C7hM/6Gn7QWA7BJQseXPkIWzzkYw4TkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNGiXlfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23C1C4CEEB;
	Thu, 28 Aug 2025 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756392095;
	bh=tQg7xfyAxcrmyjhSs4+FueA6nMvrdiK3yJQHbHBNTgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNGiXlfF2YTkufpmYwA2+JTKkCx9P1swGXqD3ZAY4QG6rJ2A6RivXXvyZeIA/jWZk
	 ngvDjvyHz+6OifbPGZwh8trlnKbF4c2/+Owiql6JW42V2BWEljKa9lSv4nQKJkXaV2
	 lPu+VOULhg7c3VOkpVbRMRzut+QyCflSXeiBw9Kt/nU+gbqgwY6k5r8cHugx2nZP9T
	 EFfa17VwUXSCIROHiHdJ+5re4wCC2R4mqOEsRKRSA45SnE/AvpoVgrOaUALSOQtMHr
	 6JYOHeL+2ORn55bRhvpvRls2+IhICVgKeZZgS+OWvKwWPGEPjBMr8NTApjqtZd+kjd
	 HCx9iVZewUyEQ==
Date: Thu, 28 Aug 2025 07:41:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] xfs_db: use file_setattr to copy attributes on
 special files with rdump
Message-ID: <20250828144135.GD8096@frogsfrogsfrogs>
References: <20250827-xattrat-syscall-v2-0-82a2d2d5865b@kernel.org>
 <20250827-xattrat-syscall-v2-4-82a2d2d5865b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-xattrat-syscall-v2-4-82a2d2d5865b@kernel.org>

On Wed, Aug 27, 2025 at 05:15:56PM +0200, Andrey Albershteyn wrote:
> rdump just skipped file attributes on special files as copying wasn't
> possible. Let's use new file_getattr/file_setattr syscalls to copy
> attributes even for special files.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks good!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  db/rdump.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/db/rdump.c b/db/rdump.c
> index 9ff833553ccb..82520e37d713 100644
> --- a/db/rdump.c
> +++ b/db/rdump.c
> @@ -17,6 +17,7 @@
>  #include "field.h"
>  #include "inode.h"
>  #include "listxattr.h"
> +#include "libfrog/file_attr.h"
>  #include <sys/xattr.h>
>  #include <linux/xattr.h>
>  
> @@ -152,6 +153,12 @@ rdump_fileattrs_path(
>  	const struct destdir	*destdir,
>  	const struct pathbuf	*pbuf)
>  {
> +	struct file_attr	fa = {
> +		.fa_extsize	= ip->i_extsize,
> +		.fa_projid	= ip->i_projid,
> +		.fa_cowextsize	= ip->i_cowextsize,
> +		.fa_xflags	= xfs_ip2xflags(ip),
> +	};
>  	int			ret;
>  
>  	ret = fchmodat(destdir->fd, pbuf->path, VFS_I(ip)->i_mode & ~S_IFMT,
> @@ -181,7 +188,18 @@ rdump_fileattrs_path(
>  			return 1;
>  	}
>  
> -	/* Cannot copy fsxattrs until setfsxattrat gets merged */
> +	ret = xfrog_file_setattr(destdir->fd, pbuf->path, NULL, &fa,
> +			AT_SYMLINK_NOFOLLOW);
> +	if (ret) {
> +		if (errno == EOPNOTSUPP || errno == EPERM || errno == ENOTTY)
> +			lost_mask |= LOST_FSXATTR;
> +		else
> +			dbprintf(_("%s%s%s: xfrog_file_setattr %s\n"),
> +					destdir->path, destdir->sep, pbuf->path,
> +					strerror(errno));
> +		if (strict_errors)
> +			return 1;
> +	}
>  
>  	return 0;
>  }
> 
> -- 
> 2.49.0
> 
> 

