Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B0238C2D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 11:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbhEUJPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 05:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhEUJPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 05:15:19 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05F8C061574;
        Fri, 21 May 2021 02:13:55 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s7so3365728iov.2;
        Fri, 21 May 2021 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/IMP/4fsn+lRvE1Hs75ptxDfQxNUaEfOlolkyNC62Q=;
        b=IGrBRRP8XZGcg6le5Wz/g5DA+CguvEbF02onfyPzwJPzBqZ6HQHo4JLpIH+zGkMsk6
         lYD6tGFnRD3sQvr4xt94Hqjw72y+SGEKoNOOxsMlRausTKBFtWX2ehNZBkbu+toT7Bzf
         2G5799AtEnBaqCpkZtZAKS+zw1wqgva+sYGFh+ktBLvuWr9b4S3SkJAicbSePrPigB6c
         IiYHAwpkS0DX0yQpiiZBK20bSgUTj1fWvRcwMcBBUroI6vlKYw11JnV4gEkoOnbLIfmt
         lIeQX3bpHl5PoWOeP4TFFa6zLzPGYCEbJySr11yVbPSnaUkdtSPPmGRMdpOOhAjkxc4+
         097A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/IMP/4fsn+lRvE1Hs75ptxDfQxNUaEfOlolkyNC62Q=;
        b=kwzaYiAIefA/lpjg62B/OHywfg1XK0D6CMmb9st0ZnbBiM/wX8DAo6/DYCSB7apCZn
         XqXrqT9Poh5oUGq+chPOs/8/OAqCX3lmvhlgz3PcyAxhQjsbPSz6h77e8+UACoOOCSLQ
         ct2GUzaXOqt2UY1CtQ/i/4dqpOHNTJie3JUrAS88Gm2PYdCpWEBQIPJNK10NcdUY8PWy
         eNrJZ7CU0RA9RzQMe/ML3rLjlb+1O+lHungUbp2bHINB2Cixe+qvQWw7WWcXzVmKDscT
         1dvSaNXa1xRT0jlrBJtUGq0VVxN0ZLYywxTPftVFKSKXBCi8u94vJfFgjRkfJ/e0TGXs
         LdYA==
X-Gm-Message-State: AOAM5322DFbY/NcaK7pZoaySEI90nUNG1Oqtw0qsYWLhnuMQCQuXx4Ii
        JpLRZ9j3mqQiQsZ7qlbIRtxXeev0hZ3WOaOI8ik=
X-Google-Smtp-Source: ABdhPJyhYcuQqefw/VnEFtOH1Q1yrNSjhbzQgLkYI/cBrERGibAhTpLtk6j4xqhN53dlbNVZMhejPzwnUkKYFPz1zXU=
X-Received: by 2002:a6b:6b11:: with SMTP id g17mr10170817ioc.72.1621588435260;
 Fri, 21 May 2021 02:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210521024134.1032503-1-krisman@collabora.com> <20210521024134.1032503-7-krisman@collabora.com>
In-Reply-To: <20210521024134.1032503-7-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 May 2021 12:13:44 +0300
Message-ID: <CAOQ4uxgb7iyFWcuyCzFOuUvcS9C8_2zEo_GZQ2eQHd9eHMPp7w@mail.gmail.com>
Subject: Re: [PATCH 06/11] fsnotify: Support FS_ERROR event type
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 5:42 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Expose a new type of fsnotify event for filesystems to report errors for
> userspace monitoring tools.  fanotify will send this type of
> notification for FAN_ERROR events.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v1:
>   - Overload FS_ERROR with FS_IN_IGNORED
> ---
>  include/linux/fsnotify_backend.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 1ce66748a2d2..bbef2df3fbc7 100644
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
> @@ -248,6 +255,12 @@ enum fsnotify_data_type {
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

Your patch may not use it, but I prefer that fsnotify_data_inode() knows
how to handle FSNOTIFY_EVENT_ERROR type.

You will need it if you choose to implement my proposal of optional
FAN_EVENT_INFO_TYPE_FID record.

Thanks,
Amir.
