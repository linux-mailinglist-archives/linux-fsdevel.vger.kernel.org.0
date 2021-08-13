Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7DE3EB2DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 10:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbhHMIsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 04:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238799AbhHMIsc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:48:32 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC93AC061756;
        Fri, 13 Aug 2021 01:48:05 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n17so10731663ioc.7;
        Fri, 13 Aug 2021 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsvqmOcg7ghrpmVCq63zefkNu8uaiwPfBKTMCXYdiqY=;
        b=LhkVJh1B78ivwTakdmeUvUVL/gJzPip9TiT4S1A7vWbeHkF09Tb5Fr0ty9xgCYFzw5
         cSqzjVN7s1cz7kG1zg8+1EhGC9gSuRFc5h2fbZaFzH48JnOaJw+erZAwY2yzlpGMGlfL
         PLGBhsScB4gsLWkErEXtth1ncsccZ52pLNdzI+Ic4AHz4HI6tTZkeNeZ55niEBk7uEXm
         hgufwWzlzn0Cp/eHCcjpxGHfisFNGCG+uZjQh1avuKCoSiim8kBj9b/oFBTE2+DLwii0
         M3Nct6lGPt1e7oiMYPPbgs5Qft90SbSXVPM3SreaUuGt623wPaF8hh6ETQH0meCcQSyk
         rh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsvqmOcg7ghrpmVCq63zefkNu8uaiwPfBKTMCXYdiqY=;
        b=eXF6LQUxBevU5xmcHAfXsKiyjvVikO6UYOJyonRRXItt1ANGyI/c3HETITfLgqyw5s
         D8eJF6mFT2HOh0rO0GZQRQE0TxMQFO5iwL9zoVVKkhRgYeHwVq0l6LwOHzjhgMtethSg
         Z0Wg95z7xoj2qfn8JawDLgRpptuNO4tnxFmLwebTq2MGD31AMSe/frGS3u5TdFyn2hXJ
         2Fq6yP5MtyD52vmNaGJi2mqQQsejk+TsMYATeF2uYiX4oLhAqDyzpx2jba+Tojo8BYLP
         7e8q15Gzufdj9+BZAW/ScCYcIgH6vGtTvzP4aW6i6Pu/QPPu/N99Wr6mM+jRaZcQbZOR
         xFTA==
X-Gm-Message-State: AOAM532iwnJ0bbTePiw7A0Au8jvd5KV5QTX791/XTao80HRiLPQXCEl/
        IT36mcRnEEM0JPlDVa8+6QpL2WwCjXRdWx0rqrw=
X-Google-Smtp-Source: ABdhPJzZCzCrr1guu0DcfYv30Elnd8o2a6pb9g1AV4bLvDIFgpHFeDDhdc2qVcB+oCoCdngt2SdVG0/kOhvn1rALLMQ=
X-Received: by 2002:a05:6602:1848:: with SMTP id d8mr1226287ioi.72.1628844485272;
 Fri, 13 Aug 2021 01:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com> <20210812214010.3197279-19-krisman@collabora.com>
In-Reply-To: <20210812214010.3197279-19-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Aug 2021 11:47:54 +0300
Message-ID: <CAOQ4uxjCmdUpfVgQzaFgaQCe+H8BzTi7MAf6Y=qN3e832_aVPA@mail.gmail.com>
Subject: Re: [PATCH v6 18/21] fanotify: Emit generic error info type for error event
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
> The Error info type is a record sent to users on FAN_FS_ERROR events
> documenting the type of error.  It also carries an error count,
> documenting how many errors were observed since the last reporting.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v5:
>   - Move error code here
> ---
>  fs/notify/fanotify/fanotify.c      |  1 +
>  fs/notify/fanotify/fanotify.h      |  1 +
>  fs/notify/fanotify/fanotify_user.c | 36 ++++++++++++++++++++++++++++++
>  include/uapi/linux/fanotify.h      |  7 ++++++
>  4 files changed, 45 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index f5c16ac37835..b49a474c1d7f 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -745,6 +745,7 @@ static int fanotify_handle_error_event(struct fsnotify_iter_info *iter_info,
>         spin_unlock(&group->notification_lock);
>
>         fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +       fee->error = report->error;
>         fee->fsid = fee->sb_mark->fsn_mark.connector->fsid;
>
>         fh_len = fanotify_encode_fh_len(inode);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 158cf0c4b0bd..0cfe376c6fd9 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -220,6 +220,7 @@ FANOTIFY_NE(struct fanotify_event *event)
>
>  struct fanotify_error_event {
>         struct fanotify_event fae;
> +       s32 error; /* Error reported by the Filesystem. */
>         u32 err_count; /* Suppressed errors count */
>
>         struct fanotify_sb_mark *sb_mark; /* Back reference to the mark. */
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 1ab8f9d8b3ac..ca53159ce673 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -107,6 +107,8 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
>  #define FANOTIFY_EVENT_ALIGN 4
>  #define FANOTIFY_INFO_HDR_LEN \
>         (sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
> +#define FANOTIFY_INFO_ERROR_LEN \
> +       (sizeof(struct fanotify_event_info_error))
>
>  static int fanotify_fid_info_len(int fh_len, int name_len)
>  {
> @@ -130,6 +132,9 @@ static size_t fanotify_event_len(struct fanotify_event *event,
>         if (!fid_mode)
>                 return event_len;
>
> +       if (fanotify_is_error_event(event->mask))
> +               event_len += FANOTIFY_INFO_ERROR_LEN;
> +
>         info = fanotify_event_info(event);
>         dir_fh_len = fanotify_event_dir_fh_len(event);
>         fh_len = fanotify_event_object_fh_len(event);
> @@ -176,6 +181,7 @@ static struct fanotify_event *fanotify_dup_error_to_stack(
>         error_on_stack->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
>         error_on_stack->err_count = fee->err_count;
>         error_on_stack->sb_mark = fee->sb_mark;
> +       error_on_stack->error = fee->error;
>
>         error_on_stack->fsid = fee->fsid;
>
> @@ -342,6 +348,28 @@ static int process_access_response(struct fsnotify_group *group,
>         return -ENOENT;
>  }
>
> +static size_t copy_error_info_to_user(struct fanotify_event *event,
> +                                     char __user *buf, int count)
> +{
> +       struct fanotify_event_info_error info;
> +       struct fanotify_error_event *fee = FANOTIFY_EE(event);
> +
> +       info.hdr.info_type = FAN_EVENT_INFO_TYPE_ERROR;
> +       info.hdr.pad = 0;
> +       info.hdr.len = FANOTIFY_INFO_ERROR_LEN;
> +
> +       if (WARN_ON(count < info.hdr.len))
> +               return -EFAULT;
> +
> +       info.error = fee->error;
> +       info.error_count = fee->err_count;
> +
> +       if (copy_to_user(buf, &info, sizeof(info)))
> +               return -EFAULT;
> +
> +       return info.hdr.len;
> +}
> +
>  static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>                              int info_type, const char *name, size_t name_len,
>                              char __user *buf, size_t count)
> @@ -505,6 +533,14 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>         if (f)
>                 fd_install(fd, f);
>
> +       if (fanotify_is_error_event(event->mask)) {
> +               ret = copy_error_info_to_user(event, buf, count);
> +               if (ret < 0)
> +                       goto out_close_fd;
> +               buf += ret;
> +               count -= ret;
> +       }
> +
>         /* Event info records order is: dir fid + name, child fid */
>         if (fanotify_event_dir_fh_len(event)) {
>                 info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index 16402037fc7a..80040a92e9d9 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -124,6 +124,7 @@ struct fanotify_event_metadata {
>  #define FAN_EVENT_INFO_TYPE_FID                1
>  #define FAN_EVENT_INFO_TYPE_DFID_NAME  2
>  #define FAN_EVENT_INFO_TYPE_DFID       3
> +#define FAN_EVENT_INFO_TYPE_ERROR      4
>
>  /* Variable length info record following event metadata */
>  struct fanotify_event_info_header {
> @@ -149,6 +150,12 @@ struct fanotify_event_info_fid {
>         unsigned char handle[0];
>  };
>
> +struct fanotify_event_info_error {
> +       struct fanotify_event_info_header hdr;
> +       __s32 error;
> +       __u32 error_count;
> +};
> +
>  struct fanotify_response {
>         __s32 fd;
>         __u32 response;
> --
> 2.32.0
>
