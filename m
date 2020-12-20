Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806232DF541
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Dec 2020 12:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgLTLdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Dec 2020 06:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbgLTLdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Dec 2020 06:33:41 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB041C0613CF;
        Sun, 20 Dec 2020 03:32:57 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id v3so6398845ilo.5;
        Sun, 20 Dec 2020 03:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0RIf8qETIbxVC3oxNn/SpILYlWi1bd6TPTjH2d2PIU=;
        b=Om1jvy2REMmihIhtP0X3fKOLyxar5IgOSk4Ra2xCTYLU5EeGoF5haZw9Y2VKINVd43
         jx14ijuBZ+YcM6h+b0mDb6qJuy4RqiAZ0psuBqwBzhSgJuk10JG7v87txjkYZ2jOjVGK
         +oT1wGh5wAJDo6AeAFhNvLESwc2RZWy/EiHt4aAmrjEGZuaRrWaHC0z/+DrxUqRavaB5
         yoe2krG6rPw7UKU8kk7YDuQrRDqy8CN9ZSk1H+T9cceHAwLjXZ9WncXUCHWvEDl1FHFF
         qlF3mUOVNxQ45HG41sSn2IVip0g0MckDfyKx9f0Pri1JDDAxWeAwHVM9SH3Qb04bx+Rs
         70RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0RIf8qETIbxVC3oxNn/SpILYlWi1bd6TPTjH2d2PIU=;
        b=TnGGAgD7o0Oi2uelEDtJtrv2/AWblb4DqFTP13ublKUvpD3kh7Tg0k6W3nzWvJEqPT
         Ptjh7FrXes/GUB0KaSgYUVB0G9zDCUVlb5ePcmHCbFmRCewGZ9nShyx+Jj/BD40nYmKz
         i2WZl5LXtLlUHzVWig00uzzNgbUppMxva1YHxsLMRUaeuMEt97AouyIGPxcIEGYFqC7k
         aHsc45DMr7a9noFghRa5fjSv85O/hICwh4VvpAlvMcyNu9EeaLbych9hBmwmN2JTWq49
         98GFOouOV3WQvqZfAiqVHEODm5c58Q6mlQl526lIEnVx1pq5CCAlqUUIr7yR3ofgvTTY
         nfbg==
X-Gm-Message-State: AOAM531njX578jvdqGuCPX78lGYhKUFzH5ZCnPbuH5rw1y8UMFBOEMvd
        UbFrER/ZR6RnNY+W/FROQUG3iw897GKH33Go7DmwhENC08g=
X-Google-Smtp-Source: ABdhPJxz0i3yqCU2nccIyMbrYSoLimcj5YLlFyqjOww+uKnb0rkz2vigOE1VXXZg23a3Rxfh6CpMnfQ4rvHEJXzxip8=
X-Received: by 2002:a05:6e02:1a8e:: with SMTP id k14mr12471342ilv.275.1608463977040;
 Sun, 20 Dec 2020 03:32:57 -0800 (PST)
MIME-Version: 1.0
References: <20201220044608.1258123-1-shakeelb@google.com>
In-Reply-To: <20201220044608.1258123-1-shakeelb@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 20 Dec 2020 13:32:46 +0200
Message-ID: <CAOQ4uxi4b-zXfWhLNQ+aGWn2qG3vqMCjkJnhrugc0+oER1EjUA@mail.gmail.com>
Subject: Re: [PATCH v2] inotify, memcg: account inotify instances to kmemcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 20, 2020 at 6:46 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> Currently the fs sysctl inotify/max_user_instances is used to limit the
> number of inotify instances on the system. For systems running multiple
> workloads, the per-user namespace sysctl max_inotify_instances can be
> used to further partition inotify instances. However there is no easy
> way to set a sensible system level max limit on inotify instances and
> further partition it between the workloads. It is much easier to charge
> the underlying resource (i.e. memory) behind the inotify instances to
> the memcg of the workload and let their memory limits limit the number
> of inotify instances they can create.
>
> With inotify instances charged to memcg, the admin can simply set
> max_user_instances to INT_MAX and let the memcg limits of the jobs limit
> their inotify instances.
>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v1:
> - introduce fsnotify_alloc_user_group() and convert fanotify in addition
>   to inotify to use that function. [suggested by Amir]
>
>  fs/notify/fanotify/fanotify_user.c |  2 +-
>  fs/notify/group.c                  | 25 ++++++++++++++++++++-----
>  fs/notify/inotify/inotify_user.c   |  4 ++--
>  include/linux/fsnotify_backend.h   |  1 +
>  4 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 3e01d8f2ab90..7e7afc2b62e1 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -976,7 +976,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>                 f_flags |= O_NONBLOCK;
>
>         /* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
> -       group = fsnotify_alloc_group(&fanotify_fsnotify_ops);
> +       group = fsnotify_alloc_user_group(&fanotify_fsnotify_ops);
>         if (IS_ERR(group)) {
>                 free_uid(user);
>                 return PTR_ERR(group);
> diff --git a/fs/notify/group.c b/fs/notify/group.c
> index a4a4b1c64d32..ffd723ffe46d 100644
> --- a/fs/notify/group.c
> +++ b/fs/notify/group.c
> @@ -111,14 +111,12 @@ void fsnotify_put_group(struct fsnotify_group *group)
>  }
>  EXPORT_SYMBOL_GPL(fsnotify_put_group);
>
> -/*
> - * Create a new fsnotify_group and hold a reference for the group returned.
> - */
> -struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
> +static struct fsnotify_group *__fsnotify_alloc_group(
> +                               const struct fsnotify_ops *ops, gfp_t gfp)
>  {
>         struct fsnotify_group *group;
>
> -       group = kzalloc(sizeof(struct fsnotify_group), GFP_KERNEL);
> +       group = kzalloc(sizeof(struct fsnotify_group), gfp);
>         if (!group)
>                 return ERR_PTR(-ENOMEM);
>
> @@ -139,8 +137,25 @@ struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
>
>         return group;
>  }
> +
> +/*
> + * Create a new fsnotify_group and hold a reference for the group returned.
> + */
> +struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
> +{
> +       return __fsnotify_alloc_group(ops, GFP_KERNEL);
> +}
>  EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
>
> +/*
> + * Create a new fsnotify_group and hold a reference for the group returned.
> + */
> +struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops)
> +{
> +       return __fsnotify_alloc_group(ops, GFP_KERNEL_ACCOUNT);
> +}
> +EXPORT_SYMBOL_GPL(fsnotify_alloc_user_group);
> +
>  int fsnotify_fasync(int fd, struct file *file, int on)
>  {
>         struct fsnotify_group *group = file->private_data;
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 59c177011a0f..266d17e8ecb9 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -632,11 +632,11 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
>         struct fsnotify_group *group;
>         struct inotify_event_info *oevent;
>
> -       group = fsnotify_alloc_group(&inotify_fsnotify_ops);
> +       group = fsnotify_alloc_user_group(&inotify_fsnotify_ops);
>         if (IS_ERR(group))
>                 return group;
>
> -       oevent = kmalloc(sizeof(struct inotify_event_info), GFP_KERNEL);
> +       oevent = kmalloc(sizeof(struct inotify_event_info), GFP_KERNEL_ACCOUNT);
>         if (unlikely(!oevent)) {
>                 fsnotify_destroy_group(group);
>                 return ERR_PTR(-ENOMEM);
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index a2e42d3cd87c..e5409b83e731 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -470,6 +470,7 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
>
>  /* create a new group */
>  extern struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops);
> +extern struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops);
>  /* get reference to a group */
>  extern void fsnotify_get_group(struct fsnotify_group *group);
>  /* drop reference on a group from fsnotify_alloc_group */
> --
> 2.29.2.684.gfbc64c5ab5-goog
>
