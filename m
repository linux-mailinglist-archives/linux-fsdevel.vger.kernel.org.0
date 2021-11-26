Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E836145EA49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 10:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376370AbhKZJ0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 04:26:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39044 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbhKZJYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:24:22 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DDD211FDFF;
        Fri, 26 Nov 2021 09:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637918468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dNtAZLhAdZfY9nhUGWuckEHBf4CR0zGhNxN7G6PMLHw=;
        b=tm4s/tT2mMeosyLvtPOni4r3ynjERjGe5Q3Zjy+bh/KzNQgVNkYE4BCQiMd2Pe3Ru4rW1u
        42f4F+b8gsZ7kU5L55KjFZScmdXOlJRanU3Be1MSSHLxKFu0f68XQPdjvqXQlStgfYPhOB
        zi3IvbwNyaeKVpiDtGWaQFuApMtxNZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637918468;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dNtAZLhAdZfY9nhUGWuckEHBf4CR0zGhNxN7G6PMLHw=;
        b=t9xEJO10N8ZTQi4puanGf1+2jjrKw/19hixXvvRKMYRWigEXhExEMCr1Zq5EUSWyEJ8W9f
        dj0Ed++LdgsrHcDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id CBD9AA3B85;
        Fri, 26 Nov 2021 09:21:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BF3AC1E11F3; Fri, 26 Nov 2021 10:21:08 +0100 (CET)
Date:   Fri, 26 Nov 2021 10:21:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Subject: Re: [RFC PATCH V6 6/7] ovl: introduce ovl_sync_upper_blockdev()
Message-ID: <20211126092108.GF13004@quack2.suse.cz>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
 <20211122030038.1938875-7-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122030038.1938875-7-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-11-21 11:00:37, Chengguang Xu wrote:
> From: Chengguang Xu <charliecgxu@tencent.com>
> 
> Introduce new helper ovl_sync_upper_blockdev() to sync
> upper blockdev.
> 
> Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/overlayfs/super.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 12acf0ec7395..ccffcd96491d 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -258,6 +258,16 @@ static void ovl_put_super(struct super_block *sb)
>  	ovl_free_fs(ofs);
>  }
>  
> +static int ovl_sync_upper_blockdev(struct super_block *sb, int wait)
> +{
> +	if (!sb->s_bdev)
> +		return 0;
> +
> +	if (!wait)
> +		return filemap_flush(sb->s_bdev->bd_inode->i_mapping);
> +	return filemap_write_and_wait_range(sb->s_bdev->bd_inode->i_mapping, 0, LLONG_MAX);
> +}
> +
>  /* Sync real dirty inodes in upper filesystem (if it exists) */
>  static int ovl_sync_fs(struct super_block *sb, int wait)
>  {
> -- 
> 2.27.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
