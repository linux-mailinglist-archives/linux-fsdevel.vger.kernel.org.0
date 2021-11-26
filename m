Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB0045EA3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 10:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376290AbhKZJZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 04:25:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39006 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbhKZJXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:23:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 47D431FDFD;
        Fri, 26 Nov 2021 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637918424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/usd3bihFH8h8Sl+Gav3FHfBHtdDk46haHDYjEnfXUc=;
        b=rtKQo6sqahD+RKAzi8qgj1rUY86w3JG/TuFQOIwrCRd8Bs3NUzfVDR+9Kqh/GaBKIDxxZS
        k76DCWEJspNVg7uDgmocE3n7mO0Uz+oY0DjzKpy3DWea4xDDINl47hajN6tST0Cl0o22ST
        is7tgsJB0/F+S8LH4NINVvxJ6joBI0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637918424;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/usd3bihFH8h8Sl+Gav3FHfBHtdDk46haHDYjEnfXUc=;
        b=HlZckQEdqAg2aTzynhoSC5RxuGZR3ku1ReLoi01tjJxJwlTs5mBO3nK1r3nF/9L5VBjzf/
        EUd2QQn0qJUr5uAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 097EAA3B81;
        Fri, 26 Nov 2021 09:20:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E733D1E11F3; Fri, 26 Nov 2021 10:20:23 +0100 (CET)
Date:   Fri, 26 Nov 2021 10:20:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Subject: Re: [RFC PATCH V6 4/7] ovl: set 'DONTCACHE' flag for overlayfs inode
Message-ID: <20211126092023.GD13004@quack2.suse.cz>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
 <20211122030038.1938875-5-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122030038.1938875-5-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-11-21 11:00:35, Chengguang Xu wrote:
> From: Chengguang Xu <charliecgxu@tencent.com>
> 
> Set 'DONTCACHE' flag to overlayfs inode so that
> upper inode to be always synced before eviction.
> 
> Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
> ---
>  fs/overlayfs/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 027ffc0a2539..c4472299d5df 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -791,6 +791,7 @@ void ovl_inode_init(struct inode *inode, struct ovl_inode_params *oip,
>  	ovl_copyattr(realinode, inode);
>  	ovl_copyflags(realinode, inode);
>  	ovl_map_ino(inode, ino, fsid);
> +	d_mark_dontcache(inode);
>  }

Doesn't this effectively disable dcache for overlayfs dentries? I mean e.g.
whenever overlayfs file is closed, we will drop its dentry & inode from the
cache. Upper and lower inodes / dentries stay in cache so no disk access
should be needed to reconstruct overlayfs dentry & inode but still it may
be a bit costly? I guess others more familiar with overlayfs have to judge.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
