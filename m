Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42843A9602
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 11:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhFPJZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFPJZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:25:42 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A26C061574;
        Wed, 16 Jun 2021 02:23:36 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id s19so2297457ioc.3;
        Wed, 16 Jun 2021 02:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2kVLciPDPeVeRcKFf/sRj4Adpof6AaDamoTAcluhdG8=;
        b=mUoWcsrTuZOUX086t0rGiPboCUaC3kh2gARt9HxRHhiTRx28G+gTre2cHB4uOXxLvc
         cQy1tddI6uE1brKPVsLhD6dgwI67ui7g0aubwdw4EMEhF9Yx5e2WjrZlrQXwhzB5wV8g
         PQSgB2Wpjn0TMUozpoPF1Fe+eb5ILtK55CCQghMEAq0ccUMt/iRXyraqf/rw2kMqv1ff
         SOdGrZWXoD9lc5bzfvaVjKdF15YcYKMoS/d3ftXS7G+N2RolHJWqfexoygN81Ulgmw7w
         ZSv92WT6X/WHd6xiZBqUzMT+5umPRUiHUPjYOqejxUhe6nNMirK7upisL6gnph1YQ5Ko
         cV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kVLciPDPeVeRcKFf/sRj4Adpof6AaDamoTAcluhdG8=;
        b=HzwLYpMB+oey34Ww6EX4ThL1OGAuYNJUj2ykLODjm/SaBuZTKF0s8yiAlMcPTj70He
         ldXJo1a9TBfisxfptON2/pGSmnBR3rLXIDfLFxyAGXtOk07SIDszN3um6U8TQQB9WxjZ
         5g8+yAM7naPFEBnqW7D6yvtB7DKrSLmIrbsglU1fYzLTlg7h6NzpD60c6ZCu+B28oAAK
         OuJT0cKFvJcg2iLK4J8+N342Fs0bKwloyPef5DcuIFEyJRMd6JsFJW2KgWCHq+yT4yev
         t0OTea6LZfdPW5kMnFymrgxPv0tmIHL/0i0rwbhIwWKVy14mHqlPIlm+fyih9ooq0DOe
         pEww==
X-Gm-Message-State: AOAM532ZKeA/JEtva5LCQ7vL4O6D1WnWLMMZvNUrdk3OEUCmj11yvOpi
        xOl0HuuromGoEbgiBS/ON2b/GkpmRRQsW3WPP9g=
X-Google-Smtp-Source: ABdhPJxy/ByhjwoswMs6q2WVL/+nf/RAYiITJqrTk2W7vUeUUYt6TJ/xmrOUkaBe91EOWRXP8OMz8rwzuRC3UKEilcw=
X-Received: by 2002:a02:908a:: with SMTP id x10mr3270285jaf.30.1623835415523;
 Wed, 16 Jun 2021 02:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210615235556.970928-1-krisman@collabora.com> <20210615235556.970928-7-krisman@collabora.com>
In-Reply-To: <20210615235556.970928-7-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 16 Jun 2021 12:23:24 +0300
Message-ID: <CAOQ4uxh08gJjqi7Opoxp3D4Nf9S6n+81z8ay_UgTRdRB7mmZjw@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] fsnotify: Add helper to detect overflow_event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel@collabora.com, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 2:56 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Similarly to fanotify_is_perm_event and friends, provide a helper
> predicate to say whether a mask is of an overflow event.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks!

>  fs/notify/fanotify/fanotify.h    | 3 ++-
>  include/linux/fsnotify_backend.h | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index aec05e21d5a9..7e00c05a979a 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -326,7 +326,8 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
>   */
>  static inline bool fanotify_is_hashed_event(u32 mask)
>  {
> -       return !fanotify_is_perm_event(mask) && !(mask & FS_Q_OVERFLOW);
> +       return !(fanotify_is_perm_event(mask) ||
> +                fsnotify_is_overflow_event(mask));
>  }
>
>  static inline unsigned int fanotify_event_hash_bucket(
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index c4473b467c28..f9e2c6cd0f7d 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -495,6 +495,11 @@ static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
>         fsnotify_add_event(group, group->overflow_event, NULL, NULL);
>  }
>
> +static inline bool fsnotify_is_overflow_event(u32 mask)
> +{
> +       return mask & FS_Q_OVERFLOW;
> +}
> +
>  static inline bool fsnotify_notify_queue_is_empty(struct fsnotify_group *group)
>  {
>         assert_spin_locked(&group->notification_lock);
> --
> 2.31.0
>
