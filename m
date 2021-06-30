Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA2B3B80DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhF3K2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 06:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhF3K2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 06:28:45 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8250C061756;
        Wed, 30 Jun 2021 03:26:15 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o10so2359920ils.6;
        Wed, 30 Jun 2021 03:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=helfDWN/FXXIiwTFzOIn1d/Z6iHEpKz62bryP2tLe1s=;
        b=DQKbQER1OvJNu9vYpCP0WYAGgrlqa4QapCZ2B4kt9G/4c/ZQSWRbLZfr4rkemZu/hZ
         UGMHbgt1WFTeiuNh/F64zavd19n1r8RlGZWtlXaFEgve7fKFXRDi+dWDn8KWURXbtooJ
         pUzLph94eWeKFnQsCuH40ESFH7tWKhTmtNvfwLFuuHFfT5l7R65yNWLU7LYcz1lUJbSa
         hiYz9823Ktk0iC2MHZAY2ek2l91oapp2/zKIfT7ws8l6kThvHYw2P7huEXuiHfiqVdLu
         SwpeWWi2fdzVIGvivqik0HYR7wM/1e9yIQsuYgznYLuNBZpBXY+fGTcrwu1o65qzHCWo
         cj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=helfDWN/FXXIiwTFzOIn1d/Z6iHEpKz62bryP2tLe1s=;
        b=mRUsXJp+WRv6HKMbOxZMk7LfNesj2KarHbdaYgcE+UMDvQCofKZEJzewLOQCmzYd/E
         4YyTgCEwWdEIBvC6DYFuEXhVIXJI/PqNJjkgExRtTwZ8paUmf+hgl0nmILxQ0DewEMlN
         ypu8sILNGhxDkpCnQ2Hxi1zTZ+IoEuk/tNTrtuYxFTW2lXPX01kMmW3OtfXPclvLIKCB
         w9HX4XtZ6k/BoLjFD8+D+6LIfj2oUzJqZR4gvd+I/l1ZiuJgdnuM/sXLUbfj0fHqfXxz
         rTePvYFKVrKtoKWZow2GBy9XbaLGRQCURAHfQ1PbcRp0MOGhM5GbY8DneXXh0Ksv7BLe
         PKoA==
X-Gm-Message-State: AOAM531FJ//ZyQLIGI/NBIFje+Lw4ht6S2krHfYq8UiSgu0xkfNbiplF
        AZD/WVSVUHqX5eAFPskNEK0EKRLWFWBGfExTmpg=
X-Google-Smtp-Source: ABdhPJwragCUdq/DCOMdYcsw0weGvVytTPv8rhe6+QBbmSdoIk5Ie3kUCFAiiBSV6nvZkAn9BcVgFtey3ePua+mE2T8=
X-Received: by 2002:a92:dd05:: with SMTP id n5mr14769418ilm.72.1625048775015;
 Wed, 30 Jun 2021 03:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com> <20210629191035.681913-13-krisman@collabora.com>
In-Reply-To: <20210629191035.681913-13-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 13:26:03 +0300
Message-ID: <CAOQ4uxiUYAwj561=ap_Hq6AwRdAdZFY1yQ99Y9_ahsd82-qFug@mail.gmail.com>
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
>   - Base merging on error_count
>   - drop fanotify_queue_error_event
>
> Changes since v1:
>   - Pass dentry to fanotify_check_fsid (Amir)
>   - FANOTIFY_EVENT_TYPE_ERROR -> FANOTIFY_EVENT_TYPE_FS_ERROR
>   - Merge previous patch into it
>   - Use a single slot
>   - Move fanotify_mark.error_event definition to this commit
>   - Rename FAN_ERROR -> FAN_FS_ERROR
>   - Restrict FAN_FS_ERROR to FAN_MARK_FILESYSTEM
> ---
>  fs/notify/fanotify/fanotify.c      | 108 +++++++++++++++++++++++------
>  fs/notify/fanotify/fanotify.h      |  53 ++++++++++++++
>  fs/notify/fanotify/fanotify_user.c |  97 +++++++++++++++++++++++++-
>  include/linux/fanotify.h           |  11 ++-
>  include/uapi/linux/fanotify.h      |   8 +++
>  5 files changed, 253 insertions(+), 24 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 769703ef2b9a..854adcbeb95d 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -336,23 +336,6 @@ static u32 fanotify_group_event_mask(
>         return test_mask & user_mask;
>  }
>
> -/*
> - * Check size needed to encode fanotify_fh.
> - *
> - * Return size of encoded fh without fanotify_fh header.
> - * Return 0 on failure to encode.
> - */
> -static int fanotify_encode_fh_len(struct inode *inode)
> -{
> -       int dwords = 0;
> -
> -       if (!inode)
> -               return 0;
> -
> -       exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
> -
> -       return dwords << 2;
> -}
>
>  /*
>   * Encode fanotify_fh.
> @@ -405,8 +388,12 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>         fh->type = type;
>         fh->len = fh_len;
>
> -       /* Mix fh into event merge key */
> -       *hash ^= fanotify_hash_fh(fh);
> +       /*
> +        * Mix fh into event merge key.  Hash might be NULL in case of
> +        * unhashed FID events (i.e. FAN_FS_ERROR).
> +        */
> +       if (hash)
> +               *hash ^= fanotify_hash_fh(fh);
>
>         return FANOTIFY_FH_HDR_LEN + fh_len;
>
> @@ -692,6 +679,60 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
>         return fsid;
>  }
>
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
> +


I'd like to address the review of this patch in two parts.
First, I will comments on minor technical details.
Stay tuned for another reply regarding this merge() method...

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

WARN_ON() is not acceptable for things that can logically happen
if you think this is important you could use pr_warn_ratelimited()
like we do in fanotify_encode_fh(),
but since fs-monitor will observe the lack of FID anyway, I think
there is little point in reporting this to kmsg.

> +               return;
> +
> +       fanotify_encode_fh(&fee->object_fh, inode, fh_len, NULL, 0);
> +}
> +
>  /*
>   * Add an event to hash table for faster merge.
>   */
> @@ -742,8 +783,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>         BUILD_BUG_ON(FAN_ONDIR != FS_ISDIR);
>         BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
>         BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
> +       BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>
> -       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
> +       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
>
>         mask = fanotify_group_event_mask(group, mask, event_info, iter_info);
>         if (!mask)
> @@ -767,6 +809,17 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>                         return 0;
>         }
>
> +       if (fanotify_is_error_event(mask)) {
> +               struct fanotify_sb_mark *sb_mark =
> +                       FANOTIFY_SB_MARK(fsnotify_iter_sb_mark(iter_info));
> +
> +               ret = fsnotify_add_event(group, &sb_mark->error_event->fae.fse,
> +                                        fanotify_merge_error_event,
> +                                        fanotify_insert_error_event,
> +                                        event_info);
> +               goto finish;
> +       }
> +
>         event = fanotify_alloc_event(group, mask, event_info, &fsid);
>         ret = -ENOMEM;
>         if (unlikely(!event)) {
> @@ -834,6 +887,17 @@ static void fanotify_free_name_event(struct fanotify_event *event)
>         kfree(FANOTIFY_NE(event));
>  }
>
> +static void fanotify_free_error_event(struct fanotify_event *event)
> +{
> +       /*
> +        * Just drop the reference acquired by
> +        * fanotify_insert_error_event.
> +        *
> +        * The actual memory is freed with the mark.
> +        */
> +       fsnotify_put_mark(FANOTIFY_EE(event)->mark);
> +}
> +
>  static void fanotify_free_event(struct fsnotify_event *fsn_event)
>  {
>         struct fanotify_event *event;
> @@ -856,6 +920,9 @@ static void fanotify_free_event(struct fsnotify_event *fsn_event)
>         case FANOTIFY_EVENT_TYPE_OVERFLOW:
>                 kfree(event);
>                 break;
> +       case FANOTIFY_EVENT_TYPE_FS_ERROR:
> +               fanotify_free_error_event(event);
> +               break;
>         default:
>                 WARN_ON_ONCE(1);
>         }
> @@ -873,6 +940,7 @@ static void fanotify_free_mark(struct fsnotify_mark *mark)
>         if (mark->flags & FSNOTIFY_MARK_FLAG_SB) {
>                 struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
>
> +               kfree(fa_mark->error_event);
>                 kmem_cache_free(fanotify_sb_mark_cache, fa_mark);
>         } else {
>                 kmem_cache_free(fanotify_mark_cache, mark);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 2e005b3a75f2..0259d631b8d8 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -132,6 +132,7 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
>
>  struct fanotify_sb_mark {
>         struct fsnotify_mark fsn_mark;
> +       struct fanotify_error_event *error_event;
>  };
>
>  static inline
> @@ -154,6 +155,7 @@ enum fanotify_event_type {
>         FANOTIFY_EVENT_TYPE_PATH,
>         FANOTIFY_EVENT_TYPE_PATH_PERM,
>         FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
> +       FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
>         __FANOTIFY_EVENT_TYPE_NUM
>  };
>
> @@ -209,12 +211,37 @@ FANOTIFY_NE(struct fanotify_event *event)
>         return container_of(event, struct fanotify_name_event, fae);
>  }
>
> +struct fanotify_error_event {
> +       struct fanotify_event fae;
> +       s32 error;                      /* Error reported by the Filesystem. */
> +       atomic_t err_count;             /* Suppressed errors count */
> +       __kernel_fsid_t fsid;           /* FSID this error refers to. */
> +
> +       struct fsnotify_mark *mark;     /* Back reference to the mark. */
> +       int max_fh_len;                 /* Maximum object_fh buffer size. */
> +
> +       /*
> +        * object_fh is followed by a variable sized buffer, so it must
> +        * be the last element of this structure.
> +        */
> +       struct fanotify_fh object_fh;
> +};
> +
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
>                 return &FANOTIFY_FE(event)->fsid;
>         else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
>                 return &FANOTIFY_NE(event)->fsid;
> +       else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
> +               return &FANOTIFY_EE(event)->fsid;
>         else
>                 return NULL;
>  }
> @@ -226,6 +253,8 @@ static inline struct fanotify_fh *fanotify_event_object_fh(
>                 return &FANOTIFY_FE(event)->object_fh;
>         else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
>                 return fanotify_info_file_fh(&FANOTIFY_NE(event)->info);
> +       else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
> +               return &FANOTIFY_EE(event)->object_fh;
>         else
>                 return NULL;
>  }
> @@ -300,6 +329,11 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
>         return container_of(fse, struct fanotify_event, fse);
>  }
>
> +static inline bool fanotify_is_error_event(u32 mask)
> +{
> +       return mask & FANOTIFY_ERROR_EVENTS;
> +}
> +
>  static inline bool fanotify_event_has_path(struct fanotify_event *event)
>  {
>         return event->type == FANOTIFY_EVENT_TYPE_PATH ||
> @@ -329,6 +363,7 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
>  static inline bool fanotify_is_hashed_event(u32 mask)
>  {
>         return !(fanotify_is_perm_event(mask) ||
> +                fanotify_is_error_event(mask) ||
>                  fsnotify_is_overflow_event(mask));
>  }
>
> @@ -338,3 +373,21 @@ static inline unsigned int fanotify_event_hash_bucket(
>  {
>         return event->hash & FANOTIFY_HTABLE_MASK;
>  }
> +
> +/*
> + * Check size needed to encode fanotify_fh.
> + *
> + * Return size of encoded fh without fanotify_fh header.
> + * Return 0 on failure to encode.
> + */
> +static inline int fanotify_encode_fh_len(struct inode *inode)
> +{
> +       int dwords = 0;
> +
> +       if (!inode)
> +               return 0;
> +
> +       exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
> +
> +       return dwords << 2;
> +}
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index a42521e140e6..8bcce26e21df 100644
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
> @@ -310,6 +315,30 @@ static int process_access_response(struct fsnotify_group *group,
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
> +       if (copy_to_user(buf, &info, sizeof(info)))
> +               return -EFAULT;
> +
> +       return info.hdr.len;
> +}
> +
>  static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>                              int info_type, const char *name, size_t name_len,
>                              char __user *buf, size_t count)
> @@ -468,6 +497,14 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
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
> @@ -896,6 +933,43 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
>                                     flags, umask);
>  }
>
> +static int fanotify_create_fs_error_event(struct fsnotify_mark *fsn_mark,
> +                                          fsnotify_connp_t *connp)
> +{
> +       struct fanotify_sb_mark *sb_mark = FANOTIFY_SB_MARK(fsn_mark);
> +       struct super_block *sb =
> +               container_of(connp, struct super_block, s_fsnotify_marks);
> +       struct fanotify_error_event *fee;
> +       int fh_len;
> +
> +       /*
> +        * Since the allocation is done holding group->mark_mutex, the
> +        * error event allocation is guaranteed not to race with itself.

If this is protected by a mutex then READ_ONCE/WRITE_ONCE are not need
and the comment above is confusing.
You should fire your code reviewer ;-)

> +        */
> +       if (READ_ONCE(sb_mark->error_event))
> +               return 0;
> +
> +       /* Since, for error events, every memory must be preallocated,
> +        * the FH buffer size is predicted to be the same as the root
> +        * inode file handler size.  This should work for file systems
> +        * without variable sized FH.
> +        */
> +       fh_len = fanotify_encode_fh_len(sb->s_root->d_inode);
> +
> +       fee = kzalloc(sizeof(*fee) + fh_len, GFP_KERNEL);

GFP_KERNEL_ACCOUNT

> +       if (!fee)
> +               return -ENOMEM;
> +
> +       fanotify_init_event(&fee->fae, 0, FS_ERROR);
> +       fee->mark = fsn_mark;
> +       fee->max_fh_len = fh_len;
> +
> +       WRITE_ONCE(sb_mark->error_event, fee);
> +
> +       return 0;
> +
> +}
> +
>  static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
>                                        __u32 mask,
>                                        unsigned int flags)
> @@ -994,6 +1068,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>  {
>         struct fsnotify_mark *fsn_mark;
>         __u32 added;
> +       int ret = 0;
>
>         mutex_lock(&group->mark_mutex);
>         fsn_mark = fsnotify_find_mark(connp, group);
> @@ -1004,13 +1079,28 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>                         return PTR_ERR(fsn_mark);
>                 }
>         }
> +
> +       /*
> +        * Error events are allocated per super-block mark, but only if
> +        * strictly needed (i.e. FAN_FS_ERROR was requested).
> +        */
> +       if (type == FSNOTIFY_OBJ_TYPE_SB && !(flags & FAN_MARK_IGNORED_MASK) &&
> +           (mask & FAN_FS_ERROR)) {
> +               if (fanotify_create_fs_error_event(fsn_mark, connp)) {
> +                       ret = -ENOMEM;
> +                       goto out;
> +               }
> +       }
> +
>         added = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
>         if (added & ~fsnotify_conn_mask(fsn_mark->connector))
>                 fsnotify_recalc_mask(fsn_mark->connector);
> +
> +out:
>         mutex_unlock(&group->mark_mutex);
>
>         fsnotify_put_mark(fsn_mark);
> -       return 0;
> +       return ret;
>  }
>
>  static int fanotify_add_vfsmount_mark(struct fsnotify_group *group,
> @@ -1427,6 +1517,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>                 fsid = &__fsid;
>         }
>
> +       if (mask & FAN_FS_ERROR && mark_type != FAN_MARK_FILESYSTEM) {
> +               ret = -EINVAL;
> +               goto path_put_and_out;
> +       }
> +
>         /* inode held in place by reference to path; group by fget on fd */
>         if (mark_type == FAN_MARK_INODE)
>                 inode = path.dentry->d_inode;
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index a16dbeced152..d086a19aff63 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -81,13 +81,17 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
>   */
>  #define FANOTIFY_DIRENT_EVENTS (FAN_MOVE | FAN_CREATE | FAN_DELETE)
>
> -/* Events that can only be reported with data type FSNOTIFY_EVENT_INODE */
> +#define FANOTIFY_ERROR_EVENTS  (FAN_FS_ERROR)
> +
> +/* Events that can only be reported to groups that support FID mode */

Let's not do that.
How about the opposite:

/* Events that can be reported with event->fd */
#define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)

        /*
         * Events that do not carry enough information to report event->fd
         * require a group that supports reporting fid.
         * Those events are not supported on a mount mark, because they do
         * not carry enough information (i.e. path) to be filtered by
mount point.
         */
        fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
        if (!(mask & FANOTIFY_FD_EVENTS) &&
            (!fid_mode || mark_type == FAN_MARK_MOUNT))

Thanks,
Amir.
