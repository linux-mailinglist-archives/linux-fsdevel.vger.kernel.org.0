Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F6B3EB35F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 11:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbhHMJgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 05:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhHMJgb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 05:36:31 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96830C061756;
        Fri, 13 Aug 2021 02:36:04 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a13so12342923iol.5;
        Fri, 13 Aug 2021 02:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awjBYh+Mhb6sHy+SMTywmzaFElGx+4woBsmpts8FQTU=;
        b=mRTYOwR6alNyN7+5QxdDdSJH/UspgkL42FQ5f4hfVCCnmnxjtGqTdiOdeRqm0RxfHx
         ZOPnMQO/AdaPYm7Kl/bhTGV+2gMI4i99s2lfCvWGrLrTwrRgB0UBCDF8s3lzNxdl7++3
         IzUAoZCUQPiVI2Wl8e5TmInP0BivTDLKCF0UKLM7ZbN8gBWYBHW08RCpPw5l8RcZIWxZ
         gXCszImyWv5bvXWfg33awshQfaI5/4zVVivgxJ1yaHNgZjUAngHQ/FRyBVXtSP8/JXHD
         eNtEDzHVPQV4G9yRgFQFoffrsjrxe3gocsELQFCiCevvSu3fpw89dY/lmYxA7iN3hKwG
         C/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awjBYh+Mhb6sHy+SMTywmzaFElGx+4woBsmpts8FQTU=;
        b=CbLcLIS8ClAL3Ffi9dF65ky7zaAevTslC/ePa97poycNt57mjsw5mfPD+tYfywtI1a
         f0Omp6s8wnOhTcxPO359aUp1dWz0j+cCcngX/8eLIKbmiPwGodeeh5XMkRXcQsarOO1x
         DRUfZWAXNL6KghQRVSvjkITN7YJqka2sczKDrU+etPv4PhpRYO0NcQkq1xDh+zDChbX3
         ibaGwEhxODYwQhNpicHJc7P6Nhwt7QWB4+7MlmkI5KAK/xQCWCWAwemb6uW73//buW4S
         n5uon9G3CULfaypAKDy9U0orRdQ/DdLmXhE93TMnnbbcspqBI6/oHSMXMilXgjHPQJLy
         5OTA==
X-Gm-Message-State: AOAM532OOf9cm7Ugs/0Sjjsk/+B27DW2WvGj2cNHVXkTaEYgxgAVx/z+
        6+RzDCsgB5sQZrm1guOuGUIgLzWMP/GyUzAFnYI=
X-Google-Smtp-Source: ABdhPJzIEACInv6KQr9wTw06gsXvr4DYiMtBMQ8h221n7OfkJKfNkrPE27dQRHvezqFsOuu2+Or/GQXR3V5HrO7wZGI=
X-Received: by 2002:a05:6602:1848:: with SMTP id d8mr1355166ioi.72.1628847363912;
 Fri, 13 Aug 2021 02:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com> <20210812214010.3197279-17-krisman@collabora.com>
In-Reply-To: <20210812214010.3197279-17-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Aug 2021 12:35:52 +0300
Message-ID: <CAOQ4uxjb8kpfaX2Jtq-h6Vai2My67PdqGRbVUP5+GspLCsq_+A@mail.gmail.com>
Subject: Re: [PATCH v6 16/21] fanotify: Handle FAN_FS_ERROR events
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
> Wire up FAN_FS_ERROR in the fanotify_mark syscall.  The event can only
> be requested for the entire filesystem, thus it requires the
> FAN_MARK_FILESYSTEM.

Please split the Wire-up to fanotify_mark syscall into a separate patch applied
after patches that implement the report of event info records.

>
> FAN_FS_ERROR has to be handled slightly differently from other events
> because it needs to be submitted in an atomic context, using
> preallocated memory.  This patch implements the submission path by only
> storing the first error event that happened in the slot (userspace
> resets the slot by reading the event).
>
> Extra error events happening when the slot is occupied are merged to the
> original report, and the only information keep for these extra errors is
> an accumulator counting the number of events, which is part of the
> record reported back to userspace.
>
> Reporting only the first event should be fine, since when a FS error
> happens, a cascade of error usually follows, but the most meaningful
> information is (usually) on the first erro.
>
> The event dequeueing is also a bit special to avoid losing events. Since
> event merging only happens while the event is queued, there is a window
> between when an error event is dequeued (notification_lock is dropped)
> until it is reset (.free_event()) where the slot is full, but no merges
> can happen.
>
> The proposed solution is to copy the event to the stack prior to
> dropping the lock.  This way, if a new event arrives in the time between
> the event was dequeued and the time it resets, the new errors will still
> be logged and merged in the recently freed slot.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v5:
>   - Copy to stack instead of replacing the fee slot(jan)
>   - prepare error slot outside of the notification lock(jan)
> Changes since v4:
>   - Split parts to earlier patches (amir)
>   - Simplify fanotify entry replacement
>   - Update handle size prediction on overflow
> Changes since v3:
>   - Convert WARN_ON to pr_warn (amir)
>   - Remove unecessary READ/WRITE_ONCE (amir)
>   - Alloc with GFP_KERNEL_ACCOUNT(amir)
>   - Simplify flags on mark allocation (amir)
>   - Avoid atomic set of error_count (amir)
>   - Simplify rules when merging error_event (amir)
>   - Allocate new error_event on get_one_event (amir)
>   - Report superblock error with invalid FH (amir,jan)
>
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
>  fs/notify/fanotify/fanotify.c      | 57 +++++++++++++++++++++++++++++-
>  fs/notify/fanotify/fanotify.h      | 21 +++++++++++
>  fs/notify/fanotify/fanotify_user.c | 39 ++++++++++++++++++--
>  include/linux/fanotify.h           |  6 +++-
>  4 files changed, 119 insertions(+), 4 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 3bf6fd85c634..0c7667d3f5d1 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -709,6 +709,55 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
>         return fsid;
>  }
>
> +static void fanotify_insert_error_event(struct fsnotify_group *group,
> +                                       struct fsnotify_event *fsn_event)
> +
> +{
> +       struct fanotify_event *event = FANOTIFY_E(fsn_event);
> +
> +       if (!fanotify_is_error_event(event->mask))
> +               return;
> +
> +       /*
> +        * Prevent the mark from going away while an outstanding error
> +        * event is queued.  The reference is released by
> +        * fanotify_dequeue_first_event.
> +        */
> +       fsnotify_get_mark(&FANOTIFY_EE(event)->sb_mark->fsn_mark);
> +
> +}
> +
> +static int fanotify_handle_error_event(struct fsnotify_iter_info *iter_info,
> +                                      struct fsnotify_group *group,
> +                                      const struct fs_error_report *report)
> +{
> +       struct fanotify_sb_mark *sb_mark =
> +               FANOTIFY_SB_MARK(fsnotify_iter_sb_mark(iter_info));
> +       struct fanotify_error_event *fee = sb_mark->fee_slot;
> +
> +       spin_lock(&group->notification_lock);
> +       if (fee->err_count++) {
> +               spin_unlock(&group->notification_lock);
> +               return 0;
> +       }

Please add commentary to explain why logic is before merge()/insert().

> +       spin_unlock(&group->notification_lock);
> +
> +       fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +
> +       if (fsnotify_insert_event(group, &fee->fae.fse,
> +                                 NULL, fanotify_insert_error_event)) {
> +               /*
> +                *  Even if an error occurred, an overflow event is
> +                *  queued. Just reset the error count and succeed.
> +                */
> +               spin_lock(&group->notification_lock);
> +               fanotify_reset_error_slot(fee);
> +               spin_unlock(&group->notification_lock);

This feels racy.
I think that fanotify_reset_error_slot() should WARN about
trying to reset a queued error event and here we need to
check that fee was not queued while we dropped the lock.

And I am not convinced about correctness of incrementing
err_count while the lock is dropped.
Need to see the commentary.

> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   * Add an event to hash table for faster merge.
>   */
> @@ -762,7 +811,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>         BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
>         BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>
> -       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
> +       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
>
>         mask = fanotify_group_event_mask(group, iter_info, mask, data,
>                                          data_type, dir);
> @@ -787,6 +836,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>                         return 0;
>         }
>
> +       if (fanotify_is_error_event(mask))
> +               return fanotify_handle_error_event(iter_info, group, data);
> +
>         event = fanotify_alloc_event(group, mask, data, data_type, dir,
>                                      file_name, &fsid);
>         ret = -ENOMEM;
> @@ -857,10 +909,13 @@ static void fanotify_free_name_event(struct fanotify_event *event)
>
>  static void fanotify_free_error_event(struct fanotify_event *event)
>  {
> +       struct fanotify_error_event *fee = FANOTIFY_EE(event);
> +
>         /*
>          * The actual event is tied to a mark, and is released on mark
>          * removal
>          */
> +       fsnotify_put_mark(&fee->sb_mark->fsn_mark);
>  }
>
>  static void fanotify_free_event(struct fsnotify_event *fsn_event)
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 3f03333df32f..eeb4a85af74e 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -220,6 +220,8 @@ FANOTIFY_NE(struct fanotify_event *event)
>
>  struct fanotify_error_event {
>         struct fanotify_event fae;
> +       u32 err_count; /* Suppressed errors count */
> +
>         struct fanotify_sb_mark *sb_mark; /* Back reference to the mark. */
>  };
>
> @@ -320,6 +322,11 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
>         return container_of(fse, struct fanotify_event, fse);
>  }
>
> +static inline bool fanotify_is_error_event(u32 mask)
> +{
> +       return mask & FAN_FS_ERROR;
> +}
> +
>  static inline bool fanotify_event_has_path(struct fanotify_event *event)
>  {
>         return event->type == FANOTIFY_EVENT_TYPE_PATH ||
> @@ -349,6 +356,7 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
>  static inline bool fanotify_is_hashed_event(u32 mask)
>  {
>         return !(fanotify_is_perm_event(mask) ||
> +                fanotify_is_error_event(mask) ||
>                  fsnotify_is_overflow_event(mask));
>  }
>
> @@ -358,3 +366,16 @@ static inline unsigned int fanotify_event_hash_bucket(
>  {
>         return event->hash & FANOTIFY_HTABLE_MASK;
>  }
> +
> +/*
> + * Reset the FAN_FS_ERROR event slot
> + *
> + * This is used to restore the error event slot to a a zeroed state,
> + * where it can be used for a new incoming error.  It does not
> + * initialize the event, but clear only the required data to free the
> + * slot.
> + */
> +static inline void fanotify_reset_error_slot(struct fanotify_error_event *fee)
> +{
> +       fee->err_count = 0;

Makes sense that it should also zero the error field. No?


> +}
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index b77030386d7f..3fff0c994dc8 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -167,6 +167,19 @@ static void fanotify_unhash_event(struct fsnotify_group *group,
>         hlist_del_init(&event->merge_list);
>  }
>
> +static struct fanotify_event *fanotify_dup_error_to_stack(
> +                               struct fanotify_error_event *fee,
> +                               struct fanotify_error_event *error_on_stack)
> +{
> +       fanotify_init_event(&error_on_stack->fae, 0, FS_ERROR);
> +
> +       error_on_stack->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +       error_on_stack->err_count = fee->err_count;
> +       error_on_stack->sb_mark = fee->sb_mark;
> +
> +       return &error_on_stack->fae;
> +}
> +
>  /*
>   * Get an fanotify notification event if one exists and is small
>   * enough to fit in "count". Return an error pointer if the count
> @@ -174,7 +187,9 @@ static void fanotify_unhash_event(struct fsnotify_group *group,
>   * updated accordingly.
>   */
>  static struct fanotify_event *get_one_event(struct fsnotify_group *group,
> -                                           size_t count)
> +                                   size_t count,
> +                                   struct fanotify_error_event *error_on_stack)
> +
>  {
>         size_t event_size;
>         struct fanotify_event *event = NULL;
> @@ -205,6 +220,16 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
>                 FANOTIFY_PERM(event)->state = FAN_EVENT_REPORTED;
>         if (fanotify_is_hashed_event(event->mask))
>                 fanotify_unhash_event(group, event);
> +
> +       if (fanotify_is_error_event(event->mask)) {
> +               /*
> +                * Error events are returned as a copy of the error
> +                * slot.  The actual error slot is reused.
> +                */
> +               fanotify_dup_error_to_stack(FANOTIFY_EE(event), error_on_stack);
> +               fanotify_reset_error_slot(FANOTIFY_EE(event));
> +               event = &error_on_stack->fae;
> +       }
>  out:
>         spin_unlock(&group->notification_lock);
>         return event;
> @@ -564,6 +589,7 @@ static __poll_t fanotify_poll(struct file *file, poll_table *wait)
>  static ssize_t fanotify_read(struct file *file, char __user *buf,
>                              size_t count, loff_t *pos)
>  {
> +       struct fanotify_error_event error_on_stack;
>         struct fsnotify_group *group;
>         struct fanotify_event *event;
>         char __user *start;
> @@ -582,7 +608,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
>                  * in case there are lots of available events.
>                  */
>                 cond_resched();
> -               event = get_one_event(group, count);
> +               event = get_one_event(group, count, &error_on_stack);
>                 if (IS_ERR(event)) {
>                         ret = PTR_ERR(event);
>                         break;
> @@ -1031,6 +1057,10 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>                         fanotify_init_event(&fee->fae, 0, FS_ERROR);
>                         fee->sb_mark = sb_mark;
>                         sb_mark->fee_slot = fee;
> +
> +                       /* Mark the error slot ready to receive events. */
> +                       fanotify_reset_error_slot(fee);
> +
>                 }
>         }
>
> @@ -1459,6 +1489,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>                 fsid = &__fsid;
>         }
>
> +       if (mask & FAN_FS_ERROR && mark_type != FAN_MARK_FILESYSTEM) {
> +               ret = -EINVAL;
> +               goto path_put_and_out;
> +       }
> +

Split to Wire-up patch please.

>         /* inode held in place by reference to path; group by fget on fd */
>         if (mark_type == FAN_MARK_INODE)
>                 inode = path.dentry->d_inode;
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index c05d45bde8b8..c4d49308b2d0 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -88,9 +88,13 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
>  #define FANOTIFY_INODE_EVENTS  (FANOTIFY_DIRENT_EVENTS | \
>                                  FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
>
> +/* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
> +#define FANOTIFY_ERROR_EVENTS  (FAN_FS_ERROR)
> +
>  /* Events that user can request to be notified on */
>  #define FANOTIFY_EVENTS                (FANOTIFY_PATH_EVENTS | \
> -                                FANOTIFY_INODE_EVENTS)
> +                                FANOTIFY_INODE_EVENTS | \
> +                                FANOTIFY_ERROR_EVENTS)
>

Split to Wire-up patch please.

Thanks,
Amir.
