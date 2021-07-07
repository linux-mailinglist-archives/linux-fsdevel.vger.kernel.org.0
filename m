Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12413BF059
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 21:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhGGTjs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 15:39:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49162 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGGTjr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:39:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 16AA920013;
        Wed,  7 Jul 2021 19:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625686626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5l7XC8r9s3s3KUS8ZgIFU2KXa80s6gaafOlF4TeGHlw=;
        b=vajHy4ar4U/jCEKtShtrSj/pBP+a/TCvBdnZ3pMQg8DUqx4tGABQJfIQAG+p9dlmJ+gfSM
        kDNleC6fy/Av/XGfZpbqnFEJz0SdsqmJv+28pRL5yCkksh4U8rX59emB9BYaASp23t17Xm
        sntEfb9c6YXpiWkY3e6kcy0aPfTvyXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625686626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5l7XC8r9s3s3KUS8ZgIFU2KXa80s6gaafOlF4TeGHlw=;
        b=/HG97lnqZVEiRQGwVCaAvI5upkJhj0je0UKPF4sw0Cc+w5N1VkzstMtQC56a0QClZNkKK+
        0SlHu6lGGiSiTmDw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id F3857A3B9C;
        Wed,  7 Jul 2021 19:37:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CC2541F2CD7; Wed,  7 Jul 2021 21:37:05 +0200 (CEST)
Date:   Wed, 7 Jul 2021 21:37:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 05/15] inotify: Don't force FS_IN_IGNORED
Message-ID: <20210707193705.GF18396@quack2.suse.cz>
References: <20210629191035.681913-1-krisman@collabora.com>
 <20210629191035.681913-6-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629191035.681913-6-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-06-21 15:10:25, Gabriel Krisman Bertazi wrote:
> According to Amir:
> 
> "FS_IN_IGNORED is completely internal to inotify and there is no need
> to set it in i_fsnotify_mask at all, so if we remove the bit from the
> output of inotify_arg_to_mask() no functionality will change and we will
> be able to overload the event bit for FS_ERROR."
> 
> This is done in preparation to overload FS_ERROR with the notification
> mechanism in fanotify.
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/inotify/inotify_user.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 98f61b31745a..4d17be6dd58d 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -89,10 +89,10 @@ static inline __u32 inotify_arg_to_mask(struct inode *inode, u32 arg)
>  	__u32 mask;
>  
>  	/*
> -	 * Everything should accept their own ignored and should receive events
> -	 * when the inode is unmounted.  All directories care about children.
> +	 * Everything should receive events when the inode is unmounted.
> +	 * All directories care about children.
>  	 */
> -	mask = (FS_IN_IGNORED | FS_UNMOUNT);
> +	mask = (FS_UNMOUNT);
>  	if (S_ISDIR(inode->i_mode))
>  		mask |= FS_EVENT_ON_CHILD;
>  
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
