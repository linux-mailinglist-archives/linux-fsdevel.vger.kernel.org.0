Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9FD42EDBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 11:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbhJOJex (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 05:34:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59790 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbhJOJen (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:34:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 963D41FD39;
        Fri, 15 Oct 2021 09:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634290356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+YccwefQA5p8o06eHm8nEC8qUU7yt3FVWxnzswl0XFE=;
        b=J8WqOR0RWF2uisr6/AavIvpO/251h/xi378DxfvXNit8fA5NJtvVsnEAx5MJMQ0F6Vqwth
        TSGTPBCFiNOR1m9rfm0+TUUr/k9oQDyn+Z8PUu0w+CMvhcj0+9RDNhZ4vnpuK1VKOYJUYa
        WaRjJNKrJckOlQXKJbBBdVGM2BTKsa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634290356;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+YccwefQA5p8o06eHm8nEC8qUU7yt3FVWxnzswl0XFE=;
        b=02wjcBJ1ls+YxORLx5INXml9B5H76rP9oWk+roFVzVuawHLAKS77bk8CAB0URGG+1m45cT
        JWoGWhNjk7JyxtAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 83124A3B83;
        Fri, 15 Oct 2021 09:32:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6445F1E0A40; Fri, 15 Oct 2021 11:32:36 +0200 (CEST)
Date:   Fri, 15 Oct 2021 11:32:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v7 14/28] fanotify: Encode empty file handle when no
 inode is provided
Message-ID: <20211015093236.GG23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-15-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014213646.1139469-15-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-10-21 18:36:32, Gabriel Krisman Bertazi wrote:
> Instead of failing, encode an invalid file handle in fanotify_encode_fh
> if no inode is provided.  This bogus file handle will be reported by
> FAN_FS_ERROR for non-inode errors.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
 
> ---
> Changes since v6:
>   - Use FILEID_ROOT as the internal value (jan)
>   - Create an empty FH (jan)
> 
> Changes since v5:
>   - Preserve flags initialization (jan)
>   - Add BUILD_BUG_ON (amir)
>   - Require minimum of FANOTIFY_NULL_FH_LEN for fh_len(amir)
>   - Improve comment to explain the null FH length (jan)
>   - Simplify logic
> ---
>  fs/notify/fanotify/fanotify.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index ec84fee7ad01..c64d61b673ca 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -370,8 +370,14 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>  	fh->type = FILEID_ROOT;
>  	fh->len = 0;
>  	fh->flags = 0;
> +
> +	/*
> +	 * Invalid FHs are used by FAN_FS_ERROR for errors not
> +	 * linked to any inode. The f_handle won't be reported
> +	 * back to userspace.
> +	 */
>  	if (!inode)
> -		return 0;
> +		goto out;
>  
>  	/*
>  	 * !gpf means preallocated variable size fh, but fh_len could
> @@ -403,6 +409,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>  	fh->type = type;
>  	fh->len = fh_len;
>  
> +out:
>  	/*
>  	 * Mix fh into event merge key.  Hash might be NULL in case of
>  	 * unhashed FID events (i.e. FAN_FS_ERROR).
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
