Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAC13FF947
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 06:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhICERo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 00:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhICERo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 00:17:44 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D763C061575;
        Thu,  2 Sep 2021 21:16:45 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id m11so5276471ioo.6;
        Thu, 02 Sep 2021 21:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0guQT0U37UbQ5Iw8Wrxkb6O6gDW4AD2C77si9uBEwk=;
        b=PrOoVR1y8p3j7eNRwUHH0Y65YIGFq52torMLiwySZcQxEqtB3fzUYbyrLgftqx3j4O
         Nd9yz+2bjWcTydAH3593m3auC6mXcjpxCaAjZXq6yaKWO20nVk9XsDKoM9w46y5BkFfD
         SLUSbvchj3ePE93yDZqbm5F9DJ6vylOyabtbMgfaxeENz18OooxGI7nZE+FvYpIRxtV0
         dV7oaoTbvPoQLpBZ5hV+XcYI4ALtV7f2NCgJ9DoN9d52JBHQPwU/sr4gidYewddaErCR
         wN4nGbtzT3y9CnzUCD7SBTHxzrv0VohpdyQ+WnhgmdnA02pCcnbI2od1EohQn5PbQXC7
         BsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0guQT0U37UbQ5Iw8Wrxkb6O6gDW4AD2C77si9uBEwk=;
        b=ENlBHTkUDFrkgy8nZkc3X+DazBXXCKAszgeNoth8pZbelrl7pdLpJneB2dX4NBckUB
         CF8edQz3DtN+8E+mnURdAZ+Tw4lRB21Xv+ERVl+dcEefST4lha8p2xpWan4lhgDGJ2KP
         RkpgGayKjQlhIhmJTsewWdc89YwtSwIL2Eduf0tPxwxV3dnnU9kQ+5x/g86NW9sSGr4j
         6q8mAnJTK3nkSmSxzMIMGU0mbkxOROSmxznlcrWAb7khI0W4Bb0ocuEQeobycKJonkKv
         DsCOx7HkSJtzfOPYt2uxaTeVQAPn2swcbtJL2VeADgNfON1qnhsJEOjsFctWUX0QB3nK
         tfqQ==
X-Gm-Message-State: AOAM532OrFzMO/mK2kX7j8RhukRRH9zDyFeC408/fXntQefnY8+AK33H
        YAQDjIvE3gwWMmmrxHYoouApE5ayCk00dTLJ6HaCl5da
X-Google-Smtp-Source: ABdhPJydAQTqUUywodkFdb7WUUexERBk+tz7jiLRdDZq+5G2uYF602RQYxTPC/x1nzoUArNEHHpcaV54VKIdAnAOGZI=
X-Received: by 2002:a05:6602:200f:: with SMTP id y15mr1433093iod.64.1630642604562;
 Thu, 02 Sep 2021 21:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-16-krisman@collabora.com> <20210816155758.GF30215@quack2.suse.cz>
 <877dg6rbtn.fsf@collabora.com> <87a6kusmar.fsf@collabora.com>
In-Reply-To: <87a6kusmar.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 3 Sep 2021 07:16:33 +0300
Message-ID: <CAOQ4uxjDtA45nn4iT9LFbbavuGa=vMPQJFp7GOJHdqrst8y+1A@mail.gmail.com>
Subject: Re: [PATCH v6 15/21] fanotify: Preallocate per superblock mark error event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 3, 2021 at 12:24 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Gabriel Krisman Bertazi <krisman@collabora.com> writes:
>
> > Jan Kara <jack@suse.cz> writes:
> >
> >> On Thu 12-08-21 17:40:04, Gabriel Krisman Bertazi wrote:
> >>> Error reporting needs to be done in an atomic context.  This patch
> >>> introduces a single error slot for superblock marks that report the
> >>> FAN_FS_ERROR event, to be used during event submission.
> >>>
> >>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >>>
> >>> ---
> >>> Changes v5:
> >>>   - Restore mark references. (jan)
> >>>   - Tie fee slot to the mark lifetime.(jan)
> >>>   - Don't reallocate event(jan)
> >>> ---
> >>>  fs/notify/fanotify/fanotify.c      | 12 ++++++++++++
> >>>  fs/notify/fanotify/fanotify.h      | 13 +++++++++++++
> >>>  fs/notify/fanotify/fanotify_user.c | 31 ++++++++++++++++++++++++++++--
> >>>  3 files changed, 54 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> >>> index ebb6c557cea1..3bf6fd85c634 100644
> >>> --- a/fs/notify/fanotify/fanotify.c
> >>> +++ b/fs/notify/fanotify/fanotify.c
> >>> @@ -855,6 +855,14 @@ static void fanotify_free_name_event(struct fanotify_event *event)
> >>>     kfree(FANOTIFY_NE(event));
> >>>  }
> >>>
> >>> +static void fanotify_free_error_event(struct fanotify_event *event)
> >>> +{
> >>> +   /*
> >>> +    * The actual event is tied to a mark, and is released on mark
> >>> +    * removal
> >>> +    */
> >>> +}
> >>> +
> >>
> >> I was pondering about the lifetime rules some more. This is also related to
> >> patch 16/21 but I'll comment here. When we hold mark ref from queued event,
> >> we introduce a subtle race into group destruction logic. There we first
> >> evict all marks, wait for them to be destroyed by worker thread after SRCU
> >> period expires, and then we remove queued events. When we hold mark
> >> reference from an event we break this as mark will exist until the event is
> >> dequeued and then group can get freed before we actually free the mark and
> >> so mark freeing can hit use-after-free issues.
> >>
> >> So we'll have to do this a bit differently. I have two options:
> >>
> >> 1) Instead of preallocating events explicitely like this, we could setup a
> >> mempool to allocate error events from for each notification group. We would
> >> resize the mempool when adding error mark so that it has as many reserved
> >> events as error marks. Upside is error events will be much less special -
> >> no special lifetime rules. We'd just need to setup & resize the mempool. We
> >> would also have to provide proper merge function for error events (to merge
> >> events from the same sb). Also there will be limitation of number of error
> >> marks per group because mempools use kmalloc() for an array tracking
> >> reserved events. But we could certainly manage 512, likely 1024 error marks
> >> per notification group.
> >>
> >> 2) We would keep attaching event to mark as currently. As far as I have
> >> checked the event doesn't actually need a back-ref to sb_mark. It is
> >> really only used for mark reference taking (and then to get to sb from
> >> fanotify_handle_error_event() but we can certainly get to sb by easier
> >> means there). So I would just remove that. What we still need to know in
> >> fanotify_free_error_event() though is whether the sb_mark is still alive or
> >> not. If it is alive, we leave the event alone, otherwise we need to free it.
> >> So we need a mark_alive flag in the error event and then do in ->freeing_mark
> >> callback something like:
> >>
> >>      if (mark->flags & FANOTIFY_MARK_FLAG_SB_MARK) {
> >>              struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
> >>
> >> ###          /* Maybe we could use mark->lock for this? */
> >>              spin_lock(&group->notification_lock);
> >>              if (fa_mark->fee_slot) {
> >>                      if (list_empty(&fa_mark->fee_slot->fae.fse.list)) {
> >>                              kfree(fa_mark->fee_slot);
> >>                              fa_mark->fee_slot = NULL;
> >>                      } else {
> >>                              fa_mark->fee_slot->mark_alive = 0;
> >>                      }
> >>              }
> >>              spin_unlock(&group->notification_lock);
> >>      }
> >>
> >> And then when queueing and dequeueing event we would have to carefully

"would have to carefully..." oh oh! there are not words that I like to
read unless
I have to.
I think that fs error events are rare enough case and not performance sensitive
at all, so we should strive to KISS design principle in this case.

> >> check what is the mark & event state under appropriate lock (because
> >> ->handle_event() callbacks can see marks on the way to be destroyed as they
> >> are protected just by SRCU).
> >
> > Thanks for the review.  That is indeed a subtle race that I hadn't
> > noticed.
> >
> > Option 2 is much more straightforward.  And considering the uABI won't
> > be changed if we decide to change to option 1 later, I gave that a try
> > and should be able to prepare a new version that leaves the error event
> > with a weak association to the mark, without the back reference, and
> > allowing it to be deleted by the latest between dequeue and
> > ->freeing_mark, as you suggested.
>
> Actually, I don't think this will work for insertion unless we keep a
> bounce buffer for the file_handle, because we need to keep the
> group->notification_lock to ensure the fee doesn't go away with the mark
> (since it is not yet enqueued) but, as discussed before, we don't want
> to hold that lock when generating the FH.
>
> I think the correct way is to have some sort of refcount of the error
> event slot.  We could use err_count for that and change the suggestion
> above to:
>
> if (mark->flags & FANOTIFY_MARK_FLAG_SB_MARK) {
>         struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
>
>         spin_lock(&group->notification_lock);
>         if (fa_mark->fee_slot) {
>                 if (!fee->err_count) {
>                         kfree(fa_mark->fee_slot);
>                         fa_mark->fee_slot = NULL;
>                 } else {
>                         fa_mark->fee_slot->mark_alive = 0;
>                 }
>         }
>         spin_unlock(&group->notification_lock);
> }
>
> And insertion would look like this:
>
> static int fanotify_handle_error_event(....) {
>
>         spin_lock(&group->notification_lock);
>
>         if (!mark->fee || (mark->fee->err_count++) {
>                 spin_unlock(&group->notification_lock);
>                 return 0;
>         }
>
>         spin_unlock(&group->notification_lock);
>
>         mark->fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
>
>         /* ... Write report data to error event ... */
>
>         fanotify_encode_fh(&fee->object_fh, fanotify_encode_fh_len(inode),
>                            NULL, 0);
>
>         fsnotify_add_event(group, &fee->fae.fse, NULL);
>    }
>
> Unless you think this is too hack-ish.
>
> To be fair, I think it is hack-ish.

Actually, I wouldn't mind the hack-ish-ness if it would simplify things,
but I do not see how this is the case here.
I still cannot wrap my head around the semantics, which is a big red light.
First of all a suggestion should start with the lifetime rules:
- Possible states
- State transition rules

Speaking for myself, I simply cannot review a proposal without these
documented rules.

> I would add a proper refcount_t
> to the error event, and let the mark own a reference to it, which is
> dropped when the mark goes away.  Enqueue and Dequeue will acquire and
> drop references, respectively. In this case, err_count is not
> overloaded.
>
> Will it work?

Maybe, I still don't see the full picture, but if this can get us to a state
where error events handling is simpler then it's a good idea.
Saving the space of refcount_t in error event struct is not important at all.

But if Jan's option #1 (mempool) brings us to less special casing
of enqueue/dequeue of error events, then I think that would be
my preference.

In any case, I suggest to wait for Jan's inputs before you continue.

Thanks,
Amir.
