Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E821E092E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 10:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbgEYIo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 04:44:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:46418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388182AbgEYIo5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 04:44:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 84CEBAB5C;
        Mon, 25 May 2020 08:44:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6316F1E127C; Mon, 25 May 2020 10:44:55 +0200 (CEST)
Date:   Mon, 25 May 2020 10:44:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: fix ignore mask logic for events on child and
 on dir
Message-ID: <20200525084455.GL14199@quack2.suse.cz>
References: <20200524072441.18258-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524072441.18258-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 24-05-20 10:24:41, Amir Goldstein wrote:
> The comments in fanotify_group_event_mask() say:
> 
>   "If the event is on dir/child and this mark doesn't care about
>    events on dir/child, don't send it!"
> 
> Specifically, mount and filesystem marks do not care about events
> on child, but they can still specify an ignore mask for those events.
> For example, a group that has:
> - A mount mark with mask 0 and ignore_mask FAN_OPEN
> - An inode mark on a directory with mask FAN_OPEN | FAN_OPEN_EXEC
>   with flag FAN_EVENT_ON_CHILD
> 
> A child file open for exec would be reported to group with the FAN_OPEN
> event despite the fact that FAN_OPEN is in ignore mask of mount mark,
> because the mark iteration loop skips over non-inode marks for events
> on child when calculating the ignore mask.
> 
> Move ignore mask calculation to the top of the iteration loop block
> before excluding marks for events on dir/child.
> 
> Reported-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/linux-fsdevel/20200521162443.GA26052@quack2.suse.cz/
> Fixes: 55bf882c7f13 "fanotify: fix merging marks masks with FAN_ONDIR"
> Fixes: b469e7e47c8a "fanotify: fix handling of events on child..."
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks! I've added the patch to my tree. I don't think this is really
urgent fix so I plan to push it to Linus in the coming merge window.

								Honza

> ---
> 
> Jan,
> 
> As you suspected we had a bug in ignore mask logic.
> The actual test case is quite asoteric, but it's worth fixing the logic
> anyway.
> 
> Judging by LTP tests fanotify10 and fanotify12, we were pretty paranoid
> about adding the compound event FAN_OPEN | FAN_OPEN_EXEC, so Matthew
> wrote a lot of tests even for ignore mask, but we still missed this
> corner case.
> 
> It was, however, trivial to add a test case for this issue [1].
> I couldn't figure out if a similar bug exists with FAN_ONDIR, because
> the FAN_OPEN_EXEC event is not applicable and it is quite hard to figure
> out if fsnotify_change() is ever called with a combination of ia_valid
> flags that ends up with a compound event on dir.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/ltp/commits/fsnotify-fixes
> 
>  fs/notify/fanotify/fanotify.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 95480d3dcff7..e22fd8f8c281 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -232,6 +232,10 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  		if (!fsnotify_iter_should_report_type(iter_info, type))
>  			continue;
>  		mark = iter_info->marks[type];
> +
> +		/* Apply ignore mask regardless of ISDIR and ON_CHILD flags */
> +		marks_ignored_mask |= mark->ignored_mask;
> +
>  		/*
>  		 * If the event is on dir and this mark doesn't care about
>  		 * events on dir, don't send it!
> @@ -249,7 +253,6 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  			continue;
>  
>  		marks_mask |= mark->mask;
> -		marks_ignored_mask |= mark->ignored_mask;
>  	}
>  
>  	test_mask = event_mask & marks_mask & ~marks_ignored_mask;
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
