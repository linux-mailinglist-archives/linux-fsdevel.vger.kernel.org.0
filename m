Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C4F3EB1F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 09:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbhHMHtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 03:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239614AbhHMHtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:49:36 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C48C061756;
        Fri, 13 Aug 2021 00:49:09 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id z2so9959092iln.0;
        Fri, 13 Aug 2021 00:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUPcvao+VBLMcbahATQc4c2Hj6GHt0UJVmJ7mxM52JQ=;
        b=vcUg15tVKamX4wju606nE+FkbLMr8dgv3HdqkZwLcDcCgueO2G9Ax9TDRP6sHHAuet
         uOuxHV3SJsdY07NN16UMbKquEUctzUoD5EVVbKd6QkerAEby2jU8fQnMHvSVMRqR7uUC
         s+B4+wXwrIdcY7lGy3HxHrmc+M0HOU/3nRcxwl1bP2q+nEcNy9YBRhsKtun+Z1vCQ9Ia
         M6CEf+3Nu5oPlJ77NmTR8GBa0ZtWpFu8fk5ut87GmsVTqNAQ/PgjdKUZwrg6c6FkCZpR
         6anBMRPdIaURyauaGCTKhWw9Wk3eWRygMJkm4hNXQgb7QqyCkxa4P3sSyvcpJUPAx1/Z
         tAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUPcvao+VBLMcbahATQc4c2Hj6GHt0UJVmJ7mxM52JQ=;
        b=aTjh8+9+Kqjl1xqoJMVx4/b1enBOjjt01JpJBQxyiP6XS6x/gTIhaN+2786uvKvn8Z
         R6fPdiBTwi652ltNHUYz4/kw2/mYZDT5XIxNlI60W62YZPy8wS+A9MaZSwNIeSkXC/Ew
         v4TcXXjcjsXxIYoOD4IDZcZmLPmV+xTSZqYckY49wB4oYa6ugIiXzei4l7ZcwsnsgSXg
         fZXvdi5ppvzMUlgNJbfUUHVuJhAomkrbv6fL2wRSqkwBOKSbq+RLwE5gKJzyqJqBprCq
         Ad2RqXWUD9BKij8ZRVKNdR04xvVznkFarotHcw9Wj55uAj7f11PaJTRzo/OxOn5gITgq
         VJ1Q==
X-Gm-Message-State: AOAM5334Qs/ysRy1nSM0ZzrXCHFhKsB6ymChze6H0hjRD/IKfvW5r2Bz
        oDnSpBkCEnW8GX5+HMeIyW34wIAn2GSx51TyW3s=
X-Google-Smtp-Source: ABdhPJwgS4MWrwRMZWLIU1ghPAUoXXnMP3aoFYmIgTLmrXLTvNmqcVuq//oGG5gNGjL9T90WoqPYCY9A5+GnR4k+mKY=
X-Received: by 2002:a92:8702:: with SMTP id m2mr960247ild.250.1628840949100;
 Fri, 13 Aug 2021 00:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com> <20210812214010.3197279-11-krisman@collabora.com>
In-Reply-To: <20210812214010.3197279-11-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Aug 2021 10:48:58 +0300
Message-ID: <CAOQ4uxinGS-FA_Ue2PQeYktug+JtOL-6-aXSzw4qFagTR7P8sw@mail.gmail.com>
Subject: Re: [PATCH v6 10/21] fsnotify: Support FS_ERROR event type
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
> Expose a new type of fsnotify event for filesystems to report errors for
> userspace monitoring tools.  fanotify will send this type of
> notification for FAN_FS_ERROR events.  This also introduce a helper for
> generating the new event.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>
> ---
> Changes since v5:
>   - pass sb inside data field (jan)
> Changes since v3:
>   - Squash patch ("fsnotify: Introduce helpers to send error_events")
>   - Drop reviewed-bys!
>
> Changes since v2:
>   - FAN_ERROR->FAN_FS_ERROR (Amir)
>
> Changes since v1:
>   - Overload FS_ERROR with FS_IN_IGNORED
>   - Implement support for this type on fsnotify_data_inode (Amir)
> ---
>  fs/notify/fsnotify.c             |  3 +++
>  include/linux/fsnotify.h         | 13 +++++++++++++
>  include/linux/fsnotify_backend.h | 18 +++++++++++++++++-
>  3 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 536db02cb26e..6d3b3de4f8ee 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -103,6 +103,9 @@ static struct super_block *fsnotify_data_sb(const void *data, int data_type)
>         struct inode *inode = fsnotify_data_inode(data, data_type);
>         struct super_block *sb = inode ? inode->i_sb : NULL;
>
> +       if (!sb && data_type == FSNOTIFY_EVENT_ERROR)
> +               sb = ((struct fs_error_report *) data)->sb;
> +
>         return sb;
>  }
>
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index f8acddcf54fb..521234af1827 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -317,4 +317,17 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
>                 fsnotify_dentry(dentry, mask);
>  }
>
> +static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
> +                                   int error)
> +{
> +       struct fs_error_report report = {
> +               .error = error,
> +               .inode = inode,
> +               .sb = sb,
> +       };
> +
> +       return fsnotify(FS_ERROR, &report, FSNOTIFY_EVENT_ERROR,
> +                       NULL, NULL, NULL, 0);
> +}
> +
>  #endif /* _LINUX_FS_NOTIFY_H */
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index e027af3cd8dd..277b6f3e0998 100644
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
> @@ -248,6 +255,13 @@ enum fsnotify_data_type {
>         FSNOTIFY_EVENT_NONE,
>         FSNOTIFY_EVENT_PATH,
>         FSNOTIFY_EVENT_INODE,
> +       FSNOTIFY_EVENT_ERROR,
> +};
> +
> +struct fs_error_report {
> +       int error;
> +       struct inode *inode;
> +       struct super_block *sb;
>  };
>
>  static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
> @@ -257,6 +271,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
>                 return (struct inode *)data;
>         case FSNOTIFY_EVENT_PATH:
>                 return d_inode(((const struct path *)data)->dentry);
> +       case FSNOTIFY_EVENT_ERROR:
> +               return ((struct fs_error_report *)data)->inode;
>         default:
>                 return NULL;
>         }
> --
> 2.32.0
>
