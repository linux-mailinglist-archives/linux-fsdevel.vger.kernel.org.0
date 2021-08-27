Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404B03F9EA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 20:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhH0STI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 14:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhH0STH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:19:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A732AC061757;
        Fri, 27 Aug 2021 11:18:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 09B781F447AF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jan Kara <jack@suse.cz>
Cc:     amir73il@gmail.com, jack@suse.com, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        khazhy@google.com, dhowells@redhat.com, david@fromorbit.com,
        tytso@mit.edu, djwong@kernel.org, repnop@google.com,
        kernel@collabora.com
Subject: Re: [PATCH v6 15/21] fanotify: Preallocate per superblock mark
 error event
Organization: Collabora
References: <20210812214010.3197279-1-krisman@collabora.com>
        <20210812214010.3197279-16-krisman@collabora.com>
        <20210816155758.GF30215@quack2.suse.cz>
Date:   Fri, 27 Aug 2021 14:18:12 -0400
In-Reply-To: <20210816155758.GF30215@quack2.suse.cz> (Jan Kara's message of
        "Mon, 16 Aug 2021 17:57:58 +0200")
Message-ID: <877dg6rbtn.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Thu 12-08-21 17:40:04, Gabriel Krisman Bertazi wrote:
>> Error reporting needs to be done in an atomic context.  This patch
>> introduces a single error slot for superblock marks that report the
>> FAN_FS_ERROR event, to be used during event submission.
>> 
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> 
>> ---
>> Changes v5:
>>   - Restore mark references. (jan)
>>   - Tie fee slot to the mark lifetime.(jan)
>>   - Don't reallocate event(jan)
>> ---
>>  fs/notify/fanotify/fanotify.c      | 12 ++++++++++++
>>  fs/notify/fanotify/fanotify.h      | 13 +++++++++++++
>>  fs/notify/fanotify/fanotify_user.c | 31 ++++++++++++++++++++++++++++--
>>  3 files changed, 54 insertions(+), 2 deletions(-)
>> 
>> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
>> index ebb6c557cea1..3bf6fd85c634 100644
>> --- a/fs/notify/fanotify/fanotify.c
>> +++ b/fs/notify/fanotify/fanotify.c
>> @@ -855,6 +855,14 @@ static void fanotify_free_name_event(struct fanotify_event *event)
>>  	kfree(FANOTIFY_NE(event));
>>  }
>>  
>> +static void fanotify_free_error_event(struct fanotify_event *event)
>> +{
>> +	/*
>> +	 * The actual event is tied to a mark, and is released on mark
>> +	 * removal
>> +	 */
>> +}
>> +
>
> I was pondering about the lifetime rules some more. This is also related to
> patch 16/21 but I'll comment here. When we hold mark ref from queued event,
> we introduce a subtle race into group destruction logic. There we first
> evict all marks, wait for them to be destroyed by worker thread after SRCU
> period expires, and then we remove queued events. When we hold mark
> reference from an event we break this as mark will exist until the event is
> dequeued and then group can get freed before we actually free the mark and
> so mark freeing can hit use-after-free issues.
>
> So we'll have to do this a bit differently. I have two options:
>
> 1) Instead of preallocating events explicitely like this, we could setup a
> mempool to allocate error events from for each notification group. We would
> resize the mempool when adding error mark so that it has as many reserved
> events as error marks. Upside is error events will be much less special -
> no special lifetime rules. We'd just need to setup & resize the mempool. We
> would also have to provide proper merge function for error events (to merge
> events from the same sb). Also there will be limitation of number of error
> marks per group because mempools use kmalloc() for an array tracking
> reserved events. But we could certainly manage 512, likely 1024 error marks
> per notification group.
>
> 2) We would keep attaching event to mark as currently. As far as I have
> checked the event doesn't actually need a back-ref to sb_mark. It is
> really only used for mark reference taking (and then to get to sb from
> fanotify_handle_error_event() but we can certainly get to sb by easier
> means there). So I would just remove that. What we still need to know in
> fanotify_free_error_event() though is whether the sb_mark is still alive or
> not. If it is alive, we leave the event alone, otherwise we need to free it.
> So we need a mark_alive flag in the error event and then do in ->freeing_mark
> callback something like:
>
> 	if (mark->flags & FANOTIFY_MARK_FLAG_SB_MARK) {
> 		struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
>
> ###		/* Maybe we could use mark->lock for this? */
> 		spin_lock(&group->notification_lock);
> 		if (fa_mark->fee_slot) {
> 			if (list_empty(&fa_mark->fee_slot->fae.fse.list)) {
> 				kfree(fa_mark->fee_slot);
> 				fa_mark->fee_slot = NULL;
> 			} else {
> 				fa_mark->fee_slot->mark_alive = 0;
> 			}
> 		}
> 		spin_unlock(&group->notification_lock);
> 	}
>
> And then when queueing and dequeueing event we would have to carefully
> check what is the mark & event state under appropriate lock (because
> ->handle_event() callbacks can see marks on the way to be destroyed as they
> are protected just by SRCU).

Thanks for the review.  That is indeed a subtle race that I hadn't
noticed.

Option 2 is much more straightforward.  And considering the uABI won't
be changed if we decide to change to option 1 later, I gave that a try
and should be able to prepare a new version that leaves the error event
with a weak association to the mark, without the back reference, and
allowing it to be deleted by the latest between dequeue and
->freeing_mark, as you suggested.

-- 
Gabriel Krisman Bertazi
