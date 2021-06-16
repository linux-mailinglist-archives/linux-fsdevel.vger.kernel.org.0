Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78FB3A9629
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 11:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhFPJcD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 05:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhFPJcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:32:02 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D845C061574;
        Wed, 16 Jun 2021 02:29:56 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i17so1738675ilj.11;
        Wed, 16 Jun 2021 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2QyrZ5u9nirgNRl+yX3M8mJOnXZQHhwgkJca21/81I=;
        b=GHYm6GxRdEg+YoZWPkMFFfHUfPA8V/M3t+7djJnxneGLywcYEaCXKmwaeF55CiNTm9
         zETDvrqULt4ouLGUC8HNHvmZ6/eo0JWWt18crEoE6jtuF3f13kpU+omeFL0b6FmWMRR3
         UDXaR8cNaRgiWAEayJST+stErbVd35hVtMhkUwqNHIaf1qGYHoiTQXNXHNRybB/QojGf
         S5mYikAHKRLPAQ0vdM1zGxHlvfvxvy3sUO13+155cFWqok8Ab36lFd2Gg9q21x6Th/mw
         hy2tvmuADY1Rk+Qj7cgECyeKDdaVdV1i+uu28ebSt10K+3mTIYlmalc/WHIfZSWleaUx
         wF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2QyrZ5u9nirgNRl+yX3M8mJOnXZQHhwgkJca21/81I=;
        b=V2P3tvT6LZbL/l4NtgrhpzbBh8nHkP41dJUK2dxkfTbvLfyJSWBzoY3tlyDihmEYWT
         Em3eqr+5Ye8+GxYdnO4mzrIxJJOcA2eSyNVYah6P4aDEosiNCa2Pnx5/NzwAj0jV5LE3
         JJS4BySOjWRmsFYhKZiz4yu71KcM4wzXoqu0YtI0pyMaIeNzJ8EGT09pbBvOhPcqnqVi
         qYUJdtLnXEcXbSa1cfCm+PeXQSzKVrAqysSA24byy/nC5/RwtCCnuuTZ8e+OV/xMTOeN
         D9oS/SMkVl0WFAn2btXZbK1frbey+gyaCAW+kbjziyVSZumZ6uJz08hoevMzcuOydkHW
         ySXw==
X-Gm-Message-State: AOAM533JsY2GUEDkE//HzEFl6WJJ6SMC21x1B7tW89LKzgUw3VCmdW1Y
        xWf/JmbXuED9i/UnfDiZX3ag+jXK7psIeWkUlpW8lu5Rv5s=
X-Google-Smtp-Source: ABdhPJygjWBaouZKWKd9k77NdbKLoAQB8r0y+T6vqUdDyqPyDhI8dbLB8RCCh29diNk/74B1oLB8WVeiPQuaT39xr4g=
X-Received: by 2002:a92:4446:: with SMTP id a6mr3111923ilm.9.1623835795692;
 Wed, 16 Jun 2021 02:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210615235556.970928-1-krisman@collabora.com> <20210615235556.970928-10-krisman@collabora.com>
In-Reply-To: <20210615235556.970928-10-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 16 Jun 2021 12:29:44 +0300
Message-ID: <CAOQ4uxjNLR9ohUoF+P=bO0ZxA1qSGfpLJePXVuDcowapwOLoLQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] fsnotify: Support FS_ERROR event type
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
> Expose a new type of fsnotify event for filesystems to report errors for
> userspace monitoring tools.  fanotify will send this type of
> notification for FAN_ERROR events.

FAN_FS_ERROR... it's all over the place ;-)

Otherwise
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v1:
>   - Overload FS_ERROR with FS_IN_IGNORED
>   - IMplement support for this type on fsnotify_data_inode
> ---
>  include/linux/fsnotify_backend.h | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 8222fe12a6c9..ea5f5c7cc381 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -42,6 +42,12 @@
>
>  #define FS_UNMOUNT             0x00002000      /* inode on umount fs */
>  #define FS_Q_OVERFLOW          0x00004000      /* Event queued overflowed */
> +#define FS_ERROR               0x00008000      /* Filesystem Error (fanotify) */
> +
> +/*
> + * FS_IN_IGNORED overloads FS_ERROR.  It is only used internally by inotify
> + * which does not support FS_ERROR.
> + */
>  #define FS_IN_IGNORED          0x00008000      /* last inotify event here */
>
>  #define FS_OPEN_PERM           0x00010000      /* open event in an permission hook */
> @@ -95,7 +101,8 @@
>  #define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
>                              FS_EVENTS_POSS_ON_CHILD | \
>                              FS_DELETE_SELF | FS_MOVE_SELF | FS_DN_RENAME | \
> -                            FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED)
> +                            FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
> +                            FS_ERROR)
>
>  /* Extra flags that may be reported with event or control handling of events */
>  #define ALL_FSNOTIFY_FLAGS  (FS_EXCL_UNLINK | FS_ISDIR | FS_IN_ONESHOT | \
> @@ -263,6 +270,12 @@ enum fsnotify_data_type {
>         FSNOTIFY_EVENT_NONE,
>         FSNOTIFY_EVENT_PATH,
>         FSNOTIFY_EVENT_INODE,
> +       FSNOTIFY_EVENT_ERROR,
> +};
> +
> +struct fs_error_report {
> +       int error;
> +       struct inode *inode;
>  };
>
>  static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
> @@ -272,6 +285,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
>                 return (struct inode *)data;
>         case FSNOTIFY_EVENT_PATH:
>                 return d_inode(((const struct path *)data)->dentry);
> +       case FSNOTIFY_EVENT_ERROR:
> +               return ((struct fs_error_report *)data)->inode;
>         default:
>                 return NULL;
>         }
> --
> 2.31.0
>
