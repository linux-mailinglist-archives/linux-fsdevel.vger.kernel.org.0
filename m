Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B2042EB3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhJOIQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 04:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhJOIQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:16:00 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DC7C061570;
        Fri, 15 Oct 2021 01:13:54 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r134so6773582iod.11;
        Fri, 15 Oct 2021 01:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/t7ENqLtc3A2cI8jOOQHDeugmxFMit6C89TwkO64mQ=;
        b=ZmT7hjp6n6eFFMs/6GjmOMlDu3o5ub//o6yMy8xKnpPs32zVEf/NZYsakW3WKpnaSI
         tA0jLOg4PxOSdOJmgROSMwcY1UoivPnBKpibAFdfr3B5Ei4GipoycKOW1xSYoET0PVoR
         xMy/MGfq6ttlZC884u9UC1Zeupb1aT4ZpdpbkQt6dZHoEBXJ30I2YaWidbPIlAfW173J
         Zd8rom9hChERLmZDJ9hc5NFamJoxzPpk3xTWeGEoAhdzoxygU0gFfhFmDsn4UT9lqk68
         tqEmTyIWLLBiO2aFnepxCWRv9EBrLXQA2C0x5Y3P3wW5RL4jDbM2rkrp70yhmC3r9D+O
         o+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/t7ENqLtc3A2cI8jOOQHDeugmxFMit6C89TwkO64mQ=;
        b=BoBq8SdkRo6/i0wV40VtW1elZ702eI/o7Wb4gZ8992Hu9YtLkobsceHQc2NHUSakxf
         nw7bUEw4wUzjkdHmzzxI9VXDTH4px/f7FGIZJO3uIzGlCZqqnl43WHVGBOuPcTOIbLP7
         2ENjsPIjHe6RqiLgZaxLTD7BoHH/gC9VfvjlZluSKcJZY/wum3/K16VhrYdr/hYzn4HD
         V1ZLUUVNPd1Q5PUMYT3OTR3XtiDe6/8GeLj/bw1AsxbuDl9j7CCyf7R8jNBcIwW4yg9A
         7kgG30/GJWOgTbMeKA2PgDunkFVEPMw90via1mxFCJf4Tpx99KS/O8SwdWBN0UsdyPxm
         vxoQ==
X-Gm-Message-State: AOAM533BzDYbZoIyKpY2G6M+Ayb6KmNbPUmgOs7u7FkLeLDflsnByX80
        yzPYNTu3Vk+24xd4CUJqjOK81MU+SMX7LCyybOL7V+KqEgM=
X-Google-Smtp-Source: ABdhPJyWeRVFOtwkigZ5E4J1x+fHujYQzyPAj7xSf7rqyjJlajkRRIf7IEfNfdD1GsyPnx+Imw9I/bLil+FtP1Blr80=
X-Received: by 2002:a6b:b5d8:: with SMTP id e207mr2742186iof.52.1634285634424;
 Fri, 15 Oct 2021 01:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com> <20211014213646.1139469-25-krisman@collabora.com>
In-Reply-To: <20211014213646.1139469-25-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 11:13:43 +0300
Message-ID: <CAOQ4uxh21WmmVXWzx9UnNmJGwUGJN+sPwoMbuiUKFpf3cYJ7wA@mail.gmail.com>
Subject: Re: [PATCH v7 24/28] fanotify: Emit generic error info for error event
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
> The error info is a record sent to users on FAN_FS_ERROR events
> documenting the type of error.  It also carries an error count,
> documenting how many errors were observed since the last reporting.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>
> ---
> Changes since v6:
>   - Rebase on top of pidfd patches
> Changes since v5:
>   - Move error code here
> ---
>  fs/notify/fanotify/fanotify.c      |  1 +
>  fs/notify/fanotify/fanotify.h      |  1 +
>  fs/notify/fanotify/fanotify_user.c | 35 ++++++++++++++++++++++++++++++
>  include/uapi/linux/fanotify.h      |  7 ++++++
>  4 files changed, 44 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 8a60c96f5fb2..47e28f418711 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -623,6 +623,7 @@ static struct fanotify_event *fanotify_alloc_error_event(
>                 return NULL;
>
>         fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +       fee->error = report->error;
>         fee->err_count = 1;
>         fee->fsid = *fsid;
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index b58400926f92..a0897425df07 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -199,6 +199,7 @@ FANOTIFY_NE(struct fanotify_event *event)
>
>  struct fanotify_error_event {
>         struct fanotify_event fae;
> +       s32 error; /* Error reported by the Filesystem. */
>         u32 err_count; /* Suppressed errors count */
>
>         __kernel_fsid_t fsid; /* FSID this error refers to. */
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 39cf8ba4a6ce..8f7c2f4ce674 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -115,6 +115,8 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
>         (sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
>  #define FANOTIFY_PIDFD_INFO_HDR_LEN \
>         sizeof(struct fanotify_event_info_pidfd)
> +#define FANOTIFY_ERROR_INFO_LEN \
> +       (sizeof(struct fanotify_event_info_error))
>
>  static int fanotify_fid_info_len(int fh_len, int name_len)
>  {
> @@ -149,6 +151,9 @@ static size_t fanotify_event_len(unsigned int info_mode,
>         if (!info_mode)
>                 return event_len;
>
> +       if (fanotify_is_error_event(event->mask))
> +               event_len += FANOTIFY_ERROR_INFO_LEN;
> +
>         info = fanotify_event_info(event);
>         dir_fh_len = fanotify_event_dir_fh_len(event);
>         fh_len = fanotify_event_object_fh_len(event);
> @@ -333,6 +338,28 @@ static int process_access_response(struct fsnotify_group *group,
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
> +       info.hdr.len = FANOTIFY_ERROR_INFO_LEN;
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
>  static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>                                  int info_type, const char *name,
>                                  size_t name_len,
> @@ -540,6 +567,14 @@ static int copy_info_records_to_user(struct fanotify_event *event,
>                 total_bytes += ret;
>         }
>
> +       if (fanotify_is_error_event(event->mask)) {
> +               ret = copy_error_info_to_user(event, buf, count);
> +               if (ret < 0)
> +                       return ret;
> +               buf += ret;
> +               count -= ret;
> +       }
> +
>         return total_bytes;
>  }
>
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index 2990731ddc8b..bd1932c2074d 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -126,6 +126,7 @@ struct fanotify_event_metadata {
>  #define FAN_EVENT_INFO_TYPE_DFID_NAME  2
>  #define FAN_EVENT_INFO_TYPE_DFID       3
>  #define FAN_EVENT_INFO_TYPE_PIDFD      4
> +#define FAN_EVENT_INFO_TYPE_ERROR      5
>
>  /* Variable length info record following event metadata */
>  struct fanotify_event_info_header {
> @@ -160,6 +161,12 @@ struct fanotify_event_info_pidfd {
>         __s32 pidfd;
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
> 2.33.0
>
