Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0836BEFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 07:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhD0Fkf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 01:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhD0Fkc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 01:40:32 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D88CC061574;
        Mon, 26 Apr 2021 22:39:49 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id r5so8429861ilb.2;
        Mon, 26 Apr 2021 22:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HR6fdrvmxf/u/fSe+9RKbOvxnOH1tRmTt4LGT8UPlO0=;
        b=o6fpFBybMXiIxoVdJntZNWjCf9+bQ/zkoDdF8tbeAGbrQIBOA2laXnv40YOydfkXwh
         JoglC2N3PEec6Mkxb1IpVQBSHGUmYkx04e2+QLyisVMn1fuXOlzJtO/8i2NLbo31jJNX
         QUW2Ww0uI6WyyIZ6oGiv6GUGh221EzQvOzGXEuU9KXZ2xzSWQnH0iUbnu3fSsdsyCfx5
         Tq5falxVrQW2qBiHLH3THyEnKDpF2Qwxw9Qdz/2QfdqlG63ihxgPdOAb+aMyv0EiTtPT
         yavOiMpy2zfDxRtyL/VHmMqxcHaOzMQLBnsEHAEpWIqt4Jvc9OybwmwU7uLxWbxE1peS
         W4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HR6fdrvmxf/u/fSe+9RKbOvxnOH1tRmTt4LGT8UPlO0=;
        b=OuO/jmuvzpmC3G15FkPHytwRdRAKANgJO8gtAMHocHJNMnPpE8bJ10amK3+Fb86k9k
         muzpcB4pRrQl//J/jkbIlc5C03/lJKzZXRXL4fNWNnlOlcmwhlMWPy/6L357n2LeCc+g
         uHKG5jmoi3kDte8AyLjaUukhF9WOU7kyQ9eSTk09CucvmNU5nteIQhfI/ldjNgbys/ER
         kCjT0CkMBX+iu80fJYpO1uvK8QVrz0o7DSGkf10GFdBCts040JJcYz1ixPpKiMuPKcqU
         UWJcP5tNIRPXJ8CWQDsNL27Bremremg2du4ZlnIhMG8qn3DLpWoqcM/DST4kTB28hw0S
         S5Dw==
X-Gm-Message-State: AOAM530QTUGnoHo2bt7sYSrBBtmfbmRmHJ2XNn1yrPxhSOP5n9D/UI+n
        auI1yFrYr/UGjSjOHl86on2D5ivVAG+kE193Z+E=
X-Google-Smtp-Source: ABdhPJwE49Bi0Y5QTmSKGBhSAa7+rSNK7m+159b0CBbSEAhbJQYhcP/BpmY8IDQCysF0VjiINb3vMUhm5lSMxXwGa9w=
X-Received: by 2002:a92:b74a:: with SMTP id c10mr16716218ilm.72.1619501989018;
 Mon, 26 Apr 2021 22:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com> <20210426184201.4177978-6-krisman@collabora.com>
In-Reply-To: <20210426184201.4177978-6-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 08:39:37 +0300
Message-ID: <CAOQ4uxhxao_R-xuKHt4_bC+ADd9DkEFJgiHH=vwQxdOJXCpTAg@mail.gmail.com>
Subject: Re: [PATCH RFC 05/15] fsnotify: Support event submission through ring buffer
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
> In order to support file system health/error reporting over fanotify,
> fsnotify needs to expose a submission path that doesn't allow sleeping.
> The only problem I identified with the current submission path is the
> need to dynamically allocate memory for the event queue.
>
> This patch avoids the problem by introducing a new mode in fsnotify,
> where a ring buffer is used to submit events for a group.  Each group
> has its own ring buffer, and error notifications are submitted
> exclusively through it.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/Makefile               |   2 +-
>  fs/notify/group.c                |  12 +-
>  fs/notify/notification.c         |  10 ++
>  fs/notify/ring.c                 | 199 +++++++++++++++++++++++++++++++
>  include/linux/fsnotify_backend.h |  37 +++++-
>  5 files changed, 255 insertions(+), 5 deletions(-)
>  create mode 100644 fs/notify/ring.c
>
> diff --git a/fs/notify/Makefile b/fs/notify/Makefile
> index 63a4b8828df4..61dae1e90f2d 100644
> --- a/fs/notify/Makefile
> +++ b/fs/notify/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_FSNOTIFY)         += fsnotify.o notification.o group.o mark.o \
> -                                  fdinfo.o
> +                                  fdinfo.o ring.o
>
>  obj-y                  += dnotify/
>  obj-y                  += inotify/
> diff --git a/fs/notify/group.c b/fs/notify/group.c
> index 08acb1afc0c2..b99b3de36696 100644
> --- a/fs/notify/group.c
> +++ b/fs/notify/group.c
> @@ -81,7 +81,10 @@ void fsnotify_destroy_group(struct fsnotify_group *group)
>          * notification against this group. So clearing the notification queue
>          * of all events is reliable now.
>          */
> -       fsnotify_flush_notify(group);
> +       if (group->flags & FSN_SUBMISSION_RING_BUFFER)
> +               fsnotify_free_ring_buffer(group);
> +       else
> +               fsnotify_flush_notify(group);
>
>         /*
>          * Destroy overflow event (we cannot use fsnotify_destroy_event() as
> @@ -136,6 +139,13 @@ static struct fsnotify_group *__fsnotify_alloc_group(
>         group->ops = ops;
>         group->flags = flags;
>
> +       if (group->flags & FSN_SUBMISSION_RING_BUFFER) {
> +               if (fsnotify_create_ring_buffer(group)) {
> +                       kfree(group);
> +                       return ERR_PTR(-ENOMEM);
> +               }
> +       }
> +
>         return group;
>  }
>
> diff --git a/fs/notify/notification.c b/fs/notify/notification.c
> index 75d79d6d3ef0..32f97e7b7a80 100644
> --- a/fs/notify/notification.c
> +++ b/fs/notify/notification.c
> @@ -51,6 +51,10 @@ EXPORT_SYMBOL_GPL(fsnotify_get_cookie);
>  bool fsnotify_notify_queue_is_empty(struct fsnotify_group *group)
>  {
>         assert_spin_locked(&group->notification_lock);
> +
> +       if (group->flags & FSN_SUBMISSION_RING_BUFFER)
> +               return fsnotify_ring_notify_queue_is_empty(group);
> +
>         return list_empty(&group->notification_list) ? true : false;
>  }
>
> @@ -132,6 +136,9 @@ void fsnotify_remove_queued_event(struct fsnotify_group *group,
>                                   struct fsnotify_event *event)
>  {
>         assert_spin_locked(&group->notification_lock);
> +
> +       if (group->flags & FSN_SUBMISSION_RING_BUFFER)
> +               return;
>         /*
>          * We need to init list head for the case of overflow event so that
>          * check in fsnotify_add_event() works
> @@ -166,6 +173,9 @@ struct fsnotify_event *fsnotify_peek_first_event(struct fsnotify_group *group)
>  {
>         assert_spin_locked(&group->notification_lock);
>
> +       if (group->flags & FSN_SUBMISSION_RING_BUFFER)
> +               return fsnotify_ring_peek_first_event(group);
> +
>         return list_first_entry(&group->notification_list,
>                                 struct fsnotify_event, list);
>  }
> diff --git a/fs/notify/ring.c b/fs/notify/ring.c
> new file mode 100644
> index 000000000000..75e8af1f8d80
> --- /dev/null
> +++ b/fs/notify/ring.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/types.h>
> +#include <linux/fsnotify.h>
> +#include <linux/memcontrol.h>
> +
> +#define INVALID_RING_SLOT -1
> +
> +#define FSNOTIFY_RING_PAGES 16
> +
> +#define NEXT_SLOT(cur, len, ring_size) ((cur + len) & (ring_size-1))
> +#define NEXT_PAGE(cur, ring_size) (round_up(cur, PAGE_SIZE) & (ring_size-1))
> +
> +bool fsnotify_ring_notify_queue_is_empty(struct fsnotify_group *group)
> +{
> +       assert_spin_locked(&group->notification_lock);
> +
> +       if (group->ring_buffer.tail == group->ring_buffer.head)
> +               return true;
> +       return false;
> +}
> +
> +struct fsnotify_event *fsnotify_ring_peek_first_event(struct fsnotify_group *group)
> +{
> +       u64 ring_size = group->ring_buffer.nr_pages << PAGE_SHIFT;
> +       struct fsnotify_event *fsn;
> +       char *kaddr;
> +       u64 tail;
> +
> +       assert_spin_locked(&group->notification_lock);
> +
> +again:
> +       tail = group->ring_buffer.tail;
> +
> +       if ((PAGE_SIZE - (tail & (PAGE_SIZE-1))) < sizeof(struct fsnotify_event)) {
> +               group->ring_buffer.tail = NEXT_PAGE(tail, ring_size);
> +               goto again;
> +       }
> +
> +       kaddr = kmap_atomic(group->ring_buffer.pages[tail / PAGE_SIZE]);
> +       if (!kaddr)
> +               return NULL;
> +       fsn = (struct fsnotify_event *) (kaddr + (tail & (PAGE_SIZE-1)));
> +
> +       if (fsn->slot_len == INVALID_RING_SLOT) {
> +               group->ring_buffer.tail = NEXT_PAGE(tail, ring_size);
> +               kunmap_atomic(kaddr);
> +               goto again;
> +       }
> +
> +       /* will be unmapped when entry is consumed. */
> +       return fsn;
> +}
> +
> +void fsnotify_ring_buffer_consume_event(struct fsnotify_group *group,
> +                                       struct fsnotify_event *event)
> +{
> +       u64 ring_size = group->ring_buffer.nr_pages << PAGE_SHIFT;
> +       u64 new_tail = NEXT_SLOT(group->ring_buffer.tail, event->slot_len, ring_size);
> +
> +       kunmap_atomic(event);
> +
> +       pr_debug("%s: group=%p tail=%llx->%llx ring_size=%llu\n", __func__,
> +                group, group->ring_buffer.tail, new_tail, ring_size);
> +
> +       WRITE_ONCE(group->ring_buffer.tail, new_tail);
> +}
> +
> +struct fsnotify_event *fsnotify_ring_alloc_event_slot(struct fsnotify_group *group,
> +                                                     size_t size)
> +       __acquires(&group->notification_lock)
> +{
> +       struct fsnotify_event *fsn;
> +       u64 head, tail;
> +       u64 ring_size = group->ring_buffer.nr_pages << PAGE_SHIFT;
> +       u64 new_head;
> +       void *kaddr;
> +
> +       if (WARN_ON(!(group->flags & FSN_SUBMISSION_RING_BUFFER) || size > PAGE_SIZE))
> +               return ERR_PTR(-EINVAL);
> +
> +       pr_debug("%s: start group=%p ring_size=%llu, requested=%lu\n", __func__, group,
> +                ring_size, size);
> +
> +       spin_lock(&group->notification_lock);
> +again:
> +       head = group->ring_buffer.head;
> +       tail = group->ring_buffer.tail;
> +       new_head = NEXT_SLOT(head, size, ring_size);
> +
> +       /* head would catch up to tail, corrupting an entry. */
> +       if ((head < tail && new_head > tail) || (head > new_head && new_head > tail)) {
> +               fsn = ERR_PTR(-ENOMEM);
> +               goto err;
> +       }
> +
> +       /*
> +        * Not event a skip message fits in the page. We can detect the
> +        * lack of space. Move on to the next page.
> +        */
> +       if ((PAGE_SIZE - (head & (PAGE_SIZE-1))) < sizeof(struct fsnotify_event)) {
> +               /* Start again on next page */
> +               group->ring_buffer.head = NEXT_PAGE(head, ring_size);
> +               goto again;
> +       }
> +
> +       kaddr = kmap_atomic(group->ring_buffer.pages[head / PAGE_SIZE]);
> +       if (!kaddr) {
> +               fsn = ERR_PTR(-EFAULT);
> +               goto err;
> +       }
> +
> +       fsn = (struct fsnotify_event *) (kaddr + (head & (PAGE_SIZE-1)));
> +
> +       if ((head >> PAGE_SHIFT) != (new_head >> PAGE_SHIFT)) {
> +               /*
> +                * No room in the current page.  Add a fake entry
> +                * consuming the end the page to avoid splitting event
> +                * structure.
> +                */
> +               fsn->slot_len = INVALID_RING_SLOT;
> +               kunmap_atomic(kaddr);
> +               /* Start again on the next page */
> +               group->ring_buffer.head = NEXT_PAGE(head, ring_size);
> +
> +               goto again;
> +       }
> +       fsn->slot_len = size;
> +
> +       return fsn;
> +
> +err:
> +       spin_unlock(&group->notification_lock);
> +       return fsn;
> +}
> +
> +void fsnotify_ring_commit_slot(struct fsnotify_group *group, struct fsnotify_event *fsn)
> +       __releases(&group->notification_lock)
> +{
> +       u64 ring_size = group->ring_buffer.nr_pages << PAGE_SHIFT;
> +       u64 head = group->ring_buffer.head;
> +       u64 new_head = NEXT_SLOT(head, fsn->slot_len, ring_size);
> +
> +       pr_debug("%s: group=%p head=%llx->%llx ring_size=%llu\n", __func__,
> +                group, head, new_head, ring_size);
> +
> +       kunmap_atomic(fsn);
> +       group->ring_buffer.head = new_head;
> +
> +       spin_unlock(&group->notification_lock);
> +
> +       wake_up(&group->notification_waitq);
> +       kill_fasync(&group->fsn_fa, SIGIO, POLL_IN);
> +
> +}
> +
> +void fsnotify_free_ring_buffer(struct fsnotify_group *group)
> +{
> +       int i;
> +
> +       for (i = 0; i < group->ring_buffer.nr_pages; i++)
> +               __free_page(group->ring_buffer.pages[i]);
> +       kfree(group->ring_buffer.pages);
> +       group->ring_buffer.nr_pages = 0;
> +}
> +
> +int fsnotify_create_ring_buffer(struct fsnotify_group *group)
> +{
> +       int nr_pages = FSNOTIFY_RING_PAGES;
> +       int i;
> +
> +       pr_debug("%s: group=%p pages=%d\n", __func__, group, nr_pages);
> +
> +       group->ring_buffer.pages = kmalloc_array(nr_pages, sizeof(struct pages *),
> +                                                GFP_KERNEL);
> +       if (!group->ring_buffer.pages)
> +               return -ENOMEM;
> +
> +       group->ring_buffer.head = 0;
> +       group->ring_buffer.tail = 0;
> +
> +       for (i = 0; i < nr_pages; i++) {
> +               group->ring_buffer.pages[i] = alloc_pages(GFP_KERNEL, 1);
> +               if (!group->ring_buffer.pages)
> +                       goto err_dealloc;
> +       }
> +
> +       group->ring_buffer.nr_pages = nr_pages;
> +
> +       return 0;
> +
> +err_dealloc:
> +       for (--i; i >= 0; i--)
> +               __free_page(group->ring_buffer.pages[i]);
> +       kfree(group->ring_buffer.pages);
> +       group->ring_buffer.nr_pages = 0;
> +       return -ENOMEM;
> +}
> +
> +

Nothing in this file is fsnotify specific.
Is there no kernel lib implementation for this already?
If there isn't (I'd be very surprised) please put this in lib/ and post it
for wider review including self tests.

> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 190c6a402e98..a1a4dd69e5ed 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -74,6 +74,8 @@
>  #define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
>                                   FS_OPEN_EXEC_PERM)
>
> +#define FSN_SUBMISSION_RING_BUFFER     0x00000080

FSNOTIFY_GROUP_FLAG_RING_BUFFER please (or FSN_GROUP_ if you must)
and please define this above struct fsnotify_group, even right above the flags
field like FSNOTIFY_CONN_FLAG_HAS_FSID

*IF* we go this way :)

Thanks,
Amir.
