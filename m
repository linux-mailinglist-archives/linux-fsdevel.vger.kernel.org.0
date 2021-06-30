Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0093B7C26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 05:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhF3Dmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 23:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhF3Dmm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 23:42:42 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E41FC061760;
        Tue, 29 Jun 2021 20:40:13 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b7so1422410ioq.12;
        Tue, 29 Jun 2021 20:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kdz7uL0Ru1LcZD7JQPGwULRGlOCeqsP2VoZEDjSMQlY=;
        b=VXePGl39rmcqSjh36WeFhfqj/BUfBIRYom1btR0GztXJODJ7sFGXlzb5o4TZDVCErc
         8YRwJoYG44qpl5hhoMkuWJ4p7erW/p6RQd0uXHJRIH42I0N7Z/sYoDrNtNDPKDEt55l0
         MvX0lF1C5jURbknzSXn/OPAGRp4nAvuEXFmeAGqxEyPrAhy2rpvUEKfvB0EomL+9y78m
         MUuXN/1IsVXlLmHTTYyWgU/+Q35esCN93aNHlbPKldhiM6oGYHmJcIBEHbmsFv8fC4DW
         ow390bwr8OHcZEP0dWwFw946Qwt9YK1kWDdhwF+INjj1lilZ0aVRteF7KNbQBf9Jn1WJ
         NQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kdz7uL0Ru1LcZD7JQPGwULRGlOCeqsP2VoZEDjSMQlY=;
        b=cFr4u0pYGkLOQ4dRpLO8qreerSORcA5Kr5v612ZGZFkDGqaHRX57kgvrIMkAI5SLxD
         naGNVZXYAjggaiO1ohrdFmu22SibFjFLhZv7S9EDgvADIU2A7VL6w/clW5TUo2kF/PkQ
         KXuJmJX10uLBW1wESgB6D/33dWcyXlijnRMN58HuRc8r0Z3rYAU+7UHxKBDa/hUkYWaC
         v6etuRrcW/Lp+LM0P40c8FtUQRorc5YSDTj0zRoMoCa57BTy5/oDroKTZiJv3S+mOyhr
         jNPOINAKA6mmDK3EzAEh4KBLYYa+kqfZwKvfr8I5B4SUeiF9AptuwOc7Cfm+wPGUuN1+
         91xA==
X-Gm-Message-State: AOAM531tmPeODrIHEd3BOhUD85u6aeJfyeuV5DMslrqLhxRQvPRphkZs
        1BGzPnedIeKzEwEt6oQq5m0n+4Lf+ZQaHww6Axo=
X-Google-Smtp-Source: ABdhPJwpZILk99THSxK9mY9wCF5SdwliSjwoLLgCpCvrX9ZyFeLJaiYx6fxA8wfked/MklIb74eaS4lQr3PxnxTMgBU=
X-Received: by 2002:a02:3505:: with SMTP id k5mr7060303jaa.123.1625024411866;
 Tue, 29 Jun 2021 20:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com> <20210629191035.681913-9-krisman@collabora.com>
In-Reply-To: <20210629191035.681913-9-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 06:40:00 +0300
Message-ID: <CAOQ4uxhbRvZXTQ9c2V7KFFDs0pYw05tgKruJTXr8AmJCKKTauw@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] fsnotify: Support passing argument to insert
 callback on add_event
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
> FAN_FS_ERROR requires some initialization to happen from inside the
> insert hook.  This allows a user of fanotify_add_event to pass an
> argument to be sent to the insert callback.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

with optional suggestion for improvement...

> ---
>  fs/notify/fanotify/fanotify.c        | 5 +++--
>  fs/notify/inotify/inotify_fsnotify.c | 2 +-
>  fs/notify/notification.c             | 6 ++++--
>  include/linux/fsnotify_backend.h     | 7 +++++--
>  4 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 4f2febb15e94..aba06b84da91 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -695,7 +695,8 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
>   * Add an event to hash table for faster merge.
>   */
>  static void fanotify_insert_event(struct fsnotify_group *group,
> -                                 struct fsnotify_event *fsn_event)
> +                                 struct fsnotify_event *fsn_event,
> +                                 const void *data)
>  {
>         struct fanotify_event *event = FANOTIFY_E(fsn_event);
>         unsigned int bucket = fanotify_event_hash_bucket(group, event);
> @@ -779,7 +780,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>
>         fsn_event = &event->fse;
>         ret = fsnotify_add_event(group, fsn_event, fanotify_merge,
> -                                fanotify_insert_event);
> +                                fanotify_insert_event, NULL);
>         if (ret) {
>                 /* Permission events shouldn't be merged */
>                 BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index d1a64daa0171..a003a64ff8ee 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -116,7 +116,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
>         if (len)
>                 strcpy(event->name, name->name);
>
> -       ret = fsnotify_add_event(group, fsn_event, inotify_merge, NULL);
> +       ret = fsnotify_add_event(group, fsn_event, inotify_merge, NULL, NULL);
>         if (ret) {
>                 /* Our event wasn't used in the end. Free it. */
>                 fsnotify_destroy_event(group, fsn_event);
> diff --git a/fs/notify/notification.c b/fs/notify/notification.c
> index 32f45543b9c6..0d9ba592d725 100644
> --- a/fs/notify/notification.c
> +++ b/fs/notify/notification.c
> @@ -83,7 +83,9 @@ int fsnotify_add_event(struct fsnotify_group *group,
>                        int (*merge)(struct fsnotify_group *,
>                                     struct fsnotify_event *),
>                        void (*insert)(struct fsnotify_group *,
> -                                     struct fsnotify_event *))
> +                                     struct fsnotify_event *,
> +                                     const void *),
> +                      const void *insert_data)
>  {
>         int ret = 0;
>         struct list_head *list = &group->notification_list;
> @@ -121,7 +123,7 @@ int fsnotify_add_event(struct fsnotify_group *group,
>         group->q_len++;
>         list_add_tail(&event->list, list);
>         if (insert)
> -               insert(group, event);
> +               insert(group, event, insert_data);
>         spin_unlock(&group->notification_lock);
>
>         wake_up(&group->notification_waitq);
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index b1590f654ade..8222fe12a6c9 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -526,11 +526,14 @@ extern int fsnotify_add_event(struct fsnotify_group *group,
>                               int (*merge)(struct fsnotify_group *,
>                                            struct fsnotify_event *),
>                               void (*insert)(struct fsnotify_group *,
> -                                            struct fsnotify_event *));
> +                                            struct fsnotify_event *,
> +                                            const void *),
> +                             const void *insert_data);
> +
>  /* Queue overflow event to a notification group */
>  static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
>  {
> -       fsnotify_add_event(group, group->overflow_event, NULL, NULL);
> +       fsnotify_add_event(group, group->overflow_event, NULL, NULL, NULL);
>  }
>

Looking back, when I added the insert() callback, it might have been wiser to
rename fsnotify_add_event() to fsnotify_insert_event() add a wrapper:

static inline int fsnotify_add_event(group, event, merge) {
    return fsnotify_insert_event(group, event, merge, NULL);
}

But the two call sites did not seem to justify it.
Perhaps with the growing list of NULL arguments it is time to
reconsider this small tidy up?
Not critical though.

Thanks,
Amir.
