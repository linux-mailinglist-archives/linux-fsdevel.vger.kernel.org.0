Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6D83E50A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 03:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhHJBfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 21:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhHJBfs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 21:35:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EEBC0613D3;
        Mon,  9 Aug 2021 18:35:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 2E49F1F42F02
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v5 18/23] fanotify: Handle FAN_FS_ERROR events
Organization: Collabora
References: <20210804160612.3575505-1-krisman@collabora.com>
        <20210804160612.3575505-19-krisman@collabora.com>
        <20210805121516.GL14483@quack2.suse.cz>
Date:   Mon, 09 Aug 2021 21:35:20 -0400
In-Reply-To: <20210805121516.GL14483@quack2.suse.cz> (Jan Kara's message of
        "Thu, 5 Aug 2021 14:15:16 +0200")
Message-ID: <87bl66dquf.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:
>> @@ -760,6 +796,18 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>>  			return 0;
>>  	}
>>  
>> +	if (fanotify_is_error_event(mask)) {
>> +		struct fanotify_sb_mark *sb_mark =
>> +			FANOTIFY_SB_MARK(fsnotify_iter_sb_mark(iter_info));
>> +
>> +		ret = fsnotify_insert_event(group,
>> +					    &sb_mark->fee_slot->fae.fse,
>> +					    fanotify_merge_error_event,
>> +					    fanotify_insert_error_event,
>> +					    data);
>> +		goto finish;
>> +	}
>
> Hum, seeing this and how you had to extend fsnotify_add_event() to
> accommodate this use, cannot we instead have something like:
>
> 	if (fanotify_is_error_event(mask)) {
> 		struct fanotify_sb_mark *sb_mark =
> 			FANOTIFY_SB_MARK(fsnotify_iter_sb_mark(iter_info));
> 		struct fanotify_error_event *event = &sb_mark->fee_slot;
> 		bool queue = false;
>
> 		spin_lock(&group->notification_lock);
> 		/* Not yet queued? */
> 		if (!event->err_count) {
> 			fee->error = report->error;
> 			queue = true;
> 		}
> 		event->err_count++;
> 		spin_unlock(&group->notification_lock);
> 		if (queue) {
> 			... fill in other error info in 'event' such as fhandle
> 			fsnotify_add_event(group, &event->fae.fse, NULL);
> 		}
> 	}
>
> It would be IMHO simpler to follow what's going on and we don't have to
> touch fsnotify_add_event(). I do recognize that due to races it may happen
> that some racing fsnotify(FAN_FS_ERROR) call returns before the event is
> actually visible in the event queue. It don't think it really matters but
> if we wanted to be more careful, we would need to preformat fhandle into a
> local buffer and only copy it into the event under notification_lock when
> we see the event is unused.

Hi Jan,

This is actually similar to my first implementation too (like what
Amir said about the hunk below). It is a shame, cause I really like
the current version better, but the point about not doing the FH
encoding under the notification_lock makes a lot of sense.  I will
revert to the previous approach.

>> +/*
>> + * Replace a mark's error event with a new structure in preparation for
>> + * it to be dequeued.  This is a bit annoying since we need to drop the
>> + * lock, so another thread might just steal the event from us.
>> + */
>> +static int fanotify_replace_fs_error_event(struct fsnotify_group *group,
>> +					   struct fanotify_event *fae)
>> +{
>> +	struct fanotify_error_event *new, *fee = FANOTIFY_EE(fae);
>> +	struct fanotify_sb_mark *sb_mark = fee->sb_mark;
>> +	struct fsnotify_event *fse;
>> +
>> +	pr_debug("%s: event=%p\n", __func__, fae);
>> +
>> +	assert_spin_locked(&group->notification_lock);
>> +
>> +	spin_unlock(&group->notification_lock);
>> +	new = fanotify_alloc_error_event(sb_mark);
>> +	spin_lock(&group->notification_lock);
>> +
>> +	if (!new)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * Since we temporarily dropped the notification_lock, the event
>> +	 * might have been taken from under us and reported by another
>> +	 * reader.  If that is the case, don't play games, just retry.
>> +	 */
>> +	fse = fsnotify_peek_first_event(group);
>> +	if (fse != &fae->fse) {
>> +		kfree(new);
>> +		return -EAGAIN;
>> +	}
>> +
>> +	sb_mark->fee_slot = new;
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * Get an fanotify notification event if one exists and is small
>>   * enough to fit in "count". Return an error pointer if the count
>> @@ -212,9 +252,21 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
>>  		goto out;
>>  	}
>>  
>> +	if (fanotify_is_error_event(event->mask)) {
>> +		/*
>> +		 * Replace the error event ahead of dequeueing so we
>> +		 * don't need to handle a incorrectly dequeued event.
>> +		 */
>> +		ret = fanotify_replace_fs_error_event(group, event);
>> +		if (ret) {
>> +			event = ERR_PTR(ret);
>> +			goto out;
>> +		}
>> +	}
>> +
> The replacing, retry, and all is hairy. Cannot we just keep the same event
> attached to the sb mark and copy-out to on-stack buffer under
> notification_lock in get_one_event()? The event is big (due to fhandle) but
> fanotify_read() is not called from a deep call chain so we should have
> enough space on stack for that.



-- 
Gabriel Krisman Bertazi
