Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563A4361AE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhDPHy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 03:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbhDPHy0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:54:26 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FACC061574;
        Fri, 16 Apr 2021 00:54:00 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e186so26849985iof.7;
        Fri, 16 Apr 2021 00:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZgJ4HPYSc2Bm8VdO2ALDr1JFJ3KD0zJrkMrbQQE57b8=;
        b=OX7yBpXWn2ssAxkb3r7+qQ7aamSOBKZ0EDBPvTJqyR8BG8bYrtoMScCbJjiF4pSGcS
         l9Ywks4aVDRA+TgBW8EjLpmTfTQbsDu5zFx/GbfJ4kLX1gxMiT5Ex/UTmTyV2WVQuJ6i
         +2kd5MKn9hFiNzYarWvGMjYw1E4FUZmi+IasTK4vEFnq8elg2pIv9f5fnJZxqVZCYtHo
         TuKAIHmSboFQV7x68I1pwAy7FHr0LkHBK+fZR8fkxlsAUgQnC1i3/XOr8pO+q+lQAsGJ
         i/opyqBXccs2Dd6Dm2YjdRga1/yOkcojkgLstEeD4OLZsG/FHvEFSbdiHSkDXrgQ75mv
         3b4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgJ4HPYSc2Bm8VdO2ALDr1JFJ3KD0zJrkMrbQQE57b8=;
        b=lfEoSwtg5vNFWsEsKha77aH9NohNH8n+H/vnY/PxSOwR8NRoOcQZ2hktJp2hInVBWc
         x6BXoNXWmm9n0kNXp1nbTRquLOXui+uQMVS9AdPf9fNaeJ9qGNj7NIalD6bEg+UUYiM+
         bDWRqPX9SvAu4F7vxk6e0yh2TQeHeCqRyu+u7R06BLO5CGsjABrH2suqbQoe3T7yXv42
         xc1ev3gWlxKN0lJ8WNl8vpFXQtv58q6mAQX5fqhezElo0A33mHVOzjB6llkTZdi0jxyB
         IhdUWyYE36cijuItOA/dO52o6MldhjldYi0SQV94WsxmkQkOBYBmrUDQZ49bGU2Oc5De
         Rj5g==
X-Gm-Message-State: AOAM532m0rD+woqQY/r0MVk87pSmXT/ofJX1y64RTWZZ+X9QbEUBCCeW
        fhSFBIGGqL7kphF0yK/Bjg6h4w2NMHXbkAP/d/gxzHMWEbc=
X-Google-Smtp-Source: ABdhPJzbnz+doZyA/ZlKhiVLSaMWSyiqc0T96lV6wlWQ572onxtig6GV5Wn4q98ZtK4M5EXfcWX9q7P8y50IYh2e9a8=
X-Received: by 2002:a6b:d309:: with SMTP id s9mr2513490iob.186.1618559640091;
 Fri, 16 Apr 2021 00:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618527437.git.repnop@google.com> <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <CAOQ4uxhWicqpKQxvuN5=WiULwNRozFvxQKgTDMOL-UxKpnk-WQ@mail.gmail.com> <YHk3Uko0feh3ud/X@google.com>
In-Reply-To: <YHk3Uko0feh3ud/X@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 16 Apr 2021 10:53:48 +0300
Message-ID: <CAOQ4uxjQi4dV0XoU2WDKG+3R81Xam6giee9hhkvXb13tQB+Tdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:06 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Fri, Apr 16, 2021 at 09:27:03AM +0300, Amir Goldstein wrote:
> > On Fri, Apr 16, 2021 at 2:22 AM Matthew Bobrowski <repnop@google.com> wrote:
> > >
> > > Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> > > allows userspace applications to control whether a pidfd is to be
> > > returned instead of a pid for `struct fanotify_event_metadata.pid`.
> > >
> > > FAN_REPORT_PIDFD is mutually exclusive with FAN_REPORT_TID as the
> > > pidfd API is currently restricted to only support pidfd generation for
> > > thread-group leaders. Attempting to set them both when calling
> > > fanotify_init(2) will result in -EINVAL being returned to the
> > > caller. As the pidfd API evolves and support is added for tids, this
> > > is something that could be relaxed in the future.
> > >
> > > If pidfd creation fails, the pid in struct fanotify_event_metadata is
> > > set to FAN_NOPIDFD(-1).
> >
> > Hi Matthew,
> >
> > All in all looks good, just a few small nits.
>
> Thanks for feedback Amir! :)
>
> > > Falling back and providing a pid instead of a
> > > pidfd on pidfd creation failures was considered, although this could
> > > possibly lead to confusion and unpredictability within userspace
> > > applications as distinguishing between whether an actual pidfd or pid
> > > was returned could be difficult, so it's best to be explicit.
> >
> > I don't think this should have been even "considered" so I see little
> > value in this paragraph in commit message.
>
> Fair point. I will discard this sentence for all subsequent iterations
> of this patch series. I guess the idea was that this patch series was
> meant to be labeled as being "RFC", so some extra thoughts had been
> noted.
>
> > > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> > > ---
> > >  fs/notify/fanotify/fanotify_user.c | 33 +++++++++++++++++++++++++++---
> > >  include/linux/fanotify.h           |  2 +-
> > >  include/uapi/linux/fanotify.h      |  2 ++
> > >  3 files changed, 33 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > index 9e0c1afac8bd..fd8ae88796a8 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -329,7 +329,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> > >         struct fanotify_info *info = fanotify_event_info(event);
> > >         unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> > >         struct file *f = NULL;
> > > -       int ret, fd = FAN_NOFD;
> > > +       int ret, pidfd, fd = FAN_NOFD;
> > >         int info_type = 0;
> > >
> > >         pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> > > @@ -340,7 +340,25 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> > >         metadata.vers = FANOTIFY_METADATA_VERSION;
> > >         metadata.reserved = 0;
> > >         metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
> > > -       metadata.pid = pid_vnr(event->pid);
> > > +
> > > +       if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD) &&
> > > +               pid_has_task(event->pid, PIDTYPE_TGID)) {
> > > +               /*
> > > +                * Given FAN_REPORT_PIDFD is to be mutually exclusive with
> > > +                * FAN_REPORT_TID, panic here if the mutual exclusion is ever
> > > +                * blindly lifted without pidfds for threads actually being
> > > +                * supported.
> > > +                */
> > > +               WARN_ON(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> >
> > Better WARN_ON_ONCE() the outcome of this error is not terrible.
> > Also in the comment above I would not refer to this warning as "panic".
>
> ACK.
>
> > > +
> > > +               pidfd = pidfd_create(event->pid, 0);
> > > +               if (unlikely(pidfd < 0))
> > > +                       metadata.pid = FAN_NOPIDFD;
> > > +               else
> > > +                       metadata.pid = pidfd;
> > > +       } else {
> > > +               metadata.pid = pid_vnr(event->pid);
> > > +       }
> >
> > You should rebase your work on:
> > git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
> > and resolve conflicts with "unprivileged listener" code.
>
> ACK.
>
> > Need to make sure that pidfd is not reported to an unprivileged
> > listener even if group was initialized by a privileged process.
> > This is a conscious conservative choice that we made for reporting
> > pid info to unprivileged listener that can be revisited in the future.
>
> OK, I see. In that case, I guess I can add the FAN_REPORT_PIDFD check
> above the current conditional [0]:
>
> ...
> if (!capable(CAP_SYS_ADMIN) && task_tgid(current) != event->pid)
>         metadata.pid = 0;
> ...
>
> That way, AFAIK even if it is an unprivileged listener the pid info
> will be overwritten as intended.
>

Situation is a bit more subtle than that.
If you override event->pid with zero and zero is interpreted as pidfd
that would not be consistent with uapi documentation.
You need to make sure that event->pid is FAN_NOPIDFD in case
(!capable(CAP_SYS_ADMIN) &&
 FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD))
Hopefully, you can do that while keeping the special cases to minimum...


> > >
> > >         if (path && path->mnt && path->dentry) {
> > >                 fd = create_fd(group, path, &f);
> > > @@ -941,6 +959,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
> > >  #endif
> > >                 return -EINVAL;
> > >
> > > +       /*
> > > +        * A pidfd can only be returned for a thread-group leader; thus
> > > +        * FAN_REPORT_TID and FAN_REPORT_PIDFD need to be mutually
> > > +        * exclusive. Once the pidfd API supports the creation of pidfds on
> > > +        * individual threads, then we can look at removing this conditional.
> > > +        */
> > > +       if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
> > > +               return -EINVAL;
> > > +
> > >         if (event_f_flags & ~FANOTIFY_INIT_ALL_EVENT_F_BITS)
> > >                 return -EINVAL;
> > >
> > > @@ -1312,7 +1339,7 @@ SYSCALL32_DEFINE6(fanotify_mark,
> > >   */
> > >  static int __init fanotify_user_setup(void)
> > >  {
> > > -       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
> > > +       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 11);
> > >         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
> > >
> > >         fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
> > > diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> > > index 3e9c56ee651f..894740a6f4e0 100644
> > > --- a/include/linux/fanotify.h
> > > +++ b/include/linux/fanotify.h
> > > @@ -21,7 +21,7 @@
> > >  #define FANOTIFY_FID_BITS      (FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
> > >
> > >  #define FANOTIFY_INIT_FLAGS    (FANOTIFY_CLASS_BITS | FANOTIFY_FID_BITS | \
> > > -                                FAN_REPORT_TID | \
> > > +                                FAN_REPORT_TID | FAN_REPORT_PIDFD | \
> > >                                  FAN_CLOEXEC | FAN_NONBLOCK | \
> > >                                  FAN_UNLIMITED_QUEUE | FAN_UNLIMITED_MARKS)
> > >
> >
> > FAN_REPORT_PIDFD should be added to FANOTIFY_ADMIN_INIT_FLAGS
> > from fsnotify branch.
>
> ACK.
>
> Before sending any other version of this patch series through I will
> see what Jan and Christian have to say.
>

That makes sense.

Thanks,
Amir.
