Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0513B7C2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 05:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhF3DpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 23:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhF3DpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 23:45:11 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1369BC061760;
        Tue, 29 Jun 2021 20:42:43 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a6so1546292ioe.0;
        Tue, 29 Jun 2021 20:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5mJh0GuM9dWVj3pLNCclAjDi8ktew2oL6pbqKxfNw8=;
        b=ukmTsgKoHZu+pEtk3UOemMOQ2RvCZ2yvytZ1lStj8aNOtTyYQ8T6kFMlqcvkqOxIeB
         jxcWgIIShGEassSrjPy1cFn9ftgp2SIwCaLSOPFcbGdUvHqYcSIq5XmiYoCQBXemyAjS
         vXVTiTcZYzkbL6bRAxxQGMLh/h4wOXHJ1m//U50kFCYKjvQbtKJB7SoGintAh6KADLDQ
         eRGa6GerLR027OS/hnhWfSK7X0jbw5ZontGAv67IoJ54GlhhAhdkE7L1IhBAEsE7n+xy
         07oa9cEUih+9hDoGmprfWT1TsGUd+wIOIJUJBRuyVglFAJCOm48FyeLPeDkXfSjNVR2a
         MTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5mJh0GuM9dWVj3pLNCclAjDi8ktew2oL6pbqKxfNw8=;
        b=j5Zclzb+NlBs91MbWi88VLLF8UCpDUfRtgOnokFbEC9M+RYe6H1+4N5iwKNL50HStk
         YWc7HeOPut7loJ7ZsVf7zxPLyt4/u2fsVN56pU7F0Qgkz2fUAXPtFU0DhSV+AXr7Ptma
         Xlhh6qjm18r5ZpS/cwBZLhiySoRBhT1p0QuDu1Hcw/qgJZPrI9MCqb1tRz/voPA+dPVO
         EdA58MCTQjjnzxuKt+QgV/0E5dHvS80+s7bRLJyPX75bKxPaJbxJjbOsXmKjkiDQ5Bq2
         R7JHYapfIQWFvO0n2WvUC8L1TmO+JN7Hv6hOJE23Wsz3oMMGQtX7Pf2Tt/Jbh7UbU551
         0WRA==
X-Gm-Message-State: AOAM533ACaqjv9dWe7riMG4KvEBDO8YmGZextmeaHQcDYNlDDvj1qBpF
        Qia28vAw7bo5xcWCAFLwuo/hx0KDGmn5Fonuewo=
X-Google-Smtp-Source: ABdhPJyxgE1+5QXomnsB0wTlG4VykpZWNL2mST2YtiUYSy9zR3pJfWntPN6Yl72gL7IKMChLX4nX7KiPzCinBAoZnxI=
X-Received: by 2002:a02:8790:: with SMTP id t16mr7070139jai.81.1625024562534;
 Tue, 29 Jun 2021 20:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com> <20210629191035.681913-10-krisman@collabora.com>
In-Reply-To: <20210629191035.681913-10-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 06:42:31 +0300
Message-ID: <CAOQ4uxj=ByQuYOj946HqJv1MjHaSBgZVPnod_+a2yMrkw60nbw@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] fsnotify: Always run the merge hook
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 10:12 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> FS_FAN_ERROR must be able to merge events even in the short window after
> they've been unqueued but prior to being read.  Move the list_empty

This smells like trouble.
Breaking abstractions like this should be done for a very good reason
and I am not sure this is the case at hand.
More on this on merge_error_event patch.

Thanks,
Amir.

> check into the merge hooks, such that merge() is always invoked if
> existing.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.c        | 3 ++-
>  fs/notify/inotify/inotify_fsnotify.c | 3 +++
>  fs/notify/notification.c             | 2 +-
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index aba06b84da91..769703ef2b9a 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -168,7 +168,8 @@ static int fanotify_merge(struct fsnotify_group *group,
>          * the event structure we have created in fanotify_handle_event() is the
>          * one we should check for permission response.
>          */
> -       if (fanotify_is_perm_event(new->mask))
> +       if (list_empty(&group->notification_list) ||
> +           fanotify_is_perm_event(new->mask))
>                 return 0;
>
>         hlist_for_each_entry(old, hlist, merge_list) {
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index a003a64ff8ee..2f357b4933c2 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -52,6 +52,9 @@ static int inotify_merge(struct fsnotify_group *group,
>         struct list_head *list = &group->notification_list;
>         struct fsnotify_event *last_event;
>
> +       if (list_empty(list))
> +               return 0;
> +
>         last_event = list_entry(list->prev, struct fsnotify_event, list);
>         return event_compare(last_event, event);
>  }
> diff --git a/fs/notify/notification.c b/fs/notify/notification.c
> index 0d9ba592d725..1d06e0728a24 100644
> --- a/fs/notify/notification.c
> +++ b/fs/notify/notification.c
> @@ -111,7 +111,7 @@ int fsnotify_add_event(struct fsnotify_group *group,
>                 goto queue;
>         }
>
> -       if (!list_empty(list) && merge) {
> +       if (merge) {
>                 ret = merge(group, event);
>                 if (ret) {
>                         spin_unlock(&group->notification_lock);
> --
> 2.32.0
>
