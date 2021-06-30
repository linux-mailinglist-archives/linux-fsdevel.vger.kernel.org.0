Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137B23B84A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 16:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhF3OH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbhF3OGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:06:55 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF75C061756;
        Wed, 30 Jun 2021 07:03:43 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id g22so3306103iom.1;
        Wed, 30 Jun 2021 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T1sDjepqwZeytLmMtGCTuJy6Jtc+y1+1PWUTIxVsl9Y=;
        b=htmM3iEc+d0attZcRRyhGOAg4iudkhagyFv/GlBd9I5jyP/pKYvoJvi4iyM8kosto0
         2i5jdrF5hAQgedgCCRJrK+c6QpBZZXrqKxzAgD8qITrq2s1tUqDVnyf0l8NXxKGr331y
         AlbunkpqoyMVsAYUrUoUaQ+PRbNgim/y32+pCB9TnhthNt+pe9HY9nMStB1U7cE1ze4f
         G6FZ33FNyB96wARbe3uNh+btnstop1BCV1at63zoBNqYTan/i4rGhdGytZoElkbxURQd
         ZAGwAtX96pIQdH8Hc1XS3PCwCHwH3S3mdzRUsjJUV4BJUbmn2nRy1ZwEDoPv0g3N6PVw
         rkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1sDjepqwZeytLmMtGCTuJy6Jtc+y1+1PWUTIxVsl9Y=;
        b=LxIm7DLMw/OSb7jGBPwbfZHiq/BDei8vQk1gUXPJCMObSu93DD4xg8O9QSe0ISYoZf
         FBTBcBx3vzU+hbGyYNqf3OM3/rV2vrdHNLM9JHzIl/PB4LmBI97F9la9d30/Sw81SRhE
         l9apysCu4NHLHdOKPVCM/IcXOekw9WknF4RoN82N8J7uqRFpdQd6Y0MnBA3EgAHlNMqK
         CpS3Hj3lQFadJO3P7Vp8VTGMQIOpprRp3PfziL4J5xRAdlXRBi64zkfBQd8tyIy64rFh
         pSexQx38mjNzH1l7CnFK7TG9yBTPDBcg0hkvvIfTUMte0LVp6AAG8odlNbqatLJBULrN
         n6fg==
X-Gm-Message-State: AOAM532mJRezpLqsHzfzlsWTvQ+mXMDDDw7BrCvLvYvAC6AmRcNFqY+A
        zCbB9vT1gK7vFKIWQEayGCLFdW6Ig3vWoxCbrks=
X-Google-Smtp-Source: ABdhPJwc+j1ElyNc78+imOHyXcL80IItdbVsZx4y01OLMkUG/EyJV45beSnR+qcT+io1TN2/nBuDxB+JOcyY0Lf7nvI=
X-Received: by 2002:a6b:3119:: with SMTP id j25mr7709676ioa.64.1625061823300;
 Wed, 30 Jun 2021 07:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com> <20210629191035.681913-13-krisman@collabora.com>
In-Reply-To: <20210629191035.681913-13-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 17:03:32 +0300
Message-ID: <CAOQ4uxiQc+g5dRzTOVzesZTffVkX7o-bedd_MB9SmG4Unex6wg@mail.gmail.com>
Subject: Re: [PATCH v3 12/15] fanotify: Introduce FAN_FS_ERROR event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 10:13 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> The FAN_FS_ERROR event is a new inode event used by filesystem wide
> monitoring tools to receive notifications of type FS_ERROR_EVENT,
> emitted directly by filesystems when a problem is detected.  The error
> notification includes a generic error descriptor and a FID identifying
> the file affected.
>
> FID is sent for every FAN_FS_ERROR. Errors not linked to a regular inode
> are reported against the root inode.
>
> An error reporting structure is attached per-mark, and only a single
> error can be stored at a time.  This is ok, since once an error occurs,
> it is common for a stream of related errors to be reported.  We only log
> accumulate the total of errors occurred since the last notification.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v2:
>   - Support and equire FID mode (amir)
>   - Goto error path instead of early return (amir)
>   - Simplify get_one_event (me)

About that...

>   - Base merging on error_count
>   - drop fanotify_queue_error_event

[...]

> +static int fanotify_merge_error_event(struct fsnotify_group *group,
> +                                     struct fsnotify_event *event)
> +{
> +       struct fanotify_event *fae = FANOTIFY_E(event);
> +
> +       /*
> +        * When err_count > 0, the reporting slot is full.  Just account
> +        * the additional error and abort the insertion.
> +        */
> +       if (atomic_fetch_inc(&FANOTIFY_EE(fae)->err_count) != 0)
> +               return 1;

It feels a bit unsafe to bump err_count to 1 in merge() and set the error
info in insert(). feels like looking for trouble.
Maybe atomic_inc_not_zero() would have been better,
but since I am going to argue against modifying err_count outside
the notification_lock, it does not need to be atomic at all.

> +
> +       return 0;
> +}
> +
> +static void fanotify_insert_error_event(struct fsnotify_group *group,
> +                                       struct fsnotify_event *event,
> +                                       const void *data)
> +{
> +       const struct fsnotify_event_info *ei =
> +               (struct fsnotify_event_info *) data;
> +       struct fanotify_event *fae = FANOTIFY_E(event);
> +       const struct fs_error_report *report;
> +       struct fanotify_error_event *fee;
> +       struct inode *inode;
> +       int fh_len;
> +
> +       /* This might be an unexpected type of event (i.e. overflow). */
> +       if (!fanotify_is_error_event(fae->mask))
> +               return;
> +
> +       report = (struct fs_error_report *) ei->data;
> +       inode = report->inode ?: ei->sb->s_root->d_inode;

As I commented on the cover letter, I think it would be better to
encode a NULL-FID in case of NULL inode, e.g.:

static int fanotify_encode_null_fh(struct fanotify_fh *fh)
{
        fh->type = FILEID_ROOT;
        fh->len = 8;
        fh->flags = 0;
        memset(fh->buf, 0, 8);
}

But that API may be controversial, so wait for other voices
before changing that.

> +
> +       fee = FANOTIFY_EE(fae);
> +       fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +       fee->error = report->error;
> +       fee->fsid = fee->mark->connector->fsid;
> +
> +       fsnotify_get_mark(fee->mark);
> +
> +       /*
> +        * Error reporting needs to happen in atomic context.  If this
> +        * inode's file handler is more than we initially predicted,
> +        * there is nothing better we can do than report the error with
> +        * a bad FH.
> +        */
> +       fh_len = fanotify_encode_fh_len(inode);
> +       if (WARN_ON(fh_len > fee->max_fh_len))
> +               return;
> +
> +       fanotify_encode_fh(&fee->object_fh, inode, fh_len, NULL, 0);
> +}
> +

[...]

> +static size_t copy_error_info_to_user(struct fanotify_event *event,
> +                                     char __user *buf, int count)
> +{
> +       struct fanotify_event_info_error info;
> +       struct fanotify_error_event *fee = FANOTIFY_EE(event);
> +
> +       info.hdr.info_type = FAN_EVENT_INFO_TYPE_ERROR;
> +       info.hdr.pad = 0;
> +       info.hdr.len = sizeof(struct fanotify_event_info_error);
> +
> +       if (WARN_ON(count < info.hdr.len))
> +               return -EFAULT;
> +
> +       info.error = fee->error;
> +
> +       /* This effectively releases the event for logging another error */
> +       info.error_count = atomic_xchg(&fee->err_count, 0);
> +

it's  a shame because the code is really simpler, but
I am afraid it may not be correct, even without mentioning breaking
the queue abstraction.

While the read/insert of err_count is "atomic", read of FID is done
after this point, not to mention that read of fee->error could be reordered
without barriers. FID and error could be set by insert event after reading
fee->err_count.

You can either go back to copying the error report to stack on dequeue
(though it was a bit ugly) under the group notification_lock
or you can allocate a new initialized error event on dequeue and
exchange it with the mark's event, without having to change the
calling semantics of get_one_event(), e.g.:

        fsnotify_remove_first_event(group);
        if (fanotify_is_perm_event(event->mask))
                FANOTIFY_PERM(event)->state = FAN_EVENT_REPORTED;
        if (fanotify_is_hashed_event(event->mask))
                fanotify_unhash_event(group, event);
+        if (fanotify_is_error_event(event->mask))
+                event = fanotify_recreate_fs_error_event(event);

If allocation fails, this helper returns ERR_PTR(-EINVAL)
and resets the info and err_count of the event in the mark.

Thanks,
Amir.
