Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFFD36BEB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 07:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhD0FEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 01:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhD0FEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 01:04:50 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105A3C06175F;
        Mon, 26 Apr 2021 22:04:08 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e186so5370337iof.7;
        Mon, 26 Apr 2021 22:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVBTKgwVPMCu3qySU0w50mv3CZTJa6GH+1DgmX3JJ3Y=;
        b=RAqLZPCPQdSiP0Yt00GykPqWT7lfjS7aFf4xCszy5HEaVsXr8pYyKzqz8QwDD+haj4
         XrH7RlXN48pHquYyaRMY7qZCB2urh3V3HdiVVOAq+HcJYtbTzZueOa9BUe3yAdSey7XE
         cC4y5GdFh/KQXecSQRPk01s/rmIS/INMfV7HbcduFp1/TS3K4n7DKwPTdqOXxbFNm4hS
         5PeeHNcg2fmrW/1FrzP2rtazpf7I20acWkxmKBBdFy0XvASbPHCCxTHpRUghWirYksQT
         rpiOFkIbxSSZaSatZOYjqsX3+N3hAa5aLQMoyQnBbrzqAO2tBVpQYlZ9NLaW/9RvN9xO
         xxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVBTKgwVPMCu3qySU0w50mv3CZTJa6GH+1DgmX3JJ3Y=;
        b=pJXWzn/c3PZ7bPbTmr/pRxcPLWaKGOxqROM00d91G7dES1wdavWS/9Yt76xEnZJV2V
         JorSSJI52R9/9bGtlZWhcwU4QKOOdlipRhuiqcudWBQpbvNYzhJjcUTrw7WCoTapFj9w
         6+YtGM4wH0K+qcAZnvINfMEOQMOsPDNwBIJW6QG3bI70KR6HQA1ICeSgMSTq8y6JfJN/
         KPKsJugwhUJ+WmXzZq2T+5AuRQSD4tm1uZSBQ+LqFZTOU3d9ZWsgeNTcLcXFTWuQoaNU
         4o3DBWG66FYidVun5Ri5rXW8JYkoknDgCcO+7I01EHmpUQ1+9N/7L3pTFY1tsTPJ1sHo
         qCUg==
X-Gm-Message-State: AOAM532Jj9k0Jn1Y67I7F0LqbCFS56tHsADpgYl+8qvf2ScWAj7caDm0
        vY+eNRtd09SoCK1SoLGVylo8r3i9gn21IslJt8Y=
X-Google-Smtp-Source: ABdhPJxXkKmZ5B0/KF/FKdP6GWi6hCyVwhUZ8Wqyo9Pcq7HhHamd26KzHdKpbXI8DWvRDmRm/RUJxfwO4/j1QXQMgmY=
X-Received: by 2002:a05:6602:58d:: with SMTP id v13mr17005697iox.64.1619499847554;
 Mon, 26 Apr 2021 22:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com> <20210426184201.4177978-4-krisman@collabora.com>
In-Reply-To: <20210426184201.4177978-4-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 08:03:56 +0300
Message-ID: <CAOQ4uxjUp_GecrV5VdBArN07PWQBUguQvwyL6K7NuXK=8yFMAw@mail.gmail.com>
Subject: Re: [PATCH RFC 03/15] fsnotify: Wire flags field on group allocation
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 9:42 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Introduce a flags field in fsnotify_group to track the mode of
> submission this group has.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/dnotify/dnotify.c        |  2 +-
>  fs/notify/fanotify/fanotify_user.c |  4 ++--
>  fs/notify/group.c                  | 13 ++++++++-----
>  fs/notify/inotify/inotify_user.c   |  2 +-
>  include/linux/fsnotify_backend.h   |  7 +++++--
>  kernel/audit_fsnotify.c            |  2 +-
>  kernel/audit_tree.c                |  2 +-
>  kernel/audit_watch.c               |  2 +-
>  8 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index e85e13c50d6d..37960c8750e4 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -383,7 +383,7 @@ static int __init dnotify_init(void)
>                                           SLAB_PANIC|SLAB_ACCOUNT);
>         dnotify_mark_cache = KMEM_CACHE(dnotify_mark, SLAB_PANIC|SLAB_ACCOUNT);
>
> -       dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops);
> +       dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops, 0);
>         if (IS_ERR(dnotify_group))
>                 panic("unable to allocate fsnotify group for dnotify\n");
>         return 0;
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index e0d113e3b65c..f50c4ab721e3 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -929,7 +929,7 @@ static struct fsnotify_event *fanotify_alloc_overflow_event(void)
>  SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  {
>         struct fsnotify_group *group;
> -       int f_flags, fd;
> +       int f_flags, fd, fsn_flags = 0;
>         struct user_struct *user;
>         unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
>         unsigned int class = flags & FANOTIFY_CLASS_BITS;
> @@ -982,7 +982,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>                 f_flags |= O_NONBLOCK;
>
>         /* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
> -       group = fsnotify_alloc_user_group(&fanotify_fsnotify_ops);
> +       group = fsnotify_alloc_user_group(&fanotify_fsnotify_ops, fsn_flags);
>         if (IS_ERR(group)) {
>                 free_uid(user);
>                 return PTR_ERR(group);
> diff --git a/fs/notify/group.c b/fs/notify/group.c
> index ffd723ffe46d..08acb1afc0c2 100644
> --- a/fs/notify/group.c
> +++ b/fs/notify/group.c
> @@ -112,7 +112,7 @@ void fsnotify_put_group(struct fsnotify_group *group)
>  EXPORT_SYMBOL_GPL(fsnotify_put_group);
>
>  static struct fsnotify_group *__fsnotify_alloc_group(
> -                               const struct fsnotify_ops *ops, gfp_t gfp)
> +       const struct fsnotify_ops *ops, unsigned int flags, gfp_t gfp)
>  {
>         struct fsnotify_group *group;
>
> @@ -134,6 +134,7 @@ static struct fsnotify_group *__fsnotify_alloc_group(
>         INIT_LIST_HEAD(&group->marks_list);
>
>         group->ops = ops;
> +       group->flags = flags;
>
>         return group;
>  }
> @@ -141,18 +142,20 @@ static struct fsnotify_group *__fsnotify_alloc_group(
>  /*
>   * Create a new fsnotify_group and hold a reference for the group returned.
>   */
> -struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
> +struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops,
> +                                           unsigned int flags)
>  {
> -       return __fsnotify_alloc_group(ops, GFP_KERNEL);
> +       return __fsnotify_alloc_group(ops, flags, GFP_KERNEL);
>  }
>  EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
>
>  /*
>   * Create a new fsnotify_group and hold a reference for the group returned.
>   */
> -struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops)
> +struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops,
> +                                                unsigned int flags)
>  {
> -       return __fsnotify_alloc_group(ops, GFP_KERNEL_ACCOUNT);
> +       return __fsnotify_alloc_group(ops, flags, GFP_KERNEL_ACCOUNT);
>  }
>  EXPORT_SYMBOL_GPL(fsnotify_alloc_user_group);
>

*IF* we go this way, note that fsnotify_alloc_group() doesn't need
flags argument.
None of the callers of fsnotify_alloc_group() ever use the
notification list, so it
would be better to pass flag FSN_NOTIFICATION_LIST from the backends that
do use it (fanotify and inotify) for the sake of symmetry with FSN_RING_BUFFER
and no need to change other callers.

Thanks,
Amir.
