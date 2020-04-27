Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780F71BA0E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 12:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgD0KPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 06:15:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:58650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgD0KPY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:15:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AF0FBAF0C;
        Mon, 27 Apr 2020 10:15:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 105041E129C; Mon, 27 Apr 2020 12:15:22 +0200 (CEST)
Date:   Mon, 27 Apr 2020 12:15:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     youngjun <her0gyugyu@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inotify: Fix error return code assignment flow.
Message-ID: <20200427101522.GD15107@quack2.suse.cz>
References: <20200426143316.29877-1-her0gyugyu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426143316.29877-1-her0gyugyu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 26-04-20 07:33:16, youngjun wrote:
> If error code is initialized -EINVAL, there is no need to assign -EINVAL.
> 
> Signed-off-by: youngjun <her0gyugyu@gmail.com>

Thanks. I've added the cleanup to my tree,

								Honza

> ---
>  fs/notify/inotify/inotify_user.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 81ffc8629fc4..f88bbcc9efeb 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -764,20 +764,18 @@ SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
>  	struct fsnotify_group *group;
>  	struct inotify_inode_mark *i_mark;
>  	struct fd f;
> -	int ret = 0;
> +	int ret = -EINVAL;
>  
>  	f = fdget(fd);
>  	if (unlikely(!f.file))
>  		return -EBADF;
>  
>  	/* verify that this is indeed an inotify instance */
> -	ret = -EINVAL;
>  	if (unlikely(f.file->f_op != &inotify_fops))
>  		goto out;
>  
>  	group = f.file->private_data;
>  
> -	ret = -EINVAL;
>  	i_mark = inotify_idr_find(group, wd);
>  	if (unlikely(!i_mark))
>  		goto out;
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
