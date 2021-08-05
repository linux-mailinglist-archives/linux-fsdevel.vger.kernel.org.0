Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72B03E160E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 15:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbhHENvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 09:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhHENvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:51:08 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8297C061765;
        Thu,  5 Aug 2021 06:50:51 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id i9so5158953ilk.9;
        Thu, 05 Aug 2021 06:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtNSBN5S70m218P0btiIuzg+F+pRLQ2zqLYdMPWPN08=;
        b=Yde5ios7YBlLJ/EGBP5zUOFZBxDulkk7LxGpglRskBi9ista4YyCttQdZjSbszy9nK
         9hU9ZO5iRqIkHjSpI39fqrbooa73mZjjD99kx48mV1sBtMKtrkLqa6M2bkhlDn8+TXky
         3XQPXvUw267mM2iw413fJj3xHQQD5bBVI1b2Ft2rrV4WwUHdkz5EgaKP0Wuh40ttliuT
         P+DLKY+E8/jECtr3sI+ynH8KaoEw6XC8X4+QfGbf2V/Ey1RA8ou9ytdMBy2LAvfOYdkJ
         9SaGxlsRFZWufdzMCSEpd+7WBF0R1XR3A6PEhxdfRMWtlVjuS7Pwg4MKnpl9Pcq9myo4
         tgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtNSBN5S70m218P0btiIuzg+F+pRLQ2zqLYdMPWPN08=;
        b=Pzj150mZfRw8iRnpii+XZplZvQxZspoEN/CRdGqE+VBZx2Y2aj2rtvd28LwVdEINvb
         e+Do/l0s5E6GXlnSkfAfPZW2cQOhsKHOOVVq4jx4h8PzI8iOG9cZ1oFBLh58uSEBEPle
         48uINebgkYiFbAAOZKqmM7CXwPInbxZ9/uHGq5no1tkWppmRy14J970Iikz4ZVSim2Te
         IIAx4rIEwaA8nPvXUK8nVbnzig8G52ctBTPAD/LRV4Gb4SpyssAbNUs1F5f/k96hjFXf
         5dLN+LwGXAFJ8v7pCNsZsfIW5ObuezAQijjZLKz9Xm8WcgwhHMPxF2y/apzUGX/LLsIM
         CTcg==
X-Gm-Message-State: AOAM531Sg0EOmsS5OJWEYq9oKyWKs9KAhIx7Gj98ynMorf1T1EEFnymW
        XsgB8IdxTiHSo15hh0MT1k41caqcjj5gILhYpVE=
X-Google-Smtp-Source: ABdhPJxp8f75BLbLvqFbFQJ/JmFdkB9hqGULGoc/5+oj3EQ9sSx2nkWrgFRBF4u3GB4GNUD5AWtAXZAzTzgYpEzuTyk=
X-Received: by 2002:a05:6e02:1bcc:: with SMTP id x12mr889079ilv.275.1628171451242;
 Thu, 05 Aug 2021 06:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-19-krisman@collabora.com> <20210805121516.GL14483@quack2.suse.cz>
In-Reply-To: <20210805121516.GL14483@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 Aug 2021 16:50:40 +0300
Message-ID: <CAOQ4uxicopjm1LffaYrPa_d4AQROOgi5GDPHtbrJQ-Oh=yi8hQ@mail.gmail.com>
Subject: Re: [PATCH v5 18/23] fanotify: Handle FAN_FS_ERROR events
To:     Jan Kara <jack@suse.cz>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 5, 2021 at 3:15 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 04-08-21 12:06:07, Gabriel Krisman Bertazi wrote:
> > Wire up FAN_FS_ERROR in the fanotify_mark syscall.  The event can only
> > be requested for the entire filesystem, thus it requires the
> > FAN_MARK_FILESYSTEM.
> >
> > FAN_FS_ERROR has to be handled slightly differently from other events
> > because it needs to be submitted in an atomic context, using
> > preallocated memory.  This patch implements the submission path by only
> > storing the first error event that happened in the slot (userspace
> > resets the slot by reading the event).
> >
> > Extra error events happening when the slot is occupied are merged to the
> > original report, and the only information keep for these extra errors is
> > an accumulator counting the number of events, which is part of the
> > record reported back to userspace.
> >
> > Reporting only the first event should be fine, since when a FS error
> > happens, a cascade of error usually follows, but the most meaningful
> > information is (usually) on the first erro.
> >
> > The event dequeueing is also a bit special to avoid losing events. Since
> > event merging only happens while the event is queued, there is a window
> > between when an error event is dequeued (notification_lock is dropped)
> > until it is reset (.free_event()) where the slot is full, but no merges
> > can happen.
> >
> > The proposed solution is to replace the event in the slot with a new
> > structure, prior to dropping the lock.  This way, if a new event arrives
> > in the time between the event was dequeued and the time it resets, the
> > new errors will still be logged and merged in the new slot.
> >
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> The splitting of the patches really helped. Now I think I can grok much
> more details than before :) Thanks! Some comments below.
>
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 0678d35432a7..4e9e271a4394 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -681,6 +681,42 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
> >       return fsid;
> >  }
> >
> > +static int fanotify_merge_error_event(struct fsnotify_group *group,
> > +                                   struct fsnotify_event *event)
> > +{
> > +     struct fanotify_event *fae = FANOTIFY_E(event);
> > +     struct fanotify_error_event *fee = FANOTIFY_EE(fae);
> > +
> > +     /*
> > +      * When err_count > 0, the reporting slot is full.  Just account
> > +      * the additional error and abort the insertion.
> > +      */
> > +     if (fee->err_count) {
> > +             fee->err_count++;
> > +             return 1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void fanotify_insert_error_event(struct fsnotify_group *group,
> > +                                     struct fsnotify_event *event,
> > +                                     const void *data)
> > +{
> > +     const struct fs_error_report *report = (struct fs_error_report *) data;
> > +     struct fanotify_event *fae = FANOTIFY_E(event);
> > +     struct fanotify_error_event *fee;
> > +
> > +     /* This might be an unexpected type of event (i.e. overflow). */
> > +     if (!fanotify_is_error_event(fae->mask))
> > +             return;
> > +
> > +     fee = FANOTIFY_EE(fae);
> > +     fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> > +     fee->error = report->error;
> > +     fee->err_count = 1;
> > +}
> > +
> >  /*
> >   * Add an event to hash table for faster merge.
> >   */
> > @@ -735,7 +771,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
> >       BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
> >       BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
> >
> > -     BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
> > +     BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
> >
> >       mask = fanotify_group_event_mask(group, iter_info, mask, data,
> >                                        data_type, dir);
> > @@ -760,6 +796,18 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
> >                       return 0;
> >       }
> >
> > +     if (fanotify_is_error_event(mask)) {
> > +             struct fanotify_sb_mark *sb_mark =
> > +                     FANOTIFY_SB_MARK(fsnotify_iter_sb_mark(iter_info));
> > +
> > +             ret = fsnotify_insert_event(group,
> > +                                         &sb_mark->fee_slot->fae.fse,
> > +                                         fanotify_merge_error_event,
> > +                                         fanotify_insert_error_event,
> > +                                         data);
> > +             goto finish;
> > +     }
>
> Hum, seeing this and how you had to extend fsnotify_add_event() to
> accommodate this use, cannot we instead have something like:
>
>         if (fanotify_is_error_event(mask)) {
>                 struct fanotify_sb_mark *sb_mark =
>                         FANOTIFY_SB_MARK(fsnotify_iter_sb_mark(iter_info));
>                 struct fanotify_error_event *event = &sb_mark->fee_slot;
>                 bool queue = false;
>
>                 spin_lock(&group->notification_lock);
>                 /* Not yet queued? */
>                 if (!event->err_count) {
>                         fee->error = report->error;
>                         queue = true;
>                 }
>                 event->err_count++;
>                 spin_unlock(&group->notification_lock);
>                 if (queue) {
>                         ... fill in other error info in 'event' such as fhandle
>                         fsnotify_add_event(group, &event->fae.fse, NULL);
>                 }
>         }
>
> It would be IMHO simpler to follow what's going on and we don't have to
> touch fsnotify_add_event(). I do recognize that due to races it may happen
> that some racing fsnotify(FAN_FS_ERROR) call returns before the event is
> actually visible in the event queue. It don't think it really matters but
> if we wanted to be more careful, we would need to preformat fhandle into a
> local buffer and only copy it into the event under notification_lock when
> we see the event is unused.
>
> > +/*
> > + * Replace a mark's error event with a new structure in preparation for
> > + * it to be dequeued.  This is a bit annoying since we need to drop the
> > + * lock, so another thread might just steal the event from us.
> > + */
> > +static int fanotify_replace_fs_error_event(struct fsnotify_group *group,
> > +                                        struct fanotify_event *fae)
> > +{
> > +     struct fanotify_error_event *new, *fee = FANOTIFY_EE(fae);
> > +     struct fanotify_sb_mark *sb_mark = fee->sb_mark;
> > +     struct fsnotify_event *fse;
> > +
> > +     pr_debug("%s: event=%p\n", __func__, fae);
> > +
> > +     assert_spin_locked(&group->notification_lock);
> > +
> > +     spin_unlock(&group->notification_lock);
> > +     new = fanotify_alloc_error_event(sb_mark);
> > +     spin_lock(&group->notification_lock);
> > +
> > +     if (!new)
> > +             return -ENOMEM;
> > +
> > +     /*
> > +      * Since we temporarily dropped the notification_lock, the event
> > +      * might have been taken from under us and reported by another
> > +      * reader.  If that is the case, don't play games, just retry.
> > +      */
> > +     fse = fsnotify_peek_first_event(group);
> > +     if (fse != &fae->fse) {
> > +             kfree(new);
> > +             return -EAGAIN;
> > +     }
> > +
> > +     sb_mark->fee_slot = new;
> > +
> > +     return 0;
> > +}
> > +
> >  /*
> >   * Get an fanotify notification event if one exists and is small
> >   * enough to fit in "count". Return an error pointer if the count
> > @@ -212,9 +252,21 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
> >               goto out;
> >       }
> >
> > +     if (fanotify_is_error_event(event->mask)) {
> > +             /*
> > +              * Replace the error event ahead of dequeueing so we
> > +              * don't need to handle a incorrectly dequeued event.
> > +              */
> > +             ret = fanotify_replace_fs_error_event(group, event);
> > +             if (ret) {
> > +                     event = ERR_PTR(ret);
> > +                     goto out;
> > +             }
> > +     }
> > +
>
> The replacing, retry, and all is hairy. Cannot we just keep the same event
> attached to the sb mark and copy-out to on-stack buffer under
> notification_lock in get_one_event()? The event is big (due to fhandle) but
> fanotify_read() is not called from a deep call chain so we should have
> enough space on stack for that.
>

For the record, this was one of the first implementations from Gabriel.
When I proposed the double buffer implementation it was either that
or go back to copy to stack.

Given the complications, I agree that going back to copy to stack
is preferred.

Thanks,
Amir.
