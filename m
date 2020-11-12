Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0502B0118
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 09:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgKLIRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 03:17:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgKLIRf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:17:35 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE6942076E;
        Thu, 12 Nov 2020 08:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605169055;
        bh=60LD1GgC6+1u0vFCE0HU0a6eOMYhYnVT9GwcRHrKswU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dASG2/LAcoLoRbfyP0liXXIDOr6W2kT+KJBlGAKvj1TL6b9YUYUAsrCsVs6FLB0p9
         +OeuM64tWyk84maJYLufSnw15lVjqxHmx0UPIXIvPCaHD71QYPYKFrLpZdYzuFlRD0
         Lenf4Nh0Qoj4kzd1IIdZi7+61frI7qHSL11iZ7T4=
Date:   Thu, 12 Nov 2020 00:17:33 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Hyeongseok Kim <hyeongseok@gmail.com>
Cc:     yuchao0@huawei.com, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org, hyeongseok.kim@lge.com,
        linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix double free of unicode map
Message-ID: <X6zvndTKKQfISlcj@sol.localdomain>
References: <20201112080201.149359-1-hyeongseok@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112080201.149359-1-hyeongseok@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 05:02:01PM +0900, Hyeongseok Kim wrote:
> In case of retrying fill_super with skip_recovery,
> s_encoding for casefold would not be loaded again even though it's
> already been freed because it's not NULL.
> Set NULL after free to prevent double freeing when unmount.
> 
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
> ---
>  fs/f2fs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 00eff2f51807..fef22e476c52 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3918,6 +3918,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  #ifdef CONFIG_UNICODE
>  	utf8_unload(sb->s_encoding);
> +	sb->s_encoding = NULL;
>  #endif
>  free_options:
>  #ifdef CONFIG_QUOTA
> -- 

This is:

Fixes: eca4873ee1b6 ("f2fs: Use generic casefolding support")

Right?

- Eric
