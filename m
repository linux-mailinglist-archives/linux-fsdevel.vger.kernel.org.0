Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFC83A679C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfICLkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:40:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:49850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728938AbfICLkS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:40:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7532FAFE2;
        Tue,  3 Sep 2019 11:40:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D2D381E4402; Tue,  3 Sep 2019 13:40:16 +0200 (CEST)
Date:   Tue, 3 Sep 2019 13:40:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: remove always false comparison in
 copy_fid_to_user
Message-ID: <20190903114016.GA4401@quack2.suse.cz>
References: <1567475654-6133-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567475654-6133-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-09-19 09:54:14, zhengbin wrote:
> Fixes gcc warning:
> 
> fs/notify/fanotify/fanotify_user.c:252:19: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Thanks for the patch! I've added it to my tree.

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 8508ab5..e15547d 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -249,7 +249,7 @@ static int copy_fid_to_user(struct fanotify_event *event, char __user *buf)
>  	/* Pad with 0's */
>  	buf += fh_len;
>  	len -= fh_len;
> -	WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);
> +	WARN_ON_ONCE(len >= FANOTIFY_EVENT_ALIGN);
>  	if (len > 0 && clear_user(buf, len))
>  		return -EFAULT;
> 
> --
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
