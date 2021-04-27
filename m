Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8DE36BF11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 08:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhD0GDr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 02:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhD0GDq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:03:46 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA54C061574;
        Mon, 26 Apr 2021 23:03:04 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id c15so1223370ilj.1;
        Mon, 26 Apr 2021 23:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MV9NoEK1cal4ul8qF4aeSQtJ02tQye3pVXfcdyKAMs=;
        b=Yn4tHF8l7rmGuf0O67NLSCyzc34+ZSxmXxwCgHnhGnyhw/4CWcHvbl4m7HpTPzNwdq
         UC1laTPeJ+0dRhjLRs6cNRK2xoEzaiPQWJlyU6fev+igX1tZLBOXqhUrkbj6Q+NN+vJ4
         7xnmEfOfbDorJGawMqbUy+4J+T51d9n6/OAL1O8pqe1Bp0Gp5jTLMUwdd4JOIKZi5U4R
         ZQIDIKWRatHMvDIZT0e1hQvk9ZIH/adKHb3qqhyzBOMHQnOzQ/LH5GlGQ3zvQlLWVSql
         DvkMQSNJewqzgOvlN7KWyGdFIJ8bpzN5DcjaSTFE/hYG/vhGlOeBNwhBXiC1UJmJOHY8
         VSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MV9NoEK1cal4ul8qF4aeSQtJ02tQye3pVXfcdyKAMs=;
        b=F7k/4WuDnwNCOa+3FVl4n6pDCB6LtygMo8Fp6R5aM5zGa7sP+RFIHexQzaBVcKOb7f
         OsYM8YH0cNCpid0zqzAr3A/F2UIs6x7EgXvkyu/YQFDf2O6oM38ee1JJrvdVlSuQaLTl
         V3gdxvl2zVfkbAF+CY2lAhnjdRD75bzIGNP/GvgYr+Q70wwFHQXSp9Jy2yYsCpkK7ERs
         shLtiQ1chKqqwirIe0fnwhvLxs0z7541m6nUQiWCqgCQ6oVVwkrkNqRzZQ5y3b1aVD7a
         XIwB9jB+yn5RF+b2ZOs0wQaYnLYvauocOHLwXrnpgHmOZNRzjKZwJ+HyL35aiObzqfVP
         A8yA==
X-Gm-Message-State: AOAM530w8Dp/6pfKkO6srCmkOIlJKECQnQVLJZWq1I2ais6vBUWORP57
        +r1+n69luTiQwpR+lWVsa61u5XzHmTwkwDoUpbs=
X-Google-Smtp-Source: ABdhPJzyT8qmyf4VPMY8iUDJTmcIzqP4nzMouR+yn6xqoYdHJNZCrawt+H5hmW0k1uJGV3pB0dmpkYYs/VXnRZUEGbQ=
X-Received: by 2002:a92:c548:: with SMTP id a8mr16739368ilj.137.1619503383554;
 Mon, 26 Apr 2021 23:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com> <20210426184201.4177978-7-krisman@collabora.com>
In-Reply-To: <20210426184201.4177978-7-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 09:02:52 +0300
Message-ID: <CAOQ4uxjOZ2W6DrcQgTd4aaA_tA1AnriAWgepaHAbyKOpVOP_Hw@mail.gmail.com>
Subject: Re: [PATCH RFC 06/15] fanotify: Support submission through ring buffer
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
> This adds support for the ring buffer mode in fanotify.  It is enabled
> by a new flag FAN_PREALLOC_QUEUE passed to fanotify_init.  If this flag
> is enabled, the group only allows marks that support the ring buffer

I don't like this limitation.
I think FAN_PREALLOC_QUEUE can work with other events, why not?

In any case if we keep ring buffer, please use a different set of
fanotify_ring_buffer_ops struct instead of spraying if/else all over the
event queue implementation.

> submission.  In a following patch, FAN_ERROR will make use of this
> mechanism.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.c      | 77 +++++++++++++++++++---------
>  fs/notify/fanotify/fanotify_user.c | 81 ++++++++++++++++++------------
>  include/linux/fanotify.h           |  5 +-
>  include/uapi/linux/fanotify.h      |  1 +
>  4 files changed, 105 insertions(+), 59 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index e3669d8a4a64..98591a8155a7 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -612,6 +612,26 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>         return event;
>  }
>
> +static struct fanotify_event *fanotify_ring_get_slot(struct fsnotify_group *group,
> +                                                    u32 mask, const void *data,
> +                                                    int data_type)
> +{
> +       size_t size = 0;
> +
> +       pr_debug("%s: group=%p mask=%x size=%lu\n", __func__, group, mask, size);
> +
> +       return FANOTIFY_E(fsnotify_ring_alloc_event_slot(group, size));
> +}
> +
> +static void fanotify_ring_write_event(struct fsnotify_group *group,
> +                                     struct fanotify_event *event, u32 mask,
> +                                     const void *data, __kernel_fsid_t *fsid)
> +{
> +       fanotify_init_event(group, event, 0, mask);
> +
> +       event->pid = get_pid(task_tgid(current));
> +}
> +
>  /*
>   * Get cached fsid of the filesystem containing the object from any connector.
>   * All connectors are supposed to have the same fsid, but we do not verify that
> @@ -701,31 +721,38 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>                         return 0;
>         }
>
> -       event = fanotify_alloc_event(group, mask, data, data_type, dir,
> -                                    file_name, &fsid);
> -       ret = -ENOMEM;
> -       if (unlikely(!event)) {
> -               /*
> -                * We don't queue overflow events for permission events as
> -                * there the access is denied and so no event is in fact lost.
> -                */
> -               if (!fanotify_is_perm_event(mask))
> -                       fsnotify_queue_overflow(group);
> -               goto finish;
> -       }
> -
> -       fsn_event = &event->fse;
> -       ret = fsnotify_add_event(group, fsn_event, fanotify_merge);
> -       if (ret) {
> -               /* Permission events shouldn't be merged */
> -               BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
> -               /* Our event wasn't used in the end. Free it. */
> -               fsnotify_destroy_event(group, fsn_event);
> -
> -               ret = 0;
> -       } else if (fanotify_is_perm_event(mask)) {
> -               ret = fanotify_get_response(group, FANOTIFY_PERM(event),
> -                                           iter_info);
> +       if (group->flags & FSN_SUBMISSION_RING_BUFFER) {
> +               event = fanotify_ring_get_slot(group, mask, data, data_type);
> +               if (IS_ERR(event))
> +                       return PTR_ERR(event);

So no FAN_OVERFLOW with the ring buffer implementation?
This will be unexpected for fanotify users and frankly, less useful IMO.
I also don't see the technical reason to omit the overflow event.

> +               fanotify_ring_write_event(group, event, mask, data, &fsid);
> +               fsnotify_ring_commit_slot(group, &event->fse);
> +       } else {
> +               event = fanotify_alloc_event(group, mask, data, data_type, dir,
> +                                            file_name, &fsid);
> +               ret = -ENOMEM;
> +               if (unlikely(!event)) {
> +                       /*
> +                        * We don't queue overflow events for permission events as
> +                        * there the access is denied and so no event is in fact lost.
> +                        */
> +                       if (!fanotify_is_perm_event(mask))
> +                               fsnotify_queue_overflow(group);
> +                       goto finish;
> +               }
> +               fsn_event = &event->fse;
> +               ret = fsnotify_add_event(group, fsn_event, fanotify_merge);
> +               if (ret) {
> +                       /* Permission events shouldn't be merged */
> +                       BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
> +                       /* Our event wasn't used in the end. Free it. */
> +                       fsnotify_destroy_event(group, fsn_event);
> +
> +                       ret = 0;
> +               } else if (fanotify_is_perm_event(mask)) {
> +                       ret = fanotify_get_response(group, FANOTIFY_PERM(event),
> +                                                   iter_info);
> +               }
>         }
>  finish:
>         if (fanotify_is_perm_event(mask))
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index fe605359af88..5031198bf7db 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -521,7 +521,9 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
>                  * Permission events get queued to wait for response.  Other
>                  * events can be destroyed now.
>                  */
> -               if (!fanotify_is_perm_event(event->mask)) {
> +               if (group->fanotify_data.flags & FAN_PREALLOC_QUEUE) {
> +                       fsnotify_ring_buffer_consume_event(group, &event->fse);
> +               } else if (!fanotify_is_perm_event(event->mask)) {
>                         fsnotify_destroy_event(group, &event->fse);
>                 } else {
>                         if (ret <= 0) {
> @@ -587,40 +589,39 @@ static int fanotify_release(struct inode *ignored, struct file *file)
>          */
>         fsnotify_group_stop_queueing(group);
>
> -       /*
> -        * Process all permission events on access_list and notification queue
> -        * and simulate reply from userspace.
> -        */
> -       spin_lock(&group->notification_lock);
> -       while (!list_empty(&group->fanotify_data.access_list)) {
> -               struct fanotify_perm_event *event;
> -
> -               event = list_first_entry(&group->fanotify_data.access_list,
> -                               struct fanotify_perm_event, fae.fse.list);
> -               list_del_init(&event->fae.fse.list);
> -               finish_permission_event(group, event, FAN_ALLOW);
> +       if (!(group->flags & FSN_SUBMISSION_RING_BUFFER)) {
> +               /*
> +                * Process all permission events on access_list and notification queue
> +                * and simulate reply from userspace.
> +                */
>                 spin_lock(&group->notification_lock);
> -       }
> -
> -       /*
> -        * Destroy all non-permission events. For permission events just
> -        * dequeue them and set the response. They will be freed once the
> -        * response is consumed and fanotify_get_response() returns.
> -        */
> -       while (!fsnotify_notify_queue_is_empty(group)) {
> -               struct fanotify_event *event;
> -
> -               event = FANOTIFY_E(fsnotify_remove_first_event(group));
> -               if (!(event->mask & FANOTIFY_PERM_EVENTS)) {
> -                       spin_unlock(&group->notification_lock);
> -                       fsnotify_destroy_event(group, &event->fse);
> -               } else {
> -                       finish_permission_event(group, FANOTIFY_PERM(event),
> -                                               FAN_ALLOW);
> +               while (!list_empty(&group->fanotify_data.access_list)) {
> +                       struct fanotify_perm_event *event;
> +                       event = list_first_entry(&group->fanotify_data.access_list,
> +                                                struct fanotify_perm_event, fae.fse.list);
> +                       list_del_init(&event->fae.fse.list);
> +                       finish_permission_event(group, event, FAN_ALLOW);
> +                       spin_lock(&group->notification_lock);
>                 }
> -               spin_lock(&group->notification_lock);
> +               /*
> +                * Destroy all non-permission events. For permission events just
> +                * dequeue them and set the response. They will be freed once the
> +                * response is consumed and fanotify_get_response() returns.
> +                */
> +               while (!fsnotify_notify_queue_is_empty(group)) {
> +                       struct fanotify_event *event;
> +                       event = FANOTIFY_E(fsnotify_remove_first_event(group));
> +                       if (!(event->mask & FANOTIFY_PERM_EVENTS)) {
> +                               spin_unlock(&group->notification_lock);
> +                               fsnotify_destroy_event(group, &event->fse);
> +                       } else {
> +                               finish_permission_event(group, FANOTIFY_PERM(event),
> +                                                       FAN_ALLOW);
> +                       }
> +                       spin_lock(&group->notification_lock);
> +               }
> +               spin_unlock(&group->notification_lock);
>         }
> -       spin_unlock(&group->notification_lock);
>
>         /* Response for all permission events it set, wakeup waiters */
>         wake_up(&group->fanotify_data.access_waitq);
> @@ -981,6 +982,16 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>         if (flags & FAN_NONBLOCK)
>                 f_flags |= O_NONBLOCK;
>
> +       if (flags & FAN_PREALLOC_QUEUE) {
> +               if (!capable(CAP_SYS_ADMIN))
> +                       return -EPERM;
> +
> +               if (flags & FAN_UNLIMITED_QUEUE)
> +                       return -EINVAL;
> +
> +               fsn_flags = FSN_SUBMISSION_RING_BUFFER;
> +       }
> +
>         /* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
>         group = fsnotify_alloc_user_group(&fanotify_fsnotify_ops, fsn_flags);
>         if (IS_ERR(group)) {
> @@ -1223,6 +1234,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>                 goto fput_and_out;
>         }
>
> +       if ((group->flags & FSN_SUBMISSION_RING_BUFFER) &&
> +           (mask & ~FANOTIFY_SUBMISSION_BUFFER_EVENTS))
> +               goto fput_and_out;
> +
>         ret = fanotify_find_path(dfd, pathname, &path, flags,
>                         (mask & ALL_FSNOTIFY_EVENTS), obj_type);
>         if (ret)
> @@ -1327,7 +1342,7 @@ SYSCALL32_DEFINE6(fanotify_mark,
>   */
>  static int __init fanotify_user_setup(void)
>  {
> -       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
> +       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 11);
>         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
>
>         fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 3e9c56ee651f..5a4cefb4b1c3 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -23,7 +23,8 @@
>  #define FANOTIFY_INIT_FLAGS    (FANOTIFY_CLASS_BITS | FANOTIFY_FID_BITS | \
>                                  FAN_REPORT_TID | \
>                                  FAN_CLOEXEC | FAN_NONBLOCK | \
> -                                FAN_UNLIMITED_QUEUE | FAN_UNLIMITED_MARKS)
> +                                FAN_UNLIMITED_QUEUE | FAN_UNLIMITED_MARKS | \
> +                                FAN_PREALLOC_QUEUE)
>
>  #define FANOTIFY_MARK_TYPE_BITS        (FAN_MARK_INODE | FAN_MARK_MOUNT | \
>                                  FAN_MARK_FILESYSTEM)
> @@ -71,6 +72,8 @@
>                                          FANOTIFY_PERM_EVENTS | \
>                                          FAN_Q_OVERFLOW | FAN_ONDIR)
>
> +#define FANOTIFY_SUBMISSION_BUFFER_EVENTS 0

FANOTIFY_RING_BUFFER_EVENTS? FANOTIFY_PREALLOC_EVENTS?

Please leave a comment above to state what this group means.
I *think* there is no reason to limit the set of events, only the sort of
information that is possible with FAN_PREALLOC_QUEUE.

Perhaps FAN_REPORT_FID cannot be allowed and as a result
FANOTIFY_INODE_EVENTS will not be allowed, but I am not even
sure if that limitation is needed.

Thanks,
Amir.
