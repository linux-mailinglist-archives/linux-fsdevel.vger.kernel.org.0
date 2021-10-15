Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CD942EB2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 10:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhJOIN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 04:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbhJOINQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:13:16 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB90C061570;
        Fri, 15 Oct 2021 01:11:10 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id w10so6247379ilc.13;
        Fri, 15 Oct 2021 01:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zApZgTuclfrPVli+p5QDQmHfsbBsDrrid6Gn/lN1tuY=;
        b=CjGZWw6YWA8jHk+TNgeXu36l/6b36+Oj4GcknbPbMbwjgfHG47TLVXbBnpcGgMjUqo
         Rht3dnD7k+TF9dc8hH3GlOC/K2v4m5TB4a8kbLgNU9WnTtx3M4+kfH4EgcwZCqn8Oih0
         GGLCrJ6+tvi0lz6ZYXSN/F7nTpN20Go2oBrITreXiHYXSjKLK1OwLlBmqm8OzJY3F7qt
         aUtBEtt3wiL7iU1COvMW6Ae/3vaox/xDEbuEdgAR83tMudE0s26sv9IcGPnY/nAvLw77
         RgPeH0m5Ay1LfHRJcwkwJUrjxymfFjJL50Cw1L5T7xdZhnWAYXCo/saEVLoWxnwMZU7N
         qkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zApZgTuclfrPVli+p5QDQmHfsbBsDrrid6Gn/lN1tuY=;
        b=R0g7RpX0TWh0YWCk1UEHpuBZrmOQtdobkWcGznLvS5JEwpvRgMNqMIecGrNTb6FkaE
         YnDH6NTPu/+p/RUso3yvQhsmAmmRY48WFWMI6dPrIuge30hWJz5LtjQsZ4BQGcup7EhA
         X5kAcNLP7FC1cTCVT0E1B4vIHaArVjElu/d14cynjpNA0X3I3Q8uRBGHCQyFKi5GoA0Y
         Uf/yQKfrZjh6+qoMiIHjKcQunEfj5i6YwjvQcj30SJCstaTRhHaloUf3gcKeOdIm3hwA
         zChex1y6rO0RiJUkYD3Rg85oBl6HilAwfW4gyAX45qrudF5PH4fkY7dy84yJLzvVjzD2
         qqAA==
X-Gm-Message-State: AOAM531bFsIAZnvGeiYZVScjj+CqPZCTM4SOS5GIJIawbg8KjrS0crqa
        kRINSRTqruNneiBiZ4f41HPT7VTUacQZ2X9r1/E=
X-Google-Smtp-Source: ABdhPJyJtUo7icQo/KbCREbaARV5bBPGUXdH8jjaHJw4xTtWd8iPC16ATh9+uMrvnPACbFmn106IsOyn87hfVwJXJ/E=
X-Received: by 2002:a05:6e02:160e:: with SMTP id t14mr2952690ilu.107.1634285469904;
 Fri, 15 Oct 2021 01:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com> <20211014213646.1139469-23-krisman@collabora.com>
In-Reply-To: <20211014213646.1139469-23-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 11:10:58 +0300
Message-ID: <CAOQ4uxjD6CpnDcg3jhVXT5adVJTk-RgiSCayELeTeqJLdWFKOw@mail.gmail.com>
Subject: Re: [PATCH v7 22/28] fanotify: Report FID entry even for zero-length file_handle
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
> Non-inode errors will reported with an empty file_handle.  In
> preparation for that, allow some events to print the FID record even if
> there isn't any file_handle encoded
>
> Even though FILEID_ROOT is used internally, make zero-length file
> handles be reported as FILEID_INVALID.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 5324890500fc..39cf8ba4a6ce 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -127,6 +127,16 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
>                        FANOTIFY_EVENT_ALIGN);
>  }
>
> +static bool fanotify_event_allows_empty_fh(struct fanotify_event *event)
> +{
> +       switch (event->type) {
> +       case FANOTIFY_EVENT_TYPE_FS_ERROR:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  static size_t fanotify_event_len(unsigned int info_mode,
>                                  struct fanotify_event *event)
>  {
> @@ -157,7 +167,7 @@ static size_t fanotify_event_len(unsigned int info_mode,
>         if (info_mode & FAN_REPORT_PIDFD)
>                 event_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
>
> -       if (fh_len)
> +       if (fh_len || fanotify_event_allows_empty_fh(event))
>                 event_len += fanotify_fid_info_len(fh_len, dot_len);
>
>         return event_len;
> @@ -338,9 +348,6 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>         pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
>                  __func__, fh_len, name_len, info_len, count);
>
> -       if (!fh_len)
> -               return 0;
> -
>         if (WARN_ON_ONCE(len < sizeof(info) || len > count))
>                 return -EFAULT;
>
> @@ -375,6 +382,11 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>
>         handle.handle_type = fh->type;
>         handle.handle_bytes = fh_len;
> +
> +       /* Mangle handle_type for bad file_handle */
> +       if (!fh_len)
> +               handle.handle_type = FILEID_INVALID;
> +
>         if (copy_to_user(buf, &handle, sizeof(handle)))
>                 return -EFAULT;
>
> @@ -467,7 +479,8 @@ static int copy_info_records_to_user(struct fanotify_event *event,
>                 total_bytes += ret;
>         }
>
> -       if (fanotify_event_object_fh_len(event)) {
> +       if (fanotify_event_object_fh_len(event) ||
> +           fanotify_event_allows_empty_fh(event)) {
>                 const char *dot = NULL;
>                 int dot_len = 0;
>

I don't like this fanotify_event_allows_empty_fh() implementation so much.

How about this instead:

static inline struct fanotify_fh *fanotify_event_object_fh(
                                                struct fanotify_event *event)
{
        struct fanotify_fh *fh = NULL;

        /* An error event encodes (a FILEID_INVAL) fh for an empty fh */
        if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
                return &FANOTIFY_EE(event)->object_fh;
        else if (event->type == FANOTIFY_EVENT_TYPE_FID)
                fh = &FANOTIFY_FE(event)->object_fh;
        else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
                fh = fanotify_info_file_fh(&FANOTIFY_NE(event)->info);

        if (!fh && !fh->len)
                return NULL;

        return fh;
}

        struct fanotify_fh *object_fh = fanotify_event_object_fh(event);
...

-       if (fanotify_event_object_fh_len(event)) {
+       if (object_fh) {
                const char *dot = NULL;
...
                ret = copy_fid_info_to_user(fanotify_event_fsid(event),
-                                           fanotify_event_object_fh(event),
+                                          object_fh,
                                            info_type, dot, dot_len,
                                            buf, count);
...

And similar change to fanotify_event_len()

This way, the logic of whether to report fh or not is encoded in
fanotify_event_object_fh() and fanotify_event_object_fh_len()
goes back to being a property of the the fh report.

Thanks,
Amir.
