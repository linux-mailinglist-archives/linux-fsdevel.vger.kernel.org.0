Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B735745E9AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 09:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359726AbhKZI5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 03:57:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36026 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344599AbhKZIzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:55:11 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CDB5B1FDFC;
        Fri, 26 Nov 2021 08:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637916717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GO/CEFsKscptchxk94rFkxTwkn3ZTcCkh+pO7jjo1Es=;
        b=kSRqac9d9tMPzRCBw4x9ALwwMpGbHjlXjAGfMe5mW+WlqJ97igIdgpLIEeR0PRfqUdPVdb
        wAkM9Q5W20L0ZeduQWiov0Zlnn2DF+MDqP/UpBRozpOoVs9Rklya8nIIMrVO0pX1YiMGcY
        DLBDjFpgbupXwieKpxBvA4jklBYJcTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637916717;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GO/CEFsKscptchxk94rFkxTwkn3ZTcCkh+pO7jjo1Es=;
        b=cKo39gTtmrK28q8KZrUwHcA4hSA6wcUHTimQZsFM5/B4jbsQcybhQ1n7AbbtgP3asLCPx0
        zMFrHu7XbFwpSyAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 49F6FA3B81;
        Fri, 26 Nov 2021 08:51:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 38F7B1E11F3; Fri, 26 Nov 2021 09:51:54 +0100 (CET)
Date:   Fri, 26 Nov 2021 09:51:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Subject: Re: [RFC PATCH V6 1/7] ovl: setup overlayfs' private bdi
Message-ID: <20211126085154.GA13004@quack2.suse.cz>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
 <20211122030038.1938875-2-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122030038.1938875-2-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-11-21 11:00:32, Chengguang Xu wrote:
> From: Chengguang Xu <charliecgxu@tencent.com>
> 
> Setup overlayfs' private bdi so that we can collect
> overlayfs' own dirty inodes.
> 
> Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/overlayfs/super.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 265181c110ae..18a12088a37b 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1984,6 +1984,10 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>  	if (!ofs)
>  		goto out;
>  
> +	err = super_setup_bdi(sb);
> +	if (err)
> +		goto out_err;
> +
>  	err = -ENOMEM;
>  	ofs->creator_cred = cred = prepare_creds();
>  	if (!cred)
> -- 
> 2.27.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
