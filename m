Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629C94A5BA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 12:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbiBAL5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 06:57:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52668 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiBAL5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:57:04 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 030421F3A5;
        Tue,  1 Feb 2022 11:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643716623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6S1ZfmJRkfd5YMTv7fcsXGlYQuGJkJu4gyAaW0w/4Y=;
        b=vDBo1yOixkTVjEBDHkjtu6y/AbbMRuc7uGXCV3ewgskwOT0RpO+4v0Mvsmt85YZJVO8DLx
        o4LU00D38bpxwthPDFvIRXYvaxHkc5oQyYQUSP8R16bqnCFESQQeo90rWhWuYoq9wzFcgE
        9iKQXwvZGOKPayKTbsvaeyL5B6wOlU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643716623;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6S1ZfmJRkfd5YMTv7fcsXGlYQuGJkJu4gyAaW0w/4Y=;
        b=2ACnZg8Ma3EzEWs9PgkQQDQyXWMRTzceeG2y4/dUcjBpnSyzZn94Vxgp5cIGqop6KGPrQu
        Z3I5/+fcRI8N19Cw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E4453A3B84;
        Tue,  1 Feb 2022 11:57:02 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8823AA05B1; Tue,  1 Feb 2022 12:57:02 +0100 (CET)
Date:   Tue, 1 Feb 2022 12:57:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fanotify: Fix stale file descriptor in
 copy_event_to_user()
Message-ID: <20220201115702.3m3curnkpk7jld2o@quack3.lan>
References: <20220128195656.GA26981@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128195656.GA26981@kili>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 28-01-22 22:57:01, Dan Carpenter wrote:
> This code calls fd_install() which gives the userspace access to the fd.
> Then if copy_info_records_to_user() fails it calls put_unused_fd(fd) but
> that will not release it and leads to a stale entry in the file
> descriptor table.
> 
> Generally you can't trust the fd after a call to fd_install().  The fix
> is to delay the fd_install() until everything else has succeeded.
> 
> Fortunately it requires CAP_SYS_ADMIN to reach this code so the security
> impact is less.
> 
> Fixes: f644bc449b37 ("fanotify: fix copy_event_to_user() fid error clean up")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Mathias Krause <minipli@grsecurity.net>

Thanks. I've added the patch to my tree and will push it to Linus.

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 1026f67b1d1e..2ff6bd85ba8f 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -701,9 +701,6 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  	if (fanotify_is_perm_event(event->mask))
>  		FANOTIFY_PERM(event)->fd = fd;
>  
> -	if (f)
> -		fd_install(fd, f);
> -
>  	if (info_mode) {
>  		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
>  						buf, count);
> @@ -711,6 +708,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  			goto out_close_fd;
>  	}
>  
> +	if (f)
> +		fd_install(fd, f);
> +
>  	return metadata.event_len;
>  
>  out_close_fd:
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
