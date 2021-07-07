Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB643BF02C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 21:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhGGTXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 15:23:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46484 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhGGTXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:23:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E5DE3200ED;
        Wed,  7 Jul 2021 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625685664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LE2jZkHx/bJbCE8AVNQqBwLgs4Dbdn7m6hJiD+GTDTk=;
        b=wd5Ep5AUwicc6N3k7bk0efVOEibq1LgMuWxX5Cq18kUJC0NGvh7daZQaQfyNKm8F+HqIaw
        22aRcui1AYlkMGSyHQ8A29BAjQMXdLZUZaAUHfCNaFw/IS8UXKKVMumBW0fdL5La/8vJ+/
        ngeMhYgzTjYnK2CXA9nNx7uc++7vkG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625685664;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LE2jZkHx/bJbCE8AVNQqBwLgs4Dbdn7m6hJiD+GTDTk=;
        b=uS0jfXnIow+iDj7CFc7POxp61djeonWSmX5gm0h6N24iZW3YzlrgcgLawr8Gx8MwkJHzDU
        5KhT/9j4kw+Q/qCg==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id C5D30A3BB4;
        Wed,  7 Jul 2021 19:21:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9493D1F2CD7; Wed,  7 Jul 2021 21:21:04 +0200 (CEST)
Date:   Wed, 7 Jul 2021 21:21:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 01/15] fsnotify: Don't insert unmergeable events in
 hashtable
Message-ID: <20210707192103.GC18396@quack2.suse.cz>
References: <20210629191035.681913-1-krisman@collabora.com>
 <20210629191035.681913-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629191035.681913-2-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-06-21 15:10:21, Gabriel Krisman Bertazi wrote:
> Some events, like the overflow event, are not mergeable, so they are not
> hashed.  But, when failing inside fsnotify_add_event for lack of space,
> fsnotify_add_event() still calls the insert hook, which adds the
> overflow event to the merge list.  Add a check to prevent any kind of
> unmergeable event to be inserted in the hashtable.
> 
> Fixes: 94e00d28a680 ("fsnotify: use hash table for faster events merge")
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes since v2:
>   - Do check for hashed events inside the insert hook (Amir)
> ---
>  fs/notify/fanotify/fanotify.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 057abd2cf887..310246f8d3f1 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -702,6 +702,9 @@ static void fanotify_insert_event(struct fsnotify_group *group,
>  
>  	assert_spin_locked(&group->notification_lock);
>  
> +	if (!fanotify_is_hashed_event(event->mask))
> +		return;
> +
>  	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__,
>  		 group, event, bucket);
>  
> @@ -779,8 +782,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  
>  	fsn_event = &event->fse;
>  	ret = fsnotify_add_event(group, fsn_event, fanotify_merge,
> -				 fanotify_is_hashed_event(mask) ?
> -				 fanotify_insert_event : NULL);
> +				 fanotify_insert_event);
>  	if (ret) {
>  		/* Permission events shouldn't be merged */
>  		BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
