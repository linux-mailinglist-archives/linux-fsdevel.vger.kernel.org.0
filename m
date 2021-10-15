Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A442FA8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 19:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbhJORwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 13:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbhJORwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:52:12 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EA8C061570;
        Fri, 15 Oct 2021 10:50:05 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y17so7983839ilb.9;
        Fri, 15 Oct 2021 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8OVo/q2M/eo6jYyxOymFITXCWpgSOR7Fi9RX8ZDSCQ=;
        b=DJ1sk2gGlDWB2tTltEB7zC+lsOFWCgzmvUAZTSKtZuZCjHsXHBOLug2T9AGz+watrn
         aTbsx5Yeq9INmRckY2X03bN2018otdF2iH8lkpGdN0+j1U8DbbZs1TNW5WDL7TIvgEM2
         rgipKChjHaKBsAlLOW0UGD6gUKfzTEVsJc2jNuBREK9DIOW1IOC7AyDDUstpd6IinTr3
         yc0YNCWXXYW0PiqC+VMvOH2s73CccNzoZedSHx9yrgDjzLTtuNTWLaKZVBLduFkeMjqE
         MpTzxnlEC4jsgP5JTcWAFn8P9jGwzGotIhST43wvZBY9BL8RruruYpWVaEOxsPW5jmX3
         Wt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8OVo/q2M/eo6jYyxOymFITXCWpgSOR7Fi9RX8ZDSCQ=;
        b=5W/5eMXAOA7W5uhJmnIkwmbGp66ApztD2Xn9GoM5uFsUtgvm7Kttii3q12zUOY9aZz
         bXntcrcXghkEIU2Mi8heTlEJkdMQYM7WNW5wB4pmCb8Yact2RA2SIXiDych9Gfqbe1cD
         759MxCnazNef2GtrJq2EX08LfhlTR7QzS0IjMo/UCdYVjkhwLBKgVgNznQl4YmOGhBAZ
         oEukuwI2i5ZzfL/ICOsfU6LumKa7jyM2IAyo2eY47HOzn+mX1EPCStNX5N/3K6/K5Ow2
         7Nt4TaV1qjp1qVsIIOFFTJkJ3sq8aXwET8KEFdwjPvol+Kz3ej06r7pJAWdR/DkMKgQh
         cdwg==
X-Gm-Message-State: AOAM5302ThEV3wvKckBrRFxle5azFWnVR+y+Ju1fIhCK90mWIR7SHyOJ
        nPSQm0Hcpy7yLOdr0Gmej1RSxqSv3NU2b2Dr1iQ=
X-Google-Smtp-Source: ABdhPJyWh1mF51Ml0+m1b6WTUNjQed43Zu1JcMbrGV6HxOIdo/dw1qFd7L8rDBwOeBGYOOKWv9yibKxWMheKbn11nVE=
X-Received: by 2002:a05:6e02:1be8:: with SMTP id y8mr4814921ilv.24.1634320205195;
 Fri, 15 Oct 2021 10:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-20-krisman@collabora.com> <CAOQ4uxjhTu+fPwZfjGtzcoj3-RLxBSh8ozyLjWzcTC0YJAwnwA@mail.gmail.com>
 <87tuhip6v7.fsf@collabora.com>
In-Reply-To: <87tuhip6v7.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 20:49:54 +0300
Message-ID: <CAOQ4uxiUrMrLYJC+ogHVJXzO4-v_LceuDoe4mmU1sSM5SMx6jg@mail.gmail.com>
Subject: Re: [PATCH v7 19/28] fanotify: Limit number of marks with
 FAN_FS_ERROR per group
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 7:53 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Fri, Oct 15, 2021 at 12:39 AM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> >>
> >> Since FAN_FS_ERROR memory must be pre-allocated, limit a single group
> >> from watching too many file systems at once.  The current scheme
> >> guarantees 1 slot per filesystem, so limit the number of marks with
> >> FAN_FS_ERROR per group.
> >>
> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >> ---
> >>  fs/notify/fanotify/fanotify_user.c | 10 ++++++++++
> >>  include/linux/fsnotify_backend.h   |  1 +
> >>  2 files changed, 11 insertions(+)
> >>
> >> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> >> index f1cf863d6f9f..5324890500fc 100644
> >> --- a/fs/notify/fanotify/fanotify_user.c
> >> +++ b/fs/notify/fanotify/fanotify_user.c
> >> @@ -959,6 +959,10 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
> >>
> >>         removed = fanotify_mark_remove_from_mask(fsn_mark, mask, flags,
> >>                                                  umask, &destroy_mark);
> >> +
> >> +       if (removed & FAN_FS_ERROR)
> >> +               group->fanotify_data.error_event_marks--;
> >> +
> >>         if (removed & fsnotify_conn_mask(fsn_mark->connector))
> >>                 fsnotify_recalc_mask(fsn_mark->connector);
> >>         if (destroy_mark)
> >> @@ -1057,6 +1061,9 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
> >>
> >>  static int fanotify_group_init_error_pool(struct fsnotify_group *group)
> >>  {
> >> +       if (group->fanotify_data.error_event_marks >= FANOTIFY_DEFAULT_FEE_POOL)
> >> +               return -ENOMEM;
> >
> > Why not try to mempool_resize()?
>
> Jan suggested we might not need to bother with it, but I can do that for
> the next version.
>
> > Also, I did not read the rest of the patches yet, but don't we need two
> > slots per mark? one for alloc-pre-enqueue and one for free-post-dequeue?
>
> I don't understand what you mean by two slots for alloc-pre-enqueue and
> free-post-dequeue.  I suspect it is no longer necessary now that
> FAN_FS_ERROR is handled like any other event on enqueue/dequeue, but can
> you confirm or clarify?
>

What I meant was, your code is counting error_event_marks.
Every mark accounts for either 1 or 0 queued events, because more
errors from the same fs would merge with the single queued event.

I thought we could have one more event per fs being copied to user
but really we could potentially have many events allocated, before
being "merged", so my calculation was wrong.

Anyway, as Jan explained, the limited size of mempool does not doom
allocations to fail, so we probably have nothing to worry about and
there is no need to mempool_resize().

Thanks,
Amir.
