Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7035342E86F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 07:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbhJOFl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 01:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJOFl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 01:41:58 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64F1C061570;
        Thu, 14 Oct 2021 22:39:52 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d11so5942164ilc.8;
        Thu, 14 Oct 2021 22:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJH54z5FrApYnv352nJKhrkNVvoyaeKQ0P2zUWx5Lm0=;
        b=o4uiMlwrKyI52tb61elVw0KsuZ2tRZNqn0oHZUglxYBSgrJ7Zo50pSd39h/jINBarR
         hzng2IUkAFBHzWo26pbi9gGuK3N0dGx0j1fbkPHMq5t/xQ1FrAv9Vd90ff9UPqu+Uj5H
         VQW430K09xTbyRJcMVkSdTbr9jiWdDGhmHKRQiJyxeJQU7v+TA9hlOBuDdMKFhARrBNJ
         si8FoIH4AJ3MeyNH12KlYOSkg6uAeEMIpECljqPLiaUCIpLCpDd42W5+Te7oYk95EIsx
         3TBmN5Ee05t6hTbvWl4IsIS9kfLIsaoKJIAGNreBT5z/JzkmOS+t9REs1yT7+aSKAjIt
         DzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJH54z5FrApYnv352nJKhrkNVvoyaeKQ0P2zUWx5Lm0=;
        b=TYl7P6NBg25L8Ljh4+vEK19EIoxdMiytGI/YmdV1RYfJB3hY5hyrg9z1YCkVpH9yoB
         2Yzrof4LNGYh5xzhScLWCEhpZa8TjdHvGmEe3QdtanHpSGWqB5hry1mUzehM/ltymEH1
         wghH22TzZcAs2ZsQeP1MyuycQoU/9gA037/tYZlTe9hFsVkV8aJCbOJmHHOZKOu5tfsY
         PU14S31+YETuY9fLu+wUc8Pd7uYaFFbsqV1VUXrDZ1mb4wBIDo6EUpIBYkpymfLZsb2C
         OfkRW8QUbGaMZOrWfmq3nH7fEX/UEJmbAE17zJvk9k97jap00yA+EAXebqUvKfwNYDO2
         iU6g==
X-Gm-Message-State: AOAM53202ipoSc0ne92ZjbVesUiwaxM47agofONvGXrN0XLvL8eoN3Wt
        YboKyPpizoPebpq2U+fkIgV7A+MTYTTUQcIyB3K5bIdt1A4=
X-Google-Smtp-Source: ABdhPJz+zXN8mVBqmPXk3Dlpb7LQQN+eENOE2Z7mVprofVOqD6HhbR+jf7IGnKchfIgBHTlD7Xq9fzd9AQZUj4INd/M=
X-Received: by 2002:a05:6e02:1be8:: with SMTP id y8mr2458946ilv.24.1634276390657;
 Thu, 14 Oct 2021 22:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com> <20211014213646.1139469-11-krisman@collabora.com>
In-Reply-To: <20211014213646.1139469-11-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 08:39:39 +0300
Message-ID: <CAOQ4uxhNDjPbcdLGYAQp78TwTkPWxfoeQ=7OoKfkQG0SW6X4wg@mail.gmail.com>
Subject: Re: [PATCH v7 10/28] fsnotify: Retrieve super block from the data field
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:38 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Some file system events (i.e. FS_ERROR) might not be associated with an
> inode or directory.  For these, we can retrieve the super block from the
> data field.  But, since the super_block is available in the data field
> on every event type, simplify the code to always retrieve it from there,
> through a new helper.
>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>
> --
> Changes since v6:
>   - Always use data field for superblock retrieval
> Changes since v5:
>   - add fsnotify_data_sb handle to retrieve sb from the data field. (jan)
> ---
>  fs/notify/fsnotify.c             |  7 +++----
>  include/linux/fsnotify_backend.h | 15 +++++++++++++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 963e6ce75b96..fde3a1115a17 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -455,16 +455,16 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
>   *             @file_name is relative to
>   * @file_name: optional file name associated with event
>   * @inode:     optional inode associated with event -
> - *             either @dir or @inode must be non-NULL.
> - *             if both are non-NULL event may be reported to both.
> + *             If @dir and @inode are both non-NULL, event may be
> + *             reported to both.
>   * @cookie:    inotify rename cookie
>   */
>  int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>              const struct qstr *file_name, struct inode *inode, u32 cookie)
>  {
>         const struct path *path = fsnotify_data_path(data, data_type);
> +       struct super_block *sb = fsnotify_data_sb(data, data_type);
>         struct fsnotify_iter_info iter_info = {};
> -       struct super_block *sb;
>         struct mount *mnt = NULL;
>         struct inode *parent = NULL;
>         int ret = 0;
> @@ -483,7 +483,6 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>                  */
>                 parent = dir;
>         }
> -       sb = inode->i_sb;
>
>         /*
>          * Optimization: srcu_read_lock() has a memory barrier which can
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index b323d0c4b967..035438fe4a43 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -289,6 +289,21 @@ static inline const struct path *fsnotify_data_path(const void *data,
>         }
>  }
>
> +static inline struct super_block *fsnotify_data_sb(const void *data,
> +                                                  int data_type)
> +{
> +       switch (data_type) {
> +       case FSNOTIFY_EVENT_INODE:
> +               return ((struct inode *)data)->i_sb;
> +       case FSNOTIFY_EVENT_DENTRY:
> +               return ((struct dentry *)data)->d_sb;
> +       case FSNOTIFY_EVENT_PATH:
> +               return ((const struct path *)data)->dentry->d_sb;
> +       default:
> +               return NULL;
> +       }
> +}
> +
>  enum fsnotify_obj_type {
>         FSNOTIFY_OBJ_TYPE_INODE,
>         FSNOTIFY_OBJ_TYPE_PARENT,
> --
> 2.33.0
>
