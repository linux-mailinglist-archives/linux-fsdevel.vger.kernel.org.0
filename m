Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27BD3EB311
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 11:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbhHMJBP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 05:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhHMJBO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 05:01:14 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73120C061756;
        Fri, 13 Aug 2021 02:00:48 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id q16so9950159ioj.0;
        Fri, 13 Aug 2021 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPAa+w2Ys/VteMX/NgfcA0FZvBwkN3wnXraE4W29uBM=;
        b=ZWZB3pukZqfgzyz5ZVD6ZwCIkGStv0ORjUN9oApSfM59tGWiSR2xqz653VbfWlWvxz
         O3YHD92kNRzkaXhbecs96V8UqPBaALO6Z/k4M0hOvKpyYhvTgroI1tvBpJNnpJ3mpBxC
         tzlhu9HoUfuasgPYqHCgoSBsXEM+Ayy94UcykN6OtB/XUBTspDtxk4SNsBx4oe7SZlZh
         qmzbkRgQlbvyX5uZStifs0G55SHaXxI5WBNw4PfJ6sFEWj0pl7/GjywAXbzmz94OD8dZ
         5vvJaaHJ1pdYIz8doQOm05eaTOSMwTfVbfY+1O1uDDt1MYyNZuVD+NPcUzdKRifGdawy
         xtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPAa+w2Ys/VteMX/NgfcA0FZvBwkN3wnXraE4W29uBM=;
        b=nfBlAfF3qJFd3fU+nlDpl6RaJseelZP67ggV6xrS/8tsfrzzXbdOTsk7LXUTq24qov
         8d5fiqD4DTynsGA+F//w4c9nzRcKSGMHbgypyXEMQZ0wU2Rqf5zSRRmYZczjrg4UMH9o
         Ya3+RyOq1pb/stJ8MwSrZDBZGayQoJM+uV2XElBKtdH8VSptPmsVEJvDZTa64ldLxaA8
         dDJsdUsiR/iZD3FqGHTZx9I8zvadu/6nzYyYZloGCyGBUwmDtilxtTwXcI8ohMDyPoCp
         I+vspWNLA+Gkw/lJARNk8aYbFtzsMmE3fvKEbdp/HHZC3hPVlLzscqytjqsB4NrJH552
         y5rQ==
X-Gm-Message-State: AOAM5323it0SAjAy/9lPdmwTmVZuT9QlqyN91/KybsDhavRrqkjOHKaX
        ygSij21csmBoJTnc2mYPa/wlBC0133etFsYx1dI=
X-Google-Smtp-Source: ABdhPJy8EwsCpNaIggyAXfFdNCJHY76s0xEymq1jGExAg/JLTIK41XNaFIZQhK3Icex6Na219aljPw47ynZdAhnQikM=
X-Received: by 2002:a02:908a:: with SMTP id x10mr1295648jaf.30.1628845247857;
 Fri, 13 Aug 2021 02:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com> <20210812214010.3197279-18-krisman@collabora.com>
In-Reply-To: <20210812214010.3197279-18-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Aug 2021 12:00:36 +0300
Message-ID: <CAOQ4uxg1ZhZi25aeF80a2bdWo8p+3ZNMZegZBi2PKM5fa_GfYg@mail.gmail.com>
Subject: Re: [PATCH v6 17/21] fanotify: Report fid info for file related file
 system errors
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 12:41 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Plumb the pieces to add a FID report to error records.  Since all error
> event memory must be pre-allocated, we estimate a file handle size and
> if it is insuficient, we report an invalid FID and increase the
> prediction for the next error slot allocation.
>
> For errors that don't expose a file handle report it with an invalid
> FID.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v5:
>   - Use preallocated MAX_HANDLE_SZ FH buffer
>   - Report superblock errors with a zerolength INVALID FID (jan, amir)
> ---
>  fs/notify/fanotify/fanotify.c      | 15 +++++++++++++++
>  fs/notify/fanotify/fanotify.h      | 11 +++++++++++
>  fs/notify/fanotify/fanotify_user.c |  7 +++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 0c7667d3f5d1..f5c16ac37835 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -734,6 +734,8 @@ static int fanotify_handle_error_event(struct fsnotify_iter_info *iter_info,
>         struct fanotify_sb_mark *sb_mark =
>                 FANOTIFY_SB_MARK(fsnotify_iter_sb_mark(iter_info));
>         struct fanotify_error_event *fee = sb_mark->fee_slot;
> +       struct inode *inode = report->inode;
> +       int fh_len;
>
>         spin_lock(&group->notification_lock);
>         if (fee->err_count++) {
> @@ -743,6 +745,19 @@ static int fanotify_handle_error_event(struct fsnotify_iter_info *iter_info,
>         spin_unlock(&group->notification_lock);
>
>         fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +       fee->fsid = fee->sb_mark->fsn_mark.connector->fsid;
> +
> +       fh_len = fanotify_encode_fh_len(inode);
> +       if (WARN_ON(fh_len > MAX_HANDLE_SZ)) {
> +               /*
> +                * Fallback to reporting the error against the super
> +                * block.  It should never happen.
> +                */
> +               inode = NULL;
> +               fh_len = fanotify_encode_fh_len(NULL);
> +       }
> +
> +       fanotify_encode_fh(&fee->object_fh, inode, fh_len, NULL, 0);
>
>         if (fsnotify_insert_event(group, &fee->fae.fse,
>                                   NULL, fanotify_insert_error_event)) {
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index eeb4a85af74e..158cf0c4b0bd 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -223,6 +223,13 @@ struct fanotify_error_event {
>         u32 err_count; /* Suppressed errors count */
>
>         struct fanotify_sb_mark *sb_mark; /* Back reference to the mark. */
> +
> +       __kernel_fsid_t fsid; /* FSID this error refers to. */
> +
> +       /* object_fh must be followed by the inline handle buffer. */
> +       struct fanotify_fh object_fh;
> +       /* Reserve space in object_fh.buf[] - access with fanotify_fh_buf() */
> +       unsigned char _inline_fh_buf[MAX_HANDLE_SZ];
>  };
>
>  static inline struct fanotify_error_event *
> @@ -237,6 +244,8 @@ static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
>                 return &FANOTIFY_FE(event)->fsid;
>         else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
>                 return &FANOTIFY_NE(event)->fsid;
> +       else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
> +               return &FANOTIFY_EE(event)->fsid;
>         else
>                 return NULL;
>  }
> @@ -248,6 +257,8 @@ static inline struct fanotify_fh *fanotify_event_object_fh(
>                 return &FANOTIFY_FE(event)->object_fh;
>         else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
>                 return fanotify_info_file_fh(&FANOTIFY_NE(event)->info);
> +       else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
> +               return &FANOTIFY_EE(event)->object_fh;
>         else
>                 return NULL;
>  }
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 3fff0c994dc8..1ab8f9d8b3ac 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -177,6 +177,13 @@ static struct fanotify_event *fanotify_dup_error_to_stack(
>         error_on_stack->err_count = fee->err_count;
>         error_on_stack->sb_mark = fee->sb_mark;
>
> +       error_on_stack->fsid = fee->fsid;
> +
> +       memcpy(&error_on_stack->object_fh, &fee->object_fh,
> +              sizeof(fee->object_fh));
> +       memcpy(error_on_stack->object_fh.buf, fee->object_fh.buf,
> +               fee->object_fh.len);
> +

I would go with:

    size_t len = offsetof(struct fanotify_error_event, _inline_fh_buf)
+ fee->object_fh.len);

    memcpy(error_on_stack, fee, len);

But maybe it's just me, so I don't insist.

Thanks,
Amir.
