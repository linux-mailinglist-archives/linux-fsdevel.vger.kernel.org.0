Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B0242E8D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 08:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhJOGWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 02:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhJOGWF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:22:05 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1427FC061570;
        Thu, 14 Oct 2021 23:20:00 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y67so6518685iof.10;
        Thu, 14 Oct 2021 23:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Urk/B2tjY6GfH9QPDDKjsAPCFKGDEtqV8itWDx5+oYU=;
        b=QBM7LeV+Q42CxqQhd+wZZTIsQKOdGsj4lvJ2RIiq0VptP5aNvT5GWwBtEu9ojKkS2f
         WfDs7ETuQJTyqioE5/bHOKX/8OqCA2sL3a2HRZTY+RBGNT8VNDMX4Km+raWulvI79R/j
         ImWJcFfi7rX9sbts4Mi4uGKAOYNOHYwegPffwstjtpiTDW9IAxd6kt9s0f6MdbocEpOC
         lqEVNHDeJDVW2xwHNTYmsOXuJ8knfUTrKgR5fJcYZ3hwd4/W6lK1AsgX8lh2jR+/gyfl
         yQESVgbZjmZ/vkPjlUk2fEAhXGrVK/2OrfxFTHN2qqUQaiuEYQWX8bQ2RyIZbdQZKMt2
         2AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Urk/B2tjY6GfH9QPDDKjsAPCFKGDEtqV8itWDx5+oYU=;
        b=ens37bdspEew9A0xLB1WMSIxIVjVaxZoXSIZ60pmy81NPO4Y78mzqIBG/pv9m03Abs
         vKIVmd62PmodrvRUwWtS7RKnr3rBJvMgViUv5mZOMAsixgqjT3hdXlrB77iBp4wwlai2
         OJ4Zy7lDWZQo3TbBdY/FJzhlpg7ubr1mK/plw5svfKTK8ySSOGBOdnssn0t07B9nzbv3
         HV2W04thjtbrbwU0lBExuQw5tqBy5fcpsuepIvMlcj/9l2iyjJrKvQgBjLxbXOCmjWKd
         I6Gm99s/L6SYnfHnHQzyjRFUqmK2TcTtZgOmdpH/XutE5DqpSZLJUXbHxyzFM6Fwrm1g
         z0pg==
X-Gm-Message-State: AOAM5317ZW3xbV0lWuQiS4UgrsSaqBo+GFBm8PvPNvNLuowFw24Qauvv
        g0m/R8MJuOjkc78cDzsEI9oVAHm8OWBLzn0+soAaNHRe
X-Google-Smtp-Source: ABdhPJxOt5QLWNOSitCSIdNTuhL6YUTA0JxB69dwPTAEBKaKNfEO4C/4bqg/AQQxwt+DYobsqiqkwlSulpWAR+Isfyc=
X-Received: by 2002:a02:6987:: with SMTP id e129mr7194652jac.136.1634278799439;
 Thu, 14 Oct 2021 23:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com> <20211014213646.1139469-19-krisman@collabora.com>
In-Reply-To: <20211014213646.1139469-19-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 09:19:48 +0300
Message-ID: <CAOQ4uxh+Xt5xrL7WgNVWxdigBRhR-HCixiUsAQvUT7L87TzTNg@mail.gmail.com>
Subject: Re: [PATCH v7 18/28] fanotify: Pre-allocate pool of error events
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

On Fri, Oct 15, 2021 at 12:39 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Error reporting needs to be done in an atomic context.  This patch
> introduces a group-wide mempool of error events, shared by all
> marks in this group.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
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
> index 66ee3c2805c7..f1cf863d6f9f 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -30,6 +30,7 @@
>  #define FANOTIFY_DEFAULT_MAX_EVENTS    16384
>  #define FANOTIFY_OLD_DEFAULT_MAX_MARKS 8192
>  #define FANOTIFY_DEFAULT_MAX_GROUPS    128
> +#define FANOTIFY_DEFAULT_FEE_POOL      32
>

We can probably start with a more generous pool (128?)
It doesn't cost that much.
But anyway, I think this pool needs to auto-grow (up to a maximum size)
instead of having a rigid arbitrary limit.

Thanks,
Amir.
