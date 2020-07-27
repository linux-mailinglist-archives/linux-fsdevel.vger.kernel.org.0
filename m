Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE1C22F39E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 17:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgG0PRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 11:17:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:47322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgG0PRB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:17:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27EA1AC61;
        Mon, 27 Jul 2020 15:17:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 82EF41E12C5; Mon, 27 Jul 2020 17:17:00 +0200 (CEST)
Date:   Mon, 27 Jul 2020 17:17:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/9] fanotify: fix reporting event to sb/mount marks
Message-ID: <20200727151700.GD5284@quack2.suse.cz>
References: <20200722125849.17418-1-amir73il@gmail.com>
 <20200722125849.17418-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722125849.17418-2-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-07-20 15:58:41, Amir Goldstein wrote:
> When reporting event with parent/name info, we should not skip sb/mount
> marks mask if event has FAN_EVENT_ON_CHILD in the mask.
> 
> This check is a leftover from the time when the event on child was
> reported in a separate callback than the event on parent and we did
> not want to get duplicate events for sb/mount mark.
> 
> Fixes: eca4784cbb18 ("fsnotify: send event to parent and child with single callback")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

OK, I've decided to just drop "fanotify: report both events on parent and
child with single callback" because it didn't improve anything and amend
eca4784cbb18 with this change...

								Honza

> ---
>  fs/notify/fanotify/fanotify.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index a24f08a9c50f..36ea0cd6387e 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -265,13 +265,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  			continue;
>  
>  		/*
> -		 * If the event is for a child and this mark doesn't care about
> -		 * events on a child, don't send it!
> -		 * The special object type "child" always cares about events on
> -		 * a child, because it refers to the child inode itself.
> +		 * If the event is for a child and this mark is on a parent not
> +		 * watching children, don't send it!
>  		 */
>  		if (event_mask & FS_EVENT_ON_CHILD &&
> -		    type != FSNOTIFY_OBJ_TYPE_CHILD &&
> +		    type == FSNOTIFY_OBJ_TYPE_INODE &&
>  		    !(mark->mask & FS_EVENT_ON_CHILD))
>  			continue;
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
