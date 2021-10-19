Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE3A432D51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 07:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhJSFk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 01:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJSFk6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:40:58 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E6FC06161C;
        Mon, 18 Oct 2021 22:38:46 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y17so17271004ilb.9;
        Mon, 18 Oct 2021 22:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AKoR6nDtBITkicn4Nsiqe7KOgtlnc41dLY9bS/3EslA=;
        b=RNBbkqGQMrDQ++ons7iVuAt+XSLzJicCHGnnvj5yU1mPrR3pkixrnWut0EE4h2w3Yo
         2pRPne3RSqvUTimUgKTnMlBeAprcrc6GB3lQLXZAW/u69vWe+hIp82x9IUCgauPYgn5I
         FigYGbwN6+PiGT67qs+cnqZ2XKN3YInQm8inwGHhXhA+KHtWCaGI/wjD1lulsbA/8RwK
         NgL3wt8lWyX+FIFW2FP9lrpq0uPmYSu+8WjNbZY1tnLIffAVUvoM1JfEpYhne4C/+WEi
         nUiT/0sauGTZa+JvIHRffVV9F/Egf8mLNFuvkPu4jPl8Ct7vosq8oK2838Uu1BirExdm
         JvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKoR6nDtBITkicn4Nsiqe7KOgtlnc41dLY9bS/3EslA=;
        b=NrXucqgLpXq4cPMnVJdjJqO4LyMJWEK7ScBILwHoxyf51M2P3L4ztdhdzSL95etHXs
         14ECPN51HAqmNFQo4lGvlzDPtaG93Ht70+UD73mOkyH3u/0t2BtKn6KHyiyZLw1hwGi4
         68Q8KkXx90gIVngbXunQ3WdkAcMkyO4G5S+0H1fhpuPqDULqacXnytdUxyoCkEwhSMoz
         adpqL/uvRVq9QZK1WOgmiFqfBbaslu+wEEreb3ijBT1sORg4dpLsyYpu1sT7j5uu0zOR
         24sO6DYUDbQYYeLQXntJNPwve7dqn/HQcFT2rHykiZmHSDbUcQwSpi3kbGQUqBMLC1hz
         pyYQ==
X-Gm-Message-State: AOAM5301Rk/Q9D6P3KIfTBVHDua1I4BlpL8X3W8s2QrDcfvRmwNAuBnA
        qCUTuDkIiJFO3v0J5hVC/MaFOt0sqNSDaDMA4Ms=
X-Google-Smtp-Source: ABdhPJzmC3B6lIPEDXFUIlJZ1P+amZUcANtXUfOsUu05dCCHKmVNET7uoDucJJ/8RkOkpjYBd2tujiz+MsDUG5YUELk=
X-Received: by 2002:a05:6e02:1b04:: with SMTP id i4mr17450172ilv.319.1634621925579;
 Mon, 18 Oct 2021 22:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211019000015.1666608-1-krisman@collabora.com> <20211019000015.1666608-20-krisman@collabora.com>
In-Reply-To: <20211019000015.1666608-20-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Oct 2021 08:38:34 +0300
Message-ID: <CAOQ4uxgpgNqA1CUUuytbwuxNJepvARMjMPAhi3WTXcCxtkMCmA@mail.gmail.com>
Subject: Re: [PATCH v8 19/32] fanotify: Pre-allocate pool of error events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 3:03 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Pre-allocate slots for file system errors to have greater chances of
> succeeding, since error events can happen in GFP_NOFS context.  This
> patch introduces a group-wide mempool of error events, shared by all
> FAN_FS_ERROR marks in this group.
>
> For now, just allocate 128 positions.  A future patch allows this
> array to be dynamically resized when a new mark is added.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v7:
>   - Expand limit to 128. (Amir)

I am not sure if Jan was also on board with this request but otherwise

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

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
> index 66ee3c2805c7..f77581c5b97f 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -30,6 +30,7 @@
>  #define FANOTIFY_DEFAULT_MAX_EVENTS    16384
>  #define FANOTIFY_OLD_DEFAULT_MAX_MARKS 8192
>  #define FANOTIFY_DEFAULT_MAX_GROUPS    128
> +#define FANOTIFY_DEFAULT_MAX_FEE_POOL  128
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
> +                                        FANOTIFY_DEFAULT_MAX_FEE_POOL,
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
> index a378a314e309..9941c06b8c8a 100644
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
> @@ -245,6 +246,7 @@ struct fsnotify_group {
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
