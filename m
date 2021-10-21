Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAAF436B5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 21:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhJUTcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 15:32:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36556 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhJUTcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:32:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 642A321973;
        Thu, 21 Oct 2021 19:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634844587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qs8+FA8yALRVhtd6Z9xGHWLepDV6jZsU2P+lolLy0s4=;
        b=UZ5aEgPwFGZFbE9JOUz4e7W55xEqisWGjphPtf9Daa8khV8kQrRp1zovg5JYuWBA9g+0fc
        x2w3Sq+OKIbowS0U0rVUkHldxsK+CRpu/RNLhVCrEhYPSYgYtWhcMBvjR895kv73fVgRyy
        if0AvD97wggk/du+T7hRMHgMk5WssLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634844587;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qs8+FA8yALRVhtd6Z9xGHWLepDV6jZsU2P+lolLy0s4=;
        b=VJwfRjaJ727SJ97QyD6F1UVrByLQ0EsXd4pH9B4AYlRh4GKowiHDh/s+OCVqt9cpaCGYH6
        g9iGlQo2+Bh0yeAw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 47CAAA3B83;
        Thu, 21 Oct 2021 19:29:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A9F5A1F2C7E; Thu, 21 Oct 2021 21:29:44 +0200 (CEST)
Date:   Thu, 21 Oct 2021 21:29:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.com>,
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
Message-ID: <20211021192944.GB17971@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-21-krisman@collabora.com>
 <CAOQ4uxi3C7MQxGPc1fD8ZyRTkyJZQac3_M-0aGYzPKbJ6AK8Jg@mail.gmail.com>
 <20211019120316.GI3255@quack2.suse.cz>
 <871r4e1buq.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r4e1buq.fsf@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-10-21 15:17:33, Gabriel Krisman Bertazi wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > On Tue 19-10-21 08:50:23, Amir Goldstein wrote:
> >> On Tue, Oct 19, 2021 at 3:03 AM Gabriel Krisman Bertazi
> >> <krisman@collabora.com> wrote:
> >> >
> >> > Allow the FAN_FS_ERROR group mempool to grow up to an upper limit
> >> > dynamically, instead of starting already at the limit.  This doesn't
> >> > bother resizing on mark removal, but next time a mark is added, the slot
> >> > will be either reused or resized.  Also, if several marks are being
> >> > removed at once, most likely the group is going away anyway.
> >> >
> >> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >> > ---
> >> >  fs/notify/fanotify/fanotify_user.c | 26 +++++++++++++++++++++-----
> >> >  include/linux/fsnotify_backend.h   |  1 +
> >> >  2 files changed, 22 insertions(+), 5 deletions(-)
> >> >
> >> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> >> > index f77581c5b97f..a860c286e885 100644
> >> > --- a/fs/notify/fanotify/fanotify_user.c
> >> > +++ b/fs/notify/fanotify/fanotify_user.c
> >> > @@ -959,6 +959,10 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
> >> >
> >> >         removed = fanotify_mark_remove_from_mask(fsn_mark, mask, flags,
> >> >                                                  umask, &destroy_mark);
> >> > +
> >> > +       if (removed & FAN_FS_ERROR)
> >> > +               group->fanotify_data.error_event_marks--;
> >> > +
> >> >         if (removed & fsnotify_conn_mask(fsn_mark->connector))
> >> >                 fsnotify_recalc_mask(fsn_mark->connector);
> >> >         if (destroy_mark)
> >> > @@ -1057,12 +1061,24 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
> >> >
> >> >  static int fanotify_group_init_error_pool(struct fsnotify_group *group)
> >> >  {
> >> > -       if (mempool_initialized(&group->fanotify_data.error_events_pool))
> >> > -               return 0;
> >> > +       int ret;
> >> > +
> >> > +       if (group->fanotify_data.error_event_marks >=
> >> > +           FANOTIFY_DEFAULT_MAX_FEE_POOL)
> >> > +               return -ENOMEM;
> >> >
> >> > -       return mempool_init_kmalloc_pool(&group->fanotify_data.error_events_pool,
> >> > -                                        FANOTIFY_DEFAULT_MAX_FEE_POOL,
> >> > -                                        sizeof(struct fanotify_error_event));
> >> > +       if (!mempool_initialized(&group->fanotify_data.error_events_pool))
> >> > +               ret = mempool_init_kmalloc_pool(
> >> > +                               &group->fanotify_data.error_events_pool,
> >> > +                                1, sizeof(struct fanotify_error_event));
> >> > +       else
> >> > +               ret = mempool_resize(&group->fanotify_data.error_events_pool,
> >> > +                                    group->fanotify_data.error_event_marks + 1);
> >> > +
> >> > +       if (!ret)
> >> > +               group->fanotify_data.error_event_marks++;
> >> > +
> >> > +       return ret;
> >> >  }
> >> 
> >> This is not what I had in mind.
> >> I was thinking start with ~32 and double each time limit is reached.
> >
> > Do you mean when number of FS_ERROR marks reaches the number of preallocated
> > events? We could do that but note that due to mempool implementation limits
> > there cannot be more than 255 preallocated events, also mempool_resize()
> > will only update number of slots for preallocated events but these slots
> > will be empty. You have to manually allocate and free events to fill these
> > slots with preallocated events.
> >
> >> And also, this code grows the pool to infinity with add/remove mark loop.
> >
> > I see a cap at FANOTIFY_DEFAULT_MAX_FEE_POOL in the code there. But I don't
> > think there's a good enough reason to hard-limit number of FS_ERROR marks
> > at 128. As I explained in the previous version of the series, in vast
> > majority of cases we will not use even a single preallocated event...
> >
> >> Anyway, since I clearly did not understand how mempool works and
> >> Jan had some different ideas I would leave it to Jan to explain
> >> how he wants the mempool init limit and resize to be implemented.
> >
> > Honestly, I'm for keeping it simple for now. Just 32 preallocated events
> > and try to come up with something more clever only if someone actually
> > complains.
> 
> So, If I understand correctly the conclusion, you are fine if I revert to
> the version I had in v7: 32 fields pre-allocated, no dynamic growth and
> just limit the number of FAN_FS_ERROR marks to <= 32?

Yes to 32 preallocated events, no to FAN_FS_ERROR mark limit - just keep
number of marks unlimited. IMO it would be a hard to understand limit for
userspace.

> In the future, if this ever becomes a problem, we look into dynamic
> resizing/increasing the limit?

Yes.

> I think either option is fine by me.  I thought that growing 1 by 1 like
> I did here would be ugly, but before sending the patch, I checked and I
> was quite satisfied with how simple mempool_resize actually is.

Yes, mempool resize is simple, except that you have to care not to resize
to more than 255 and also for mempool_resize() to guarantee anything you
have to allocate and free events to fill slots at which point things become
a bit ugly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
