Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763CB3B7C30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 05:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhF3DsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 23:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhF3DrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 23:47:22 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCFAC061760;
        Tue, 29 Jun 2021 20:44:29 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y76so1474821iof.6;
        Tue, 29 Jun 2021 20:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4hZC+l4mVzqQUkq44/PxM6l5xfwdj0M7Czt5aw2uBk=;
        b=ivAvz1U3CBcX3xJV0Qe6aTcd52KvoLL1fairIRJqw797mWT6nu6WcRWN6Xt/6pp55q
         nv7OwBN6GnGt1BvRQm5IfFzyjwXoROcwcOVCVYJ4I9HEDcqk6CVLoBsb8KxuMQ50EspO
         bFaKIDAR7hHp32JDDtOsIhQKKBbG1wWIM4gh+WKRoComth8TI18NFI1USnD3Kv5cTWHs
         O7QQ48JOpN0BU5dTsMRnwZ80OWq4KksRmcugWwiMaez6k31nkZnd3vhrvg6rRmBl64q2
         A0agoB5NIxIJjbAga++3jm09PoAXoAGDC/Cpc/JqkFdCmosyrzMPqxvuglw1Hfp/Uz8l
         N9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4hZC+l4mVzqQUkq44/PxM6l5xfwdj0M7Czt5aw2uBk=;
        b=e61HlXZavfrmIVrLg+ZyInbLzcx+HBeWq4TFnXYIXi2sqwHrn+lRVy7xGBM7COR4Sw
         VmxrvsjePrzyDjmNsBrTvjBjyL8fIi0aZ1LOu6ZYZG2kCnapgx/8f4pi17fd0WSDjL/v
         cpDrePy4vKZvS/AaYPOW7cwA8S9GtvzIn3XcYgQe1GhlVxAyudmNgtUggeke/AWHocHz
         +EkFRUjT32B9SmngliJzDLRxU9WrX0LD9FSCulhWS51R0iZnlU8OxZy0Z4CqN8b1hutj
         AtDxQJGWFtZ1FAwMRHpmm55B88aAwIEqjli7uEyuNCsXkMCyx4i6WgGP+4oYn9ltovhL
         5bxQ==
X-Gm-Message-State: AOAM530Iy+wACxgmQZks/057HYDrJ6nHXsy7nSEezqChimEXCStndmRc
        yS/izdfR1mict3RFQyAB49zHKMB1UhhjquHDVpg=
X-Google-Smtp-Source: ABdhPJzMBcfC7wWQKbl3/2ZrvXgpWQ+LN0m/Oy5rizDg2ZczGamY7wAXwhM6ihSv69mueAHxLWDjW8E073mhDhbhDi8=
X-Received: by 2002:a02:3505:: with SMTP id k5mr7070426jaa.123.1625024668481;
 Tue, 29 Jun 2021 20:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com> <20210629191035.681913-12-krisman@collabora.com>
In-Reply-To: <20210629191035.681913-12-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 06:44:17 +0300
Message-ID: <CAOQ4uxiDfDez8y2ah_pXzD1bZAQra49jni2VJ2LMv9YFpLHt6Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] fsnotify: Introduce helpers to send error_events
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

On Tue, Jun 29, 2021 at 10:12 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Introduce helpers for filesystems interested in reporting FS_ERROR
> events.  When notifying errors, the file system might not have an inode
> to report on the error.  To support this, allow the caller to specify
> the superblock to which the error applies.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v2:
>   - Drop reference to s_fnotify_marks and guards (Amir)
>
> Changes since v1:
>   - Use the inode argument (Amir)
>   - Protect s_fsnotify_marks with ifdef guard
> ---
>  fs/notify/fsnotify.c             |  2 +-
>  include/linux/fsnotify.h         | 13 +++++++++++++
>  include/linux/fsnotify_backend.h |  1 +
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 36205a769dde..ac05eb3fb368 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -491,7 +491,7 @@ int __fsnotify(__u32 mask, const struct fsnotify_event_info *event_info)
>                  */
>                 parent = event_info->dir;
>         }
> -       sb = inode->i_sb;
> +       sb = event_info->sb ?: inode->i_sb;
>
>         /*
>          * Optimization: srcu_read_lock() has a memory barrier which can
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 8c2c681b4495..684c79ca01b2 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -326,4 +326,17 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
>                 fsnotify_dentry(dentry, mask);
>  }
>
> +static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
> +                                   int error)
> +{
> +       struct fs_error_report report = {
> +               .error = error,
> +               .inode = inode,
> +       };
> +
> +       return __fsnotify(FS_ERROR, &(struct fsnotify_event_info) {
> +                       .data = &report, .data_type = FSNOTIFY_EVENT_ERROR,
> +                       .sb = sb});
> +}
> +
>  #endif /* _LINUX_FS_NOTIFY_H */
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index ea5f5c7cc381..5a32c5010f45 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -138,6 +138,7 @@ struct fsnotify_event_info {
>         struct inode *dir;
>         const struct qstr *name;
>         struct inode *inode;
> +       struct super_block *sb;
>         u32 cookie;
>  };
>
> --
> 2.32.0
>
