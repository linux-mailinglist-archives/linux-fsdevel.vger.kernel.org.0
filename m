Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B47843AC90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 09:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhJZHFW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 03:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhJZHFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:05:20 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3285C061745;
        Tue, 26 Oct 2021 00:02:57 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z69so18840225iof.9;
        Tue, 26 Oct 2021 00:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqrMvDSGmgeDoEvwt9n0yNpgDU+ylvvpv0ZSDn/6Py0=;
        b=dO5Dwi6GjaSyp4RB7QN7zcbJ8CXsNT3OsEgKcwUWZyP3YLLrVVWnhx7VQk6zUcwUcN
         t3Nljsykrvzgr21iAh/l5+45NgQly5lEXsd8ZkTN9IIfO7VcBfC34mdQxxJs49sHjFYQ
         +kuXZD9hbBVhjgdj8jWbg54xAmXDry68oB7OmY/UgqX/VN4qQR+GcbKeniRezVhVA48y
         7aXWPGOWrjep3OURqerek/oT6JC4BodmUBwbsNFo9yS6Yg4dDcE5PgH3mYnmPw9gS+ZE
         +Hy8MnQKoyPR0DPQ2wiy+eP5vNMbx06VEQoRaQNu32KBEu3EknEsntGEQ/SHx0rdHyH2
         xERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqrMvDSGmgeDoEvwt9n0yNpgDU+ylvvpv0ZSDn/6Py0=;
        b=KXJsh42P00O/YKp2S/Rypc8dunBvHuhcRL9aEGlLbOfGbPfMspAVP+XJOqOVHPQamr
         DspNCNdc8a3z8FXiThC/oenDBbTAyl7DgXdXVIbNv1XIb+z2xaZqkz5qHsdWGG/bUzyG
         8WQ0HUPImqUzZ2AsRxCgqIkR8a2s6s4BhUOud0PKAue54Rd/bd2wOEWpwIltVV3T59qi
         lXlUAoAQuENwc8pXfyyvROIn2AH9NeXdunQB7OQZSpQGsZZEz1pVg2aMDQHvzExv69ad
         cegsF9QESj4mST8vuVjh8k+YtZYx0IgMqk5KUkgYMSUgGKIvw9kSU2E/r88/oaQpizJ0
         thKw==
X-Gm-Message-State: AOAM533tayBBxzle8PTn/waWwIF326B20ng0I41OTJuSJFHjTWPN8q53
        JCJWJ2yBP8b3fCoR+j8agcQdeieaLNa1AgrAg9M=
X-Google-Smtp-Source: ABdhPJw51TtHWk1hUOE+CWGkUYNAAg8CIWqMVhO9sjnQTL5RJ5AXo8CbZYVx8KjezTpZxwv7BlXYmPEOSRt3tYFnADI=
X-Received: by 2002:a5d:8792:: with SMTP id f18mr13692155ion.52.1635231776948;
 Tue, 26 Oct 2021 00:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211025192746.66445-1-krisman@collabora.com> <20211025192746.66445-24-krisman@collabora.com>
In-Reply-To: <20211025192746.66445-24-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Oct 2021 10:02:46 +0300
Message-ID: <CAOQ4uxi9HfMZFLb4joE42AZeVAZPDPPJRREaUdrKwhoQsuRHrQ@mail.gmail.com>
Subject: Re: [PATCH v9 23/31] fanotify: Add helpers to decide whether to
 report FID/DFID
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
> Now that there is an event that reports FID records even for a zeroed
> file handle, wrap the logic that deides whether to issue the records
> into helper functions.  This shouldn't have any impact on the code, but
> simplifies further patches.
>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v8:
>   - Simplify constructs (Amir)
> ---
>  fs/notify/fanotify/fanotify.h      | 10 ++++++++++
>  fs/notify/fanotify/fanotify_user.c | 13 +++++++------
>  2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 3510d06654ed..80af269eebb8 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -264,6 +264,16 @@ static inline int fanotify_event_dir_fh_len(struct fanotify_event *event)
>         return info ? fanotify_info_dir_fh_len(info) : 0;
>  }
>
> +static inline bool fanotify_event_has_object_fh(struct fanotify_event *event)
> +{
> +       return fanotify_event_object_fh_len(event) > 0;
> +}
> +
> +static inline bool fanotify_event_has_dir_fh(struct fanotify_event *event)
> +{
> +       return fanotify_event_dir_fh_len(event) > 0;
> +}
> +
>  struct fanotify_path_event {
>         struct fanotify_event fae;
>         struct path path;
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 2f4182b754b2..a9b5c36ee49e 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -140,10 +140,9 @@ static size_t fanotify_event_len(unsigned int info_mode,
>                 return event_len;
>
>         info = fanotify_event_info(event);
> -       dir_fh_len = fanotify_event_dir_fh_len(event);
> -       fh_len = fanotify_event_object_fh_len(event);
>
> -       if (dir_fh_len) {
> +       if (fanotify_event_has_dir_fh(event)) {
> +               dir_fh_len = fanotify_event_dir_fh_len(event);
>                 event_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
>         } else if ((info_mode & FAN_REPORT_NAME) &&
>                    (event->mask & FAN_ONDIR)) {
> @@ -157,8 +156,10 @@ static size_t fanotify_event_len(unsigned int info_mode,
>         if (info_mode & FAN_REPORT_PIDFD)
>                 event_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
>
> -       if (fh_len)
> +       if (fanotify_event_has_object_fh(event)) {
> +               fh_len = fanotify_event_object_fh_len(event);
>                 event_len += fanotify_fid_info_len(fh_len, dot_len);
> +       }
>
>         return event_len;
>  }
> @@ -451,7 +452,7 @@ static int copy_info_records_to_user(struct fanotify_event *event,
>         /*
>          * Event info records order is as follows: dir fid + name, child fid.
>          */
> -       if (fanotify_event_dir_fh_len(event)) {
> +       if (fanotify_event_has_dir_fh(event)) {
>                 info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
>                                              FAN_EVENT_INFO_TYPE_DFID;
>                 ret = copy_fid_info_to_user(fanotify_event_fsid(event),
> @@ -467,7 +468,7 @@ static int copy_info_records_to_user(struct fanotify_event *event,
>                 total_bytes += ret;
>         }
>
> -       if (fanotify_event_object_fh_len(event)) {
> +       if (fanotify_event_has_object_fh(event)) {
>                 const char *dot = NULL;
>                 int dot_len = 0;
>
> --
> 2.33.0
>
