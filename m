Return-Path: <linux-fsdevel+bounces-37811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8F69F7EAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4CA189542E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E5B227BA6;
	Thu, 19 Dec 2024 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdGYA2F3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE12226163;
	Thu, 19 Dec 2024 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623734; cv=none; b=lmykRdQjtVuW/o7ONFRFf5BceRqAjEYGfq47YZ4d7l0UWThXkrSmN9jXxhZPHxlVyqSXQqqS0V/l3tnmpZHUe2+JDhLzQUkip1XsYlO9HNycuFWsCKlCxqaT0v4rZMDOBnABaNb2gfMYeUQLri4P5QYylQoXrQgznJUfA/rp/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623734; c=relaxed/simple;
	bh=LOYqbRv0S3PGHTtgWb+8XOMIbZx4Cp42YCyY/lAWYIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9tvgelN7gyLaj6xNKanWdklU4S+O4FS+4zfB1ECA90RDAA8vGUSTmofkw04acOSzSSqJQjwZ2IB6MZyMQVlysLcaeEpD2B4C5DXrFB0dZ20+DgwZRMgOeSnL2b9hWEPpEqmoY0hTtzZzEQtQeGnHf1ZD5AKVv5bNw3RiPoCRE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdGYA2F3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADAEC4CECE;
	Thu, 19 Dec 2024 15:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734623733;
	bh=LOYqbRv0S3PGHTtgWb+8XOMIbZx4Cp42YCyY/lAWYIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KdGYA2F3uqub2fqM2T1TIG3HBnua4bpl8X2WxE1nk6unVGdxF1neqfsFWg6wY9Iml
	 sIqpcg11whvdNgiXee363skzGkdmBRZXVxtwcrezL1MdNXEJ6mNlyDog8QxqWxci+U
	 tyqGIU+0IT6/55KPwEou0L23VeZVBJ5mZ1hlDjIvVE/JcIkvbzLWUI4epJk8r3F/ZU
	 hmXhT42xreAT3YeYqqBr3r7gNRMqV0fEjwg5vnUQAD8DOabA3v2brfpHwHksh9TGSU
	 V6/OVJGXa/t7z4PL8D8+R1dKuOzLycvD8QZ4Eqb7iOKC+0+xtDzqhW8HlxfHiojaCQ
	 ZB98CXzk3pDZQ==
Date: Thu, 19 Dec 2024 07:55:32 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/3] include/linux.h: use linux/magic.h to get
 XFS_SUPER_MAGIC
Message-ID: <20241219155532.GF6174@frogsfrogsfrogs>
References: <cover.1734611784.git.ojaswin@linux.ibm.com>
 <66f4220d2c2da6ce143114f9635ed8cd4e54af1d.1734611784.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f4220d2c2da6ce143114f9635ed8cd4e54af1d.1734611784.git.ojaswin@linux.ibm.com>

On Thu, Dec 19, 2024 at 06:09:13PM +0530, Ojaswin Mujoo wrote:
> This avoids open coding the magic number
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks reasonable,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  include/linux.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux.h b/include/linux.h
> index e9eb7bfb26a1..b3516d54c51b 100644
> --- a/include/linux.h
> +++ b/include/linux.h
> @@ -37,6 +37,7 @@
>  #endif
>  #include <unistd.h>
>  #include <assert.h>
> +#include <linux/magic.h> /* super block magic numbers */
>  
>  static __inline__ int xfsctl(const char *path, int fd, int cmd, void *p)
>  {
> @@ -60,7 +61,7 @@ static __inline__ int platform_test_xfs_fd(int fd)
>  		return 0;
>  	if (!S_ISREG(statbuf.st_mode) && !S_ISDIR(statbuf.st_mode))
>  		return 0;
> -	return (statfsbuf.f_type == 0x58465342);	/* XFSB */
> +	return statfsbuf.f_type == XFS_SUPER_MAGIC;
>  }
>  
>  static __inline__ int platform_test_xfs_path(const char *path)
> -- 
> 2.43.5
> 
> 

