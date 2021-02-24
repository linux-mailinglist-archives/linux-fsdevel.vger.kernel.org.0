Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6944B324083
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 16:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhBXPKI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 10:10:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:42508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235816AbhBXOgR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:36:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DEDE5AEC4;
        Wed, 24 Feb 2021 14:34:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 49BD01E14F1; Wed, 24 Feb 2021 15:34:42 +0100 (CET)
Date:   Wed, 24 Feb 2021 15:34:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: don't specify flag FIEMAP_FLAG_SYNC when calling
 fiemap_prep()
Message-ID: <20210224143442.GA849@quack2.suse.cz>
References: <20210223131632.2208648-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223131632.2208648-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 23-02-21 21:16:32, Chengguang Xu wrote:
> commit 45dd052e67ad17c7a ("fs: handle FIEMAP_FLAG_SYNC in fiemap_prep")
> has moved FIEMAP_FLAG_SYNC handling to fiemap_prep(), so don't have
> to specify flags FIEMAP_FLAG_SYNC when calling fiemap_prep in
> __generic_block_fiemap().
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 4e6cc0a7d69c..49355e689750 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -303,7 +303,7 @@ static int __generic_block_fiemap(struct inode *inode,
>  	bool past_eof = false, whole_file = false;
>  	int ret = 0;
>  
> -	ret = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
> +	ret = fiemap_prep(inode, fieinfo, start, &len, 0);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.27.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
