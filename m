Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D41A3CA3A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 19:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhGOROq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 13:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231977AbhGOROp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:14:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 298FB613D8;
        Thu, 15 Jul 2021 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626369112;
        bh=FY4e+oZ1PFtHlMAKa/Bsp5UEp0fB77fsFYJPP2oLU6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXXddtYDTrm0gSn9hX/wlxWLaGSOhAF0JIE80yuFrp41mSOsycIe5H7/PowCrqoCG
         H1yFnyrY8gC5fRTpb85ZkSuT7lwhtFww3+uX14gCVnKXGefiPU2E3GybGPHpy3ZYhY
         rCocgvbdZoYDv/JY60VJRxss50LmwwYTQYhnQjBYumauSRTAd0nkkl6BAjpAPvb1Tu
         V/JkBneUfyIdkgkQm9JuIuPgK87OUoW05LRCsvffzsEk+KOaEtCfsUA+vu7dJjnG6i
         y4XvIXDDREY7ocscb3Hk+ks773TBx31HDbXLNT2YHyOM8E8DUB9xNZ/NuTgNroQQor
         icHAyHi7bL6qw==
Date:   Thu, 15 Jul 2021 10:11:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jia He <justin.he@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 07/13] iomap: simplify iomap_swapfile_fail() with
 '%pD' specifier
Message-ID: <20210715171151.GU22402@magnolia>
References: <20210715031533.9553-1-justin.he@arm.com>
 <20210715031533.9553-8-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715031533.9553-8-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 11:15:27AM +0800, Jia He wrote:
> After the behavior of '%pD' is change to print the full path of file,
> iomap_swapfile_fail() can be simplified.
> 
> Given the space with proper length would be allocated in vprintk_store(),
> the kmalloc() is not required any more.
> 
> Besides, the previous number postfix of '%pD' in format string is
> pointless.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: linux-xfs@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Jia He <justin.he@arm.com>

Seems reasonable to me...
Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 2 +-
>  fs/iomap/swapfile.c  | 8 +-------
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323..e876a5f9d888 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -426,7 +426,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		 * iomap_apply() call in the DIO path, then it will see the
>  		 * DELALLOC block that the page-mkwrite allocated.
>  		 */
> -		pr_warn_ratelimited("Direct I/O collision with buffered writes! File: %pD4 Comm: %.20s\n",
> +		pr_warn_ratelimited("Direct I/O collision with buffered writes! File: %pD Comm: %.20s\n",
>  				    dio->iocb->ki_filp, current->comm);
>  		return -EIO;
>  	default:
> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> index 6250ca6a1f85..17032c14e466 100644
> --- a/fs/iomap/swapfile.c
> +++ b/fs/iomap/swapfile.c
> @@ -73,13 +73,7 @@ static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
>  
>  static int iomap_swapfile_fail(struct iomap_swapfile_info *isi, const char *str)
>  {
> -	char *buf, *p = ERR_PTR(-ENOMEM);
> -
> -	buf = kmalloc(PATH_MAX, GFP_KERNEL);
> -	if (buf)
> -		p = file_path(isi->file, buf, PATH_MAX);
> -	pr_err("swapon: file %s %s\n", IS_ERR(p) ? "<unknown>" : p, str);
> -	kfree(buf);
> +	pr_err("swapon: file %pD %s\n", isi->file, str);
>  	return -EINVAL;
>  }
>  
> -- 
> 2.17.1
> 
