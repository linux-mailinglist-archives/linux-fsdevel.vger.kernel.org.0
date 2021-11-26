Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EEF45EA5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 10:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376275AbhKZJaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 04:30:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56530 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbhKZJ2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:28:22 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DB98C212BC;
        Fri, 26 Nov 2021 09:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637918708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+BmyZ6nHsjemv7f4v1pkF+IOWYslCFmtmkVz+Xq0J28=;
        b=OC44tj16AZJCpddzarYtO2rqZeK442EbB86zjW2HXf2ltg0/a7I8mpqT5KBW+k3XN1gFDg
        zEaq80YY1SrCkmBGDOdrN6AjU+tD6wmSVXHvMzXrh9BHQz8e63j7axhMFZFt+haNQD/N3y
        vxaZZ7O3kBND1DhbThlTLpV3S8r3y0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637918708;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+BmyZ6nHsjemv7f4v1pkF+IOWYslCFmtmkVz+Xq0J28=;
        b=0ALdFhr5x+iuvXanawyssRtSdKo0ZqsSJB+d2sz0AFmNQEBMEa6zMfK3cmBu9plyqHKcge
        NsjtGWyKTuzJIVBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 9D684A3B87;
        Fri, 26 Nov 2021 09:25:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8EFDE1E11F3; Fri, 26 Nov 2021 10:25:08 +0100 (CET)
Date:   Fri, 26 Nov 2021 10:25:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Subject: Re: [RFC PATCH V6 7/7] ovl: implement containerized syncfs for
 overlayfs
Message-ID: <20211126092508.GG13004@quack2.suse.cz>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
 <20211122030038.1938875-8-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122030038.1938875-8-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-11-21 11:00:38, Chengguang Xu wrote:
> From: Chengguang Xu <charliecgxu@tencent.com>
> 
> Now overlayfs can only sync own dirty inodes during syncfs,
> so remove unnecessary sync_filesystem() on upper file system.
> 
> Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/overlayfs/super.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index ccffcd96491d..213b795a6a86 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -292,18 +292,14 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
>  	/*
>  	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
>  	 * All the super blocks will be iterated, including upper_sb.
> -	 *
> -	 * If this is a syncfs(2) call, then we do need to call
> -	 * sync_filesystem() on upper_sb, but enough if we do it when being
> -	 * called with wait == 1.
>  	 */
> -	if (!wait)
> -		return 0;
> -
>  	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> -
>  	down_read(&upper_sb->s_umount);
> -	ret = sync_filesystem(upper_sb);
> +	if (wait)
> +		wait_sb_inodes(upper_sb);
> +	if (upper_sb->s_op->sync_fs)
> +		upper_sb->s_op->sync_fs(upper_sb, wait);
> +	ret = ovl_sync_upper_blockdev(upper_sb, wait);
>  	up_read(&upper_sb->s_umount);
>  
>  	return ret;
> -- 
> 2.27.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
