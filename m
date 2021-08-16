Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912EF3EDA51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 17:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhHPP6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 11:58:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42942 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhHPP6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:58:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 410C11FF92;
        Mon, 16 Aug 2021 15:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629129479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QjDF6IkW3wee596kgFPTehby8RmT00zEqsmCOps1hJk=;
        b=O7Coxd1Xp5ktIUotDTqLHkjeccpTqWj7m6jYAYV83i7Zap9lzHnDBHMuN7jsuIBfMrAJVP
        yoVCVbe9npfNytrG7mmoomzl+Bw+SUEkh+4Ve9j5xeIfdSnNsptnDDnC6UY6Jy8o7eyrI2
        r69d20X/A2FTOWzQOqQbwJwCs4IknWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629129479;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QjDF6IkW3wee596kgFPTehby8RmT00zEqsmCOps1hJk=;
        b=tVodTNxralzB5N+Jc4L0Dbibv6MWlJ2kDTK7v+OfUNrlQTq8wxRHhKJHPRmGorKZ6EyUaJ
        gZa1QSuueygE9nCA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 21C44A3B87;
        Mon, 16 Aug 2021 15:57:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D81791E0426; Mon, 16 Aug 2021 17:57:58 +0200 (CEST)
Date:   Mon, 16 Aug 2021 17:57:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, jack@suse.com, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        khazhy@google.com, dhowells@redhat.com, david@fromorbit.com,
        tytso@mit.edu, djwong@kernel.org, repnop@google.com,
        kernel@collabora.com
Subject: Re: [PATCH v6 15/21] fanotify: Preallocate per superblock mark error
 event
Message-ID: <20210816155758.GF30215@quack2.suse.cz>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-16-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812214010.3197279-16-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 12-08-21 17:40:04, Gabriel Krisman Bertazi wrote:
> Error reporting needs to be done in an atomic context.  This patch
> introduces a single error slot for superblock marks that report the
> FAN_FS_ERROR event, to be used during event submission.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> Changes v5:
>   - Restore mark references. (jan)
>   - Tie fee slot to the mark lifetime.(jan)
>   - Don't reallocate event(jan)
> ---
>  fs/notify/fanotify/fanotify.c      | 12 ++++++++++++
>  fs/notify/fanotify/fanotify.h      | 13 +++++++++++++
>  fs/notify/fanotify/fanotify_user.c | 31 ++++++++++++++++++++++++++++--
>  3 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index ebb6c557cea1..3bf6fd85c634 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -855,6 +855,14 @@ static void fanotify_free_name_event(struct fanotify_event *event)
>  	kfree(FANOTIFY_NE(event));
>  }
>  
> +static void fanotify_free_error_event(struct fanotify_event *event)
> +{
> +	/*
> +	 * The actual event is tied to a mark, and is released on mark
> +	 * removal
> +	 */
> +}
> +

I was pondering about the lifetime rules some more. This is also related to
patch 16/21 but I'll comment here. When we hold mark ref from queued event,
we introduce a subtle race into group destruction logic. There we first
evict all marks, wait for them to be destroyed by worker thread after SRCU
period expires, and then we remove queued events. When we hold mark
reference from an event we break this as mark will exist until the event is
dequeued and then group can get freed before we actually free the mark and
so mark freeing can hit use-after-free issues.

So we'll have to do this a bit differently. I have two options:

1) Instead of preallocating events explicitely like this, we could setup a
mempool to allocate error events from for each notification group. We would
resize the mempool when adding error mark so that it has as many reserved
events as error marks. Upside is error events will be much less special -
no special lifetime rules. We'd just need to setup & resize the mempool. We
would also have to provide proper merge function for error events (to merge
events from the same sb). Also there will be limitation of number of error
marks per group because mempools use kmalloc() for an array tracking
reserved events. But we could certainly manage 512, likely 1024 error marks
per notification group.

2) We would keep attaching event to mark as currently. As far as I have
checked the event doesn't actually need a back-ref to sb_mark. It is
really only used for mark reference taking (and then to get to sb from
fanotify_handle_error_event() but we can certainly get to sb by easier
means there). So I would just remove that. What we still need to know in
fanotify_free_error_event() though is whether the sb_mark is still alive or
not. If it is alive, we leave the event alone, otherwise we need to free it.
So we need a mark_alive flag in the error event and then do in ->freeing_mark
callback something like:

	if (mark->flags & FANOTIFY_MARK_FLAG_SB_MARK) {
		struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);

###		/* Maybe we could use mark->lock for this? */
		spin_lock(&group->notification_lock);
		if (fa_mark->fee_slot) {
			if (list_empty(&fa_mark->fee_slot->fae.fse.list)) {
				kfree(fa_mark->fee_slot);
				fa_mark->fee_slot = NULL;
			} else {
				fa_mark->fee_slot->mark_alive = 0;
			}
		}
		spin_unlock(&group->notification_lock);
	}

And then when queueing and dequeueing event we would have to carefully
check what is the mark & event state under appropriate lock (because
->handle_event() callbacks can see marks on the way to be destroyed as they
are protected just by SRCU).


> @@ -1009,13 +1012,37 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>  			return PTR_ERR(fsn_mark);
>  		}
>  	}
> +
> +	/*
> +	 * Error events are allocated per super-block mark only if
> +	 * strictly needed (i.e. FAN_FS_ERROR was requested).
> +	 */
> +	if (type == FSNOTIFY_OBJ_TYPE_SB && !(flags & FAN_MARK_IGNORED_MASK) &&
> +	    (mask & FAN_FS_ERROR)) {
> +		struct fanotify_sb_mark *sb_mark = FANOTIFY_SB_MARK(fsn_mark);
> +
> +		if (!sb_mark->fee_slot) {
> +			struct fanotify_error_event *fee =
> +				kzalloc(sizeof(*fee), GFP_KERNEL_ACCOUNT);

As Amir mentioned, no need for kzalloc() here.

> +			if (!fee) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +			fanotify_init_event(&fee->fae, 0, FS_ERROR);
> +			fee->sb_mark = sb_mark;
> +			sb_mark->fee_slot = fee;

Careful here. The 'sb_mark' can be already attached to sb and events can
walk it. So we should make sure these readers don't see half initialized
'fee' due to CPU reordering stores. So this needs to be protected by the
same lock that we use when generating error event.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
