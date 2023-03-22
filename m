Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D9D6C44C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 09:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjCVIUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 04:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCVIUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:20:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFF75941D;
        Wed, 22 Mar 2023 01:20:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6787B81B5B;
        Wed, 22 Mar 2023 08:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B5EC433EF;
        Wed, 22 Mar 2023 08:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679473248;
        bh=hclSpSAvHMC2NvRtZD9SW20kTIbHxZrtYZ1rX/4B/Pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQtimfNRBpQAgwCX2xh5yhh0iIFgMbqMnDBt81yGUOsTT69OJF1CNyZce90iSnLBV
         teRbPYVZ5mljc5wCa5cfPRlOCuMq9Og6mjj2XjDiC87z4ZAq5seI+ZA29ZcCM+5lBk
         +kh8f2hOk3jOk9PGCG+5UdQGGpZgxauHSl9xD6WCKdqxbX6tbpzNQeQ0sMbMHLGS/7
         /sazMg6Q4LkJvGK3pRrZCNe5x/CcCTgqJo9fj4dYkFtIUUMNczgj8kbNO3bT7UqfgB
         NCBWt7XSfi5gpej+t8rDj+2vH1b0FXuhUxEZ/34OiveX9cA1ijRPUfSVi3CxTw2xtx
         usF5f8/AmKnWg==
Date:   Wed, 22 Mar 2023 09:20:43 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] fs/buffer: Remove redundant assignment to err
Message-ID: <20230322082043.f3vcu4iucqe533hl@wittgenstein>
References: <20230322065949.29223-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322065949.29223-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 02:59:49PM +0800, Jiapeng Chong wrote:
> Variable 'err' set but not used.
> 
> fs/buffer.c:2613:2: warning: Value stored to 'err' is never read.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4589
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/buffer.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index d759b105c1e7..c844b5b93a89 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2580,7 +2580,7 @@ int block_truncate_page(struct address_space *mapping,
>  	struct inode *inode = mapping->host;
>  	struct page *page;
>  	struct buffer_head *bh;
> -	int err;
> +	int err = 0;
>  
>  	blocksize = i_blocksize(inode);
>  	length = offset & (blocksize - 1);
> @@ -2593,9 +2593,8 @@ int block_truncate_page(struct address_space *mapping,
>  	iblock = (sector_t)index << (PAGE_SHIFT - inode->i_blkbits);
>  	
>  	page = grab_cache_page(mapping, index);
> -	err = -ENOMEM;
>  	if (!page)
> -		goto out;
> +		return -ENOMEM;

This change makes the out: label unused.
