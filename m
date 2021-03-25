Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6CC349432
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 15:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhCYOed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 10:34:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:45042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhCYOea (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:34:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0434CAD80;
        Thu, 25 Mar 2021 14:34:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C03DE1E4415; Thu, 25 Mar 2021 15:34:28 +0100 (CET)
Date:   Thu, 25 Mar 2021 15:34:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH] fanotify_user: use upper_32_bits() to verify mask
Message-ID: <20210325143428.GD13673@quack2.suse.cz>
References: <20210325083742.2334933-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325083742.2334933-1-brauner@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 25-03-21 09:37:43, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> I don't see an obvious reason why the upper 32 bit check needs to be
> open-coded this way. Switch to upper_32_bits() which is more idiomatic and
> should conceptually be the same check.
> 
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks for the cleanup. I've added it to my tree.

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 9e0c1afac8bd..d5683fa9d495 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1126,7 +1126,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		 __func__, fanotify_fd, flags, dfd, pathname, mask);
>  
>  	/* we only use the lower 32 bits as of right now. */
> -	if (mask & ((__u64)0xffffffff << 32))
> +	if (upper_32_bits(mask))
>  		return -EINVAL;
>  
>  	if (flags & ~FANOTIFY_MARK_FLAGS)
> 
> base-commit: 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b
> -- 
> 2.27.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
