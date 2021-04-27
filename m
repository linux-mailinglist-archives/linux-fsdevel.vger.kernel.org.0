Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE5936BF95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 09:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhD0HCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 03:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhD0HCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:02:44 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E891C061574;
        Tue, 27 Apr 2021 00:02:00 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id c3so2590127ils.5;
        Tue, 27 Apr 2021 00:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9Qt/PNIUM76w/s8A28x+xnbjsoSLCqkK9LFTkFb2Fg=;
        b=kOIffbVJLsU9r/e7FuE9jHiTShXXgAbuhlah1ljNuns7Q1BuNdmdeRR3lPIectKiII
         S936ruOGRvBvMIyveGJgOE7XHEcmaYaHG2HXTlGkpICKp0iiXg/0NyN0GhjAVaCeNE0L
         REcvy/G16GmGeL7bgXOl+5ZCIqdGl04Aq18v2yI6qcjR/jH54AC6D+TRch1ZlMlEodKJ
         AnbTPsIVpnofxq+CeaGbu45gQE24gxLkk63Fea1k6NLZcRZv5slUuAG4AX0I1Ljj0SYw
         QffwIs4ZUmV9YOnQLVsXCKV/2OJZt5w8N5P6lJcs1PUL1wTcs4m7IHh9O64Ks2GmgbTs
         uqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9Qt/PNIUM76w/s8A28x+xnbjsoSLCqkK9LFTkFb2Fg=;
        b=t9+kfZupKjiaYZCeEUa2LFYAYEZ6GkuUFAyKhT+gXR7P54PmqHHA8EK1QBCTSaOHEg
         JcZBhAJpzZC3NdtPJnwO2LFQlYyIKB998hj/M6ad95jtLUpjPX2HKujVk3tAnP2XJZK8
         rJZhVx+iotvRXlwCPP9FYjXo/g21YkyhgEfZLslh8vGjpSYO8fFMVGl8omdV0jTUkluV
         Cl0w4GXbajtQi546ExcAJhWqj4pkyoY83DXrZUBUKzGdDuCFKDBlFcLyFPLaUj03Dtzl
         r++bsR0oue5T1wRCLn4vqZBpNDPajNKSnkbpMb2A+PqgxQ+SqLXWnR2g1w4THOrXXWlU
         CINA==
X-Gm-Message-State: AOAM531YhEbqlnxcJ0nbNxnBcEI5cEjLrFQ2bMXWPXe54+jPx4M7XeVd
        N5DoRNsycOG8dg2A/ZxQBM8SkABKxMhrvcItkdA=
X-Google-Smtp-Source: ABdhPJwnIRUzneGbkdDGnJl8oYZklTFiGiLoqoJuWi5Ty5oXTGaBr5RH70oM6MjMK6IIMRKEHwNOtdIFyU6JYdhmCeg=
X-Received: by 2002:a92:c548:: with SMTP id a8mr16895976ilj.137.1619506919767;
 Tue, 27 Apr 2021 00:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com> <20210426184201.4177978-10-krisman@collabora.com>
In-Reply-To: <20210426184201.4177978-10-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 10:01:48 +0300
Message-ID: <CAOQ4uxinWaDssraxMBgrPExa=oByKEwWMn-Y07OYefFPSm-0GQ@mail.gmail.com>
Subject: Re: [PATCH RFC 09/15] fanotify: Introduce generic error record
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
> This record describes a fs error in a fs agnostic way.  It will be send
> back to userspace in response to a FSNOTIFY_EVENT_ERROR for groups with
> the FAN_ERROR mark.

It's not a mark, it's an event, so:
"...for groups with the FAN_ERROR event in their mark mask"

>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.h      | 16 ++++++++++++++++
>  fs/notify/fanotify/fanotify_user.c | 28 ++++++++++++++++++++++++++++
>  include/uapi/linux/fanotify.h      | 10 ++++++++++
>  3 files changed, 54 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 47299e3d6efd..4cb9dd31f084 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -179,6 +179,22 @@ FANOTIFY_NE(struct fanotify_event *event)
>         return container_of(event, struct fanotify_name_event, fae);
>  }
>
> +struct fanotify_error_event {
> +       struct fanotify_event fae;
> +       int error;
> +       __kernel_fsid_t fsid;
> +
> +       int fs_data_size;
> +       /* Must be the last item in the structure */
> +       char fs_data[0];
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
> index 5031198bf7db..21162d347bd1 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -64,6 +64,11 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
>         return roundup(FANOTIFY_INFO_HDR_LEN + info_len, FANOTIFY_EVENT_ALIGN);
>  }
>
> +static size_t fanotify_error_info_len(struct fanotify_error_event *fee)
> +{
> +       return sizeof(struct fanotify_event_info_error);
> +}
> +
>  static size_t fanotify_event_len(struct fanotify_event *event,
>                                  unsigned int fid_mode)
>  {
> @@ -232,6 +237,29 @@ static int process_access_response(struct fsnotify_group *group,
>         return -ENOENT;
>  }
>
> +static size_t copy_error_info_to_user(struct fanotify_error_event *fee,
> +                                     char __user *buf, int count)
> +{
> +       struct fanotify_event_info_error info;
> +
> +       info.hdr.info_type = FAN_EVENT_INFO_TYPE_ERROR;
> +       info.hdr.pad = 0;
> +       info.hdr.len = fanotify_error_info_len(fee);
> +
> +       if (WARN_ON(count < info.hdr.len))
> +               return -EFAULT;
> +
> +       info.version = FANOTIFY_EVENT_INFO_ERROR_VERS_1;
> +       info.error = fee->error;
> +       info.fsid = fee->fsid;
> +
> +       if (copy_to_user(buf, &info, sizeof(info)))
> +               return -EFAULT;
> +
> +       return info.hdr.len;
> +
> +}
> +
>  static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>                              int info_type, const char *name, size_t name_len,
>                              char __user *buf, size_t count)
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index b283531549f1..cc9a1fa80e30 100644
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
> @@ -149,6 +150,15 @@ struct fanotify_event_info_fid {
>         unsigned char handle[0];
>  };
>
> +#define FANOTIFY_EVENT_INFO_ERROR_VERS_1   1

Honestly, this struct is too simple to have a 'version'.
The format of this simple struct is already defined by
FAN_EVENT_INFO_TYPE_ERROR and if we want to change
the reported info in the future, we can use
FAN_EVENT_INFO_TYPE_ERROR_V2.
In fact, I suggest to name the type
FAN_EVENT_INFO_TYPE_FS_ERROR
to differentiate from a future
FAN_EVENT_INFO_TYPE_WB_ERROR

> +
> +struct fanotify_event_info_error {
> +       struct fanotify_event_info_header hdr;
> +       int version;
> +       int error;
> +       __kernel_fsid_t fsid;
> +};

I suggest to put an error seq counter in this struct.
The per-sb seq counter can be provided by the filesystem
or by fsnotify.

Thanks,
Amir.
