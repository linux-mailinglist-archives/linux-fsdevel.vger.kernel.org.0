Return-Path: <linux-fsdevel+bounces-37812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8203A9F7EA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B687A3259
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9201226864;
	Thu, 19 Dec 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNGB2+yB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CDB13790B;
	Thu, 19 Dec 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623813; cv=none; b=AvgcI33PZjzZcm3oiFkoxsRi+jhqEoZVLm0ob9R+rKWjTlPH91+XDWAs2GFsISYnoFBFXLyoqmNTMqBKPT5ehC7RvJxIwyU0jcmraDHyDEvwxL4eBn9EI8YZlMmKHO6z+RO8Hhze7GIjupfyNgCfKtMfv8CQ7uLiQ+cENXteEwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623813; c=relaxed/simple;
	bh=QzA+qzkkvFX+yqRFR9Id8E1rWxTGu2gmOtEzvLm0DPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GirCUeMuTQR7MR8bX8/dGeEkBoXjIqBwjtuHANyUmxR7i2wmRELDwB4LHhZDK2jQh2L+YOtut97r8nCEUoEgyovK3BHJFz9WTwn7fWIyPfmH6Q3l9kmbxMB7w2+l7RXgXlYrJ6cO0HhsB9EXZxQjRwNS1v+iwzn8VgxLGckakj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNGB2+yB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9D6C4CECE;
	Thu, 19 Dec 2024 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734623812;
	bh=QzA+qzkkvFX+yqRFR9Id8E1rWxTGu2gmOtEzvLm0DPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNGB2+yBPrj7k43zmbAaPLSZaSYbxb67q0HoDS2Tabo5yzZ2vpgudz3ggP/gI62Ia
	 tmvlTGBImWSXuXedAKXBintmWRsD06d8LqnaxbfPIPieKEhoUVut/gcOK3DpuJfQVR
	 qRWZ40E3h1BVkRaGWxJfjdXYQINzC911i6ZIWKprTTKpytQLCWt66yWdviJmN5dSt0
	 i+VwUIiVAqi0fW1sgPSUW7vh2Q//EB7vqk+e3P73X1kjZFojIefb1LjaDgXaqca+xN
	 GFHjmiv7xQ1e76NUdgmWVxPN1A7f6PsgvOnD+j+uvZcwgFlNMbQZR0QhtLZTj71843
	 QuRYBhk3q5FRQ==
Date: Thu, 19 Dec 2024 07:56:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 2/3] xfs_io: allow foreign FSes to show
 FS_IOC_FSGETXATTR details
Message-ID: <20241219155652.GG6174@frogsfrogsfrogs>
References: <cover.1734611784.git.ojaswin@linux.ibm.com>
 <0d572efaadc1ed7726a79c0f8cc074914f45d320.1734611784.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d572efaadc1ed7726a79c0f8cc074914f45d320.1734611784.git.ojaswin@linux.ibm.com>

On Thu, Dec 19, 2024 at 06:09:14PM +0530, Ojaswin Mujoo wrote:
> Currently with stat we only show FS_IOC_FSGETXATTR details if the
> filesystem is XFS. With extsize support also coming to ext4 and possibly
> other filesystems, make sure to allow foreign FSes to display these details
> when "stat" or "statx" is used.
> 
> (Thanks to Dave for suggesting implementation of print_extended_info())
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good to me now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  io/stat.c | 63 +++++++++++++++++++++++++++++++------------------------
>  1 file changed, 36 insertions(+), 27 deletions(-)
> 
> diff --git a/io/stat.c b/io/stat.c
> index 326f2822e276..3ce3308d0562 100644
> --- a/io/stat.c
> +++ b/io/stat.c
> @@ -98,30 +98,45 @@ print_file_info(void)
>  }
>  
>  static void
> -print_xfs_info(int verbose)
> +print_extended_info(int verbose)
>  {
> -	struct dioattr	dio;
> -	struct fsxattr	fsx, fsxa;
> -
> -	if ((xfsctl(file->name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> -	    (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> -		perror("FS_IOC_FSGETXATTR");
> -	} else {
> -		printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
> -		printxattr(fsx.fsx_xflags, verbose, 0, file->name, 1, 1);
> -		printf(_("fsxattr.projid = %u\n"), fsx.fsx_projid);
> -		printf(_("fsxattr.extsize = %u\n"), fsx.fsx_extsize);
> -		printf(_("fsxattr.cowextsize = %u\n"), fsx.fsx_cowextsize);
> -		printf(_("fsxattr.nextents = %u\n"), fsx.fsx_nextents);
> -		printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
> +	struct dioattr dio = {};
> +	struct fsxattr fsx = {}, fsxa = {};
> +
> +	if ((ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> +		perror("FS_IOC_GETXATTR");
> +		exitcode = 1;
> +		return;
>  	}
> +
> +	printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
> +	printxattr(fsx.fsx_xflags, verbose, 0, file->name, 1, 1);
> +	printf(_("fsxattr.projid = %u\n"), fsx.fsx_projid);
> +	printf(_("fsxattr.extsize = %u\n"), fsx.fsx_extsize);
> +	printf(_("fsxattr.cowextsize = %u\n"), fsx.fsx_cowextsize);
> +	printf(_("fsxattr.nextents = %u\n"), fsx.fsx_nextents);
> +
> +	/* Only XFS supports FS_IOC_FSGETXATTRA and XFS_IOC_DIOINFO */
> +	if (file->flags & IO_FOREIGN)
> +		return;
> +
> +	if ((ioctl(file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> +		perror("XFS_IOC_GETXATTRA");
> +		exitcode = 1;
> +		return;
> +	}
> +
> +	printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
> +
>  	if ((xfsctl(file->name, file->fd, XFS_IOC_DIOINFO, &dio)) < 0) {
>  		perror("XFS_IOC_DIOINFO");
> -	} else {
> -		printf(_("dioattr.mem = 0x%x\n"), dio.d_mem);
> -		printf(_("dioattr.miniosz = %u\n"), dio.d_miniosz);
> -		printf(_("dioattr.maxiosz = %u\n"), dio.d_maxiosz);
> +		exitcode = 1;
> +		return;
>  	}
> +
> +	printf(_("dioattr.mem = 0x%x\n"), dio.d_mem);
> +	printf(_("dioattr.miniosz = %u\n"), dio.d_miniosz);
> +	printf(_("dioattr.maxiosz = %u\n"), dio.d_maxiosz);
>  }
>  
>  int
> @@ -167,10 +182,7 @@ stat_f(
>  		printf(_("stat.ctime = %s"), ctime(&st.st_ctime));
>  	}
>  
> -	if (file->flags & IO_FOREIGN)
> -		return 0;
> -
> -	print_xfs_info(verbose);
> +	print_extended_info(verbose);
>  
>  	return 0;
>  }
> @@ -440,10 +452,7 @@ statx_f(
>  				ctime((time_t *)&stx.stx_btime.tv_sec));
>  	}
>  
> -	if (file->flags & IO_FOREIGN)
> -		return 0;
> -
> -	print_xfs_info(verbose);
> +	print_extended_info(verbose);
>  
>  	return 0;
>  }
> -- 
> 2.43.5
> 
> 

