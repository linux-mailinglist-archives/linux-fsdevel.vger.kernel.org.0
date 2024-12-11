Return-Path: <linux-fsdevel+bounces-37082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26CE9ED492
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 19:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44762188B2B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855CC204088;
	Wed, 11 Dec 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjArjt8j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4770201002;
	Wed, 11 Dec 2024 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941028; cv=none; b=QwUMTvIX9zrXUOghK8SKRtrUNt6BdtJqmwrPV9Bj0/f9g2243h6sqDCc3Mex6wTBQgngQqACp4m44ZbPVa2k89PDk1309s3cIbRGCLy0Ce4weHYmxBvY/WHDiHh5fD5FUe2KiZZVKB7JveJ1thsOblM0Iv1aIpHtxW48mL7v9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941028; c=relaxed/simple;
	bh=7MLzO1E7Zd3RDrU3Vs1tmk8Jw0vd7w/FoS3e93gR2Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNAMRjvHqFbKU0t0wF1HPq1pi4wOV4efOonPtiWdbK2Gz6rpczIitO5rb0BAycHxjpXYVYXHL3QJXkFFlG4HT9gBQ44EF7ZTrHZqIwfVoZw4kCib2A9vNMlHjWcFTPzjRbvw5lnheO5O1eg8y6/7WPgawGe6UEgxGjxcGrABf6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjArjt8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D6CC4CED2;
	Wed, 11 Dec 2024 18:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733941027;
	bh=7MLzO1E7Zd3RDrU3Vs1tmk8Jw0vd7w/FoS3e93gR2Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjArjt8j5uqDhJSBOz/WfyTRdHlkPPV2tOJfHj+tzfZ3922dxxb7KLuS6FlKB3RM0
	 1nYWpfocvbOND+lqKek+q1kwuVb3NaUviklkeJai0AN4RquyLPADGQ46OEYkUCnlwX
	 zIzJ+zXHbrIywU+wHkMmRk4tecP1gZ4HtpaBDaMK3gKuwm3lGNVVJ4Vn4DqmxTUckB
	 CHgmtWqq6PMdt8/oOy7hmJvrgPTwc7EqA0B8uNlGbU9UsQuOt7dHU2KRe7RYJYFAf2
	 bQd4vXca2npq1RUdLU0fhTgiVayPVsvwennSnnhPDyIjSEpjf1Q0GTkUiCXRaXs542
	 WFnSdMGOx6x+Q==
Date: Wed, 11 Dec 2024 10:17:06 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/3] xfs_io: Add ext4 support to show FS_IOC_FSGETXATTR
 details
Message-ID: <20241211181706.GB6678@frogsfrogsfrogs>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <3b4b9f091519d2b2085888d296888179da3bdb73.1733902742.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b4b9f091519d2b2085888d296888179da3bdb73.1733902742.git.ojaswin@linux.ibm.com>

On Wed, Dec 11, 2024 at 01:24:03PM +0530, Ojaswin Mujoo wrote:
> Currently with stat we only show FS_IOC_FSGETXATTR details
> if the filesystem is XFS. With extsize support also coming
> to ext4 make sure to show these details when -c "stat" or "statx"
> is used.
> 
> No functional changes for filesystems other than ext4.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  io/stat.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/io/stat.c b/io/stat.c
> index 326f2822e276..d06c2186cde4 100644
> --- a/io/stat.c
> +++ b/io/stat.c
> @@ -97,14 +97,14 @@ print_file_info(void)
>  		file->flags & IO_TMPFILE ? _(",tmpfile") : "");
>  }
>  
> -static void
> -print_xfs_info(int verbose)
> +static void print_extended_info(int verbose)
>  {
> -	struct dioattr	dio;
> -	struct fsxattr	fsx, fsxa;
> +	struct dioattr dio;
> +	struct fsxattr fsx, fsxa;
> +	bool is_xfs_fd = platform_test_xfs_fd(file->fd);
>  
> -	if ((xfsctl(file->name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> -	    (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> +	if ((ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> +		(is_xfs_fd && (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa) < 0))) {

Urgh... perhaps we should call FS_IOC_FSGETXATTR and if it returns zero
print whatever is returned, no matter what filesystem we think is
feeding us information?

e.g.

	if (ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
		if (is_xfs_fd || (errno != EOPNOTSUPP &&
				  errno != ENOTTY))
			perror("FS_IOC_GETXATTR");
	} else {
		printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
		...
	}

	if (ioctl(file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
		if (is_xfs_fd || (errno != EOPNOTSUPP &&
				  errno != ENOTTY))
			perror("XFS_IOC_FSGETXATTRA");
	} else {
		printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
	}

That way we don't have to specialcase platform_test_*_fd() for every
other filesystem that might want to return real fsxattr results?
Same idea for DIOINFO.

--D

>  		perror("FS_IOC_FSGETXATTR");
>  	} else {
>  		printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
> @@ -113,14 +113,18 @@ print_xfs_info(int verbose)
>  		printf(_("fsxattr.extsize = %u\n"), fsx.fsx_extsize);
>  		printf(_("fsxattr.cowextsize = %u\n"), fsx.fsx_cowextsize);
>  		printf(_("fsxattr.nextents = %u\n"), fsx.fsx_nextents);
> -		printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
> +		if (is_xfs_fd)
> +			printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
>  	}
> -	if ((xfsctl(file->name, file->fd, XFS_IOC_DIOINFO, &dio)) < 0) {
> -		perror("XFS_IOC_DIOINFO");
> -	} else {
> -		printf(_("dioattr.mem = 0x%x\n"), dio.d_mem);
> -		printf(_("dioattr.miniosz = %u\n"), dio.d_miniosz);
> -		printf(_("dioattr.maxiosz = %u\n"), dio.d_maxiosz);
> +
> +	if (is_xfs_fd) {
> +		if ((xfsctl(file->name, file->fd, XFS_IOC_DIOINFO, &dio)) < 0) {
> +			perror("XFS_IOC_DIOINFO");
> +		} else {
> +			printf(_("dioattr.mem = 0x%x\n"), dio.d_mem);
> +			printf(_("dioattr.miniosz = %u\n"), dio.d_miniosz);
> +			printf(_("dioattr.maxiosz = %u\n"), dio.d_maxiosz);
> +		}
>  	}
>  }
>  
> @@ -167,10 +171,10 @@ stat_f(
>  		printf(_("stat.ctime = %s"), ctime(&st.st_ctime));
>  	}
>  
> -	if (file->flags & IO_FOREIGN)
> +	if (file->flags & IO_FOREIGN && !platform_test_ext4_fd(file->fd))
>  		return 0;
>  
> -	print_xfs_info(verbose);
> +	print_extended_info(verbose);
>  
>  	return 0;
>  }
> @@ -440,10 +444,10 @@ statx_f(
>  				ctime((time_t *)&stx.stx_btime.tv_sec));
>  	}
>  
> -	if (file->flags & IO_FOREIGN)
> +	if (file->flags & IO_FOREIGN && !platform_test_ext4_fd(file->fd))
>  		return 0;
>  
> -	print_xfs_info(verbose);
> +	print_extended_info(verbose);
>  
>  	return 0;
>  }
> -- 
> 2.43.5
> 
> 

