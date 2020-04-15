Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA78B1A9934
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895775AbgDOJpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:45:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:59734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895721AbgDOJpU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:45:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE8BBAD5E;
        Wed, 15 Apr 2020 09:45:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1EB031E1250; Wed, 15 Apr 2020 11:45:16 +0200 (CEST)
Date:   Wed, 15 Apr 2020 11:45:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        "open list:FSNOTIFY: FILESYSTEM NOTIFICATION INFRASTRUCTURE" 
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] fsnotify: Add missing annotation for
 fsnotify_finish_user_wait() and for fsnotify_prepare_user_wait()
Message-ID: <20200415094516.GA6126@quack2.suse.cz>
References: <20200413214240.15245-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413214240.15245-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-04-20 22:42:40, Jules Irenge wrote:
> Sparse reports warnings at fsnotify_prepare_user_wait()
> 	and at fsnotify_finish_user_wait()
> 
> warning: context imbalance in fsnotify_finish_user_wait()
> 	- wrong count at exit
> warning: context imbalance in fsnotify_prepare_user_wait()
> 	- unexpected unlock
> 
> The root cause is the missing annotation at fsnotify_finish_user_wait()
> 	and at fsnotify_prepare_user_wait()
> fsnotify_prepare_user_wait() has an extra annotation __release()
>  that only tell Sparse and not GCC to shutdown the warning
> 
> Add the missing  __acquires(&fsnotify_mark_srcu) annotation
> Add the missing __releases(&fsnotify_mark_srcu) annotation
> Add the __release(&fsnotify_mark_srcu) annotation.

Thanks for the patch. I've added it to my tree.

								Honza

> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
> changes since v2
> -include annotations for fsnotify_prepare_user_wait()
> 
>  fs/notify/mark.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 1d96216dffd1..8387937b9d01 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -325,13 +325,16 @@ static void fsnotify_put_mark_wake(struct fsnotify_mark *mark)
>  }
>  
>  bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
> +	__releases(&fsnotify_mark_srcu)
>  {
>  	int type;
>  
>  	fsnotify_foreach_obj_type(type) {
>  		/* This can fail if mark is being removed */
> -		if (!fsnotify_get_mark_safe(iter_info->marks[type]))
> +		if (!fsnotify_get_mark_safe(iter_info->marks[type])) {
> +			__release(&fsnotify_mark_srcu);
>  			goto fail;
> +		}
>  	}
>  
>  	/*
> @@ -350,6 +353,7 @@ bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
>  }
>  
>  void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info)
> +	__acquires(&fsnotify_mark_srcu)
>  {
>  	int type;
>  
> -- 
> 2.24.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
