Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938C636BE8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 06:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhD0EnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 00:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbhD0EnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:43:20 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A745C061574;
        Mon, 26 Apr 2021 21:42:38 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id t21so7546505iob.2;
        Mon, 26 Apr 2021 21:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EzSe38NJjrCvosP/G6D4PJaz045LslJADhZl0Vyj2/E=;
        b=qWk7oZvNsF5EgbGk6j9nzCrBtUiofXrtCMUQ3l09zo+Mf6GRFAcjwaKCowYR/+ZsO1
         veKJBI0kwyFCeSUd7I4WYKnNfK+C9cGYnDHk4OL5lo3leGvq1S7RONH7APV/ipC6wf4m
         cZALgfdXTgdESYUrYU4mhcvHf46sDlGiQjPUOIKlxK6fllS32sGgPneK1968aAH8yE2M
         Phv1W+hBx5pE/Bh9389gbc7QDN1S17gj2of9EWIje7nPiew9StwbvkQsUGacveX2qhVE
         62Jf0vXdBXIFiqFITB2FZSZyXvxUgxvmYyNdWnxrcx6CjdHk4y8R7WdvWOKZb8qOzcAZ
         hPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EzSe38NJjrCvosP/G6D4PJaz045LslJADhZl0Vyj2/E=;
        b=LwoN9zJ9tEXOua5QqGwg6FDXq/hnrOTnRYoI6a2aIVVKC3nrnaCt6wEwHBbX0j1oZO
         M/Yx+vjdsvpPBkhtstf6ZjKLV9jzLMhxWG8mjjQt7r4UW1fJgdpe5fi3okbfMaJWIZfd
         UH91D2w+O8IrqoWGe70ODwYHswvBmpqo9NjgYhIi6z6JlhTaiN8abt8lQx1D/hecfR+M
         PzVyJkzjWUVOsm5duFQCfB72Gx2P8hAmNYKjm2bH0vNLu2lU8nyActdmsiZ0VXK9veHD
         qbnZIwRWRNx6KNjiWFQxOpQfHUwRpJhteYU2vA9OxRCl7Fh9Ca6LuPIt3sasPzKPMzyS
         HqCA==
X-Gm-Message-State: AOAM533fAjvifxaxwD7Nk2ietFJ6KwDcDTdo+VxhgvokLnRhkC5Onhb+
        NomGo41hk+heWsSfCMOtskfXd4sFrpH7RFS80is=
X-Google-Smtp-Source: ABdhPJyh6lu2y8THwj6O+gzhUftnojOyzxw5viTBcrBGXcc8d1impNAPSnw7ACcCDq8WrbmGyIadDCYSu1GFFM3zFNM=
X-Received: by 2002:a6b:f115:: with SMTP id e21mr17625161iog.5.1619498558076;
 Mon, 26 Apr 2021 21:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com> <20210426184201.4177978-2-krisman@collabora.com>
In-Reply-To: <20210426184201.4177978-2-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 07:42:27 +0300
Message-ID: <CAOQ4uxhAMaWFmHw-s_n+Hdad9jkDR8KD6bOYiQQV6RWMv+_TbA@mail.gmail.com>
Subject: Re: [PATCH RFC 01/15] fanotify: Fold event size calculation to its
 own function
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
> Every time this function is invoked, it is immediately added to
> FAN_EVENT_METADATA_LEN, since there is no need to just calculate the
> length of info records. This minor clean up folds the rest of the
> calculation into the function, which now operates in terms of events,
> returning the size of the entire event, including metadata.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Nice

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fanotify/fanotify_user.c | 40 +++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 9e0c1afac8bd..0332c4afeec3 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -64,17 +64,24 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
>         return roundup(FANOTIFY_INFO_HDR_LEN + info_len, FANOTIFY_EVENT_ALIGN);
>  }
>
> -static int fanotify_event_info_len(unsigned int fid_mode,
> -                                  struct fanotify_event *event)
> +static size_t fanotify_event_len(struct fanotify_event *event,
> +                                unsigned int fid_mode)
>  {
> -       struct fanotify_info *info = fanotify_event_info(event);
> -       int dir_fh_len = fanotify_event_dir_fh_len(event);
> -       int fh_len = fanotify_event_object_fh_len(event);
> -       int info_len = 0;
> +       size_t event_len = FAN_EVENT_METADATA_LEN;
> +       struct fanotify_info *info;
> +       int dir_fh_len;
> +       int fh_len;
>         int dot_len = 0;
>
> +       if (!fid_mode)
> +               return event_len;
> +
> +       info = fanotify_event_info(event);
> +       dir_fh_len = fanotify_event_dir_fh_len(event);
> +       fh_len = fanotify_event_object_fh_len(event);
> +
>         if (dir_fh_len) {
> -               info_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
> +               event_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
>         } else if ((fid_mode & FAN_REPORT_NAME) && (event->mask & FAN_ONDIR)) {
>                 /*
>                  * With group flag FAN_REPORT_NAME, if name was not recorded in
> @@ -84,9 +91,9 @@ static int fanotify_event_info_len(unsigned int fid_mode,
>         }
>
>         if (fh_len)
> -               info_len += fanotify_fid_info_len(fh_len, dot_len);
> +               event_len += fanotify_fid_info_len(fh_len, dot_len);
>
> -       return info_len;
> +       return event_len;
>  }
>
>  /*
> @@ -98,7 +105,8 @@ static int fanotify_event_info_len(unsigned int fid_mode,
>  static struct fanotify_event *get_one_event(struct fsnotify_group *group,
>                                             size_t count)
>  {
> -       size_t event_size = FAN_EVENT_METADATA_LEN;
> +       size_t event_size;
> +       struct fsnotify_event *fse;
>         struct fanotify_event *event = NULL;
>         unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
>
> @@ -108,16 +116,15 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
>         if (fsnotify_notify_queue_is_empty(group))
>                 goto out;
>
> -       if (fid_mode) {
> -               event_size += fanotify_event_info_len(fid_mode,
> -                       FANOTIFY_E(fsnotify_peek_first_event(group)));
> -       }
> +       fse = fsnotify_peek_first_event(group);
> +       event = FANOTIFY_E(fse);
> +       event_size = fanotify_event_len(event, fid_mode);
>
>         if (event_size > count) {
>                 event = ERR_PTR(-EINVAL);
>                 goto out;
>         }
> -       event = FANOTIFY_E(fsnotify_remove_first_event(group));
> +       fsnotify_remove_queued_event(group, fse);
>         if (fanotify_is_perm_event(event->mask))
>                 FANOTIFY_PERM(event)->state = FAN_EVENT_REPORTED;
>  out:
> @@ -334,8 +341,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>
>         pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>
> -       metadata.event_len = FAN_EVENT_METADATA_LEN +
> -                               fanotify_event_info_len(fid_mode, event);
> +       metadata.event_len = fanotify_event_len(event, fid_mode);
>         metadata.metadata_len = FAN_EVENT_METADATA_LEN;
>         metadata.vers = FANOTIFY_METADATA_VERSION;
>         metadata.reserved = 0;
> --
> 2.31.0
>
