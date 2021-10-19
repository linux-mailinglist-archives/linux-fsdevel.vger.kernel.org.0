Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0750E432D6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 07:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhJSFwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 01:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhJSFwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:52:47 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2018C06161C;
        Mon, 18 Oct 2021 22:50:34 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id k3so17301323ilu.2;
        Mon, 18 Oct 2021 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nB2w38LzezW3Z/eG4neQ0XBbF97Fb0almr5Ic9daItI=;
        b=gnXToFv1a+cHok9KxBXiqbAxQqReTQM5WNapBiRddbUCDGERG8g3/AAlxNj0wVANVY
         9J6qmNFB07LU0WAcCynG1RfDUR7WznXuvw6OYBTL07QxZm/K3h+sKKbggnIC33boxk4o
         KxVe7MAAelmW44O3KVmBzQQmebbMC7dnxkO6SEzIyhy8wiedmBXPDo8Tr5Vmyi3qZnJv
         3tuMbhShEHWvN0s20L8xz5i9Xx6mB+LGHzzEeGyLymEDfwijl7hIJ2xN7Wkawi/tdbCD
         KWX4k8axYkw/jGt5IVx6WLF48kC1fcoBzfSFaU9qXMplq8jGua6GI42NEB4PCU1eVn/O
         k3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nB2w38LzezW3Z/eG4neQ0XBbF97Fb0almr5Ic9daItI=;
        b=rFe0Cyb9NRPu/jMw4rcb1LnExPmtsYIOeQn1wXy1IbSSbxqt9Dj4EHtjLj9uCMYSKF
         D2C10GwXS+Vt4kbCHiCYHegpho6aBOsr3/jBND0gEoTHc9ejApKtpx6NBdOMH7CYVj1E
         dwbbnstKIQRLya2Z1izFHTON2hDAZ5/pE0SkhN+H09pVkyQaZ5vAfrRrpC9JedCkw+1s
         NI3asi7wPHKfUwVsHXFVwWaRaRoNOHTAqchcvLiwZXaW8VJw5j88Zzv3P7StDOyrcp79
         NV+aYyNcLr1aYKZakyCCYEhhvmna80jX5GAxtIx06/VsRwc5gSfYc4e604qqw2ykKp4h
         X1zw==
X-Gm-Message-State: AOAM532Kdrb8s0AYrmfhBjy/CF0ynGgeYAadbidCqO1HQskvZk4zKLgh
        PGCDCDbxtiapvUIwZwvpyRtKu/lDLRsfnRwjU2j5evKF
X-Google-Smtp-Source: ABdhPJywTCTOSYY4Qdeq+f8bFlsLBdwWXSWwS/5i6K1gtrA3+F7ZXF89Ny3DltDPJ6fJHqgP0eoNPn6/9g3yD1IAWjo=
X-Received: by 2002:a05:6e02:160e:: with SMTP id t14mr17780921ilu.107.1634622634211;
 Mon, 18 Oct 2021 22:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211019000015.1666608-1-krisman@collabora.com> <20211019000015.1666608-21-krisman@collabora.com>
In-Reply-To: <20211019000015.1666608-21-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Oct 2021 08:50:23 +0300
Message-ID: <CAOQ4uxi3C7MQxGPc1fD8ZyRTkyJZQac3_M-0aGYzPKbJ6AK8Jg@mail.gmail.com>
Subject: Re: [PATCH v8 20/32] fanotify: Dynamically resize the FAN_FS_ERROR pool
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
> Allow the FAN_FS_ERROR group mempool to grow up to an upper limit
> dynamically, instead of starting already at the limit.  This doesn't
> bother resizing on mark removal, but next time a mark is added, the slot
> will be either reused or resized.  Also, if several marks are being
> removed at once, most likely the group is going away anyway.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 26 +++++++++++++++++++++-----
>  include/linux/fsnotify_backend.h   |  1 +
>  2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index f77581c5b97f..a860c286e885 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -959,6 +959,10 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
>
>         removed = fanotify_mark_remove_from_mask(fsn_mark, mask, flags,
>                                                  umask, &destroy_mark);
> +
> +       if (removed & FAN_FS_ERROR)
> +               group->fanotify_data.error_event_marks--;
> +
>         if (removed & fsnotify_conn_mask(fsn_mark->connector))
>                 fsnotify_recalc_mask(fsn_mark->connector);
>         if (destroy_mark)
> @@ -1057,12 +1061,24 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>
>  static int fanotify_group_init_error_pool(struct fsnotify_group *group)
>  {
> -       if (mempool_initialized(&group->fanotify_data.error_events_pool))
> -               return 0;
> +       int ret;
> +
> +       if (group->fanotify_data.error_event_marks >=
> +           FANOTIFY_DEFAULT_MAX_FEE_POOL)
> +               return -ENOMEM;
>
> -       return mempool_init_kmalloc_pool(&group->fanotify_data.error_events_pool,
> -                                        FANOTIFY_DEFAULT_MAX_FEE_POOL,
> -                                        sizeof(struct fanotify_error_event));
> +       if (!mempool_initialized(&group->fanotify_data.error_events_pool))
> +               ret = mempool_init_kmalloc_pool(
> +                               &group->fanotify_data.error_events_pool,
> +                                1, sizeof(struct fanotify_error_event));
> +       else
> +               ret = mempool_resize(&group->fanotify_data.error_events_pool,
> +                                    group->fanotify_data.error_event_marks + 1);
> +
> +       if (!ret)
> +               group->fanotify_data.error_event_marks++;
> +
> +       return ret;
>  }

This is not what I had in mind.
I was thinking start with ~32 and double each time limit is reached.
And also, this code grows the pool to infinity with add/remove mark loop.

Anyway, since I clearly did not understand how mempool works and
Jan had some different ideas I would leave it to Jan to explain
how he wants the mempool init limit and resize to be implemented.

Thanks,
Amir.
