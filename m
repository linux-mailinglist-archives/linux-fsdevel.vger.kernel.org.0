Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DC63D0C04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 12:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhGUJGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 05:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237945AbhGUI7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:59:10 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C199C061766;
        Wed, 21 Jul 2021 02:39:46 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id s5so1774978ild.5;
        Wed, 21 Jul 2021 02:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqnfXSVw9ZhpYEUhVi5LY+sO2mCns1m2gOR7gfRBMSc=;
        b=QNJatkNKJN+toDL45men9oftNBU/szZw+2yKqRLYVLMMEhvdiIvFJMUYlKDxXpgO3n
         zf8vZdi9nRUKqpaK3GehzJQGPW9eLb/zqvLFyN0AQlEpECEXo+Lh7QjDWlfm+NwZDgp/
         OrQG95Jdt9DecP0sbf4mhDKdVMvoAu900XlygDNeVlA44vW1DIiweI1nnopGm+1zuTPt
         7sd0TVlS90GxJavKo6EMJx2TJ+1e+Uuelc7YKSaXEtFfKnLyJKIM+DgZ0gfUFgXc1dTY
         W40CB5q4L+P5tuVB0OTe4XhH0863jDoWi/8m4O0t2v5alkt6hWGRWnvUJsKEI6Zcs8qP
         LaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqnfXSVw9ZhpYEUhVi5LY+sO2mCns1m2gOR7gfRBMSc=;
        b=LMFL6xc4NJmqq/3C2H200cP7atLebjAM7CU/aSIGLx5dKt+fCqXLfwBmPo6q/8QdO9
         DLwlbbBvqa0VcpQMF/ZtfdkFa7uIVvSuxC3HT+YVJaWPgxHktctmWIcmHFAyb1PBSrkz
         Sq0NEmRt3bywI2gafQRkx5MI6z8QXzX6zXUdTKLT2sZ58M/8b0Oa/L5yryRw9kwrZK8Y
         CnU/BASyXY3kgOCORdQ6AMXPcJZOv+bMv+xhvR3OB9rde+1KvY/xnLRyz2f31iU8CCAd
         13hScGvJiE7qR/hg5vklmvfWUPN6Es/4TI3W173GTV2jVLLHxohDkagEzvp1VwVuHRfP
         rplA==
X-Gm-Message-State: AOAM533uZ8Pu+gaFQ4WhyvBP6nTuPu/SnCSdSjqjphPCj59RqJvJDK9d
        rH0amfhyhOUfQM4M/tQOFSSCC3MsouBdKzYz5LU=
X-Google-Smtp-Source: ABdhPJzZCw2SOmBvYTMKb4JDfD6QiE8adwSlNjsWQ2lSZKwVa7vzCMYYS61MpC6LoCBjLGFRn3V2BO3cSFgWI5IskOc=
X-Received: by 2002:a05:6e02:d93:: with SMTP id i19mr11519754ilj.72.1626860385644;
 Wed, 21 Jul 2021 02:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210720155944.1447086-1-krisman@collabora.com> <20210720155944.1447086-14-krisman@collabora.com>
In-Reply-To: <20210720155944.1447086-14-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 21 Jul 2021 12:39:34 +0300
Message-ID: <CAOQ4uxiFWmBKBDh8s5GZzCZMQiD9RKvqpxT+1pjjLmTGRX2dnw@mail.gmail.com>
Subject: Re: [PATCH v4 13/16] fanotify: Introduce FAN_FS_ERROR event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 7:00 PM Gabriel Krisman Bertazi
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

commit message is out dated.

>
> An error reporting structure is attached per-mark, and only a single
> error can be stored at a time.  This is ok, since once an error occurs,
> it is common for a stream of related errors to be reported.  We only log
> accumulate the total of errors occurred since the last notification.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---

Part #2 of review:

[...]

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 0696f2121781..bfc6bf6be197 100644
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
> @@ -167,6 +172,90 @@ static void fanotify_unhash_event(struct fsnotify_group *group,
>         hlist_del_init(&event->merge_list);
>  }
>
> +static struct fanotify_error_event *fanotify_alloc_error_event(
> +                                       struct fanotify_sb_mark *sb_mark,
> +                                       int fh_len)
> +{
> +       struct fanotify_error_event *fee;
> +       struct super_block *sb;
> +
> +       if (!fh_len) {
> +               /*
> +                * The FH buffer size is predicted to be the same size
> +                * as the root inode file handler.  This should work for
> +                * file systems without variable sized FH.
> +                */
> +               sb = container_of(sb_mark->fsn_mark.connector->obj,
> +                                 struct super_block, s_fsnotify_marks);
> +               fh_len = fanotify_encode_fh_len(sb->s_root->d_inode);

We need to make sure that fh_len is at least 8 bytes.
We could also take care of that inside fanotify_encode_fh_len.

> +       }
> +
> +       fee = kzalloc(sizeof(*fee) + fh_len, GFP_KERNEL_ACCOUNT);
> +       if (!fee)
> +               return NULL;
> +
> +       fanotify_init_event(&fee->fae, 0, FS_ERROR);
> +       fee->sb_mark = sb_mark;
> +       fee->max_fh_len = fh_len;


I don't understand this logic.
I think we need to store max_fh_len in fanotify_sb_mark struct
and maybe rename to error event member to fh_buf_len.

fanotify_add_mark() should initialize max_fh_len of the sb mark according
to sb->s_root->d_inode.

When insert_error_event fails to encode fh because it does not fit in the
event allocated fh_buf_len, it needs to update the sb_mark's max_fh_len
(with notification lock held).

The next event read will use the new max_fh_len to allocate an event
with a larger buffer and resolve the error condition.

I may be missing something but I don't see how your implementation
resolves the error condition?

> +
> +       return fee;
> +}
> +
> +/*
> + * Replace a mark's error event with a new structure in preparation for
> + * it to be dequeued.  This is a bit annoying since we need to drop the
> + * lock, so another thread might just steal the event from us.
> + */
> +static struct fanotify_event *fanotify_replace_fs_error_event(
> +                                       struct fsnotify_group *group,
> +                                       struct fanotify_event *fae)
> +{
> +       struct fanotify_error_event *new, *fee = FANOTIFY_EE(fae);
> +       struct fanotify_sb_mark *sb_mark = fee->sb_mark;
> +       struct fsnotify_event *fse;
> +       int max_fh_len = fee->max_fh_len;
> +       int fh_len = fanotify_event_object_fh_len(fae);
> +
> +       pr_debug("%s: event=%p\n", __func__, fae);
> +
> +       assert_spin_locked(&group->notification_lock);
> +
> +       spin_unlock(&group->notification_lock);
> +       new = fanotify_alloc_error_event(sb_mark, fee->max_fh_len);
> +       spin_lock(&group->notification_lock);
> +
> +       if (!new)
> +               return ERR_PTR(-ENOMEM);
> +
> +       /*
> +        * Since we temporarily dropped the notification_lock, the event
> +        * might have been taken from under us and reported by another
> +        * reader.  Peek again prior to removal.
> +        *
> +        * Maybe this is not the same event we started handling.  But as
> +        * long as it is also a same size error event for the same
> +        * filesystem, it is safe to reuse the allocated memory.
> +        */

I don't like this optimization. It doesn't gain much and adds complexity.
If it's not the same event we started handling please return EAGAIN.

> +       fse = fsnotify_peek_first_event(group);
> +       if (!fse || !fanotify_is_error_event(FANOTIFY_E(fse)->mask))
> +               goto fail;
> +
> +       fae = FANOTIFY_E(fse);
> +       fee = FANOTIFY_EE(fae);
> +       if (fee->sb_mark != sb_mark || max_fh_len != fee->max_fh_len  ||
> +           fh_len < fanotify_event_object_fh_len(fae))
> +               goto fail;
> +
> +       sb_mark->error_event = new;
> +
> +       return fae;
> +
> +fail:
> +       kfree(new);
> +
> +       return ERR_PTR(-EAGAIN);
> +}
> +
>  /*
>   * Get an fanotify notification event if one exists and is small
>   * enough to fit in "count". Return an error pointer if the count
> @@ -196,9 +285,20 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
>                 goto out;
>         }
>
> +       if (fanotify_is_error_event(event->mask)) {
> +               /*
> +                * Recreate the error event ahead of dequeueing so we
> +                * don't need to handle a incorrectly dequeued event.
> +                */
> +               event = fanotify_replace_fs_error_event(group, event);
> +               if (IS_ERR(event))
> +                       goto out;
> +       }
> +
>         /*
> -        * Held the notification_lock the whole time, so this is the
> -        * same event we peeked above.
> +        * This might not be the same event peeked above, if
> +        * fanotify_recreate_fs_error raced with another reader. It is
> +        * guaranteed to succeed, though.

I don't think we need to drop this assumption.

>          */
>         fsnotify_remove_first_event(group);
>         if (fanotify_is_perm_event(event->mask))
> @@ -310,6 +410,28 @@ static int process_access_response(struct fsnotify_group *group,
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
> @@ -468,6 +590,14 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
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
> @@ -580,6 +710,8 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
>                 event = get_one_event(group, count);
>                 if (IS_ERR(event)) {
>                         ret = PTR_ERR(event);
> +                       if (ret == -EAGAIN)
> +                               continue;
>                         break;
>                 }
>
> @@ -993,7 +1125,9 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>                              __kernel_fsid_t *fsid)
>  {
>         struct fsnotify_mark *fsn_mark;
> +       struct fanotify_sb_mark *sb_mark;
>         __u32 added;
> +       int ret = 0;
>
>         mutex_lock(&group->mark_mutex);
>         fsn_mark = fsnotify_find_mark(connp, group);
> @@ -1004,13 +1138,34 @@ static int fanotify_add_mark(struct fsnotify_group *group,
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
> +               sb_mark = FANOTIFY_SB_MARK(fsn_mark);
> +
> +               if (!sb_mark->error_event) {
> +                       sb_mark->error_event =
> +                               fanotify_alloc_error_event(sb_mark, 0);
> +                       if (!sb_mark->error_event) {
> +                               ret = -ENOMEM;
> +                               goto out;
> +                       }
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
> @@ -1382,14 +1537,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>                 goto fput_and_out;
>
>         /*
> -        * Events with data type inode do not carry enough information to report
> -        * event->fd, so we do not allow setting a mask for inode events unless
> -        * group supports reporting fid.
> -        * inode events are not supported on a mount mark, because they do not
> -        * carry enough information (i.e. path) to be filtered by mount point.
> -        */
> +       * Events that do not carry enough information to report
> +       * event->fd require a group that supports reporting fid.  Those
> +       * events are not supported on a mount mark, because they do not
> +       * carry enough information (i.e. path) to be filtered by mount
> +       * point.
> +       */
>         fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> -       if (mask & FANOTIFY_INODE_EVENTS &&
> +       if (!(mask & FANOTIFY_FD_EVENTS) &&
>             (!fid_mode || mark_type == FAN_MARK_MOUNT))
>                 goto fput_and_out;
>

[...]

> @@ -81,9 +81,13 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
>   */
>  #define FANOTIFY_DIRENT_EVENTS (FAN_MOVE | FAN_CREATE | FAN_DELETE)
>
> -/* Events that can only be reported with data type FSNOTIFY_EVENT_INODE */
> +/* Events that can be reported with event->fd */
> +#define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
> +
> +/* Events that can only be reported to groups that support FID mode */
>  #define FANOTIFY_INODE_EVENTS  (FANOTIFY_DIRENT_EVENTS | \

I know this macro is unused now, but let's call it FANOTIFY_FID_EVENTS please,
because FAN_FS_ERROR does not have data type INODE.

Thanks,
Amir.
