Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2B8436A61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 20:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhJUST4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 14:19:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47330 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUST4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:19:56 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 707911F44DA7;
        Thu, 21 Oct 2021 19:17:38 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v8 20/32] fanotify: Dynamically resize the FAN_FS_ERROR
 pool
Organization: Collabora
References: <20211019000015.1666608-1-krisman@collabora.com>
        <20211019000015.1666608-21-krisman@collabora.com>
        <CAOQ4uxi3C7MQxGPc1fD8ZyRTkyJZQac3_M-0aGYzPKbJ6AK8Jg@mail.gmail.com>
        <20211019120316.GI3255@quack2.suse.cz>
Date:   Thu, 21 Oct 2021 15:17:33 -0300
In-Reply-To: <20211019120316.GI3255@quack2.suse.cz> (Jan Kara's message of
        "Tue, 19 Oct 2021 14:03:16 +0200")
Message-ID: <871r4e1buq.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Tue 19-10-21 08:50:23, Amir Goldstein wrote:
>> On Tue, Oct 19, 2021 at 3:03 AM Gabriel Krisman Bertazi
>> <krisman@collabora.com> wrote:
>> >
>> > Allow the FAN_FS_ERROR group mempool to grow up to an upper limit
>> > dynamically, instead of starting already at the limit.  This doesn't
>> > bother resizing on mark removal, but next time a mark is added, the slot
>> > will be either reused or resized.  Also, if several marks are being
>> > removed at once, most likely the group is going away anyway.
>> >
>> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> > ---
>> >  fs/notify/fanotify/fanotify_user.c | 26 +++++++++++++++++++++-----
>> >  include/linux/fsnotify_backend.h   |  1 +
>> >  2 files changed, 22 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
>> > index f77581c5b97f..a860c286e885 100644
>> > --- a/fs/notify/fanotify/fanotify_user.c
>> > +++ b/fs/notify/fanotify/fanotify_user.c
>> > @@ -959,6 +959,10 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
>> >
>> >         removed = fanotify_mark_remove_from_mask(fsn_mark, mask, flags,
>> >                                                  umask, &destroy_mark);
>> > +
>> > +       if (removed & FAN_FS_ERROR)
>> > +               group->fanotify_data.error_event_marks--;
>> > +
>> >         if (removed & fsnotify_conn_mask(fsn_mark->connector))
>> >                 fsnotify_recalc_mask(fsn_mark->connector);
>> >         if (destroy_mark)
>> > @@ -1057,12 +1061,24 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>> >
>> >  static int fanotify_group_init_error_pool(struct fsnotify_group *group)
>> >  {
>> > -       if (mempool_initialized(&group->fanotify_data.error_events_pool))
>> > -               return 0;
>> > +       int ret;
>> > +
>> > +       if (group->fanotify_data.error_event_marks >=
>> > +           FANOTIFY_DEFAULT_MAX_FEE_POOL)
>> > +               return -ENOMEM;
>> >
>> > -       return mempool_init_kmalloc_pool(&group->fanotify_data.error_events_pool,
>> > -                                        FANOTIFY_DEFAULT_MAX_FEE_POOL,
>> > -                                        sizeof(struct fanotify_error_event));
>> > +       if (!mempool_initialized(&group->fanotify_data.error_events_pool))
>> > +               ret = mempool_init_kmalloc_pool(
>> > +                               &group->fanotify_data.error_events_pool,
>> > +                                1, sizeof(struct fanotify_error_event));
>> > +       else
>> > +               ret = mempool_resize(&group->fanotify_data.error_events_pool,
>> > +                                    group->fanotify_data.error_event_marks + 1);
>> > +
>> > +       if (!ret)
>> > +               group->fanotify_data.error_event_marks++;
>> > +
>> > +       return ret;
>> >  }
>> 
>> This is not what I had in mind.
>> I was thinking start with ~32 and double each time limit is reached.
>
> Do you mean when number of FS_ERROR marks reaches the number of preallocated
> events? We could do that but note that due to mempool implementation limits
> there cannot be more than 255 preallocated events, also mempool_resize()
> will only update number of slots for preallocated events but these slots
> will be empty. You have to manually allocate and free events to fill these
> slots with preallocated events.
>
>> And also, this code grows the pool to infinity with add/remove mark loop.
>
> I see a cap at FANOTIFY_DEFAULT_MAX_FEE_POOL in the code there. But I don't
> think there's a good enough reason to hard-limit number of FS_ERROR marks
> at 128. As I explained in the previous version of the series, in vast
> majority of cases we will not use even a single preallocated event...
>
>> Anyway, since I clearly did not understand how mempool works and
>> Jan had some different ideas I would leave it to Jan to explain
>> how he wants the mempool init limit and resize to be implemented.
>
> Honestly, I'm for keeping it simple for now. Just 32 preallocated events
> and try to come up with something more clever only if someone actually
> complains.

So, If I understand correctly the conclusion, you are fine if I revert to
the version I had in v7: 32 fields pre-allocated, no dynamic growth and
just limit the number of FAN_FS_ERROR marks to <= 32?  In the future, if
this ever becomes a problem, we look into dynamic resizing/increasing
the limit?

I think either option is fine by me.  I thought that growing 1 by 1 like
I did here would be ugly, but before sending the patch, I checked and I
was quite satisfied with how simple mempool_resize actually is.

-- 
Gabriel Krisman Bertazi
