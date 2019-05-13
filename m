Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37DC01B219
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 10:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfEMIvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 04:51:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:52442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727967AbfEMIvQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 04:51:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12230AECD;
        Mon, 13 May 2019 08:51:15 +0000 (UTC)
Date:   Mon, 13 May 2019 10:51:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/2] memcg, fsnotify: no oom-kill for remote
 memcg charging
Message-ID: <20190513085114.GD24036@dhcp22.suse.cz>
References: <20190512160927.80042-1-shakeelb@google.com>
 <20190512160927.80042-2-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512160927.80042-2-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 12-05-19 09:09:27, Shakeel Butt wrote:
[...]
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 6b9c27548997..f78fd4c8f12d 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -288,10 +288,13 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  	/*
>  	 * For queues with unlimited length lost events are not expected and
>  	 * can possibly have security implications. Avoid losing events when
> -	 * memory is short.
> +	 * memory is short. Also make sure to not trigger OOM killer in the
> +	 * target memcg for the limited size queues.
>  	 */
>  	if (group->max_events == UINT_MAX)
>  		gfp |= __GFP_NOFAIL;
> +	else
> +		gfp |= __GFP_RETRY_MAYFAIL;
>  
>  	/* Whoever is interested in the event, pays for the allocation. */
>  	memalloc_use_memcg(group->memcg);
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index ff30abd6a49b..17c08daa1ba7 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -99,9 +99,12 @@ int inotify_handle_event(struct fsnotify_group *group,
>  	i_mark = container_of(inode_mark, struct inotify_inode_mark,
>  			      fsn_mark);
>  
> -	/* Whoever is interested in the event, pays for the allocation. */
> +	/*
> +	 * Whoever is interested in the event, pays for the allocation. However
> +	 * do not trigger the OOM killer in the target memcg.

Both comments would be much more helpful if they mentioned _why_ we do
not want to trigger the OOM iller.

> +	 */
>  	memalloc_use_memcg(group->memcg);
> -	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT);
> +	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
>  	memalloc_unuse_memcg();
>  
>  	if (unlikely(!event)) {
-- 
Michal Hocko
SUSE Labs
