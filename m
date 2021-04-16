Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055733619D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 08:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhDPG1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 02:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbhDPG1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:27:41 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D43CC061574;
        Thu, 15 Apr 2021 23:27:15 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id r5so14066689ilb.2;
        Thu, 15 Apr 2021 23:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBb8+96zrnT1IoY07WahT2MpUgP5ZNhOBO5cPCsGZGw=;
        b=hMH4+zkVi375/Nik2gy3sUQfdCDd/BVAT7aPiPChWln0HjEA20R8lw9zYEwOkXK9Cb
         IM413zpeoJ/rxGCIj2MIzUOKo2+B8YtL9aejT59oKEkQ90emUJcMQr/T2/4ynwQPw7m6
         o3Fc4C32CgU2UlK6fEiiFemXqwlCG/ddUVTgVW+N/9qLfe9sQM1bjX2VTs6iC7oGu98v
         TdCIZhiemgTNAfBc99ASc0wcie+Y3VpO6hmWEDnNn07fY52oEt1AgS0iRoajMg321QDG
         oHaw7DT7GMIPc+TKXN9tRW+riCB/hgqaycmF0bTAGq+SyeVUt9162wGWHPo5Y6J3jgp/
         SYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBb8+96zrnT1IoY07WahT2MpUgP5ZNhOBO5cPCsGZGw=;
        b=o8OOIKl5BW7V0v8i/050ac+sh0m7M0qR8mBBRJamiEmNJKFeF+hKq3Kj8gc+iZidV6
         LZ2ijN/xGDVpxQBKiXYiZj9Nd41GQrI1ZqJrOZKBMFJBPiHP7j4eaMG8Sl/VXwxdVCtI
         v5TB3bWQO7L7xbb345wW2o6bX50bv3JLlQnujmhrYrDUK8l1bGbkkL3HEtQId11PD0rH
         7AEerT7AGYXwRM9xgusyLT+zzVUPLce0wK0VbDvp+OKfwwgOa0JZEf7vNAhEBUoYewiK
         7XtgCMTEVlk1vlDO1MuweCiItyUtzm/VbSoEjLbj3BX3AI4+R8Jv5GHfZIBxJKn3T2wT
         v/Nw==
X-Gm-Message-State: AOAM531zl2z/D3R+Se/d94grMXXNtfL4if/76q+LDPXBew443IUVCPgn
        mViWPrbTiTv+CMSAZzJecvFo4Q72qiG+a8h3HdSxrZF4mHI=
X-Google-Smtp-Source: ABdhPJzWLpYRgCCamV9owDE0FwrNw0ElhWMag7FcT31UdrG4/J65NAs7DJav6ShZ6rLZk3zmLnN4o+bvy2y0BxjCVvY=
X-Received: by 2002:a92:2c08:: with SMTP id t8mr5631044ile.72.1618554434902;
 Thu, 15 Apr 2021 23:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618527437.git.repnop@google.com> <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
In-Reply-To: <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 16 Apr 2021 09:27:03 +0300
Message-ID: <CAOQ4uxhWicqpKQxvuN5=WiULwNRozFvxQKgTDMOL-UxKpnk-WQ@mail.gmail.com>
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

On Fri, Apr 16, 2021 at 2:22 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> allows userspace applications to control whether a pidfd is to be
> returned instead of a pid for `struct fanotify_event_metadata.pid`.
>
> FAN_REPORT_PIDFD is mutually exclusive with FAN_REPORT_TID as the
> pidfd API is currently restricted to only support pidfd generation for
> thread-group leaders. Attempting to set them both when calling
> fanotify_init(2) will result in -EINVAL being returned to the
> caller. As the pidfd API evolves and support is added for tids, this
> is something that could be relaxed in the future.
>
> If pidfd creation fails, the pid in struct fanotify_event_metadata is
> set to FAN_NOPIDFD(-1).

Hi Matthew,

All in all looks good, just a few small nits.

> Falling back and providing a pid instead of a
> pidfd on pidfd creation failures was considered, although this could
> possibly lead to confusion and unpredictability within userspace
> applications as distinguishing between whether an actual pidfd or pid
> was returned could be difficult, so it's best to be explicit.

I don't think this should have been even "considered" so I see little
value in this paragraph in commit message.

>
> Signed-off-by: Matthew Bobrowski <repnop@google.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 33 +++++++++++++++++++++++++++---
>  include/linux/fanotify.h           |  2 +-
>  include/uapi/linux/fanotify.h      |  2 ++
>  3 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 9e0c1afac8bd..fd8ae88796a8 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -329,7 +329,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>         struct fanotify_info *info = fanotify_event_info(event);
>         unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
>         struct file *f = NULL;
> -       int ret, fd = FAN_NOFD;
> +       int ret, pidfd, fd = FAN_NOFD;
>         int info_type = 0;
>
>         pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> @@ -340,7 +340,25 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>         metadata.vers = FANOTIFY_METADATA_VERSION;
>         metadata.reserved = 0;
>         metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
> -       metadata.pid = pid_vnr(event->pid);
> +
> +       if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD) &&
> +               pid_has_task(event->pid, PIDTYPE_TGID)) {
> +               /*
> +                * Given FAN_REPORT_PIDFD is to be mutually exclusive with
> +                * FAN_REPORT_TID, panic here if the mutual exclusion is ever
> +                * blindly lifted without pidfds for threads actually being
> +                * supported.
> +                */
> +               WARN_ON(FAN_GROUP_FLAG(group, FAN_REPORT_TID));

Better WARN_ON_ONCE() the outcome of this error is not terrible.
Also in the comment above I would not refer to this warning as "panic".

> +
> +               pidfd = pidfd_create(event->pid, 0);
> +               if (unlikely(pidfd < 0))
> +                       metadata.pid = FAN_NOPIDFD;
> +               else
> +                       metadata.pid = pidfd;
> +       } else {
> +               metadata.pid = pid_vnr(event->pid);
> +       }

You should rebase your work on:
git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
and resolve conflicts with "unprivileged listener" code.

Need to make sure that pidfd is not reported to an unprivileged
listener even if group was initialized by a privileged process.
This is a conscious conservative choice that we made for reporting
pid info to unprivileged listener that can be revisited in the future.

>
>         if (path && path->mnt && path->dentry) {
>                 fd = create_fd(group, path, &f);
> @@ -941,6 +959,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  #endif
>                 return -EINVAL;
>
> +       /*
> +        * A pidfd can only be returned for a thread-group leader; thus
> +        * FAN_REPORT_TID and FAN_REPORT_PIDFD need to be mutually
> +        * exclusive. Once the pidfd API supports the creation of pidfds on
> +        * individual threads, then we can look at removing this conditional.
> +        */
> +       if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
> +               return -EINVAL;
> +
>         if (event_f_flags & ~FANOTIFY_INIT_ALL_EVENT_F_BITS)
>                 return -EINVAL;
>
> @@ -1312,7 +1339,7 @@ SYSCALL32_DEFINE6(fanotify_mark,
>   */
>  static int __init fanotify_user_setup(void)
>  {
> -       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
> +       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 11);
>         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
>
>         fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 3e9c56ee651f..894740a6f4e0 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -21,7 +21,7 @@
>  #define FANOTIFY_FID_BITS      (FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
>
>  #define FANOTIFY_INIT_FLAGS    (FANOTIFY_CLASS_BITS | FANOTIFY_FID_BITS | \
> -                                FAN_REPORT_TID | \
> +                                FAN_REPORT_TID | FAN_REPORT_PIDFD | \
>                                  FAN_CLOEXEC | FAN_NONBLOCK | \
>                                  FAN_UNLIMITED_QUEUE | FAN_UNLIMITED_MARKS)
>

FAN_REPORT_PIDFD should be added to FANOTIFY_ADMIN_INIT_FLAGS
from fsnotify branch.

Thanks,
Amir.
