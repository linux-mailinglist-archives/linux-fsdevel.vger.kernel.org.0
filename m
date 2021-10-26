Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279FE43ACB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 09:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhJZHMX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 03:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhJZHMS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:12:18 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F863C061745;
        Tue, 26 Oct 2021 00:09:55 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id m184so112102iof.1;
        Tue, 26 Oct 2021 00:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qXfIahzZjO8wVgjHQ0K86FMC26cKc3jAQsamr0uQOk=;
        b=OShLWQy9mKnBef0AvcV6XVjTEkykEz6s4DNff8hWKWoTTK3fszdXiRIC3rx6zDJRM/
         p6n97/7r4e30HdQD3F3GsHxd87uCFW0JH2sFm4Bry0BBWb4I+ubxfow56N1vs1pIre3Y
         WLHW6ZHTUQYyOk0romp3hXg0X4xgSjU6dAwYwWKtQgpJ67KRSdEExQrpUkw8E/PmQXf0
         9ZkLm0UH3UfyE85tkYp3Rujd2qpfuhhUertdcoBbLpNgQwU/JNhAZo7+OxEIe1jSmPAh
         Vrcvk1vj5CayDiHgHEcVf6aJhuG0G0dDYqghZ+I7G4mr/r2uImIrq9AJeeViUkU+gMLB
         PSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qXfIahzZjO8wVgjHQ0K86FMC26cKc3jAQsamr0uQOk=;
        b=xIMhW1cBnQT/flgztwDr6c7d4WLtvCATt+3hulTTYqZa6jmhDAvlNN3G9+3vxmGs8O
         1lLA/aXOyQJa3vx9wjW7raFnmRwydsZbVxXWzX5SQKCWwNzxjj5acOfaCpSnHt87cwUZ
         lC/v2SWY4Jc8JQJUnkJLzqHf9atSSwq7pQleYcWA1V1cnnfkkoL0TVw4bLrEn0wJYaMw
         20dhtln6taJqQJS+d8MVNWYVuJ7Y5AOxqX9g5jI6FtcZ56r5gJ9Yp5HBrtg9Bwr0ETQK
         PS/A1pFTFAXuEP5oQyvh0rNsFySIvErKVRe8Vyqi+0ySUwoF0tinUUDAEUJ6f50tGVah
         gWqQ==
X-Gm-Message-State: AOAM530Ztean32S7swBionDeVbTXQnCpuWQXMks8tWVF5c6XlFSfy1sP
        1WjsMFBWXwgZFTZomTzhpiP/dI9hbC/PMbKilZQ=
X-Google-Smtp-Source: ABdhPJx1+3p8HqO6kfPYYMvqy0Hcs72BzmskYTqnoaxID/W9wkQkmtvzRc7+j9lDNR3q5KwSxcqTJ5q6L+GpzP2WvDo=
X-Received: by 2002:a02:624c:: with SMTP id d73mr14392209jac.32.1635232194855;
 Tue, 26 Oct 2021 00:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211025192746.66445-1-krisman@collabora.com> <20211025192746.66445-20-krisman@collabora.com>
In-Reply-To: <20211025192746.66445-20-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Oct 2021 10:09:43 +0300
Message-ID: <CAOQ4uxjOvHCfZtNTQ7P_v5Zy8eX8Oa-hZyxkoxArAYDeZoG7AQ@mail.gmail.com>
Subject: Re: [PATCH v9 19/31] fanotify: Pre-allocate pool of error events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 10:30 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Pre-allocate slots for file system errors to have greater chances of
> succeeding, since error events can happen in GFP_NOFS context.  This
> patch introduces a group-wide mempool of error events, shared by all
> FAN_FS_ERROR marks in this group.
>
> For now, just allocate 128 positions.  A future patch allows this
> array to be dynamically resized when a new mark is added.

This phrase is out dated.
No need to re-post entire v10 series just for that.
You may suggest the re-phrase here.

Thanks,
Amir.

>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v8:
>   - FANOTIFY_DEFAULT_MAX_FEE_POOL -> FANOTIFY_DEFAULT_FEE_POOL_SIZE
>   - Reduce limit to 32. (Jan)
> Changes since v7:
>   - Expand limit to 128. (Amir)
> ---
>  fs/notify/fanotify/fanotify.c      |  3 +++
>  fs/notify/fanotify/fanotify.h      | 11 +++++++++++
>  fs/notify/fanotify/fanotify_user.c | 26 +++++++++++++++++++++++++-
>  include/linux/fsnotify_backend.h   |  2 ++
>  4 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 8f152445d75c..01d68dfc74aa 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -819,6 +819,9 @@ static void fanotify_free_group_priv(struct fsnotify_group *group)
>         if (group->fanotify_data.ucounts)
>                 dec_ucount(group->fanotify_data.ucounts,
>                            UCOUNT_FANOTIFY_GROUPS);
> +
> +       if (mempool_initialized(&group->fanotify_data.error_events_pool))
> +               mempool_exit(&group->fanotify_data.error_events_pool);
>  }
>
>  static void fanotify_free_path_event(struct fanotify_event *event)
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index c42cf8fd7d79..a577e87fac2b 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -141,6 +141,7 @@ enum fanotify_event_type {
>         FANOTIFY_EVENT_TYPE_PATH,
>         FANOTIFY_EVENT_TYPE_PATH_PERM,
>         FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
> +       FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
>         __FANOTIFY_EVENT_TYPE_NUM
>  };
>
> @@ -196,6 +197,16 @@ FANOTIFY_NE(struct fanotify_event *event)
>         return container_of(event, struct fanotify_name_event, fae);
>  }
>
> +struct fanotify_error_event {
> +       struct fanotify_event fae;
> +};
> +
> +static inline struct fanotify_error_event *
> +FANOTIFY_EE(struct fanotify_event *event)
> +{
> +       return container_of(event, struct fanotify_error_event, fae);
> +}
> +
>  static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
>  {
>         if (event->type == FANOTIFY_EVENT_TYPE_FID)
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 66ee3c2805c7..2f4182b754b2 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -30,6 +30,7 @@
>  #define FANOTIFY_DEFAULT_MAX_EVENTS    16384
>  #define FANOTIFY_OLD_DEFAULT_MAX_MARKS 8192
>  #define FANOTIFY_DEFAULT_MAX_GROUPS    128
> +#define FANOTIFY_DEFAULT_FEE_POOL_SIZE 32
>
>  /*
>   * Legacy fanotify marks limits (8192) is per group and we introduced a tunable
> @@ -1054,6 +1055,15 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>         return ERR_PTR(ret);
>  }
>
> +static int fanotify_group_init_error_pool(struct fsnotify_group *group)
> +{
> +       if (mempool_initialized(&group->fanotify_data.error_events_pool))
> +               return 0;
> +
> +       return mempool_init_kmalloc_pool(&group->fanotify_data.error_events_pool,
> +                                        FANOTIFY_DEFAULT_FEE_POOL_SIZE,
> +                                        sizeof(struct fanotify_error_event));
> +}
>
>  static int fanotify_add_mark(struct fsnotify_group *group,
>                              fsnotify_connp_t *connp, unsigned int type,
> @@ -1062,6 +1072,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>  {
>         struct fsnotify_mark *fsn_mark;
>         __u32 added;
> +       int ret = 0;
>
>         mutex_lock(&group->mark_mutex);
>         fsn_mark = fsnotify_find_mark(connp, group);
> @@ -1072,13 +1083,26 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>                         return PTR_ERR(fsn_mark);
>                 }
>         }
> +
> +       /*
> +        * Error events are pre-allocated per group, only if strictly
> +        * needed (i.e. FAN_FS_ERROR was requested).
> +        */
> +       if (!(flags & FAN_MARK_IGNORED_MASK) && (mask & FAN_FS_ERROR)) {
> +               ret = fanotify_group_init_error_pool(group);
> +               if (ret)
> +                       goto out;
> +       }
> +
>         added = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
>         if (added & ~fsnotify_conn_mask(fsn_mark->connector))
>                 fsnotify_recalc_mask(fsn_mark->connector);
> +
> +out:
>         mutex_unlock(&group->mark_mutex);
>
>         fsnotify_put_mark(fsn_mark);
> -       return 0;
> +       return ret;
>  }
>
>  static int fanotify_add_vfsmount_mark(struct fsnotify_group *group,
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 00dbaafbcf95..51ef2b079bfa 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -19,6 +19,7 @@
>  #include <linux/atomic.h>
>  #include <linux/user_namespace.h>
>  #include <linux/refcount.h>
> +#include <linux/mempool.h>
>
>  /*
>   * IN_* from inotfy.h lines up EXACTLY with FS_*, this is so we can easily
> @@ -246,6 +247,7 @@ struct fsnotify_group {
>                         int flags;           /* flags from fanotify_init() */
>                         int f_flags; /* event_f_flags from fanotify_init() */
>                         struct ucounts *ucounts;
> +                       mempool_t error_events_pool;
>                 } fanotify_data;
>  #endif /* CONFIG_FANOTIFY */
>         };
> --
> 2.33.0
>
