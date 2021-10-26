Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7866043AC8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 09:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhJZHDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 03:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhJZHDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:03:47 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A81C061767;
        Tue, 26 Oct 2021 00:01:24 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id l7so15864160iln.8;
        Tue, 26 Oct 2021 00:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D09RJ9bxsiKuYw4O4J+IukGYc3Ze7wdSQQ4u4VL/QIc=;
        b=Q9lxXn4UFXUTxiRFpM/DL9Xkv8XeOk0vQwH49BRQBSjpmNK0Ck7dlTPb0i12Swdzls
         +P6SN36jUpD2JhINSeNuaASWKhqCLfMvw2OwXL+I28DlX6RIzXW3utuGgCMSiH6nYoaU
         675LuHB7GuK+B4+7OFMepz8sJEGg6fSxGhw1mzNhVeGNIDc4G5Jh7mFO1d8A8PZbrcE+
         jrv2caLYXsLXey9EUJs071Ztc42tDqI4LyPajnZBtaHaGR3vGTgsswgtmYcjwuFnAyWn
         mpo6Uc/geYVzRb+X1QB9JhVkz2RQTJGJFS+08+SROvGIyTMgVIPUd0n9OoOPrVZ7J54M
         0uBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D09RJ9bxsiKuYw4O4J+IukGYc3Ze7wdSQQ4u4VL/QIc=;
        b=0dRGLejZwaGcoAyBr/FaJCfDygfMvQGt9Cnvn0usDJATNVGwHsxWVw4snKEhQpS9NF
         wAlrXQOsxrrl1Ev0tzcmfFb5ba9uwuqQQkIws0V1uRBft37kf4kQ+witguwCFQixozb/
         5ma4pymv59BoDjrjmmDEFjus1PPdzwGWLfkqAiySPRlKfdI2fiTU0NSIi5vTCjWgU+7y
         1gsw5+XNXqxzU+/n85D1qj4vOdrOcvJR2p0r1/NJRMpf4FtJ/e1MDQXOjnVkZ2qqVWFm
         Qy6mKBElbGlR1lttxgT174Be47i6Y49YmrXCAkAo7jm1l/Q70otBxig6nVr5MEdcMQgV
         BtPg==
X-Gm-Message-State: AOAM531MBi6O/pkhSRMxf7hP3ti6ohCkbOWmLByIcywqbRKTMEGI4P/9
        9CYKXOqDAdEovFu/z9HapMnm0W2ZOVhE488Yla8=
X-Google-Smtp-Source: ABdhPJzx18dpnuCcn0hYph8KwM0v4FldEHmci+rz3YWq6Cc6r57VuitGisXKxMyxqlKA4MCNyE+4PqSSJZWk2F0LiJ8=
X-Received: by 2002:a05:6e02:214f:: with SMTP id d15mr12521942ilv.24.1635231684012;
 Tue, 26 Oct 2021 00:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211025192746.66445-1-krisman@collabora.com> <20211025192746.66445-12-krisman@collabora.com>
In-Reply-To: <20211025192746.66445-12-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Oct 2021 10:01:12 +0300
Message-ID: <CAOQ4uxg8Mmi-UH3q3xrxVbrK-GUsF5mTgWG15sfRW3EOJUj3rg@mail.gmail.com>
Subject: Re: [PATCH v9 11/31] fsnotify: Protect fsnotify_handle_inode_event
 from no-inode events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 10:29 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> FAN_FS_ERROR allows events without inodes - i.e. for file system-wide
> errors.  Even though fsnotify_handle_inode_event is not currently used
> by fanotify, this patch protects other backends from cases where neither
> inode or dir are provided.  Also document the constraints of the
> interface (inode and dir cannot be both NULL).
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v8:
>   - Convert verifications to WARN_ON
>   - Require either inode or dir
>   - Protect nfsd backend from !inode.
> ---
>  fs/nfsd/filecache.c              | 3 +++
>  fs/notify/fsnotify.c             | 3 +++
>  include/linux/fsnotify_backend.h | 1 +
>  3 files changed, 7 insertions(+)
>
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index be3c1aad50ea..fdf89fcf1a0c 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -602,6 +602,9 @@ nfsd_file_fsnotify_handle_event(struct fsnotify_mark *mark, u32 mask,
>                                 struct inode *inode, struct inode *dir,
>                                 const struct qstr *name, u32 cookie)
>  {
> +       if (WARN_ON_ONCE(!inode))
> +               return 0;
> +
>         trace_nfsd_file_fsnotify_handle_event(inode, mask);
>
>         /* Should be no marks on non-regular files */
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index fde3a1115a17..4034ca566f95 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -252,6 +252,9 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
>         if (WARN_ON_ONCE(!ops->handle_inode_event))
>                 return 0;
>
> +       if (WARN_ON_ONCE(!inode && !dir))
> +               return 0;
> +
>         if ((inode_mark->mask & FS_EXCL_UNLINK) &&
>             path && d_unlinked(path->dentry))
>                 return 0;
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 035438fe4a43..b71dc788018e 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -136,6 +136,7 @@ struct mem_cgroup;
>   * @dir:       optional directory associated with event -
>   *             if @file_name is not NULL, this is the directory that
>   *             @file_name is relative to.
> + *             Either @inode or @dir must be non-NULL.
>   * @file_name: optional file name associated with event
>   * @cookie:    inotify rename cookie
>   *
> --
> 2.33.0
>
