Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441543CFFD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 18:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhGTQPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 12:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhGTQPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 12:15:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98280C061762;
        Tue, 20 Jul 2021 09:56:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so1876847wmf.5;
        Tue, 20 Jul 2021 09:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xadoaP6a/fOgGejgqCkE+KjA+gb1/Cu1z/gORdF39MM=;
        b=UIlfSZIFil/4wlHMam2+jJJTgTC9SLZH5oeQEE6Sf32dqhZw/wD/Z/7Ysj7PiP3v0m
         qpRtBTAn6k1k8uFzdYjY/4C4FGPGS8p3MpiMH/WVw6KDimYazrtXSw4YtQlrlk6J5QBP
         due9llyGW/LXKRX4oZrX8hMI7yWgYFOkv8sJQtrzbR8B3Y0+MV/etPP6YCccrNQI/pR9
         O30+AQU4/6HAOFLRaAFl0QCUBWPfjf3fcMwp/Lf7FqG8Y3njNXDlsT/IpfBqm7vzxJ86
         I4Aa5vbEhKHXrDmaPSFoxIX/yRMdVIYOHdKKsZvXxt9LST/9+pJE+7CbQERMIGsgJijH
         713A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xadoaP6a/fOgGejgqCkE+KjA+gb1/Cu1z/gORdF39MM=;
        b=AgcWTXAsM+3clYeAt1BsIxTl7xE+zmYTZivA3JC9fct34XOJC0Uj2wmh2kWiX8o9wn
         NV3ZGi16Yp6TLfz5OR8YgrX7Gj/qs9skyqYy86Txm5URIcuaaYjxf6ELj0dMifDV5kGW
         saCZ1nUX96gUEe2OOxpmnzxtDdRqHO0X5wMUL2bQYCPfE9C4rgtpo0SPH5/T97AVkEyZ
         ygcUG7Nol+1RqX2nBwPbSyylhxmjq38+tywvl/Wqg1cUM6HzawXYS4VYjz2nGBtE/qdU
         QVAj0/Sc4T0i5VT+0/k42na4X++KaEB3dboxn2Vi2OK29IhIATgvKAFa7pngJ5/3ue3e
         H0IA==
X-Gm-Message-State: AOAM531xHhu50t7gvFC2Ig/evLhRRA/dC0Gk3oRjrZXm0OqpZ0BdnoN/
        itbWm9YVMpICSIGtfk4Ve2y3zJgjq3VmGFRl544=
X-Google-Smtp-Source: ABdhPJzeq7D6dxXy4SwjmQ01E/5DNg+7EKLpcvNVDY+xrby+RLKHfxhDwHW0oorrNhOk3tw/IcPuKwMFoV6vzOvsHQ4=
X-Received: by 2002:a7b:c251:: with SMTP id b17mr17742709wmj.83.1626800171062;
 Tue, 20 Jul 2021 09:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210720155944.1447086-1-krisman@collabora.com> <20210720155944.1447086-10-krisman@collabora.com>
In-Reply-To: <20210720155944.1447086-10-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 20 Jul 2021 19:56:00 +0300
Message-ID: <CAOQ4uxgC4qqMVDcoHHC=Zi-29a8pOOrqyNF6ZFYWgK-EBs8SVA@mail.gmail.com>
Subject: Re: [PATCH v4 09/16] fsnotify: Add wrapper around fsnotify_add_event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 7:00 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> fsnotify_add_event is growing in number of parameters, which is most
> case are just passed a NULL pointer.  So, split out a new
> fsnotify_insert_event function to clean things up for users who don't
> need an insert hook.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>  fs/notify/fanotify/fanotify.c        |  4 ++--
>  fs/notify/inotify/inotify_fsnotify.c |  2 +-
>  fs/notify/notification.c             | 12 ++++++------
>  include/linux/fsnotify_backend.h     | 23 ++++++++++++++++-------
>  4 files changed, 25 insertions(+), 16 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 6875d4d34c0c..93f96589ad1e 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -778,8 +778,8 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>         }
>
>         fsn_event = &event->fse;
> -       ret = fsnotify_add_event(group, fsn_event, fanotify_merge,
> -                                fanotify_insert_event);
> +       ret = fsnotify_insert_event(group, fsn_event, fanotify_merge,
> +                                   fanotify_insert_event);
>         if (ret) {
>                 /* Permission events shouldn't be merged */
>                 BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index d1a64daa0171..a96582cbfad1 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -116,7 +116,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
>         if (len)
>                 strcpy(event->name, name->name);
>
> -       ret = fsnotify_add_event(group, fsn_event, inotify_merge, NULL);
> +       ret = fsnotify_add_event(group, fsn_event, inotify_merge);
>         if (ret) {
>                 /* Our event wasn't used in the end. Free it. */
>                 fsnotify_destroy_event(group, fsn_event);
> diff --git a/fs/notify/notification.c b/fs/notify/notification.c
> index 32f45543b9c6..44bb10f50715 100644
> --- a/fs/notify/notification.c
> +++ b/fs/notify/notification.c
> @@ -78,12 +78,12 @@ void fsnotify_destroy_event(struct fsnotify_group *group,
>   * 2 if the event was not queued - either the queue of events has overflown
>   *   or the group is shutting down.
>   */
> -int fsnotify_add_event(struct fsnotify_group *group,
> -                      struct fsnotify_event *event,
> -                      int (*merge)(struct fsnotify_group *,
> -                                   struct fsnotify_event *),
> -                      void (*insert)(struct fsnotify_group *,
> -                                     struct fsnotify_event *))
> +int fsnotify_insert_event(struct fsnotify_group *group,
> +                         struct fsnotify_event *event,
> +                         int (*merge)(struct fsnotify_group *,
> +                                      struct fsnotify_event *),
> +                         void (*insert)(struct fsnotify_group *,
> +                                        struct fsnotify_event *))
>  {
>         int ret = 0;
>         struct list_head *list = &group->notification_list;
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 3c6fb43276ba..435982f88687 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -522,16 +522,25 @@ extern int fsnotify_fasync(int fd, struct file *file, int on);
>  extern void fsnotify_destroy_event(struct fsnotify_group *group,
>                                    struct fsnotify_event *event);
>  /* attach the event to the group notification queue */
> -extern int fsnotify_add_event(struct fsnotify_group *group,
> -                             struct fsnotify_event *event,
> -                             int (*merge)(struct fsnotify_group *,
> -                                          struct fsnotify_event *),
> -                             void (*insert)(struct fsnotify_group *,
> -                                            struct fsnotify_event *));
> +extern int fsnotify_insert_event(struct fsnotify_group *group,
> +                                struct fsnotify_event *event,
> +                                int (*merge)(struct fsnotify_group *,
> +                                             struct fsnotify_event *),
> +                                void (*insert)(struct fsnotify_group *,
> +                                               struct fsnotify_event *));
> +
> +static inline int fsnotify_add_event(struct fsnotify_group *group,
> +                                    struct fsnotify_event *event,
> +                                    int (*merge)(struct fsnotify_group *,
> +                                                 struct fsnotify_event *))
> +{
> +       return fsnotify_insert_event(group, event, merge, NULL);
> +}
> +
>  /* Queue overflow event to a notification group */
>  static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
>  {
> -       fsnotify_add_event(group, group->overflow_event, NULL, NULL);
> +       fsnotify_add_event(group, group->overflow_event, NULL);
>  }
>
>  static inline bool fsnotify_is_overflow_event(u32 mask)
> --
> 2.32.0
>
