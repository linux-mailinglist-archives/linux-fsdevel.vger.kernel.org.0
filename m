Return-Path: <linux-fsdevel+bounces-37081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AD89ED47E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 19:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADD4188AB99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 18:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4306A201264;
	Wed, 11 Dec 2024 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcUFqsS0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E091246344;
	Wed, 11 Dec 2024 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940543; cv=none; b=bxd2Jk1XUnV9//M230xinsyIhQXpM2AFgGVwDDG2avHcKkij3A2F2PA7lpz1tqp+YItfDqs15enKX7VMYiHnmVlj+W6hseQBqxUas+DrYWd59Ubwr9IAB5qDc8JGH2wRlRudVQVkaRzMLXrXFKlvsDUAnGK8ihhaTG8NbHGhctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940543; c=relaxed/simple;
	bh=zPEuBaFJs0hO+pYKyZErs+pnHfMb5a1H6fIgZhfiuJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPU63PPp3H3PdyPsXNm8al244cJ/d7GZxJq3VD/G2hAJqEJsgjZbW/klzXe9voPH9AzMfBrEec+xBesJf0DA8aaKZJJ9j2aaSQ79x9URHDWrpPa+OMavgd5MEmPYAymeHSXq1xVYbbclZS4aMp9SkFdIns3Pk4aHV59IJ/e8yfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcUFqsS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C3AC4CED2;
	Wed, 11 Dec 2024 18:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733940543;
	bh=zPEuBaFJs0hO+pYKyZErs+pnHfMb5a1H6fIgZhfiuJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcUFqsS0snssUsYzkB8vQnGYSY1ln6dzw6FYi9YphMxqFHnxSyR9BruYZ7cNf6YeK
	 SwkZiSxBMT+w+lPhH5CJLZg45OUzgTzy8c+iCJ80iGk7gygXOdaj/Wty7WFC80tFwp
	 HXx5+TDan456VqBTf+eALKDqU3RTN+tiOTiRwjKgsGx/6uJ9KlTBeJWpjCRM2CGVTl
	 LrkfcyrvC5k+nfhF7J3F+K5TeNUOpOJE/9nOWcU6bvETWZ3xpddZoJ6C8qzEaR0aIg
	 CsYWqK435b3EESXGlPn5F4cYspDw6D3PBXLt/Li+ijQoveouAuPKTB3zkPl0PztW+6
	 IEPGabXxDWR5A==
Date: Wed, 11 Dec 2024 10:09:02 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 1/3] include/linux.h: Factor out generic
 platform_test_fs_fd() helper
Message-ID: <20241211180902.GA6678@frogsfrogsfrogs>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <5996d6854a16852daca5977063af6f2af2f0f4ca.1733902742.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5996d6854a16852daca5977063af6f2af2f0f4ca.1733902742.git.ojaswin@linux.ibm.com>

On Wed, Dec 11, 2024 at 01:24:02PM +0530, Ojaswin Mujoo wrote:
> Factor our the generic code to detect the FS type out of
> platform_test_fs_fd(). This can then be used to detect different file
> systems types based on magic number.
> 
> Also, add a helper to detect if the fd is from an ext4 filesystem.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  include/linux.h | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux.h b/include/linux.h
> index e9eb7bfb26a1..52c64014c57f 100644
> --- a/include/linux.h
> +++ b/include/linux.h
> @@ -43,13 +43,7 @@ static __inline__ int xfsctl(const char *path, int fd, int cmd, void *p)
>  	return ioctl(fd, cmd, p);
>  }
>  
> -/*
> - * platform_test_xfs_*() implies that xfsctl will succeed on the file;
> - * on Linux, at least, special files don't get xfs file ops,
> - * so return 0 for those
> - */
> -
> -static __inline__ int platform_test_xfs_fd(int fd)
> +static __inline__ int platform_test_fs_fd(int fd, long type)
>  {
>  	struct statfs statfsbuf;
>  	struct stat statbuf;
> @@ -60,7 +54,22 @@ static __inline__ int platform_test_xfs_fd(int fd)
>  		return 0;
>  	if (!S_ISREG(statbuf.st_mode) && !S_ISDIR(statbuf.st_mode))
>  		return 0;
> -	return (statfsbuf.f_type == 0x58465342);	/* XFSB */
> +	return (statfsbuf.f_type == type);
> +}
> +
> +/*
> + * platform_test_xfs_*() implies that xfsctl will succeed on the file;
> + * on Linux, at least, special files don't get xfs file ops,
> + * so return 0 for those
> + */
> +static __inline__ int platform_test_xfs_fd(int fd)
> +{
> +	return platform_test_fs_fd(fd, 0x58465342); /* XFSB */
> +}
> +
> +static __inline__ int platform_test_ext4_fd(int fd)
> +{
> +	return platform_test_fs_fd(fd, 0xef53); /* EXT4 magic number */

Should this be pulling EXT4_SUPER_MAGIC from linux/magic.h?

--D

>  }
>  
>  static __inline__ int platform_test_xfs_path(const char *path)
> -- 
> 2.43.5
> 
> 

