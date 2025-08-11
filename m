Return-Path: <linux-fsdevel+bounces-57380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 413E4B20D45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DCA1882384
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75602DFA2F;
	Mon, 11 Aug 2025 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jspNcJ1N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BB54EB38;
	Mon, 11 Aug 2025 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925269; cv=none; b=a4CtGZ9r0X/5gmc7aytnZ/ST6SbIyoqCViStsl4NDMudcqtMuVFE31kHjPR5hgAM0pqmhT0Ddiwu81/baAEEp/lJYW95uRutAMEa4o4+tH/ThxD7Uczxeu83LfZh6tb7mTsF+gCcqMHdRppTGiPcTjdlblkQxGgTIqPO/q2+uX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925269; c=relaxed/simple;
	bh=/mbXIpabho31eUfIim0DE7D3c8tlMfBRMicVypve6Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBsFOGrvU86mInyAhxOYEVR7OyX5Goo8fxaZ/5qZ+qIbNE4OYWEZgn1014JAYsMh8YigXamc9xq2IVyeRhfxEFLZ0D42F2itLRs/c/ktwM4z1kyN0Xy0VKcg2UeqWvEyllfNfxdcGkf9h0fmkJEh0VZ0TNQ9CKz+i3kWfZwwEcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jspNcJ1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AE9C4CEED;
	Mon, 11 Aug 2025 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754925268;
	bh=/mbXIpabho31eUfIim0DE7D3c8tlMfBRMicVypve6Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jspNcJ1NFXl2diJz3m98rIx4+L0EisejPc9UQN6hEE9p9kNQmtcO3uI2Xe5e79aVs
	 52ihPNCi+jUzaehTJAp2kn/xXgG/T+3qf8QgTDOm1wtYLmNZzLDQ7diN0KS1j9TTHw
	 n31VJisd5eMrrCWo13w+hurRnPpscOsCMxiAshi5HcYHR9IwKIKLri2ltcmfABw8yz
	 csPRFx7WNQLCL3v5qD04O14jPKGvVb10a0AQWM/lfm6oOtQVyXlbFPWW2X6S+iMkfM
	 W2fmCrsfGU3b7yosrl4KTik4c/H1MSRVOrNCZkzZ5atWtGif3v25kxPliwpizf22Um
	 mb4OIUOiGHl8g==
Date: Mon, 11 Aug 2025 08:14:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs_db: use file_setattr to copy attributes on
 special files with rdump
Message-ID: <20250811151427.GD7965@frogsfrogsfrogs>
References: <20250808-xattrat-syscall-v1-0-48567c29e45c@kernel.org>
 <20250808-xattrat-syscall-v1-4-48567c29e45c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-xattrat-syscall-v1-4-48567c29e45c@kernel.org>

On Fri, Aug 08, 2025 at 09:30:19PM +0200, Andrey Albershteyn wrote:
> rdump just skipped file attributes on special files as copying wasn't
> possible. Let's use new file_getattr/file_setattr syscalls to copy
> attributes even for special files.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  db/rdump.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/db/rdump.c b/db/rdump.c
> index 9ff833553ccb..5b9458e6bc94 100644
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
> @@ -152,10 +153,17 @@ rdump_fileattrs_path(
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
> +	int			at_flags = AT_SYMLINK_NOFOLLOW;

Why does this become a mutable variable?  AFAICT it doesn't change?

Otherwise things look good here.

--D

>  
>  	ret = fchmodat(destdir->fd, pbuf->path, VFS_I(ip)->i_mode & ~S_IFMT,
> -			AT_SYMLINK_NOFOLLOW);
> +			at_flags);
>  	if (ret) {
>  		/* fchmodat on a symlink is not supported */
>  		if (errno == EPERM || errno == EOPNOTSUPP)
> @@ -169,7 +177,7 @@ rdump_fileattrs_path(
>  	}
>  
>  	ret = fchownat(destdir->fd, pbuf->path, i_uid_read(VFS_I(ip)),
> -			i_gid_read(VFS_I(ip)), AT_SYMLINK_NOFOLLOW);
> +			i_gid_read(VFS_I(ip)), at_flags);
>  	if (ret) {
>  		if (errno == EPERM)
>  			lost_mask |= LOST_OWNER;
> @@ -181,7 +189,17 @@ rdump_fileattrs_path(
>  			return 1;
>  	}
>  
> -	/* Cannot copy fsxattrs until setfsxattrat gets merged */
> +	ret = file_setattr(destdir->fd, pbuf->path, NULL, &fa, at_flags);
> +	if (ret) {
> +		if (errno == EOPNOTSUPP || errno == EPERM || errno == ENOTTY)
> +			lost_mask |= LOST_FSXATTR;
> +		else
> +			dbprintf(_("%s%s%s: file_setattr %s\n"), destdir->path,
> +					destdir->sep, pbuf->path,
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

